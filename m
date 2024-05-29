Return-Path: <linux-rdma+bounces-2648-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 834878D2B61
	for <lists+linux-rdma@lfdr.de>; Wed, 29 May 2024 05:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3141C289EAD
	for <lists+linux-rdma@lfdr.de>; Wed, 29 May 2024 03:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E3615B15C;
	Wed, 29 May 2024 03:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="jQWVaHQq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44E215B150
	for <linux-rdma@vger.kernel.org>; Wed, 29 May 2024 03:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716952852; cv=none; b=fN847pB7Y8+WB/16AiKsSTpEZwNgyZz8Z70SbIM8PAdeXTIo3SZyWSYftB5I2bH4JOFp8pQLLuGy6zYoIYictXWrKc+xfDtAR6O/zWdTGuOUbrB6gzl6IPig4ikZdO+372IX6MtVg/lX77/vwAgKWQ/p0UIF5r/j9Y703wCMC40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716952852; c=relaxed/simple;
	bh=ngrgWoSn3dkOnzAYRsmf183bsxtu9OpYrpfalp4oSyM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SB1NLqvD0oM2vw2P/keRT5a7EoyxPYRwaH07J6IYBy+rOwk+2XzyY74Sz4Gmuk3Hbu8KXDGT2zPtIGXtrnn5I/wFITD2Irjr0SzRAJZV96p/M0ew0bS36teN0BBeAvfm46RttW49RlzRCvUkqJoHiZ2DcgPrBI/ZuHkSqdlrAok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=jQWVaHQq; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3cabac56b38so794460b6e.3
        for <linux-rdma@vger.kernel.org>; Tue, 28 May 2024 20:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1716952850; x=1717557650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0LUNrAmj3v5i6Z8gYuVk/e8D51N4ShDxOcIG47i78U=;
        b=jQWVaHQqLdGjoo50QZA81JQ8bG0AF3OxBR8OmY4JnLZiWRELbhNRwILISsUIV/T+/C
         E/n7DZ/+1EJSGpCZVLvzXm7JLWjdHNwOperqlNyMdOuTvbguvbMRi+PZzRhN8tHBVIoC
         ycpScZk2O5JRdzpwqmMq91KTTwYcHRH6AT+PI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716952850; x=1717557650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J0LUNrAmj3v5i6Z8gYuVk/e8D51N4ShDxOcIG47i78U=;
        b=h9eKIpQWJeG3PEtxQAkW4ANFWaOX3VhaNUH9JwKuy5cj+Rzet/tWXGE3E1Ujx3m5ep
         75DPS19pw2H5wLIVURvSRIXEi95LK0rIxNOS2cYdaUwdWCgmBLB7PbF8a1PevFLPGCX4
         /N2F1hpZCIKWOs3T9WiWIakOPwiMApAPDsog/SMXkf4ZBkI/xb3SyeLx3mmosu1fxLrQ
         9BfBlBlZkNfjmcaW9JZlDPXhx2MGH+kH1OI2cPM0PSJPBwBwFaoCv5GjVPXatBTrof4G
         2sJyxmU4XXjx4L/migspL3kEh4a4LMT3OS65ASNlsReeeiVUJbcm8xwJWdw9+OiLS2lU
         N3Rw==
X-Forwarded-Encrypted: i=1; AJvYcCUUhEOLz7yVEPtXLEazNtnD2ei9T/Ih4TVpGHFIfvftEskfgFmkggKYsPCl94VVDrv+30RTH7kIS5fBU8oGIZRx0umAYwpbjUUN1w==
X-Gm-Message-State: AOJu0Yx+27Wyf6St39H3iQlgTSO+wd2r+JAxX0eBpiom7a7AbzdzCGOv
	38BcaE1GoEM0aw4BJIGUM0eOpoAcJaE9T+p+CaP8522k/PuXB740INJ+QtymGhbzbR28GTvql8n
	x
X-Google-Smtp-Source: AGHT+IF75C9u7f1pbiCwVZLhWlBLJ3alIuJgKnuDVZBCwa68S0caQmXZ+PKHwtGllBRjmWhuiFSbRg==
X-Received: by 2002:a05:6808:205:b0:3c8:6543:584b with SMTP id 5614622812f47-3d1a7d27b10mr15151160b6e.54.1716952849895;
        Tue, 28 May 2024 20:20:49 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fbd3ea03sm7156766b3a.39.2024.05.28.20.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 20:20:49 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
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
Subject: [RFC net-next v3 2/2] net/mlx5e: Add per queue netdev-genl stats
Date: Wed, 29 May 2024 03:16:27 +0000
Message-Id: <20240529031628.324117-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240529031628.324117-1-jdamato@fastly.com>
References: <20240529031628.324117-1-jdamato@fastly.com>
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
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 132 ++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index ce15805ad55a..515c16a88a6c 100644
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
@@ -5293,6 +5294,136 @@ static bool mlx5e_tunnel_any_tx_proto_supported(struct mlx5_core_dev *mdev)
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
+	struct mlx5e_channel_stats *channel_stats;
+	struct mlx5e_sq_stats *sq_stats;
+	int ch_ix, tc_ix;
+
+	mutex_lock(&priv->state_lock);
+	txq_ix_to_chtc_ix(&priv->channels.params, i, &ch_ix, &tc_ix);
+	mutex_unlock(&priv->state_lock);
+
+	channel_stats = priv->channel_stats[ch_ix];
+	sq_stats = &channel_stats->sq[tc_ix];
+
+	stats->packets = sq_stats->packets;
+	stats->bytes = sq_stats->bytes;
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
+		mutex_lock(&priv->state_lock);
+		if (priv->channels.num == 0)
+			i = 0;
+		else
+			i = priv->channels.params.num_channels;
+		mutex_unlock(&priv->state_lock);
+
+		for (; i < priv->stats_nch; i++) {
+			struct netdev_queue_stats_rx rx_i = {0};
+
+			mlx5e_get_queue_stats_rx(dev, i, &rx_i);
+
+			rx->packets += rx_i.packets;
+			rx->bytes += rx_i.bytes;
+			rx->alloc_fail += rx_i.alloc_fail;
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
+	mutex_lock(&priv->state_lock);
+	for (i = 0; i < priv->stats_nch; i++) {
+		struct mlx5e_channel_stats *channel_stats = priv->channel_stats[i];
+
+		/* while iterating through all channels [0, stats_nch], there
+		 * are two cases to handle:
+		 *
+		 *  1. the channel is available, so sum only the unavailable TCs
+		 *     [mlx5e_get_dcb_num_tc, max_opened_tc).
+		 *
+		 *  2. the channel is unavailable, so sum all TCs [0, max_opened_tc).
+		 */
+		if (i < priv->channels.params.num_channels) {
+			j = mlx5e_get_dcb_num_tc(&priv->channels.params);
+		} else {
+			j = 0;
+		}
+
+		for (; j < priv->max_opened_tc; j++) {
+			struct mlx5e_sq_stats *sq_stats = &channel_stats->sq[j];
+
+			tx->packets += sq_stats->packets;
+			tx->bytes += sq_stats->bytes;
+		}
+	}
+	mutex_unlock(&priv->state_lock);
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
@@ -5310,6 +5441,7 @@ static void mlx5e_build_nic_netdev(struct net_device *netdev)
 
 	netdev->watchdog_timeo    = 15 * HZ;
 
+	netdev->stat_ops          = &mlx5e_stat_ops;
 	netdev->ethtool_ops	  = &mlx5e_ethtool_ops;
 
 	netdev->vlan_features    |= NETIF_F_SG;
-- 
2.25.1


