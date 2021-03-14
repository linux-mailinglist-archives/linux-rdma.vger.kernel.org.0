Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23B633A888
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Mar 2021 23:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbhCNWan (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 14 Mar 2021 18:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhCNWaL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 14 Mar 2021 18:30:11 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73D1C061574
        for <linux-rdma@vger.kernel.org>; Sun, 14 Mar 2021 15:30:10 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id j8so6215642otc.0
        for <linux-rdma@vger.kernel.org>; Sun, 14 Mar 2021 15:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iE1iMRrs9i2azU+GnOfoVfVH9rqkBfBPp4hwHdinfYQ=;
        b=fWip73QCqV1FQoAMJPT+qH3IeTzmVLg+VhrVD3y5TNPwvJgsZxMawhC0yl0xljR+h9
         MNou+/ouQnUNguZAvXPCjgZ2z4dvOgmUj/s2aiSqgPh9wgQYtrdS6WWxVq909wYAj0Uz
         fRhNPiPNaF6eZo1IE3frtbYH75fwy/heZ5oejvovXUxfLtFp/7AQKZFellRoGoPbLQeG
         FvrSSIMPI8j+FmKFr+z8YsSrKZeXRoiOgJ6Aka2cBD4CbcVMep8J8778SLdqcy+2XyCN
         +sFdQEG/iT7rOpd/Ye4N98aZVm5/gz8aYRD9p5MPTxDh9iaV5PkihsVM407J5p0qakP+
         W/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iE1iMRrs9i2azU+GnOfoVfVH9rqkBfBPp4hwHdinfYQ=;
        b=O/Dazg34CrB2F9hVQA1A3xV17AN+/ozGGS/CE8aQLg0j7/5yPaM6qRWQ6+3oNufAoM
         MBWjdSD0twW6FFw7GSBilkWFrBcWJkFw4Cfjke9x0vCDsFYL+/H6Vx6zjuXTpKvUefgc
         IFRIQ+fuGi3HOjHvmvH0TpTNTzxb9i5Wm+2+XPUoQ1BBlncbDGM+kdpDZlT64FMG63UD
         mOaxgqCrRjX+x7glkU2k67YvG5uwPzb1sojnz9FBKnTDGfHTYzZIflgmzEHHv+u0a8GZ
         nkswbzmZJguTB+m6h+0lq/8B+Q6mEyZe+RZQyOiLVBh/+0Ab07lVjdAmPJx4elC16ah+
         OlmQ==
X-Gm-Message-State: AOAM532DCMTewRu88c6SLAFKdUEIQzYvj/GdlyfeeQ4L4KhhTlcXqkQA
        5uwpoTMWN+NxTxq0IKhrweE=
X-Google-Smtp-Source: ABdhPJwXlQzF6fNEZwmKM2o4llNFUHAzneGBckADxtCgo/01Y+pwYF7qciXjC8Y4l+AmdKXXRWILlg==
X-Received: by 2002:a9d:19c1:: with SMTP id k59mr11247611otk.361.1615761009926;
        Sun, 14 Mar 2021 15:30:09 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-042b-6bf0-04bd-b4bc.res6.spectrum.com. [2603:8081:140c:1a00:42b:6bf0:4bd:b4bc])
        by smtp.gmail.com with ESMTPSA id l24sm6274879otr.31.2021.03.14.15.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 15:30:09 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next] RDMA/rxe: Split MEM into MR and MW
Date:   Sun, 14 Mar 2021 17:26:13 -0500
Message-Id: <20210314222612.44728-1-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In the original rxe implementation it was intended to use a common
object to represent MRs and MWs but they are different enough to
separate these into two objects.

This allows replacing the mem name with mr for MRs which is more
consistent with the style for the other objects and less likely
to be confusing. This is a long patch that mostly changes mem to
mr where it makes sense and adds a new rxe_mw struct.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c  |   4 +-
 drivers/infiniband/sw/rxe/rxe_loc.h   |  26 +--
 drivers/infiniband/sw/rxe/rxe_mr.c    | 256 +++++++++++++-------------
 drivers/infiniband/sw/rxe/rxe_pool.c  |  12 +-
 drivers/infiniband/sw/rxe/rxe_req.c   |  10 +-
 drivers/infiniband/sw/rxe/rxe_resp.c  |  34 ++--
 drivers/infiniband/sw/rxe/rxe_verbs.c |  20 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h |  73 +++++---
 8 files changed, 224 insertions(+), 211 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index 0a1e6393250b..5dc86c9e74c2 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -345,7 +345,7 @@ static inline enum comp_state do_read(struct rxe_qp *qp,
 
 	ret = copy_data(qp->pd, IB_ACCESS_LOCAL_WRITE,
 			&wqe->dma, payload_addr(pkt),
-			payload_size(pkt), to_mem_obj, NULL);
+			payload_size(pkt), to_mr_obj, NULL);
 	if (ret)
 		return COMPST_ERROR;
 
@@ -365,7 +365,7 @@ static inline enum comp_state do_atomic(struct rxe_qp *qp,
 
 	ret = copy_data(qp->pd, IB_ACCESS_LOCAL_WRITE,
 			&wqe->dma, &atomic_orig,
-			sizeof(u64), to_mem_obj, NULL);
+			sizeof(u64), to_mr_obj, NULL);
 	if (ret)
 		return COMPST_ERROR;
 	else
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 0d758760b9ae..9ec6bff6863f 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -72,40 +72,40 @@ int rxe_mmap(struct ib_ucontext *context, struct vm_area_struct *vma);
 
 /* rxe_mr.c */
 enum copy_direction {
-	to_mem_obj,
-	from_mem_obj,
+	to_mr_obj,
+	from_mr_obj,
 };
 
