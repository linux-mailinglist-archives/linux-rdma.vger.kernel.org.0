Return-Path: <linux-rdma+bounces-10951-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65475ACD4B0
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 03:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8133817B231
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 01:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B273027CCDA;
	Wed,  4 Jun 2025 01:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQLQwk8A"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8A919E971;
	Wed,  4 Jun 2025 01:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748999250; cv=none; b=BANzXqiIimLGUtpHhWFKfN+UvKEHd21HfOqH4ffRL1aOh52OnFf0a+24zXnBloUxhdFFfm2IpnhwP2x7vOwf75nKMdSyFHMRgcpfp0QZsUc/PLmoJ6I5wgKY1q9zLJxkfS37FJNwdBajxpJmYvUn45xltJblMs2eR3tNS1Ife1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748999250; c=relaxed/simple;
	bh=P+A5NfgO9BFaz1yef9hYcl6zxLNgtEW8OmZXQzCd8OA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BA+OBVHK83Sy11gotulhrn/lcCqNkPO/VY1FitetQTA4hOrYGCmixU0okrZ8d3/lg+/c/hUSPN4wMptWGoc3PI0R84XXH++/ZAhm7o8Xca4SxO2YHeVHyZqT3dtNySB+n27EKUqtYrhLalEmefxrJME2G3jdEZWIsNq8PY+5a7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQLQwk8A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57AA7C4CEF1;
	Wed,  4 Jun 2025 01:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748999250;
	bh=P+A5NfgO9BFaz1yef9hYcl6zxLNgtEW8OmZXQzCd8OA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HQLQwk8AWz48TBxyswRwv9nsjRDG+MeKhAatsKn27LTl08EOT9K/5unDuW4LBzbGQ
	 qM+BvDFaRjKH72LfWR7/X1a/00aKuMCnj91gn+SdIM/c3UZQICrR+vrKaIQe5Ydxvd
	 0HlSqYYSJec4BjPT9m8K79R6GWuCshTPWh589ibyjpvLhy0IlPKmROn06o+Sk93H0c
	 JH18z6buQDg4/wFVFM1mqyAoqunAT/QR8jUzDb3PFKXd8ocmmfOLDu6OmjisvFHYu6
	 49rWJKCuEZWYFbgBOfTC8utm+Ovt6yixICOtlcLRqo/14UV4RH17eorWMrRpCTme08
	 JjlEJ1YutzrJQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 14/20] net: mlx4: add SOF_TIMESTAMPING_TX_SOFTWARE flag when getting ts info
Date: Tue,  3 Jun 2025 21:07:00 -0400
Message-Id: <20250604010706.7395-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250604010706.7395-1-sashal@kernel.org>
References: <20250604010706.7395-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.293
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

[ Upstream commit b86bcfee30576b752302c55693fff97242b35dfd ]

As mlx4 has implemented skb_tx_timestamp() in mlx4_en_xmit(), the
SOFTWARE flag is surely needed when users are trying to get timestamp
information.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Link: https://patch.msgid.link/20250510093442.79711-1-kerneljasonxing@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

Perfect! Now I can see that `skb_tx_timestamp(skb)` is called in the
`mlx4_en_xmit()` function, which is the main transmit function. This
confirms that the mlx4 driver does implement software timestamping. Now
let me compare this to the similar commits to see the pattern: **YES**
This commit should be backported to stable kernel trees. **Extensive
Explanation:** This commit addresses a clear inconsistency bug where the
mlx4 driver implements software timestamping functionality but fails to
advertise this capability to userspace through the ethtool timestamping
info interface. **Analysis of the fix:** 1. **The Problem**: The mlx4
driver calls `skb_tx_timestamp(skb)` in `mlx4_en_xmit()` at line 1091 of
`/drivers/net/ethernet/mellanox/mlx4/en_tx.c`, which means it properly
implements software TX timestamping. However, in
`mlx4_en_get_ts_info()`, it only advertises hardware timestamping
capabilities (`SOF_TIMESTAMPING_TX_HARDWARE`,
`SOF_TIMESTAMPING_RX_HARDWARE`, `SOF_TIMESTAMPING_RAW_HARDWARE`) but
omits the `SOF_TIMESTAMPING_TX_SOFTWARE` flag. 2. **The Fix**: The
change adds a single line `SOF_TIMESTAMPING_TX_SOFTWARE |` to the
`info->so_timestamping` field when hardware timestamping is supported,
correctly advertising both hardware and software timestamping
capabilities. 3. **Impact**: This is a user-facing API correctness
issue. Applications checking timestamping capabilities via ethtool would
incorrectly believe software timestamping is not supported, even though
the driver implements it. **Comparison with similar commits:** -
**Similar Commit #1 (YES)**: Also fixed a timestamping bug in mlx4,
showing these are important fixes - **Similar Commit #3 (YES)**: Fixed
incorrect timestamping capability reporting in mlx5 by removing false
software timestamping indication - **Similar Commit #5 (YES)**: Fixed
timestamping capabilities reporting using wrong BIT() macro in mlx5 The
pattern shows that timestamping capability reporting bugs are
consistently considered backport-worthy because they affect user-visible
API behavior. **Backport Criteria Assessment:** ✅ **Fixes a user-
affecting bug**: Applications cannot detect software timestamping
support ✅ **Small, contained change**: Single line addition with no
functional logic changes ✅ **No architectural changes**: Only fixes
capability reporting ✅ **Low regression risk**: Only adds a missing
flag, doesn't change driver behavior ✅ **Clear side effects**: None
beyond correctly advertising existing functionality ✅ **Follows stable
rules**: Important API correctness fix with minimal risk The fix is
identical in nature to Similar Commit #3 (marked YES) but in reverse -
where mlx5 removed false software timestamping advertisement, this adds
the missing software timestamping advertisement for mlx4 where it's
actually implemented.

 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
index b711148a9d503..9dbdd6266f731 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
@@ -1889,6 +1889,7 @@ static int mlx4_en_get_ts_info(struct net_device *dev,
 	if (mdev->dev->caps.flags2 & MLX4_DEV_CAP_FLAG2_TS) {
 		info->so_timestamping |=
 			SOF_TIMESTAMPING_TX_HARDWARE |
+			SOF_TIMESTAMPING_TX_SOFTWARE |
 			SOF_TIMESTAMPING_RX_HARDWARE |
 			SOF_TIMESTAMPING_RAW_HARDWARE;
 
-- 
2.39.5


