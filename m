Return-Path: <linux-rdma+bounces-3085-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF241905C88
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2024 22:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8294628575F
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2024 20:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DB484E1E;
	Wed, 12 Jun 2024 20:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="OYCxK/jt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC2984D37
	for <linux-rdma@vger.kernel.org>; Wed, 12 Jun 2024 20:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718222974; cv=none; b=A3Ylgh/tjpS63eQneOjgoJNrpPW4NieduwUpFUw+hDtxTyAhGodlcsRSWpcI8Anh1pr5Xv7TBzK7B1qzgiY4a0RamshCbfsE/d0/2yHMEpy2Voepf+KGBUfaDag3yKpEX2W9ulRKqSFrz+KBhbgXB9nTyU8KqRKVPID+s9GzYmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718222974; c=relaxed/simple;
	bh=PsJKH+lCKWWS3H0rneAzrW5DWt2H7bpPV0sFIgSIRlI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m8K+njDpeSB3QtyklZXfnc7ncXgwVVQDJjvmGWWv4kxm0nGRKNTMrOJTJNLLf6y/rkl0+3Il7xL0zkR0knmjJqbJjITqV7cuqEUN9fs7e2fcZIOxHkBKreLIJVodWjvdE2mVHCXuHMN/iIrSQ4uSaUXOU1sqU8femxBp5MWm9fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=OYCxK/jt; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f32a3b9491so2980215ad.0
        for <linux-rdma@vger.kernel.org>; Wed, 12 Jun 2024 13:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1718222971; x=1718827771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHRoXfMJv7xxFmAl7D08EWhFyofI20i7TnuC8dt0Mqk=;
        b=OYCxK/jt+pcBg3p34tbZ+nNlkdeOvRnnqkQQHlV7Wi6/nKIfLucEcJ6scbB/qpHma0
         ArkT06poFbV9eU26MfLubyJdZFm86M+piXIzrCSXppSCa1mOQzYAudWUPvV3vPrR58z7
         /e1AlBmpMNJ7N6zEQZtJEdD3TKtGBRxJGNrRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718222971; x=1718827771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BHRoXfMJv7xxFmAl7D08EWhFyofI20i7TnuC8dt0Mqk=;
        b=E+C68pFFtnguN7qS17nBJ+nFaqtnf8xW+p0c78DHp7mPotsAhlMfCDxD0kB4G041D6
         3BbCeDPwuiHM9zwOLSWQU8V0ZORNsCGqGhcF5QMsf3SIUnEXOPWIF0KXzkGng/nowc8b
         W9LG0B51v9ZvUF5XGLJg8xZsEJMNbjrdPPE9uZffwVMv0uexjOIY7Tb67xDm5Gw/q3k3
         K/YsRXjORBpcMEmxJBnFbX08F3eyqR6tlZaLJ5Mh4/RcIFqPwJhDpKBUWPR+uFg35Pti
         8HjYK9QdFQQTt69lJhuS/HxivsQV6ZBQwSiZDAfmqzd8rQCf1nlNFJXHr6Wz58aA7nCn
         dABg==
X-Forwarded-Encrypted: i=1; AJvYcCX5cxUAvdjU4R320Bo+qFMYRb9Ojnd4Zw4hCugwPHioIEwDT2ufir/CLlvRDSTG23pBcRIFaktyFFSZwyAiftEIJsT/FM9uDJXAdw==
X-Gm-Message-State: AOJu0Yx3rDo5I31Slm2FZcMdjqtBn8w50hhJI+GTo2IQKsSFHxi+CXBU
	xDbhoMSYcMiEb4rfS8Zdojr3Q8FBswSZ1Ps23dfn2Y7mMGR2R0JEkzW24VB3NEw=
X-Google-Smtp-Source: AGHT+IGB5oEl7l0tZsi6sOT+SddVNR5ScKCvGZij4rfG2UQemhbbUGNns6syPq7qUh+bwWKg4TSdng==
X-Received: by 2002:a17:902:ea12:b0:1f6:6de6:9274 with SMTP id d9443c01a7336-1f83b716bbamr33029335ad.59.1718222971242;
        Wed, 12 Jun 2024 13:09:31 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6ee3d5a17sm91506805ad.146.2024.06.12.13.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 13:09:30 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: nalramli@fastly.com,
	Joe Damato <jdamato@fastly.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Gal Pressman <gal@nvidia.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Naveen Mamindlapalli <naveenm@marvell.com>,
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX5 core VPI driver)
Subject: [net-next v5 1/2] net/mlx5e: Add txq to sq stats mapping
Date: Wed, 12 Jun 2024 20:08:56 +0000
Message-Id: <20240612200900.246492-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240612200900.246492-1-jdamato@fastly.com>
References: <20240612200900.246492-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mlx5 currently maps txqs to an sq via priv->txq2sq. It is useful to map
txqs to sq_stats, as well, for direct access to stats.

