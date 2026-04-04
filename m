Return-Path: <linux-rdma+bounces-18980-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEAzBXGI0WmlKwcAu9opvQ
	(envelope-from <linux-rdma+bounces-18980-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 04 Apr 2026 23:53:53 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5BA39CA8D
	for <lists+linux-rdma@lfdr.de>; Sat, 04 Apr 2026 23:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 31018300B996
	for <lists+linux-rdma@lfdr.de>; Sat,  4 Apr 2026 21:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9DE33E373;
	Sat,  4 Apr 2026 21:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPiZb7Lb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEA63537FF
	for <linux-rdma@vger.kernel.org>; Sat,  4 Apr 2026 21:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775339630; cv=none; b=B1SSSxM3HbkZW6Z9U0Ehyp1wT1vIwzk63H4IlGcyO7c8p7XPSl47i/FglHOwvr660L7UxnyP4Cumdt457ktdoCTp3sc1JekVMywPur7B8mfxNOrwct6/kBEilATEACfUu2NevTmr0WZteUtCsDHXRO+fofNV7/hO0gEeT8HI8qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775339630; c=relaxed/simple;
	bh=tznmjjTGe9P0prfUa9qOMcSvAKDN/f3n6xVVXB5ptgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HjTYj5RXrkFGLmfnpVPOBJToZQMbJeL20uhrku0k7F0TMI0NkXf3zIf6xFSI5isNDUzdHcmVVJVZgORS4WsCkId6vFwt4gkkXDoJ3DDr2GlT16z/xdm9e2StN5jgIWGBKKJTgwHu5i33Gl5XlsJqeKn/Fhe9+I4dzV9Fi3RcLPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kPiZb7Lb; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43cfde3c3f3so2730737f8f.3
        for <linux-rdma@vger.kernel.org>; Sat, 04 Apr 2026 14:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775339627; x=1775944427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aaqSSAqndsOonppRKT5nCBm50Qia4L4ieix5UZV1ew4=;
        b=kPiZb7Lb1csn+UHx98VdtONIwuzp2pt0cCjIPpmzAowS9FzWnhvfxmxGoOuYDXs4em
         GWoTt2jl818iX7rnTMkhZ5wiEMRP55A/eo9atavJj6cAYRv3CXAo2YJHr3wvJGsAIsTq
         PT3KX+3uEd3dgC1vW+du3m5dsDtITdrVWcneFrs5KAWxHyXIscJWjllmHsILz38YAM/w
         P22SJ7sWf/LGHrP1iYy+VQ3lv8zNEEj+0ulvT3cXc4Wa1Gp1hr/j6GYhYoGPqWPX5/pL
         CS0BaT0fnSUGFda89YbAAcnPxt/sbh1jOwhY4dIq8aeMt7DB69wWGblVZ7NI8j4D9lzI
         25cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775339627; x=1775944427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aaqSSAqndsOonppRKT5nCBm50Qia4L4ieix5UZV1ew4=;
        b=GfO4Fx5sMbLLDJrHcgu6l0zFb4EU2NpRBBIQQRbNixRrlDou/5j0GuSDp7uD4mfEwR
         tbHIEbzWJZia331rCZunRIhjwxB6NImZV11oBL1et7YXcAuWdpwIi7JbheUx0eB0P9u5
         9LQnfrJQvIT7LIFJxwO/drARwkdCYPMs+HOOWFq6sIBkGHy7oPTjcDU2QZIHnVGUoJ1V
         qw8qtRMX+LjTz73/8OpuaaB7Vn4ezjhUTr6NYn12Wa06orPG75H0uB2A3NGFD+FHMTf9
         Vy0OdlVvHqRkp6t4NYhlPUuWfewDgwybh9AcM6X0nbKz1mTz60jSHplcDWT34LCklCCI
         H7gg==
X-Forwarded-Encrypted: i=1; AJvYcCVqgN1hh2tt5pByTjZiQPJ0EMWIQ3GIN87r1LjdWYH4RsUEqFkyLx9L63mEfDjOO7tDrsQajNhWj9eK@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8oHtjf7JHqJk1H9g1iA1cVzmA2/qfcRFSQ9alkSh3LhKvlOgB
	gypO9FyARmj/UMy/9iwLR7CtXCzMCEPJaU0ii9Ch6EYfZEzKeuoggCBg
X-Gm-Gg: AeBDieuC5FkhJfSoEjZFjDeivv5dDwlesOznW4x08DQmMv/lx4l9oTWKkoBfKm5LrO5
	PmrYqll8dQL4JzO1mIC+IF2S1wbPlaWUfxBucqUSJO0kcbLJ+s+Fow01MK2zMCmJkQwAzLIBEhK
	hn+9pMoUYH3FwGOnA/3eQoQIKjWl8TcU7lSPBH7nDjMpDXO34DirC/D/OjJTT0py4USd/qRriLD
	xhHJh116AVZHqXoiatnMbIJrIwFofFGv/2eSsao41cpLP8puLZV4YYeoQtcvLT/p0Tatb4g+J3b
	g0ag+OACeM2I8xRpnGuzZnm/yQ01XBh+WmMyghEEu8qINfvpY0Oo/s9RQq//pJ4z8DnRhwgrujV
	RCaB8u1Tju6Bdi+oL+dUIsiLIf28d91+ngK9K7UU9gWC8i6RgQ2ue141PBV7u1EMnVw5KX+6o4q
	TfuBeCgsRXEGkZ9ODi+EbWxZZHTHgJIeNT0VDUKYXf5XFRcdRY7Dc6vRO3fehNSRTO1dJ6SuK1A
	Uo2/ZgGSFk+mXVqexVKjNqZJQIQMDUzAq/70Wk0bJvbQNxm
X-Received: by 2002:a05:6000:11d1:b0:43c:fd4d:2404 with SMTP id ffacd0b85a97d-43d29269f6emr8327444f8f.7.1775339627065;
        Sat, 04 Apr 2026 14:53:47 -0700 (PDT)
Received: from DESKTOP-NQ2T5I7.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a720dsm27714924f8f.4.2026.04.04.14.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 14:53:46 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: prathameshdeshpande7@gmail.com
Cc: dledford@redhat.com,
	haggaie@mellanox.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH v5] IB/mlx5: Fix loopback enablement state and resource leaks
