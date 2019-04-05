ActionView::Base.field_error_proc = proc do |html_tag, instance|
  if html_tag.match?(/^<label/)
    %(<div class="field_with_errors has-error">#{html_tag}</div>).html_safe
  else
    %(<div class="field_with_errors has-error">#{html_tag}<label for="#{instance.send(:tag_id)}" class="full-width help-block alert alert-danger scrolled_box"><ul class="list-unstyled">#{instance.error_message.map { |error| "<li>#{error}</li>" }.join}</ul><div class="clearfix"></div></label></div>).html_safe
  end
end
