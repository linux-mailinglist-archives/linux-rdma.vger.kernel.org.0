Return-Path: <linux-rdma+bounces-9464-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17911A8AE08
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Apr 2025 04:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 494683B510C
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Apr 2025 02:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8B4221D9E;
	Wed, 16 Apr 2025 02:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YnEQQHO6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50F914B959;
	Wed, 16 Apr 2025 02:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744769776; cv=none; b=nfNL4ywHja5pwRxV33ShfU4+n+4MB7mXXFVkgc47kS92o/chLmOCUP11rv6uWjAhro0CTg5UnorVG3bTaPbCBrRolTOYMxandEcCI50PXEk7Ex2YrkPCy0PHV9QBYBjZOS7I7FgxFJGrC5FxTAAPIGRetT9+S555hVqE6B6WYwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744769776; c=relaxed/simple;
	bh=Es2I7GH/PeTuu57TYB5FO5PcIolFl7helrKTM1/g+Lk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sEUdEmhD6Kz0yQ7vN5yE40PtBm6OGdGNydzUXQ1vgjnW8AqLZpGTjkeCMYasBJ+xANJMkJctievU8feCzQO854A4riy632E9uG3q/XS20pgxW3OvFZ19wTBh5ZE8YXXBISgWEb2+3Sx4egK4NU5m2qwflLRaMYDYNwaMQmgaPyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YnEQQHO6; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744769774; x=1776305774;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Es2I7GH/PeTuu57TYB5FO5PcIolFl7helrKTM1/g+Lk=;
  b=YnEQQHO6A77eVVj+4GTnaTKQwpcPqFK9k+cfJOYV6TsRKPlSob7VqlJu
   jr4y3j9b0ZBp0QfoIfN7AYOzLhoSBNnEFlTJFBfAFS3Skfd3fPGZey3do
   zUs98t2tfNYF+gepBb/+KQ1KW0s2lvixzQ1cbD+zJQ0hKfHy908QGbv0L
   5y/W8OaEO7xczphNigOihEZTFH+GHK4eHH/Tc8MTbq01DPTxuaKwHIKPq
   Fic5meorLMmudQFqcG0Ibmi9MpGjnxtzs/m//LH0UF4p+oO6Fj4jlQwNJ
   kU7ZfGCjCoJGGHS5o4eksY2BSaEiWwF/txg38XEUH0+pcg0nlHuNEGwz4
   A==;
X-CSE-ConnectionGUID: ICAGZ8LZS4eU9W9YeCsLug==
X-CSE-MsgGUID: LiQ+VLb3TJyM2lynTd2c6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="50125559"
X-IronPort-AV: E=Sophos;i="6.15,214,1739865600"; 
   d="scan'208";a="50125559"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 19:16:12 -0700
X-CSE-ConnectionGUID: 2EZAvZUuSQGQ4Cnw8EosEA==
X-CSE-MsgGUID: aTSxVK+XQVSY/7GjsIZ9pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,214,1739865600"; 
   d="scan'208";a="130605795"
Received: from bnkannan-mobl1.amr.corp.intel.com (HELO soc-PF51RAGT.clients.intel.com) ([10.246.114.218])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 19:16:12 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org,
	intel-wired-lan@lists.osuosl.org
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [iwl-next v5 2/5] iidc/ice/irdma: Rename to iidc_* convention
Date: Tue, 15 Apr 2025 21:15:46 -0500
Message-ID: <20250416021549.606-3-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250416021549.606-1-tatyana.e.nikolova@intel.com>
References: <20250416021549.606-1-tatyana.e.nikolova@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Ertman <david.m.ertman@intel.com>

