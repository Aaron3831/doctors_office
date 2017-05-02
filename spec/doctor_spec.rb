require 'spec_helper'

describe(Doctor) do
  describe(".all") do
    it("is empty at first") do
      expect(Doctor.all()).to(eq([]))
    end
  end

  describe("#specialty_id") do
    it("lets you read the specialty ID out") do
      test_doctor = Doctor.new({:name => "Aaron", :specialty_id => 1, :id => nil})
      expect(test_doctor.specialty_id).to(eq(1))
    end
  end

  describe("#save") do
    it("adds a doctor to the array of saved doctors") do
      test_doctor = Doctor.new({:name => "Aaron", :specialty_id => 1, :id => nil})
      test_doctor.save()
      expect(Doctor.all()).to(eq([test_doctor]))
    end
  end

  describe(".doctors_in_specialty") do
    it("finds all doctors that are in the specialty") do
      test_specialty = Specialty.new({:name => "Radiologist", :id => nil})
      test_specialty.save()
      test_doctor = Doctor.new({:name => "Aaron", :specialty_id => test_specialty.id, :id => nil})
      test_doctor.save()
      expect(Doctor.doctors_in_specialty("Radiologist")).to(eq([test_doctor]))
    end
  end

  describe(".patients_for_doctor") do
    it("Shows each doctor in alphabetical order with number of patients they see") do
      test_doctor1 = Doctor.new({:name => "Max", :specialty_id => 2, :id => nil})
      test_doctor1.save()
      test_doctor2 = Doctor.new({:name => "Aaron", :specialty_id => 1, :id => nil})
      test_doctor2.save()
      test_patient1 = Patient.new({:name => "patient1", :doctor_id => test_doctor1.id, :id => nil})
      test_patient1.save()
      test_patient2 = Patient.new({:name => "patient2", :doctor_id => test_doctor2.id, :id => nil})
      test_patient2.save()
      test_patient3 = Patient.new({:name => "patient3", :doctor_id => test_doctor1.id, :id => nil})
      test_patient3.save()
      expect(Doctor.patients_for_doctor()).to(eq(["Aaron1", "Max2"]))
    end
  end
end
