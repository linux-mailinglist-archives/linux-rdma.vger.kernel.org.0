Return-Path: <linux-rdma+bounces-10552-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0EFAC1130
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 18:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D7BF1BC8662
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 16:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF0E29AB1B;
	Thu, 22 May 2025 16:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DoGarBy5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E0B29AAFF;
	Thu, 22 May 2025 16:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747931753; cv=none; b=L9ddRVsFvDbsY8G7bZzUFwsqfvoud/8hUtY3HCL4katT2qypnPGA7HF6r1TAsRyOljdv9CwuD26YJUFcL5pwxuMVe02fUKp4vaETfZ8cHXzRLVPmWg9s6tMVpeEmtC8+0fRAVThHnsOI6vP0pv2GYC4o9AR25aN1NqdEi0mO/Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747931753; c=relaxed/simple;
	bh=/JXqKo6G3hoboR9AwzFAc8Rgpe3RCnPrzF5g32h/av0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qtBXIOBbzhNSpE/BvVlaYCXoAOtzy0wtHRl38lNR1lurkllcFOVv9tZCH4MCNmzjEy6cSztlsxC6leJBLLVtI6J/hERBbwXXdmi8boR1qHc+sJ8zv6f3NUiebE0tJLhL49epaPCragdt7U+N6z1xDzHXmHsZasce/l14h9PoHPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DoGarBy5; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747931752; x=1779467752;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/JXqKo6G3hoboR9AwzFAc8Rgpe3RCnPrzF5g32h/av0=;
  b=DoGarBy5pUew+0fILfd5QuqdQm8mFA7quQ8k6dI5eqionJHOpHZv1ph/
   c0VlQ0n4lF1tp51IQ79mUR0WniBQvJFS/ZDkZfNCv9jKCLIpGqo/j+2fH
   YzZm5NeK3bdTswksmh12eqWzEc+Thq49k7KVIc6my9R3Wo1yDn7mo36cQ
   bBOiXN24ZywyfDZRejPu5+ndvV8baK+pG9LHpAjg+g3MZddsYqAjxfQnj
   rHTSH7O12ZINBYxfu5j8ZZZjn0HE8jAzo06rrwcTUZq8RnE+bsqbVMvnY
   /7WA8k4YubuWMhQesfKSaWd2T695wVFHN0bC6A7dLmPMprlG3TpHPlL2f
   A==;
X-CSE-ConnectionGUID: l8f/X9BeQguTdCUXIM0pIQ==
X-CSE-MsgGUID: hPqJ0rJxQkKiSlrZvrLcxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="49889038"
X-IronPort-AV: E=Sophos;i="6.15,306,1739865600"; 
   d="scan'208";a="49889038"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 09:35:51 -0700
X-CSE-ConnectionGUID: P3XYCopDTRqJYrPToCtTJg==
X-CSE-MsgGUID: nuoeatvwReeffMHAeL7ikw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,306,1739865600"; 
   d="scan'208";a="145631353"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by orviesa004.jf.intel.com with ESMTP; 22 May 2025 09:35:47 -0700
From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To: donald.hunter@gmail.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	vadim.fedorenko@linux.dev,
	jiri@resnulli.us,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	aleksandr.loktionov@intel.com,
	corbet@lwn.net
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Milena Olech <milena.olech@intel.com>
Subject: [PATCH net-next v3 1/3] dpll: add reference-sync netlink attribute
Date: Thu, 22 May 2025 18:29:36 +0200
Message-Id: <20250522162938.1490791-2-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250522162938.1490791-1-arkadiusz.kubalewski@intel.com>
References: <20250522162938.1490791-1-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new netlink attribute to allow user space configuration of reference
sync pin pairs, where both pins are used to provide one clock signal
consisting of both: base frequency and sync signal.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
 v3:
