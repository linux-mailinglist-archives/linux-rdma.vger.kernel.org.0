Return-Path: <linux-rdma+bounces-18994-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CCQCzRf0mm6XAcAu9opvQ
	(envelope-from <linux-rdma+bounces-18994-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Apr 2026 15:10:12 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D9B39E849
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Apr 2026 15:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA7A7300D696
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Apr 2026 13:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B861C341ACA;
	Sun,  5 Apr 2026 13:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4WuUICt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23818347BD7
	for <linux-rdma@vger.kernel.org>; Sun,  5 Apr 2026 13:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775394595; cv=none; b=OOhoN4BaV43SpX2gw944moGh3ScuZvXtAmBm1gZ6qGjCISQVqO7sFtFDxTxos3LfG/2Ck5YbbcxCHLO2CKRsNEtuFF03NuMPg6GdCMg2ew0l7GCZHv7aqL5hTcRLzakCEKQFJxm0KsnnO41XpiwB2UraARgCgA84AU9vBjaPuwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775394595; c=relaxed/simple;
	bh=okQQngKXo+aY1Qeyh5ia3DdILYQcp1oNFcCB0azXW5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WnUX8yrtESffl1jSlBSqIRdp5vtB3IjviyVWANwhV8CpnP+lI/zeEXnekGNkxt9Waf9fGHin9sBJ250N8OTaGD0TvpMsGG9n8ozr8rIGVEl6Rhbqu1O1Ff+U0UNWerpv4EOkS6RvocYEy17TrnU6bsgrZrJCmZuye3mcIdrszes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i4WuUICt; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4887eca00c4so21418225e9.2
        for <linux-rdma@vger.kernel.org>; Sun, 05 Apr 2026 06:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775394592; x=1775999392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8uiNnAyaBFWdCwNFZVe5fPpU1Jq+Fz5rI3i14Oz+jO4=;
        b=i4WuUICtyr/pYBJS4dF9kksS/KmNsJ9VK6AWWQ2ZDkET8IihjcPG3BBWSaxlqwyCVz
         wQ4pX43S0/iDpdN09DXKc4ZUCMgd1nFWFnZy4rnFzIns+ScynU3j09hNMLRbkWS1HMq7
         +ONsAM8OioR/ds9c5j9HohynHzhdRpGITrbtWSc/t5a5iRmdbH45MMW7g+LC2nCuXxJE
         ZSCrUz+DjRmOe+aJEUe1t9MbxumUdtvji28upX5SCRs/loTunr1KfRF6qsBi+qjOOc9K
         oIWUWYI0ZQOE16WGMM6EjmqDJj4fjPaMUKvNG0cv2zzFGA7Q6fYomcFBwrNCY1WF+qwf
         /QIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775394592; x=1775999392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8uiNnAyaBFWdCwNFZVe5fPpU1Jq+Fz5rI3i14Oz+jO4=;
        b=LZu8/9QiLSR1mzKFbFu7H9szenVNwdflWzOe8yYH7jABS9gmUtzDiR5cImB8waAoZB
         YRlb8R9LafcpWsA7aSuBwF45mu3R/Gyyh4RpbOlnOvJiO4PdXyyIbAvpYXYMGJzmWJYd
         /Mib9LDVOk3xQNPf9urZlZOA5G/yUnmOD3NM0ZuvCcYIQe2hKjOaTIHT5NGKj8J4Sdfw
         l6wYxObuKZOTo95Ks8CGZugjCkseR9Ub2VdJRyxOld7ssEyBwGkw/WXmcQBk2Z63qcrp
         bhbtDeHZoiXD7vYaGyAaHDCdtj8KejXh835sAaml3eVmd72jwBSBheRSaqkisLspUxnP
         aRDA==
X-Gm-Message-State: AOJu0YwKL6mjbZHFfmUdCoxsKDR5qU/mFKqygfdyUPoxwknSXIL4GtVM
	ZUbFUndw8OY28+L55WaZASQErV5HKL/gAuzloSBhoRe+53zKNVwngKTu6B1dGVKp
X-Gm-Gg: AeBDievUWKW80Z7bS2l8zSoImSsORhRcLq1APOTLX+N789TU6o10o3pvMYwbV93pFnv
	mq3Gf5OO4cABq7059lWnVMQ++S07fhV/PFgqSBqFZoB95gv5dnWZ6l7tP8eM4ojnhq0+tjHexO8
	z7SMHdIGpznc+5HC4GkNLFaVIGkBQWLCTCmWn43iBvI1j9bWBRxOImk8Nrr3NGEvevuZfjrBxA9
	YYIvmtFezGqop44MxRyoEzZYE1eusoxzZBoUBbqhfAn3mJtyj4/NC8QaeLHw0XH/obDcfbogm88
	OIi2ItMrAb0zRaAswQGe1NePUsEG6S+rmncvwon3luGPu8pEGzJtOgZqqvggjw7I9JeNlAf9sxG
	sfHF3p6d2CRNNFFJTZXB9WbmVqjLKPg5BG1ij6D64Ha+iBtYemiDIoc2XNk3d7IMUmM+iJ31P2t
	FbmzD7BsnDUfCEGnqIzVGJl+29gbV79SvqEjbJb8jXOt8OCfWNCMVL7h6EL9ThRdKBfLIWOFQmo
	Me0TOlEnjHTXhzwvIDevdkcDElyjmjeYBCVwlttfW0bxPRKFw+ciYwOzKk=
X-Received: by 2002:a05:600c:a11:b0:488:8185:e672 with SMTP id 5b1f17b1804b1-488998f8562mr127912955e9.30.1775394591786;
        Sun, 05 Apr 2026 06:09:51 -0700 (PDT)
Received: from DESKTOP-NQ2T5I7.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4889f6843dfsm180115695e9.12.2026.04.05.06.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 06:09:50 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: linux-rdma@vger.kernel.org
Cc: prathameshdeshpande7@gmail.com,
	dledford@redhat.com,
	haggaie@mellanox.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/2] IB/mlx5: Fix loopback refcounting leaks and premature disable
