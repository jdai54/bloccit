module ApplicationHelper
  # #4 define a method named form_group_tag which takes two arguments. The first argument is an array of errors, and the second is a block. The & turns the block into a Proc which is a block that can be resued like a variable
  def form_group_tag(errors, &block)
    css_class = 'form-group'
    css_class << ' has-error' if errors.any?
  # #5 the content_tag helper method is called. This method is used to build the HTML and CSS to display the form element and any associated errors. Helpers are written in Ruby and usually return HTML. It takes a symbol argument, a block, and an options hash. It then creates a symbol-specified HTML tag with the block contents, and if specified, the options
    content_tag :div, capture(&block), class: css_class
  end
end
