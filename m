Return-Path: <linux-rdma+bounces-12957-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4169B38698
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Aug 2025 17:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7151A1BA5F8A
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Aug 2025 15:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA76286424;
	Wed, 27 Aug 2025 15:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uh01nXw2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4E727B4F7
	for <linux-rdma@vger.kernel.org>; Wed, 27 Aug 2025 15:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756308418; cv=none; b=tHT0K9x9oYRsUlXsEmMRq6zvFmISwWxIC0F2tnaNiTKno/KzoviGWcW10Rdxozy6VXjjhMZnLD11U9mIvQVPciNY88zze3kDJd/mcvibUOQ+vPdMdoN+u3wtk1fcZiH7p3EJ69eOmVCQmZz2FtzOZMlQMYbz4Bv67CZbb/Zfn84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756308418; c=relaxed/simple;
	bh=HicXo29o7r2FIQMNJKaZrfFfS1hONlWnZD7hMCnpL/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CkdB+VvWIpMfmB0lGzSOm6qoqFUQAhKgNLevgZVnJ4vQP/ahafFZ6aQBzcQBO82xst27iR5tOwFEiGixt8TBff1zJSL0b3t9PWVc9ZzyJispaPd/WeFRIQ+DZ3XVPfzluJfttyWX8bcIUFBQBtk9m+sY6ChZ9cSr9xuJ+tYjCAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uh01nXw2; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756308416; x=1787844416;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HicXo29o7r2FIQMNJKaZrfFfS1hONlWnZD7hMCnpL/Q=;
  b=Uh01nXw2UAAt0keSAExICIMOig0EdSmzPpS5zlobOuyWamRMI5W2Easn
   n4G7SljzPo2GTbdb1zX4U1OY5yzc0SORiJfZJnte/TYz33H5oAmG7OZLC
   C58HhgcF8iW9sCOBefdceq/NN8BL1qxWHObNXf5/CUb9QQn85a0WJWDXw
   inKf5CYSbVAGWkN9Z4MtQX/sK8qxVyruc/ernCCACCRx7u/zfo0UFE+HK
   RvMO7TJOqIrFeemOwof0fHio+WF8oUlLH3Ix33zCJ4mcwBDVOWsurh06D
   hry5deRYaUniTLWPfyOEKF7TiNq1pjgKQxSCcRyalRbrARQysEW/vJd46
   g==;
X-CSE-ConnectionGUID: IyzmGqtWTzilcjaRW7wJmQ==
X-CSE-MsgGUID: Wgu35v38TrCYf5BCSfpr7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="76162774"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="76162774"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 08:26:42 -0700
X-CSE-ConnectionGUID: unT2CaVCSsGyrR/+QWMt5Q==
X-CSE-MsgGUID: Vf8ex4oEQCuh3N/odS/ixw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="174206839"
Received: from pthorat-mobl.amr.corp.intel.com (HELO soc-PF51RAGT.clients.intel.com) ([10.246.116.180])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 08:26:38 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	tatyana.e.nikolova@intel.com,
	krzysztof.czurylo@intel.com
Subject: [for-next 07/16] RDMA/irdma: Introduce GEN3 vPort driver support
Date: Wed, 27 Aug 2025 10:25:36 -0500
Message-ID: <20250827152545.2056-8-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250827152545.2056-1-tatyana.e.nikolova@intel.com>
References: <20250827152545.2056-1-tatyana.e.nikolova@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mustafa Ismail <mustafa.ismail@intel.com>

In the IPU model, a function can host one or more logical network
endpoints called vPorts. Each vPort may be associated with either a
physical or an internal communication port, and can be RDMA capable. A
vPort features a netdev and, if RDMA capable, must have an associated
ib_dev.

This change introduces a GEN3 auxiliary vPort driver responsible for
registering a verbs device for every RDMA-capable vPort. Additionally,
the UAPI is updated to prevent the binding of GEN3 devices to older
user-space providers.

Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---

Changes since split:
* Include iidc_rdma_idpf.h to enable vport functionality
* Set push mode to false since push mode support for GEN3 is
removed from this series.

 drivers/infiniband/hw/irdma/main.c  | 120 ++++++++++++++++++++++++++++
 drivers/infiniband/hw/irdma/main.h  |   2 +
 drivers/infiniband/hw/irdma/verbs.c |  10 ++-
 include/uapi/rdma/irdma-abi.h       |   1 +
 4 files changed, 132 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/main.c b/drivers/infiniband/hw/irdma/main.c
index 162f1fab32b5..95957d52883d 100644
--- a/drivers/infiniband/hw/irdma/main.c
+++ b/drivers/infiniband/hw/irdma/main.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /* Copyright (c) 2015 - 2021 Intel Corporation */
 #include "main.h"
