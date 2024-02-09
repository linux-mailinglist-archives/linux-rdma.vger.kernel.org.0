Return-Path: <linux-rdma+bounces-993-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CE684FD7E
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Feb 2024 21:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A69AD2820CF
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Feb 2024 20:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8617126F3F;
	Fri,  9 Feb 2024 20:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="k/nFKFRo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109F786AC1
	for <linux-rdma@vger.kernel.org>; Fri,  9 Feb 2024 20:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707510200; cv=none; b=IFhdxVjlzySO4fKiPfEzEedoTVbwQtYFQE3LRQ2J1CJs7dxUlsJul8CCXW+Tr6yAuNQsV5hP4RLLZVVAnRebQQ7u3/C0sqoNcBeezFuzGIhlkQ94Qa4R4EMTw1ao+/O+w49zkFbZTogNd/rIEUA7XRj0Q6lHdmyyj5wcwFaEJ3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707510200; c=relaxed/simple;
	bh=Qa7WBTIDQpNbeS/hiyhWQzSVHICDNi2Lqssf/YFEgRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZxDPa3yqs32ZsmBX5+0JYKYjC8GkGpTsGTJNvMO9Y3iLSf+GaOp7q9lZ5wo6csgssHY5zcMBusUoK8h87tINi/LnE+5SE2ClKofAKak1b0uhw/x1RHUZnxHWpG9FdV95GtZTHVOjuWR8I84CVdUYGnRca60mnDpSsyZHg1jUFPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=k/nFKFRo; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-59a31c14100so561485eaf.0
        for <linux-rdma@vger.kernel.org>; Fri, 09 Feb 2024 12:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1707510198; x=1708114998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rDZ3Jmq4/nSFOD85T2yiUnizUyC/JrtpL4z0B/Jmq+Q=;
        b=k/nFKFRoIeO5UyIXezOjU30+kbylY8X0rdH7lU4D4U22GLlP9xx/qMLNRMw9s1q/FM
         Y++AG17tiVa3nnrR2QkltW4NqiQThgQstzq7+7bDLlDz3+9Om3ShVOlg0nC1QZVZrmnj
         eMnmfmlf3uypwlMNZr0CbUzRHtjH1HSkfX4Qs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707510198; x=1708114998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rDZ3Jmq4/nSFOD85T2yiUnizUyC/JrtpL4z0B/Jmq+Q=;
        b=Fgkz8xi6EyIBQPfydPz2D1IJ8EfmVsHtXtCjZpkpgvzQ9hLeR1yVYh9iGi/hJY68pP
         1+IhFHJKwNyuXN2rVRhaVQi6QIyXZJsCuugj2RYXxQ7U56/VW8778nKPWBzAk7Vj8fIX
         cOHeqo4f1nmuHVP1kMRbQvUzRjbphJL3XPdzbsqnGIdKLOG6NFSRro3XJh3taLmxU0er
         Bz5oU9R/YTKRQmoB+Fz5x5K3Snv5KkZOndkyI8svzyPQIS6QfvXN4w3stRUROgKq4Aed
         tKHHalABh/7jg3ghg9ab8nk9F8JD9BzjSN07hu+3Xh+33wmUE6IYqq2KH0bui5qt9hzr
         fS5g==
X-Forwarded-Encrypted: i=1; AJvYcCXLn8KwjrixLqZo07KvpBHWyIeKgH3dhPmk6YknR2Q1nuE4u88ynRmueOABlIqx3U96eJmW7dr3mNUlwOG6hkH+uA7UBJuIKym3+w==
X-Gm-Message-State: AOJu0YxYbVZiNhtnJnc2GO87Ip0+KSX6UN36xKcRkycWJPTTTP9ysBE6
	2zCZ3DRwYXalz5yuAnP8R/fQq0Rph1YDrPuH8g0VhKz6avmg/wvwcQPix2l2y/U=
