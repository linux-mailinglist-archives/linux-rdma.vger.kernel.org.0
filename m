Return-Path: <linux-rdma+bounces-12953-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DFFB38693
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Aug 2025 17:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A97A21BA79CE
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Aug 2025 15:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9818427E7F9;
	Wed, 27 Aug 2025 15:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IqLBgaLz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C97279915
	for <linux-rdma@vger.kernel.org>; Wed, 27 Aug 2025 15:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756308404; cv=none; b=bS4f9DWKNlSa0Fpu3rfKVTH7PrESve2iQ7Oij/7WJZuqivyinIEf4hSl14c0mTCtY3r96JJ1wVug2xpiLHpTf9z5jUOi5e0+jI1/NCbBD5jsrIwCBqyn0vSguxnVlw3GgO4OzjrqOMvSphRJOlTzrKHH4ijneiPY4jOx/6RNhyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756308404; c=relaxed/simple;
	bh=e3XuJc5TQd+ZXki3lzvpHomKhFPfhebX42zGs6HU0+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z2Q1pBQ8BlSJFJEHDoPJtfAqylgfnWbViGPv0FuCWe//ttjEkyMWWbG9dxTLmxFmC/L10W3tNsyCUriw0heyoTceuO5buPk5EsxLj0C7Okd6vA2u/cSY+z0yHTjTYd+Lx715utZhqPDr18TMSMbOeJG73s4PTlQL0t/CoYxDqg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IqLBgaLz; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756308401; x=1787844401;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e3XuJc5TQd+ZXki3lzvpHomKhFPfhebX42zGs6HU0+M=;
  b=IqLBgaLz8fcJZpGKnDzp8fUU5ewl6Rsavxc8H2kTdVAQxa59aLN84dVg
   f63h7rlHPF3ekXcIldf6z6K0hImNrPw2iAydFmxsIOtTXJxnFrGu/kMqC
   IZE2dxLRhMzgoXdmlQB2hx+c4eu/9tdPLRoYrSo3/kUhwcHdKT6KuE2s7
   Ohf3W0W1lgAksOcDrfb5C7a36PQ/2F88rk2Bxb3Ej9V9tNwJu0CZW8xst
   KcBtVkqhlgkB/8yrw3gSDiP9a85R2WDrXeObwzhLcYTdKlZ3b3ts6wiqz
   cyRKmGW/ayG+gMxbPBv5SMCBqN+DH8NyyysNLrHN4AQ8VwY7wc/jgJr6O
   g==;
X-CSE-ConnectionGUID: EdinUXbXS161vLNIIO4uWQ==
X-CSE-MsgGUID: df2qsM8eRr6uXLbg6aRYRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="76162759"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="76162759"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 08:26:41 -0700
X-CSE-ConnectionGUID: prCTF3L+QbSICMkx6Gda0g==
X-CSE-MsgGUID: hw4dw4lNRUWEioIV5F7H7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="174206766"
Received: from pthorat-mobl.amr.corp.intel.com (HELO soc-PF51RAGT.clients.intel.com) ([10.246.116.180])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 08:26:34 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	tatyana.e.nikolova@intel.com,
	krzysztof.czurylo@intel.com
Subject: [for-next 01/16] RDMA/irdma: Refactor GEN2 auxiliary driver
Date: Wed, 27 Aug 2025 10:25:30 -0500
Message-ID: <20250827152545.2056-2-tatyana.e.nikolova@intel.com>
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

Refactor the irdma auxiliary driver and associated interfaces out of main.c
and into a standalone GEN2-specific source file and rename as gen_2 driver.

This is in preparation for adding GEN3 auxiliary drivers. Each HW
generation will have its own gen-specific interface file.

Additionally, move the Address Handle hash table and associated locks
under rf struct. This will allow GEN3 code to migrate to use it easily.

Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
Co-developed-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---

Changes since split:
* Use ice exported symbols instead of device ops struct
* Move ice specific functionality to icrdma_* files
* Adapt to the renamed IIDC structs/functions iidc_*
* Use iidc_priv struct to access ice specific info

 drivers/infiniband/hw/irdma/Makefile    |   1 +
 drivers/infiniband/hw/irdma/i40iw_if.c  |   2 +
 drivers/infiniband/hw/irdma/icrdma_if.c | 341 +++++++++++++++++++++++
 drivers/infiniband/hw/irdma/main.c      | 347 +-----------------------
 drivers/infiniband/hw/irdma/main.h      |   7 +-
 drivers/infiniband/hw/irdma/verbs.c     |  16 +-
 6 files changed, 360 insertions(+), 354 deletions(-)
 create mode 100644 drivers/infiniband/hw/irdma/icrdma_if.c

diff --git a/drivers/infiniband/hw/irdma/Makefile b/drivers/infiniband/hw/irdma/Makefile
index 48c3854235a0..2522e4ca650b 100644
--- a/drivers/infiniband/hw/irdma/Makefile
+++ b/drivers/infiniband/hw/irdma/Makefile
@@ -13,6 +13,7 @@ irdma-objs := cm.o        \
               hw.o        \
               i40iw_hw.o  \
               i40iw_if.o  \
+	      icrdma_if.o \
               icrdma_hw.o \
               main.o      \
               pble.o      \
