Return-Path: <linux-rdma+bounces-3964-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7188093B98A
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2024 01:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E38131F22269
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jul 2024 23:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E39C1494B5;
	Wed, 24 Jul 2024 23:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PfyR2ZzL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EAB1448D8
	for <linux-rdma@vger.kernel.org>; Wed, 24 Jul 2024 23:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721864449; cv=none; b=bxUYprX+4mPJvu2wuC4i3ETzpvJHHicP1wWkKDIy1o1mSpuYyqakIdBL5LbsTz94j1+vf2OEisEDkhEJWwzjxhV4FogLvnj0GY0sm94qCbHaCPe9raLRMXUh4Lfx4kGKhfk54BePWTaa/JvtkrUOZnvhtKZ4aVCZjbVpeQ9i1JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721864449; c=relaxed/simple;
	bh=1JbHvQeQlMfHeYUQOYebKU6bO7marf/qLoZLX7h0NM4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i3qxz5B1SDaJ4SHaCCIkK3tNxQPTZMCCKX+mPLGbfa/1ZwFzO7bvKE9uQxld5bG5+VjLr6vs0e42xzXtatLdHsKE5tvLjO4uS+ktw0IPxH4b2Su23JcKS/oQHEqrrsmr45RhhHi+BsB/a9a9gt6qLLL03fq2nGd2E+bJWQuJROI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PfyR2ZzL; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721864448; x=1753400448;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1JbHvQeQlMfHeYUQOYebKU6bO7marf/qLoZLX7h0NM4=;
  b=PfyR2ZzLQ5VRgRcq3xJt6auzRIifaBSNKlU6r5MaFHE1EOX2LMp9aYMT
   sUv5LvPJDZqe71Q9Q9tAB3JiYUnMB3umBjIjPUIGNaoylUaS0tIrIbrzs
   ASk5TW8mjBJfuxXGIZ7UYB7NRW74Htm3wCA9iHPwL3+HR6hJbcWrLu9sO
   d8c6u0S7zEyH1j8OKb0RT9f5V9o4DU4sOjl/GBXFu+7UzHyPegC43l9HT
   DPf5bVLIPjz8PFf+ze8dwRzFoOoHIEpzTj8AwvT6sX6Jk66KQklVuupqz
   +8R01OjolUttVAm2/9mo7b0aeHkJzk3XbSIgljXQ6inWC2yqkARf/ktJB
   A==;
X-CSE-ConnectionGUID: YozypsV3QJmD2zWtCmzWUg==
X-CSE-MsgGUID: IRkCwvMfSv2PmtDjqxz7FQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="44999782"
X-IronPort-AV: E=Sophos;i="6.09,234,1716274800"; 
   d="scan'208";a="44999782"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 16:40:43 -0700
X-CSE-ConnectionGUID: HpFXINCEQTC1NEvfglR1UQ==
X-CSE-MsgGUID: 1vIIHAZ2STGbs1tsb96JLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,234,1716274800"; 
   d="scan'208";a="52426073"
Received: from tenikolo-mobl1.amr.corp.intel.com ([10.124.96.138])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 16:40:42 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	mustafa.ismail@intel.com,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [RFC PATCH 16/25] RDMA/irdma: Introduce GEN3 vPort driver support
Date: Wed, 24 Jul 2024 18:39:08 -0500
Message-Id: <20240724233917.704-17-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20240724233917.704-1-tatyana.e.nikolova@intel.com>
References: <20240724233917.704-1-tatyana.e.nikolova@intel.com>
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
 drivers/infiniband/hw/irdma/ig3rdma_if.c | 110 ++++++++++++++++++++++++++++++-
 drivers/infiniband/hw/irdma/main.c       |  12 ++++
 drivers/infiniband/hw/irdma/main.h       |   3 +
 drivers/infiniband/hw/irdma/verbs.c      |  12 +++-
 include/uapi/rdma/irdma-abi.h            |   1 +
 5 files changed, 135 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/ig3rdma_if.c b/drivers/infiniband/hw/irdma/ig3rdma_if.c
index 70b1ed3..1e2e41d 100644
--- a/drivers/infiniband/hw/irdma/ig3rdma_if.c
+++ b/drivers/infiniband/hw/irdma/ig3rdma_if.c
@@ -14,6 +14,23 @@ static void ig3rdma_idc_core_event_handler(struct idc_rdma_core_dev_info *cdev_i
 	}
 }
 
