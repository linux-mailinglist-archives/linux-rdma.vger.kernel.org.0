Return-Path: <linux-rdma+bounces-19248-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNjeNqPz2mn87QgAu9opvQ
	(envelope-from <linux-rdma+bounces-19248-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Apr 2026 03:21:39 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE6C3E25A5
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Apr 2026 03:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 598BD30557CB
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Apr 2026 01:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F8A2D12EC;
	Sun, 12 Apr 2026 01:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSjJJ2kL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167A12BF3F4
	for <linux-rdma@vger.kernel.org>; Sun, 12 Apr 2026 01:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775956806; cv=none; b=Ak1RN62T8fJ3pwecnzVt5ANjrzGu7Gju/2BO5m+2yiUNUHQCn0myA9mX2J859xyOtxuIy21fhCUSXS/IPj2n7D+lCVRw/L4ZYOXju4wm0+7hDE9CJ6u1/fT9qAmf9rxDWZ2TrnaD1jJnQePGaXKh84TZfivbVsOLHs3WYgDnUos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775956806; c=relaxed/simple;
	bh=ihDeI2uUOMIXgbdjNzbAOR7OO6RhP62EWTOPWtclGYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eYE5kXCVfbTq/UVL27Oo9I8SBi9jlsFhxdEGYTal8HKgt3go8j2ccTIQ2fiHIh9pX0tAZHdC76I31StjRT8yjmdRqQD2uiK8cUNM51o1yG6kh9OQKgHYq0aMviR88a8jn7HnPSC5Wy0Yv+r8kGTsLzh0us7QXKj9AoZOOVtmKTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lSjJJ2kL; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43ba1f3fa7eso3366846f8f.2
        for <linux-rdma@vger.kernel.org>; Sat, 11 Apr 2026 18:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775956802; x=1776561602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w88ok4FjcXWQxMS0ICUIgG8uXvZuVdvGncjq3kPMsik=;
        b=lSjJJ2kL2rGkahS4Y3QsiTfRiS54D1chOXmKhNU0hzVUSGglESTXNYM7LQ3gpQt+Bl
         lxCNOWqbWY9eNcycpSj1I5nTn32yNSD7sTttjyJoQxRI5+Oh1PtK3j/s1D3HLll8MNAt
         YW4qpWfV74Az52BhYxnNZ5rBIeXBkpW94GRXq6pumTsI8Uqp857lkXPcNLNPKfuntJKv
         2Cqat0cAxyuFdA05peeV1qXXWQC7qiVsjMcKFF+/Tl1nACcyel6N52ueQmqKjVV55BSB
         jZx3dthNlYKqi3bqy79njO4l+2aWz+7e6ECutRMlqRoT5ApaxsPTxnt3E1bDs1siJ0i6
         8a+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775956802; x=1776561602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w88ok4FjcXWQxMS0ICUIgG8uXvZuVdvGncjq3kPMsik=;
        b=FzadzPR6rpSa8eP5UMBKSMf50xJGtF6SpOHYWsX5/kk3YDzY9XnQ48R+CZSGn31cLb
         Bz4S0T5pQaPmL2ZegYb9Hbg4NXoDhxlb8LOqnjmwqNvyo9rRRwqUu5S50r3QyCWqUyei
         2SBtmuZHTVWXzNHxYC01J7WeiLXh8CrftPxbhAWornuzxv3oFFNEkfieicI3jqFosKUd
         iOXCiNAGDigS/ABgO64o9WgfpsFtuAPgj92rdYdzkqWPeicnchlUt0rmEir4oNLWT1tb
         1iJob0hfCi9W6mMd5HYOgIrMVYlNLHxSIXUlXgS+0wTMwIubiDZPXyzmNsSsnzBlc75h
         /P5w==
X-Gm-Message-State: AOJu0Yyaa2s3w8zshd7dhKxFtBoMw/1yImAmCm3PvweO8XWAaoxM2Rli
	IfSl7S6AIq1S5R++zfK/7pPaKEEWNt9WbahPnxPqgqyOX3AzZ3yTs34H
X-Gm-Gg: AeBDietuwgwFeMu1lQMWG8ibqgjfyoIOwOOkSsW3cRjUS93ccJjfaNXWG1LPS/Iprjj
	9fDa0b472ijfYTbwhEhr5m02GGYrE44Ww2xF5/nLCspEC5ZoO7zL0tHmB1DH4lyJl/YiJYcymUc
	X9PYk6ycpinMKZO7F5Fhf4R3c1PK3wvnpQKslCPJfSORdRLVzM3cSWnqHFUx77J+/1EHr+8vP6k
	NAHMy1JKxaCN7YL3jJlB85G3o70DFGRm5mE62ftXMXpilTqbsxj5+IXMBh8TKvEx8pnPbRoljVJ
	ESMw538Me2jLE1Dfc76WPh6o34FWw4SoOEZA/k8bn433wmnHW9ueSBgkbW4XTJRR/7rWmSYfWy2
	613pycqfR6xuaWvEYMVBtVFbsHJeKzAJM0shg+hxPTIfph9f87G3avFfzUbvyn9HzZIHPUYZ2Ev
	Yl61WTBMLrUccHuUL4yZnSqr3/AH1AOhsGahZpiO9Jn2Qq9g6/6KAKFpimouWqif/lKTZ+XqNur
	wNmFKcnPKyCFY2QBreS10qU26fma3Y=
X-Received: by 2002:a05:6000:25c2:b0:43c:f1a5:56f6 with SMTP id ffacd0b85a97d-43d642dd457mr12496295f8f.43.1775956802317;
        Sat, 11 Apr 2026 18:20:02 -0700 (PDT)
Received: from SD.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63dec295sm19903643f8f.14.2026.04.11.18.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 18:20:01 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dledford@redhat.com,
	haggaie@mellanox.com,
	Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Subject: [PATCH v10 2/2] IB/mlx5: Serialize force-enable state and preserve loopback accounting
Date: Sun, 12 Apr 2026 02:18:50 +0100
Message-ID: <20260412011942.13744-3-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260412011942.13744-1-prathameshdeshpande7@gmail.com>
References: <20260412011942.13744-1-prathameshdeshpande7@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,mellanox.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-19248-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prathameshdeshpande7@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4CE6C3E25A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

force_enable is shared between MP bind/unbind flows and regular loopback
enable/disable flows. MP helpers updated force_enable without lb.mutex,
while regular paths read it under lb.mutex, allowing races and state
mismatches.

Serialize MP force-enable transitions under lb.mutex. In regular loopback
paths, update counters before checking force_enable
and roll them back if HW enable fails. Also keep pre-existing
master loopback enabled when MP enable fails on the slave side.

Use a TD-capability-aware baseline for user_td transitions so threshold
checks are correct on both TD-capable and no-TD hardware.

Fixes: 08aae7860450 ("RDMA/mlx5: Fix vport loopback forcing for MPV device")
Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
---
 drivers/infiniband/hw/mlx5/main.c | 67 +++++++++++++++++++++++++------
 1 file changed, 55 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index b3b297bc2f2b..1f11ab443233 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -1973,25 +1973,45 @@ static void deallocate_uars(struct mlx5_ib_dev *dev,
 					     context->devx_uid);
 }
 
