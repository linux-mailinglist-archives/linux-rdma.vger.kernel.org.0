Return-Path: <linux-rdma+bounces-18981-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SwOLBPuZ0WnqLgcAu9opvQ
	(envelope-from <linux-rdma+bounces-18981-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Apr 2026 01:08:43 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FCC39CD3D
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Apr 2026 01:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C36BB30078F3
	for <lists+linux-rdma@lfdr.de>; Sat,  4 Apr 2026 23:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DFB342538;
	Sat,  4 Apr 2026 23:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrCrIgZN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2420423D7FF
	for <linux-rdma@vger.kernel.org>; Sat,  4 Apr 2026 23:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775344118; cv=none; b=IETjT386AGHZFc9KqnjHtzqZZcqijwgNQP8QTBHWZ4gR07VoqHGE4VNkuOuDWrn2k4ANf/TLB3QdcOSZWlXjNE6y/I9zJi4mhnuRPTedM45Mp4FSghRS1NeygCi2BK7TrbB8vC3QUf2diXBGw8FT6MULiwbxk+TxC4ULKADwBkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775344118; c=relaxed/simple;
	bh=xpg9Q/ksUK8DcRTOQbzD6p0gQtdWyK+r1oMqC0fUAnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rxwfs7VbWltqst1lu5U54vOhkmWPL/Sllr0Qw18ELdwRLGzGKuck161JDfDGb1jFGkolYkeoeQLrN36poT4E7VTcxdM45Y2Y6DEaXwqmoqMo86xapStE690FHfUAvIsaPDYFCRxbKBUTpkRonQfjHy67nEGuoOez+4rlhHSvaVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZrCrIgZN; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4887ca8e529so22583035e9.0
        for <linux-rdma@vger.kernel.org>; Sat, 04 Apr 2026 16:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775344115; x=1775948915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0hZbwZb7uVS7mrdKS76KPEmzeWc8xmna+sIeGDuLXBQ=;
        b=ZrCrIgZN39uCemqCafF+Zin1EqzmquEAFoz45v8A+enRp+LEvm+H28ZDfXdaQWqYRG
         +bHtMICUuys2ewQckunmJkptA78yp1tBmGWxcNga1wSIDP0sIi9E0TbjeUf8QRUgxpO2
         0DYvKBvUtdFZMMgKZpsmNvRhQ4grA2/eHyiJ1ZTtoPqXPj5N7qkWe2PkrAY9YmsjZDvJ
         RkKLkmR77fvlyM8VcrYOQ1/y7KOSruFjhYag+bSJ35Fbs2LUGgBW1JD4AbimWByzE//k
         1yyquh3WzvcR98o3tz+UyVhb2i5uXbIL1DNVYoMROY0ISmEodBC57Uv8KecIYLKgGh45
         gGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775344115; x=1775948915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0hZbwZb7uVS7mrdKS76KPEmzeWc8xmna+sIeGDuLXBQ=;
        b=Q3qmK7cM8SS22ibbDn7Xw9DKEw0PeQCnFJNfgZ0WpkETxzSfpK3Jf984BypyXToqG/
         90Dlg6Mknaz0CNi4SEy0jJ7uVylx2MSkM5uSd5tCdrdvKzOB5A9JnunpEfjdFiuKl7jR
         XIXlmGt9uQzIkFxkQrH+d2V+Zs1oqvqkyQQC/yjlVbQtmNH3/RfgM79puv2A+w5U3kRb
         3/K7bsWeWzOtjgqk9zJWdGsSbwDrBqXZDky4kOnNYy0PoM6o2ypuau7EjSjpKesv3n2O
         igfZMWERxrDM9vYnNbBsQmAiOTpknqgKYnKtDEi/JdHTdOspmKWBFUgwULBuyda4rcii
         9ArQ==
X-Forwarded-Encrypted: i=1; AJvYcCU52gnNaidtB4mTUXQ5eZwmIBJWp/fRWVBg7ogbTmymX0c/ysLPsXk4ybv01gDg1j0g+k1yRLb2VY0S@vger.kernel.org
X-Gm-Message-State: AOJu0YwZbtD79I9wffpFouvz43ohuEXD7y3UK4n1zdk2FxNsle28/M3e
	OgDVrlRXwMKZ4ulIsnfjTYLhvdZ1gKcGLgHC/CMLO8OqVnQcnL8gLy65
X-Gm-Gg: AeBDieubs6XrC2xOZPzNUpQLGgo7acZvXoay6pf793clKme77XtWnwxGqOXPsMWtai9
	zWAW7/7I0SdTkZHb7NldjalI+nfvbG51qv2c9uz9BrCjeqQiWmKnPKbSZkpQPAZflYdN7A2zH5J
	YMGgWxhIQ9Le+k+eugks7GY2DhaTT6pGuBB9mqKL5vQIayEmtmmCuL3dbHKJ5dGzwuBYrHEPOkY
	EKv67c9wtmQ1VA8cnM0C678DxN7uDzVDqIdHIRnSBtUvXp9FhCLAXF1z/2f4pr4iHZes6lPmSuP
	/Rj0JfgLZtdz4++Hxfi5fAiw7+2eA0S/gGvjdUyB5rmFBAfCv1EAIUPLNKJyjQKqKd/czfwzn6t
	+54dLRvM463qt7JTOWOUqqss5rheq1Ink3E3XUjd9KDRO1mjJhrWjLR6ipoZl+sTqJ+B06S3ybv
	GQTcP2mD0PkT5M2f4xlLI7YiHyZ/VYmN2M7QpUExC55I3/fOsXhln03MThBRGYY7Q31Ff9i1sWV
	RqJaP7LCf1p36bdZ0/9Xst+ANJWAi7bKnPE2ruMVurkm+b6
X-Received: by 2002:a05:600c:5289:b0:487:22ad:403e with SMTP id 5b1f17b1804b1-488994b34b4mr127115975e9.14.1775344115272;
        Sat, 04 Apr 2026 16:08:35 -0700 (PDT)
Received: from DESKTOP-NQ2T5I7.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488a3d6944bsm82743405e9.11.2026.04.04.16.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 16:08:34 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: prathameshdeshpande7@gmail.com
Cc: dledford@redhat.com,
	haggaie@mellanox.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH v6] IB/mlx5: Fix loopback enablement state and resource leaks
