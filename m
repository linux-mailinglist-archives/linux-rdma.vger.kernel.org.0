Return-Path: <linux-rdma+bounces-2390-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E872A8C1D62
	for <lists+linux-rdma@lfdr.de>; Fri, 10 May 2024 06:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21B3C1C21E6C
	for <lists+linux-rdma@lfdr.de>; Fri, 10 May 2024 04:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3485014A4F3;
	Fri, 10 May 2024 04:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="QSJmbA8I"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AA4149DEE
	for <linux-rdma@vger.kernel.org>; Fri, 10 May 2024 04:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715314632; cv=none; b=gbiRZcWLpx+BB6EFT+WYngp3vhNcgOnIAmrd9f+hNQSe5HdPPmL+IkEfrkRHDu6Be2rFiDwRGoLvAzv0lMDlqlVYux5BRkY58sNKNRsO8OVFRdJvckPBSgkbIak2G9EHMXG4GhSBG2dMLHDZvb9oaazCRvBW/BFFZeMIlKdaio4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715314632; c=relaxed/simple;
	bh=sItGtJBIJNMhfVpHFpYOWuJhXQi9rByjma23Wzavzq8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=isnDlBD1rIJBH3jr0cVpMGbYi0iv0WnurPQ5y+32W2nmTQst0b8cZzzFLKvxO1OGElekpJyuVm6+i8L/0VYrdh8EUYwzT57drcsHNfQ/9NVEQKcEJNKVgsHFj5scRF65Y7mC6b48Zm31pWDPKlGX1clmLU3ZDB+zTtUR5yEfVmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=QSJmbA8I; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1edfc57ac0cso12904115ad.3
        for <linux-rdma@vger.kernel.org>; Thu, 09 May 2024 21:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1715314630; x=1715919430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TpQN7GJz3KBsvp4IKZd1UGER/INOZY+tW+x17mpIBcY=;
        b=QSJmbA8Ij+tRqdxgxjSuRwqYQMX1aYjnHI/wdXAKrvkLOqM330uhClskWh62PLOME/
         Mxfjjay4M2F96LAVmviS/pybSCsXaY/rcID6oiLt1hMRJaMiruOI5pr8sxq5rTCm2Sal
         Q1qIkKCjAf4MQBhC6uwADOOsAO9k5wmKJx7Yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715314630; x=1715919430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TpQN7GJz3KBsvp4IKZd1UGER/INOZY+tW+x17mpIBcY=;
        b=eX0aIopQMg0h5qXylEBU6rrNV4aUJY85NMJmFZmujfCkQGRHZqHE6KnL65kMzJqfD8
         4xAKHjqtnH20FCdwxd/LQmS4bwCYyV9CcFFW4A342vQH9/zSKYqxVmGiBTodtffpe1v7
         y+lFyS2/fQNgOShfL/j4JXVXAdOI8Mq7aS7lx3SySCi3fDIQ+9bpFMJlKAoZi7Yjz+97
         YZO+pBZRDQR4/BO57o0y833ZKrPs54vsa3O+kduZKb/kavofH0sIUtcnmIIbG0ndF188
         H//L8sEnw089Woqcz5QVoFKyXtFAaQcM42djuRj7tqAZouUexm4d4gjktqCPkdcmyCyT
         aRAA==
X-Forwarded-Encrypted: i=1; AJvYcCUusEG0OT8sPFFR09k8Y4Wv3YYm7L677KwOfFVpaNPB+cG/3s0Q+LCim42lboMb7MB5NUAi3/gSfGuHAaxJxtquCnj8JZMGL4OEtw==
X-Gm-Message-State: AOJu0YxY7BKPpDSiQSki5yaCprWMFiiEJx0wS55MVHv5ffrypSqfnCf2
	2rpg5QgkGemvChWdw2QQiAhW5ksl/HyU9BtgjUSgLp5Bp65y7s5lbhBE6OB7c1Q=
