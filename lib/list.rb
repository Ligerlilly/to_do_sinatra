class List
  attr_reader :name, :id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id).to_i
  end

  def self.all
    returned_lists = DB.exec('SELECT * FROM lists;')
    lists = []
    returned_lists.each do |list|
      name = list.fetch('name')
      id = list.fetch('id')
      lists.push(List.new({ name: name, id: id }))
    end
    lists
  end

  def save
    result = DB.exec("INSERT INTO lists (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first.fetch("id").to_i
  end


  def ==(another_list)
    self.name == another_list.name && self.id == another_list.id
  end

  def tasks
    returned_tasks =  DB.exec("SELECT * FROM tasks WHERE list_id = #{self.id}")
    found_tasks     = []
    returned_tasks.each do |task|
      description = task.fetch 'description'
      due_date    = task.fetch 'due_date'
      complete    = task.fetch 'complete'
      list_id     = task.fetch 'list_id'
      found_tasks.push(Task.new({description: description, complete: complete, list_id: list_id, due_date: due_date }))
    end
    found_tasks
  end

  def self.find(list_id)
    returned_lists = DB.exec("SELECT * FROM lists WHERE id = #{list_id};")
    found_list = nil
    returned_lists.each do |list|
      id = list.fetch 'id'
      name = list.fetch 'name'
      new_list = List.new({ name: name, id: id})
      if list_id == new_list.id
        found_list = new_list
      end
    end
    found_list
  end

end
