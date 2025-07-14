Return-Path: <linux-rdma+bounces-12152-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E2BB04741
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 20:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 547367ABD65
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 18:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BF2273D82;
	Mon, 14 Jul 2025 18:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XaB5mE0a"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268F226D4E2;
	Mon, 14 Jul 2025 18:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752516615; cv=none; b=DNXXn2dm4IHeNM/OkTbtqHXzBA/T8l84qF3j5JXWUlbZbC19Cp5rUfz9VP7ENfMT9JdP0wqtYzQQWC4YTknkkqy9hoHi07unNNL46Vi9pVQ4kJfA99UQFk49myiR0lbXEUX4Ns0MwMEGxWbPq0VOR7TW773ceUq95UTihjc4TzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752516615; c=relaxed/simple;
	bh=GuORu4mLE49bgOKkKRvnYrvQgcRvwmKYem4+rPy00sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hXZPkgG1Fv0L7udhLC/kVNDqaerax9Skch8spIFrhxNpVdJtvYPXPqb7bW1Wb/9WGTRSuL7qUdbktWrViIEje4NtpbQ7NV5O8h6+NrhU544KQoQnI2vvfRjj/O9k0p/mByEQeoLhFc5A0hAb7D8T48maJvrqXF5885cmwL/Cm+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XaB5mE0a; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752516613; x=1784052613;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GuORu4mLE49bgOKkKRvnYrvQgcRvwmKYem4+rPy00sk=;
  b=XaB5mE0antG2/JlRMTYYahVGV3e0l00XGsHk5gN0mydhtNbazlwfOe1U
   azoeDZb9AMaJRld53Pm3rU6ls3gtWzo6Dg1c1iGW2NzpPL8S/iE9JN7Lu
   fM8vqYnqS2MQgdzjGZSt+el/x5pAntDfoSa0L2f8ZkZws0GHHng5MBbMz
   eGIQOGPhmOUa6sfKlMOMM0qO4qXOygwyCUV/kB08/fn+9D0kQ9BF3+oLm
   IP50Tmf4N+aV8yzx3cAYMORdeOoF6u/db5MePMvj8WGT6jFyUf1tvtBgO
   2VPcLf6iQnp8igjasqkuSabiR4BEP+6LNd0nxEV/qfkSmX9qCUtRlcUeW
   w==;
X-CSE-ConnectionGUID: rtXrVEGlSCyG9sc0ZXM+fA==
X-CSE-MsgGUID: 5pTsBEDiQICsOyJhOsrQsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54592358"
X-IronPort-AV: E=Sophos;i="6.16,311,1744095600"; 
   d="scan'208";a="54592358"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 11:10:11 -0700
X-CSE-ConnectionGUID: F2k70UZ5SkG1KGdEKZnFgQ==
X-CSE-MsgGUID: pyTtL/ubSOmosPnI9XLNAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,311,1744095600"; 
   d="scan'208";a="162553814"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 14 Jul 2025 11:10:09 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Joshua Hay <joshua.a.hay@intel.com>,
	tatyana.e.nikolova@intel.com,
	Madhu Chittim <madhu.chittim@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next,rdma-next 3/6] idpf: implement RDMA vport auxiliary dev create, init, and destroy
Date: Mon, 14 Jul 2025 11:09:58 -0700
Message-ID: <20250714181002.2865694-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250714181002.2865694-1-anthony.l.nguyen@intel.com>
References: <20250714181002.2865694-1-anthony.l.nguyen@intel.com>
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