+static void ig3rdma_idc_vport_event_handler(struct idc_rdma_vport_dev_info *cdev_info,
+					    struct idc_rdma_event *event)
+{
+	struct irdma_device *iwdev = auxiliary_get_drvdata(cdev_info->adev);
+	struct irdma_l2params l2params = {};
+
+	if (*event->type & BIT(IDC_RDMA_EVENT_AFTER_MTU_CHANGE)) {
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
 static int ig3rdma_cfg_regions(struct irdma_hw *hw,
 			       struct idc_rdma_core_dev_info *cdev_info)
 {
@@ -168,4 +185,95 @@ struct idc_rdma_core_auxiliary_drv ig3rdma_core_auxiliary_drv = {
 		.remove = ig3rdma_core_remove,
 	},
 	.event_handler = ig3rdma_idc_core_event_handler,
-};
\ No newline at end of file
+};
+
+static int ig3rdma_vport_probe(struct auxiliary_device *aux_dev,
+			       const struct auxiliary_device_id *id)
+{
+	struct idc_rdma_vport_auxiliary_dev *idc_adev =
+		container_of(aux_dev, struct idc_rdma_vport_auxiliary_dev, adev);
+	struct auxiliary_device *aux_core_dev = idc_adev->vdev_info->core_adev;
+	struct irdma_pci_f *rf = auxiliary_get_drvdata(aux_core_dev);
+	struct iidc_rdma_qos_params qos_info = {};
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
+	iwdev->push_mode = true;
+
+	l2params.mtu = iwdev->netdev->mtu;
+	irdma_fill_qos_info(&l2params, &qos_info);
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
+	struct idc_rdma_vport_auxiliary_dev *idc_adev =
+		container_of(aux_dev, struct idc_rdma_vport_auxiliary_dev, adev);
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
+struct idc_rdma_vport_auxiliary_drv ig3rdma_vport_auxiliary_drv = {
+	.adrv = {
+		.name = "vdev",
+		.id_table = ig3rdma_vport_auxiliary_id_table,
+		.probe = ig3rdma_vport_probe,
+		.remove = ig3rdma_vport_remove,
+	},
+	.event_handler = ig3rdma_idc_vport_event_handler,
+};
diff --git a/drivers/infiniband/hw/irdma/main.c b/drivers/infiniband/hw/irdma/main.c
index e9524de..4b07b07 100644
--- a/drivers/infiniband/hw/irdma/main.c
+++ b/drivers/infiniband/hw/irdma/main.c
@@ -129,6 +129,17 @@ static int __init irdma_init_module(void)
 
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
@@ -168,6 +179,7 @@ static void __exit irdma_exit_module(void)
 	auxiliary_driver_unregister(&icrdma_core_auxiliary_drv.adrv);
 	auxiliary_driver_unregister(&i40iw_auxiliary_drv);
 	auxiliary_driver_unregister(&ig3rdma_core_auxiliary_drv.adrv);
+	auxiliary_driver_unregister(&ig3rdma_vport_auxiliary_drv.adrv);
 }
 
 module_init(irdma_init_module);
diff --git a/drivers/infiniband/hw/irdma/main.h b/drivers/infiniband/hw/irdma/main.h
index 1716933..1dab2ff 100644
--- a/drivers/infiniband/hw/irdma/main.h
+++ b/drivers/infiniband/hw/irdma/main.h
@@ -56,6 +56,7 @@
 
 extern struct auxiliary_driver i40iw_auxiliary_drv;
 extern struct idc_rdma_core_auxiliary_drv ig3rdma_core_auxiliary_drv;
+extern struct idc_rdma_vport_auxiliary_drv ig3rdma_vport_auxiliary_drv;
 extern struct idc_rdma_core_auxiliary_drv icrdma_core_auxiliary_drv;
 
 #define IRDMA_FW_VER_DEFAULT	2
@@ -353,12 +354,14 @@ struct irdma_device {
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
index 9a42a88..bb654f4 100644
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
 
@@ -4881,6 +4885,10 @@ void irdma_ib_dealloc_device(struct ib_device *ibdev)
 	struct irdma_device *iwdev = to_iwdev(ibdev);
 
 	irdma_rt_deinit_hw(iwdev);
-	irdma_ctrl_deinit_hw(iwdev->rf);
-	kfree(iwdev->rf);
+	if (!iwdev->is_vport) {
+		irdma_ctrl_deinit_hw(iwdev->rf);
+		if (iwdev->rf->vchnl_wq)
+			destroy_workqueue(iwdev->rf->vchnl_wq);
+		kfree(iwdev->rf);
+	}
 }
diff --git a/include/uapi/rdma/irdma-abi.h b/include/uapi/rdma/irdma-abi.h
index bb18f15..4e42054 100644
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
1.8.3.1


