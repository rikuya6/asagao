table_name = %w(members articles entries)
table_name.each do |name|
  path = Rails.root.join('db/seeds', Rails.env, name + '.rb')
  if File.exist?(path)
    puts "Creating #{name}..."
    require path
  end
end
