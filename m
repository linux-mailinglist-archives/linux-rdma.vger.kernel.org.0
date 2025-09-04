Return-Path: <linux-rdma+bounces-13097-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8BCB446CF
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Sep 2025 21:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB63E5A3C8D
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Sep 2025 19:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B72277C90;
	Thu,  4 Sep 2025 19:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SWwshMza"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3BD1BD035;
	Thu,  4 Sep 2025 19:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757015915; cv=none; b=K4y8mblZ+K6I+v76qh3HhpYWnsG1VEq+EY/tMhk2syxNyi/nduxqRwpMP36DEXcSPx6SyZ14cbCzLZ4fYrg2lPKaJBpgAStDZP1qjixJE4cZZiHhEQyLNRmtMRTb/gPLVBVeFs+LwwDgYKIq2mslnXy0g2xlb8bk66sOGTH8tbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757015915; c=relaxed/simple;
	bh=PixqzQGGIrRfX7IIdPxeApKscwbKNdTHmf7PTPgFrow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qlvW9duK9xm5YWoqhDIZhv2ECnwq2RF1YovKEwXc1l94DbFHxZycc1RKQOj4u3uqm+DPiKVQ8yA2YBtAJJcxGO3tKdgW6WcT2uE2+S9TmzqIVhyxpDK8PLU3vGvYF7rn9WUd9QUfbmVcdOyfywjqrDVgu27b0IFksxzoEKxRlac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SWwshMza; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757015913; x=1788551913;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PixqzQGGIrRfX7IIdPxeApKscwbKNdTHmf7PTPgFrow=;
  b=SWwshMza7JWTMOdrWzZuRcX0gqisFChHmhtYHSyaKSa7ZSKYx15w7/dR
   JaikbTFef+xti7T9Qe5AXvLuMGEnY2dMQZkl3VWzp5gjTFR6Yea+KIjXW
   vjn7I09YjbIoX6QcPcnfa68Avjd5V4dxKzcfW6Pv1M1Po84j9p0ZIvv2h
   z7Zpp8aoC4Lr4QXR1LvQ0apXumZKMzO1sfqQaRwF/VSwfrJaEC5gOFkPK
   pKYgfsikDfUkCuqWHTDSs6yf53ixTwB/q/YgDpniJbjWbCRUmfB8sdja/
   KNpwNQyg+5TJSjZ9VPx0WXUcfLTslY29Rglc+1XsPV0ZmuY5gtcZqeD6a
   Q==;
X-CSE-ConnectionGUID: cRpANMFYQ9O+BORyksUg6Q==
X-CSE-MsgGUID: Q9Yrd9jQRHqXAETeMbvLLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="70745157"
X-IronPort-AV: E=Sophos;i="6.18,239,1751266800"; 
   d="scan'208";a="70745157"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 12:58:32 -0700
X-CSE-ConnectionGUID: BSuZao85S0KnGRvPaIOlfw==
X-CSE-MsgGUID: R0onZi9jT1q0mHcMMXt+ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,239,1751266800"; 
   d="scan'208";a="176102768"
Received: from pthorat-mobl.amr.corp.intel.com (HELO soc-PF51RAGT.clients.intel.com) ([10.246.116.180])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 12:58:31 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: przemyslaw.kitszel@intel.com,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	jiri@resnulli.us,
	anthony.l.nguyen@intel.com,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [iwl-next] ice, irdma: Add rdma_qp_limits_sel devlink parameter for irdma
Date: Thu,  4 Sep 2025 14:57:19 -0500
Message-ID: <20250904195719.371-1-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a devlink parameter to switch between different QP resource profiles
(max number of QPs) supported by irdma for Intel Ethernet 800 devices. The
rdma_qp_limits_sel is translated into an index in the rsrc_limits_table to
select a power of two number between 1 and 256 for max supported QPs (1K-256K).
To reduce the irdma memory footprint, set the rdma_qp_limits_sel default value
to 1 (max 1K QPs).

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
Since the changes to irdma are minor, this is targeted to iwl-next/net-next.

 Documentation/networking/devlink/ice.rst      |  29 +++++
 drivers/infiniband/hw/irdma/hw.c              |  15 ++-
 drivers/infiniband/hw/irdma/main.c            |   2 +-
 .../net/ethernet/intel/ice/devlink/devlink.c  | 110 ++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_idc.c      |   4 +
 include/linux/net/intel/iidc_rdma_ice.h       |   1 +
 6 files changed, 154 insertions(+), 7 deletions(-)

diff --git a/Documentation/networking/devlink/ice.rst b/Documentation/networking/devlink/ice.rst
index 792e9f8c846a..0514815fcf9c 100644
--- a/Documentation/networking/devlink/ice.rst
+++ b/Documentation/networking/devlink/ice.rst
@@ -104,6 +104,35 @@ Parameters
         one port capacity at cost of the another. User needs to disable
         local forwarding on one of the ports in order have increased capacity
         on the ``prioritized`` port.
