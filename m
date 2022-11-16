Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5B762BB88
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Nov 2022 12:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237359AbiKPLYn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Nov 2022 06:24:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239203AbiKPLYZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Nov 2022 06:24:25 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418076432
        for <linux-rdma@vger.kernel.org>; Wed, 16 Nov 2022 03:14:24 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1668597262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FeZJDyvy2k1yMG7X6RBCLmLoH6HX8BrnLiKUuq8/UYc=;
        b=K712G5J56UmCsSviuFCmbzIV1gtf/yHgTyEcYX/ANJmex9PmZEoUDeetEqUjlyG6KWTQYI
        EH3hZZD1nWbIOkw8gUFeDxbEr/rTu9rXzyLVyFVLRzMiy5fMxQwW92huI8h3sNtzYPdUuZ
        b0taykOqGWF/atOPMub9qVxIZY2QhKI=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, jgg@ziepe.ca,
        leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH 2/8] RDMA/rtrs-srv: Refactor the handling of failure case in map_cont_bufs
Date:   Wed, 16 Nov 2022 19:13:54 +0800
Message-Id: <20221116111400.7203-3-guoqing.jiang@linux.dev>
In-Reply-To: <20221116111400.7203-1-guoqing.jiang@linux.dev>
References: <20221116111400.7203-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Let's call unmap_cont_bufs when failure happens, and also only update
mrs_num after everything is settled which means we can remove 'mri'.

Acked-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 47 +++++++++++---------------
 1 file changed, 20 insertions(+), 27 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 5fe3699cb8ff..b877dd57b6b9 100644
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

