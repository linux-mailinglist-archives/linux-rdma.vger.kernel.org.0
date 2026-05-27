Return-Path: <linux-rdma+bounces-21390-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMhcMMUlF2qu6wcAu9opvQ
	(envelope-from <linux-rdma+bounces-21390-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 19:11:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B38715E835E
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 19:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 336813021645
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 17:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E62C44CAD7;
	Wed, 27 May 2026 17:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="NHAfEucp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9819C44CAE0
	for <linux-rdma@vger.kernel.org>; Wed, 27 May 2026 17:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779901830; cv=none; b=aB4r06UMnLzINtFmwcK/saosirlvoKroQ1PdTz0eqjjMhmDyyyZ35AWHfJlLYBxbeq8R5ArTfj+yZPP87epkbNC4ssDI7r0++WX1k2a0JjSvoz/tp8pwrircjMbQLWKRdHdZ5ZFWzcR6GcGZvuyWgLR34Mpt/+K1g7Ohyue5hNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779901830; c=relaxed/simple;
	bh=NihX+0OFrZoXiFkBG5FF3jBnDswC4iBmuvHvtZSEfcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UEDgBXKEjYW+5e+Q6PGH+yd6f8Q49yDs5f6erpxyC+0q6dpjket2vUYiXhcEuhP51oq+9UD105RDfPSZxr76pSh4PQNTkKUTdcLlaxMd2yxa6gy8tyPwQAxIkd36AHRbpPX1jbNp3Lrjqs6NOJK5ARdikS96BrJnFQL8gbP7l1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=NHAfEucp; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4906869f0cbso36250725e9.1
        for <linux-rdma@vger.kernel.org>; Wed, 27 May 2026 10:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779901827; x=1780506627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jC78BKQRx7y/SG3LvzmjdtvkmWDOANPdBORItDx21V8=;
        b=NHAfEucp1on6P1PMgY5HPXS1pwuLoe2Z2Ndbkh5BO3rIGH6yIOXME0TkmrH5NFTssI
         q1TOk4DraQCZxotKzp0VsmrdBOjeRdbgzjIXmzB7M7ZFrUYy4owbbuBoemd5THc3e+q8
         Z0pXCJu+68rGKyXfHrGfaXkrTCGvmlcdN8bVR10IDfJACEcKkdcduNyguVmCo85UWF7K
         eKKZMl0UP9u2piEj7fY1bsd5DV1s9sTb25E4+8UirM0FlfSrGfOoegcVsqkp9W+4NL9z
         RQeN2Qexyi9zC+yDKOWmVy3cmPYk+TgTWn+U0PGyTQFPIV0xO2CTPIwFrRVn5r7e89Y0
         E4CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779901827; x=1780506627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jC78BKQRx7y/SG3LvzmjdtvkmWDOANPdBORItDx21V8=;
        b=X2VVZiZ4VIZbSKpGI1iD0l6+B2iGVeEDr7bvmpC/G9aRpsYcvLv8zZzpcXuil57cF1
         T3VGW35+fJ1qQDjTAlllFh8cMZMraGOdjwE0OPv2fvtz0ksD9uyZbLWWbVxEpLe0fEKU
         90yu2riHma+wzD7TT3RUvq8LrjUU+mRx3sH6s5JhrpEmVlFXdu1YS4LHaD8Z4t61d6v4
         NLsrKgtcgXth5Qir8wZtYpszps0Wt4MhxNrr0XTPGd0qklZdnzOwGX0CqJ/Fxal9Tj1s
         4VHCntA9a6NStvY8wmqYB5Q9DJCHPiFjL1VUDAO3tECcxvbbApj2GXoDFXmkkq2SVFUB
         7ggw==
X-Gm-Message-State: AOJu0YzQb8JNfdkLErSdI2bv8GiwnmYP7L9AO+NXswXN7BKkmcbu8nnJ
	RH42BvTPOMJseSxs7rzvNXxLxC0+Yslh8UX0gtwXZbxH12AqCB9zHEyxrokau1x+la4T55meMbz
	UisD0Lk3BVA==
X-Gm-Gg: Acq92OFm40zVMl5r2gSBTot56wFNLl/Yq4QrOyAYvX+JLBvbaWy8AtmXcUjJGPz6XCh
	bGkBtmjkpOvEpq1UT+KMDTOjFkOo+fPDiFGzUbiHRy+WzIblpnPgHk8rcWeNx/+ieku8TFrK9zA
	QiG03EejksTlvCfLuz3tOswpq5vfRPjW0l/g3tQ/n+ooPKZuOUc46px6fsTabgp81JADg2gzlRW
	SAQaJJx+e2cAbJsq0OYpNFa8Afh1hwiE4W/agjZYQgtRixs55J4y+H9yufHXXcZ04iOn+P1bw+c
	qEaX8THtSJnv8dIbvNCFKsT+pPloJdcNkhOjh/tFKsZWH+S/gMLySYu1+6frc/OtcQmHq3Mdnj+
	NtVktmKVs11IkNkZ6loINB43Iiww2koAmhsg+x8XLVNoPgFCyHjWnH+kIgRwTfaHwNWNhyXYy4i
	6oYKr3B55wgIS+UJjHQd4wI2DZ6h4muHk=
X-Received: by 2002:a05:600c:354f:b0:490:6e11:c303 with SMTP id 5b1f17b1804b1-4906e11c4b1mr188667505e9.13.1779901826870;
        Wed, 27 May 2026 10:10:26 -0700 (PDT)
Received: from localhost ([128.77.52.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454c600esm399607285e9.3.2026.05.27.10.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 10:10:26 -0700 (PDT)
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
Subject: [PATCH rdma-next v8 10/15] RDMA/mlx4: Use ib_umem_get_cq_buf() for user CQ buffer
Date: Wed, 27 May 2026 19:09:43 +0200
Message-ID: <20260527170948.2017439-11-jiri@resnulli.us>
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
	TAGGED_FROM(0.00)[bounces-21390-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20251104.gappssmtp.com:dkim,resnulli.us:mid,nvidia.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B38715E835E
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