+#include <linux/net/intel/iidc_rdma_idpf.h>
 
 MODULE_ALIAS("i40iw");
 MODULE_DESCRIPTION("Intel(R) Ethernet Protocol Driver for RDMA");
@@ -46,6 +47,113 @@ void irdma_log_invalid_mtu(u16 mtu, struct irdma_sc_dev *dev)
 		ibdev_warn(to_ibdev(dev), "MTU setting [%d] too low for RDMA traffic. Minimum MTU is 1280 for IPv6\\n", mtu);
 }
 
+static void ig3rdma_idc_vport_event_handler(struct iidc_rdma_vport_dev_info *cdev_info,
+					    struct iidc_rdma_event *event)
+{
+	struct irdma_device *iwdev = auxiliary_get_drvdata(cdev_info->adev);
+	struct irdma_l2params l2params = {};
+
+	if (*event->type & BIT(IIDC_RDMA_EVENT_AFTER_MTU_CHANGE)) {
+		ibdev_dbg(&iwdev->ibdev, "CLNT: new MTU = %d\n", iwdev->netdev->mtu);
+		if (iwdev->vsi.mtu != iwdev->netdev->mtu) {
+			l2params.mtu = iwdev->netdev->mtu;
+			l2params.mtu_changed = true;
+			irdma_log_invalid_mtu(l2params.mtu, &iwdev->rf->sc_dev);
+			irdma_change_l2params(&iwdev->vsi, &l2params);
+		}
+	}
+}
+
+static int ig3rdma_vport_probe(struct auxiliary_device *aux_dev,
+			       const struct auxiliary_device_id *id)
+{
+	struct iidc_rdma_vport_auxiliary_dev *idc_adev =
+		container_of(aux_dev, struct iidc_rdma_vport_auxiliary_dev, adev);
+	struct auxiliary_device *aux_core_dev = idc_adev->vdev_info->core_adev;
+	struct irdma_pci_f *rf = auxiliary_get_drvdata(aux_core_dev);
+	struct irdma_l2params l2params = {};
+	struct irdma_device *iwdev;
+	int err;
+
+	if (!rf) {
+		WARN_ON_ONCE(1);
+		return -ENOMEM;
+	}
+	iwdev = ib_alloc_device(irdma_device, ibdev);
+	/* Fill iwdev info */
+	iwdev->is_vport = true;
+	iwdev->rf = rf;
+	iwdev->vport_id = idc_adev->vdev_info->vport_id;
+	iwdev->netdev = idc_adev->vdev_info->netdev;
+	iwdev->init_state = INITIAL_STATE;
+	iwdev->roce_cwnd = IRDMA_ROCE_CWND_DEFAULT;
+	iwdev->roce_ackcreds = IRDMA_ROCE_ACKCREDS_DEFAULT;
+	iwdev->rcv_wnd = IRDMA_CM_DEFAULT_RCV_WND_SCALED;
+	iwdev->rcv_wscale = IRDMA_CM_DEFAULT_RCV_WND_SCALE;
+	iwdev->roce_mode = true;
+	iwdev->push_mode = false;
+
+	l2params.mtu = iwdev->netdev->mtu;
+
+	err = irdma_rt_init_hw(iwdev, &l2params);
+	if (err)
+		goto err_rt_init;
+
+	err = irdma_ib_register_device(iwdev);
+	if (err)
+		goto err_ibreg;
+
+	auxiliary_set_drvdata(aux_dev, iwdev);
+
+	ibdev_dbg(&iwdev->ibdev,
+		  "INIT: Gen[%d] vport[%d] probe success. dev_name = %s, core_dev_name = %s, netdev=%s\n",
+		  rf->rdma_ver, idc_adev->vdev_info->vport_id,
+		  dev_name(&aux_dev->dev),
+		  dev_name(&idc_adev->vdev_info->core_adev->dev),
+		  netdev_name(idc_adev->vdev_info->netdev));
+
+	return 0;
+err_ibreg:
+	irdma_rt_deinit_hw(iwdev);
+err_rt_init:
+	ib_dealloc_device(&iwdev->ibdev);
+
+	return err;
+}
+
+static void ig3rdma_vport_remove(struct auxiliary_device *aux_dev)
+{
+	struct iidc_rdma_vport_auxiliary_dev *idc_adev =
+		container_of(aux_dev, struct iidc_rdma_vport_auxiliary_dev, adev);
+	struct irdma_device *iwdev = auxiliary_get_drvdata(aux_dev);
+
+	ibdev_dbg(&iwdev->ibdev,
+		  "INIT: Gen[%d] dev_name = %s, core_dev_name = %s, netdev=%s\n",
+		  iwdev->rf->rdma_ver, dev_name(&aux_dev->dev),
+		  dev_name(&idc_adev->vdev_info->core_adev->dev),
+		  netdev_name(idc_adev->vdev_info->netdev));
+
+	irdma_ib_unregister_device(iwdev);
+}
+
+static const struct auxiliary_device_id ig3rdma_vport_auxiliary_id_table[] = {
+	{.name = "idpf.8086.rdma.vdev", },
+	{},
+};
+
+MODULE_DEVICE_TABLE(auxiliary, ig3rdma_vport_auxiliary_id_table);
+
+static struct iidc_rdma_vport_auxiliary_drv ig3rdma_vport_auxiliary_drv = {
+	.adrv = {
+		.name = "vdev",
+		.id_table = ig3rdma_vport_auxiliary_id_table,
+		.probe = ig3rdma_vport_probe,
+		.remove = ig3rdma_vport_remove,
+	},
+	.event_handler = ig3rdma_idc_vport_event_handler,
+};
+
+
 static int __init irdma_init_module(void)
 {
 	int ret;
@@ -74,6 +182,17 @@ static int __init irdma_init_module(void)
 
 		return ret;
 	}
