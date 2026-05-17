Return-Path: <linux-rdma+bounces-20821-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCsLF5JgCWrhXQQAu9opvQ
	(envelope-from <linux-rdma+bounces-20821-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 08:30:42 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C03455F801
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 08:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 32CD630055C5
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 06:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7978223702;
	Sun, 17 May 2026 06:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="pcttJMmK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D8825D527
	for <linux-rdma@vger.kernel.org>; Sun, 17 May 2026 06:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778999425; cv=none; b=h11DXdV5/9DfNjb6on2pLpaddh83FLCQE6v2KlUkrQO194ur/RvwJ+Ex+YzQfGvd2FIBl2LUcKStprXTk0oRv9KPjTzZ3uP0HS3vvfmt1GYr6kLOGMpulKfJ7Rgf8kserN8ammqGly5nQ5fISKpUId7JKrYCzcvlKAprJSRg1js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778999425; c=relaxed/simple;
	bh=yWz8W+Ve1c2/4i5DFD5sNtQrrZvOk+tDwfaNV7LQMuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ujrbjXA6UR02ft8GWFNa1c/kWfpio7O48DaI5xDuJgSAsOP6blv5jUb+9nNhetVntkNk2dGLvb7312o3083A1AgmIHpZ8wKRZRcr+gBqMD45+wlkjf57jleVuu0EWK+Eq19CNDovWz/Ib+jSqB/uBRBx//cfVZmGO0dNkqX0+AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=pcttJMmK; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so13447515e9.2
        for <linux-rdma@vger.kernel.org>; Sat, 16 May 2026 23:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778999422; x=1779604222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hx9cJXO26+cfRwn+5gXriiAguRs+Qf2KP3Yj0EqKNQU=;
        b=pcttJMmK6zgmqPHqjcNnuZKCL8uI1/yHbdsZa7k6Mp+GjgGzo9RNhnk6y/u74k549y
         YvuRnq02/dYnXtvO3HIusd+rbJA+chEyzKyoIqxfx9Qi1dJ47U6I6a7HqNswoGPFWZTp
         N9uYT1xWyWE2OWZfXevUZpA6r2CQoHdlAUXX5xFBzJV+FSEobNBmE0qXDMlf4QBPr412
         KUzJ0foQE2X1X7a9o6Z9wQqUZ5LtS2YXZioUIp1KGVWESIQyTb4FQ5ukS8Zm9j+fEYlr
         kvvM8+TlHQnOXgAPHSxI2KKR3hTWidf74djl02ZHbfWVrPHnyA1MxP7UENHzECiRZKXH
         8NhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778999422; x=1779604222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hx9cJXO26+cfRwn+5gXriiAguRs+Qf2KP3Yj0EqKNQU=;
        b=hiE5JNO40HJjxtOZEWMHu7k5U85+XnhGiekfrG+YPTbM90xn8NMKuxKIv20jdTcudu
         SoJqVxCt/xmGPdTtpJestMIoOKyzyalB80HDq7ixqWhPwOJyamzBEukPqDAhlT5IjWGB
         phkr57xdGet9LhwFKYIdMYAUokkZhQ0U5CnaX5d9Kd2gB+iY6UEkBAG+md93N80H+efU
         xdMN8lN63vOtKUTvKXynfCqUUB8zWN+nzElXUsM8mnAawhDvoWtFO9qNJGLa8cu9nIXM
         GiMMoFHMVe8LNLZNGQPk5uRvflko1OoCyIqU7fmD85hN4Sw+Li07NktgLH0Il0RF4wBK
         +ZCg==
X-Gm-Message-State: AOJu0YzRMi1VebyMoWpfABR4WHgBoVdyCzE8PC8Ytqvv5R3RI/4Ni1kD
	nZf+aBJ4jAc8iNQ3BJ6hl4hskd2cLBfdJivBkTob8cVxAddI3zQRzKg39pLF/mC6VFCPi1SLexa
	fMG8fnuucc/gq
X-Gm-Gg: Acq92OEyUpd2pMKDt0tjyEd9L3M8Cyil8KQtNvuRxB8R4Ak2+ZE0tkd79k+qtmBJ/z3
	qXQdCxUI7+rAxZeg0T0msVrBxWjcJmnSSGmidIjP0NmoZ2HgQ6HgXfTngiEwnfNA+enCZRHrhKg
	kXm2uMreoeBFbScVawNUt72Ka5pKrJbYQlK9ml/oypBU28H4w00uu9BNbwPK7ne9FgLI/okZzwB
	00H28o2UBeJdNn85kULyhGv5XG/EaVJ/eFyVAPDGLXT3i482oIdJeBhLTHh9R5bORv0ulMyl+VB
	UW6oshaSZeWwpVJjeS1ZhXp40jMSjbgBJ/WKpvt8BNO60a72jck3QUNEXlmDMZAmx0ysCWyfUtL
	amc29X2JyGEStVhIKfU94A9+b21DgI3zBqXFRuMeiWuZbCo4UmXWvOYPFDkGkFlRQDqkOXHkHvl
	6a5mJEmBfuPgC4P5mlFp1+0gU9ZE+3HR10FKipzbDHYpEUrw==
X-Received: by 2002:a05:600c:8189:b0:48a:9428:5522 with SMTP id 5b1f17b1804b1-48fe632249dmr158789435e9.16.1778999422382;
        Sat, 16 May 2026 23:30:22 -0700 (PDT)
Received: from localhost (46-13-72-179.customers.tmcz.cz. [46.13.72.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48ff43f213esm53813005e9.1.2026.05.16.23.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 23:30:21 -0700 (PDT)
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
Subject: [PATCH rdma-next v5 10/15] RDMA/mlx4: Use ib_umem_get_cq_buf() for user CQ buffer
Date: Sun, 17 May 2026 08:30:01 +0200
Message-ID: <20260517063006.2200680-11-jiri@resnulli.us>
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
X-Rspamd-Queue-Id: 6C03455F801
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
	TAGGED_FROM(0.00)[bounces-20821-lists,linux-rdma=lfdr.de];
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
	RCPT_COUNT_TWELVE(0.00)[23];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,resnulli.us:mid,nvidia.com:email,resnulli-us.20251104.gappssmtp.com:dkim]
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
2.54.0


