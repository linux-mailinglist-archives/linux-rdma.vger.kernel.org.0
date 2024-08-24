Return-Path: <linux-rdma+bounces-4532-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E901B95DAD5
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Aug 2024 05:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DC1A1C215F7
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Aug 2024 03:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C78836127;
	Sat, 24 Aug 2024 03:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eba3/D+S"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255BD29CFB;
	Sat, 24 Aug 2024 03:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724469643; cv=none; b=bSsE+vQQun5JOfF3LJJ3asSkDaYFhDAafdrnpdOUNxUZ1qtu2TMuFKeYPr2BtNKiVdqwgKYhJqhtMiJ271RatQOyyK00beGG6rzb+owZIDYWIQp14xkVyivz5S8HM12Xk/5UVlp/0CEMzf1lZ3LEcrTgqcC6PBfwqwZ1kmh0GgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724469643; c=relaxed/simple;
	bh=PP+U0LTwmrmgMb+yhWXSf0DiOEdXv4/bcRbPuADeh5M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D/iHIFhmEgDBruD7A3LJYd1cFGwYZXSwCPPDqAWiMiLJwIIavIlSQt7u7nBSfIanFASs5zjGhOlKrMplPtn5KuiRTf++UClbbgKvoSY8LLBwqW84K8MpJmXdSflQyq1Eyuv1J1ZvJxEmKf9uAuLvil0QUgTWrl4lTovjrGCdrL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eba3/D+S; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724469641; x=1756005641;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PP+U0LTwmrmgMb+yhWXSf0DiOEdXv4/bcRbPuADeh5M=;
  b=eba3/D+SFtP4lh5sobcDtU76nyjzWRdzDORkVZ8B5cs98+d9x1h7Yh4a
   cHbV6HjkhWhcuMmuMtGgPQt/xfCHJJ5A+Z5UekGa+uPwZeyEudRx3iXhz
   /flVOJDxyA9I0MY3J5KQOEhr1ghc2VG86I3/dN1yByGaVstTeePZmKhwO
   0SqpcGEuQYlEDlu3arnkbthlDjDzSzmQaxVS9U+0C7hdnx8fE8TWQnhXk
   NBR0OauNgA0hGuoXqIv121R8RIKKS5VFa3iLZ67I/CER1f32GwW6xhEOR
   b5JRpP2Nh17R478NvLtyXZIk4VtNEE84Fc5vUpAPQRYXtTLrjPhqDmPgA
   Q==;
X-CSE-ConnectionGUID: XTbLsz9HS7WdtMaYGGuHVA==
X-CSE-MsgGUID: IXH6WpNuRcqK9FvpAPASOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11173"; a="13187773"
X-IronPort-AV: E=Sophos;i="6.10,172,1719903600"; 
   d="scan'208";a="13187773"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 20:20:40 -0700
X-CSE-ConnectionGUID: y4K9M2zrTdKAP70EXOuj1g==
X-CSE-MsgGUID: kBB4236CR8aCjDB82ryRWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,172,1719903600"; 
   d="scan'208";a="99492077"
Received: from tenikolo-mobl1.amr.corp.intel.com ([10.124.36.66])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 20:20:39 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Joshua Hay <joshua.a.hay@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [RFC v2 03/25] idpf: implement core rdma auxiliary dev create, init, and destroy
Date: Fri, 23 Aug 2024 22:19:02 -0500
Message-Id: <20240824031924.421-4-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20240824031924.421-1-tatyana.e.nikolova@intel.com>
References: <20240824031924.421-1-tatyana.e.nikolova@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joshua Hay <joshua.a.hay@intel.com>

Add the initial idpf_idc.c file with the functions to kick off the idc
initialization, create and initialize a core rdma auxiliary device, and
destroy said device.

The rdma core has a dependency on the vports being created by the
control plane before it can be initialized. Therefore, once all the
vports are up after a hard reset (either during driver load a function
level reset), the core rdma device info will be created. It is populated
with the function type (as distinguished by the idc initialization
function pointer), the core idc_ops function points (just stubs for
now), the reserved rdma msix table, and various other info the core rdma
auxiliary driver will need. It is then plugged on to the bus.

