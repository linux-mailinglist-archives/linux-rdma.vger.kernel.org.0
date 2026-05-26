Return-Path: <linux-rdma+bounces-21318-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFPFJQ21FWpxYAcAu9opvQ
	(envelope-from <linux-rdma+bounces-21318-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 16:58:21 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 959D25D828F
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 16:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 21C7B307183F
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 14:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BCF400DEB;
	Tue, 26 May 2026 14:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="e1oS92RR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2ED400E0B
	for <linux-rdma@vger.kernel.org>; Tue, 26 May 2026 14:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779806569; cv=none; b=q5citzYYGQMalvuV/Y911BwckXWHiIu5pxjcO1xqtRF3AYAmJMFcTt3/dhFxD/fUXbyQ38sY2qb5psJX9zywBA3gNfREmNGL/Q/esMpQCwPy0sT6IWbYzFNGg3ji07IRZE/CNcjnrjrU8JltSLBhHvznu0d+DgHvd25KkD/TR2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779806569; c=relaxed/simple;
	bh=gCmBIGWfMMTfFjAbhZB4UtETUyzQm4uIxJ8qcA9bqkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fxcvTcy2+wbrmrL4x++NFZvGMCiG5DShoaqEq9eV3nQVoGAlrT5P9STH970fBLcHthIHVn98Za1rOZcujxXvCO7w/C4cjZKgYeoR/x7jKdmQICgSoOqMIo+uNJKLWptpavDtSfJlIbMRbzeID77p2HKEbejhno1AqQaUNNUAjNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=e1oS92RR; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-44dd5cb0f81so7665504f8f.0
        for <linux-rdma@vger.kernel.org>; Tue, 26 May 2026 07:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779806566; x=1780411366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Db22UDEfVqdoooR5TLw2VHfejFh6/Z68awKlDrIBgI=;
        b=e1oS92RRwCLG/xGHrmOBbohYcPlGleJbNi+cBmTiQNxO/36YVOGBh9wDPCJzQcNJM0
         7SBLKHw4vgDdh8XmvXibAjMpz6+a657zc1ZPB5JvYGu3sTXQIhOHagc+TnYHa/aOpYdR
         I8sRolrYTDENvhnjU98yMH4JS6uIkCb6FMyOZl+w1iyOXX59QisIhldf9HItw4zwQZIm
         z4s1rnHxvCkGQxOvrZ9mSw7/lYKTjhsDhR0TN92lXkcWdsPQP+9Rv5frL4q/Uz/rvyaa
         NYVHd/APUMOMxXtqWaf0pAbx04mlNY2g+pUO8y/IGZOs+9X+TIPNEPqmTmj6zIGWfd74
         ts2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779806566; x=1780411366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3Db22UDEfVqdoooR5TLw2VHfejFh6/Z68awKlDrIBgI=;
        b=PZeGskQWigjp87EIGozS3MIya8bU+gBLW26vNOhEWW3PpGrmBTSFt2F0yOJwz3+1Cw
         LTqC9pVmu5RfpW3qoYGaukU65ozQGRCYmhKQgM0XkNMT9/ZtHF4lXGEFtE5uMC0gS0Bi
         c6UDdnNzpzgBwLlHqOK5x3Q0JdwOcBE5poc+CFveUZsshin7Ecrq5i1kEmUPrZd2vacG
         XzU9o33ifU6ZRyXNR0jUog49gwSOQzbMJazC4/qsto3nVJaz0DillRomHHZ4aGWhhuaT
         7ukB1AI25D+KhK2m1V4ZKldqXwwcojOL/jubaLSWmYiC5VRw+7C2NWGFzIha+b2s1Vjh
         THJw==
X-Gm-Message-State: AOJu0YwemLCPK6AYXfSj8DgOZ6g+Nng/LDP9o9fI1XoXNg1SKNiDqsZC
	R5KE0U4c93tf6oa43ugt8uq4haRlKwFO2v5EpffBLSEVxG3TcxDaHFIVztlmmblfXiRAFFNu30Q
	ZwFZtr6Bt6Q==
X-Gm-Gg: Acq92OH3UjQPDIpjUpUhg1yIckBGcB9i2o6L+f4lw2X7TFa/jveh+qZzBiaNsBBAf3o
	wwWItZhEZp9itF6khaJHq8u97m/g95BzLwddI+pYLAI0bSWZYC4uI6XFPIvhO1XLWhWDPNpa7sU
	AAnTEQuIUwaMWJGAww2ngnH5jNpsRvUsk0o1YSqaVzsNtbItfQj7vJ/awqBxByQM5RcYs4ELeB3
	5nEu0KgMJNIm+RnZZbbXj9yxkvrGwT1hKibL1ZQjIpfEksrjBnVTunQspsrUu613WjS3HMu3EF5
	jn8zcSRMLiWAqRCMNmX0EqP1OJpJXE3mnBnWwKD4GTLiYFMd+O+us3x0QcO3yaRjmTHTPZesKQJ
	CD9nN1233LofKWbv1f/ZJLvtfB23SKDcRDA8n6XdC7h9G/MNQ9wVnxmQ6J5DxZO0YuxthIRD5R0
	M0APL5I3Z7Wg+UvuQNUaDa6s0tA5LdKfg3b8edjfARnCE=
X-Received: by 2002:a05:600c:4746:b0:490:3d48:6cb9 with SMTP id 5b1f17b1804b1-4904225f7efmr292533825e9.3.1779806566250;
        Tue, 26 May 2026 07:42:46 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6c9b980sm33053496f8f.3.2026.05.26.07.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 07:42:45 -0700 (PDT)
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
Subject: [PATCH rdma-next v7 14/15] RDMA/mlx5: Use UMEM attribute for CQ doorbell record
Date: Tue, 26 May 2026 16:41:51 +0200
Message-ID: <20260526144152.1422310-15-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526144152.1422310-1-jiri@resnulli.us>
References: <20260526144152.1422310-1-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21318-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 959D25D828F
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


