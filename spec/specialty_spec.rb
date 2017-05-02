require 'spec_helper'

DB = PG.connect({:dbname => 'doctors_office_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM specialties *;")
  end
end

describe(Specialty) do
  describe(".all") do
    it("starts off with no specialties") do
      expect(Specialty.all()).to(eq([]))
    end
  end

  describe("#name") do
    it("tells you its name") do
      specialty = Specialty.new({:name => "Radiologist", :id => nil})
      expect(specialty.name).to(eq("Radiologist"))
    end
  end

  describe("#id") do
    it("sets its ID when you save it") do
      specialty = Specialty.new({:name => "Radiologist", :id => nil})
      specialty.save()
      expect(specialty.id).to(be_an_instance_of(Fixnum))
    end
  end

  describe("#save") do
    it("lets you save specialties to the database") do
      specialty = Specialty.new({:name => "Radiologist", :id => nil})
      specialty.save()
      expect(Specialty.all()).to(eq([specialty]))
    end
  end

  describe("#==") do
    it("is the same list if it has the same name") do
      specialty1 = Specialty.new({:name => "Radiologist", :id => nil})
      specialty2 = Specialty.new({:name => "Radiologist", :id => nil})
      expect(specialty1).to(eq(specialty2))
    end
  end
end
