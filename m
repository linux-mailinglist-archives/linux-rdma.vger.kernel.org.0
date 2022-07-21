Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA8457D4BE
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jul 2022 22:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiGUUYR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jul 2022 16:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiGUUYQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jul 2022 16:24:16 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3288737E
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jul 2022 13:24:15 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-10bd4812c29so3923235fac.11
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jul 2022 13:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7r9VOSN68TmsXuksLeavf8hGZzGgtXKATOiUHgIXfD8=;
        b=L6OvovkCfidssk85JYcnIRCecru4L1v2LJZ1WQbz5QfdM7QdEKaxLTEepOniwRuCN+
         uuueMR5uYT4bpTFrsbQA37eJqs+b9JNQhb0IkaelMSDb1mGhPF05Hg0gyKMdDhgFyjcF
         at+BylCblXRraJuYV9xcWNWnA1vLK/uofokTiqMtVRZXkribCwb/UX7F2nRQYt14XTXe
         HjE8XaAkf/U2E/llvQBI/VDObPL/7J78sxDw1fu3mQIt/l53dkwjtIs0tmtfpNl/LzKY
         7zrU06A90kTTBRWwgZDzcArNwj4Qficy39xunC7877/wYTiVQj8WN2gIKXis9JMHtVKm
         t97g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7r9VOSN68TmsXuksLeavf8hGZzGgtXKATOiUHgIXfD8=;
        b=I8CmBubZ7NRtRHIG84+jRwDhl6HgBbRu7LnBWUJRXRKMTNTH+0+3/a2VGgRLyH6Yzr
         hBoUJPu5HI08lhr3ZXSf7t3VgAbcpSjAdmCpVPRKwvnyikCEC6c0kGbqe4Ecb8rUtD71
         But/JVUVOyCIhn0D9FwcDMTKjJKODEwaLWqFUqjWXKTJFFLG/s6HXixjJ5cvlKEppaOH
         eX+bLPRSLQjQtRISulnjVswIvojZi1jjef2dHKmn8RYfDy4E9GDN+qxzzJaCKiqDDNIp
         7AuyKddhCvIx4GtSYovi0zJXE/hOeiJ9r5437UR1UQE1k0X0Sa4uRx9ql/sAMFQSci5H
         GjeQ==
X-Gm-Message-State: AJIora/hFEBzoJc+yvWkNoW9dun/3J8/z3nsYsQZO+iNd6QB2oQ2K2F4
        9+PpCf6NRhs/0fxJzGcH4qM=
X-Google-Smtp-Source: AGRyM1tVgnWgGBnjflexg0WvskRAVuWKGMIyml5y5MyDvKOKEPt+K8npNO7Ox2uBiqCGJ8JeCTXx/w==
X-Received: by 2002:a05:6870:818f:b0:10d:8870:6906 with SMTP id k15-20020a056870818f00b0010d88706906mr4635623oae.35.1658435054987;
        Thu, 21 Jul 2022 13:24:14 -0700 (PDT)
Received: from u-22.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id u21-20020a056870421500b001019fb71e4bsm1381858oac.17.2022.07.21.13.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 13:24:14 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        lizhijian@fujitsu.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2] RDMA/rxe: Fix error paths in MR alloc routines
Date:   Thu, 21 Jul 2022 15:22:14 -0500
Message-Id: <20220721202213.55061-1-rpearsonhpe@gmail.com>
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
rxe_mr_cleanup(). umem and map sets are freed if an error
occurs in an allocate mr call.

Reported-by: Li Zhijian <lizhijian@fujitsu.com>
Link: https://lore.kernel.org/linux-rdma/11dafa5f-c52d-16c1-fe37-2cd45ab20474@fujitsu.com/
Fixes: 3902b429ca14 ("Implement invalidate MW operations")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v2:
  Moved setting mr->umem until after checks to avoid sending
  an ERR_PTR to ib_umem_release().
  Cleaned up umem and map sets if errors occur in alloc mr calls.
  Rebased to current for-next.

 drivers/infiniband/sw/rxe/rxe_loc.h   |  6 +--
 drivers/infiniband/sw/rxe/rxe_mr.c    | 65 +++++++++++----------------
 drivers/infiniband/sw/rxe/rxe_verbs.c | 43 +++++++-----------
 3 files changed, 43 insertions(+), 71 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 336164843db4..575bb1b57bfa 100644
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
index 9a5c2af6a56f..d19580596996 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -139,29 +139,26 @@ static int rxe_mr_alloc(struct rxe_mr *mr, int num_buf, int both)
 
 	if (both) {
 		ret = rxe_mr_alloc_map_set(num_map, &mr->next_map_set);
-		if (ret)
-			goto err_free;
+		if (ret) {
+			rxe_mr_free_map_set(mr->num_map, mr->cur_map_set);
+			mr->cur_map_set = NULL;
+			return -ENOMEM;
+		}
 	}
 
 	return 0;
