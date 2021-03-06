## #FIXME: This spec file fails in Travis

# require 'rails_helper'
# require 'spec_helper'
#
# RSpec.describe 'IdeaFeature', type: :feature do
#   let!(:user_moderator){ FactoryGirl.create(:user_moderator) }
#   let!(:idea){ FactoryGirl.create(:idea) }
#   let!(:user){ FactoryGirl.create(:user) }
#
#   describe 'visiting pages' do
#       it 'approved page is accessible' do
#       visit '/'
#       expect(page).to have_current_path('/ideas?basket=Approved')
#   end
#
#       it 'new ideas page is accessible when moderator' do
#       page.set_rack_session(:user_id => user_moderator.id)
#       visit '/ideas?basket=New'
#       expect(page).to have_content('idea topic')
#     end
#
#     it 'Approved page shows published ideas' do
#       page.set_rack_session(:user_id => user_moderator.id)
#       visit '/ideas?basket=New'
#       click_link('Julkaise')
#       page.set_rack_session(:user_id => user.id)
#       visit '/'
#       expect(page).to have_current_path('/ideas?basket=Approved')
#       expect(page).to have_content('idea topic')
#     end
#   end
#
#   describe 'idea basket actions for moderators' do
#     before :each do
#       page.set_rack_session(:user_id => user_moderator.id)
#       visit '/ideas?basket=New'
#       click_link('Julkaise')
#     end
#
#   context 'when an ideas status is published' do
#     it 'shows as published and shows who moved it' do
#       expect(page).to have_current_path('/ideas?basket=Approved')
#       expect(page).to have_content('idea topic')
#       expect(page).to have_content("Hyväksytty" + ': ' + idea.histories.all.last.time.strftime('%d.%m.%Y %H:%M ') + ' ' + user_moderator.name + ' (' + user_moderator.title + ')')
#     end
#
#     it 'moves to changing when clicked and shows who moved it' do
#       click_link('Muutettava')
#       visit '/ideas?basket=Changing'
#       expect(page).to have_current_path('/ideas?basket=Changing')
#       expect(page).to have_content('idea topic')
#       expect(page).to have_content("Työn alla" + ': ' + idea.histories.all.last.time.strftime('%d.%m.%Y %H:%M ') + ' ' + user_moderator.name + ' (' + user_moderator.title + ')')
#     end
#
#     it 'moves to changed when clicked and shows who moved it' do
#       click_link('Muutettu')
#       visit '/ideas?basket=Changed'
#       expect(page).to have_current_path('/ideas?basket=Changed')
#       expect(page).to have_content('idea topic')
#       expect(page).to have_content("Muutettu" + ': ' + idea.histories.all.last.time.strftime('%d.%m.%Y %H:%M ') + ' ' + user_moderator.name + ' (' + user_moderator.title + ')')
#     end
#
#     it 'moves to not changed when clicked and shows who moved it' do
#       click_link('Ei muutettu')
#       visit '/ideas?basket=Not+Changed'
#       expect(page).to have_current_path('/ideas?basket=Not+Changed')
#       expect(page).to have_content('idea topic')
#       expect(page).to have_content("Ei muutettu" + ': ' + idea.histories.all.last.time.strftime('%d.%m.%Y %H:%M ') + ' ' + user_moderator.name + ' (' + user_moderator.title + ')')
#     end
#   end
#
#     context 'when an ideas status is changing' do
#       before :each do
#         click_link('Muutettava')
#         visit '/ideas?basket=Changing'
#       end
#
#       it 'moves to changed when clicked and shows who moved it' do
#         click_link('Muutettu')
#         visit '/ideas?basket=Changed'
#         expect(page).to have_current_path('/ideas?basket=Changed')
#         expect(page).to have_content('idea topic')
#         expect(page).to have_content("Muutettu" + ': ' + idea.histories.all.last.time.strftime('%d.%m.%Y %H:%M ') + ' ' + user_moderator.name + ' (' + user_moderator.title + ')')
#       end
#
#       it 'moves to not changed and shows who moved it' do
#         click_link('Ei muutettu')
#         visit '/ideas?basket=Not+Changed'
#         expect(page).to have_current_path('/ideas?basket=Not+Changed')
#         expect(page).to have_content('idea topic')
#         expect(page).to have_content("Ei muutettu" + ': ' + idea.histories.all.last.time.strftime('%d.%m.%Y %H:%M ') + ' ' + user_moderator.name + ' (' + user_moderator.title + ')')
#       end
#     end
#   end
#
#     context 'when it has new status' do
#       it 'moves to rejected when clicked and shows who moved it' do
#         page.set_rack_session(:user_id => user_moderator.id)
#         visit '/ideas?basket=New'
#         click_link('Hylkää')
#         expect(page).to have_current_path('/ideas?basket=Approved')
#         expect(page).to_not have_content('idea topic')
#         visit '/ideas?basket=Rejected'
#         expect(page).to have_content('idea topic')
#         expect(page).to have_content("Hylätty" + ': ' + idea.histories.all.last.time.strftime('%d.%m.%Y %H:%M ') + ' ' + user_moderator.name + ' (' + user_moderator.title + ')')
#     end
#       end
#
#   it 'redirects basket New when not moderator' do
#     page.set_rack_session(:user_id => user.id)
#     visit '/ideas?basket=New'
#     expect(page).to have_current_path('/ideas?basket=Approved')
#   end
#
#   it 'redirects basket Rejected when not moderator' do
#     page.set_rack_session(:user_id => user.id)
#     visit '/ideas?basket=Rejected'
#     expect(page).to have_current_path('/ideas?basket=Approved')
#   end
#
#   describe 'link to idea' do
#     before :each do
#       page.set_rack_session(:user_id => user_moderator.id)
#       visit '/ideas?basket=New'
#     end
#
#     context 'is not shown' do
#       it 'while basket is New' do
#         expect(page).to have_current_path('/ideas?basket=New')
#         expect(page).to have_no_selector(:css, 'a[title="Show idea"]')
#       end
#       it 'while basket is Rejected' do
#         click_link('Hylkää')
#         visit '/ideas?basket=Reject'
#         expect(page).to have_no_selector(:css, 'a[title="Show idea"]')
#       end
#     end
#
#     context 'is shown' do
#       before :each do
#         click_link('Julkaise')
#         expect(page).to have_current_path('/ideas?basket=Approved')
#       end
#
#       it 'while basket is Approved' do
#         find(:css, 'a[title="Show idea"]').click
#         expect(page).to have_current_path('/ideas/1')
#       end
#
#       it 'while basket is Changing' do
#         click_link('Muutettava')
#         visit '/ideas?basket=Changing'
#         find(:css, 'a[title="Show idea"]').click
#         expect(page).to have_current_path('/ideas/1')
#       end
#
#       it 'while basket is Changed' do
#         click_link('Muutettu')
#         visit '/ideas?basket=Changed'
#         find(:css, 'a[title="Show idea"]').click
#         expect(page).to have_current_path('/ideas/1')
#       end
#
#       it 'while basket is Not Changed' do
#         click_link('Ei muutettu')
#         visit '/ideas?basket=Not+Changed'
#         find(:css, 'a[title="Show idea"]').click
#         expect(page).to have_current_path('/ideas/1')
#       end
#     end
#   end
#
#   describe 'show active basket' do
#     before :each do
#       page.set_rack_session(:user_id => user_moderator.id)
#     end
#
#     it 'while basket is New' do
#       visit '/ideas?basket=New'
#       expect(find('li', class: 'active')).to have_content('Uudet ideat')
#     end
#
#     it 'while basket is Approved' do
#       visit '/ideas?basket=Approved'
#       expect(find('li', class: 'active')).to have_content('Hyväksytyt ideat')
#     end
#
#     it 'while basket is Changing' do
#       visit '/ideas?basket=Changing'
#       expect(find('li', class: 'active')).to have_content('Muutettavat ideat')
#     end
#
#     it 'while basket is Changed' do
#       visit '/ideas?basket=Changed'
#       expect(find('li', class: 'active')).to have_content('Muutetut ideat')
#     end
#
#     it 'while basket is Not Changed' do
#       visit '/ideas?basket=Not+Changed'
#       expect(find('li', class: 'active')).to have_content('Ei muutetut ideat')
#     end
#
#     it 'while basket is Rejected' do
#       visit '/ideas?basket=Rejected'
#       expect(find('li', class: 'active')).to have_content('Hylätyt ideat')
#     end
#   end
#
#   describe 'idea basket actions for moderators' do
#     before :each do
#       page.set_rack_session(:user_id => user_moderator.id)
#       visit '/ideas?basket=New'
#       it 'publish and moderate' do
#         click_link("Julkaise moderoituna")
#         expect(page).to have_content('idea topic')
#         expect(page).to have_content('Kommenttien moderointi päällä')
#       end
#     end
#   end
#
#   describe 'sort ideas' do
#     before :each do
#       idea1 = FactoryGirl.create(:idea_approved, topic: 'AAA older idea with likes', created_at: '2018-01-01 00:00:00')
#       idea2 = FactoryGirl.create(:idea_approved, topic: 'ZZZ newer idea without likes', created_at: '2000-01-01 00:00:00')
#       like = FactoryGirl.create(:like, idea_id: idea1.id)
#       visit '/'
#     end
#     context 'by date' do
#       it 'from new to old' do
#         expect find('h4:first-child', text: 'ZZZ newer idea without like')
#         expect find('h4:nth-last-child(2)', text: 'AAA older idea with likes')
#       end
#       it 'from old to new' do
#         page.find_link(nil, href: /created_at/).click
#         expect find('h4:first-child', text: 'AAA older idea with like')
#         expect find('h4:nth-last-child(2)', text: 'ZZZ newer idea without likes')
#       end
#     end
#     context 'by topic' do
#       before :each do
#         page.find_link(nil, href: /topic_case_insensitive/).click
#       end
#       it 'ascending' do
#         expect find('h4:first-child', text: 'AAA older idea with like')
#         expect find('h4:nth-last-child(2)', text: 'ZZZ newer idea without likes')
#       end
#       it 'descending' do
#         page.find_link(nil, href: /topic_case_insensitive/).click
#         expect find('h4:first-child', text: 'ZZZ newer idea without like')
#         expect find('h4:nth-last-child(2)', text: 'AAA older idea with likes')
#       end
#     end
#     context 'by likes' do
#       before :each do
#         page.find_link(nil, href: /likes_count_sort/).click
#       end
#       it 'ascending' do
#         expect find('h4:first-child', text: 'ZZZ newer idea without like')
#         expect find('h4:nth-last-child(2)', text: 'AAA older idea with likes')
#       end
#       it 'descending' do
#         page.find_link(nil, href: /likes_count_sort/).click
#         expect find('h4:first-child', text: 'AAA older idea with like')
#         expect find('h4:nth-last-child(2)', text: 'ZZZ newer idea without likes')
#       end
#     end
#   end
#
#   describe 'show comment count' do
#     let!(:moderated_idea){ FactoryGirl.create(:idea_moderate_enabled) }
#
#     context 'on non-moderated idea' do
#       it 'without comments' do
#         visit '/'
#         expect(page).to have_content('Kommentit (0)', count: 2)
#       end
#
#       it 'with comments' do
#         comment = FactoryGirl.create(:comment, text: 'comment', idea: moderated_idea)
#         visit '/'
#         expect(page).to have_content('Kommentit (1)', count: 2)
#       end
#     end
#
#     context 'on moderated idea for moderator' do
#       before :each do
#         page.set_rack_session(:user_id => user_moderator.id)
#       end
#
#       it 'with unpublished comments' do
#         comment = FactoryGirl.create(:comment, text: 'comment', idea: moderated_idea, visible: false)
#         visit '/'
#         expect(page).to have_content('odottaa julkaisua')
#         expect(page).to have_content('Kommentit (1)', count: 2)
#       end
#
#       it 'with published comments' do
#         comment = FactoryGirl.create(:comment, text: 'comment', idea: moderated_idea, visible: true)
#         visit '/'
#         expect(page).not_to have_content('odottaa julkaisua')
#         expect(page).to have_content('Kommentit (1)', count: 2)
#       end
#     end
#
#     context 'on moderated idea for non-moderator' do
#       it 'with unpublished comments' do
#         comment = FactoryGirl.create(:comment, text: 'comment', idea: moderated_idea, visible: false)
#         visit '/'
#         expect(page).not_to have_content('odottaa julkaisua')
#         expect(page).to have_content('Kommentit (0)', count: 2)
#       end
#
#       it 'with published comments' do
#         comment = FactoryGirl.create(:comment, text: 'comment', idea: moderated_idea, visible: true)
#         visit '/'
#         expect(page).not_to have_content('odottaa julkaisua')
#         expect(page).to have_content('Kommentit (1)', count: 2)
#       end
#     end
#   end
#
#   context 'Pagination is' do
#     before :each do
#       10.times do
#         FactoryGirl.create(:idea_approved)
#       end
#     end
#
#     it 'not shown while 10 or fewer ideas' do
#       visit '/'
#       expect(page).to have_content('idea topic', count: 10)
#       expect(page).not_to have_link('2')
#     end
#
#     it '' do
#       FactoryGirl.create(:idea_approved)
#       visit '/'
#       expect(page).to have_content('idea topic', count: 10)
#       expect(page).to have_link('2')
#       click_link('2')
#       expect(page).to have_content('idea topic', count: 1)
#     end
#   end
# end
