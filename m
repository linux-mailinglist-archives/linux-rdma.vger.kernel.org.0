Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B96B405E33
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Sep 2021 22:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345629AbhIIUrh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Sep 2021 16:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345651AbhIIUrg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Sep 2021 16:47:36 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFDEC061760
        for <linux-rdma@vger.kernel.org>; Thu,  9 Sep 2021 13:46:24 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id i3-20020a056830210300b0051af5666070so4231309otc.4
        for <linux-rdma@vger.kernel.org>; Thu, 09 Sep 2021 13:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3aM3qq4fHgJda2e5mEZa1bGegbWZ3Tpt2sKvCz8ZwDc=;
        b=oCbY+qtHxAsjdxaRmFV/9w50Kkjqe3M9Gc/0z8Itbd9rm9weHayfV78ma7oMfjyXvF
         eKgaW0qvEPDqfYGl3HIDdQ75DrXzbs+HWbuM7Ri+ISrxu16x05thfgJgC4FQjmL/wYLc
         2h0LMlDkW1tgHaYxKVQ8LDtEz/P6u2vEZg38vcxVU6Tp/1XvYlvZBQ7vpsMPrnhkt5sa
         ubMGRySRHafqw9wAf5H4uvOm2ImiR7jNsl0mTcwruKSOHQDnpwRfMxsw2r2ONkjQuni1
         obY+QvNNrsNuR/pwR8Te/CoSntPnG9zRaOHoibBZ1ECUhXvx4RW2lE+lquLOWYLxzqBa
         rqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3aM3qq4fHgJda2e5mEZa1bGegbWZ3Tpt2sKvCz8ZwDc=;
        b=fUepzYEkB//znXNeMjMdr5bDcvr50eUTUGKoTQTsFhE056qHrsgRdSk0ekr9L1Pvwb
         l0e8cfPK3lM38+mctwyOuFNXEj1w9UUfX9jrVR8ipy4IMFBZ2q3n/Sjp+e6iGxsyOecs
         xmORy715h++Z0mJLqI+a33c7mpcMXEYoY32lUraUazWQat6/mhLxhTcG9A/NfZn9RkEG
         RgeD1QOHlk2z0/USn65zXCKkms2LpmM6XD869ZIU6cguV8nGVZc1h3ZMD+mH/PATV1JN
         FXKVmsFTVoe9Y34NpVXb5Q73PsYfkA5b2WVrU7YmRHiBWMtvP1zoLadufIRNWSYgpYS9
         d16w==
X-Gm-Message-State: AOAM533pM3fJi4a/G2cjPMGK5rCpDnjbQwAHyHmr1icuH3HWgBh204PI
        MIRW+4I7BjUzR09u1dm/7Vk3DHYJfQIfiQ==
X-Google-Smtp-Source: ABdhPJwJjr0UglCywItx+3h+kH17uAVUh8vOlEt0pRwqI6BhPFWHpR+xQ3ZZILXp5EekQUnnTEQhSA==
X-Received: by 2002:a9d:6c04:: with SMTP id f4mr1524847otq.185.1631220384061;
        Thu, 09 Sep 2021 13:46:24 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-a0a5-b98f-837d-887f.res6.spectrum.com. [2603:8081:140c:1a00:a0a5:b98f:837d:887f])
        by smtp.gmail.com with ESMTPSA id i9sm719892otp.18.2021.09.09.13.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 13:46:23 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        mie@igel.co.jp, bvanassche@acm.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-rc v3 5/6] RDMA/rxe: Create duplicate mapping tables for FMRs
Date:   Thu,  9 Sep 2021 15:44:56 -0500
Message-Id: <20210909204456.7476-6-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210909204456.7476-1-rpearsonhpe@gmail.com>
References: <20210909204456.7476-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

For fast memory regions create duplicate mapping tables so
ib_map_mr_sg() can build a new mapping table which is then
swapped into place synchronously with the execution of an IB_WR_REG_MR
work request.

