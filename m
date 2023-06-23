Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0A473B794
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jun 2023 14:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbjFWMlI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Jun 2023 08:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjFWMlG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Jun 2023 08:41:06 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA102126;
        Fri, 23 Jun 2023 05:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687524061; x=1719060061;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uTdU/i32piFdb7v87h1WXxNSsz43lpPMopUoNy1xfM0=;
  b=g5XVaPzNOWNJYwBKE61ZW2ysIK3aVFhpaVfVwYOgC3DOpc/KJfRGLxl/
   3l/LF7VjuND1H92c+KKm/0mgwKt9yapdZcp7oZie5IOxmIFKWIpawN1yw
   7QsZmK8ZzoEWRti2PgDI7+11G1lHxWBFfOOn5tCsjyykXXhgrafuApF+Q
   0qKcIRsfW5M1TuXJCplbksr56/uJ6u+HP+FB/WBmFBYSwHSQ32g9zQFaH
   46AaxRkMCCFfMgAfJ+j6elFHf6qXrDaYxcOHJBw2MwzYRAIZqhDwZgipt
   m3dD09pWOMWkblnsXBgy0P1UDFTuSo8f68EVGyrZvmDihxO98j3M5p8gI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="341096349"
X-IronPort-AV: E=Sophos;i="6.01,152,1684825200"; 
   d="scan'208";a="341096349"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 05:40:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="785321147"
X-IronPort-AV: E=Sophos;i="6.01,152,1684825200"; 
   d="scan'208";a="785321147"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by fmsmga004.fm.intel.com with ESMTP; 23 Jun 2023 05:40:12 -0700
From:   Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To:     kuba@kernel.org, jiri@resnulli.us, arkadiusz.kubalewski@intel.com,
        vadfed@meta.com, jonathan.lemon@gmail.com, pabeni@redhat.com
Cc:     corbet@lwn.net, davem@davemloft.net, edumazet@google.com,
        vadfed@fb.com, jesse.brandeburg@intel.com,
        anthony.l.nguyen@intel.com, saeedm@nvidia.com, leon@kernel.org,
        richardcochran@gmail.com, sj@kernel.org, javierm@redhat.com,
        ricardo.canuelo@collabora.com, mst@redhat.com, tzimmermann@suse.de,
        michal.michalik@intel.com, gregkh@linuxfoundation.org,
        jacek.lawrynowicz@linux.intel.com, airlied@redhat.com,
        ogabbay@kernel.org, arnd@arndb.de, nipun.gupta@amd.com,
        axboe@kernel.dk, linux@zary.sk, masahiroy@kernel.org,
        benjamin.tissoires@redhat.com, geert+renesas@glider.be,
        milena.olech@intel.com, kuniyu@amazon.com, liuhangbin@gmail.com,
        hkallweit1@gmail.com, andy.ren@getcruise.com, razor@blackwall.org,
        idosch@nvidia.com, lucien.xin@gmail.com, nicolas.dichtel@6wind.com,
        phil@nwl.cc, claudiajkang@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, poros@redhat.com,
        mschmidt@redhat.com, linux-clk@vger.kernel.org,
        vadim.fedorenko@linux.dev
Subject: [RFC PATCH v9 00/10] Create common DPLL configuration API
Date:   Fri, 23 Jun 2023 14:38:10 +0200
Message-Id: <20230623123820.42850-1-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Implement common API for clock/DPLL configuration and status reporting.
The API utilises netlink interface as transport for commands and event
notifications. This API aim to extend current pin configuration and
make it flexible and easy to cover special configurations.

Netlink interface is based on ynl spec, it allows use of in-kernel
tools/net/ynl/cli.py application to control the interface with properly
formated command and json attribute strings. Here are few command
examples of how it works with `ice` driver on supported NIC:

