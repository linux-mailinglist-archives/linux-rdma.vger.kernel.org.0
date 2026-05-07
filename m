Return-Path: <linux-rdma+bounces-20152-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LwqIWWL/GleRAAAu9opvQ
	(envelope-from <linux-rdma+bounces-20152-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 14:53:57 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5654B4E88AC
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 14:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8EA9C300F293
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 12:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25D13F076C;
	Thu,  7 May 2026 12:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="dBfJRJU6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439C53ED5D5
	for <linux-rdma@vger.kernel.org>; Thu,  7 May 2026 12:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778158367; cv=none; b=baIovJhgcIKmFc0J+ZQODQd0BW01nP5AgpIVfzgwS9FlJzT93T1lhG02qBGBNZh5pxBWQLX9wqWS1BZMBk+lxwsugme+1gNlf2d6VUPwQstglvjA0tdzvbR35/UW4l+Ax58TodZEpf7UUPAzR3xHYPJ+b76i1LT/c5nb74TgIIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778158367; c=relaxed/simple;
	bh=+8R7aaMMa7pWDBJg3jNABtAT06FpnkwLiglCp/tfUZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uiBqzsSL2K515w4NpZMC/jJo9+DnOEHNNbTLH8CgEzJ3NDMhrO+rQyWag04g9nK/7LVLk6+NPOoMx6Xr6yN9cC5+PHXBYijpHUoNNPKAt33EQFD+iZo1d2+xnasTP3s/qP/VfQxK7wp8LG6ws8B8l0xmjUSDzad4GnyHwLg8/dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=dBfJRJU6; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48896199cbaso7065985e9.1
        for <linux-rdma@vger.kernel.org>; Thu, 07 May 2026 05:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778158365; x=1778763165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KM8J3dwDrt2LUcO6M6DOcNvFtMPeFBMeHtYnSOecjXU=;
        b=dBfJRJU6yphj2GlF2JAF0oNLM9ivf+L5SYm8wWjYhYGKJXSGEskzqfWck4EFEQiNjA
         McFfxiK1d2y5NhLwFH1Jl5HWIuOlsOvlnTfTxbwA9jvDruT/SaVtTuAEld6I1xcKfJWN
         DA3Mzgfk3sGHxdWBwUrcP7FRrzc623Uj65hRDqaH5tEX8nR40zZoF99UVTWZUxAGjL6b
         lYQcH3Th6pHBKPS/JhhQ2IKvaOuZ2CxP+mqsIygZTogcIDrWeKzPLMy6fVpQypPqWf6M
         z0zTQfmXxdRoYpATA6cmkrxxZokIvNKiwhXLYhcdgQFtOSIAcxel7xd72YN23Kx5bGfT
         IzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778158365; x=1778763165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KM8J3dwDrt2LUcO6M6DOcNvFtMPeFBMeHtYnSOecjXU=;
        b=FP5PiE8kkhFN80Q/+q1JeqplwryTdclD31d7X4JFjHedUeoemhWWf4TZDhrt4hUVyp
         6fCnVnMeqI1Bkk2tFSsP329wnDtkNQc9qLNqIQRy/zYBfaQFONCKtDWYxpHn29JOmgq5
         vTyug0MVilvZLwDMPcWIq8rukgMj/VlWjQzrRVK0+jN1mcHPt5lXI69WRDEOqfmYydnI
         E7SQX4uv6fgSM8uT9yd26cID2qDJVjB7peh0hFaNYH/CiIGskfQ3y4m6zHqbIefo1S+c
         X2Zz6g7DbXG3duNfJZ8S4xvxb93XLIyXkQF2Rvng1zQyWTCibW8Jk1y7pkodVhPhalFm
         k5rQ==
X-Gm-Message-State: AOJu0Yw5fc/CyBqdSpmgO/jED7xuluna4C+bmsuCGWVcmivU9ly672x3
	OgmlaAeBdq0ixX3Jz9Y7Vtt+4Gc4AGlaNsOtu/L0Rl7xNBphscv8Ab6VDEeCciD2FULmhqoReZf
	ICgIe
X-Gm-Gg: AeBDieudjQeXxxaINVPExPmwgyA8//H9M7tQKrrlq3VmAOW08KxXFpV6oXRHcgTimSv
	Z2XjvJjTH/2YJSEIGtHlo9kFYsUwrfa7Z8eGw9/rPoBtb0RHkiFSysGlkN6ySn92UgRJmMey+8/
	YkuFYKJZXCISDRDm51hlm8xLNMVl4aT9wO+qXbPMX1fH767SUzVEEK1f9OjS0mQ2Cgq22H0k9lQ
	/LejD9+DsVNJ49FNuWFQto3loAl1aawv4xvruT9F83U8bhC1OY1Q9rd3O3etHFImvUnism9EunE
	/CzO28TW5M8jdhfnzMco9VPQb8MhjCzahd0ZKk5fbY4pzd3Plhq8RpjuZbOfRTU055yql4OvdU1
	6FXJ7p4cyRTOPr3lGMNnq4OTLi+yXH5gYoREh+D18Dy3Y9E+iVJzCSCZrifiCAbMZCTQf7DNA7e
	IPaW7H22sqET9gauCs5fMxV0lQhC8S7KgyoVomFoAFb4PxWmpqvkpt6Lay
X-Received: by 2002:a05:600c:1d18:b0:489:1a63:509c with SMTP id 5b1f17b1804b1-48e51dd689fmr124190905e9.0.1778158364493;
        Thu, 07 May 2026 05:52:44 -0700 (PDT)
Received: from localhost (46-13-72-179.customers.tmcz.cz. [46.13.72.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-453509db3ccsm3462846f8f.36.2026.05.07.05.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 05:52:44 -0700 (PDT)
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
Subject: [PATCH rdma-next v4 11/16] RDMA/mlx4: Use ib_umem_get_cq_buf() for user CQ buffer
Date: Thu,  7 May 2026 14:52:26 +0200
Message-ID: <20260507125231.2950751-12-jiri@resnulli.us>
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
X-Rspamd-Queue-Id: 5654B4E88AC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20152-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Jiri Pirko <jiri@nvidia.com>

Pin the user CQ buffer with ib_umem_get_cq_buf() and take
ownership of the umem in the driver; fall back to
ib_umem_get_va() for the legacy UHW VA path. Apply the same
ownership pattern to the resize path.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
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
index 381c7dfa4667..86557b413ca5 100644
--- a/drivers/infiniband/hw/mlx4/cq.c
+++ b/drivers/infiniband/hw/mlx4/cq.c
@@ -172,32 +172,40 @@ int mlx4_ib_create_user_cq(struct ib_cq *ibcq,
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
+	cq->umem = ib_umem_get_cq_buf(&dev->ib_dev, udata, entries * cqe_size,
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
 
@@ -234,7 +242,9 @@ int mlx4_ib_create_user_cq(struct ib_cq *ibcq,
 
 err_mtt:
 	mlx4_mtt_cleanup(dev->dev, &cq->buf.mtt);
-	/* UMEM is released by ib_core */
+
+err_umem:
+	ib_umem_release(cq->umem);
 
 err_cq:
 	return err;
@@ -471,8 +481,8 @@ int mlx4_ib_resize_cq(struct ib_cq *ibcq, unsigned int entries,
 	if (ibcq->uobject) {
 		cq->buf      = cq->resize_buf->buf;
 		cq->ibcq.cqe = cq->resize_buf->cqe;
-		ib_umem_release(cq->ibcq.umem);
-		cq->ibcq.umem     = cq->resize_umem;
+		ib_umem_release(cq->umem);
+		cq->umem     = cq->resize_umem;
 
 		kfree(cq->resize_buf);
 		cq->resize_buf = NULL;
@@ -532,7 +542,7 @@ int mlx4_ib_destroy_cq(struct ib_cq *cq, struct ib_udata *udata)
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
2.53.0