Currently the rxe driver uses the same table for receiving RDMA operations
and for building new tables in preparation for reusing the MR. This
exposes users to potentially incorrect results.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h   |   1 +
 drivers/infiniband/sw/rxe/rxe_mr.c    | 196 +++++++++++++++++---------
 drivers/infiniband/sw/rxe/rxe_mw.c    |   6 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c |  39 ++---
 drivers/infiniband/sw/rxe/rxe_verbs.h |  21 +--
 5 files changed, 161 insertions(+), 102 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 4fd73b51fabf..1ca43b859d80 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -87,6 +87,7 @@ int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length);
 int advance_dma_data(struct rxe_dma_info *dma, unsigned int length);
 int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey);
 int rxe_reg_fast_mr(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
+int rxe_mr_set_page(struct ib_mr *ibmr, u64 addr);
 int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata);
 void rxe_mr_cleanup(struct rxe_pool_entry *arg);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 370212801abc..8d658d42abed 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -24,7 +24,7 @@ u8 rxe_get_next_key(u32 last_key)
 
 int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length)
 {
-
+	struct rxe_map_set *set = mr->cur_map_set;
 
 	switch (mr->type) {
 	case IB_MR_TYPE_DMA:
@@ -32,8 +32,8 @@ int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length)
 
 	case IB_MR_TYPE_USER:
 	case IB_MR_TYPE_MEM_REG:
-		if (iova < mr->iova || length > mr->length ||
-		    iova > mr->iova + mr->length - length)
+		if (iova < set->iova || length > set->length ||
+		    iova > set->iova + set->length - length)
 			return -EFAULT;
 		return 0;
 
@@ -65,41 +65,89 @@ static void rxe_mr_init(int access, struct rxe_mr *mr)
 	mr->map_shift = ilog2(RXE_BUF_PER_MAP);
 }
 
-static int rxe_mr_alloc(struct rxe_mr *mr, int num_buf)
+static void rxe_mr_free_map_set(int num_map, struct rxe_map_set *set)
 {
 	int i;
-	int num_map;
-	struct rxe_map **map = mr->map;
 
-	num_map = (num_buf + RXE_BUF_PER_MAP - 1) / RXE_BUF_PER_MAP;
+	for (i = 0; i < num_map; i++)
+		kfree(set->map[i]);
 
-	mr->map = kmalloc_array(num_map, sizeof(*map), GFP_KERNEL);
-	if (!mr->map)
-		goto err1;
+	kfree(set->map);
+	kfree(set);
+}
+
+static int rxe_mr_alloc_map_set(int num_map, struct rxe_map_set **setp)
+{
+	int i;
+	struct rxe_map_set *set;
+
+	set = kmalloc(sizeof(*set), GFP_KERNEL);
+	if (!set)
+		goto err_out;
+
+	set->map = kmalloc_array(num_map, sizeof(struct rxe_map *), GFP_KERNEL);
+	if (!set->map)
+		goto err_free_set;
 
 	for (i = 0; i < num_map; i++) {
-		mr->map[i] = kmalloc(sizeof(**map), GFP_KERNEL);
-		if (!mr->map[i])
-			goto err2;
+		set->map[i] = kmalloc(sizeof(struct rxe_map), GFP_KERNEL);
+		if (!set->map[i])
+			goto err_free_map;
 	}
 
+	*setp = set;
+
+	return 0;
+
+err_free_map:
+	for (i--; i >= 0; i--)
+		kfree(set->map[i]);
+
+	kfree(set->map);
+err_free_set:
+	kfree(set);
+err_out:
+	return -ENOMEM;
+}
+
+/**
+ * rxe_mr_alloc() - Allocate memory map array(s) for MR
+ * @mr: Memory region
+ * @num_buf: Number of buffer descriptors to support
+ * @both: If non zero allocate both mr->map and mr->next_map
+ *	  else just allocate mr->map. Used for fast MRs
+ *
+ * Return: 0 on success else an error
+ */
+static int rxe_mr_alloc(struct rxe_mr *mr, int num_buf, int both)
+{
+	int ret;
+	int num_map;
+
 	BUILD_BUG_ON(!is_power_of_2(RXE_BUF_PER_MAP));
+	num_map = (num_buf + RXE_BUF_PER_MAP - 1) / RXE_BUF_PER_MAP;
 
 	mr->map_shift = ilog2(RXE_BUF_PER_MAP);
 	mr->map_mask = RXE_BUF_PER_MAP - 1;
-
 	mr->num_buf = num_buf;
-	mr->num_map = num_map;
 	mr->max_buf = num_map * RXE_BUF_PER_MAP;
+	mr->num_map = num_map;
 
-	return 0;
+	ret = rxe_mr_alloc_map_set(num_map, &mr->cur_map_set);
+	if (ret)
+		goto err_out;
 
-err2:
-	for (i--; i >= 0; i--)
-		kfree(mr->map[i]);
+	if (both) {
+		ret = rxe_mr_alloc_map_set(num_map, &mr->next_map_set);
+		if (ret) {
+			rxe_mr_free_map_set(mr->num_map, mr->cur_map_set);
+			goto err_out;
+		}
+	}
 
-	kfree(mr->map);
-err1:
+	return 0;
+
+err_out:
 	return -ENOMEM;
 }
 