X-Google-Smtp-Source: AGHT+IG/BuQR5ro/SbMkt/wRVmSLRrb8pcixKb+A/Usu4R6NRLr71H1G3HJsj0W0HfRlB7IyDnKkBA==
X-Received: by 2002:a05:6358:1212:b0:178:8ec9:a2f with SMTP id h18-20020a056358121200b001788ec90a2fmr602645rwi.5.1707510198038;
        Fri, 09 Feb 2024 12:23:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV9gYyDVJ/FTepbkZQWu3Aexv8qHVS0hrlr6yspf74pQaoAyp4jb/aaAEShwx8G0I0JF64bQF9DRoyw+vjK2VOuOd/N+ZjwRQnKTZ/0/RENVtV5Q9qXujjeJo+UJWx3Ku7z+XPP57RCd2F/wJDbaOZmySQTKUyv62JIUVVoj+Xo1xyLufeMnuDWwPxHpTkgJHDd8CTYykBE/gZ0LTgqmJ+kY1/t2ATggIS/IE9CnVm7C8wNXntCa6X94WvNdAakwC0eU8cZncggC3/Xqzdcso5l40SRE9WGdecCHd/8S+jbsfyfkokOvelVGw8otO96Ktlui4zilWlJjvOSNbGLTsrCQnY+nw+Mlh+jj8e95ovv6zuenZ7CrKyJjq5j8zy/4CCbU370DH0/vTnAWfqFZX7d2bwg9uulY0r3efo7usGizAXonVLf
Received: from localhost.localdomain ([2620:11a:c018:0:ea8:be91:8d1:f59b])
        by smtp.gmail.com with ESMTPSA id e25-20020a62aa19000000b006ddc71607a7sm933742pff.191.2024.02.09.12.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 12:23:17 -0800 (PST)
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
Subject: [PATCH net-next v4] net/mlx5e: link NAPI instances to queues and IRQs
Date: Fri,  9 Feb 2024 20:23:08 +0000
Message-Id: <20240209202312.30181-1-jdamato@fastly.com>
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
v3 -> v4:
  - Use sq->netdev and sq->cq.napi to get the netdev and NAPI structures in
    mlx5e_activate_txqsq and mlx5e_deactivate_txqsq as requested by Tariq
    Toukan [1]
  - Only set or unset NETDEV_QUEUE_TYPE_RX when the MLX5E_PTP_STATE_RX bit
    is on in mlx5e_ptp_activate_channel and mlx5e_ptp_deactivate_channel as
    requested by Rahul Rameshbabu [2]

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

[1]: https://lore.kernel.org/all/8c083e6d-5fcd-4557-88dd-0f95acdbc747@gmail.com/
[2]: https://lore.kernel.org/all/871q9mz1a0.fsf@nvidia.com/

 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c  | 5 ++++-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 7 +++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
index 078f56a3cbb2..fd4ef6431142 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
@@ -935,6 +935,7 @@ void mlx5e_ptp_activate_channel(struct mlx5e_ptp *c)
 	if (test_bit(MLX5E_PTP_STATE_RX, c->state)) {
 		mlx5e_ptp_rx_set_fs(c->priv);
 		mlx5e_activate_rq(&c->rq);
+		netif_queue_set_napi(c->netdev, c->rq.ix, NETDEV_QUEUE_TYPE_RX, &c->napi);
 	}
 	mlx5e_trigger_napi_sched(&c->napi);
 }
@@ -943,8 +944,10 @@ void mlx5e_ptp_deactivate_channel(struct mlx5e_ptp *c)
 {
 	int tc;
 
-	if (test_bit(MLX5E_PTP_STATE_RX, c->state))
+	if (test_bit(MLX5E_PTP_STATE_RX, c->state)) {
+		netif_queue_set_napi(c->netdev, c->rq.ix, NETDEV_QUEUE_TYPE_RX, NULL);
 		mlx5e_deactivate_rq(&c->rq);
+	}
 
 	if (test_bit(MLX5E_PTP_STATE_TX, c->state)) {
 		for (tc = 0; tc < c->num_tc; tc++)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index c8e8f512803e..be809556b2e1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -1806,6 +1806,7 @@ void mlx5e_activate_txqsq(struct mlx5e_txqsq *sq)
 	set_bit(MLX5E_SQ_STATE_ENABLED, &sq->state);
 	netdev_tx_reset_queue(sq->txq);
 	netif_tx_start_queue(sq->txq);
+	netif_queue_set_napi(sq->netdev, sq->txq_ix, NETDEV_QUEUE_TYPE_TX, sq->cq.napi);
 }
 
 void mlx5e_tx_disable_queue(struct netdev_queue *txq)
@@ -1819,6 +1820,7 @@ void mlx5e_deactivate_txqsq(struct mlx5e_txqsq *sq)
 {
 	struct mlx5_wq_cyc *wq = &sq->wq;
 
+	netif_queue_set_napi(sq->netdev, sq->txq_ix, NETDEV_QUEUE_TYPE_TX, NULL);
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


