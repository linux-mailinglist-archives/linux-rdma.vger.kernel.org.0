Return-Path: <linux-rdma+bounces-964-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBE884D816
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Feb 2024 04:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D6851C22BA2
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Feb 2024 03:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031C81CD19;
	Thu,  8 Feb 2024 03:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="v05K2LjN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321441D524
	for <linux-rdma@vger.kernel.org>; Thu,  8 Feb 2024 03:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707361630; cv=none; b=dJFOxrZx9qz0XKl6I3b2VhMzGiUO1qnej3z5orLTGFZP+UzVN3yluPQINQx2jbfS5XWXug53NxcwbCbq+NGVDN0ab8Ioy0Ir6Yb15px5WmUB10HD/D1bjDEmZNwFUzYkmHdBhSp2/qOELNc+QQUwmAKp8PP8BNPiNQ7tPthdKMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707361630; c=relaxed/simple;
	bh=Uh3Rm8V4VHsu71sBjaBczwz61EnKx5fFtPzxEMRZyvI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iey75DPiVPGFIVX2fSJYlZ4A+icfwjZNbnNfB11Lcoh5NYgbug2+TcLEekzRUfWCdOs2kZ6wMIndO8sluWSFyyXRkOpo0dbC12aZc+KezEAnt8l7Y/RpsUIlvcf3SYlnVxsGxn3IkyZJXfutYNcONIP/Zuqhl1LDYR9UE94SB2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=v05K2LjN; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d93edfa76dso11829035ad.1
        for <linux-rdma@vger.kernel.org>; Wed, 07 Feb 2024 19:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1707361628; x=1707966428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=egs7rCfpH1ftbki48KCuJAklsR0MNJ7M7ZSfGS5ub5U=;
        b=v05K2LjNf419fOZY8Hlm9F1vAYGv552eZ8LjB3QAZwNxzCWxAiapna16aDvXUurOCH
         9kZIIT3tOXmE5xVMG0c6jYnbwX2GPV4aJzHqdTex24L0BPRZAAnXQXx0FhiB5Xq0yLqy
         nc9I3mCCyUqty+rNfFQ6Z0TxbWmNHMBUXBQNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707361628; x=1707966428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=egs7rCfpH1ftbki48KCuJAklsR0MNJ7M7ZSfGS5ub5U=;
        b=nzetrRJFy7bqzvbZoZ9CxEkADe+cHPogqj65w1m0EPS6pA2wMKsfvz733vYbSJQmBc
         4W+PVaM/FjLohkkbXh7hjQ7HMIhXI7qkECUzVk8Lc9MTsUtg5tGF/lreKVk0ivMQkFfq
         rBzpa2oTAQSpPjDb/a3J0xEtZWFem4hJCgwoXvLN8KSAgCEf2AY3qE6u52w2LuCQycnA
         /sKeQoxKM7mzOLkiXg+dmtwI0fXIVbMpyoX00nLSGtO2qgsnKhX7YFzONUIEs4260tHQ
         OXG4zZis7/MbKpy8QZp54vC4EbwZVYuUtZTIbgHxgEAvvJnlnJxCkUkiR18WbaYQpkS7
         m1Mg==
X-Gm-Message-State: AOJu0Yz0RDZsNpkhxYP5UDbZUmaVTuM2WqWTs7D0QG3v3gndelO/iZF7
	JswHioiasoTwnHFLG/WypqUBd/QHr7k4lgqDwEj+fk5ICqT0AxsQlqgGhlYsisg=
X-Google-Smtp-Source: AGHT+IFeQByc3Ud6HAkpe54Ssf4Ks5auR0GRuMFO0189+CN7FpKYZqgiGhkuedzUoLJa+6jvKIo9Gw==
X-Received: by 2002:a17:902:6b44:b0:1d9:bc11:66e with SMTP id g4-20020a1709026b4400b001d9bc11066emr6196112plt.37.1707361628549;
        Wed, 07 Feb 2024 19:07:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWLLVbDAWkfFtyhSVVzh+qvy66GqylkUIRMroRtqJlDWxFeOc32pUB9RrPlUQyPQHQRsIEh7PCjqZYG9FT/j36boFo3nuhugbBy5NNz579ZY6vYDjR8jpJXPRxdTPZ3D+az1RklSBm1Y09QIYvUO/VyKE7LJTRMyRnHzjVW2PTdSsSSztuyIbCEf+5LlBC1NwF7ivTlCmtXDKFgwQraNBX96xDu3UOmSjROOfGxWCEYNoPzo11QOfbOdGgPDBchllmsEGaiTsKw3VOaBZej2Y7/b377piUFa8OF28Qto619MBsAVagNNwpbNMFE28Tj9u6bGGYxi81MfDA4uwItTZBdly95ViAD6ziwyRr1z6fZCj/iNhOmioMGkOa1eACs86sG9wWx0Blp9f/KYMdU24cinrZmGyLEBAcdkMS1/uvJHKjDO6bT
