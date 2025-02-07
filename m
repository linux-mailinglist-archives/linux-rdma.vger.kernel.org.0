Return-Path: <linux-rdma+bounces-7535-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DFAA2CD1A
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 20:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CDA37A454A
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 19:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F771A3143;
	Fri,  7 Feb 2025 19:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B1xQiby0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D033119E7F9;
	Fri,  7 Feb 2025 19:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738957829; cv=none; b=LGjhaXHAC+U6kCCjWNUn8RF5y7EmGv71JyIX2XhyUvuKtUhpy/K8oPnj+jv8L65IqqcWPn0aTWjBoi8zBipKFpV7Hs+f7sC3iLdRDPUgpQtlWBsPjKsb3r1whX/nkY3ejrSLYh2dr2H+en1JmUbA6pChvZLOME3B6a6YuOIUoWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738957829; c=relaxed/simple;
	bh=BYvwdoyOM9bMCEaG8Ien7H19KTobTmBZ0fBqCqtqAKY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tfRFXsfgh+L/26IMV2PJUhbV+yVHfWZHmYxsiQALG9JIiTG/ag4RAJIqw3Arj//bTZHAla+91a1k7bh0nn6ZAYlTxtGRjyo+93EFFP2p81keRtjXY/OUyMsl2n19L+VnP7XWlax7LPCMZ9npRqR3ZduE0r8Io3Oqw1p3z50cR2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B1xQiby0; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738957828; x=1770493828;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BYvwdoyOM9bMCEaG8Ien7H19KTobTmBZ0fBqCqtqAKY=;
  b=B1xQiby0jckZob8pwZ7C0dzmNC7y/iq5g0hB0Er9nO/B0mrm7qvODy3Q
   4eHDJARi6W8Yo9GHdb3LdIKqcW5wJKRoGNoQbHoGxBVyepb0T2cUpviPx
   pd4zLuEOBdx+mLQyUTik26inkK4ncnQQefi/377m8oPdEjeSyihA4Z6qb
   OPW/riyGt+1PPIpxqQTG2IiteBvJk8pE9UiCZO2qZ/CFLpu1vcV4bShql
   ZztyShIRsUKH9yiHlU/BQqxg+KdCtIliPc0mUyhSvTwTEJKVpcJzJav50
   xQaCp56SOq7/jsm1klktTwammTFvOXYrLQHiLyeHqXGqPHTbVBm35AQp4
   w==;
X-CSE-ConnectionGUID: 2dEQ8nb5RASq7m/hFxhZoA==
X-CSE-MsgGUID: 3kVIhGXsTRyoTWLQ1Bmu+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="42451759"
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="42451759"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 11:50:23 -0800
X-CSE-ConnectionGUID: zQYS9bTwR3+HqA8rQyau4A==
X-CSE-MsgGUID: odSKVUMIRmmJ98EjGgsd/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="112238126"
Received: from tenikolo-mobl1.amr.corp.intel.com ([10.124.81.134])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 11:50:23 -0800
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org,
	intel-wired-lan@lists.osuosl.org
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Joshua Hay <joshua.a.hay@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [iwl-next v3 04/24] idpf: implement RDMA vport auxiliary dev create, init, and destroy
Date: Fri,  7 Feb 2025 13:49:11 -0600
Message-Id: <20250207194931.1569-5-tatyana.e.nikolova@intel.com>
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

From: Joshua Hay <joshua.a.hay@intel.com>

Implement the functions to create, initialize, and destroy an RDMA vport
auxiliary device. The vport aux dev creation is dependent on the
core aux device to call idpf_idc_vport_dev_ctrl to signal that it is
ready for vport aux devices. Implement that core callback to either
create and initialize the vport aux dev or deinitialize.

Rdma vport aux dev creation is also dependent on the control plane to
tell us the vport is RDMA enabled. Add a flag in the create vport
message to signal individual vport RDMA capabilities.

Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---

v2: Guard against unplugging vport aux dev twice. This is possible if
irdma is unloaded and then idpf is unloaded. irdma calls
idpf_idc_vport_dev_down during its unload which calls unplug. Set the
adev to NULL in dev_down, so that the following call to
deinit_vport_aux_device during idpf unload will return early from
unplug.

