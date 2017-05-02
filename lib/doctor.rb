class Doctor
  attr_reader(:name, :specialty_id, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @specialty_id = attributes.fetch(:specialty_id)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_doctors = DB.exec("SELECT * FROM doctors;")
    doctors = []
    returned_doctors.each() do |doctor|
      name = doctor.fetch("name")
      specialty_id = doctor.fetch("specialty_id").to_i()
      id = doctor.fetch("id").to_i()
      doctors.push(Doctor.new({:name => name, :specialty_id => specialty_id, :id => id}))
    end
    doctors
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO doctors (name, specialty_id) VALUES ('#{@name}', #{@specialty_id}) RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_doctor|
    self.name.==(another_doctor.name).&(self.id.==(another_doctor.id))
  end

  define_singleton_method(:doctors_in_specialty) do |specialty_name|
    specialty = specialty_name
    returned_specialty = DB.exec("SELECT * FROM specialties WHERE name = '#{specialty}';")
    specialty_id = nil
    returned_specialty.each() do |specialty|
      specialty_id = specialty.fetch("id").to_i()
    end
    doctors_list = DB.exec("SELECT * FROM doctors WHERE specialty_id = #{specialty_id};")
    doctors_array = []
    doctors_list.each() do |doctor|
      name = doctor.fetch("name")
      specialty_id = doctor.fetch("specialty_id").to_i()
      id = doctor.fetch("id").to_i()
      doctors_array.push(Doctor.new({:name => name, :specialty_id => specialty_id, :id => id}))
    end
    doctors_array
  end

  define_singleton_method(:patients_for_doctor) do
    returned_doctors = DB.exec("SELECT * FROM doctors ORDER BY name;")
    doctors = []
    returned_doctors.each() do |doctor|
      name = doctor.fetch("name")
      specialty_id = doctor.fetch("specialty_id").to_i()
      id = doctor.fetch("id").to_i()
      doctors.push(Doctor.new({:name => name, :specialty_id => specialty_id, :id => id}))
    end
    doctor_patient_array = []
    returned_doctors.each() do |doctor|
      id = doctor.fetch("id").to_i()
      patients_amount = DB.exec("SELECT COUNT(name) FROM patients WHERE doctor_id = #{id};")
      amount = patients_amount.values().join().to_s()
      name = doctor.fetch("name")
      doctor_patient_array.push(name + amount)
    end
    doctor_patient_array
  end
end
