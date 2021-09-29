# urlが変更されるまで待つ
#   登録ボタンをクリックして登録処理が完了すると画面遷移する場合などで画面遷移するまで待つようにできる
#   例) wait_for_url_change { click_on '登録' }
#       登録して画面遷移が終わるまでwait_for_url_changeでsleepされる
  def wait_for_url_change(timeout_sec = 3)
    current_path = page.current_path

    yield

    Timeout.timeout(timeout_sec) do
      until page.current_path == current_path
        sleep(0.1)
      end
    end
  end

  # def wait_for_loaded_until_css_exists(selector)
  #     until has_css?(selector); end
  #   end
  #
  # def wait_for_loaded_until_content_exists(content)
  #   until has_content?(content); end
  # end
