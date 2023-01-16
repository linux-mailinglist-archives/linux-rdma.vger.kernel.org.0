Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEF766D212
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Jan 2023 23:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235046AbjAPWxz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Jan 2023 17:53:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235211AbjAPWxb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Jan 2023 17:53:31 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83432687B
        for <linux-rdma@vger.kernel.org>; Mon, 16 Jan 2023 14:53:18 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id o66so24552234oia.6
        for <linux-rdma@vger.kernel.org>; Mon, 16 Jan 2023 14:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+tMrbES7iAPFERVwmrpXMmq8ACmpuWPOnqo2LwvtS/M=;
        b=SBC5QRpltLHvE77of/qNokBeZ/fqInXFvxvf9WfDPZgMXDl1II+T60Dey3lj0GH9zK
         qk5P7PQP7q07H4rEZBkCaa06mT6pT74IO0+yq5z0WG54Cryy14ArazEFdbRu23O/uYrf
         NDSqxUWI5KyQkpNJu5XN5gEVSZIicvNtXvi/gYbsWzkjyAzw2k8gfJ8rTRZsA4gqESbE
         X+DbnMjr1p4Rq4lCecc+cKZSEGv/x2r1NfKRTTjT5scCD79MYTAWYsllJF7Sbu9bRhC2
         LugCXRUtAP2gPJ8vQoSNX1MFWmhzji5c60XvUdwYD3yr6HecAc08fdf9ykg/6sgWa5MK
         V0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+tMrbES7iAPFERVwmrpXMmq8ACmpuWPOnqo2LwvtS/M=;
        b=jfvRtDh40EemaiUp1L6dsKaykC5PtUcdw1nCix6mFouXUriyr+mJ/EB4zNZ9/A7AM0
         2Rz6mSOu+Q43ybTL1evBcb1EqGHCO39+cx1Q7ijxRQ21JoLx3ytBPt3/oI6orvyvl9L8
         xvtaugNQHqF4p5Mwyz1qoDlcew/ApkSvFrej1mvx9lFvskbvBHw+ad50yzMPgmW4kz4E
         6oBvNb68IVDCcaumfPrB4yVdO3I+ZGbCJ4TSFNmywhyppcYrt2dEqhZOAXvcV6aB8Lbn
         JaJODrjExaykRcDrL77h+tNoDv9AtH5Uc5yedv/51crlz4Xzpljpz2EN4DthSHpfnBik
         bbNg==
X-Gm-Message-State: AFqh2kr6SwEecCuyU3aNdEE3M9D/cE2fdp++lajL/wHU5x8n0tq0XGTW
        cqCSH/t4HUuTyeF+CETsfCw=
X-Google-Smtp-Source: AMrXdXvRaBXYVnvD/HiWG8Z0S2bumH7i3jL2zKBKFLlzeablxZC+RSc5RHvHlGw5HvgWeL1shvasFg==
X-Received: by 2002:a05:6808:1a1d:b0:35e:646b:2cd6 with SMTP id bk29-20020a0568081a1d00b0035e646b2cd6mr490169oib.59.1673909598213;
        Mon, 16 Jan 2023 14:53:18 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-ea18-3ee9-26d1-7526.res6.spectrum.com. [2603:8081:140c:1a00:ea18:3ee9:26d1:7526])
        by smtp.gmail.com with ESMTPSA id s4-20020a056808008400b0035028730c90sm13651937oic.1.2023.01.16.14.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 14:53:17 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, leonro@nvidia.com,
        yangx.jy@fujitsu.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v4 5/6] RDMA/rxe: Cleanup page variables in rxe_mr.c
Date:   Mon, 16 Jan 2023 16:52:28 -0600
Message-Id: <20230116225227.21163-6-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230116225227.21163-1-rpearsonhpe@gmail.com>
References: <20230116225227.21163-1-rpearsonhpe@gmail.com>
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

