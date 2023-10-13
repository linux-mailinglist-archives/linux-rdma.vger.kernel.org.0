Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645BD7C7B69
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Oct 2023 04:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjJMCBR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Oct 2023 22:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjJMCBQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Oct 2023 22:01:16 -0400
Received: from out-205.mta0.migadu.com (out-205.mta0.migadu.com [IPv6:2001:41d0:1004:224b::cd])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EB3C9
        for <linux-rdma@vger.kernel.org>; Thu, 12 Oct 2023 19:01:14 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1697162473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8QWXY1PhPhm4onMUTkfyNxSBhqeIIDhkJyYRVb/18AM=;
        b=Jm+kyhSlCirCMFCfAeSWaAqh9NSNbsii05TOD1S6g9+fGyNKXLF1ql4IRR9G6NI/BHkoC9
        rjE8qUu1ODslGdOJpIAYai8oKEdv1pNW5Y3yVTgw1tjo5rVVX7Dn031La0M8zg7fZ4N3p/
        SSEatEsbayO2GYc+Gmm0topdZKkQA50=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH V2 08/20] RDMA/siw: Factor out siw_generic_rx helper
Date:   Fri, 13 Oct 2023 10:00:41 +0800
Message-Id: <20231013020053.2120-9-guoqing.jiang@linux.dev>
In-Reply-To: <20231013020053.2120-1-guoqing.jiang@linux.dev>
References: <20231013020053.2120-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Remove the redundant code given they share the same logic.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/sw/siw/siw_qp_rx.c | 53 ++++++++++-----------------
 1 file changed, 20 insertions(+), 33 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_qp_rx.c b/drivers/infiniband/sw/siw/siw_qp_rx.c
index aa7b680452fb..4931c0c57df0 100644
--- a/drivers/infiniband/sw/siw/siw_qp_rx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_rx.c
@@ -405,6 +405,20 @@ static struct siw_wqe *siw_rqe_get(struct siw_qp *qp)
 	return wqe;
 }
 
+static int siw_generic_rx(struct siw_mem *mem_p, struct siw_rx_stream *srx,
+			  unsigned int *pbl_idx, u64 addr, int bytes)
+{
+	int rv;
+
+	if (mem_p->mem_obj == NULL)
+		rv = siw_rx_kva(srx, ib_virt_dma_to_ptr(addr), bytes);
+	else if (!mem_p->is_pbl)
+		rv = siw_rx_umem(srx, mem_p->umem, addr, bytes);
+	else
+		rv = siw_rx_pbl(srx, pbl_idx, mem_p, addr, bytes);
+	return rv;
+}
+
 /*
  * siw_proc_send:
  *
@@ -485,17 +499,8 @@ int siw_proc_send(struct siw_qp *qp)
 			break;
 		}
 		mem_p = *mem;
-		if (mem_p->mem_obj == NULL)
-			rv = siw_rx_kva(srx,
-				ib_virt_dma_to_ptr(sge->laddr + frx->sge_off),
-				sge_bytes);
-		else if (!mem_p->is_pbl)
-			rv = siw_rx_umem(srx, mem_p->umem,
-					 sge->laddr + frx->sge_off, sge_bytes);
-		else
-			rv = siw_rx_pbl(srx, &frx->pbl_idx, mem_p,
-					sge->laddr + frx->sge_off, sge_bytes);
-
+		rv = siw_generic_rx(mem_p, srx, &frx->pbl_idx,
+				    sge->laddr + frx->sge_off, sge_bytes);
 		if (unlikely(rv != sge_bytes)) {
 			wqe->processed += rcvd_bytes;
 
@@ -598,17 +603,8 @@ int siw_proc_write(struct siw_qp *qp)
 		return -EINVAL;
 	}
 
-	if (mem->mem_obj == NULL)
-		rv = siw_rx_kva(srx,
-			(void *)(uintptr_t)(srx->ddp_to + srx->fpdu_part_rcvd),
-			bytes);
-	else if (!mem->is_pbl)
-		rv = siw_rx_umem(srx, mem->umem,
-				 srx->ddp_to + srx->fpdu_part_rcvd, bytes);
-	else
-		rv = siw_rx_pbl(srx, &frx->pbl_idx, mem,
-				srx->ddp_to + srx->fpdu_part_rcvd, bytes);
-
+	rv = siw_generic_rx(mem, srx, &frx->pbl_idx,
+			    srx->ddp_to + srx->fpdu_part_rcvd, bytes);
 	if (unlikely(rv != bytes)) {
 		siw_init_terminate(qp, TERM_ERROR_LAYER_DDP,
 				   DDP_ETYPE_CATASTROPHIC,
@@ -849,17 +845,8 @@ int siw_proc_rresp(struct siw_qp *qp)
 	mem_p = *mem;
 
 	bytes = min(srx->fpdu_part_rem, srx->skb_new);
-
-	if (mem_p->mem_obj == NULL)
-		rv = siw_rx_kva(srx,
-			ib_virt_dma_to_ptr(sge->laddr + wqe->processed),
-			bytes);
-	else if (!mem_p->is_pbl)
-		rv = siw_rx_umem(srx, mem_p->umem, sge->laddr + wqe->processed,
-				 bytes);
-	else
-		rv = siw_rx_pbl(srx, &frx->pbl_idx, mem_p,
-				sge->laddr + wqe->processed, bytes);
+	rv = siw_generic_rx(mem_p, srx, &frx->pbl_idx,
+			    sge->laddr + wqe->processed, bytes);
 	if (rv != bytes) {
 		wqe->wc_status = SIW_WC_GENERAL_ERR;
 		rv = -EINVAL;
-- 
2.35.3

