Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E5B58AFD0
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Aug 2022 20:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236261AbiHESfs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Aug 2022 14:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237475AbiHESfq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Aug 2022 14:35:46 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517F55F9C
        for <linux-rdma@vger.kernel.org>; Fri,  5 Aug 2022 11:35:45 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id m22-20020a0568301e7600b006369227f745so2430756otr.7
        for <linux-rdma@vger.kernel.org>; Fri, 05 Aug 2022 11:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=CTmq931d+MyqFalIoXxThJaowqlQOJTiDna1XFqizvE=;
        b=EnyZ/X2Rjg1FZrk6xq9XnW9tqqssIx/cNxpCHoIklsQjDFvTqBlLYxjHCY18IcA071
         moblzpFvulCLMjjVGxrCLzHcaoPOWjYJfRrDnxHGw1AJrhIu15FC456KX1TElbzVTu33
         WuYDjLX4pQ5OmuRUJZvqvzVg2flGkEEH0aCiUtO3x9btljCMYpH/oib2nwaVMhQWH9Qk
         WH5Few9Q2OTFb3YYO1yuhWPjgb6pbmo6NJNmMKqD5Q+O5jhAh5dW9AJD2HnBH/7Wd/7i
         XcWsAa1beP9ThempAb/5EwLKZoKqeAtbxJMVrXT7fvyJEMArvZSL1P+i/JqsIicXq1MB
         rUKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=CTmq931d+MyqFalIoXxThJaowqlQOJTiDna1XFqizvE=;
        b=Y/xCBeO+BTh8g7exkC3H5F4BT2PT+ZoFZDNbR2HdSv0nf4KuQSpspPe6KDSOh0gIFP
         blTdXHRwAsyD8nHBWm0evJTrJIsgSyI2lQtYQSxUiI0NgfsIDQRtVy9vDtYKX4qTT6KN
         Ye2sgTtLKhEI9d5rdFTOz1lT39cW6mOJBrkPngOv3YFibUB5pnwaoQ0PgMUKhdzj2sqJ
         iprZRFQxJJ9blupmQtaEP4MUEUiCH50evsGdN+NQxdpWc0Mx04dL+QTwiaOh9vRpmtWh
         cieFEv/JVp8a12v3uhhCuU6JQsxT33l8MzJlewpTVgkTfZ/mDFA3apPiUPS4C/J6rhLs
         nC2A==
X-Gm-Message-State: ACgBeo1ozyZxJgtby7YLKpK1+/EsxZwqthyLbgTuwzYKPh4gattFxR+m
        dhVsKLFWg+XJIf3TZk/AzxI=
X-Google-Smtp-Source: AA6agR4+Ig2B0cMZNGX4TlPOGXZIE71ihNdSepbF+9MOVe7YxN2BexgJkjxCUss4y8b1bgMH+t6/Uw==
X-Received: by 2002:a05:6830:1d76:b0:636:9ff0:c87 with SMTP id l22-20020a0568301d7600b006369ff00c87mr3059301oti.133.1659724544715;
        Fri, 05 Aug 2022 11:35:44 -0700 (PDT)
Received: from u-22.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id 98-20020a9d036b000000b00636a2a150f7sm802838otv.15.2022.08.05.11.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 11:35:44 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, lizhijian@fujitsu.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH v5 for-next 1/2] RDMA/rxe: Set pd early in mr alloc routines
Date:   Fri,  5 Aug 2022 13:35:24 -0500
Message-Id: <20220805183523.32044-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Move setting of pd in mr objects ahead of any possible errors
so that it will always be set in rxe_mr_complete() to avoid
seg faults when rxe_put(mr_pd(mr)) is called.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h   |  6 +++---
 drivers/infiniband/sw/rxe/rxe_mr.c    | 11 ++++-------
 drivers/infiniband/sw/rxe/rxe_verbs.c | 10 +++++++---
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 22f6cc31d1d6..c2a5c8814a48 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -64,10 +64,10 @@ int rxe_mmap(struct ib_ucontext *context, struct vm_area_struct *vma);
 
 /* rxe_mr.c */
 u8 rxe_get_next_key(u32 last_key);
