Return-Path: <linux-rdma+bounces-21510-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHZGOG2ZGWrVxggAu9opvQ
	(envelope-from <linux-rdma+bounces-21510-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 15:49:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE7660315E
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 15:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 32E8D310D03D
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 13:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2CE33CE88;
	Fri, 29 May 2026 13:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="gM43cdgT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7006433C18B
	for <linux-rdma@vger.kernel.org>; Fri, 29 May 2026 13:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780062231; cv=none; b=DLUJMYPceu/bljZIVVhdQLHh7E6yz/twMNcoJGZLpDsa146HjLcSl9GeFQnPmYGza9QEU+IKCWxUxGhl3UGI+HIymkwV9el1n3f/wI4RaIZ8eInPQ4Ceo75BQsCqo0tfaltC2+EkAVsBgk1/z8QxXjSi+u1QygNmURHiMzCBwIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780062231; c=relaxed/simple;
	bh=NihX+0OFrZoXiFkBG5FF3jBnDswC4iBmuvHvtZSEfcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fR+BwpMlkoupapwjD663VIlroeDlKKMqcgFHtQxF0tV8gC+yUEW/woxlVKESCo+4HoyTlBoM7mbJrT8xjOWwHwJacMGFCIdgOZB0hHLEcwCnL6v5FobE+k/rQqJBNdqMynpiIcReFFeiiepkFC02/+t1mximNHe0FAZo+Up3S1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=gM43cdgT; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43eb05b1875so7289042f8f.3
        for <linux-rdma@vger.kernel.org>; Fri, 29 May 2026 06:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1780062228; x=1780667028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jC78BKQRx7y/SG3LvzmjdtvkmWDOANPdBORItDx21V8=;
        b=gM43cdgThx/EljtPP5XOAH2Y/Rj+mCb5EMvROneGciM//8Mbxu+dPMJf/KUOT2cjrc
         gJ9HhBY3VHUOBUK0uqN6YtYDbsgs9htOq4VniLiAwLeg8LZmo6XPXAZFe/+viJXxN6rr
         qjdT9P3/J+oEoA3bw35LsBHNHnWfvvKmkGFZ02XWt+TxZfidwqcLf788BAny/YBuvCOt
         blmJr9MBuBcwwK0QI+gLyaz3ftYoR89SMIwxRDO7kRKdbuogPScguOp1nJukuDS6vr6S
         gHLd7t813Ssw6ZjeuqotUXDJpAtGTGZeVoYtgZ68d9rey2VRfttJGJqd28pkZJzcmex/
         k+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780062228; x=1780667028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jC78BKQRx7y/SG3LvzmjdtvkmWDOANPdBORItDx21V8=;
        b=dHCkLRnIG02G9RNDdvfCsC/BGtrrlSpiXtPDoUSWvVlOug5WNRUQSAPqZzlgBTy6rl
         ogLWKc07MAj1eA49JSkQ+cFlVj499G4Shb20xcto+AverCkifpi4/OBCs+bTUEkp84AK
         Ua5/dDhOLKyFfyygHO8Sm4Yaxf8bHORgUAu3rs2Qs8AOAmOTxGFJWvk8MfXHyu9VhgUA
         feN5/Enwww5vPk5JvAKviujaVl1uIvdgMujvfklYRtKsoRfH0bYN4Nx0o99obS1S6X4F
         RB+aTRBxQ08QzQKNpnDjG19O0CxITr7fOPl6mJHlWzwIThXt+d5yDgyDtcqlJmDRa/JJ
         Pv8g==
X-Gm-Message-State: AOJu0YzjtDC4U5t52c+3/UlCeYctz/EjTh38BgsHglKInbEsAWFt1aVT
	WBiiYO3jOh6huscq0neDe4bhHblhdHDYU42numKv/607lybXNj7olkISPP1yK+MrX4g0gSQSYVU
	b98K9/PKLQg==
X-Gm-Gg: Acq92OF/Hgo8nVHsoO++uMgZ0lsMlN73hEO1cGiKpROVF1DTdrBiyMbAnxgc+Eb+Z+Z
	U+voqmsEQB302F5YLL8dDcU6oYj8Kz8g3WQFPKqhxKP4CMHTQt1XtYFjhfjbbtpPZH0tidOQf2w
	WaqdBb0xOONkKwKVi7XgV20kkV540gEpX6aoEpyg/xndiMmMPHGfu1LaDUmYTE1L2jsfrqfTh5b
	A/wo2XbTEP0oVWIBb81JIdPN3O6wHGVvGq2alq1LVqMg6ntfzGm19pxEQGSxISi4yJSApBfLq/T
	kNTctcyrIeLcsQ8QX3QRMxXz7nIiAoOaEu6JDPQaZNMqzy7cQr1d4yJa/vkbQp0+NBHnnP6gbyh
	4rvpMgyY1lvxSFejjgOaCyYxgwQoIWTeN9dGnaTXn27ravqxqGhYRpZRkYDa+RQadQ7TlVy8bA6
	J9NQyxmqdlH27P9QEMiqPij80E8U3TGZrVFfnEFVvFNYQ=
X-Received: by 2002:a05:600d:6413:20b0:490:41b6:4d87 with SMTP id 5b1f17b1804b1-4909c080ac9mr44125925e9.4.1780062227826;
        Fri, 29 May 2026 06:43:47 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d6eb470sm35757365e9.10.2026.05.29.06.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 06:43:47 -0700 (PDT)
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
Subject: [PATCH rdma-next v9 10/16] RDMA/mlx4: Use ib_umem_get_cq_buf() for user CQ buffer
Date: Fri, 29 May 2026 15:43:06 +0200
Message-ID: <20260529134312.2836341-11-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529134312.2836341-1-jiri@resnulli.us>
References: <20260529134312.2836341-1-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21510-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	URIBL_MULTI_FAIL(0.00)[nvidia.com:server fail,resnulli.us:server fail,tor.lore.kernel.org:server fail,resnulli-us.20251104.gappssmtp.com:server fail];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,resnulli-us.20251104.gappssmtp.com:dkim,nvidia.com:email,resnulli.us:mid]
X-Rspamd-Queue-Id: 6EE7660315E
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


