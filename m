Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9D166885C
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Jan 2023 01:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjAMAWe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Jan 2023 19:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240282AbjAMAWF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Jan 2023 19:22:05 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3505DE7F
        for <linux-rdma@vger.kernel.org>; Thu, 12 Jan 2023 16:22:03 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id o66so16604841oia.6
        for <linux-rdma@vger.kernel.org>; Thu, 12 Jan 2023 16:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cp2tQtiqzjVQApU9c251Qx43c+Yghn17fbct5ZTYpxw=;
        b=ZZVNFPtBzuS5lh9TtxYHsZLGvREacE9Pf/n022h9OuPd/99coIPkk2DZ6HL/iuDExI
         x2sFl/PuNdcqByrew1kslb0LxVY5I3sBLsdxwd1lp/EQYaXtwmsihLfU5x2c5QyfInhB
         wgJNjda6CEha4lBts8yzEisF1Mwb2oa28Ft/daV7UundZ1dAB29ICNiZqKiSf5Z5MIDV
         AotYlt/R/u+mLRW3TQb3pEXG4BtIpL8EDABeCkWJGOBSGWmJ22camC0sJGSIX9jPEwg0
         rQS94mgnM3WnyVqrKQqrLwwMhrV5UzbshZjkXt2JwafJEJeabIk8FOzP10E/nJp6gD+a
         CUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cp2tQtiqzjVQApU9c251Qx43c+Yghn17fbct5ZTYpxw=;
        b=cEv78Cw0eTOeTskE5nO8Q1Mvmjs0BKh8jIYlpQNzEEDyFiihj0+fAkiIgigbVmIRgF
         mB+3M1+tmymE/ejiTNYtiWj3HVidRmy3k0mhMIbjaxs02H79I0bzBXrRAncqCVHKQ+UK
         W6uBJkTqYJFHuUrtNSgJZWo15j88R7pq58dqYAvIv6L6OPDXo9M2bS6KB/jhE+S+K0OX
         97DXmzQbM9CnB+lQSslOBcfvV5oKWGR2lPJqqawjL4u291hi8vfm2nr0+BeKfROSBPZX
         DWIbFoim6hcEu6prF6uSSDwRXfKjN4/9UJj0SquEhaZm8A0k01xJIg4LJv4D2l14NY8T
         9pYQ==
X-Gm-Message-State: AFqh2kqiNmZHaBbMFfny8AfH/dhUuwu2CwPXAVYq6EncuZr8V+yURRnh
        sv15ahpOJpluXckaZbEoBYM=
X-Google-Smtp-Source: AMrXdXusVCjrV9nweYEWfdDFkyeCnABkfSfzxjp8BldcpC2+xz7yrKEiwBKO5PDnsJWFEmLpqZk1KA==
X-Received: by 2002:a05:6808:1442:b0:364:8be5:9229 with SMTP id x2-20020a056808144200b003648be59229mr3382802oiv.34.1673569322800;
        Thu, 12 Jan 2023 16:22:02 -0800 (PST)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-550f-93bd-b210-47c2.res6.spectrum.com. [2603:8081:140c:1a00:550f:93bd:b210:47c2])
        by smtp.googlemail.com with ESMTPSA id z25-20020a056808049900b0035a9003b8edsm8480471oid.40.2023.01.12.16.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 16:22:02 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leonro@nvidia.com, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 6/6] RDMA/rxe: Replace rxe_map and rxe_phys_buf by xarray
Date:   Thu, 12 Jan 2023 18:21:16 -0600
Message-Id: <20230113002116.457324-7-rpearsonhpe@gmail.com>
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

Replace struct rxe-phys_buf and struct rxe_map by struct xarray
in rxe_verbs.h. This allows using rcu locking on reads for
the memory maps stored in each mr.

This is based off of a sketch of a patch from Jason Gunthorpe in the
link below. Some changes were needed to make this work. It applies
cleanly to the current for-next and passes the pyverbs, perftest
and the same blktests test cases which run today.

Link: https://lore.kernel.org/linux-rdma/Y3gvZr6%2FNCii9Avy@nvidia.com/
Co-developed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h   |   1 -
 drivers/infiniband/sw/rxe/rxe_mr.c    | 533 ++++++++++++--------------
 drivers/infiniband/sw/rxe/rxe_resp.c  |   2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h |  21 +-
 4 files changed, 251 insertions(+), 306 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index fd70c71a9e4e..0cf78f9bb27c 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -71,7 +71,6 @@ int copy_data(struct rxe_pd *pd, int access, struct rxe_dma_info *dma,
 	      void *addr, int length, enum rxe_mr_copy_dir dir);
 int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
 		  int sg_nents, unsigned int *sg_offset);
