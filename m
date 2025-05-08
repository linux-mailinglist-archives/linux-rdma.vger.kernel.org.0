Return-Path: <linux-rdma+bounces-10158-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B888AAF9E4
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 14:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ED6C9C6F29
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 12:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E5A228CA3;
	Thu,  8 May 2025 12:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g1yhE/p9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65C2227E89;
	Thu,  8 May 2025 12:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746707251; cv=none; b=u0dmpEgseRry0yfnsU0LCEEiMVEu8wz/Tfgm291dLUv67//hMxOcfRm4Cka8Bm+IkTvcH6J3wW/Zkyptw9wtGgAC3wpwk6/xdZU/eoxn8jA6VtCzscsLj8RKCbt5UVIvXsJTREg6aEJK0WwpWqE+GlFHJDlrS0uoR9fIjZGe+ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746707251; c=relaxed/simple;
	bh=KaJyWY9o7KT1LtfUBQe5B6THOx9ebRzyhdQpLC6rhmY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M4XNaXSTNH+4iG51jdmk8apvC01y91imZVzF41h12odCsLKlvBVKF9SMq5w8Ij/d/imKUVxV+PGSCeFnXZVdfMZ7FZLAedFfWya+FgSjpZxOfP+g382Er3Wg1LQT07zf/KCjo+56vMPmlJNsOouCksI+m9FoPpSKDWUfo3vElIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g1yhE/p9; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746707250; x=1778243250;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KaJyWY9o7KT1LtfUBQe5B6THOx9ebRzyhdQpLC6rhmY=;
  b=g1yhE/p9plE5P+/vwvBl95PwZtfCC2TTxHRM9EbZQeZtoWJTcbYggUgp
   nJjVkPtLatZgakx+aJIOmobnsSNhrI2gS0v2mbcntClobyhw68LiXMIc5
   WXky3pvDOajbH7E6/Fv4zrSixca9BPuyvNLgoawhIF3HeOAZphKDZAgdH
   xanrUOoEQ8t7wlzwzvg7OYdHB+WG5oQ3elFVuD2ZObIM59SrbcPfWLMwU
   N1HcSSFq+GM+7fcBXdS/oB7XqYNsO6bsSn962wcZNS5EMhM7IL57DeNfo
   hXRYKcv+840P6Yqj/PX08l8oPGpSlTMaNqtByoSRWwK9q47zWGtwfZqvv
   Q==;
X-CSE-ConnectionGUID: jer7XzTDRe2/9/EVqBX39Q==
X-CSE-MsgGUID: 3WUHlaCGRw20OzHII38exQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="36115118"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="36115118"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 05:27:30 -0700
X-CSE-ConnectionGUID: qrBt83uRS8uBULUxx6LZGw==
X-CSE-MsgGUID: MhwjLBJDTK+xXGQlFrq7ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="136772857"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by fmviesa010.fm.intel.com with ESMTP; 08 May 2025 05:27:25 -0700
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
	saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	jonathan.lemon@gmail.com,
	richardcochran@gmail.com,
	aleksandr.loktionov@intel.com,
	milena.olech@intel.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH net-next v3 1/3] dpll: add phase-offset-monitor feature to netlink spec
Date: Thu,  8 May 2025 14:21:26 +0200
Message-Id: <20250508122128.1216231-2-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250508122128.1216231-1-arkadiusz.kubalewski@intel.com>
References: <20250508122128.1216231-1-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add enum dpll_feature_state for control over features.

Add dpll device level attribute:
DPLL_A_PHASE_OFFSET_MONITOR - to allow control over a phase offset monitor
feature. Attribute is present and shall return current state of a feature
(enum dpll_feature_state), if the device driver provides such capability,
otherwie attribute shall not be present.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
v3:
- replace feature flags and capabilities with per feature attribute
  approach,
- add dpll documentation for phase-offset-monitor feature.
---
 Documentation/driver-api/dpll.rst     | 16 ++++++++++++++++
 Documentation/netlink/specs/dpll.yaml | 24 ++++++++++++++++++++++++
 drivers/dpll/dpll_nl.c                |  5 +++--
 include/uapi/linux/dpll.h             | 12 ++++++++++++
 4 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/dpll.rst b/Documentation/driver-api/dpll.rst
index e6855cd37e85..04efb425b411 100644
--- a/Documentation/driver-api/dpll.rst
+++ b/Documentation/driver-api/dpll.rst
@@ -214,6 +214,22 @@ offset values are fractional with 3-digit decimal places and shell be
 divided with ``DPLL_PIN_PHASE_OFFSET_DIVIDER`` to get integer part and
 modulo divided to get fractional part.
 