- add missing maintainers.
---
Documentation/driver-api/dpll.rst     | 25 +++++++++++++++++++++++++
 Documentation/netlink/specs/dpll.yaml | 19 +++++++++++++++++++
 drivers/dpll/dpll_nl.c                | 10 ++++++++--
 drivers/dpll/dpll_nl.h                |  1 +
 include/uapi/linux/dpll.h             |  1 +
 5 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/dpll.rst b/Documentation/driver-api/dpll.rst
index e6855cd37e85..7570890c6cd1 100644
--- a/Documentation/driver-api/dpll.rst
+++ b/Documentation/driver-api/dpll.rst
@@ -235,6 +235,31 @@ the pin.
   ``DPLL_A_PIN_ESYNC_PULSE``                pulse type of Embedded SYNC
   ========================================= =================================
 
+Reference SYNC
+==============
+
+The device may support the Reference SYNC feature, which allows the combination
+of two inputs into a Reference SYNC pair. In this configuration, clock signals
+from both inputs are used to synchronize the dpll device. The higher frequency
+signal is utilized for the loop bandwidth of the DPLL, while the lower frequency
+signal is used to syntonize the output signal of the DPLL device. This feature
+enables the provision of a high-quality loop bandwidth signal from an external
+source.
+
+A capable input provides a list of inputs that can be paired to create a
+Reference SYNC pair. To control this feature, the user must request a desired
+state for a target pin: use ``DPLL_PIN_STATE_CONNECTED`` to enable or
+``DPLL_PIN_STATE_DISCONNECTED`` to disable the feature. Only two pins can be
+bound to form a Reference SYNC pair at any given time.
+
+  ============================== ==========================================
+  ``DPLL_A_PIN_REFERENCE_SYNC``  nested attribute for providing info or
+                                 requesting configuration of the Reference
+                                 SYNC feature
+    ``DPLL_A_PIN_ID``            target pin id for Reference SYNC pair
+    ``DPLL_A_PIN_STATE``         state of Reference SYNC pair connection
+  ============================== ==========================================
+
 Configuration commands group
 ============================
 
diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
index 8feefeae5376..333b4596b36f 100644
--- a/Documentation/netlink/specs/dpll.yaml
+++ b/Documentation/netlink/specs/dpll.yaml
@@ -406,6 +406,15 @@ attribute-sets:
         doc: |
           A ratio of high to low state of a SYNC signal pulse embedded
           into base clock frequency. Value is in percents.
+      -
+        name: reference-sync
+        type: nest
+        multi-attr: true
+        nested-attributes: reference-sync
+        doc: |
+          Capable pin provides list of pins that can be bound to create a
+          reference-sync pin pair.
+
   -
     name: pin-parent-device
     subset-of: pin
@@ -436,6 +445,14 @@ attribute-sets:
         name: frequency-min
       -
         name: frequency-max
+  -
+    name: reference-sync
+    subset-of: pin
+    attributes:
+      -
+        name: id
+      -
+        name: state
 
 operations:
   enum-name: dpll_cmd
@@ -574,6 +591,7 @@ operations:
             - esync-frequency
             - esync-frequency-supported
             - esync-pulse
+            - reference-sync
 
       dump:
         request:
@@ -601,6 +619,7 @@ operations:
             - parent-pin
             - phase-adjust
             - esync-frequency
+            - reference-sync
     -
       name: pin-create-ntf
       doc: Notification about pin appearing
diff --git a/drivers/dpll/dpll_nl.c b/drivers/dpll/dpll_nl.c
index fe9b6893d261..d709a8dc304f 100644
--- a/drivers/dpll/dpll_nl.c
+++ b/drivers/dpll/dpll_nl.c
@@ -24,6 +24,11 @@ const struct nla_policy dpll_pin_parent_pin_nl_policy[DPLL_A_PIN_STATE + 1] = {
 	[DPLL_A_PIN_STATE] = NLA_POLICY_RANGE(NLA_U32, 1, 3),
 };
 
