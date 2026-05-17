Return-Path: <linux-rdma+bounces-20825-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6L+kF49gCWrhXQQAu9opvQ
	(envelope-from <linux-rdma+bounces-20825-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 08:30:39 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E6C55F7ED
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 08:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 86230300BBAB
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 06:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF202D8771;
	Sun, 17 May 2026 06:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="HojIROu4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7CD2D5923
	for <linux-rdma@vger.kernel.org>; Sun, 17 May 2026 06:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778999431; cv=none; b=eFgUToJ8v0qPRPDbWCHSuxNWAGLB3dMI5y4I+IpX0GtHaiX3vFSUMda7NmBGdio4yZGtQhonBCoURv7bAn5cLJti410zShugyXgyI+V9vfQfVRglOBUiErnr1Gu13Hn5Jm/lGqtetVuBEoAai3mfJwOFPSP45OZ51HCka1BgXNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778999431; c=relaxed/simple;
	bh=ZMqTyRnTCzsON9OHANH5MpT0g9MPLYsldio1ggg0lcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kduLD1EqMZ9A0Krt1OdTV8fsB6DlZAFZnl6y7AJWtMReTGPdCyvAveI0vVU/kdSmGUv/JaSXwfayx8iN01L4HaH+XBf7vytwlKYuzpDE/dZcUQIGizMOBYvl/H9PYfyXld600xQ3fDiNvsY7FJ6oZAq4U2RLvyd0U7+c55GwLrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=HojIROu4; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43fe608cb92so571536f8f.2
        for <linux-rdma@vger.kernel.org>; Sat, 16 May 2026 23:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778999428; x=1779604228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vzSWl/1ZRYmCTt81altYqN83NNpNXZ7Aglx6vxSJwEM=;
        b=HojIROu4wzubUwHV9JSKZK+FWkaWUWhoVGO716oVPO9Y5MvO2VoM+3fo7IDpbBDZb2
         cQeyGr4yB54c9H57iJke2ZOb4bL4PlMeaP/MMjlmeyONdXxHFn7ON1MLVShwty0YpHiw
         vgJ89kv0cFw1IdSdQD+SKOzle679R/8G4PseKe44GZC7n6u6rkpSNdUm17nbDZW2ekDG
         ZwGhKrgrlPDDnNzMga+JjlUMS5eenjn8Y4TSBy1O12/STloDhXwMtdAVtlJRyFQutoGW
         lNAajNloUDD4YecWLW0B/vD39/cX7hnIReEYgO4RBkia7E0QGrzNXgYF7OWgwwfbOHcE
         c5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778999428; x=1779604228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vzSWl/1ZRYmCTt81altYqN83NNpNXZ7Aglx6vxSJwEM=;
        b=PeQl9gbov5HAtd+FLHGylPDi1C7gQbMX1e4RAEFe4lRbXkmZBxfXC+UJIlMTDU8bds
         lrRFrkfTVE0c5tvnjs/gmyXxy1Kmv0EYKLM+qflCa3aGzGEpsXkyygZTWmqyTBU5PUBw
         oxcHBRgbNFsQm+E5VZgAK7GF/HOXAAFhdWft38sAuX11kYyRAMlYnA54oERVtK1XO4WT
         ucQSln1lKTz/2uhjj+VBEH7VC504BJmUiCxxdmRfpwgRQ2XwLOAR8OC189D94MBHd9sl
         fm4Zg2lwlCnlBaK9MVkYVT80VkmQ+ojMGHmDXfemVnLW/I82TSu/vGAZuBRBTtbyZw5w
         BNFg==
X-Gm-Message-State: AOJu0YzyUFuWjKV7tuKlRBrGHNT2prq8URJbcEgQXfYxGPSih4JsRlrS
	piZagtV5+MzK9oQk0BneFGl1uIsFDKiStBR+fE5lKV0MC3AZkolnU5JqesGvvqQRQsFTzAnyLEJ
	vCRSMNF7I4Zmi
X-Gm-Gg: Acq92OG00D39wcY6IpINoJI9wYyZpJ/3nD3fYBT889nulZ61WdX6lmtWEl8BtrJ24Z4
	YNgmWhGGHMa6vAOJn1kJxga8J3zq7EkvHvsFYZpiZZlUOcZK9Ru/zuUfj2iiPFVKmGX0iGv+DDd
	bqT+kEoTvvpWerMV2tbGUNJoPmoT2CjTm4CaiGYWfvsGXb7rMAb1jyuVbR5nUoYu/eA5rpqbtqL
	iQ72PScAZZ6nT+p+ELo+77yvCps2T1T1q7yYpj+vvN97S+EVA/4/rWyV0foRtrfMRKCnEBQHk0A
	ro+tfx4iGYiQVFKaaiXfk+qdBKLd70A/W1nX4XC5dzQneXZ6wTT/kYKrdVZynq3IodQ0tPYdUw0
	S5mgIqPqMpIkQpChg9gS+FwAQYmF7+74EVioAEomdwJkXPDO9AxEzE55Kql4EJ+DN/cRseToAwB
	btuDO6NmF8KQQw98jyy0mnM+595jgWgyxVloAT9e+Gw2/9kABCgcWcvyaI
X-Received: by 2002:a5d:6311:0:b0:45e:73a5:e7f4 with SMTP id ffacd0b85a97d-45e73a61c59mr1294034f8f.37.1778999428436;
        Sat, 16 May 2026 23:30:28 -0700 (PDT)
Received: from localhost (46-13-72-179.customers.tmcz.cz. [46.13.72.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e768acesm29115630f8f.7.2026.05.16.23.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 23:30:27 -0700 (PDT)
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
Subject: [PATCH rdma-next v5 14/15] RDMA/mlx5: Use UMEM attribute for CQ doorbell record
Date: Sun, 17 May 2026 08:30:05 +0200
Message-ID: <20260517063006.2200680-15-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260517063006.2200680-1-jiri@resnulli.us>
References: <20260517063006.2200680-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 42E6C55F7ED
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20825-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[23];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:mid,nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

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
 drivers/infiniband/hw/mlx5/doorbell.c    | 95 +++++++++++++++++++-----
 drivers/infiniband/hw/mlx5/mlx5_ib.h     |  5 +-
 drivers/infiniband/hw/mlx5/qp.c          |  4 +-
 drivers/infiniband/hw/mlx5/srq.c         |  2 +-
 include/uapi/rdma/mlx5_user_ioctl_cmds.h |  1 +
 6 files changed, 90 insertions(+), 25 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index 04917e454d29..77005895b876 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -761,7 +761,9 @@ static int create_cq_user(struct mlx5_ib_dev *dev, struct ib_udata *udata,
 		goto err_umem;
 	}
 
-	err = mlx5_ib_db_map_user(context, ucmd.db_addr, &cq->db);
+	err = mlx5_ib_db_map_user(context, udata,
+				  MLX5_IB_ATTR_CREATE_CQ_DBR_BUF_UMEM,
+				  ucmd.db_addr, &cq->db);
 	if (err)
 		goto err_umem;
 
@@ -1520,7 +1522,9 @@ ADD_UVERBS_ATTRIBUTES_SIMPLE(
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
index 020c70328663..437d99621320 100644
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
 
@@ -90,13 +125,37 @@ int mlx5_ib_db_map_user(struct mlx5_ib_ucontext *context, unsigned long virt,
 	return err;
 }
 
+int mlx5_ib_db_map_user(struct mlx5_ib_ucontext *context,
+			struct ib_udata *udata, u16 attr_id,
+			unsigned long virt, struct mlx5_db *db)
+{
+	struct ib_uverbs_buffer_desc desc = {
+		.type = IB_UVERBS_BUFFER_TYPE_VA,
+		.addr = virt,
+		.length = sizeof(__be32) * 2,
+	};
+
+	if (udata) {
+		struct uverbs_attr_bundle *attrs = container_of(
+			udata, struct uverbs_attr_bundle, driver_udata);
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
index bd4e5971720c..f9f9bf1499d3 100644
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
@@ -1052,7 +1052,7 @@ static int _create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
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
2.54.0