v3:
- Used signed ret value from ida_alloc and only assign unsigned id if no
  err
- capitalize some abbreviations
- add missing field descriptions
- remove unnecessary casts

 drivers/net/ethernet/intel/idpf/idpf.h      |   4 +
 drivers/net/ethernet/intel/idpf/idpf_idc.c  | 178 +++++++++++++++++++-
 drivers/net/ethernet/intel/idpf/idpf_lib.c  |   2 +
 drivers/net/ethernet/intel/idpf/virtchnl2.h |  13 +-
 4 files changed, 194 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 64f731fe878c..a9c0639f0021 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -275,6 +275,7 @@ struct idpf_port_stats {
  *	      group will yield total number of RX queues.
  * @rxq_model: Splitq queue or single queue queuing model
  * @rx_ptype_lkup: Lookup table for ptypes on RX
+ * @vdev_info: IDC vport device info pointer
  * @adapter: back pointer to associated adapter
  * @netdev: Associated net_device. Each vport should have one and only one
  *	    associated netdev.
@@ -317,6 +318,8 @@ struct idpf_vport {
 	u32 rxq_model;
 	struct libeth_rx_pt *rx_ptype_lkup;
 
+	struct idc_rdma_vport_dev_info *vdev_info;
+
 	struct idpf_adapter *adapter;
 	struct net_device *netdev;
 	DECLARE_BITMAP(flags, IDPF_VPORT_FLAGS_NBITS);
@@ -868,5 +871,6 @@ int idpf_idc_init(struct idpf_adapter *adapter);
 int idpf_idc_init_aux_core_dev(struct idpf_adapter *adapter,
 			       enum idc_function_type ftype);
 void idpf_idc_deinit_core_aux_device(struct idc_rdma_core_dev_info *cdev_info);
+void idpf_idc_deinit_vport_aux_device(struct idc_rdma_vport_dev_info *vdev_info);
 
 #endif /* !_IDPF_H_ */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_idc.c b/drivers/net/ethernet/intel/idpf/idpf_idc.c
index 4c7cf32d4863..a9049cb616a9 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_idc.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_idc.c
@@ -30,6 +30,113 @@ int idpf_idc_init(struct idpf_adapter *adapter)
 	return err;
 }
 
+/**
+ * idpf_vport_adev_release - function to be mapped to aux dev's release op
+ * @dev: pointer to device to free
+ */
+static void idpf_vport_adev_release(struct device *dev)
+{
+	struct idc_rdma_vport_auxiliary_dev *iadev;
+
+	iadev = container_of(dev, struct idc_rdma_vport_auxiliary_dev, adev.dev);
+	kfree(iadev);
+	iadev = NULL;
+}
+
+/* idpf_plug_vport_aux_dev - allocate and register a vport Auxiliary device
+ * @cdev_info: IDC core device info pointer
+ * @vdev_info: IDC vport device info pointer
+ *
+ * Return: 0 on success or error code on failure.
+ */
+static int idpf_plug_vport_aux_dev(struct idc_rdma_core_dev_info *cdev_info,
+				   struct idc_rdma_vport_dev_info *vdev_info)
+{
+	struct idc_rdma_vport_auxiliary_dev *iadev;
+	char name[IDPF_IDC_MAX_ADEV_NAME_LEN];
+	struct auxiliary_device *adev;
+	int ret;
+
+	iadev = kzalloc(sizeof(*iadev), GFP_KERNEL);
+	if (!iadev)
+		return -ENOMEM;
+
+	adev = &iadev->adev;
+	vdev_info->adev = &iadev->adev;
+	iadev->vdev_info = vdev_info;
+
+	ret = ida_alloc(&idpf_idc_ida, GFP_KERNEL);
+	if (ret < 0) {
+		pr_err("failed to allocate unique device ID for Auxiliary driver\n");
+		goto err_ida_alloc;
+	}
+	adev->id = ret;
+	adev->dev.release = idpf_vport_adev_release;
+	adev->dev.parent = &cdev_info->pdev->dev;
+	sprintf(name, "%04x.rdma.vdev", cdev_info->pdev->vendor);
+	adev->name = name;
+
+	ret = auxiliary_device_init(adev);
+	if (ret)
+		goto err_aux_dev_init;
+
+	ret = auxiliary_device_add(adev);
+	if (ret)
+		goto err_aux_dev_add;
+
+	return 0;
+
+err_aux_dev_add:
+	vdev_info->adev = NULL;
+	auxiliary_device_uninit(adev);
+err_aux_dev_init:
+	ida_free(&idpf_idc_ida, adev->id);
+err_ida_alloc:
+	kfree(iadev);
+
+	return ret;
+}
+
+/**
+ * idpf_idc_init_aux_vport_dev - initialize vport Auxiliary Device(s)
+ * @vport: virtual port data struct
+ *
+ * Return: 0 on success or error code on failure.
+ */
+static int idpf_idc_init_aux_vport_dev(struct idpf_vport *vport)
+{
+	struct idpf_adapter *adapter = vport->adapter;
+	struct idc_rdma_vport_dev_info *vdev_info;
+	struct idc_rdma_core_dev_info *cdev_info;
+	struct virtchnl2_create_vport *vport_msg;
+	int err;
+
+	vport_msg = (struct virtchnl2_create_vport *)
+				adapter->vport_params_recvd[vport->idx];
+
+	if (!(le16_to_cpu(vport_msg->vport_flags) & VIRTCHNL2_VPORT_ENABLE_RDMA))
+		return 0;
+
+	vport->vdev_info = kzalloc(sizeof(*vdev_info), GFP_KERNEL);
+	if (!vport->vdev_info)
+		return -ENOMEM;
+
+	cdev_info = vport->adapter->cdev_info;
+
+	vdev_info = vport->vdev_info;
+	vdev_info->vport_id = vport->vport_id;
+	vdev_info->netdev = vport->netdev;
+	vdev_info->core_adev = cdev_info->adev;
+
+	err = idpf_plug_vport_aux_dev(cdev_info, vdev_info);
+	if (err) {
+		kfree(vdev_info);
+		return err;
+	}
+
+	return 0;
+}
+
 /**
  * idpf_core_adev_release - function to be mapped to aux dev's release op
  * @dev: pointer to device to free
@@ -100,12 +207,60 @@ static int idpf_plug_core_aux_dev(struct idc_rdma_core_dev_info *cdev_info)
  */
 static void idpf_unplug_aux_dev(struct auxiliary_device *adev)
 {
+	if (!adev)
+		return;
+
 	auxiliary_device_delete(adev);
 	auxiliary_device_uninit(adev);
 
 	ida_free(&idpf_idc_ida, adev->id);
 }
 
+/**
+ * idpf_idc_vport_dev_up - called when CORE is ready for vport aux devs
+ * @adapter: private data struct
+ *
+ * Return: 0 on success or error code on failure.
+ */
+static int idpf_idc_vport_dev_up(struct idpf_adapter *adapter)
+{
+	int i, err = 0;
+
+	for (i = 0; i < adapter->num_alloc_vports; i++) {
+		struct idpf_vport *vport = adapter->vports[i];
+
+		if (!vport)
+			continue;
+
+		if (!vport->vdev_info)
+			err = idpf_idc_init_aux_vport_dev(vport);
+		else
+			err = idpf_plug_vport_aux_dev(vport->adapter->cdev_info,
+						      vport->vdev_info);
+	}
+
+	return err;
+}
+
+/**
+ * idpf_idc_vport_dev_down - called CORE is leaving vport aux dev support state
+ * @adapter: private data struct
+ */
+static void idpf_idc_vport_dev_down(struct idpf_adapter *adapter)
+{
+	int i;
+
+	for (i = 0; i < adapter->num_alloc_vports; i++) {
+		struct idpf_vport *vport = adapter->vports[i];
+
+		if (!vport)
+			continue;
+
+		idpf_unplug_aux_dev(vport->vdev_info->adev);
+		vport->vdev_info->adev = NULL;
+	}
+}
+
 /**
  * idpf_idc_vport_dev_ctrl - Called by an Auxiliary Driver
  * @cdev_info: IDC core device info pointer
@@ -121,7 +276,14 @@ static int
 idpf_idc_vport_dev_ctrl(struct idc_rdma_core_dev_info *cdev_info,
 			bool up)
 {
-	return -EOPNOTSUPP;
+	struct idpf_adapter *adapter = pci_get_drvdata(cdev_info->pdev);
+
+	if (up)
+		return idpf_idc_vport_dev_up(adapter);
+
+	idpf_idc_vport_dev_down(adapter);
+
+	return 0;
 }
 
 /**
@@ -218,3 +380,17 @@ void idpf_idc_deinit_core_aux_device(struct idc_rdma_core_dev_info *cdev_info)
 	kfree(cdev_info->mapped_mem_regions);
 	kfree(cdev_info);
 }
+
+/**
+ * idpf_idc_deinit_vport_aux_device - de-initialize Auxiliary Device(s)
+ * @vdev_info: IDC vport device info pointer
+ */
+void idpf_idc_deinit_vport_aux_device(struct idc_rdma_vport_dev_info *vdev_info)
+{
+	if (!vdev_info)
+		return;
+
+	idpf_unplug_aux_dev(vdev_info->adev);
+
+	kfree(vdev_info);
+}
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 813c073dc45f..a211fca9e925 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1047,6 +1047,8 @@ static void idpf_vport_dealloc(struct idpf_vport *vport)
 	struct idpf_adapter *adapter = vport->adapter;
 	unsigned int i = vport->idx;
 
+	idpf_idc_deinit_vport_aux_device(vport->vdev_info);
+
 	idpf_deinit_mac_addr(vport);
 	idpf_vport_stop(vport);
 
diff --git a/drivers/net/ethernet/intel/idpf/virtchnl2.h b/drivers/net/ethernet/intel/idpf/virtchnl2.h
index 80c17e4a394e..673a39e6698d 100644
--- a/drivers/net/ethernet/intel/idpf/virtchnl2.h
+++ b/drivers/net/ethernet/intel/idpf/virtchnl2.h
@@ -562,6 +562,15 @@ struct virtchnl2_queue_reg_chunks {
 };
 VIRTCHNL2_CHECK_STRUCT_LEN(8, virtchnl2_queue_reg_chunks);
 
+/**
+ * enum virtchnl2_vport_flags - Vport flags
+ * @VIRTCHNL2_VPORT_ENABLE_RDMA: RDMA is enabled for this vport
+ */
+enum virtchnl2_vport_flags {
+	/* VIRTCHNL2_VPORT_* bits [0:3] rsvd */
+	VIRTCHNL2_VPORT_ENABLE_RDMA             = BIT(4),
+};
+
 /**
  * struct virtchnl2_create_vport - Create vport config info.
  * @vport_type: See enum virtchnl2_vport_type.
@@ -580,7 +589,7 @@ VIRTCHNL2_CHECK_STRUCT_LEN(8, virtchnl2_queue_reg_chunks);
  * @max_mtu: Max MTU. CP populates this field on response.
  * @vport_id: Vport id. CP populates this field on response.
  * @default_mac_addr: Default MAC address.
- * @pad: Padding.
+ * @vport_flags: See enum virtchnl2_vport_flags
  * @rx_desc_ids: See VIRTCHNL2_RX_DESC_IDS definitions.
  * @tx_desc_ids: See VIRTCHNL2_TX_DESC_IDS definitions.
  * @pad1: Padding.
@@ -613,7 +622,7 @@ struct virtchnl2_create_vport {
 	__le16 max_mtu;
 	__le32 vport_id;
 	u8 default_mac_addr[ETH_ALEN];
-	__le16 pad;
+	__le16 vport_flags;
 	__le64 rx_desc_ids;
 	__le64 tx_desc_ids;
 	u8 pad1[72];
-- 
2.37.3