Date: Sun,  5 Apr 2026 00:07:58 +0100
Message-ID: <20260404230759.15131-1-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260404215155.13254-1-prathameshdeshpande7@gmail.com>
References: <20260404215155.13254-1-prathameshdeshpande7@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18981-lists,linux-rdma=lfdr.de];
	TO_DN_NONE(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prathameshdeshpande7@gmail.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 47FCC39CD3D
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
v6:
- Always update software counters regardless of force_enable to prevent 
  underflows during dynamic unbinding [Sashiko].
- Updated disable condition to user_td <= 1 to prevent HW state leaks 
  on systems without transport domains [Sashiko].
- Rebased on rdma/for-next to resolve baseline application failures.
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

 drivers/infiniband/hw/mlx5/main.c | 39 +++++++++++++++++++------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index b74bf2697655..c2fafa00b60c 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2009,23 +2009,31 @@ int mlx5_ib_enable_lb(struct mlx5_ib_dev *dev, bool td, bool qp)
 {
 	int err = 0;
 
-	if (dev->lb.force_enable)
-		return 0;
-
 	mutex_lock(&dev->lb.mutex);
 	if (td)
 		dev->lb.user_td++;
 	if (qp)
 		dev->lb.qps++;
 
-	if (dev->lb.user_td == 2 ||
+	if (dev->lb.force_enable)
+		goto unlock;
+
+	if (dev->lb.user_td == 1 ||
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
@@ -2033,16 +2041,16 @@ int mlx5_ib_enable_lb(struct mlx5_ib_dev *dev, bool td, bool qp)
 
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
 		dev->lb.qps--;
 
-	if (dev->lb.user_td == 1 &&
+	if (dev->lb.user_td <= 1 &&
 	    dev->lb.qps == 0) {
 		if (dev->lb.enabled) {
 			mlx5_nic_vport_update_local_lb(dev->mdev, false);
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
+
+	err = mlx5_ib_enable_lb(dev, true, false);
+	if (err)
+		mlx5_cmd_dealloc_transport_domain(dev->mdev, *tdn, uid);
 
-	return mlx5_ib_enable_lb(dev, true, false);
+	return err;
 }
 
 static void mlx5_ib_dealloc_transport_domain(struct mlx5_ib_dev *dev, u32 tdn,
@@ -4515,6 +4528,7 @@ static int mlx5_ib_stage_init_init(struct mlx5_ib_dev *dev)
 	mutex_init(&dev->data_direct_lock);
 	INIT_LIST_HEAD(&dev->qp_list);
 	spin_lock_init(&dev->reset_flow_resource_lock);
+	mutex_init(&dev->lb.mutex);
 	xa_init(&dev->odp_mkeys);
 	xa_init(&dev->sig_mrs);
 	atomic_set(&dev->mkey_var, 0);
@@ -4786,11 +4800,6 @@ static int mlx5_ib_stage_caps_init(struct mlx5_ib_dev *dev)
 	if (err)
 		return err;
 
-	if ((MLX5_CAP_GEN(dev->mdev, port_type) == MLX5_CAP_PORT_TYPE_ETH) &&
-	    (MLX5_CAP_GEN(dev->mdev, disable_local_lb_uc) ||
-	     MLX5_CAP_GEN(dev->mdev, disable_local_lb_mc)))
-		mutex_init(&dev->lb.mutex);
-
 	if (MLX5_CAP_GEN_64(dev->mdev, general_obj_types) &
 			MLX5_GENERAL_OBJ_TYPES_CAP_VIRTIO_NET_Q) {
 		err = mlx5_ib_init_var_region(dev);
-- 
2.43.0