- dump dpll devices
$# ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml \
--dump device-get
[{'clock-id': 282574471561216,
  'id': 0,
  'lock-status': 'unlocked',
  'mode': 'automatic',
  'module-name': 'ice',
  'type': 'eec'},
 {'clock-id': 282574471561216,
  'id': 1,
  'lock-status': 'unlocked',
  'mode': 'automatic',
  'module-name': 'ice',
  'type': 'pps'}]

- get single pin info:
$# ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml \
--do pin-get --json '{"pin-id":2}'
{'clock-id': 282574471561216,
 'module-name': 'ice',
 'pin-board-label': 'C827_0-RCLKA',
 'pin-dpll-caps': 6,
 'pin-frequency': 1953125,
 'pin-id': 2,
 'pin-parenti-device': [{'id': 0,
                         'pin-direction': 'input',
                         'pin-prio': 11,
                         'pin-state': 'selectable'},
                        {'id': 1,
                         'pin-direction': 'input',
                         'pin-prio': 9,
                         'pin-state': 'selectable'}],
 'pin-type': 'mux'}

- set pin's state on dpll:
$# ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml \
--do pin-set --json '{"pin-id":2, "pin-parent-device":{"id":1, "pin-state":2}}'

- set pin's prio on dpll:
$# ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml \
--do pin-set --json '{"pin-id":2, "pin-parent-device":{"id":1, "pin-prio":4}}'

- set pin's state on parent pin:
$# ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml \
--do pin-set --json '{"pin-id":13, \
                      "pin-parent-pin":{"pin-id":2, "pin-state":1}}'

v8 -> v9:
[00/10] Create common DPLL configuration API
- update examples to reflect new pin-parent nest split

[01/10] dpll: documentation on DPLL subsystem interface
- fix docs build warnings
- separate netlink command/attribute list
- replace enum description with uapi header
- add brief explanation what is a DPLL
- fix EOPNOTSUPP typo
- fix typo .state_get -> .state_on_dpll_get

[02/10] dpll: spec: Add Netlink spec in YAML
- regenerate policy max values
- add missing enum descriptions
- split pin-parent nest:
  - pin-parent-device - for configuration of pin-device tuple
  - pin-parent-pin - for configuration od pin-pin tuple
- fix typos:
  - s/working-modes/working modes/
  - s/differentiate/differentiates/
  - s/valid input, auto selected by dpll/input pin auto selected by dpll/
- remove FREERUN and HOLDOVER modes

[03/10] dpll: core: Add DPLL framework base functions
- fix description in spdx header.
- remove refcount check if refcount was already set
- do not validate dpll ptr in dpll_device_put(..)
- fix return -ENOMEM on failed memory alloc
- do not validate pin ptr in dpll_pin_put(..)
- return -EINVAL in case of module/clock_id mismatch
- do not {} around one-line xa_for_each() macro
- move dpll_<x>_registration structs to dpll_core.c
- rephrase doc comment on device and pin id struct members
- remove ref in case of memory allocation fail
- check for required ops on pin/device registration
- mark pin with DPLL_REGISTERED once pin is registered with dpll

[04/10] dpll: netlink: Add DPLL framework base functions
- fix pin-id-get/device-id-get behavior
- reshuffle order of functions
- avoid forward declarations
- functions for adding pin/device handle next to each other
- pass ops callback return values to the user
- remove dpll_cmd_pin_fill_details(..) function, merge the code into
  __dpll_cmd_pin_dump_one(..)
