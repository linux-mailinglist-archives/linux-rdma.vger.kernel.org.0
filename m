Return-Path: <linux-rdma+bounces-2641-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 130AD8D231A
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2024 20:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C15F62822F1
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2024 18:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57B6171E5D;
	Tue, 28 May 2024 18:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="GPidMOJ/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE5716DED8
	for <linux-rdma@vger.kernel.org>; Tue, 28 May 2024 18:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716919911; cv=none; b=UvYU/pcNU7s4oMCxv1CH1x/dn4G5eGNHmB7AlGouUGKgZIZrmjZb+Iyffey4w/0e24sNq5rltK2/RAeNpvQg35F0sqD4/kI7YL455pNbnbtpVZR55RI8aPZrWt0lshvLQG3VTD6+iv1Z74f2c39OWP6sz75oF6MHT0PZ2JHnjlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716919911; c=relaxed/simple;
	bh=iyTG7Cq3pocgTQck4D1YrQGNjvMiY2USz0q4p8QPPAA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V+QENeb6F9jcMLEj7SG2tSkWCOobAFMTIHlyGYu/6dcJkrGWbZhFYawU4p48x38Bcyp+t/Ki+L+ID/W5DKeTRsKIsHiB8e807tKDPR4U1n641+kLZt96LTnJnKQw8D1aM3H4hhdJr9mfuWRCnVFJpIM39Yw7D5QOhfV9VFRBCbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=GPidMOJ/; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6f8edff35a0so962839b3a.2
        for <linux-rdma@vger.kernel.org>; Tue, 28 May 2024 11:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1716919909; x=1717524709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F53AvWwbOsFwRRf3aqw2FPbWvEDA36PwlFhpoQmzPfo=;
        b=GPidMOJ/QeQX5bdzPglDYi+muygwhtYj+hhInjsSFIcu/z7FrmEVkS49OiASOuhIKq
         X/pwWl0JK2J0skIldRgXngbVGuq8rzkuWaaPEpuHAM1Y0b3Yq6CQ/0TQt8BTxPkrBWdl
         DlOSoJiXfQ7Bmp/tHUeyD7jTW5asZQ+oumU3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716919909; x=1717524709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F53AvWwbOsFwRRf3aqw2FPbWvEDA36PwlFhpoQmzPfo=;
        b=hCvPU+YqWcWXuxi0Bo4UvDDhijcByCQFbz0LOPRrwcvFd9+IbT9JsExQpy92Cuwatu
         Hzme2FZN3Q4zshpZ+pcHaPyibcMdTlsoPvjwq+WwoqP0qruqIiLBwqT4m967NsQyNpiO
         wRQbYQ52JJDCMva5fxWYbRjzUtRbfUfQkVrU1jPYpryht1+4FKxj5PevL+fXQn/lU2ka
         mM7HA7FLtMd9dhJJ49CUX9B3mKGhyw9WFpJWL/dT0kwusTosAsLGWGGbJt2SV15Oel5t
         ejPpLrMcgOmr+3Q0n1YxWyutLiWocpvQA7cUH7+IZNFdQFH/sGq/dpi1uDQzc1cbEfK+
         jLYA==
X-Forwarded-Encrypted: i=1; AJvYcCWNQWgbm5ikGmMAG67VJuBIY7MfmP8nENmgOSvAqzIHbo2ERoH7C2ZUuzWImzF3aoOyRrj50c56SPnbdLdL2wGgoOnLod7q3ViPCA==
X-Gm-Message-State: AOJu0Yw2mua8ut8vyHpTmofIRJKfby05M4PlNjjeqK71CBZdkUl35kzC
	shuyaiEJ0826FUwgU6km7Be23KdmNm9/5XcWUBSjPpjh8IDzWux+S0YFMp3FE/Q=
X-Google-Smtp-Source: AGHT+IH526oPfXwlVZihlIMLiUTTnTItfT1UqLFzZfgiSTPeVbqfEm6VgxczQEfX/RxXPYLbuae5nA==
X-Received: by 2002:a05:6a20:9783:b0:1af:d9a3:f399 with SMTP id adf61e73a8af0-1b212dfe3e3mr12049996637.29.1716919909260;
        Tue, 28 May 2024 11:11:49 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fcdebf54sm6718849b3a.112.2024.05.28.11.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 11:11:48 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: nalramli@fastly.com,
	mkarsten@uwaterloo.ca,
	Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX4 core VPI driver)
Subject: [PATCH net-next v6 2/3] net/mlx4: link NAPI instances to queues and IRQs
Date: Tue, 28 May 2024 18:11:37 +0000
Message-Id: <20240528181139.515070-3-jdamato@fastly.com>
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

Make mlx4 compatible with the newly added netlink queue GET APIs.

Signed-off-by: Joe Damato <jdamato@fastly.com>
Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
Acked-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
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


