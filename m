Return-Path: <linux-rdma+bounces-14469-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8DEC58FA4
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Nov 2025 18:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA4C7426FAA
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Nov 2025 16:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6391935A140;
	Thu, 13 Nov 2025 16:46:17 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F291359F9D
	for <linux-rdma@vger.kernel.org>; Thu, 13 Nov 2025 16:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052377; cv=none; b=uZKl25kHHTjZs63LNMLiE8Qm0fGf21RswS4IJNMP1wabgPdDkrEGUhCZa7ap6umLugMHVm3G8dKLGlSXerWgSJ/sQGoe9XkaJLWwiS4j7UJxLRY+ZLbIj7W1yFl5Zp79Bz0e/BbNwVDcX6DrNecHinmAz3w+hm4UJcsdXsVGT5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052377; c=relaxed/simple;
	bh=RJ6nsg4wuWJH6h/QyKbbPd0OvBVyOjvlKFeZqEdONLY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l7JayfxkJ9VbLmVBaUhfeyCWasEOHZHeG+CGN3badNIzXkFyzQnBeTPbmsWWnVF0VNLO3NeyDnsZfOFapLmbUc/ka52vViNhQSWBTeusrudII+Fb0djXBpZKLNZiV4mxUeX1B7nbA0viqbWJKevLx7IFOx9UPrrad8GKIZhSTpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7c6d13986f8so735097a34.0
        for <linux-rdma@vger.kernel.org>; Thu, 13 Nov 2025 08:46:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763052374; x=1763657174;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OBN2WZm/+dOU7IJxKWOSEg+NlxGX9+nctR5VlBcbo74=;
        b=qJh5c1WgPFPJorTYO9Y71MIvCdiUykFi9D3XVA1bWSixYLlbwEIgClJRfNc3Gi4wss
         jUg3dXB1j/cajS551Ngnja0q+2NxaK49yKLR1qJZ50nZj20vNkY6RIKC4fI1gLJKaB4H
         QVRGUWsY3/EyvkiPe6O26Hb9DpTOJKmXMQKPpCjetwWHxMr6LNnt2y2+pBaopK1YKkQc
         FzvZHN+37Gbgt1kIQiOS8t9zSxjmS4lpdkeyuIGoIAwKbvDqyQFR4+LW7zaIBjYIpou4
         bcecWNUIiFK9bq1EmWUG+KZbSHN5775L6KsIGEyCm+Jim7Vy4eomdcglBUrnsJpyZiH3
         ewKw==
X-Forwarded-Encrypted: i=1; AJvYcCXA4zEQzeItV2j0U5EdT0ie7+UUYXABEyDeBR8G0V+Jb+28evTumg6cARFLFR80hgw4PVNkeIxtPEWN@vger.kernel.org
X-Gm-Message-State: AOJu0YzXYWAb4SzlKErtBOi/LIbK46wcsOlMUlAkW0jK5QD/kVTRSEd6
	sucuV0ul+wad9vXAZrE/qcL2GFzcK91ZuiCKTOz5XRP5862TMer33s+oCPcD1A==
X-Gm-Gg: ASbGncs/4fOwABZnLUOLan4JLYfVfQfXtDzQi5ySl03yLEifkI8APGpVYctzSEGTw4t
	qK91QpXDYl5wr3W8p8Gy4MjaSUgYII5Tj/liLAFjmVvxC3LgvZTs5Cj5nNEFa5TLNUnMzVT9nmx
	gIahuhGcIsocyshbF1kdCv83xOD5N+sVcWcuIqokZFUOyhYjOX/TWbqucB1SeCUgeis12prw9Vr
	B3g1eZ9r8+m75w2Q0BYd0XGN9b5uub/fMeCtqO7C9CsjNkY7+eEdLyCAdw1ss10p9YQ0TL7cWz6
	d4NfKsCE78+wyqvu+nJ2/q8EbBly8ij6VsYa0Q7k1LQFBU4LdwT4FYD3mBcL50FVyc5kT+pfpkn
	xtN8PeOgbJmfgTFiolm5H3M6BlbAB4dTBZEtHg1urwPJsqMAFVa8fMJXyAfPHUfkG+6fQYLCR1h
	thJfc=