In preparation of supporting more than a single core PCI driver
for RDMA, homogenize naming to iidc_rdma_* and IIDC_RDMA_*
form.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 drivers/infiniband/hw/irdma/main.c           | 41 +++++++++++---------
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c |  8 ++--
 drivers/net/ethernet/intel/ice/ice_idc.c     | 22 ++++++-----
 drivers/net/ethernet/intel/ice/ice_idc_int.h |  2 +-
 drivers/net/ethernet/intel/ice/ice_main.c    |  8 ++--
 include/linux/net/intel/iidc_rdma.h          | 38 +++++++++---------
 6 files changed, 63 insertions(+), 56 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/main.c b/drivers/infiniband/hw/irdma/main.c
index 1ee8969595d3..46489c0ab511 100644
--- a/drivers/infiniband/hw/irdma/main.c
+++ b/drivers/infiniband/hw/irdma/main.c
@@ -61,7 +61,7 @@ static void irdma_log_invalid_mtu(u16 mtu, struct irdma_sc_dev *dev)
 }
 
 static void irdma_fill_qos_info(struct irdma_l2params *l2params,
-				struct iidc_qos_params *qos_info)
+				struct iidc_rdma_qos_params *qos_info)
 {
 	int i;
 
@@ -85,12 +85,12 @@ static void irdma_fill_qos_info(struct irdma_l2params *l2params,
 	}
 }
 
