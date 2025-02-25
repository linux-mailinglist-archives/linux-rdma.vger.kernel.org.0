Return-Path: <linux-rdma+bounces-8057-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEACFA43471
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2025 06:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6D29189E915
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2025 05:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A856255E3C;
	Tue, 25 Feb 2025 05:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YjYSncax"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BCA254878;
	Tue, 25 Feb 2025 05:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740459939; cv=none; b=JAoyJsjeirUflcAET9g3nqk6gv7bTg5NaJQjA7OdfleiDCcDFg8pd/K9ipQdSES9tSj72GSmXfP/l/7uHKcUt0JxM1DcsHIP1x7XvoSZp15lT91PbWnrp6sXQcooL5J/NzKPbqEqJz1Np26o2wP19pFml2iFTHZooTd+Kumu89c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740459939; c=relaxed/simple;
	bh=OPfPk6Gs8430B0a/BvCpZbiuFDamnc8BPTDz6Hq+suI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SibFj9hi9Rfb5SejSOzHrl3U6MKMmgbWRbZpvovS9ufss855yYc0tM3B86KoczWvXjsp93CrO8H1iDFI2HW6QonJwsNwF78cnVVp+UL03eCNXhXO3W7PlQ8vxQjiMiR4b/k31/1TtL5p3RtGNpNDLZr63ULPFCEZ/ihZ9ETAHxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YjYSncax; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740459936; x=1771995936;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OPfPk6Gs8430B0a/BvCpZbiuFDamnc8BPTDz6Hq+suI=;
  b=YjYSncaxMuqN7B5SbmYhjeD+xjcY2eDleJfj7EJWdUyiuBLFnG5/GNRJ
   c7DhvKKRk0igLOXIrr7xpayLxPZJboEJ64aZEcIHA7i5gMeXySHeWfyvF
   sC+SXWuJ7PCbbhDNE1v/mxVepKx5fGCe3NAQjLefejaMZOwwvUyVSrEge
   R0mDcMHohBbEupRTl22T1zxjPBIe4D1VBvAO4QHnucvNjoPJ0/f/WZ+Y7
   si7A6YaseASEYGRAUkXi8lPmHGbF24EUpXZ2KG1LkJc3Uk7DwfluE6iVu
   e/yWL6sDT3MQWCPGcCMlEt5iI5PNm02smP/gvXPP088hf4tnz7Xh9lSBi
   w==;
X-CSE-ConnectionGUID: WGl4213tRp61b609eTRRmw==
X-CSE-MsgGUID: B/iLOKuCTLeXTzf3Bh1ITQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="44075730"
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="44075730"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 21:05:34 -0800
X-CSE-ConnectionGUID: FTD6erq0SMquCNigU1Aktw==
X-CSE-MsgGUID: A1A6p+JMSZCveLVlTj/YqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="116773609"
Received: from tenikolo-mobl1.amr.corp.intel.com ([10.246.115.109])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 21:05:33 -0800
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org,
	intel-wired-lan@lists.osuosl.org
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	david.m.ertman@intel.com,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [iwl-next v4 1/1] iidc/ice/irdma: Update IDC to support multiple consumers
Date: Mon, 24 Feb 2025 23:04:28 -0600
Message-Id: <20250225050428.2166-2-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20250225050428.2166-1-tatyana.e.nikolova@intel.com>
References: <20250225050428.2166-1-tatyana.e.nikolova@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Ertman <david.m.ertman@intel.com>

To support RDMA for E2000 product, the idpf driver will use the IDC
interface with the irdma auxiliary driver, thus becoming a second
consumer of it. This requires the IDC be updated to support multiple
consumers. The use of exported symbols no longer makes sense because it
will require all core drivers (ice/idpf) that can interface with irdma
auxiliary driver to be loaded even if hardware is not present for those
drivers.

To address this, implement an ops struct that will be universal set of
naked function pointers that will be populated by each core driver for
the irdma auxiliary driver to call.

Also previously, the ice driver was just exporting its entire PF struct
to the auxiliary driver, but since each core driver will have its own
different PF struct, implement a universal struct that all core drivers
can export to the auxiliary driver through the probe call.

The iidc.h header file will be divided into two files.  The first,
idc_rdma.h, will host all of the generic header info that will be needed
for RDMA support in the auxiliary device.  The second, iidc_rdma.h, will
contain specific elements used by Intel drivers to support RDMA.  This
will be primarily the implementation of a new struct that will be
assigned under the new generic opaque element of idc_priv in the
idc_core_dev_info struct.

Update ice and irdma to conform with the new IIDC interface definitions.

Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
Co-developed-by: Mustafa Ismail <mustafa.ismail@intel.com>
Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
Co-developed-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 drivers/infiniband/hw/irdma/main.c            | 110 ++++----
 drivers/infiniband/hw/irdma/main.h            |   3 +-
 drivers/infiniband/hw/irdma/osdep.h           |   4 +-
 .../net/ethernet/intel/ice/devlink/devlink.c  |  40 ++-
 drivers/net/ethernet/intel/ice/ice.h          |   6 +-
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |  46 +++-
 drivers/net/ethernet/intel/ice/ice_dcb_lib.h  |   4 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |   8 +-
 drivers/net/ethernet/intel/ice/ice_idc.c      | 255 +++++++++++-------
 drivers/net/ethernet/intel/ice/ice_idc_int.h  |   5 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |  18 +-
 include/linux/net/intel/idc_rdma.h            | 138 ++++++++++
 include/linux/net/intel/iidc.h                | 107 --------
 include/linux/net/intel/iidc_rdma.h           |  67 +++++
 14 files changed, 527 insertions(+), 284 deletions(-)
 create mode 100644 include/linux/net/intel/idc_rdma.h
 delete mode 100644 include/linux/net/intel/iidc.h
 create mode 100644 include/linux/net/intel/iidc_rdma.h

diff --git a/drivers/infiniband/hw/irdma/main.c b/drivers/infiniband/hw/irdma/main.c
index 3f13200ff71b..9b6f1d8bf06a 100644
--- a/drivers/infiniband/hw/irdma/main.c
+++ b/drivers/infiniband/hw/irdma/main.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /* Copyright (c) 2015 - 2021 Intel Corporation */
 #include "main.h"
-#include "../../../net/ethernet/intel/ice/ice.h"
 
 MODULE_ALIAS("i40iw");
 MODULE_AUTHOR("Intel Corporation, <e1000-rdma@lists.sourceforge.net>");
@@ -61,7 +60,7 @@ static void irdma_log_invalid_mtu(u16 mtu, struct irdma_sc_dev *dev)
 }
 
 static void irdma_fill_qos_info(struct irdma_l2params *l2params,
-				struct iidc_qos_params *qos_info)
+				struct iidc_rdma_qos_params *qos_info)
 {
 	int i;
 
@@ -85,12 +84,13 @@ static void irdma_fill_qos_info(struct irdma_l2params *l2params,
 	}
 }
 