-void rxe_mr_init_dma(struct rxe_pd *pd, int access, struct rxe_mr *mr);
-int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
+void rxe_mr_init_dma(int access, struct rxe_mr *mr);
+int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 		     int access, struct rxe_mr *mr);
-int rxe_mr_init_fast(struct rxe_pd *pd, int max_pages, struct rxe_mr *mr);
+int rxe_mr_init_fast(int max_pages, struct rxe_mr *mr);
 int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 		enum rxe_mr_copy_dir dir);
 int copy_data(struct rxe_pd *pd, int access, struct rxe_dma_info *dma,
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 850b80f5ad8b..af34f198e645 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -103,17 +103,16 @@ static int rxe_mr_alloc(struct rxe_mr *mr, int num_buf)
 	return -ENOMEM;
 }
 
-void rxe_mr_init_dma(struct rxe_pd *pd, int access, struct rxe_mr *mr)
+void rxe_mr_init_dma(int access, struct rxe_mr *mr)
 {
 	rxe_mr_init(access, mr);
 
-	mr->ibmr.pd = &pd->ibpd;
 	mr->access = access;
 	mr->state = RXE_MR_STATE_VALID;
 	mr->type = IB_MR_TYPE_DMA;
 }
 
-int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
+int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 		     int access, struct rxe_mr *mr)
 {
 	struct rxe_map		**map;
@@ -125,7 +124,7 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 	int err;
 	int i;
 
-	umem = ib_umem_get(pd->ibpd.device, start, length, access);
+	umem = ib_umem_get(&rxe->ib_dev, start, length, access);
 	if (IS_ERR(umem)) {
 		pr_warn("%s: Unable to pin memory region err = %d\n",
 			__func__, (int)PTR_ERR(umem));
@@ -175,7 +174,6 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 		}
 	}
 
-	mr->ibmr.pd = &pd->ibpd;
 	mr->umem = umem;
 	mr->access = access;
 	mr->length = length;
@@ -197,7 +195,7 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 	return err;
 }
 
-int rxe_mr_init_fast(struct rxe_pd *pd, int max_pages, struct rxe_mr *mr)
+int rxe_mr_init_fast(int max_pages, struct rxe_mr *mr)
 {
 	int err;
 
@@ -208,7 +206,6 @@ int rxe_mr_init_fast(struct rxe_pd *pd, int max_pages, struct rxe_mr *mr)
 	if (err)
 		goto err1;
 
-	mr->ibmr.pd = &pd->ibpd;
 	mr->max_buf = max_pages;
 	mr->state = RXE_MR_STATE_FREE;
 	mr->type = IB_MR_TYPE_MEM_REG;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index e264cf69bf55..6c13be14d723 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -903,7 +903,9 @@ static struct ib_mr *rxe_get_dma_mr(struct ib_pd *ibpd, int access)
 		return ERR_PTR(-ENOMEM);
 
 	rxe_get(pd);
-	rxe_mr_init_dma(pd, access, mr);
+	mr->ibmr.pd = ibpd;
+
+	rxe_mr_init_dma(access, mr);
 	rxe_finalize(mr);
 
 	return &mr->ibmr;
@@ -928,8 +930,9 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 
 
 	rxe_get(pd);
+	mr->ibmr.pd = ibpd;
 
-	err = rxe_mr_init_user(pd, start, length, iova, access, mr);
+	err = rxe_mr_init_user(rxe, start, length, iova, access, mr);
 	if (err)
 		goto err3;
 
@@ -962,8 +965,9 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 	}
 
 	rxe_get(pd);
+	mr->ibmr.pd = ibpd;
 
-	err = rxe_mr_init_fast(pd, max_num_sg, mr);
+	err = rxe_mr_init_fast(max_num_sg, mr);
 	if (err)
 		goto err2;
 
-- 
2.34.1

