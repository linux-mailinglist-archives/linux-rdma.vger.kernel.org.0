Return-Path: <linux-rdma+bounces-21047-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMSsECGJDWpdygUAu9opvQ
	(envelope-from <linux-rdma+bounces-21047-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 12:12:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1C258B7A7
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 12:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0D0E6303DE08
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 10:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0323D6CA7;
	Wed, 20 May 2026 10:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="spke8CRU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23563D6486
	for <linux-rdma@vger.kernel.org>; Wed, 20 May 2026 10:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779271924; cv=none; b=EvtCYE9ZVX2ntUVOT+SoWIFBZ3OlyXe7uwrJsdC3qov/IwELiDvEC7BO4s7oe/U1f6qzpZWzAyXSmZTSoXUiTsqne9+17FWg1DXq6PD6ln2/YQ0USzPiklcObGGd0QSKzz6HqtAoqCT2bkkV9PCnG0q5WluzGOil6VHckndaInA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779271924; c=relaxed/simple;
	bh=V0Ml6SqMaRgGxinVR64oqOLByyHxjcZ+5Uh2dbEymhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bhayXtHcKGGLZXFBuZbebpVQlshoz57rxmtMSXRX4wiwgIjnZgoEOgD6df5lzaWIIGXfANlJn2FxIrOo59ISy/rkg/809kY/JGsJ0USLIYH8lCfj+SnaOlKdLldo9pdZyCM0gWTEovv85gc/PFwoAMZo8tngd4T0EVeEtU5Cs3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=spke8CRU; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so43789445e9.2
        for <linux-rdma@vger.kernel.org>; Wed, 20 May 2026 03:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779271916; x=1779876716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AbNqTgXG1PrEUkKIH1wwaht3xLkiT1eU1JTu2y1c6Jo=;
        b=spke8CRU6tOKL80WyjsCO88fFESzOACrR3td27rPkXmsxOVkddeUGgdKtFoSdMqbKp
         I0iDOkm8px6u/IEuKSD9N6iilzPoNfBPfrs0lhkDYrQTXIvG0/IItz5fQ63EM3Vt/v85
         3eUZLgcZ/ni8wak1a7hsFu12wiA+VDXoKUKfBtPSrPAAvN7Us17PD1OqOwYFq4hIC7jL
         V/Blsw/0yosN7zJlvcEpKJG0GmNjM3apUUYb9wHQJKyo9yBvBXg7akbuW0w151a+MEEn
         Tj25G6QbfgZXD3UTbo6lCgGBW6gTpBA6Qy34pRBsQempp5No+e6pEql3La/IRJK+2l8p
         mh3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779271916; x=1779876716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AbNqTgXG1PrEUkKIH1wwaht3xLkiT1eU1JTu2y1c6Jo=;
        b=BUEmOyrzbZt9u4DQGjy2Xek0EjBn27OjNag3Bt+i7bOvmBO0WBV4UaMRDxw8neo/6K
         goj+S6733kGNFFXBE/wQ4n2Edi8QfQ4JnGi3HqCQvUy5ozxHqMfjbAgLn5zyE/bgz5Le
         0kwTdM4itZL6KDr5U4RsF5EFCxXoUbwEBB7fnnykFKMnh9oLbxdwiWT/ly0jNvhrkOOb
         oQaHuGtUpc+F9xXlW2ShNkak9ustk3S98tGpPF6fZngClX+W8XfSQkfjftTg155i0TiU
         aM5fytm7KtLwr3ZMvmaGQNE4fIGblcyI6/UrECv8ziPMShxmjHKca9UdY96I1Yl0mkG2
         TEFQ==
X-Gm-Message-State: AOJu0YwuBLQ0j1GAnddjblkXRVWDtBZc5AnxexRO5VhO2R5vFK+VhAec
	pw1Il9Ub3vuqI4nzUWzI7PGndo1CVI/XQNrYMNHEbuLnvyruGt7UShxechN0/uvdqj2oTmuI+iZ
	E5c/EMbBkvg==
X-Gm-Gg: Acq92OFmtHF346CHa/pyTeEiSPfbVS8AnSzPfnEPZNizbku3auNU+3VemB+qwrUuNlw
	7yJVQXTTivA9nKTLEb5RDk475vU2G2QHnfCtUxQ3aZJ4ck1+2ud3oSo2Hek4ZqmYHAr60JcVTRv
	WX8wn39aqDsesglFCJOTjw4eytnG8qUkoXZqF5zzeFqFhNOynBkr+yzmafiVmrFLZJNyFDfxI+i
	FTg5XLh3VuW2gDQRihaa0RXyCq/ml4vsy5VtYZufHpbzYJRM5hJiniZTabl570ZtxbBZTQCjygF
	KXYj6Hs7OWwxbibeal9whv77RVI/ZxQxqtspF6n+Ah1EOxfmZhY1kEkcj2ArvWq+OR/32xCDeA9
	yTOcziRF7PiqXqFLK5zYk0YE3hxbrU04sBUPe2MbEatxykbl/oK65Li3qnNgYzgzkKithOkcAt/
	o2nA2Dpvp/OJxqkdz+y7aqiAXtTCeqBDQqYDGLrZjdQMI=
X-Received: by 2002:a05:600c:a4f:b0:48f:e230:2a24 with SMTP id 5b1f17b1804b1-48fe66204e8mr338460015e9.31.1779271916448;
        Wed, 20 May 2026 03:11:56 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe5694fbfsm667150025e9.6.2026.05.20.03.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 03:11:56 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	edwards@nvidia.com,
	kees@kernel.org,
	parav@nvidia.com,
	mbloch@nvidia.com,
	yishaih@nvidia.com,
	lirongqing@baidu.com,
	huangjunxian6@hisilicon.com,
	liuy22@mails.tsinghua.edu.cn,
	jmoroni@google.com
Subject: [PATCH rdma-next v6 14/15] RDMA/mlx5: Use UMEM attribute for CQ doorbell record
Date: Wed, 20 May 2026 12:11:28 +0200
Message-ID: <20260520101129.899464-15-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520101129.899464-1-jiri@resnulli.us>
References: <20260520101129.899464-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21047-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Queue-Id: EA1C258B7A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiri Pirko <jiri@nvidia.com>

Add an optional mlx5 driver-namespace UMEM attribute on CQ
create so userspace can supply the doorbell record buffer
explicitly. mlx5_ib_db_map_user() resolves the attribute (or
falls back to the legacy UHW VA) into a struct
ib_uverbs_buffer_desc and runs a unified lookup-then-pin:
VA-typed descriptors share a per-page umem across CQ/QP/SRQ
in the same process, FD-typed descriptors are pinned per call.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v5->v6:
- changed to pass attrs instead of udata to ib_umem_get*()
v4->v5:
- split mlx5_ib_db_map_user() into a thin attr-resolving wrapper
  and a static mlx5_ib_db_map_user_desc() taking a desc
- struct mlx5_ib_user_db_page: store ib_uverbs_buffer_desc instead
  of user_virt; one match key for both VA and FD entries
- attr-based callers now share per-page umems with each other
  and the legacy VA path; single ib_umem_get_desc() call
- replaced manual page-boundary check with ib_umem_is_contiguous()
v2->v3:
- moved CQ DBR attr to mlx5 driver namespace
- changed to use ib_umem_get_attr() to get umem
- added page-crossing check
---
 drivers/infiniband/hw/mlx5/cq.c          |  8 +-
 drivers/infiniband/hw/mlx5/doorbell.c    | 93 +++++++++++++++++++-----
 drivers/infiniband/hw/mlx5/mlx5_ib.h     |  5 +-
 drivers/infiniband/hw/mlx5/qp.c          |  4 +-
 drivers/infiniband/hw/mlx5/srq.c         |  2 +-
 include/uapi/rdma/mlx5_user_ioctl_cmds.h |  1 +
 6 files changed, 88 insertions(+), 25 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index e8f8fcc106c8..49b4bf148a4a 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -761,7 +761,9 @@ static int create_cq_user(struct mlx5_ib_dev *dev, struct ib_udata *udata,
 		goto err_umem;
 	}
 
-	err = mlx5_ib_db_map_user(context, ucmd.db_addr, &cq->db);
+	err = mlx5_ib_db_map_user(context, attrs,
+				  MLX5_IB_ATTR_CREATE_CQ_DBR_BUF_UMEM,
+				  ucmd.db_addr, &cq->db);
 	if (err)
 		goto err_umem;
 
@@ -1521,7 +1523,9 @@ ADD_UVERBS_ATTRIBUTES_SIMPLE(
 	UVERBS_ATTR_PTR_IN(
 		MLX5_IB_ATTR_CREATE_CQ_UAR_INDEX,
 		UVERBS_ATTR_TYPE(u32),
-		UA_OPTIONAL));
+		UA_OPTIONAL),
+	UVERBS_ATTR_UMEM(MLX5_IB_ATTR_CREATE_CQ_DBR_BUF_UMEM,
+			 UA_OPTIONAL));
 
 const struct uapi_definition mlx5_ib_create_cq_defs[] = {
 	UAPI_DEF_CHAIN_OBJ_TREE(UVERBS_OBJECT_CQ, &mlx5_ib_cq_create),
diff --git a/drivers/infiniband/hw/mlx5/doorbell.c b/drivers/infiniband/hw/mlx5/doorbell.c
index 020c70328663..7c864fe0b8dc 100644
--- a/drivers/infiniband/hw/mlx5/doorbell.c
+++ b/drivers/infiniband/hw/mlx5/doorbell.c
@@ -40,47 +40,82 @@
 struct mlx5_ib_user_db_page {
 	struct list_head	list;
 	struct ib_umem	       *umem;
-	unsigned long		user_virt;
+	struct ib_uverbs_buffer_desc desc;
 	int			refcnt;
 	struct mm_struct	*mm;
 };
 
-int mlx5_ib_db_map_user(struct mlx5_ib_ucontext *context, unsigned long virt,
-			struct mlx5_db *db)
+static int mlx5_ib_db_map_user_desc(struct mlx5_ib_ucontext *context,
+				    const struct ib_uverbs_buffer_desc *desc,
+				    struct mlx5_db *db)
 {
 	struct mlx5_ib_user_db_page *page;
+	struct ib_umem *umem;
 	int err = 0;
 
+	if (desc->length < sizeof(__be32) * 2)
+		return -EINVAL;
+
 	mutex_lock(&context->db_page_mutex);
 
-	list_for_each_entry(page, &context->db_page_list, list)
-		if ((current->mm == page->mm) &&
-		    (page->user_virt == (virt & PAGE_MASK)))
-			goto found;
+	/*
+	 * Only VA-typed descriptors are eligible to share a per-page
+	 * doorbell umem; FD-typed descriptors are pinned individually.
+	 */
+	if (desc->type == IB_UVERBS_BUFFER_TYPE_VA) {
+		list_for_each_entry(page, &context->db_page_list, list) {
+			if (current->mm != page->mm)
+				continue;
+			if (page->desc.addr == (desc->addr & PAGE_MASK))
+				goto found;
+		}
+	}
 
-	page = kmalloc_obj(*page);
+	page = kzalloc_obj(*page);
 	if (!page) {
 		err = -ENOMEM;
 		goto out;
 	}
 
-	page->user_virt = (virt & PAGE_MASK);
-	page->refcnt    = 0;
-	page->umem = ib_umem_get_va(context->ibucontext.device,
-				    virt & PAGE_MASK, PAGE_SIZE, 0);
-	if (IS_ERR(page->umem)) {
-		err = PTR_ERR(page->umem);
+	page->desc = *desc;
+
+	/*
+	 * Normalize VA descriptors to a page-aligned PAGE_SIZE region so
+	 * multiple DBRs that fall in the same user page share one umem.
+	 */
+	if (page->desc.type == IB_UVERBS_BUFFER_TYPE_VA) {
+		page->desc.addr &= PAGE_MASK;
+		page->desc.length = PAGE_SIZE;
+	}
+
+	umem = ib_umem_get_desc(context->ibucontext.device, &page->desc, 0);
+	if (IS_ERR(umem)) {
+		err = PTR_ERR(umem);
+		kfree(page);
+		goto out;
+	}
+
+	/*
+	 * The 8-byte DBR is programmed to the device as one DMA address,
+	 * so it must live in a single contiguous DMA segment.
+	 */
+	if (!ib_umem_is_contiguous(umem)) {
+		ib_umem_release(umem);
 		kfree(page);
+		err = -EINVAL;
 		goto out;
 	}
-	mmgrab(current->mm);
-	page->mm = current->mm;
 
+	page->umem = umem;
+	if (page->desc.type == IB_UVERBS_BUFFER_TYPE_VA) {
+		mmgrab(current->mm);
+		page->mm = current->mm;
+	}
 	list_add(&page->list, &context->db_page_list);
 
 found:
 	db->dma = sg_dma_address(page->umem->sgt_append.sgt.sgl) +
-		  (virt & ~PAGE_MASK);
+		  (desc->addr & ~PAGE_MASK);
 	db->u.user_page = page;
 	++page->refcnt;
 
@@ -90,13 +125,35 @@ int mlx5_ib_db_map_user(struct mlx5_ib_ucontext *context, unsigned long virt,
 	return err;
 }
 
+int mlx5_ib_db_map_user(struct mlx5_ib_ucontext *context,
+			const struct uverbs_attr_bundle *attrs, u16 attr_id,
+			unsigned long virt, struct mlx5_db *db)
+{
+	struct ib_uverbs_buffer_desc desc = {
+		.type = IB_UVERBS_BUFFER_TYPE_VA,
+		.addr = virt,
+		.length = sizeof(__be32) * 2,
+	};
+
+	if (attrs) {
+		int err;
+
+		err = uverbs_attr_get_buffer_desc(attrs, attr_id, &desc);
+		if (err && err != -ENOENT)
+			return err;
+	}
+
+	return mlx5_ib_db_map_user_desc(context, &desc, db);
+}
+
 void mlx5_ib_db_unmap_user(struct mlx5_ib_ucontext *context, struct mlx5_db *db)
 {
 	mutex_lock(&context->db_page_mutex);
 
 	if (!--db->u.user_page->refcnt) {
 		list_del(&db->u.user_page->list);
-		mmdrop(db->u.user_page->mm);
+		if (db->u.user_page->mm)
+			mmdrop(db->u.user_page->mm);
 		ib_umem_release(db->u.user_page->umem);
 		kfree(db->u.user_page);
 	}
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index e156dc4d7529..078f281bcdac 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1259,8 +1259,9 @@ to_mmmap(struct rdma_user_mmap_entry *rdma_entry)
 
 int mlx5_ib_dev_res_cq_init(struct mlx5_ib_dev *dev);
 int mlx5_ib_dev_res_srq_init(struct mlx5_ib_dev *dev);
-int mlx5_ib_db_map_user(struct mlx5_ib_ucontext *context, unsigned long virt,
-			struct mlx5_db *db);
+int mlx5_ib_db_map_user(struct mlx5_ib_ucontext *context,
+			const struct uverbs_attr_bundle *attrs, u16 attr_id,
+			unsigned long virt, struct mlx5_db *db);
 void mlx5_ib_db_unmap_user(struct mlx5_ib_ucontext *context, struct mlx5_db *db);
 void __mlx5_ib_cq_clean(struct mlx5_ib_cq *cq, u32 qpn, struct mlx5_ib_srq *srq);
 void mlx5_ib_cq_clean(struct mlx5_ib_cq *cq, u32 qpn, struct mlx5_ib_srq *srq);
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 11b1deec7f42..9accc5dc70ee 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -914,7 +914,7 @@ static int create_user_rq(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 		ib_umem_num_pages(rwq->umem), page_size, rwq->rq_num_pas,
 		offset);
 
-	err = mlx5_ib_db_map_user(ucontext, ucmd->db_addr, &rwq->db);
+	err = mlx5_ib_db_map_user(ucontext, NULL, 0, ucmd->db_addr, &rwq->db);
 	if (err) {
 		mlx5_ib_dbg(dev, "map failed\n");
 		goto err_umem;
@@ -1053,7 +1053,7 @@ static int _create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 		resp->bfreg_index = MLX5_IB_INVALID_BFREG;
 	qp->bfregn = bfregn;
 
-	err = mlx5_ib_db_map_user(context, ucmd->db_addr, &qp->db);
+	err = mlx5_ib_db_map_user(context, NULL, 0, ucmd->db_addr, &qp->db);
 	if (err) {
 		mlx5_ib_dbg(dev, "map failed\n");
 		goto err_free;
diff --git a/drivers/infiniband/hw/mlx5/srq.c b/drivers/infiniband/hw/mlx5/srq.c
index 44903015c6c9..5bc48fef3744 100644
--- a/drivers/infiniband/hw/mlx5/srq.c
+++ b/drivers/infiniband/hw/mlx5/srq.c
@@ -74,7 +74,7 @@ static int create_srq_user(struct ib_pd *pd, struct mlx5_ib_srq *srq,
 	}
 	in->umem = srq->umem;
 
-	err = mlx5_ib_db_map_user(ucontext, ucmd.db_addr, &srq->db);
+	err = mlx5_ib_db_map_user(ucontext, NULL, 0, ucmd.db_addr, &srq->db);
 	if (err) {
 		mlx5_ib_dbg(dev, "map doorbell failed\n");
 		goto err_umem;
diff --git a/include/uapi/rdma/mlx5_user_ioctl_cmds.h b/include/uapi/rdma/mlx5_user_ioctl_cmds.h
index 01a2a050e468..b63e75034cda 100644
--- a/include/uapi/rdma/mlx5_user_ioctl_cmds.h
+++ b/include/uapi/rdma/mlx5_user_ioctl_cmds.h
@@ -274,6 +274,7 @@ enum mlx5_ib_device_query_context_attrs {
 
 enum mlx5_ib_create_cq_attrs {
 	MLX5_IB_ATTR_CREATE_CQ_UAR_INDEX = UVERBS_ID_DRIVER_NS_WITH_UHW,
+	MLX5_IB_ATTR_CREATE_CQ_DBR_BUF_UMEM,
 };
 
 enum mlx5_ib_reg_dmabuf_mr_attrs {
-- 
2.54.0


