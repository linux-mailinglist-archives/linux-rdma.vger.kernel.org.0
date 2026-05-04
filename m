Return-Path: <linux-rdma+bounces-19928-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAttGs6m+GnQxQIAu9opvQ
	(envelope-from <linux-rdma+bounces-19928-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 16:01:50 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C334BE5D5
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 16:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC2D8301CA4F
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 13:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5313DD519;
	Mon,  4 May 2026 13:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="qjAtYZrN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A073DDDD5
	for <linux-rdma@vger.kernel.org>; Mon,  4 May 2026 13:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903083; cv=none; b=kjhelgVzoFaeWArtn70EsEOdNvnZhB1bi/Nrfodtlwrmfmf6j4x/qEGSTYp68W0TfG9SvXDKdPq31K79w0rgYB/wtCK7Iqt+ikzhSALTGMBMzULarWFsVZ7VtAjy0Db4dmt/RylgC4X0YdyULE6xYygLRDvL37GMLiVIcd4Pxao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903083; c=relaxed/simple;
	bh=SB5QdHousMlditt2XIm1F0txb4id34IV2wjxconsSWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WnfV36pg7AWXo7QAngfpkYSdFvoDddExo5lW9bfnpj46Hzkx1wmbg39MhMJKw8hIjHTQs9n0zhLCTIVwU/RdmWaS61N1OBQ7+GlVfmeNSqGL7QYlmSpnKiotkXPs+5fNMwEEUY+4dapYETlAdNIpFtRObebFHctCNaR8CW0XVMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=qjAtYZrN; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so39343455e9.2
        for <linux-rdma@vger.kernel.org>; Mon, 04 May 2026 06:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1777903080; x=1778507880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WR2nxvQ9SAWP1acLAnK4um7ADSArZlKrWozWm4tmEWM=;
        b=qjAtYZrNmidnvzWqHPpf3TK8ReWMlpQgwh6tEBfub7pNt2OLH+qlaUarZQwHqu8fey
         G8qkBc3MqsRTlmAHl57g2vRs6e8nFu4UBv6Y1fcOPZYy5ZiLxqJwBDL4SKRUcF5Lqrt7
         TkYVkysTPtzvNjIGou0r/dA9eh9JpHoOny6n5U3BTmjms2kzykB0Uu+i1D0iK4KHhrTL
         z8OKUsX7Gj8ePodLSxVPN5pl3iKythx9fphCNxQf4vWb78SBS71hOYhXDc4XWsPLKqmZ
         2iOwrMCNQit1qFcKJ2RbgQDMuyZZx1AfqWw0HZVSZWSCn6G5g7Uq5XrDFzDTuVDKqTBk
         at7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777903080; x=1778507880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WR2nxvQ9SAWP1acLAnK4um7ADSArZlKrWozWm4tmEWM=;
        b=nkx3DolCCCHzwCvQpzuoNZDvaIaKl6gEU8ZlHkcEmhWdLaAvpiRg1h8fNdp5bJTQdZ
         fGHT3sN40bC22x8a3pK8E2c+CWQN5onIvrtwG+NLnigoPbrVjGM6jgYBZKF9HSZhW4Di
         cDfr7ta2H2blI+NTin3x+WBbJ+XV2HZD9Cv0POYLTnfKli5kyFQrv7A2bgZCjBrB621V
         QUyKTzHBKsAlhwYkReT9R8PHtF3gLM4NjtODuxFRJLWfBFAfsqabG/80QaxIv8n7S7Rq
         Kwl3Z7GewNzd/Fptc95eGLQ45Ph2wPGu7j7krNss5/hRnoHbwnra0EbucOllqndvTN+9
         dxbQ==
X-Gm-Message-State: AOJu0YyNRjesXU0RQ2xynRYN4r9GLvqxHzFvHRl1Wuq3rUPkJZEjIbCo
	AHUrmq+yLrbuWTqmAWHQgNf17zUhdUpRUqi8/4nFUaxjg6BW0cpU1RD6gPN2WpIuc3F4GBjTrjT
	1nGcmsbk=
X-Gm-Gg: AeBDievwxywzaVlVZJA13sTu5YGwtR/tSWj3Ww4O2YYwdpGO9tMoCNaC9LBGincmDLp
	jOdEeeDIWIimBxbtJGzoPyNy0U7tUNjOlEgedhbTZMPl34x4SNGB1mVV2wlBZ8GqVMowLSZHpzF
	/gV2jXOLrhSxRnaO/MXWFAEk3sAS9zcF2ESFxuMh/V8GPHi1XlOmPRWFlMC0BjgBUWyWOq+miR6
	yRbMhGZO90It6DeoSjFE2Vv0r+q0eMMVY+JVSQsWozL7uNROJks3tBjVZm/k2YEdvuxU/JwItXu
	T5vQ119rk3k8eCy2ZgufxyZfCuxbCksLFR0DByB7c7rdB0xCgKWljqUA95q/h3opok2VQLhmkvQ
	w33eXTWmp9PhuZirgHqpGPUBltSljxYtFvxzyy6U3BV13Zoc6IOnzyaAtFG5LKt58XUO94JliVt
	DVwzbK39mibWBjUlT8RhMrR7JE
X-Received: by 2002:a05:600c:5296:b0:489:1b10:d896 with SMTP id 5b1f17b1804b1-48d12f9147emr7937235e9.0.1777903079771;
        Mon, 04 May 2026 06:57:59 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb69698sm496201345e9.1.2026.05.04.06.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 06:57:59 -0700 (PDT)
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
Subject: [PATCH rdma-next v3 15/17] RDMA/mlx5: Use UMEM attribute for CQ doorbell record
Date: Mon,  4 May 2026 15:57:29 +0200
Message-ID: <20260504135731.2345383-16-jiri@resnulli.us>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260504135731.2345383-1-jiri@resnulli.us>
References: <20260504135731.2345383-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A7C334BE5D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19928-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[23];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20251104.gappssmtp.com:dkim,resnulli.us:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

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


