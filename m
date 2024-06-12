Return-Path: <linux-rdma+bounces-3086-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F70905C8B
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2024 22:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86ACF285717
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2024 20:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC2885654;
	Wed, 12 Jun 2024 20:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="UsfHvtpL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984F184DF3
	for <linux-rdma@vger.kernel.org>; Wed, 12 Jun 2024 20:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718222975; cv=none; b=ea2cMVcx/q0bY7DTTb8deTmkc0Bzbye9virc6KdX7OPolV8WWnS4GQlLgfYkuVfw3YlR1nrozRUK6YarVWpQFSqoGq6360jM3gyX2x5vjX1YizC4Ta12Fcz7uKX1raT/+TAghxm1ucqEYRJPYj0BPqTTEAM41N/y5avOl6FG7Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718222975; c=relaxed/simple;
	bh=jF2I4eWVfCTC/mgwsHEU1ahkjsFYbbCMnQ/zLeO8He4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=owXbE0x1T8S3FS93vB7nuARlTU3lmSyEARsUEZ+DJJup/vbNKM+wSdNV2I4BYXhFSB7odSQgWemqwfeLNQQYuqjSZAPh1crJIoZNbdeSyp209tCNiyJ+nLArOU6YtIv1r3DJ/uF38aJ0Vdu/mBJpQuCIjC4WRQnZb7n3Ee+9qXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=UsfHvtpL; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f480624d0dso2754435ad.1
        for <linux-rdma@vger.kernel.org>; Wed, 12 Jun 2024 13:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1718222973; x=1718827773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0s8R7PiKG7ygOhXdI8mYQIM9Nw0ZpcuydO4wtHx1EMs=;
        b=UsfHvtpLFxcnz6Eg7k9HqLBR2W9wJddrq0qRVGl+/pFoD4gFyeL16BorqUOgk+advY
         o4MKvWS9tnNwds5F4CoWROlvBGysb79w2F709ZszgFh01jH8kpHH+aR/cuN95Cb5IgPz
         kF3z36z8NkiA115cExOQFBWxqge6nbaiwQK6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718222973; x=1718827773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0s8R7PiKG7ygOhXdI8mYQIM9Nw0ZpcuydO4wtHx1EMs=;
        b=n6L0S9wPNJ1Whh9Qw1pRcESZofxvHk8kVzhwtnCHFo0R4Kd99iRaIW9boChufZFXto
         8loeR4YHSE6yxJzFwxyIE1p13pdn1dNe9Chz4LE7Z+U28sOTSTMSoEdRS/VO0o+LSu9K
         GsXdJOLS4QGbLNWFKubYTemkHZMSiWLvnZKkGhMOewsH7/csWr/rGrCh2BdQfWcManBH
         ucGmgLMaytXVh7kSKNodizxS0Lhs8G1sKG5ySdctNKVQgp9186VHapDQZsiiU/yB4nQ2
         Gn3gvfPLDcpchWscleaDe999P9B6V2kGYR5QD0ufP4m5qTg3BGQLIa8B+WtecXeuv2yx
         D5cQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8TMbPQWTrmHclIzgOYdbv6C9529PNrBCXYWFpiIDc9d93fnHbNyBzl/9tHtgxEz7q/ARYsJ8LArK5BkUS86Ej4lEp68mo4uE3cg==
X-Gm-Message-State: AOJu0YwW+gc5geJqluGz+TnenWwY3Ja2v/yR6pml5W3Onh+0x8DtiToH
	77kgd83TMAmjgHM6Vemg6nZab3EYf9RVuZAaBhXYiyqJTehEunXAANCFh6Tl7Dc=
X-Google-Smtp-Source: AGHT+IHNCHnF1MmZHVxSU7HnVfRcpDsxPSWFUTjrM9Uz154aliKZf70E5jtEhSMhN5KO+k991iL49g==
X-Received: by 2002:a17:903:1c9:b0:1f7:123e:2c6f with SMTP id d9443c01a7336-1f83b6788eemr35571165ad.37.1718222972808;
        Wed, 12 Jun 2024 13:09:32 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6ee3d5a17sm91506805ad.146.2024.06.12.13.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 13:09:32 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: nalramli@fastly.com,
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
Subject: [net-next v5 2/2] net/mlx5e: Add per queue netdev-genl stats
Date: Wed, 12 Jun 2024 20:08:57 +0000
Message-Id: <20240612200900.246492-3-jdamato@fastly.com>
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

The tools/testing/selftests/drivers/net/stats.py brings the device up,
so to test with the device down, I did the following:

$ ip link show eth4
7: eth4: <BROADCAST,MULTICAST> mtu 9000 qdisc mq state DOWN [..snip..]
  [..snip..]

$ cat /proc/net/dev | grep eth4
eth4: 235710489  434811 [..snip rx..] 2878744 21227  [..snip tx..]

$ ./cli.py --spec ../../../Documentation/netlink/specs/netdev.yaml \
           --dump qstats-get --json '{"ifindex": 7}'
[{'ifindex': 7,
  'rx-alloc-fail': 0,
  'rx-bytes': 235710489,
  'rx-packets': 434811,
  'tx-bytes': 2878744,
  'tx-packets': 21227}]

Compare the values in /proc/net/dev match the output of cli for the same
device, even while the device is down.

Note that while the device is down, per queue stats output nothing
(because the device is down there are no queues):

$ ./cli.py --spec ../../../Documentation/netlink/specs/netdev.yaml \
           --dump qstats-get --json '{"scope": "queue", "ifindex": 7}'
