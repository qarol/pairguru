class MovieExporterJob < ApplicationJob
  queue_as :default

  def perform(*args)
    MovieExporter.new.call(*args)
  end
end
