Return-Path: <linux-rdma+bounces-14470-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34693C58F6E
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Nov 2025 18:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EDF73BD949
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Nov 2025 16:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A0335C1A5;
	Thu, 13 Nov 2025 16:46:18 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5953D359FBD
	for <linux-rdma@vger.kernel.org>; Thu, 13 Nov 2025 16:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052378; cv=none; b=FvEBBLgvlzMac5ok6W84iOwE26O3C+YPx2eboUP11cOyqMljr+sHigJoJ02k3deeFFtTuzzaQ5oTc0ygMRyWGhx8smWJm7XcTNkTehR9HFfETVk561iUNFX0we0I5MpdhnlHjMuUaudymjBomseqTb+q4NKGoPyFnA1zFvGUwHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052378; c=relaxed/simple;
	bh=poQ2ltGXAGj/R6azLC8+vFrV6fsBn4x8KuYNyoxOTxE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GkjMSaZT/gflhi0MY5P7QTx6YDJ1e+6zB74k4MdJkI0MRzPoS6LSNevVhuCqY5CMgCgLaXz6NhUyR6pC96tL7+GzHvCWccPd7l2WWpXOhT35JdoB9BMEB/anDfhhDQ0LPTc9KVLS2Ln981WgiuArstEW2QFMzPLmAvK+92zdiVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7c70fcc8561so395984a34.0
        for <linux-rdma@vger.kernel.org>; Thu, 13 Nov 2025 08:46:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763052375; x=1763657175;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AMwHal9dzTj8WL52AK+cJ5GudloGhSjkVv/ITspvX8U=;
        b=Yeadn2zi+bk8P9sVhZ8hgg5Lvf63zBkmwwoVoU6EdQUMpm95jq3uK2YjnGLwt/pC1u
         aDH663zwpDpeQ/aItqC/yXP/Cbj7oSGZXjQGwEr4ok/6Gxmk+o1ZOweD0odm3uHpe9zD
         N8dSqPpTDAB4qc9DAp5vIumuIrRm24YqpULbtynpLAZFMk1WDs1F25mafKNoixY27+gh
         Tu1r1WIoVxlJHUdep5D8v/SpsBqoP371BSW3BnQkIh2cZSVY/pn7Dzv7Iz69/RdSDPev
         8hA5xi+FSlH+0UpzPXOei3J5QaqVKBKgFsuuOcb8VgBkEhI0agbLaIyI4ADki5o2PlgY
         AJHw==
X-Forwarded-Encrypted: i=1; AJvYcCXrn0WoC3jWHR8PRzlxATNf+jg41HwVX5e1wwi9pjfmHBiNvVs5BMtAxpn2oRLZu46tJGXQPOkQDTI1@vger.kernel.org
X-Gm-Message-State: AOJu0YzU4H7A79CcPpzGHl9/WVoXUl4QJO4moRaNLuKGOx+2WagRpNYt
	gFanFsslrZz91t2i5ITbGhWxYKk0YqSdbHNZ4iQycn4m+nJ9Ce38lxCJ4iBYTA==
X-Gm-Gg: ASbGncupDKQe9gf9h7/7RvlDgo0f8c/Z5EIk1JOTArmLiVOGsnCpAefwDhJNxnFSMPX
	v9ZipKVUYJVs0YADgnBVzjZTwlw8JHy6h7hDDx0VVkZ+TCoJ2dydsXhnLX/MUDKwoqK0Tm9A3y8
	Rj+iT9XObsM5s0THD29Tgb9NPdgjzPCkubnuUv+soDaoilO3ydv2ckusBLUAMg1CmQg2KdMidKg
	MxrmVuMCEnay597msCLNOY8rYdN4pqIhGBstf1YhJ1Gusg+2E2okpLjTkaSX5VwiyyW+4r78TO8
	3p/hFb+GQNgnx13foVp4ptMplFzyndr3R0okLjv+t7SLk+xJ1inKiAk8sdcZLjBMgqGnguzhQ3z
	p5y4xaKTnv+Px2Ffg9X0N6f3/LHAG8c7OjN0Kbi4bRXeYkyc+78cTavJPCRdSDRcEW+RzIPVdIx
	C5VXVqHSOLc/w0
