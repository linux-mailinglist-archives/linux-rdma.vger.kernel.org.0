Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55D3024C7EF
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Aug 2020 00:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbgHTWrf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Aug 2020 18:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728556AbgHTWrY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Aug 2020 18:47:24 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA7AC061386
        for <linux-rdma@vger.kernel.org>; Thu, 20 Aug 2020 15:47:20 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id h22so132038otq.11
        for <linux-rdma@vger.kernel.org>; Thu, 20 Aug 2020 15:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lDIKw8Le8kLTf3YCrZ4g4L5x1fbjAt0KSFma6dx1omI=;
        b=RRsHEwXm3QGKrKSrKDWuFyzy2l+tLSju+tKYpUZyPNvLTQYAcfkEhtomBB27ml8Czy
         rZnw1hMzQ2UzN9zntkUa5dn1geBJYmx28Phv20QtSgXBmpd9BcfIUg0w424G4hqsLEuD
         Ber/YvJ2XG7nqzGhnt0ZZ2CrkOdr4+PraDMsl2JzO1pka5I721Wtf3FiOhedbvZO32/a
         yQymrhx3CbPP1CvGGRc/LvV5ZLMZ/MZIeyXUKk6HzcSg7nkbAqH3cb+CYxMTvSr8OM33
         F9NMBBX3SD6hnrJ6ENPRIFI51LqUoUGDHC1ph/4QCZHy7RpHsH1r0miGPyQiiYephh5O
         Smpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lDIKw8Le8kLTf3YCrZ4g4L5x1fbjAt0KSFma6dx1omI=;
        b=O4gFvFrLSgFn5Q/+PvqYRGegvNYCnbckLkaOZnFlxrwQIr5m8gkPFZXWPAaxTbHanH
         bE6bzOM3vmNuF1t/t92wHan4EtRbwdoPKLTORd0cCutPEqws2bTzQGBbYGP3JZ+J3E48
         KfNjz7CGN8gJPKmojVNb6sl3goIo0gV66UVwZcWohFuNPGqf708LAu33W0W3S2SIeWgE
         JPI16gEt8D/NSE8K/zTArP4L34cRrNmqexOJG8+HFMGL7Y/3c9Bw/umhn4c2iwHbWLgE
         j8jOXRlOZeauwwdaOHv7/yOh2AfBEx6JKpXH/HxSZmC4FsJh0GB5BAcmN+WTbR//MpFh
         NXwg==
X-Gm-Message-State: AOAM530eWPl+IgYMQknxzH9ZlWVnVjo0jf5kIXfapxUYMDxjDw9blmhH
        lxymGPMVUIGYTt7izDbNHLCl5jyBzyeYCw==
X-Google-Smtp-Source: ABdhPJzLm23EFIjlC5/paShZGG5HVTCO+b29WC3BDBt39/+tfGxhnPUQGts6pBmhOFy1Jl0Vi4XEZw==
X-Received: by 2002:a9d:f26:: with SMTP id 35mr8366ott.314.1597963638605;
        Thu, 20 Aug 2020 15:47:18 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:e2a0:5228:a0c3:36eb])
        by smtp.gmail.com with ESMTPSA id 22sm678969oin.26.2020.08.20.15.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 15:47:18 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     linux-rdma@vger.kernel.org, zyjzyj2000@gmail.com
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH v3 07/17] rdma_rxe: Separated MR and MW objects.
Date:   Thu, 20 Aug 2020 17:46:28 -0500
Message-Id: <20200820224638.3212-8-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200820224638.3212-1-rpearson@hpe.com>
References: <20200820224638.3212-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In the original rxe implementation it was intended to use a common
object to represent MRs and MWs but it became clear that they are
different enough to separate these into two objects.

