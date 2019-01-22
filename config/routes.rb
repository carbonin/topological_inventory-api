Rails.application.routes.draw do
  prefix = "api"
  if ENV["PATH_PREFIX"].present? && ENV["APP_NAME"].present?
    prefix = File.join(ENV["PATH_PREFIX"], ENV["APP_NAME"]).gsub(/^\/+|\/+$/, "")
  end

  scope :as => :api, :module => "api", :path => prefix do
    match "/v0/*path", :via => [:delete, :get, :options, :patch, :post, :put], :to => redirect("#{prefix}/v0.0/%{path}")

    namespace :v0x1, :path => "v0.1" do
      resources :authentications,         :only => [:create, :destroy, :index, :show, :update]
      resources :containers,              :only => [:index, :show]
      resources :container_groups,        :only => [:index, :show] do
        resources :containers, :only => [:index]
      end
      resources :container_nodes,         :only => [:index, :show] do
        resources :container_groups, :only => [:index]
      end
      resources :container_images,        :only => [:index, :show]
      resources :container_projects,      :only => [:index, :show] do
        resources :container_groups,    :only => [:index]
        resources :container_templates, :only => [:index]
      end
      resources :container_templates,     :only => [:index, :show]
      resources :endpoints,               :only => [:create, :destroy, :index, :show, :update]
      resources :flavors,                 :only => [:index, :show]
      resources :service_instances,       :only => [:index, :show]
      resources :service_offerings,       :only => [:index, :show] do
        resources :service_instances,       :only => [:index]
        resources :service_plans, :only => [:index]
      end
      resources :orchestration_stacks, :only => [:index, :show]
      resources :service_plans, :only => [:index, :show] do
        post "order", :to => "service_plans#order"
        resources :service_instances, :only => [:index]
      end
      resources :source_types, :only => [:create, :index, :show] do
        resources :sources, :only => [:index]
      end
      resources :sources,                 :only => [:create, :destroy, :index, :show, :update] do
        resources :containers,              :only => [:index]
        resources :container_groups,        :only => [:index]
        resources :container_images,        :only => [:index]
        resources :container_nodes,         :only => [:index]
        resources :container_projects,      :only => [:index]
        resources :container_templates,     :only => [:index]
        resources :endpoints,               :only => [:index]
        resources :orchestration_stacks,    :only => [:index]
        resources :service_instances,       :only => [:index]
        resources :service_offerings,       :only => [:index]
        resources :service_plans, :only => [:index]
        resources :vms,                     :only => [:index]
        resources :volume_types,            :only => [:index]
        resources :volumes,                 :only => [:index]
      end
      resources :tasks, :only => [:index, :show]
      resources :vms, :only => [:index, :show] do
        resources :volume_attachments, :only => [:index]
        resources :volumes,            :only => [:index]
      end
      resources :volume_attachments, :only => [:index, :show]
      resources :volume_types,       :only => [:index, :show]
      resources :volumes,            :only => [:index, :show]
    end

    namespace :v0x0, :path => "v0.0" do
      resources :authentications,         :only => [:create, :destroy, :index, :show, :update]
      resources :containers,              :only => [:index, :show]
      resources :container_groups,        :only => [:index, :show] do
        resources :containers, :only => [:index]
      end
      resources :container_nodes,         :only => [:index, :show] do
        resources :container_groups, :only => [:index]
      end
      resources :container_images,        :only => [:index, :show]
      resources :container_projects,      :only => [:index, :show] do
        resources :container_groups,    :only => [:index]
        resources :container_templates, :only => [:index]
      end
      resources :container_templates,     :only => [:index, :show]
      resources :endpoints,               :only => [:create, :destroy, :index, :show, :update]
      resources :flavors,                 :only => [:index, :show]
      resources :service_instances,       :only => [:index, :show]
      resources :service_offerings,       :only => [:index, :show] do
        resources :service_instances,       :only => [:index]
        resources :service_plans, :only => [:index]
      end
      resources :orchestration_stacks, :only => [:index, :show]
      resources :service_plans, :only => [:index, :show] do
        post "order", :to => "service_plans#order"
        resources :service_instances, :only => [:index]
      end
      resources :source_types, :only => [:create, :index, :show] do
        resources :sources, :only => [:index]
      end
      resources :sources,                 :only => [:create, :destroy, :index, :show, :update] do
        resources :containers,              :only => [:index]
        resources :container_groups,        :only => [:index]
        resources :container_images,        :only => [:index]
        resources :container_nodes,         :only => [:index]
        resources :container_projects,      :only => [:index]
        resources :container_templates,     :only => [:index]
        resources :endpoints,               :only => [:index]
        resources :orchestration_stacks,    :only => [:index]
        resources :service_instances,       :only => [:index]
        resources :service_offerings,       :only => [:index]
        resources :service_plans, :only => [:index]
        resources :vms,                     :only => [:index]
        resources :volume_types,            :only => [:index]
        resources :volumes,                 :only => [:index]
      end
      resources :tasks, :only => [:index, :show]
      resources :vms, :only => [:index, :show] do
        resources :volume_attachments, :only => [:index]
        resources :volumes,            :only => [:index]
      end
      resources :volume_attachments, :only => [:index, :show]
      resources :volume_types,       :only => [:index, :show]
      resources :volumes,            :only => [:index, :show]
    end
  end
end