X-Google-Smtp-Source: AGHT+IHwklT+fSAdTS6FhgXRWj9vGB2ajsTuhU7iPf3ZuTDe1HF6NP47ittL43ZGlAOFk7Zre3gEqA==
X-Received: by 2002:a05:6830:4129:b0:7c7:162:e0c7 with SMTP id 46e09a7af769-7c7442db71dmr128771a34.6.1763052375233;
        Thu, 13 Nov 2025 08:46:15 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:5::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c73a283a44sm1515045a34.2.2025.11.13.08.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:46:14 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 13 Nov 2025 08:46:04 -0800
Subject: [PATCH 2/2] mlx5: extract GRXRINGS from .get_rxnfc
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-mlx_grxrings-v1-2-0017f2af7dd0@debian.org>
References: <20251113-mlx_grxrings-v1-0-0017f2af7dd0@debian.org>
In-Reply-To: <20251113-mlx_grxrings-v1-0-0017f2af7dd0@debian.org>
To: Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
 Leon Romanovsky <leon@kernel.org>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4074; i=leitao@debian.org;
 h=from:subject:message-id; bh=poQ2ltGXAGj/R6azLC8+vFrV6fsBn4x8KuYNyoxOTxE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpFgtUh28966CZumXyyIbtdUKCDXVJ8AGRMjLUp
 wrz5B/DxWmJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaRYLVAAKCRA1o5Of/Hh3
 bdFbD/982JwpeO4nF2jB9yp61nX7YvYeLYMRBYZfid29jOZd2WDNUdzO9NVNTaIVbKOZBn5xA1K
 waiTW2l04raQU0qsjerdzgOWGHtn1q9rYnu6WUN5vkXkocZCBfjfFYv9Cuf9UaEHU2NWgWBlbO3
 UQatrdWD3FJmrx8ziHaw5u2Z4rYmrhmk8RVLh7SSAbU2zVatHBuMcyd35GMgduFkavNNMk4wMLS
 6txW1fGu2VBmEhNbQEJJou+zK7K6jisiFpBqd3jS6k2VRyjCwFoJ+X8zhrQMgwB9YP85IiXTlWH
 JUCpk/ugnrlTbq58FjFjyUAv8AW+c/EB6e1HGLJWWT22MJtt5dmUkG/6rVDAT0vpRtPkYgt1wxG
 L+KtiYVC1kkCJpFlPWKpHCLNkzk+TShPOmo7kNjdUeVKpbDKX7Cw71m5PG8Xd1Eqa42n8Jfz1qG
 4xTq6TRVw30lZO7oF2ZyHkQHmM8xfVh0pxq/cYgrBQvdWAuMyIMpkrxvhKF3yenZly5Juq5+QH6
 Dn6pZhTcLMRZRfGja6Z5K7I435aXUUlb7TH1h/W4DdN4fmkzMM/LOlIR19/JcSjiQE8SnWkzJnh
 bbQDhhKDvL0w67oZG7T8g7VHZ3QtpsJNXvIyuPMp7k36nRXsbHMiw/qU1N2NoALz4N6xYXxvuHE
 j/fVWMcO1UlhFrw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Commit 84eaf4359c36 ("net: ethtool: add get_rx_ring_count callback to
optimize RX ring queries") added specific support for GRXRINGS callback,
simplifying .get_rxnfc.

Remove the handling of GRXRINGS in .get_rxnfc() by moving it to the new
.get_rx_ring_count() for both the mlx5 ethernet and IPoIB drivers.

The ETHTOOL_GRXRINGS handling was previously kept in .get_rxnfc() to
support "ethtool -x" when CONFIG_MLX5_EN_RXNFC=n. With the new
dedicated .get_rx_ring_count() callback, this is no longer necessary.

This simplifies the RX ring count retrieval and aligns mlx5 with the new
ethtool API for querying RX ring parameters.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c   | 18 ++++++++----------
 .../net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c    | 18 ++++++++----------
 2 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 01b8f05a23db..939e274779b3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -2492,21 +2492,18 @@ static int mlx5e_set_rxfh_fields(struct net_device *dev,
 	return mlx5e_ethtool_set_rxfh_fields(priv, cmd, extack);
 }
 
+static u32 mlx5e_get_rx_ring_count(struct net_device *dev)
+{
+	struct mlx5e_priv *priv = netdev_priv(dev);
+
+	return priv->channels.params.num_channels;
+}
+
 static int mlx5e_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info,
 			   u32 *rule_locs)
 {
 	struct mlx5e_priv *priv = netdev_priv(dev);
 
-	/* ETHTOOL_GRXRINGS is needed by ethtool -x which is not part
-	 * of rxnfc. We keep this logic out of mlx5e_ethtool_get_rxnfc,
-	 * to avoid breaking "ethtool -x" when mlx5e_ethtool_get_rxnfc
-	 * is compiled out via CONFIG_MLX5_EN_RXNFC=n.
-	 */
-	if (info->cmd == ETHTOOL_GRXRINGS) {
-		info->data = priv->channels.params.num_channels;
-		return 0;
-	}
-
 	return mlx5e_ethtool_get_rxnfc(priv, info, rule_locs);
 }
 