-void rxe_mem_init_dma(struct rxe_pd *pd,
-		      int access, struct rxe_mem *mem);
+void rxe_mr_init_dma(struct rxe_pd *pd,
+		      int access, struct rxe_mr *mr);
 
-int rxe_mem_init_user(struct rxe_pd *pd, u64 start,
+int rxe_mr_init_user(struct rxe_pd *pd, u64 start,
 		      u64 length, u64 iova, int access, struct ib_udata *udata,
-		      struct rxe_mem *mr);
+		      struct rxe_mr *mr);
 
-int rxe_mem_init_fast(struct rxe_pd *pd,
-		      int max_pages, struct rxe_mem *mem);
+int rxe_mr_init_fast(struct rxe_pd *pd,
+		      int max_pages, struct rxe_mr *mr);
 
-int rxe_mem_copy(struct rxe_mem *mem, u64 iova, void *addr,
+int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr,
 		 int length, enum copy_direction dir, u32 *crcp);
 
 int copy_data(struct rxe_pd *pd, int access,
 	      struct rxe_dma_info *dma, void *addr, int length,
 	      enum copy_direction dir, u32 *crcp);
 
-void *iova_to_vaddr(struct rxe_mem *mem, u64 iova, int length);
+void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length);
 
 enum lookup_type {
 	lookup_local,
 	lookup_remote,
 };
 
-struct rxe_mem *lookup_mem(struct rxe_pd *pd, int access, u32 key,
+struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
 			   enum lookup_type type);
 
-int mem_check_range(struct rxe_mem *mem, u64 iova, size_t length);
+int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length);
 
-void rxe_mem_cleanup(struct rxe_pool_entry *arg);
+void rxe_mr_cleanup(struct rxe_pool_entry *arg);
 
 int advance_dma_data(struct rxe_dma_info *dma, unsigned int length);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 6e8c41567ba0..b27aea9638b8 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -24,16 +24,16 @@ static u8 rxe_get_key(void)
 	return key;
 }
 
