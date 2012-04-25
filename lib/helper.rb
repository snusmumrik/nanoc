def create_tag_pages
  tag_set(items).each do |tag|
    items << ::Nanoc::Item.new("<%= render('_tag_page', :tag => '#{tag}') %>",
                               { :title => "Tags: #{tag}", :is_hidden => true },
                               "/tags/#{tag}/",
                               :binary => false
                               )
  end
end

def articles_by_year_month
  result = {}
  current_year = current_month = hash_of_year = items_of_the_month = nil
  sorted_articles.each do |article|
    d = Date.parse(article[:created_at])
    if current_year != d.year
      current_month = nil
      current_year = d.year
      hash_of_year = result[current_year] = {}
    end
    if current_month != d.month
      current_month = d.month
      items_of_the_month = hash_of_year[current_month] = []
    end
    items_of_the_month << article
  end
  result
end

def mm_str_month(month)
  sprintf("%02d", month)
end

def create_year_month_archive_pages
  articles_by_year_month.each do |year, month_hash|
    month_hash.each do |month, articles|
      month_str = sprintf("%02d", month)
      items << ::Nanoc3::Item.new(
        "<%= render('_archives_by_year_month', :year => #{year}, :month => #{month}) %>",
        { :title => "Archives: #{year}/#{month_str}", :is_hidden => true },
        "/archives/#{year}/#{month_str}/",
        :binary => false
      )
    end
  end
end
