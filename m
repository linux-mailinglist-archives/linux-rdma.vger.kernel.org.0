Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9DC16477A7
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Dec 2022 22:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiLHVG0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Dec 2022 16:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiLHVGX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Dec 2022 16:06:23 -0500
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CC9786BC
        for <linux-rdma@vger.kernel.org>; Thu,  8 Dec 2022 13:06:20 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1433ef3b61fso3284868fac.10
        for <linux-rdma@vger.kernel.org>; Thu, 08 Dec 2022 13:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qvnJoTf0O/tnyT/nf5vfo5SJGf0Ff/gwGcFhvP0HgKI=;
        b=G21lQ/aPfLG8fGpwi7re4LmM1UbwJAxlVM7KLAKoDVAAX4b5h9hvA9ke7HfqgX7BEa
         q+cja6ugbu+55sKNwYltmR99Hy/lzm3JlIfyGyL+0laD4/i+vujbo+ENXfUogei/O/TF
         kJbU6H1Nym9u7ZPB1mynshKHZ/pbWuaNtHtRfwWwCXEFluJ7DnIEw5+/d4WrPNU7LBhC
         nCDe2tTigWGCJJJYW//YScYMGQ1x5O8UF7y9SQ14daaST9ZfowTMddxgqk+hvwfL/Rvb
         D6lKFVpY9be4syU54Ein0VhHUlDANCLfR+yCk74hR44O47hKP3bpH1QNV7jlx3hGqPe0
         Qi+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qvnJoTf0O/tnyT/nf5vfo5SJGf0Ff/gwGcFhvP0HgKI=;
        b=A7bmBbhzWpl8VXdg/DFe6HDRN0Ikvz6oSnPpbOoW9LM5xJR+zzt6B+Fzk9C3IE1HqQ
         9qjMkjn0cAAcoUePTBRuEPWe9l8OB50N6J9rlbbcSAHDMWVa0jTCVo0MrlWhRrD/MgqT
         o/FR/qgRC2NQd2fxB+5BJvuDYEvJXrkvvSCzvHgXz1p161NliCghQLLsaMBusth8s488
         UcG3z6eQg1QGK8YXCWP5AStlk8VrRlkgIJnKkyItqcigIBFULV/7DJPZTDChNPHlGz9O
         aiF38uDndiHemm5gbmGDvjEEHnuRshqsHqCVZdppDZlKG4CQtYzoSgwoXvy031ek/2g7
         PI2w==
X-Gm-Message-State: ANoB5pk3X6u9xDGsQr8QKq6/vXd25DwPKqPJON8bTOjiD8GBdyOSPz6O
        QXvzAM2cP48JUKcwMHZaCFoiuZp3YVE=
X-Google-Smtp-Source: AA0mqf5UJtuw1UDQPZKcgskhaU0uMKkGQq+OQkLq/eKV7yF8samg0WVFAntBBlGttGXpmWOuzwx05Q==
X-Received: by 2002:a05:6870:9f13:b0:143:91f5:65b2 with SMTP id xl19-20020a0568709f1300b0014391f565b2mr1601730oab.52.1670533580270;
        Thu, 08 Dec 2022 13:06:20 -0800 (PST)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-a13f-9234-e395-548a.res6.spectrum.com. [2603:8081:140c:1a00:a13f:9234:e395:548a])
        by smtp.googlemail.com with ESMTPSA id t11-20020a056870e74b00b0012763819bcasm5739250oak.50.2022.12.08.13.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 13:06:19 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leonro@nvidia.com, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 5/6] RDMA/rxe: Cleanup page variables in rxe_mr.c
Date:   Thu,  8 Dec 2022 15:05:47 -0600
Message-Id: <20221208210547.28562-6-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221208210547.28562-1-rpearsonhpe@gmail.com>
References: <20221208210547.28562-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Cleanup usage of mr->page_shift and mr->page_mask and introduce
an extractor for mr->ibmr.page_size. Normal usage in the kernel
has page_mask masking out offset in page rather than masking out
the page number. The rxe driver had reversed that which was confusing.
Implicitly there can be a per mr page_size which was not uniformly
supported.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c    | 28 +++++++++++++--------------
 drivers/infiniband/sw/rxe/rxe_verbs.h | 11 ++++++++---
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index c6aa86d28b89..2b600557fbfa 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -58,6 +58,9 @@ static void rxe_mr_init(int access, struct rxe_mr *mr)
 	mr->lkey = mr->ibmr.lkey = lkey;
 	mr->rkey = mr->ibmr.rkey = rkey;
 
