Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1708373B79F
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jun 2023 14:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjFWMlU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Jun 2023 08:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbjFWMlS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Jun 2023 08:41:18 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A16212C;
        Fri, 23 Jun 2023 05:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687524074; x=1719060074;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FQIWeBvwpKI+nOrxXAHVpVJ0pEhSzhxDEnyfax2tYu4=;
  b=fcgfYAyydmXZ/CAZiUL6i3CKT7XJoX62g6wPxfKO09eEgK2dmYc1rqyI
   hiSvpmFhFPK8hfvKLPZm/gcPt9IxiGbt/mDObCgdErN0ylQ6LApwLY3De
   lUS9u5x/OW+QHAq3jb+KIbZedH0PqDbbLELAkoGPcnVP7WNSqkNSbBTHU
   n/pnaFYbvQGIvkpOb6HUOBFvDT/JI8AnXPmbtlYFVoizvYoMAaGVPElp9
   kBIP3yYyZZY+0ljzK4mMGNHuPHmVQ8ZAdeW6jdAaO3lM54NYE6vICY7JG
   TK1RrzoHWcLdvcNwD3iaTOROAXNqawal7GugfOgCASf9ZK1vyCq4I8ioT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="341096488"
X-IronPort-AV: E=Sophos;i="6.01,152,1684825200"; 
   d="scan'208";a="341096488"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 05:40:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="785321164"
X-IronPort-AV: E=Sophos;i="6.01,152,1684825200"; 
   d="scan'208";a="785321164"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by fmsmga004.fm.intel.com with ESMTP; 23 Jun 2023 05:40:34 -0700
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
Subject: [RFC PATCH v9 02/10] dpll: spec: Add Netlink spec in YAML
Date:   Fri, 23 Jun 2023 14:38:12 +0200
Message-Id: <20230623123820.42850-3-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230623123820.42850-1-arkadiusz.kubalewski@intel.com>
References: <20230623123820.42850-1-arkadiusz.kubalewski@intel.com>
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

Add a protocol spec for DPLL.
Add code generated from the spec.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Michal Michalik <michal.michalik@intel.com>
Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
 Documentation/netlink/specs/dpll.yaml | 472 ++++++++++++++++++++++++++
 drivers/dpll/dpll_nl.c                | 163 +++++++++
 drivers/dpll/dpll_nl.h                |  51 +++
 include/uapi/linux/dpll.h             | 183 ++++++++++
 4 files changed, 869 insertions(+)
 create mode 100644 Documentation/netlink/specs/dpll.yaml
 create mode 100644 drivers/dpll/dpll_nl.c
 create mode 100644 drivers/dpll/dpll_nl.h
 create mode 100644 include/uapi/linux/dpll.h

diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
new file mode 100644
index 000000000000..af6258c3d8ec
--- /dev/null
+++ b/Documentation/netlink/specs/dpll.yaml
@@ -0,0 +1,472 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+
+name: dpll
+
+doc: DPLL subsystem.
+
+definitions:
+  -
+    type: enum
+    name: mode
+    doc: |
+      working modes a dpll can support, differentiates if and how dpll selects
+      one of its inputs to syntonize with it, valid values for DPLL_A_MODE
+      attribute
+    entries:
+      -
+        name: manual
+        doc: input can be only selected by sending a request to dpll
+        value: 1
+      -
+        name: automatic
+        doc: highest prio input pin auto selected by dpll
+    render-max: true
+  -
+    type: enum
+    name: lock-status
+    doc: |
+      provides information of dpll device lock status, valid values for
+      DPLL_A_LOCK_STATUS attribute
+    entries:
+      -
+        name: unlocked
+        doc: |
+          dpll was not yet locked to any valid input
+        value: 1
+      -
+        name: locked
+        doc: |
+          dpll is locked to a valid signal, but no holdover available
+      -
+        name: locked-ho-acq
+        doc: |
+          dpll is locked and holdover acquired
+      -
+        name: holdover
+        doc: |
+          dpll is in holdover state - lost a valid lock or was forced
+          by disconnecting all the pins (latter possible only
+          when dpll lock-state was already DPLL_LOCK_STATUS_LOCKED_HO_ACQ,
+          if dpll lock-state was not DPLL_LOCK_STATUS_LOCKED_HO_ACQ, the
+          dpll's lock-state shall remain DPLL_LOCK_STATUS_UNLOCKED)
+    render-max: true
+  -
+    type: const
+    name: temp-divider
+    value: 1000
+    doc: |
+      temperature divider allowing userspace to calculate the
+      temperature as float with three digit decimal precision.
+      Value of (DPLL_A_TEMP / DPLL_TEMP_DIVIDER) is integer part of
+      temperature value.
+      Value of (DPLL_A_TEMP % DPLL_TEMP_DIVIDER) is fractional part of
+      temperature value.
+  -
+    type: enum
+    name: type
+    doc: type of dpll, valid values for DPLL_A_TYPE attribute
+    entries:
+      -
+        name: pps
+        doc: dpll produces Pulse-Per-Second signal
+        value: 1
+      -
+        name: eec
+        doc: dpll drives the Ethernet Equipment Clock
+    render-max: true
+  -
+    type: enum
+    name: pin-type
+    doc: |
+      defines possible types of a pin, valid values for DPLL_A_PIN_TYPE
+      attribute
+    entries:
+      -
+        name: mux
+        doc: aggregates another layer of selectable pins
+        value: 1
+      -
+        name: ext
+        doc: external input
+      -
+        name: synce-eth-port
+        doc: ethernet port PHY's recovered clock
+      -
+        name: int-oscillator
+        doc: device internal oscillator
+      -
+        name: gnss
+        doc: GNSS recovered clock
+    render-max: true
+  -
+    type: enum
+    name: pin-direction
+    doc: |
+      defines possible direction of a pin, valid values for
+      DPLL_A_PIN_DIRECTION attribute
+    entries:
+      -
+        name: input
+        doc: pin used as a input of a signal
+        value: 1
+      -
+        name: output
+        doc: pin used to output the signal
+    render-max: true
+  -
+    type: const
+    name: pin-frequency-1-hz
+    value: 1
+  -
+    type: const
+    name: pin-frequency-10-khz
+    value: 10000
+  -
+    type: const
+    name: pin-frequency-77_5-khz
+    value: 77500
+  -
+    type: const
+    name: pin-frequency-10-mhz
+    value: 10000000
+  -
+    type: enum
+    name: pin-state
+    doc: |
+      defines possible states of a pin, valid values for
+      DPLL_A_PIN_STATE attribute
+    entries:
+      -
+        name: connected
+        doc: pin connected, active input of phase locked loop
+        value: 1
+      -
+        name: disconnected
+        doc: pin disconnected, not considered as a valid input
+      -
+        name: selectable
+        doc: pin enabled for automatic input selection
+    render-max: true
+  -
+    type: flags
+    name: pin-caps
+    doc: |
+      defines possible capabilities of a pin, valid flags on
+      DPLL_A_PIN_CAPS attribute
+    entries:
+      -
+        name: direction-can-change
+        doc: pin direction can be changed
+      -
+        name: priority-can-change
+        doc: pin prority can be changed
+      -
+        name: state-can-change
+        doc: pin state can be changed
+
+attribute-sets:
+  -
+    name: dpll
+    enum-name: dpll_a
+    attributes:
+      -
+        name: id
+        type: u32
+        value: 1
+      -
+        name: module-name
+        type: string
+      -
+        name: clock-id
+        type: u64
+      -
+        name: mode
+        type: u8
+        enum: mode
+      -
+        name: mode-supported
+        type: u8
+        enum: mode
+        multi-attr: true
+      -
+        name: lock-status
+        type: u8
+        enum: lock-status
+      -
+        name: temp
+        type: s32
+      -
+        name: type
+        type: u8
+        enum: type
+      -
+        name: pin-id
+        type: u32
+      -
+        name: pin-board-label
+        type: string
+      -
+        name: pin-panel-label
+        type: string
+      -
+        name: pin-package-label
+        type: string
+      -
+        name: pin-type
+        type: u8
+        enum: pin-type
+      -
+        name: pin-direction
+        type: u8
+        enum: pin-direction
+      -
+        name: pin-frequency
+        type: u64
+      -
+        name: pin-frequency-supported
+        type: nest
+        multi-attr: true
+        nested-attributes: pin-frequency-range
+      -
+        name: pin-frequency-min
+        type: u64
+      -
+        name: pin-frequency-max
+        type: u64
+      -
+        name: pin-prio
+        type: u32
+      -
+        name: pin-state
+        type: u8
+        enum: pin-state
+      -
+        name: pin-dpll-caps
+        type: u32
+      -
+        name: pin-parent-device
+        type: nest
+        multi-attr: true
+        nested-attributes: pin-parent-device
+      -
+        name: pin-parent-pin
+        type: nest
+        multi-attr: true
+        nested-attributes: pin-parent-pin
+  -
+    name: pin-parent-device
+    subset-of: dpll
+    attributes:
+      -
+        name: id
+        type: u32
+      -
+        name: pin-direction
+        type: u8
+      -
+        name: pin-prio
+        type: u32
+      -
+        name: pin-state
+        type: u8
+  -
+    name: pin-parent-pin
+    subset-of: dpll
+    attributes:
+      -
+        name: pin-state
+        type: u8
+      -
+        name: pin-id
+        type: u32
+  -
+    name: pin-frequency-range
+    subset-of: dpll
+    attributes:
+      -
+        name: pin-frequency-min
+        type: u64
+      -
+        name: pin-frequency-max
+        type: u64
+
+operations:
+  enum-name: dpll_cmd
+  list:
+    -
+      name: device-id-get
+      doc: |
+        Get id of dpll device that matches given attributes
+      value: 1
+      attribute-set: dpll
+      flags: [ admin-perm ]
+
+      do:
+        pre: dpll-lock-doit
+        post: dpll-unlock-doit
+        request:
+          attributes:
+            - module-name
+            - clock-id
+            - type
+        reply:
+          attributes:
+            - id
+
+    -
+      name: device-get
+      doc: |
+        Get list of DPLL devices (dump) or attributes of a single dpll device
+      attribute-set: dpll
+      flags: [ admin-perm ]
+
+      do:
+        pre: dpll-pre-doit
+        post: dpll-post-doit
+        request:
+          attributes:
+            - id
+            - module-name
+        reply: &dev-attrs
+          attributes:
+            - id
+            - module-name
+            - mode
+            - mode-supported
+            - lock-status
+            - temp
+            - clock-id
+            - type
+
+      dump:
+        pre: dpll-lock-dumpit
+        post: dpll-unlock-dumpit
+        reply: *dev-attrs
+
+    -
+      name: device-set
+      doc: Set attributes for a DPLL device
+      attribute-set: dpll
+      flags: [ admin-perm ]
+
+      do:
+        pre: dpll-pre-doit
+        post: dpll-post-doit
+        request:
+          attributes:
+            - id
+            - mode
+    -
+      name: device-create-ntf
+      doc: Notification about device appearing
+      notify: device-get
+      mcgrp: monitor
+    -
+      name: device-delete-ntf
+      doc: Notification about device disappearing
+      notify: device-get
+      mcgrp: monitor
+    -
+      name: device-change-ntf
+      doc: Notification about device configuration being changed
+      notify: device-get
+      mcgrp: monitor
+    -
+      name: pin-id-get
+      doc: |
+        Get id of a pin that matches given attributes
+      attribute-set: dpll
+      flags: [ admin-perm ]
+
+      do:
+        pre: dpll-lock-doit
+        post: dpll-unlock-doit
+        request:
+          attributes:
+            - module-name
+            - clock-id
+            - pin-board-label
+            - pin-panel-label
+            - pin-package-label
+            - pin-type
+        reply:
+          attributes:
+            - pin-id
+
+    -
+      name: pin-get
+      doc: |
+        Get list of pins and its attributes.
+        - dump request without any attributes given - list all the pins in the
+          system
+        - dump request with target dpll - list all the pins registered with
+          a given dpll device
+        - do request with target dpll and target pin - single pin attributes
+      attribute-set: dpll
+      flags: [ admin-perm ]
+
+      do:
+        pre: dpll-pin-pre-doit
+        post: dpll-pin-post-doit
+        request:
+          attributes:
+            - pin-id
+        reply: &pin-attrs
+          attributes:
+            - pin-id
+            - pin-board-label
+            - pin-panel-label
+            - pin-package-label
+            - pin-type
+            - pin-frequency
+            - pin-frequency-supported
+            - pin-dpll-caps
+            - pin-parent-device
+            - pin-parent-pin
+
+      dump:
+        pre: dpll-lock-dumpit
+        post: dpll-unlock-dumpit
+        request:
+          attributes:
+            - id
+        reply: *pin-attrs
+
+    -
+      name: pin-set
+      doc: Set attributes of a target pin
+      attribute-set: dpll
+      flags: [ admin-perm ]
+
+      do:
+        pre: dpll-pin-pre-doit
+        post: dpll-pin-post-doit
+        request:
+          attributes:
+            - pin-id
+            - pin-frequency
+            - pin-direction
+            - pin-prio
+            - pin-state
+            - pin-parent-device
+            - pin-parent-pin
+    -
+      name: pin-create-ntf
+      doc: Notification about pin appearing
+      notify: pin-get
+      mcgrp: monitor
+    -
+      name: pin-delete-ntf
+      doc: Notification about pin disappearing
+      notify: pin-get
+      mcgrp: monitor
+    -
+      name: pin-change-ntf
+      doc: Notification about pin configuration being changed
+      notify: pin-get
+      mcgrp: monitor
+
+mcast-groups:
+  list:
+    -
+      name: monitor
diff --git a/drivers/dpll/dpll_nl.c b/drivers/dpll/dpll_nl.c
new file mode 100644
index 000000000000..3b5ed39971b4
--- /dev/null
+++ b/drivers/dpll/dpll_nl.c
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/dpll.yaml */
+/* YNL-GEN kernel source */
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include "dpll_nl.h"
+
+#include <uapi/linux/dpll.h>
+
+/* Common nested types */
+const struct nla_policy dpll_pin_parent_device_nl_policy[DPLL_A_PIN_STATE + 1] = {
+	[DPLL_A_ID] = { .type = NLA_U32, },
+	[DPLL_A_PIN_DIRECTION] = NLA_POLICY_RANGE(NLA_U8, 1, 2),
+	[DPLL_A_PIN_PRIO] = { .type = NLA_U32, },
+	[DPLL_A_PIN_STATE] = NLA_POLICY_RANGE(NLA_U8, 1, 3),
+};
+const struct nla_policy dpll_pin_parent_pin_nl_policy[DPLL_A_PIN_STATE + 1] = {
+	[DPLL_A_PIN_STATE] = NLA_POLICY_RANGE(NLA_U8, 1, 3),
+	[DPLL_A_PIN_ID] = { .type = NLA_U32, },
+};
+
+/* DPLL_CMD_DEVICE_ID_GET - do */
+static const struct nla_policy dpll_device_id_get_nl_policy[DPLL_A_TYPE + 1] = {
+	[DPLL_A_MODULE_NAME] = { .type = NLA_NUL_STRING, },
+	[DPLL_A_CLOCK_ID] = { .type = NLA_U64, },
+	[DPLL_A_TYPE] = NLA_POLICY_RANGE(NLA_U8, 1, 2),
+};
+
+/* DPLL_CMD_DEVICE_GET - do */
+static const struct nla_policy dpll_device_get_nl_policy[DPLL_A_MODULE_NAME + 1] = {
+	[DPLL_A_ID] = { .type = NLA_U32, },
+	[DPLL_A_MODULE_NAME] = { .type = NLA_NUL_STRING, },
+};
+
+/* DPLL_CMD_DEVICE_SET - do */
+static const struct nla_policy dpll_device_set_nl_policy[DPLL_A_MODE + 1] = {
+	[DPLL_A_ID] = { .type = NLA_U32, },
+	[DPLL_A_MODE] = NLA_POLICY_RANGE(NLA_U8, 1, 2),
+};
+
+/* DPLL_CMD_PIN_ID_GET - do */
+static const struct nla_policy dpll_pin_id_get_nl_policy[DPLL_A_PIN_TYPE + 1] = {
+	[DPLL_A_MODULE_NAME] = { .type = NLA_NUL_STRING, },
+	[DPLL_A_CLOCK_ID] = { .type = NLA_U64, },
+	[DPLL_A_PIN_BOARD_LABEL] = { .type = NLA_NUL_STRING, },
+	[DPLL_A_PIN_PANEL_LABEL] = { .type = NLA_NUL_STRING, },
+	[DPLL_A_PIN_PACKAGE_LABEL] = { .type = NLA_NUL_STRING, },
+	[DPLL_A_PIN_TYPE] = NLA_POLICY_RANGE(NLA_U8, 1, 5),
+};
+
+/* DPLL_CMD_PIN_GET - do */
+static const struct nla_policy dpll_pin_get_do_nl_policy[DPLL_A_PIN_ID + 1] = {
+	[DPLL_A_PIN_ID] = { .type = NLA_U32, },
+};
+
+/* DPLL_CMD_PIN_GET - dump */
+static const struct nla_policy dpll_pin_get_dump_nl_policy[DPLL_A_ID + 1] = {
+	[DPLL_A_ID] = { .type = NLA_U32, },
+};
+
+/* DPLL_CMD_PIN_SET - do */
+static const struct nla_policy dpll_pin_set_nl_policy[DPLL_A_PIN_PARENT_PIN + 1] = {
+	[DPLL_A_PIN_ID] = { .type = NLA_U32, },
+	[DPLL_A_PIN_FREQUENCY] = { .type = NLA_U64, },
+	[DPLL_A_PIN_DIRECTION] = NLA_POLICY_RANGE(NLA_U8, 1, 2),
+	[DPLL_A_PIN_PRIO] = { .type = NLA_U32, },
+	[DPLL_A_PIN_STATE] = NLA_POLICY_RANGE(NLA_U8, 1, 3),
+	[DPLL_A_PIN_PARENT_DEVICE] = NLA_POLICY_NESTED(dpll_pin_parent_device_nl_policy),
+	[DPLL_A_PIN_PARENT_PIN] = NLA_POLICY_NESTED(dpll_pin_parent_pin_nl_policy),
+};
+
+/* Ops table for dpll */
+static const struct genl_split_ops dpll_nl_ops[] = {
+	{
+		.cmd		= DPLL_CMD_DEVICE_ID_GET,
+		.pre_doit	= dpll_lock_doit,
+		.doit		= dpll_nl_device_id_get_doit,
+		.post_doit	= dpll_unlock_doit,
+		.policy		= dpll_device_id_get_nl_policy,
+		.maxattr	= DPLL_A_TYPE,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= DPLL_CMD_DEVICE_GET,
+		.pre_doit	= dpll_pre_doit,
+		.doit		= dpll_nl_device_get_doit,
+		.post_doit	= dpll_post_doit,
+		.policy		= dpll_device_get_nl_policy,
+		.maxattr	= DPLL_A_MODULE_NAME,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd	= DPLL_CMD_DEVICE_GET,
+		.start	= dpll_lock_dumpit,
+		.dumpit	= dpll_nl_device_get_dumpit,
+		.done	= dpll_unlock_dumpit,
+		.flags	= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
+	},
+	{
+		.cmd		= DPLL_CMD_DEVICE_SET,
+		.pre_doit	= dpll_pre_doit,
+		.doit		= dpll_nl_device_set_doit,
+		.post_doit	= dpll_post_doit,
+		.policy		= dpll_device_set_nl_policy,
+		.maxattr	= DPLL_A_MODE,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= DPLL_CMD_PIN_ID_GET,
+		.pre_doit	= dpll_lock_doit,
+		.doit		= dpll_nl_pin_id_get_doit,
+		.post_doit	= dpll_unlock_doit,
+		.policy		= dpll_pin_id_get_nl_policy,
+		.maxattr	= DPLL_A_PIN_TYPE,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= DPLL_CMD_PIN_GET,
+		.pre_doit	= dpll_pin_pre_doit,
+		.doit		= dpll_nl_pin_get_doit,
+		.post_doit	= dpll_pin_post_doit,
+		.policy		= dpll_pin_get_do_nl_policy,
+		.maxattr	= DPLL_A_PIN_ID,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= DPLL_CMD_PIN_GET,
+		.start		= dpll_lock_dumpit,
+		.dumpit		= dpll_nl_pin_get_dumpit,
+		.done		= dpll_unlock_dumpit,
+		.policy		= dpll_pin_get_dump_nl_policy,
+		.maxattr	= DPLL_A_ID,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
+	},
+	{
+		.cmd		= DPLL_CMD_PIN_SET,
+		.pre_doit	= dpll_pin_pre_doit,
+		.doit		= dpll_nl_pin_set_doit,
+		.post_doit	= dpll_pin_post_doit,
+		.policy		= dpll_pin_set_nl_policy,
+		.maxattr	= DPLL_A_PIN_PARENT_PIN,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+};
+
+static const struct genl_multicast_group dpll_nl_mcgrps[] = {
+	[DPLL_NLGRP_MONITOR] = { "monitor", },
+};
+
+struct genl_family dpll_nl_family __ro_after_init = {
+	.name		= DPLL_FAMILY_NAME,
+	.version	= DPLL_FAMILY_VERSION,
+	.netnsok	= true,
+	.parallel_ops	= true,
+	.module		= THIS_MODULE,
+	.split_ops	= dpll_nl_ops,
+	.n_split_ops	= ARRAY_SIZE(dpll_nl_ops),
+	.mcgrps		= dpll_nl_mcgrps,
+	.n_mcgrps	= ARRAY_SIZE(dpll_nl_mcgrps),
+};
diff --git a/drivers/dpll/dpll_nl.h b/drivers/dpll/dpll_nl.h
new file mode 100644
index 000000000000..1f67aaed4742
--- /dev/null
+++ b/drivers/dpll/dpll_nl.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/dpll.yaml */
+/* YNL-GEN kernel header */
+
+#ifndef _LINUX_DPLL_GEN_H
+#define _LINUX_DPLL_GEN_H
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include <uapi/linux/dpll.h>
+
+/* Common nested types */
+extern const struct nla_policy dpll_pin_parent_device_nl_policy[DPLL_A_PIN_STATE + 1];
+extern const struct nla_policy dpll_pin_parent_pin_nl_policy[DPLL_A_PIN_STATE + 1];
+
+int dpll_lock_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
+		   struct genl_info *info);
+int dpll_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
+		  struct genl_info *info);
+int dpll_pin_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
+		      struct genl_info *info);
+void
+dpll_unlock_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
+		 struct genl_info *info);
+void
+dpll_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
+	       struct genl_info *info);
+void
+dpll_pin_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
+		   struct genl_info *info);
+int dpll_lock_dumpit(struct netlink_callback *cb);
+int dpll_unlock_dumpit(struct netlink_callback *cb);
+
+int dpll_nl_device_id_get_doit(struct sk_buff *skb, struct genl_info *info);
+int dpll_nl_device_get_doit(struct sk_buff *skb, struct genl_info *info);
+int dpll_nl_device_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
+int dpll_nl_device_set_doit(struct sk_buff *skb, struct genl_info *info);
+int dpll_nl_pin_id_get_doit(struct sk_buff *skb, struct genl_info *info);
+int dpll_nl_pin_get_doit(struct sk_buff *skb, struct genl_info *info);
+int dpll_nl_pin_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
+int dpll_nl_pin_set_doit(struct sk_buff *skb, struct genl_info *info);
+
+enum {
+	DPLL_NLGRP_MONITOR,
+};
+
+extern struct genl_family dpll_nl_family;
+
+#endif /* _LINUX_DPLL_GEN_H */
diff --git a/include/uapi/linux/dpll.h b/include/uapi/linux/dpll.h
new file mode 100644
index 000000000000..fd09965aed00
--- /dev/null
+++ b/include/uapi/linux/dpll.h
@@ -0,0 +1,183 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/dpll.yaml */
+/* YNL-GEN uapi header */
+
+#ifndef _UAPI_LINUX_DPLL_H
+#define _UAPI_LINUX_DPLL_H
+
+#define DPLL_FAMILY_NAME	"dpll"
+#define DPLL_FAMILY_VERSION	1
+
+/**
+ * enum dpll_mode - working modes a dpll can support, differentiates if and how
+ *   dpll selects one of its inputs to syntonize with it, valid values for
+ *   DPLL_A_MODE attribute
+ * @DPLL_MODE_MANUAL: input can be only selected by sending a request to dpll
+ * @DPLL_MODE_AUTOMATIC: highest prio input pin auto selected by dpll
+ */
+enum dpll_mode {
+	DPLL_MODE_MANUAL = 1,
+	DPLL_MODE_AUTOMATIC,
+
+	__DPLL_MODE_MAX,
+	DPLL_MODE_MAX = (__DPLL_MODE_MAX - 1)
+};
+
+/**
+ * enum dpll_lock_status - provides information of dpll device lock status,
+ *   valid values for DPLL_A_LOCK_STATUS attribute
+ * @DPLL_LOCK_STATUS_UNLOCKED: dpll was not yet locked to any valid input
+ * @DPLL_LOCK_STATUS_LOCKED: dpll is locked to a valid signal, but no holdover
+ *   available
+ * @DPLL_LOCK_STATUS_LOCKED_HO_ACQ: dpll is locked and holdover acquired
+ * @DPLL_LOCK_STATUS_HOLDOVER: dpll is in holdover state - lost a valid lock or
+ *   was forced by disconnecting all the pins (latter possible only when dpll
+ *   lock-state was already DPLL_LOCK_STATUS_LOCKED_HO_ACQ, if dpll lock-state
+ *   was not DPLL_LOCK_STATUS_LOCKED_HO_ACQ, the dpll's lock-state shall remain
+ *   DPLL_LOCK_STATUS_UNLOCKED)
+ */
+enum dpll_lock_status {
+	DPLL_LOCK_STATUS_UNLOCKED = 1,
+	DPLL_LOCK_STATUS_LOCKED,
+	DPLL_LOCK_STATUS_LOCKED_HO_ACQ,
+	DPLL_LOCK_STATUS_HOLDOVER,
+
+	__DPLL_LOCK_STATUS_MAX,
+	DPLL_LOCK_STATUS_MAX = (__DPLL_LOCK_STATUS_MAX - 1)
+};
+
+#define DPLL_TEMP_DIVIDER	1000
+
+/**
+ * enum dpll_type - type of dpll, valid values for DPLL_A_TYPE attribute
+ * @DPLL_TYPE_PPS: dpll produces Pulse-Per-Second signal
+ * @DPLL_TYPE_EEC: dpll drives the Ethernet Equipment Clock
+ */
+enum dpll_type {
+	DPLL_TYPE_PPS = 1,
+	DPLL_TYPE_EEC,
+
+	__DPLL_TYPE_MAX,
+	DPLL_TYPE_MAX = (__DPLL_TYPE_MAX - 1)
+};
+
+/**
+ * enum dpll_pin_type - defines possible types of a pin, valid values for
+ *   DPLL_A_PIN_TYPE attribute
+ * @DPLL_PIN_TYPE_MUX: aggregates another layer of selectable pins
+ * @DPLL_PIN_TYPE_EXT: external input
+ * @DPLL_PIN_TYPE_SYNCE_ETH_PORT: ethernet port PHY's recovered clock
+ * @DPLL_PIN_TYPE_INT_OSCILLATOR: device internal oscillator
+ * @DPLL_PIN_TYPE_GNSS: GNSS recovered clock
+ */
+enum dpll_pin_type {
+	DPLL_PIN_TYPE_MUX = 1,
+	DPLL_PIN_TYPE_EXT,
+	DPLL_PIN_TYPE_SYNCE_ETH_PORT,
+	DPLL_PIN_TYPE_INT_OSCILLATOR,
+	DPLL_PIN_TYPE_GNSS,
+
+	__DPLL_PIN_TYPE_MAX,
+	DPLL_PIN_TYPE_MAX = (__DPLL_PIN_TYPE_MAX - 1)
+};
+
+/**
+ * enum dpll_pin_direction - defines possible direction of a pin, valid values
+ *   for DPLL_A_PIN_DIRECTION attribute
+ * @DPLL_PIN_DIRECTION_INPUT: pin used as a input of a signal
+ * @DPLL_PIN_DIRECTION_OUTPUT: pin used to output the signal
+ */
+enum dpll_pin_direction {
+	DPLL_PIN_DIRECTION_INPUT = 1,
+	DPLL_PIN_DIRECTION_OUTPUT,
+
+	__DPLL_PIN_DIRECTION_MAX,
+	DPLL_PIN_DIRECTION_MAX = (__DPLL_PIN_DIRECTION_MAX - 1)
+};
+
+#define DPLL_PIN_FREQUENCY_1_HZ		1
+#define DPLL_PIN_FREQUENCY_10_KHZ	10000
+#define DPLL_PIN_FREQUENCY_77_5_KHZ	77500
+#define DPLL_PIN_FREQUENCY_10_MHZ	10000000
+
+/**
+ * enum dpll_pin_state - defines possible states of a pin, valid values for
+ *   DPLL_A_PIN_STATE attribute
+ * @DPLL_PIN_STATE_CONNECTED: pin connected, active input of phase locked loop
+ * @DPLL_PIN_STATE_DISCONNECTED: pin disconnected, not considered as a valid
+ *   input
+ * @DPLL_PIN_STATE_SELECTABLE: pin enabled for automatic input selection
+ */
+enum dpll_pin_state {
+	DPLL_PIN_STATE_CONNECTED = 1,
+	DPLL_PIN_STATE_DISCONNECTED,
+	DPLL_PIN_STATE_SELECTABLE,
+
+	__DPLL_PIN_STATE_MAX,
+	DPLL_PIN_STATE_MAX = (__DPLL_PIN_STATE_MAX - 1)
+};
+
+/**
+ * enum dpll_pin_caps - defines possible capabilities of a pin, valid flags on
+ *   DPLL_A_PIN_CAPS attribute
+ * @DPLL_PIN_CAPS_DIRECTION_CAN_CHANGE: pin direction can be changed
+ * @DPLL_PIN_CAPS_PRIORITY_CAN_CHANGE: pin prority can be changed
+ * @DPLL_PIN_CAPS_STATE_CAN_CHANGE: pin state can be changed
+ */
+enum dpll_pin_caps {
+	DPLL_PIN_CAPS_DIRECTION_CAN_CHANGE = 1,
+	DPLL_PIN_CAPS_PRIORITY_CAN_CHANGE = 2,
+	DPLL_PIN_CAPS_STATE_CAN_CHANGE = 4,
+};
+
+enum dpll_a {
+	DPLL_A_ID = 1,
+	DPLL_A_MODULE_NAME,
+	DPLL_A_CLOCK_ID,
+	DPLL_A_MODE,
+	DPLL_A_MODE_SUPPORTED,
+	DPLL_A_LOCK_STATUS,
+	DPLL_A_TEMP,
+	DPLL_A_TYPE,
+	DPLL_A_PIN_ID,
+	DPLL_A_PIN_BOARD_LABEL,
+	DPLL_A_PIN_PANEL_LABEL,
+	DPLL_A_PIN_PACKAGE_LABEL,
+	DPLL_A_PIN_TYPE,
+	DPLL_A_PIN_DIRECTION,
+	DPLL_A_PIN_FREQUENCY,
+	DPLL_A_PIN_FREQUENCY_SUPPORTED,
+	DPLL_A_PIN_FREQUENCY_MIN,
+	DPLL_A_PIN_FREQUENCY_MAX,
+	DPLL_A_PIN_PRIO,
+	DPLL_A_PIN_STATE,
+	DPLL_A_PIN_DPLL_CAPS,
+	DPLL_A_PIN_PARENT_DEVICE,
+	DPLL_A_PIN_PARENT_PIN,
+
+	__DPLL_A_MAX,
+	DPLL_A_MAX = (__DPLL_A_MAX - 1)
+};
+
+enum dpll_cmd {
+	DPLL_CMD_DEVICE_ID_GET = 1,
+	DPLL_CMD_DEVICE_GET,
+	DPLL_CMD_DEVICE_SET,
+	DPLL_CMD_DEVICE_CREATE_NTF,
+	DPLL_CMD_DEVICE_DELETE_NTF,
+	DPLL_CMD_DEVICE_CHANGE_NTF,
+	DPLL_CMD_PIN_ID_GET,
+	DPLL_CMD_PIN_GET,
+	DPLL_CMD_PIN_SET,
+	DPLL_CMD_PIN_CREATE_NTF,
+	DPLL_CMD_PIN_DELETE_NTF,
+	DPLL_CMD_PIN_CHANGE_NTF,
+
+	__DPLL_CMD_MAX,
+	DPLL_CMD_MAX = (__DPLL_CMD_MAX - 1)
+};
+
+#define DPLL_MCGRP_MONITOR	"monitor"
+
+#endif /* _UAPI_LINUX_DPLL_H */
-- 
2.39.3

