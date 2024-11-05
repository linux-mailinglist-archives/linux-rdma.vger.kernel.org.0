Return-Path: <linux-rdma+bounces-5778-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 983819BD726
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2024 21:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00184B22BEC
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2024 20:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713211F9AB6;
	Tue,  5 Nov 2024 20:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="RNClhGVh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f98.google.com (mail-oo1-f98.google.com [209.85.161.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEFC1CB9E6
	for <linux-rdma@vger.kernel.org>; Tue,  5 Nov 2024 20:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730839320; cv=none; b=TJNfK2wTjRued4waVWVL3Z/8hq9OZALoF1znKFC8VnQzsqOzUogcfeP/Pyr0KVW2DIcjAkH3yWmIaEtEIex0Xxab6pWpB8g9TDyK79rUDqBba2JGWN4P/lktErBo2MIcn9IU28c3ng9hQ/q6pM2XvHu5+ST+ZAZlAC3pZo8z0jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730839320; c=relaxed/simple;
	bh=fWkWu0fGnyaGjA6B6hCOd4KCPCNJ21ri/TvOuUXtMk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fcFg9pCAxv4zt0IqA/aAoWHYR+9CtaEzKwxnwmjMd6FKpRN1HC8AsC2r91YMo9DjugrSYtuTPLVsQmQYEuUuwQMXukwzuYZITaVSgnYMfWTnhOmXB0t3U2orUM4yWsBrA0HXVDo1wS57Ni975G0JrLynATK7cu/9TaC1t17WOPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=RNClhGVh; arc=none smtp.client-ip=209.85.161.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-oo1-f98.google.com with SMTP id 006d021491bc7-5eb66104733so190044eaf.3
        for <linux-rdma@vger.kernel.org>; Tue, 05 Nov 2024 12:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1730839317; x=1731444117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3D9gC9tIydtY1uqE/NToJTfUA9D/ImLOp+4hoaGi+fk=;
        b=RNClhGVhKTkFG284ltAEZ1+0yCKk677iTVW0oxwpqOmV6byluSW6/Idc1z2dPhEM58
         izIUB5qukkq7rSmjb4Q2URaAO9xqABn9rYX3cXDVzPszANQyAY8esOu+kFMYXE27qX7e
         APaSGXIzHTkVkK4AhVM094UQ+sCCwpFEPFyJ5EYdSQWOGA3X47bp2QyIU2bWJMMcRTE7
         20CiFr8DnYQgKsGpCsPIaEC3+YJYvy4T91OGKmSq1DG0XHXNyXOoR18x+3Vj/nyrkm3M
         k+5WXc8+Be/sFkHJv8dwzV2/m+eK/qN6Y45JND0wRsmSiT5dDVCrEFPHOPxMHxKGj1PK
         FS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730839317; x=1731444117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3D9gC9tIydtY1uqE/NToJTfUA9D/ImLOp+4hoaGi+fk=;
        b=K7ZO1hR5DLp8+9lpd09QnoZZZAN1SPFzR79BiAgphs9owJXbKlgyBRmDD/G2rEbpCK
         D0o63xbJFa62vCKAgaYNdFm6P3foUhYL4ChnWG1yXJir9ylZAPmpJTDP0WXHbXn1d1NH
         UZvhaIoEqhIoqJC9iavCShqAZfFq8Wp8Tew2csJxNaWrrCUUCVXoFLtIHP8rsuQDrf9N
         Nwwd63Ae58hZt2k7p6kBJ6I1p9fEnWkF8UriOd0mmACZjxW9Cv2cYrWmrsDNo/Rwie9d
         c8+fNXszQLIWPimgta7womHkUoiAWFHxY5v9jObdsCdNWzWk2Rcuuf1VO5O2y9DDPSU9
         AWtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtAJ8I6lIDTj+PNXnNOIGLWKvwKln5+RA6IIY4H2ekxz0r8wmbKmDMozdkGFlw+VI8bL7HOp3rdTF4@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+aEYKxxx/NroXNTtu6DlQMa6FhZORjAGuumGcVDwBob1IZx5m
	F7fLtOroJaAppfx2mbklDnPLLCYfJTpggLpnLS8tzUe5CP/Blp61FKNaVOVxccZlFFlBHia8Djg
	Bjw5QsB4USv1Z4L/Ow2ZpJ1gQvX/E2ob9qZICi+YwjcOIYfob
