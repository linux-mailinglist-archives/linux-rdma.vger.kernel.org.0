Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9705D5766B4
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Jul 2022 20:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiGOS0L (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 15 Jul 2022 14:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiGOS0K (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 15 Jul 2022 14:26:10 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6D368DDB
        for <linux-rdma@vger.kernel.org>; Fri, 15 Jul 2022 11:26:09 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-10bd4812c29so7781147fac.11
        for <linux-rdma@vger.kernel.org>; Fri, 15 Jul 2022 11:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y0bIuNygwuyoxBWaM1o+c48npkZVEOagrZeteTWunbg=;
        b=I6exsmGYQP+VrhhCNnzqABIySc9btPtiVsYCTt5TwjXhigqoltHtld08guvDL+8vyS
         LKz4T5rjzMSyMucv9ny254ByoBsTpVrokJxX7YKmY0rrTFn7GUEgoboaG+2gOwHuuCH1
         KO4b8in6eCB/Uf7mJeWPW3ga1r7VMJkgXv7odC5kkjDcgb9acMYfq5MHRbODpv0m+GFe
         4YPkFokI91zcQVmrYXILifQ6Ob7yLETnGH0jl0Q85C7DgAXCe9hN+U7ILlnc+KI0wLRH
         YnqW8dQqUcBRNNBbKUK1hjahcNMAHMhFOdMNmg7OdNqur0Mjjc1FzJsNeG6IREP9l4ZR
         UkzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y0bIuNygwuyoxBWaM1o+c48npkZVEOagrZeteTWunbg=;
        b=PldSnNQRd0cXwtRIFXilECt2RkNnH23WNibNrMhFaTt09lCBZCgiTeGjM37Y3/r+tz
         F+TqDD0gS6JOhoZ0ydlaosRCkTufQtzHaaYLqtwXQ2Jl9g6lUtuem/Q11c1DoEQYPk8V
         LBcrC6IICXkTr+6NLBFrjlMQe9Vamb9bIxS/QwPXnLcPteGQSGUqEX2SjPW6wzUNA2ie
         abMC+idzXr4x1YVTZ8ZgicjxT4INZ76RSpD808vVdQRXhZWog+ELl9oXl8ZBZbVL6VMb
         NLfkGoR+O6KbfnZB04TNAJS2ZhonugHUVFOFv31baasusgqLs2Bvxyr0sdVWIu9KSfOQ
         Wv8w==
X-Gm-Message-State: AJIora9F9Z33DLK0wB8UBhtMx+WcTZww53HmTGUWwz25pbWXPiCDbEX+
        tVqyl3vSg2HJ4ZCMhoVicS4=
X-Google-Smtp-Source: AGRyM1stgnMasC+LCVR9nkKDBPHPwI9PcS7XVyomRKoz32SnIP6SBb24rpBeVUIXBGHqzXjsV84Usg==
X-Received: by 2002:a05:6870:1496:b0:10c:145f:e4d3 with SMTP id k22-20020a056870149600b0010c145fe4d3mr7983651oab.230.1657909568815;
        Fri, 15 Jul 2022 11:26:08 -0700 (PDT)
Received: from u-22.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id m22-20020a9d6ad6000000b0061c1a0b4677sm2197028otq.12.2022.07.15.11.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 11:26:08 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     lizhijian@fujitsu.com, jgg@nvidia.com, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next] RDMA/rxe: Fix error paths in MR alloc routines
Date:   Fri, 15 Jul 2022 13:24:15 -0500
Message-Id: <20220715182414.21320-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Currently the rxe driver has incorrect code in error paths for
allocating MR objects. The PD and umem are always freed in
rxe_mr_cleanup() but in some error paths they are already
freed or never set. This patch makes sure that the PD is always
set and checks to see if umem is set before freeing it in
rxe_mr_cleanup().

Reported-by: Li Zhijian <lizhijian@fujitsu.com>
Link: https://lore.kernel.org/linux-rdma/11dafa5f-c52d-16c1-fe37-2cd45ab20474@fujitsu.com/
Fixes: 3902b429ca14 ("Implement invalidate MW operations")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h   |  6 ++--
 drivers/infiniband/sw/rxe/rxe_mr.c    | 36 +++++++-------------
 drivers/infiniband/sw/rxe/rxe_verbs.c | 47 +++++++++++----------------
 3 files changed, 34 insertions(+), 55 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 0e022ae1b8a5..8969918275f9 100644
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
index 9a5c2af6a56f..674af4c36c49 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -151,17 +151,16 @@ static int rxe_mr_alloc(struct rxe_mr *mr, int num_buf, int both)
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
 	struct rxe_map_set	*set;
@@ -173,12 +172,11 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 	void			*vaddr;
 	int err;
 
-	umem = ib_umem_get(pd->ibpd.device, start, length, access);
+	mr->umem = umem = ib_umem_get(&rxe->ib_dev, start, length, access);
 	if (IS_ERR(umem)) {
 		pr_warn("%s: Unable to pin memory region err = %d\n",
 			__func__, (int)PTR_ERR(umem));
-		err = PTR_ERR(umem);
-		goto err_out;
+		return PTR_ERR(umem);
 	}
 
 	num_buf = ib_umem_num_pages(umem);
@@ -189,7 +187,7 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 	if (err) {
 		pr_warn("%s: Unable to allocate memory for map\n",
 				__func__);
-		goto err_release_umem;
+		return err;
 	}
 
 	set = mr->cur_map_set;
@@ -213,8 +211,7 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 			if (!vaddr) {
 				pr_warn("%s: Unable to get virtual address\n",
 						__func__);
-				err = -ENOMEM;
-				goto err_release_umem;
+				return -ENOMEM;
 			}
 
 			buf->addr = (uintptr_t)vaddr;
@@ -224,8 +221,6 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 		}
 	}
 