-static void irdma_iidc_event_handler(struct ice_pf *pf, struct iidc_event *event)
+static void irdma_iidc_event_handler(struct ice_pf *pf, struct iidc_rdma_event *event)
 {
 	struct irdma_device *iwdev = dev_get_drvdata(&pf->adev->dev);
 	struct irdma_l2params l2params = {};
 
-	if (*event->type & BIT(IIDC_EVENT_AFTER_MTU_CHANGE)) {
+	if (*event->type & BIT(IIDC_RDMA_EVENT_AFTER_MTU_CHANGE)) {
 		ibdev_dbg(&iwdev->ibdev, "CLNT: new MTU = %d\n", iwdev->netdev->mtu);
 		if (iwdev->vsi.mtu != iwdev->netdev->mtu) {
 			l2params.mtu = iwdev->netdev->mtu;
@@ -98,13 +98,13 @@ static void irdma_iidc_event_handler(struct ice_pf *pf, struct iidc_event *event
 			irdma_log_invalid_mtu(l2params.mtu, &iwdev->rf->sc_dev);
 			irdma_change_l2params(&iwdev->vsi, &l2params);
 		}
-	} else if (*event->type & BIT(IIDC_EVENT_BEFORE_TC_CHANGE)) {
+	} else if (*event->type & BIT(IIDC_RDMA_EVENT_BEFORE_TC_CHANGE)) {
 		if (iwdev->vsi.tc_change_pending)
 			return;
 
 		irdma_prep_tc_change(iwdev);
-	} else if (*event->type & BIT(IIDC_EVENT_AFTER_TC_CHANGE)) {
-		struct iidc_qos_params qos_info = {};
+	} else if (*event->type & BIT(IIDC_RDMA_EVENT_AFTER_TC_CHANGE)) {
+		struct iidc_rdma_qos_params qos_info = {};
 
 		if (!iwdev->vsi.tc_change_pending)
 			return;
@@ -116,7 +116,7 @@ static void irdma_iidc_event_handler(struct ice_pf *pf, struct iidc_event *event
 		if (iwdev->rf->protocol_used != IRDMA_IWARP_PROTOCOL_ONLY)
 			iwdev->dcb_vlan_mode = qos_info.num_tc > 1 && !l2params.dscp_mode;
 		irdma_change_l2params(&iwdev->vsi, &l2params);
-	} else if (*event->type & BIT(IIDC_EVENT_CRIT_ERR)) {
+	} else if (*event->type & BIT(IIDC_RDMA_EVENT_CRIT_ERR)) {
 		ibdev_warn(&iwdev->ibdev, "ICE OICR event notification: oicr = 0x%08x\n",
 			   event->reg);
 		if (event->reg & IRDMAPFINT_OICR_PE_CRITERR_M) {
@@ -245,11 +245,12 @@ static void irdma_deinit_interrupts(struct irdma_pci_f *rf, struct ice_pf *pf)
 
 static void irdma_remove(struct auxiliary_device *aux_dev)
 {
-	struct iidc_auxiliary_dev *iidc_adev = container_of(aux_dev,
-							    struct iidc_auxiliary_dev,
-							    adev);
-	struct ice_pf *pf = iidc_adev->pf;
 	struct irdma_device *iwdev = auxiliary_get_drvdata(aux_dev);
+	struct iidc_rdma_core_auxiliary_dev *iidc_adev;
+	struct ice_pf *pf;
+
+	iidc_adev = container_of(aux_dev, struct iidc_rdma_core_auxiliary_dev, adev);
+	pf = iidc_adev->pf;
 
 	irdma_ib_unregister_device(iwdev);
 	ice_rdma_update_vsi_filter(pf, iwdev->vsi_num, false);
@@ -292,17 +293,19 @@ static void irdma_fill_device_info(struct irdma_device *iwdev, struct ice_pf *pf
 
 static int irdma_probe(struct auxiliary_device *aux_dev, const struct auxiliary_device_id *id)
 {
-	struct iidc_auxiliary_dev *iidc_adev = container_of(aux_dev,
-							    struct iidc_auxiliary_dev,
-							    adev);
-	struct ice_pf *pf = iidc_adev->pf;
-	struct ice_vsi *vsi = ice_get_main_vsi(pf);
-	struct iidc_qos_params qos_info = {};
+	struct iidc_rdma_core_auxiliary_dev *iidc_adev;
+	struct iidc_rdma_qos_params qos_info = {};
+	struct irdma_l2params l2params = {};
 	struct irdma_device *iwdev;
 	struct irdma_pci_f *rf;
-	struct irdma_l2params l2params = {};
+	struct ice_vsi *vsi;
+	struct ice_pf *pf;
 	int err;
 
+	iidc_adev = container_of(aux_dev, struct iidc_rdma_core_auxiliary_dev, adev);
+	pf = iidc_adev->pf;
+	vsi = ice_get_main_vsi(pf);
+
 	if (!vsi)
 		return -EIO;
 	iwdev = ib_alloc_device(irdma_device, ibdev);
@@ -367,7 +370,7 @@ static const struct auxiliary_device_id irdma_auxiliary_id_table[] = {
 
 MODULE_DEVICE_TABLE(auxiliary, irdma_auxiliary_id_table);
 
-static struct iidc_auxiliary_drv irdma_auxiliary_drv = {
+static struct iidc_rdma_core_auxiliary_drv irdma_auxiliary_drv = {
 	.adrv = {
 	    .id_table = irdma_auxiliary_id_table,
 	    .probe = irdma_probe,
diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
index a7c510832824..fe16c59796db 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
@@ -352,8 +352,8 @@ int ice_pf_dcb_cfg(struct ice_pf *pf, struct ice_dcbx_cfg *new_cfg, bool locked)
 	struct ice_aqc_port_ets_elem buf = { 0 };
 	struct ice_dcbx_cfg *old_cfg, *curr_cfg;
 	struct device *dev = ice_pf_to_dev(pf);
+	struct iidc_rdma_event *event;
 	int ret = ICE_DCB_NO_HW_CHG;
-	struct iidc_event *event;
 	struct ice_vsi *pf_vsi;
 
 	curr_cfg = &pf->hw.port_info->qos_cfg.local_dcbx_cfg;
@@ -405,7 +405,7 @@ int ice_pf_dcb_cfg(struct ice_pf *pf, struct ice_dcbx_cfg *new_cfg, bool locked)
 		goto free_cfg;
 	}
 
-	set_bit(IIDC_EVENT_BEFORE_TC_CHANGE, event->type);
+	set_bit(IIDC_RDMA_EVENT_BEFORE_TC_CHANGE, event->type);
 	ice_send_event_to_aux(pf, event);
 	kfree(event);
 
@@ -740,7 +740,7 @@ static int ice_dcb_noncontig_cfg(struct ice_pf *pf)
 void ice_pf_dcb_recfg(struct ice_pf *pf, bool locked)
 {
 	struct ice_dcbx_cfg *dcbcfg = &pf->hw.port_info->qos_cfg.local_dcbx_cfg;
-	struct iidc_event *event;
+	struct iidc_rdma_event *event;
 	u8 tc_map = 0;
 	int v, ret;
 
@@ -789,7 +789,7 @@ void ice_pf_dcb_recfg(struct ice_pf *pf, bool locked)
 		if (!event)
 			return;
 
-		set_bit(IIDC_EVENT_AFTER_TC_CHANGE, event->type);
+		set_bit(IIDC_RDMA_EVENT_AFTER_TC_CHANGE, event->type);
 		ice_send_event_to_aux(pf, event);
 		kfree(event);
 	}
diff --git a/drivers/net/ethernet/intel/ice/ice_idc.c b/drivers/net/ethernet/intel/ice/ice_idc.c
index bab3e81cad5d..3f678426b7c9 100644
--- a/drivers/net/ethernet/intel/ice/ice_idc.c
+++ b/drivers/net/ethernet/intel/ice/ice_idc.c
@@ -15,7 +15,8 @@ static DEFINE_XARRAY_ALLOC1(ice_aux_id);
  * This function has to be called with a device_lock on the
  * pf->adev.dev to avoid race conditions.
  */
-static struct iidc_auxiliary_drv *ice_get_auxiliary_drv(struct ice_pf *pf)
+static
+struct iidc_rdma_core_auxiliary_drv *ice_get_auxiliary_drv(struct ice_pf *pf)
 {
 	struct auxiliary_device *adev;
 
@@ -23,8 +24,8 @@ static struct iidc_auxiliary_drv *ice_get_auxiliary_drv(struct ice_pf *pf)
 	if (!adev || !adev->dev.driver)
 		return NULL;
 
-	return container_of(adev->dev.driver, struct iidc_auxiliary_drv,
-			    adrv.driver);
+	return container_of(adev->dev.driver,
+			    struct iidc_rdma_core_auxiliary_drv, adrv.driver);
 }
 
 /**
@@ -32,9 +33,9 @@ static struct iidc_auxiliary_drv *ice_get_auxiliary_drv(struct ice_pf *pf)
  * @pf: pointer to PF struct
  * @event: event struct
  */
-void ice_send_event_to_aux(struct ice_pf *pf, struct iidc_event *event)
+void ice_send_event_to_aux(struct ice_pf *pf, struct iidc_rdma_event *event)
 {
-	struct iidc_auxiliary_drv *iadrv;
+	struct iidc_rdma_core_auxiliary_drv *iadrv;
 
 	if (WARN_ON_ONCE(!in_task()))
 		return;
@@ -141,7 +142,7 @@ EXPORT_SYMBOL_GPL(ice_del_rdma_qset);
  * @pf: struct for PF
  * @reset_type: type of reset
  */
-int ice_rdma_request_reset(struct ice_pf *pf, enum iidc_reset_type reset_type)
+int ice_rdma_request_reset(struct ice_pf *pf, enum iidc_rdma_reset_type reset_type)
 {
 	enum ice_reset_req reset;
 
@@ -205,7 +206,7 @@ EXPORT_SYMBOL_GPL(ice_rdma_update_vsi_filter);
  * @pf: pointer to PF struct
  * @qos: set of QoS values
  */
-void ice_get_qos_params(struct ice_pf *pf, struct iidc_qos_params *qos)
+void ice_get_qos_params(struct ice_pf *pf, struct iidc_rdma_qos_params *qos)
 {
 	struct ice_dcbx_cfg *dcbx_cfg;
 	unsigned int i;
@@ -263,9 +264,10 @@ EXPORT_SYMBOL_GPL(ice_free_rdma_qvector);
  */
 static void ice_adev_release(struct device *dev)
 {
-	struct iidc_auxiliary_dev *iadev;
+	struct iidc_rdma_core_auxiliary_dev *iadev;
 
-	iadev = container_of(dev, struct iidc_auxiliary_dev, adev.dev);
+	iadev = container_of(dev, struct iidc_rdma_core_auxiliary_dev,
+			     adev.dev);
 	kfree(iadev);
 }
 
@@ -275,7 +277,7 @@ static void ice_adev_release(struct device *dev)
  */
 int ice_plug_aux_dev(struct ice_pf *pf)
 {
-	struct iidc_auxiliary_dev *iadev;
+	struct iidc_rdma_core_auxiliary_dev *iadev;
 	struct auxiliary_device *adev;
 	int ret;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_idc_int.h b/drivers/net/ethernet/intel/ice/ice_idc_int.h
index b0c504a6408e..03cd7d8d1aaa 100644
--- a/drivers/net/ethernet/intel/ice/ice_idc_int.h
+++ b/drivers/net/ethernet/intel/ice/ice_idc_int.h
@@ -8,6 +8,6 @@
 
 struct ice_pf;
 
-void ice_send_event_to_aux(struct ice_pf *pf, struct iidc_event *event);
+void ice_send_event_to_aux(struct ice_pf *pf, struct iidc_rdma_event *event);
 
 #endif /* !_ICE_IDC_INT_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index d390157b59fe..6a20f9f2e608 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2401,11 +2401,11 @@ static void ice_service_task(struct work_struct *work)
 	}
 
 	if (test_and_clear_bit(ICE_AUX_ERR_PENDING, pf->state)) {
-		struct iidc_event *event;
+		struct iidc_rdma_event *event;
 
 		event = kzalloc(sizeof(*event), GFP_KERNEL);
 		if (event) {
-			set_bit(IIDC_EVENT_CRIT_ERR, event->type);
+			set_bit(IIDC_RDMA_EVENT_CRIT_ERR, event->type);
 			/* report the entire OICR value to AUX driver */
 			swap(event->reg, pf->oicr_err_reg);
 			ice_send_event_to_aux(pf, event);
@@ -2424,11 +2424,11 @@ static void ice_service_task(struct work_struct *work)
 		ice_plug_aux_dev(pf);
 
 	if (test_and_clear_bit(ICE_FLAG_MTU_CHANGED, pf->flags)) {
-		struct iidc_event *event;
+		struct iidc_rdma_event *event;
 
 		event = kzalloc(sizeof(*event), GFP_KERNEL);
 		if (event) {
-			set_bit(IIDC_EVENT_AFTER_MTU_CHANGE, event->type);
+			set_bit(IIDC_RDMA_EVENT_AFTER_MTU_CHANGE, event->type);
 			ice_send_event_to_aux(pf, event);
 			kfree(event);
 		}
diff --git a/include/linux/net/intel/iidc_rdma.h b/include/linux/net/intel/iidc_rdma.h
index 0cd75404e459..2b24a9912fa0 100644
--- a/include/linux/net/intel/iidc_rdma.h
+++ b/include/linux/net/intel/iidc_rdma.h
@@ -11,16 +11,16 @@
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
 
-enum iidc_event_type {
-	IIDC_EVENT_BEFORE_MTU_CHANGE,
-	IIDC_EVENT_AFTER_MTU_CHANGE,
-	IIDC_EVENT_BEFORE_TC_CHANGE,
-	IIDC_EVENT_AFTER_TC_CHANGE,
-	IIDC_EVENT_CRIT_ERR,
-	IIDC_EVENT_NBITS		/* must be last */
+enum iidc_rdma_event_type {
+	IIDC_RDMA_EVENT_BEFORE_MTU_CHANGE,
+	IIDC_RDMA_EVENT_AFTER_MTU_CHANGE,
+	IIDC_RDMA_EVENT_BEFORE_TC_CHANGE,
+	IIDC_RDMA_EVENT_AFTER_TC_CHANGE,
+	IIDC_RDMA_EVENT_CRIT_ERR,
+	IIDC_RDMA_EVENT_NBITS		/* must be last */
 };
 
-enum iidc_reset_type {
+enum iidc_rdma_reset_type {
 	IIDC_PFR,
 	IIDC_CORER,
 	IIDC_GLOBR,
@@ -47,7 +47,7 @@ struct iidc_rdma_qset_params {
 	u8 tc; /* TC branch the Qset should belong to */
 };
 
-struct iidc_qos_info {
+struct iidc_rdma_qos_info {
 	u64 tc_ctx;
 	u8 rel_bw;
 	u8 prio_type;
@@ -56,8 +56,8 @@ struct iidc_qos_info {
 };
 
 /* Struct to pass QoS info */
-struct iidc_qos_params {
-	struct iidc_qos_info tc_info[IEEE_8021QAZ_MAX_TCS];
+struct iidc_rdma_qos_params {
+	struct iidc_rdma_qos_info tc_info[IEEE_8021QAZ_MAX_TCS];
 	u8 up2tc[IIDC_MAX_USER_PRIORITY];
 	u8 vport_relative_bw;
 	u8 vport_priority_type;
@@ -66,8 +66,8 @@ struct iidc_qos_params {
 	u8 dscp_map[IIDC_MAX_DSCP_MAPPING];
 };
 
-struct iidc_event {
-	DECLARE_BITMAP(type, IIDC_EVENT_NBITS);
+struct iidc_rdma_event {
+	DECLARE_BITMAP(type, IIDC_RDMA_EVENT_NBITS);
 	u32 reg;
 };
 
@@ -75,9 +75,11 @@ struct ice_pf;
 
 int ice_add_rdma_qset(struct ice_pf *pf, struct iidc_rdma_qset_params *qset);
 int ice_del_rdma_qset(struct ice_pf *pf, struct iidc_rdma_qset_params *qset);
-int ice_rdma_request_reset(struct ice_pf *pf, enum iidc_reset_type reset_type);
+int ice_rdma_request_reset(struct ice_pf *pf,
+			   enum iidc_rdma_reset_type reset_type);
 int ice_rdma_update_vsi_filter(struct ice_pf *pf, u16 vsi_id, bool enable);
-void ice_get_qos_params(struct ice_pf *pf, struct iidc_qos_params *qos);
+void ice_get_qos_params(struct ice_pf *pf,
+			struct iidc_rdma_qos_params *qos);
 int ice_alloc_rdma_qvector(struct ice_pf *pf, struct msix_entry *entry);
 void ice_free_rdma_qvector(struct ice_pf *pf, struct msix_entry *entry);
 
@@ -86,7 +88,7 @@ void ice_free_rdma_qvector(struct ice_pf *pf, struct msix_entry *entry);
  * instance of this struct dedicated to it.
  */
 
-struct iidc_auxiliary_dev {
+struct iidc_rdma_core_auxiliary_dev {
 	struct auxiliary_device adev;
 	struct ice_pf *pf;
 };
@@ -96,14 +98,14 @@ struct iidc_auxiliary_dev {
  * driver will access these ops by performing a container_of on the
  * auxiliary_device->dev.driver.
  */
-struct iidc_auxiliary_drv {
+struct iidc_rdma_core_auxiliary_drv {
 	struct auxiliary_driver adrv;
 	/* This event_handler is meant to be a blocking call.  For instance,
 	 * when a BEFORE_MTU_CHANGE event comes in, the event_handler will not
 	 * return until the auxiliary driver is ready for the MTU change to
 	 * happen.
 	 */
-	void (*event_handler)(struct ice_pf *pf, struct iidc_event *event);
+	void (*event_handler)(struct ice_pf *pf, struct iidc_rdma_event *event);
 };
 
 #endif /* _IIDC_RDMA_H_*/
-- 
2.37.3


