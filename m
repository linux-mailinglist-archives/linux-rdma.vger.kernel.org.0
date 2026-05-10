Return-Path: <linux-rdma+bounces-20325-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HzgCX8FAWptPwEAu9opvQ
	(envelope-from <linux-rdma+bounces-20325-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 00:23:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A17C2506AE6
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 00:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C20430068EA
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 22:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539553630A9;
	Sun, 10 May 2026 22:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GV0LAvOa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983A2361DD0
	for <linux-rdma@vger.kernel.org>; Sun, 10 May 2026 22:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778451826; cv=none; b=jTeU+wl7SqTrv+r45KLzkRw7e4zwQ2ackLmSpuqnnAKSriXO6zud0qikGHrBRRadsDwVuf4zNYdlf0HXNOjXjsKYtT4Va50XR5uFXMk6rTkq6eqdZdEyKxvXPwPNGSedyKmD6IgJlLTIu8BcXheaFVKnVDIW+iuMdT2IUeh/gKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778451826; c=relaxed/simple;
	bh=oBxuEB+aaHEkcQac15TNh2XExBr2eA7gU/JMXl7Tcrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PmwtxmynMvRDMnSweq01lL+8PH6JoRHr6L8upxzUPZQGScEenXj7g3Mdw/A4pBzaTifSFwk3miaGoeylXxEgMQ+dvc1wqvPaaW/IhWG3EM2bLeufL5sWEX+BGpXOHfjXSa4tIXsaNrVtDPX1oYwNUk/Dowg9UbX+qK/QEmeLVOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GV0LAvOa; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso33687615e9.2
        for <linux-rdma@vger.kernel.org>; Sun, 10 May 2026 15:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778451823; x=1779056623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rt6ifERVXSbrnlx4NxpDGcaM8n5Tm9/Lm9YlK0Pjc0o=;
        b=GV0LAvOaZK5fYVcQUyyiqpQ76PepndWl/DxbT/6dt4r52HA4Zn/GyxZekmjdNV5zL2
         53w8VtLOW/A/eSi9OS7PaFscAOJr0TaV5SCSlJRlU4EfN4i5j6rsVEB2bSamuVQ5ZlUf
         gQHtyeB5H1HTSyHLNMj4GVn99AccksnBFjZ2g0rScEsm/bdiP8sDo4AXw/+SVNqhI+xz
         Ing9s/Ayx3zdliBGiZUAFv8P5Oqd5/+EZ7rjQ4JE8layPZSugvNsygv9bWaA+QQH/NG0
         dt2hmRzQtXQhdycto41bNk8EX4W7satfUSFuPdk1uDxTkzqVq6QdmeSBI1t5ss6U2Aio
         cM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778451823; x=1779056623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rt6ifERVXSbrnlx4NxpDGcaM8n5Tm9/Lm9YlK0Pjc0o=;
        b=XirytbzArqU9N3Ez5Es1Dp4sxXVpsd6trIv8XllZaAsU4b9/kA/PSXolEBXQU7y/Po
         ro6zBo/uX0TX1+nk3WoAOun3YI16F/SPJIN/vrTr8Eap206gQvWFgUfBU/4ss3NKzQHf
         Rzg7YnYhQYl22P+6608fU/2S7/CZcLSEdbmWSqzwJ+sv7ZiXPmPoINu17q6HoxpnAPoo
         DJMzmgvNofEToVeoeLb80Folq/RbH1sKxuzINWymECpHE1w+mw6wN2EWmumCN+CAvDnI
         JHCiNgfjS/x6Cz7JQZzSS9FXPbp2vOboN+AIkPRnGvYFtZ/aHQzqHHRiuC8vzttE82ve
         zPoA==
X-Forwarded-Encrypted: i=1; AFNElJ8kq8bYQEI0hqAfaDEJh6JNIX2jlEORjDP/Hg4u9kT0LoTnjWBE8/+P8UDSpPvfC7yBevhJUfyIh3Bl@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk9JNLNd/3ODdGvN089MSk7xCh4/G/Oryszi2LnRNgOkUq5j5q
	mjrsGlAM3FLQgpVaYIyuHKNcypol+Bcm75yUYu7aw8ZRbKSIIKpStp6W
X-Gm-Gg: Acq92OEz42Hr9k0sYMxDh4yMdAWsIx6tDtYJu5QqNacY4R/L0Lxws6NBBrkyXiT+fPA
	qqrQwCec/yNp/h8/ytnjy8hAuDFJfjzPw7FLmmu6e1RLY8TtiRaOBE58XYk7CRy0k8/t7LcnONA
	Yp0lv1PWZHhyQgy8jrs4RRB1PMZqM0FMJ7DvKoNibbKNEylwZ6rrRFKiyvmFkaXVDO6oouarL/0
	y+Th1+Za8iz4KRbUB3Y7c7y/WS0k5uWf4Xne4tg+IPjpT1EnCKOTzfGL3bQC5Z/vlqldgl2ZsaI
	e76qxkNpxjTLSDf2pdooClrUFsQRL6hqfa54qlU0M0Ebd9Ins5aE1aC3mSRLJ3zTkpfb42nEDQQ
	TlCPsx7NdH6M4ngUBgLMTTKI+nM2O3uUx9ERi4uWBw/TKKXtj6TFRWUbFLcBHdXcAtcNpk5Wizq
	2yif6M5QPqrRtculhwXoqf9ZVFSbTKgLSRrtYIHWkUg6RaHYYfrqSxDH1oP9EijcVNZYI59Xowl
	jx9vx0NCDINN66Zc6Jbgr9R+M1anQM=
X-Received: by 2002:a05:600c:46ca:b0:486:fa35:aef2 with SMTP id 5b1f17b1804b1-48e70687eb6mr118387365e9.4.1778451822997;
        Sun, 10 May 2026 15:23:42 -0700 (PDT)
Received: from SD.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6f9fbf12sm152399565e9.0.2026.05.10.15.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 15:23:42 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Patrisious Haddad <phaddad@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Doug Ledford <dledford@redhat.com>,
	Haggai Eran <haggaie@nvidia.com>,
	Majd Dibbiny <majd@nvidia.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Subject: [PATCH v12 2/2] IB/mlx5: Fix loopback threshold/accounting in regular path
Date: Sun, 10 May 2026 23:22:54 +0100
Message-ID: <20260510222258.6654-3-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260510222258.6654-1-prathameshdeshpande7@gmail.com>
References: <20260510222258.6654-1-prathameshdeshpande7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A17C2506AE6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-20325-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prathameshdeshpande7@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

In regular (non-MP) loopback enable/disable paths, threshold logic uses a
hardcoded user_td baseline and does not rollback counters when HW enable
fails.

Use a TD-capability-aware baseline for user_td transitions, and rollback
user_td/qps accounting if mlx5_nic_vport_update_local_lb() fails.

Per review, keep MP helper behavior unchanged.

Fixes: 08aae7860450 ("RDMA/mlx5: Fix vport loopback forcing for MPV device")
Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
---
 drivers/infiniband/hw/mlx5/main.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index f6d9841c2bcf..eda578029d28 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2005,8 +2005,14 @@ static void mlx5_ib_disable_lb_mp(struct mlx5_core_dev *master,
 	lb_state->force_enable = false;
 }
 
+static inline u32 mlx5_ib_lb_td_base(struct mlx5_core_dev *mdev)
+{
+	return MLX5_CAP_GEN(mdev, log_max_transport_domain) ? 1 : 0;
+}
+
 int mlx5_ib_enable_lb(struct mlx5_ib_dev *dev, bool td, bool qp)
 {
+	u32 td_base = mlx5_ib_lb_td_base(dev->mdev);
 	int err = 0;
 
 	if (dev->lb.force_enable)
@@ -2018,11 +2024,18 @@ int mlx5_ib_enable_lb(struct mlx5_ib_dev *dev, bool td, bool qp)
 	if (qp)
 		dev->lb.qps++;
 
-	if (dev->lb.user_td == 2 ||
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
 
@@ -2033,6 +2046,8 @@ int mlx5_ib_enable_lb(struct mlx5_ib_dev *dev, bool td, bool qp)
 
 void mlx5_ib_disable_lb(struct mlx5_ib_dev *dev, bool td, bool qp)
 {
+	u32 td_base = mlx5_ib_lb_td_base(dev->mdev);
+
 	if (dev->lb.force_enable)
 		return;
 
@@ -2042,7 +2057,7 @@ void mlx5_ib_disable_lb(struct mlx5_ib_dev *dev, bool td, bool qp)
 	if (qp)
 		dev->lb.qps--;
 
-	if (dev->lb.user_td == 1 &&
+	if (dev->lb.user_td <= td_base &&
 	    dev->lb.qps == 0) {
 		if (dev->lb.enabled) {
 			mlx5_nic_vport_update_local_lb(dev->mdev, false);
-- 
2.43.0


