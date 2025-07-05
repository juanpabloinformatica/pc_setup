$(info "Checking needed packages")
DISTRIB:=$(shell cat /etc/os-release | grep -Pi "\bID\b" | awk -F"=" '{print $$2}')
ifeq (arch,${DISTRIB})
  $(info "Requirements for arch-linux")
endif
ifeq (ubuntu,${DISTRIB})
  $(info "Requirements for arch-linux")
ifeq (,$(shell which git))
  $(error "git needs to be installed")
endif

endif
#docker
#qemu
#git