-void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length);
 int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
 			u64 compare, u64 swap_add, u64 *orig_val);
 int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, void *addr);
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 369062ffaba6..08cc3e31a662 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -60,145 +60,113 @@ static void rxe_mr_init(int access, struct rxe_mr *mr)
 	mr->lkey = mr->ibmr.lkey = lkey;
 	mr->rkey = mr->ibmr.rkey = rkey;
 
+	mr->access = access;
 	mr->ibmr.page_size = PAGE_SIZE;
 	mr->page_mask = PAGE_MASK;
 	mr->page_shift = PAGE_SHIFT;
 	mr->state = RXE_MR_STATE_INVALID;
 }
 
-static int rxe_mr_alloc(struct rxe_mr *mr, int num_buf)
-{
-	int i;
-	int num_map;
-	struct rxe_map **map = mr->map;
-
-	num_map = (num_buf + RXE_BUF_PER_MAP - 1) / RXE_BUF_PER_MAP;
-
-	mr->map = kmalloc_array(num_map, sizeof(*map), GFP_KERNEL);
-	if (!mr->map)
-		goto err1;
-
-	for (i = 0; i < num_map; i++) {
-		mr->map[i] = kmalloc(sizeof(**map), GFP_KERNEL);
-		if (!mr->map[i])
-			goto err2;
-	}
-
-	BUILD_BUG_ON(!is_power_of_2(RXE_BUF_PER_MAP));
-
-	mr->map_shift = ilog2(RXE_BUF_PER_MAP);
-	mr->map_mask = RXE_BUF_PER_MAP - 1;
-
-	mr->num_buf = num_buf;
-	mr->num_map = num_map;
-	mr->max_buf = num_map * RXE_BUF_PER_MAP;
-
-	return 0;
-
-err2:
-	for (i--; i >= 0; i--)
-		kfree(mr->map[i]);
-
-	kfree(mr->map);
-	mr->map = NULL;
-err1:
-	return -ENOMEM;
-}
-
 void rxe_mr_init_dma(int access, struct rxe_mr *mr)
 {
 	rxe_mr_init(access, mr);
 
-	mr->access = access;
 	mr->state = RXE_MR_STATE_VALID;
 	mr->ibmr.type = IB_MR_TYPE_DMA;
 }
 
-static bool is_pmem_page(struct page *pg)
+static unsigned long rxe_mr_iova_to_index(struct rxe_mr *mr, u64 iova)
 {
-	unsigned long paddr = page_to_phys(pg);
+	return (iova >> mr->page_shift) - (mr->ibmr.iova >> mr->page_shift);
+}
 