This allows replacing the mem name with mr for MRs which is more consistent
with the style for the other objects and less likely to be confusing. This
is a long patch that just changes mem to mr where it makes sense.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c  |   4 +-
 drivers/infiniband/sw/rxe/rxe_loc.h   |  26 +--
 drivers/infiniband/sw/rxe/rxe_mr.c    | 264 +++++++++++++-------------
 drivers/infiniband/sw/rxe/rxe_pool.c  |   6 +-
 drivers/infiniband/sw/rxe/rxe_req.c   |   6 +-
 drivers/infiniband/sw/rxe/rxe_resp.c  |  30 +--
 drivers/infiniband/sw/rxe/rxe_verbs.c |  18 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h |  33 ++--
 8 files changed, 189 insertions(+), 198 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index d9a527c138d3..54fc55487bc0 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -347,7 +347,7 @@ static inline enum comp_state do_read(struct rxe_qp *qp,
 
 	ret = copy_data(qp->pd, IB_ACCESS_LOCAL_WRITE,
 			&wqe->dma, payload_addr(pkt),
-			payload_size(pkt), to_mem_obj, NULL);
+			payload_size(pkt), to_mr_obj, NULL);
 	if (ret)
 		return COMPST_ERROR;
 
@@ -367,7 +367,7 @@ static inline enum comp_state do_atomic(struct rxe_qp *qp,
 
 	ret = copy_data(qp->pd, IB_ACCESS_LOCAL_WRITE,
 			&wqe->dma, &atomic_orig,
-			sizeof(u64), to_mem_obj, NULL);
+			sizeof(u64), to_mr_obj, NULL);
 	if (ret)
 		return COMPST_ERROR;
 	else
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 9ab5f2c34def..cbed269edfe7 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -74,40 +74,40 @@ int rxe_mmap(struct ib_ucontext *context, struct vm_area_struct *vma);
 
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
index 6e802abc4257..7b870873edca 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -26,17 +26,17 @@ static u8 rxe_get_key(void)
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
-	case RXE_MEM_TYPE_FMR:
-		if (iova < mem->iova ||
-		    length > mem->length ||
-		    iova > mem->iova + mem->length - length)
+	case RXE_MR_TYPE_MR:
+	case RXE_MR_TYPE_FMR:
+		if (iova < mr->iova ||
+		    length > mr->length ||
+		    iova > mr->iova + mr->length - length)
 			return -EFAULT;
 		return 0;
 
@@ -49,90 +49,90 @@ int mem_check_range(struct rxe_mem *mem, u64 iova, size_t length)
 				| IB_ACCESS_REMOTE_WRITE	\
 				| IB_ACCESS_REMOTE_ATOMIC)
 
