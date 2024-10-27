Return-Path: <linux-rdma+bounces-5531-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DB69B1C1D
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Oct 2024 05:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C861AB2138E
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Oct 2024 04:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C37E1CFA9;
	Sun, 27 Oct 2024 04:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="C7qVNel0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f228.google.com (mail-qt1-f228.google.com [209.85.160.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3041BC49
	for <linux-rdma@vger.kernel.org>; Sun, 27 Oct 2024 04:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730002042; cv=none; b=k6MEZCirMafMKoW4h/xF8bOKe+yPJ0NLCYm7zKZJOVB2QmRIo7VC9di8/a8jqjFgQH7kNS8grMVd7/kvHSgXlfOKDh1AlHuZjjo4rnIkqiFvhew3fWdVtnPwv/8vvsHcp6QOs6q2iuhZ3huzQzNshMpcJ3im+/wbU+SHsvZZupE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730002042; c=relaxed/simple;
	bh=K40sm6a5rnZnDviFoC5gXMAnEzE/x92f8YKdKML+Okg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dtvt/Sn+P3SeEwI79mrIB18FwrnAszHBRBFr+85jknurTHEGs6r+lqSWYtcPH8S26Y4lSpcrhSy1AjrLQCRI7qgboVPnuO0ioQMAzXCHVpocpAs1Gb5tx8tRwhWrb0hNeq/l4Pxu7cLlRAdStDv/Uoij4O6DGSdmJu3ondAdSGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=C7qVNel0; arc=none smtp.client-ip=209.85.160.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-qt1-f228.google.com with SMTP id d75a77b69052e-460e3b596fcso1138691cf.2
        for <linux-rdma@vger.kernel.org>; Sat, 26 Oct 2024 21:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1730002038; x=1730606838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yFPBOawvNAC40LRH3vsqWPQVymUE1kR2pFs5OkfXjZc=;
        b=C7qVNel0KuEN8AXD5Kh9lOPOqHCR/e8KbpEspG5b2wcsvI9X6hHUTMhVuIuqN66ttR
         OKSSCy+54NjI/LJH9z6fjRyI/g2zK3MSW33hfWC54JK6zamJWiZcTWJn0k902qcKf1k8
         16sf359118BwJHcq1ggUzuMSLaubuVGNIknuI7+/1WrxuLEiNP8bHz5UFvnjdFe13Yhe
         073W4Rvcy1AR+7elNcBG2I3z6xrYkUs+GPuZAb7JS18zCJBrBZ0zUV44G45/+Z3cnxK+
         4rIl/EG7Q+ZxcPfVobo2MT/0pvqITRyIs0lbO6KxMVWiMOPJHejKFbpao5HLPQEbgcwp
         fIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730002038; x=1730606838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yFPBOawvNAC40LRH3vsqWPQVymUE1kR2pFs5OkfXjZc=;
        b=oy5QNgY9zW6mdusOBwtlTGNZv6Xa+EwlrpZz90AC4tejdwst6B1p1fkpzbWdW7Bt16
         /Yl8oX+tk1W8etJkOYgIt4LKd0rpBe0E2p21o0I6+tj/sCNdsHXAITqEX81HfDMX1R4c
         VZ/IomRKnDHMhFNdhsCl85979YFaIJ/iQ9h/Vgp5irHQ1PA1Q2kl2+cY5YLjEyJl5MN4
         yiZlcMzxWyol0oEDbS4ug3BAqhFDKSxd5TfyTfC0MsOaoHz1lsPL/KmV+EzObe79bKQv
         ma/VK07mOQm1kbC3mZAOlsRsukVW6FSgc6odoMARhQrxA8Wme1b3HgDUD5WbZ6T7F/OZ
         9z/A==
X-Forwarded-Encrypted: i=1; AJvYcCXLrhJbMkW4UTeqjZ3FC6ueIjQiMhovUIya6j6GmyI7fKhC6MNroXoaKHwYfE+O6tvay40nMOePm9xP@vger.kernel.org
X-Gm-Message-State: AOJu0YwENBwlMrwV1frGTRblQCzOADJ67hziMKSiv3o6sC7o2+uEzAXq
	BGY4vxYBLFTfdb6a0/wSXnxtI/alz+dcm51gDDUZOz2pwoBTOOdfTR8X8bXBrGHqWC9qfoTsO2c
	YBIElcROfLdf6+zIs3HAvWS2lPD8D0JSfK2xyCjoDf/Gzh+Rt