-	return REGION_INTERSECTS ==
-	       region_intersects(paddr, PAGE_SIZE, IORESOURCE_MEM,
-				 IORES_DESC_PERSISTENT_MEMORY);
+static unsigned long rxe_mr_iova_to_page_offset(struct rxe_mr *mr, u64 iova)
+{
+	return iova & (mr_page_size(mr) - 1);
+}
+
+static int rxe_mr_fill_pages_from_sgt(struct rxe_mr *mr, struct sg_table *sgt)
+{
+	XA_STATE(xas, &mr->pages, 0);
+	struct sg_page_iter sg_iter;
+
+	xa_init(&mr->pages);
+
+	__sg_page_iter_start(&sg_iter, sgt->sgl, sgt->orig_nents, 0);
+	if (!__sg_page_iter_next(&sg_iter))
+		return 0;
+
+	do {
+		xas_lock(&xas);
+		while (true) {
+			xas_store(&xas, sg_page_iter_page(&sg_iter));
+			if (xas_error(&xas))
+				break;
+			xas_next(&xas);
+			if (!__sg_page_iter_next(&sg_iter))
+				break;
+		}
+		xas_unlock(&xas);
+	} while (xas_nomem(&xas, GFP_KERNEL));
+
+	return xas_error(&xas);
 }
 
 int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 		     int access, struct rxe_mr *mr)
 {
-	struct rxe_map		**map;
-	struct rxe_phys_buf	*buf = NULL;
-	struct ib_umem		*umem;
-	struct sg_page_iter	sg_iter;
-	int			num_buf;
-	void			*vaddr;
+	struct ib_umem *umem;
 	int err;
 
+	rxe_mr_init(access, mr);
+
 	umem = ib_umem_get(&rxe->ib_dev, start, length, access);
 	if (IS_ERR(umem)) {
 		rxe_dbg_mr(mr, "Unable to pin memory region err = %d\n",
 			(int)PTR_ERR(umem));
-		err = PTR_ERR(umem);
-		goto err_out;
+		return PTR_ERR(umem);
 	}
 
-	num_buf = ib_umem_num_pages(umem);
-
-	rxe_mr_init(access, mr);
-
-	err = rxe_mr_alloc(mr, num_buf);
+	err = rxe_mr_fill_pages_from_sgt(mr, &umem->sgt_append.sgt);
 	if (err) {
-		rxe_dbg_mr(mr, "Unable to allocate memory for map\n");
-		goto err_release_umem;
+		ib_umem_release(umem);
+		return err;
 	}
 
-	num_buf			= 0;
-	map = mr->map;
-	if (length > 0) {
-		bool persistent_access = access & IB_ACCESS_FLUSH_PERSISTENT;
-
-		buf = map[0]->buf;
-		for_each_sgtable_page (&umem->sgt_append.sgt, &sg_iter, 0) {
-			struct page *pg = sg_page_iter_page(&sg_iter);
+	mr->umem = umem;
+	mr->ibmr.type = IB_MR_TYPE_USER;
+	mr->state = RXE_MR_STATE_VALID;
 
-			if (persistent_access && !is_pmem_page(pg)) {
-				rxe_dbg_mr(mr, "Unable to register persistent access to non-pmem device\n");
-				err = -EINVAL;
-				goto err_release_umem;
-			}
+	return 0;
+}
 
-			if (num_buf >= RXE_BUF_PER_MAP) {
-				map++;
-				buf = map[0]->buf;
-				num_buf = 0;
-			}
+static int rxe_mr_alloc(struct rxe_mr *mr, int num_buf)
+{
+	XA_STATE(xas, &mr->pages, 0);
+	int i = 0;
+	int err;
 
-			vaddr = page_address(pg);
-			if (!vaddr) {
-				rxe_dbg_mr(mr, "Unable to get virtual address\n");
-				err = -ENOMEM;
-				goto err_release_umem;
-			}
-			buf->addr = (uintptr_t)vaddr;
-			buf->size = mr_page_size(mr);
-			num_buf++;
-			buf++;
+	xa_init(&mr->pages);
 
+	do {
+		xas_lock(&xas);
+		while (i != num_buf) {
+			xas_store(&xas, XA_ZERO_ENTRY);
+			if (xas_error(&xas))
+				break;
+			xas_next(&xas);
+			i++;
 		}
-	}
+		xas_unlock(&xas);
+	} while (xas_nomem(&xas, GFP_KERNEL));
 
-	mr->umem = umem;
-	mr->access = access;
-	mr->page_offset = ib_umem_offset(umem);
-	mr->state = RXE_MR_STATE_VALID;
-	mr->ibmr.type = IB_MR_TYPE_USER;
+	err = xas_error(&xas);
+	if (err)
+		return err;
 
-	return 0;
+	mr->num_buf = num_buf;
 
-err_release_umem:
-	ib_umem_release(umem);
-err_out:
-	return err;
+	return 0;
 }
 
 int rxe_mr_init_fast(int max_pages, struct rxe_mr *mr)
@@ -212,7 +180,6 @@ int rxe_mr_init_fast(int max_pages, struct rxe_mr *mr)
 	if (err)
 		goto err1;
 
-	mr->max_buf = max_pages;
 	mr->state = RXE_MR_STATE_FREE;
 	mr->ibmr.type = IB_MR_TYPE_MEM_REG;
 
@@ -222,116 +189,100 @@ int rxe_mr_init_fast(int max_pages, struct rxe_mr *mr)
 	return err;
 }
 
