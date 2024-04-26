Return-Path: <linux-rdma+bounces-2115-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D64408B3F5D
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Apr 2024 20:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D3E21F24CCD
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Apr 2024 18:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305F712B6C;
	Fri, 26 Apr 2024 18:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="SiRoxZi6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9637146A4
	for <linux-rdma@vger.kernel.org>; Fri, 26 Apr 2024 18:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714156450; cv=none; b=U/kuPMHrKDReZbBWtRju/jsQoO2l95s3/vbYw3mykVLbM2ea6vyp1LbOhou6rGpKPJKaNjKG6+zqMqSZgYGT06wzltPEjsoGT4/JPXPjKRqzKqeoxozLbCRfYcIb1hOQdq3cOUQlSkdVHmIposBb//IyZAyPfDQfB88bL5IRzV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714156450; c=relaxed/simple;
	bh=vHW1DL0lxBdtpusUhIuDr8YiecZhEDqf3QUX1YWqzBU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BB+qBQqqblGN/cxF8YtkqZQOsvCzXyRWTSzAgPQmf2dFj3S1zxAwzlB+j4LrA+UNyMmmlaAOl9ALYVMAYPEQcMhQgvKjmuYLTaPQ3boPHHmbc5XvhitKGlQmCFA6UztCI9JlOowr11wNCHmAt0gnQfS+tbqg7Y/I6wuiTG2EC5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=SiRoxZi6; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e65b29f703so22625735ad.3
        for <linux-rdma@vger.kernel.org>; Fri, 26 Apr 2024 11:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1714156448; x=1714761248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aqaAQgdA856jvIs7dAW5ZIMPYVryl65URaMxVc//Sq0=;
        b=SiRoxZi6yDcS7xehwrjfxyCY3jGc6AAAdpeCGyiTmJmoT7ywIEGPo7WZ+YiSXnO1Nf
         SOHhjebIOgI4KiAdoB6ZlxyTP6SQKI4aBarpXaiOy7G986qTar+Hi0TpPtdFzLTZZyJ+
         sGj5NWmI1QoHbMyyVsh2/RrSDh5dU0IsQn7Yk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714156448; x=1714761248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aqaAQgdA856jvIs7dAW5ZIMPYVryl65URaMxVc//Sq0=;
        b=F/8NsKtPpslbfGU290uFII0Pl830KNiOz0GbRp2470F6Y68/w8Kxr6ZaMZDFG+2X2Y
         2e+FTK7pq9JI73t4FrsscSnXalyI0OgOPn9DNqy8CshPiWOYcrwzdyVHGE+Cz2Oag0Ji
         TI5kpR7I/WT5lSB/hGTRtkjN4/CgPqBXWw2+HeHK3bBwHq5baLQoNF850GWUMmqdqfr9
         yR/GwYp/apfzkP1cjb1WVDZ+UA5MAUUd6xPTKH47rdVhFQgC/l2BwIgMDKHEApQPgHR5
         EyFcrhEljqHdGyTwXEawkgedq36alT98T3AiAswmDLOFLWqI0bJcsjbc3uiOblKUfT64
         Y0AQ==
X-Forwarded-Encrypted: i=1; AJvYcCXx8IY8J+NCZSEXW7H0JCVKrY4nhLJYkUk8S03jXtAlh6B8N+aLetKhgcDzuTmyw2NwGla6IyMqlFbwnWuyaDrz+2Es+3LcwAWbEA==
X-Gm-Message-State: AOJu0YyQ9secYsJmkotlo8RgI9DFsp2QluHJZdNtBblSJaSe4B/oroPZ
	Vb5vwyfNj3gAeQAYlFoTgO3uBVcEpOjvaQVzBpL8PUI8X5KooDifl7iCVdJ3/fo=
X-Google-Smtp-Source: AGHT+IGmOBABSwmeCyrHpqNf6ZoNtezrLaurXRxgwMJaiE7lf1v3+4wY7GFcM3RlNtf1RT1PE1g6qw==
X-Received: by 2002:a17:903:1205:b0:1e4:ccf6:209f with SMTP id l5-20020a170903120500b001e4ccf6209fmr4140136plh.28.1714156447894;
        Fri, 26 Apr 2024 11:34:07 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id j23-20020a170902759700b001deecb4f897sm15713152pll.100.2024.04.26.11.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 11:34:07 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	tariqt@nvidia.com,
	saeedm@nvidia.com
Cc: mkarsten@uwaterloo.ca,
	gal@nvidia.com,
	nalramli@fastly.com,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX4 core VPI driver)
Subject: [PATCH net-next v2 1/3] net/mlx4: Track RX allocation failures in a stat
Date: Fri, 26 Apr 2024 18:33:53 +0000
Message-Id: <20240426183355.500364-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240426183355.500364-1-jdamato@fastly.com>
References: <20240426183355.500364-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mlx4_en_alloc_frags currently returns -ENOMEM when mlx4_alloc_page
fails but does not increment a stat field when this occurs.

struct mlx4_en_rx_ring has a dropped field which is tabulated in
mlx4_en_DUMP_ETH_STATS, but never incremented by the driver.

This change modifies mlx4_en_alloc_frags to increment mlx4_en_rx_ring's
dropped field for the -ENOMEM case.

Signed-off-by: Joe Damato <jdamato@fastly.com>
Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
---
 drivers/net/ethernet/mellanox/mlx4/en_port.c | 5 ++++-
 drivers/net/ethernet/mellanox/mlx4/en_rx.c   | 4 +++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_port.c b/drivers/net/ethernet/mellanox/mlx4/en_port.c
index 532997eba698..47541f7666f2 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_port.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_port.c
@@ -151,7 +151,7 @@ void mlx4_en_fold_software_stats(struct net_device *dev)
 {
 	struct mlx4_en_priv *priv = netdev_priv(dev);
 	struct mlx4_en_dev *mdev = priv->mdev;
-	unsigned long packets, bytes;
+	unsigned long packets, bytes, dropped;
 	int i;
 
 	if (!priv->port_up || mlx4_is_master(mdev->dev))
@@ -159,14 +159,17 @@ void mlx4_en_fold_software_stats(struct net_device *dev)
 
 	packets = 0;
 	bytes = 0;
+	dropped = 0;
 	for (i = 0; i < priv->rx_ring_num; i++) {
 		const struct mlx4_en_rx_ring *ring = priv->rx_ring[i];
 
 		packets += READ_ONCE(ring->packets);
 		bytes   += READ_ONCE(ring->bytes);
+		dropped += READ_ONCE(ring->dropped);
 	}
 	dev->stats.rx_packets = packets;
 	dev->stats.rx_bytes = bytes;
+	dev->stats.rx_missed_errors = dropped;
 
 	packets = 0;
 	bytes = 0;
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
index 8328df8645d5..573ae10300c7 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
@@ -82,8 +82,10 @@ static int mlx4_en_alloc_frags(struct mlx4_en_priv *priv,
 
 	for (i = 0; i < priv->num_frags; i++, frags++) {
 		if (!frags->page) {
-			if (mlx4_alloc_page(priv, frags, gfp))
+			if (mlx4_alloc_page(priv, frags, gfp)) {
+				ring->dropped++;
 				return -ENOMEM;
+			}
 			ring->rx_alloc_pages++;
 		}
 		rx_desc->data[i].addr = cpu_to_be64(frags->dma +
-- 
2.25.1