- rename __dpll_cmd_pin_dump_one() to dpll_cmd_pin_get_one()
- use WARN_ON macro when dpll ref is missing
- remove redundant pin's dpll list not empty check
- remove double spaces inside if statement
- add extack message when set command is not possible
- do not return error when callback is not required
- WARN_ON missing ops moved to dpll_core.c
- use DPLL_REGISTERED if pin was registered with dpll
- fix pin-id-get return and add extack errors
- fix device-id-get return and add extack errors
- drop pointless init of variables
- add macro for iterating over marked pins/devices
- move dpll_set_from_nlattr() for consistent order
- use GENL_REQ_ATTR_CHECK() for checking attibute presence
- fill extack if pin/device was not found
- drop pointless init of variables
- WARN_ON if dpll not registered on send event
- rename goto labels to indicate error path
- fix docs
- drop pointless init of variables
- verify pin in notify with a mark
- prevent ops->mode_set call if missing callback
- move static dpll_msg_add_pin_handle() from pin<->netdev patch
- split pin-parent nest:
  - pin-parent-device - for configuration of pin-device tuple
  - pin-parent-pin - for configuration od pin-pin tuple

[06/10] netdev: expose DPLL pin handle for netdevice
- net_device->dpll_pin is only valid if IS_ENABLED(CONFIG_DPLL) fix the
  code in net/core/rtnetlink.c to respect that.
- move dpll_msg_add_pin_handle to "dpll: netlink" patch + export the
  function with this patch

[07/10] ice: add admin commands to access cgu configuration
- rename MAX_NETLIST_SIZE -> ICE_MAX_NETLIST_SIZE
- simplify function: s64 convert_s48_to_s64(s64 signed_48)
- do not assign 0 to field that is already 0

[08/10] ice: implement dpll interface to control cgu
- drop pointless 0 assignement
- ice_dpll_init(..) returns void instead of int
- fix context description of the functions
- fix ice_dpll_init(..) traces
- fix use package_label instead pf board_label for rclk pin
- be consistent on cgu presence naming
- remove indent in ice_dpll_deinit(..)
- remove unused struct field lock_err_num
- fix kworker resched behavior
- remove debug log from ice_dpll_deinit_worker(..)
- reorder ice internal functions
- release resources directly on error path
- remove redundant NULL checks when releasing resources
- do not assign NULL to pointers after releasing resources
- simplify variable assignement
- fix 'int ret;' declarations across the ice_dpll.c
- remove leftover ice_dpll_find(..)
- get pf pointer from dpll_priv without type cast
- improve error reporting
- fix documentation
- fix ice_dpll_update_state(..) flow
- fix return in case out of range prio set


v7 -> v8:
[0/10] Create common DPLL configuration API
- reorder the patches in patch series
- split patch "[RFC PATCH v7 2/8] dpll: Add DPLL framework base functions"
  into 3 smaller patches for easier review:
  - [03/10] dpll: core: Add DPLL framework base functions
  - [04/10] dpll: netlink: Add DPLL framework base functions
  - [05/10] dpll: api header: Add DPLL framework base
- add cli.py usage examples in commit message

[01/10] dpll: documentation on DPLL subsystem interface
- fix DPLL_MODE_MANUAL documentation
- remove DPLL_MODE_NCO
- remove DPLL_LOCK_STATUS_CALIBRATING
- add grepability Use full names of commands, attributes and values of
  dpll subsystem in the documentation
- align documentation with changes introduced in v8
- fix typos
- fix phrases to better show the intentions
- move dpll.rst to Documentation/driver-api/

[02/10] dpll: spec: Add Netlink spec in YAML
- remove unspec attribute values
- add 10 KHZ and 77,5 KHZ frequency defines
- fix documentation
- remove assigned values from subset attributes
- reorder dpll attributes
- fix `device` nested attribute usage, device get is not used on pin-get
- temperature with 3 digit float precision
- remove enum from subset definitions
- move pin-direction to pin-dpll tuple/subset
- remove DPLL_MODE_NCO
- remove DPLL_LOCK_STATUS_CALIBRATING
- fix naming scheme od notification interface functions
- separate notifications for pins
- rename attribute enum name: dplla -> dpll_a
- rename pin-idx to pin-id
- remove attributes: pin-parent-idx, device
- replace bus-name and dev-name attributes with module-name
- replace pin-label with 3 new attributes: pin-board-label,
  pin-panel-label, pin-package-label
