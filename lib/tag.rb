module Tag
  def count_by_tag(items = nil)
    items = @items if items.nil?
    count_by_tag = Hash.new(0)
    items.each do |item|
      if item[:tags]
        item[:tags].each do |tag|
          count_by_tag[tag] += 1
        end
      end
    end
    count_by_tag
  end

  def tag_set(items = nil)
    require "set"
    items = @items if items.nil?
    tags = Set.new
    items.each do |item|
      next if item[:tags].nil?
      item[:tags].each { |tag| tags << tag }
    end
    tags.to_a
  end
end
include Tag