Date: Sat,  4 Apr 2026 22:51:54 +0100
Message-ID: <20260404215155.13254-1-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260401235232.21155-1-prathameshdeshpande7@gmail.com>
References: <20260401235232.21155-1-prathameshdeshpande7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18980-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prathameshdeshpande7@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7F5BA39CA8D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In mlx5_ib_alloc_transport_domain(), an early success path was
incorrectly returning a variable instead of a literal 0. Additionally,
the loopback (LB) infrastructure required updates to address
initialization and concurrency issues:

1. Initialization: The LB mutex was initialized conditionally, but
   paths like create_raw_packet_qp_tir() in qp.c call LB functions
   regardless of those conditions. Move initialization to
   stage_init_init() to ensure the lock is always valid.
2. State Integrity: Update mlx5_ib_enable_lb() to roll back reference
   counters if the hardware command fails, ensuring software state
   matches hardware.
3. Concurrency: Move 'force_enable' checks inside the mutex in both
   enable/disable paths to prevent potential counter underflows.
4. Resource Leak: Deallocate the transport domain if LB enablement
   fails in mlx5_ib_alloc_transport_domain().

Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
---
v5:
- Moved mutex_init to stage_init_init to prevent crashes on non-ETH hardware.
- Implemented 'goto unlock' for concurrency safety in enable/disable paths.
- Added atomic rollback and fixed tdn leak.
v4:
- Moved rollback logic into mlx5_ib_enable_lb() to ensure atomicity
  within the mutex and prevent race conditions [Sashiko].
v3:
- Also call mlx5_ib_disable_lb() on failure to roll back software state/counters
  [Sashiko].
