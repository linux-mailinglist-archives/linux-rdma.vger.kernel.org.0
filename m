Return-Path: <linux-rdma+bounces-9467-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48531A8AE0D
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Apr 2025 04:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3571B443AAB
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Apr 2025 02:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E392288FB;
	Wed, 16 Apr 2025 02:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HzxuAEr5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA552139B1;
	Wed, 16 Apr 2025 02:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744769779; cv=none; b=EL2YorRsBPiTi47J088LXrL7Q79zd4odsBRQ1cO/m7smV9//e6TmDXCOCalQEVN+9C2EiPBosb+S66QcoFWqX7Sig8Ri+eFB7JFTupVqrzuTep4MPU42RKHe52G4G40vah6ZrI2/RoxV2NazlL1Vfla3hd6Yj91E+ST8piLfvDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744769779; c=relaxed/simple;
	bh=ojePAG2NBOeJeYoY3cwhFnI6jaJkQIU5XZbhWBiCg/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gfmlzdWh3zIO1YqGAlb0sJcNLJ/JfQl/SQ+GaAPtGpv4Oy66LXDe7839kMKN0syp6/Pz/phG45cgBjShjR7eKWIaJH05R19AEpjKLw5ZXUSxig9MShRyv4U/NjIwdbu3xIZn5Mo6/aL/aaOp1I2ffobL/KZhVOhNoFBKZC6sVFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HzxuAEr5; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744769776; x=1776305776;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ojePAG2NBOeJeYoY3cwhFnI6jaJkQIU5XZbhWBiCg/I=;
  b=HzxuAEr55z5lAPr6WNnw763C2iAOJsdMq2swkPZKU83uUPISD7Z/6hmp
   c+TWYBPaG9k4TbgAd/pFvZlBT/+CxnWZOmZKLcug/iUt2ahYYgxJ854tO
   CDl32p2si6mwPh14m3Y6bk035fMW6DaKAhSB9QAk2s2pNUnmFAou57Kux
   pC9REjJr9rWdpmmOIHsCwRuQswAXsreeGfuv5HzG+gMW/pzzQmIEt9Tc1
   GnyloC++/vW4R8dJi/HsXmxFL6AS8t3oWinlhL+D7vmR4HYL9smJdPbeE
   w7pTvZEoomv14ZROueoz1UdqvKyDb4eNLSBvaTWFhCVDyryob1GnpBHED
   Q==;
X-CSE-ConnectionGUID: J0MFesHtRkWsmB/5B42g2w==
X-CSE-MsgGUID: N9ShgaAISz6hYqgU8UDmRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="50125572"
X-IronPort-AV: E=Sophos;i="6.15,214,1739865600"; 
   d="scan'208";a="50125572"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 19:16:14 -0700
X-CSE-ConnectionGUID: vusmn2VIRQKc45d/xRN39A==
X-CSE-MsgGUID: X5/p0FXsTGGAx1NWxQlLiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,214,1739865600"; 
   d="scan'208";a="130605802"
Received: from bnkannan-mobl1.amr.corp.intel.com (HELO soc-PF51RAGT.clients.intel.com) ([10.246.114.218])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 19:16:13 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org,
	intel-wired-lan@lists.osuosl.org
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [iwl-next v5 5/5] iidc/ice/irdma: Update IDC to support multiple consumers
Date: Tue, 15 Apr 2025 21:15:49 -0500
Message-ID: <20250416021549.606-6-tatyana.e.nikolova@intel.com>
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
for RDMA, move ice specific structs like qset_params, qos_info
and qos_params from iidc_rdma.h to iidc_rdma_ice.h.

Previously, the ice driver was just exporting its entire PF struct
to the auxiliary driver, but since each core driver will have its own
different PF struct, implement a universal struct that all core drivers
can provide to the auxiliary driver through the probe call.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
Co-developed-by: Mustafa Ismail <mustafa.ismail@intel.com>
Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
Co-developed-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Co-developed-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 drivers/infiniband/hw/irdma/main.c            | 102 +++++-----
 drivers/infiniband/hw/irdma/main.h            |   1 +
 .../net/ethernet/intel/ice/devlink/devlink.c  |  45 ++++-
 drivers/net/ethernet/intel/ice/ice.h          |   6 +-
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |  39 +++-
 drivers/net/ethernet/intel/ice/ice_dcb_lib.h  |   9 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |   8 +-
 drivers/net/ethernet/intel/ice/ice_idc.c      | 190 +++++++++++-------
 drivers/net/ethernet/intel/ice/ice_main.c     |  10 +-
 include/linux/net/intel/iidc_rdma.h           |  69 ++-----
 include/linux/net/intel/iidc_rdma_ice.h       |  69 ++++++-
 11 files changed, 347 insertions(+), 201 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/main.c b/drivers/infiniband/hw/irdma/main.c
index 46489c0ab511..abb532bc8ce4 100644
--- a/drivers/infiniband/hw/irdma/main.c
+++ b/drivers/infiniband/hw/irdma/main.c
@@ -1,10 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /* Copyright (c) 2015 - 2021 Intel Corporation */
 #include "main.h"
-#include "../../../net/ethernet/intel/ice/ice.h"
 
 MODULE_ALIAS("i40iw");
-MODULE_AUTHOR("Intel Corporation, <e1000-rdma@lists.sourceforge.net>");
 MODULE_DESCRIPTION("Intel(R) Ethernet Protocol Driver for RDMA");
 MODULE_LICENSE("Dual BSD/GPL");
 
@@ -85,9 +83,10 @@ static void irdma_fill_qos_info(struct irdma_l2params *l2params,
 	}
 }
 
