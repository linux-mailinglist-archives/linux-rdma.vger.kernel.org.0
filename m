Return-Path: <linux-rdma+bounces-2806-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5A08FA722
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 02:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 834BE285F13
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 00:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BC15680;
	Tue,  4 Jun 2024 00:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="tu3N44vG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009DB7FD
	for <linux-rdma@vger.kernel.org>; Tue,  4 Jun 2024 00:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717462009; cv=none; b=ijD9PC9SqTFR5mq8azHxTZp5zLvV9xGpqCAQBah/Q5KA3FLCUsd8q9+i4OBIiTusJP/mJulYRp/kM95aqXh+NPT0Uvp1osuaMB1AEWVw1PHgpWpn4pWJ9B0iimqY8zjYtXMW/cInufo/igzOc4s6Chzam8FldUBUH5iTbvp7HiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717462009; c=relaxed/simple;
	bh=vifrwv8yYRKvsytmY8Yg4L+M9MnG70MF7+heh32UiaU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XY6rluYkvoGVnti3xpudSPOAC96pzAw+RE7a7yYWeR7H/sIqYpojrRWppnx8vyofs5Ifl7daRGVPJqwBmJ02sUPEeR3cbsunCMX7S9OrPQmXKYnpIAt7E2DKTeaWJP7NpPmqDtLvSbRLxKOnxMI9CKjvMz+uc7O15TSecuOd/54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=tu3N44vG; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7026ad046a2so1282561b3a.2
        for <linux-rdma@vger.kernel.org>; Mon, 03 Jun 2024 17:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1717462007; x=1718066807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=26yx+OPnR88JIyyXlG7s80Xixo/lv0hmlHAIk2iBWII=;
        b=tu3N44vGker/sOFaYpTK3RAqvNT7N+dLjmUzDhY6NABFg8eCedMxGwper18EPk0I0n
         LhtHmzBX2P8PrLcrD7groBkikyTyhtvfLFetPjSv9S/eY/zSIddERl2U4ymQ/Z4VI9Wx
         MF3MlSOnbPEO/COSWTFZJa3ao1Ldj06ZjgXJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717462007; x=1718066807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=26yx+OPnR88JIyyXlG7s80Xixo/lv0hmlHAIk2iBWII=;
        b=BsiWlSQZYPlTxfbDh1L1s3zN8H4h+F7P6L7jht5DsGcZZtO/cRLU7uap7ulsMShyIo
         t8Hx+LqwjwJn1jHv+LV95jOsM/aXvb5Q9GUuqijO8aC5sgKe0TWQaLIXSjqkfOCIlFsR
         nVhiGvwyakLO84lZdgxH5TnUHe60v9/FokNRglaKBhvSxGDzWIFFX9rysBgjV8BQlIZ9
         3UVp2N/vJgxes7qgJJ1g3mUnwuYzwd8CWVLcE3m+GCjBzJ4I3TRH4uJX7KURwKfiS0NO
         1ovkYine50tmdy/s/v2WoTXvl82J1G0n2c6AI+fcFLE9KNeqEotlnHSRS+5LewzlA9NX
         1lcg==
X-Forwarded-Encrypted: i=1; AJvYcCUC6DYfKG1bjLbgwbZWhKJV8P47sVydaDmoNKLWxG81pKLuSFuUc6TB262y3puixybAwRkz7xMtcwyt8D4nqrvULVaWVMCXhLUsZA==
X-Gm-Message-State: AOJu0Yz0LlybW4eM3FHTLK2okiL57pVrT7SjaEmihUsHwcjR5QA+evq7
	/nlIeMVuUPQGJxMNi5Am/ZoK+VWkVB16OV2DZHcoBufmq08PFYH6Ojaat2M+rKM=