-static int rxe_set_page(struct ib_mr *ibmr, u64 addr)
+static int rxe_set_page(struct ib_mr *ibmr, u64 iova)
 {
 	struct rxe_mr *mr = to_rmr(ibmr);
-	struct rxe_map *map;
-	struct rxe_phys_buf *buf;
+	struct page *page = virt_to_page(iova & mr->page_mask);
+	XA_STATE(xas, &mr->pages, mr->nbuf);
+	int err;
 
 	if (unlikely(mr->nbuf == mr->num_buf))
 		return -ENOMEM;
 
-	map = mr->map[mr->nbuf / RXE_BUF_PER_MAP];
-	buf = &map->buf[mr->nbuf % RXE_BUF_PER_MAP];
+	do {
+		xas_lock(&xas);
+		xas_store(&xas, page);
+		xas_unlock(&xas);
+	} while (xas_nomem(&xas, GFP_KERNEL));
 
-	buf->addr = addr;
-	buf->size = ibmr->page_size;
-	mr->nbuf++;
+	err = xas_error(&xas);
+	if (err)
+		return err;
 
+	mr->nbuf++;
 	return 0;
 }
 
-int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
+int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sgl,
 		  int sg_nents, unsigned int *sg_offset)
 {
 	struct rxe_mr *mr = to_rmr(ibmr);
 	unsigned int page_size = mr_page_size(mr);
 
+	mr->nbuf = 0;
 	mr->page_shift = ilog2(page_size);
 	mr->page_mask = ~((u64)page_size - 1);
-	mr->page_offset = ibmr->iova & (page_size - 1);
+	mr->page_offset = mr->ibmr.iova & (page_size - 1);
 
-	mr->nbuf = 0;
-
-	return ib_sg_to_pages(ibmr, sg, sg_nents, sg_offset, rxe_set_page);
+	return ib_sg_to_pages(ibmr, sgl, sg_nents, sg_offset, rxe_set_page);
 }
 
