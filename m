Return-Path: <linux-rdma+bounces-3954-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FEF93B980
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2024 01:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D718F1F22042
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jul 2024 23:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1C6145B00;
	Wed, 24 Jul 2024 23:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jo7LQepY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE71143888
	for <linux-rdma@vger.kernel.org>; Wed, 24 Jul 2024 23:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721864441; cv=none; b=qOH8yn8roeDnpIsseLK5DUEHFAZ+pDBJ0Gv9mlriRY13E7/QaxE4m8Gi6xGJnkKNRs1j/3A2LDciV4GK5WqKhAfTJW9wSvXwo2u3ms7PCbcvCggriAIMvecbqvw+eMdhv8NXfZmPuQuAoCB+hn8J584Cc/+OEvT9R17RUxk7eSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721864441; c=relaxed/simple;
	bh=OnBHFG5Pr6ADKwrVtJHTycEjn1QZrzo8yDVJoB29Xf8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=il5suvVBPAMwtywv7U65Ym58WlDgo60xgaT6jl2l6HemFyKPkSynmJhrAvzwO2VPQCfzohVvScucKjiNY3anCYAkM49TSSQP/jMVTU+d+3MSK6Z7H9X//yB8vmwtcXy7/Jh239ADyqwvh7RZbuw+ats2zdA5kokqCiDAwit8QZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jo7LQepY; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721864440; x=1753400440;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OnBHFG5Pr6ADKwrVtJHTycEjn1QZrzo8yDVJoB29Xf8=;
  b=Jo7LQepYSAh/Ralg/qpEWKHGj7sfdhUiDzMxi+SaIIRM7pP19QMK+HtB
   SO+4FfRuE0CK9cW92IR8Zzfb5MIDLLAoUukwleKdSTRMHAnHUnHqJYOSj
   6wpfYbmf14/2TEIhYjkCrUK0HlkJE/D1/mz18s2wehuZ6bqw5beLwZYwr
   tvynln1uXdxYQ/Xt6bUHQcAfjEVsDOf4tVhflyT/b7o/Lh9c3fNUBYSzI
   1pi1PLYZzzV60rY6WZWCIvFtthwVBXPCXgDmFUb05lE2ahJ1h9YxNY/UG
   vUi++AfJGo6bDFpVMejTeVqwzcVMnCvYvhDGaVqN++J0t3Lbwlq8QgAJ5
   g==;
X-CSE-ConnectionGUID: IKVNBEnlQRujCo9NqvZ/2w==
X-CSE-MsgGUID: wUvw665+QHCI1fDUBl6ofA==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="44999748"
X-IronPort-AV: E=Sophos;i="6.09,234,1716274800"; 
   d="scan'208";a="44999748"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 16:40:37 -0700
X-CSE-ConnectionGUID: pxPvqRryQZillXRucJVOWw==
X-CSE-MsgGUID: hlcswRXmS6Oqk1lgJ/BdvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,234,1716274800"; 
   d="scan'208";a="52426010"
Received: from tenikolo-mobl1.amr.corp.intel.com ([10.124.96.138])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 16:40:36 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	mustafa.ismail@intel.com,
	Joshua Hay <joshua.a.hay@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [RFC PATCH 05/25] idpf: implement rdma vport auxiliary dev create, init, and destroy
Date: Wed, 24 Jul 2024 18:38:57 -0500
Message-Id: <20240724233917.704-6-tatyana.e.nikolova@intel.com>
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

From: Joshua Hay <joshua.a.hay@intel.com>

Implement the functions to create, initialize, and destroy an rdma vport
auxiliary device. The vport aux dev creation is dependent on the
core aux device to call idpf_idc_vport_dev_ctrl to signal that it is
ready for vport aux devices. Implement that core callback to either
create and initialize the vport aux dev or deinitialize.