During a function level reset or driver unload, the device will be
unplugged from the bus and destroyed.

Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 drivers/net/ethernet/intel/idpf/Makefile      |   1 +
 drivers/net/ethernet/intel/idpf/idpf.h        |   8 +
 drivers/net/ethernet/intel/idpf/idpf_dev.c    |  11 +
 drivers/net/ethernet/intel/idpf/idpf_idc.c    | 212 ++++++++++++++++++
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |   4 +
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |  11 +
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  17 ++
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |   3 +
 8 files changed, 267 insertions(+)
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_idc.c

diff --git a/drivers/net/ethernet/intel/idpf/Makefile b/drivers/net/ethernet/intel/idpf/Makefile
index 2ce01a0b5898..bde9c893d8a1 100644
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
index 85503fb5dd69..cb9344596bfb 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -17,6 +17,7 @@ struct idpf_vport_max_q;
 #include <linux/sctp.h>
 #include <linux/ethtool_netlink.h>
 #include <net/gro.h>
+#include <linux/net/intel/idc_rdma.h>
 
 #include "virtchnl2.h"
 #include "idpf_txrx.h"
@@ -203,6 +204,8 @@ struct idpf_reg_ops {
  */
 struct idpf_dev_ops {
 	struct idpf_reg_ops reg_ops;
+
+	int (*idc_init)(struct idpf_adapter *adapter);
 };
 
 /**
@@ -580,6 +583,7 @@ struct idpf_adapter {
 	struct idpf_vc_xn_manager *vcxn_mngr;
 
 	struct idpf_dev_ops dev_ops;
+	struct idc_rdma_core_dev_info *cdev_info;
 	int num_vfs;
 	bool crc_enable;
 	bool req_tx_splitq;
@@ -854,5 +858,9 @@ int idpf_sriov_configure(struct pci_dev *pdev, int num_vfs);
 
 u8 idpf_vport_get_hsplit(const struct idpf_vport *vport);
 bool idpf_vport_set_hsplit(const struct idpf_vport *vport, u8 val);
+int idpf_idc_init(struct idpf_adapter *adapter);
+int idpf_idc_init_aux_core_dev(struct idpf_adapter *adapter,
+			       enum idc_function_type ftype);
+void idpf_idc_deinit_core_aux_device(struct idc_rdma_core_dev_info *cdev_info);
 
 #endif /* !_IDPF_H_ */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_dev.c b/drivers/net/ethernet/intel/idpf/idpf_dev.c
index 3df9935685e9..f4c56915b934 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_dev.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_dev.c
@@ -143,6 +143,15 @@ static void idpf_trigger_reset(struct idpf_adapter *adapter,
 	       idpf_get_reg_addr(adapter, PFGEN_CTRL));
 }
 
