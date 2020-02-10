Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 125471579DD
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Feb 2020 14:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbgBJNSj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Feb 2020 08:18:39 -0500
Received: from mga06.intel.com ([134.134.136.31]:22574 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729211AbgBJNSe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 Feb 2020 08:18:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Feb 2020 05:18:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,425,1574150400"; 
   d="scan'208";a="226192606"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by fmsmga007.fm.intel.com with ESMTP; 10 Feb 2020 05:18:33 -0800
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id 01ADIWf6008026;
        Mon, 10 Feb 2020 06:18:33 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id 01ADIVFn088299;
        Mon, 10 Feb 2020 08:18:31 -0500
Subject: [PATCH for-next 04/16] IB/hfi1: Remove module parameter for KDETH
 qpns
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.alessandro@intel.com>,
        Gary Leshner <Gary.S.Leshner@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
Date:   Mon, 10 Feb 2020 08:18:31 -0500
Message-ID: <20200210131831.87776.8721.stgit@awfm-01.aw.intel.com>
In-Reply-To: <20200210131223.87776.21339.stgit@awfm-01.aw.intel.com>
References: <20200210131223.87776.21339.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Gary Leshner <Gary.S.Leshner@intel.com>

The module parameter for KDETH qpns is being removed in favor
of always using the default value of 0x80 as the qpn prefix.
Defines have been added for various KDETH values including
the prefix of 0x80.
The reserved range now starts at the base value for KDETH
qpns (0x80) and extends up to and including the last qpn for
other reserved QP prefixed types.
Adjust other QP prefixed define names to match KDETH defined
names.

Reviewed-by: Dennis Dalessandro <dennis.alessandro@intel.com>
Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Gary Leshner <Gary.S.Leshner@intel.com>
Signed-off-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/hw/hfi1/chip.c     |   19 +++----------------
 drivers/infiniband/hw/hfi1/common.h   |    7 -------
 drivers/infiniband/hw/hfi1/file_ops.c |    4 ++--
 drivers/infiniband/hw/hfi1/hfi.h      |    3 +--
 drivers/infiniband/hw/hfi1/tid_rdma.c |    4 ++--
 drivers/infiniband/hw/hfi1/verbs.c    |    7 +++----
 include/rdma/rdmavt_qp.h              |   29 ++++++++++++++++++++++++++++-
 7 files changed, 39 insertions(+), 34 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1/chip.c
index e0b1238..c08bf81 100644
--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -1,5 +1,5 @@
 /*
- * Copyright(c) 2015 - 2018 Intel Corporation.
+ * Copyright(c) 2015 - 2020 Intel Corporation.
  *
  * This file is provided under a dual BSD/GPLv2 license.  When using or
  * redistributing this file, you may do so under either license.
@@ -67,10 +67,6 @@
 #include "debugfs.h"
 #include "fault.h"
 
-uint kdeth_qp;
-module_param_named(kdeth_qp, kdeth_qp, uint, S_IRUGO);
-MODULE_PARM_DESC(kdeth_qp, "Set the KDETH queue pair prefix");
-
 uint num_vls = HFI1_MAX_VLS_SUPPORTED;
 module_param(num_vls, uint, S_IRUGO);
 MODULE_PARM_DESC(num_vls, "Set number of Virtual Lanes to use (1-8)");
@@ -14119,21 +14115,12 @@ static void init_early_variables(struct hfi1_devdata *dd)
 
 static void init_kdeth_qp(struct hfi1_devdata *dd)
 {
-	/* user changed the KDETH_QP */
-	if (kdeth_qp != 0 && kdeth_qp >= 0xff) {
-		/* out of range or illegal value */
-		dd_dev_err(dd, "Invalid KDETH queue pair prefix, ignoring");
-		kdeth_qp = 0;
-	}
-	if (kdeth_qp == 0)	/* not set, or failed range check */
-		kdeth_qp = DEFAULT_KDETH_QP;
-
 	write_csr(dd, SEND_BTH_QP,
-		  (kdeth_qp & SEND_BTH_QP_KDETH_QP_MASK) <<
+		  (RVT_KDETH_QP_PREFIX & SEND_BTH_QP_KDETH_QP_MASK) <<
 		  SEND_BTH_QP_KDETH_QP_SHIFT);
 
 	write_csr(dd, RCV_BTH_QP,
-		  (kdeth_qp & RCV_BTH_QP_KDETH_QP_MASK) <<
+		  (RVT_KDETH_QP_PREFIX & RCV_BTH_QP_KDETH_QP_MASK) <<
 		  RCV_BTH_QP_KDETH_QP_SHIFT);
 }
 