RDMA vport aux dev creation is also dependent on the control plane to
tell us the vport is RDMA enabled. Add a flag in the create vport
message to signal individual vport RDMA capabilities.

Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h      |   4 +
 drivers/net/ethernet/intel/idpf/idpf_idc.c  | 180 +++++++++++++++++++-
 drivers/net/ethernet/intel/idpf/idpf_lib.c  |   2 +
 drivers/net/ethernet/intel/idpf/virtchnl2.h |   3 +
 include/linux/net/intel/iidc_rdma_idpf.h    |  19 +++
 5 files changed, 207 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index dd2aa515a31b..7103cf551bb8 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -281,6 +281,7 @@ struct idpf_port_stats {
  *	      group will yield total number of RX queues.
  * @rxq_model: Splitq queue or single queue queuing model
  * @rx_ptype_lkup: Lookup table for ptypes on RX
+ * @vdev_info: IDC vport device info pointer
  * @adapter: back pointer to associated adapter
  * @netdev: Associated net_device. Each vport should have one and only one
  *	    associated netdev.
@@ -326,6 +327,8 @@ struct idpf_vport {
 	u32 rxq_model;
 	struct libeth_rx_pt *rx_ptype_lkup;
 
+	struct iidc_rdma_vport_dev_info *vdev_info;
+
 	struct idpf_adapter *adapter;
 	struct net_device *netdev;
 	DECLARE_BITMAP(flags, IDPF_VPORT_FLAGS_NBITS);
@@ -889,5 +892,6 @@ int idpf_idc_init(struct idpf_adapter *adapter);
 int idpf_idc_init_aux_core_dev(struct idpf_adapter *adapter,
 			       enum iidc_function_type ftype);
 void idpf_idc_deinit_core_aux_device(struct iidc_rdma_core_dev_info *cdev_info);
+void idpf_idc_deinit_vport_aux_device(struct iidc_rdma_vport_dev_info *vdev_info);
 
 #endif /* !_IDPF_H_ */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_idc.c b/drivers/net/ethernet/intel/idpf/idpf_idc.c
index bc90699f22c5..237dfe1ac06d 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_idc.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_idc.c
@@ -32,6 +32,115 @@ int idpf_idc_init(struct idpf_adapter *adapter)
 	return err;
 }
 
+/**
+ * idpf_vport_adev_release - function to be mapped to aux dev's release op
+ * @dev: pointer to device to free
+ */
+static void idpf_vport_adev_release(struct device *dev)
+{
+	struct iidc_rdma_vport_auxiliary_dev *iadev;
+
+	iadev = container_of(dev, struct iidc_rdma_vport_auxiliary_dev, adev.dev);
+	kfree(iadev);
+	iadev = NULL;
+}
+
+/**
+ * idpf_plug_vport_aux_dev - allocate and register a vport Auxiliary device
+ * @cdev_info: IDC core device info pointer
+ * @vdev_info: IDC vport device info pointer
+ *
+ * Return: 0 on success or error code on failure.
+ */
+static int idpf_plug_vport_aux_dev(struct iidc_rdma_core_dev_info *cdev_info,
+				   struct iidc_rdma_vport_dev_info *vdev_info)
+{
+	struct iidc_rdma_vport_auxiliary_dev *iadev;
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
+	auxiliary_device_uninit(adev);
+err_aux_dev_init:
+	ida_free(&idpf_idc_ida, adev->id);
+err_ida_alloc:
+	vdev_info->adev = NULL;
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
+	struct iidc_rdma_vport_dev_info *vdev_info;
+	struct iidc_rdma_core_dev_info *cdev_info;
+	struct virtchnl2_create_vport *vport_msg;
+	int err;
+
+	vport_msg = (struct virtchnl2_create_vport *)
+			adapter->vport_params_recvd[vport->idx];
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
+		vport->vdev_info = NULL;
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
@@ -104,12 +213,60 @@ static int idpf_plug_core_aux_dev(struct iidc_rdma_core_dev_info *cdev_info)
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
@@ -123,7 +280,14 @@ static void idpf_unplug_aux_dev(struct auxiliary_device *adev)
  */
 int idpf_idc_vport_dev_ctrl(struct iidc_rdma_core_dev_info *cdev_info, bool up)
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
 EXPORT_SYMBOL_GPL(idpf_idc_vport_dev_ctrl);
 
@@ -225,3 +389,17 @@ void idpf_idc_deinit_core_aux_device(struct iidc_rdma_core_dev_info *cdev_info)
 	kfree(cdev_info->iidc_priv);
 	kfree(cdev_info);
 }
+
+/**
+ * idpf_idc_deinit_vport_aux_device - de-initialize Auxiliary Device(s)
+ * @vdev_info: IDC vport device info pointer
+ */
+void idpf_idc_deinit_vport_aux_device(struct iidc_rdma_vport_dev_info *vdev_info)
+{
+	if (!vdev_info)
+		return;
+
+	idpf_unplug_aux_dev(vdev_info->adev);
+
+	kfree(vdev_info);
+}
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index b9e04ea2cbd4..30a7beb23155 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1021,6 +1021,8 @@ static void idpf_vport_dealloc(struct idpf_vport *vport)
 	struct idpf_adapter *adapter = vport->adapter;
 	unsigned int i = vport->idx;
 
+	idpf_idc_deinit_vport_aux_device(vport->vdev_info);
+
 	idpf_deinit_mac_addr(vport);
 	idpf_vport_stop(vport);
 
diff --git a/drivers/net/ethernet/intel/idpf/virtchnl2.h b/drivers/net/ethernet/intel/idpf/virtchnl2.h
index a2881979c7f8..82a3c307307e 100644
--- a/drivers/net/ethernet/intel/idpf/virtchnl2.h
+++ b/drivers/net/ethernet/intel/idpf/virtchnl2.h
@@ -575,9 +575,12 @@ VIRTCHNL2_CHECK_STRUCT_LEN(8, virtchnl2_queue_reg_chunks);
 /**
  * enum virtchnl2_vport_flags - Vport flags that indicate vport capabilities.
  * @VIRTCHNL2_VPORT_UPLINK_PORT: Representatives of underlying physical ports
+ * @VIRTCHNL2_VPORT_ENABLE_RDMA: RDMA is enabled for this vport
  */
 enum virtchnl2_vport_flags {
 	VIRTCHNL2_VPORT_UPLINK_PORT	= BIT(0),
+	/* VIRTCHNL2_VPORT_* bits [1:3] rsvd */
+	VIRTCHNL2_VPORT_ENABLE_RDMA             = BIT(4),
 };
 
 /**
diff --git a/include/linux/net/intel/iidc_rdma_idpf.h b/include/linux/net/intel/iidc_rdma_idpf.h
index f2fe1844f660..16c970dd4c6e 100644
--- a/include/linux/net/intel/iidc_rdma_idpf.h
+++ b/include/linux/net/intel/iidc_rdma_idpf.h
@@ -6,6 +6,25 @@
 
 #include <linux/auxiliary_bus.h>
 
+/* struct to be populated by core LAN PCI driver */
+struct iidc_rdma_vport_dev_info {
+	struct auxiliary_device *adev;
+	struct auxiliary_device *core_adev;
+	struct net_device *netdev;
+	u16 vport_id;
+};
+
+struct iidc_rdma_vport_auxiliary_dev {
+	struct auxiliary_device adev;
+	struct iidc_rdma_vport_dev_info *vdev_info;
+};
+
+struct iidc_rdma_vport_auxiliary_drv {
+	struct auxiliary_driver adrv;
+	void (*event_handler)(struct iidc_rdma_vport_dev_info *vdev,
+			      struct iidc_rdma_event *event);
+};
+
 /* struct to be populated by core LAN PCI driver */
 enum iidc_function_type {
 	IIDC_FUNCTION_TYPE_PF,
-- 
2.47.1