+    * - ``rdma_qp_limits_sel``
+      - runtime
+      - The RDMA QP limits selector controls the max Queue Pairs (QPs) resources
+        which could be allocated per device. Depending on the available memory in
+        the system the actual allocated QP number could be smaller. QPs are evenly
+        distributed across active ports, so more ports mean fewer QPs per port.
+        Supported values for the QP limits selector are powers of 2, less or equal
+        to 256 and each value denotes a number of thousands QPs.
+
+        ``1`` - 1K QPs
+
+        ``2`` - 2K QPs
+
+        ``4`` - 4K QPs
+
+        ``8`` - 8K QPs
+
+        ``16`` - 16K QPs
+
+        ``32`` - 32K QPs
+
+        ``64`` - 64K QPs
+
+        ``128`` - 128K QPs
+
+        ``256`` - 256K QPs
+
+        Default value of ``rdma_qp_limits_sel`` parameter is ``1`` allowing 1K QPs to
+        maintain a low memory footprint.
 
 Info versions
 =============
diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
index 69ce1862eabe..de83a281aaab 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -4,27 +4,30 @@
 
 static struct irdma_rsrc_limits rsrc_limits_table[] = {
 	[0] = {
-		.qplimit = SZ_128,
+		.qplimit = SZ_1K,
 	},
 	[1] = {
-		.qplimit = SZ_1K,
+		.qplimit = SZ_2K,
 	},
 	[2] = {
-		.qplimit = SZ_2K,
+		.qplimit = SZ_4K,
 	},
 	[3] = {
-		.qplimit = SZ_4K,
+		.qplimit = SZ_8K,
 	},
 	[4] = {
 		.qplimit = SZ_16K,
 	},
 	[5] = {
-		.qplimit = SZ_64K,
+		.qplimit = SZ_32K,
 	},
 	[6] = {
-		.qplimit = SZ_128K,
+		.qplimit = SZ_64K,
 	},
 	[7] = {
+		.qplimit = SZ_128K,
+	},
+	[8] = {
 		.qplimit = SZ_256K,
 	},
 };
