Return-Path: <linux-rdma+bounces-18681-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPgJFevDxGmu3QQAu9opvQ
	(envelope-from <linux-rdma+bounces-18681-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 06:28:11 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D1732F629
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 06:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 81977303D8A4
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 05:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4644234AB0B;
	Thu, 26 Mar 2026 05:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AMuaBs++"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E141359A9F
	for <linux-rdma@vger.kernel.org>; Thu, 26 Mar 2026 05:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774502885; cv=none; b=QcsVJnZpxSOa9rKGTkVwpGCnM5f530E9BwZ/UJ664dFi73GRT2bcUVpsczocQBHDVIfK1OVBRZGPFG37NLk6OzVZ29bnBl1rij45QLQ1Inbkb6a9JWYUDHVXqAsYTUA8lba3hoaEoUb+uAtIF6IdRP8wGIImard+TDocrSUeR9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774502885; c=relaxed/simple;
	bh=fmPTGYiEPt+UdgS8YPTQYYaWAW4xFvDk8PdqmSMaE/k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=apNENiB2xrHHWgnY4ngu+WxKEpgU/LV/vEDddfXFglDGfSw+BbAvxn2b5DOYoY0uDQ34WMtvSu81yUna0hJGBcYRC5UjMBtRCwznbPV39/KgCcsSv7u3gxDFYq3iUX6V/hSMetMXDSB56ods1MKRdiB4rpY4hoGTtaNosO8pqSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AMuaBs++; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774502881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aKN6xJzlfQb6gMHtCDP2A7igZWXeagg60DlPBkjK20w=;
	b=AMuaBs++BdOcpKkceI89Dc1wz8o0yrNq10g4kRAnE3YKVEpMxkJPSaqcfCkplRZLTa69zG
	CM2d8TvRk+ddrY64SYfCdk64rl4brwgXNxTQ02oieu/vqeNOiqkbkwE4PYlyz/QU57MGmp
	p3fAMuZsV8GqJ0w6JW6VaVcgQymrGFU=
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: jgg@ziepe.ca,
	leon@kernel.org,
	zyjzyj2000@gmail.com,
	linux-rdma@vger.kernel.org,
	yanjun.zhu@linux.dev,
	mie@igel.co.jp
Subject: [PATCH 2/2] RDMA/rxe: Add dma-buf support
Date: Wed, 25 Mar 2026 22:27:39 -0700
Message-ID: <20260326052739.3778-3-yanjun.zhu@linux.dev>
In-Reply-To: <20260326052739.3778-1-yanjun.zhu@linux.dev>
References: <20260326052739.3778-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18681-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[ziepe.ca,kernel.org,gmail.com,vger.kernel.org,linux.dev,igel.co.jp];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: A9D1732F629
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implement a ib device operation ‘reg_user_mr_dmabuf’. Generate a
rxe_map from the memory space linked the passed dma-buf.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe.c       |  2 +
 drivers/infiniband/sw/rxe/rxe_loc.h   |  2 +
 drivers/infiniband/sw/rxe/rxe_mr.c    | 89 ++++++++++++++++++++++++---
 drivers/infiniband/sw/rxe/rxe_odp.c   |  2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c | 40 ++++++++++++
 drivers/infiniband/sw/rxe/rxe_verbs.h |  2 +-
 6 files changed, 126 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index e891199cbdef..9920ea3104be 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -278,3 +278,5 @@ late_initcall(rxe_module_init);
 module_exit(rxe_module_exit);
 
 MODULE_ALIAS_RDMA_LINK("rxe");
+
+MODULE_IMPORT_NS("DMA_BUF");
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 7992290886e1..dc9a56450c82 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -66,6 +66,8 @@ int rxe_mr_init_fast(int max_pages, struct rxe_mr *mr);
 int rxe_flush_pmem_iova(struct rxe_mr *mr, u64 iova, unsigned int length);
 int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr,
 		unsigned int length, enum rxe_mr_copy_dir dir);
+int rxe_mr_dmabuf_init_user(struct rxe_pd *pd, int fd, u64 start, u64 length,
+			    u64 iova, int access, struct rxe_mr *mr);
 int copy_data(struct rxe_pd *pd, int access, struct rxe_dma_info *dma,
 	      void *addr, int length, enum rxe_mr_copy_dir dir);
 int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index c696ff874980..5c129a488b83 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/libnvdimm.h>
+#include <linux/dma-buf.h>
 
 #include "rxe.h"
 #include "rxe_loc.h"