Received: from localhost.localdomain ([2620:11a:c018:0:ea8:be91:8d1:f59b])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902c9c500b001d8b8bf8e44sm2235232pld.92.2024.02.07.19.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 19:07:08 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: tariqt@nvidia.com,
	rrameshbabu@nvidia.com,
	Joe Damato <jdamato@fastly.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Gal Pressman <gal@nvidia.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX5 core VPI driver)
Subject: [PATCH net-next v3] net/mlx5e: link NAPI instances to queues and IRQs
Date: Thu,  8 Feb 2024 03:07:00 +0000
Message-Id: <20240208030702.27296-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make mlx5 compatible with the newly added netlink queue GET APIs.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
v2 -> v3:
  - Fix commit message subject
  - call netif_queue_set_napi in mlx5e_ptp_activate_channel and
    mlx5e_ptp_deactivate_channel to enable/disable NETDEV_QUEUE_TYPE_RX for
    the PTP channel.
  - Modify mlx5e_activate_txqsq and mlx5e_deactivate_txqsq to set
    NETDEV_QUEUE_TYPE_TX which should take care of all TX queues including
    QoS/HTB and PTP.
  - Rearrange mlx5e_activate_channel and mlx5e_deactivate_channel for
    better ordering when setting and unsetting NETDEV_QUEUE_TYPE_RX NAPI
    structs

v1 -> v2:
  - Move netlink NULL code to mlx5e_deactivate_channel
  - Move netif_napi_set_irq to mlx5e_open_channel and avoid storing the
    irq, after netif_napi_add which itself sets the IRQ to -1

 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c  | 3 +++
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
index 078f56a3cbb2..fbbc287d924d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
@@ -927,6 +927,8 @@ void mlx5e_ptp_activate_channel(struct mlx5e_ptp *c)
 	int tc;
 
 	napi_enable(&c->napi);
+	netif_queue_set_napi(c->netdev, c->rq.ix, NETDEV_QUEUE_TYPE_RX,
+			     &c->napi);
 
 	if (test_bit(MLX5E_PTP_STATE_TX, c->state)) {
 		for (tc = 0; tc < c->num_tc; tc++)
@@ -951,6 +953,7 @@ void mlx5e_ptp_deactivate_channel(struct mlx5e_ptp *c)
 			mlx5e_deactivate_txqsq(&c->ptpsq[tc].txqsq);
 	}
 
+	netif_queue_set_napi(c->netdev, c->rq.ix, NETDEV_QUEUE_TYPE_RX, NULL);
 	napi_disable(&c->napi);
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index c8e8f512803e..2f1792854dd5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -1806,6 +1806,7 @@ void mlx5e_activate_txqsq(struct mlx5e_txqsq *sq)
 	set_bit(MLX5E_SQ_STATE_ENABLED, &sq->state);
 	netdev_tx_reset_queue(sq->txq);
 	netif_tx_start_queue(sq->txq);
+	netif_queue_set_napi(sq->channel->netdev, sq->txq_ix, NETDEV_QUEUE_TYPE_TX, &sq->channel->napi);
 }
 
 void mlx5e_tx_disable_queue(struct netdev_queue *txq)
@@ -1819,6 +1820,7 @@ void mlx5e_deactivate_txqsq(struct mlx5e_txqsq *sq)
 {
 	struct mlx5_wq_cyc *wq = &sq->wq;
 
+	netif_queue_set_napi(sq->channel->netdev, sq->txq_ix, NETDEV_QUEUE_TYPE_TX, NULL);
 	clear_bit(MLX5E_SQ_STATE_ENABLED, &sq->state);
 	synchronize_net(); /* Sync with NAPI to prevent netif_tx_wake_queue. */
 
@@ -2560,6 +2562,7 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
 	c->lag_port = mlx5e_enumerate_lag_port(priv->mdev, ix);
 
 	netif_napi_add(netdev, &c->napi, mlx5e_napi_poll);
+	netif_napi_set_irq(&c->napi, irq);
 
 	err = mlx5e_open_queues(c, params, cparam);
 	if (unlikely(err))
@@ -2602,12 +2605,16 @@ static void mlx5e_activate_channel(struct mlx5e_channel *c)
 		mlx5e_activate_xsk(c);
 	else
 		mlx5e_activate_rq(&c->rq);
+
+	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_RX, &c->napi);
 }
 
 static void mlx5e_deactivate_channel(struct mlx5e_channel *c)
 {
 	int tc;
 
+	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_RX, NULL);
+
 	if (test_bit(MLX5E_CHANNEL_STATE_XSK, c->state))
 		mlx5e_deactivate_xsk(c);
 	else
-- 
2.25.1