-int mem_check_range(struct rxe_mem *mem, u64 iova, size_t length)
+int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length)
 {
-	switch (mem->type) {
-	case RXE_MEM_TYPE_DMA:
+	switch (mr->type) {
+	case RXE_MR_TYPE_DMA:
 		return 0;
 
-	case RXE_MEM_TYPE_MR:
-		if (iova < mem->iova ||
-		    length > mem->length ||
-		    iova > mem->iova + mem->length - length)
+	case RXE_MR_TYPE_MR:
+		if (iova < mr->iova ||
+		    length > mr->length ||
+		    iova > mr->iova + mr->length - length)
 			return -EFAULT;
 		return 0;
 
@@ -46,85 +46,85 @@ int mem_check_range(struct rxe_mem *mem, u64 iova, size_t length)
 				| IB_ACCESS_REMOTE_WRITE	\
 				| IB_ACCESS_REMOTE_ATOMIC)
 
-static void rxe_mem_init(int access, struct rxe_mem *mem)
+static void rxe_mr_init(int access, struct rxe_mr *mr)
 {
-	u32 lkey = mem->pelem.index << 8 | rxe_get_key();
+	u32 lkey = mr->pelem.index << 8 | rxe_get_key();
 	u32 rkey = (access & IB_ACCESS_REMOTE) ? lkey : 0;
 
-	mem->ibmr.lkey		= lkey;
-	mem->ibmr.rkey		= rkey;
-	mem->state		= RXE_MEM_STATE_INVALID;
-	mem->type		= RXE_MEM_TYPE_NONE;
-	mem->map_shift		= ilog2(RXE_BUF_PER_MAP);
+	mr->ibmr.lkey		= lkey;
+	mr->ibmr.rkey		= rkey;
+	mr->state		= RXE_MR_STATE_INVALID;
+	mr->type		= RXE_MR_TYPE_NONE;
+	mr->map_shift		= ilog2(RXE_BUF_PER_MAP);
 }
 
-void rxe_mem_cleanup(struct rxe_pool_entry *arg)
+void rxe_mr_cleanup(struct rxe_pool_entry *arg)
 {
-	struct rxe_mem *mem = container_of(arg, typeof(*mem), pelem);
+	struct rxe_mr *mr = container_of(arg, typeof(*mr), pelem);
 	int i;
 
-	ib_umem_release(mem->umem);
+	ib_umem_release(mr->umem);
 
-	if (mem->map) {
-		for (i = 0; i < mem->num_map; i++)
-			kfree(mem->map[i]);
+	if (mr->map) {
+		for (i = 0; i < mr->num_map; i++)
+			kfree(mr->map[i]);
 
-		kfree(mem->map);
+		kfree(mr->map);
 	}
 }
 
-static int rxe_mem_alloc(struct rxe_mem *mem, int num_buf)
+static int rxe_mr_alloc(struct rxe_mr *mr, int num_buf)
 {
 	int i;
 	int num_map;
-	struct rxe_map **map = mem->map;
+	struct rxe_map **map = mr->map;
 
 	num_map = (num_buf + RXE_BUF_PER_MAP - 1) / RXE_BUF_PER_MAP;
 
-	mem->map = kmalloc_array(num_map, sizeof(*map), GFP_KERNEL);
-	if (!mem->map)
+	mr->map = kmalloc_array(num_map, sizeof(*map), GFP_KERNEL);
+	if (!mr->map)
 		goto err1;
 
 	for (i = 0; i < num_map; i++) {
-		mem->map[i] = kmalloc(sizeof(**map), GFP_KERNEL);
-		if (!mem->map[i])
+		mr->map[i] = kmalloc(sizeof(**map), GFP_KERNEL);
+		if (!mr->map[i])
 			goto err2;
 	}
 
 	BUILD_BUG_ON(!is_power_of_2(RXE_BUF_PER_MAP));
 
-	mem->map_shift	= ilog2(RXE_BUF_PER_MAP);
-	mem->map_mask	= RXE_BUF_PER_MAP - 1;
+	mr->map_shift	= ilog2(RXE_BUF_PER_MAP);
+	mr->map_mask	= RXE_BUF_PER_MAP - 1;
 
-	mem->num_buf = num_buf;
-	mem->num_map = num_map;
-	mem->max_buf = num_map * RXE_BUF_PER_MAP;
+	mr->num_buf = num_buf;
+	mr->num_map = num_map;
+	mr->max_buf = num_map * RXE_BUF_PER_MAP;
 
 	return 0;
 
 err2:
 	for (i--; i >= 0; i--)
-		kfree(mem->map[i]);
+		kfree(mr->map[i]);
 
-	kfree(mem->map);
+	kfree(mr->map);
 err1:
 	return -ENOMEM;
 }
 
-void rxe_mem_init_dma(struct rxe_pd *pd,
-		      int access, struct rxe_mem *mem)
+void rxe_mr_init_dma(struct rxe_pd *pd,
+		      int access, struct rxe_mr *mr)
 {
-	rxe_mem_init(access, mem);
+	rxe_mr_init(access, mr);
 
-	mem->ibmr.pd		= &pd->ibpd;
-	mem->access		= access;
-	mem->state		= RXE_MEM_STATE_VALID;
-	mem->type		= RXE_MEM_TYPE_DMA;
+	mr->ibmr.pd		= &pd->ibpd;
+	mr->access		= access;
+	mr->state		= RXE_MR_STATE_VALID;
+	mr->type		= RXE_MR_TYPE_DMA;
 }
 
-int rxe_mem_init_user(struct rxe_pd *pd, u64 start,
+int rxe_mr_init_user(struct rxe_pd *pd, u64 start,
 		      u64 length, u64 iova, int access, struct ib_udata *udata,
-		      struct rxe_mem *mem)
+		      struct rxe_mr *mr)
 {
 	struct rxe_map		**map;
 	struct rxe_phys_buf	*buf = NULL;
@@ -142,23 +142,23 @@ int rxe_mem_init_user(struct rxe_pd *pd, u64 start,
 		goto err1;
 	}
 
-	mem->umem = umem;
+	mr->umem = umem;
 	num_buf = ib_umem_num_pages(umem);
 
-	rxe_mem_init(access, mem);
+	rxe_mr_init(access, mr);
 
-	err = rxe_mem_alloc(mem, num_buf);
+	err = rxe_mr_alloc(mr, num_buf);
 	if (err) {
-		pr_warn("err %d from rxe_mem_alloc\n", err);
+		pr_warn("err %d from rxe_mr_alloc\n", err);
 		ib_umem_release(umem);
 		goto err1;
 	}
 
-	mem->page_shift		= PAGE_SHIFT;
-	mem->page_mask = PAGE_SIZE - 1;
+	mr->page_shift		= PAGE_SHIFT;
+	mr->page_mask = PAGE_SIZE - 1;
 
 	num_buf			= 0;
-	map			= mem->map;
+	map			= mr->map;
 	if (length > 0) {
 		buf = map[0]->buf;
 
@@ -185,15 +185,15 @@ int rxe_mem_init_user(struct rxe_pd *pd, u64 start,
 		}
 	}
 
-	mem->ibmr.pd		= &pd->ibpd;
-	mem->umem		= umem;
-	mem->access		= access;
-	mem->length		= length;
-	mem->iova		= iova;
-	mem->va			= start;
-	mem->offset		= ib_umem_offset(umem);
-	mem->state		= RXE_MEM_STATE_VALID;
-	mem->type		= RXE_MEM_TYPE_MR;
+	mr->ibmr.pd		= &pd->ibpd;
+	mr->umem		= umem;
+	mr->access		= access;
+	mr->length		= length;
+	mr->iova		= iova;
+	mr->va			= start;
+	mr->offset		= ib_umem_offset(umem);
+	mr->state		= RXE_MR_STATE_VALID;
+	mr->type		= RXE_MR_TYPE_MR;
 
 	return 0;
 
@@ -201,24 +201,24 @@ int rxe_mem_init_user(struct rxe_pd *pd, u64 start,
 	return err;
 }
 
-int rxe_mem_init_fast(struct rxe_pd *pd,
-		      int max_pages, struct rxe_mem *mem)
+int rxe_mr_init_fast(struct rxe_pd *pd,
+		      int max_pages, struct rxe_mr *mr)
 {
 	int err;
 
-	rxe_mem_init(0, mem);
+	rxe_mr_init(0, mr);
 
 	/* In fastreg, we also set the rkey */
-	mem->ibmr.rkey = mem->ibmr.lkey;
+	mr->ibmr.rkey = mr->ibmr.lkey;
 
-	err = rxe_mem_alloc(mem, max_pages);
+	err = rxe_mr_alloc(mr, max_pages);
 	if (err)
 		goto err1;
 
-	mem->ibmr.pd		= &pd->ibpd;
-	mem->max_buf		= max_pages;
-	mem->state		= RXE_MEM_STATE_FREE;
-	mem->type		= RXE_MEM_TYPE_MR;
+	mr->ibmr.pd		= &pd->ibpd;
+	mr->max_buf		= max_pages;
+	mr->state		= RXE_MR_STATE_FREE;
+	mr->type		= RXE_MR_TYPE_MR;
 
 	return 0;
 
@@ -227,27 +227,27 @@ int rxe_mem_init_fast(struct rxe_pd *pd,
 }
 
 static void lookup_iova(
-	struct rxe_mem	*mem,
+	struct rxe_mr	*mr,
 	u64			iova,
 	int			*m_out,
 	int			*n_out,
 	size_t			*offset_out)
 {
-	size_t			offset = iova - mem->iova + mem->offset;
+	size_t			offset = iova - mr->iova + mr->offset;
 	int			map_index;
 	int			buf_index;
 	u64			length;
 
-	if (likely(mem->page_shift)) {
-		*offset_out = offset & mem->page_mask;
-		offset >>= mem->page_shift;
-		*n_out = offset & mem->map_mask;
-		*m_out = offset >> mem->map_shift;
+	if (likely(mr->page_shift)) {
+		*offset_out = offset & mr->page_mask;
+		offset >>= mr->page_shift;
+		*n_out = offset & mr->map_mask;
+		*m_out = offset >> mr->map_shift;
 	} else {
 		map_index = 0;
 		buf_index = 0;
 
-		length = mem->map[map_index]->buf[buf_index].size;
+		length = mr->map[map_index]->buf[buf_index].size;
 
 		while (offset >= length) {
 			offset -= length;
@@ -257,7 +257,7 @@ static void lookup_iova(
 				map_index++;
 				buf_index = 0;
 			}
-			length = mem->map[map_index]->buf[buf_index].size;
+			length = mr->map[map_index]->buf[buf_index].size;
 		}
 
 		*m_out = map_index;
@@ -266,48 +266,48 @@ static void lookup_iova(
 	}
 }
 
-void *iova_to_vaddr(struct rxe_mem *mem, u64 iova, int length)
+void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length)
 {
 	size_t offset;
 	int m, n;
 	void *addr;
 
-	if (mem->state != RXE_MEM_STATE_VALID) {
-		pr_warn("mem not in valid state\n");
+	if (mr->state != RXE_MR_STATE_VALID) {
+		pr_warn("mr not in valid state\n");
 		addr = NULL;
 		goto out;
 	}
 
-	if (!mem->map) {
+	if (!mr->map) {
 		addr = (void *)(uintptr_t)iova;
 		goto out;
 	}
 
-	if (mem_check_range(mem, iova, length)) {
+	if (mr_check_range(mr, iova, length)) {
 		pr_warn("range violation\n");
 		addr = NULL;
 		goto out;
 	}
 
-	lookup_iova(mem, iova, &m, &n, &offset);
+	lookup_iova(mr, iova, &m, &n, &offset);
 
-	if (offset + length > mem->map[m]->buf[n].size) {
+	if (offset + length > mr->map[m]->buf[n].size) {
 		pr_warn("crosses page boundary\n");
 		addr = NULL;
 		goto out;
 	}
 
-	addr = (void *)(uintptr_t)mem->map[m]->buf[n].addr + offset;
+	addr = (void *)(uintptr_t)mr->map[m]->buf[n].addr + offset;
 
 out:
 	return addr;
 }
 
 /* copy data from a range (vaddr, vaddr+length-1) to or from
- * a mem object starting at iova. Compute incremental value of
- * crc32 if crcp is not zero. caller must hold a reference to mem
+ * a mr object starting at iova. Compute incremental value of
+ * crc32 if crcp is not zero. caller must hold a reference to mr
  */
-int rxe_mem_copy(struct rxe_mem *mem, u64 iova, void *addr, int length,
+int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 		 enum copy_direction dir, u32 *crcp)
 {
 	int			err;
@@ -323,43 +323,43 @@ int rxe_mem_copy(struct rxe_mem *mem, u64 iova, void *addr, int length,
 	if (length == 0)
 		return 0;
 
-	if (mem->type == RXE_MEM_TYPE_DMA) {
+	if (mr->type == RXE_MR_TYPE_DMA) {
 		u8 *src, *dest;
 
-		src  = (dir == to_mem_obj) ?
+		src  = (dir == to_mr_obj) ?
 			addr : ((void *)(uintptr_t)iova);
 
-		dest = (dir == to_mem_obj) ?
+		dest = (dir == to_mr_obj) ?
 			((void *)(uintptr_t)iova) : addr;
 
 		memcpy(dest, src, length);
 
 		if (crcp)
-			*crcp = rxe_crc32(to_rdev(mem->ibmr.device),
+			*crcp = rxe_crc32(to_rdev(mr->ibmr.device),
 					*crcp, dest, length);
 
 		return 0;
 	}
 
-	WARN_ON_ONCE(!mem->map);
+	WARN_ON_ONCE(!mr->map);
 
-	err = mem_check_range(mem, iova, length);
+	err = mr_check_range(mr, iova, length);
 	if (err) {
 		err = -EFAULT;
 		goto err1;
 	}
 
-	lookup_iova(mem, iova, &m, &i, &offset);
+	lookup_iova(mr, iova, &m, &i, &offset);
 
-	map	= mem->map + m;
+	map	= mr->map + m;
 	buf	= map[0]->buf + i;
 
 	while (length > 0) {
 		u8 *src, *dest;
 
 		va	= (u8 *)(uintptr_t)buf->addr + offset;
-		src  = (dir == to_mem_obj) ? addr : va;
-		dest = (dir == to_mem_obj) ? va : addr;
+		src  = (dir == to_mr_obj) ? addr : va;
+		dest = (dir == to_mr_obj) ? va : addr;
 
 		bytes	= buf->size - offset;
 
@@ -369,7 +369,7 @@ int rxe_mem_copy(struct rxe_mem *mem, u64 iova, void *addr, int length,
 		memcpy(dest, src, bytes);
 
 		if (crcp)
-			crc = rxe_crc32(to_rdev(mem->ibmr.device),
+			crc = rxe_crc32(to_rdev(mr->ibmr.device),
 					crc, dest, bytes);
 
 		length	-= bytes;
@@ -411,7 +411,7 @@ int copy_data(
 	struct rxe_sge		*sge	= &dma->sge[dma->cur_sge];
 	int			offset	= dma->sge_offset;
 	int			resid	= dma->resid;
-	struct rxe_mem		*mem	= NULL;
+	struct rxe_mr		*mr	= NULL;
 	u64			iova;
 	int			err;
 
@@ -424,8 +424,8 @@ int copy_data(
 	}
 
 	if (sge->length && (offset < sge->length)) {
-		mem = lookup_mem(pd, access, sge->lkey, lookup_local);
-		if (!mem) {
+		mr = lookup_mr(pd, access, sge->lkey, lookup_local);
+		if (!mr) {
 			err = -EINVAL;
 			goto err1;
 		}
@@ -435,9 +435,9 @@ int copy_data(
 		bytes = length;
 
 		if (offset >= sge->length) {
-			if (mem) {
-				rxe_drop_ref(mem);
-				mem = NULL;
+			if (mr) {
+				rxe_drop_ref(mr);
+				mr = NULL;
 			}
 			sge++;
 			dma->cur_sge++;
@@ -449,9 +449,9 @@ int copy_data(
 			}
 
 			if (sge->length) {
-				mem = lookup_mem(pd, access, sge->lkey,
+				mr = lookup_mr(pd, access, sge->lkey,
 						 lookup_local);
-				if (!mem) {
+				if (!mr) {
 					err = -EINVAL;
 					goto err1;
 				}
@@ -466,7 +466,7 @@ int copy_data(
 		if (bytes > 0) {
 			iova = sge->addr + offset;
 
-			err = rxe_mem_copy(mem, iova, addr, bytes, dir, crcp);
+			err = rxe_mr_copy(mr, iova, addr, bytes, dir, crcp);
 			if (err)
 				goto err2;
 
@@ -480,14 +480,14 @@ int copy_data(
 	dma->sge_offset = offset;
 	dma->resid	= resid;
 
-	if (mem)
-		rxe_drop_ref(mem);
+	if (mr)
+		rxe_drop_ref(mr);
 
 	return 0;
 
 err2:
-	if (mem)
-		rxe_drop_ref(mem);
+	if (mr)
+		rxe_drop_ref(mr);
 err1:
 	return err;
 }
@@ -525,31 +525,31 @@ int advance_dma_data(struct rxe_dma_info *dma, unsigned int length)
 	return 0;
 }
 
-/* (1) find the mem (mr or mw) corresponding to lkey/rkey
+/* (1) find the mr corresponding to lkey/rkey
  *     depending on lookup_type
- * (2) verify that the (qp) pd matches the mem pd
- * (3) verify that the mem can support the requested access
- * (4) verify that mem state is valid
+ * (2) verify that the (qp) pd matches the mr pd
+ * (3) verify that the mr can support the requested access
+ * (4) verify that mr state is valid
  */
-struct rxe_mem *lookup_mem(struct rxe_pd *pd, int access, u32 key,
+struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
 			   enum lookup_type type)
 {
-	struct rxe_mem *mem;
+	struct rxe_mr *mr;
 	struct rxe_dev *rxe = to_rdev(pd->ibpd.device);
 	int index = key >> 8;
 
-	mem = rxe_pool_get_index(&rxe->mr_pool, index);
-	if (!mem)
+	mr = rxe_pool_get_index(&rxe->mr_pool, index);
+	if (!mr)
 		return NULL;
 
-	if (unlikely((type == lookup_local && mr_lkey(mem) != key) ||
-		     (type == lookup_remote && mr_rkey(mem) != key) ||
-		     mr_pd(mem) != pd ||
-		     (access && !(access & mem->access)) ||
-		     mem->state != RXE_MEM_STATE_VALID)) {
-		rxe_drop_ref(mem);
-		mem = NULL;
+	if (unlikely((type == lookup_local && mr_lkey(mr) != key) ||
+		     (type == lookup_remote && mr_rkey(mr) != key) ||
+		     mr_pd(mr) != pd ||
+		     (access && !(access & mr->access)) ||
+		     mr->state != RXE_MR_STATE_VALID)) {
+		rxe_drop_ref(mr);
+		mr = NULL;
 	}
 
-	return mem;
+	return mr;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 62fef162e6a1..e7ae060059b8 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -8,8 +8,6 @@
 #include "rxe_loc.h"
 
 /* info about object pools
- * note that mr and mw share a single index space
- * so that one can map an lkey to the correct type of object
  */
 struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 	[RXE_TYPE_UC] = {
@@ -56,17 +54,17 @@ struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 	},
 	[RXE_TYPE_MR] = {
 		.name		= "rxe-mr",
-		.size		= sizeof(struct rxe_mem),
-		.elem_offset	= offsetof(struct rxe_mem, pelem),
-		.cleanup	= rxe_mem_cleanup,
+		.size		= sizeof(struct rxe_mr),
+		.elem_offset	= offsetof(struct rxe_mr, pelem),
+		.cleanup	= rxe_mr_cleanup,
 		.flags		= RXE_POOL_INDEX,
 		.max_index	= RXE_MAX_MR_INDEX,
 		.min_index	= RXE_MIN_MR_INDEX,
 	},
 	[RXE_TYPE_MW] = {
 		.name		= "rxe-mw",
-		.size		= sizeof(struct rxe_mem),
-		.elem_offset	= offsetof(struct rxe_mem, pelem),
+		.size		= sizeof(struct rxe_mw),
+		.elem_offset	= offsetof(struct rxe_mw, pelem),
 		.flags		= RXE_POOL_INDEX,
 		.max_index	= RXE_MAX_MW_INDEX,
 		.min_index	= RXE_MIN_MW_INDEX,
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index d4917646641a..4f4c82872378 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -465,7 +465,7 @@ static int fill_packet(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 		} else {
 			err = copy_data(qp->pd, 0, &wqe->dma,
 					payload_addr(pkt), paylen,
-					from_mem_obj,
+					from_mr_obj,
 					&crc);
 			if (err)
 				return err;
@@ -597,7 +597,7 @@ int rxe_requester(void *arg)
 	if (wqe->mask & WR_REG_MASK) {
 		if (wqe->wr.opcode == IB_WR_LOCAL_INV) {
 			struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
-			struct rxe_mem *rmr;
+			struct rxe_mr *rmr;
 
 			rmr = rxe_pool_get_index(&rxe->mr_pool,
 						 wqe->wr.ex.invalidate_rkey >> 8);
@@ -608,14 +608,14 @@ int rxe_requester(void *arg)
 				wqe->status = IB_WC_MW_BIND_ERR;
 				goto exit;
 			}
-			rmr->state = RXE_MEM_STATE_FREE;
+			rmr->state = RXE_MR_STATE_FREE;
 			rxe_drop_ref(rmr);
 			wqe->state = wqe_state_done;
 			wqe->status = IB_WC_SUCCESS;
 		} else if (wqe->wr.opcode == IB_WR_REG_MR) {
-			struct rxe_mem *rmr = to_rmr(wqe->wr.wr.reg.mr);
+			struct rxe_mr *rmr = to_rmr(wqe->wr.wr.reg.mr);
 
-			rmr->state = RXE_MEM_STATE_VALID;
+			rmr->state = RXE_MR_STATE_VALID;
 			rmr->access = wqe->wr.wr.reg.access;
 			rmr->ibmr.lkey = wqe->wr.wr.reg.key;
 			rmr->ibmr.rkey = wqe->wr.wr.reg.key;
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 5a098083a9d2..4da05751c79a 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -390,7 +390,7 @@ static enum resp_states check_length(struct rxe_qp *qp,
 static enum resp_states check_rkey(struct rxe_qp *qp,
 				   struct rxe_pkt_info *pkt)
 {
-	struct rxe_mem *mem = NULL;
+	struct rxe_mr *mr = NULL;
 	u64 va;
 	u32 rkey;
 	u32 resid;
@@ -429,18 +429,18 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 	resid	= qp->resp.resid;
 	pktlen	= payload_size(pkt);
 
-	mem = lookup_mem(qp->pd, access, rkey, lookup_remote);
-	if (!mem) {
+	mr = lookup_mr(qp->pd, access, rkey, lookup_remote);
+	if (!mr) {
 		state = RESPST_ERR_RKEY_VIOLATION;
 		goto err;
 	}
 
-	if (unlikely(mem->state == RXE_MEM_STATE_FREE)) {
+	if (unlikely(mr->state == RXE_MR_STATE_FREE)) {
 		state = RESPST_ERR_RKEY_VIOLATION;
 		goto err;
 	}
 
-	if (mem_check_range(mem, va, resid)) {
+	if (mr_check_range(mr, va, resid)) {
 		state = RESPST_ERR_RKEY_VIOLATION;
 		goto err;
 	}
@@ -468,12 +468,12 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 
 	WARN_ON_ONCE(qp->resp.mr);
 
-	qp->resp.mr = mem;
+	qp->resp.mr = mr;
 	return RESPST_EXECUTE;
 
 err:
-	if (mem)
-		rxe_drop_ref(mem);
+	if (mr)
+		rxe_drop_ref(mr);
 	return state;
 }
 
@@ -483,7 +483,7 @@ static enum resp_states send_data_in(struct rxe_qp *qp, void *data_addr,
 	int err;
 
 	err = copy_data(qp->pd, IB_ACCESS_LOCAL_WRITE, &qp->resp.wqe->dma,
-			data_addr, data_len, to_mem_obj, NULL);
+			data_addr, data_len, to_mr_obj, NULL);
 	if (unlikely(err))
 		return (err == -ENOSPC) ? RESPST_ERR_LENGTH
 					: RESPST_ERR_MALFORMED_WQE;
@@ -498,8 +498,8 @@ static enum resp_states write_data_in(struct rxe_qp *qp,
 	int	err;
 	int data_len = payload_size(pkt);
 
-	err = rxe_mem_copy(qp->resp.mr, qp->resp.va, payload_addr(pkt),
-			   data_len, to_mem_obj, NULL);
+	err = rxe_mr_copy(qp->resp.mr, qp->resp.va, payload_addr(pkt),
+			   data_len, to_mr_obj, NULL);
 	if (err) {
 		rc = RESPST_ERR_RKEY_VIOLATION;
 		goto out;
@@ -521,9 +521,9 @@ static enum resp_states process_atomic(struct rxe_qp *qp,
 	u64 iova = atmeth_va(pkt);
 	u64 *vaddr;
 	enum resp_states ret;
-	struct rxe_mem *mr = qp->resp.mr;
+	struct rxe_mr *mr = qp->resp.mr;
 
-	if (mr->state != RXE_MEM_STATE_VALID) {
+	if (mr->state != RXE_MR_STATE_VALID) {
 		ret = RESPST_ERR_RKEY_VIOLATION;
 		goto out;
 	}
@@ -700,8 +700,8 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 	if (!skb)
 		return RESPST_ERR_RNR;
 
-	err = rxe_mem_copy(res->read.mr, res->read.va, payload_addr(&ack_pkt),
-			   payload, from_mem_obj, &icrc);
+	err = rxe_mr_copy(res->read.mr, res->read.va, payload_addr(&ack_pkt),
+			   payload, from_mr_obj, &icrc);
 	if (err)
 		pr_err("Failed copying memory\n");
 
@@ -878,7 +878,7 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 			}
 
 			if (pkt->mask & RXE_IETH_MASK) {
-				struct rxe_mem *rmr;
+				struct rxe_mr *rmr;
 
 				wc->wc_flags |= IB_WC_WITH_INVALIDATE;
 				wc->ex.invalidate_rkey = ieth_rkey(pkt);
@@ -890,7 +890,7 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 					       wc->ex.invalidate_rkey);
 					return RESPST_ERROR;
 				}
-				rmr->state = RXE_MEM_STATE_FREE;
+				rmr->state = RXE_MR_STATE_FREE;
 				rxe_drop_ref(rmr);
 			}
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 7483a33bcec5..bfec57e0825c 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -865,7 +865,7 @@ static struct ib_mr *rxe_get_dma_mr(struct ib_pd *ibpd, int access)
 {
 	struct rxe_dev *rxe = to_rdev(ibpd->device);
 	struct rxe_pd *pd = to_rpd(ibpd);
-	struct rxe_mem *mr;
+	struct rxe_mr *mr;
 
 	mr = rxe_alloc(&rxe->mr_pool);
 	if (!mr)
@@ -873,7 +873,7 @@ static struct ib_mr *rxe_get_dma_mr(struct ib_pd *ibpd, int access)
 
 	rxe_add_index(mr);
 	rxe_add_ref(pd);
-	rxe_mem_init_dma(pd, access, mr);
+	rxe_mr_init_dma(pd, access, mr);
 
 	return &mr->ibmr;
 }
@@ -887,7 +887,7 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 	int err;
 	struct rxe_dev *rxe = to_rdev(ibpd->device);
 	struct rxe_pd *pd = to_rpd(ibpd);
-	struct rxe_mem *mr;
+	struct rxe_mr *mr;
 
 	mr = rxe_alloc(&rxe->mr_pool);
 	if (!mr) {
@@ -899,7 +899,7 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 
 	rxe_add_ref(pd);
 
-	err = rxe_mem_init_user(pd, start, length, iova,
+	err = rxe_mr_init_user(pd, start, length, iova,
 				access, udata, mr);
 	if (err)
 		goto err3;
@@ -916,9 +916,9 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 
 static int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 {
-	struct rxe_mem *mr = to_rmr(ibmr);
+	struct rxe_mr *mr = to_rmr(ibmr);
 
-	mr->state = RXE_MEM_STATE_ZOMBIE;
+	mr->state = RXE_MR_STATE_ZOMBIE;
 	rxe_drop_ref(mr_pd(mr));
 	rxe_drop_index(mr);
 	rxe_drop_ref(mr);
@@ -930,7 +930,7 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 {
 	struct rxe_dev *rxe = to_rdev(ibpd->device);
 	struct rxe_pd *pd = to_rpd(ibpd);
-	struct rxe_mem *mr;
+	struct rxe_mr *mr;
 	int err;
 
 	if (mr_type != IB_MR_TYPE_MEM_REG)
@@ -946,7 +946,7 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 
 	rxe_add_ref(pd);
 
-	err = rxe_mem_init_fast(pd, max_num_sg, mr);
+	err = rxe_mr_init_fast(pd, max_num_sg, mr);
 	if (err)
 		goto err2;
 
@@ -962,7 +962,7 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 
 static int rxe_set_page(struct ib_mr *ibmr, u64 addr)
 {
-	struct rxe_mem *mr = to_rmr(ibmr);
+	struct rxe_mr *mr = to_rmr(ibmr);
 	struct rxe_map *map;
 	struct rxe_phys_buf *buf;
 
@@ -982,7 +982,7 @@ static int rxe_set_page(struct ib_mr *ibmr, u64 addr)
 static int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
 			 int sg_nents, unsigned int *sg_offset)
 {
-	struct rxe_mem *mr = to_rmr(ibmr);
+	struct rxe_mr *mr = to_rmr(ibmr);
 	int n;
 
 	mr->nbuf = 0;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 79e0a5a878da..806d2735ec9f 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -39,7 +39,7 @@ struct rxe_ucontext {
 };
 
 struct rxe_pd {
-	struct ib_pd            ibpd;
+	struct ib_pd		ibpd;
 	struct rxe_pool_entry	pelem;
 };
 
@@ -156,7 +156,7 @@ struct resp_res {
 			struct sk_buff	*skb;
 		} atomic;
 		struct {
-			struct rxe_mem	*mr;
+			struct rxe_mr	*mr;
 			u64		va_org;
 			u32		rkey;
 			u32		length;
@@ -183,7 +183,7 @@ struct rxe_resp_info {
 
 	/* RDMA read / atomic only */
 	u64			va;
-	struct rxe_mem		*mr;
+	struct rxe_mr		*mr;
 	u32			resid;
 	u32			rkey;
 	u32			length;
@@ -262,42 +262,39 @@ struct rxe_qp {
 	struct execute_work	cleanup_work;
 };
 
-enum rxe_mem_state {
-	RXE_MEM_STATE_ZOMBIE,
-	RXE_MEM_STATE_INVALID,
-	RXE_MEM_STATE_FREE,
-	RXE_MEM_STATE_VALID,
+enum rxe_mr_state {
+	RXE_MR_STATE_ZOMBIE,
+	RXE_MR_STATE_INVALID,
+	RXE_MR_STATE_FREE,
+	RXE_MR_STATE_VALID,
 };
 
-enum rxe_mem_type {
-	RXE_MEM_TYPE_NONE,
-	RXE_MEM_TYPE_DMA,
-	RXE_MEM_TYPE_MR,
-	RXE_MEM_TYPE_MW,
+enum rxe_mr_type {
+	RXE_MR_TYPE_NONE,
+	RXE_MR_TYPE_DMA,
+	RXE_MR_TYPE_MR,
+	RXE_MR_TYPE_MW,
 };
 
 #define RXE_BUF_PER_MAP		(PAGE_SIZE / sizeof(struct rxe_phys_buf))
 
 struct rxe_phys_buf {
-	u64      addr;
-	u64      size;
+	u64	addr;
+	u64	size;
 };
 
 struct rxe_map {
 	struct rxe_phys_buf	buf[RXE_BUF_PER_MAP];
 };
 
-struct rxe_mem {
+struct rxe_mr {
 	struct rxe_pool_entry	pelem;
-	union {
-		struct ib_mr		ibmr;
-		struct ib_mw		ibmw;
-	};
+	struct ib_mr		ibmr;
 
 	struct ib_umem		*umem;
 
-	enum rxe_mem_state	state;
-	enum rxe_mem_type	type;
+	enum rxe_mr_state	state;
+	enum rxe_mr_type	type;
 	u64			va;
 	u64			iova;
 	size_t			length;
@@ -318,6 +315,24 @@ struct rxe_mem {
 	struct rxe_map		**map;
 };
 
+enum rxe_mw_state {
+	RXE_MW_STATE_INVALID	= RXE_MR_STATE_INVALID,
+	RXE_MW_STATE_FREE	= RXE_MR_STATE_FREE,
+	RXE_MW_STATE_VALID	= RXE_MR_STATE_VALID,
+};
+
+struct rxe_mw {
+	struct rxe_pool_entry	pelem;
+	struct ib_mw		ibmw;
+	struct rxe_qp		*qp;	/* type 2B only */
+	struct rxe_mr		*mr;
+	spinlock_t		lock;
+	enum rxe_mw_state	state;
+	u32			access;
+	u64			addr;
+	u64			length;
+};
+
 struct rxe_mc_grp {
 	struct rxe_pool_entry	pelem;
 	spinlock_t		mcg_lock; /* guard group */
@@ -422,27 +437,27 @@ static inline struct rxe_cq *to_rcq(struct ib_cq *cq)
 	return cq ? container_of(cq, struct rxe_cq, ibcq) : NULL;
 }
 
-static inline struct rxe_mem *to_rmr(struct ib_mr *mr)
+static inline struct rxe_mr *to_rmr(struct ib_mr *mr)
 {
-	return mr ? container_of(mr, struct rxe_mem, ibmr) : NULL;
+	return mr ? container_of(mr, struct rxe_mr, ibmr) : NULL;
 }
 
-static inline struct rxe_mem *to_rmw(struct ib_mw *mw)
+static inline struct rxe_mw *to_rmw(struct ib_mw *mw)
 {
-	return mw ? container_of(mw, struct rxe_mem, ibmw) : NULL;
+	return mw ? container_of(mw, struct rxe_mw, ibmw) : NULL;
 }
 
-static inline struct rxe_pd *mr_pd(struct rxe_mem *mr)
+static inline struct rxe_pd *mr_pd(struct rxe_mr *mr)
 {
 	return to_rpd(mr->ibmr.pd);
 }
 
-static inline u32 mr_lkey(struct rxe_mem *mr)
+static inline u32 mr_lkey(struct rxe_mr *mr)
 {
 	return mr->ibmr.lkey;
 }
 
-static inline u32 mr_rkey(struct rxe_mem *mr)
+static inline u32 mr_rkey(struct rxe_mr *mr)
 {
 	return mr->ibmr.rkey;
 }
-- 
2.27.0

