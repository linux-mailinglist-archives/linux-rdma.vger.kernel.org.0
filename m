Return-Path: <linux-rdma+bounces-9298-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C88A82ABE
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Apr 2025 17:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FFEB8A24C9
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Apr 2025 15:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D8C265628;
	Wed,  9 Apr 2025 15:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TM+YA+Cx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB62267B14;
	Wed,  9 Apr 2025 15:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744212719; cv=none; b=k5nzTPzZG5tKJeGCb5feTeZocFXHTDJoxE6y8H4JCqcTGgpr3kZQEFOG19jNhmLh7GhtmArxkI16YYLSIGz5LUKSbp7+ptNXCZ5KRZt2LBoBc19KPZQF90MTfEnAPAyjPkjww/C3YuFzBSqB8rcH1y5HiZGxxk4JWP5VsB2W2t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744212719; c=relaxed/simple;
	bh=5/FmNp8Wq+cSIaU7ijr39JuoFFGclk2AkfFlNuIlLMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bcgtGcsKLl5KvhlcTxjCbC5jJ+dijpabV8TFeijhIgZMsd8J4JuXciECCMJ6v9V9ohxEH4MEJ8LcHF+2y8ddvdMFRzic6d60nn0A1u1Gce/grcn/GX72CEMrtVTlGSJ39jUQstd32W5M+E3mvMKIVmeQihmu9he8VU8i+0HyZaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TM+YA+Cx; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744212718; x=1775748718;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5/FmNp8Wq+cSIaU7ijr39JuoFFGclk2AkfFlNuIlLMQ=;
  b=TM+YA+CxRboU0R2C2kI1HlKrE1czrOhIGyT8CntQKL4USAGMxYD2E191
   9lE4Da26H0Jyil+UtPotORZw8CklM3z4tI3r3SgSqQHrIt0HY++1NOxW3
   gE74k8gmQP0ChPUf/v+oGiOD752zmOwLTDd8QpNz0LvNeBrvVwWy2CbWU
   rcqCrewvE8D5yLCwhvULJMJ0/A/N0gTrxJE0AWJ84kVLQst/Y1c6iyK8T
   mfsaVGU65k4fTIYbGm3CQFLsulC/1p5sWuyj/xNYYBopNGVL5MojLElFl
   LiSqOwoROo1GgO8/4UrrKY1ndSzk1RxJSG2AWyE5tm4SVbP2uRkyXaRTG
   Q==;
X-CSE-ConnectionGUID: 6oQ2bvYtTDivUthx1zuxUA==
X-CSE-MsgGUID: fxdSirxTQpqSxh4gf+rb+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="71072107"
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="71072107"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 08:31:58 -0700
X-CSE-ConnectionGUID: g5Sf1TxlQVK/7cnYG7wrsg==
X-CSE-MsgGUID: 48FCyNpqRrimuuYORwuApw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="151796005"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by fmviesa002.fm.intel.com with ESMTP; 09 Apr 2025 08:31:54 -0700
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
Subject: [PATCH net-next v1 1/4] dpll: add features and capabilities to dpll device spec
Date: Wed,  9 Apr 2025 17:25:55 +0200
Message-Id: <20250409152558.1007335-2-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250409152558.1007335-1-arkadiusz.kubalewski@intel.com>
References: <20250409152558.1007335-1-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add infrastructure for adding simple control over dpll device level
features.
Add define for new dpll device level feature:
DPLL_FEATURES_ALL_INPUTS_PHASE_OFFSET_MONITOR - control over monitoring of
all input pins phase offsets.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
 Documentation/netlink/specs/dpll.yaml | 25 +++++++++++++++++++++++++
 drivers/dpll/dpll_nl.c                |  5 +++--
 include/uapi/linux/dpll.h             | 13 +++++++++++++
 3 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
index 8feefeae5376..c9a3873e03f6 100644
--- a/Documentation/netlink/specs/dpll.yaml
+++ b/Documentation/netlink/specs/dpll.yaml
@@ -240,6 +240,18 @@ definitions:
       integer part of a measured phase offset value.
       Value of (DPLL_A_PHASE_OFFSET % DPLL_PHASE_OFFSET_DIVIDER) is a
       fractional part of a measured phase offset value.
