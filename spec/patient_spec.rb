require 'spec_helper'

describe(Patient) do
  describe(".all") do
    it("is empty at first") do
      expect(Patient.all()).to(eq([]))
    end
  end

  describe("#doctor_id") do
    it("lets you read the doctor ID out") do
      test_patient = Patient.new({:name => "Max", :doctor_id => 1, :id => nil})
      expect(test_patient.doctor_id).to(eq(1))
    end
  end

  describe("#save") do
    it("adds a patient to the array of saved patients") do
      test_patient = Patient.new({:name => "Aaron", :doctor_id => 1, :id => nil})
      test_patient.save()
      expect(Patient.all()).to(eq([test_patient]))
    end
  end
end