+static inline u32 mlx5_ib_lb_td_base(struct mlx5_core_dev *mdev)
+{
+	return MLX5_CAP_GEN(mdev, log_max_transport_domain) ? 1 : 0;
+}
+
 static int mlx5_ib_enable_lb_mp(struct mlx5_core_dev *master,
 				struct mlx5_core_dev *slave,
 				struct mlx5_ib_lb_state *lb_state)
 {
+	bool user_enabled;
 	int err;
 
+	lockdep_assert_held(&mlx5_ib_multiport_mutex);
+
+	mutex_lock(&lb_state->mutex);
+	if (lb_state->force_enable) {
+		mutex_unlock(&lb_state->mutex);
+		return 0;
+	}
+	user_enabled = lb_state->enabled;
+
 	err = mlx5_nic_vport_update_local_lb(master, true);
 	if (err)
-		return err;
+		goto unlock;
 
 	err = mlx5_nic_vport_update_local_lb(slave, true);
 	if (err)
 		goto out;
 
 	lb_state->force_enable = true;
+	lb_state->enabled = true;
+	mutex_unlock(&lb_state->mutex);
 	return 0;
 
 out:
-	mlx5_nic_vport_update_local_lb(master, false);
+	if (!user_enabled)
+		mlx5_nic_vport_update_local_lb(master, false);
+unlock:
+	mutex_unlock(&lb_state->mutex);
 	return err;
 }
 
@@ -1999,33 +2019,53 @@ static void mlx5_ib_disable_lb_mp(struct mlx5_core_dev *master,
 				  struct mlx5_core_dev *slave,
 				  struct mlx5_ib_lb_state *lb_state)
 {
-	mlx5_nic_vport_update_local_lb(slave, false);
-	mlx5_nic_vport_update_local_lb(master, false);
+	u32 td_base = mlx5_ib_lb_td_base(master);
+
+	lockdep_assert_held(&mlx5_ib_multiport_mutex);
+
+	mutex_lock(&lb_state->mutex);
 
+	mlx5_nic_vport_update_local_lb(slave, false);
 	lb_state->force_enable = false;
+	if (lb_state->enabled &&
+	    lb_state->user_td <= td_base && lb_state->qps == 0) {
+		mlx5_nic_vport_update_local_lb(master, false);
+		lb_state->enabled = false;
+	}
+
+	mutex_unlock(&lb_state->mutex);
 }
 
 int mlx5_ib_enable_lb(struct mlx5_ib_dev *dev, bool td, bool qp)
 {
+	u32 td_base = mlx5_ib_lb_td_base(dev->mdev);
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
+	if (dev->lb.user_td == td_base + 1 ||
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
@@ -2033,8 +2073,7 @@ int mlx5_ib_enable_lb(struct mlx5_ib_dev *dev, bool td, bool qp)
 
 void mlx5_ib_disable_lb(struct mlx5_ib_dev *dev, bool td, bool qp)
 {
-	if (dev->lb.force_enable)
-		return;
+	u32 td_base = mlx5_ib_lb_td_base(dev->mdev);
 
 	mutex_lock(&dev->lb.mutex);
 	if (td)
@@ -2042,7 +2081,10 @@ void mlx5_ib_disable_lb(struct mlx5_ib_dev *dev, bool td, bool qp)
 	if (qp)
 		dev->lb.qps--;
 
-	if (dev->lb.user_td == 1 &&
+	if (dev->lb.force_enable)
+		goto unlock;
+
+	if (dev->lb.user_td <= td_base &&
 	    dev->lb.qps == 0) {
 		if (dev->lb.enabled) {
 			mlx5_nic_vport_update_local_lb(dev->mdev, false);
@@ -2050,6 +2092,7 @@ void mlx5_ib_disable_lb(struct mlx5_ib_dev *dev, bool td, bool qp)
 		}
 	}
 
+unlock:
 	mutex_unlock(&dev->lb.mutex);
 }
 
-- 
2.43.0