-static void lookup_iova(struct rxe_mr *mr, u64 iova, int *m_out, int *n_out,
-			size_t *offset_out)
-{
-	size_t offset = iova - mr->ibmr.iova + mr->page_offset;
-	int			map_index;
-	int			buf_index;
-	u64			length;
-
-	if (likely(mr->page_shift)) {
-		*offset_out = offset & (mr_page_size(mr) - 1);
-		offset >>= mr->page_shift;
-		*n_out = offset & mr->map_mask;
-		*m_out = offset >> mr->map_shift;
-	} else {
-		map_index = 0;
-		buf_index = 0;
-
-		length = mr->map[map_index]->buf[buf_index].size;
-
-		while (offset >= length) {
-			offset -= length;
-			buf_index++;
-
-			if (buf_index == RXE_BUF_PER_MAP) {
-				map_index++;
-				buf_index = 0;
-			}
-			length = mr->map[map_index]->buf[buf_index].size;
-		}
-
-		*m_out = map_index;
-		*n_out = buf_index;
-		*offset_out = offset;
-	}
-}
-
-void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length)
+/*
+ * TODO: Attempting to modify the mr page map between the time
+ * a packet is received and the map is referenced as here
+ * in xa_load(&mr->pages) will cause problems. It is OK to
+ * deregister the mr since the mr reference counts will preserve
+ * it until memory accesses are complete. Currently reregister mr
+ * operations are not supported by the rxe driver but could be
+ * in the future. Invalidate followed by fast_reg mr will change
+ * the map and then the rkey so delayed packets arriving in the
+ * middle could use the wrong map entries. This isn't new but was
+ * already the case in the earlier implementation. This won't be
+ * a problem for well behaved programs which wait until all the
+ * outstanding packets for the first FMR before remapping to the
+ * second.
+ */
+static int rxe_mr_copy_xarray(struct rxe_mr *mr, void *addr,
+			      unsigned long index,
+			      unsigned int page_offset, unsigned int length,
+			      enum rxe_mr_copy_dir dir)
 {
-	size_t offset;
-	int m, n;
-	void *addr;
-
-	if (mr->state != RXE_MR_STATE_VALID) {
-		rxe_dbg_mr(mr, "Not in valid state\n");
-		addr = NULL;
-		goto out;
-	}
-
-	if (!mr->map) {
-		addr = (void *)(uintptr_t)iova;
-		goto out;
-	}
+	struct page *page;
+	unsigned int bytes;
+	void *va;
 
-	if (mr_check_range(mr, iova, length)) {
-		rxe_dbg_mr(mr, "Range violation\n");
-		addr = NULL;
-		goto out;
-	}
-
-	lookup_iova(mr, iova, &m, &n, &offset);
-
-	if (offset + length > mr->map[m]->buf[n].size) {
-		rxe_dbg_mr(mr, "Crosses page boundary\n");
-		addr = NULL;
-		goto out;
+	while (length) {
+		page = xa_load(&mr->pages, index);
+		if (WARN_ON(!page))
+			return -EINVAL;
+
+		bytes = min_t(unsigned int, length,
+				mr_page_size(mr) - page_offset);
+		va = kmap_local_page(page);
+		if (dir == RXE_FROM_MR_OBJ)
+			memcpy(addr, va + page_offset, bytes);
+		else
+			memcpy(va + page_offset, addr, bytes);
+		kunmap_local(va);
+
+		page_offset = 0;
+		addr += bytes;
+		length -= bytes;
+		index++;
 	}
 
-	addr = (void *)(uintptr_t)mr->map[m]->buf[n].addr + offset;
-
-out:
-	return addr;
+	return 0;
 }
 
+// TODO convert iova to va through xarray and then flush
 int rxe_flush_pmem_iova(struct rxe_mr *mr, u64 iova, int length)
 {
-	size_t offset;
+	unsigned int page_offset;
+	unsigned long index;
+	struct page *page;
+	int bytes;
+	int err;
+	u8 *va;
 
 	if (length == 0)
 		return 0;
@@ -339,104 +290,84 @@ int rxe_flush_pmem_iova(struct rxe_mr *mr, u64 iova, int length)
 	if (mr->ibmr.type == IB_MR_TYPE_DMA)
 		return -EFAULT;
 
-	offset = (iova - mr->ibmr.iova + mr->page_offset) & mr->page_mask;
-	while (length > 0) {
-		u8 *va;
-		int bytes;
+	err = mr_check_range(mr, iova, length);
+	if (err)
+		return err;
 
-		bytes = mr->ibmr.page_size - offset;
+	while (length > 0) {
+		page_offset = rxe_mr_iova_to_page_offset(mr, iova);
+		bytes = mr->ibmr.page_size - page_offset;
 		if (bytes > length)
 			bytes = length;
 
-		va = iova_to_vaddr(mr, iova, length);
+		index = rxe_mr_iova_to_index(mr, iova);
+		page = xa_load(&mr->pages, index);
+		if (!page)
+			return -2;
+
+		va = kmap_local_page(page);
 		if (!va)
 			return -EFAULT;
 
-		arch_wb_cache_pmem(va, bytes);
+		arch_wb_cache_pmem(va + page_offset, bytes);
 
 		length -= bytes;
 		iova += bytes;
-		offset = 0;
+		page_offset = 0;
 	}
 
 	return 0;
 }
 
-/* copy data from a range (vaddr, vaddr+length-1) to or from
- * a mr object starting at iova.
- */
+static void rxe_mr_copy_dma(struct rxe_mr *mr, u64 iova, void *addr,
+			    unsigned int page_offset, unsigned int length,
+			    enum rxe_mr_copy_dir dir)
+{
+	unsigned int bytes;
+	struct page *page;
+	u8 *va;
+
+	while (length) {
+		page = virt_to_page(iova & mr->page_mask);
+		va = kmap_local_page(page);
+		bytes = min_t(unsigned int, length, PAGE_SIZE - page_offset);
+
+		if (dir == RXE_TO_MR_OBJ)
+			memcpy(va + page_offset, addr, bytes);
+		else
+			memcpy(addr, va + page_offset, bytes);
+
+		kunmap_local(va);
+		page_offset = 0;
+		iova += bytes;
+		addr += bytes;
+		length -= bytes;
+	}
+}
+
 int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 		enum rxe_mr_copy_dir dir)
 {
-	int			err;
-	int			bytes;
-	u8			*va;
-	struct rxe_map		**map;
-	struct rxe_phys_buf	*buf;
-	int			m;
-	int			i;
-	size_t			offset;
+	unsigned int page_offset;
+	unsigned long index;
+	int err;
 
 	if (length == 0)
 		return 0;
 
 	if (mr->ibmr.type == IB_MR_TYPE_DMA) {
-		u8 *src, *dest;
-
-		src = (dir == RXE_TO_MR_OBJ) ? addr : ((void *)(uintptr_t)iova);
-
-		dest = (dir == RXE_TO_MR_OBJ) ? ((void *)(uintptr_t)iova) : addr;
-
-		memcpy(dest, src, length);
-
+		page_offset = iova & (PAGE_SIZE - 1);
+		rxe_mr_copy_dma(mr, iova, addr, page_offset, length, dir);
 		return 0;
 	}
 
-	WARN_ON_ONCE(!mr->map);
-
 	err = mr_check_range(mr, iova, length);
-	if (err) {
-		err = -EFAULT;
-		goto err1;
-	}
-
-	lookup_iova(mr, iova, &m, &i, &offset);
-
-	map = mr->map + m;
-	buf	= map[0]->buf + i;
-
-	while (length > 0) {
-		u8 *src, *dest;
-
-		va	= (u8 *)(uintptr_t)buf->addr + offset;
-		src = (dir == RXE_TO_MR_OBJ) ? addr : va;
-		dest = (dir == RXE_TO_MR_OBJ) ? va : addr;
-
-		bytes	= buf->size - offset;
-
-		if (bytes > length)
-			bytes = length;
-
-		memcpy(dest, src, bytes);
-
-		length	-= bytes;
-		addr	+= bytes;
-
-		offset	= 0;
-		buf++;
-		i++;
-
-		if (i == RXE_BUF_PER_MAP) {
-			i = 0;
-			map++;
-			buf = map[0]->buf;
-		}
-	}
-
-	return 0;
+	if (err)
+		return err;
 
-err1:
-	return err;
+	page_offset = rxe_mr_iova_to_page_offset(mr, iova);
+	index = rxe_mr_iova_to_index(mr, iova);
+	return rxe_mr_copy_xarray(mr, addr, index, page_offset, length, dir);
 }
 
 /* copy data in or out of a wqe, i.e. sg list
@@ -508,7 +439,6 @@ int copy_data(
 
 		if (bytes > 0) {
 			iova = sge->addr + offset;
-
 			err = rxe_mr_copy(mr, iova, addr, bytes, dir);
 			if (err)
 				goto err2;
@@ -537,20 +467,47 @@ int copy_data(
 
 static DEFINE_SPINLOCK(atomic_ops_lock);
 
+/*
+ * Returns:
+ *	 0	on success
+ *	-1	address is misaligned
+ *	-2	access violations
+ */
 int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
 			u64 compare, u64 swap_add, u64 *orig_val)
 {
-	u64 *vaddr = iova_to_vaddr(mr, iova, sizeof(u64));
+	unsigned int page_offset;
+	struct page *page;
 	u64 value;
+	u64 *va;
 
-	/* needs to match rxe_resp.c */
-	if (mr->state != RXE_MR_STATE_VALID || !vaddr)
-		return -EFAULT;
-	if ((uintptr_t)vaddr & 0x7)
-		return -EINVAL;
+	if (unlikely(mr->state != RXE_MR_STATE_VALID))
+		return -2;
+
+	if (mr->ibmr.type == IB_MR_TYPE_DMA) {
+		page_offset = iova & (PAGE_SIZE - 1);
+		page = virt_to_page(iova & PAGE_MASK);
+	} else {
+		unsigned long index;
+		int err;
+
+		err = mr_check_range(mr, iova, 8);
+		if (err)
+			return err;
+		page_offset = rxe_mr_iova_to_page_offset(mr, iova);
+		index = rxe_mr_iova_to_index(mr, iova);
+		page = xa_load(&mr->pages, index);
+		if (!page)
+			return -2;
+	}
+
+	if (unlikely(page_offset & 0x7))
+		return -1;
+
+	va = kmap_local_page(page);
 
 	spin_lock_bh(&atomic_ops_lock);
-	value = *orig_val = *vaddr;
+	*orig_val = value = va[page_offset >> 3];
 
 	if (opcode == IB_OPCODE_RC_COMPARE_SWAP) {
 		if (value == compare)
@@ -559,9 +516,11 @@ int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
 		value += swap_add;
 	}
 
-	*vaddr = value;
+	va[page_offset >> 3] = value;
 	spin_unlock_bh(&atomic_ops_lock);
 
+	kunmap_local(va);
+
 	return 0;
 }
 