@@ -2766,6 +2763,7 @@ const struct ethtool_ops mlx5e_ethtool_ops = {
 	.remove_rxfh_context	= mlx5e_remove_rxfh_context,
 	.get_rxnfc         = mlx5e_get_rxnfc,
 	.set_rxnfc         = mlx5e_set_rxnfc,
+	.get_rx_ring_count = mlx5e_get_rx_ring_count,
 	.get_tunable       = mlx5e_get_tunable,
 	.set_tunable       = mlx5e_set_tunable,
 	.get_pause_stats   = mlx5e_get_pause_stats,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c
index 4b3430ac3905..3b2f54ca30a8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c
@@ -266,21 +266,18 @@ static int mlx5i_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
 	return mlx5e_ethtool_set_rxnfc(priv, cmd);
 }
 
+static u32 mlx5i_get_rx_ring_count(struct net_device *dev)
+{
+	struct mlx5e_priv *priv = mlx5i_epriv(dev);
+
+	return priv->channels.params.num_channels;
+}
+
 static int mlx5i_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info,
 			   u32 *rule_locs)
 {
 	struct mlx5e_priv *priv = mlx5i_epriv(dev);
 
-	/* ETHTOOL_GRXRINGS is needed by ethtool -x which is not part
-	 * of rxnfc. We keep this logic out of mlx5e_ethtool_get_rxnfc,
-	 * to avoid breaking "ethtool -x" when mlx5e_ethtool_get_rxnfc
-	 * is compiled out via CONFIG_MLX5_EN_RXNFC=n.
-	 */
-	if (info->cmd == ETHTOOL_GRXRINGS) {
-		info->data = priv->channels.params.num_channels;
-		return 0;
-	}
-
 	return mlx5e_ethtool_get_rxnfc(priv, info, rule_locs);
 }
 
@@ -304,6 +301,7 @@ const struct ethtool_ops mlx5i_ethtool_ops = {
 	.set_rxfh_fields    = mlx5i_set_rxfh_fields,
 	.get_rxnfc          = mlx5i_get_rxnfc,
 	.set_rxnfc          = mlx5i_set_rxnfc,
+	.get_rx_ring_count  = mlx5i_get_rx_ring_count,
 	.get_link_ksettings = mlx5i_get_link_ksettings,
 	.get_link           = ethtool_op_get_link,
 };

-- 
2.47.3


