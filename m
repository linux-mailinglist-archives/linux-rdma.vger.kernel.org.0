Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299D858971B
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Aug 2022 06:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiHDEie (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Aug 2022 00:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiHDEic (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Aug 2022 00:38:32 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609AF63E3
        for <linux-rdma@vger.kernel.org>; Wed,  3 Aug 2022 21:38:31 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id g20-20020a9d6a14000000b0061c84e679f5so13501891otn.2
        for <linux-rdma@vger.kernel.org>; Wed, 03 Aug 2022 21:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=PiU5Y3vlArI9Syqr/qJv3y0P+7/25/q2jQw8I0zUuKo=;
        b=GiFlTNNa4DX028rYeT+6FS7zStA76Up/zjVqIKNpWT7Mv3fVu6G4h8waR7FU2TxjFm
         vrOZWQd2khrbtMKOqTGkalEXiIK8ji4z9RP1a8b0RvzD7c9fDpxauyGfv0n3kNgPAMJf
         2ekNohkCDbfkfCqeD9lAIrPvK3JPTP5UNBUyQ3v2dNC+Xmx3ZG8APJcWc6WjfqnyfU09
         JgQx4U4qDzR1ZJJUBPWzq+Q/lsTzLWIx8NXfsWdGi+/YnnlLG1Pp/HaI7aCbyOY4kDpJ
         7FJjWaOX/XPVsK+d6jmzXhjaysZk4FmrnC7fzWh1fbvIgCibwT7cz2ZNCS/47Iq+hLyr
         6JGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=PiU5Y3vlArI9Syqr/qJv3y0P+7/25/q2jQw8I0zUuKo=;
        b=MelYM2Q5WV1DqZkQfKzmidLfa/hOLNVZ/uJTeq+OA1E5+xtlzl43GvTXl5EKv+a/tc
         Lr4InMawCv41yaVarRQzFO2Y3oRz03rvAK6ciUIIyV8yzyiIRH3tm8XRA5kp29cVuTLg
         wBPfw6Ws+hEWEeZpRUPE/J1Sbj/LxFF1DjQCWzIAG4dtzFoNhmKOBvx3CmWfyHp42OJQ
         pLKBijIxZAN2LHwulIed1AMf0Q3URxw9sAmnuU0PoHdlwZ/Mc9kU/3KvjYUvbO0HAhEG
         z2JOhR49YSBulkZ25NG5DOjamxhuLhMsqv6OUUc+ICllgTgz6uXCiQcHYDD4STZAvFN0
         w9Eg==
X-Gm-Message-State: AJIora/Ov+2aFTQVJZs8oim8HR4SqQjgArgdec3yoHitLSE5TGohl72N
        F9IYOWYZPrtgLyo3ovn0HBQ=
X-Google-Smtp-Source: AGRyM1u4FM4dl9lMGHQ9Ei/gvcdqH+usnRQodWHs83olYx1tOhDfyBz/r4DowdIE7Lhv8z//Ih/Ofg==
X-Received: by 2002:a9d:6956:0:b0:61d:2d64:e57f with SMTP id p22-20020a9d6956000000b0061d2d64e57fmr10484716oto.222.1659587910690;
        Wed, 03 Aug 2022 21:38:30 -0700 (PDT)
Received: from u-22.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id n132-20020aca408a000000b003357568e39fsm7896oia.57.2022.08.03.21.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 21:38:30 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, lizhijian@fujitsu.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH v4 for-next] RDMA/rxe: Fix error paths in MR alloc routines
Date:   Wed,  3 Aug 2022 23:37:32 -0500
Message-Id: <20220804043731.3737-1-rpearsonhpe@gmail.com>
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
rxe_mr_cleanup(). umem and maps are freed if an error occurs
in an allocate mr call.

Reported-by: Li Zhijian <lizhijian@fujitsu.com>
Link: https://lore.kernel.org/linux-rdma/11dafa5f-c52d-16c1-fe37-2cd45ab20474@fujitsu.com/
Fixes: 3902b429ca14 ("Implement invalidate MW operations")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v4:
  added set mr->ibmr.pd back to avoid an -ENOMEM error causing
  rxe_put(mr_pd(mr)); to seg fault in rxe_mr_cleanup() since pd
  is not getting set in the error path.
v3:
  rebased to apply to current for-next after
  	Revert "RDMA/rxe: Create duplicate mapping tables for FMRs"
v2:
  Moved setting mr->umem until after checks to avoid sending
  an ERR_PTR to ib_umem_release().
  Cleaned up umem and map sets if errors occur in alloc mr calls.
  Rebased to current for-next.

 drivers/infiniband/sw/rxe/rxe_loc.h   |  6 +-
 drivers/infiniband/sw/rxe/rxe_mr.c    | 93 +++++++++++----------------
 drivers/infiniband/sw/rxe/rxe_verbs.c | 57 +++++++---------
 3 files changed, 62 insertions(+), 94 deletions(-)

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
index 850b80f5ad8b..3814f8d3c2a9 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -67,20 +67,24 @@ static void rxe_mr_init(int access, struct rxe_mr *mr)
 
 static int rxe_mr_alloc(struct rxe_mr *mr, int num_buf)
 {
-	int i;
-	int num_map;
 	struct rxe_map **map = mr->map;
+	int num_map;
+	int i;
 
 	num_map = (num_buf + RXE_BUF_PER_MAP - 1) / RXE_BUF_PER_MAP;
 
 	mr->map = kmalloc_array(num_map, sizeof(*map), GFP_KERNEL);
 	if (!mr->map)
-		goto err1;
+		return -ENOMEM;
 
 	for (i = 0; i < num_map; i++) {
 		mr->map[i] = kmalloc(sizeof(**map), GFP_KERNEL);
-		if (!mr->map[i])
-			goto err2;
+		if (!mr->map[i]) {
+			for (i--; i >= 0; i--)
+				kfree(mr->map[i]);
+			kfree(mr->map);
+			return -ENOMEM;
+		}
 	}
 
 	BUILD_BUG_ON(!is_power_of_2(RXE_BUF_PER_MAP));
@@ -93,55 +97,40 @@ static int rxe_mr_alloc(struct rxe_mr *mr, int num_buf)
 	mr->max_buf = num_map * RXE_BUF_PER_MAP;
 
 	return 0;
-
-err2:
-	for (i--; i >= 0; i--)
-		kfree(mr->map[i]);
-
-	kfree(mr->map);
-err1:
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
-	struct rxe_map		**map;
-	struct rxe_phys_buf	*buf = NULL;
-	struct ib_umem		*umem;
-	struct sg_page_iter	sg_iter;
-	int			num_buf;
-	void			*vaddr;
+	struct rxe_phys_buf *buf = NULL;
+	struct sg_page_iter sg_iter;
+	struct rxe_map **map;
+	struct ib_umem *umem;
+	int num_buf;
+	void *vaddr;
 	int err;
-	int i;
 
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
 
 	rxe_mr_init(access, mr);
 
-	err = rxe_mr_alloc(mr, num_buf);
+	err = -ENOMEM; //err = rxe_mr_alloc(mr, num_buf);
 	if (err) {
-		pr_warn("%s: Unable to allocate memory for map\n",
-				__func__);
-		goto err_release_umem;
+		ib_umem_release(umem);
+		return err;
 	}
 
 	mr->page_shift = PAGE_SHIFT;
@@ -152,7 +141,7 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 	if (length > 0) {
 		buf = map[0]->buf;
 
-		for_each_sgtable_page (&umem->sgt_append.sgt, &sg_iter, 0) {
+		for_each_sgtable_page(&umem->sgt_append.sgt, &sg_iter, 0) {
 			if (num_buf >= RXE_BUF_PER_MAP) {
 				map++;
 				buf = map[0]->buf;
@@ -161,21 +150,22 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 
 			vaddr = page_address(sg_page_iter_page(&sg_iter));
 			if (!vaddr) {
-				pr_warn("%s: Unable to get virtual address\n",
-						__func__);
-				err = -ENOMEM;
-				goto err_cleanup_map;
+				int i;
+
+				for (i = 0; i < mr->num_map; i++)
+					kfree(mr->map[i]);
+				kfree(mr->map);
+				ib_umem_release(umem);
+				return -ENOMEM;
 			}
 
 			buf->addr = (uintptr_t)vaddr;
 			buf->size = PAGE_SIZE;
 			num_buf++;
 			buf++;
-
 		}
 	}
 
-	mr->ibmr.pd = &pd->ibpd;
 	mr->umem = umem;
 	mr->access = access;
 	mr->length = length;
@@ -186,18 +176,9 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 	mr->type = IB_MR_TYPE_USER;
 
 	return 0;
-
-err_cleanup_map:
-	for (i = 0; i < mr->num_map; i++)
-		kfree(mr->map[i]);
-	kfree(mr->map);
-err_release_umem:
-	ib_umem_release(umem);
-err_out:
-	return err;
 }
 
-int rxe_mr_init_fast(struct rxe_pd *pd, int max_pages, struct rxe_mr *mr)
+int rxe_mr_init_fast(int max_pages, struct rxe_mr *mr)
 {
 	int err;
 
@@ -206,17 +187,13 @@ int rxe_mr_init_fast(struct rxe_pd *pd, int max_pages, struct rxe_mr *mr)
 
 	err = rxe_mr_alloc(mr, max_pages);
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
@@ -630,7 +607,9 @@ void rxe_mr_cleanup(struct rxe_pool_elem *elem)
 	int i;
 
 	rxe_put(mr_pd(mr));
-	ib_umem_release(mr->umem);
+
+	if (mr->umem)
+		ib_umem_release(mr->umem);
 
 	if (mr->map) {
 		for (i = 0; i < mr->num_map; i++)
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index e264cf69bf55..4ab32df13bd6 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -903,45 +903,39 @@ static struct ib_mr *rxe_get_dma_mr(struct ib_pd *ibpd, int access)
 		return ERR_PTR(-ENOMEM);
 
 	rxe_get(pd);
-	rxe_mr_init_dma(pd, access, mr);
+	mr->ibmr.pd = ibpd;
+
+	rxe_mr_init_dma(access, mr);
 	rxe_finalize(mr);
 
 	return &mr->ibmr;
 }
 
-static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
-				     u64 start,
-				     u64 length,
-				     u64 iova,
-				     int access, struct ib_udata *udata)
+static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd, u64 start,
+				     u64 length, u64 iova, int access,
+				     struct ib_udata *udata)
 {
-	int err;
 	struct rxe_dev *rxe = to_rdev(ibpd->device);
 	struct rxe_pd *pd = to_rpd(ibpd);
 	struct rxe_mr *mr;
+	int err;
 
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
@@ -956,26 +950,21 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
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
 
 static int rxe_set_page(struct ib_mr *ibmr, u64 addr)

base-commit: 6b822d408b58c3c4f26dae93245c6b7d8b39e0f9
-- 
2.34.1