diff --git a/drivers/infiniband/hw/irdma/i40iw_if.c b/drivers/infiniband/hw/irdma/i40iw_if.c
index cc50a7070371..6fa807ef4545 100644
--- a/drivers/infiniband/hw/irdma/i40iw_if.c
+++ b/drivers/infiniband/hw/irdma/i40iw_if.c
@@ -75,6 +75,8 @@ static void i40iw_fill_device_info(struct irdma_device *iwdev, struct i40e_info
 	struct irdma_pci_f *rf = iwdev->rf;
 
 	rf->rdma_ver = IRDMA_GEN_1;
+	rf->sc_dev.hw = &rf->hw;
+	rf->sc_dev.hw_attrs.uk_attrs.hw_rev = IRDMA_GEN_1;
 	rf->gen_ops.request_reset = i40iw_request_reset;
 	rf->pcidev = cdev_info->pcidev;
 	rf->pf_id = cdev_info->fid;
diff --git a/drivers/infiniband/hw/irdma/icrdma_if.c b/drivers/infiniband/hw/irdma/icrdma_if.c
new file mode 100644
index 000000000000..db7c50b63b1d
--- /dev/null
+++ b/drivers/infiniband/hw/irdma/icrdma_if.c
@@ -0,0 +1,341 @@
+// SPDX-License-Identifier: GPL-2.0 or Linux-OpenIB
+/* Copyright (c) 2015 - 2024 Intel Corporation */
+
+#include "main.h"
+#include <linux/net/intel/iidc_rdma_ice.h>
+
+static void icrdma_prep_tc_change(struct irdma_device *iwdev)
+{
+	iwdev->vsi.tc_change_pending = true;
+	irdma_sc_suspend_resume_qps(&iwdev->vsi, IRDMA_OP_SUSPEND);
+
+	/* Wait for all qp's to suspend */
+	wait_event_timeout(iwdev->suspend_wq,
+			   !atomic_read(&iwdev->vsi.qp_suspend_reqs),
+			   msecs_to_jiffies(IRDMA_EVENT_TIMEOUT_MS));
+	irdma_ws_reset(&iwdev->vsi);
+}
+
+static void icrdma_fill_qos_info(struct irdma_l2params *l2params,
+			 struct iidc_rdma_qos_params *qos_info)
+{
+	int i;
+
+	l2params->num_tc = qos_info->num_tc;
+	l2params->vsi_prio_type = qos_info->vport_priority_type;
+	l2params->vsi_rel_bw = qos_info->vport_relative_bw;
+	for (i = 0; i < l2params->num_tc; i++) {
+		l2params->tc_info[i].egress_virt_up =
+			qos_info->tc_info[i].egress_virt_up;
+		l2params->tc_info[i].ingress_virt_up =
+			qos_info->tc_info[i].ingress_virt_up;
+		l2params->tc_info[i].prio_type = qos_info->tc_info[i].prio_type;
+		l2params->tc_info[i].rel_bw = qos_info->tc_info[i].rel_bw;
+		l2params->tc_info[i].tc_ctx = qos_info->tc_info[i].tc_ctx;
+	}
+	for (i = 0; i < IIDC_MAX_USER_PRIORITY; i++)
+		l2params->up2tc[i] = qos_info->up2tc[i];
+	if (qos_info->pfc_mode == IIDC_DSCP_PFC_MODE) {
+		l2params->dscp_mode = true;
+		memcpy(l2params->dscp_map, qos_info->dscp_map, sizeof(l2params->dscp_map));
+	}
+}
+
+static void icrdma_iidc_event_handler(struct iidc_rdma_core_dev_info *cdev_info,
+				     struct iidc_rdma_event *event)
+{
+	struct irdma_device *iwdev = dev_get_drvdata(&cdev_info->adev->dev);
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
+	} else if (*event->type & BIT(IIDC_RDMA_EVENT_BEFORE_TC_CHANGE)) {
+		if (iwdev->vsi.tc_change_pending)
+			return;
+
+		icrdma_prep_tc_change(iwdev);
+	} else if (*event->type & BIT(IIDC_RDMA_EVENT_AFTER_TC_CHANGE)) {
+		struct iidc_rdma_priv_dev_info *idc_priv = cdev_info->iidc_priv;
+
+		if (!iwdev->vsi.tc_change_pending)
+			return;
+
+		l2params.tc_changed = true;
+		ibdev_dbg(&iwdev->ibdev, "CLNT: TC Change\n");
+
+		icrdma_fill_qos_info(&l2params, &idc_priv->qos_info);
+		if (iwdev->rf->protocol_used != IRDMA_IWARP_PROTOCOL_ONLY)
+			iwdev->dcb_vlan_mode =
+				l2params.num_tc > 1 && !l2params.dscp_mode;
+		irdma_change_l2params(&iwdev->vsi, &l2params);
+	} else if (*event->type & BIT(IIDC_RDMA_EVENT_CRIT_ERR)) {
+		ibdev_warn(&iwdev->ibdev, "ICE OICR event notification: oicr = 0x%08x\n",
+			   event->reg);
+		if (event->reg & IRDMAPFINT_OICR_PE_CRITERR_M) {
+			u32 pe_criterr;
+
+			pe_criterr = readl(iwdev->rf->sc_dev.hw_regs[IRDMA_GLPE_CRITERR]);
+#define IRDMA_Q1_RESOURCE_ERR 0x0001024d
+			if (pe_criterr != IRDMA_Q1_RESOURCE_ERR) {
+				ibdev_err(&iwdev->ibdev, "critical PE Error, GLPE_CRITERR=0x%08x\n",
+					  pe_criterr);
+				iwdev->rf->reset = true;
+			} else {
+				ibdev_warn(&iwdev->ibdev, "Q1 Resource Check\n");
+			}
+		}
+		if (event->reg & IRDMAPFINT_OICR_HMC_ERR_M) {
+			ibdev_err(&iwdev->ibdev, "HMC Error\n");
+			iwdev->rf->reset = true;
+		}
+		if (event->reg & IRDMAPFINT_OICR_PE_PUSH_M) {
+			ibdev_err(&iwdev->ibdev, "PE Push Error\n");
+			iwdev->rf->reset = true;
+		}
+		if (iwdev->rf->reset)
+			iwdev->rf->gen_ops.request_reset(iwdev->rf);
+	}
+}
+
+/**
+ * icrdma_lan_register_qset - Register qset with LAN driver
+ * @vsi: vsi structure
+ * @tc_node: Traffic class node
+ */
+static int icrdma_lan_register_qset(struct irdma_sc_vsi *vsi,
+				    struct irdma_ws_node *tc_node)
+{
+	struct irdma_device *iwdev = vsi->back_vsi;
+	struct iidc_rdma_core_dev_info *cdev_info = iwdev->rf->cdev;
+	struct iidc_rdma_qset_params qset = {};
+	int ret;
+
+	qset.qs_handle = tc_node->qs_handle;
+	qset.tc = tc_node->traffic_class;
+	qset.vport_id = vsi->vsi_idx;
+	ret = ice_add_rdma_qset(cdev_info, &qset);
+	if (ret) {
+		ibdev_dbg(&iwdev->ibdev, "WS: LAN alloc_res for rdma qset failed.\n");
+		return ret;
+	}
+
+	tc_node->l2_sched_node_id = qset.teid;
+	vsi->qos[tc_node->user_pri].l2_sched_node_id = qset.teid;
+
+	return 0;
+}
+
+/**
+ * icrdma_lan_unregister_qset - Unregister qset with LAN driver
+ * @vsi: vsi structure
+ * @tc_node: Traffic class node
+ */
+static void icrdma_lan_unregister_qset(struct irdma_sc_vsi *vsi,
+				       struct irdma_ws_node *tc_node)
+{
+	struct irdma_device *iwdev = vsi->back_vsi;
+	struct iidc_rdma_core_dev_info *cdev_info = iwdev->rf->cdev;
+	struct iidc_rdma_qset_params qset = {};
+
+	qset.qs_handle = tc_node->qs_handle;
+	qset.tc = tc_node->traffic_class;
+	qset.vport_id = vsi->vsi_idx;
+	qset.teid = tc_node->l2_sched_node_id;
+
+	if (ice_del_rdma_qset(cdev_info, &qset))
+		ibdev_dbg(&iwdev->ibdev, "WS: LAN free_res for rdma qset failed.\n");
+}
+
+/**
+ * icrdma_request_reset - Request a reset
+ * @rf: RDMA PCI function
+ */
+static void icrdma_request_reset(struct irdma_pci_f *rf)
+{
+	ibdev_warn(&rf->iwdev->ibdev, "Requesting a reset\n");
+	ice_rdma_request_reset(rf->cdev, IIDC_FUNC_RESET);
+}
+
+static int icrdma_init_interrupts(struct irdma_pci_f *rf, struct iidc_rdma_core_dev_info *cdev)
+{
+	int i;
+
+	rf->msix_count = num_online_cpus() + IRDMA_NUM_AEQ_MSIX;
+	rf->msix_entries = kcalloc(rf->msix_count, sizeof(*rf->msix_entries),
+				   GFP_KERNEL);
+	if (!rf->msix_entries)
+		return -ENOMEM;
+
+	for (i = 0; i < rf->msix_count; i++)
+		if (ice_alloc_rdma_qvector(cdev, &rf->msix_entries[i]))
+			break;
+
+	if (i < IRDMA_MIN_MSIX) {
+		while (--i >= 0)
+			ice_free_rdma_qvector(cdev, &rf->msix_entries[i]);
+
+		kfree(rf->msix_entries);
+		return -ENOMEM;
+	}
+
+	rf->msix_count = i;
+
+	return 0;
+}
+
+static void icrdma_deinit_interrupts(struct irdma_pci_f *rf, struct iidc_rdma_core_dev_info *cdev)
+{
+	int i;
+
+	for (i = 0; i < rf->msix_count; i++)
+		ice_free_rdma_qvector(cdev, &rf->msix_entries[i]);
+
+	kfree(rf->msix_entries);
+}
+
+static void icrdma_fill_device_info(struct irdma_device *iwdev,
+				    struct iidc_rdma_core_dev_info *cdev_info)
+{
+	struct iidc_rdma_priv_dev_info *idc_priv = cdev_info->iidc_priv;
+	struct irdma_pci_f *rf = iwdev->rf;
+
+	rf->sc_dev.hw = &rf->hw;
+	rf->iwdev = iwdev;
+	rf->cdev = cdev_info;
+	rf->hw.hw_addr = idc_priv->hw_addr;
+	rf->pcidev = cdev_info->pdev;
+	rf->hw.device = &rf->pcidev->dev;
+	rf->pf_id = idc_priv->pf_id;
+	rf->rdma_ver = IRDMA_GEN_2;
+	rf->sc_dev.hw_attrs.uk_attrs.hw_rev = IRDMA_GEN_2;
+
+	rf->gen_ops.register_qset = icrdma_lan_register_qset;
+	rf->gen_ops.unregister_qset = icrdma_lan_unregister_qset;
+
+	rf->default_vsi.vsi_idx = idc_priv->vport_id;
+	rf->protocol_used =
+		cdev_info->rdma_protocol == IIDC_RDMA_PROTOCOL_ROCEV2 ?
+			IRDMA_ROCE_PROTOCOL_ONLY : IRDMA_IWARP_PROTOCOL_ONLY;
+	rf->rsrc_profile = IRDMA_HMC_PROFILE_DEFAULT;
+	rf->rst_to = IRDMA_RST_TIMEOUT_HZ;
+	rf->gen_ops.request_reset = icrdma_request_reset;
+	rf->limits_sel = 7;
+	mutex_init(&rf->ah_tbl_lock);
+
+	iwdev->netdev = idc_priv->netdev;
+	iwdev->vsi_num = idc_priv->vport_id;
+	iwdev->init_state = INITIAL_STATE;
+	iwdev->roce_cwnd = IRDMA_ROCE_CWND_DEFAULT;
+	iwdev->roce_ackcreds = IRDMA_ROCE_ACKCREDS_DEFAULT;
+	iwdev->rcv_wnd = IRDMA_CM_DEFAULT_RCV_WND_SCALED;
+	iwdev->rcv_wscale = IRDMA_CM_DEFAULT_RCV_WND_SCALE;
+	if (iwdev->rf->protocol_used != IRDMA_IWARP_PROTOCOL_ONLY)
+		iwdev->roce_mode = true;
+}
+
+static int icrdma_probe(struct auxiliary_device *aux_dev, const struct auxiliary_device_id *id)
+{
+	struct iidc_rdma_core_auxiliary_dev *iidc_adev;
+	struct iidc_rdma_core_dev_info *cdev_info;
+	struct iidc_rdma_priv_dev_info *idc_priv;
+	struct irdma_l2params l2params = {};
+	struct irdma_device *iwdev;
+	struct irdma_pci_f *rf;
+	int err;
+
+	iidc_adev = container_of(aux_dev, struct iidc_rdma_core_auxiliary_dev, adev);
+	cdev_info = iidc_adev->cdev_info;
+	idc_priv = cdev_info->iidc_priv;
+
+	iwdev = ib_alloc_device(irdma_device, ibdev);
+	if (!iwdev)
+		return -ENOMEM;
+	iwdev->rf = kzalloc(sizeof(*rf), GFP_KERNEL);
+	if (!iwdev->rf) {
+		ib_dealloc_device(&iwdev->ibdev);
+		return -ENOMEM;
+	}
+
+	icrdma_fill_device_info(iwdev, cdev_info);
+	rf = iwdev->rf;
+
+	err = icrdma_init_interrupts(rf, cdev_info);
+	if (err)
+		goto err_init_interrupts;
+
+	err = irdma_ctrl_init_hw(rf);
+	if (err)
+		goto err_ctrl_init;
+
+	l2params.mtu = iwdev->netdev->mtu;
+	icrdma_fill_qos_info(&l2params, &idc_priv->qos_info);
+	if (iwdev->rf->protocol_used != IRDMA_IWARP_PROTOCOL_ONLY)
+		iwdev->dcb_vlan_mode = l2params.num_tc > 1 && !l2params.dscp_mode;
+
+	err = irdma_rt_init_hw(iwdev, &l2params);
+	if (err)
+		goto err_rt_init;
+
+	err = irdma_ib_register_device(iwdev);
+	if (err)
+		goto err_ibreg;
+
+	ice_rdma_update_vsi_filter(cdev_info, iwdev->vsi_num, true);
+
+	ibdev_dbg(&iwdev->ibdev, "INIT: Gen2 PF[%d] device probe success\n", PCI_FUNC(rf->pcidev->devfn));
+	auxiliary_set_drvdata(aux_dev, iwdev);
+
+	return 0;
+
+err_ibreg:
+	irdma_rt_deinit_hw(iwdev);
+err_rt_init:
+	irdma_ctrl_deinit_hw(rf);
+err_ctrl_init:
+	icrdma_deinit_interrupts(rf, cdev_info);
+err_init_interrupts:
+	kfree(iwdev->rf);
+	ib_dealloc_device(&iwdev->ibdev);
+
+	return err;
+}
+
+static void icrdma_remove(struct auxiliary_device *aux_dev)
+{
+	struct iidc_rdma_core_auxiliary_dev *idc_adev =
+		container_of(aux_dev, struct iidc_rdma_core_auxiliary_dev, adev);
+	struct iidc_rdma_core_dev_info *cdev_info = idc_adev->cdev_info;
+	struct irdma_device *iwdev = auxiliary_get_drvdata(aux_dev);
+	u8 rdma_ver = iwdev->rf->rdma_ver;
+
+	ice_rdma_update_vsi_filter(cdev_info, iwdev->vsi_num, false);
+	irdma_ib_unregister_device(iwdev);
+	icrdma_deinit_interrupts(iwdev->rf, cdev_info);
+
+	pr_debug("INIT: Gen[%d] func[%d] device remove success\n",
+		 rdma_ver, PCI_FUNC(cdev_info->pdev->devfn));
+}
+
+static const struct auxiliary_device_id icrdma_auxiliary_id_table[] = {
+	{.name = "ice.iwarp", },
+	{.name = "ice.roce", },
+	{},
+};
+
+MODULE_DEVICE_TABLE(auxiliary, icrdma_auxiliary_id_table);
+
+struct iidc_rdma_core_auxiliary_drv icrdma_core_auxiliary_drv = {
+	.adrv = {
+	    .name = "gen_2",
+	    .id_table = icrdma_auxiliary_id_table,
+	    .probe = icrdma_probe,
+	    .remove = icrdma_remove,
+	},
+	.event_handler = icrdma_iidc_event_handler,
+};
diff --git a/drivers/infiniband/hw/irdma/main.c b/drivers/infiniband/hw/irdma/main.c
index 1e840bbd619d..f703f489a0bf 100644
--- a/drivers/infiniband/hw/irdma/main.c
+++ b/drivers/infiniband/hw/irdma/main.c
@@ -38,19 +38,7 @@ static void irdma_unregister_notifiers(void)
 	unregister_netdevice_notifier(&irdma_netdevice_notifier);
 }
 
