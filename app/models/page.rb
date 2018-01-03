# == Schema Information
#
# Table name: pages
#
#  id           :integer          not null, primary key
#  page_type    :string
#  title        :string
#  content_html :string
#  content      :string
#  source_url   :string
#  status       :string
#  screenshot   :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  company_id   :integer
#

class Page < ApplicationRecord
  ACTIVE_STATUS   = 'active'.freeze
  PENDING_STATUS  = 'pending'.freeze
  FINISHED_STATUS = 'finished'.freeze
  STATUSES        = [ACTIVE_STATUS, PENDING_STATUS, FINISHED_STATUS].freeze

  BING_TYPE       = 'bing'.freeze
  ANGLECO_TYPE    = 'angle.co'.freeze
  LINKEDIN_TYPE   = 'linkedin'.freeze
  CRUNCHBASE_TYPE = 'crunchbase'.freeze
  PAGE_TYPES      = [BING_TYPE, ANGLECO_TYPE, LINKEDIN_TYPE, CRUNCHBASE_TYPE].freeze

  belongs_to :company

  mount_uploader :screenshot, ScreenshotUploader

  after_commit :start_worker, on: :create

  private

  def start_worker
    NewPageWorker.perform_async(id)
  end
end
