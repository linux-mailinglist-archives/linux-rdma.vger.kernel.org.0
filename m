Return-Path: <linux-rdma+bounces-15318-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F28ECF6F42
	for <lists+linux-rdma@lfdr.de>; Tue, 06 Jan 2026 08:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89A9B301B832
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Jan 2026 07:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDBC3093C7;
	Tue,  6 Jan 2026 07:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b="gO3zELgT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from www5210.sakura.ne.jp (www5210.sakura.ne.jp [133.167.8.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAD73090E0;
	Tue,  6 Jan 2026 07:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=133.167.8.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767682997; cv=none; b=OxNYKVfWk5CsKBBh58CU32j/3+GrU7s5PTavbaiF09FQSRFyRrVoAowUGIirbSQvMT8z7dh1tBojGCx3Jvz6w8R5fEWqhm4Nr8TVE+3KK7BtDmaTOmkRL1RTbI51x9XsSq3olp922TZE+9rpP61PpcQE4z+1354L+nuqYQo0xek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767682997; c=relaxed/simple;
	bh=uXiBJtsX0svQmePqiCn8rWdMoN1ClmUNN3b8dWA4RKk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dlE7rYDz2k/ohewzP3V8E5XbGPllb2DNxI8+XJOqUu/iwYaWhLNYu7jEIDa2uY1Owe8+Viv/Tct8VFBuF+pVjMmhGrMWpR1cuzR44ktN27WlEV0NcnZEx0SknasI3mK4s6Vsp78ST9lFnB6By+rIwvHHYssRahfzP+igC8YfSLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me; spf=pass smtp.mailfrom=mgml.me; dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b=gO3zELgT; arc=none smtp.client-ip=133.167.8.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mgml.me
Received: from fedora (p4548043-ipxg00s01tokaisakaetozai.aichi.ocn.ne.jp [153.219.109.43])
	(authenticated bits=0)
	by www5210.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 60672QsI034247
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 6 Jan 2026 16:02:42 +0900 (JST)
	(envelope-from k@mgml.me)
DKIM-Signature: a=rsa-sha256; bh=KGA45rKZ0slnQFj06I4+4i25YQo4RQUItYgH6ErbTlI=;
        c=relaxed/relaxed; d=mgml.me;
        h=From:To:Subject:Date:Message-ID;
        s=rs20250315; t=1767682962; v=1;
        b=gO3zELgTpDfmQSU9qjMLoJkjDW6G3IDjOYKOrD1GAcpxb6ZMIvHvax0efKrxwBGH
         3pRjXO74U9YZSQ+EPjHLSL2DD4RVKNsFMG4GejnjgWIhWC28364H8GI+4U02VsPV
         z14ToaIm4niakJ5ySfmc73LPzjJWmi9sp3sHsX/FTEUfWeNx225I/27sWKkMOapx
         JH5x2cywrrcwsykbIPVRMP0q3gUaVvmVJex8i6dXk9Tj0u5MLime9sKjCa1MmrWo
         3BAnWrm47Z2eZee6TlpbKZSnyxiL6DOE1VrNzG3PWtuEdayu1ulnihaihQ7IuJOB
         T0QchtwH/EoPQX3ADTGXzw==
From: Kenta Akagi <k@mgml.me>
To: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
        Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kenta Akagi <k@mgml.me>
Subject: [PATCH] net/mlx5e: Expose physical received bits counters to ethtool
Date: Tue,  6 Jan 2026 16:02:10 +0900
Message-ID: <20260106070210.24449-1-k@mgml.me>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rx_bits_phy is documented but not shown in ethtool --statistics.
Make this value available via ethtool.

According to existing documentation, rx_bits_phy is needed to calculate the
error rate from rx_pcs_symbol_err_phy and rx_corrected_bits_phy. The
existing rx_bytes_phy cannot be used for this calculation as it appears
to be a counter above the PHY in the strict sense (i.e. traffic based).

To avoid confusion, it might be better to use a different name (e.g.,
rx_bits_pcs), but for now, I will submit the patch as per the
documentation.

Signed-off-by: Kenta Akagi <k@mgml.me>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index a2802cfc9b98..e167355daad5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -1226,6 +1226,7 @@ static const struct counter_desc pport_phy_layer_cntrs_stats_desc[] = {
 	MLX5_BYTE_OFF(ppcnt_reg, \
 		      counter_set.phys_layer_statistical_cntrs.c##_high)
 static const struct counter_desc pport_phy_statistical_stats_desc[] = {
+	{ "rx_bits_phy", PPORT_PHY_STATISTICAL_OFF(phy_received_bits) },
 	{ "rx_pcs_symbol_err_phy", PPORT_PHY_STATISTICAL_OFF(phy_symbol_errors) },
 	{ "rx_corrected_bits_phy", PPORT_PHY_STATISTICAL_OFF(phy_corrected_bits) },
 };
-- 
2.50.1


