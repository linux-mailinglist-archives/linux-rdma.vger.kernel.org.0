Return-Path: <linux-rdma+bounces-21043-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UC5WHBSJDWpdygUAu9opvQ
	(envelope-from <linux-rdma+bounces-21043-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 12:12:36 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 136E758B775
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 12:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BD5F4304642C
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 10:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA5C3D6CB8;
	Wed, 20 May 2026 10:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="uFZZviC0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0853D5646
	for <linux-rdma@vger.kernel.org>; Wed, 20 May 2026 10:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779271915; cv=none; b=m3aZj7MSFM5S4KnjAVNddIzvmuHCnExIwHLDaNvpp6Ncp5Qmi8PvEkLASA/jsug13uToteRqYzgmZkaPf03i+DQEJl3QhnOYQcj7OhoCv3S2KqsdBbAnkAwrk2Do7H57L6YNgwVkOXtYPFStMaBY3xKPNf0JhgFZbd3AcUvkDJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779271915; c=relaxed/simple;
	bh=NihX+0OFrZoXiFkBG5FF3jBnDswC4iBmuvHvtZSEfcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xp++rlTb3jsHXKcjTctsbqWp0zb/ZHnPJnpKM41zImb3hW69cUzAq3PEwQaZQse1QVlR6ZAhLkON4FBlBRAdgPUjn4QCMbZmpyItOpq39xjltJDObJcfmINEyCUx0BA5NZpHTfq71WSXaeuBRDjn6tB+aVunTj4AM1Lz5+rvEz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=uFZZviC0; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488b150559bso35836155e9.1
        for <linux-rdma@vger.kernel.org>; Wed, 20 May 2026 03:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779271910; x=1779876710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jC78BKQRx7y/SG3LvzmjdtvkmWDOANPdBORItDx21V8=;
        b=uFZZviC02yTbp8XN9LjQq/FW726bQ5I450fNHwzRzIk0sKnr7gBL+BlilZy0NPBTzI
         fdXcvRFafUZakznlpqGgcjCEgE0v8i8mwpyD1MvfJQhrmCnliHfJL/HY419nfq6m7BIM
         6XoO1/dQ3QSo/g9ovUcL+LDxy5exW1TyJiWouInOT39vhtbxOxiu9V6TheVi96N5lEVP
         zirVlu33hkdR5xyIRirEWWO67jVCp6S7YyYA/ZaKO4yZFsWDQyaUxqLxeVqdgtI5UfMe
         Arg8oVckpxW78sZjVlIRWl6quU5d7X0jcl6cKQnZbJbXshz+H5Ru31rHkeMGf//aTfhe
         KwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779271910; x=1779876710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jC78BKQRx7y/SG3LvzmjdtvkmWDOANPdBORItDx21V8=;
        b=eCelMM+6IuZcW1zRZcX/vapHpdMQJhDFCkMAge0TTQiApO31Q6HF2s90BKCtTAaNsX
         4V0aypgO3k9u5H98Dg4CJq8W5T0crGsxQZd0wwiRBGpgqWb7ZM4slkRrxTREH9R0Z2AD
         5DMJHzmX8bTG3k1nECVKKzx3dg2ALfIUVSk6JsNd3YhJ2VqbC/cgE1/TW26C8FK4TNDf
         GZP2UypKqHi1Yl0zYrZIh/S6i3udeSXw1WsHSlZXUQ/ZuIZQk52e7Glp3CfpP+9ClMVR
         2lIoI+HFHJZaj/5KdJ/cf8Db2HS8btqdBgdwjAtZ5HQ9UhcWGhSVFtxyBqtLh1Waouuh
         HxbQ==
X-Gm-Message-State: AOJu0YyGiRpIZRnCW8b4uO95ozbyfHwxo8sEi6mPU7OyZwBMS2hJiStV
	oZPQn4KDNzckbJtBuJJKE2TfYg97xcdM3miI62Tmy122xcXweqHU8RCM+7ULffxugW8tsOSNbUo
	fRG7XRWdUmQ==
X-Gm-Gg: Acq92OHQppbS9/7Ij4OvHUGPQuhDisAozvPOu4+GOhdgFz8nZgn52MI82Qs3HfdG8vf
	pp25ZziY296Ov6BXLzqECIe7XhHamkn47jQGlJRAATQaf9eRa5661UD647EGnkzy8m/aTNaB5kU
	qU7T8em2aVnNT07YXolclOJ7F/Rjt/ab3yCoz0GGU5RVyT2CdkV2nW5eITfTqt1cS/MECQrmxAR
	6yCJ9HnEckEfXxmLmilx/Y71LRPpWwSlwMKs/VgFjSf9S3Pra+uepq7EyxgfPwEiNFEnK0U/WEj
	2LurHdW40NBHj63tSHJHLI2a81Xm/bYHqFRLTgenC/wd9nrrkmTxT2BaLztzFqt7aImPTO+0T/P
	KCKHAgbkYKCZW47/wlUFnIV3y38ndDJbCkb4nDJWkFu32wGD23M24geI93veOUwtGB5e7+Zwe3j
	w2QY8sZEecnjCDLlWcEuGuJECZiKRaqH2P
X-Received: by 2002:a05:600c:1f89:b0:48e:526e:101a with SMTP id 5b1f17b1804b1-48fe60e7a13mr344286525e9.12.1779271910185;
        Wed, 20 May 2026 03:11:50 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a17ec2sm49705563f8f.24.2026.05.20.03.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 03:11:49 -0700 (PDT)
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
Subject: [PATCH rdma-next v6 10/15] RDMA/mlx4: Use ib_umem_get_cq_buf() for user CQ buffer
Date: Wed, 20 May 2026 12:11:24 +0200
Message-ID: <20260520101129.899464-11-jiri@resnulli.us>
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
	TAGGED_FROM(0.00)[bounces-21043-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 136E758B775
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiri Pirko <jiri@nvidia.com>

Pin the user CQ buffer with ib_umem_get_cq_buf() and take
ownership of the umem in the driver; fall back to
ib_umem_get_va() for the legacy UHW VA path. Apply the same
ownership pattern to the resize path.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v5->v6:
- changed to pass attrs instead of udata to ib_umem_get*()
v2->v3:
- used ib_umem_get_cq_buf() to get umem, with ib_umem_get_va()
  as the legacy UHW VA fallback; stored in new struct mlx4_ib_cq
  field cq->umem
- replaced ib_umem_release_non_listed() with ib_umem_release()
- added release to mlx4_ib_destroy_cq(), the create error path
  and the resize error path
v1->v2:
- rebase on top of Leon's fix
---
 drivers/infiniband/hw/mlx4/cq.c      | 50 +++++++++++++++++-----------
 drivers/infiniband/hw/mlx4/mlx4_ib.h |  1 +
 2 files changed, 31 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/cq.c b/drivers/infiniband/hw/mlx4/cq.c
index f9ec6917d9c9..887912469742 100644
--- a/drivers/infiniband/hw/mlx4/cq.c
+++ b/drivers/infiniband/hw/mlx4/cq.c
@@ -173,32 +173,40 @@ int mlx4_ib_create_user_cq(struct ib_cq *ibcq,
 	if (err)
 		goto err_cq;
 
-	if (ibcq->umem &&
-	    (dev->dev->caps.flags2 & MLX4_DEV_CAP_FLAG2_SW_CQ_INIT))
-		return -EOPNOTSUPP;
-
-	buf_addr = (void *)(unsigned long)ucmd.buf_addr;
-
-	if (!ibcq->umem)
-		ibcq->umem = ib_umem_get_va(&dev->ib_dev, ucmd.buf_addr,
-					    entries * cqe_size,
-					    IB_ACCESS_LOCAL_WRITE);
-	if (IS_ERR(ibcq->umem)) {
-		err = PTR_ERR(ibcq->umem);
+	cq->umem = ib_umem_get_cq_buf(&dev->ib_dev, attrs, entries * cqe_size,
+				      IB_ACCESS_LOCAL_WRITE);
+	if (IS_ERR(cq->umem)) {
+		err = PTR_ERR(cq->umem);
 		goto err_cq;
 	}
+	if (cq->umem) {
+		if (dev->dev->caps.flags2 & MLX4_DEV_CAP_FLAG2_SW_CQ_INIT) {
+			err = -EOPNOTSUPP;
+			goto err_umem;
+		}
+	} else {
+		cq->umem = ib_umem_get_va(&dev->ib_dev, ucmd.buf_addr,
+					  entries * cqe_size,
+					  IB_ACCESS_LOCAL_WRITE);
+		if (IS_ERR(cq->umem)) {
+			err = PTR_ERR(cq->umem);
+			goto err_cq;
+		}
+	}
 
-	shift = mlx4_ib_umem_calc_optimal_mtt_size(cq->ibcq.umem, 0, &n);
+	buf_addr = (void *)(unsigned long)ucmd.buf_addr;
+
+	shift = mlx4_ib_umem_calc_optimal_mtt_size(cq->umem, 0, &n);
 	if (shift < 0) {
 		err = shift;
-		goto err_cq;
+		goto err_umem;
 	}
 
 	err = mlx4_mtt_init(dev->dev, n, shift, &cq->buf.mtt);
 	if (err)
-		goto err_cq;
+		goto err_umem;
 
-	err = mlx4_ib_umem_write_mtt(dev, &cq->buf.mtt, cq->ibcq.umem);
+	err = mlx4_ib_umem_write_mtt(dev, &cq->buf.mtt, cq->umem);
 	if (err)
 		goto err_mtt;
 
@@ -235,7 +243,9 @@ int mlx4_ib_create_user_cq(struct ib_cq *ibcq,
 
 err_mtt:
 	mlx4_mtt_cleanup(dev->dev, &cq->buf.mtt);
-	/* UMEM is released by ib_core */
+
+err_umem:
+	ib_umem_release(cq->umem);
 
 err_cq:
 	return err;
@@ -472,8 +482,8 @@ int mlx4_ib_resize_cq(struct ib_cq *ibcq, unsigned int entries,
 	if (ibcq->uobject) {
 		cq->buf      = cq->resize_buf->buf;
 		cq->ibcq.cqe = cq->resize_buf->cqe;
-		ib_umem_release(cq->ibcq.umem);
-		cq->ibcq.umem     = cq->resize_umem;
+		ib_umem_release(cq->umem);
+		cq->umem     = cq->resize_umem;
 
 		kfree(cq->resize_buf);
 		cq->resize_buf = NULL;
@@ -533,7 +543,7 @@ int mlx4_ib_destroy_cq(struct ib_cq *cq, struct ib_udata *udata)
 				struct mlx4_ib_ucontext,
 				ibucontext),
 			&mcq->db);
-		/* UMEM is released by ib_core */
+		ib_umem_release(mcq->umem);
 	} else {
 		mlx4_ib_free_cq_buf(dev, &mcq->buf, cq->cqe);
 		mlx4_db_free(dev->dev, &mcq->db);
diff --git a/drivers/infiniband/hw/mlx4/mlx4_ib.h b/drivers/infiniband/hw/mlx4/mlx4_ib.h
index 5a799d6df93e..598954dd0613 100644
--- a/drivers/infiniband/hw/mlx4/mlx4_ib.h
+++ b/drivers/infiniband/hw/mlx4/mlx4_ib.h
@@ -121,6 +121,7 @@ struct mlx4_ib_cq {
 	struct mlx4_db		db;
 	spinlock_t		lock;
 	struct mutex		resize_mutex;
+	struct ib_umem	       *umem;
 	struct ib_umem	       *resize_umem;
 	/* List of qps that it serves.*/
 	struct list_head		send_qp_list;
-- 
2.54.0


