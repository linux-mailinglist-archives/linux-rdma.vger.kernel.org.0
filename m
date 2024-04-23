Return-Path: <linux-rdma+bounces-2028-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDB18AF78C
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Apr 2024 21:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFE771C220E5
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Apr 2024 19:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3131422D8;
	Tue, 23 Apr 2024 19:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="H79s4Q/R"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE7C1420C9
	for <linux-rdma@vger.kernel.org>; Tue, 23 Apr 2024 19:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713901779; cv=none; b=kJRxQ7MleI75HJr1MbfbbgQIoEzje4Dh/sTBRc2iEWeuZxdTRTeYsk/1ispGlYbASahh+87n5rtGq0hzr11KkdjpsxMoWpYtxitvdk/s/oITDMHgp9PjS45naV2co/RcI3knPlb2HbzLTW+mUmV6/tWCOmbUQMVKhqyT6VBxx+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713901779; c=relaxed/simple;
	bh=NAmZBz9KaDewSEn6UsfuFlFlWSCv9ZwDJZlG72i5LnE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qfO7KNwkSEe2p58lAOoBf7Q6NH1P1XqqLVsdLJ6mT+y2k2hddehotZe6KLjtybjubqQQBHS2fwHoVfmR1x17bUkzb0LFf2F4TOnvH9IgiQlKRdaqk77wUajXlaHD90tCj4gxaugMmdpcoOLxRP61Emn91FhvTRuWHD5Mg21nLQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=H79s4Q/R; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f28bb6d747so2561150b3a.3
        for <linux-rdma@vger.kernel.org>; Tue, 23 Apr 2024 12:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1713901777; x=1714506577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9XSEsaXMnYKVqcTHOSxPSgntkBLCcmZ9J5ASUc0dakk=;
        b=H79s4Q/RBaNSw0rrpw6Qp6qd61iAjvVhd9VStu1LP40yRnj4je7Q/QYbgcjlaHqLs7
         /gFTUuskAhWmlJe3FU5pLj+wKY+bMQWXdIDg8HgppiesxQl6RPLWyN9ntPvdjWJ/QwgI
         t6BcbuP5psZuSXsrByIgBQszexyRjR9oZ73W4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713901777; x=1714506577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9XSEsaXMnYKVqcTHOSxPSgntkBLCcmZ9J5ASUc0dakk=;
        b=wK/qvNxIcQfgIboQJb/5+IEThlT5ME1mNm/s4m3A68txtULtVd52N7IHFo1T1KWjZd
         yWY1MB2oqASKYQyTqPfyKnRtbfF1vJbQzEplQffb5U38U4cCDM8p+epU8m8xXcPQ3sQ9
         x3ObtBmpy0E4In/qHT851AIqPuseU+b0NMxtpXogseI0OUfp1nim/QuS6nZkTZFd9VY6
         fIddiOWKIm6aMYP/Dd4vZiRv20TaH8mTtdWzJ/I4Wbue4+VfCSl0DX5TE2rGCgqahY2D
         mFrHwdTkG+vrwl52GVgzeDq/MO2ejvtqwPkZpV+PnRM7LD3QkrUtQQouCXWd44pMHk9U
         VGjA==
X-Forwarded-Encrypted: i=1; AJvYcCX7SoaxT3FKYFrV10OiQrU4rrrso49jkWlCdTNfIqpKM1HK0ksPoloKN/oGgUZ3s66R3JEw/EQKRV6wt3/8J4JI3d+xro8R6FCucw==
X-Gm-Message-State: AOJu0YxjF88xHf+88ZHPNCGLVJxXYCYFTBC3MrBfgaeMQ5iUWFrsZ0Zc
	dmhcA6jyoNSPEn61N9lAOlmix99Z/6fwHJSVHLZ6ibZNFKE2luYMob+qNx0XzM4=
X-Google-Smtp-Source: AGHT+IG6XovYKWAkwGpJrOjAuxe2PGxzyt0cRlqmXFkcgQRTJ+XKwTbwxnJkl3VTUBPWj80xsE85hw==
X-Received: by 2002:a05:6a00:8c4:b0:6ed:41f3:431d with SMTP id s4-20020a056a0008c400b006ed41f3431dmr779855pfu.0.1713901777469;
        Tue, 23 Apr 2024 12:49:37 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id q3-20020a056a00084300b006ecc6c1c67asm9995672pfk.215.2024.04.23.12.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 12:49:37 -0700 (PDT)
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
Subject: [PATCH net-next 1/3] net/mlx4: Track RX allocation failures in a stat
Date: Tue, 23 Apr 2024 19:49:28 +0000
Message-Id: <20240423194931.97013-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240423194931.97013-1-jdamato@fastly.com>
References: <20240423194931.97013-1-jdamato@fastly.com>
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
 drivers/net/ethernet/mellanox/mlx4/en_port.c | 4 +++-
 drivers/net/ethernet/mellanox/mlx4/en_rx.c   | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_port.c b/drivers/net/ethernet/mellanox/mlx4/en_port.c
index 532997eba698..c4b1062158e1 100644
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
@@ -164,9 +164,11 @@ void mlx4_en_fold_software_stats(struct net_device *dev)
 
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


