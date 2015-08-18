class Article < ActiveRecord::Base
    has_many :comments;
    has_many :taggings;
    has_many :tags, through: :taggings;
    has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>"};
    validates_attachment_content_type :image, :content_type => ["image/jpeg", "image/jpg", "image/png"];
    
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
