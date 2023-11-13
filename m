Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D730E7E9B96
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Nov 2023 12:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjKML5s (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Nov 2023 06:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjKML5r (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Nov 2023 06:57:47 -0500
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770D3D70
        for <linux-rdma@vger.kernel.org>; Mon, 13 Nov 2023 03:57:44 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699876662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OZANMPHie+HKVjyA+KVrxiOg9yFSnCOaLgxewqW/ZSU=;
        b=vgR2D3nEbvdco/Vm+kCOh8rdiHHqtsdUCAqQ3qrZ/fXW2TqLjyFO6PvJX8ECqSttT5F7Tf
        0io7vE2IXIW26K3b5EsrX9r4IXM/ndfBG+xH5JgA6dnkBfjb/ofKd0+pSXKhMhpAh0b8rX
        ATmwQTVUqts/r0zZhbkYsEZZkQHVPCI=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH V5 07/17] RDMA/siw: Factor out siw_rx_data helper
Date:   Mon, 13 Nov 2023 19:57:16 +0800
Message-Id: <20231113115726.12762-8-guoqing.jiang@linux.dev>
In-Reply-To: <20231113115726.12762-1-guoqing.jiang@linux.dev>
References: <20231113115726.12762-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Remove the redundant code given they share the same logic.

Acked-by: Bernard Metzler <bmt@zurich.ibm.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/sw/siw/siw_qp_rx.c | 53 ++++++++++-----------------
 1 file changed, 20 insertions(+), 33 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_qp_rx.c b/drivers/infiniband/sw/siw/siw_qp_rx.c
index 10805a7d0487..ed4fc39718b4 100644
--- a/drivers/infiniband/sw/siw/siw_qp_rx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_rx.c
@@ -405,6 +405,20 @@ static struct siw_wqe *siw_rqe_get(struct siw_qp *qp)
 	return wqe;
 }
 
+static int siw_rx_data(struct siw_mem *mem_p, struct siw_rx_stream *srx,
+		       unsigned int *pbl_idx, u64 addr, int bytes)
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
+		rv = siw_rx_data(mem_p, srx, &frx->pbl_idx,
+				 sge->laddr + frx->sge_off, sge_bytes);
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
+	rv = siw_rx_data(mem, srx, &frx->pbl_idx,
+			 srx->ddp_to + srx->fpdu_part_rcvd, bytes);
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
+	rv = siw_rx_data(mem_p, srx, &frx->pbl_idx,
+			 sge->laddr + wqe->processed, bytes);
 	if (rv != bytes) {
 		wqe->wc_status = SIW_WC_GENERAL_ERR;
 		rv = -EINVAL;
-- 
2.35.3

