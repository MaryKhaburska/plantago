module ApparatsHelper
  def short_name(name)
    name.length > 25 ?
      "#{name[0..25]}..." :
      name
  end
end
