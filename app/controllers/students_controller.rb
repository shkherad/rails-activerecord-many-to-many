class StudentsController < ApplicationController
  def show
    @student = Student.find(params[:id])
  end

  def new
    @house = House.find(params[:house_id])
    @student = Student.new
  end

  def create
    house = House.find(params[:house_id])
    student = house.students.create(student_params)
    redirect_to [house, student]
  end

  private

  def student_params
    params.require(:student).permit(:name)
  end
end
