Return-Path: <linux-rdma+bounces-19240-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMlaNOlf2mlQ0wgAu9opvQ
	(envelope-from <linux-rdma+bounces-19240-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Apr 2026 16:51:21 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3416F3E0723
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Apr 2026 16:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E23BB300E38D
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Apr 2026 14:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A8338736B;
	Sat, 11 Apr 2026 14:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="cfd74Be4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3D0385520
	for <linux-rdma@vger.kernel.org>; Sat, 11 Apr 2026 14:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775918978; cv=none; b=tcPGZkGxjaOfSsDx9tQ8GtWajRcVOpHKWYi/HgS386yMELLhKjyTQ3Jh8TVLMkX//QYqV62/MtmpYKUHi2pGS9PS/dXcp5dhLTBgtAWgGoMP3tuEVfRSte1GZIeF9lzObS5FaS2WSn9Rvt3j6sr+01wVDZEYh0s9qdDnAbbK/zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775918978; c=relaxed/simple;
	bh=9eXJH4XO8H4K+3AzCd4CwiGL3YCrexmMoenG2goVRog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M009cqo0ZNWV1gzMIDM/5ouDIm87TBWf/gNsXjz1pTHUu6N/8pH3WrgpwL0grL+Udhy1aPzILA8tCRACbJtxJNwrkIA5d/Anm68jCxXOfOmnwSSlNrxJbIbOeK0BJAZh46DCx7pA2nKXwMc3BHB0hpAxOw3Nzfimr7xVz80JqMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=cfd74Be4; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4887ca8e529so19105255e9.0
        for <linux-rdma@vger.kernel.org>; Sat, 11 Apr 2026 07:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1775918976; x=1776523776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SAz7hXu9vKuzZeDEmBci/JVg0w//cZlQzDnW/Tq0AuU=;
        b=cfd74Be47C+Bg97wXXBEUXb6U/hkuff7Z4z1aF5nFyTc6gyUYABF3xbLvuvCR4CLj4
         qVfjk80eL6wkMgzfWA7VWXluG2JytlKFCMJOqhyRug2ONlSGBB6H6WWW7rYb2u7BZ/aI
         Tsa3U3n/pHL7uKOl9fGJnqe7KyHCKAwUdXFtagWOhAWRLjIxRRhVpDHozwr3RvXduhZ2
         7EnJ7xM6c3I+sRBLkqo2kUHnD1Z43L9KIUbC21ltWwfoDO61iIJRC8egcLoQUhsyM4+q
         5uFTJfOm014u4WcMjhAM7wT9uq8TrEVSymvERfMi5PZhtoa8EPYZdK+/SJoZDePTjbF9
         ffxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775918976; x=1776523776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SAz7hXu9vKuzZeDEmBci/JVg0w//cZlQzDnW/Tq0AuU=;
        b=hwdSYF+DduzlXJY5oVcKlSTCUKWHfA4lOAtT99NMlbHC/XY+QKftINIVzz697aY6qL
         2Vf+uTWNz9QRMvUB/29IkyGbqyPb5vfS93q+ynj+onm3IpZxzrv5x/QbBUugVL4oh5CP
         hDiM0tB+jUDyBZDYuH7SkjAr/pd6wzsEZ/WB9pf87FOkOvnROOyd7iIXB7bdtOM1c1z3
         v1/Ima/T8OZ9cUQHiR07PonDqyJwT/xvlMJpQDxM2R6T2lQwFJGYlJ3Ou94Qiq0z7V/y
         1ZvMs8MxND/TmBx2LeFrzhzsysiUqs3HJ5CyLHBDpEsD/orY73XlFVi6Wd/pDvBRtrho
         bNzg==
X-Gm-Message-State: AOJu0YyT6q5wJLuePi6xF9vbhPLZHwrHeH5IAaGgPo5zKreQXnccblqz
	BMlc7nbp0+k/ArfTcWVFRlZbqmdcDKADBez4Iz4QJ+jl/qZPpmaJfY6tBf+VumsYqKOlA47bS5S
	TtOJc
X-Gm-Gg: AeBDietfeQvmuYHTAhJvol8xDVUUff4Sx2J8QoRDa6Fr2x01biTn8EWc5W2BJAFTjxW
	Lq+rXwVGdCUlC05JnrxmepSbfhwHqcjd1MqtxefAbpuLCrw6iD6n2LF56kfRdCOE94f6U31r5/n
	giAu1tw9b3mYxhjw3dGRkv/1jJCyn9ApzPyYSelZcxngOnN2fIOXeMnc8L12QLOaJfbTOBpsuZX
	ve70ZB9EdgSgaVZ1wryI51PfgU6doSPfIcbcYuKDMxxHuOcNl0i1DKgxYOa0oJwzy9objO8vZiC
	iFowtajBnFQxEwrqf8vePf3d3/WkbAOKs5cOGTXGAF9Th9UR1B8dWETDTFpfzUh2se3NEFMlNL2
	IKHIfutvFM+uYhjnMZfMGC0uouJ/Hr23iWUbTQ+VDYiNEEXpEzLucKWz4DeYQN7bmsBmaeHkcw6
	bohlw5SMaCLIX1khw3/Z26hiKwHdNOj5FrgXT7dMK3dbg=
X-Received: by 2002:a05:600c:8717:b0:477:9890:9ab8 with SMTP id 5b1f17b1804b1-488d6816f5amr95822525e9.3.1775918975658;
        Sat, 11 Apr 2026 07:49:35 -0700 (PDT)
Received: from localhost (78-80-9-176.customers.tmcz.cz. [78.80.9.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d6881ea1sm46896525e9.33.2026.04.11.07.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 07:49:35 -0700 (PDT)
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
Subject: [PATCH rdma-next v2 13/15] RDMA/mlx5: Use umem_list for CQ doorbell record
Date: Sat, 11 Apr 2026 16:49:13 +0200
Message-ID: <20260411144915.114571-14-jiri@resnulli.us>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411144915.114571-1-jiri@resnulli.us>
References: <20260411144915.114571-1-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19240-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[23];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20251104.gappssmtp.com:dkim,resnulli.us:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 3416F3E0723
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
index 6118deb5e6dc..ef36417a3c65 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -759,7 +759,9 @@ static int create_cq_user(struct mlx5_ib_dev *dev, struct ib_udata *udata,
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
index ba5b41fa5ef9..3edfe44f911a 100644
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
index 852f6f502d14..d4dbbd5a500f 100644
--- a/drivers/infiniband/hw/mlx5/srq.c
+++ b/drivers/infiniband/hw/mlx5/srq.c
@@ -74,7 +74,7 @@ static int create_srq_user(struct ib_pd *pd, struct mlx5_ib_srq *srq,
 	}
 	in->umem = srq->umem;
 
-	err = mlx5_ib_db_map_user(ucontext, ucmd.db_addr, &srq->db);
+	err = mlx5_ib_db_map_user(ucontext, ucmd.db_addr, NULL, 0, 0, &srq->db);
 	if (err) {
 		mlx5_ib_dbg(dev, "map doorbell failed\n");
 		goto err_umem;
-- 
2.53.0


