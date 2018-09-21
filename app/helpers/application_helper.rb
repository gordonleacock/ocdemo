module ApplicationHelper
  def format_flash_message(flashes)
    return flashes if flashes.is_a?(String)
    flashes.each_pair.map { |k, v| "#{k}: #{sanitize(v)}" }.join(", ")
  end
end
