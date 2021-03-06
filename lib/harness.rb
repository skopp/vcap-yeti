require "vcap/logging"
require "yaml"

module BVT
  module Harness
    if ENV['VCAP_BVT_HOME']
      VCAP_BVT_HOME       = ENV['VCAP_BVT_HOME']
    else
      VCAP_BVT_HOME       = File.join(ENV['HOME'], '.bvt')
    end

    VCAP_BVT_CONFIG_FILE  = ENV['VCAP_BVT_CONFIG_FILE'] || File.join(VCAP_BVT_HOME, "config.yml")
    VCAP_BVT_ERROR_LOG    = File.join(VCAP_BVT_HOME, "error.log")

    VCAP_BVT_APP_CONFIG   = File.join(File.dirname(__FILE__), "../config/assets.yml")
    VCAP_BVT_APP_ASSETS   = YAML.load_file(VCAP_BVT_APP_CONFIG)

    VCAP_BVT_RERUN_FILE   = File.join(File.dirname(__FILE__), "../rerun.sh")

    # Assets Data Store Config
    VCAP_BVT_ASSETS_DATASTORE_CONFIG  =  File.join(VCAP_BVT_HOME, "datastore.yml")
    VCAP_BVT_ASSETS_PACKAGES_HOME     =  File.join(File.dirname(__FILE__),
                                                   "../.assets-binaries")
    VCAP_BVT_ASSETS_PACKAGES_MANIFEST =  File.join(VCAP_BVT_ASSETS_PACKAGES_HOME,
                                                   "packages.yml")
    VCAP_BVT_ASSETS_STORE_URL         =  "http://blobs.cloudfoundry.com"

    ## parallel
    VCAP_BVT_PARALLEL_MAX_USERS  = 16
    VCAP_BVT_PARALLEL_SYNC_FILE  = File.join(VCAP_BVT_HOME, "sync.yml")

    ## multi-target config in memory
    $target_config = {}

  end
end

require "harness/logger_helper"
BVT::Harness::LoggerHelper::set_logger(ENV['VCAP_BVT_TARGET'])

require "harness/constants"
require "harness/color_helper"
require "harness/rake_helper"
require "harness/cfsession"
require "harness/app"
require "harness/service"
require "harness/user"
require "harness/http_response_code"
require "harness/scripts_helper"
require "harness/parallel_helper"

## to arrange rails console cases in parallel
require "harness/parallel_monkey_patch"

## in order to support service versions, require this monkey patch
require "harness/cfoundry_monkey_patch"