-static void irdma_prep_tc_change(struct irdma_device *iwdev)
-{
-	iwdev->vsi.tc_change_pending = true;
-	irdma_sc_suspend_resume_qps(&iwdev->vsi, IRDMA_OP_SUSPEND);
-
-	/* Wait for all qp's to suspend */
-	wait_event_timeout(iwdev->suspend_wq,
-			   !atomic_read(&iwdev->vsi.qp_suspend_reqs),
-			   msecs_to_jiffies(IRDMA_EVENT_TIMEOUT_MS));
-	irdma_ws_reset(&iwdev->vsi);
-}
-
-static void irdma_log_invalid_mtu(u16 mtu, struct irdma_sc_dev *dev)
+void irdma_log_invalid_mtu(u16 mtu, struct irdma_sc_dev *dev)
 {
 	if (mtu < IRDMA_MIN_MTU_IPV4)
 		ibdev_warn(to_ibdev(dev), "MTU setting [%d] too low for RDMA traffic. Minimum MTU is 576 for IPv4\n", mtu);
@@ -58,333 +46,6 @@ static void irdma_log_invalid_mtu(u16 mtu, struct irdma_sc_dev *dev)
 		ibdev_warn(to_ibdev(dev), "MTU setting [%d] too low for RDMA traffic. Minimum MTU is 1280 for IPv6\\n", mtu);
 }
 