X-Google-Smtp-Source: AGHT+IFFj+NXeyBVIJKuxXoFbm0U0klEMjzpvgGDAfmphm1s5cKOzarMplbtCNgb3hGFDYekjGbsr+xQxXZk
X-Received: by 2002:a05:6830:600a:b0:710:f408:bd54 with SMTP id 46e09a7af769-71867f1a3b3mr10416111a34.2.1730839317543;
        Tue, 05 Nov 2024 12:41:57 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-5ec705a2446sm411582eaf.18.2024.11.05.12.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 12:41:57 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 67E67340245;
	Tue,  5 Nov 2024 13:41:56 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 5D637E42752; Tue,  5 Nov 2024 13:41:26 -0700 (MST)
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
	Parav Pandit <parav@nvidia.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4] mlx5/core: Schedule EQ comp tasklet only if necessary
Date: Tue,  5 Nov 2024 13:39:59 -0700
Message-ID: <20241105204000.1807095-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <ZypqYHaRbBCGo3FD@x130>
References: <ZypqYHaRbBCGo3FD@x130>
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
adds unnecessary overhead. In a heavy TCP workload, we see 4% of CPU
time spent on the tasklet_trylock() in tasklet_action_common(), with a
smaller amount spent on the atomic operations in tasklet_schedule(),
tasklet_clear_sched(), and locking the spinlock in mlx5_cq_tasklet_cb().
TCP completions are handled by mlx5e_completion_event(), which schedules
NAPI to poll the queue, so they don't need tasklet processing.

Schedule the tasklet in mlx5_add_cq_to_tasklet() instead to avoid this
overhead. mlx5_add_cq_to_tasklet() is responsible for enqueuing the CQs
to be processed in tasklet context, so it can schedule the tasklet. CQs
that need tasklet processing have their interrupt comp handler set to
mlx5_add_cq_to_tasklet(), so they will schedule the tasklet. CQs that
don't need tasklet processing won't schedule the tasklet. To avoid
scheduling the tasklet multiple times during the same interrupt, only
schedule the tasklet in mlx5_add_cq_to_tasklet() if the tasklet work
queue was empty before the new CQ was pushed to it.

The additional branch in mlx5_add_cq_to_tasklet(), called for each EQE,
may add a small cost for the userspace Infiniband CQs whose completions
are processed in tasklet context. But this seems worth it to avoid the
tasklet overhead for CQs that don't need it.

Note that the mlx4 driver works the same way: it schedules the tasklet
in mlx4_add_cq_to_tasklet() and only if the work queue was empty before.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Acked-by: Tariq Toukan <tariqt@nvidia.com>
Acked-by: Saeed Mahameed <saeedm@nvidia.com>
---
v4: add comment describing tasklet schedule condition
v3: revise commit message
v2: reorder variable declarations, describe CPU profile results

 drivers/net/ethernet/mellanox/mlx5/core/cq.c | 11 +++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/eq.c |  5 +----
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cq.c b/drivers/net/ethernet/mellanox/mlx5/core/cq.c
index 4caa1b6f40ba..1fd403713baf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cq.c
@@ -69,22 +69,33 @@ void mlx5_cq_tasklet_cb(struct tasklet_struct *t)
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
+		/* If the tasklet CQ work list isn't empty, mlx5_cq_tasklet_cb()
+		 * is scheduled/running and hasn't processed the list yet, so it
+		 * will see this added CQ when it runs. If the list is empty,
+		 * the tasklet needs to be scheduled to pick up the CQ. The
+		 * spinlock avoids any race with the tasklet accessing the list.
+		 */
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
index 859dcf09b770..3fd2091c11c8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
@@ -112,14 +112,14 @@ static int mlx5_eq_comp_int(struct notifier_block *nb,
 	struct mlx5_eq_comp *eq_comp =
 		container_of(nb, struct mlx5_eq_comp, irq_nb);
 	struct mlx5_eq *eq = &eq_comp->core;
 	struct mlx5_eqe *eqe;
 	int num_eqes = 0;
-	u32 cqn = -1;
 
 	while ((eqe = next_eqe_sw(eq))) {
 		struct mlx5_core_cq *cq;
+		u32 cqn;
 
 		/* Make sure we read EQ entry contents after we've
 		 * checked the ownership bit.
 		 */
 		dma_rmb();
@@ -142,13 +142,10 @@ static int mlx5_eq_comp_int(struct notifier_block *nb,
 			break;
 	}
 
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


