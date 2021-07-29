Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A67243D9F6A
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jul 2021 10:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbhG2IYK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Jul 2021 04:24:10 -0400
Received: from mx20.baidu.com ([111.202.115.85]:46352 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234256AbhG2IYJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 29 Jul 2021 04:24:09 -0400
Received: from BJHW-Mail-Ex06.internal.baidu.com (unknown [10.127.64.16])
        by Forcepoint Email with ESMTPS id DF24B8948CC6F6BE6635;
        Thu, 29 Jul 2021 16:23:54 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-Mail-Ex06.internal.baidu.com (10.127.64.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Thu, 29 Jul 2021 16:23:54 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Thu, 29 Jul 2021 16:23:54 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <mike.marciniszyn@cornelisnetworks.com>,
        <dennis.dalessandro@cornelisnetworks.com>, <dledford@redhat.com>,
        <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, Cai Huoqing <caihuoqing@baidu.com>
Subject: [PATCH] RDMA/hfi1: Fix typo in comments
Date:   Thu, 29 Jul 2021 16:23:46 +0800
Message-ID: <20210729082346.1882-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex27.internal.baidu.com (172.31.51.21) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex06_2021-07-29 16:23:54:901
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Remove the repeated word 'the' from comments

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/infiniband/hw/hfi1/chip.c     | 4 ++--
 drivers/infiniband/hw/hfi1/hfi.h      | 2 +-
 drivers/infiniband/hw/hfi1/ruc.c      | 2 +-
 drivers/infiniband/hw/hfi1/sdma.c     | 2 +-
 drivers/infiniband/hw/hfi1/tid_rdma.c | 4 ++--
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1/chip.c
index c97544638367..2c8c9b7e7df7 100644
--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -14414,7 +14414,7 @@ static void init_qos(struct hfi1_devdata *dd, struct rsm_map_table *rmt)
 	if (rmt->used + rmt_entries >= NUM_MAP_ENTRIES)
 		goto bail;
 
-	/* add qos entries to the the RSM map table */
+	/* add qos entries to the RSM map table */
 	for (i = 0, ctxt = FIRST_KERNEL_KCTXT; i < num_vls; i++) {
 		unsigned tctxt;
 
@@ -14893,7 +14893,7 @@ int hfi1_clear_ctxt_pkey(struct hfi1_devdata *dd, struct hfi1_ctxtdata *ctxt)
 }
 
 /*
- * Start doing the clean up the the chip. Our clean up happens in multiple
+ * Start doing the clean up the chip. Our clean up happens in multiple
  * stages and this is just the first.
  */
 void hfi1_start_cleanup(struct hfi1_devdata *dd)
diff --git a/drivers/infiniband/hw/hfi1/hfi.h b/drivers/infiniband/hw/hfi1/hfi.h
index 31664f43c27f..8fa85391de93 100644
--- a/drivers/infiniband/hw/hfi1/hfi.h
+++ b/drivers/infiniband/hw/hfi1/hfi.h
@@ -2601,7 +2601,7 @@ static inline bool hfi1_get_hdr_type(u32 lid, struct rdma_ah_attr *attr)
 			HFI1_PKT_TYPE_16B : HFI1_PKT_TYPE_9B;
 
 	/*
-	 * Return a 16B header type if either the the destination
+	 * Return a 16B header type if either the destination
 	 * or source lid is extended.
 	 */
 	if (hfi1_get_packet_type(rdma_ah_get_dlid(attr)) == HFI1_PKT_TYPE_16B)
diff --git a/drivers/infiniband/hw/hfi1/ruc.c b/drivers/infiniband/hw/hfi1/ruc.c
index c3fa1814c6a8..8cc65a7182f3 100644
--- a/drivers/infiniband/hw/hfi1/ruc.c
+++ b/drivers/infiniband/hw/hfi1/ruc.c
@@ -459,7 +459,7 @@ void hfi1_make_ruc_header(struct rvt_qp *qp, struct ib_other_headers *ohdr,
  * send engine
  * @qp: a pointer to QP
  * @ps: a pointer to a structure with commonly lookup values for
- *      the the send engine progress
+ *      the send engine progress
  * @tid: true if it is the tid leg
  *
  * This routine checks if the time slice for the QP has expired
diff --git a/drivers/infiniband/hw/hfi1/sdma.c b/drivers/infiniband/hw/hfi1/sdma.c
index eb15c310d63d..f5bd40152cb7 100644
--- a/drivers/infiniband/hw/hfi1/sdma.c
+++ b/drivers/infiniband/hw/hfi1/sdma.c
@@ -1860,7 +1860,7 @@ static void sdma_make_progress(struct sdma_engine *sde, u64 status)
 
 	/*
 	 * The SDMA idle interrupt is not guaranteed to be ordered with respect
-	 * to updates to the the dma_head location in host memory. The head
+	 * to updates to the dma_head location in host memory. The head
 	 * value read might not be fully up to date. If there are pending
 	 * descriptors and the SDMA idle interrupt fired then read from the
 	 * CSR SDMA head instead to get the latest value from the hardware.
diff --git a/drivers/infiniband/hw/hfi1/tid_rdma.c b/drivers/infiniband/hw/hfi1/tid_rdma.c
index 233ea48b72c8..2a7abf7a1f7f 100644
--- a/drivers/infiniband/hw/hfi1/tid_rdma.c
+++ b/drivers/infiniband/hw/hfi1/tid_rdma.c
@@ -605,7 +605,7 @@ static void __trigger_tid_waiter(struct rvt_qp *qp)
  * to this call via first_qp().
  *
  * If the qp trigger was already scheduled (!rval)
- * the the reference is dropped, otherwise the resume
+ * the reference is dropped, otherwise the resume
  * or the destroy cancel will dispatch the reference.
  */
 static void tid_rdma_schedule_tid_wakeup(struct rvt_qp *qp)
@@ -5174,7 +5174,7 @@ int hfi1_make_tid_rdma_pkt(struct rvt_qp *qp, struct hfi1_pkt_state *ps)
 	priv->s_flags &= ~RVT_S_BUSY;
 	/*
 	 * If we didn't get a txreq, the QP will be woken up later to try
-	 * again, set the flags to the the wake up which work item to wake
+	 * again, set the flags to the wake up which work item to wake
 	 * up.
 	 * (A better algorithm should be found to do this and generalize the
 	 * sleep/wakeup flags.)
-- 
2.25.1

