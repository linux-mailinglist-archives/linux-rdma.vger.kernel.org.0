Return-Path: <linux-rdma+bounces-10175-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A40AB06CC
	for <lists+linux-rdma@lfdr.de>; Fri,  9 May 2025 01:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 276A23AE095
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 23:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2C022FF4C;
	Thu,  8 May 2025 23:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMI2FZIG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4B528E0F;
	Thu,  8 May 2025 23:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746748273; cv=none; b=A9zl1GBIUPyptJ7shwrbxHmC1pRocd6L+t2unS6zkT9TtAxCABj2nILvVDa2dxhVpFEXlfq3Q+YfqgPQ483xl+vKxLjTcGTPsTZFJ/QbEMqxd1W6o8+kzJMTYH7kLP7j1hnH6cM7ySd5Z2D9/m/kAewJdWzxHtmuGFBHPhnX5Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746748273; c=relaxed/simple;
	bh=XLtXSV3YB2wMR3rf8YoNwOysDSGP/edc5e4gRMcZF9k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tVb+8a8f00AVPFbDHkenIKxoFLjvBDtI8RVgffGKeQ0yYINPmZHMScxBTQYc3Pil7oPAPbIJ39Muhxcyi4dZg0Ko6p8phMU6EDjcRyH0jdLMkcbL4o3qwWx9wds00e59vM1x5DPKhqZwGLCpNnrK1qrMsQcNEG2AtJwKK94wStQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMI2FZIG; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-30a8cfa713fso1564433a91.1;
        Thu, 08 May 2025 16:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746748270; x=1747353070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2tNz5T37bIUq+s38EPZp+Fj62nX8tr4TvbgzvkpBsJ8=;
        b=UMI2FZIGgN1/Z+bcFlzdoM7jP5wnYpzT/cxuOZNn+5d3gCFnQgHvCfNXUzwL8EdHVK
         Z+F6T77CBcjyDbQ+YE98Riew15JFo3ET/W5CE6iZsq7cG2AUAj5+Sj5aZTRbz/4aUjkd
         1wByixmXkhXJjnA694KsxqaPsiGrnpxmasBGM8xTPAOPSEWIhgHN37KKMR2N9P2efoeG
         1E//6BKe3a4F0CZl2Pc5a8IwMN1agNxoW8Pxaml80X3bb9ZK0TYZgeoSmT9hxv5NmXUB
         4uHk2e55rsLdZLxXJKvivnclIdbtrWzubJy6hhCUJSD+eGuZVYc5P52cuJq1Wccm9PCi
         zg5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746748270; x=1747353070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2tNz5T37bIUq+s38EPZp+Fj62nX8tr4TvbgzvkpBsJ8=;
        b=IEUc1UH3vsJpfaGXNRtu5VXK3hkefPKkiK7qyH+LRheIDKc/d1E984y610JMpccq8N
         FIx4NQQ/gxdSKYCnBdWj/80e227ZZ8rly3PU/QNKHhzLE3q2tiwf84RIGgSdTgryBznx
         uXeIlB05pej45PfK1ZRHEdhx1v6nFqucGfTGpApnN8U3ZbBR2Y0Cy8ZgRPjv/PZUY9EV
         Eiy3c/z376a5ipljgYZdSDXNq9FeOnsNuWm0GC0k0E8JAErw7C6nMod8rWvK8pKYm8B2
         xQO8anflVvJ9TK6Xs1qKrYvBgjWDhbfC2XnZgaSclDZGlgoPN5u6sPbZJY9GkYJDbDyf
         N8BA==
X-Forwarded-Encrypted: i=1; AJvYcCVgaWjE0A/kq3KWGjIyaf7Q00dNNkkmgDIv5GSGtVfLnb8Sm9w1HLUASDgxEO5/oolIcTqs9gkpn1/sNg==@vger.kernel.org, AJvYcCXZOcqKfL3Le8F78wDMTi4IGKmLsfWrd7VYH7iJtq/XSopfKQ0UiMEqLTP+YrQXTaeKjs8mll9nKwrQylc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbh5A6TLTBlhuSN+kA843etBm/PcUvd0aFoRdifv6TjJ2FQgg2
	qvSS4jyXXyRZDwzV9QiijbPJ6CIXby0uQQFSO2XCPpSTLHfrQAvC6Pbt
