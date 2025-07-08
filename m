Return-Path: <linux-rdma+bounces-11977-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F0EAFD939
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 23:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F98E3BB885
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 21:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6B8246BA1;
	Tue,  8 Jul 2025 21:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eLSGfBG1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409DC245005;
	Tue,  8 Jul 2025 21:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752008817; cv=none; b=prws+FYs21vOAujp5YeAQb/KEJCJIckKmECBAut+2UUlZEZQeuiVV3FIxlkh9G/mUv4WQ7njzjrJ8RhYAjOKJRUcgUt2vV4iyUyZ2ahF4PZLR457xTrBRKJksimxbSvksjbAnygTpPGSaXPkNlfiiYpj4OfEBQUBUBjg43XgdzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752008817; c=relaxed/simple;
	bh=pmyyA9Ini25VJz54+3dOozHvAKH7NFdCEriuVgjBBLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uccmHTnQqfbijSKuPmuYGeIyeGLEZfqdBPH260pdLA+fCC/aF5EvR4/4gRVUgouevi591cHWlllFgRp2AaoQE1DQKfD7ZsWUKXCwhNh6hvvYYijmK8fn/kEi136MzJw/zd8UNg3Sivh7xzOut9NYqBDq3EWcIloTLnBe6SfAQaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eLSGfBG1; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752008815; x=1783544815;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pmyyA9Ini25VJz54+3dOozHvAKH7NFdCEriuVgjBBLA=;
  b=eLSGfBG1MS9fkOFC0+4GoCVV18VJA5QOtoFTOqdeRYkI0EiqbyUIZLNK
   hWFSMU79QdmKZsroHolNxe2kt760bGfhXC2VrMSwTaE4zciszPeOG8KaS
   WHEJ7Oz9ZNar1uo+qhOmMImP0hRGunBsZUkaeUyuaq6VP0BZ5pD/c+4/+
   XS2o5eH3dZ4Djx+MwtyZbCtYh7R3BBVr6ZlkFFoneJzQoZRY8K9v5TqRb
   SocavVKAXM81lvbrEITubcLUFNWDl1bde2/72TrABI4gac5/UuLYwNDCn
   EiAvrYWk7lob6AyQigp2UV3fLg7K/zLsauuIg1TrL4RdJ0RaBed5CXIfy
   Q==;
X-CSE-ConnectionGUID: 7qtm56nbSnG13Qy20v1fVg==
X-CSE-MsgGUID: AYg10O+vTo2ZQM6k0V5JBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54391714"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54391714"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 14:06:54 -0700
X-CSE-ConnectionGUID: HYCGKyV3Tzqd2GrtVTjgmA==
X-CSE-MsgGUID: eTruB9OGSXWGl+sRh7+lyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="179276535"
Received: from pthorat-mobl.amr.corp.intel.com (HELO soc-PF51RAGT.clients.intel.com) ([10.246.116.180])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 14:06:53 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: jgg@nvidia.com,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	Joshua Hay <joshua.a.hay@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [iwl-next v3 2/6] idpf: implement core RDMA auxiliary dev create, init, and destroy
Date: Tue,  8 Jul 2025 16:05:50 -0500
Message-ID: <20250708210554.1662-3-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250708210554.1662-1-tatyana.e.nikolova@intel.com>
References: <20250708210554.1662-1-tatyana.e.nikolova@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joshua Hay <joshua.a.hay@intel.com>

Add the initial idpf_idc.c file with the functions to kick off the IDC
initialization, create and initialize a core RDMA auxiliary device, and
destroy said device.

The RDMA core has a dependency on the vports being created by the
control plane before it can be initialized. Therefore, once all the
vports are up after a hard reset (either during driver load a function
level reset), the core RDMA device info will be created. It is populated
with the function type (as distinguished by the IDC initialization
function pointer), the core idc_ops function points (just stubs for
now), the reserved RDMA MSIX table, and various other info the core RDMA
auxiliary driver will need. It is then plugged on to the bus.

During a function level reset or driver unload, the device will be
unplugged from the bus and destroyed.

Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---

v3:
- Include <linux/export.h> to fix kernel auto build test warning:
"EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing"

v2:
- initialize cdev_info earlier to properly free it in error path

Changes since split (v1):
- replace core dev_ops with exported symbols
- align with new header split scheme (idc_rdma->iidc_rdma and
  iidc_rdma_idpf specific header)

[3]:
- use signed ret value from ida_alloc and only assign
  unsigned id if no err
