Return-Path: <linux-rdma+bounces-20156-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCcACWiL/GleRAAAu9opvQ
	(envelope-from <linux-rdma+bounces-20156-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 14:54:00 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF7C4E88B3
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 14:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BED5C3046E83
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 12:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978CD3F0AB2;
	Thu,  7 May 2026 12:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="CDUUyoKm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A602B3F0AA3
	for <linux-rdma@vger.kernel.org>; Thu,  7 May 2026 12:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778158372; cv=none; b=WugQgHZw7/MhfwW2R7hp9TP71bbqIIdMG2kSkwHTMxzs9XyQueY2r/teAAUmZtFGspOT2VPlmUPxdl7Shj8UneUgOtAPwcQq7CL3kx/QN6bQpF6Nv9yRTpZjDaklMcMbxV4aBTlVtAUpCx0LxMDwaUOuaHV8vB+XSG6rrBtEQkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778158372; c=relaxed/simple;
	bh=SB5QdHousMlditt2XIm1F0txb4id34IV2wjxconsSWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DEoisIk0R971iBgzFTvOwWK4TIfAcjBC9tfi2/RA62nl8pA66Y7Cp79YSqD9jZ9fRHCzYI0SddCa2uTRF15Y7mMGV3lD72iPz7DlGBM8X5ed/dlpn/LBcw+LeSVtAx6HhwZy8jdJF9FuT5uVeDSBOu1og27/q7YKV9ZKihtojU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=CDUUyoKm; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so7523075e9.2
        for <linux-rdma@vger.kernel.org>; Thu, 07 May 2026 05:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778158369; x=1778763169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WR2nxvQ9SAWP1acLAnK4um7ADSArZlKrWozWm4tmEWM=;
        b=CDUUyoKmrXV902sxmNvz9w1iuNpkhGLSBgz1Xa3jtqkyVsJy2eixISTYgtglPcIg9B
         G1vdWX3H+KS+CxxS/qm/ONgsgUMSRnabKwSy85xTBccMd+Ew025JNqOSfpLYolkEIdSz
         K+EQ3RobA05XCK+xpky7yprAYT5M35eztVzL3/01hdWdaR1pLnC1a/Czi/kyhjR6UdhR
         nkx5EeaBMvKpJMp1M4IkRh4PaERNPxNQwni+18AsYBZTYaCFZu+LTnD4Yd7TXa8HN4wh
         ex4y3cwBNzy4rPDhO1D+XmQqjbx/SVwKcyh3rMpgjX1VHjgkV1N46wkV7UUnRXtnY74H
         g5yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778158369; x=1778763169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WR2nxvQ9SAWP1acLAnK4um7ADSArZlKrWozWm4tmEWM=;
        b=H4CzUfoWRtgA7Z5i63BX4r76C76L8gwS9+c9lkpww5SlmyFH02Gs5wSy7M4gcLbTPk
         wRBuq0o1TLCU2w626FQgDCfe57s5F/8R2hQaXOLqZADRWX78UwI4sGhbFmY7za48myEl
         eSi4QqebFLIVoT+H5/9WXvTIP6jKapha+3pVoZOxJzyGlG5L/0fTcI0rln0CacIfAwBs
         bYgkmcN9SkEl4h2Y+Ep5ZLSdddqeMh5VQ3AKO6AJPEszR/dkCw4wm3PBrHJDPsHhFqee
         B5aPLTh26rKCJrFnUD+pKG7g689hFmXV9PcpGtAC7hLdd4gtRbwxmJ2TdZjlCV+6uno+
         unpA==
X-Gm-Message-State: AOJu0Yx2gvLGFsu+OAyb83WIj/hShy+3fW8AIEQT6sCa1veGAnir3qIS
	FKU/SyVl1IIvXSuw5mDvh5Xez8YXqHN8hhnaOhByssTVps+iNQxRODPbt5hWGaAdfbwbJqv5272
	asZfN
X-Gm-Gg: AeBDietfGZVHw7wiLevxshxYGqS+FUMquU8RHMiz0vEAscO6zUyhYtrW5P54h1Nsa2n
	+GUPJlKsPj0HfuPVgDa3sOXTO+YybpsJ24ZIGtXO/bVZgeYB17oEx/xaJ3vqqc9FYW4/5a4+WpT
	FH82twi7hZyZcG+RewALSD67BaVxN+w8tEZx7ZjgACeuaiuSsclHG9WGEWzkC7l9valXYzimmWz
	Wn5fn2ZsXr7lxk98jx1rl8sP0lQvyKV6g36VBAmD24ai2yjzsRYidN/xPSvGFhzuibwj6RV4wj1
	FZueUSsOZS/Y5fIr7qCxl4N3cVwL9/F7BDJpC7EAbJ952n++ll3ZPhM9UksUYPEPQSJ5+qbMxVh
	L/pKKnfWm/KGBazL3SqCVw2VRjPiFugXSV3kIgc6Km8f3bI6vryPTZRqyhb3JS2D2nO5G+NNmgo
	+oCpjmlBCFyh05RIjXNvRgLetS6dZkCJ3IrBWKXwDOS8T/6s7DzGAQoC1Z
X-Received: by 2002:a05:600c:4617:b0:48a:5970:1fe1 with SMTP id 5b1f17b1804b1-48e51e0bb17mr72404595e9.4.1778158368955;
        Thu, 07 May 2026 05:52:48 -0700 (PDT)
Received: from localhost (46-13-72-179.customers.tmcz.cz. [46.13.72.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538a50d0sm214746275e9.5.2026.05.07.05.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 05:52:48 -0700 (PDT)
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
	selvin.xavier@broadcom.com
Subject: [PATCH rdma-next v4 15/16] RDMA/mlx5: Use UMEM attribute for CQ doorbell record
Date: Thu,  7 May 2026 14:52:30 +0200
Message-ID: <20260507125231.2950751-16-jiri@resnulli.us>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507125231.2950751-1-jiri@resnulli.us>
References: <20260507125231.2950751-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6DF7C4E88B3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20156-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Jiri Pirko <jiri@nvidia.com>

Add an optional mlx5 driver-namespace UMEM attribute on CQ
create so userspace can supply the doorbell record umem
explicitly. Resolve it inside mlx5_ib_db_map_user() and use it
as a private DBR page when present; otherwise take the existing
UHW share-or-pin path that preserves per-page DBR sharing
across CQ/QP/SRQ in the same process.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- moved CQ DBR attr to mlx5 driver namespace
- changed to use ib_umem_get_attr() to get umem
- added page-crossing check
---
 drivers/infiniband/hw/mlx5/cq.c          |  8 +++-
 drivers/infiniband/hw/mlx5/doorbell.c    | 51 ++++++++++++++++++++----
 drivers/infiniband/hw/mlx5/mlx5_ib.h     |  5 ++-
 drivers/infiniband/hw/mlx5/qp.c          |  4 +-
 drivers/infiniband/hw/mlx5/srq.c         |  2 +-
 include/uapi/rdma/mlx5_user_ioctl_cmds.h |  1 +
 6 files changed, 57 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index fb6172a9be57..b69ab49b1b3e 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -760,7 +760,9 @@ static int create_cq_user(struct mlx5_ib_dev *dev, struct ib_udata *udata,
 		goto err_umem;
 	}
 
-	err = mlx5_ib_db_map_user(context, ucmd.db_addr, &cq->db);
+	err = mlx5_ib_db_map_user(context, udata,
+				  MLX5_IB_ATTR_CREATE_CQ_DBR_BUF_UMEM,
+				  ucmd.db_addr, &cq->db);
 	if (err)
 		goto err_umem;
 
@@ -1519,7 +1521,9 @@ ADD_UVERBS_ATTRIBUTES_SIMPLE(
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
index 020c70328663..c9f9b9179e88 100644
--- a/drivers/infiniband/hw/mlx5/doorbell.c
+++ b/drivers/infiniband/hw/mlx5/doorbell.c
@@ -45,20 +45,56 @@ struct mlx5_ib_user_db_page {
 	struct mm_struct	*mm;
 };
 
-int mlx5_ib_db_map_user(struct mlx5_ib_ucontext *context, unsigned long virt,
-			struct mlx5_db *db)
+int mlx5_ib_db_map_user(struct mlx5_ib_ucontext *context,
+			struct ib_udata *udata, u16 attr_id,
+			unsigned long virt, struct mlx5_db *db)
 {
-	struct mlx5_ib_user_db_page *page;
+	struct mlx5_ib_user_db_page *page = NULL;
+	unsigned long dma_offset;
 	int err = 0;
 
+	if (udata) {
+		struct ib_umem *umem;
+
+		umem = ib_umem_get_attr(context->ibucontext.device, udata,
+					attr_id, sizeof(__be32) * 2, 0);
+		if (IS_ERR(umem))
+			return PTR_ERR(umem);
+		if (umem) {
+			/*
+			 * The 8-byte DBR is programmed to the device as one
+			 * DMA address, so it must stay within a single page.
+			 * An 8-byte range that crosses a page boundary may
+			 * be split across two non-contiguous DMA mappings.
+			 */
+			if (ib_umem_offset(umem) >
+			    PAGE_SIZE - sizeof(__be32) * 2) {
+				ib_umem_release(umem);
+				return -EINVAL;
+			}
+			page = kzalloc_obj(*page);
+			if (!page) {
+				ib_umem_release(umem);
+				return -ENOMEM;
+			}
+			page->umem = umem;
+			dma_offset = ib_umem_offset(umem);
+		}
+	}
+
 	mutex_lock(&context->db_page_mutex);
 
+	if (page)
+		goto add_page;
+
+	dma_offset = virt & ~PAGE_MASK;
+
 	list_for_each_entry(page, &context->db_page_list, list)
 		if ((current->mm == page->mm) &&
 		    (page->user_virt == (virt & PAGE_MASK)))
 			goto found;
 
-	page = kmalloc_obj(*page);
+	page = kzalloc_obj(*page);
 	if (!page) {
 		err = -ENOMEM;
 		goto out;
@@ -76,11 +112,11 @@ int mlx5_ib_db_map_user(struct mlx5_ib_ucontext *context, unsigned long virt,
 	mmgrab(current->mm);
 	page->mm = current->mm;
 
+add_page:
 	list_add(&page->list, &context->db_page_list);
 
 found:
-	db->dma = sg_dma_address(page->umem->sgt_append.sgt.sgl) +
-		  (virt & ~PAGE_MASK);
+	db->dma = sg_dma_address(page->umem->sgt_append.sgt.sgl) + dma_offset;
 	db->u.user_page = page;
 	++page->refcnt;
 
@@ -96,7 +132,8 @@ void mlx5_ib_db_unmap_user(struct mlx5_ib_ucontext *context, struct mlx5_db *db)
 
 	if (!--db->u.user_page->refcnt) {
 		list_del(&db->u.user_page->list);
-		mmdrop(db->u.user_page->mm);
+		if (db->u.user_page->mm)
+			mmdrop(db->u.user_page->mm);
 		ib_umem_release(db->u.user_page->umem);
 		kfree(db->u.user_page);
 	}
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index e156dc4d7529..45bc8928523a 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1259,8 +1259,9 @@ to_mmmap(struct rdma_user_mmap_entry *rdma_entry)
 
 int mlx5_ib_dev_res_cq_init(struct mlx5_ib_dev *dev);
 int mlx5_ib_dev_res_srq_init(struct mlx5_ib_dev *dev);
-int mlx5_ib_db_map_user(struct mlx5_ib_ucontext *context, unsigned long virt,
-			struct mlx5_db *db);
+int mlx5_ib_db_map_user(struct mlx5_ib_ucontext *context,
+			struct ib_udata *udata, u16 attr_id,
+			unsigned long virt, struct mlx5_db *db);
 void mlx5_ib_db_unmap_user(struct mlx5_ib_ucontext *context, struct mlx5_db *db);
 void __mlx5_ib_cq_clean(struct mlx5_ib_cq *cq, u32 qpn, struct mlx5_ib_srq *srq);
 void mlx5_ib_cq_clean(struct mlx5_ib_cq *cq, u32 qpn, struct mlx5_ib_srq *srq);
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 1b764a573dd7..997ea9bcfc55 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -918,7 +918,7 @@ static int create_user_rq(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 		ib_umem_num_pages(rwq->umem), page_size, rwq->rq_num_pas,
 		offset);
 
-	err = mlx5_ib_db_map_user(ucontext, ucmd->db_addr, &rwq->db);
+	err = mlx5_ib_db_map_user(ucontext, NULL, 0, ucmd->db_addr, &rwq->db);
 	if (err) {
 		mlx5_ib_dbg(dev, "map failed\n");
 		goto err_umem;
@@ -1056,7 +1056,7 @@ static int _create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 		resp->bfreg_index = MLX5_IB_INVALID_BFREG;
 	qp->bfregn = bfregn;
 
-	err = mlx5_ib_db_map_user(context, ucmd->db_addr, &qp->db);
+	err = mlx5_ib_db_map_user(context, NULL, 0, ucmd->db_addr, &qp->db);
 	if (err) {
 		mlx5_ib_dbg(dev, "map failed\n");
 		goto err_free;
diff --git a/drivers/infiniband/hw/mlx5/srq.c b/drivers/infiniband/hw/mlx5/srq.c
index bc22036d7e80..88db0143bc3f 100644
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
2.53.0