@@ -90,7 +91,7 @@ static unsigned long rxe_mr_iova_to_index(struct rxe_mr *mr, u64 iova)
 {
 	int idx;
 
-	if (mr_page_size(mr) > PAGE_SIZE)
+	if (rxe_mr_page_size(mr) > PAGE_SIZE)
 		idx = (iova - (mr->ibmr.iova & mr->page_mask)) >> PAGE_SHIFT;
 	else
 		idx = (iova >> mr->page_shift) -
@@ -103,15 +104,15 @@ static unsigned long rxe_mr_iova_to_index(struct rxe_mr *mr, u64 iova)
 /*
  * Convert iova to offset within the page_info entry.
  *
- * For mr_page_size > PAGE_SIZE, the offset is within the system page.
- * For mr_page_size <= PAGE_SIZE, the offset is within the MR page size.
+ * For rxe_mr_page_size > PAGE_SIZE, the offset is within the system page.
+ * For rxe_mr_page_size <= PAGE_SIZE, the offset is within the MR page size.
  */
 static unsigned long rxe_mr_iova_to_page_offset(struct rxe_mr *mr, u64 iova)
 {
-	if (mr_page_size(mr) > PAGE_SIZE)
+	if (rxe_mr_page_size(mr) > PAGE_SIZE)
 		return iova & (PAGE_SIZE - 1);
 	else
-		return iova & (mr_page_size(mr) - 1);
+		return iova & (rxe_mr_page_size(mr) - 1);
 }
 
 static bool is_pmem_page(struct page *pg)
@@ -129,7 +130,7 @@ static int rxe_mr_fill_pages_from_sgt(struct rxe_mr *mr, struct sg_table *sgt)
 	struct page *page;
 	bool persistent = !!(mr->access & IB_ACCESS_FLUSH_PERSISTENT);
 
-	WARN_ON(mr_page_size(mr) != PAGE_SIZE);
+	WARN_ON(rxe_mr_page_size(mr) != PAGE_SIZE);
 
 	__sg_page_iter_start(&sg_iter, sgt->sgl, sgt->orig_nents, 0);
 	if (!__sg_page_iter_next(&sg_iter))
@@ -224,6 +225,75 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length,
 	return err;
 }
 