X-Google-Smtp-Source: AGHT+IFLVMIJviFB7oFNyQyjEM3uN/bEshHi0Ww68pbsDPdz+G/261P3Itvj7Q1GDkCFDmN+vqTdp3NEj8vT
X-Received: by 2002:a05:622a:89:b0:460:9acd:68be with SMTP id d75a77b69052e-4613c005fbcmr32681281cf.5.1730002038304;
        Sat, 26 Oct 2024 21:07:18 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-46132179ceesm1643211cf.11.2024.10.26.21.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 21:07:18 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id D2313340278;
	Sat, 26 Oct 2024 22:07:16 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id CD2F9E40D12; Sat, 26 Oct 2024 22:07:16 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mlx5: only schedule EQ comp tasklet if necessary
Date: Sat, 26 Oct 2024 22:06:55 -0600
Message-ID: <20241027040700.1616307-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the mlx5_eq_comp_int() interrupt handler schedules a tasklet
to call mlx5_cq_tasklet_cb() if it processes any completions. For CQs
whose completions don't need to be processed in tasklet context, this
overhead is unnecessary. Atomic operations are needed to schedule, lock,
and clear the tasklet. And when mlx5_cq_tasklet_cb() runs, it acquires a
spin lock to access the list of CQs enqueued for processing.

Schedule the tasklet in mlx5_add_cq_to_tasklet() instead to avoid this
overhead. mlx5_add_cq_to_tasklet() is responsible for enqueuing the CQs
to be processed in tasklet context, so it can schedule the tasklet. CQs
that need tasklet processing have their interrupt comp handler set to
mlx5_add_cq_to_tasklet(), so they will schedule the tasklet. CQs that
don't need tasklet processing won't schedule the tasklet. To avoid
scheduling the tasklet multiple times during the same interrupt, only
schedule the tasklet in mlx5_add_cq_to_tasklet() if the tasklet work
queue was empty before the new CQ was pushed to it.

Note that the mlx4 driver works the same way: it schedules the tasklet
in mlx4_add_cq_to_tasklet() and only if the work queue was empty before.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/cq.c | 5 +++++
 drivers/net/ethernet/mellanox/mlx5/core/eq.c | 5 +----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cq.c b/drivers/net/ethernet/mellanox/mlx5/core/cq.c
index 4caa1b6f40ba..25f3b26db729 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cq.c
@@ -69,22 +69,27 @@ void mlx5_cq_tasklet_cb(struct tasklet_struct *t)
 static void mlx5_add_cq_to_tasklet(struct mlx5_core_cq *cq,
 				   struct mlx5_eqe *eqe)
 {
 	unsigned long flags;
 	struct mlx5_eq_tasklet *tasklet_ctx = cq->tasklet_ctx.priv;
+	bool schedule_tasklet = false;
 
 	spin_lock_irqsave(&tasklet_ctx->lock, flags);
 	/* When migrating CQs between EQs will be implemented, please note
 	 * that you need to sync this point. It is possible that
 	 * while migrating a CQ, completions on the old EQs could
 	 * still arrive.
 	 */
 	if (list_empty_careful(&cq->tasklet_ctx.list)) {
 		mlx5_cq_hold(cq);
+		schedule_tasklet = list_empty(&tasklet_ctx->list);
 		list_add_tail(&cq->tasklet_ctx.list, &tasklet_ctx->list);
 	}
 	spin_unlock_irqrestore(&tasklet_ctx->lock, flags);
+
+	if (schedule_tasklet)
+		tasklet_schedule(&tasklet_ctx->task);
 }
 
 /* Callers must verify outbox status in case of err */
 int mlx5_create_cq(struct mlx5_core_dev *dev, struct mlx5_core_cq *cq,
 		   u32 *in, int inlen, u32 *out, int outlen)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
index 68cb86b37e56..66fc17d9c949 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
@@ -112,17 +112,17 @@ static int mlx5_eq_comp_int(struct notifier_block *nb,
 	struct mlx5_eq_comp *eq_comp =
 		container_of(nb, struct mlx5_eq_comp, irq_nb);
 	struct mlx5_eq *eq = &eq_comp->core;
 	struct mlx5_eqe *eqe;
 	int num_eqes = 0;
-	u32 cqn = -1;
 
 	eqe = next_eqe_sw(eq);
 	if (!eqe)
 		goto out;
 
 	do {
+		u32 cqn;
 		struct mlx5_core_cq *cq;
 
 		/* Make sure we read EQ entry contents after we've
 		 * checked the ownership bit.
 		 */
@@ -145,13 +145,10 @@ static int mlx5_eq_comp_int(struct notifier_block *nb,
 	} while ((++num_eqes < MLX5_EQ_POLLING_BUDGET) && (eqe = next_eqe_sw(eq)));
 
 out:
 	eq_update_ci(eq, 1);
 
-	if (cqn != -1)
-		tasklet_schedule(&eq_comp->tasklet_ctx.task);
-
 	return 0;
 }
 
 /* Some architectures don't latch interrupts when they are disabled, so using
  * mlx5_eq_poll_irq_disabled could end up losing interrupts while trying to
-- 
2.45.2


