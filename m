Return-Path: <linux-rdma+bounces-19361-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDHaLP3Z3mkyJQAAu9opvQ
	(envelope-from <linux-rdma+bounces-19361-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 02:21:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A15FF3FF471
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 02:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4667B302E720
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 00:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A761523182D;
	Wed, 15 Apr 2026 00:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPeLgbeI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEAF23ABA7
	for <linux-rdma@vger.kernel.org>; Wed, 15 Apr 2026 00:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776212421; cv=none; b=LA/gqp6db7FTFzInu4FbQ3e5vcruRTBev31J83H5f4ag/kektmZ1ty0JW4MqBg1xoazmHHgIBN1nDxC/A6dLuD+3Sp/E5jW5qhOvEd/xO5SThGFbmMa8gadGbw0BCunWJTAVBMxtE3rUFAPqqp0FGi3GNrl+Wqqt+089/uK3rxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776212421; c=relaxed/simple;
	bh=wRRC+myoDRNiS3Chjt9jKzeFURG8nCHhZyCnT4uClAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BRW1ipRaWtT5Rhg77AN7EOp8/GDUA9YB6bjS31QaUfJUwItBE5WncBqp0KMywW573jAg4o3FV/e3dG3U0PZY8AoG/4bLOpMWU8GhU32cSc2mMRZdL4q05XPpD0c7+W4ChznViILnBD0k5AL8Eqg1C3tOByoTRPj09YfFtrZOQs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPeLgbeI; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso74972375e9.2
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 17:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776212418; x=1776817218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTGfSgIst+cFmUNo9YdtWhV3CTyBFHxJWs4hrjTeAxE=;
        b=bPeLgbeIoVvibYJ4jPk0ICILTXd4K54AvqkwrJexOIuzaTExyo92VJH3UgfLXlmDir
         mTRY3TdUeXoTW5i8iyPfAhc792K7WaOEZf8sWhqvDNVmPDDsVPXvatFtW54v04WscbRX
         VfIzFW1esbuTQUMK16SR4THG/ZaAlGJP+fk1HOkGDRkAWbkja8vFh6EIYnKGsOKvktv4
         1uHAAArVUOktgJ60ZldDUwmlAi90WQlOD+OZgODX1ew2/mAvELd+KRs1rb/qgEP2YOck
         tJm0mb+ZMdldUwbdfsdB//i7lhmpNY8zx90rO+Aiyh1tZJmNthpbLBMsp5Q7L+1w1ycv
         2GJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776212418; x=1776817218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cTGfSgIst+cFmUNo9YdtWhV3CTyBFHxJWs4hrjTeAxE=;
        b=GKapDUGPbW8OYo58sLy/LZwFPXyi4UsW5+dwBFeauXtU5Xv+9ZmmFc7LHyahBy6uJR
         9rqcjNRc3vTal5hZzKoZGQZgFITBDn3N8o173Tt54mW0qVkXCjMJ/lSbgUc5ad/O1fHu
         f05UNBTvKq/HTmVYgFo1UzhimvSYOLD/0GXUCqswR0S9yXWhegJeG+BGWpRJKcQ7WKvJ
         2+2w/AcO5Tkp1nZ9PqVv1ISj3sawrtuuY+jiNEwgpFTDG4avAEGNLu0DT/zc5BrZyqOr
         F2tb97p++DgUj6sBx/R5sp98QFMY90ehTE9R/nOsH1Cbab6NT6y9JZtiwNKAt4HWW5XL
         E96w==
X-Gm-Message-State: AOJu0Yz2nU4rBdaSBg7AaXCIRL7GcL8prZG3/s+kUriVr1+rfLEMXeTy
	YFUYB5HpszHrovmHRG7wwNmp+EKLd3JYjTQAKgbTlCB8U5tcQNsNvZ2q
X-Gm-Gg: AeBDievKd3mGdIIOXO0sAaUA6HzShQwc6jNzn2FNNeuwqjgvTcQWurS+YDR+VWLx6jQ
	2kVRWdYAqYEj+0ndwZMlgWfcehkV2ZkBUD50jq8LuQxIxNk/Ok2xZMH3WkReoTJ/vsK2B18YLRz
	OoNWIi6VMa5IxiLO1eNwmYCW2uAuOTzgqPCiF0FxKKC9QC3qY3o6CTtM1gMlOapaZlHscWcqCoS
	IxBu4ePbNFVYBSyuT5IiwGsxpl9Tny7/w0inq7fygGOp2BqJ9/J/pNEXMxYD6aIAEf5oMNbaoA1
	l9evGUpvbRVAcoh2gvQVSej9VjE7Z6EoQdK5fgrUBG6JmgmM9qfK2CIbiWb1LjxAlebFcQUjPbl
	fRzjCfW36HWU90gC50fRKHoZ+stGmindGl88hHmwan9/lxD0ZHmDmoww6k8cSoxnU/bFCxELO0s
	A35TXe0hoX+wXXmm4hMwTlBT/S/ycnJBPvTB4Fvo3xKEUopGi4FSspXlospU8gD1ZyDTLR6/WWg
	/q/27Bx//1zmm/LsQ/cZ2Lw7Uz73B4nvh3ceGUhEA==
X-Received: by 2002:a05:600c:c088:b0:488:a98b:b891 with SMTP id 5b1f17b1804b1-488d67bf75amr198310845e9.3.1776212418391;
        Tue, 14 Apr 2026 17:20:18 -0700 (PDT)
Received: from SD.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ee03898bsm83149055e9.11.2026.04.14.17.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 17:20:17 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dledford@redhat.com,
	haggaie@mellanox.com,
	Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Subject: [PATCH v11 2/2] IB/mlx5: Fix loopback threshold/accounting in regular path
Date: Wed, 15 Apr 2026 01:19:46 +0100
Message-ID: <20260415002001.25702-3-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415002001.25702-1-prathameshdeshpande7@gmail.com>
References: <20260415002001.25702-1-prathameshdeshpande7@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,mellanox.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-19361-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prathameshdeshpande7@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A15FF3FF471
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index b3b297bc2f2b..6b1182b18702 100644
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


