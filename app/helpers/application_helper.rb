module ApplicationHelper
  def format_flash_message(flashes)
    flashes.each_pair.map { |k, v| "#{k}: #{sanitize(v)}" }.join(", ")
  end
end
