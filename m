Return-Path: <linux-rdma+bounces-19006-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCxvGCPb0mnebgcAu9opvQ
	(envelope-from <linux-rdma+bounces-19006-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Apr 2026 23:58:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0289039FEF7
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Apr 2026 23:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AF58301AD05
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Apr 2026 21:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228093845CB;
	Sun,  5 Apr 2026 21:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Psy7yL6y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461CC3845A4
	for <linux-rdma@vger.kernel.org>; Sun,  5 Apr 2026 21:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775426282; cv=none; b=FWAHXssHBAaHsJ8tIOrNuSj4k9+cGB9U1QFnfGgfN2W2a72dVJxgwPoTcZzPgbTwggVX6GFZh8HlqeK9Crg6OuCnNIbXK+BSn/wNC65EB4liYNESfsF6PME2s76yuBpZsP+Bthw6XP9JFSLe0lkIu2HRi2POT6IqafQ5/7IQ5jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775426282; c=relaxed/simple;
	bh=9PgSB8kogVBI6kHUCqIahqOtnI0C8AyrDlTTT0+XSNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aO935lJLBHkkKSpotTbacXOD/w2Q/z+r/5Mnx0doK/xH6wImTytjB575Gy/l1Hqo2xakeTo9KCRK+79ecPNa6yb+zACQdwU+/WJaGV5EFG9VKzux0gLltDy5Hbj7Rvs/ygX0fusNbcHrZ3yQbPB7hXjmb85hmvnAEwlNCkA55DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Psy7yL6y; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488a4bc360bso6553825e9.0
        for <linux-rdma@vger.kernel.org>; Sun, 05 Apr 2026 14:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775426279; x=1776031079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p0RodKviW51tNwaUnbNGUJi1Hu9hhGtdKumi2ui2WlY=;
        b=Psy7yL6ykPJlGPcYCjH+/wzMZOMkbH94ezRDlsKzHlO633ZtmOYUpC9Phn23nBDsc7
         tRzsdp3mOukmjDlIzEohdww0FO9SWp0ZlBCC9L7ilkfXrjiXvzC8ACGib23EZIYoE/zl
         oweiCG3rn+mdRwSKc1euyWl2NfZBO85TnBb0VlNvcAhFg1ZuC5obIbfZXILm+gDRu+tO
         LSHUC1xnLUgtILzRl6JIrKdDBa4DWeU+e6LpQDUaCE2Me06MlTi4xC0rROfFGOxO4mTp
         XsYQ6GBA+u4sNzBpUuQaE3522QjMyYJ7BeVtn3+5UqsWhFtMm1a9emu9yAvZx/9EQdU1
         WWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775426279; x=1776031079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p0RodKviW51tNwaUnbNGUJi1Hu9hhGtdKumi2ui2WlY=;
        b=ZYmQ0SBnWx4Whb03UG/h0cFfJSlNT7SARjxFaOGddI1GUP7RFjQocPAYUZCYACMaFA
         0kX9MF++IAARuKXfJc6KIaAXd5mRBqP/bjnyc94E7TiBMWoKPSavISfFXWcZbv74NVBw
         ix46Kd6IPylsmVphzwhtJYhlBQmFmINO4hEdB8ZJJzZAtSnHf7MJ6ntuL8hu8WLEm4DQ
         xMBR+sRk/yYwtI16ErMjKwxJSnywDQiCUMvoKxWcH0Tr2vrxO0ZUFaaeC68UQHIhjga3
         OPkmWEV6MPZXfXARLNRtJPh+1MCe+e9bJJD564IxW46/EUHbUgKEq8a7oM+eSK9iHqyI
         nNjQ==
X-Gm-Message-State: AOJu0YxA5Ma/hH0r7EoDDNoFdAEKlJL5zbLBKLA5nztH3/O08pvMIyo9
	vCOVyLhyGf4ie1eCEeAqjs/kgiLHFP9x3PQlPvMCAwwq5eZtmBVuFlZI+1Eg0ciN
X-Gm-Gg: AeBDievoYgRNSueUadagfUL6zVJQu9PwEQQhO7lAabFgjWUYQ9TXT2KBgVykjEBy39W
	zIshm8Ci1osOrvoCx92Uh5DVeo+Esz37Rd8DVYNkZHtMRC0EB1X13W7AlQl6M4vlyCKoaRN+5kJ
	FpZ02ZfKdis/Km3+DLCGccnUCfFWXp/z7X3abzHF2DCYt/ZmY37h3+Dbig67A1Movbqzn9iwH4P
	EmKMe389T4vD66Y3ehdpsR3M9VIQmE6/HnJBM/qPcpk7t7X3lhfgewSmMNHCCE/1vYoKZMUWCeN
	QdwKAgzvGzRnR65W/+Zl5j23jR0sYh2rYVMNK2ck9IwqqqAdXgIbgm7pXv2+5BiUiYdvtV6H5z6
	WWI/ZfYi50q7roukZDD80mDfy8rjIvArkX7x3YvVnmLK6+AwzEAHbpWn09gaDX/obfgap6OaoW2
	KqVbdgHt69F0y1xDDOMY85reu2d2lS5GkladG8zQ03YsFyIp8l76GIJJSygW/ZgSZFwE+tGFNAz
	ZslgPIXP+rJEMg+OOwtSlQi/usdPiBcg4fqH82olsoRdn5P
X-Received: by 2002:a05:600c:530d:b0:485:3692:e8f7 with SMTP id 5b1f17b1804b1-488997b7d62mr156567995e9.25.1775426278993;
        Sun, 05 Apr 2026 14:57:58 -0700 (PDT)
Received: from DESKTOP-NQ2T5I7.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e822227sm479479095e9.4.2026.04.05.14.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 14:57:58 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: linux-rdma@vger.kernel.org
Cc: prathameshdeshpande7@gmail.com,
	dledford@redhat.com,
	haggaie@mellanox.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 2/2] IB/mlx5: Fix loopback refcounting leaks and premature disable
Date: Sun,  5 Apr 2026 22:57:18 +0100
Message-ID: <20260405215718.19301-3-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260405215718.19301-1-prathameshdeshpande7@gmail.com>
References: <20260405215718.19301-1-prathameshdeshpande7@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-19006-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,mellanox.com,ziepe.ca,kernel.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prathameshdeshpande7@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0289039FEF7
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
v8:
- Resubmitted as a fresh, independent thread per maintainer request.
- No functional changes since v7.
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


