Return-Path: <linux-rdma+bounces-2376-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 531C08C17EE
	for <lists+linux-rdma@lfdr.de>; Thu,  9 May 2024 22:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80D0A1C21728
	for <lists+linux-rdma@lfdr.de>; Thu,  9 May 2024 20:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710AC8061D;
	Thu,  9 May 2024 20:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Ed67/4tf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A3B38DC7
	for <linux-rdma@vger.kernel.org>; Thu,  9 May 2024 20:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715287870; cv=none; b=F2nOLZRnADhW/ao78JJqFvVMIwsDXYvJVxoohPkZNWmE7kHv9FA/42R5XFU/eKGszh0O83oi7OnMapY/OgEzRfmkZUdY1Hg5xxLRxPbJpxHBc4xoiNst/iVW3il1XS4/r5fgMGIFpP9eCrK/CI0jLDegD6PRYCn9wHZy4Yl/mQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715287870; c=relaxed/simple;
	bh=AO4ibM0f40u0LST8xsBvynBO/brqWCLwYZxK5Wpm0nw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=foLUR8XmC7vluHCBqtLOHjSkC368JjBtO0QMBzhpzlZKj274p/L8sQsSlTWXtQugqmr5Ck5ATKbFkchGfcrwQ+mJ+a3zTGt7WouvXQ8bwewo4oki9lj+Bqy0bmAIMQNgJRu+/bMQ+P9Pgd4/p8X6eSrmCyNLjDFTl+ndcVyJKfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Ed67/4tf; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6edc61d0ff6so1197103b3a.2
        for <linux-rdma@vger.kernel.org>; Thu, 09 May 2024 13:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1715287866; x=1715892666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mK9jRCqJy/IAjt4V55hSSH/H3KvUaHNlqx/4tUOcg/w=;
        b=Ed67/4tfRKob+rHwqlGfFIl6bqdWmz9So+IxPDc4LHg5gndY/4YzTkAYeIdM4Tp9Yk
         OrrehrbByqoUzvelU3q/x5TzL98DIlmdYARhEYkZnbXNhud9tvOvxMhnphWq5Taxcb7P
         tzRfNG/9JxVKihzIGfjBgX1vUmbScnaNzEhuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715287866; x=1715892666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mK9jRCqJy/IAjt4V55hSSH/H3KvUaHNlqx/4tUOcg/w=;
        b=FlF/wUIj9iuvau0OqJpbynSUnCDHmQvBzkA/IJiScmrRGHWjFa3vtpb583piMyk5AJ
         +bpg0jCC0rDXkuaJ39lPwdfAK4KL/q2bcT3Ymc1AT+7HQ0Vem4zIwvOCqbj8n2OgZ1lx
         +bfvwaGumwqJOkwvK/Ik4SMZKhZX09nJsdFr3SX/MEz4NWyAsiqpvr7APPC0RKiFDy7S
         8EakMpWvenWb6Ok9DBah2MvmOx+bhMakf9KCjIxtVJ6QNpSrx9PCzqNri1vrDkq4Hr86
         McsR/fHdE+puXmE64Obav4ElhWeurumbm7FU9jJBdr3G4mkyBi5J7U3RE8NFM91Swe5X
         lv0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW4V256tkCV2F+KC82GSwiY2XDDiBZgt92Km+oDOcGXQjRaBwW3koYZX2Az+Ne00wZn7xx/PUL0Lp3OXGr2rvwOorzG1TJjcKDlsA==
X-Gm-Message-State: AOJu0YybTKYSSt1pt5cV7DU8X3epoSop8uc3bzplpo20mSoxVnRjA042
	dBFkk0YzufPkF636Df2axo8qxLlQulPnA/JL6cxPFHZR0di2KHMeKC5bvFWAIaw=
X-Google-Smtp-Source: AGHT+IHla1dQrim4j3USXrIXGvmfovYHjmRSCd80Xn+OwNzfQ8XNKU71RDvgr85iegLA1EQwUc2zpw==
X-Received: by 2002:a05:6a21:99aa:b0:1af:7180:494f with SMTP id adf61e73a8af0-1afde1b6f3dmr1283476637.41.1715287865782;
        Thu, 09 May 2024 13:51:05 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0badb959sm18677365ad.85.2024.05.09.13.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 13:51:05 -0700 (PDT)
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
Subject: [PATCH net-next v4 1/3] net/mlx4: Track RX allocation failures in a stat
Date: Thu,  9 May 2024 20:50:54 +0000
Message-Id: <20240509205057.246191-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240509205057.246191-1-jdamato@fastly.com>
References: <20240509205057.246191-1-jdamato@fastly.com>
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
 drivers/net/ethernet/mellanox/mlx4/en_rx.c   | 4 +++-
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

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


