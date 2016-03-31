FactoryGirl.define do
  sequence(:task_name) { |n| "Task name #{n}" }
  sequence(:task_description) { |n| "Task description #{n}" }

  factory :task do
    name { FactoryGirl.generate(:task_name) }
    description { FactoryGirl.generate(:task_description) }
    user
  end

  factory :invalid_task, class: 'Task' do
    name nil
    description nil
    user
  end
end