X-Google-Smtp-Source: AGHT+IGKqe1bccc6DLMtv1Yamu/Y/iCmWtqFo06blB8qUSDje65ihSgrtrh6NSrRngdN1FJV3QRz8w==
X-Received: by 2002:a17:903:1cd:b0:1ee:8fb7:dce9 with SMTP id d9443c01a7336-1ef43d18246mr17526025ad.15.1715314629837;
        Thu, 09 May 2024 21:17:09 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bad634asm22617485ad.87.2024.05.09.21.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 21:17:09 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: zyjzyj2000@gmail.com,
	nalramli@fastly.com,
	Joe Damato <jdamato@fastly.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX5 core VPI driver)
Subject: [PATCH net-next v2 1/1] net/mlx5e: Add per queue netdev-genl stats
Date: Fri, 10 May 2024 04:17:04 +0000
Message-Id: <20240510041705.96453-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240510041705.96453-1-jdamato@fastly.com>
References: <20240510041705.96453-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add functions to support the netdev-genl per queue stats API.

./cli.py --spec netlink/specs/netdev.yaml \
--dump qstats-get --json '{"scope": "queue"}'

...snip

 {'ifindex': 7,
  'queue-id': 62,
  'queue-type': 'rx',
  'rx-alloc-fail': 0,
  'rx-bytes': 105965251,
  'rx-packets': 179790},
 {'ifindex': 7,
  'queue-id': 0,
  'queue-type': 'tx',
  'tx-bytes': 9402665,
  'tx-packets': 17551},

...snip

Also tested with the script tools/testing/selftests/drivers/net/stats.py
in several scenarios to ensure stats tallying was correct:

- on boot (default queue counts)
- adjusting queue count up or down (ethtool -L eth0 combined ...)
- adding mqprio TCs

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 144 ++++++++++++++++++
 1 file changed, 144 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index ffe8919494d5..4a675d8b31b5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -39,6 +39,7 @@
 #include <linux/debugfs.h>
 #include <linux/if_bridge.h>
 #include <linux/filter.h>
+#include <net/netdev_queues.h>
 #include <net/page_pool/types.h>
 #include <net/pkt_sched.h>
 #include <net/xdp_sock_drv.h>
@@ -5282,6 +5283,148 @@ static bool mlx5e_tunnel_any_tx_proto_supported(struct mlx5_core_dev *mdev)
 	return (mlx5_vxlan_allowed(mdev->vxlan) || mlx5_geneve_tx_allowed(mdev));
 }
 