- capitalize some abbreviations
- add missing field descriptions

 drivers/net/ethernet/intel/idpf/Makefile      |   1 +
 drivers/net/ethernet/intel/idpf/idpf.h        |  11 +
 drivers/net/ethernet/intel/idpf/idpf_dev.c    |  13 +
 drivers/net/ethernet/intel/idpf/idpf_idc.c    | 225 ++++++++++++++++++
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |   4 +
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |  13 +
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  21 ++
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |   3 +
 include/linux/net/intel/iidc_rdma_idpf.h      |  28 +++
 9 files changed, 319 insertions(+)
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_idc.c
 create mode 100644 include/linux/net/intel/iidc_rdma_idpf.h

diff --git a/drivers/net/ethernet/intel/idpf/Makefile b/drivers/net/ethernet/intel/idpf/Makefile
index 83ac5e296382..4ef4b2b5e37a 100644
--- a/drivers/net/ethernet/intel/idpf/Makefile
+++ b/drivers/net/ethernet/intel/idpf/Makefile
@@ -10,6 +10,7 @@ idpf-y := \
 	idpf_controlq_setup.o	\
 	idpf_dev.o		\
 	idpf_ethtool.o		\
+	idpf_idc.o		\
 	idpf_lib.o		\
 	idpf_main.o		\
 	idpf_txrx.o		\
diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index d9f06764aba0..6b1cc55e34a3 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -17,6 +17,8 @@ struct idpf_vport_max_q;
 #include <linux/sctp.h>
 #include <linux/ethtool_netlink.h>
 #include <net/gro.h>
+#include <linux/net/intel/iidc_rdma.h>
+#include <linux/net/intel/iidc_rdma_idpf.h>
 
 #include "virtchnl2.h"
 #include "idpf_txrx.h"
@@ -206,9 +208,12 @@ struct idpf_reg_ops {
 /**
  * struct idpf_dev_ops - Device specific operations
  * @reg_ops: Register operations
+ * @idc_init: IDC initialization
  */
 struct idpf_dev_ops {
 	struct idpf_reg_ops reg_ops;
+
+	int (*idc_init)(struct idpf_adapter *adapter);
 };
 
 /**
@@ -540,6 +545,7 @@ struct idpf_vc_xn_manager;
  * @caps: Negotiated capabilities with device
  * @vcxn_mngr: Virtchnl transaction manager
  * @dev_ops: See idpf_dev_ops
+ * @cdev_info: IDC core device info pointer
  * @num_vfs: Number of allocated VFs through sysfs. PF does not directly talk
  *	     to VFs but is used to initialize them
  * @crc_enable: Enable CRC insertion offload
@@ -599,6 +605,7 @@ struct idpf_adapter {
 	struct idpf_vc_xn_manager *vcxn_mngr;
 
 	struct idpf_dev_ops dev_ops;
+	struct iidc_rdma_core_dev_info *cdev_info;
 	int num_vfs;
 	bool crc_enable;
 	bool req_tx_splitq;
@@ -877,5 +884,9 @@ int idpf_sriov_configure(struct pci_dev *pdev, int num_vfs);
 
 u8 idpf_vport_get_hsplit(const struct idpf_vport *vport);
 bool idpf_vport_set_hsplit(const struct idpf_vport *vport, u8 val);
+int idpf_idc_init(struct idpf_adapter *adapter);
+int idpf_idc_init_aux_core_dev(struct idpf_adapter *adapter,
+			       enum iidc_function_type ftype);
+void idpf_idc_deinit_core_aux_device(struct iidc_rdma_core_dev_info *cdev_info);
 
 #endif /* !_IDPF_H_ */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_dev.c b/drivers/net/ethernet/intel/idpf/idpf_dev.c
index 3fae81f1f988..dd227a4368fb 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_dev.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_dev.c
@@ -161,6 +161,17 @@ static void idpf_ptp_reg_init(const struct idpf_adapter *adapter)
 	adapter->ptp->cmd.exec_cmd_mask = PF_GLTSYN_CMD_SYNC_EXEC_CMD_M;
 }
 
