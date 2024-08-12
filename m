Return-Path: <linux-rdma+bounces-4340-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9517094F0F1
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2024 16:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AE8C1F20FFE
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2024 14:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658C71862BE;
	Mon, 12 Aug 2024 14:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="jFX0zuWg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC931184554
	for <linux-rdma@vger.kernel.org>; Mon, 12 Aug 2024 14:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474630; cv=none; b=qxqooK0jMyVwc9xWqO7VBa1BG9WJMI2V2eZ+XydeFEJT1h+F8FGvJME3iebY7L+7mxSfRWGSvsJHjRF9cqHy9RemOmwu8lX1uKK9xqw0FNQ8uxhZjfPq4M8HlK6IQXcjgesMiuI9My3JC8PHSWqSAJ/2UeY6fE6THT09XSAb4wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474630; c=relaxed/simple;
	bh=qttIpi4HRsWevPJvdgv7JnCbSSNPmNcCGu3sxRJxwIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hLLNkMhUNOCN6TKqdNJHi2HvpmjA8QrURQG/Ri6Ukt2/q57gON/BEi8TZN5XelgQecHOjzAB1+qN2QAqoi5PU3/7Z9zlSoBenpXC/O5mHzgCW+TAltmuvc4bQtyjgK27PtG7zbdZMN6lrmwmi/hctG9QtYQQCzrwHbLd7/Dmxk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=jFX0zuWg; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fd640a6454so33528345ad.3
        for <linux-rdma@vger.kernel.org>; Mon, 12 Aug 2024 07:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1723474628; x=1724079428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krsVPmGJ7mUpHzCKNJF3hcG8Is07gdPgaERGEpodORE=;
        b=jFX0zuWgifE0wxa+qx0p21VDtTATsMsRg2biF4fCKZWSZcCXaV72F8/iyjB9AWyHyb
         bx4g3+K1HEunDLIIxjU+wrhXchD6KFpHs4cLG7TjNm7JsU6ctO2gCyL14FQowBc8OH0V
         U28Lhvuuo018y03Anf55v/9zAUCFGWIcrniZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723474628; x=1724079428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=krsVPmGJ7mUpHzCKNJF3hcG8Is07gdPgaERGEpodORE=;
        b=a8lShsPXSFfUSPrntE6iAWTEOpF9G0LUD3WvdT9E3rQ53eRYjL2h2Ve1UucW9PbaAc
         OS3DD/eFDKcIBrBsfcJWX36l2vNwDoHWRr5wLEoHVV4LT4Yf7gJZcFDSelLqwBX3n/KB
         o9xZcK8CfohYOz5QVnbqJ71Eo4WUjV5CgGAbiEaFoDr0ZGka32OXQFjkm22L9wtd2AGT
         HB2BlHKnxIbT0OMCp2m79F4YB7Nyn2TKm7kcNwvoCanfhIhvPI3dPMdj5t7rRPtoL7ZP
         kZl59hPLNWjtBVFMSUhHCQMt7sDCKUMg9/eMvWrN+V3F7t/RFqXZsc29v8Om4j5yjIZX
         Y/LQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFuCvMf2Xcg2Tns9Jzi5NlcnbN2G3wsEaHDW6KojdjXr+reTnA3BeQQSuh6e4rUqMOWOwg5i/9DhnwMhUXHjS9BCJousXncyEL9A==
X-Gm-Message-State: AOJu0Yw9MziTBoWCO403pu8p1nQ3g/wZMAB1SavyEEfJXYyw32qh3FlI
	BquTak1+NSFGBdT5WCqDNN9IasYEuhi6fnh2x74756YSUAwwyZorQgEhSIMB/6o=
X-Google-Smtp-Source: AGHT+IGI1VKC/hH97K8mVlaBVtWBUX28eQCqGKnY+VncEcLp2Gvi+LfAg0ooVhF0BwcGRliS31Rfvw==
X-Received: by 2002:a17:902:d4cd:b0:1fa:449:1dd6 with SMTP id d9443c01a7336-201ca1c77edmr6127215ad.48.1723474628092;
        Mon, 12 Aug 2024 07:57:08 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bb8fd835sm39006955ad.89.2024.08.12.07.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 07:57:07 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX5 core VPI driver),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next 2/6] mlx5: Use napi_affinity_no_change
Date: Mon, 12 Aug 2024 14:56:23 +0000
Message-Id: <20240812145633.52911-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240812145633.52911-1-jdamato@fastly.com>
References: <20240812145633.52911-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use napi_affinity_no_change instead of mlx5's internal implementation,
simplifying and centralizing the logic.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h      | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c | 9 +--------
 3 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 7832f6b6c8a8..c288e3f45a06 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -767,7 +767,7 @@ struct mlx5e_channel {
 	spinlock_t                 async_icosq_lock;
 
 	/* data path - accessed per napi poll */
-	const struct cpumask	  *aff_mask;
+	unsigned int		  irq;
 	struct mlx5e_ch_stats     *stats;
 
 	/* control */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 6f686fabed44..7b217aafbdfd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -2684,8 +2684,8 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
 	c->mkey_be  = cpu_to_be32(mdev->mlx5e_res.hw_objs.mkey);
 	c->num_tc   = mlx5e_get_dcb_num_tc(params);
 	c->xdp      = !!params->xdp_prog;
+	c->irq      = irq;
 	c->stats    = &priv->channel_stats[ix]->ch;
-	c->aff_mask = irq_get_effective_affinity_mask(irq);
 	c->lag_port = mlx5e_enumerate_lag_port(mdev, ix);
 
 	netif_napi_add(netdev, &c->napi, mlx5e_napi_poll);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
index 5873fde65c2e..ee453d019c3b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
@@ -39,13 +39,6 @@
 #include "en/xsk/tx.h"
 #include "en_accel/ktls_txrx.h"
 
-static inline bool mlx5e_channel_no_affinity_change(struct mlx5e_channel *c)
-{
-	int current_cpu = smp_processor_id();
-
-	return cpumask_test_cpu(current_cpu, c->aff_mask);
-}
-
 static void mlx5e_handle_tx_dim(struct mlx5e_txqsq *sq)
 {
 	struct mlx5e_sq_stats *stats = sq->stats;
@@ -201,7 +194,7 @@ int mlx5e_napi_poll(struct napi_struct *napi, int budget)
 	busy |= busy_xsk;
 
 	if (busy) {
-		if (likely(mlx5e_channel_no_affinity_change(c))) {
+		if (likely(napi_affinity_no_change(c->irq))) {
 			work_done = budget;
 			goto out;
 		}
-- 
2.25.1


