Return-Path: <linux-rdma+bounces-6036-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAA99D1F32
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Nov 2024 05:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A0CC1F2263A
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Nov 2024 04:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48F7150980;
	Tue, 19 Nov 2024 04:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Q5Jq4elT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D5414F9ED
	for <linux-rdma@vger.kernel.org>; Tue, 19 Nov 2024 04:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731990331; cv=none; b=sPEG8jy5jC+zc+Wa8gkFJq2BgWHfqsD+1iSlDaks0nPytUyi5/EEkXTFjuyf+CFdjlRN0ZAgmAfcXlJF2F6BUbvRZwBQtEIRBwin9RNn04Jc7rXTuWHXN4/jZzOU5A8dzfM9M3PQb4XZbDCqjfVpsmkMc3aXFdE0gsU4g05IG8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731990331; c=relaxed/simple;
	bh=FJjmKpzIYgDfujopHIkhYFFfJzGJtokItrd50odKjeY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bp64j/wJYKwKnepEeAU7B53HhUsgflqsLgpbvUTGro8pjUQeq1ysuvc0lweTU0Vqs3XcZZA9mAyOqfDgyVOy1l2839LX/I7bawXYf1vBIdosubyBNYWg4sfHFyujVqmytCr01N+S4iI86dM5EmSXBxz905IVhum/3SJVYAQu0FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Q5Jq4elT; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-211f35ee55cso2154295ad.1
        for <linux-rdma@vger.kernel.org>; Mon, 18 Nov 2024 20:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1731990329; x=1732595129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3trMWXYzttAOtdIjV6M2XhTs2gOppEYx/zOfIC7UPJ8=;
        b=Q5Jq4elTQE6NzvJyxp4Sq8QsKzEiMNFEQQKtkB63iVO6mL9yNFkHtWr8OIp1xyEb2s
         /RXz76Svba3ki0msM31M69yd9mKp0Jr9o3/gapIjq4fo1ebnRyWTO5ovjYubx69Sm+fU
         vwk0pCdsdCfxdnbvy3Pqph/gtqn46+IvXYsyvc7Kg69e52IaV5e85SLLAiANnoBtQ/4w
         vHRcDhQGGRbdp6h7FReuPHTX9BTs4MNeHm1Jmy9lhQoXi5wFqxel/yoBV1W9XvzxXRg0
         xMJasQiIvyhFoXFeEgmCE8m9uo7VpgMDy9AVyR5h1VGNJamcI5ixq8bFoXYyrImPH3wv
         2hJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731990329; x=1732595129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3trMWXYzttAOtdIjV6M2XhTs2gOppEYx/zOfIC7UPJ8=;
        b=Wnqc99AuQrrcVnsISx9/7aID08l/8fd6UTXnEPlvvsj+QG/dZzIO2zKVhug/JVzufT
         Diyi6GkGoGCJmY3xP7T7qweqN11lp5zk1pg6R0Py11KHg1jB4lI5oFu6JzAimO7GLN83
         UsdbnoMROEnc+sWxa32IOhc3hC++GW29J4+z9YYCE3x08bylfBNtIzkkSwHSmOI/HNQK
         g7MtZnJLu5AHklqXF/PS9+hx1Q8mYjBMa0KPonfmk0xVevy+KyXV1DOEa1l0KRkFO2JJ
         MPuBqOSgnzbFcvgdh+F5qsL0Xxu6MKyEJYr/243Zu2P+4+cOcdsDP2fZzf0g3BaIqI7s
         +s/w==
X-Forwarded-Encrypted: i=1; AJvYcCX3P5+TsSITOS3FrcimYc7/wpze/lEj2hiaIic9fD8as7m30wE4cWGgH8u1vh9oVR/kHLCMekaEZAN1@vger.kernel.org
X-Gm-Message-State: AOJu0YzEnhOIW/lGaE6MrcApBJW44jAI338gc+cYYg8GHg+a1yoJ9Dl9
	Ie2H0iiAoGp/52Ma5mQjo10t26nYog9wn28WJIX5Ufp3n6a5HDZIS5NwayyfNdWker63JxjvMlA
	sbpaZft8it/2SrVru/ho40kBc0dP6i6T8