+/**
+ * idpf_idc_register - register for IDC callbacks
+ * @adapter: Driver specific private structure
+ *
+ * Return: 0 on success or error code on failure.
+ */
+static int idpf_idc_register(struct idpf_adapter *adapter)
+{
+	return idpf_idc_init_aux_core_dev(adapter, IIDC_FUNCTION_TYPE_PF);
+}
+
 /**
  * idpf_reg_ops_init - Initialize register API function pointers
  * @adapter: Driver specific private structure
@@ -182,4 +193,6 @@ static void idpf_reg_ops_init(struct idpf_adapter *adapter)
 void idpf_dev_ops_init(struct idpf_adapter *adapter)
 {
 	idpf_reg_ops_init(adapter);
+
+	adapter->dev_ops.idc_init = idpf_idc_register;
 }
diff --git a/drivers/net/ethernet/intel/idpf/idpf_idc.c b/drivers/net/ethernet/intel/idpf/idpf_idc.c
new file mode 100644
index 000000000000..fc5485e348a4
--- /dev/null
+++ b/drivers/net/ethernet/intel/idpf/idpf_idc.c
@@ -0,0 +1,225 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2025 Intel Corporation */
+
+#include <linux/export.h>
+
+#include "idpf.h"
+#include "idpf_virtchnl.h"
+
+static DEFINE_IDA(idpf_idc_ida);
+
+#define IDPF_IDC_MAX_ADEV_NAME_LEN	15
+
+/**
+ * idpf_idc_init - Called to initialize IDC
+ * @adapter: driver private data structure
+ *
+ * Return: 0 on success or cap not enabled, error code on failure.
+ */
+int idpf_idc_init(struct idpf_adapter *adapter)
+{
+	int err;
+
+	if (!idpf_is_rdma_cap_ena(adapter) ||
+	    !adapter->dev_ops.idc_init)
+		return 0;
+
+	err = adapter->dev_ops.idc_init(adapter);
+	if (err)
+		dev_err(&adapter->pdev->dev, "failed to initialize idc: %d\n",
+			err);
+
+	return err;
+}
+
+/**
+ * idpf_core_adev_release - function to be mapped to aux dev's release op
+ * @dev: pointer to device to free
+ */
+static void idpf_core_adev_release(struct device *dev)
+{
+	struct iidc_rdma_core_auxiliary_dev *iadev;
+
+	iadev = container_of(dev, struct iidc_rdma_core_auxiliary_dev, adev.dev);
+	kfree(iadev);
+	iadev = NULL;
+}
+
+/* idpf_plug_core_aux_dev - allocate and register an Auxiliary device
+ * @cdev_info: IDC core device info pointer
+ *
+ * Return: 0 on success or error code on failure.
+ */
+static int idpf_plug_core_aux_dev(struct iidc_rdma_core_dev_info *cdev_info)
+{
+	struct iidc_rdma_core_auxiliary_dev *iadev;
+	char name[IDPF_IDC_MAX_ADEV_NAME_LEN];
+	struct auxiliary_device *adev;
+	int ret;
+
+	iadev = kzalloc(sizeof(*iadev), GFP_KERNEL);
+	if (!iadev)
+		return -ENOMEM;
+
+	adev = &iadev->adev;
+	cdev_info->adev = adev;
+	iadev->cdev_info = cdev_info;
+
+	ret = ida_alloc(&idpf_idc_ida, GFP_KERNEL);
+	if (ret < 0) {
+		pr_err("failed to allocate unique device ID for Auxiliary driver\n");
+		goto err_ida_alloc;
+	}
+	adev->id = ret;
+	adev->dev.release = idpf_core_adev_release;
+	adev->dev.parent = &cdev_info->pdev->dev;
+	sprintf(name, "%04x.rdma.core", cdev_info->pdev->vendor);
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
+	cdev_info->adev = NULL;
+	auxiliary_device_uninit(adev);
+err_aux_dev_init:
+	ida_free(&idpf_idc_ida, adev->id);
+err_ida_alloc:
+	kfree(iadev);
+
+	return ret;
+}
+
+/* idpf_unplug_aux_dev - unregister and free an Auxiliary device
+ * @adev: auxiliary device struct
+ */
+static void idpf_unplug_aux_dev(struct auxiliary_device *adev)
+{
+	auxiliary_device_delete(adev);
+	auxiliary_device_uninit(adev);
+
+	ida_free(&idpf_idc_ida, adev->id);
+}
+
+/**
+ * idpf_idc_vport_dev_ctrl - Called by an Auxiliary Driver
+ * @cdev_info: IDC core device info pointer
+ * @up: RDMA core driver status
+ *
+ * This callback function is accessed by an Auxiliary Driver to indicate
+ * whether core driver is ready to support vport driver load or if vport
+ * drivers need to be taken down.
+ *
+ * Return: 0 on success or error code on failure.
+ */
+int idpf_idc_vport_dev_ctrl(struct iidc_rdma_core_dev_info *cdev_info, bool up)
+{
+	return -EOPNOTSUPP;
+}
+EXPORT_SYMBOL_GPL(idpf_idc_vport_dev_ctrl);
+
+/**
+ * idpf_idc_request_reset - Called by an Auxiliary Driver
+ * @cdev_info: IDC core device info pointer
+ * @reset_type: function, core or other
+ *
+ * This callback function is accessed by an Auxiliary Driver to request a reset
+ * on the Auxiliary Device.
+ *
+ * Return: 0 on success or error code on failure.
+ */
+int idpf_idc_request_reset(struct iidc_rdma_core_dev_info *cdev_info,
+			   enum iidc_rdma_reset_type __always_unused reset_type)
+{
+	return -EOPNOTSUPP;
+}
+EXPORT_SYMBOL_GPL(idpf_idc_request_reset);
+
+/**
+ * idpf_idc_init_msix_data - initialize MSIX data for the cdev_info structure
+ * @adapter: driver private data structure
+ */
+static void
+idpf_idc_init_msix_data(struct idpf_adapter *adapter)
+{
+	struct iidc_rdma_core_dev_info *cdev_info;
+	struct iidc_rdma_priv_dev_info *privd;
+
+	if (!adapter->rdma_msix_entries)
+		return;
+
+	cdev_info = adapter->cdev_info;
+	privd = cdev_info->iidc_priv;
+
+	privd->msix_entries = adapter->rdma_msix_entries;
+	privd->msix_count = adapter->num_rdma_msix_entries;
+}
+
+/**
+ * idpf_idc_init_aux_core_dev - initialize Auxiliary Device(s)
+ * @adapter: driver private data structure
+ * @ftype: PF or VF
+ *
+ * Return: 0 on success or error code on failure.
+ */
+int idpf_idc_init_aux_core_dev(struct idpf_adapter *adapter,
+			       enum iidc_function_type ftype)
+{
+	struct iidc_rdma_core_dev_info *cdev_info;
+	struct iidc_rdma_priv_dev_info *privd;
+	int err;
+
+	adapter->cdev_info = kzalloc(sizeof(*cdev_info), GFP_KERNEL);
+	if (!adapter->cdev_info)
+		return -ENOMEM;
+	cdev_info = adapter->cdev_info;
+
+	privd = kzalloc(sizeof(*privd), GFP_KERNEL);
+	if (!privd) {
+		err = -ENOMEM;
+		goto err_privd_alloc;
+	}
+
+	cdev_info->iidc_priv = privd;
+	cdev_info->pdev = adapter->pdev;
+	cdev_info->rdma_protocol = IIDC_RDMA_PROTOCOL_ROCEV2;
+	privd->ftype = ftype;
+
+	idpf_idc_init_msix_data(adapter);
+
+	err = idpf_plug_core_aux_dev(cdev_info);
+	if (err)
+		goto err_plug_aux_dev;
+
+	return 0;
+
+err_plug_aux_dev:
+	kfree(privd);
+err_privd_alloc:
+	kfree(cdev_info);
+	adapter->cdev_info = NULL;
+
+	return err;
+}
+
+/**
+ * idpf_idc_deinit_core_aux_device - de-initialize Auxiliary Device(s)
+ * @cdev_info: IDC core device info pointer
+ */
+void idpf_idc_deinit_core_aux_device(struct iidc_rdma_core_dev_info *cdev_info)
+{
+	if (!cdev_info)
+		return;
+
+	idpf_unplug_aux_dev(cdev_info->adev);
+
+	kfree(cdev_info->iidc_priv);
+	kfree(cdev_info);
+}
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 71d1577ca9e4..2c9fda5783f8 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1834,6 +1834,10 @@ static int idpf_init_hard_reset(struct idpf_adapter *adapter)
 unlock_mutex:
 	mutex_unlock(&adapter->vport_ctrl_lock);
 