diff --git a/drivers/infiniband/hw/irdma/main.c b/drivers/infiniband/hw/irdma/main.c
index 1e840bbd619d..9d8e6e940667 100644
--- a/drivers/infiniband/hw/irdma/main.c
+++ b/drivers/infiniband/hw/irdma/main.c
@@ -285,7 +285,7 @@ static void irdma_fill_device_info(struct irdma_device *iwdev,
 	rf->rsrc_profile = IRDMA_HMC_PROFILE_DEFAULT;
 	rf->rst_to = IRDMA_RST_TIMEOUT_HZ;
 	rf->gen_ops.request_reset = irdma_request_reset;
-	rf->limits_sel = 7;
+	rf->limits_sel = iidc_priv->rdma_qp_limits_sel;
 	rf->iwdev = iwdev;
 
 	mutex_init(&iwdev->ah_tbl_lock);
diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index fb2de521731a..19f7f2d77812 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
@@ -1461,6 +1461,108 @@ ice_devlink_enable_iw_validate(struct devlink *devlink, u32 id,
 	return 0;
 }
 
+/**
+ * ice_devlink_rdma_qp_limits_get - Get RDMA QP limits select parameter
+ * @devlink: pointer to the devlink instance
+ * @__unused: the parameter ID
+ * @ctx: context to store the parameter value
+ *
+ * Return: zero on success and a negative value on failure.
+ */
+static int ice_devlink_rdma_qp_limits_get(struct devlink *devlink, u32 __unused,
+					   struct devlink_param_gset_ctx *ctx)
+{
+	struct ice_pf *pf = devlink_priv(devlink);
+	struct iidc_rdma_priv_dev_info *privd;
+	struct iidc_rdma_core_dev_info *cdev;
+
+	cdev = pf->cdev_info;
+	if (!cdev)
+		return -ENODEV;
+
+	privd = cdev->iidc_priv;
+	ctx->val.vu32 = 1 << privd->rdma_qp_limits_sel;
+
+	return 0;
+}
+
+/**
+ * ice_devlink_rdma_qp_limits_set - Set RDMA QP limits select parameter
+ * @devlink: pointer to the devlink instance
+ * @__unused: the parameter ID
+ * @ctx: context to get the parameter value
+ * @extack: netlink extended ACK structure
+ *
+ * Return: zero on success and a negative value on failure.
+ */
+static int ice_devlink_rdma_qp_limits_set(struct devlink *devlink, u32 __unused,
+					   struct devlink_param_gset_ctx *ctx,
+					   struct netlink_ext_ack *extack)
+{
+	struct ice_pf *pf = devlink_priv(devlink);
+	struct iidc_rdma_priv_dev_info *privd;
+	struct iidc_rdma_core_dev_info *cdev;
+	u32 qp_limits, prev_qp_limits;
+	int ret;
+
+	cdev = pf->cdev_info;
+	if (!cdev)
+		return -ENODEV;
+
+	privd = cdev->iidc_priv;
+	prev_qp_limits = privd->rdma_qp_limits_sel;
+	qp_limits = ilog2(ctx->val.vu32);
+
+	if (qp_limits == prev_qp_limits)
+		return 0;
+
+	ice_unplug_aux_dev(pf);
+	privd->rdma_qp_limits_sel = qp_limits;
+	ret = ice_plug_aux_dev(pf);
+	if (ret) {
+		int err;
+
+		privd->rdma_qp_limits_sel = prev_qp_limits;
+		NL_SET_ERR_MSG_MOD(extack, "Unable to change rdma_qp_limits_sel value");
+		err = ice_plug_aux_dev(pf);
+		if (err)
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Unable to restore RDMA capabilities for this function");
+	}
+
+	return ret;
+}
+
+/**
+ * ice_devlink_rdma_limits_sel_validate - Validate RDMA QP limits select parameter
+ * @devlink: pointer to devlink instance
+ * @__unused: the parameter ID
+ * @val: value to validate
+ * @extack: netlink extended ACK structure
+ *
+ * Supported values are <= 256 and power of 2
+ *
+ * Return: zero when passed parameter value is supported or a negative value on
+ * error.
+ */
+static int ice_devlink_rdma_qp_limits_validate(struct devlink *devlink, u32 __unused,
+						union devlink_param_value val,
+						struct netlink_ext_ack *extack)
+{
+	struct ice_pf *pf = devlink_priv(devlink);
+
+        if (!test_bit(ICE_FLAG_RDMA_ENA, pf->flags))
+		return -EOPNOTSUPP;
+
+	if (!is_power_of_2(val.vu32) || val.vu32 > 256) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "RDMA QP Limits Select value should be a power of 2 and <= 256");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 #define DEVLINK_LOCAL_FWD_DISABLED_STR "disabled"
 #define DEVLINK_LOCAL_FWD_ENABLED_STR "enabled"
 #define DEVLINK_LOCAL_FWD_PRIORITIZED_STR "prioritized"
@@ -1621,6 +1723,7 @@ enum ice_param_id {
 	ICE_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
 	ICE_DEVLINK_PARAM_ID_TX_SCHED_LAYERS,
 	ICE_DEVLINK_PARAM_ID_LOCAL_FWD,
+	ICE_DEVLINK_PARAM_ID_RDMA_QP_LIMITS_SEL,
 };
 
 static const struct devlink_param ice_dvl_rdma_params[] = {
@@ -1634,6 +1737,13 @@ static const struct devlink_param ice_dvl_rdma_params[] = {
 			      ice_devlink_enable_iw_validate),
 	DEVLINK_PARAM_GENERIC(ENABLE_RDMA, BIT(DEVLINK_PARAM_CMODE_DRIVERINIT),
 			      NULL, NULL, ice_devlink_enable_rdma_validate),
+	DEVLINK_PARAM_DRIVER(ICE_DEVLINK_PARAM_ID_RDMA_QP_LIMITS_SEL,
+			     "rdma_qp_limits_sel",
+			     DEVLINK_PARAM_TYPE_U32,
+			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
+			     ice_devlink_rdma_qp_limits_get,
+			     ice_devlink_rdma_qp_limits_set,
+			     ice_devlink_rdma_qp_limits_validate),
 };
 
 static const struct devlink_param ice_dvl_msix_params[] = {
diff --git a/drivers/net/ethernet/intel/ice/ice_idc.c b/drivers/net/ethernet/intel/ice/ice_idc.c
index 6ab53e430f91..6a4e1ac1804b 100644
--- a/drivers/net/ethernet/intel/ice/ice_idc.c
+++ b/drivers/net/ethernet/intel/ice/ice_idc.c
@@ -358,6 +358,8 @@ void ice_unplug_aux_dev(struct ice_pf *pf)
 	}
 }
 
+#define ICE_RDMA_QP_LIMITS_SELECT_DFLT  0
+
 /**
  * ice_init_rdma - initializes PF for RDMA use
  * @pf: ptr to ice_pf
@@ -403,6 +405,8 @@ int ice_init_rdma(struct ice_pf *pf)
 	privd->vport_id = pf->vsi[0]->vsi_num;
 
 	pf->cdev_info->rdma_protocol |= IIDC_RDMA_PROTOCOL_ROCEV2;
+	privd->rdma_qp_limits_sel = ICE_RDMA_QP_LIMITS_SELECT_DFLT;
+
 	ice_setup_dcb_qos_info(pf, &privd->qos_info);
 	ret = ice_plug_aux_dev(pf);
 	if (ret)
diff --git a/include/linux/net/intel/iidc_rdma_ice.h b/include/linux/net/intel/iidc_rdma_ice.h
index b40eed0e13fe..cb60797427c4 100644
--- a/include/linux/net/intel/iidc_rdma_ice.h
+++ b/include/linux/net/intel/iidc_rdma_ice.h
@@ -52,6 +52,7 @@ struct iidc_rdma_priv_dev_info {
 	struct net_device *netdev;
 	struct iidc_rdma_qos_params qos_info;
 	u8 __iomem *hw_addr;
+	u8 rdma_qp_limits_sel;
 };
 
 int ice_add_rdma_qset(struct iidc_rdma_core_dev_info *cdev,
-- 
2.37.3