diff --git a/drivers/infiniband/hw/hfi1/common.h b/drivers/infiniband/hw/hfi1/common.h
index 1f7107e..6062545 100644
--- a/drivers/infiniband/hw/hfi1/common.h
+++ b/drivers/infiniband/hw/hfi1/common.h
@@ -72,13 +72,6 @@
  * compilation unit
  */
 
-/*
- * If a packet's QP[23:16] bits match this value, then it is
- * a PSM packet and the hardware will expect a KDETH header
- * following the BTH.
- */
-#define DEFAULT_KDETH_QP 0x80
-
 /* driver/hw feature set bitmask */
 #define HFI1_CAP_USER_SHIFT      24
 #define HFI1_CAP_MASK            ((1UL << HFI1_CAP_USER_SHIFT) - 1)
diff --git a/drivers/infiniband/hw/hfi1/file_ops.c b/drivers/infiniband/hw/hfi1/file_ops.c
index 2591158..00ba8d9 100644
--- a/drivers/infiniband/hw/hfi1/file_ops.c
+++ b/drivers/infiniband/hw/hfi1/file_ops.c
@@ -1,5 +1,5 @@
 /*
- * Copyright(c) 2015-2017 Intel Corporation.
+ * Copyright(c) 2015-2020 Intel Corporation.
  *
  * This file is provided under a dual BSD/GPLv2 license.  When using or
  * redistributing this file, you may do so under either license.
@@ -1266,7 +1266,7 @@ static int get_base_info(struct hfi1_filedata *fd, unsigned long arg, u32 len)
 	memset(&binfo, 0, sizeof(binfo));
 	binfo.hw_version = dd->revision;
 	binfo.sw_version = HFI1_KERN_SWVERSION;
-	binfo.bthqp = kdeth_qp;
+	binfo.bthqp = RVT_KDETH_QP_PREFIX;
 	binfo.jkey = uctxt->jkey;
 	/*
 	 * If more than 64 contexts are enabled the allocated credit
diff --git a/drivers/infiniband/hw/hfi1/hfi.h b/drivers/infiniband/hw/hfi1/hfi.h
index cae12f4..92fceb5 100644
--- a/drivers/infiniband/hw/hfi1/hfi.h
+++ b/drivers/infiniband/hw/hfi1/hfi.h
@@ -1,7 +1,7 @@
 #ifndef _HFI1_KERNEL_H
 #define _HFI1_KERNEL_H
 /*
- * Copyright(c) 2015-2018 Intel Corporation.
+ * Copyright(c) 2015-2020 Intel Corporation.
  *
  * This file is provided under a dual BSD/GPLv2 license.  When using or
  * redistributing this file, you may do so under either license.
@@ -2252,7 +2252,6 @@ static inline void flush_wc(void)
 extern unsigned long n_krcvqs;
 extern uint krcvqs[];
 extern int krcvqsset;
-extern uint kdeth_qp;
 extern uint loopback;
 extern uint quick_linkup;
 extern uint rcv_intr_timeout;
diff --git a/drivers/infiniband/hw/hfi1/tid_rdma.c b/drivers/infiniband/hw/hfi1/tid_rdma.c
index 8a2e0d9..243b4ba 100644
--- a/drivers/infiniband/hw/hfi1/tid_rdma.c
+++ b/drivers/infiniband/hw/hfi1/tid_rdma.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
 /*
- * Copyright(c) 2018 Intel Corporation.
+ * Copyright(c) 2018 - 2020 Intel Corporation.
  *
  */
 