Rdma vport aux dev creation is also dependent on the control plane to
tell us the vport is rdma enabled. Add a flag in the create vport
message to signal individual vport rdma capabilities.

Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h      |   3 +
 drivers/net/ethernet/intel/idpf/idpf_idc.c  | 170 +++++++++++++++++++++++++++-
 drivers/net/ethernet/intel/idpf/idpf_lib.c  |   2 +
 drivers/net/ethernet/intel/idpf/virtchnl2.h |  13 ++-
 4 files changed, 185 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 9397208..46ec54e 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -319,6 +319,8 @@ struct idpf_vport {
 	u32 rxq_model;
 	struct idpf_rx_ptype_decoded rx_ptype_lkup[IDPF_RX_MAX_PTYPE];
 
+	struct idc_rdma_vport_dev_info *vdev_info;
+
 	struct idpf_adapter *adapter;
 	struct net_device *netdev;
 	DECLARE_BITMAP(flags, IDPF_VPORT_FLAGS_NBITS);
@@ -865,5 +867,6 @@ void idpf_vport_intr_write_itr(struct idpf_q_vector *q_vector,
 int idpf_idc_init_aux_core_dev(struct idpf_adapter *adapter,
 			       enum idc_function_type ftype);
 void idpf_idc_deinit_core_aux_device(struct idc_rdma_core_dev_info *cdev_info);
+void idpf_idc_deinit_vport_aux_device(struct idc_rdma_vport_dev_info *vdev_info);
 
 #endif /* !_IDPF_H_ */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_idc.c b/drivers/net/ethernet/intel/idpf/idpf_idc.c
index 9eb0e0c..bb69b2d 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_idc.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_idc.c
@@ -29,6 +29,111 @@ int idpf_idc_init(struct idpf_adapter *adapter)
 }
 
 /**
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
+ * @cdev_info: idc core device info pointer
+ * @vdev_info: idc vport device info pointer
+ */
+static int idpf_plug_vport_aux_dev(struct idc_rdma_core_dev_info *cdev_info,
+				   struct idc_rdma_vport_dev_info *vdev_info)
+{
+	struct idc_rdma_vport_auxiliary_dev *iadev;
+	char name[IDPF_IDC_MAX_ADEV_NAME_LEN];
+	struct auxiliary_device *adev;
+	int err;
+
+	iadev = (struct idc_rdma_vport_auxiliary_dev *)
+		kzalloc(sizeof(*iadev), GFP_KERNEL);
+	if (!iadev)
+		return -ENOMEM;
+
+	adev = &iadev->adev;
+	vdev_info->adev = &iadev->adev;
+	iadev->vdev_info = vdev_info;
+
+	adev->id = ida_alloc(&idpf_idc_ida, GFP_KERNEL);
+	if (adev->id < 0) {
+		pr_err("failed to allocate unique device ID for Auxiliary driver\n");
+		err = -ENOMEM;
+		goto err_ida_alloc;
+	}
+	adev->dev.release = idpf_vport_adev_release;
+	adev->dev.parent = &cdev_info->pdev->dev;
+	sprintf(name, "%04x.rdma.vdev", cdev_info->pdev->vendor);
+	adev->name = name;
+
+	err = auxiliary_device_init(adev);
+	if (err)
+		goto err_aux_dev_init;
+
+	err = auxiliary_device_add(adev);
+	if (err)
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
+	return err;
+}
+
+/**
+ * idpf_idc_init_aux_vport_dev - initialize vport Auxiliary Device(s)
+ * @vport: virtual port data struct
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
+	vport->vdev_info = (struct idc_rdma_vport_dev_info *)
+			kzalloc(sizeof(*vdev_info), GFP_KERNEL);
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
+/**
  * idpf_core_adev_release - function to be mapped to aux dev's release op
  * @dev: pointer to device to free
  */
@@ -104,6 +209,48 @@ static void idpf_unplug_aux_dev(struct auxiliary_device *adev)
 }
 
 /**
+ * idpf_idc_vport_dev_up - called when CORE is ready for vport aux devs
+ * @adapter: private data struct
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
+	}
+}
+
+/**
  * idpf_idc_vport_dev_ctrl - Called by an Auxiliary Driver
  * @cdev_info: idc core device info pointer
  * @up: RDMA core driver status
@@ -116,7 +263,14 @@ static void idpf_unplug_aux_dev(struct auxiliary_device *adev)
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
@@ -210,3 +364,17 @@ void idpf_idc_deinit_core_aux_device(struct idc_rdma_core_dev_info *cdev_info)
 	kfree(cdev_info->mapped_mem_regions);
 	kfree(cdev_info);
 }
+
+/**
+ * idpf_idc_deinit_vport_aux_device - de-initialize Auxiliary Device(s)
+ * @vdev_info: idc vport device info pointer
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
index 5e1414b..718d40c 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1056,6 +1056,8 @@ static void idpf_vport_dealloc(struct idpf_vport *vport)
 	struct idpf_adapter *adapter = vport->adapter;
 	unsigned int i = vport->idx;
 
+	idpf_idc_deinit_vport_aux_device(vport->vdev_info);
+
 	idpf_deinit_mac_addr(vport);
 	idpf_vport_stop(vport);
 
diff --git a/drivers/net/ethernet/intel/idpf/virtchnl2.h b/drivers/net/ethernet/intel/idpf/virtchnl2.h
index 80c17e4..673a39e 100644
--- a/drivers/net/ethernet/intel/idpf/virtchnl2.h
+++ b/drivers/net/ethernet/intel/idpf/virtchnl2.h
@@ -563,6 +563,15 @@ struct virtchnl2_queue_reg_chunks {
 VIRTCHNL2_CHECK_STRUCT_LEN(8, virtchnl2_queue_reg_chunks);
 
 /**
+ * enum virtchnl2_vport_flags - Vport flags
+ * @VIRTCHNL2_VPORT_ENABLE_RDMA: RDMA is enabled for this vport
+ */
+enum virtchnl2_vport_flags {
+	/* VIRTCHNL2_VPORT_* bits [0:3] rsvd */
+	VIRTCHNL2_VPORT_ENABLE_RDMA             = BIT(4),
+};
+
+/**
  * struct virtchnl2_create_vport - Create vport config info.
  * @vport_type: See enum virtchnl2_vport_type.
  * @txq_model: See virtchnl2_queue_model.
@@ -580,7 +589,7 @@ struct virtchnl2_queue_reg_chunks {
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
1.8.3.1