+	/* Wait until all vports are created to init RDMA CORE AUX */
+	if (!err)
+		err = idpf_idc_init(adapter);
+
 	return err;
 }
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c b/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
index aba828abcb17..2f84bd596ae4 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
@@ -147,6 +147,17 @@ static void idpf_vf_trigger_reset(struct idpf_adapter *adapter,
 		idpf_send_mb_msg(adapter, VIRTCHNL2_OP_RESET_VF, 0, NULL, 0);
 }
 
+/**
+ * idpf_idc_vf_register - register for IDC callbacks
+ * @adapter: Driver specific private structure
+ *
+ * Return: 0 on success or error code on failure.
+ */
+static int idpf_idc_vf_register(struct idpf_adapter *adapter)
+{
+	return idpf_idc_init_aux_core_dev(adapter, IIDC_FUNCTION_TYPE_VF);
+}
+
 /**
  * idpf_vf_reg_ops_init - Initialize register API function pointers
  * @adapter: Driver specific private structure
@@ -167,4 +178,6 @@ static void idpf_vf_reg_ops_init(struct idpf_adapter *adapter)
 void idpf_vf_dev_ops_init(struct idpf_adapter *adapter)
 {
 	idpf_vf_reg_ops_init(adapter);
+
+	adapter->dev_ops.idc_init = idpf_idc_vf_register;
 }
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 24febaaa8fbb..f7e105c67baf 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (C) 2023 Intel Corporation */
 
