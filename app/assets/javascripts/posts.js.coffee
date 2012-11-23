# Place all the behaviors and hooks related to the matching controller here.
# All logic will automatically be available in application.js.
# You can use CoffeeScript in file: http://jashkenas.github.com/coffee-script/

SITE.posts =
  show: () ->
    this.highlight()
  new: () ->
    this.form()
  create: () ->
    this.form()
  edit: () ->
    this.form()
  update: () ->
    this.form()
  form: () ->
    this.highlight()
    this.codemirror()
    this.show_title()
  highlight: () ->
    hljs.initHighlightingOnLoad()
  codemirror: () ->
    textArea = document.getElementById("post_content")
    preview = $('#preview')
    converter = new Markdown.Converter()
    editor = CodeMirror.fromTextArea(textArea,
      mode: "markdown",
      theme: "vibrant-ink",
      lineWrapping: true,
      onChange: () ->
        preview.html(converter.makeHtml(editor.getValue()))
        #MathJax.Hub.Queue(["Typeset",MathJax.Hub])
        MathJax.Hub.Typeset()
        preview.find('pre code').each (i, e) ->
          hljs.highlightBlock(e)
    )
  show_title: () ->
    title = $('#post_title')
    title_preview = $('#post_title_preview')    
    show_title = $('#post_show_title')
    update_title = () ->
      if show_title.attr("checked")
        title_preview.text(title.val())
        title_preview.css(display: "inherit")
      else
        title_preview.css(display: "none")
    update_title()
    show_title.change update_title
    title.bind("keyup", update_title)