- add device-id-get and pin-id-get commands
- remove rclk-dev-name atribute
- rename DPLL_PIN_DIRECTION_SOURCE -> DPLL_PIN_DIRECTION_INPUT

[03/10] dpll: core: Add DPLL framework base functions
[04/10] dpll: netlink: Add DPLL framework base functions
[05/10] dpll: api header: Add DPLL framework base
- remove unspec attributes after removing from dpll netlink spec
- move pin-direction to pin-dpll tuple
- pass parent_priv on state_on_pin_<get/set>
- align with new notification definitions from netlink spec
- use separated notifications for dpll pins and devices
- format notification messages as corresponding get netlink commands
- rename pin-idx to pin-id
- remove attributes pin-parent-idx, device
- use DPLL_A_PIN_PARENT to hold information on parent pin or dpll device
- refactor lookup for pins and dplls for dpll subsystem
- replace bus-name, dev-name with module-name
- replace pin-label with 3 new attributes: pin-board-label,
  pin-panel-label, pin-package-label
- add device-id-get and pin-id-get commands
- rename dpll_xa_lock to dpll_lock
- improve doxygen in dpll_core.c
- remove unused parent and dev fields from dpll_device struct
- use u32 for pin_idx in dpll_pin_alloc
- use driver provided pin properties struct
- verify pin/dpll owner on registering pin
- remove const arg modifier for helper _priv functions
- remove function declaration _get_by_name()
- update SPDX headers
- parse netlink set attributes with nlattr array
- remove rclk-dev-name attribute
- remove device pointer from dpll_pin_register/dpll_device_register
- remove redundant doxygen from dpll header
- use module_name() to get name of module
- add missing/remove outdated kdocs
- fix call frequency_set only if available
- fix call direction_set only for pin-dpll tuple

[06/10] netdev: expose DPLL pin handle for netdevice
- rebased on top of v8 changes
  - use dpll_msg_add_pin_handle() in dpll_pin_find_from_nlattr()
    and dpll_msg_add_pin_parents()
  - fixed handle to use DPLL_A_PIN_ID and removed temporary comments
- added documentation record for dpll_pin pointer
- fixed compilation of net/core/dev.c when CONFIG_DPLL is not enabled
- adjusted patch description a bit

[07/10] ice: add admin commands to access cgu configuration
- Remove unspec attributes after removing from dpll netlink spec.

[08/10] ice: implement dpll interface to control cgu
- remove unspec attributes
- do not store pin flags received in set commands
- use pin state field to provide pin state to the caller
- remove include of uapi header
- remove redundant check against null arguments
- propagate lock function return value to the caller
- use switch case instead of if statements
- fix dev_dbg to dev_err for error cases
- fix dpll/pin lookup on dpll subsytem callbacks
- fix extack of dpll subsystem callbacks
- remove double negation and variable cast
- simplify ice_dpll_pin_state_set function
- pass parent_priv on state_on_pin_<get/set>
- remove parent hw_idx lookup
- fix use const qualifier for dpll/dpll_pin ops
- fix IS_ERR macros usage in ice_dpll
- add notify previous source state change
- fix mutex locking on releasing pins
- use '|=' instead of '+=' when modifing capabilities field
- rename ice_dpll_register_pins function
- clock_id function to return clock ID on the stack instead of using
  an output variable
- DPLL_LOCK_STATUS_CALIBRATING was removed, return:
  DPLL_LOCK_STATUS_LOCKED - if dpll was locked
  DPLL_LOCK_STATUS_LOCKED_HO_ACQ - if dpll was locked and holdover is
  acquired
- propagate and use dpll_priv to obtain pf pointer in corresponding
  functions.
- remove null check for pf pointer
- adapt to `dpll: core: fix notification scheme`
- expose pf related pin to corresponding netdevice
- fix dpll init error path
- fix dpll pins naming scheme `source` -> `input`
- replace pin-label with pin-board-label
- dpll remove parent and dev fields from dpll_device
- remove device pointer from dpll_pin_register/dpll_device_register
- rename DPLL_PIN_DIRECTION_SOURCE -> DPLL_PIN_DIRECTION_INPUT

