Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340D766885B
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Jan 2023 01:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbjAMAWd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Jan 2023 19:22:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240248AbjAMAWD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Jan 2023 19:22:03 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474E95E0AA
        for <linux-rdma@vger.kernel.org>; Thu, 12 Jan 2023 16:22:02 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id d127so16574449oif.12
        for <linux-rdma@vger.kernel.org>; Thu, 12 Jan 2023 16:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Skd7HNc9y0RSKtnaGBsVgtGJYkRVee4MlHML5372Liw=;
        b=EJVWG0/1mH7d9y0VG7CYmmyXIG8zPZ7sCSEqswgLX62ZCMGCrXze7dNXspu7LeD1VM
         qZs5KFIGBXwBGUqvqI0nG5JOCNsXegj8IU4hD3P8GM0i04IPdF4YPU0UZQdNKeQVYPGP
         HDOrwm+jhVGNfQyML7jdOWu9Dl/w11X5yGecOgT+7yV49RRGNz6R2+t/3+HZofqsJlHx
         kswCvY0YJuhHQ/aUPp8pN00Yz6xevqvv89/8h4Tc1fajkplQpwUkNkd17Nj+RI+2LJ9n
         yI8IqZKQU1zLuJk0xqfjDrLkaiLPKUueTV6u+iuPeDGuLzJ2Zx9u1Ww2h9ZaYRYD5T9M
         dZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Skd7HNc9y0RSKtnaGBsVgtGJYkRVee4MlHML5372Liw=;
        b=GCD91E7ZVuDAkovAITUirnwYrp5H06g6vOVbL1R0XnCRuuU/I8Gc4rRXCEZayNNKOj
         XY5UY3lIoSgoR6FrfKkyEUggiEVNfR91EIdUh74SKzAzFuGqDDbmgDlZujMU59HJfpfu
         2dzNJCga/dXAnGh3B4PUTGokFIjBfnIO28k8HmNxXq0aHywKh9eTPSqFL79d86euBkOM
         yP0OnX8r4DQfAMDz/ARGTz0Jk4x024qNVU7KRFr1BFAJyYlObhBSb4zf6Bj5WN6deWtB
         8ivKtOLFTr+wCsWNRd0HlFC7NeoF/vUBMeD4pbxtmbUlQrZ3M/n010onYSmrOGwuoESS
         GpqA==
X-Gm-Message-State: AFqh2kqS+V8Jx9SjIofl0C35/XPyLmERPibL7OBWXp4dbLuMxPaT2i6u
        EDm2gcB9baEnO8BE8EMcsJs=
X-Google-Smtp-Source: AMrXdXv5bHrcVb2XhVZH92sKs2Gxn1Ph5niKpr7Tf8azMxx/MbFOGW7HIwnkNsUtfW8Zn0ScgOo0xw==
X-Received: by 2002:a05:6808:3092:b0:35e:d78a:706 with SMTP id bl18-20020a056808309200b0035ed78a0706mr4676001oib.23.1673569321666;
        Thu, 12 Jan 2023 16:22:01 -0800 (PST)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-550f-93bd-b210-47c2.res6.spectrum.com. [2603:8081:140c:1a00:550f:93bd:b210:47c2])
        by smtp.googlemail.com with ESMTPSA id z25-20020a056808049900b0035a9003b8edsm8480471oid.40.2023.01.12.16.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 16:22:01 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leonro@nvidia.com, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 5/6] RDMA/rxe: Cleanup page variables in rxe_mr.c
Date:   Thu, 12 Jan 2023 18:21:15 -0600
Message-Id: <20230113002116.457324-6-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230113002116.457324-1-rpearsonhpe@gmail.com>
References: <20230113002116.457324-1-rpearsonhpe@gmail.com>
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
index d11b38117e58..369062ffaba6 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -60,6 +60,9 @@ static void rxe_mr_init(int access, struct rxe_mr *mr)
 	mr->lkey = mr->ibmr.lkey = lkey;
 	mr->rkey = mr->ibmr.rkey = rkey;
 
+	mr->ibmr.page_size = PAGE_SIZE;
+	mr->page_mask = PAGE_MASK;
+	mr->page_shift = PAGE_SHIFT;
 	mr->state = RXE_MR_STATE_INVALID;
 }
 
@@ -149,9 +152,6 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 		goto err_release_umem;
 	}
 
-	mr->page_shift = PAGE_SHIFT;
-	mr->page_mask = PAGE_SIZE - 1;
-
 	num_buf			= 0;
 	map = mr->map;
 	if (length > 0) {
@@ -180,7 +180,7 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 				goto err_release_umem;
 			}
 			buf->addr = (uintptr_t)vaddr;
-			buf->size = PAGE_SIZE;
+			buf->size = mr_page_size(mr);
 			num_buf++;
 			buf++;
 
@@ -189,10 +189,9 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 
 	mr->umem = umem;
 	mr->access = access;
-	mr->offset = ib_umem_offset(umem);
+	mr->page_offset = ib_umem_offset(umem);
 	mr->state = RXE_MR_STATE_VALID;
 	mr->ibmr.type = IB_MR_TYPE_USER;
-	mr->ibmr.page_size = PAGE_SIZE;
 
 	return 0;
 
@@ -246,29 +245,27 @@ int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
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
@@ -342,7 +339,7 @@ int rxe_flush_pmem_iova(struct rxe_mr *mr, u64 iova, int length)
 	if (mr->ibmr.type == IB_MR_TYPE_DMA)
 		return -EFAULT;
 
-	offset = (iova - mr->ibmr.iova + mr->offset) & mr->page_mask;
+	offset = (iova - mr->ibmr.iova + mr->page_offset) & mr->page_mask;
 	while (length > 0) {
 		u8 *va;
 		int bytes;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 19ddfa890480..bfc94caaeec5 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -310,11 +310,11 @@ struct rxe_mr {
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
 
@@ -329,6 +329,11 @@ struct rxe_mr {
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