+Phase offset monitor
+====================
+
+Phase offset measurement is typically performed against the current active
+source. However, some DPLL (Digital Phase-Locked Loop) devices may offer
+the capability to monitor phase offsets across all available inputs.
+The attribute and current feature state shall be included in the response
+message of the ``DPLL_CMD_DEVICE_GET`` command for supported DPLL devices.
+In such cases, users can also control the feature using the
+``DPLL_CMD_DEVICE_SET`` command by setting the ``enum dpll_feature_state``
+values for the attribute.
+
+  =============================== ========================
+  ``DPLL_A_PHASE_OFFSET_MONITOR`` attr state of a feature
+  =============================== ========================
+
 Embedded SYNC
 =============
 
diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
index 8feefeae5376..e9774678b3f3 100644
--- a/Documentation/netlink/specs/dpll.yaml
+++ b/Documentation/netlink/specs/dpll.yaml
@@ -240,6 +240,20 @@ definitions:
       integer part of a measured phase offset value.
       Value of (DPLL_A_PHASE_OFFSET % DPLL_PHASE_OFFSET_DIVIDER) is a
       fractional part of a measured phase offset value.
+  -
+    type: enum
+    name: feature-state
+    doc: |
+      Allow control (enable/disable) and status checking over features.
+    entries:
+      -
+        name: disable
+        doc: |
+          feature shall be disabled
+      -
+        name: enable
+        doc: |
+          feature shall be enabled
 
 attribute-sets:
   -
@@ -293,6 +307,14 @@ attribute-sets:
           be put to message multiple times to indicate possible parallel
           quality levels (e.g. one specified by ITU option 1 and another
           one specified by option 2).
+      -
+        name: phase-offset-monitor
+        type: u32
+        enum: feature-state
+        doc: Receive or request state of phase offset monitor feature.
+          If enabled, dpll device shall monitor and notify all currently
+          available inputs for changes of their phase offset against the
+          dpll device.
   -
     name: pin
     enum-name: dpll_a_pin
@@ -483,6 +505,7 @@ operations:
             - temp
             - clock-id
             - type
+            - phase-offset-monitor
 
       dump:
         reply: *dev-attrs
@@ -499,6 +522,7 @@ operations:
         request:
           attributes:
             - id
+            - phase-offset-monitor
     -
       name: device-create-ntf
       doc: Notification about device appearing
diff --git a/drivers/dpll/dpll_nl.c b/drivers/dpll/dpll_nl.c
index fe9b6893d261..8de90310c3be 100644
--- a/drivers/dpll/dpll_nl.c
+++ b/drivers/dpll/dpll_nl.c
@@ -37,8 +37,9 @@ static const struct nla_policy dpll_device_get_nl_policy[DPLL_A_ID + 1] = {
 };
 
 /* DPLL_CMD_DEVICE_SET - do */
-static const struct nla_policy dpll_device_set_nl_policy[DPLL_A_ID + 1] = {
+static const struct nla_policy dpll_device_set_nl_policy[DPLL_A_PHASE_OFFSET_MONITOR + 1] = {
 	[DPLL_A_ID] = { .type = NLA_U32, },
+	[DPLL_A_PHASE_OFFSET_MONITOR] = NLA_POLICY_MAX(NLA_U32, 1),
 };
 
 /* DPLL_CMD_PIN_ID_GET - do */
@@ -105,7 +106,7 @@ static const struct genl_split_ops dpll_nl_ops[] = {
 		.doit		= dpll_nl_device_set_doit,
 		.post_doit	= dpll_post_doit,
 		.policy		= dpll_device_set_nl_policy,
-		.maxattr	= DPLL_A_ID,
+		.maxattr	= DPLL_A_PHASE_OFFSET_MONITOR,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
diff --git a/include/uapi/linux/dpll.h b/include/uapi/linux/dpll.h
index bf97d4b6d51f..349e1b3ca1ae 100644
--- a/include/uapi/linux/dpll.h
+++ b/include/uapi/linux/dpll.h
@@ -192,6 +192,17 @@ enum dpll_pin_capabilities {
 
 #define DPLL_PHASE_OFFSET_DIVIDER	1000
 
+/**
+ * enum dpll_feature_state - Allow control (enable/disable) and status checking
+ *   over features.
+ * @DPLL_FEATURE_STATE_DISABLE: feature shall be disabled
+ * @DPLL_FEATURE_STATE_ENABLE: feature shall be enabled
+ */
+enum dpll_feature_state {
+	DPLL_FEATURE_STATE_DISABLE,
+	DPLL_FEATURE_STATE_ENABLE,
+};
+
 enum dpll_a {
 	DPLL_A_ID = 1,
 	DPLL_A_MODULE_NAME,
@@ -204,6 +215,7 @@ enum dpll_a {
 	DPLL_A_TYPE,
 	DPLL_A_LOCK_STATUS_ERROR,
 	DPLL_A_CLOCK_QUALITY_LEVEL,
+	DPLL_A_PHASE_OFFSET_MONITOR,
 
 	__DPLL_A_MAX,
 	DPLL_A_MAX = (__DPLL_A_MAX - 1)
-- 
2.38.1


