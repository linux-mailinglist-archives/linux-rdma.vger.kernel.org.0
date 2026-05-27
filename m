Return-Path: <linux-rdma+bounces-21394-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNBnFdIlF2qu6wcAu9opvQ
	(envelope-from <linux-rdma+bounces-21394-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 19:11:46 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 979235E8375
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 19:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 47929301CEF8
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 17:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101EA44CAE4;
	Wed, 27 May 2026 17:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="izVI+lXe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A1D382F05
	for <linux-rdma@vger.kernel.org>; Wed, 27 May 2026 17:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779901844; cv=none; b=Ag9LxgPMLUxgVhmkLV/NWxGesN98AJ34YyuPPuNB8ysUW5KZzYRUBDoLTr0JAlz0yFrYo5rapAIINsvfVsVrJjhEb2Pcnmaw+x05Og0l1y84z/Ok1Tlvn4ROQQRoW95wIxTrKTcThOLAd0cKGfQPJc07dtsjY9QF64ybOmoYmRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779901844; c=relaxed/simple;
	bh=OmyBI6l3LVa7Ic/TQnYf5VqMoCrai7xgeXaGp99e7+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XdpMie/7GJV0iAnXukxBBMed7H27VghNhWUf+r5f+WXfc72gDWWt2bFsvVmHypgvPF7Hcj7rcv6fGw5A7kx4pFG9dGBEaD4Dzq2fUD0dEaZPybTH5Tlvc7VZ9DTucyqt9dttkqtVRKdnps6xSzgxdIv6kUNAnCNlFJmibo2F1/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=izVI+lXe; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48d146705b4so126561425e9.3
        for <linux-rdma@vger.kernel.org>; Wed, 27 May 2026 10:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779901841; x=1780506641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4dpeeVKjsGMIkvFNkLTFzR6cRglnxD70wYiXkHx0I+Q=;
        b=izVI+lXeZR+taggIjyifphZDzVdvfcbZCDaHaVMfSW2GbIHyaTFUnrQToy6bTqXpzg
         FasySjAiKWQEq3Uu6Vb2SuNEjA0/QwM+aX8B56iF2vSuqp+IQTSVPRr5tiMxhq1ayk6R
         dnTs0wRg6hnB8GxDQDsSTnWTUkLuHoqHAPadV/xKk1ryq2UAfTS5qIi5nps6VX80xP9+
         lSwZvCjaY3CuS343FhW1MwEE+Y9gqbnPhyNN35wgSUDt9LzOErYKhccYbmltTWFgVNxE
         QtC13rQy42aQPfHe5ewOI9/EBUDYT/G4beeCTyzyk/Qek3JdnTwOtGEtEP6ORQpFGtMf
         zdKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779901841; x=1780506641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4dpeeVKjsGMIkvFNkLTFzR6cRglnxD70wYiXkHx0I+Q=;
        b=ibB1ADK+w578m/3/qwDccaPKOOUR+lnRHZoHkfFToty9jke81hM/B7pS96Oo5sfCpz
         kdPIE5jVwSSu8bLzIpc5sdZXvZXOpk7rBUhhIn+U4z0tnCCdoDvyhJArhj/DrA/2xCLm
         IzXu7dpsudaJRICIFcjB5oUFrfwP3mhVgESkqGTSl33RnWnWtpUP4F1PsakNN3RRbeAI
         yGZNkvEoz8YPSJS6HWLMzT6LT6GcMaaSqoskw2v1AyNSTojbI4mh4Hvl3juISmTfHOoY
         V59Pa5z6MclXIPu8iKSm/I1pG7LKCjoCWFMgnxNSuP9hGfIi5+a3ZiTbVcn+3/ttB3/I
         +TOQ==
X-Gm-Message-State: AOJu0Yw3Gnuch/lPTeJlCo6pgsr8GBD8TfHhZfepiGSrxISAtsNaSxTr
	5Blk7FqBMlcDqtxZexXPKQJpQF4GPKuKDun/ddtCH+4oWZNNjZeiCx3q6hEgkwNvni93r3vTJWr
	EBZt7DhF0zg==
X-Gm-Gg: Acq92OGL2sSPc/Nda3ehhawF90MMWeOgXl3x7oWjAgjb9r+VZ3NJGKJz7wJYer0hL6D
	8gxohuEVcRfpD8o+V5m+NLTyq+AFwtMDHnb+QMSNL43W8VdVHMbhW1LiuBYODE9PEie79kx9cG0
	XaA6j4E5ap7CODg7xuuvEf/JRoB2Vh1jHZnNyJiRK8BI6Km9crJLIobBhwvf3kpyHpuM0Sak/gs
	/mpxIX1wDVeMUSs2h6SVuO5QmzCJ4ZM1lPh60bAZBX1bvoBUNsKTyTzZ4oXP7ZAGz7atkOaMl+l
	JiF84k0q/3j6xPNGK+tcZ/cbZPLVlUO1U6TDHS8zN8EkwHlDx07zWjY8phlDIhna8Biu/jUiuM9
	Wp2QIMcMAAQnXf90Ex3woV6izfNXMYAPnwZLHjznwiWOJxUlm8x4W4cz2vbW4XhgBj4x/HhV0WZ
	Rgl24RhK7K2xpQQXtLneMbqDVArM8BDCQ=
X-Received: by 2002:a05:600c:4e0d:b0:490:58ef:ce9b with SMTP id 5b1f17b1804b1-49058efcfbfmr314302785e9.16.1779901841351;
        Wed, 27 May 2026 10:10:41 -0700 (PDT)
Received: from localhost ([128.77.52.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454c600esm399618485e9.3.2026.05.27.10.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 10:10:40 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	mrgolin@amazon.com,
	gal.pressman@linux.dev,
	sleybo@amazon.com,
	parav@nvidia.com,
	mbloch@nvidia.com,
	yanjun.zhu@linux.dev,
	marco.crivellari@suse.com,
	roman.gushchin@linux.dev,
	phaddad@nvidia.com,
	lirongqing@baidu.com,
	ynachum@amazon.com,
	huangjunxian6@hisilicon.com,
	kalesh-anakkur.purayil@broadcom.com,
	ohartoov@nvidia.com,
	michaelgur@nvidia.com,
	shayd@nvidia.com,
	edwards@nvidia.com,
	sriharsha.basavapatna@broadcom.com,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	jmoroni@google.com
Subject: [PATCH rdma-next v8 14/15] RDMA/mlx5: Use UMEM attribute for CQ doorbell record
Date: Wed, 27 May 2026 19:09:47 +0200
Message-ID: <20260527170948.2017439-15-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527170948.2017439-1-jiri@resnulli.us>
References: <20260527170948.2017439-1-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21394-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[24];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,resnulli-us.20251104.gappssmtp.com:dkim,resnulli.us:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 979235E8375
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
v7->v8:
- rebased on top of uverbs_get_buffer_desc() rename
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
index 020c70328663..7bef9383c64d 100644
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
+		err = uverbs_get_buffer_desc(attrs, attr_id, &desc);
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
index dd5611800531..58997714df70 100644
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