@@ -194,7 +194,7 @@ void tid_rdma_opfn_init(struct rvt_qp *qp, struct tid_rdma_params *p)
 {
 	struct hfi1_qp_priv *priv = qp->priv;
 
-	p->qp = (kdeth_qp << 16) | priv->rcd->ctxt;
+	p->qp = (RVT_KDETH_QP_PREFIX << 16) | priv->rcd->ctxt;
 	p->max_len = TID_RDMA_MAX_SEGMENT_SIZE;
 	p->jkey = priv->rcd->jkey;
 	p->max_read = TID_RDMA_MAX_READ_SEGS_PER_REQ;
diff --git a/drivers/infiniband/hw/hfi1/verbs.c b/drivers/infiniband/hw/hfi1/verbs.c
index 089e201..2bddc28 100644
--- a/drivers/infiniband/hw/hfi1/verbs.c
+++ b/drivers/infiniband/hw/hfi1/verbs.c
@@ -1,5 +1,5 @@
 /*
- * Copyright(c) 2015 - 2018 Intel Corporation.
+ * Copyright(c) 2015 - 2020 Intel Corporation.
  *
  * This file is provided under a dual BSD/GPLv2 license.  When using or
  * redistributing this file, you may do so under either license.
@@ -1861,9 +1861,8 @@ int hfi1_register_ib_device(struct hfi1_devdata *dd)
 	dd->verbs_dev.rdi.dparms.qpn_start = 0;
 	dd->verbs_dev.rdi.dparms.qpn_inc = 1;
 	dd->verbs_dev.rdi.dparms.qos_shift = dd->qos_shift;
-	dd->verbs_dev.rdi.dparms.qpn_res_start = kdeth_qp << 16;
-	dd->verbs_dev.rdi.dparms.qpn_res_end =
-	dd->verbs_dev.rdi.dparms.qpn_res_start + 65535;
+	dd->verbs_dev.rdi.dparms.qpn_res_start = RVT_KDETH_QP_BASE;
+	dd->verbs_dev.rdi.dparms.qpn_res_end = RVT_AIP_QP_MAX;
 	dd->verbs_dev.rdi.dparms.max_rdma_atomic = HFI1_MAX_RDMA_ATOMIC;
 	dd->verbs_dev.rdi.dparms.psn_mask = PSN_MASK;
 	dd->verbs_dev.rdi.dparms.psn_shift = PSN_SHIFT;
diff --git a/include/rdma/rdmavt_qp.h b/include/rdma/rdmavt_qp.h
index 0d5c70e..afd7be6 100644
--- a/include/rdma/rdmavt_qp.h
+++ b/include/rdma/rdmavt_qp.h
@@ -2,7 +2,7 @@
 #define DEF_RDMAVT_INCQP_H
 
 /*
- * Copyright(c) 2016 - 2019 Intel Corporation.
+ * Copyright(c) 2016 - 2020 Intel Corporation.
  *
  * This file is provided under a dual BSD/GPLv2 license.  When using or
  * redistributing this file, you may do so under either license.
@@ -69,6 +69,33 @@
 #define RVT_R_COMM_EST  0x10
 
 /*
+ * If a packet's QP[23:16] bits match this value, then it is
+ * a PSM packet and the hardware will expect a KDETH header
+ * following the BTH.
+ */
+#define RVT_KDETH_QP_PREFIX       0x80
+#define RVT_KDETH_QP_SUFFIX       0xffff
+#define RVT_KDETH_QP_PREFIX_MASK  0x00ff0000
+#define RVT_KDETH_QP_PREFIX_SHIFT 16
+#define RVT_KDETH_QP_BASE         (u32)(RVT_KDETH_QP_PREFIX << \
+					RVT_KDETH_QP_PREFIX_SHIFT)
+#define RVT_KDETH_QP_MAX          (u32)(RVT_KDETH_QP_BASE + RVT_KDETH_QP_SUFFIX)
+
+/*
+ * If a packet's LNH == BTH and DEST QPN[23:16] in the BTH match this
+ * prefix value, then it is an AIP packet with a DETH containing the entropy
+ * value in byte 4 following the BTH.
+ */
+#define RVT_AIP_QP_PREFIX       0x81
+#define RVT_AIP_QP_SUFFIX       0xffff
+#define RVT_AIP_QP_PREFIX_MASK  0x00ff0000
+#define RVT_AIP_QP_PREFIX_SHIFT 16
+#define RVT_AIP_QP_BASE         (u32)(RVT_AIP_QP_PREFIX << \
+				      RVT_AIP_QP_PREFIX_SHIFT)
+#define RVT_AIP_QPN_MAX         BIT(RVT_AIP_QP_PREFIX_SHIFT)
+#define RVT_AIP_QP_MAX          (u32)(RVT_AIP_QP_BASE + RVT_AIP_QPN_MAX - 1)
+
+/*
  * Bit definitions for s_flags.
  *
  * RVT_S_SIGNAL_REQ_WR - set if QP send WRs contain completion signaled