Add priv->txq2sq_stats and insert mappings. The mappings will be used
next to tabulate stats information.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h      |  2 ++
 drivers/net/ethernet/mellanox/mlx5/core/en/qos.c  | 13 +++++++++++--
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 11 ++++++++++-
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index bec784d25d7b..6a343a8f162f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -867,6 +867,8 @@ struct mlx5e_priv {
 	/* priv data path fields - start */
 	struct mlx5e_selq selq;
 	struct mlx5e_txqsq **txq2sq;
+	struct mlx5e_sq_stats **txq2sq_stats;
+
 #ifdef CONFIG_MLX5_CORE_EN_DCB
 	struct mlx5e_dcbx_dp       dcbx_dp;
 #endif
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c
index 6743806b8480..f0744a45db92 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c
@@ -170,6 +170,7 @@ int mlx5e_activate_qos_sq(void *data, u16 node_qid, u32 hw_id)
 	mlx5e_tx_disable_queue(netdev_get_tx_queue(priv->netdev, qid));
 
 	priv->txq2sq[qid] = sq;
+	priv->txq2sq_stats[qid] = sq->stats;
 
 	/* Make the change to txq2sq visible before the queue is started.
 	 * As mlx5e_xmit runs under a spinlock, there is an implicit ACQUIRE,
@@ -186,6 +187,7 @@ int mlx5e_activate_qos_sq(void *data, u16 node_qid, u32 hw_id)
 void mlx5e_deactivate_qos_sq(struct mlx5e_priv *priv, u16 qid)
 {
 	struct mlx5e_txqsq *sq;
+	u16 txq_ix;
 
 	sq = mlx5e_get_qos_sq(priv, qid);
 	if (!sq) /* Handle the case when the SQ failed to open. */
@@ -194,7 +196,10 @@ void mlx5e_deactivate_qos_sq(struct mlx5e_priv *priv, u16 qid)
 	qos_dbg(sq->mdev, "Deactivate QoS SQ qid %u\n", qid);
 	mlx5e_deactivate_txqsq(sq);
 
-	priv->txq2sq[mlx5e_qid_from_qos(&priv->channels, qid)] = NULL;
+	txq_ix = mlx5e_qid_from_qos(&priv->channels, qid);
+
+	priv->txq2sq[txq_ix] = NULL;
+	priv->txq2sq_stats[txq_ix] = NULL;
 
 	/* Make the change to txq2sq visible before the queue is started again.
 	 * As mlx5e_xmit runs under a spinlock, there is an implicit ACQUIRE,
@@ -325,6 +330,7 @@ void mlx5e_qos_deactivate_queues(struct mlx5e_channel *c)
 {
 	struct mlx5e_params *params = &c->priv->channels.params;
 	struct mlx5e_txqsq __rcu **qos_sqs;
+	u16 txq_ix;
 	int i;
 
 	qos_sqs = mlx5e_state_dereference(c->priv, c->qos_sqs);
@@ -342,8 +348,11 @@ void mlx5e_qos_deactivate_queues(struct mlx5e_channel *c)
 		qos_dbg(c->mdev, "Deactivate QoS SQ qid %u\n", qid);
 		mlx5e_deactivate_txqsq(sq);
 
+		txq_ix = mlx5e_qid_from_qos(&c->priv->channels, qid);
+
 		/* The queue is disabled, no synchronization with datapath is needed. */
-		c->priv->txq2sq[mlx5e_qid_from_qos(&c->priv->channels, qid)] = NULL;
+		c->priv->txq2sq[txq_ix] = NULL;
+		c->priv->txq2sq_stats[txq_ix] = NULL;
 	}
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 44a64d062e42..c548e2fdc58f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -3125,6 +3125,7 @@ static void mlx5e_build_txq_maps(struct mlx5e_priv *priv)
 			struct mlx5e_txqsq *sq = &c->sq[tc];
 
 			priv->txq2sq[sq->txq_ix] = sq;
+			priv->txq2sq_stats[sq->txq_ix] = sq->stats;
 		}
 	}
 
@@ -3139,6 +3140,7 @@ static void mlx5e_build_txq_maps(struct mlx5e_priv *priv)
 		struct mlx5e_txqsq *sq = &c->ptpsq[tc].txqsq;
 
 		priv->txq2sq[sq->txq_ix] = sq;
+		priv->txq2sq_stats[sq->txq_ix] = sq->stats;
 	}
 
 out:
@@ -5849,9 +5851,13 @@ int mlx5e_priv_init(struct mlx5e_priv *priv,
 	if (!priv->txq2sq)
 		goto err_destroy_workqueue;
 
+	priv->txq2sq_stats = kcalloc_node(num_txqs, sizeof(*priv->txq2sq_stats), GFP_KERNEL, node);
+	if (!priv->txq2sq_stats)
+		goto err_free_txq2sq;
+
 	priv->tx_rates = kcalloc_node(num_txqs, sizeof(*priv->tx_rates), GFP_KERNEL, node);
 	if (!priv->tx_rates)
-		goto err_free_txq2sq;
+		goto err_free_txq2sq_stats;
 
 	priv->channel_stats =
 		kcalloc_node(nch, sizeof(*priv->channel_stats), GFP_KERNEL, node);
@@ -5862,6 +5868,8 @@ int mlx5e_priv_init(struct mlx5e_priv *priv,
 
 err_free_tx_rates:
 	kfree(priv->tx_rates);
+err_free_txq2sq_stats:
+	kfree(priv->txq2sq_stats);
 err_free_txq2sq:
 	kfree(priv->txq2sq);
 err_destroy_workqueue:
@@ -5885,6 +5893,7 @@ void mlx5e_priv_cleanup(struct mlx5e_priv *priv)
 		kvfree(priv->channel_stats[i]);
 	kfree(priv->channel_stats);
 	kfree(priv->tx_rates);
+	kfree(priv->txq2sq_stats);
 	kfree(priv->txq2sq);
 	destroy_workqueue(priv->wq);
 	mlx5e_selq_cleanup(&priv->selq);
-- 
2.25.1