-static void irdma_fill_qos_info(struct irdma_l2params *l2params,
-				struct iidc_rdma_qos_params *qos_info)
-{
-	int i;
-
-	l2params->num_tc = qos_info->num_tc;
-	l2params->vsi_prio_type = qos_info->vport_priority_type;
-	l2params->vsi_rel_bw = qos_info->vport_relative_bw;
-	for (i = 0; i < l2params->num_tc; i++) {
-		l2params->tc_info[i].egress_virt_up =
-			qos_info->tc_info[i].egress_virt_up;
-		l2params->tc_info[i].ingress_virt_up =
-			qos_info->tc_info[i].ingress_virt_up;
-		l2params->tc_info[i].prio_type = qos_info->tc_info[i].prio_type;
-		l2params->tc_info[i].rel_bw = qos_info->tc_info[i].rel_bw;
-		l2params->tc_info[i].tc_ctx = qos_info->tc_info[i].tc_ctx;
-	}
-	for (i = 0; i < IIDC_MAX_USER_PRIORITY; i++)
-		l2params->up2tc[i] = qos_info->up2tc[i];
-	if (qos_info->pfc_mode == IIDC_DSCP_PFC_MODE) {
-		l2params->dscp_mode = true;
-		memcpy(l2params->dscp_map, qos_info->dscp_map, sizeof(l2params->dscp_map));
-	}
-}
-
-static void irdma_iidc_event_handler(struct iidc_rdma_core_dev_info *cdev_info,
-				     struct iidc_rdma_event *event)
-{
-	struct irdma_device *iwdev = dev_get_drvdata(&cdev_info->adev->dev);
-	struct irdma_l2params l2params = {};
-
-	if (*event->type & BIT(IIDC_RDMA_EVENT_AFTER_MTU_CHANGE)) {
-		ibdev_dbg(&iwdev->ibdev, "CLNT: new MTU = %d\n", iwdev->netdev->mtu);
-		if (iwdev->vsi.mtu != iwdev->netdev->mtu) {
-			l2params.mtu = iwdev->netdev->mtu;
-			l2params.mtu_changed = true;
-			irdma_log_invalid_mtu(l2params.mtu, &iwdev->rf->sc_dev);
-			irdma_change_l2params(&iwdev->vsi, &l2params);
-		}
-	} else if (*event->type & BIT(IIDC_RDMA_EVENT_BEFORE_TC_CHANGE)) {
-		if (iwdev->vsi.tc_change_pending)
-			return;
-
-		irdma_prep_tc_change(iwdev);
-	} else if (*event->type & BIT(IIDC_RDMA_EVENT_AFTER_TC_CHANGE)) {
-		struct iidc_rdma_priv_dev_info *iidc_priv = cdev_info->iidc_priv;
-
-		if (!iwdev->vsi.tc_change_pending)
-			return;
-
-		l2params.tc_changed = true;
-		ibdev_dbg(&iwdev->ibdev, "CLNT: TC Change\n");
-
-		irdma_fill_qos_info(&l2params, &iidc_priv->qos_info);
-		if (iwdev->rf->protocol_used != IRDMA_IWARP_PROTOCOL_ONLY)
-			iwdev->dcb_vlan_mode =
-				l2params.num_tc > 1 && !l2params.dscp_mode;
-		irdma_change_l2params(&iwdev->vsi, &l2params);
-	} else if (*event->type & BIT(IIDC_RDMA_EVENT_CRIT_ERR)) {
-		ibdev_warn(&iwdev->ibdev, "ICE OICR event notification: oicr = 0x%08x\n",
-			   event->reg);
-		if (event->reg & IRDMAPFINT_OICR_PE_CRITERR_M) {
-			u32 pe_criterr;
-
-			pe_criterr = readl(iwdev->rf->sc_dev.hw_regs[IRDMA_GLPE_CRITERR]);
-#define IRDMA_Q1_RESOURCE_ERR 0x0001024d
-			if (pe_criterr != IRDMA_Q1_RESOURCE_ERR) {
-				ibdev_err(&iwdev->ibdev, "critical PE Error, GLPE_CRITERR=0x%08x\n",
-					  pe_criterr);
-				iwdev->rf->reset = true;
-			} else {
-				ibdev_warn(&iwdev->ibdev, "Q1 Resource Check\n");
-			}
-		}
-		if (event->reg & IRDMAPFINT_OICR_HMC_ERR_M) {
-			ibdev_err(&iwdev->ibdev, "HMC Error\n");
-			iwdev->rf->reset = true;
-		}
-		if (event->reg & IRDMAPFINT_OICR_PE_PUSH_M) {
-			ibdev_err(&iwdev->ibdev, "PE Push Error\n");
-			iwdev->rf->reset = true;
-		}
-		if (iwdev->rf->reset)
-			iwdev->rf->gen_ops.request_reset(iwdev->rf);
-	}
-}
-
-/**
- * irdma_request_reset - Request a reset
- * @rf: RDMA PCI function
- */
-static void irdma_request_reset(struct irdma_pci_f *rf)
-{
-	ibdev_warn(&rf->iwdev->ibdev, "Requesting a reset\n");
-	ice_rdma_request_reset(rf->cdev, IIDC_FUNC_RESET);
-}
-
-/**
- * irdma_lan_register_qset - Register qset with LAN driver
- * @vsi: vsi structure
- * @tc_node: Traffic class node
- */
-static int irdma_lan_register_qset(struct irdma_sc_vsi *vsi,
-				   struct irdma_ws_node *tc_node)
-{
-	struct irdma_device *iwdev = vsi->back_vsi;
-	struct iidc_rdma_core_dev_info *cdev_info;
-	struct iidc_rdma_qset_params qset = {};
-	int ret;
-
-	cdev_info = iwdev->rf->cdev;
-	qset.qs_handle = tc_node->qs_handle;
-	qset.tc = tc_node->traffic_class;
-	qset.vport_id = vsi->vsi_idx;
-	ret = ice_add_rdma_qset(cdev_info, &qset);
-	if (ret) {
-		ibdev_dbg(&iwdev->ibdev, "WS: LAN alloc_res for rdma qset failed.\n");
-		return ret;
-	}
-
-	tc_node->l2_sched_node_id = qset.teid;
-	vsi->qos[tc_node->user_pri].l2_sched_node_id = qset.teid;
-
-	return 0;
-}
-
-/**
- * irdma_lan_unregister_qset - Unregister qset with LAN driver
- * @vsi: vsi structure
- * @tc_node: Traffic class node
- */
-static void irdma_lan_unregister_qset(struct irdma_sc_vsi *vsi,
-				      struct irdma_ws_node *tc_node)
-{
-	struct irdma_device *iwdev = vsi->back_vsi;
-	struct iidc_rdma_core_dev_info *cdev_info;
-	struct iidc_rdma_qset_params qset = {};
-
-	cdev_info = iwdev->rf->cdev;
-	qset.qs_handle = tc_node->qs_handle;
-	qset.tc = tc_node->traffic_class;
-	qset.vport_id = vsi->vsi_idx;
-	qset.teid = tc_node->l2_sched_node_id;
-
-	if (ice_del_rdma_qset(cdev_info, &qset))
-		ibdev_dbg(&iwdev->ibdev, "WS: LAN free_res for rdma qset failed.\n");
-}
-
-static int irdma_init_interrupts(struct irdma_pci_f *rf, struct iidc_rdma_core_dev_info *cdev)
-{
-	int i;
-
-	rf->msix_count = num_online_cpus() + IRDMA_NUM_AEQ_MSIX;
-	rf->msix_entries = kcalloc(rf->msix_count, sizeof(*rf->msix_entries),
-				   GFP_KERNEL);
-	if (!rf->msix_entries)
-		return -ENOMEM;
-
-	for (i = 0; i < rf->msix_count; i++)
-		if (ice_alloc_rdma_qvector(cdev, &rf->msix_entries[i]))
-			break;
-
-	if (i < IRDMA_MIN_MSIX) {
-		while (--i >= 0)
-			ice_free_rdma_qvector(cdev, &rf->msix_entries[i]);
-
-		kfree(rf->msix_entries);
-		return -ENOMEM;
-	}
-
-	rf->msix_count = i;
-
-	return 0;
-}
-
-static void irdma_deinit_interrupts(struct irdma_pci_f *rf, struct iidc_rdma_core_dev_info *cdev)
-{
-	int i;
-
-	for (i = 0; i < rf->msix_count; i++)
-		ice_free_rdma_qvector(cdev, &rf->msix_entries[i]);
-
-	kfree(rf->msix_entries);
-}
-
-static void irdma_remove(struct auxiliary_device *aux_dev)
-{
-	struct irdma_device *iwdev = auxiliary_get_drvdata(aux_dev);
-	struct iidc_rdma_core_auxiliary_dev *iidc_adev;
-	struct iidc_rdma_core_dev_info *cdev_info;
-
-	iidc_adev = container_of(aux_dev, struct iidc_rdma_core_auxiliary_dev, adev);
-	cdev_info = iidc_adev->cdev_info;
-
-	ice_rdma_update_vsi_filter(cdev_info, iwdev->vsi_num, false);
-	irdma_ib_unregister_device(iwdev);
-	irdma_deinit_interrupts(iwdev->rf, cdev_info);
-
-	kfree(iwdev->rf);
-
-	pr_debug("INIT: Gen2 PF[%d] device remove success\n", PCI_FUNC(cdev_info->pdev->devfn));
-}
-
-static void irdma_fill_device_info(struct irdma_device *iwdev,
-				   struct iidc_rdma_core_dev_info *cdev_info)
-{
-	struct iidc_rdma_priv_dev_info *iidc_priv = cdev_info->iidc_priv;
-	struct irdma_pci_f *rf = iwdev->rf;
-
-	rf->sc_dev.hw = &rf->hw;
-	rf->iwdev = iwdev;
-	rf->cdev = cdev_info;
-	rf->hw.hw_addr = iidc_priv->hw_addr;
-	rf->pcidev = cdev_info->pdev;
-	rf->hw.device = &rf->pcidev->dev;
-	rf->pf_id = iidc_priv->pf_id;
-	rf->gen_ops.register_qset = irdma_lan_register_qset;
-	rf->gen_ops.unregister_qset = irdma_lan_unregister_qset;
-
-	rf->default_vsi.vsi_idx = iidc_priv->vport_id;
-	rf->protocol_used =
-		cdev_info->rdma_protocol == IIDC_RDMA_PROTOCOL_ROCEV2 ?
-		IRDMA_ROCE_PROTOCOL_ONLY : IRDMA_IWARP_PROTOCOL_ONLY;
-	rf->rdma_ver = IRDMA_GEN_2;
-	rf->rsrc_profile = IRDMA_HMC_PROFILE_DEFAULT;
-	rf->rst_to = IRDMA_RST_TIMEOUT_HZ;
-	rf->gen_ops.request_reset = irdma_request_reset;
-	rf->limits_sel = 7;
-	rf->iwdev = iwdev;
-
-	mutex_init(&iwdev->ah_tbl_lock);
-
-	iwdev->netdev = iidc_priv->netdev;
-	iwdev->vsi_num = iidc_priv->vport_id;
-	iwdev->init_state = INITIAL_STATE;
-	iwdev->roce_cwnd = IRDMA_ROCE_CWND_DEFAULT;
-	iwdev->roce_ackcreds = IRDMA_ROCE_ACKCREDS_DEFAULT;
-	iwdev->rcv_wnd = IRDMA_CM_DEFAULT_RCV_WND_SCALED;
-	iwdev->rcv_wscale = IRDMA_CM_DEFAULT_RCV_WND_SCALE;
-	if (rf->protocol_used == IRDMA_ROCE_PROTOCOL_ONLY)
-		iwdev->roce_mode = true;
-}
-
-static int irdma_probe(struct auxiliary_device *aux_dev, const struct auxiliary_device_id *id)
-{
-	struct iidc_rdma_core_auxiliary_dev *iidc_adev;
-	struct iidc_rdma_core_dev_info *cdev_info;
-	struct iidc_rdma_priv_dev_info *iidc_priv;
-	struct irdma_l2params l2params = {};
-	struct irdma_device *iwdev;
-	struct irdma_pci_f *rf;
-	int err;
-
-	iidc_adev = container_of(aux_dev, struct iidc_rdma_core_auxiliary_dev, adev);
-	cdev_info = iidc_adev->cdev_info;
-	iidc_priv = cdev_info->iidc_priv;
-
-	iwdev = ib_alloc_device(irdma_device, ibdev);
-	if (!iwdev)
-		return -ENOMEM;
-	iwdev->rf = kzalloc(sizeof(*rf), GFP_KERNEL);
-	if (!iwdev->rf) {
-		ib_dealloc_device(&iwdev->ibdev);
-		return -ENOMEM;
-	}
-
-	irdma_fill_device_info(iwdev, cdev_info);
-	rf = iwdev->rf;
-
-	err = irdma_init_interrupts(rf, cdev_info);
-	if (err)
-		goto err_init_interrupts;
-
-	err = irdma_ctrl_init_hw(rf);
-	if (err)
-		goto err_ctrl_init;
-
-	l2params.mtu = iwdev->netdev->mtu;
-	irdma_fill_qos_info(&l2params, &iidc_priv->qos_info);
-	if (iwdev->rf->protocol_used != IRDMA_IWARP_PROTOCOL_ONLY)
-		iwdev->dcb_vlan_mode = l2params.num_tc > 1 && !l2params.dscp_mode;
-
-	err = irdma_rt_init_hw(iwdev, &l2params);
-	if (err)
-		goto err_rt_init;
-
-	err = irdma_ib_register_device(iwdev);
-	if (err)
-		goto err_ibreg;
-
-	ice_rdma_update_vsi_filter(cdev_info, iwdev->vsi_num, true);
-
-	ibdev_dbg(&iwdev->ibdev, "INIT: Gen2 PF[%d] device probe success\n", PCI_FUNC(rf->pcidev->devfn));
-	auxiliary_set_drvdata(aux_dev, iwdev);
-
-	return 0;
-
-err_ibreg:
-	irdma_rt_deinit_hw(iwdev);
-err_rt_init:
-	irdma_ctrl_deinit_hw(rf);
-err_ctrl_init:
-	irdma_deinit_interrupts(rf, cdev_info);
-err_init_interrupts:
-	kfree(iwdev->rf);
-	ib_dealloc_device(&iwdev->ibdev);
-
-	return err;
-}
-
-static const struct auxiliary_device_id irdma_auxiliary_id_table[] = {
-	{.name = "ice.iwarp", },
-	{.name = "ice.roce", },
-	{},
-};
-
-MODULE_DEVICE_TABLE(auxiliary, irdma_auxiliary_id_table);
-
-static struct iidc_rdma_core_auxiliary_drv irdma_auxiliary_drv = {
-	.adrv = {
-	    .id_table = irdma_auxiliary_id_table,
-	    .probe = irdma_probe,
-	    .remove = irdma_remove,
-	},
-	.event_handler = irdma_iidc_event_handler,
-};
-
 static int __init irdma_init_module(void)
 {
 	int ret;
@@ -396,10 +57,10 @@ static int __init irdma_init_module(void)
 		return ret;
 	}
 
