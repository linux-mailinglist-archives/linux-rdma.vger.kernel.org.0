Return-Path: <linux-rdma+bounces-2460-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 373C98C4601
	for <lists+linux-rdma@lfdr.de>; Mon, 13 May 2024 19:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 644461C22AFE
	for <lists+linux-rdma@lfdr.de>; Mon, 13 May 2024 17:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8766123763;
	Mon, 13 May 2024 17:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="krpBOLQM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F194320DF7
	for <linux-rdma@vger.kernel.org>; Mon, 13 May 2024 17:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715621359; cv=none; b=e98yK7KWM6iFb7Xu2F5xWVj7wei93DeLiKsWLiuP91Ejm2dM5kpR9tBUtHS6tk4gimPBlsGNe9/Zb7ORW5fQlq0BANCYPOrcXjB0H7HbYnQkJ0Km9y2e9ZxuyoTWHc/+CoF80V5hVC0wtyb9RWcnn2c6ol51/5AAldqSibp/2Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715621359; c=relaxed/simple;
	bh=WG61YN2Nk7u7U7P0fO8v+PMiI3q/l4RfJSzMoJVrZSs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o3tPVagf7io3Z6Bt8u1h3gRLTi1Nsf4IQXsKXBM10ZoQ031HI9eP2AvjZ/bCxWEAKPgj/HdMle6zeCTG33TmHeukACQGKY0/PTdWx8LUDwDMonH7iDBK6OEO76j1DNTGc8TMfCJje67P7UhvBP090HGLAO9zGDAAyBpIsL0IgAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=krpBOLQM; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1edfc57ac0cso36743145ad.3
        for <linux-rdma@vger.kernel.org>; Mon, 13 May 2024 10:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1715621357; x=1716226157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prTLobfW9EKFUcdfFKM6P4Zgx11iA1pn2v87YJC+EGA=;
        b=krpBOLQMp5px5k53sqHorpJOHLfWSh6/oD7If8Tu30EBtb4KUFYs02xap1vgsry/dZ
         yWy9nBqzTE9uTf298ET05OKpS7OzAfPI4ndC8KxfihllDzOCs740GK2fzWean1fQpsHs
         1JDsPYljok6wfS2EMgOO02ZvW0Q5LFKb9WIqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715621357; x=1716226157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=prTLobfW9EKFUcdfFKM6P4Zgx11iA1pn2v87YJC+EGA=;
        b=Ds6i08fxSeGzfnWurRbVP3lLcQqnpwrgxV5av3rbYWrBp8nW7uQIKGniV68dVT+LAo
         8Cx/vkw6BHSaXdQy/3EsyQagt6chSjh755zii016abNALoc/ML5Emg7sRxEyi61+HQ0W
         /51JHRbkZtsf8uIdU7JJEsLmwJDydtPhJo44w5kfbBDiEXx34YJzveVfr8wlmlQ0vcQD
         +6edhtOaGJWTlFljOpW8JmozHtC9YEcAufonOyhJw3oN7OIFqdMaCt4axZFpDaU392mn
         dzfDXRpje6mRepURp11P5c4OT7/MKZjpfINBwTJkwMthpWGeiMnU8oeTLqu8dJDZLY7v
         IANg==
X-Forwarded-Encrypted: i=1; AJvYcCXvIPmZNO5Fh4iW6dZU9cX4JqPZrdL7BbkF3k3oFC85QCkSu/0A538l7Nu2QGhdDhIIU8CSS4YOGuAkjYcZa5kr+Y8F0ax6W6YjeA==
X-Gm-Message-State: AOJu0YwOlJ2BTTc9HYQ9ufVWYXe9KEGDNW6/n9LuaBWOh8E9yYhAsv67
	ZLDq5J/LmI97e7WluUN3+8BLDAG3AboaiGeDnCoGW3Y+wNBmUwCcW61E8QqgfJc=
X-Google-Smtp-Source: AGHT+IF46wCZ1KQeIgtuYfMcqauDYMnMH2aXWUlfUF/ZIORIOH/ffVUgIGrqxIkotET62+M6MUa2bg==
X-Received: by 2002:a17:902:eb8b:b0:1e5:5ccd:30e1 with SMTP id d9443c01a7336-1ef4404b81dmr120238405ad.65.1715621357397;
        Mon, 13 May 2024 10:29:17 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d1663sm81948995ad.6.2024.05.13.10.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 10:29:17 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	nalramli@fastly.com,
	Joe Damato <jdamato@fastly.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX4 core VPI driver)
Subject: [PATCH net-next v5 1/3] net/mlx4: Track RX allocation failures in a stat
Date: Mon, 13 May 2024 17:29:06 +0000
Message-Id: <20240513172909.473066-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240513172909.473066-1-jdamato@fastly.com>
References: <20240513172909.473066-1-jdamato@fastly.com>
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