+
+	ret = auxiliary_driver_register(&ig3rdma_vport_auxiliary_drv.adrv);
+	if (ret) {
+		auxiliary_driver_unregister(&ig3rdma_core_auxiliary_drv.adrv);
+		auxiliary_driver_unregister(&icrdma_core_auxiliary_drv.adrv);
+		auxiliary_driver_unregister(&i40iw_auxiliary_drv);
+		pr_err("Failed ig3rdma vport auxiliary_driver_register() ret=%d\n",
+		       ret);
+
+		return ret;
+	}
 	irdma_register_notifiers();
 
 	return 0;
@@ -85,6 +204,7 @@ static void __exit irdma_exit_module(void)
 	auxiliary_driver_unregister(&icrdma_core_auxiliary_drv.adrv);
 	auxiliary_driver_unregister(&i40iw_auxiliary_drv);
 	auxiliary_driver_unregister(&ig3rdma_core_auxiliary_drv.adrv);
+	auxiliary_driver_unregister(&ig3rdma_vport_auxiliary_drv.adrv);
 }
 
 module_init(irdma_init_module);
diff --git a/drivers/infiniband/hw/irdma/main.h b/drivers/infiniband/hw/irdma/main.h
index 7300f8ab49ca..c64d772dc644 100644
--- a/drivers/infiniband/hw/irdma/main.h
+++ b/drivers/infiniband/hw/irdma/main.h
@@ -354,12 +354,14 @@ struct irdma_device {
 	u32 rcv_wnd;
 	u16 mac_ip_table_idx;
 	u16 vsi_num;
+	u16 vport_id;
 	u8 rcv_wscale;
 	u8 iw_status;
 	bool roce_mode:1;
 	bool roce_dcqcn_en:1;
 	bool dcb_vlan_mode:1;
 	bool iw_ooo:1;
+	bool is_vport:1;
 	enum init_completion_state init_state;
 
 	wait_queue_head_t suspend_wq;
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 894c1f7bcb43..7f59bdd85da0 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -292,6 +292,10 @@ static int irdma_alloc_ucontext(struct ib_ucontext *uctx,
 	ucontext->iwdev = iwdev;
 	ucontext->abi_ver = req.userspace_ver;
 
+	if (!(req.comp_mask & IRDMA_SUPPORT_WQE_FORMAT_V2) &&
+	    uk_attrs->hw_rev >= IRDMA_GEN_3)
+		return -EOPNOTSUPP;
+
 	if (req.comp_mask & IRDMA_ALLOC_UCTX_USE_RAW_ATTR)
 		ucontext->use_raw_attrs = true;
 
@@ -4891,5 +4895,9 @@ void irdma_ib_dealloc_device(struct ib_device *ibdev)
 	struct irdma_device *iwdev = to_iwdev(ibdev);
 
 	irdma_rt_deinit_hw(iwdev);
-	irdma_ctrl_deinit_hw(iwdev->rf);
+	if (!iwdev->is_vport) {
+		irdma_ctrl_deinit_hw(iwdev->rf);
+		if (iwdev->rf->vchnl_wq)
+			destroy_workqueue(iwdev->rf->vchnl_wq);
+	}
 }
diff --git a/include/uapi/rdma/irdma-abi.h b/include/uapi/rdma/irdma-abi.h
index bb18f15489e3..4e42054cca33 100644
--- a/include/uapi/rdma/irdma-abi.h
+++ b/include/uapi/rdma/irdma-abi.h
@@ -25,6 +25,7 @@ enum irdma_memreg_type {
 enum {
 	IRDMA_ALLOC_UCTX_USE_RAW_ATTR = 1 << 0,
 	IRDMA_ALLOC_UCTX_MIN_HW_WQ_SIZE = 1 << 1,
+	IRDMA_SUPPORT_WQE_FORMAT_V2 = 1 << 3,
 };
 
 struct irdma_alloc_ucontext_req {
-- 
2.42.0


