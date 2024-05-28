Return-Path: <linux-rdma+bounces-2640-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F348D2316
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2024 20:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D974283350
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2024 18:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E3F16C6A0;
	Tue, 28 May 2024 18:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="iqFWdEzZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4D2482CA
	for <linux-rdma@vger.kernel.org>; Tue, 28 May 2024 18:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716919909; cv=none; b=DVxA4+v0DF5x+IuddU21KipdVHc1yyaPm3juDA9nSSgd/U0MDPvwLLf2OztFXlyMOhV49uzjTU8Fl69h9xkq3Qwc/VcVoQx0g2fM4n5nKENG9GHXlzxvcHDRsAsFdUn+vMXSW7aDeFNI7vq3jXciQj2P4TmMs2bmNiazbjV1ksg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716919909; c=relaxed/simple;
	bh=At1AhuB6bMioug31oBJZbuGGBQlkqzmenZ/4OhCkf/M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A/ces2rp7zgKzCQXi04L2QUtUWYF3L0vnpvkwBM3GEzDG9S7Q4MtFdLht3CqNt8k7syDCebAEYQLlrWzw98RvWnkAqyqrwDXDD0KKmjQdGhWfThWs+6gi+mUekfmGB77uPdvSI5bshCyuS6n87vG/gdVgxVtMgDzfQ5FxMcZck4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=iqFWdEzZ; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6f966840af7so991930b3a.2
        for <linux-rdma@vger.kernel.org>; Tue, 28 May 2024 11:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1716919908; x=1717524708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XMwDaG0C8XGkjNqWFyY43ZulaM5n6/Kpuxg3CcMZavU=;
        b=iqFWdEzZEidSACaumrywtSVK9nVLmfhHtI747HVUSw/7ILOlffuVF3lxILWG7wElQm
         0HfJ9PhDxhOdenBBJXWtFNKWXKj+0g3QQGGMmtaIhqe0UXMAQe98mpUASdcY/6B6HCoR
         HOcYj5mau8tC3YZLSzh0cZ5cWYypA+BftlCAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716919908; x=1717524708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XMwDaG0C8XGkjNqWFyY43ZulaM5n6/Kpuxg3CcMZavU=;
        b=jd5fuBihyP6963tSwaDzOM5ocH5zCBCfPyCvO2YWV+lf7ddQCMK4Mnzgtuta/ZI0KE
         QiPphva3V4S+aBjHFY6/hx2Xna+b2c+IUcMPhr9+X+/aB1iaHDZfqNI946JPOhRzjQC/
         GirRw5fVybTdXhZZ7k2efgJN+Z5PBbDeFxzlrTkZWlm0BBcbZRdRWWs0VFE4PQQdYALV
         EvCi7ap9qbAviSecuMAQZvpdkYPCOie12YJ2pQtroKGRCtKGHCMzBWkjO5QIO+CopkXV
         V8lhX6x6b9bKKLiIXqAI1go+HMIAcNXy3wAawizL+qPXdhFFuCDLx93IBFLMGvf9s6Hd
         ZIaw==
X-Forwarded-Encrypted: i=1; AJvYcCU74QF8UfVVKqy1CRxM70xxyV0nDylkkuLcRMn/TaR71EHVzzEEc009hfnpY9FOnHqTpiRU4E+DUBuYSnAzpTLC7U1Kvgm7GWOBBw==
X-Gm-Message-State: AOJu0YwIrDIDJgMhcPFenqROH8aUmDEGNHfGu3Muw6xj+UpsaVQ/K0tB
	VSs/1uoJpqWvf9KTyDfYRr9XVypalg+Zl1r3lppkm345V34dvBwDtp6ZPVjoCRk=
X-Google-Smtp-Source: AGHT+IHXeid6bB3qbISuL1ms2RtSB9UuPU79/g2JxlCBPKxlRIA2qVwPU06XmMZ0xegX72n80AJblQ==
X-Received: by 2002:a05:6a00:1c83:b0:6f4:d079:bb2b with SMTP id d2e1a72fcca58-6f8f3186614mr13750541b3a.9.1716919907646;
        Tue, 28 May 2024 11:11:47 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fcdebf54sm6718849b3a.112.2024.05.28.11.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 11:11:47 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: nalramli@fastly.com,
	mkarsten@uwaterloo.ca,
	Joe Damato <jdamato@fastly.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX4 core VPI driver)
Subject: [PATCH net-next v6 1/3] net/mlx4: Track RX allocation failures in a stat
Date: Tue, 28 May 2024 18:11:36 +0000
Message-Id: <20240528181139.515070-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240528181139.515070-1-jdamato@fastly.com>
References: <20240528181139.515070-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mlx4_en_alloc_frags currently returns -ENOMEM when mlx4_alloc_page
fails but does not increment a stat field when this occurs.

A new field called alloc_fail has been added to struct mlx4_en_rx_ring
which is now incremented in mlx4_en_rx_ring when -ENOMEM occurs.

Signed-off-by: Joe Damato <jdamato@fastly.com>
Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c | 1 +
 drivers/net/ethernet/mellanox/mlx4/en_rx.c     | 4 +++-
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h   | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
index 4c089cfa027a..4d2f8c458346 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
@@ -2073,6 +2073,7 @@ static void mlx4_en_clear_stats(struct net_device *dev)
 		priv->rx_ring[i]->csum_ok = 0;
 		priv->rx_ring[i]->csum_none = 0;
 		priv->rx_ring[i]->csum_complete = 0;
+		priv->rx_ring[i]->alloc_fail = 0;
 	}
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
index 8328df8645d5..15c57e9517e9 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
@@ -82,8 +82,10 @@ static int mlx4_en_alloc_frags(struct mlx4_en_priv *priv,
 
 	for (i = 0; i < priv->num_frags; i++, frags++) {
 		if (!frags->page) {
-			if (mlx4_alloc_page(priv, frags, gfp))
+			if (mlx4_alloc_page(priv, frags, gfp)) {
+				ring->alloc_fail++;
 				return -ENOMEM;
+			}
 			ring->rx_alloc_pages++;
 		}
 		rx_desc->data[i].addr = cpu_to_be64(frags->dma +
diff --git a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
index efe3f97b874f..cd70df22724b 100644
--- a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
+++ b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
@@ -355,6 +355,7 @@ struct mlx4_en_rx_ring {
 	unsigned long xdp_tx;
 	unsigned long xdp_tx_full;
 	unsigned long dropped;
+	unsigned long alloc_fail;
 	int hwtstamp_rx_filter;
 	cpumask_var_t affinity_mask;
 	struct xdp_rxq_info xdp_rxq;
-- 
2.25.1