+static int rxe_map_dmabuf_mr(struct rxe_mr *mr, struct ib_umem_dmabuf *umem_dmabuf)
+{
+	unsigned int page_size = rxe_mr_page_size(mr);
+	struct sg_table *sgt = umem_dmabuf->sgt;
+	struct scatterlist *sg;
+	struct page *page;
+	int i, j, n = 0;
+
+	mr->page_shift = ilog2(page_size);
+	mr->page_mask = ~((u64)page_size - 1);
+	mr->nbuf = 0;
+
+	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
+		page = sg_page(sg);
+		for (j = 0; j < (sg->length >> PAGE_SHIFT); j++) {
+			mr->page_info[n].page = page + j;
+			mr->page_info[n].offset = 0;
+			n++;
+		}
+	}
+
+	mr->nbuf = n;
+	return 0;
+}
+
+int rxe_mr_dmabuf_init_user(struct rxe_pd *pd, int fd, u64 start, u64 length,
+			    u64 iova, int access, struct rxe_mr *mr)
+{
+	struct ib_umem_dmabuf *umem_dmabuf;
+	int err;
+
+	umem_dmabuf = ib_umem_dmabuf_get(pd->ibpd.device, start, length, fd,
+					 access, NULL);
+	if (IS_ERR(umem_dmabuf)) {
+		err = PTR_ERR(umem_dmabuf);
+		goto err_out;
+	}
+
+	rxe_mr_init(access, mr);
+
+	err = alloc_mr_page_info(mr, ib_umem_num_pages(&umem_dmabuf->umem));
+	if (err) {
+		pr_warn("%s: Unable to allocate memory for map\n", __func__);
+		goto err_release_umem;
+	}
+
+	mr->ibmr.pd = &pd->ibpd;
+	mr->ibmr.iova = iova;
+	mr->umem = &umem_dmabuf->umem;
+	mr->access = access;
+	mr->state = RXE_MR_STATE_VALID;
+	mr->ibmr.type = IB_MR_TYPE_USER;
+
+	err = rxe_map_dmabuf_mr(mr, umem_dmabuf);
+	if (err)
+		goto err_free_mr_map;
+
+	return 0;
+
+err_free_mr_map:
+	free_mr_page_info(mr);
+
+err_release_umem:
+	ib_umem_release(&umem_dmabuf->umem);
+
+err_out:
+	return err;
+}
+
 int rxe_mr_init_fast(int max_pages, struct rxe_mr *mr)
 {
 	int err;
@@ -260,7 +330,7 @@ static int rxe_set_page(struct ib_mr *ibmr, u64 dma_addr)
 {
 	struct rxe_mr *mr = to_rmr(ibmr);
 	bool persistent = !!(mr->access & IB_ACCESS_FLUSH_PERSISTENT);
-	u32 i, pages_per_mr = mr_page_size(mr) >> PAGE_SHIFT;
+	u32 i, pages_per_mr = rxe_mr_page_size(mr) >> PAGE_SHIFT;
 
 	pages_per_mr = MAX(1, pages_per_mr);
 
@@ -288,7 +358,7 @@ int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sgl,
 		  int sg_nents, unsigned int *sg_offset)
 {
 	struct rxe_mr *mr = to_rmr(ibmr);
-	unsigned int page_size = mr_page_size(mr);
+	unsigned int page_size = rxe_mr_page_size(mr);
 
 	/*
 	 * Ensure page_size and PAGE_SIZE are compatible for mapping.
@@ -302,7 +372,7 @@ int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sgl,
 		return -EINVAL;
 	}
 
-	if (mr_page_size(mr) > PAGE_SIZE) {
+	if (rxe_mr_page_size(mr) > PAGE_SIZE) {
 		/* resize page_info if needed */
 		u32 map_mr_pages = (page_size >> PAGE_SHIFT) * mr->num_buf;
 
@@ -809,6 +879,7 @@ void rxe_mr_cleanup(struct rxe_pool_elem *elem)
 	struct rxe_mr *mr = container_of(elem, typeof(*mr), elem);
 
 	rxe_put(mr_pd(mr));
+
 	ib_umem_release(mr->umem);
 
 	if (mr->ibmr.type != IB_MR_TYPE_DMA)
diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
index bc11b1ec59ac..12c48f0cae47 100644
--- a/drivers/infiniband/sw/rxe/rxe_odp.c
+++ b/drivers/infiniband/sw/rxe/rxe_odp.c
@@ -351,7 +351,7 @@ int rxe_odp_flush_pmem_iova(struct rxe_mr *mr, u64 iova,
 		page = hmm_pfn_to_page(umem_odp->map.pfn_list[index]);
 
 		bytes = min_t(unsigned int, length,
-			      mr_page_size(mr) - page_offset);
+			      rxe_mr_page_size(mr) - page_offset);
 
 		va = kmap_local_page(page);
 		arch_wb_cache_pmem(va + page_offset, bytes);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index fe41362c5144..1b5381b14d4b 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1358,6 +1358,45 @@ static struct ib_mr *rxe_rereg_user_mr(struct ib_mr *ibmr, int flags,
 	return NULL;
 }
 
+static struct ib_mr *rxe_reg_user_mr_dmabuf(struct ib_pd *ibpd, u64 start,
+					    u64 length, u64 iova, int fd,
+					    int access, struct ib_dmah *dmah,
+					    struct uverbs_attr_bundle *udata)
+{
+	int err;
+	struct rxe_dev *rxe = to_rdev(ibpd->device);
+	struct rxe_pd *pd = to_rpd(ibpd);
+	struct rxe_mr *mr;
+
+	mr = kzalloc_obj(*mr);
+	if (!mr) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	err = rxe_add_to_pool(&rxe->mr_pool, mr);
+	if (err)
+		goto err_free;
+
+	rxe_get(pd);
+
+	err = rxe_mr_dmabuf_init_user(pd, fd, start, length, iova, access, mr);
+	if (err)
+		goto err3;
+
+	return &mr->ibmr;
+
+err3:
+	rxe_put(pd);
+	rxe_put(mr);
+
+err_free:
+	kfree(mr);
+
+err_out:
+	return ERR_PTR(err);
+}
+
 static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 				  u32 max_num_sg)
 {
@@ -1517,6 +1556,7 @@ static const struct ib_device_ops rxe_dev_ops = {
 	.query_qp = rxe_query_qp,
 	.query_srq = rxe_query_srq,
 	.reg_user_mr = rxe_reg_user_mr,
+	.reg_user_mr_dmabuf = rxe_reg_user_mr_dmabuf,
 	.req_notify_cq = rxe_req_notify_cq,
 	.rereg_user_mr = rxe_rereg_user_mr,
 	.resize_cq = rxe_resize_cq,
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index fb149f37e91d..9d77bec0bf3c 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -364,7 +364,7 @@ struct rxe_mr {
 	struct rxe_mr_page	*page_info;
 };
 
-static inline unsigned int mr_page_size(struct rxe_mr *mr)
+static inline unsigned int rxe_mr_page_size(struct rxe_mr *mr)
 {
 	return mr ? mr->ibmr.page_size : PAGE_SIZE;
 }
-- 
2.53.0


