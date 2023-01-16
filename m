Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0445466D37E
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jan 2023 00:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235307AbjAPX7P (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Jan 2023 18:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235699AbjAPX6q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Jan 2023 18:58:46 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3418822DE5
        for <linux-rdma@vger.kernel.org>; Mon, 16 Jan 2023 15:56:56 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id f88-20020a9d03e1000000b00684c4041ff1so7273746otf.8
        for <linux-rdma@vger.kernel.org>; Mon, 16 Jan 2023 15:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/Cet/USgSJJRLucLnh5Osrr/lhc9Pi9WyS4f2LbIqg=;
        b=qY+8KaSUhftTcLRthY+Q0vrUdkRvi5dyoMBJwsP7GrrEj3vtiB1axkvB2cCzTmPoTy
         H81hS9+uIwmzYN3PXxGDh8yt5t+FMsUq0wdOf0i6ft9RVh/Oq7wKnwBVajQdTA2B3vC6
         Of3RWq3mdMSHWhqAYVtGIm389h9TcHJJOh6tL7GC2nNvXzVL6KSvUharzdSH7kPByEpv
         1AXF+x5+s4oDMhboTmXu1CdvB9d2Wyo1Cp/qXaaOcnEVym4u5n1aluVxZ3mBCcDTAZJI
         VMrbaRc4U+vrahiMG2Cz0sXiAMsnUfHy3Aqt6DuCzNAS3O/dfILltJ+GnsqBH9R0bBUd
         AdqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b/Cet/USgSJJRLucLnh5Osrr/lhc9Pi9WyS4f2LbIqg=;
        b=0EYpjB8Zdw6XS7iHRDTzo/LXsYhPc+5cgksFRPKx2IBZPko7yDoHaMm1CPpOQC3/2d
         pioemJ1UEIXZiIOQP2/zA1ZXy+FcHrGBzMB/u0skP1EP5kVcWVzu3qyzdCKyMQ4ztqAs
         f+y9B98+Iu11ShvDvzplb7ZcIRnQuRro05hk1yb4KsgnE1BBZ6NB4cHGoSaAKbdyg+V1
         KZzv5Jd/yemJ7CrYaP4tcDhEVL2iwH4kXCOYinpVp4ib/E791Xi9Aq+W6gbYciIdz6YM
         9nNxmJ9OqAmFkGxjJruTPBFBOll/8bjUbxq1hKTczmWZghpfH8RpU6L6UerAcAcsdoO2
         AVrw==
X-Gm-Message-State: AFqh2kqFBvikl3hJ6AviH/STdRiXyvIFMXAYxfo2p5woXVd8jP+KhzBB
        IGGGXXXbfeMdNapKHss0+BrjJasGldszPg==
X-Google-Smtp-Source: AMrXdXspkjE6Lp+X46Jv7ksAaX+V03LwabCcz2qnLzsmVIQxcXFsjt6cYME2L2+qymF0evgoWjQe0Q==
X-Received: by 2002:a9d:6f88:0:b0:670:5e21:70f0 with SMTP id h8-20020a9d6f88000000b006705e2170f0mr463949otq.22.1673913413942;
        Mon, 16 Jan 2023 15:56:53 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-ea18-3ee9-26d1-7526.res6.spectrum.com. [2603:8081:140c:1a00:ea18:3ee9:26d1:7526])
        by smtp.gmail.com with ESMTPSA id w17-20020a9d77d1000000b00684e55f4541sm3540546otl.70.2023.01.16.15.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 15:56:53 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, leonro@nvidia.com,
        yangx.jy@fujitsu.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v5 6/6] RDMA/rxe: Replace rxe_map and rxe_phys_buf by xarray