+	mr->ibmr.page_size = PAGE_SIZE;
+	mr->page_mask = PAGE_MASK;
+	mr->page_shift = PAGE_SHIFT;
 	mr->state = RXE_MR_STATE_INVALID;
 }
 
@@ -138,9 +141,6 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 		goto err_release_umem;
 	}
 
-	mr->page_shift = PAGE_SHIFT;
-	mr->page_mask = PAGE_SIZE - 1;
-
 	num_buf			= 0;
 	map = mr->map;
 	if (length > 0) {
@@ -160,7 +160,7 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 				goto err_release_umem;
 			}
 			buf->addr = (uintptr_t)vaddr;
-			buf->size = PAGE_SIZE;
+			buf->size = mr_page_size(mr);
 			num_buf++;
 			buf++;
 
@@ -169,7 +169,7 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 
 	mr->umem = umem;
 	mr->access = access;
-	mr->offset = ib_umem_offset(umem);
+	mr->page_offset = ib_umem_offset(umem);
 	mr->state = RXE_MR_STATE_VALID;
 	mr->ibmr.type = IB_MR_TYPE_USER;
 
@@ -225,29 +225,27 @@ int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
 		  int sg_nents, unsigned int *sg_offset)
 {
 	struct rxe_mr *mr = to_rmr(ibmr);
-	int n;
+	unsigned int page_size = mr_page_size(mr);
 
-	mr->nbuf = 0;
-
-	n = ib_sg_to_pages(ibmr, sg, sg_nents, sg_offset, rxe_set_page);
+	mr->page_shift = ilog2(page_size);
+	mr->page_mask = ~((u64)page_size - 1);
+	mr->page_offset = ibmr->iova & (page_size - 1);
 
-	mr->page_shift = ilog2(ibmr->page_size);
-	mr->page_mask = ibmr->page_size - 1;
-	mr->offset = ibmr->iova & mr->page_mask;
+	mr->nbuf = 0;
 
-	return n;
+	return ib_sg_to_pages(ibmr, sg, sg_nents, sg_offset, rxe_set_page);
 }
 
 static void lookup_iova(struct rxe_mr *mr, u64 iova, int *m_out, int *n_out,
 			size_t *offset_out)
 {
-	size_t offset = iova - mr->ibmr.iova + mr->offset;
+	size_t offset = iova - mr->ibmr.iova + mr->page_offset;
 	int			map_index;
 	int			buf_index;
 	u64			length;
 
 	if (likely(mr->page_shift)) {
-		*offset_out = offset & mr->page_mask;
+		*offset_out = offset & (mr_page_size(mr) - 1);
 		offset >>= mr->page_shift;
 		*n_out = offset & mr->map_mask;
 		*m_out = offset >> mr->map_shift;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 22a299b0a9f0..ddaa4de5e1c7 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -304,11 +304,11 @@ struct rxe_mr {
 	u32			lkey;
 	u32			rkey;
 	enum rxe_mr_state	state;
-	u32			offset;
 	int			access;
 
-	int			page_shift;
-	int			page_mask;
+	unsigned int		page_offset;
+	unsigned int		page_shift;
+	u64			page_mask;
 	int			map_shift;
 	int			map_mask;
 
@@ -323,6 +323,11 @@ struct rxe_mr {
 	struct rxe_map		**map;
 };
 
+static inline unsigned int mr_page_size(struct rxe_mr *mr)
+{
+	return mr ? mr->ibmr.page_size : PAGE_SIZE;
+}
+
 enum rxe_mw_state {
 	RXE_MW_STATE_INVALID	= RXE_MR_STATE_INVALID,
 	RXE_MW_STATE_FREE	= RXE_MR_STATE_FREE,
-- 
2.37.2