[09/10] ptp_ocp: implement DPLL ops
- replace pin-label with pin-board-label
- dpll remove parent and dev fields from dpll_device
- remove device pointer from dpll_pin_register/dpll_device_register
- rename DPLL_PIN_DIRECTION_SOURCE -> DPLL_PIN_DIRECTION_INPUT

[10/10] mlx5: Implement SyncE support using DPLL infrastructure
- rebased on top of v8 changes:
  - changed notification scheme
  - no need to fill pin label
  - implemented locked_ho_acq status
  - rename DPLL_PIN_DIRECTION_SOURCE -> DPLL_PIN_DIRECTION_INPUT
  - remove device pointer from dpll_pin_register/dpll_device_register
- fixed MSEES register writes
- adjusted pin state and lock state values reported
- fixed a white space issue

v6 -> v7:
 * YAML spec:
   - remove nested 'pin' attribute
   - clean up definitions on top of the latest changes
 * pin object:
   - pin xarray uses id provided by the driver
   - remove usage of PIN_IDX_INVALID in set function
   - source_pin_get() returns object instead of idx
   - fixes in frequency support API
 * device and pin operations are const now
 * small fixes in naming in Makefile and in the functions
 * single mutex for the subsystem to avoid possible ABBA locks
 * no special *_priv() helpers anymore, private data is passed as void*
 * no netlink filters by name anymore, only index is supported
 * update ptp_ocp and ice drivers to follow new API version
 * add mlx5e driver as a new customer of the subsystem
v5 -> v6:
 * rework pin part to better fit shared pins use cases
 * add YAML spec to easy generate user-space apps
 * simple implementation in ptp_ocp is back again
v4 -> v5:
 * fix code issues found during last reviews:
   - replace cookie with clock id
   - follow one naming schema in dpll subsys
   - move function comments to dpll_core.c, fix exports
   - remove single-use helper functions
   - merge device register with alloc
   - lock and unlock mutex on dpll device release
   - move dpll_type to uapi header
   - rename DPLLA_DUMP_FILTER to DPLLA_FILTER
   - rename dpll_pin_state to dpll_pin_mode
   - rename DPLL_MODE_FORCED to DPLL_MODE_MANUAL
   - remove DPLL_CHANGE_PIN_TYPE enum value
 * rewrite framework once again (Arkadiusz)
   - add clock class:
     Provide userspace with clock class value of DPLL with dpll device
     dump netlink request. Clock class is assigned by driver allocating
     a dpll device. Clock class values are defined as specified in:
     ITU-T G.8273.2/Y.1368.2 recommendation.
   - dpll device naming schema use new pattern:
     "dpll_%s_%d_%d", where:
       - %s - dev_name(parent) of parent device,
       - %d (1) - enum value of dpll type,
       - %d (2) - device index provided by parent device.
   - new muxed/shared pin registration:
     Let the kernel module to register a shared or muxed pin without
     finding it or its parent. Instead use a parent/shared pin
     description to find correct pin internally in dpll_core, simplifing
     a dpll API
 * Implement complex DPLL design in ice driver (Arkadiusz)
 * Remove ptp_ocp driver from the series for now
v3 -> v4:
 * redesign framework to make pins dynamically allocated (Arkadiusz)
 * implement shared pins (Arkadiusz)
v2 -> v3:
 * implement source select mode (Arkadiusz)
 * add documentation
 * implementation improvements (Jakub)
v1 -> v2:
 * implement returning supported input/output types
 * ptp_ocp: follow suggestions from Jonathan
 * add linux-clk mailing list
v0 -> v1:
 * fix code style and errors
 * add linux-arm mailing list


*** BLURB HERE ***

Arkadiusz Kubalewski (3):
  dpll: spec: Add Netlink spec in YAML
  ice: add admin commands to access cgu configuration
  ice: implement dpll interface to control cgu

