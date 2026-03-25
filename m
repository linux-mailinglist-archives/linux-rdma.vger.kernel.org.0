Return-Path: <linux-rdma+bounces-18632-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGd/EFn9w2lXvQQAu9opvQ
	(envelope-from <linux-rdma+bounces-18632-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 16:20:57 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7D5327CB3
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 16:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E3B63305805E
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 15:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490753D666F;
	Wed, 25 Mar 2026 15:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="OUJ2ARx5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644DB401A2D
	for <linux-rdma@vger.kernel.org>; Wed, 25 Mar 2026 15:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774450874; cv=none; b=pUl9RGQOzYVi6kLxOufX8RJJZ5/DoP2Fg6aDAXvAfidP+f6KcQIt2ppx5LIxzcrZpeXoPZNdIE+TiP9WW1eDOrPaUX5q+E1KYb7S5j3LVi68raR1hp8pGHl1p//yUgRMQHzdMeao6NzOlP0VV6ieyNxe8LrrNOh8ToLixfzD2ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774450874; c=relaxed/simple;
	bh=TRU7MtkM2pCULjsWJUDIEnTu5LrHIUF6cm9tofzhRzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X7WjGVevMLiFQm6NVR2Xhk0QSoCLZuT3Sdlq0L5JpmJMc7MColeVbBHUCY2QbeJ8W8Wx333uafk9L2ElED0X4tIwgMeuCo/AubxdabsLloJ4RVXC4yWIKCDceZS3ZyVdINb3kYztFlJXaCm2RRc2HvJLFCCjJ+7ByCMGLbld48U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=OUJ2ARx5; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43b5bded412so1991192f8f.0
        for <linux-rdma@vger.kernel.org>; Wed, 25 Mar 2026 08:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1774450871; x=1775055671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vc4PU4ai3h3waBnkKa34tQ/WruB7MC0Kv7pKMK/9oO8=;
        b=OUJ2ARx57I2u8KUbJeYQGE1QMaNokQ7/Glk0E6+AYcVncdLI6YFA7wWfYkCEBA8ccb
         SN7WDYOPY4AypkFqM8v22U2dG0xa8Cqc27mm4eoAB7Ya+JqazYL3T8lwyqOHMt2gjiXl
         4qSwVxoCcjQ32iofU+obyWOMDQqPk/xiPktCUKu0mKBWUXI9emu+KSjzH1VmLYPJCZGW
         A129ZZOjhkjf1nI2JFu3ZEgiXA0MWP395sA2rWneU1CRmE8ZxKeu9SaMoYrhO5IuqVtn
         2b424Cwqe7XU368+IdIb0Jb0MmMXVA87RWg3e9eVeOgJMHJqzcvHJhgZ9R3iAP9FuQQ/
         AZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774450871; x=1775055671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vc4PU4ai3h3waBnkKa34tQ/WruB7MC0Kv7pKMK/9oO8=;
        b=kTcSoi2zP5G/y0S+7D6skBUWPUiH6F2vL85nNt1wbaWhz9LEVuQg8PD7KeWsQ/P+LO
         AL24Efyi7fORtPKEpFgvrJorUHOk/oJ3TBD00SumDwyViDVYRLi0MokqHc4tAMloVQS6
         ZTfstbiqGGyt1dHeii7Mb9E8fwDOfjrF7nMKcdWP5AkKilHh1vICBUh80CsN9dPUPzUE
         HpkfmxsVVTILqqAFVL7zVJjCgrw9blL6gNFGaCEB35fUnGlKji2ZUVqdUXeYym7F+fDi
         UPDJNhDt6wbWRCPJ3ExLGfo7HCbO4F2o1ttyd3hQsJcQxPf8uN8VeS80ZdbX8J7kNJnL
         6NSA==
X-Gm-Message-State: AOJu0YxHpIhLrdvSzGkhPqOk2GONYPu7q5m8JxYlt7v5WMTfKaza2Uo9
	I5NQTI5c5qnxipqZB1RM97yYXywZUqs95hn4S4516I4uJXv8poXCsagL5dl8lNoyQmM8BKUUpnQ
	VrzCa5X0=
X-Gm-Gg: ATEYQzwliZDwG6o5tlYnoEuxfNprDN2ZzqRqU0S9pjAirNyX9D84QBGh687Xrhg3KUE
	uGc0aij+pkBuVpYE63pZo5xewfR5IVM1Np5pQk6V+42qaf5jYwJargSdy3EsnnWp3znQn1OP4Ff
	36bs9xuZ+PXHpBHUu2UNxtWxmFjcA36nafGUFowJIsePpqgLjk44KXq4Y2dv3P68qnmsjVKdNrl
	kzpArLGWYklhzJr8omMMKtUTmGmkGv4nBFcqOm09Zq6LtuOnbm/xUw2H1Fj5SyW9c1ixfRZLHip
	3CUl4KhE5bPexZ0aF1uqVK1LIGeQLfOkKWzC3VoJV52MM3Z7JfUHFEmQGhZ3kJOKtUUGWqfYgl7
	JpY39hCwABm2F8j6RqOh4IokGh5UNWTzvdNOL7VHMO6xaTD+iPe6rhcxsePlejT75m9Edwy0she
	2npC8x2yhs05S78w==
X-Received: by 2002:a5d:5f93:0:b0:439:b4dc:1e1e with SMTP id ffacd0b85a97d-43b88a0558cmr5886707f8f.29.1774450870334;
        Wed, 25 Mar 2026 08:01:10 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919cefd7sm284941f8f.17.2026.03.25.08.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 08:01:09 -0700 (PDT)
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
	wangliang74@huawei.com,
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
Subject: [PATCH rdma-next 13/15] RDMA/mlx5: Use umem_list for CQ doorbell record
Date: Wed, 25 Mar 2026 16:00:46 +0100
Message-ID: <20260325150048.168341-14-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260325150048.168341-1-jiri@resnulli.us>
References: <20260325150048.168341-1-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18632-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[24];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,resnulli.us:mid,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: CF7D5327CB3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiri Pirko <jiri@nvidia.com>

Load the doorbell record umem from the umem_list, falling back to
ib_umem_get() for the legacy path. Pass the umem_list and a
per-command slot index through the doorbell mapping infrastructure.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/infiniband/hw/mlx5/cq.c       |  4 ++-
 drivers/infiniband/hw/mlx5/doorbell.c | 41 +++++++++++++++++++++++----
 drivers/infiniband/hw/mlx5/mlx5_ib.h  |  3 +-
 drivers/infiniband/hw/mlx5/qp.c       |  4 +--
 drivers/infiniband/hw/mlx5/srq.c      |  2 +-
 5 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index 29cb584692c1..7f64c827051f 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -763,7 +763,9 @@ static int create_cq_user(struct mlx5_ib_dev *dev, struct ib_udata *udata,
 	if (!page_size)
 		return -EINVAL;
 
-	err = mlx5_ib_db_map_user(context, ucmd.db_addr, &cq->db);
+	err = mlx5_ib_db_map_user(context, ucmd.db_addr,
+				  cq->ibcq.umem_list, UVERBS_BUF_CQ_DBR,
+				  sizeof(__be32) * 2, &cq->db);
 	if (err)
 		return err;
 
diff --git a/drivers/infiniband/hw/mlx5/doorbell.c b/drivers/infiniband/hw/mlx5/doorbell.c
index bd68fcf011f4..a1c5851aba10 100644
--- a/drivers/infiniband/hw/mlx5/doorbell.c
+++ b/drivers/infiniband/hw/mlx5/doorbell.c
@@ -40,25 +40,51 @@
 struct mlx5_ib_user_db_page {
 	struct list_head	list;
 	struct ib_umem	       *umem;
+	struct ib_umem_list     *umem_list;
+	unsigned int		dbr_index;
 	unsigned long		user_virt;
 	int			refcnt;
 	struct mm_struct	*mm;
 };
 
 int mlx5_ib_db_map_user(struct mlx5_ib_ucontext *context, unsigned long virt,
-			struct mlx5_db *db)
+			struct ib_umem_list *umem_list, unsigned int dbr_index,
+			size_t dbr_size, struct mlx5_db *db)
 {
+	unsigned long dma_offset;
 	struct mlx5_ib_user_db_page *page;
+	struct ib_umem *umem;
 	int err = 0;
 
 	mutex_lock(&context->db_page_mutex);
 
+	umem = ib_umem_list_load(umem_list, dbr_index, dbr_size);
+	if (IS_ERR(umem)) {
+		err = PTR_ERR(umem);
+		goto out;
+	} else if (umem) {
+		/* External umem path - no page sharing */
+		page = kzalloc_obj(*page);
+		if (!page) {
+			err = -ENOMEM;
+			goto out;
+		}
+
+		page->umem = umem;
+		page->umem_list = umem_list;
+		page->dbr_index = dbr_index;
+		dma_offset = ib_umem_offset(umem);
+		goto add_page;
+	}
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
@@ -76,11 +102,11 @@ int mlx5_ib_db_map_user(struct mlx5_ib_ucontext *context, unsigned long virt,
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
 
@@ -96,8 +122,11 @@ void mlx5_ib_db_unmap_user(struct mlx5_ib_ucontext *context, struct mlx5_db *db)
 
 	if (!--db->u.user_page->refcnt) {
 		list_del(&db->u.user_page->list);
-		mmdrop(db->u.user_page->mm);
-		ib_umem_release(db->u.user_page->umem);
+		if (db->u.user_page->mm)
+			mmdrop(db->u.user_page->mm);
+		ib_umem_release_non_listed(db->u.user_page->umem_list,
+					  db->u.user_page->dbr_index,
+					  db->u.user_page->umem);
 		kfree(db->u.user_page);
 	}
 
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 94d1e4f83679..f68f8466e60a 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1261,7 +1261,8 @@ to_mmmap(struct rdma_user_mmap_entry *rdma_entry)
 int mlx5_ib_dev_res_cq_init(struct mlx5_ib_dev *dev);
 int mlx5_ib_dev_res_srq_init(struct mlx5_ib_dev *dev);
 int mlx5_ib_db_map_user(struct mlx5_ib_ucontext *context, unsigned long virt,
-			struct mlx5_db *db);
+			struct ib_umem_list *umem_list, unsigned int dbr_index,
+			size_t dbr_size, struct mlx5_db *db);
 void mlx5_ib_db_unmap_user(struct mlx5_ib_ucontext *context, struct mlx5_db *db);
 void __mlx5_ib_cq_clean(struct mlx5_ib_cq *cq, u32 qpn, struct mlx5_ib_srq *srq);
 void mlx5_ib_cq_clean(struct mlx5_ib_cq *cq, u32 qpn, struct mlx5_ib_srq *srq);
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 7d42eda81794..318ab6f346e8 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -918,7 +918,7 @@ static int create_user_rq(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 		ib_umem_num_pages(rwq->umem), page_size, rwq->rq_num_pas,
 		offset);
 
-	err = mlx5_ib_db_map_user(ucontext, ucmd->db_addr, &rwq->db);
+	err = mlx5_ib_db_map_user(ucontext, ucmd->db_addr, NULL, 0, 0, &rwq->db);
 	if (err) {
 		mlx5_ib_dbg(dev, "map failed\n");
 		goto err_umem;
@@ -1062,7 +1062,7 @@ static int _create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 		resp->bfreg_index = MLX5_IB_INVALID_BFREG;
 	qp->bfregn = bfregn;
 
-	err = mlx5_ib_db_map_user(context, ucmd->db_addr, &qp->db);
+	err = mlx5_ib_db_map_user(context, ucmd->db_addr, NULL, 0, 0, &qp->db);
 	if (err) {
 		mlx5_ib_dbg(dev, "map failed\n");
 		goto err_free;
diff --git a/drivers/infiniband/hw/mlx5/srq.c b/drivers/infiniband/hw/mlx5/srq.c
index 17e018554d81..6c3a850470e0 100644
--- a/drivers/infiniband/hw/mlx5/srq.c
+++ b/drivers/infiniband/hw/mlx5/srq.c
@@ -83,7 +83,7 @@ static int create_srq_user(struct ib_pd *pd, struct mlx5_ib_srq *srq,
 	}
 	in->umem = srq->umem;
 
-	err = mlx5_ib_db_map_user(ucontext, ucmd.db_addr, &srq->db);
+	err = mlx5_ib_db_map_user(ucontext, ucmd.db_addr, NULL, 0, 0, &srq->db);
 	if (err) {
 		mlx5_ib_dbg(dev, "map doorbell failed\n");
 		goto err_umem;
-- 
2.51.1