+#include <linux/export.h>
 #include <net/libeth/rx.h>
 
 #include "idpf.h"
@@ -868,6 +869,7 @@ static int idpf_send_get_caps_msg(struct idpf_adapter *adapter)
 
 	caps.other_caps =
 		cpu_to_le64(VIRTCHNL2_CAP_SRIOV			|
+			    VIRTCHNL2_CAP_RDMA                  |
 			    VIRTCHNL2_CAP_MACFILTER		|
 			    VIRTCHNL2_CAP_SPLITQ_QSCHED		|
 			    VIRTCHNL2_CAP_PROMISC		|
@@ -3070,6 +3072,7 @@ void idpf_vc_core_deinit(struct idpf_adapter *adapter)
 
 	idpf_ptp_release(adapter);
 	idpf_deinit_task(adapter);
+	idpf_idc_deinit_core_aux_device(adapter->cdev_info);
 	idpf_intr_rel(adapter);
 
 	if (remove_in_prog)
@@ -3728,3 +3731,21 @@ int idpf_set_promiscuous(struct idpf_adapter *adapter,
 
 	return reply_sz < 0 ? reply_sz : 0;
 }
+
+/**
+ * idpf_idc_rdma_vc_send_sync - virtchnl send callback for IDC registered drivers
+ * @cdev_info: IDC core device info pointer
+ * @send_msg: message to send
+ * @msg_size: size of message to send
+ * @recv_msg: message to populate on reception of response
+ * @recv_len: length of message copied into recv_msg or 0 on error
+ *
+ * Return: 0 on success or error code on failure.
+ */
+int idpf_idc_rdma_vc_send_sync(struct iidc_rdma_core_dev_info *cdev_info,
+			       u8 *send_msg, u16 msg_size,
+			       u8 *recv_msg, u16 *recv_len)
+{
+	return -EOPNOTSUPP;
+}
+EXPORT_SYMBOL_GPL(idpf_idc_rdma_vc_send_sync);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
index 77578206bada..7bae09483aed 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
@@ -151,5 +151,8 @@ int idpf_send_set_sriov_vfs_msg(struct idpf_adapter *adapter, u16 num_vfs);
 int idpf_send_get_set_rss_key_msg(struct idpf_vport *vport, bool get);
 int idpf_send_get_set_rss_lut_msg(struct idpf_vport *vport, bool get);
 void idpf_vc_xn_shutdown(struct idpf_vc_xn_manager *vcxn_mngr);
+int idpf_idc_rdma_vc_send_sync(struct iidc_rdma_core_dev_info *cdev_info,
+			       u8 *send_msg, u16 msg_size,
+			       u8 *recv_msg, u16 *recv_len);
 
 #endif /* _IDPF_VIRTCHNL_H_ */
diff --git a/include/linux/net/intel/iidc_rdma_idpf.h b/include/linux/net/intel/iidc_rdma_idpf.h
new file mode 100644
index 000000000000..f2fe1844f660
--- /dev/null
+++ b/include/linux/net/intel/iidc_rdma_idpf.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2025 Intel Corporation. */
+
+#ifndef _IIDC_RDMA_IDPF_H_
+#define _IIDC_RDMA_IDPF_H_
+
+#include <linux/auxiliary_bus.h>
+
+/* struct to be populated by core LAN PCI driver */
+enum iidc_function_type {
+	IIDC_FUNCTION_TYPE_PF,
+	IIDC_FUNCTION_TYPE_VF,
+};
+
+struct iidc_rdma_priv_dev_info {
+	struct msix_entry *msix_entries;
+	u16 msix_count; /* How many vectors are reserved for this device */
+	enum iidc_function_type ftype;
+};
+
+int idpf_idc_vport_dev_ctrl(struct iidc_rdma_core_dev_info *cdev_info, bool up);
+int idpf_idc_request_reset(struct iidc_rdma_core_dev_info *cdev_info,
+			   enum iidc_rdma_reset_type __always_unused reset_type);
+int idpf_idc_rdma_vc_send_sync(struct iidc_rdma_core_dev_info *cdev_info,
+			       u8 *send_msg, u16 msg_size,
+			       u8 *recv_msg, u16 *recv_len);
+
+#endif /* _IIDC_RDMA_IDPF_H_ */
-- 
2.37.3