+static void mlx5e_get_queue_stats_rx(struct net_device *dev, int i,
+				     struct netdev_queue_stats_rx *stats)
+{
+	struct mlx5e_priv *priv = netdev_priv(dev);
+
+	if (mlx5e_is_uplink_rep(priv))
+		return;
+
+	struct mlx5e_channel_stats *channel_stats = priv->channel_stats[i];
+	struct mlx5e_rq_stats *xskrq_stats = &channel_stats->xskrq;
+	struct mlx5e_rq_stats *rq_stats = &channel_stats->rq;
+
+	stats->packets = rq_stats->packets + xskrq_stats->packets;
+	stats->bytes = rq_stats->bytes + xskrq_stats->bytes;
+	stats->alloc_fail = rq_stats->buff_alloc_err +
+			    xskrq_stats->buff_alloc_err;
+}
+
+static void mlx5e_get_queue_stats_tx(struct net_device *dev, int i,
+				     struct netdev_queue_stats_tx *stats)
+{
+	struct mlx5e_priv *priv = netdev_priv(dev);
+	struct net_device *netdev = priv->netdev;
+	struct mlx5e_txqsq *sq;
+	int j;
+
+	if (mlx5e_is_uplink_rep(priv))
+		return;
+
+	for (j = 0; j < netdev->num_tx_queues; j++) {
+		sq = priv->txq2sq[j];
+		if (sq->ch_ix == i) {
+			stats->packets = sq->stats->packets;
+			stats->bytes = sq->stats->bytes;
+			return;
+		}
+	}
+}
+
+static void mlx5e_get_base_stats(struct net_device *dev,
+				 struct netdev_queue_stats_rx *rx,
+				 struct netdev_queue_stats_tx *tx)
+{
+	struct mlx5e_priv *priv = netdev_priv(dev);
+	int i, j;
+
+	if (!mlx5e_is_uplink_rep(priv)) {
+		rx->packets = 0;
+		rx->bytes = 0;
+		rx->alloc_fail = 0;
+
+		/* compute stats for deactivated RX queues
+		 *
+		 * if priv->channels.num == 0 the device is down, so compute
+		 * stats for every queue.
+		 *
+		 * otherwise, compute only the queues which have been deactivated.
+		 */
+		if (priv->channels.num == 0)
+			i = 0;
+		else
+			i = priv->channels.params.num_channels;
+
+		for (; i < priv->stats_nch; i++) {
+			struct mlx5e_channel_stats *channel_stats = priv->channel_stats[i];
+			struct mlx5e_rq_stats *xskrq_stats = &channel_stats->xskrq;
+			struct mlx5e_rq_stats *rq_stats = &channel_stats->rq;
+
+			rx->packets += rq_stats->packets + xskrq_stats->packets;
+			rx->bytes += rq_stats->bytes + xskrq_stats->bytes;
+			rx->alloc_fail += rq_stats->buff_alloc_err +
+					  xskrq_stats->buff_alloc_err;
+		}
+
+		if (priv->rx_ptp_opened) {
+			struct mlx5e_rq_stats *rq_stats = &priv->ptp_stats.rq;
+
+			rx->packets += rq_stats->packets;
+			rx->bytes += rq_stats->bytes;
+		}
+	}
+
+	tx->packets = 0;
+	tx->bytes = 0;
+
+	/* three TX cases to handle:
+	 *
+	 * case 1: priv->channels.num == 0, get the stats for every TC
+	 *         on every queue.
+	 *
+	 * case 2: priv->channel.num > 0, so get the stats for every TC on
+	 *         every deactivated queue.
+	 *
+	 * case 3: the number of TCs has changed, so get the stats for the
+	 *         inactive TCs on active TX queues (handled in the second loop
+	 *         below).
+	 */
+	if (priv->channels.num == 0)
+		i = 0;
+	else
+		i = priv->channels.params.num_channels;
+
+	for (; i < priv->stats_nch; i++) {
+		struct mlx5e_channel_stats *channel_stats = priv->channel_stats[i];
+
+		for (j = 0; j < priv->max_opened_tc; j++) {
+			struct mlx5e_sq_stats *sq_stats = &channel_stats->sq[j];
+
+			tx->packets += sq_stats->packets;
+			tx->bytes += sq_stats->bytes;
+		}
+	}
+
+	/* Handle case 3 described above. */
+	for (i = 0; i < priv->channels.params.num_channels; i++) {
+		struct mlx5e_channel_stats *channel_stats = priv->channel_stats[i];
+		u8 dcb_num_tc = mlx5e_get_dcb_num_tc(&priv->channels.params);
+
+		for (j = dcb_num_tc; j < priv->max_opened_tc; j++) {
+			struct mlx5e_sq_stats *sq_stats = &channel_stats->sq[j];
+
+			tx->packets += sq_stats->packets;
+			tx->bytes += sq_stats->bytes;
+		}
+	}
+
+	if (priv->tx_ptp_opened) {
+		for (j = 0; j < priv->max_opened_tc; j++) {
+			struct mlx5e_sq_stats *sq_stats = &priv->ptp_stats.sq[j];
+
+			tx->packets    += sq_stats->packets;
+			tx->bytes      += sq_stats->bytes;
+		}
+	}
+}
+
+static const struct netdev_stat_ops mlx5e_stat_ops = {
+	.get_queue_stats_rx     = mlx5e_get_queue_stats_rx,
+	.get_queue_stats_tx     = mlx5e_get_queue_stats_tx,
+	.get_base_stats         = mlx5e_get_base_stats,
+};
+
 static void mlx5e_build_nic_netdev(struct net_device *netdev)
 {
 	struct mlx5e_priv *priv = netdev_priv(netdev);
@@ -5299,6 +5442,7 @@ static void mlx5e_build_nic_netdev(struct net_device *netdev)
 
 	netdev->watchdog_timeo    = 15 * HZ;
 
+	netdev->stat_ops          = &mlx5e_stat_ops;
 	netdev->ethtool_ops	  = &mlx5e_ethtool_ops;
 
 	netdev->vlan_features    |= NETIF_F_SG;
-- 
2.25.1