X-Google-Smtp-Source: AGHT+IEPG52Tne7U0YrRACo1Z+TeE3WGnQbb/AUFnv2POhqkyIWHi24LZi3+2U8QJIzPuCpVZmi3Iw==
X-Received: by 2002:a9d:6163:0:b0:7c7:e3b:4860 with SMTP id 46e09a7af769-7c743dbe729mr151477a34.10.1763052374092;
        Thu, 13 Nov 2025 08:46:14 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:53::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c73a283b3asm1512345a34.4.2025.11.13.08.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:46:13 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 13 Nov 2025 08:46:03 -0800
Subject: [PATCH 1/2] mlx4: extract GRXRINGS from .get_rxnfc
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-mlx_grxrings-v1-1-0017f2af7dd0@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1920; i=leitao@debian.org;
 h=from:subject:message-id; bh=RJ6nsg4wuWJH6h/QyKbbPd0OvBVyOjvlKFeZqEdONLY=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpFgtU20ui1SM7ldzsOfYh0RKNbAMgtZmV2SUFc
 AuLbQXyFFqJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaRYLVAAKCRA1o5Of/Hh3
 bdjtEAClpuKcPUAu9a1yuZm7LxJseq0LrfszVEFz8iGSZM0uPe/VHHXL3T9x/Wg6n3VG7FgfDM/
 RL3oxzVzdv+n2zTIrfY25r9T2axgewm0F8qDO1stjDHRpG5+xlmDg7Z+AD7S4VftN9AFGIec5PD
 lS7yXl9ozqtU+o83TOFPpGnybbz9Y/5dw8Joc1Un40poXxyx1EDNLMkr7Ip8cQJYehbJXOf2HA+
 nGCo5xAhU3ruHZGibwzrGOrj97+kIRdN5n5wwoElVffIWonsAEZiICbNhbKvPUVYlRvIrVuReUY
 BWBB8+5txOqJbVkbalRahMGz8IIvjFwTuTi9Uwh5IpN+8RoJRo7VA9F24jvGYNF0jJyNUg24lU6
 kjyW+SP05peWwELwiywdWRpSdNR4oV600iqZdiDJp3ap2jovORUw7+hnO2spkMUnRr46Qk72Zfh
 PVzcS5Vw4Qw9z4mkm7hdHo2TqpX5BaGbSxmkgEdyl5qseRHMfFeVkzCpH+W3WwqgIc3BLnWG187
 nDItNBYB/guoxTmU9uocKOi4q91hhyJtSU57FxXjwWUMKe3BZ9eF4MilsWhp7JZg7ieYIXu4wT9
 zuxFNSNGyNboZFsNl9badt/3I5nNakhMaTENvDSoX2Wzhp8evyH8WGBYX6zF61wr6bjhYBGAsLy
 MV2bfl3+4A1bb+Q==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Commit 84eaf4359c36 ("net: ethtool: add get_rx_ring_count callback to
optimize RX ring queries") added specific support for GRXRINGS callback,
simplifying .get_rxnfc.

Remove the handling of GRXRINGS in .get_rxnfc() by moving it to the new
.get_rx_ring_count().

This simplifies the RX ring count retrieval and aligns mlx4 with the new
ethtool API for querying RX ring parameters. This is compiled tested
only.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
index a68cd3f0304c..ad6298456639 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
@@ -1727,6 +1727,13 @@ static int mlx4_en_get_num_flows(struct mlx4_en_priv *priv)
 
 }
 
+static u32 mlx4_en_get_rx_ring_count(struct net_device *dev)
+{
+	struct mlx4_en_priv *priv = netdev_priv(dev);
+
+	return priv->rx_ring_num;
+}
+
 static int mlx4_en_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
 			     u32 *rule_locs)
 {
@@ -1743,9 +1750,6 @@ static int mlx4_en_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
 		return -EINVAL;
 
 	switch (cmd->cmd) {
-	case ETHTOOL_GRXRINGS:
-		cmd->data = priv->rx_ring_num;
-		break;
 	case ETHTOOL_GRXCLSRLCNT:
 		cmd->rule_cnt = mlx4_en_get_num_flows(priv);
 		break;
@@ -2154,6 +2158,7 @@ const struct ethtool_ops mlx4_en_ethtool_ops = {
 	.set_ringparam = mlx4_en_set_ringparam,
 	.get_rxnfc = mlx4_en_get_rxnfc,
 	.set_rxnfc = mlx4_en_set_rxnfc,
+	.get_rx_ring_count = mlx4_en_get_rx_ring_count,
 	.get_rxfh_indir_size = mlx4_en_get_rxfh_indir_size,
 	.get_rxfh_key_size = mlx4_en_get_rxfh_key_size,
 	.get_rxfh = mlx4_en_get_rxfh,

-- 
2.47.3


