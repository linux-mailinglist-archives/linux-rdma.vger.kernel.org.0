Return-Path: <linux-rdma+bounces-2377-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE5A8C17EF
	for <lists+linux-rdma@lfdr.de>; Thu,  9 May 2024 22:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E83D428138F
	for <lists+linux-rdma@lfdr.de>; Thu,  9 May 2024 20:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6C485C5D;
	Thu,  9 May 2024 20:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="hYC9Rgdp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F921811E0
	for <linux-rdma@vger.kernel.org>; Thu,  9 May 2024 20:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715287870; cv=none; b=lKqGPsjBn3xWG2J/tx3daqv5D6YC5K9/63xKfpmYSw05pQE8N32pzcCw9wWNJe/fHwvQTFUhyEzoxs6ihh9FNGwv4fZSO357zTSKrG6QxNJKGZvJ/5pKBjWLuAcFELzGSOSUhpXx0Z/BMKCkiaC7oDY0vPUQ8pOq4t/UyVMQ0kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715287870; c=relaxed/simple;
	bh=gCbabcQaR8Ix1K97TkMliO2FSC7RBAC3W9/BPXaCzC8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MCvOfGaAXYq/Wnom/JV8QVAilIJ/Q9k9hgYbm5B+S+Hm0ymz/fwTfNyq8H5+ru9I2UjmZsvshFGroHvSfqUcJFSMZ5V7IyVfuPr7agxp38KRKKv5zwBoisjTeDne4e5BD4dvnkZHH+bFvlzPeVCopDCxlELaM9nBwLpVJ/346Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=hYC9Rgdp; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1ee7963db64so10198135ad.1
        for <linux-rdma@vger.kernel.org>; Thu, 09 May 2024 13:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1715287867; x=1715892667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KmgZyGJ6WZhyygeOTuBznvTKrsssXOFJdYN+KnXDyKU=;
        b=hYC9RgdpmNvwLSFloxHwGaw+e7pmgNtitqyJHDDhUem8n+0hxCP/5WnD2hcd471I5L
         hdLXA9w08eZ/nZl7irhqC1khRlPK20SDefVorcL9Tg5w1l3B4Sci7mEaz8qtnXXGMPSR
         axYI2Otl+5r57V7yt9QZldcrzAIRP++r7mPfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715287867; x=1715892667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KmgZyGJ6WZhyygeOTuBznvTKrsssXOFJdYN+KnXDyKU=;
        b=qVRZr5CA52Qq5SsN/aMy0wfttjlr2kxWvS6x8wG1F2WVPFofAyHcA027+fTu1vcPl4
         MjKAzxryr1TGkhovYxfF1zVhs+bLucdgmTLOdw0RA9je2h3sfOftfDaPShNDgdTawAyC
         0KXC1l6Km2WLseRaSprDRmkxNzA9/bUrAjG+wfJdLiVgerLw/ibufFwkHaKjk1dr316B
         ME1P7QnA9boB9KKrixvznRq4S8yvDa9B1h6Fqcjq2nmbnMUuLpiZTyElpI42MMb6/i8c
         9jTjQXT8OOzWXlSiEoGkc2bL2jhhcnGAWyX+E89S8CZGW2+NTbdYsiWq91fO4Flk3IML
         ISlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtqDS9CMGjhKfKhvhUF6i/g+kbOnxA+s+hf6NJcZWyKFndcMtrriT3nn/cVbjnycMiFH+DNEzhdXurozbc8N3d0Aqo7ksxA0mAww==
X-Gm-Message-State: AOJu0Yy0iYgCCppjzDwe5Xnbq0DXxWp6rEtfcPpCxHxOZriT+l1lxbr1
	+/8DMQWDdWt7DY7gW8uQkjgUohXq29saaqflPM/Y+AScWL3AgyHjNeJoq4mG7o0=