-static void rxe_mem_init(int access, struct rxe_mem *mem)
+static void rxe_mr_init(int access, struct rxe_mr *mr)
 {
-	u32 lkey = mem->pelem.index << 8 | rxe_get_key();
+	u32 lkey = mr->pelem.index << 8 | rxe_get_key();
 	u32 rkey = (access & IB_ACCESS_REMOTE) ? lkey : 0;
 
-	if (mem->pelem.pool->type == RXE_TYPE_MR) {
-		mem->ibmr.lkey		= lkey;
-		mem->ibmr.rkey		= rkey;
+	if (mr->pelem.pool->type == RXE_TYPE_MR) {
+		mr->ibmr.lkey		= lkey;
+		mr->ibmr.rkey		= rkey;
 	}
 
-	mem->lkey		= lkey;
-	mem->rkey		= rkey;
-	mem->state		= RXE_MEM_STATE_INVALID;
-	mem->type		= RXE_MEM_TYPE_NONE;
-	mem->map_shift		= ilog2(RXE_BUF_PER_MAP);
+	mr->lkey		= lkey;
+	mr->rkey		= rkey;
+	mr->state		= RXE_MEM_STATE_INVALID;
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
 
-	mem->pd			= pd;
-	mem->access		= access;
-	mem->state		= RXE_MEM_STATE_VALID;
-	mem->type		= RXE_MEM_TYPE_DMA;
+	mr->pd			= pd;
+	mr->access		= access;
+	mr->state		= RXE_MEM_STATE_VALID;
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
@@ -150,23 +150,23 @@ int rxe_mem_init_user(struct rxe_pd *pd, u64 start,
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
 
@@ -192,15 +192,15 @@ int rxe_mem_init_user(struct rxe_pd *pd, u64 start,
 		}
 	}
 
-	mem->pd			= pd;
-	mem->umem		= umem;
-	mem->access		= access;
-	mem->length		= length;
-	mem->iova		= iova;
-	mem->va			= start;
-	mem->offset		= ib_umem_offset(umem);
-	mem->state		= RXE_MEM_STATE_VALID;
-	mem->type		= RXE_MEM_TYPE_MR;
+	mr->pd			= pd;
+	mr->umem		= umem;
+	mr->access		= access;
+	mr->length		= length;
+	mr->iova		= iova;
+	mr->va			= start;
+	mr->offset		= ib_umem_offset(umem);
+	mr->state		= RXE_MEM_STATE_VALID;
+	mr->type		= RXE_MR_TYPE_MR;
 
 	return 0;
 
@@ -208,24 +208,24 @@ int rxe_mem_init_user(struct rxe_pd *pd, u64 start,
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
 
-	mem->pd			= pd;
-	mem->max_buf		= max_pages;
-	mem->state		= RXE_MEM_STATE_FREE;
-	mem->type		= RXE_MEM_TYPE_MR;
+	mr->pd			= pd;
+	mr->max_buf		= max_pages;
+	mr->state		= RXE_MEM_STATE_FREE;
+	mr->type		= RXE_MR_TYPE_MR;
 
 	return 0;
 
@@ -234,27 +234,27 @@ int rxe_mem_init_fast(struct rxe_pd *pd,
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
@@ -264,7 +264,7 @@ static void lookup_iova(
 				map_index++;
 				buf_index = 0;
 			}
-			length = mem->map[map_index]->buf[buf_index].size;
+			length = mr->map[map_index]->buf[buf_index].size;
 		}
 
 		*m_out = map_index;
@@ -273,48 +273,48 @@ static void lookup_iova(
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
+	if (mr->state != RXE_MEM_STATE_VALID) {
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
@@ -330,43 +330,43 @@ int rxe_mem_copy(struct rxe_mem *mem, u64 iova, void *addr, int length,
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
-			*crcp = rxe_crc32(to_rdev(mem->pd->ibpd.device),
+			*crcp = rxe_crc32(to_rdev(mr->pd->ibpd.device),
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
 
@@ -376,7 +376,7 @@ int rxe_mem_copy(struct rxe_mem *mem, u64 iova, void *addr, int length,
 		memcpy(dest, src, bytes);
 
 		if (crcp)
-			crc = rxe_crc32(to_rdev(mem->pd->ibpd.device),
+			crc = rxe_crc32(to_rdev(mr->pd->ibpd.device),
 					crc, dest, bytes);
 
 		length	-= bytes;
@@ -418,7 +418,7 @@ int copy_data(
 	struct rxe_sge		*sge	= &dma->sge[dma->cur_sge];
 	int			offset	= dma->sge_offset;
 	int			resid	= dma->resid;
-	struct rxe_mem		*mem	= NULL;
+	struct rxe_mr		*mr	= NULL;
 	u64			iova;
 	int			err;
 
@@ -431,8 +431,8 @@ int copy_data(
 	}
 
 	if (sge->length && (offset < sge->length)) {
-		mem = lookup_mem(pd, access, sge->lkey, lookup_local);
-		if (!mem) {
+		mr = lookup_mr(pd, access, sge->lkey, lookup_local);
+		if (!mr) {
 			err = -EINVAL;
 			goto err1;
 		}
@@ -442,9 +442,9 @@ int copy_data(
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
@@ -456,9 +456,9 @@ int copy_data(
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
@@ -473,7 +473,7 @@ int copy_data(
 		if (bytes > 0) {
 			iova = sge->addr + offset;
 
-			err = rxe_mem_copy(mem, iova, addr, bytes, dir, crcp);
+			err = rxe_mr_copy(mr, iova, addr, bytes, dir, crcp);
 			if (err)
 				goto err2;
 
@@ -487,14 +487,14 @@ int copy_data(
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
@@ -532,31 +532,31 @@ int advance_dma_data(struct rxe_dma_info *dma, unsigned int length)
 	return 0;
 }
 
-/* (1) find the mem (mr or mw) corresponding to lkey/rkey
+/* (1) find the mr (mr or mw) corresponding to lkey/rkey
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
 
-	if (unlikely((type == lookup_local && mem->lkey != key) ||
-		     (type == lookup_remote && mem->rkey != key) ||
-		     mem->pd != pd ||
-		     (access && !(access & mem->access)) ||
-		     mem->state != RXE_MEM_STATE_VALID)) {
-		rxe_drop_ref(mem);
-		mem = NULL;
+	if (unlikely((type == lookup_local && mr->lkey != key) ||
+		     (type == lookup_remote && mr->rkey != key) ||
+		     mr->pd != pd ||
+		     (access && !(access & mr->access)) ||
+		     mr->state != RXE_MEM_STATE_VALID)) {
+		rxe_drop_ref(mr);
+		mr = NULL;
 	}
 
-	return mem;
+	return mr;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 31fb0be7cdf3..fe652ce488f3 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -52,15 +52,15 @@ struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 	},
 	[RXE_TYPE_MR] = {
 		.name		= "rxe-mr",
-		.size		= sizeof(struct rxe_mem),
-		.cleanup	= rxe_mem_cleanup,
+		.size		= sizeof(struct rxe_mr),
+		.cleanup	= rxe_mr_cleanup,
 		.flags		= RXE_POOL_INDEX,
 		.max_index	= RXE_MAX_MR_INDEX,
 		.min_index	= RXE_MIN_MR_INDEX,
 	},
 	[RXE_TYPE_MW] = {
 		.name		= "rxe-mw",
-		.size		= sizeof(struct rxe_mem),
+		.size		= sizeof(struct rxe_mr),
 		.flags		= RXE_POOL_INDEX,
 		.max_index	= RXE_MAX_MW_INDEX,
 		.min_index	= RXE_MIN_MW_INDEX,
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index dcf6ab0bcd51..ffc8f65b2ad7 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -467,7 +467,7 @@ static int fill_packet(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 		} else {
 			err = copy_data(qp->pd, 0, &wqe->dma,
 					payload_addr(pkt), paylen,
-					from_mem_obj,
+					from_mr_obj,
 					&crc);
 			if (err)
 				return err;
@@ -599,7 +599,7 @@ int rxe_requester(void *arg)
 	if (wqe->mask & WR_REG_MASK) {
 		if (wqe->wr.opcode == IB_WR_LOCAL_INV) {
 			struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
-			struct rxe_mem *rmr;
+			struct rxe_mr *rmr;
 
 			rmr = rxe_pool_get_index(&rxe->mr_pool,
 						 wqe->wr.ex.invalidate_rkey >> 8);
@@ -615,7 +615,7 @@ int rxe_requester(void *arg)
 			wqe->state = wqe_state_done;
 			wqe->status = IB_WC_SUCCESS;
 		} else if (wqe->wr.opcode == IB_WR_REG_MR) {
-			struct rxe_mem *rmr = to_rmr(wqe->wr.wr.reg.mr);
+			struct rxe_mr *rmr = to_rmr(wqe->wr.wr.reg.mr);
 
 			rmr->state = RXE_MEM_STATE_VALID;
 			rmr->access = wqe->wr.wr.reg.access;
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index aefc9a27ece5..6748cdde4e78 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -392,7 +392,7 @@ static enum resp_states check_length(struct rxe_qp *qp,
 static enum resp_states check_rkey(struct rxe_qp *qp,
 				   struct rxe_pkt_info *pkt)
 {
-	struct rxe_mem *mem = NULL;
+	struct rxe_mr *mr = NULL;
 	u64 va;
 	u32 rkey;
 	u32 resid;
@@ -431,18 +431,18 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
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
+	if (unlikely(mr->state == RXE_MEM_STATE_FREE)) {
 		state = RESPST_ERR_RKEY_VIOLATION;
 		goto err;
 	}
 
-	if (mem_check_range(mem, va, resid)) {
+	if (mr_check_range(mr, va, resid)) {
 		state = RESPST_ERR_RKEY_VIOLATION;
 		goto err;
 	}
@@ -470,12 +470,12 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 
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
 
@@ -485,7 +485,7 @@ static enum resp_states send_data_in(struct rxe_qp *qp, void *data_addr,
 	int err;
 
 	err = copy_data(qp->pd, IB_ACCESS_LOCAL_WRITE, &qp->resp.wqe->dma,
-			data_addr, data_len, to_mem_obj, NULL);
+			data_addr, data_len, to_mr_obj, NULL);
 	if (unlikely(err))
 		return (err == -ENOSPC) ? RESPST_ERR_LENGTH
 					: RESPST_ERR_MALFORMED_WQE;
@@ -500,8 +500,8 @@ static enum resp_states write_data_in(struct rxe_qp *qp,
 	int	err;
 	int data_len = payload_size(pkt);
 
-	err = rxe_mem_copy(qp->resp.mr, qp->resp.va, payload_addr(pkt),
-			   data_len, to_mem_obj, NULL);
+	err = rxe_mr_copy(qp->resp.mr, qp->resp.va, payload_addr(pkt),
+			   data_len, to_mr_obj, NULL);
 	if (err) {
 		rc = RESPST_ERR_RKEY_VIOLATION;
 		goto out;
@@ -523,7 +523,7 @@ static enum resp_states process_atomic(struct rxe_qp *qp,
 	u64 iova = atmeth_va(pkt);
 	u64 *vaddr;
 	enum resp_states ret;
-	struct rxe_mem *mr = qp->resp.mr;
+	struct rxe_mr *mr = qp->resp.mr;
 
 	if (mr->state != RXE_MEM_STATE_VALID) {
 		ret = RESPST_ERR_RKEY_VIOLATION;
@@ -702,8 +702,8 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 	if (!skb)
 		return RESPST_ERR_RNR;
 
-	err = rxe_mem_copy(res->read.mr, res->read.va, payload_addr(&ack_pkt),
-			   payload, from_mem_obj, &icrc);
+	err = rxe_mr_copy(res->read.mr, res->read.va, payload_addr(&ack_pkt),
+			   payload, from_mr_obj, &icrc);
 	if (err)
 		pr_err("Failed copying memory\n");
 
@@ -885,7 +885,7 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 			}
 
 			if (pkt->mask & RXE_IETH_MASK) {
-				struct rxe_mem *rmr;
+				struct rxe_mr *rmr;
 
 				wc->wc_flags |= IB_WC_WITH_INVALIDATE;
 				wc->ex.invalidate_rkey = ieth_rkey(pkt);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index dcd8693f8ce6..c0db1e318dab 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -868,7 +868,7 @@ static struct ib_mr *rxe_get_dma_mr(struct ib_pd *ibpd, int access)
 {
 	struct rxe_dev *rxe = to_rdev(ibpd->device);
 	struct rxe_pd *pd = to_rpd(ibpd);
-	struct rxe_mem *mr;
+	struct rxe_mr *mr;
 
 	mr = rxe_alloc(&rxe->mr_pool);
 	if (!mr)
@@ -876,7 +876,7 @@ static struct ib_mr *rxe_get_dma_mr(struct ib_pd *ibpd, int access)
 
 	rxe_add_index(mr);
 	rxe_add_ref(pd);
-	rxe_mem_init_dma(pd, access, mr);
+	rxe_mr_init_dma(pd, access, mr);
 
 	return &mr->ibmr;
 }
@@ -890,7 +890,7 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 	int err;
 	struct rxe_dev *rxe = to_rdev(ibpd->device);
 	struct rxe_pd *pd = to_rpd(ibpd);
-	struct rxe_mem *mr;
+	struct rxe_mr *mr;
 
 	mr = rxe_alloc(&rxe->mr_pool);
 	if (!mr) {
@@ -902,7 +902,7 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 
 	rxe_add_ref(pd);
 
-	err = rxe_mem_init_user(pd, start, length, iova,
+	err = rxe_mr_init_user(pd, start, length, iova,
 				access, udata, mr);
 	if (err)
 		goto err3;
@@ -919,7 +919,7 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 
 static int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 {
-	struct rxe_mem *mr = to_rmr(ibmr);
+	struct rxe_mr *mr = to_rmr(ibmr);
 
 	mr->state = RXE_MEM_STATE_ZOMBIE;
 	rxe_drop_ref(mr->pd);
@@ -933,7 +933,7 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 {
 	struct rxe_dev *rxe = to_rdev(ibpd->device);
 	struct rxe_pd *pd = to_rpd(ibpd);
-	struct rxe_mem *mr;
+	struct rxe_mr *mr;
 	int err;
 
 	if (mr_type != IB_MR_TYPE_MEM_REG)
@@ -949,7 +949,7 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 
 	rxe_add_ref(pd);
 
-	err = rxe_mem_init_fast(pd, max_num_sg, mr);
+	err = rxe_mr_init_fast(pd, max_num_sg, mr);
 	if (err)
 		goto err2;
 
@@ -965,7 +965,7 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 
 static int rxe_set_page(struct ib_mr *ibmr, u64 addr)
 {
-	struct rxe_mem *mr = to_rmr(ibmr);
+	struct rxe_mr *mr = to_rmr(ibmr);
 	struct rxe_map *map;
 	struct rxe_phys_buf *buf;
 
@@ -985,7 +985,7 @@ static int rxe_set_page(struct ib_mr *ibmr, u64 addr)
 static int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
 			 int sg_nents, unsigned int *sg_offset)
 {
-	struct rxe_mem *mr = to_rmr(ibmr);
+	struct rxe_mr *mr = to_rmr(ibmr);
 	int n;
 
 	mr->nbuf = 0;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 431551bb5d66..c866fc5a80d6 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -158,7 +158,7 @@ struct resp_res {
 			struct sk_buff	*skb;
 		} atomic;
 		struct {
-			struct rxe_mem	*mr;
+			struct rxe_mr	*mr;
 			u64		va_org;
 			u32		rkey;
 			u32		length;
@@ -185,7 +185,7 @@ struct rxe_resp_info {
 
 	/* RDMA read / atomic only */
 	u64			va;
-	struct rxe_mem		*mr;
+	struct rxe_mr		*mr;
 	u32			resid;
 	u32			rkey;
 	u32			length;
@@ -271,12 +271,11 @@ enum rxe_mem_state {
 	RXE_MEM_STATE_VALID,
 };
 
-enum rxe_mem_type {
-	RXE_MEM_TYPE_NONE,
-	RXE_MEM_TYPE_DMA,
-	RXE_MEM_TYPE_MR,
-	RXE_MEM_TYPE_FMR,
-	RXE_MEM_TYPE_MW,
+enum rxe_mr_type {
+	RXE_MR_TYPE_NONE,
+	RXE_MR_TYPE_DMA,
+	RXE_MR_TYPE_MR,
+	RXE_MR_TYPE_FMR,
 };
 
 #define RXE_BUF_PER_MAP		(PAGE_SIZE / sizeof(struct rxe_phys_buf))
@@ -290,12 +289,9 @@ struct rxe_map {
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
 
 	struct rxe_pd		*pd;
 	struct ib_umem		*umem;
@@ -304,7 +300,7 @@ struct rxe_mem {
 	u32			rkey;
 
 	enum rxe_mem_state	state;
-	enum rxe_mem_type	type;
+	enum rxe_mr_type	type;
 	u64			va;
 	u64			iova;
 	size_t			length;
@@ -430,14 +426,9 @@ static inline struct rxe_cq *to_rcq(struct ib_cq *cq)
 	return cq ? container_of(cq, struct rxe_cq, ibcq) : NULL;
 }
 
-static inline struct rxe_mem *to_rmr(struct ib_mr *mr)
-{
-	return mr ? container_of(mr, struct rxe_mem, ibmr) : NULL;
-}
-
-static inline struct rxe_mem *to_rmw(struct ib_mw *mw)
+static inline struct rxe_mr *to_rmr(struct ib_mr *mr)
 {
-	return mw ? container_of(mw, struct rxe_mem, ibmw) : NULL;
+	return mr ? container_of(mr, struct rxe_mr, ibmr) : NULL;
 }
 
 int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name);
-- 
2.25.1