+/**
+ * idpf_idc_register - register for IDC callbacks
+ * @adapter: Driver specific private structure
+ */
+static int idpf_idc_register(struct idpf_adapter *adapter)
+{
+	return idpf_idc_init_aux_core_dev(adapter, IDC_FUNCTION_TYPE_PF);
+}
+
 /**
  * idpf_reg_ops_init - Initialize register API function pointers
  * @adapter: Driver specific private structure
@@ -163,4 +172,6 @@ static void idpf_reg_ops_init(struct idpf_adapter *adapter)
 void idpf_dev_ops_init(struct idpf_adapter *adapter)
 {
 	idpf_reg_ops_init(adapter);
+
+	adapter->dev_ops.idc_init = idpf_idc_register;
 }
diff --git a/drivers/net/ethernet/intel/idpf/idpf_idc.c b/drivers/net/ethernet/intel/idpf/idpf_idc.c
new file mode 100644
index 000000000000..9eb0e0cfc61f
--- /dev/null
+++ b/drivers/net/ethernet/intel/idpf/idpf_idc.c
@@ -0,0 +1,212 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2022 Intel Corporation */
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
+	struct idc_rdma_core_auxiliary_dev *iadev;
+
+	iadev = container_of(dev, struct idc_rdma_core_auxiliary_dev, adev.dev);
+	kfree(iadev);
+	iadev = NULL;
+}
+
+/* idpf_plug_core_aux_dev - allocate and register an Auxiliary device
+ * @cdev_info: idc core device info pointer
+ */
+static int idpf_plug_core_aux_dev(struct idc_rdma_core_dev_info *cdev_info)
+{
+	struct idc_rdma_core_auxiliary_dev *iadev;
+	char name[IDPF_IDC_MAX_ADEV_NAME_LEN];
+	struct auxiliary_device *adev;
+	int err;
+
+	iadev = (struct idc_rdma_core_auxiliary_dev *)
+		kzalloc(sizeof(*iadev), GFP_KERNEL);
+	if (!iadev)
+		return -ENOMEM;
+
+	adev = &iadev->adev;
+	cdev_info->adev = adev;
+	iadev->cdev_info = cdev_info;
+
+	adev->id = ida_alloc(&idpf_idc_ida, GFP_KERNEL);
+	if (adev->id < 0) {
+		pr_err("failed to allocate unique device ID for Auxiliary driver\n");
+		err = -ENOMEM;
+		goto err_ida_alloc;
+	}
+	adev->dev.release = idpf_core_adev_release;
+	adev->dev.parent = &cdev_info->pdev->dev;
+	sprintf(name, "%04x.rdma.core", cdev_info->pdev->vendor);
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
+	cdev_info->adev = NULL;
+	auxiliary_device_uninit(adev);
+err_aux_dev_init:
+	ida_free(&idpf_idc_ida, adev->id);
+err_ida_alloc:
+	kfree(iadev);
+
+	return err;
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
+ * @cdev_info: idc core device info pointer
+ * @up: RDMA core driver status
+ *
+ * This callback function is accessed by an Auxiliary Driver to indicate
+ * whether core driver is ready to support vport driver load or if vport
+ * drivers need to be taken down.
+ */
+static int
+idpf_idc_vport_dev_ctrl(struct idc_rdma_core_dev_info *cdev_info,
+			bool up)
+{
+	return -EOPNOTSUPP;
+}
+
+/**
+ * idpf_idc_request_reset - Called by an Auxiliary Driver
+ * @cdev_info: idc core device info pointer
+ * @reset_type: function, core or other
+ *
+ * This callback function is accessed by an Auxiliary Driver to request a reset
+ * on the Auxiliary Device
+ */
+static int
+idpf_idc_request_reset(struct idc_rdma_core_dev_info *cdev_info,
+		       enum idc_rdma_reset_type __always_unused reset_type)
+{
+	return -EOPNOTSUPP;
+}
+
+/* Implemented by the Auxiliary Device and called by the Auxiliary Driver */
+static const struct idc_rdma_core_ops idc_ops = {
+	.vport_dev_ctrl			= idpf_idc_vport_dev_ctrl,
+	.request_reset                  = idpf_idc_request_reset,
+	.vc_send_sync			= idpf_idc_rdma_vc_send_sync,
+};
+
+/**
+ * idpf_idc_init_msix_data - initialize MSIX data for the cdev_info structure
+ * @adapter: driver private data structure
+ */
+static void
+idpf_idc_init_msix_data(struct idpf_adapter *adapter)
+{
+	struct idc_rdma_core_dev_info *cdev_info;
+
+	if (!adapter->rdma_msix_entries)
+		return;
+
+	cdev_info = adapter->cdev_info;
+
+	cdev_info->msix_entries = adapter->rdma_msix_entries;
+	cdev_info->msix_count = adapter->num_rdma_msix_entries;
+}
+
+/**
+ * idpf_idc_init_aux_core_dev - initialize Auxiliary Device(s)
+ * @adapter: driver private data structure
+ * @ftype: PF or VF
+ */
+int idpf_idc_init_aux_core_dev(struct idpf_adapter *adapter,
+			       enum idc_function_type ftype)
+{
+	struct idc_rdma_core_dev_info *cdev_info;
+	int err;
+
+	adapter->cdev_info = (struct idc_rdma_core_dev_info *)
+		kzalloc(sizeof(struct idc_rdma_core_dev_info), GFP_KERNEL);
+	if (!adapter->cdev_info)
+		return -ENOMEM;
+
+	cdev_info = adapter->cdev_info;
+	cdev_info->pdev = adapter->pdev;
+	cdev_info->ops = &idc_ops;
+	cdev_info->rdma_protocol = IDC_RDMA_PROTOCOL_ROCEV2;
+	cdev_info->ftype = ftype;
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
+	kfree(cdev_info);
+	adapter->cdev_info = NULL;
+
+	return err;
+}
+
+/**
+ * idpf_idc_deinit_core_aux_device - de-initialize Auxiliary Device(s)
+ * @cdev_info: idc core device info pointer
+ */
+void idpf_idc_deinit_core_aux_device(struct idc_rdma_core_dev_info *cdev_info)
+{
+	if (!cdev_info)
+		return;
+
+	idpf_unplug_aux_dev(cdev_info->adev);
+
+	kfree(cdev_info->mapped_mem_regions);
+	kfree(cdev_info);
+}
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index e985f27051de..ff7dcbced76c 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1861,6 +1861,10 @@ static int idpf_init_hard_reset(struct idpf_adapter *adapter)
 unlock_mutex:
 	mutex_unlock(&adapter->vport_ctrl_lock);
 
+	/* Wait until all vports are created to init RDMA CORE AUX */
+	if (!err)
+		err = idpf_idc_init(adapter);
+
 	return err;
 }
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c b/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
index 629cb5cb7c9f..db6a5951a594 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
@@ -141,6 +141,15 @@ static void idpf_vf_trigger_reset(struct idpf_adapter *adapter,
 		idpf_send_mb_msg(adapter, VIRTCHNL2_OP_RESET_VF, 0, NULL, 0);
 }
 
