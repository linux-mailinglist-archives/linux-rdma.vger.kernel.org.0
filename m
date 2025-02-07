Return-Path: <linux-rdma+bounces-7544-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6A2A2CD2A
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 20:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 386243ACDD7
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 19:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E907D1AE875;
	Fri,  7 Feb 2025 19:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WeaFPVI5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0811B0409;
	Fri,  7 Feb 2025 19:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738957836; cv=none; b=PLnC732N4MWHDLjjRYeJJuV/eIhdPcP5jbTev1v5Slfx8dR+7MxFRyIi+PacPtNATxkd4ktzpZ1+fxdqk9wetnv+mwI80y+X/FcvAXJ9a6iccCK5fsfT0kuJ4t8+UPSwXM9QyiY8aqsFkc0hCnQCeUndvLmCJxAhNaLxUpCfBTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738957836; c=relaxed/simple;
	bh=TeMXc1b6KlktiLZYTSK7kLkcWUMla5xDq2GCQlxHusI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ekf/ngKIF6NiMWzZbIT5mgK0gxLA28j4bM/PBtHot8Pd0pnCfI/ELE/z+qeKAZlKqMxV6O8v+0VU/f+ABdKxJbNENXYY9nsBU/lJfIQOcd7wE78VUXOudISsqbxxZHKIVQS12dSl8LfY7ohO1Nk80U8+vVwqPtuMaYURdF2zUq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WeaFPVI5; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738957835; x=1770493835;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TeMXc1b6KlktiLZYTSK7kLkcWUMla5xDq2GCQlxHusI=;
  b=WeaFPVI5Nz1fHn8vBaQgDsXJvRkHsLOJhd4uqEVx4x1Yk+FhcEMyPOTc
   x6++s7rdghy8NyIK/hxT8zBqATwZEohh+HTzwiGDgITWJ/pkwUzW+V/W0
   Uz5+mCE6ElE9mCWd8rh5Vu6bBF+aCt9DmQRYt0aUWuxX1YLq4JJfIhNHi
   SwkyLLz8OuEsV0EFI6eT6TSfOe39nW1sWUM94ayLe7X+PBtXvRMiTqbnn
   52GahMglBgpMfjQL5pQaLuZRQTr+ouKnsoV7tyaHyCfqVlMlM+zD42qsS
   GWfdIa6wZwvMIefc2Uztw9A/PoMiS9XPC5qgUOuQpeY0CLgPQrvwuaIba
   A==;
X-CSE-ConnectionGUID: c9EBOiYySie3i7+v8NRRuA==
X-CSE-MsgGUID: tCNQWasHRDOnJrRwT1KQ3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="42451816"
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="42451816"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 11:50:30 -0800
X-CSE-ConnectionGUID: 8ugmlWHVRJG7R/+O3KCM7g==
X-CSE-MsgGUID: A0eOb9UiT9qXMBj3EjX7tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="112238203"
Received: from tenikolo-mobl1.amr.corp.intel.com ([10.124.81.134])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 11:50:29 -0800
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org,
	intel-wired-lan@lists.osuosl.org
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [rdma v3 14/24] RDMA/irdma: Introduce GEN3 vPort driver support
Date: Fri,  7 Feb 2025 13:49:21 -0600
Message-Id: <20250207194931.1569-15-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20250207194931.1569-1-tatyana.e.nikolova@intel.com>
References: <20250207194931.1569-1-tatyana.e.nikolova@intel.com>
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
 drivers/infiniband/hw/irdma/ig3rdma_if.c | 108 +++++++++++++++++++++++
 drivers/infiniband/hw/irdma/main.c       |  12 +++
 drivers/infiniband/hw/irdma/main.h       |   3 +
 drivers/infiniband/hw/irdma/verbs.c      |  12 ++-
 include/uapi/rdma/irdma-abi.h            |   1 +
 5 files changed, 134 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/ig3rdma_if.c b/drivers/infiniband/hw/irdma/ig3rdma_if.c
index 9d0623467af2..2c7dc93dc576 100644
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
@@ -169,3 +186,94 @@ struct idc_rdma_core_auxiliary_drv ig3rdma_core_auxiliary_drv = {
 	},
 	.event_handler = ig3rdma_idc_core_event_handler,
 };
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
index e9524de1c10f..4b07b0719557 100644
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
index 17169338045a..1dab2ffba5e5 100644
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
index a0257b87d99f..2535e0f59ceb 100644
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
 
@@ -4882,6 +4886,10 @@ void irdma_ib_dealloc_device(struct ib_device *ibdev)
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
2.37.3