Date:   Mon, 16 Jan 2023 17:56:03 -0600
Message-Id: <20230116235602.22899-7-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230116235602.22899-1-rpearsonhpe@gmail.com>
References: <20230116235602.22899-1-rpearsonhpe@gmail.com>
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
v5:
  link: https://lore.kernel.org/linux-rdma/c03afa55-c2f2-5949-289a-4411bdba87f9@fujitsu.com/
  Responded to a note from lizhijian@fujitsu.com and restored calls to
  is_pmem_page() which were accidentally dropped in earlier versions.

 drivers/infiniband/sw/rxe/rxe_loc.h   |   8 +-
 drivers/infiniband/sw/rxe/rxe_mr.c    | 559 +++++++++++++-------------
 drivers/infiniband/sw/rxe/rxe_verbs.h |  21 +-
 3 files changed, 285 insertions(+), 303 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index b1dda0cf891b..c1f78ed0f991 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -64,14 +64,14 @@ void rxe_mr_init_dma(int access, struct rxe_mr *mr);
 int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 		     int access, struct rxe_mr *mr);
 int rxe_mr_init_fast(int max_pages, struct rxe_mr *mr);
-int rxe_flush_pmem_iova(struct rxe_mr *mr, u64 iova, int length);
-int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
-		enum rxe_mr_copy_dir dir);
+int rxe_flush_pmem_iova(struct rxe_mr *mr, u64 iova,
+			unsigned int length);
+int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr,
+		unsigned int length, enum rxe_mr_copy_dir dir);
 int copy_data(struct rxe_pd *pd, int access, struct rxe_dma_info *dma,
 	      void *addr, int length, enum rxe_mr_copy_dir dir);
 int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
 		  int sg_nents, unsigned int *sg_offset);
-void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length);
 int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
 			u64 compare, u64 swap_add, u64 *orig_val);
 int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value);
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index fdf76df4cf3e..a495c186dc3c 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -62,60 +62,31 @@ static void rxe_mr_init(int access, struct rxe_mr *mr)
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
 
+static unsigned long rxe_mr_iova_to_index(struct rxe_mr *mr, u64 iova)
+{
+	return (iova >> mr->page_shift) - (mr->ibmr.iova >> mr->page_shift);
+}
+
+static unsigned long rxe_mr_iova_to_page_offset(struct rxe_mr *mr, u64 iova)
+{
+	return iova & (mr_page_size(mr) - 1);
+}
+
 static bool is_pmem_page(struct page *pg)
 {
 	unsigned long paddr = page_to_phys(pg);
@@ -125,82 +96,97 @@ static bool is_pmem_page(struct page *pg)
 				 IORES_DESC_PERSISTENT_MEMORY);
 }
 
