def create_tag_pages
  tag_set(items).each do |tag|
    items << ::Nanoc::Item.new("<%= render('_tag_page', :tag => '#{tag}') %>",
                               { :title => "Tags: #{tag}", :is_hidden => true },
                               "/tags/#{tag}/",
                               :binary => false
                               )
  end
end
