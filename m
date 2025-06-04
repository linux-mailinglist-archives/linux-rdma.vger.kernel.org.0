Return-Path: <linux-rdma+bounces-10947-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F37ACD406
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 03:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 971D5189A5D9
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 01:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2612673A9;
	Wed,  4 Jun 2025 01:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlXgDxDT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E4920B804;
	Wed,  4 Jun 2025 01:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748998987; cv=none; b=H9n1zFjTWi5q9ZQKgRKGYNDq2YnQq5Y8Er8lDrnxJE23zm7VrKZZva604pUWRSwK+oiDjDo1z5UKTG+iDFzjWwPsBOthACIgcAMaF3EWXThH61kVYUb2RnpHekaYB40ewbVJymcUiKbfs0n0oVsyyamH5CyaCb/J4SMr0gxi7ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748998987; c=relaxed/simple;
	bh=08BxaT9ZGJXp3r0UYYVj8yIm9CHhMt71rgBI9Nq5iyM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g9m4pLrVB0whQW6Twq4Y07X+nShteICYyJYnzXGMV0SbIQLqJzd45aAwfnofbqdYMChr5Mpk+18drDA5J/ns0eIitBMWXHNR2MhcwT0IoMQg0Ka2y4PMPgGG7fOuo3ijXV4SfoO/KUZZgaO9RuewF8z/nsgVmPMlobQ6dKVvO6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlXgDxDT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB197C4CEF2;
	Wed,  4 Jun 2025 01:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748998987;
	bh=08BxaT9ZGJXp3r0UYYVj8yIm9CHhMt71rgBI9Nq5iyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jlXgDxDTI7TkHxWsQvEz/h4zVS27eFRMzMR5bXHrym6VADfeRkoBA+sK2WR607kIP
	 VP7qYPIIoQ2du8JkCGQBIX3GlI5Dxkr1ahJKW3wOjvtn7pZEvxwaIvTbjkNoboxbqh
	 XdZo7GnH0zMMSSPdC40EppZ2W1CM+bldNLOB+e5cqQ+6UrKx57heQS/9evPiUKRLPQ
	 98sokrVfZxzPTzuIWT/CBFLOFeNJgfZwwm/xToWQUO5SiVVvuu/TphG2iLi3ZttIRd
	 vJq4qODb6QTn4mU2PB3WzIQJLFFj2jFhaJ4U/tlNK5BZ6eXAA0+TROrJgbPpqaFJG3
	 cEI6swyFamKCQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 30/62] net: mlx4: add SOF_TIMESTAMPING_TX_SOFTWARE flag when getting ts info
Date: Tue,  3 Jun 2025 21:01:41 -0400
Message-Id: <20250604010213.3462-30-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250604010213.3462-1-sashal@kernel.org>
References: <20250604010213.3462-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.92
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
index 164a13272faa2..07dced3c2b1c0 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
@@ -1916,6 +1916,7 @@ static int mlx4_en_get_ts_info(struct net_device *dev,
 	if (mdev->dev->caps.flags2 & MLX4_DEV_CAP_FLAG2_TS) {
 		info->so_timestamping |=
 			SOF_TIMESTAMPING_TX_HARDWARE |
+			SOF_TIMESTAMPING_TX_SOFTWARE |
 			SOF_TIMESTAMPING_RX_HARDWARE |
 			SOF_TIMESTAMPING_RAW_HARDWARE;
 
-- 
2.39.5


