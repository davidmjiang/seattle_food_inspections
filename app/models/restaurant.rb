class Restaurant < ActiveRecord::Base
  has_many :inspections

  def make_address
    "#{address} #{city}, WA #{zip}"
  end

  def self.sort_by_average_score(limit, sorting)
    if sorting == "descending"
      limit(limit).joins(:inspections).group("restaurants.id, restaurants.name").order("avg(score) DESC")
    else
      limit(limit).joins(:inspections).group("restaurants.id, restaurants.name").order("avg(score) ASC")
    end
  end

  def average_score
    inspections.average(:score).round(1)
  end

  def self.search(query, limit, sorting)
    if query
      if sorting == "descending"
        limit(limit).joins(:inspections).where("name ILIKE ?", "%#{query}%").group("restaurants.id, restaurants.name").order("avg(score) DESC")
      else
        limit(limit).joins(:inspections).where("name ILIKE ?", "%#{query}%").group("restaurants.id, restaurants.name").order("avg(score) ASC")
      end
    else
      limit(limit).where("")
    end
  end

  def violation_count
    v_count = 0
    self.inspections.each do |i|
      v_count += i.violations.count
    end
    v_count
  end

  def violation_collection
    v_collection = []
    self.inspections.each do |i|
      i.violations.each do |v|
        v_collection << v
      end
    end
    v_collection
  end

end