+const struct nla_policy dpll_reference_sync_nl_policy[DPLL_A_PIN_STATE + 1] = {
+	[DPLL_A_PIN_ID] = { .type = NLA_U32, },
+	[DPLL_A_PIN_STATE] = NLA_POLICY_RANGE(NLA_U32, 1, 3),
+};
+
 /* DPLL_CMD_DEVICE_ID_GET - do */
 static const struct nla_policy dpll_device_id_get_nl_policy[DPLL_A_TYPE + 1] = {
 	[DPLL_A_MODULE_NAME] = { .type = NLA_NUL_STRING, },
@@ -62,7 +67,7 @@ static const struct nla_policy dpll_pin_get_dump_nl_policy[DPLL_A_PIN_ID + 1] =
 };
 
 /* DPLL_CMD_PIN_SET - do */
-static const struct nla_policy dpll_pin_set_nl_policy[DPLL_A_PIN_ESYNC_FREQUENCY + 1] = {
+static const struct nla_policy dpll_pin_set_nl_policy[DPLL_A_PIN_REFERENCE_SYNC + 1] = {
 	[DPLL_A_PIN_ID] = { .type = NLA_U32, },
 	[DPLL_A_PIN_FREQUENCY] = { .type = NLA_U64, },
 	[DPLL_A_PIN_DIRECTION] = NLA_POLICY_RANGE(NLA_U32, 1, 2),
@@ -72,6 +77,7 @@ static const struct nla_policy dpll_pin_set_nl_policy[DPLL_A_PIN_ESYNC_FREQUENCY
 	[DPLL_A_PIN_PARENT_PIN] = NLA_POLICY_NESTED(dpll_pin_parent_pin_nl_policy),
 	[DPLL_A_PIN_PHASE_ADJUST] = { .type = NLA_S32, },
 	[DPLL_A_PIN_ESYNC_FREQUENCY] = { .type = NLA_U64, },
+	[DPLL_A_PIN_REFERENCE_SYNC] = NLA_POLICY_NESTED(dpll_reference_sync_nl_policy),
 };
 
 /* Ops table for dpll */
@@ -139,7 +145,7 @@ static const struct genl_split_ops dpll_nl_ops[] = {
 		.doit		= dpll_nl_pin_set_doit,
 		.post_doit	= dpll_pin_post_doit,
 		.policy		= dpll_pin_set_nl_policy,
-		.maxattr	= DPLL_A_PIN_ESYNC_FREQUENCY,
+		.maxattr	= DPLL_A_PIN_REFERENCE_SYNC,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 };
diff --git a/drivers/dpll/dpll_nl.h b/drivers/dpll/dpll_nl.h
index f491262bee4f..3da10cfe9a6e 100644
--- a/drivers/dpll/dpll_nl.h
+++ b/drivers/dpll/dpll_nl.h
@@ -14,6 +14,7 @@
 /* Common nested types */
 extern const struct nla_policy dpll_pin_parent_device_nl_policy[DPLL_A_PIN_PHASE_OFFSET + 1];
 extern const struct nla_policy dpll_pin_parent_pin_nl_policy[DPLL_A_PIN_STATE + 1];
+extern const struct nla_policy dpll_reference_sync_nl_policy[DPLL_A_PIN_STATE + 1];
 
 int dpll_lock_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 		   struct genl_info *info);
diff --git a/include/uapi/linux/dpll.h b/include/uapi/linux/dpll.h
index bf97d4b6d51f..f6cb6209566c 100644
--- a/include/uapi/linux/dpll.h
+++ b/include/uapi/linux/dpll.h
@@ -237,6 +237,7 @@ enum dpll_a_pin {
 	DPLL_A_PIN_ESYNC_FREQUENCY,
 	DPLL_A_PIN_ESYNC_FREQUENCY_SUPPORTED,
 	DPLL_A_PIN_ESYNC_PULSE,
+	DPLL_A_PIN_REFERENCE_SYNC,
 
 	__DPLL_A_PIN_MAX,
 	DPLL_A_PIN_MAX = (__DPLL_A_PIN_MAX - 1)
-- 
2.38.1


