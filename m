Return-Path: <linux-rdma+bounces-19199-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPwODf9J2Gm0bAgAu9opvQ
	(envelope-from <linux-rdma+bounces-19199-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Apr 2026 02:53:19 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3C03D0E74
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Apr 2026 02:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50D49302C904
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Apr 2026 00:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0848031AABF;
	Fri, 10 Apr 2026 00:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/V86Vaw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAB831714C
	for <linux-rdma@vger.kernel.org>; Fri, 10 Apr 2026 00:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775782355; cv=none; b=EBXyZqu1Ev7mgenLodP0Z1IOjC5ukjF3DVVvcHS/xs5AWxr/gsjT+DRGvFzzn7JSfqtmqInCR/Xse4jIVHvYtbG7IsuXC8lx9HmRStXMQIVbTTmfIB4G7nsquY9HAiz0y4hff1L6k1IAHYYlr2V1fPDtnArte3pBMKVwBpJCMk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775782355; c=relaxed/simple;
	bh=AzK9ruia8Q87pTv0kbUNrH9po6XlPjhIs72J+aJy4qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NLdlTnz9hjyRiUBFxeJAOeiXNolPsWRFf8JoBm5OCKfwzAWlJZaU+NDK+Cv4WptaWib7w2zmPHw+C+fVtV3hd6xVDu0eh/Pk1th2czH8+pKJQ/ba0U94XInPDSbVK4Nrp1d9DvePCps5rSTp0wp6toU94XwIST1cxOIcDjF37iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/V86Vaw; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so19014895e9.0
        for <linux-rdma@vger.kernel.org>; Thu, 09 Apr 2026 17:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775782353; x=1776387153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SLgSuAiphf84lF6XSAXW7SBQ6kFrrEH+AhQsxWrl6jA=;
        b=K/V86VawsDbtK7h0C1poS645DEzuhXJSSSdciQRFmkbw+NN52QsR8zX0Eewz+VhwqW
         BZgUHfst6CEZRAzKiRNqTJVwvG6cWBL4/USJPiAAjLb7vtS9gnIKh+sNG+Jfi6qXZFSA
         +RURRo8sUbjp/U1PfBltau06dZzWeLYiClXFWdOAliWoH6qUy7Q++B/ZjR9vEwx7PQXp
         VaJ2V+d4TaYWrVuuxKVojhBWnQ0DJvAYhiZ89JXW9gDBsrQJH/tq3lH6SVNixhxmbJ0F
         ZVD3sQNdhPK4s7Ld37hI2KyjyRJ32MOuwHPM+hJu3c0r3X89rMfmuvetAWbDTQlDAetN
         npSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775782353; x=1776387153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SLgSuAiphf84lF6XSAXW7SBQ6kFrrEH+AhQsxWrl6jA=;
        b=Sf0z5O5DI0CyuTku7wVQl2sRxlQJLX8EXJnzond963VX7kTR/XWm8UIp9cb4LKwfsy
         kBpeodf1BDjL3f4AXexzcPA6GfLPC+Mywg7Is3RB7cudp61cturvw/mq7VehlxKuPD3P
         K/BX4x3GUuDbrCgL7gy/y9MbMnkQkmZL0luVRh57lFC8fkT3IO1zDxgrBylKCF/rUagK
         +4zDMkG3npR9BkTHP/QxBnOLimxeEeNsC4LuRXjPRgsJ9OcgQXJezMUrt7p0KX9Pi4GQ
         A59Q022qWs61ehBOrjiT0yzWA+VcTnkwVOvJOF2IBs+n9HPwZTGjUDjdKTeic+NwIzXl
         jxwg==
X-Gm-Message-State: AOJu0YxNHtn6fp4qUwzC6j7x1xkwu8rXRCuySDZaAwEj5FSCXObdED79
	ygpB0Pztp9ryQKhKoDejbZ8pbbysjEqbJMz+TI50D4WePSXmhkVUcFKR
X-Gm-Gg: AeBDievIm9gbKwiW+feykGPwSWwnr7atyeKduq/I0F/OofxRW/jYTqnTTWIQ0BCjlJ8
	gOn34VpLpaTOSWU9+/dsNSjTJiiGDke6WyD+/JP9U/+tQ1dE1oRFF+oi540yHRMipZ2nAk0YGM/
	PmgabK1dm8+t0JdKQ1bpSfNsFvDTDl2vxQ56ZpaymiYSRYlTsuNJrzYOfjWRlQwMQAMr/Ydzlo0
	62fnIRoA0MtdmrsxdMojdmAUDxKo74TIZzuSU5dm1icM+XUrVhlMPUOugTdICZNbLm1vCvHaAhm
	rXdwpRf19BbZmUkn2+yg0xhWIhmKNF45rhGyLEmr+xjrRhABpyKV4iIDRqK9AGtIr4IBjIEDsIk
	CmaDEBQofRrD0xk4Q/k2tPjZCA07FnKdVFNhfchyvsglcQlOXyk7M7lltzTEl6c0q9Z3LXZPs0T
	VWsTPlPSBcefPnkxuUbAlHMAk8sCUomSj1Mq9Wum5EclBP820bYowyb+rOAEkkdL3no0/PRsQKJ
	j8DzXgueyKg9uoabdIgfZ+/zLqSU9dPaDG5DYuT+JK5YfEz
X-Received: by 2002:a05:600c:64cd:b0:487:21c7:2885 with SMTP id 5b1f17b1804b1-488d67df57dmr10982015e9.5.1775782352671;
        Thu, 09 Apr 2026 17:52:32 -0700 (PDT)
Received: from DESKTOP-NQ2T5I7.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d67b4903sm8508265e9.5.2026.04.09.17.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 17:52:31 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dledford@redhat.com,
	haggaie@mellanox.com,
	Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Subject: [PATCH v9 2/2] IB/mlx5: Serialize force-enable state and preserve loopback accounting
Date: Fri, 10 Apr 2026 01:52:18 +0100
Message-ID: <20260410005219.5197-3-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260410005219.5197-1-prathameshdeshpande7@gmail.com>
References: <20260410005219.5197-1-prathameshdeshpande7@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,mellanox.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19199-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prathameshdeshpande7@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 8D3C03D0E74
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
index 6be198c0651c..5038053cc9cc 100644
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
+	    lb_state->user_td == td_base && lb_state->qps == 0) {
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
+	if (dev->lb.user_td == td_base &&
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