X-Gm-Gg: ASbGncsdbursV5zsqOpeDCERL09gSn9yjxzAjziPQK0VGpwqFD//SOzLIAKV14Ki7GV
	Xjr4y6Alt1Mc0iEAqFedgRMn6lejz43eONuD10PC5O5DVIUuW9WV1rZgsVcnaFkwhix5t1NPVvu
	Aiunkjqz43ibBzeISLb6ygSRETpnksO63TqWnI+Ff1YvVT1t9futSleJmkhknzoyDL+GRjQ37vq
	5lD6XegwFZnGT7tjJaJogYUSIlslqKAwDs0Tp7JQ/2CXqjE36v+iTvNYAgqH6K5Cm/Ys7p7kSBq
	zcMT7xw3KCUZ/fm51uPbHuASzhDm3Pr4Irckg1PiZN7xgxJDpLnkTlWRihsvldn5gXqELYINn9I
	EbA==
X-Google-Smtp-Source: AGHT+IF5UwdT+dpyOFkrKM1cBtO+e3lXz9lyiUr9349apmbudXoYjrOoYfqNfHfAt4QrANmb7fjJQA==
X-Received: by 2002:a17:90b:55c4:b0:305:5f32:d9f0 with SMTP id 98e67ed59e1d1-30c3d3e1da0mr1974700a91.19.1746748270474;
        Thu, 08 May 2025 16:51:10 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b2351b7afeasm416158a12.73.2025.05.08.16.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 16:51:10 -0700 (PDT)
From: Stanislav Fomichev <stfomichev@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	andrew+netdev@lunn.ch,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	leon@kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH net-next v2] net/mlx5: support software TX timestamp
Date: Thu,  8 May 2025 16:51:09 -0700
Message-ID: <20250508235109.585096-1-stfomichev@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Having a software timestamp (along with existing hardware one) is
useful to trace how the packets flow through the stack.
mlx5e_tx_skb_update_hwts_flags is called from tx paths
to setup HW timestamp; extend it to add software one as well.

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>
---
v2: rename mlx5e_tx_skb_update_hwts_flags (Tariq & Jason)
---
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c | 1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c      | 7 ++++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index fdf9e9bb99ac..e399d7a3d6cb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -1689,6 +1689,7 @@ int mlx5e_ethtool_get_ts_info(struct mlx5e_priv *priv,
 		return 0;
 
 	info->so_timestamping = SOF_TIMESTAMPING_TX_HARDWARE |
+				SOF_TIMESTAMPING_TX_SOFTWARE |
 				SOF_TIMESTAMPING_RX_HARDWARE |
 				SOF_TIMESTAMPING_RAW_HARDWARE;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
index 4fd853d19e31..55a8629f0792 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
@@ -337,10 +337,11 @@ static void mlx5e_sq_calc_wqe_attr(struct sk_buff *skb, const struct mlx5e_tx_at
 	};
 }
 
-static void mlx5e_tx_skb_update_hwts_flags(struct sk_buff *skb)
+static void mlx5e_tx_skb_update_ts_flags(struct sk_buff *skb)
 {
 	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP))
 		skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
+	skb_tx_timestamp(skb);
 }
 
 static void mlx5e_tx_check_stop(struct mlx5e_txqsq *sq)
@@ -392,7 +393,7 @@ mlx5e_txwqe_complete(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 	cseg->opmod_idx_opcode = cpu_to_be32((sq->pc << 8) | attr->opcode);
 	cseg->qpn_ds           = cpu_to_be32((sq->sqn << 8) | wqe_attr->ds_cnt);
 
-	mlx5e_tx_skb_update_hwts_flags(skb);
+	mlx5e_tx_skb_update_ts_flags(skb);
 
 	sq->pc += wi->num_wqebbs;
 
@@ -625,7 +626,7 @@ mlx5e_sq_xmit_mpwqe(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 	mlx5e_dma_push(sq, txd.dma_addr, txd.len, MLX5E_DMA_MAP_SINGLE);
 	mlx5e_skb_fifo_push(&sq->db.skb_fifo, skb);
 	mlx5e_tx_mpwqe_add_dseg(sq, &txd);
-	mlx5e_tx_skb_update_hwts_flags(skb);
+	mlx5e_tx_skb_update_ts_flags(skb);
 
 	if (unlikely(mlx5e_tx_mpwqe_is_full(&sq->mpwqe))) {
 		/* Might stop the queue and affect the retval of __netdev_tx_sent_queue. */
-- 
2.49.0