Date: Sun,  5 Apr 2026 14:09:23 +0100
Message-ID: <20260405130924.18901-3-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260405130924.18901-1-prathameshdeshpande7@gmail.com>
References: <20260404230759.15131-1-prathameshdeshpande7@gmail.com>
 <20260405130924.18901-1-prathameshdeshpande7@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-18994-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,mellanox.com,ziepe.ca,kernel.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
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
X-Rspamd-Queue-Id: A6D9B39E849
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Update mlx5_ib_enable_lb() and mlx5_ib_disable_lb() to ensure
symmetric updates of user_td and qps counters.

Software state leaks can occur if the force_enable flag is checked
before updating counters. Furthermore, the hardware deactivation
condition in the original code (user_td == 1) can fail to disable
loopback if user_td remains 0, or cause premature deactivation in
multi-user scenarios.

Fix these by:
- Updating counters prior to checking the force_enable gate.
- Disabling hardware only when both user_td and qps reach zero.
- Implementing a counter rollback if the hardware command fails.

Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
---
v7:
- Split into a separate patch for better bisection.
- Moved force_enable check after increments/decrements to fix leaks [Sashiko].
- Updated hardware disable condition to a strict zero-check.
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

 drivers/infiniband/hw/mlx5/main.c | 37 ++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index f49f746bc5bd..fde72ebe721a 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2009,23 +2009,29 @@ int mlx5_ib_enable_lb(struct mlx5_ib_dev *dev, bool td, bool qp)
 {
 	int err = 0;
 
-	if (dev->lb.force_enable)
-		return 0;
-
 	mutex_lock(&dev->lb.mutex);
+
 	if (td)
 		dev->lb.user_td++;
 	if (qp)
 		dev->lb.qps++;
 
-	if (dev->lb.user_td == 2 ||
-	    dev->lb.qps == 1) {
-		if (!dev->lb.enabled) {
-			err = mlx5_nic_vport_update_local_lb(dev->mdev, true);
+	if (dev->lb.force_enable)
+		goto unlock;
+
+	if (!dev->lb.enabled && (dev->lb.user_td >= 1 || dev->lb.qps >= 1)) {
+		err = mlx5_nic_vport_update_local_lb(dev->mdev, true);
+		if (err) {
+			if (td)
+				dev->lb.user_td--;
+			if (qp)
+				dev->lb.qps--;
+		} else {
 			dev->lb.enabled = true;
 		}
 	}
 
+unlock:
 	mutex_unlock(&dev->lb.mutex);
 
 	return err;
@@ -2033,23 +2039,22 @@ int mlx5_ib_enable_lb(struct mlx5_ib_dev *dev, bool td, bool qp)
 
 void mlx5_ib_disable_lb(struct mlx5_ib_dev *dev, bool td, bool qp)
 {
-	if (dev->lb.force_enable)
-		return;
-
 	mutex_lock(&dev->lb.mutex);
+
 	if (td)
 		dev->lb.user_td--;
 	if (qp)
 		dev->lb.qps--;
 
-	if (dev->lb.user_td == 1 &&
-	    dev->lb.qps == 0) {
-		if (dev->lb.enabled) {
-			mlx5_nic_vport_update_local_lb(dev->mdev, false);
-			dev->lb.enabled = false;
-		}
+	if (dev->lb.force_enable)
+		goto unlock;
+
+	if (dev->lb.enabled && (dev->lb.user_td == 0 && dev->lb.qps == 0)) {
+		mlx5_nic_vport_update_local_lb(dev->mdev, false);
+		dev->lb.enabled = false;
 	}
 
+unlock:
 	mutex_unlock(&dev->lb.mutex);
 }
 
-- 
2.43.0