-	ret = auxiliary_driver_register(&irdma_auxiliary_drv.adrv);
+	ret = auxiliary_driver_register(&icrdma_core_auxiliary_drv.adrv);
 	if (ret) {
 		auxiliary_driver_unregister(&i40iw_auxiliary_drv);
-		pr_err("Failed irdma auxiliary_driver_register() ret=%d\n",
+		pr_err("Failed icrdma(gen_2) auxiliary_driver_register() ret=%d\n",
 		       ret);
 		return ret;
 	}
@@ -412,7 +73,7 @@ static int __init irdma_init_module(void)
 static void __exit irdma_exit_module(void)
 {
 	irdma_unregister_notifiers();
-	auxiliary_driver_unregister(&irdma_auxiliary_drv.adrv);
+	auxiliary_driver_unregister(&icrdma_core_auxiliary_drv.adrv);
 	auxiliary_driver_unregister(&i40iw_auxiliary_drv);
 }
 
diff --git a/drivers/infiniband/hw/irdma/main.h b/drivers/infiniband/hw/irdma/main.h
index 674acc952168..ca568ccf8a5a 100644
--- a/drivers/infiniband/hw/irdma/main.h
+++ b/drivers/infiniband/hw/irdma/main.h
@@ -30,7 +30,6 @@
 #endif
 #include <linux/auxiliary_bus.h>
 #include <linux/net/intel/iidc_rdma.h>
-#include <linux/net/intel/iidc_rdma_ice.h>
 #include <rdma/ib_smi.h>
 #include <rdma/ib_verbs.h>
 #include <rdma/ib_pack.h>
@@ -54,6 +53,7 @@
 #include "puda.h"
 
 extern struct auxiliary_driver i40iw_auxiliary_drv;
+extern struct iidc_rdma_core_auxiliary_drv icrdma_core_auxiliary_drv;
 
 #define IRDMA_FW_VER_DEFAULT	2
 #define IRDMA_HW_VER	        2
@@ -331,6 +331,8 @@ struct irdma_pci_f {
 	void *back_fcn;
 	struct irdma_gen_ops gen_ops;
 	struct irdma_device *iwdev;
+	DECLARE_HASHTABLE(ah_hash_tbl, 8);
+	struct mutex ah_tbl_lock; /* protect AH hash table access */
 };
 
 struct irdma_device {
@@ -340,8 +342,6 @@ struct irdma_device {
 	struct workqueue_struct *cleanup_wq;
 	struct irdma_sc_vsi vsi;
 	struct irdma_cm_core cm_core;
-	DECLARE_HASHTABLE(ah_hash_tbl, 8);
-	struct mutex ah_tbl_lock; /* protect AH hash table access */
 	u32 roce_cwnd;
 	u32 roce_ackcreds;
 	u32 vendor_id;
@@ -557,4 +557,5 @@ int irdma_netdevice_event(struct notifier_block *notifier, unsigned long event,
 			  void *ptr);
 void irdma_add_ip(struct irdma_device *iwdev);
 void cqp_compl_worker(struct work_struct *work);
+void irdma_log_invalid_mtu(u16 mtu, struct irdma_sc_dev *dev);
 #endif /* IRDMA_MAIN_H */
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index da5a41b275d8..1bee1cbf7a4d 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -4539,7 +4539,7 @@ static bool irdma_ah_exists(struct irdma_device *iwdev,
 		  new_ah->sc_ah.ah_info.dest_ip_addr[2] ^
 		  new_ah->sc_ah.ah_info.dest_ip_addr[3];
 
-	hash_for_each_possible(iwdev->ah_hash_tbl, ah, list, key) {
+	hash_for_each_possible(iwdev->rf->ah_hash_tbl, ah, list, key) {
 		/* Set ah_valid and ah_id the same so memcmp can work */
 		new_ah->sc_ah.ah_info.ah_idx = ah->sc_ah.ah_info.ah_idx;
 		new_ah->sc_ah.ah_info.ah_valid = ah->sc_ah.ah_info.ah_valid;
@@ -4565,14 +4565,14 @@ static int irdma_destroy_ah(struct ib_ah *ibah, u32 ah_flags)
 	struct irdma_ah *ah = to_iwah(ibah);
 
 	if ((ah_flags & RDMA_DESTROY_AH_SLEEPABLE) && ah->parent_ah) {
-		mutex_lock(&iwdev->ah_tbl_lock);
+		mutex_lock(&iwdev->rf->ah_tbl_lock);
 		if (!refcount_dec_and_test(&ah->parent_ah->refcnt)) {
-			mutex_unlock(&iwdev->ah_tbl_lock);
+			mutex_unlock(&iwdev->rf->ah_tbl_lock);
 			return 0;
 		}
 		hash_del(&ah->parent_ah->list);
 		kfree(ah->parent_ah);
-		mutex_unlock(&iwdev->ah_tbl_lock);
+		mutex_unlock(&iwdev->rf->ah_tbl_lock);
 	}
 
 	irdma_ah_cqp_op(iwdev->rf, &ah->sc_ah, IRDMA_OP_AH_DESTROY,
@@ -4609,11 +4609,11 @@ static int irdma_create_user_ah(struct ib_ah *ibah,
 	err = irdma_setup_ah(ibah, attr);
 	if (err)
 		return err;
-	mutex_lock(&iwdev->ah_tbl_lock);
+	mutex_lock(&iwdev->rf->ah_tbl_lock);
 	if (!irdma_ah_exists(iwdev, ah)) {
 		err = irdma_create_hw_ah(iwdev, ah, true);
 		if (err) {
-			mutex_unlock(&iwdev->ah_tbl_lock);
+			mutex_unlock(&iwdev->rf->ah_tbl_lock);
 			return err;
 		}
 		/* Add new AH to list */
@@ -4625,11 +4625,11 @@ static int irdma_create_user_ah(struct ib_ah *ibah,
 				  parent_ah->sc_ah.ah_info.dest_ip_addr[3];
 
 			ah->parent_ah = parent_ah;
-			hash_add(iwdev->ah_hash_tbl, &parent_ah->list, key);
+			hash_add(iwdev->rf->ah_hash_tbl, &parent_ah->list, key);
 			refcount_set(&parent_ah->refcnt, 1);
 		}
 	}
-	mutex_unlock(&iwdev->ah_tbl_lock);
+	mutex_unlock(&iwdev->rf->ah_tbl_lock);
 
 	uresp.ah_id = ah->sc_ah.ah_info.ah_idx;
 	err = ib_copy_to_udata(udata, &uresp, min(sizeof(uresp), udata->outlen));
-- 
2.42.0