+static int rxe_mr_fill_pages_from_sgt(struct rxe_mr *mr, struct sg_table *sgt)
+{
+	XA_STATE(xas, &mr->page_list, 0);
+	struct sg_page_iter sg_iter;
+	struct page *page;
+	bool persistent = !!(mr->access & IB_ACCESS_FLUSH_PERSISTENT);
+
+	__sg_page_iter_start(&sg_iter, sgt->sgl, sgt->orig_nents, 0);
+	if (!__sg_page_iter_next(&sg_iter))
+		return 0;
+
+	do {
+		xas_lock(&xas);
+		while (true) {
+			page = sg_page_iter_page(&sg_iter);
+
+			if (persistent && !is_pmem_page(page)) {
+				rxe_dbg_mr(mr, "Unable to register persistent access to non-pmem device\n");
+				return -EINVAL;
+			}
+
+			xas_store(&xas, page);
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
+}
+
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
+	xa_init(&mr->page_list);
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
+	XA_STATE(xas, &mr->page_list, 0);
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
+	xa_init(&mr->page_list);
 
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
@@ -214,7 +200,6 @@ int rxe_mr_init_fast(int max_pages, struct rxe_mr *mr)
 	if (err)
 		goto err1;
 
-	mr->max_buf = max_pages;
 	mr->state = RXE_MR_STATE_FREE;
 	mr->ibmr.type = IB_MR_TYPE_MEM_REG;
 
@@ -224,206 +209,144 @@ int rxe_mr_init_fast(int max_pages, struct rxe_mr *mr)
 	return err;
 }
 
-static int rxe_set_page(struct ib_mr *ibmr, u64 addr)
+static int rxe_set_page(struct ib_mr *ibmr, u64 iova)
 {
 	struct rxe_mr *mr = to_rmr(ibmr);
-	struct rxe_map *map;
-	struct rxe_phys_buf *buf;
+	struct page *page = virt_to_page(iova & mr->page_mask);
+	XA_STATE(xas, &mr->page_list, mr->nbuf);
+	bool persistent = !!(mr->access & IB_ACCESS_FLUSH_PERSISTENT);
+	int err;
+
+	if (persistent && !is_pmem_page(page)) {
+		rxe_dbg_mr(mr, "Unable to register persistent access to non-pmem device\n");
+		return -EINVAL;
+	}
 
 	if (unlikely(mr->nbuf == mr->num_buf))
 		return -ENOMEM;
 
-	map = mr->map[mr->nbuf / RXE_BUF_PER_MAP];
-	buf = &map->buf[mr->nbuf % RXE_BUF_PER_MAP];
+	do {
+		xas_lock(&xas);
+		xas_store(&xas, page);
+		xas_unlock(&xas);
+	} while (xas_nomem(&xas, GFP_KERNEL));
+
+	err = xas_error(&xas);
+	if (err)
+		return err;
 
-	buf->addr = addr;
-	buf->size = ibmr->page_size;
 	mr->nbuf++;
-
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
-
-	mr->nbuf = 0;
+	mr->page_offset = mr->ibmr.iova & (page_size - 1);
 
-	return ib_sg_to_pages(ibmr, sg, sg_nents, sg_offset, rxe_set_page);
+	return ib_sg_to_pages(ibmr, sgl, sg_nents, sg_offset, rxe_set_page);
 }
 
-static void lookup_iova(struct rxe_mr *mr, u64 iova, int *m_out, int *n_out,
-			size_t *offset_out)
+/*
+ * TODO: Attempting to modify the mr page map between the time
+ * a packet is received and the map is referenced as here
+ * in xa_load(&mr->page_list) will cause problems. It is OK to
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
+static int rxe_mr_copy_xarray(struct rxe_mr *mr, u64 iova, void *addr,
+			      unsigned int length, enum rxe_mr_copy_dir dir)
 {
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
+	unsigned int page_offset = rxe_mr_iova_to_page_offset(mr, iova);
+	unsigned long index = rxe_mr_iova_to_index(mr, iova);
+	unsigned int bytes;
+	struct page *page;
+	void *va;
 
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
+	while (length) {
+		page = xa_load(&mr->page_list, index);
+		if (!page)
+			return -EFAULT;
 
-		*m_out = map_index;
-		*n_out = buf_index;
-		*offset_out = offset;
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
-}
-
-void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length)
-{
-	size_t offset;
-	int m, n;
-
-	if (mr->state != RXE_MR_STATE_VALID)
-		return NULL;
-
-	if (mr->ibmr.type == IB_MR_TYPE_DMA)
-		return (void *)(uintptr_t)iova;
-
-	if (mr_check_range(mr, iova, length))
-		return NULL;
-
-	lookup_iova(mr, iova, &m, &n, &offset);
-
-	if (offset + length > mr->map[m]->buf[n].size)
-		return NULL;
 
-	return (void *)(uintptr_t)mr->map[m]->buf[n].addr + offset;
+	return 0;
 }
 
-int rxe_flush_pmem_iova(struct rxe_mr *mr, u64 iova, int length)
+static void rxe_mr_copy_dma(struct rxe_mr *mr, u64 iova, void *addr,
+			    unsigned int length, enum rxe_mr_copy_dir dir)
 {
-	size_t offset;
-
-	if (length == 0)
-		return 0;
-
-	if (mr->ibmr.type == IB_MR_TYPE_DMA)
-		return -EFAULT;
-
-	offset = (iova - mr->ibmr.iova + mr->page_offset) & mr->page_mask;
-	while (length > 0) {
-		u8 *va;
-		int bytes;
-
-		bytes = mr->ibmr.page_size - offset;
-		if (bytes > length)
-			bytes = length;
-
-		va = iova_to_vaddr(mr, iova, length);
-		if (!va)
-			return -EFAULT;
+	unsigned int page_offset = iova & (PAGE_SIZE - 1);
+	unsigned int bytes;
+	struct page *page;
+	u8 *va;
 
-		arch_wb_cache_pmem(va, bytes);
-
-		length -= bytes;
+	while (length) {
+		page = virt_to_page(iova & mr->page_mask);
+		bytes = min_t(unsigned int, length,
+				PAGE_SIZE - page_offset);
+		va = kmap_local_page(page);
+
+		if (dir == RXE_TO_MR_OBJ)
+			memcpy(va + page_offset, addr, bytes);
+		else
+			memcpy(addr, va + page_offset, bytes);
+
+		kunmap_local(va);
+		page_offset = 0;
 		iova += bytes;
-		offset = 0;
+		addr += bytes;
+		length -= bytes;
 	}
-
-	return 0;
 }
 
-/* copy data from a range (vaddr, vaddr+length-1) to or from
- * a mr object starting at iova.
- */
-int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
-		enum rxe_mr_copy_dir dir)
+int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr,
+		unsigned int length, enum rxe_mr_copy_dir dir)
 {
-	int			err;
-	int			bytes;
-	u8			*va;
-	struct rxe_map		**map;
-	struct rxe_phys_buf	*buf;
-	int			m;
-	int			i;
-	size_t			offset;
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
+		rxe_mr_copy_dma(mr, iova, addr, length, dir);
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
+	if (unlikely(err)) {
+		rxe_dbg_mr(mr, "iova out of range");
+		return err;
 	}
 
-	return 0;
-
-err1:
-	return err;
+	return rxe_mr_copy_xarray(mr, iova, addr, length, dir);
 }
 
 /* copy data in or out of a wqe, i.e. sg list
@@ -495,7 +418,6 @@ int copy_data(
 
 		if (bytes > 0) {
 			iova = sge->addr + offset;
-
 			err = rxe_mr_copy(mr, iova, addr, bytes, dir);
 			if (err)
 				goto err2;
@@ -522,43 +444,104 @@ int copy_data(
 	return err;
 }
 
+int rxe_flush_pmem_iova(struct rxe_mr *mr, u64 iova, unsigned int length)
+{
+	unsigned int page_offset;
+	unsigned long index;
+	struct page *page;
+	unsigned int bytes;
+	int err;
+	u8 *va;
+
+	if (length == 0)
+		return 0;
+
+	if (mr->ibmr.type == IB_MR_TYPE_DMA)
+		return -EFAULT;
+
+	err = mr_check_range(mr, iova, length);
+	if (err)
+		return err;
+
+	while (length > 0) {
+		index = rxe_mr_iova_to_index(mr, iova);
+		page = xa_load(&mr->page_list, index);
+		page_offset = rxe_mr_iova_to_page_offset(mr, iova);
+		if (!page)
+			return -EFAULT;
+		bytes = min_t(unsigned int, length,
+				mr_page_size(mr) - page_offset);
+
+		va = kmap_local_page(page);
+		if (!va)
+			return -EFAULT;
+
+		arch_wb_cache_pmem(va + page_offset, bytes);
+
+		length -= bytes;
+		iova += bytes;
+		page_offset = 0;
+	}
+
+	return 0;
+}
+
 /* Guarantee atomicity of atomic operations at the machine level. */
 static DEFINE_SPINLOCK(atomic_ops_lock);
 
 int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
 			u64 compare, u64 swap_add, u64 *orig_val)
 {
-	u64 *va;
+	unsigned int page_offset;
+	struct page *page;
 	u64 value;
+	u64 *va;
 
-	if (mr->state != RXE_MR_STATE_VALID) {
+	if (unlikely(mr->state != RXE_MR_STATE_VALID)) {
 		rxe_dbg_mr(mr, "mr not in valid state");
 		return -EINVAL;
 	}
 
-	va = iova_to_vaddr(mr, iova, sizeof(u64));
-	if (!va) {
-		rxe_dbg_mr(mr, "iova out of range");
-		return -ERANGE;
+	if (mr->ibmr.type == IB_MR_TYPE_DMA) {
+		page_offset = iova & (PAGE_SIZE - 1);
+		page = virt_to_page(iova & PAGE_MASK);
+	} else {
+		unsigned long index;
+		int err;
+
+		err = mr_check_range(mr, iova, sizeof(value));
+		if (err) {
+			rxe_dbg_mr(mr, "iova out of range");
+			return -ERANGE;
+		}
+		page_offset = rxe_mr_iova_to_page_offset(mr, iova);
+		index = rxe_mr_iova_to_index(mr, iova);
+		page = xa_load(&mr->page_list, index);
+		if (!page)
+			return -EFAULT;
 	}
 
-	if ((uintptr_t)va & 0x7) {
+	if (unlikely(page_offset & 0x7)) {
 		rxe_dbg_mr(mr, "iova not aligned");
-		return RXE_ERR_NOT_ALIGNED;
+		return -RXE_ERR_NOT_ALIGNED;
 	}
 
+	va = kmap_local_page(page);
+
 	spin_lock_bh(&atomic_ops_lock);
-	value = *orig_val = *va;
+	value = *orig_val = va[page_offset >> 3];
 
 	if (opcode == IB_OPCODE_RC_COMPARE_SWAP) {
 		if (value == compare)
-			*va = swap_add;
+			va[page_offset >> 3] = swap_add;
 	} else {
 		value += swap_add;
-		*va = value;
+		va[page_offset >> 3] = value;
 	}
 	spin_unlock_bh(&atomic_ops_lock);
 
+	kunmap_local(va);
+
 	return 0;
 }
 
@@ -566,6 +549,8 @@ int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
 int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
 {
 #if defined CONFIG_64BIT
+	unsigned int page_offset;
+	struct page *page;
 	u64 *va;
 
 	/* See IBA oA19-28 */
@@ -574,20 +559,45 @@ int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
 		return -EINVAL;
 	}
 
-	va = iova_to_vaddr(mr, iova, sizeof(value));
-	if (unlikely(!va)) {
-		rxe_dbg_mr(mr, "iova out of range");
-		return -ERANGE;
+	if (mr->ibmr.type == IB_MR_TYPE_DMA) {
+		page_offset = iova & (PAGE_SIZE - 1);
+		page = virt_to_page(iova & PAGE_MASK);
+	} else {
+		unsigned long index;
+		int err;
+
+		/* See IBA oA19-28 */
+		err = mr_check_range(mr, iova, sizeof(value));
+		if (unlikely(err)) {
+			rxe_dbg_mr(mr, "iova out of range");
+			return -ERANGE;
+		}
+		page_offset = rxe_mr_iova_to_page_offset(mr, iova);
+		index = rxe_mr_iova_to_index(mr, iova);
+		page = xa_load(&mr->page_list, index);
+		if (!page)
+			return -EFAULT;
 	}
 
 	/* See IBA A19.4.2 */
-	if (unlikely((uintptr_t)va & 0x7 || iova & 0x7)) {
+	if (unlikely(page_offset & 0x7)) {
 		rxe_dbg_mr(mr, "misaligned address");
 		return -RXE_ERR_NOT_ALIGNED;
 	}
 
+	va = kmap_local_page(page);
+
 	/* Do atomic write after all prior operations have completed */
-	smp_store_release(va, value);
+	/* TODO: This is what was chosen by the implementer but I am
+	 * concerned it isn't what they want. This only guarantees that
+	 * the write will complete before any subsequent reads but the
+	 * comment says all prior operations have completed. That would
+	 * require a full me matching acquire.
+	 * Normal usage has a matching load_acquire and store release.
+	 */
+	smp_store_release(&va[page_offset >> 3], value);
+
+	kunmap_local(va);
 
 	return 0;
 #else
@@ -629,12 +639,6 @@ int advance_dma_data(struct rxe_dma_info *dma, unsigned int length)
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
@@ -755,15 +759,10 @@ int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 void rxe_mr_cleanup(struct rxe_pool_elem *elem)
 {
 	struct rxe_mr *mr = container_of(elem, typeof(*mr), elem);
-	int i;
 
 	rxe_put(mr_pd(mr));
 	ib_umem_release(mr->umem);
 
-	if (mr->map) {
-		for (i = 0; i < mr->num_map; i++)
-			kfree(mr->map[i]);
-
-		kfree(mr->map);
-	}
+	if (mr->ibmr.type != IB_MR_TYPE_DMA)
+		xa_destroy(&mr->page_list);
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 5c3d1500ca68..09437077ceee 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -288,17 +288,6 @@ enum rxe_mr_lookup_type {
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
@@ -316,22 +305,16 @@ struct rxe_mr {
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
+	struct xarray		page_list;
 };
 
 static inline unsigned int mr_page_size(struct rxe_mr *mr)
-- 
2.37.2

