class Article < ActiveRecord::Base
    has_many :comments;
    has_many :taggings;
    has_many :tags, through: :taggings;
    
    def tag_list
        self.tags.collect do |tag|
            tag.name;
        end.join(", ");
    end
    
    def tag_list=(str)
        str = str.split(",");
        str = str.map {|element| element.strip.downcase }.uniq;
        new_tags = str.collect { |element| Tag.find_or_create_by(name: element) };
        self.tags = new_tags;
    end
end