-
-err_free:
-	rxe_mr_free_map_set(mr->num_map, mr->cur_map_set);
-	mr->cur_map_set = NULL;
-	return -ENOMEM;
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
@@ -173,13 +170,9 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 	void			*vaddr;
 	int err;
 
-	umem = ib_umem_get(pd->ibpd.device, start, length, access);
-	if (IS_ERR(umem)) {
-		pr_warn("%s: Unable to pin memory region err = %d\n",
-			__func__, (int)PTR_ERR(umem));
-		err = PTR_ERR(umem);
-		goto err_out;
-	}
+	umem = ib_umem_get(&rxe->ib_dev, start, length, access);
+	if (IS_ERR(umem))
+		return PTR_ERR(umem);
 
 	num_buf = ib_umem_num_pages(umem);
 
@@ -187,9 +180,8 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 
 	err = rxe_mr_alloc(mr, num_buf, 0);
 	if (err) {
-		pr_warn("%s: Unable to allocate memory for map\n",
-				__func__);
-		goto err_release_umem;
+		ib_umem_release(umem);
+		return err;
 	}
 
 	set = mr->cur_map_set;
@@ -202,7 +194,7 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 	if (length > 0) {
 		buf = map[0]->buf;
 
-		for_each_sgtable_page (&umem->sgt_append.sgt, &sg_iter, 0) {
+		for_each_sgtable_page(&umem->sgt_append.sgt, &sg_iter, 0) {
 			if (num_buf >= RXE_BUF_PER_MAP) {
 				map++;
 				buf = map[0]->buf;
@@ -211,10 +203,11 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 
 			vaddr = page_address(sg_page_iter_page(&sg_iter));
 			if (!vaddr) {
-				pr_warn("%s: Unable to get virtual address\n",
-						__func__);
-				err = -ENOMEM;
-				goto err_release_umem;
+				rxe_mr_free_map_set(mr->num_map,
+						    mr->cur_map_set);
+				mr->cur_map_set = NULL;
+				ib_umem_release(umem);
+				return -ENOMEM;
 			}
 
 			buf->addr = (uintptr_t)vaddr;
@@ -224,11 +217,10 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 		}
 	}
 
-	mr->ibmr.pd = &pd->ibpd;
-	mr->umem = umem;
 	mr->access = access;
 	mr->state = RXE_MR_STATE_VALID;
 	mr->type = IB_MR_TYPE_USER;
+	mr->umem = umem;
 
 	set->length = length;
 	set->iova = iova;
@@ -236,14 +228,9 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
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
 
@@ -252,17 +239,13 @@ int rxe_mr_init_fast(struct rxe_pd *pd, int max_pages, struct rxe_mr *mr)
 
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
@@ -695,10 +678,12 @@ int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
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
index 151c6280abd5..831753dcde56 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -903,7 +903,7 @@ static struct ib_mr *rxe_get_dma_mr(struct ib_pd *ibpd, int access)
 		return ERR_PTR(-ENOMEM);
 
 	rxe_get(pd);
-	rxe_mr_init_dma(pd, access, mr);
+	rxe_mr_init_dma(access, mr);
 	rxe_finalize(mr);
 
 	return &mr->ibmr;
@@ -921,27 +921,20 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
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
@@ -956,26 +949,20 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 		return ERR_PTR(-EINVAL);
 
 	mr = rxe_alloc(&rxe->mr_pool);
-	if (!mr) {
-		err = -ENOMEM;
-		goto err1;
-	}
+	if (!mr)
+		return ERR_PTR(-ENOMEM);
 
 	rxe_get(pd);
 
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

base-commit: 0c6ab0ca9a662d4ca9742d97156bac0d3067d72d
-- 
2.34.1

