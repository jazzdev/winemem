$(document).ready(function() {
    $(".striped tr:even").addClass("alt");
    $("input:text:visible:first").focus();
    var inputText = document.getElementById("desc");
    var end = inputText.value.length;
    setCaretToPos(inputText, end, end);
    $("#wines").tablesorter({ headers: { 5: { sorter: false }}});
    $("#wines").bind("sortEnd",function() {
	$(".striped tr").removeClass("alt");
	$(".striped tr:even").addClass("alt");
    });
});

function setSelectionRange(input, selectionStart, selectionEnd) {
  if (input.setSelectionRange) {
    input.focus();
    input.setSelectionRange(selectionStart, selectionEnd);
  }
  else if (input.createTextRange) {
    var range = input.createTextRange();
    range.collapse(true);
    range.moveEnd('character', selectionEnd);
    range.moveStart('character', selectionStart);
    range.select();
  }
}

function setCaretToPos (input, pos) {
  setSelectionRange(input, pos, pos);
}
