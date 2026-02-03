Return-Path: <linux-rdma+bounces-16428-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJ7RLA63gWmEJAMAu9opvQ
	(envelope-from <linux-rdma+bounces-16428-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 09:51:26 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30122D666E
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 09:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 103D5301E7C9
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 08:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC39396B86;
	Tue,  3 Feb 2026 08:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="uqa1XPcv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FAB39525B
	for <linux-rdma@vger.kernel.org>; Tue,  3 Feb 2026 08:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770108618; cv=none; b=rsAPKJQtb04SWgaFnL61eUuqBZEoDtiIWAnn6uXZQk+sX0s1LKdm9nNrO+NDnBpfpGW1yZ/o4PJoveYVckXOv/80kwZGD0JEfZuLQxSJCoqMqNAzPkSQ0J4Fqh9B6LOsflH6KN6NcXLNTJOwOvHW4y+244kVKIcDIYH9ILkVNqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770108618; c=relaxed/simple;
	bh=thmjEzipbsjZTPS3Iz1o4D0dtmBJ1vqpcMgKHU+CDbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZwhNM5lJHypfQmKO+6g1oD97G9K8tNjHuxq0jIDb7spf6UWXigh0s9h1LO4FsYHjr+fPr3e4iH/W2/wPnbCGiPKg27EKNoEh5xJTPkJsIcsfOE/iDThJ5gFuSo18WdIJvUKdRnvQ0YQz3LOJSqUaw2Zv/NAYBtEklL+DoMg3W5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=uqa1XPcv; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4806cc07ce7so53484175e9.1
        for <linux-rdma@vger.kernel.org>; Tue, 03 Feb 2026 00:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1770108615; x=1770713415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HfJ0ndLVYs20J7yXWln1bTSziIm6gV3xEaESOi3uO34=;
        b=uqa1XPcvJaElKuuHaH5CvOMMnnSThZKQ0N/x+lFOY8kTVwYHNvCWzwmcmwQxYrWCJz
         bu+clVAS+F0ZW9SjaYZrztnOH++uv5599ghUzhwHdxIkjZERZuYgI6j1SimjLiey0j2y
         L6Otye5RR3rxLqRTT/TiZIYzCZTfcGQd4ky3LQKnmXvwG7DuVuLHhATNtMZXTE+W1RQ5
         VrAHXL+rrpVlXprVsL+Rdnux9QUKVqtdw8jkUn6H+dqId+4JJmPO7Fsx2Sq9oMtbbwYD
         BlSoGDMxZKRWt6b/qKfoPGpV3+83kIIHID+Rnb94M/r+52k4g/jl0/p9qUPh3uZ//s8w
         /AwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770108615; x=1770713415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HfJ0ndLVYs20J7yXWln1bTSziIm6gV3xEaESOi3uO34=;
        b=ObHguUL94TbVqXaAYDxvoVhMt03mxcEUTD9QsN6hbBmUrGB6k4sMaG9KTjdr/hGCc+
         a4Bb6S7SDEuUGiy4LfBM0CM8pAu8EV5Z0wrbs1lvO33UbtWfJkFb9csgMRP5HUQArzOd
         V5oZGM1Jum1lBOWRT5bvUt4uF6FREnC4fd89+d9h2R002kkW7J8Wbfeshrn+rXs5JsBj
         doqhi1RYcCuwpKcGXhkh/mnvkv5Nt1Z+EObcNuwSt4OPrr0Fq6SZRgiw+s/Rd8hm4cb/
         EXz0wCNOYYv25IDI5vph5CU7vztFaIZrQvVqC3dBgn5hyshb3aBLhfqEQwyaUCpl7RNl
         JAFA==
X-Gm-Message-State: AOJu0YwrOapU39XouRS5fRRGDRSF3s6X3M1TJ0RxVdvYN8KNGhBBAz7G
	RIlN4qNA5U3JZ92KvhPfPexGqaId2rDtJR9sSv4zt7wxZAWJmYdJr/Fy8PKjRpiwE3rgpq8tizx
	u93dk
X-Gm-Gg: AZuq6aLDnSPFpPB9FgGh7hZAQG9NH066D3zx3wvjX3wt4wH60wpXzdYTzgMqrmVLHqV
	52caU0NUDmFZUEQCng6+wDt2EROoj1F4owHYNs9r/NOZun9vp+CzgVjCt1DwpkehF9sAxBKTF0q
	4Rw0S00Rd1VglqF+jYhfV/2ZbFs28tZFjlSJoTgfFhgUWP5GC7Lcn8aolZ1nL4oNoNen8kq66jl
	jX4Gq3AhMtb7sabLNnWAhYcHnDw1brWDDIIt5pgi00P/LB/YjNJx/C8lDmXblyZX+VhXTmyS/P+
	wXD2I6uAzeonBk/DmBdv7nLEZ9bIYiW4HSEobJ2xNxr2htjNqqksYr+COq6APcT9vDlvJ3PGga6
	8U2Wn1AjWj0hFAx90pMlR1+d7TZs46Z2znMRqLZkBHQcXrglAeU9509Xm+mzD4gczdakV6OZRh6
	3nVQ==
X-Received: by 2002:a05:600c:19cc:b0:477:9814:6882 with SMTP id 5b1f17b1804b1-482db459292mr191840785e9.5.1770108614854;
        Tue, 03 Feb 2026 00:50:14 -0800 (PST)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482da8eb486sm138730365e9.2.2026.02.03.00.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 00:50:14 -0800 (PST)
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
Subject: [PATCH rdma-next 08/10] RDMA/mlx5: Add external doorbell record umem support for CQ
Date: Tue,  3 Feb 2026 09:50:00 +0100
Message-ID: <20260203085003.71184-9-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260203085003.71184-1-jiri@resnulli.us>
References: <20260203085003.71184-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16428-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[24];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20230601.gappssmtp.com:dkim,resnulli.us:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 30122D666E
X-Rspamd-Action: no action

From: Jiri Pirko <jiri@nvidia.com>

Extend the mlx5 doorbell mapping infrastructure to support externally
provided doorbell record (DBR) umem buffers. This enables userspace to
pass pre-pinned DBR memory for CQ creation.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Change-Id: Ic2abbd048da9eb0d691423a7df97630a6a7f5e67
---
 drivers/infiniband/hw/mlx5/cq.c       | 12 +++++++-----
 drivers/infiniband/hw/mlx5/doorbell.c | 27 +++++++++++++++++++++++----
 drivers/infiniband/hw/mlx5/mlx5_ib.h  |  2 +-
 drivers/infiniband/hw/mlx5/qp.c       |  4 ++--
 drivers/infiniband/hw/mlx5/srq.c      |  2 +-
 5 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index 35c51a91e8c4..3afcb81e53d4 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -718,7 +718,7 @@ static int mini_cqe_res_format_to_hw(struct mlx5_ib_dev *dev, u8 format)
 static int create_cq_user(struct mlx5_ib_dev *dev, struct ib_udata *udata,
 			  struct mlx5_ib_cq *cq, int entries, u32 **cqb,
 			  int *cqe_size, int *index, int *inlen,
-			  struct ib_umem *ext_umem,
+			  struct ib_umem *ext_umem, struct ib_umem *ext_dbr_umem,
 			  struct uverbs_attr_bundle *attrs)
 {
 	struct mlx5_ib_create_cq ucmd = {};
@@ -775,7 +775,7 @@ static int create_cq_user(struct mlx5_ib_dev *dev, struct ib_udata *udata,
 		goto err_umem;
 	}
 
-	err = mlx5_ib_db_map_user(context, ucmd.db_addr, &cq->db);
+	err = mlx5_ib_db_map_user(context, ucmd.db_addr, ext_dbr_umem, &cq->db);
 	if (err)
 		goto err_umem;
 
@@ -962,6 +962,7 @@ static void notify_soft_wc_handler(struct work_struct *work)
 static int __mlx5_ib_create_cq(struct ib_cq *ibcq,
 			       const struct ib_cq_init_attr *attr,
 			       struct ib_umem *ext_umem,
+			       struct ib_umem *ext_dbr_umem,
 			       struct uverbs_attr_bundle *attrs)
 {
 	struct ib_udata *udata = &attrs->driver_udata;
@@ -1001,7 +1002,8 @@ static int __mlx5_ib_create_cq(struct ib_cq *ibcq,
 
 	if (udata) {
 		err = create_cq_user(dev, udata, cq, entries, &cqb, &cqe_size,
-				     &index, &inlen, ext_umem, attrs);
+				     &index, &inlen, ext_umem, ext_dbr_umem,
+				     attrs);
 		if (err)
 			return err;
 	} else {
@@ -1073,14 +1075,14 @@ static int __mlx5_ib_create_cq(struct ib_cq *ibcq,
 int mlx5_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		      struct uverbs_attr_bundle *attrs)
 {
-	return __mlx5_ib_create_cq(ibcq, attr, NULL, attrs);
+	return __mlx5_ib_create_cq(ibcq, attr, NULL, NULL, attrs);
 }
 
 int mlx5_ib_create_cq_umem(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 			   struct ib_umem *umem, struct ib_umem *dbr_umem,
 			   struct uverbs_attr_bundle *attrs)
 {
-	return __mlx5_ib_create_cq(ibcq, attr, umem, attrs);
+	return __mlx5_ib_create_cq(ibcq, attr, umem, dbr_umem, attrs);
 }
 
 int mlx5_ib_pre_destroy_cq(struct ib_cq *cq)
diff --git a/drivers/infiniband/hw/mlx5/doorbell.c b/drivers/infiniband/hw/mlx5/doorbell.c
index e32111117a5e..fd80b3ff6145 100644
--- a/drivers/infiniband/hw/mlx5/doorbell.c
+++ b/drivers/infiniband/hw/mlx5/doorbell.c
@@ -46,13 +46,31 @@ struct mlx5_ib_user_db_page {
 };
 
 int mlx5_ib_db_map_user(struct mlx5_ib_ucontext *context, unsigned long virt,
-			struct mlx5_db *db)
+			struct ib_umem *ext_umem, struct mlx5_db *db)
 {
+	unsigned long dma_offset;
 	struct mlx5_ib_user_db_page *page;
 	int err = 0;
 
 	mutex_lock(&context->db_page_mutex);
 
+	if (ext_umem) {
+		/* External umem path - no page sharing */
+		page = kzalloc(sizeof(*page), GFP_KERNEL);
+		if (!page) {
+			err = -ENOMEM;
+			goto out;
+		}
+
+		ib_umem_get_ref(ext_umem);
+		page->umem = ext_umem;
+		dma_offset = ib_umem_offset(ext_umem);
+		goto add_page;
+	}
+
+	dma_offset = virt & ~PAGE_MASK;
+
+	/* Standard path - lookup existing or create new page */
 	list_for_each_entry(page, &context->db_page_list, list)
 		if ((current->mm == page->mm) &&
 		    (page->user_virt == (virt & PAGE_MASK)))
@@ -76,11 +94,11 @@ int mlx5_ib_db_map_user(struct mlx5_ib_ucontext *context, unsigned long virt,
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
 
@@ -96,7 +114,8 @@ void mlx5_ib_db_unmap_user(struct mlx5_ib_ucontext *context, struct mlx5_db *db)
 
 	if (!--db->u.user_page->refcnt) {
 		list_del(&db->u.user_page->list);
-		mmdrop(db->u.user_page->mm);
+		if (db->u.user_page->mm)
+			mmdrop(db->u.user_page->mm);
 		ib_umem_release(db->u.user_page->umem);
 		kfree(db->u.user_page);
 	}
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 05f764185e92..c1e60f5c1754 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1332,7 +1332,7 @@ to_mmmap(struct rdma_user_mmap_entry *rdma_entry)
 int mlx5_ib_dev_res_cq_init(struct mlx5_ib_dev *dev);
 int mlx5_ib_dev_res_srq_init(struct mlx5_ib_dev *dev);
 int mlx5_ib_db_map_user(struct mlx5_ib_ucontext *context, unsigned long virt,
-			struct mlx5_db *db);
+			struct ib_umem *ext_umem, struct mlx5_db *db);
 void mlx5_ib_db_unmap_user(struct mlx5_ib_ucontext *context, struct mlx5_db *db);
 void __mlx5_ib_cq_clean(struct mlx5_ib_cq *cq, u32 qpn, struct mlx5_ib_srq *srq);
 void mlx5_ib_cq_clean(struct mlx5_ib_cq *cq, u32 qpn, struct mlx5_ib_srq *srq);
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 010f707e209d..4b926b6f2461 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -918,7 +918,7 @@ static int create_user_rq(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 		ib_umem_num_pages(rwq->umem), page_size, rwq->rq_num_pas,
 		offset);
 
-	err = mlx5_ib_db_map_user(ucontext, ucmd->db_addr, &rwq->db);
+	err = mlx5_ib_db_map_user(ucontext, ucmd->db_addr, NULL, &rwq->db);
 	if (err) {
 		mlx5_ib_dbg(dev, "map failed\n");
 		goto err_umem;
@@ -1064,7 +1064,7 @@ static int _create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 		resp->bfreg_index = MLX5_IB_INVALID_BFREG;
 	qp->bfregn = bfregn;
 
-	err = mlx5_ib_db_map_user(context, ucmd->db_addr, &qp->db);
+	err = mlx5_ib_db_map_user(context, ucmd->db_addr, NULL, &qp->db);
 	if (err) {
 		mlx5_ib_dbg(dev, "map failed\n");
 		goto err_free;
diff --git a/drivers/infiniband/hw/mlx5/srq.c b/drivers/infiniband/hw/mlx5/srq.c
index bcb6b324af50..6169ffaf457c 100644
--- a/drivers/infiniband/hw/mlx5/srq.c
+++ b/drivers/infiniband/hw/mlx5/srq.c
@@ -83,7 +83,7 @@ static int create_srq_user(struct ib_pd *pd, struct mlx5_ib_srq *srq,
 	}
 	in->umem = srq->umem;
 
-	err = mlx5_ib_db_map_user(ucontext, ucmd.db_addr, &srq->db);
+	err = mlx5_ib_db_map_user(ucontext, ucmd.db_addr, NULL, &srq->db);
 	if (err) {
 		mlx5_ib_dbg(dev, "map doorbell failed\n");
 		goto err_umem;
-- 
2.51.1


