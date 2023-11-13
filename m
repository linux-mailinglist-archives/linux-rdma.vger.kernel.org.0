Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BEB7E9B90
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Nov 2023 12:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjKML5l (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Nov 2023 06:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjKML5l (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Nov 2023 06:57:41 -0500
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE66ED70
        for <linux-rdma@vger.kernel.org>; Mon, 13 Nov 2023 03:57:37 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699876656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LPbkjIZ3do+yOOCnrLbYUAUqYJtK1g+GboREzENwAoQ=;
        b=WFsrYUCx2S5ks/V+ORUAt1V4IH9AYzekJh+9g8I+vwGcxNxN1vPgJDKzBizlmL7nvxxM3O
        u+2gjA5vlvUSxWZQMt8DGeaxwCimAxwy5fcxzgBuvlewh7qKH2x3vWaFNHPFQEqzvYytxE
        jU5LMt5EK/bOQKf0Jr7fkGyZBip7fhU=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH V5 02/17] RDMA/siw: Introduce siw_update_skb_rcvd
Date:   Mon, 13 Nov 2023 19:57:11 +0800
Message-Id: <20231113115726.12762-3-guoqing.jiang@linux.dev>
In-Reply-To: <20231113115726.12762-1-guoqing.jiang@linux.dev>
References: <20231113115726.12762-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There are some places share the same logic, factor a common
helper for it.

Acked-by: Bernard Metzler <bmt@zurich.ibm.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/sw/siw/siw_qp_rx.c | 31 +++++++++++----------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_qp_rx.c b/drivers/infiniband/sw/siw/siw_qp_rx.c
index 33e0fdb362ff..10805a7d0487 100644
--- a/drivers/infiniband/sw/siw/siw_qp_rx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_rx.c
@@ -881,6 +881,13 @@ int siw_proc_rresp(struct siw_qp *qp)
 	return rv;
 }
 
+static void siw_update_skb_rcvd(struct siw_rx_stream *srx, u16 length)
+{
+	srx->skb_offset += length;
+	srx->skb_new -= length;
+	srx->skb_copied += length;
+}
+
 int siw_proc_terminate(struct siw_qp *qp)
 {
 	struct siw_rx_stream *srx = &qp->rx_stream;
@@ -925,9 +932,7 @@ int siw_proc_terminate(struct siw_qp *qp)
 		goto out;
 
 	infop += to_copy;
-	srx->skb_offset += to_copy;
-	srx->skb_new -= to_copy;
-	srx->skb_copied += to_copy;
+	siw_update_skb_rcvd(srx, to_copy);
 	srx->fpdu_part_rcvd += to_copy;
 	srx->fpdu_part_rem -= to_copy;
 
@@ -949,9 +954,7 @@ int siw_proc_terminate(struct siw_qp *qp)
 			   term->flag_m ? "valid" : "invalid");
 	}
 out:
-	srx->skb_new -= to_copy;
-	srx->skb_offset += to_copy;
-	srx->skb_copied += to_copy;
+	siw_update_skb_rcvd(srx, to_copy);
 	srx->fpdu_part_rcvd += to_copy;
 	srx->fpdu_part_rem -= to_copy;
 
@@ -970,9 +973,7 @@ static int siw_get_trailer(struct siw_qp *qp, struct siw_rx_stream *srx)
 
 	skb_copy_bits(skb, srx->skb_offset, tbuf, avail);
 
-	srx->skb_new -= avail;
-	srx->skb_offset += avail;
-	srx->skb_copied += avail;
+	siw_update_skb_rcvd(srx, avail);
 	srx->fpdu_part_rem -= avail;
 
 	if (srx->fpdu_part_rem)
@@ -1023,12 +1024,8 @@ static int siw_get_hdr(struct siw_rx_stream *srx)
 		skb_copy_bits(skb, srx->skb_offset,
 			      (char *)c_hdr + srx->fpdu_part_rcvd, bytes);
 
+		siw_update_skb_rcvd(srx, bytes);
 		srx->fpdu_part_rcvd += bytes;
-
-		srx->skb_new -= bytes;
-		srx->skb_offset += bytes;
-		srx->skb_copied += bytes;
-
 		if (srx->fpdu_part_rcvd < MIN_DDP_HDR)
 			return -EAGAIN;
 
@@ -1091,12 +1088,8 @@ static int siw_get_hdr(struct siw_rx_stream *srx)
 		skb_copy_bits(skb, srx->skb_offset,
 			      (char *)c_hdr + srx->fpdu_part_rcvd, bytes);
 
+		siw_update_skb_rcvd(srx, bytes);
 		srx->fpdu_part_rcvd += bytes;
-
-		srx->skb_new -= bytes;
-		srx->skb_offset += bytes;
-		srx->skb_copied += bytes;
-
 		if (srx->fpdu_part_rcvd < hdrlen)
 			return -EAGAIN;
 	}
-- 
2.35.3

