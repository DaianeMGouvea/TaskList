json.extract! task, :id, :name, :status, :completed, :created_at, :updated_at
json.url task_url(task, format: :json)
