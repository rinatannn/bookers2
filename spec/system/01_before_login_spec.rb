require 'rails_helper'

describe '[STEP1] ユーザログイン前のテスト' do
  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/'
      end
      it 'Log inリンクが表示される: 青色のボタンの表示が「Log in」である' do
        log_in_link = find_all('a')[5]
        expect(log_in_link.text).to match(/Log in/i)
      end
      it 'Log inリンクの移行先が正しい' do
        log_in_link = find_all('a')[5]
        expect(log_in_link[:href]).to eq new_user_session_path
      end
      it 'Sign upリンクが表示される: 緑色のボタンの表示が「Sign up」である' do
        sign_up_link = find_all('a')[6]
        expect(sign_up_link.text).to match(/Sign up/i)
      end
      it 'Sign upリンクの移行先が正しい' do
        sign_up_link = find_all('a')[6]
        expect(sign_up_link[:href]).to eq new_user_registration_path
      end
    end
  end

  describe 'ヘッダーのテスト: ログインしていない場合' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'Bookersリンクが表示される: 左上から1番目のリンクが「Bookers」である' do
        expect(find_all('a')[0].text).to match(/Bookers/i)
      end
      it 'Homeリンクが表示される: 左上から2番目のリンクが「Home」である' do
        expect(find_all('a')[1].text).to match(/Home/i)
      end
      it 'Aboutリンクが表示される: 左上から3番目のリンクが「About」である' do
        expect(find_all('a')[2].text).to match(/About/i)
      end
      it 'Sign upリンクが表示される: 左上から4番目のリンクが「Sign up」である' do
        expect(find_all('a')[3].text).to match(/Sign up/i)
      end
      it 'Log inリンクが表示される: 左上から5番目のリンクが「Log in」である' do
        expect(find_all('a')[4].text).to match(/Log in/i)
      end
    end

    context 'リンクの移行先の確認' do
      it 'Bookersリンクをクリックすると、トップ画面に遷移する' do
        find_all('a')[0].click
        expect(current_path).to eq '/'
      end
      it 'Homeリンクをクリックすると、トップ画面に遷移する' do
        find_all('a')[1].click
        expect(current_path).to eq '/'
      end
      it 'Aboutリンクをクリックすると、About画面に遷移する' do
        find_all('a')[2].click
        expect(current_path).to eq '/home/about'
      end
      it 'Sign upリンクをクリックすると、新規登録画面に遷移する' do
        find_all('a')[3].click
        expect(current_path).to eq '/users/sign_up'
      end
      it 'Log inリンクをクリックすると、ログイン画面に遷移する' do
        find_all('a')[4].click
        expect(current_path).to eq '/users/sign_in'
      end
    end
  end

  describe 'ユーザ新規登録のテスト' do
    before do
      visit new_user_registration_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/sign_up'
      end
      it '「Sign up」と表示される' do
        expect(page).to have_content 'Sign up'
      end
      it 'nameフォームが表示される' do
        expect(page).to have_field 'user[name]'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'user[email]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'user[password]'
      end
      it 'password_confirmationフォームが表示される' do
        expect(page).to have_field 'user[password_confirmation]'
      end
      it 'Sign upボタンが表示される' do
        expect(page).to have_button 'Sign up'
      end
    end

    context '新規登録成功のテスト' do
      before do
        fill_in 'user[name]', with: Faker::Lorem.characters(number: 10)
        fill_in 'user[email]', with: Faker::Internet.email
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
      end

      it '正しく新規登録される' do
        expect { click_button 'Sign up' }.to change(User, :count).by(1)
      end
      it '新規登録後のリダイレクト先が、新規登録できたユーザの詳細画面になっている' do
        click_button 'Sign up'
        expect(current_path).to eq '/users/' + User.last.id.to_s
      end
    end
  end

  describe 'ユーザログインのテスト' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/sign_in'
      end
      it '「Log in」と表示される' do
        expect(page).to have_content 'Log in'
      end
      it 'nameフォームが表示される' do
        expect(page).to have_field 'user[name]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'user[password]'
      end
      it 'Sign upボタンが表示される' do
        expect(page).to have_button 'Log in'
      end
    end

    context 'ログイン成功のテスト' do
      before do
        fill_in 'user[name]', with: user.name
        fill_in 'user[password]', with: user.password
        click_button 'Log in'
      end

      it 'ログイン後のリダイレクト先が、ログインしたユーザの詳細画面になっている' do
        expect(current_path).to eq '/users/' + user.id.to_s
      end
    end

    context 'ログイン失敗のテスト' do
      before do
        fill_in 'user[name]', with: ''
        fill_in 'user[password]', with: ''
        click_button 'Log in'
      end

      it 'ログインに失敗し、ログイン画面にリダイレクトされる' do
        expect(current_path).to eq '/users/sign_in'
      end
    end
  end

  describe 'ユーザログアウトのテスト' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
      fill_in 'user[name]', with: user.name
      fill_in 'user[password]', with: user.password
      click_button 'Log in'
      logout_link = find_all('a')[4]
      logout_link.click
    end

    context 'ログアウト機能のテスト' do
      it '正しくログアウトできているか: ログアウト後のリダイレクト先がトップ画面になっている' do
        expect(current_path).to eq '/'
      end
    end
  end
end