@@ -573,9 +532,11 @@ int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
  */
 int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, void *addr)
 {
-	u64 *vaddr;
-	u64 value;
+	unsigned int page_offset;
+	struct page *page;
 	unsigned int length = 8;
+	u64 value;
+	u64 *va;
 
 	/* See IBA oA19-28 */
 	if (unlikely(mr->state != RXE_MR_STATE_VALID)) {
@@ -583,23 +544,38 @@ int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, void *addr)
 		return -2;
 	}
 
+	if (mr->ibmr.type == IB_MR_TYPE_DMA) {
+		page_offset = iova & (PAGE_SIZE - 1);
+		page = virt_to_page(iova & PAGE_MASK);
+	} else {
+		unsigned long index;
+		int err;
+
+		/* See IBA oA19-28 */
+		err = mr_check_range(mr, iova, length);
+		if (unlikely(err)) {
+			rxe_dbg_mr(mr, "iova out of range");
+			return -2;
+		}
+		page_offset = rxe_mr_iova_to_page_offset(mr, iova);
+		index = rxe_mr_iova_to_index(mr, iova);
+		page = xa_load(&mr->pages, index);
+		if (WARN_ON(!page))
+			return -2;
+	}
+
 	/* See IBA A19.4.2 */
-	if (unlikely((uintptr_t)vaddr & 0x7 || iova & 0x7)) {
+	if (iova & 0x7) {
 		rxe_dbg_mr(mr, "misaligned address");
 		return -1;
 	}
 
-	vaddr = iova_to_vaddr(mr, iova, length);
-	if (unlikely(!vaddr)) {
-		rxe_dbg_mr(mr, "iova out of range");
-		return -2;
-	}
-
-	/* this makes no sense. What of payload is not 8? */
+	va = kmap_local_page(page);
 	memcpy(&value, addr, length);
 
 	/* Do atomic write after all prior operations have completed */
-	smp_store_release(vaddr, value);
+	smp_store_release(&va[page_offset >> 3], value);
+	kunmap_local(va);
 
 	return 0;
 }