-static void irdma_iidc_event_handler(struct ice_pf *pf, struct iidc_rdma_event *event)
+static void irdma_iidc_event_handler(struct iidc_rdma_core_dev_info *cdev_info,
+				     struct iidc_rdma_event *event)
 {
-	struct irdma_device *iwdev = dev_get_drvdata(&pf->adev->dev);
+	struct irdma_device *iwdev = dev_get_drvdata(&cdev_info->adev->dev);
 	struct irdma_l2params l2params = {};
 
 	if (*event->type & BIT(IIDC_RDMA_EVENT_AFTER_MTU_CHANGE)) {
@@ -104,17 +103,18 @@ static void irdma_iidc_event_handler(struct ice_pf *pf, struct iidc_rdma_event *
 
 		irdma_prep_tc_change(iwdev);
 	} else if (*event->type & BIT(IIDC_RDMA_EVENT_AFTER_TC_CHANGE)) {
-		struct iidc_rdma_qos_params qos_info = {};
+		struct iidc_rdma_priv_dev_info *iidc_priv = cdev_info->iidc_priv;
 
 		if (!iwdev->vsi.tc_change_pending)
 			return;
 
 		l2params.tc_changed = true;
 		ibdev_dbg(&iwdev->ibdev, "CLNT: TC Change\n");
-		ice_get_qos_params(pf, &qos_info);
-		irdma_fill_qos_info(&l2params, &qos_info);
+
+		irdma_fill_qos_info(&l2params, &iidc_priv->qos_info);
 		if (iwdev->rf->protocol_used != IRDMA_IWARP_PROTOCOL_ONLY)
-			iwdev->dcb_vlan_mode = qos_info.num_tc > 1 && !l2params.dscp_mode;
+			iwdev->dcb_vlan_mode =
+				l2params.num_tc > 1 && !l2params.dscp_mode;
 		irdma_change_l2params(&iwdev->vsi, &l2params);
 	} else if (*event->type & BIT(IIDC_RDMA_EVENT_CRIT_ERR)) {
 		ibdev_warn(&iwdev->ibdev, "ICE OICR event notification: oicr = 0x%08x\n",
@@ -151,10 +151,8 @@ static void irdma_iidc_event_handler(struct ice_pf *pf, struct iidc_rdma_event *
  */
 static void irdma_request_reset(struct irdma_pci_f *rf)
 {
-	struct ice_pf *pf = rf->cdev;
-
 	ibdev_warn(&rf->iwdev->ibdev, "Requesting a reset\n");
-	ice_rdma_request_reset(pf, IIDC_PFR);
+	ice_rdma_request_reset(rf->cdev, IIDC_FUNC_RESET);
 }
 
 /**
@@ -166,14 +164,15 @@ static int irdma_lan_register_qset(struct irdma_sc_vsi *vsi,
 				   struct irdma_ws_node *tc_node)
 {
 	struct irdma_device *iwdev = vsi->back_vsi;
-	struct ice_pf *pf = iwdev->rf->cdev;
+	struct iidc_rdma_core_dev_info *cdev_info;
 	struct iidc_rdma_qset_params qset = {};
 	int ret;
 
+	cdev_info = iwdev->rf->cdev;
 	qset.qs_handle = tc_node->qs_handle;
 	qset.tc = tc_node->traffic_class;
 	qset.vport_id = vsi->vsi_idx;
-	ret = ice_add_rdma_qset(pf, &qset);
+	ret = ice_add_rdma_qset(cdev_info, &qset);
 	if (ret) {
 		ibdev_dbg(&iwdev->ibdev, "WS: LAN alloc_res for rdma qset failed.\n");
 		return ret;
@@ -194,19 +193,20 @@ static void irdma_lan_unregister_qset(struct irdma_sc_vsi *vsi,
 				      struct irdma_ws_node *tc_node)
 {
 	struct irdma_device *iwdev = vsi->back_vsi;
-	struct ice_pf *pf = iwdev->rf->cdev;
+	struct iidc_rdma_core_dev_info *cdev_info;
 	struct iidc_rdma_qset_params qset = {};
 
+	cdev_info = iwdev->rf->cdev;
 	qset.qs_handle = tc_node->qs_handle;
 	qset.tc = tc_node->traffic_class;
 	qset.vport_id = vsi->vsi_idx;
 	qset.teid = tc_node->l2_sched_node_id;
 
-	if (ice_del_rdma_qset(pf, &qset))
+	if (ice_del_rdma_qset(cdev_info, &qset))
 		ibdev_dbg(&iwdev->ibdev, "WS: LAN free_res for rdma qset failed.\n");
 }
 
-static int irdma_init_interrupts(struct irdma_pci_f *rf, struct ice_pf *pf)
+static int irdma_init_interrupts(struct irdma_pci_f *rf, struct iidc_rdma_core_dev_info *cdev)
 {
 	int i;
 
@@ -217,12 +217,12 @@ static int irdma_init_interrupts(struct irdma_pci_f *rf, struct ice_pf *pf)
 		return -ENOMEM;
 
 	for (i = 0; i < rf->msix_count; i++)
-		if (ice_alloc_rdma_qvector(pf, &rf->msix_entries[i]))
+		if (ice_alloc_rdma_qvector(cdev, &rf->msix_entries[i]))
 			break;
 
 	if (i < IRDMA_MIN_MSIX) {
 		for (; i > 0; i--)
-			ice_free_rdma_qvector(pf, &rf->msix_entries[i]);
+			ice_free_rdma_qvector(cdev, &rf->msix_entries[i]);
 
 		kfree(rf->msix_entries);
 		return -ENOMEM;
@@ -233,12 +233,12 @@ static int irdma_init_interrupts(struct irdma_pci_f *rf, struct ice_pf *pf)
 	return 0;
 }
 
-static void irdma_deinit_interrupts(struct irdma_pci_f *rf, struct ice_pf *pf)
+static void irdma_deinit_interrupts(struct irdma_pci_f *rf, struct iidc_rdma_core_dev_info *cdev)
 {
 	int i;
 
 	for (i = 0; i < rf->msix_count; i++)
-		ice_free_rdma_qvector(pf, &rf->msix_entries[i]);
+		ice_free_rdma_qvector(cdev, &rf->msix_entries[i]);
 
 	kfree(rf->msix_entries);
 }
@@ -247,41 +247,49 @@ static void irdma_remove(struct auxiliary_device *aux_dev)
 {
 	struct irdma_device *iwdev = auxiliary_get_drvdata(aux_dev);
 	struct iidc_rdma_core_auxiliary_dev *iidc_adev;
-	struct ice_pf *pf;
+	struct iidc_rdma_core_dev_info *cdev_info;
 
 	iidc_adev = container_of(aux_dev, struct iidc_rdma_core_auxiliary_dev, adev);
-	pf = iidc_adev->pf;
+	cdev_info = iidc_adev->cdev_info;
 
+	ice_rdma_update_vsi_filter(cdev_info, iwdev->vsi_num, false);
 	irdma_ib_unregister_device(iwdev);
-	ice_rdma_update_vsi_filter(pf, iwdev->vsi_num, false);
-	irdma_deinit_interrupts(iwdev->rf, pf);
+	irdma_deinit_interrupts(iwdev->rf, cdev_info);
 
-	pr_debug("INIT: Gen2 PF[%d] device remove success\n", PCI_FUNC(pf->pdev->devfn));
+	pr_debug("INIT: Gen2 PF[%d] device remove success\n", PCI_FUNC(cdev_info->pdev->devfn));
 }
 
-static void irdma_fill_device_info(struct irdma_device *iwdev, struct ice_pf *pf,
-				   struct ice_vsi *vsi)
+static void irdma_fill_device_info(struct irdma_device *iwdev,
+				   struct iidc_rdma_core_dev_info *cdev_info)
 {
+	struct iidc_rdma_priv_dev_info *iidc_priv = cdev_info->iidc_priv;
 	struct irdma_pci_f *rf = iwdev->rf;
 
-	rf->cdev = pf;
+	rf->sc_dev.hw = &rf->hw;
+	rf->iwdev = iwdev;
+	rf->cdev = cdev_info;
+	rf->hw.hw_addr = iidc_priv->hw_addr;
+	rf->pcidev = cdev_info->pdev;
+	rf->hw.device = &rf->pcidev->dev;
+	rf->pf_id = iidc_priv->pf_id;
 	rf->gen_ops.register_qset = irdma_lan_register_qset;
 	rf->gen_ops.unregister_qset = irdma_lan_unregister_qset;
-	rf->hw.hw_addr = pf->hw.hw_addr;
-	rf->pcidev = pf->pdev;
-	rf->pf_id = pf->hw.pf_id;
-	rf->default_vsi.vsi_idx = vsi->vsi_num;
-	rf->protocol_used = pf->rdma_mode & IIDC_RDMA_PROTOCOL_ROCEV2 ?
-			    IRDMA_ROCE_PROTOCOL_ONLY : IRDMA_IWARP_PROTOCOL_ONLY;
+
+	rf->default_vsi.vsi_idx = iidc_priv->vport_id;
+	rf->protocol_used =
+		cdev_info->rdma_protocol == IIDC_RDMA_PROTOCOL_ROCEV2 ?
+		IRDMA_ROCE_PROTOCOL_ONLY : IRDMA_IWARP_PROTOCOL_ONLY;
 	rf->rdma_ver = IRDMA_GEN_2;
 	rf->rsrc_profile = IRDMA_HMC_PROFILE_DEFAULT;
 	rf->rst_to = IRDMA_RST_TIMEOUT_HZ;
 	rf->gen_ops.request_reset = irdma_request_reset;
 	rf->limits_sel = 7;
 	rf->iwdev = iwdev;
+
 	mutex_init(&iwdev->ah_tbl_lock);
-	iwdev->netdev = vsi->netdev;
-	iwdev->vsi_num = vsi->vsi_num;
+
+	iwdev->netdev = iidc_priv->netdev;
+	iwdev->vsi_num = iidc_priv->vport_id;
 	iwdev->init_state = INITIAL_STATE;
 	iwdev->roce_cwnd = IRDMA_ROCE_CWND_DEFAULT;
 	iwdev->roce_ackcreds = IRDMA_ROCE_ACKCREDS_DEFAULT;
@@ -294,20 +302,17 @@ static void irdma_fill_device_info(struct irdma_device *iwdev, struct ice_pf *pf
 static int irdma_probe(struct auxiliary_device *aux_dev, const struct auxiliary_device_id *id)
 {
 	struct iidc_rdma_core_auxiliary_dev *iidc_adev;
-	struct iidc_rdma_qos_params qos_info = {};
+	struct iidc_rdma_core_dev_info *cdev_info;
+	struct iidc_rdma_priv_dev_info *iidc_priv;
 	struct irdma_l2params l2params = {};
 	struct irdma_device *iwdev;
 	struct irdma_pci_f *rf;
-	struct ice_vsi *vsi;
-	struct ice_pf *pf;
 	int err;
 
 	iidc_adev = container_of(aux_dev, struct iidc_rdma_core_auxiliary_dev, adev);
-	pf = iidc_adev->pf;
-	vsi = ice_get_main_vsi(pf);
+	cdev_info = iidc_adev->cdev_info;
+	iidc_priv = cdev_info->iidc_priv;
 
-	if (!vsi)
-		return -EIO;
 	iwdev = ib_alloc_device(irdma_device, ibdev);
 	if (!iwdev)
 		return -ENOMEM;
@@ -317,10 +322,10 @@ static int irdma_probe(struct auxiliary_device *aux_dev, const struct auxiliary_
 		return -ENOMEM;
 	}
 
-	irdma_fill_device_info(iwdev, pf, vsi);
+	irdma_fill_device_info(iwdev, cdev_info);
 	rf = iwdev->rf;
 
-	err = irdma_init_interrupts(rf, pf);
+	err = irdma_init_interrupts(rf, cdev_info);
 	if (err)
 		goto err_init_interrupts;
 
@@ -329,8 +334,7 @@ static int irdma_probe(struct auxiliary_device *aux_dev, const struct auxiliary_
 		goto err_ctrl_init;
 
 	l2params.mtu = iwdev->netdev->mtu;
-	ice_get_qos_params(pf, &qos_info);
-	irdma_fill_qos_info(&l2params, &qos_info);
+	irdma_fill_qos_info(&l2params, &iidc_priv->qos_info);
 	if (iwdev->rf->protocol_used != IRDMA_IWARP_PROTOCOL_ONLY)
 		iwdev->dcb_vlan_mode = l2params.num_tc > 1 && !l2params.dscp_mode;
 
@@ -342,7 +346,7 @@ static int irdma_probe(struct auxiliary_device *aux_dev, const struct auxiliary_
 	if (err)
 		goto err_ibreg;
 
-	ice_rdma_update_vsi_filter(pf, iwdev->vsi_num, true);
+	ice_rdma_update_vsi_filter(cdev_info, iwdev->vsi_num, true);
 
 	ibdev_dbg(&iwdev->ibdev, "INIT: Gen2 PF[%d] device probe success\n", PCI_FUNC(rf->pcidev->devfn));
 	auxiliary_set_drvdata(aux_dev, iwdev);
@@ -354,7 +358,7 @@ static int irdma_probe(struct auxiliary_device *aux_dev, const struct auxiliary_
 err_rt_init:
 	irdma_ctrl_deinit_hw(rf);
 err_ctrl_init:
-	irdma_deinit_interrupts(rf, pf);
+	irdma_deinit_interrupts(rf, cdev_info);
 err_init_interrupts:
 	kfree(iwdev->rf);
 	ib_dealloc_device(&iwdev->ibdev);
diff --git a/drivers/infiniband/hw/irdma/main.h b/drivers/infiniband/hw/irdma/main.h
index e8083b0c8cb2..674acc952168 100644
--- a/drivers/infiniband/hw/irdma/main.h
+++ b/drivers/infiniband/hw/irdma/main.h
@@ -30,6 +30,7 @@
 #endif
 #include <linux/auxiliary_bus.h>
 #include <linux/net/intel/iidc_rdma.h>
+#include <linux/net/intel/iidc_rdma_ice.h>
 #include <rdma/ib_smi.h>
 #include <rdma/ib_verbs.h>
 #include <rdma/ib_pack.h>
diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index fcb199efbea5..4af60e2f37df 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
@@ -1339,8 +1339,13 @@ ice_devlink_enable_roce_get(struct devlink *devlink, u32 id,
 			    struct devlink_param_gset_ctx *ctx)
 {
 	struct ice_pf *pf = devlink_priv(devlink);
+	struct iidc_rdma_core_dev_info *cdev;
 
-	ctx->val.vbool = pf->rdma_mode & IIDC_RDMA_PROTOCOL_ROCEV2 ? true : false;
+	cdev = pf->cdev_info;
+	if (!cdev)
+		return -ENODEV;
+
+	ctx->val.vbool = !!(cdev->rdma_protocol & IIDC_RDMA_PROTOCOL_ROCEV2);
 
 	return 0;
 }
@@ -1350,19 +1355,24 @@ static int ice_devlink_enable_roce_set(struct devlink *devlink, u32 id,
 				       struct netlink_ext_ack *extack)
 {
 	struct ice_pf *pf = devlink_priv(devlink);
+	struct iidc_rdma_core_dev_info *cdev;
 	bool roce_ena = ctx->val.vbool;
 	int ret;
 
+	cdev = pf->cdev_info;
+	if (!cdev)
+		return -ENODEV;
+
 	if (!roce_ena) {
 		ice_unplug_aux_dev(pf);
-		pf->rdma_mode &= ~IIDC_RDMA_PROTOCOL_ROCEV2;
+		cdev->rdma_protocol &= ~IIDC_RDMA_PROTOCOL_ROCEV2;
 		return 0;
 	}
 
-	pf->rdma_mode |= IIDC_RDMA_PROTOCOL_ROCEV2;
+	cdev->rdma_protocol |= IIDC_RDMA_PROTOCOL_ROCEV2;
 	ret = ice_plug_aux_dev(pf);
 	if (ret)
-		pf->rdma_mode &= ~IIDC_RDMA_PROTOCOL_ROCEV2;
+		cdev->rdma_protocol &= ~IIDC_RDMA_PROTOCOL_ROCEV2;
 
 	return ret;
 }
@@ -1373,11 +1383,16 @@ ice_devlink_enable_roce_validate(struct devlink *devlink, u32 id,
 				 struct netlink_ext_ack *extack)
 {
 	struct ice_pf *pf = devlink_priv(devlink);
+	struct iidc_rdma_core_dev_info *cdev;
+
+	cdev = pf->cdev_info;
+	if (!cdev)
+		return -ENODEV;
 
 	if (!test_bit(ICE_FLAG_RDMA_ENA, pf->flags))
 		return -EOPNOTSUPP;
 
-	if (pf->rdma_mode & IIDC_RDMA_PROTOCOL_IWARP) {
+	if (cdev->rdma_protocol & IIDC_RDMA_PROTOCOL_IWARP) {
 		NL_SET_ERR_MSG_MOD(extack, "iWARP is currently enabled. This device cannot enable iWARP and RoCEv2 simultaneously");
 		return -EOPNOTSUPP;
 	}
@@ -1390,8 +1405,13 @@ ice_devlink_enable_iw_get(struct devlink *devlink, u32 id,
 			  struct devlink_param_gset_ctx *ctx)
 {
 	struct ice_pf *pf = devlink_priv(devlink);
+	struct iidc_rdma_core_dev_info *cdev;
 
-	ctx->val.vbool = pf->rdma_mode & IIDC_RDMA_PROTOCOL_IWARP;
+	cdev = pf->cdev_info;
+	if (!cdev)
+		return -ENODEV;
+
+	ctx->val.vbool = !!(cdev->rdma_protocol & IIDC_RDMA_PROTOCOL_IWARP);
 
 	return 0;
 }
@@ -1401,19 +1421,24 @@ static int ice_devlink_enable_iw_set(struct devlink *devlink, u32 id,
 				     struct netlink_ext_ack *extack)
 {
 	struct ice_pf *pf = devlink_priv(devlink);
+	struct iidc_rdma_core_dev_info *cdev;
 	bool iw_ena = ctx->val.vbool;
 	int ret;
 
+	cdev = pf->cdev_info;
+	if (!cdev)
+		return -ENODEV;
+
 	if (!iw_ena) {
 		ice_unplug_aux_dev(pf);
-		pf->rdma_mode &= ~IIDC_RDMA_PROTOCOL_IWARP;
+		cdev->rdma_protocol &= ~IIDC_RDMA_PROTOCOL_IWARP;
 		return 0;
 	}
 
-	pf->rdma_mode |= IIDC_RDMA_PROTOCOL_IWARP;
+	cdev->rdma_protocol |= IIDC_RDMA_PROTOCOL_IWARP;
 	ret = ice_plug_aux_dev(pf);
 	if (ret)
-		pf->rdma_mode &= ~IIDC_RDMA_PROTOCOL_IWARP;
+		cdev->rdma_protocol &= ~IIDC_RDMA_PROTOCOL_IWARP;
 
 	return ret;
 }
@@ -1428,7 +1453,7 @@ ice_devlink_enable_iw_validate(struct devlink *devlink, u32 id,
 	if (!test_bit(ICE_FLAG_RDMA_ENA, pf->flags))
 		return -EOPNOTSUPP;
 
-	if (pf->rdma_mode & IIDC_RDMA_PROTOCOL_ROCEV2) {
+	if (pf->cdev_info->rdma_protocol & IIDC_RDMA_PROTOCOL_ROCEV2) {
 		NL_SET_ERR_MSG_MOD(extack, "RoCEv2 is currently enabled. This device cannot enable iWARP and RoCEv2 simultaneously");
 		return -EOPNOTSUPP;
 	}
diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index fd083647c14a..e27d9044bcb3 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -401,7 +401,6 @@ struct ice_vsi {
 	u16 req_rxq;			 /* User requested Rx queues */
 	u16 num_rx_desc;
 	u16 num_tx_desc;
-	u16 qset_handle[ICE_MAX_TRAFFIC_CLASS];
 	struct ice_tc_cfg tc_cfg;
 	struct bpf_prog *xdp_prog;
 	struct ice_tx_ring **xdp_rings;	 /* XDP ring array */
@@ -557,7 +556,6 @@ struct ice_pf {
 	struct devlink_port devlink_port;
 
 	/* OS reserved IRQ details */
-	struct msix_entry *msix_entries;
 	struct ice_irq_tracker irq_tracker;
 	struct ice_virt_irq_tracker virt_irq_tracker;
 
@@ -592,7 +590,6 @@ struct ice_pf {
 	struct gnss_serial *gnss_serial;
 	struct gnss_device *gnss_dev;
 	u16 num_rdma_msix;		/* Total MSIX vectors for RDMA driver */
-	u16 rdma_base_vector;
 
 	/* spinlock to protect the AdminQ wait list */
 	spinlock_t aq_wait_lock;
@@ -625,14 +622,12 @@ struct ice_pf {
 	struct ice_hw_port_stats stats_prev;
 	struct ice_hw hw;
 	u8 stat_prev_loaded:1; /* has previous stats been loaded */
-	u8 rdma_mode;
 	u16 dcbx_cap;
 	u32 tx_timeout_count;
 	unsigned long tx_timeout_last_recovery;
 	u32 tx_timeout_recovery_level;
 	char int_name[ICE_INT_NAME_STR_LEN];
 	char int_name_ll_ts[ICE_INT_NAME_STR_LEN];
-	struct auxiliary_device *adev;
 	int aux_idx;
 	u32 sw_int_count;
 	/* count of tc_flower filters specific to channel (aka where filter
@@ -664,6 +659,7 @@ struct ice_pf {
 	struct ice_dplls dplls;
 	struct device *hwmon_dev;
 	struct ice_health health_reporters;
+	struct iidc_rdma_core_dev_info *cdev_info;
 
 	u8 num_quanta_prof_used;
 };
diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
index fe16c59796db..c5ef33c100d6 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
@@ -740,6 +740,8 @@ static int ice_dcb_noncontig_cfg(struct ice_pf *pf)
 void ice_pf_dcb_recfg(struct ice_pf *pf, bool locked)
 {
 	struct ice_dcbx_cfg *dcbcfg = &pf->hw.port_info->qos_cfg.local_dcbx_cfg;
+	struct iidc_rdma_priv_dev_info *privd;
+	struct iidc_rdma_core_dev_info *cdev;
 	struct iidc_rdma_event *event;
 	u8 tc_map = 0;
 	int v, ret;
@@ -783,7 +785,11 @@ void ice_pf_dcb_recfg(struct ice_pf *pf, bool locked)
 		if (vsi->type == ICE_VSI_PF)
 			ice_dcbnl_set_all(vsi);
 	}
-	if (!locked) {
+
+	cdev = pf->cdev_info;
+	if (cdev && !locked) {
+		privd = cdev->iidc_priv;
+		ice_setup_dcb_qos_info(pf, &privd->qos_info);
 		/* Notify the AUX drivers that TC change is finished */
 		event = kzalloc(sizeof(*event), GFP_KERNEL);
 		if (!event)
@@ -944,6 +950,37 @@ ice_tx_prepare_vlan_flags_dcb(struct ice_tx_ring *tx_ring,
 	}
 }
 
+/**
+ * ice_setup_dcb_qos_info - Setup DCB QoS information
+ * @pf: ptr to ice_pf
+ * @qos_info: QoS param instance
+ */
+void ice_setup_dcb_qos_info(struct ice_pf *pf, struct iidc_rdma_qos_params *qos_info)
+{
+	struct ice_dcbx_cfg *dcbx_cfg;
+	unsigned int i;
+	u32 up2tc;
+
+	if (!pf || !qos_info)
+		return;
+
+	dcbx_cfg = &pf->hw.port_info->qos_cfg.local_dcbx_cfg;
+	up2tc = rd32(&pf->hw, PRTDCB_TUP2TC);
+
+	qos_info->num_tc = ice_dcb_get_num_tc(dcbx_cfg);
+
+	for (i = 0; i < IIDC_MAX_USER_PRIORITY; i++)
+		qos_info->up2tc[i] = (up2tc >> (i * 3)) & 0x7;
+
+	for (i = 0; i < IEEE_8021QAZ_MAX_TCS; i++)
+		qos_info->tc_info[i].rel_bw = dcbx_cfg->etscfg.tcbwtable[i];
+
+	qos_info->pfc_mode = dcbx_cfg->pfc_mode;
+	if (qos_info->pfc_mode == IIDC_DSCP_PFC_MODE)
+		for (i = 0; i < DSCP_MAX; i++)
+			qos_info->dscp_map[i] = dcbx_cfg->dscp_map[i];
+}
+
 /**
  * ice_dcb_is_mib_change_pending - Check if MIB change is pending
  * @state: MIB change state
diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.h b/drivers/net/ethernet/intel/ice/ice_dcb_lib.h
index 800879a88c5e..da9ba814b4e8 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.h
@@ -31,6 +31,9 @@ void
 ice_tx_prepare_vlan_flags_dcb(struct ice_tx_ring *tx_ring,
 			      struct ice_tx_buf *first);
 void
+ice_setup_dcb_qos_info(struct ice_pf *pf,
+		       struct iidc_rdma_qos_params *qos_info);
+void
 ice_dcb_process_lldp_set_mib_change(struct ice_pf *pf,
 				    struct ice_rq_event_info *event);
 /**
@@ -134,5 +137,11 @@ static inline void ice_update_dcb_stats(struct ice_pf *pf) { }
 static inline void
 ice_dcb_process_lldp_set_mib_change(struct ice_pf *pf, struct ice_rq_event_info *event) { }
 static inline void ice_set_cgd_num(struct ice_tlan_ctx *tlan_ctx, u8 dcb_tc) { }
+static inline void
+ice_setup_dcb_qos_info(struct ice_pf *pf, struct iidc_rdma_qos_params *qos_info)
+{
+	qos_info->num_tc = 1;
+	qos_info->tc_info[0].rel_bw = 100;
+}
 #endif /* CONFIG_DCB */
 #endif /* _ICE_DCB_LIB_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 7c2dc347e4e5..46fbcd391a80 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3964,11 +3964,11 @@ static int ice_set_channels(struct net_device *dev, struct ethtool_channels *ch)
 		return -EINVAL;
 	}
 
-	if (pf->adev) {
+	if (pf->cdev_info && pf->cdev_info->adev) {
 		mutex_lock(&pf->adev_mutex);
-		device_lock(&pf->adev->dev);
+		device_lock(&pf->cdev_info->adev->dev);
 		locked = true;
-		if (pf->adev->dev.driver) {
+		if (pf->cdev_info->adev->dev.driver) {
 			netdev_err(dev, "Cannot change channels when RDMA is active\n");
 			ret = -EBUSY;
 			goto adev_unlock;
@@ -3987,7 +3987,7 @@ static int ice_set_channels(struct net_device *dev, struct ethtool_channels *ch)
 
 adev_unlock:
 	if (locked) {
-		device_unlock(&pf->adev->dev);
+		device_unlock(&pf->cdev_info->adev->dev);
 		mutex_unlock(&pf->adev_mutex);
 	}
 	return ret;
diff --git a/drivers/net/ethernet/intel/ice/ice_idc.c b/drivers/net/ethernet/intel/ice/ice_idc.c
index 0a19200000ad..bd7382f68e39 100644
--- a/drivers/net/ethernet/intel/ice/ice_idc.c
+++ b/drivers/net/ethernet/intel/ice/ice_idc.c
@@ -9,18 +9,20 @@
 static DEFINE_XARRAY_ALLOC1(ice_aux_id);
 
 /**
- * ice_get_auxiliary_drv - retrieve iidc_auxiliary_drv struct
- * @pf: pointer to PF struct
+ * ice_get_auxiliary_drv - retrieve iidc_rdma_core_auxiliary_drv struct
+ * @cdev: pointer to iidc_rdma_core_dev_info struct
  *
  * This function has to be called with a device_lock on the
- * pf->adev.dev to avoid race conditions.
+ * cdev->adev.dev to avoid race conditions.
+ *
+ * Return: pointer to the matched auxiliary driver struct
  */
-static
-struct iidc_rdma_core_auxiliary_drv *ice_get_auxiliary_drv(struct ice_pf *pf)
+static struct iidc_rdma_core_auxiliary_drv
+*ice_get_auxiliary_drv(struct iidc_rdma_core_dev_info *cdev)
 {
 	struct auxiliary_device *adev;
 
-	adev = pf->adev;
+	adev = cdev->adev;
 	if (!adev || !adev->dev.driver)
 		return NULL;
 
@@ -36,41 +38,51 @@ struct iidc_rdma_core_auxiliary_drv *ice_get_auxiliary_drv(struct ice_pf *pf)
 void ice_send_event_to_aux(struct ice_pf *pf, struct iidc_rdma_event *event)
 {
 	struct iidc_rdma_core_auxiliary_drv *iadrv;
+	struct iidc_rdma_core_dev_info *cdev;
 
 	if (WARN_ON_ONCE(!in_task()))
 		return;
 
+	cdev = pf->cdev_info;
+	if (!cdev)
+		return;
+
 	mutex_lock(&pf->adev_mutex);
-	if (!pf->adev)
+	if (!cdev->adev)
 		goto finish;
 
-	device_lock(&pf->adev->dev);
-	iadrv = ice_get_auxiliary_drv(pf);
+	device_lock(&cdev->adev->dev);
+	iadrv = ice_get_auxiliary_drv(cdev);
 	if (iadrv && iadrv->event_handler)
-		iadrv->event_handler(pf, event);
-	device_unlock(&pf->adev->dev);
+		iadrv->event_handler(cdev, event);
+	device_unlock(&cdev->adev->dev);
 finish:
 	mutex_unlock(&pf->adev_mutex);
 }
 
 /**
  * ice_add_rdma_qset - Add Leaf Node for RDMA Qset
- * @pf: PF struct
+ * @cdev: pointer to iidc_rdma_core_dev_info struct
  * @qset: Resource to be allocated
+ *
+ * Return: Zero on success or error code encountered
  */
-int ice_add_rdma_qset(struct ice_pf *pf, struct iidc_rdma_qset_params *qset)
+int ice_add_rdma_qset(struct iidc_rdma_core_dev_info *cdev,
+		      struct iidc_rdma_qset_params *qset)
 {
 	u16 max_rdmaqs[ICE_MAX_TRAFFIC_CLASS];
 	struct ice_vsi *vsi;
 	struct device *dev;
+	struct ice_pf *pf;
 	u32 qset_teid;
 	u16 qs_handle;
 	int status;
 	int i;
 
-	if (WARN_ON(!pf || !qset))
+	if (WARN_ON(!cdev || !qset))
 		return -EINVAL;
 
+	pf = pci_get_drvdata(cdev->pdev);
 	dev = ice_pf_to_dev(pf);
 
 	if (!ice_is_rdma_ena(pf))
@@ -101,7 +113,6 @@ int ice_add_rdma_qset(struct ice_pf *pf, struct iidc_rdma_qset_params *qset)
 		dev_err(dev, "Failed VSI RDMA Qset enable\n");
 		return status;
 	}
-	vsi->qset_handle[qset->tc] = qset->qs_handle;
 	qset->teid = qset_teid;
 
 	return 0;
@@ -110,18 +121,23 @@ EXPORT_SYMBOL_GPL(ice_add_rdma_qset);
 
 /**
  * ice_del_rdma_qset - Delete leaf node for RDMA Qset
- * @pf: PF struct
+ * @cdev: pointer to iidc_rdma_core_dev_info struct
  * @qset: Resource to be freed
+ *
+ * Return: Zero on success, error code on failure
  */
-int ice_del_rdma_qset(struct ice_pf *pf, struct iidc_rdma_qset_params *qset)
+int ice_del_rdma_qset(struct iidc_rdma_core_dev_info *cdev,
+		      struct iidc_rdma_qset_params *qset)
 {
 	struct ice_vsi *vsi;
+	struct ice_pf *pf;
 	u32 teid;
 	u16 q_id;
 
-	if (WARN_ON(!pf || !qset))
+	if (WARN_ON(!cdev || !qset))
 		return -EINVAL;
 
+	pf = pci_get_drvdata(cdev->pdev);
 	vsi = ice_find_vsi(pf, qset->vport_id);
 	if (!vsi) {
 		dev_err(ice_pf_to_dev(pf), "RDMA Invalid VSI\n");
@@ -131,36 +147,36 @@ int ice_del_rdma_qset(struct ice_pf *pf, struct iidc_rdma_qset_params *qset)
 	q_id = qset->qs_handle;
 	teid = qset->teid;
 
-	vsi->qset_handle[qset->tc] = 0;
-
 	return ice_dis_vsi_rdma_qset(vsi->port_info, 1, &teid, &q_id);
 }
 EXPORT_SYMBOL_GPL(ice_del_rdma_qset);
 
 /**
  * ice_rdma_request_reset - accept request from RDMA to perform a reset
- * @pf: struct for PF
+ * @cdev: pointer to iidc_rdma_core_dev_info struct
  * @reset_type: type of reset
+ *
+ * Return: Zero on success, error code on failure
  */
-int ice_rdma_request_reset(struct ice_pf *pf, enum iidc_rdma_reset_type reset_type)
+int ice_rdma_request_reset(struct iidc_rdma_core_dev_info *cdev,
+			   enum iidc_rdma_reset_type reset_type)
 {
 	enum ice_reset_req reset;
+	struct ice_pf *pf;
 
-	if (WARN_ON(!pf))
+	if (WARN_ON(!cdev))
 		return -EINVAL;
 
+	pf = pci_get_drvdata(cdev->pdev);
+
 	switch (reset_type) {
-	case IIDC_PFR:
+	case IIDC_FUNC_RESET:
 		reset = ICE_RESET_PFR;
 		break;
-	case IIDC_CORER:
+	case IIDC_DEV_RESET:
 		reset = ICE_RESET_CORER;
 		break;
-	case IIDC_GLOBR:
-		reset = ICE_RESET_GLOBR;
-		break;
 	default:
-		dev_err(ice_pf_to_dev(pf), "incorrect reset request\n");
 		return -EINVAL;
 	}
 
@@ -170,18 +186,23 @@ EXPORT_SYMBOL_GPL(ice_rdma_request_reset);
 
 /**
  * ice_rdma_update_vsi_filter - update main VSI filters for RDMA
- * @pf: pointer to struct for PF
+ * @cdev: pointer to iidc_rdma_core_dev_info struct
  * @vsi_id: VSI HW idx to update filter on
  * @enable: bool whether to enable or disable filters
+ *
+ * Return: Zero on success, error code on failure
  */
-int ice_rdma_update_vsi_filter(struct ice_pf *pf, u16 vsi_id, bool enable)
+int ice_rdma_update_vsi_filter(struct iidc_rdma_core_dev_info *cdev,
+			       u16 vsi_id, bool enable)
 {
 	struct ice_vsi *vsi;
+	struct ice_pf *pf;
 	int status;
 
-	if (WARN_ON(!pf))
+	if (WARN_ON(!cdev))
 		return -EINVAL;
 
+	pf = pci_get_drvdata(cdev->pdev);
 	vsi = ice_find_vsi(pf, vsi_id);
 	if (!vsi)
 		return -EINVAL;
@@ -202,37 +223,23 @@ int ice_rdma_update_vsi_filter(struct ice_pf *pf, u16 vsi_id, bool enable)
 EXPORT_SYMBOL_GPL(ice_rdma_update_vsi_filter);
 
 /**
- * ice_get_qos_params - parse QoS params for RDMA consumption
- * @pf: pointer to PF struct
- * @qos: set of QoS values
+ * ice_alloc_rdma_qvector - alloc vector resources reserved for RDMA driver
+ * @cdev: pointer to iidc_rdma_core_dev_info struct
+ * @entry: MSI-X entry to be removed
+ *
+ * Return: Zero on success, error code on failure
  */
-void ice_get_qos_params(struct ice_pf *pf, struct iidc_rdma_qos_params *qos)
+int ice_alloc_rdma_qvector(struct iidc_rdma_core_dev_info *cdev,
+			   struct msix_entry *entry)
 {
-	struct ice_dcbx_cfg *dcbx_cfg;
-	unsigned int i;
-	u32 up2tc;
-
-	dcbx_cfg = &pf->hw.port_info->qos_cfg.local_dcbx_cfg;
-	up2tc = rd32(&pf->hw, PRTDCB_TUP2TC);
-
-	qos->num_tc = ice_dcb_get_num_tc(dcbx_cfg);
-	for (i = 0; i < IIDC_MAX_USER_PRIORITY; i++)
-		qos->up2tc[i] = (up2tc >> (i * 3)) & 0x7;
-
-	for (i = 0; i < IEEE_8021QAZ_MAX_TCS; i++)
-		qos->tc_info[i].rel_bw = dcbx_cfg->etscfg.tcbwtable[i];
-
-	qos->pfc_mode = dcbx_cfg->pfc_mode;
-	if (qos->pfc_mode == IIDC_DSCP_PFC_MODE)
-		for (i = 0; i < DSCP_MAX; i++)
-			qos->dscp_map[i] = dcbx_cfg->dscp_map[i];
-}
-EXPORT_SYMBOL_GPL(ice_get_qos_params);
+	struct msi_map map;
+	struct ice_pf *pf;
 
-int ice_alloc_rdma_qvector(struct ice_pf *pf, struct msix_entry *entry)
-{
-	struct msi_map map = ice_alloc_irq(pf, true);
+	if (WARN_ON(!cdev))
+		return -EINVAL;
 
+	pf = pci_get_drvdata(cdev->pdev);
+	map = ice_alloc_irq(pf, true);
 	if (map.index < 0)
 		return -ENOMEM;
 
@@ -245,12 +252,19 @@ EXPORT_SYMBOL_GPL(ice_alloc_rdma_qvector);
 
 /**
  * ice_free_rdma_qvector - free vector resources reserved for RDMA driver
- * @pf: board private structure to initialize
+ * @cdev: pointer to iidc_rdma_core_dev_info struct
  * @entry: MSI-X entry to be removed
  */
-void ice_free_rdma_qvector(struct ice_pf *pf, struct msix_entry *entry)
+void ice_free_rdma_qvector(struct iidc_rdma_core_dev_info *cdev,
+			   struct msix_entry *entry)
 {
 	struct msi_map map;
+	struct ice_pf *pf;
+
+	if (WARN_ON(!cdev || !entry))
+		return;
+
+	pf = pci_get_drvdata(cdev->pdev);
 
 	map.index = entry->entry;
 	map.virq = entry->vector;
@@ -274,10 +288,13 @@ static void ice_adev_release(struct device *dev)
 /**
  * ice_plug_aux_dev - allocate and register AUX device
  * @pf: pointer to pf struct
+ *
+ * Return: Zero on success, error code on failure
  */
 int ice_plug_aux_dev(struct ice_pf *pf)
 {
 	struct iidc_rdma_core_auxiliary_dev *iadev;
+	struct iidc_rdma_core_dev_info *cdev;
 	struct auxiliary_device *adev;
 	int ret;
 
@@ -287,17 +304,22 @@ int ice_plug_aux_dev(struct ice_pf *pf)
 	if (!ice_is_rdma_ena(pf))
 		return 0;
 
+	cdev = pf->cdev_info;
+	if (!cdev)
+		return -ENODEV;
+
 	iadev = kzalloc(sizeof(*iadev), GFP_KERNEL);
 	if (!iadev)
 		return -ENOMEM;
 
 	adev = &iadev->adev;
-	iadev->pf = pf;
+	iadev->cdev_info = cdev;
 
 	adev->id = pf->aux_idx;
 	adev->dev.release = ice_adev_release;
 	adev->dev.parent = &pf->pdev->dev;
-	adev->name = pf->rdma_mode & IIDC_RDMA_PROTOCOL_ROCEV2 ? "roce" : "iwarp";
+	adev->name = cdev->rdma_protocol & IIDC_RDMA_PROTOCOL_ROCEV2 ?
+		"roce" : "iwarp";
 
 	ret = auxiliary_device_init(adev);
 	if (ret) {
@@ -312,7 +334,7 @@ int ice_plug_aux_dev(struct ice_pf *pf)
 	}
 
 	mutex_lock(&pf->adev_mutex);
-	pf->adev = adev;
+	cdev->adev = adev;
 	mutex_unlock(&pf->adev_mutex);
 
 	return 0;
@@ -326,8 +348,8 @@ void ice_unplug_aux_dev(struct ice_pf *pf)
 	struct auxiliary_device *adev;
 
 	mutex_lock(&pf->adev_mutex);
-	adev = pf->adev;
-	pf->adev = NULL;
+	adev = pf->cdev_info->adev;
+	pf->cdev_info->adev = NULL;
 	mutex_unlock(&pf->adev_mutex);
 
 	if (adev) {
@@ -342,7 +364,9 @@ void ice_unplug_aux_dev(struct ice_pf *pf)
  */
 int ice_init_rdma(struct ice_pf *pf)
 {
+	struct iidc_rdma_priv_dev_info *privd;
 	struct device *dev = &pf->pdev->dev;
+	struct iidc_rdma_core_dev_info *cdev;
 	int ret;
 
 	if (!ice_is_rdma_ena(pf)) {
@@ -350,22 +374,50 @@ int ice_init_rdma(struct ice_pf *pf)
 		return 0;
 	}
 
+	cdev = kzalloc(sizeof(*cdev), GFP_KERNEL);
+	if (!cdev)
+		return -ENOMEM;
+
+	pf->cdev_info = cdev;
+
+	privd = kzalloc(sizeof(*privd), GFP_KERNEL);
+	if (!privd) {
+		ret = -ENOMEM;
+		goto err_privd_alloc;
+	}
+
+	privd->pf_id = pf->hw.pf_id;
 	ret = xa_alloc(&ice_aux_id, &pf->aux_idx, NULL, XA_LIMIT(1, INT_MAX),
 		       GFP_KERNEL);
 	if (ret) {
 		dev_err(dev, "Failed to allocate device ID for AUX driver\n");
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto err_alloc_xa;
 	}
 
-	pf->rdma_mode |= IIDC_RDMA_PROTOCOL_ROCEV2;
+	cdev->iidc_priv = privd;
+	privd->netdev = pf->vsi[0]->netdev;
+
+	privd->hw_addr = (u8 __iomem *)pf->hw.hw_addr;
+	cdev->pdev = pf->pdev;
+	privd->vport_id = pf->vsi[0]->vsi_num;
+
+	pf->cdev_info->rdma_protocol |= IIDC_RDMA_PROTOCOL_ROCEV2;
+	ice_setup_dcb_qos_info(pf, &privd->qos_info);
 	ret = ice_plug_aux_dev(pf);
 	if (ret)
 		goto err_plug_aux_dev;
 	return 0;
 
 err_plug_aux_dev:
-	pf->adev = NULL;
+	pf->cdev_info->adev = NULL;
 	xa_erase(&ice_aux_id, pf->aux_idx);
+err_alloc_xa:
+	kfree(privd);
+err_privd_alloc:
+	kfree(cdev);
+	pf->cdev_info = NULL;
+
 	return ret;
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 6a20f9f2e608..eace0e3f15e8 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -9310,6 +9310,7 @@ ice_setup_tc(struct net_device *netdev, enum tc_setup_type type,
 	     void *type_data)
 {
 	struct ice_netdev_priv *np = netdev_priv(netdev);
+	struct iidc_rdma_core_dev_info *cdev;
 	struct ice_pf *pf = np->vsi->back;
 	bool locked = false;
 	int err;
@@ -9326,11 +9327,12 @@ ice_setup_tc(struct net_device *netdev, enum tc_setup_type type,
 			return -EOPNOTSUPP;
 		}
 
-		if (pf->adev) {
+		cdev = pf->cdev_info;
+		if (cdev && cdev->adev) {
 			mutex_lock(&pf->adev_mutex);
-			device_lock(&pf->adev->dev);
+			device_lock(&cdev->adev->dev);
 			locked = true;
-			if (pf->adev->dev.driver) {
+			if (cdev->adev->dev.driver) {
 				netdev_err(netdev, "Cannot change qdisc when RDMA is active\n");
 				err = -EBUSY;
 				goto adev_unlock;
@@ -9344,7 +9346,7 @@ ice_setup_tc(struct net_device *netdev, enum tc_setup_type type,
 
 adev_unlock:
 		if (locked) {
-			device_unlock(&pf->adev->dev);
+			device_unlock(&cdev->adev->dev);
 			mutex_unlock(&pf->adev_mutex);
 		}
 		return err;
diff --git a/include/linux/net/intel/iidc_rdma.h b/include/linux/net/intel/iidc_rdma.h
index 7f1910289534..1e132a67cb66 100644
--- a/include/linux/net/intel/iidc_rdma.h
+++ b/include/linux/net/intel/iidc_rdma.h
@@ -5,7 +5,6 @@
 #define _IIDC_RDMA_H_
 
 #include <linux/auxiliary_bus.h>
-#include <linux/dcbnl.h>
 #include <linux/device.h>
 #include <linux/if_ether.h>
 #include <linux/kernel.h>
@@ -17,14 +16,19 @@ enum iidc_rdma_event_type {
 	IIDC_RDMA_EVENT_AFTER_MTU_CHANGE,
 	IIDC_RDMA_EVENT_BEFORE_TC_CHANGE,
 	IIDC_RDMA_EVENT_AFTER_TC_CHANGE,
+	IIDC_RDMA_EVENT_WARN_RESET,
 	IIDC_RDMA_EVENT_CRIT_ERR,
 	IIDC_RDMA_EVENT_NBITS		/* must be last */
 };
 
+struct iidc_rdma_event {
+	DECLARE_BITMAP(type, IIDC_RDMA_EVENT_NBITS);
+	u32 reg;
+};
+
 enum iidc_rdma_reset_type {
-	IIDC_PFR,
-	IIDC_CORER,
-	IIDC_GLOBR,
+	IIDC_FUNC_RESET,
+	IIDC_DEV_RESET,
 };
 
 enum iidc_rdma_protocol {
@@ -32,53 +36,22 @@ enum iidc_rdma_protocol {
 	IIDC_RDMA_PROTOCOL_ROCEV2 = BIT(1),
 };
 
-#define IIDC_MAX_USER_PRIORITY		8
-#define IIDC_DSCP_PFC_MODE		0x1
-
-/* Struct to hold per RDMA Qset info */
-struct iidc_rdma_qset_params {
-	/* Qset TEID returned to the RDMA driver in
-	 * ice_add_rdma_qset and used by RDMA driver
-	 * for calls to ice_del_rdma_qset
-	 */
-	u32 teid;	/* Qset TEID */
-	u16 qs_handle; /* RDMA driver provides this */
-	u16 vport_id; /* VSI index */
-	u8 tc; /* TC branch the Qset should belong to */
-};
-
-struct iidc_rdma_qos_info {
-	u64 tc_ctx;
-	u8 rel_bw;
-	u8 prio_type;
-	u8 egress_virt_up;
-	u8 ingress_virt_up;
-};
-
-/* Struct to pass QoS info */
-struct iidc_rdma_qos_params {
-	struct iidc_rdma_qos_info tc_info[IEEE_8021QAZ_MAX_TCS];
-	u8 up2tc[IIDC_MAX_USER_PRIORITY];
-	u8 vport_relative_bw;
-	u8 vport_priority_type;
-	u8 num_tc;
-	u8 pfc_mode;
-	u8 dscp_map[DSCP_MAX];
-};
-
-struct iidc_rdma_event {
-	DECLARE_BITMAP(type, IIDC_RDMA_EVENT_NBITS);
-	u32 reg;
-};
+/* Structure to be populated by core LAN PCI driver */
+struct iidc_rdma_core_dev_info {
+	struct pci_dev *pdev; /* PCI device of corresponding to main function */
+	struct auxiliary_device *adev;
+	/* Current active RDMA protocol */
+	enum iidc_rdma_protocol rdma_protocol;
+	void *iidc_priv; /* elements unique to each driver */
+ };
 
 /* Structure representing auxiliary driver tailored information about the core
  * PCI dev, each auxiliary driver using the IIDC interface will have an
  * instance of this struct dedicated to it.
  */
-
 struct iidc_rdma_core_auxiliary_dev {
 	struct auxiliary_device adev;
-	struct ice_pf *pf;
+	struct iidc_rdma_core_dev_info *cdev_info;
 };
 
 /* structure representing the auxiliary driver. This struct is to be
@@ -88,12 +61,8 @@ struct iidc_rdma_core_auxiliary_dev {
  */
 struct iidc_rdma_core_auxiliary_drv {
 	struct auxiliary_driver adrv;
-	/* This event_handler is meant to be a blocking call.  For instance,
-	 * when a BEFORE_MTU_CHANGE event comes in, the event_handler will not
-	 * return until the auxiliary driver is ready for the MTU change to
-	 * happen.
-	 */
-	void (*event_handler)(struct ice_pf *pf, struct iidc_rdma_event *event);
+	void (*event_handler)(struct iidc_rdma_core_dev_info *cdev,
+			      struct iidc_rdma_event *event);
 };
 
 #endif /* _IIDC_RDMA_H_*/
diff --git a/include/linux/net/intel/iidc_rdma_ice.h b/include/linux/net/intel/iidc_rdma_ice.h
index 78d10003d776..b40eed0e13fe 100644
--- a/include/linux/net/intel/iidc_rdma_ice.h
+++ b/include/linux/net/intel/iidc_rdma_ice.h
@@ -4,16 +4,67 @@
 #ifndef _IIDC_RDMA_ICE_H_
 #define _IIDC_RDMA_ICE_H_
 
-struct ice_pf;
+#include <linux/dcbnl.h>
 
-int ice_add_rdma_qset(struct ice_pf *pf, struct iidc_rdma_qset_params *qset);
-int ice_del_rdma_qset(struct ice_pf *pf, struct iidc_rdma_qset_params *qset);
-int ice_rdma_request_reset(struct ice_pf *pf,
+#define IIDC_MAX_USER_PRIORITY         8
+#define IIDC_DSCP_PFC_MODE             0x1
+
+/**
+ * struct iidc_rdma_qset_params - Struct to hold per RDMA Qset info
+ * @teid: TEID of the Qset node
+ * @qs_handle: SW index of the Qset, RDMA provides this
+ * @vport_id: VSI index
+ * @tc: Traffic Class branch the QSet should belong to
+ */
+struct iidc_rdma_qset_params {
+	/* Qset TEID returned to the RDMA driver in
+	 * ice_add_rdma_qset and used by RDMA driver
+	 * for calls to ice_del_rdma_qset
+	 */
+	u32 teid;
+	u16 qs_handle;
+	u16 vport_id;
+	u8 tc;
+};
+
+struct iidc_rdma_qos_info {
+	u64 tc_ctx;
+	u8 rel_bw;
+	u8 prio_type;
+	u8 egress_virt_up;
+	u8 ingress_virt_up;
+};
+
+/* Struct to pass QoS info */
+struct iidc_rdma_qos_params {
+	struct iidc_rdma_qos_info tc_info[IEEE_8021QAZ_MAX_TCS];
+	u8 up2tc[IIDC_MAX_USER_PRIORITY];
+	u8 vport_relative_bw;
+	u8 vport_priority_type;
+	u8 num_tc;
+	u8 pfc_mode;
+	u8 dscp_map[DSCP_MAX];
+};
+
+struct iidc_rdma_priv_dev_info {
+	u8 pf_id;
+	u16 vport_id;
+	struct net_device *netdev;
+	struct iidc_rdma_qos_params qos_info;
+	u8 __iomem *hw_addr;
+};
+
+int ice_add_rdma_qset(struct iidc_rdma_core_dev_info *cdev,
+		      struct iidc_rdma_qset_params *qset);
+int ice_del_rdma_qset(struct iidc_rdma_core_dev_info *cdev,
+		      struct iidc_rdma_qset_params *qset);
+int ice_rdma_request_reset(struct iidc_rdma_core_dev_info *cdev,
 			   enum iidc_rdma_reset_type reset_type);
-int ice_rdma_update_vsi_filter(struct ice_pf *pf, u16 vsi_id, bool enable);
-void ice_get_qos_params(struct ice_pf *pf,
-			struct iidc_rdma_qos_params *qos);
-int ice_alloc_rdma_qvector(struct ice_pf *pf, struct msix_entry *entry);
-void ice_free_rdma_qvector(struct ice_pf *pf, struct msix_entry *entry);
+int ice_rdma_update_vsi_filter(struct iidc_rdma_core_dev_info *cdev, u16 vsi_id,
+			       bool enable);
+int ice_alloc_rdma_qvector(struct iidc_rdma_core_dev_info *cdev,
+			   struct msix_entry *entry);
+void ice_free_rdma_qvector(struct iidc_rdma_core_dev_info *cdev,
+			   struct msix_entry *entry);
 
 #endif /* _IIDC_RDMA_ICE_H_*/
-- 
2.37.3


