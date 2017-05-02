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
end