@@ -637,12 +613,6 @@ int advance_dma_data(struct rxe_dma_info *dma, unsigned int length)
 	return 0;
 }
 
-/* (1) find the mr corresponding to lkey/rkey
- *     depending on lookup_type
- * (2) verify that the (qp) pd matches the mr pd
- * (3) verify that the mr can support the requested access
- * (4) verify that mr state is valid
- */
 struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
 			 enum rxe_mr_lookup_type type)
 {
@@ -763,15 +733,8 @@ int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 void rxe_mr_cleanup(struct rxe_pool_elem *elem)
 {
 	struct rxe_mr *mr = container_of(elem, typeof(*mr), elem);
-	int i;
 
 	rxe_put(mr_pd(mr));
 	ib_umem_release(mr->umem);
-
-	if (mr->map) {
-		for (i = 0; i < mr->num_map; i++)
-			kfree(mr->map[i]);
-
-		kfree(mr->map);
-	}
+	xa_destroy(&mr->pages);
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index b60404fd33b0..0b8362bca71b 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -744,7 +744,7 @@ static enum resp_states atomic_reply(struct rxe_qp *qp,
 					  atmeth_comp(pkt),
 					  atmeth_swap_add(pkt),
 					  &res->atomic.orig_val);
-		if (err == -EINVAL)
+		if (err == -1)
 			return RESPST_ERR_MISALIGNED_ATOMIC;
 		else if (err)
 			return RESPST_ERR_RKEY_VIOLATION;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index bfc94caaeec5..64551cf354a6 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -283,17 +283,6 @@ enum rxe_mr_lookup_type {
 	RXE_LOOKUP_REMOTE,
 };
 
-#define RXE_BUF_PER_MAP		(PAGE_SIZE / sizeof(struct rxe_phys_buf))
-
-struct rxe_phys_buf {
-	u64      addr;
-	u64      size;
-};
-
-struct rxe_map {
-	struct rxe_phys_buf	buf[RXE_BUF_PER_MAP];
-};
-
 static inline int rkey_is_mw(u32 rkey)
 {
 	u32 index = rkey >> 8;
@@ -311,22 +300,16 @@ struct rxe_mr {
 	u32			rkey;
 	enum rxe_mr_state	state;
 	int			access;
+	atomic_t		num_mw;
 
 	unsigned int		page_offset;
 	unsigned int		page_shift;
 	u64			page_mask;
-	int			map_shift;
-	int			map_mask;
 
 	u32			num_buf;
 	u32			nbuf;
 
-	u32			max_buf;
-	u32			num_map;
-
-	atomic_t		num_mw;
-
-	struct rxe_map		**map;
+	struct xarray		pages;
 };
 
 static inline unsigned int mr_page_size(struct rxe_mr *mr)
-- 
2.37.2