[]

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 132 ++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index c548e2fdc58f..d3f38b4b18eb 100644
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
@@ -5299,6 +5300,136 @@ static bool mlx5e_tunnel_any_tx_proto_supported(struct mlx5_core_dev *mdev)
 	return (mlx5_vxlan_allowed(mdev->vxlan) || mlx5_geneve_tx_allowed(mdev));
 }
 
+static void mlx5e_get_queue_stats_rx(struct net_device *dev, int i,
+				     struct netdev_queue_stats_rx *stats)
+{
+	struct mlx5e_priv *priv = netdev_priv(dev);
+	struct mlx5e_channel_stats *channel_stats;
+	struct mlx5e_rq_stats *xskrq_stats;
+	struct mlx5e_rq_stats *rq_stats;
+
+	ASSERT_RTNL();
+	if (mlx5e_is_uplink_rep(priv))
+		return;
+
+	channel_stats = priv->channel_stats[i];
+	xskrq_stats = &channel_stats->xskrq;
+	rq_stats = &channel_stats->rq;
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
+	struct mlx5e_sq_stats *sq_stats;
+
+	ASSERT_RTNL();
+	/* no special case needed for ptp htb etc since txq2sq_stats is kept up
+	 * to date for active sq_stats, otherwise get_base_stats takes care of
+	 * inactive sqs.
+	 */
+	sq_stats = priv->txq2sq_stats[i];
+	stats->packets = sq_stats->packets;
+	stats->bytes = sq_stats->bytes;
+}
+
+static void mlx5e_get_base_stats(struct net_device *dev,
+				 struct netdev_queue_stats_rx *rx,
+				 struct netdev_queue_stats_tx *tx)
+{
+	struct mlx5e_priv *priv = netdev_priv(dev);
+	struct mlx5e_ptp *ptp_channel;
+	int i, tc;
+
+	ASSERT_RTNL();
+	if (!mlx5e_is_uplink_rep(priv)) {
+		rx->packets = 0;
+		rx->bytes = 0;
+		rx->alloc_fail = 0;
+
+		for (i = priv->channels.params.num_channels; i < priv->stats_nch; i++) {
+			struct netdev_queue_stats_rx rx_i = {0};
+
+			mlx5e_get_queue_stats_rx(dev, i, &rx_i);
+
+			rx->packets += rx_i.packets;
+			rx->bytes += rx_i.bytes;
+			rx->alloc_fail += rx_i.alloc_fail;
+		}
+
+		/* always report PTP RX stats from base as there is no
+		 * corresponding channel to report them under in
+		 * mlx5e_get_queue_stats_rx.
+		 */
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
+	for (i = 0; i < priv->stats_nch; i++) {
+		struct mlx5e_channel_stats *channel_stats = priv->channel_stats[i];
+
+		/* handle two cases:
+		 *
+		 *  1. channels which are active. In this case,
+		 *     report only deactivated TCs on these channels.
+		 *
+		 *  2. channels which were deactivated
+		 *     (i > priv->channels.params.num_channels)
+		 *     must have all of their TCs [0 .. priv->max_opened_tc)
+		 *     examined because deactivated channels will not be in the
+		 *     range of [0..real_num_tx_queues) and will not have their
+		 *     stats reported by mlx5e_get_queue_stats_tx.
+		 */
+		if (i < priv->channels.params.num_channels)
+			tc = mlx5e_get_dcb_num_tc(&priv->channels.params);
+		else
+			tc = 0;
+
+		for (; tc < priv->max_opened_tc; tc++) {
+			struct mlx5e_sq_stats *sq_stats = &channel_stats->sq[tc];
+
+			tx->packets += sq_stats->packets;
+			tx->bytes += sq_stats->bytes;
+		}
+	}
+
+	/* if PTP TX was opened at some point and has since either:
+	 *    -  been shutdown and set to NULL, or
+	 *    -  simply disabled (bit unset)
+	 *
+	 * report stats directly from the ptp_stats structures as these queues
+	 * are now unavailable and there is no txq index to retrieve these
+	 * stats via calls to mlx5e_get_queue_stats_tx.
+	 */
+	ptp_channel = priv->channels.ptp;
+	if (priv->tx_ptp_opened && (!ptp_channel || !test_bit(MLX5E_PTP_STATE_TX, ptp_channel->state))) {
+		for (tc = 0; tc < priv->max_opened_tc; tc++) {
+			struct mlx5e_sq_stats *sq_stats = &priv->ptp_stats.sq[tc];
+
+			tx->packets += sq_stats->packets;
+			tx->bytes   += sq_stats->bytes;
+		}
+	}
+}
+
+static const struct netdev_stat_ops mlx5e_stat_ops = {
+	.get_queue_stats_rx  = mlx5e_get_queue_stats_rx,
+	.get_queue_stats_tx  = mlx5e_get_queue_stats_tx,
+	.get_base_stats      = mlx5e_get_base_stats,
+};
+
 static void mlx5e_build_nic_netdev(struct net_device *netdev)
 {
 	struct mlx5e_priv *priv = netdev_priv(netdev);
@@ -5316,6 +5447,7 @@ static void mlx5e_build_nic_netdev(struct net_device *netdev)
 
 	netdev->watchdog_timeo    = 15 * HZ;
 
+	netdev->stat_ops	  = &mlx5e_stat_ops;
 	netdev->ethtool_ops	  = &mlx5e_ethtool_ops;
 
 	netdev->vlan_features    |= NETIF_F_SG;
-- 
2.25.1