v2:
- Added deallocation of tdn if mlx5_ib_enable_lb() fails [Sashiko].
- Reworded commit message to reflect the functional fix and credit the tool.

 drivers/infiniband/hw/mlx5/main.c | 33 ++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 635002e684a5..2d546d3b1dfe 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2009,10 +2009,10 @@ int mlx5_ib_enable_lb(struct mlx5_ib_dev *dev, bool td, bool qp)
 {
 	int err = 0;
 
+	mutex_lock(&dev->lb.mutex);
 	if (dev->lb.force_enable)
-		return 0;
+		goto unlock;
 
-	mutex_lock(&dev->lb.mutex);
 	if (td)
 		dev->lb.user_td++;
 	if (qp)
@@ -2022,10 +2022,18 @@ int mlx5_ib_enable_lb(struct mlx5_ib_dev *dev, bool td, bool qp)
 	    dev->lb.qps == 1) {
 		if (!dev->lb.enabled) {
 			err = mlx5_nic_vport_update_local_lb(dev->mdev, true);
-			dev->lb.enabled = true;
+			if (err) {
+				if (td)
+					dev->lb.user_td--;
+				if (qp)
+					dev->lb.qps--;
+			} else {
+				dev->lb.enabled = true;
+			}
 		}
 	}
 
+unlock:
 	mutex_unlock(&dev->lb.mutex);
 
 	return err;
@@ -2033,10 +2041,10 @@ int mlx5_ib_enable_lb(struct mlx5_ib_dev *dev, bool td, bool qp)
 
 void mlx5_ib_disable_lb(struct mlx5_ib_dev *dev, bool td, bool qp)
 {
+	mutex_lock(&dev->lb.mutex);
 	if (dev->lb.force_enable)
-		return;
+		goto unlock;
 
-	mutex_lock(&dev->lb.mutex);
 	if (td)
 		dev->lb.user_td--;
 	if (qp)
@@ -2050,6 +2058,7 @@ void mlx5_ib_disable_lb(struct mlx5_ib_dev *dev, bool td, bool qp)
 		}
 	}
 
+unlock:
 	mutex_unlock(&dev->lb.mutex);
 }
 
@@ -2068,9 +2077,13 @@ static int mlx5_ib_alloc_transport_domain(struct mlx5_ib_dev *dev, u32 *tdn,
 	if ((MLX5_CAP_GEN(dev->mdev, port_type) != MLX5_CAP_PORT_TYPE_ETH) ||
 	    (!MLX5_CAP_GEN(dev->mdev, disable_local_lb_uc) &&
 	     !MLX5_CAP_GEN(dev->mdev, disable_local_lb_mc)))
-		return err;
+		return 0;
 
-	return mlx5_ib_enable_lb(dev, true, false);
+	err = mlx5_ib_enable_lb(dev, true, false);
+	if (err)
+		mlx5_cmd_dealloc_transport_domain(dev->mdev, *tdn, uid);
+
+	return err;
 }
 
 static void mlx5_ib_dealloc_transport_domain(struct mlx5_ib_dev *dev, u32 tdn,
@@ -4473,6 +4486,7 @@ static int mlx5_ib_stage_init_init(struct mlx5_ib_dev *dev)
 	mutex_init(&dev->data_direct_lock);
 	INIT_LIST_HEAD(&dev->qp_list);
 	spin_lock_init(&dev->reset_flow_resource_lock);
+	mutex_init(&dev->lb.mutex);
 	xa_init(&dev->odp_mkeys);
 	xa_init(&dev->sig_mrs);
 	atomic_set(&dev->mkey_var, 0);
@@ -4713,11 +4727,6 @@ static int mlx5_ib_stage_caps_init(struct mlx5_ib_dev *dev)
 	if (err)
 		return err;
 
-	if ((MLX5_CAP_GEN(dev->mdev, port_type) == MLX5_CAP_PORT_TYPE_ETH) &&
-	    (MLX5_CAP_GEN(dev->mdev, disable_local_lb_uc) ||
-	     MLX5_CAP_GEN(dev->mdev, disable_local_lb_mc)))
-		mutex_init(&dev->lb.mutex);
-
 	if (MLX5_CAP_GEN_64(dev->mdev, general_obj_types) &
 			MLX5_GENERAL_OBJ_TYPES_CAP_VIRTIO_NET_Q) {
 		err = mlx5_ib_init_var_table(dev);
-- 
2.43.0


