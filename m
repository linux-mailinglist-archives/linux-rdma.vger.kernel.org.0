Return-Path: <linux-rdma+bounces-15440-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A52D10CB4
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 08:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27221306325E
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 07:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42458329C6B;
	Mon, 12 Jan 2026 07:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b="yznaF+Ow"
X-Original-To: linux-rdma@vger.kernel.org
Received: from www5210.sakura.ne.jp (www5210.sakura.ne.jp [133.167.8.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B031B32936C;
	Mon, 12 Jan 2026 07:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=133.167.8.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768201469; cv=none; b=k7a/7HLaGKuANJ6aj18o0Gz6VJ12HY6C4VahTHNC4l+wCOrvJa3Q/yMDnIB0v4EZ/OsEeh6oryQZBmFDiWaxS5rXEQ8iIMAWKgs/lQSa+eTgShhm1NB+l92YAI+FOl1EWvCbsK/PrVCqNELbiwLCUVbBtZBGpUb8MsYCatjifjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768201469; c=relaxed/simple;
	bh=hCr4R7FJMixHrYq3VY2HAPNsiPKBT6YSXy9HwKnpeSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uodm4absAKdGmAxj54B6zuWclyLMU8yt1NSNkXHxwGHeTkJVplnK/OQ5agHHIGR4I7pdkXtlJA7Whn566w5rkdhzHfpxJXtsOyq9xQzMYnnFmDku06O7Z5h4QC2hS48kP5NQqBC0PZElCUEZtRai8trW7NFN4bIG39oh/PMro7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me; spf=pass smtp.mailfrom=mgml.me; dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b=yznaF+Ow; arc=none smtp.client-ip=133.167.8.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mgml.me
Received: from fedora (p3112209-ipxg00a01tokaisakaetozai.aichi.ocn.ne.jp [114.173.113.209])
	(authenticated bits=0)
	by www5210.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 60C73Ylg068770
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 12 Jan 2026 16:03:56 +0900 (JST)
	(envelope-from k@mgml.me)
DKIM-Signature: a=rsa-sha256; bh=z1FfcsS8aFM38b9vz2I7P8tyxUft0rkTHxvP8AXGVwg=;
        c=relaxed/relaxed; d=mgml.me;
        h=From:To:Subject:Date:Message-ID;
        s=rs20250315; t=1768201436; v=1;
        b=yznaF+OwPkkOaVZ1I3/3Iw4bsG/bOT4V79xywgby9KLV/OYkYojNEwuXSoshoqP/
         e/lBB5FIpdEW1LXMaAj9H4US89Ao5qwj+wnbZk4f87FpqsZt0ZYRu59oZ1Jbhiwm
         osotyQ/U4yyzfVHrpQgWsMIwAMHHL/NI3y/aJBqq++6vVobDPP7uoXiyxkpn0hIk
         gqEOd/2rP/drxm+SxlIiXktB1hEm0o9VtQ5jhhCO/nKj+yhzKuz0cV+EyOrRNQZK
         rGZ8vCGk8cpB5GUw4GJuljab39GThPqMENHJApJdL+ECuj7o66+zbZBcFSML/+ij
         HQOtZgnDfm3uJRNN1YJj4Q==
From: Kenta Akagi <k@mgml.me>
To: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
        Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kenta Akagi <k@mgml.me>
Subject: [PATCH RFC mlx5-next 1/1] net/mlx5e: Expose physical received bits counters to ethtool
Date: Mon, 12 Jan 2026 16:03:24 +0900
Message-ID: <20260112070324.38819-2-k@mgml.me>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260112070324.38819-1-k@mgml.me>
References: <20260112070324.38819-1-k@mgml.me>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rx_bits_phy is documented but not shown in ethtool --statistics.
Make this value available via ethtool.

rx_bits_phy is needed to calculate the Bit Error Ratio from
rx_pcs_symbol_err_phy or rx_corrected_bits_phy. The existing
rx_bytes_phy cannot be used for this calculation as it appears to be a
counter above the PHY layer in the strict sense (i.e. traffic based).

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