Jiri Pirko (2):
  netdev: expose DPLL pin handle for netdevice
  mlx5: Implement SyncE support using DPLL infrastructure

Vadim Fedorenko (5):
  dpll: documentation on DPLL subsystem interface
  dpll: core: Add DPLL framework base functions
  dpll: netlink: Add DPLL framework base functions
  dpll: api header: Add DPLL framework base functions
  ptp_ocp: implement DPLL ops

 Documentation/driver-api/dpll.rst             |  428 ++++
 Documentation/driver-api/index.rst            |    1 +
 Documentation/netlink/specs/dpll.yaml         |  472 ++++
 MAINTAINERS                                   |    8 +
 drivers/Kconfig                               |    2 +
 drivers/Makefile                              |    1 +
 drivers/dpll/Kconfig                          |    7 +
 drivers/dpll/Makefile                         |    9 +
 drivers/dpll/dpll_core.c                      |  976 ++++++++
 drivers/dpll/dpll_core.h                      |   92 +
 drivers/dpll/dpll_netlink.c                   | 1271 +++++++++++
 drivers/dpll/dpll_netlink.h                   |   17 +
 drivers/dpll/dpll_nl.c                        |  163 ++
 drivers/dpll/dpll_nl.h                        |   51 +
 drivers/net/ethernet/intel/Kconfig            |    1 +
 drivers/net/ethernet/intel/ice/Makefile       |    3 +-
 drivers/net/ethernet/intel/ice/ice.h          |    5 +
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  240 +-
 drivers/net/ethernet/intel/ice/ice_common.c   |  462 ++++
 drivers/net/ethernet/intel/ice/ice_common.h   |   43 +
 drivers/net/ethernet/intel/ice/ice_dpll.c     | 2002 +++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_dpll.h     |  101 +
 drivers/net/ethernet/intel/ice/ice_lib.c      |   17 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |    7 +
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |  413 ++++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  230 ++
 drivers/net/ethernet/intel/ice/ice_type.h     |    1 +
 .../net/ethernet/mellanox/mlx5/core/Kconfig   |    8 +
 .../net/ethernet/mellanox/mlx5/core/Makefile  |    3 +
 drivers/net/ethernet/mellanox/mlx5/core/dev.c |   17 +
 .../net/ethernet/mellanox/mlx5/core/dpll.c    |  432 ++++
 drivers/ptp/Kconfig                           |    1 +
 drivers/ptp/ptp_ocp.c                         |  329 ++-
 include/linux/dpll.h                          |  164 ++
 include/linux/mlx5/driver.h                   |    2 +
 include/linux/mlx5/mlx5_ifc.h                 |   59 +-
 include/linux/netdevice.h                     |   20 +
 include/uapi/linux/dpll.h                     |  183 ++
 include/uapi/linux/if_link.h                  |    2 +
 net/core/dev.c                                |   22 +
 net/core/rtnetlink.c                          |   35 +
 41 files changed, 8241 insertions(+), 59 deletions(-)
 create mode 100644 Documentation/driver-api/dpll.rst
 create mode 100644 Documentation/netlink/specs/dpll.yaml
 create mode 100644 drivers/dpll/Kconfig
 create mode 100644 drivers/dpll/Makefile
 create mode 100644 drivers/dpll/dpll_core.c
 create mode 100644 drivers/dpll/dpll_core.h
 create mode 100644 drivers/dpll/dpll_netlink.c
 create mode 100644 drivers/dpll/dpll_netlink.h
 create mode 100644 drivers/dpll/dpll_nl.c
 create mode 100644 drivers/dpll/dpll_nl.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_dpll.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_dpll.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/dpll.c
 create mode 100644 include/linux/dpll.h
 create mode 100644 include/uapi/linux/dpll.h

-- 
2.39.3