X-Google-Smtp-Source: AGHT+IEr3WgxVsBp2cu2Hcr4M8L3QkXw8rg3de27C+42+/pPUWvYV6ltTUE5rrNUpd+90siAM5y9Zg==
X-Received: by 2002:a05:6a00:a14:b0:6ed:de70:5ef8 with SMTP id d2e1a72fcca58-702477bc028mr11249753b3a.6.1717462006990;
        Mon, 03 Jun 2024 17:46:46 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242c26067sm6049316b3a.218.2024.06.03.17.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 17:46:46 -0700 (PDT)
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
Subject: [RFC net-next v4 1/2] net/mlx5e: Add txq to sq stats mapping
Date: Tue,  4 Jun 2024 00:46:25 +0000
Message-Id: <20240604004629.299699-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240604004629.299699-1-jdamato@fastly.com>
References: <20240604004629.299699-1-jdamato@fastly.com>
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
index e85fb71bf0b4..4ae3eee3940c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -885,6 +885,8 @@ struct mlx5e_priv {
 	/* priv data path fields - start */
 	struct mlx5e_selq selq;
 	struct mlx5e_txqsq **txq2sq;
+	struct mlx5e_sq_stats **txq2sq_stats;
+
 #ifdef CONFIG_MLX5_CORE_EN_DCB
 	struct mlx5e_dcbx_dp       dcbx_dp;
 #endif
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c
index 6743806b8480..e89272a5d036 100644
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
+	u16 mlx5e_qid;
 
 	sq = mlx5e_get_qos_sq(priv, qid);
 	if (!sq) /* Handle the case when the SQ failed to open. */
@@ -194,7 +196,10 @@ void mlx5e_deactivate_qos_sq(struct mlx5e_priv *priv, u16 qid)
 	qos_dbg(sq->mdev, "Deactivate QoS SQ qid %u\n", qid);
 	mlx5e_deactivate_txqsq(sq);
 
-	priv->txq2sq[mlx5e_qid_from_qos(&priv->channels, qid)] = NULL;
+	mlx5e_qid = mlx5e_qid_from_qos(&priv->channels, qid);
+
+	priv->txq2sq[mlx5e_qid] = NULL;
+	priv->txq2sq_stats[mlx5e_qid] = NULL;
 
 	/* Make the change to txq2sq visible before the queue is started again.
 	 * As mlx5e_xmit runs under a spinlock, there is an implicit ACQUIRE,
@@ -325,6 +330,7 @@ void mlx5e_qos_deactivate_queues(struct mlx5e_channel *c)
 {
 	struct mlx5e_params *params = &c->priv->channels.params;
 	struct mlx5e_txqsq __rcu **qos_sqs;
+	u16 mlx5e_qid;
 	int i;
 
 	qos_sqs = mlx5e_state_dereference(c->priv, c->qos_sqs);
@@ -342,8 +348,11 @@ void mlx5e_qos_deactivate_queues(struct mlx5e_channel *c)
 		qos_dbg(c->mdev, "Deactivate QoS SQ qid %u\n", qid);
 		mlx5e_deactivate_txqsq(sq);
 
+		mlx5e_qid = mlx5e_qid_from_qos(&c->priv->channels, qid);
+
 		/* The queue is disabled, no synchronization with datapath is needed. */
-		c->priv->txq2sq[mlx5e_qid_from_qos(&c->priv->channels, qid)] = NULL;
+		c->priv->txq2sq[mlx5e_qid] = NULL;
+		c->priv->txq2sq_stats[mlx5e_qid] = NULL;
 	}
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index c53c99dde558..d03fd1c98eb6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -3111,6 +3111,7 @@ static void mlx5e_build_txq_maps(struct mlx5e_priv *priv)
 			struct mlx5e_txqsq *sq = &c->sq[tc];
 
 			priv->txq2sq[sq->txq_ix] = sq;
+			priv->txq2sq_stats[sq->txq_ix] = sq->stats;
 		}
 	}
 
@@ -3125,6 +3126,7 @@ static void mlx5e_build_txq_maps(struct mlx5e_priv *priv)
 		struct mlx5e_txqsq *sq = &c->ptpsq[tc].txqsq;
 
 		priv->txq2sq[sq->txq_ix] = sq;
+		priv->txq2sq_stats[sq->txq_ix] = sq->stats;
 	}
 
 out:
@@ -5824,9 +5826,13 @@ int mlx5e_priv_init(struct mlx5e_priv *priv,
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
@@ -5837,6 +5843,8 @@ int mlx5e_priv_init(struct mlx5e_priv *priv,
 
 err_free_tx_rates:
 	kfree(priv->tx_rates);
+err_free_txq2sq_stats:
+	kfree(priv->txq2sq_stats);
 err_free_txq2sq:
 	kfree(priv->txq2sq);
 err_destroy_workqueue:
@@ -5860,6 +5868,7 @@ void mlx5e_priv_cleanup(struct mlx5e_priv *priv)
 		kvfree(priv->channel_stats[i]);
 	kfree(priv->channel_stats);
 	kfree(priv->tx_rates);
+	kfree(priv->txq2sq_stats);
 	kfree(priv->txq2sq);
 	destroy_workqueue(priv->wq);
 	mlx5e_selq_cleanup(&priv->selq);
-- 
2.25.1


