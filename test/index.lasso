@coffee


    $('.block').on 'click', ->

      $(this).toggleClass('orange')


@sass
  .block
    @extend %block
    margin: 20px
    color: white
  .orange
    background-color: orange
  .blue
    background-color: blue

@jade
  @include section.jade
    .block.blue
