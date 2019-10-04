Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60186CC46B
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2019 22:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729440AbfJDUti (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Oct 2019 16:49:38 -0400
Received: from mga11.intel.com ([192.55.52.93]:19491 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729291AbfJDUti (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 4 Oct 2019 16:49:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2019 13:49:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,257,1566889200"; 
   d="scan'208";a="198965400"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Oct 2019 13:49:37 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id x94KnaPx058376;
        Fri, 4 Oct 2019 13:49:36 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id x94KnY9s026863;
        Fri, 4 Oct 2019 16:49:34 -0400
Subject: [PATCH for-rc 2/2] IB/hfi1: Use a common pad buffer for 9B and 16B
 packets
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Kaike Wan <kaike.wan@intel.com>
Date:   Fri, 04 Oct 2019 16:49:34 -0400
Message-ID: <20191004204934.26838.13099.stgit@awfm-01.aw.intel.com>
In-Reply-To: <20191004203739.26542.57060.stgit@awfm-01.aw.intel.com>
References: <20191004203739.26542.57060.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mike Marciniszyn <mike.marciniszyn@intel.com>

There is no reason for a different pad buffer for the two
packet types.

Expand the current buffer allocation to allow for both
packet types.

Fixes: f8195f3b14a0 ("IB/hfi1: Eliminate allocation while atomic")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Kaike Wan <kaike.wan@intel.com>
Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/hw/hfi1/sdma.c  |    5 +++--
 drivers/infiniband/hw/hfi1/verbs.c |   10 ++++------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/sdma.c b/drivers/infiniband/hw/hfi1/sdma.c
index 2ed7bfd..c61b6022 100644
--- a/drivers/infiniband/hw/hfi1/sdma.c
+++ b/drivers/infiniband/hw/hfi1/sdma.c
@@ -65,6 +65,7 @@
 #define SDMA_DESCQ_CNT 2048
 #define SDMA_DESC_INTR 64
 #define INVALID_TAIL 0xffff
+#define SDMA_PAD max_t(size_t, MAX_16B_PADDING, sizeof(u32))
 
 static uint sdma_descq_cnt = SDMA_DESCQ_CNT;
 module_param(sdma_descq_cnt, uint, S_IRUGO);
@@ -1296,7 +1297,7 @@ void sdma_clean(struct hfi1_devdata *dd, size_t num_engines)
 	struct sdma_engine *sde;
 
 	if (dd->sdma_pad_dma) {
-		dma_free_coherent(&dd->pcidev->dev, 4,
+		dma_free_coherent(&dd->pcidev->dev, SDMA_PAD,
 				  (void *)dd->sdma_pad_dma,
 				  dd->sdma_pad_phys);
 		dd->sdma_pad_dma = NULL;
@@ -1491,7 +1492,7 @@ int sdma_init(struct hfi1_devdata *dd, u8 port)
 	}
 
 	/* Allocate memory for pad */
-	dd->sdma_pad_dma = dma_alloc_coherent(&dd->pcidev->dev, sizeof(u32),
+	dd->sdma_pad_dma = dma_alloc_coherent(&dd->pcidev->dev, SDMA_PAD,
 					      &dd->sdma_pad_phys, GFP_KERNEL);
 	if (!dd->sdma_pad_dma) {
 		dd_dev_err(dd, "failed to allocate SendDMA pad memory\n");
diff --git a/drivers/infiniband/hw/hfi1/verbs.c b/drivers/infiniband/hw/hfi1/verbs.c
index 7bff0a1..089e201 100644
--- a/drivers/infiniband/hw/hfi1/verbs.c
+++ b/drivers/infiniband/hw/hfi1/verbs.c
@@ -147,9 +147,6 @@ static int pio_wait(struct rvt_qp *qp,
 /* Length of buffer to create verbs txreq cache name */
 #define TXREQ_NAME_LEN 24
 
-/* 16B trailing buffer */
-static const u8 trail_buf[MAX_16B_PADDING];
-
 static uint wss_threshold = 80;
 module_param(wss_threshold, uint, S_IRUGO);
 MODULE_PARM_DESC(wss_threshold, "Percentage (1-100) of LLC to use as a threshold for a cacheless copy");
@@ -820,8 +817,8 @@ static int build_verbs_tx_desc(
 
 	/* add icrc, lt byte, and padding to flit */
 	if (extra_bytes)
-		ret = sdma_txadd_kvaddr(sde->dd, &tx->txreq,
-					(void *)trail_buf, extra_bytes);
+		ret = sdma_txadd_daddr(sde->dd, &tx->txreq,
+				       sde->dd->sdma_pad_phys, extra_bytes);
 
 bail_txadd:
 	return ret;
@@ -1089,7 +1086,8 @@ int hfi1_verbs_send_pio(struct rvt_qp *qp, struct hfi1_pkt_state *ps,
 		}
 		/* add icrc, lt byte, and padding to flit */
 		if (extra_bytes)
-			seg_pio_copy_mid(pbuf, trail_buf, extra_bytes);
+			seg_pio_copy_mid(pbuf, ppd->dd->sdma_pad_dma,
+					 extra_bytes);
 
 		seg_pio_copy_end(pbuf);
 	}

