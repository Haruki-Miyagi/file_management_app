// テキストエリアを入力し改行した時に自動的に改行する
$(function() {
  var $textarea = $('textarea.form-control');
  var lineHeight = parseInt($textarea.css('lineHeight'));
  $textarea.on('input', function(e) {
    var lines = ($(this).val() + '\n' + '\n').match(/\n/g).length;
    $(this).height(lineHeight * lines);
  });
});

// pcの場合ポップアップで表示させる
// pc以外の端末は非表示
// ファイル追加・更新時のポップアップ表示
$(function () {
  var ua = navigator.userAgent;
  if (ua.indexOf('iPhone') > 0  ||
      ua.indexOf('Android') > 0 && ua.indexOf('Mobile') > 0 ||
      (ua.indexOf('iPad') > 0   || ua.indexOf('Android') > 0)) {
    $('[data-toggle="tooltip"]').tooltip('hide')
  } else {
    $('[data-toggle="tooltip"]').tooltip()
  }
})