X-Google-Smtp-Source: AGHT+IFAC02y7XWbzyZ9poYznCRhteDMrS6y/6vnrp3VuOJIRuyyMgREUL36urHGU3CvlHCx24DmMQ==
X-Received: by 2002:a17:902:d4c2:b0:1ec:ad62:fe87 with SMTP id d9443c01a7336-1ef44059628mr10146585ad.56.1715287867290;
        Thu, 09 May 2024 13:51:07 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0badb959sm18677365ad.85.2024.05.09.13.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 13:51:06 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	nalramli@fastly.com,
	Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX4 core VPI driver)
Subject: [PATCH net-next v4 2/3] net/mlx4: link NAPI instances to queues and IRQs
Date: Thu,  9 May 2024 20:50:55 +0000
Message-Id: <20240509205057.246191-3-jdamato@fastly.com>
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

Make mlx4 compatible with the newly added netlink queue GET APIs.

Signed-off-by: Joe Damato <jdamato@fastly.com>
Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
Acked-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx4/en_cq.c   | 14 ++++++++++++++
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_cq.c b/drivers/net/ethernet/mellanox/mlx4/en_cq.c
index 1184ac5751e1..461cc2c79c71 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_cq.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_cq.c
@@ -126,6 +126,7 @@ int mlx4_en_activate_cq(struct mlx4_en_priv *priv, struct mlx4_en_cq *cq,
 		cq_idx = cq_idx % priv->rx_ring_num;
 		rx_cq = priv->rx_cq[cq_idx];
 		cq->vector = rx_cq->vector;
+		irq = mlx4_eq_get_irq(mdev->dev, cq->vector);
 	}
 
 	if (cq->type == RX)
@@ -142,18 +143,23 @@ int mlx4_en_activate_cq(struct mlx4_en_priv *priv, struct mlx4_en_cq *cq,
 	if (err)
 		goto free_eq;
 
+	cq->cq_idx = cq_idx;
 	cq->mcq.event = mlx4_en_cq_event;
 
 	switch (cq->type) {
 	case TX:
 		cq->mcq.comp = mlx4_en_tx_irq;
 		netif_napi_add_tx(cq->dev, &cq->napi, mlx4_en_poll_tx_cq);
+		netif_napi_set_irq(&cq->napi, irq);
 		napi_enable(&cq->napi);
+		netif_queue_set_napi(cq->dev, cq_idx, NETDEV_QUEUE_TYPE_TX, &cq->napi);
 		break;
 	case RX:
 		cq->mcq.comp = mlx4_en_rx_irq;
 		netif_napi_add(cq->dev, &cq->napi, mlx4_en_poll_rx_cq);
+		netif_napi_set_irq(&cq->napi, irq);
 		napi_enable(&cq->napi);
+		netif_queue_set_napi(cq->dev, cq_idx, NETDEV_QUEUE_TYPE_RX, &cq->napi);
 		break;
 	case TX_XDP:
 		/* nothing regarding napi, it's shared with rx ring */
@@ -189,6 +195,14 @@ void mlx4_en_destroy_cq(struct mlx4_en_priv *priv, struct mlx4_en_cq **pcq)
 void mlx4_en_deactivate_cq(struct mlx4_en_priv *priv, struct mlx4_en_cq *cq)
 {
 	if (cq->type != TX_XDP) {
+		enum netdev_queue_type qtype;
+
+		if (cq->type == RX)
+			qtype = NETDEV_QUEUE_TYPE_RX;
+		else
+			qtype = NETDEV_QUEUE_TYPE_TX;
+
+		netif_queue_set_napi(cq->dev, cq->cq_idx, qtype, NULL);
 		napi_disable(&cq->napi);
 		netif_napi_del(&cq->napi);
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
index cd70df22724b..28b70dcc652e 100644
--- a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
+++ b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
@@ -380,6 +380,7 @@ struct mlx4_en_cq {
 #define MLX4_EN_OPCODE_ERROR	0x1e
 
 	const struct cpumask *aff_mask;
+	int cq_idx;
 };
 
 struct mlx4_en_port_profile {
-- 
2.25.1


