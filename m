Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FB566E4F6
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jan 2023 18:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235203AbjAQRct (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Jan 2023 12:32:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235342AbjAQR2d (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Jan 2023 12:28:33 -0500
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4344E4B198
        for <linux-rdma@vger.kernel.org>; Tue, 17 Jan 2023 09:27:05 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-15ed38a9b04so14046222fac.8
        for <linux-rdma@vger.kernel.org>; Tue, 17 Jan 2023 09:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+tMrbES7iAPFERVwmrpXMmq8ACmpuWPOnqo2LwvtS/M=;
        b=FkARL91RVeaULP/HtRJ9uP5ChLYA20JuOjoly6HDusGhXD7bhNUy0iC76UUDs9c6xF
         eS75hwNE85JYk8RA4cqMeK/ZLzuIkVIxgFG6HA60/rAGn1jzTzjI029imLRNNp/kZiow
         +Slfl9Z86gLOErzrUXQsQxGEiTMeA4gLyaYxuSrvtnvBfR6s9ciRT2EHtiJCY6f/LI4X
         THdTV9sr6W5m9Z84pq+3UrbGNoS44JKlR4nvCPAx5WKDSyr2nAO5fFioNC3DNz9AU3vg
         2rguVKyI7fgon7rLZgUGR4jozT9cYIutNY2SuNY4JVJR40s1xnL9IG6dzRqGh6feizvD
         xdNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+tMrbES7iAPFERVwmrpXMmq8ACmpuWPOnqo2LwvtS/M=;
        b=NvX5L2WBIOy14YTViu+7DdYG4LLLy2LxHgr+5oGJI65FO3CQ85H/ukrSz1CFp1qQX/
         77R6iwOJxbK9AfNMfldIlEOCuTUNwMW1O0GwKSiBVX6rFahwXtx6tllVdbKyvbMmegFT
         BqRhM9qzXg/1i/7jFC9uuys0XEmMd2PRXzqBiZwxTtDEmB/Afl0SiuMujcdaTYhYZT0g
         dZFQEqaGXsZCFoIc2AQ4pAnnK5BbXnteWkVZEOZYApAi26AbgOOv4X76eTRvpa5J2jI2
         Veg5ZpNL4Ob7S81HkIZ0leXxJmFuIorj0phf6h8Spt6JHo5ULBU3LrwBxctq5CKGo73M
         sfaw==
X-Gm-Message-State: AFqh2kphOeOH2qlsbVr5lZKNuic+IBqRMjHFZSUHDs8NPwjtfRHxI7Bk
        IV+3GdUBmIEddsx0AMyfYNM=
X-Google-Smtp-Source: AMrXdXtlO/3Uz5pJqCvGhVwfru/ZA/4RUbPLVcts9n5PtlgvLrG/wG5XxivHD45E7E+f34TCPvmUYw==
X-Received: by 2002:a05:6870:bc11:b0:156:680c:d12c with SMTP id oa17-20020a056870bc1100b00156680cd12cmr2439072oab.51.1673976424953;
        Tue, 17 Jan 2023 09:27:04 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-ea18-3ee9-26d1-7526.res6.spectrum.com. [2603:8081:140c:1a00:ea18:3ee9:26d1:7526])
        by smtp.gmail.com with ESMTPSA id l3-20020a056870218300b00152c52608dbsm16936489oae.34.2023.01.17.09.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 09:27:04 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, leonro@nvidia.com,
        yangx.jy@fujitsu.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v6 5/6] RDMA/rxe: Cleanup page variables in rxe_mr.c
Date:   Tue, 17 Jan 2023 11:25:40 -0600
Message-Id: <20230117172540.33205-6-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230117172540.33205-1-rpearsonhpe@gmail.com>
References: <20230117172540.33205-1-rpearsonhpe@gmail.com>
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
 drivers/infiniband/sw/rxe/rxe_mr.c    | 31 ++++++++++++---------------
 drivers/infiniband/sw/rxe/rxe_verbs.h | 11 +++++++---
 2 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 10484f671977..fdf76df4cf3e 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -62,6 +62,9 @@ static void rxe_mr_init(int access, struct rxe_mr *mr)
 	mr->lkey = mr->ibmr.lkey = lkey;
 	mr->rkey = mr->ibmr.rkey = rkey;
 
+	mr->ibmr.page_size = PAGE_SIZE;
+	mr->page_mask = PAGE_MASK;
+	mr->page_shift = PAGE_SHIFT;
 	mr->state = RXE_MR_STATE_INVALID;
 }
 
@@ -151,9 +154,6 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 		goto err_release_umem;
 	}
 
-	mr->page_shift = PAGE_SHIFT;
-	mr->page_mask = PAGE_SIZE - 1;
-
 	num_buf			= 0;
 	map = mr->map;
 	if (length > 0) {
@@ -182,7 +182,7 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 				goto err_release_umem;
 			}
 			buf->addr = (uintptr_t)vaddr;
-			buf->size = PAGE_SIZE;
+			buf->size = mr_page_size(mr);
 			num_buf++;
 			buf++;
 
@@ -191,10 +191,9 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 
 	mr->umem = umem;
 	mr->access = access;
-	mr->offset = ib_umem_offset(umem);
+	mr->page_offset = ib_umem_offset(umem);
 	mr->state = RXE_MR_STATE_VALID;
 	mr->ibmr.type = IB_MR_TYPE_USER;
-	mr->ibmr.page_size = PAGE_SIZE;
 
 	return 0;
 
@@ -248,29 +247,27 @@ int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
 		  int sg_nents, unsigned int *sg_offset)
 {
 	struct rxe_mr *mr = to_rmr(ibmr);
-	int n;
-
-	mr->nbuf = 0;
+	unsigned int page_size = mr_page_size(mr);
 
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
@@ -329,7 +326,7 @@ int rxe_flush_pmem_iova(struct rxe_mr *mr, u64 iova, int length)
 	if (mr->ibmr.type == IB_MR_TYPE_DMA)
 		return -EFAULT;
 
-	offset = (iova - mr->ibmr.iova + mr->offset) & mr->page_mask;
+	offset = (iova - mr->ibmr.iova + mr->page_offset) & mr->page_mask;
 	while (length > 0) {
 		u8 *va;
 		int bytes;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 691200d99d6b..5c3d1500ca68 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -315,11 +315,11 @@ struct rxe_mr {
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
 
@@ -334,6 +334,11 @@ struct rxe_mr {
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

