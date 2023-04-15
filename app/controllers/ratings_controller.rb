class RatingsController < ApplicationController
  def calculateEmployeeRating(employee)
    # Calculate average task completion rate
    task_completion_rates = employee.tasks.map(&:completion_rate)
    task_completion_rate = task_completion_rates.sum / task_completion_rates.size.to_f

    # Calculate average attendance rate
    attendance_rates = employee.attendances.map(&:attendance_rate)
    attendance_rate = attendance_rates.sum / attendance_rates.size.to_f

    # Get current project, if any
    current_project = employee.projects.current

    # Calculate disciplinary points
    disciplinary_points = employee.disciplinary_actions.sum(:points)

    # Calculate employee rating
    rating = 0.35 * task_completion_rate + 0.3 * attendance_rate

    if current_project
      # Check if employee completed tasks within project timeline
      project_completion_rate = employee.tasks.where(project_id: current_project.id).where("end_time <= ?", current_project.completion_date).size.to_f / employee.tasks.where(project_id: current_project.id).size.to_f
      rating += 0.15 * project_completion_rate

      # Give weightage to task status
      task_weightage = {
        "completed" => 0.2,
        "in progress" => 0.1,
        "not started" => 0.05,
      }
      task_weighted_rates = employee.tasks.map { |t| task_weightage[t.status] * t.completion_rate }
      task_weighted_rate = task_weighted_rates.sum / task_weighted_rates.size.to_f
      rating += 0.15 * task_weighted_rate

      # Give weightage to task complexity
      task_weightage_by_description = {
        "high" => 0.2,
        "medium" => 0.1,
        "low" => 0.05,
      }
      task_weighted_rates_by_description = employee.tasks.map { |t| task_weightage_by_description[t.description] * t.completion_rate }
      task_weighted_rate_by_description = task_weighted_rates_by_description.sum / task_weighted_rates_by_description.size.to_f
      rating += 0.05 * task_weighted_rate_by_description

      # Check if project was completed within budget
      if current_project.expenses <= current_project.budget
        rating += 0.05
      end
    end

    rating -= 0.05 * disciplinary_points

    # Ensure rating is within range
    rating = [0, rating, 100].sort[1]

    return rating
  end
end