X-Google-Smtp-Source: AGHT+IHFMNTIlbDoao3VsyR+BDuAcr6gQNxb8Qkp+B5fNRjOApOSdGc0DlUXNezS6aHNNkxf6Vvr6JXjh9oK
X-Received: by 2002:a17:902:d510:b0:20c:8ffa:7dd with SMTP id d9443c01a7336-211d0ec3017mr84205205ad.11.1731990329213;
        Mon, 18 Nov 2024 20:25:29 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-212536a5ab7sm212365ad.108.2024.11.18.20.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 20:25:29 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id BCD93340748;
	Mon, 18 Nov 2024 21:25:28 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id B3195E428AF; Mon, 18 Nov 2024 21:24:58 -0700 (MST)
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
Subject: [PATCH] mlx5/core: remove mlx5_core_cq.tasklet_ctx.priv field
Date: Mon, 18 Nov 2024 21:24:44 -0700
Message-ID: <20241119042448.2473694-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The priv field in mlx5_core_cq's tasklet_ctx struct points to the
mlx5_eq_tasklet tasklet_ctx field of the CQ's mlx5_eq_comp. mlx5_core_cq
already stores a pointer to the EQ. Use this eq pointer to get a pointer
to the tasklet_ctx with no additional pointer dereferences and no void *
casts. Remove the now unused priv field.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/cq.c | 5 ++---
 include/linux/mlx5/cq.h                      | 1 -
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cq.c b/drivers/net/ethernet/mellanox/mlx5/core/cq.c
index 1fd403713baf..dc5a291f0993 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cq.c
@@ -68,11 +68,11 @@ void mlx5_cq_tasklet_cb(struct tasklet_struct *t)
 
 static void mlx5_add_cq_to_tasklet(struct mlx5_core_cq *cq,
 				   struct mlx5_eqe *eqe)
 {
 	unsigned long flags;
-	struct mlx5_eq_tasklet *tasklet_ctx = cq->tasklet_ctx.priv;
+	struct mlx5_eq_tasklet *tasklet_ctx = &cq->eq->tasklet_ctx;
 	bool schedule_tasklet = false;
 
 	spin_lock_irqsave(&tasklet_ctx->lock, flags);
 	/* When migrating CQs between EQs will be implemented, please note
 	 * that you need to sync this point. It is possible that
@@ -117,18 +117,17 @@ int mlx5_create_cq(struct mlx5_core_dev *dev, struct mlx5_core_cq *cq,
 		return err;
 
 	cq->cqn = MLX5_GET(create_cq_out, out, cqn);
 	cq->cons_index = 0;
 	cq->arm_sn     = 0;
+	/* assuming CQ will be deleted before the EQ */
 	cq->eq         = eq;
 	cq->uid = MLX5_GET(create_cq_in, in, uid);
 	refcount_set(&cq->refcount, 1);
 	init_completion(&cq->free);
 	if (!cq->comp)
 		cq->comp = mlx5_add_cq_to_tasklet;
-	/* assuming CQ will be deleted before the EQ */
-	cq->tasklet_ctx.priv = &eq->tasklet_ctx;
 	INIT_LIST_HEAD(&cq->tasklet_ctx.list);
 
 	/* Add to comp EQ CQ tree to recv comp events */
 	err = mlx5_eq_add_cq(&eq->core, cq);
 	if (err)
diff --git a/include/linux/mlx5/cq.h b/include/linux/mlx5/cq.h
index 991526039ccb..cd034ea0ee34 100644
--- a/include/linux/mlx5/cq.h
+++ b/include/linux/mlx5/cq.h
@@ -53,11 +53,10 @@ struct mlx5_core_cq {
 	struct mlx5_rsc_debug	*dbg;
 	int			pid;
 	struct {
 		struct list_head list;
 		void (*comp)(struct mlx5_core_cq *cq, struct mlx5_eqe *eqe);
-		void		*priv;
 	} tasklet_ctx;
 	int			reset_notify_added;
 	struct list_head	reset_notify;
 	struct mlx5_eq_comp	*eq;
 	u16 uid;
-- 
2.45.2