Arkadiusz Kubalewski (3):
  dpll: spec: Add Netlink spec in YAML
  ice: add admin commands to access cgu configuration
  ice: implement dpll interface to control cgu

Jiri Pirko (2):
  netdev: expose DPLL pin handle for netdevice
  mlx5: Implement SyncE support using DPLL infrastructure

Vadim Fedorenko (5):
  dpll: documentation on DPLL subsystem interface
  dpll: core: Add DPLL framework base functions
  dpll: netlink: Add DPLL framework base functions
  dpll: api header: Add DPLL framework base functions
  ptp_ocp: implement DPLL ops

 Documentation/driver-api/dpll.rst             |  458 ++++
 Documentation/driver-api/index.rst            |    1 +
 Documentation/netlink/specs/dpll.yaml         |  466 ++++
 MAINTAINERS                                   |    8 +
 drivers/Kconfig                               |    2 +
 drivers/Makefile                              |    1 +
 drivers/dpll/Kconfig                          |    7 +
 drivers/dpll/Makefile                         |    9 +
 drivers/dpll/dpll_core.c                      |  953 ++++++++
 drivers/dpll/dpll_core.h                      |  104 +
 drivers/dpll/dpll_netlink.c                   | 1195 ++++++++++
 drivers/dpll/dpll_netlink.h                   |   44 +
 drivers/dpll/dpll_nl.c                        |  161 ++
 drivers/dpll/dpll_nl.h                        |   50 +
 drivers/net/ethernet/intel/Kconfig            |    1 +
 drivers/net/ethernet/intel/ice/Makefile       |    3 +-
 drivers/net/ethernet/intel/ice/ice.h          |    5 +
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  240 +-
 drivers/net/ethernet/intel/ice/ice_common.c   |  467 ++++
 drivers/net/ethernet/intel/ice/ice_common.h   |   43 +
 drivers/net/ethernet/intel/ice/ice_dpll.c     | 2015 +++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_dpll.h     |  102 +
 drivers/net/ethernet/intel/ice/ice_lib.c      |   17 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |    7 +
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |  414 ++++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  230 ++
 drivers/net/ethernet/intel/ice/ice_type.h     |    1 +
 .../net/ethernet/mellanox/mlx5/core/Kconfig   |    8 +
 .../net/ethernet/mellanox/mlx5/core/Makefile  |    3 +
 drivers/net/ethernet/mellanox/mlx5/core/dev.c |   17 +
 .../net/ethernet/mellanox/mlx5/core/dpll.c    |  432 ++++
 drivers/ptp/Kconfig                           |    1 +
 drivers/ptp/ptp_ocp.c                         |  329 ++-
 include/linux/dpll.h                          |  164 ++
 include/linux/mlx5/driver.h                   |    2 +
 include/linux/mlx5/mlx5_ifc.h                 |   59 +-
 include/linux/netdevice.h                     |   10 +
 include/uapi/linux/dpll.h                     |  184 ++
 include/uapi/linux/if_link.h                  |    2 +
 net/core/dev.c                                |   22 +
 net/core/rtnetlink.c                          |   38 +
 41 files changed, 8216 insertions(+), 59 deletions(-)
 create mode 100644 Documentation/driver-api/dpll.rst
 create mode 100644 Documentation/netlink/specs/dpll.yaml
 create mode 100644 drivers/dpll/Kconfig
 create mode 100644 drivers/dpll/Makefile
 create mode 100644 drivers/dpll/dpll_core.c
 create mode 100644 drivers/dpll/dpll_core.h
 create mode 100644 drivers/dpll/dpll_netlink.c
 create mode 100644 drivers/dpll/dpll_netlink.h
 create mode 100644 drivers/dpll/dpll_nl.c
 create mode 100644 drivers/dpll/dpll_nl.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_dpll.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_dpll.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/dpll.c
 create mode 100644 include/linux/dpll.h
 create mode 100644 include/uapi/linux/dpll.h

-- 
2.37.3