-static void irdma_iidc_event_handler(struct ice_pf *pf, struct iidc_event *event)
+static void irdma_idc_event_handler(struct idc_rdma_core_dev_info *cdev_info,
+				    struct idc_rdma_event *event)
 {
-	struct irdma_device *iwdev = dev_get_drvdata(&pf->adev->dev);
+	struct irdma_device *iwdev = dev_get_drvdata(&cdev_info->adev->dev);
 	struct irdma_l2params l2params = {};
 
-	if (*event->type & BIT(IIDC_EVENT_AFTER_MTU_CHANGE)) {
+	if (*event->type & BIT(IDC_RDMA_EVENT_AFTER_MTU_CHANGE)) {
 		ibdev_dbg(&iwdev->ibdev, "CLNT: new MTU = %d\n", iwdev->netdev->mtu);
 		if (iwdev->vsi.mtu != iwdev->netdev->mtu) {
 			l2params.mtu = iwdev->netdev->mtu;
@@ -98,25 +98,26 @@ static void irdma_iidc_event_handler(struct ice_pf *pf, struct iidc_event *event
 			irdma_log_invalid_mtu(l2params.mtu, &iwdev->rf->sc_dev);
 			irdma_change_l2params(&iwdev->vsi, &l2params);
 		}
-	} else if (*event->type & BIT(IIDC_EVENT_BEFORE_TC_CHANGE)) {
+	} else if (*event->type & BIT(IDC_RDMA_EVENT_BEFORE_TC_CHANGE)) {
 		if (iwdev->vsi.tc_change_pending)
 			return;
 
 		irdma_prep_tc_change(iwdev);
-	} else if (*event->type & BIT(IIDC_EVENT_AFTER_TC_CHANGE)) {
-		struct iidc_qos_params qos_info = {};
+	} else if (*event->type & BIT(IDC_RDMA_EVENT_AFTER_TC_CHANGE)) {
+		struct iidc_rdma_priv_dev_info *idc_priv = cdev_info->idc_priv;
 
 		if (!iwdev->vsi.tc_change_pending)
 			return;
 
 		l2params.tc_changed = true;
 		ibdev_dbg(&iwdev->ibdev, "CLNT: TC Change\n");
-		ice_get_qos_params(pf, &qos_info);
-		irdma_fill_qos_info(&l2params, &qos_info);
+
+		irdma_fill_qos_info(&l2params, &idc_priv->qos_info);
 		if (iwdev->rf->protocol_used != IRDMA_IWARP_PROTOCOL_ONLY)
-			iwdev->dcb_vlan_mode = qos_info.num_tc > 1 && !l2params.dscp_mode;
+			iwdev->dcb_vlan_mode =
+				l2params.num_tc > 1 && !l2params.dscp_mode;
 		irdma_change_l2params(&iwdev->vsi, &l2params);
-	} else if (*event->type & BIT(IIDC_EVENT_CRIT_ERR)) {
+	} else if (*event->type & BIT(IDC_RDMA_EVENT_CRIT_ERR)) {
 		ibdev_warn(&iwdev->ibdev, "ICE OICR event notification: oicr = 0x%08x\n",
 			   event->reg);
 		if (event->reg & IRDMAPFINT_OICR_PE_CRITERR_M) {
@@ -151,10 +152,10 @@ static void irdma_iidc_event_handler(struct ice_pf *pf, struct iidc_event *event
  */
 static void irdma_request_reset(struct irdma_pci_f *rf)
 {
-	struct ice_pf *pf = rf->cdev;
+	struct idc_rdma_core_dev_info *cdev_info = rf->cdev;
 
 	ibdev_warn(&rf->iwdev->ibdev, "Requesting a reset\n");
-	ice_rdma_request_reset(pf, IIDC_PFR);
+	cdev_info->ops->request_reset(rf->cdev, IDC_FUNC_RESET);
 }
 
 /**
@@ -166,14 +167,15 @@ static int irdma_lan_register_qset(struct irdma_sc_vsi *vsi,
 				   struct irdma_ws_node *tc_node)
 {
 	struct irdma_device *iwdev = vsi->back_vsi;
-	struct ice_pf *pf = iwdev->rf->cdev;
+	struct idc_rdma_core_dev_info *cdev_info = iwdev->rf->cdev;
+	struct iidc_rdma_priv_dev_info *idc_priv = cdev_info->idc_priv;
 	struct iidc_rdma_qset_params qset = {};
 	int ret;
 
 	qset.qs_handle = tc_node->qs_handle;
 	qset.tc = tc_node->traffic_class;
 	qset.vport_id = vsi->vsi_idx;
-	ret = ice_add_rdma_qset(pf, &qset);
+	ret = idc_priv->priv_ops->alloc_res(cdev_info, &qset);
 	if (ret) {
 		ibdev_dbg(&iwdev->ibdev, "WS: LAN alloc_res for rdma qset failed.\n");
 		return ret;
@@ -194,7 +196,8 @@ static void irdma_lan_unregister_qset(struct irdma_sc_vsi *vsi,
 				      struct irdma_ws_node *tc_node)
 {
 	struct irdma_device *iwdev = vsi->back_vsi;
-	struct ice_pf *pf = iwdev->rf->cdev;
+	struct idc_rdma_core_dev_info *cdev_info = iwdev->rf->cdev;
+	struct iidc_rdma_priv_dev_info *idc_priv = cdev_info->idc_priv;
 	struct iidc_rdma_qset_params qset = {};
 
 	qset.qs_handle = tc_node->qs_handle;
@@ -202,40 +205,48 @@ static void irdma_lan_unregister_qset(struct irdma_sc_vsi *vsi,
 	qset.vport_id = vsi->vsi_idx;
 	qset.teid = tc_node->l2_sched_node_id;
 
-	if (ice_del_rdma_qset(pf, &qset))
+	if (idc_priv->priv_ops->free_res(cdev_info, &qset))
 		ibdev_dbg(&iwdev->ibdev, "WS: LAN free_res for rdma qset failed.\n");
 }
 
 static void irdma_remove(struct auxiliary_device *aux_dev)
 {
-	struct iidc_auxiliary_dev *iidc_adev = container_of(aux_dev,
-							    struct iidc_auxiliary_dev,
-							    adev);
-	struct ice_pf *pf = iidc_adev->pf;
+	struct idc_rdma_core_auxiliary_dev *idc_adev =
+		container_of(aux_dev, struct idc_rdma_core_auxiliary_dev, adev);
+	struct idc_rdma_core_dev_info *cdev_info = idc_adev->cdev_info;
+	struct iidc_rdma_priv_dev_info *idc_priv = cdev_info->idc_priv;
 	struct irdma_device *iwdev = auxiliary_get_drvdata(aux_dev);
 
+	idc_priv->priv_ops->update_vport_filter(cdev_info,
+						iwdev->vsi_num, false);
 	irdma_ib_unregister_device(iwdev);
-	ice_rdma_update_vsi_filter(pf, iwdev->vsi_num, false);
 
-	pr_debug("INIT: Gen2 PF[%d] device remove success\n", PCI_FUNC(pf->pdev->devfn));
+	pr_debug("INIT: Gen2 PF[%d] device remove success\n", PCI_FUNC(cdev_info->pdev->devfn));
 }
 
-static void irdma_fill_device_info(struct irdma_device *iwdev, struct ice_pf *pf,
-				   struct ice_vsi *vsi)
+static void irdma_fill_device_info(struct irdma_device *iwdev,
+				   struct idc_rdma_core_dev_info *cdev_info)
 {
+	struct iidc_rdma_priv_dev_info *idc_priv = cdev_info->idc_priv;
 	struct irdma_pci_f *rf = iwdev->rf;
 
-	rf->cdev = pf;
+	rf->sc_dev.hw = &rf->hw;
+	rf->iwdev = iwdev;
+	rf->cdev = cdev_info;
+	rf->hw.hw_addr = idc_priv->hw_addr;
+	rf->pcidev = cdev_info->pdev;
+	rf->hw.device = &rf->pcidev->dev;
+	rf->msix_count = cdev_info->msix_count;
+	rf->pf_id = idc_priv->pf_id;
+	rf->msix_entries = cdev_info->msix_entries;
+
 	rf->gen_ops.register_qset = irdma_lan_register_qset;
 	rf->gen_ops.unregister_qset = irdma_lan_unregister_qset;
-	rf->hw.hw_addr = pf->hw.hw_addr;
-	rf->pcidev = pf->pdev;
-	rf->msix_count =  pf->num_rdma_msix;
-	rf->pf_id = pf->hw.pf_id;
-	rf->msix_entries = &pf->msix_entries[pf->rdma_base_vector];
-	rf->default_vsi.vsi_idx = vsi->vsi_num;
-	rf->protocol_used = pf->rdma_mode & IIDC_RDMA_PROTOCOL_ROCEV2 ?
-			    IRDMA_ROCE_PROTOCOL_ONLY : IRDMA_IWARP_PROTOCOL_ONLY;
+
+	rf->default_vsi.vsi_idx = idc_priv->vport_id;
+	rf->protocol_used =
+		cdev_info->rdma_protocol == IDC_RDMA_PROTOCOL_ROCEV2 ?
+			IRDMA_ROCE_PROTOCOL_ONLY : IRDMA_IWARP_PROTOCOL_ONLY;
 	rf->rdma_ver = IRDMA_GEN_2;
 	rf->rsrc_profile = IRDMA_HMC_PROFILE_DEFAULT;
 	rf->rst_to = IRDMA_RST_TIMEOUT_HZ;
@@ -243,8 +254,9 @@ static void irdma_fill_device_info(struct irdma_device *iwdev, struct ice_pf *pf
 	rf->limits_sel = 7;
 	rf->iwdev = iwdev;
 	mutex_init(&iwdev->ah_tbl_lock);
-	iwdev->netdev = vsi->netdev;
-	iwdev->vsi_num = vsi->vsi_num;
+
+	iwdev->netdev = idc_priv->netdev;
+	iwdev->vsi_num = idc_priv->vport_id;
 	iwdev->init_state = INITIAL_STATE;
 	iwdev->roce_cwnd = IRDMA_ROCE_CWND_DEFAULT;
 	iwdev->roce_ackcreds = IRDMA_ROCE_ACKCREDS_DEFAULT;
@@ -256,19 +268,15 @@ static void irdma_fill_device_info(struct irdma_device *iwdev, struct ice_pf *pf
 
 static int irdma_probe(struct auxiliary_device *aux_dev, const struct auxiliary_device_id *id)
 {
-	struct iidc_auxiliary_dev *iidc_adev = container_of(aux_dev,
-							    struct iidc_auxiliary_dev,
-							    adev);
-	struct ice_pf *pf = iidc_adev->pf;
-	struct ice_vsi *vsi = ice_get_main_vsi(pf);
-	struct iidc_qos_params qos_info = {};
+	struct idc_rdma_core_auxiliary_dev *idc_adev =
+		container_of(aux_dev, struct idc_rdma_core_auxiliary_dev, adev);
+	struct idc_rdma_core_dev_info *cdev_info = idc_adev->cdev_info;
+	struct iidc_rdma_priv_dev_info *idc_priv = cdev_info->idc_priv;
 	struct irdma_device *iwdev;
 	struct irdma_pci_f *rf;
 	struct irdma_l2params l2params = {};
 	int err;
 
-	if (!vsi)
-		return -EIO;
 	iwdev = ib_alloc_device(irdma_device, ibdev);
 	if (!iwdev)
 		return -ENOMEM;
@@ -278,7 +286,7 @@ static int irdma_probe(struct auxiliary_device *aux_dev, const struct auxiliary_
 		return -ENOMEM;
 	}
 
-	irdma_fill_device_info(iwdev, pf, vsi);
+	irdma_fill_device_info(iwdev, cdev_info);
 	rf = iwdev->rf;
 
 	err = irdma_ctrl_init_hw(rf);
@@ -286,8 +294,7 @@ static int irdma_probe(struct auxiliary_device *aux_dev, const struct auxiliary_
 		goto err_ctrl_init;
 
 	l2params.mtu = iwdev->netdev->mtu;
-	ice_get_qos_params(pf, &qos_info);
-	irdma_fill_qos_info(&l2params, &qos_info);
+	irdma_fill_qos_info(&l2params, &idc_priv->qos_info);
 	if (iwdev->rf->protocol_used != IRDMA_IWARP_PROTOCOL_ONLY)
 		iwdev->dcb_vlan_mode = l2params.num_tc > 1 && !l2params.dscp_mode;
 
@@ -299,7 +306,8 @@ static int irdma_probe(struct auxiliary_device *aux_dev, const struct auxiliary_
 	if (err)
 		goto err_ibreg;
 
-	ice_rdma_update_vsi_filter(pf, iwdev->vsi_num, true);
+	idc_priv->priv_ops->update_vport_filter(cdev_info, iwdev->vsi_num,
+						true);
 
 	ibdev_dbg(&iwdev->ibdev, "INIT: Gen2 PF[%d] device probe success\n", PCI_FUNC(rf->pcidev->devfn));
 	auxiliary_set_drvdata(aux_dev, iwdev);
@@ -325,13 +333,13 @@ static const struct auxiliary_device_id irdma_auxiliary_id_table[] = {
 
 MODULE_DEVICE_TABLE(auxiliary, irdma_auxiliary_id_table);
 
-static struct iidc_auxiliary_drv irdma_auxiliary_drv = {
+static struct idc_rdma_core_auxiliary_drv irdma_auxiliary_drv = {
 	.adrv = {
 	    .id_table = irdma_auxiliary_id_table,
 	    .probe = irdma_probe,
 	    .remove = irdma_remove,
 	},
-	.event_handler = irdma_iidc_event_handler,
+	.event_handler = irdma_idc_event_handler,
 };
 
 static int __init irdma_init_module(void)
diff --git a/drivers/infiniband/hw/irdma/main.h b/drivers/infiniband/hw/irdma/main.h
index 9f0ed6e84471..e81f37583138 100644
--- a/drivers/infiniband/hw/irdma/main.h
+++ b/drivers/infiniband/hw/irdma/main.h
@@ -29,7 +29,8 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #endif
 #include <linux/auxiliary_bus.h>
-#include <linux/net/intel/iidc.h>
+#include <linux/net/intel/idc_rdma.h>
+#include <linux/net/intel/iidc_rdma.h>
 #include <crypto/hash.h>
 #include <rdma/ib_smi.h>
 #include <rdma/ib_verbs.h>
diff --git a/drivers/infiniband/hw/irdma/osdep.h b/drivers/infiniband/hw/irdma/osdep.h
index ddf02a462efa..ed07553f344d 100644
--- a/drivers/infiniband/hw/irdma/osdep.h
+++ b/drivers/infiniband/hw/irdma/osdep.h
@@ -5,7 +5,9 @@
 
 #include <linux/pci.h>
 #include <linux/bitfield.h>
-#include <linux/net/intel/iidc.h>
+#include <linux/net/intel/idc_rdma.h>
+#include <linux/net/intel/iidc_rdma.h>
+
 #include <crypto/hash.h>
 #include <rdma/ib_verbs.h>
 
diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index d116e2b10bce..d4d369072127 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
@@ -1314,8 +1314,13 @@ ice_devlink_enable_roce_get(struct devlink *devlink, u32 id,
 			    struct devlink_param_gset_ctx *ctx)
 {
 	struct ice_pf *pf = devlink_priv(devlink);
+	struct idc_rdma_core_dev_info *cdev;
 
-	ctx->val.vbool = pf->rdma_mode & IIDC_RDMA_PROTOCOL_ROCEV2 ? true : false;
+	cdev = pf->cdev_info;
+	if (!cdev)
+		return -ENODEV;
+
+	ctx->val.vbool = !!(cdev->rdma_protocol & IDC_RDMA_PROTOCOL_ROCEV2);
 
 	return 0;
 }
@@ -1325,19 +1330,24 @@ static int ice_devlink_enable_roce_set(struct devlink *devlink, u32 id,
 				       struct netlink_ext_ack *extack)
 {
 	struct ice_pf *pf = devlink_priv(devlink);
+	struct idc_rdma_core_dev_info *cdev;
 	bool roce_ena = ctx->val.vbool;
 	int ret;
 
+	cdev = pf->cdev_info;
+	if (!cdev)
+		return -ENODEV;
+
 	if (!roce_ena) {
 		ice_unplug_aux_dev(pf);
-		pf->rdma_mode &= ~IIDC_RDMA_PROTOCOL_ROCEV2;
+		cdev->rdma_protocol &= ~IDC_RDMA_PROTOCOL_ROCEV2;
 		return 0;
 	}
 
-	pf->rdma_mode |= IIDC_RDMA_PROTOCOL_ROCEV2;
+	cdev->rdma_protocol |= IDC_RDMA_PROTOCOL_ROCEV2;
 	ret = ice_plug_aux_dev(pf);
 	if (ret)
-		pf->rdma_mode &= ~IIDC_RDMA_PROTOCOL_ROCEV2;
+		cdev->rdma_protocol &= ~IDC_RDMA_PROTOCOL_ROCEV2;
 
 	return ret;
 }
@@ -1348,11 +1358,16 @@ ice_devlink_enable_roce_validate(struct devlink *devlink, u32 id,
 				 struct netlink_ext_ack *extack)
 {
 	struct ice_pf *pf = devlink_priv(devlink);
+	struct idc_rdma_core_dev_info *cdev;
+
+	cdev = pf->cdev_info;
+	if (!cdev)
+		return -ENODEV;
 
 	if (!test_bit(ICE_FLAG_RDMA_ENA, pf->flags))
 		return -EOPNOTSUPP;
 
-	if (pf->rdma_mode & IIDC_RDMA_PROTOCOL_IWARP) {
+	if (cdev->rdma_protocol & IDC_RDMA_PROTOCOL_IWARP) {
 		NL_SET_ERR_MSG_MOD(extack, "iWARP is currently enabled. This device cannot enable iWARP and RoCEv2 simultaneously");
 		return -EOPNOTSUPP;
 	}
@@ -1366,7 +1381,8 @@ ice_devlink_enable_iw_get(struct devlink *devlink, u32 id,
 {
 	struct ice_pf *pf = devlink_priv(devlink);
 
-	ctx->val.vbool = pf->rdma_mode & IIDC_RDMA_PROTOCOL_IWARP;
+	ctx->val.vbool = pf->cdev_info->rdma_protocol &
+			 IDC_RDMA_PROTOCOL_IWARP;
 
 	return 0;
 }
@@ -1376,19 +1392,23 @@ static int ice_devlink_enable_iw_set(struct devlink *devlink, u32 id,
 				     struct netlink_ext_ack *extack)
 {
 	struct ice_pf *pf = devlink_priv(devlink);
+	struct idc_rdma_core_dev_info *cdev;
 	bool iw_ena = ctx->val.vbool;
 	int ret;
 
+	cdev = pf->cdev_info;
+	if (!cdev)
+		return -ENODEV;
 	if (!iw_ena) {
 		ice_unplug_aux_dev(pf);
-		pf->rdma_mode &= ~IIDC_RDMA_PROTOCOL_IWARP;
+		cdev->rdma_protocol &= ~IDC_RDMA_PROTOCOL_IWARP;
 		return 0;
 	}
 
-	pf->rdma_mode |= IIDC_RDMA_PROTOCOL_IWARP;
+	cdev->rdma_protocol |= IDC_RDMA_PROTOCOL_IWARP;
 	ret = ice_plug_aux_dev(pf);
 	if (ret)
-		pf->rdma_mode &= ~IIDC_RDMA_PROTOCOL_IWARP;
+		cdev->rdma_protocol &= ~IDC_RDMA_PROTOCOL_IWARP;
 
 	return ret;
 }
@@ -1403,7 +1423,7 @@ ice_devlink_enable_iw_validate(struct devlink *devlink, u32 id,
 	if (!test_bit(ICE_FLAG_RDMA_ENA, pf->flags))
 		return -EOPNOTSUPP;
 
-	if (pf->rdma_mode & IIDC_RDMA_PROTOCOL_ROCEV2) {
+	if (pf->cdev_info->rdma_protocol & IDC_RDMA_PROTOCOL_ROCEV2) {
 		NL_SET_ERR_MSG_MOD(extack, "RoCEv2 is currently enabled. This device cannot enable iWARP and RoCEv2 simultaneously");
 		return -EOPNOTSUPP;
 	}
diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 71e05d30f0fd..a484a02cc88c 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -403,7 +403,6 @@ struct ice_vsi {
 	u16 req_rxq;			 /* User requested Rx queues */
 	u16 num_rx_desc;
 	u16 num_tx_desc;
-	u16 qset_handle[ICE_MAX_TRAFFIC_CLASS];
 	struct ice_tc_cfg tc_cfg;
 	struct bpf_prog *xdp_prog;
 	struct ice_tx_ring **xdp_rings;	 /* XDP ring array */
@@ -554,7 +553,6 @@ struct ice_pf {
 	struct devlink_port devlink_port;
 
 	/* OS reserved IRQ details */
-	struct msix_entry *msix_entries;
 	struct ice_irq_tracker irq_tracker;
 	/* First MSIX vector used by SR-IOV VFs. Calculated by subtracting the
 	 * number of MSIX vectors needed for all SR-IOV VFs from the number of
@@ -595,7 +593,6 @@ struct ice_pf {
 	struct gnss_serial *gnss_serial;
 	struct gnss_device *gnss_dev;
 	u16 num_rdma_msix;		/* Total MSIX vectors for RDMA driver */
-	u16 rdma_base_vector;
 
 	/* spinlock to protect the AdminQ wait list */
 	spinlock_t aq_wait_lock;
@@ -628,14 +625,12 @@ struct ice_pf {
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
@@ -667,6 +662,7 @@ struct ice_pf {
 	struct ice_dplls dplls;
 	struct device *hwmon_dev;
 	struct ice_health health_reporters;
+	struct idc_rdma_core_dev_info *cdev_info;
 
 	u8 num_quanta_prof_used;
 };
diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
index a7c510832824..b946b8af0c9b 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
@@ -352,8 +352,8 @@ int ice_pf_dcb_cfg(struct ice_pf *pf, struct ice_dcbx_cfg *new_cfg, bool locked)
 	struct ice_aqc_port_ets_elem buf = { 0 };
 	struct ice_dcbx_cfg *old_cfg, *curr_cfg;
 	struct device *dev = ice_pf_to_dev(pf);
+	struct idc_rdma_event *event;
 	int ret = ICE_DCB_NO_HW_CHG;
-	struct iidc_event *event;
 	struct ice_vsi *pf_vsi;
 
 	curr_cfg = &pf->hw.port_info->qos_cfg.local_dcbx_cfg;
@@ -405,7 +405,7 @@ int ice_pf_dcb_cfg(struct ice_pf *pf, struct ice_dcbx_cfg *new_cfg, bool locked)
 		goto free_cfg;
 	}
 
-	set_bit(IIDC_EVENT_BEFORE_TC_CHANGE, event->type);
+	set_bit(IDC_RDMA_EVENT_BEFORE_TC_CHANGE, event->type);
 	ice_send_event_to_aux(pf, event);
 	kfree(event);
 
@@ -740,7 +740,9 @@ static int ice_dcb_noncontig_cfg(struct ice_pf *pf)
 void ice_pf_dcb_recfg(struct ice_pf *pf, bool locked)
 {
 	struct ice_dcbx_cfg *dcbcfg = &pf->hw.port_info->qos_cfg.local_dcbx_cfg;
-	struct iidc_event *event;
+	struct iidc_rdma_priv_dev_info *privd;
+	struct idc_rdma_core_dev_info *cdev;
+	struct idc_rdma_event *event;
 	u8 tc_map = 0;
 	int v, ret;
 
@@ -783,13 +785,17 @@ void ice_pf_dcb_recfg(struct ice_pf *pf, bool locked)
 		if (vsi->type == ICE_VSI_PF)
 			ice_dcbnl_set_all(vsi);
 	}
-	if (!locked) {
+
+	cdev = pf->cdev_info;
+	if (cdev && !locked) {
+		privd = cdev->idc_priv;
+		ice_setup_dcb_qos_info(pf, &privd->qos_info);
 		/* Notify the AUX drivers that TC change is finished */
 		event = kzalloc(sizeof(*event), GFP_KERNEL);
 		if (!event)
 			return;
 
-		set_bit(IIDC_EVENT_AFTER_TC_CHANGE, event->type);
+		set_bit(IDC_RDMA_EVENT_AFTER_TC_CHANGE, event->type);
 		ice_send_event_to_aux(pf, event);
 		kfree(event);
 	}
@@ -944,6 +950,36 @@ ice_tx_prepare_vlan_flags_dcb(struct ice_tx_ring *tx_ring,
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
+	for (i = 0; i < ICE_DSCP_NUM_VAL; i++)
+		qos_info->dscp_map[i] = dcbx_cfg->dscp_map[i];
+}
+
 /**
  * ice_dcb_is_mib_change_pending - Check if MIB change is pending
  * @state: MIB change state
diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.h b/drivers/net/ethernet/intel/ice/ice_dcb_lib.h
index 800879a88c5e..80efbf00a474 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.h
@@ -31,6 +31,8 @@ void
 ice_tx_prepare_vlan_flags_dcb(struct ice_tx_ring *tx_ring,
 			      struct ice_tx_buf *first);
 void
+ice_setup_dcb_qos_info(struct ice_pf *pf, struct iidc_rdma_qos_params *qos_info);
+void
 ice_dcb_process_lldp_set_mib_change(struct ice_pf *pf,
 				    struct ice_rq_event_info *event);
 /**
@@ -134,5 +136,7 @@ static inline void ice_update_dcb_stats(struct ice_pf *pf) { }
 static inline void
 ice_dcb_process_lldp_set_mib_change(struct ice_pf *pf, struct ice_rq_event_info *event) { }
 static inline void ice_set_cgd_num(struct ice_tlan_ctx *tlan_ctx, u8 dcb_tc) { }
+static inline void
+ice_setup_dcb_qos_info(struct ice_pf *pf, struct iidc_rdma_qos_params *qos_info) { }
 #endif /* CONFIG_DCB */
 #endif /* _ICE_DCB_LIB_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index f241493a6ac8..63261ae55d4d 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3967,11 +3967,11 @@ static int ice_set_channels(struct net_device *dev, struct ethtool_channels *ch)
 		return -EINVAL;
 	}
 
-	if (pf->adev) {
+	if (pf->cdev_info->adev) {
 		mutex_lock(&pf->adev_mutex);
-		device_lock(&pf->adev->dev);
+		device_lock(&pf->cdev_info->adev->dev);
 		locked = true;
-		if (pf->adev->dev.driver) {
+		if (pf->cdev_info->adev->dev.driver) {
 			netdev_err(dev, "Cannot change channels when RDMA is active\n");
 			ret = -EBUSY;
 			goto adev_unlock;
@@ -3990,7 +3990,7 @@ static int ice_set_channels(struct net_device *dev, struct ethtool_channels *ch)
 
 adev_unlock:
 	if (locked) {
-		device_unlock(&pf->adev->dev);
+		device_unlock(&pf->cdev_info->adev->dev);
 		mutex_unlock(&pf->adev_mutex);
 	}
 	return ret;
diff --git a/drivers/net/ethernet/intel/ice/ice_idc.c b/drivers/net/ethernet/intel/ice/ice_idc.c
index 145b27f2a4ce..fcffea5a0c86 100644
--- a/drivers/net/ethernet/intel/ice/ice_idc.c
+++ b/drivers/net/ethernet/intel/ice/ice_idc.c
@@ -9,21 +9,24 @@
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
+ * Return: pointer to auxiliary driver associated with this device
  */
-static struct iidc_auxiliary_drv *ice_get_auxiliary_drv(struct ice_pf *pf)
+static struct idc_rdma_core_auxiliary_drv
+*ice_get_auxiliary_drv(struct idc_rdma_core_dev_info *cdev)
 {
 	struct auxiliary_device *adev;
 
-	adev = pf->adev;
+	adev = cdev->adev;
 	if (!adev || !adev->dev.driver)
 		return NULL;
 
-	return container_of(adev->dev.driver, struct iidc_auxiliary_drv,
+	return container_of(adev->dev.driver, struct idc_rdma_core_auxiliary_drv,
 			    adrv.driver);
 }
 
@@ -32,44 +35,54 @@ static struct iidc_auxiliary_drv *ice_get_auxiliary_drv(struct ice_pf *pf)
  * @pf: pointer to PF struct
  * @event: event struct
  */
-void ice_send_event_to_aux(struct ice_pf *pf, struct iidc_event *event)
+void ice_send_event_to_aux(struct ice_pf *pf, struct idc_rdma_event *event)
 {
-	struct iidc_auxiliary_drv *iadrv;
+	struct idc_rdma_core_auxiliary_drv *iadrv;
+	struct idc_rdma_core_dev_info *cdev;
 
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
+static int ice_add_rdma_qset(struct idc_rdma_core_dev_info *cdev,
+			     struct iidc_rdma_qset_params *qset)
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
@@ -100,27 +113,30 @@ int ice_add_rdma_qset(struct ice_pf *pf, struct iidc_rdma_qset_params *qset)
 		dev_err(dev, "Failed VSI RDMA Qset enable\n");
 		return status;
 	}
-	vsi->qset_handle[qset->tc] = qset->qs_handle;
 	qset->teid = qset_teid;
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(ice_add_rdma_qset);
 
 /**
  * ice_del_rdma_qset - Delete leaf node for RDMA Qset
- * @pf: PF struct
+ * @cdev: pointer to iidc_rdma_core_dev_info struct
  * @qset: Resource to be freed
+ *
+ * Return: Zero on success, error code on failure
  */
-int ice_del_rdma_qset(struct ice_pf *pf, struct iidc_rdma_qset_params *qset)
+static int ice_del_rdma_qset(struct idc_rdma_core_dev_info *cdev,
+			     struct iidc_rdma_qset_params *qset)
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
@@ -130,57 +146,60 @@ int ice_del_rdma_qset(struct ice_pf *pf, struct iidc_rdma_qset_params *qset)
 	q_id = qset->qs_handle;
 	teid = qset->teid;
 
-	vsi->qset_handle[qset->tc] = 0;
-
 	return ice_dis_vsi_rdma_qset(vsi->port_info, 1, &teid, &q_id);
 }
-EXPORT_SYMBOL_GPL(ice_del_rdma_qset);
 
 /**
  * ice_rdma_request_reset - accept request from RDMA to perform a reset
- * @pf: struct for PF
+ * @cdev: pointer to iidc_rdma_core_dev_info struct
  * @reset_type: type of reset
+ *
+ * Return: Zero on success, error code on failure
  */
-int ice_rdma_request_reset(struct ice_pf *pf, enum iidc_reset_type reset_type)
+static int ice_rdma_request_reset(struct idc_rdma_core_dev_info *cdev,
+				  enum idc_rdma_reset_type reset_type)
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
+	case IDC_FUNC_RESET:
 		reset = ICE_RESET_PFR;
 		break;
-	case IIDC_CORER:
+	case IDC_DEV_RESET:
 		reset = ICE_RESET_CORER;
 		break;
-	case IIDC_GLOBR:
-		reset = ICE_RESET_GLOBR;
-		break;
 	default:
-		dev_err(ice_pf_to_dev(pf), "incorrect reset request\n");
 		return -EINVAL;
 	}
 
 	return ice_schedule_reset(pf, reset);
 }
-EXPORT_SYMBOL_GPL(ice_rdma_request_reset);
 
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
+static int ice_rdma_update_vsi_filter(struct idc_rdma_core_dev_info *cdev,
+				      u16 vsi_id, bool enable)
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
@@ -198,35 +217,6 @@ int ice_rdma_update_vsi_filter(struct ice_pf *pf, u16 vsi_id, bool enable)
 
 	return status;
 }
-EXPORT_SYMBOL_GPL(ice_rdma_update_vsi_filter);
-
-/**
- * ice_get_qos_params - parse QoS params for RDMA consumption
- * @pf: pointer to PF struct
- * @qos: set of QoS values
- */
-void ice_get_qos_params(struct ice_pf *pf, struct iidc_qos_params *qos)
-{
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
-		for (i = 0; i < IIDC_MAX_DSCP_MAPPING; i++)
-			qos->dscp_map[i] = dcbx_cfg->dscp_map[i];
-}
-EXPORT_SYMBOL_GPL(ice_get_qos_params);
 
 /**
  * ice_alloc_rdma_qvectors - Allocate vector resources for RDMA driver
@@ -234,22 +224,26 @@ EXPORT_SYMBOL_GPL(ice_get_qos_params);
  */
 static int ice_alloc_rdma_qvectors(struct ice_pf *pf)
 {
+	struct idc_rdma_core_dev_info *cdev;
+
+	cdev = pf->cdev_info;
+	if (!cdev)
+		return -ENODEV;
+
 	if (ice_is_rdma_ena(pf)) {
 		int i;
 
-		pf->msix_entries = kcalloc(pf->num_rdma_msix,
-					   sizeof(*pf->msix_entries),
-						  GFP_KERNEL);
-		if (!pf->msix_entries)
+		cdev->msix_entries = kcalloc(pf->num_rdma_msix,
+					     sizeof(*cdev->msix_entries),
+						    GFP_KERNEL);
+		if (!cdev->msix_entries)
 			return -ENOMEM;
 
-		/* RDMA is the only user of pf->msix_entries array */
-		pf->rdma_base_vector = 0;
-
 		for (i = 0; i < pf->num_rdma_msix; i++) {
-			struct msix_entry *entry = &pf->msix_entries[i];
+			struct msix_entry *entry;
 			struct msi_map map;
 
+			entry = &cdev->msix_entries[i];
 			map = ice_alloc_irq(pf, false);
 			if (map.index < 0)
 				break;
@@ -267,32 +261,49 @@ static int ice_alloc_rdma_qvectors(struct ice_pf *pf)
  */
 static void ice_free_rdma_qvector(struct ice_pf *pf)
 {
+	struct idc_rdma_core_dev_info *cdev;
 	int i;
 
-	if (!pf->msix_entries)
+	cdev = pf->cdev_info;
+	if (!cdev)
+		return;
+
+	if (!cdev->msix_entries)
 		return;
 
 	for (i = 0; i < pf->num_rdma_msix; i++) {
 		struct msi_map map;
 
-		map.index = pf->msix_entries[i].entry;
-		map.virq = pf->msix_entries[i].vector;
+		map.index = cdev->msix_entries[i].entry;
+		map.virq = cdev->msix_entries[i].vector;
 		ice_free_irq(pf, map);
 	}
 
-	kfree(pf->msix_entries);
-	pf->msix_entries = NULL;
+	kfree(cdev->msix_entries);
+	cdev->msix_entries = NULL;
 }
 
+/* Initialize the ice_ops struct, which is used in 'ice_init_rdma' */
+static const struct idc_rdma_core_ops idc_c_ops = {
+	.vc_send_sync		= NULL,
+	.request_reset		= ice_rdma_request_reset,
+};
+
+static const struct iidc_rdma_priv_ops iidc_p_ops = {
+	.alloc_res		= ice_add_rdma_qset,
+	.free_res		= ice_del_rdma_qset,
+	.update_vport_filter	= ice_rdma_update_vsi_filter,
+};
+
 /**
  * ice_adev_release - function to be mapped to AUX dev's release op
  * @dev: pointer to device to free
  */
 static void ice_adev_release(struct device *dev)
 {
-	struct iidc_auxiliary_dev *iadev;
+	struct idc_rdma_core_auxiliary_dev *iadev;
 
-	iadev = container_of(dev, struct iidc_auxiliary_dev, adev.dev);
+	iadev = container_of(dev, struct idc_rdma_core_auxiliary_dev, adev.dev);
 	kfree(iadev);
 }
 
@@ -302,7 +313,8 @@ static void ice_adev_release(struct device *dev)
  */
 int ice_plug_aux_dev(struct ice_pf *pf)
 {
-	struct iidc_auxiliary_dev *iadev;
+	struct idc_rdma_core_auxiliary_dev *iadev;
+	struct idc_rdma_core_dev_info *cdev;
 	struct auxiliary_device *adev;
 	int ret;
 
@@ -312,17 +324,22 @@ int ice_plug_aux_dev(struct ice_pf *pf)
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
+	adev->name = cdev->rdma_protocol & IDC_RDMA_PROTOCOL_ROCEV2 ?
+		     "roce" : "iwarp";
 
 	ret = auxiliary_device_init(adev);
 	if (ret) {
@@ -337,7 +354,7 @@ int ice_plug_aux_dev(struct ice_pf *pf)
 	}
 
 	mutex_lock(&pf->adev_mutex);
-	pf->adev = adev;
+	cdev->adev = adev;
 	mutex_unlock(&pf->adev_mutex);
 
 	return 0;
@@ -351,8 +368,8 @@ void ice_unplug_aux_dev(struct ice_pf *pf)
 	struct auxiliary_device *adev;
 
 	mutex_lock(&pf->adev_mutex);
-	adev = pf->adev;
-	pf->adev = NULL;
+	adev = pf->cdev_info->adev;
+	pf->cdev_info->adev = NULL;
 	mutex_unlock(&pf->adev_mutex);
 
 	if (adev) {
@@ -361,13 +378,39 @@ void ice_unplug_aux_dev(struct ice_pf *pf)
 	}
 }
 
+/**
+ * ice_init_rdma_qos_info - initialize qos_info for RDMA aux
+ * @pf: pointer to ice_pf
+ * @qos_info: pointer to qos_info struct
+ */
+static void
+ice_init_rdma_qos_info(struct ice_pf *pf, struct iidc_rdma_qos_params *qos_info)
+{
+	int j;
+
+	/* setup qos_info fields with defaults */
+	qos_info->num_tc = 1;
+
+	for (j = 0; j < IIDC_MAX_USER_PRIORITY; j++)
+		qos_info->up2tc[j] = 0;
+
+	qos_info->tc_info[0].rel_bw = 100;
+	for (j = 1; j < IEEE_8021QAZ_MAX_TCS; j++)
+		qos_info->tc_info[j].rel_bw = 0;
+
+	/* for DCB, override the qos_info defaults. */
+	ice_setup_dcb_qos_info(pf, qos_info);
+}
+
 /**
  * ice_init_rdma - initializes PF for RDMA use
  * @pf: ptr to ice_pf
  */
 int ice_init_rdma(struct ice_pf *pf)
 {
+	struct iidc_rdma_priv_dev_info *privd;
 	struct device *dev = &pf->pdev->dev;
+	struct idc_rdma_core_dev_info *cdev;
 	int ret;
 
 	if (!ice_is_rdma_ena(pf)) {
@@ -375,20 +418,46 @@ int ice_init_rdma(struct ice_pf *pf)
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
 
+	cdev->ops = &idc_c_ops;
+	cdev->idc_priv = privd;
+	privd->priv_ops = &iidc_p_ops;
+	privd->netdev = pf->vsi[0]->netdev;
+
+	cdev->msix_count = pf->num_rdma_msix;
+	privd->hw_addr = (u8 __iomem *)pf->hw.hw_addr;
+	cdev->pdev = pf->pdev;
+	privd->vport_id = pf->vsi[0]->vsi_num;
+
 	/* Reserve vector resources */
 	ret = ice_alloc_rdma_qvectors(pf);
 	if (ret < 0) {
 		dev_err(dev, "failed to reserve vectors for RDMA\n");
 		goto err_reserve_rdma_qvector;
 	}
-	pf->rdma_mode |= IIDC_RDMA_PROTOCOL_ROCEV2;
+
+	pf->cdev_info->rdma_protocol |= IDC_RDMA_PROTOCOL_ROCEV2;
+	ice_init_rdma_qos_info(pf, &privd->qos_info);
 	ret = ice_plug_aux_dev(pf);
 	if (ret)
 		goto err_plug_aux_dev;
@@ -397,8 +466,14 @@ int ice_init_rdma(struct ice_pf *pf)
 err_plug_aux_dev:
 	ice_free_rdma_qvector(pf);
 err_reserve_rdma_qvector:
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
 
diff --git a/drivers/net/ethernet/intel/ice/ice_idc_int.h b/drivers/net/ethernet/intel/ice/ice_idc_int.h
index 4b0c86757df9..8a1e9ed9b103 100644
--- a/drivers/net/ethernet/intel/ice/ice_idc_int.h
+++ b/drivers/net/ethernet/intel/ice/ice_idc_int.h
@@ -4,10 +4,11 @@
 #ifndef _ICE_IDC_INT_H_
 #define _ICE_IDC_INT_H_
 
-#include <linux/net/intel/iidc.h>
+#include <linux/net/intel/idc_rdma.h>
+#include <linux/net/intel/iidc_rdma.h>
 
 struct ice_pf;
 
-void ice_send_event_to_aux(struct ice_pf *pf, struct iidc_event *event);
+void ice_send_event_to_aux(struct ice_pf *pf, struct idc_rdma_event *event);
 
 #endif /* !_ICE_IDC_INT_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index c3a0fb97c5ee..662d229a6824 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2401,11 +2401,11 @@ static void ice_service_task(struct work_struct *work)
 	}
 
 	if (test_and_clear_bit(ICE_AUX_ERR_PENDING, pf->state)) {
-		struct iidc_event *event;
+		struct idc_rdma_event *event;
 
 		event = kzalloc(sizeof(*event), GFP_KERNEL);
 		if (event) {
-			set_bit(IIDC_EVENT_CRIT_ERR, event->type);
+			set_bit(IDC_RDMA_EVENT_CRIT_ERR, event->type);
 			/* report the entire OICR value to AUX driver */
 			swap(event->reg, pf->oicr_err_reg);
 			ice_send_event_to_aux(pf, event);
@@ -2424,11 +2424,11 @@ static void ice_service_task(struct work_struct *work)
 		ice_plug_aux_dev(pf);
 
 	if (test_and_clear_bit(ICE_FLAG_MTU_CHANGED, pf->flags)) {
-		struct iidc_event *event;
+		struct idc_rdma_event *event;
 
 		event = kzalloc(sizeof(*event), GFP_KERNEL);
 		if (event) {
-			set_bit(IIDC_EVENT_AFTER_MTU_CHANGE, event->type);
+			set_bit(IDC_RDMA_EVENT_AFTER_MTU_CHANGE, event->type);
 			ice_send_event_to_aux(pf, event);
 			kfree(event);
 		}
@@ -9340,6 +9340,7 @@ ice_setup_tc(struct net_device *netdev, enum tc_setup_type type,
 	     void *type_data)
 {
 	struct ice_netdev_priv *np = netdev_priv(netdev);
+	struct idc_rdma_core_dev_info *cdev;
 	struct ice_pf *pf = np->vsi->back;
 	bool locked = false;
 	int err;
@@ -9356,11 +9357,12 @@ ice_setup_tc(struct net_device *netdev, enum tc_setup_type type,
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
@@ -9374,7 +9376,7 @@ ice_setup_tc(struct net_device *netdev, enum tc_setup_type type,
 
 adev_unlock:
 		if (locked) {
-			device_unlock(&pf->adev->dev);
+			device_unlock(&cdev->adev->dev);
 			mutex_unlock(&pf->adev_mutex);
 		}
 		return err;
diff --git a/include/linux/net/intel/idc_rdma.h b/include/linux/net/intel/idc_rdma.h
new file mode 100644
index 000000000000..5c31c6d1cc8a
--- /dev/null
+++ b/include/linux/net/intel/idc_rdma.h
@@ -0,0 +1,138 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021, Intel Corporation. */
+
+#ifndef _IDC_RDMA_H_
+#define _IDC_RDMA_H_
+
+#include <linux/auxiliary_bus.h>
+#include <linux/device.h>
+#include <linux/if_ether.h>
+#include <linux/kernel.h>
+#include <linux/netdevice.h>
+
+#define IDC_RDMA_ROCE_NAME	"roce"
+#define IDC_RDMA_IWARP_NAME	"iwarp"
+
+enum idc_rdma_reset_type {
+	IDC_FUNC_RESET,
+	IDC_DEV_RESET,
+};
+
+enum idc_rdma_event_type {
+	IDC_RDMA_EVENT_BEFORE_MTU_CHANGE,
+	IDC_RDMA_EVENT_AFTER_MTU_CHANGE,
+	IDC_RDMA_EVENT_BEFORE_TC_CHANGE,
+	IDC_RDMA_EVENT_AFTER_TC_CHANGE,
+	IDC_RDMA_EVENT_WARN_RESET,
+	IDC_RDMA_EVENT_CRIT_ERR,
+	IDC_RDMA_EVENT_NBITS,		/* must be last */
+};
+
+struct idc_rdma_event {
+	DECLARE_BITMAP(type, IDC_RDMA_EVENT_NBITS);
+	u32 reg;
+};
+
+enum idc_rdma_protocol {
+	IDC_RDMA_PROTOCOL_IWARP = BIT(0),
+	IDC_RDMA_PROTOCOL_ROCEV2 = BIT(1),
+};
+
+struct idc_rdma_qv_info {
+	u32 v_idx;
+	u16 ceq_idx;
+	u16 aeq_idx;
+	u8 itr_idx;
+};
+
+struct idc_rdma_qvlist_info {
+	u32 num_vectors;
+	struct idc_rdma_qv_info qv_info[];
+};
+
+struct idc_rdma_core_dev_info;
+
+/* Following APIs are implemented by core PCI driver */
+struct idc_rdma_core_ops {
+	int (*vc_send_sync)(struct idc_rdma_core_dev_info *cdev_info, u8 *msg,
+			    u16 len, u8 *recv_msg, u16 *recv_len);
+	int (*vc_queue_vec_map_unmap)(struct idc_rdma_core_dev_info *cdev_info,
+				      struct idc_rdma_qvlist_info *qvl_info,
+				      bool map);
+	/* vport_dev_ctrl is for RDMA CORE driver to indicate it is either ready
+	 * for individual vport aux devices, or it is leaving the state where it
+	 * can support vports and they need to be downed
+	 */
+	int (*vport_dev_ctrl)(struct idc_rdma_core_dev_info *cdev_info,
+			      bool up);
+	int (*request_reset)(struct idc_rdma_core_dev_info *cdev_info,
+			     enum idc_rdma_reset_type reset_type);
+};
+
+enum idc_function_type {
+	IDC_FUNCTION_TYPE_PF,
+	IDC_FUNCTION_TYPE_VF,
+};
+
+struct idc_rdma_lan_mapped_mem_region {
+	u8 __iomem *region_addr;
+	__le64 size;
+	__le64 start_offset;
+};
+
+/* struct to be populated by core LAN PCI driver */
+struct idc_rdma_core_dev_info {
+	struct pci_dev *pdev; /* PCI device of corresponding to main function */
+	struct auxiliary_device *adev;
+	struct idc_rdma_lan_mapped_mem_region *mapped_mem_regions;
+	__le16 num_memory_regions;
+	/* Current active RDMA protocol */
+	enum idc_rdma_protocol rdma_protocol;
+	enum idc_function_type ftype;
+	struct msix_entry *msix_entries;
+	u16 msix_count; /* How many vectors are reserved for this device */
+	/* Following struct contains function pointers to be initialized
+	 * by core PCI driver and called by auxiliary driver
+	 */
+	const struct idc_rdma_core_ops *ops;
+	void *idc_priv;
+};
+
+struct idc_rdma_core_auxiliary_dev {
+	struct auxiliary_device adev;
+	struct idc_rdma_core_dev_info *cdev_info;
+};
+
+/* struct to be populated by core LAN PCI driver */
+struct idc_rdma_vport_dev_info {
+	struct auxiliary_device *adev;
+	struct auxiliary_device *core_adev;
+	struct net_device *netdev;
+	u16 vport_id;
+};
+
+struct idc_rdma_vport_auxiliary_dev {
+	struct auxiliary_device adev;
+	struct idc_rdma_vport_dev_info *vdev_info;
+};
+
+/* structures representing the auxiliary drivers. These structs are to be
+ * allocated and populated by the auxiliary drivers' owner. The core PCI
+ * driver will access these ops by performing a container_of on the
+ * auxiliary_device->dev.driver.
+ */
+struct idc_rdma_core_auxiliary_drv {
+	struct auxiliary_driver adrv;
+	void (*event_handler)(struct idc_rdma_core_dev_info *cdev,
+			      struct idc_rdma_event *event);
+	int (*vc_receive)(struct idc_rdma_core_dev_info *cdev_info, u8 *msg,
+			  u16 len);
+};
+
+struct idc_rdma_vport_auxiliary_drv {
+	struct auxiliary_driver adrv;
+	void (*event_handler)(struct idc_rdma_vport_dev_info *vdev,
+			      struct idc_rdma_event *event);
+};
+
+#endif /* _IDC_RDMA_H_*/
diff --git a/include/linux/net/intel/iidc.h b/include/linux/net/intel/iidc.h
deleted file mode 100644
index 1c1332e4df26..000000000000
--- a/include/linux/net/intel/iidc.h
+++ /dev/null
@@ -1,107 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2021, Intel Corporation. */
-
-#ifndef _IIDC_H_
-#define _IIDC_H_
-
-#include <linux/auxiliary_bus.h>
-#include <linux/dcbnl.h>
-#include <linux/device.h>
-#include <linux/if_ether.h>
-#include <linux/kernel.h>
-#include <linux/netdevice.h>
-
-enum iidc_event_type {
-	IIDC_EVENT_BEFORE_MTU_CHANGE,
-	IIDC_EVENT_AFTER_MTU_CHANGE,
-	IIDC_EVENT_BEFORE_TC_CHANGE,
-	IIDC_EVENT_AFTER_TC_CHANGE,
-	IIDC_EVENT_CRIT_ERR,
-	IIDC_EVENT_NBITS		/* must be last */
-};
-
-enum iidc_reset_type {
-	IIDC_PFR,
-	IIDC_CORER,
-	IIDC_GLOBR,
-};
-
-enum iidc_rdma_protocol {
-	IIDC_RDMA_PROTOCOL_IWARP = BIT(0),
-	IIDC_RDMA_PROTOCOL_ROCEV2 = BIT(1),
-};
-
-#define IIDC_MAX_USER_PRIORITY		8
-#define IIDC_MAX_DSCP_MAPPING		64
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
-struct iidc_qos_info {
-	u64 tc_ctx;
-	u8 rel_bw;
-	u8 prio_type;
-	u8 egress_virt_up;
-	u8 ingress_virt_up;
-};
-
-/* Struct to pass QoS info */
-struct iidc_qos_params {
-	struct iidc_qos_info tc_info[IEEE_8021QAZ_MAX_TCS];
-	u8 up2tc[IIDC_MAX_USER_PRIORITY];
-	u8 vport_relative_bw;
-	u8 vport_priority_type;
-	u8 num_tc;
-	u8 pfc_mode;
-	u8 dscp_map[IIDC_MAX_DSCP_MAPPING];
-};
-
-struct iidc_event {
-	DECLARE_BITMAP(type, IIDC_EVENT_NBITS);
-	u32 reg;
-};
-
-struct ice_pf;
-
-int ice_add_rdma_qset(struct ice_pf *pf, struct iidc_rdma_qset_params *qset);
-int ice_del_rdma_qset(struct ice_pf *pf, struct iidc_rdma_qset_params *qset);
-int ice_rdma_request_reset(struct ice_pf *pf, enum iidc_reset_type reset_type);
-int ice_rdma_update_vsi_filter(struct ice_pf *pf, u16 vsi_id, bool enable);
-void ice_get_qos_params(struct ice_pf *pf, struct iidc_qos_params *qos);
-
-/* Structure representing auxiliary driver tailored information about the core
- * PCI dev, each auxiliary driver using the IIDC interface will have an
- * instance of this struct dedicated to it.
- */
-
-struct iidc_auxiliary_dev {
-	struct auxiliary_device adev;
-	struct ice_pf *pf;
-};
-
-/* structure representing the auxiliary driver. This struct is to be
- * allocated and populated by the auxiliary driver's owner. The core PCI
- * driver will access these ops by performing a container_of on the
- * auxiliary_device->dev.driver.
- */
-struct iidc_auxiliary_drv {
-	struct auxiliary_driver adrv;
-	/* This event_handler is meant to be a blocking call.  For instance,
-	 * when a BEFORE_MTU_CHANGE event comes in, the event_handler will not
-	 * return until the auxiliary driver is ready for the MTU change to
-	 * happen.
-	 */
-	void (*event_handler)(struct ice_pf *pf, struct iidc_event *event);
-};
-
-#endif /* _IIDC_H_*/
diff --git a/include/linux/net/intel/iidc_rdma.h b/include/linux/net/intel/iidc_rdma.h
new file mode 100644
index 000000000000..afac07b857fd
--- /dev/null
+++ b/include/linux/net/intel/iidc_rdma.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021, Intel Corporation. */
+
+#ifndef _IIDC_RDMA_H_
+#define _IIDC_RDMA_H_
+
+#include <linux/dcbnl.h>
+
+#define IIDC_MAX_USER_PRIORITY		8
+#define IIDC_MAX_DSCP_MAPPING		64
+#define IIDC_DSCP_PFC_MODE		0x1
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
+	u8 dscp_map[IIDC_MAX_DSCP_MAPPING];
+};
+
+struct iidc_rdma_priv_ops {
+	int (*alloc_res)(struct idc_rdma_core_dev_info *cdev_info,
+			 struct iidc_rdma_qset_params *qset);
+	int (*free_res)(struct idc_rdma_core_dev_info *cdev_info,
+			struct iidc_rdma_qset_params *qset);
+	int (*update_vport_filter)(struct idc_rdma_core_dev_info *cdev_info,
+				   u16 vport_id, bool enable);
+};
+
+struct iidc_rdma_priv_dev_info {
+	u8 pf_id;
+	u16 vport_id;
+	struct net_device *netdev;
+	struct iidc_rdma_qos_params qos_info;
+	const struct iidc_rdma_priv_ops *priv_ops;
+	u8 __iomem *hw_addr;
+};
+#endif /* _IDC_RDMA_H_*/
-- 
2.37.3