-	mr->ibmr.pd = &pd->ibpd;
-	mr->umem = umem;
 	mr->access = access;
 	mr->state = RXE_MR_STATE_VALID;
 	mr->type = IB_MR_TYPE_USER;
@@ -236,14 +231,9 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 	set->offset = ib_umem_offset(umem);
 
 	return 0;
-
-err_release_umem:
-	ib_umem_release(umem);
-err_out:
-	return err;
 }
 
-int rxe_mr_init_fast(struct rxe_pd *pd, int max_pages, struct rxe_mr *mr)
+int rxe_mr_init_fast(int max_pages, struct rxe_mr *mr)
 {
 	int err;
 
@@ -252,17 +242,13 @@ int rxe_mr_init_fast(struct rxe_pd *pd, int max_pages, struct rxe_mr *mr)
 
 	err = rxe_mr_alloc(mr, max_pages, 1);
 	if (err)
-		goto err1;
+		return err;
 
-	mr->ibmr.pd = &pd->ibpd;
 	mr->max_buf = max_pages;
 	mr->state = RXE_MR_STATE_FREE;
 	mr->type = IB_MR_TYPE_MEM_REG;
 
 	return 0;
-
-err1:
-	return err;
 }
 
 static void lookup_iova(struct rxe_mr *mr, u64 iova, int *m_out, int *n_out,
@@ -695,10 +681,12 @@ int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 void rxe_mr_cleanup(struct rxe_pool_elem *elem)
 {
 	struct rxe_mr *mr = container_of(elem, typeof(*mr), elem);
+	struct rxe_pd *pd = mr_pd(mr);
 
-	rxe_put(mr_pd(mr));
+	rxe_put(pd);
 
-	ib_umem_release(mr->umem);
+	if (mr->umem)
+		ib_umem_release(mr->umem);
 
 	if (mr->cur_map_set)
 		rxe_mr_free_map_set(mr->num_map, mr->cur_map_set);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 151c6280abd5..173172a83c74 100644
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
@@ -921,27 +923,21 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 	struct rxe_mr *mr;
 
 	mr = rxe_alloc(&rxe->mr_pool);
-	if (!mr) {
-		err = -ENOMEM;
-		goto err2;
-	}
-
+	if (!mr)
+		return ERR_PTR(-ENOMEM);
 
 	rxe_get(pd);
+	mr->ibmr.pd = ibpd;
 
-	err = rxe_mr_init_user(pd, start, length, iova, access, mr);
-	if (err)
-		goto err3;
+	err = rxe_mr_init_user(rxe, start, length, iova, access, mr);
+	if (err) {
+		rxe_cleanup(mr);
+		return ERR_PTR(err);
+	}
 
 	rxe_finalize(mr);
 
 	return &mr->ibmr;
-
-err3:
-	rxe_put(pd);
-	rxe_cleanup(mr);
-err2:
-	return ERR_PTR(err);
 }
 
 static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
@@ -956,26 +952,21 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 		return ERR_PTR(-EINVAL);
 
 	mr = rxe_alloc(&rxe->mr_pool);
-	if (!mr) {
-		err = -ENOMEM;
-		goto err1;
-	}
+	if (!mr)
+		return ERR_PTR(-ENOMEM);
 
 	rxe_get(pd);
+	mr->ibmr.pd = ibpd;
 
-	err = rxe_mr_init_fast(pd, max_num_sg, mr);
-	if (err)
-		goto err2;
+	err = rxe_mr_init_fast(max_num_sg, mr);
+	if (err) {
+		rxe_cleanup(mr);
+		return ERR_PTR(err);
+	}
 
 	rxe_finalize(mr);
 
 	return &mr->ibmr;
-
-err2:
-	rxe_put(pd);
-	rxe_cleanup(mr);
-err1:
-	return ERR_PTR(err);
 }
 
 /* build next_map_set from scatterlist

base-commit: 2635d2a8d4664b665bc12e15eee88e9b1b40ae7b
-- 
2.34.1

