Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DD0626D36
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Nov 2022 02:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235105AbiKMBIr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 12 Nov 2022 20:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235078AbiKMBIp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 12 Nov 2022 20:08:45 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB9225E9
        for <linux-rdma@vger.kernel.org>; Sat, 12 Nov 2022 17:08:45 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1668301723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2lOdAc8lMynHl4hfQD1aIg7xEwiGyZy2SIdkL0eMrE0=;
        b=d83YCq7U/Ajwb3tZm3Rb2/vto1neyU7wBvn1aCD671vRh6VYWfigknyU3bGOzYq5HsfWqZ
        knMMOj4wL13aGvQe+NjGw73u0GBAsvr/Q2ERH63L8r2LJa/irbHDm52Zpl4UX8EsjlfDHr
        SVtb+qBAvPL8LzomeblEn5BPKIOBvdE=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, jgg@ziepe.ca,
        leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH RFC 04/12] RDMA/rtrs-srv: refactor the handling of failure case in map_cont_bufs
Date:   Sun, 13 Nov 2022 09:08:15 +0800
Message-Id: <20221113010823.6436-5-guoqing.jiang@linux.dev>
In-Reply-To: <20221113010823.6436-1-guoqing.jiang@linux.dev>
References: <20221113010823.6436-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Let's call unmap_cont_bufs when failure happens, and also only update
mrs_num after everything is settled which means we can remove 'mri'.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 47 +++++++++++---------------
 1 file changed, 20 insertions(+), 27 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 063082d29fc6..88eae0dcf87f 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -561,9 +561,11 @@ static int map_cont_bufs(struct rtrs_srv_path *srv_path)
 {
 	struct rtrs_srv_sess *srv = srv_path->srv;
 	struct rtrs_path *ss = &srv_path->s;
-	int i, mri, err, mrs_num;
+	int i, err, mrs_num;
 	unsigned int chunk_bits;
 	int chunks_per_mr = 1;
+	struct ib_mr *mr;
+	struct sg_table *sgt;
 
 	/*
 	 * Here we map queue_depth chunks to MR.  Firstly we have to
@@ -586,16 +588,14 @@ static int map_cont_bufs(struct rtrs_srv_path *srv_path)
 	if (!srv_path->mrs)
 		return -ENOMEM;
 
-	srv_path->mrs_num = mrs_num;
-
-	for (mri = 0; mri < mrs_num; mri++) {
-		struct rtrs_srv_mr *srv_mr = &srv_path->mrs[mri];
-		struct sg_table *sgt = &srv_mr->sgt;
+	for (srv_path->mrs_num = 0; srv_path->mrs_num < mrs_num;
+	     srv_path->mrs_num++) {
+		struct rtrs_srv_mr *srv_mr = &srv_path->mrs[srv_path->mrs_num];
 		struct scatterlist *s;
-		struct ib_mr *mr;
 		int nr, nr_sgt, chunks;
 
-		chunks = chunks_per_mr * mri;
+		sgt = &srv_mr->sgt;
+		chunks = chunks_per_mr * srv_path->mrs_num;
 		if (!always_invalidate)
 			chunks_per_mr = min_t(int, chunks_per_mr,
 					      srv->queue_depth - chunks);
@@ -644,31 +644,24 @@ static int map_cont_bufs(struct rtrs_srv_path *srv_path)
 
 		ib_update_fast_reg_key(mr, ib_inc_rkey(mr->rkey));
 		srv_mr->mr = mr;
-
-		continue;
-err:
-		while (mri--) {
-			srv_mr = &srv_path->mrs[mri];
-			sgt = &srv_mr->sgt;
-			mr = srv_mr->mr;
-			rtrs_iu_free(srv_mr->iu, srv_path->s.dev->ib_dev, 1);
-dereg_mr:
-			ib_dereg_mr(mr);
-unmap_sg:
-			ib_dma_unmap_sg(srv_path->s.dev->ib_dev, sgt->sgl,
-					sgt->nents, DMA_BIDIRECTIONAL);
-free_sg:
-			sg_free_table(sgt);
-		}
-		kfree(srv_path->mrs);
-
-		return err;
 	}
 
 	chunk_bits = ilog2(srv->queue_depth - 1) + 1;
 	srv_path->mem_bits = (MAX_IMM_PAYL_BITS - chunk_bits);
 
 	return 0;
+
+dereg_mr:
+	ib_dereg_mr(mr);
+unmap_sg:
+	ib_dma_unmap_sg(srv_path->s.dev->ib_dev, sgt->sgl,
+			sgt->nents, DMA_BIDIRECTIONAL);
+free_sg:
+	sg_free_table(sgt);
+err:
+	unmap_cont_bufs(srv_path);
+
+	return err;
 }
 
 static void rtrs_srv_hb_err_handler(struct rtrs_con *c)
-- 
2.31.1