+  -
+    type: flags
+    name: features
+    doc: |
+      Allow simple control (enable/disable) and status checking over features
+      available per single dpll device.
+    entries:
+      -
+        name: all-inputs-phase-offset-monitor
+        doc: |
+          select if phase offset values are measured and reported for
+          all the input pins available for given dpll device
 
 attribute-sets:
   -
@@ -293,6 +305,16 @@ attribute-sets:
           be put to message multiple times to indicate possible parallel
           quality levels (e.g. one specified by ITU option 1 and another
           one specified by option 2).
+      -
+        name: capabilities
+        type: u32
+        enum: features
+        doc: Features available for a dpll device.
+      -
+        name: features
+        type: u32
+        enum: features
+        doc: Features enabled for a dpll device.
   -
     name: pin
     enum-name: dpll_a_pin
@@ -483,6 +505,8 @@ operations:
             - temp
             - clock-id
             - type
+            - capabilities
+            - features
 
       dump:
         reply: *dev-attrs
@@ -499,6 +523,7 @@ operations:
         request:
           attributes:
             - id
+            - features
     -
       name: device-create-ntf
       doc: Notification about device appearing
diff --git a/drivers/dpll/dpll_nl.c b/drivers/dpll/dpll_nl.c
index fe9b6893d261..3712a693c458 100644
--- a/drivers/dpll/dpll_nl.c
+++ b/drivers/dpll/dpll_nl.c
@@ -37,8 +37,9 @@ static const struct nla_policy dpll_device_get_nl_policy[DPLL_A_ID + 1] = {
 };
 
 /* DPLL_CMD_DEVICE_SET - do */
-static const struct nla_policy dpll_device_set_nl_policy[DPLL_A_ID + 1] = {
+static const struct nla_policy dpll_device_set_nl_policy[DPLL_A_FEATURES + 1] = {
 	[DPLL_A_ID] = { .type = NLA_U32, },
+	[DPLL_A_FEATURES] = NLA_POLICY_MASK(NLA_U32, 0x1),
 };
 
 /* DPLL_CMD_PIN_ID_GET - do */
@@ -105,7 +106,7 @@ static const struct genl_split_ops dpll_nl_ops[] = {
 		.doit		= dpll_nl_device_set_doit,
 		.post_doit	= dpll_post_doit,
 		.policy		= dpll_device_set_nl_policy,
-		.maxattr	= DPLL_A_ID,
+		.maxattr	= DPLL_A_FEATURES,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
diff --git a/include/uapi/linux/dpll.h b/include/uapi/linux/dpll.h
index bf97d4b6d51f..7c8e929831aa 100644
--- a/include/uapi/linux/dpll.h
+++ b/include/uapi/linux/dpll.h
@@ -192,6 +192,17 @@ enum dpll_pin_capabilities {
 
 #define DPLL_PHASE_OFFSET_DIVIDER	1000
 
+/**
+ * enum dpll_features - Allow simple control (enable/disable) and status
+ *   checking over features available per single dpll device.
+ * @DPLL_FEATURES_ALL_INPUTS_PHASE_OFFSET_MONITOR: select if phase offset
+ *   values are measured and reported for all the input pins available for
+ *   given dpll device
+ */
+enum dpll_features {
+	DPLL_FEATURES_ALL_INPUTS_PHASE_OFFSET_MONITOR = 1,
+};
+
 enum dpll_a {
 	DPLL_A_ID = 1,
 	DPLL_A_MODULE_NAME,
@@ -204,6 +215,8 @@ enum dpll_a {
 	DPLL_A_TYPE,
 	DPLL_A_LOCK_STATUS_ERROR,
 	DPLL_A_CLOCK_QUALITY_LEVEL,
+	DPLL_A_CAPABILITIES,
+	DPLL_A_FEATURES,
 
 	__DPLL_A_MAX,
 	DPLL_A_MAX = (__DPLL_A_MAX - 1)
-- 
2.38.1


