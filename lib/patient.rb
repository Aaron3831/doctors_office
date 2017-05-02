class Patient
  attr_reader(:name, :doctor_id, :id)

  define_method(:initialize)  do |attributes|
    @name = attributes.fetch(:name)
    @doctor_id = attributes.fetch(:doctor_id)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_patients = DB.exec("SELECT * FROM patients;")
    patients = []
    returned_patients.each() do |patient|
      name = patient.fetch("name")
      doctor_id = patient.fetch("doctor_id").to_i()
      id = patient.fetch("id").to_i()
      patients.push(Patient.new({:name => name, :doctor_id => doctor_id, :id => id}))
    end
    patients
  end
  define_method(:save) do
    result = DB.exec("INSERT INTO patients (name, doctor_id) VALUES ('#{@name}', #{@doctor_id}) RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_patient|
    self.name.==(another_patient.name).&(self.id.==(another_patient.id))
  end
end