@@ -116,6 +164,7 @@ void rxe_mr_init_dma(struct rxe_pd *pd, int access, struct rxe_mr *mr)
 int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 		     int access, struct rxe_mr *mr)
 {
+	struct rxe_map_set	*set;
 	struct rxe_map		**map;
 	struct rxe_phys_buf	*buf = NULL;
 	struct ib_umem		*umem;
@@ -123,7 +172,6 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 	int			num_buf;
 	void			*vaddr;
 	int err;
-	int i;
 
 	umem = ib_umem_get(pd->ibpd.device, start, length, access);
 	if (IS_ERR(umem)) {
@@ -137,18 +185,20 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 
 	rxe_mr_init(access, mr);
 
-	err = rxe_mr_alloc(mr, num_buf);
+	err = rxe_mr_alloc(mr, num_buf, 0);
 	if (err) {
 		pr_warn("%s: Unable to allocate memory for map\n",
 				__func__);
 		goto err_release_umem;
 	}
 
-	mr->page_shift = PAGE_SHIFT;
-	mr->page_mask = PAGE_SIZE - 1;
+	set = mr->cur_map_set;
+	set->page_shift = PAGE_SHIFT;
+	set->page_mask = PAGE_SIZE - 1;
+
+	num_buf = 0;
+	map = set->map;
 
-	num_buf			= 0;
-	map = mr->map;
 	if (length > 0) {
 		buf = map[0]->buf;
 
@@ -171,26 +221,24 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 			buf->size = PAGE_SIZE;
 			num_buf++;
 			buf++;
-
 		}
 	}
 
 	mr->ibmr.pd = &pd->ibpd;
 	mr->umem = umem;
 	mr->access = access;
-	mr->length = length;
-	mr->iova = iova;
-	mr->va = start;
-	mr->offset = ib_umem_offset(umem);
 	mr->state = RXE_MR_STATE_VALID;
 	mr->type = IB_MR_TYPE_USER;
 
+	set->length = length;
+	set->iova = iova;
+	set->va = start;
+	set->offset = ib_umem_offset(umem);
+
 	return 0;
 
 err_cleanup_map:
-	for (i = 0; i < mr->num_map; i++)
-		kfree(mr->map[i]);
-	kfree(mr->map);
+	rxe_mr_free_map_set(mr->num_map, mr->cur_map_set);
 err_release_umem:
 	ib_umem_release(umem);
 err_out:
@@ -204,7 +252,7 @@ int rxe_mr_init_fast(struct rxe_pd *pd, int max_pages, struct rxe_mr *mr)
 	/* always allow remote access for FMRs */
 	rxe_mr_init(IB_ACCESS_REMOTE, mr);
 
-	err = rxe_mr_alloc(mr, max_pages);
+	err = rxe_mr_alloc(mr, max_pages, 1);
 	if (err)
 		goto err1;
 
@@ -222,21 +270,24 @@ int rxe_mr_init_fast(struct rxe_pd *pd, int max_pages, struct rxe_mr *mr)
 static void lookup_iova(struct rxe_mr *mr, u64 iova, int *m_out, int *n_out,
 			size_t *offset_out)
 {
-	size_t offset = iova - mr->iova + mr->offset;
+	struct rxe_map_set *set = mr->cur_map_set;
+	size_t offset = iova - set->iova + set->offset;
 	int			map_index;
 	int			buf_index;
 	u64			length;
+	struct rxe_map *map;
 
-	if (likely(mr->page_shift)) {
-		*offset_out = offset & mr->page_mask;
-		offset >>= mr->page_shift;
+	if (likely(set->page_shift)) {
+		*offset_out = offset & set->page_mask;
+		offset >>= set->page_shift;
 		*n_out = offset & mr->map_mask;
 		*m_out = offset >> mr->map_shift;
 	} else {
 		map_index = 0;
 		buf_index = 0;
 
-		length = mr->map[map_index]->buf[buf_index].size;
+		map = set->map[map_index];
+		length = map->buf[buf_index].size;
 
 		while (offset >= length) {
 			offset -= length;
@@ -246,7 +297,8 @@ static void lookup_iova(struct rxe_mr *mr, u64 iova, int *m_out, int *n_out,
 				map_index++;
 				buf_index = 0;
 			}
-			length = mr->map[map_index]->buf[buf_index].size;
+			map = set->map[map_index];
+			length = map->buf[buf_index].size;
 		}
 
 		*m_out = map_index;
@@ -267,7 +319,7 @@ void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length)
 		goto out;
 	}
 
-	if (!mr->map) {
+	if (!mr->cur_map_set) {
 		addr = (void *)(uintptr_t)iova;
 		goto out;
 	}
@@ -280,13 +332,13 @@ void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length)
 
 	lookup_iova(mr, iova, &m, &n, &offset);
 
-	if (offset + length > mr->map[m]->buf[n].size) {
+	if (offset + length > mr->cur_map_set->map[m]->buf[n].size) {
 		pr_warn("crosses page boundary\n");
 		addr = NULL;
 		goto out;
 	}
 
-	addr = (void *)(uintptr_t)mr->map[m]->buf[n].addr + offset;
+	addr = (void *)(uintptr_t)mr->cur_map_set->map[m]->buf[n].addr + offset;
 
 out:
 	return addr;
@@ -322,7 +374,7 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 		return 0;
 	}
 
-	WARN_ON_ONCE(!mr->map);
+	WARN_ON_ONCE(!mr->cur_map_set);
 
 	err = mr_check_range(mr, iova, length);
 	if (err) {
@@ -332,7 +384,7 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 
 	lookup_iova(mr, iova, &m, &i, &offset);
 
-	map = mr->map + m;
+	map = mr->cur_map_set->map + m;
 	buf	= map[0]->buf + i;
 
 	while (length > 0) {
@@ -572,8 +624,9 @@ int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey)
 int rxe_reg_fast_mr(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 {
 	struct rxe_mr *mr = to_rmr(wqe->wr.wr.reg.mr);
-	u32 key = wqe->wr.wr.reg.key;
+	u32 key = wqe->wr.wr.reg.key & 0xff;
 	u32 access = wqe->wr.wr.reg.access;
+	struct rxe_map_set *set;
 
 	/* user can only register MR in free state */
 	if (unlikely(mr->state != RXE_MR_STATE_FREE)) {
@@ -589,19 +642,36 @@ int rxe_reg_fast_mr(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 		return -EINVAL;
 	}
 
-	/* user is only allowed to change key portion of l/rkey */
-	if (unlikely((mr->lkey & ~0xff) != (key & ~0xff))) {
-		pr_warn("%s: key = 0x%x has wrong index mr->lkey = 0x%x\n",
-			__func__, key, mr->lkey);
-		return -EINVAL;
-	}
-
 	mr->access = access;
-	mr->lkey = key;
-	mr->rkey = (access & IB_ACCESS_REMOTE) ? key : 0;
-	mr->iova = wqe->wr.wr.reg.mr->iova;
+	mr->lkey = (mr->lkey & ~0xff) | key;
+	mr->rkey = (access & IB_ACCESS_REMOTE) ? mr->lkey : 0;
 	mr->state = RXE_MR_STATE_VALID;
 
+	set = mr->cur_map_set;
+	mr->cur_map_set = mr->next_map_set;
+	mr->cur_map_set->iova = wqe->wr.wr.reg.mr->iova;
+	mr->next_map_set = set;
+
+	return 0;
+}
+
+int rxe_mr_set_page(struct ib_mr *ibmr, u64 addr)
+{
+	struct rxe_mr *mr = to_rmr(ibmr);
+	struct rxe_map_set *set = mr->next_map_set;
+	struct rxe_map *map;
+	struct rxe_phys_buf *buf;
+
+	if (unlikely(set->nbuf == mr->num_buf))
+		return -ENOMEM;
+
+	map = set->map[set->nbuf / RXE_BUF_PER_MAP];
+	buf = &map->buf[set->nbuf % RXE_BUF_PER_MAP];
+
+	buf->addr = addr;
+	buf->size = ibmr->page_size;
+	set->nbuf++;
+
 	return 0;
 }
 
@@ -626,14 +696,12 @@ int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 void rxe_mr_cleanup(struct rxe_pool_entry *arg)
 {
 	struct rxe_mr *mr = container_of(arg, typeof(*mr), pelem);
-	int i;
 
 	ib_umem_release(mr->umem);
 
-	if (mr->map) {
-		for (i = 0; i < mr->num_map; i++)
-			kfree(mr->map[i]);
+	if (mr->cur_map_set)
+		rxe_mr_free_map_set(mr->num_map, mr->cur_map_set);
 
-		kfree(mr->map);
-	}
+	if (mr->next_map_set)
+		rxe_mr_free_map_set(mr->num_map, mr->next_map_set);
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index a5e2ea7d80f0..9534a7fe1a98 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -142,15 +142,15 @@ static int rxe_check_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 
 	/* C10-75 */
 	if (mw->access & IB_ZERO_BASED) {
-		if (unlikely(wqe->wr.wr.mw.length > mr->length)) {
+		if (unlikely(wqe->wr.wr.mw.length > mr->cur_map_set->length)) {
 			pr_err_once(
 				"attempt to bind a ZB MW outside of the MR\n");
 			return -EINVAL;
 		}
 	} else {
-		if (unlikely((wqe->wr.wr.mw.addr < mr->iova) ||
+		if (unlikely((wqe->wr.wr.mw.addr < mr->cur_map_set->iova) ||
 			     ((wqe->wr.wr.mw.addr + wqe->wr.wr.mw.length) >
-			      (mr->iova + mr->length)))) {
+			      (mr->cur_map_set->iova + mr->cur_map_set->length)))) {
 			pr_err_once(
 				"attempt to bind a VA MW outside of the MR\n");
 			return -EINVAL;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index dc70e3edeba6..e7f482184359 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -954,41 +954,26 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 	return ERR_PTR(err);
 }
 
-static int rxe_set_page(struct ib_mr *ibmr, u64 addr)
-{
-	struct rxe_mr *mr = to_rmr(ibmr);
-	struct rxe_map *map;
-	struct rxe_phys_buf *buf;
-
-	if (unlikely(mr->nbuf == mr->num_buf))
-		return -ENOMEM;
-
-	map = mr->map[mr->nbuf / RXE_BUF_PER_MAP];
-	buf = &map->buf[mr->nbuf % RXE_BUF_PER_MAP];
-
-	buf->addr = addr;
-	buf->size = ibmr->page_size;
-	mr->nbuf++;
-
-	return 0;
-}
-
+/* build next_map_set from scatterlist
+ * The IB_WR_REG_MR WR will swap map_sets
+ */
 static int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
 			 int sg_nents, unsigned int *sg_offset)
 {
 	struct rxe_mr *mr = to_rmr(ibmr);
+	struct rxe_map_set *set = mr->next_map_set;
 	int n;
 
-	mr->nbuf = 0;
+	set->nbuf = 0;
 
-	n = ib_sg_to_pages(ibmr, sg, sg_nents, sg_offset, rxe_set_page);
+	n = ib_sg_to_pages(ibmr, sg, sg_nents, sg_offset, rxe_mr_set_page);
 
-	mr->va = ibmr->iova;
-	mr->iova = ibmr->iova;
-	mr->length = ibmr->length;
-	mr->page_shift = ilog2(ibmr->page_size);
-	mr->page_mask = ibmr->page_size - 1;
-	mr->offset = mr->iova & mr->page_mask;
+	set->va = ibmr->iova;
+	set->iova = ibmr->iova;
+	set->length = ibmr->length;
+	set->page_shift = ilog2(ibmr->page_size);
+	set->page_mask = ibmr->page_size - 1;
+	set->offset = set->iova & set->page_mask;
 
 	return n;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 31c38b2f7d0a..9eabc8f30359 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -293,6 +293,17 @@ struct rxe_map {
 	struct rxe_phys_buf	buf[RXE_BUF_PER_MAP];
 };
 
+struct rxe_map_set {
+	struct rxe_map		**map;
+	u64			va;
+	u64			iova;
+	size_t			length;
+	u32			offset;
+	u32			nbuf;
+	int			page_shift;
+	int			page_mask;
+};
+
 static inline int rkey_is_mw(u32 rkey)
 {
 	u32 index = rkey >> 8;
@@ -310,26 +321,20 @@ struct rxe_mr {
 	u32			rkey;
 	enum rxe_mr_state	state;
 	enum ib_mr_type		type;
-	u64			va;
-	u64			iova;
-	size_t			length;
-	u32			offset;
 	int			access;
 
-	int			page_shift;
-	int			page_mask;
 	int			map_shift;
 	int			map_mask;
 
 	u32			num_buf;
-	u32			nbuf;
 
 	u32			max_buf;
 	u32			num_map;
 
 	atomic_t		num_mw;
 
-	struct rxe_map		**map;
+	struct rxe_map_set	*cur_map_set;
+	struct rxe_map_set	*next_map_set;
 };
 
 enum rxe_mw_state {
-- 
2.30.2