+/**
+ * idpf_idc_vf_register - register for IDC callbacks
+ * @adapter: Driver specific private structure
+ */
+static int idpf_idc_vf_register(struct idpf_adapter *adapter)
+{
+	return idpf_idc_init_aux_core_dev(adapter, IDC_FUNCTION_TYPE_VF);
+}
+
 /**
  * idpf_vf_reg_ops_init - Initialize register API function pointers
  * @adapter: Driver specific private structure
@@ -161,4 +170,6 @@ static void idpf_vf_reg_ops_init(struct idpf_adapter *adapter)
 void idpf_vf_dev_ops_init(struct idpf_adapter *adapter)
 {
 	idpf_vf_reg_ops_init(adapter);
+
+	adapter->dev_ops.idc_init = idpf_idc_vf_register;
 }
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 70986e12da28..d5067932de00 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -893,6 +893,7 @@ static int idpf_send_get_caps_msg(struct idpf_adapter *adapter)
 
 	caps.other_caps =
 		cpu_to_le64(VIRTCHNL2_CAP_SRIOV			|
+			    VIRTCHNL2_CAP_RDMA                  |
 			    VIRTCHNL2_CAP_MACFILTER		|
 			    VIRTCHNL2_CAP_SPLITQ_QSCHED		|
 			    VIRTCHNL2_CAP_PROMISC		|
@@ -3090,6 +3091,7 @@ void idpf_vc_core_deinit(struct idpf_adapter *adapter)
 
 	idpf_vc_xn_shutdown(adapter->vcxn_mngr);
 	idpf_deinit_task(adapter);
+	idpf_idc_deinit_core_aux_device(adapter->cdev_info);
 	idpf_intr_rel(adapter);
 
 	cancel_delayed_work_sync(&adapter->serv_task);
@@ -3732,3 +3734,18 @@ int idpf_set_promiscuous(struct idpf_adapter *adapter,
 
 	return reply_sz < 0 ? reply_sz : 0;
 }
+
+/**
+ * idpf_idc_rdma_vc_send_sync - virtchnl send callback for IDC registered drivers
+ * @cdev_info: idc core device info pointer
+ * @send_msg: message to send
+ * @msg_size: size of message to send
+ * @recv_msg: message to populate on reception of response
+ * @recv_len: length of message copied into recv_msg or 0 on error
+ */
+int idpf_idc_rdma_vc_send_sync(struct idc_rdma_core_dev_info *cdev_info,
+			       u8 *send_msg, u16 msg_size,
+			       u8 *recv_msg, u16 *recv_len)
+{
+	return -EOPNOTSUPP;
+}
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
index 83da5d8da56b..6163cfaeccae 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
@@ -66,5 +66,8 @@ int idpf_send_get_stats_msg(struct idpf_vport *vport);
 int idpf_send_set_sriov_vfs_msg(struct idpf_adapter *adapter, u16 num_vfs);
 int idpf_send_get_set_rss_key_msg(struct idpf_vport *vport, bool get);
 int idpf_send_get_set_rss_lut_msg(struct idpf_vport *vport, bool get);
+int idpf_idc_rdma_vc_send_sync(struct idc_rdma_core_dev_info *cdev_info,
+			       u8 *send_msg, u16 msg_size,
+			       u8 *recv_msg, u16 *recv_len);
 
 #endif /* _IDPF_VIRTCHNL_H_ */
-- 
2.42.0


