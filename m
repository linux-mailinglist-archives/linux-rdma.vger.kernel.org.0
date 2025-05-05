Return-Path: <linux-rdma+bounces-9998-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC7FAAA659
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 02:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 283204A0720
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 00:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250F0326078;
	Mon,  5 May 2025 22:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bD41xayW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC35032606D;
	Mon,  5 May 2025 22:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484472; cv=none; b=K+mwMen9Ypjxliy2GjIHrdBdJNZPjS5JUHiDKrfvYU+gGIOoBQm8fMUiav8kREOqrdIF0Pb41DSSqzzDn232Yb9rGSHAJIPzPjVvR5DLxiBJpnGz8Q51JwQn7KawUdkztifSiLfOQP0FSuEpU6dbbThpf6HqHSDPjS2RkMGeKuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484472; c=relaxed/simple;
	bh=EmCvoM54o0Hc3u6jIcjuGXPnlYegD/VTwsBsxC1EqLw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qna2gAxlegIbYICdTLFMDsFi0mb+TLC7HWhNEt8+UKHy83I7xhI4XA15rep1TZgf10Y1wWwHxTUMzqnaYu4gA5Pn85TA53MHVob1xq3aUJg86Tz/JSFe9p4AhAOwMAB6FPWeAHil5wvPDqVrIm+SDkR3v8Cd0qcyXRcdo17PCbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bD41xayW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F445C4CEF2;
	Mon,  5 May 2025 22:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484472;
	bh=EmCvoM54o0Hc3u6jIcjuGXPnlYegD/VTwsBsxC1EqLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bD41xayWImiLPBxzTR0jNjTQAm+I/GGOo0ke3yC+j6jrBd+cCr9PzDHJo+vzVFy2x
	 EgwEGy2soBhOIcuaU83L47YYRDUAhITW00wnScKEAieeGW8W+EDUZIGn5kgCkz6MmF
	 YBzsO+Q+6jZU2G66Pr9cMofiAtOrPVEn4O2F9SRJoU/FCslegu7MjeYaEIe5AdoyXI
	 +kwxmactbT+fJGHsCF5jUYhCJ81bCNXKi+3N65Sizup+pGSIgpwpS5lXGD1ReDAxSF
	 Mi7zk+1CYEPR+dcPt0mDIijtQZWGqLdAZhP0Wy6UeH5hN7ir391MRoZ1vECIpreToT
	 tc2MiNgvphmrQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexei Lazar <alazar@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	saeedm@nvidia.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 487/642] net/mlx5: Extend Ethtool loopback selftest to support non-linear SKB
Date: Mon,  5 May 2025 18:11:43 -0400
Message-Id: <20250505221419.2672473-487-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Alexei Lazar <alazar@nvidia.com>

[ Upstream commit 95b9606b15bb3ce1198d28d2393dd0e1f0a5f3e9 ]

Current loopback test validation ignores non-linear SKB case in
the SKB access, which can lead to failures in scenarios such as
when HW GRO is enabled.
Linearize the SKB so both cases will be handled.

Signed-off-by: Alexei Lazar <alazar@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Link: https://patch.msgid.link/20250209101716.112774-15-tariqt@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c b/drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c
index 1d60465cc2ca4..2f7a543feca62 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c
@@ -166,6 +166,9 @@ mlx5e_test_loopback_validate(struct sk_buff *skb,
 	struct udphdr *udph;
 	struct iphdr *iph;
 
+	if (skb_linearize(skb))
+		goto out;
+
 	/* We are only going to peek, no need to clone the SKB */
 	if (MLX5E_TEST_PKT_SIZE - ETH_HLEN > skb_headlen(skb))
 		goto out;
-- 
2.39.5


