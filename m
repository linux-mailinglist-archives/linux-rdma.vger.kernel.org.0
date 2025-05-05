Return-Path: <linux-rdma+bounces-10013-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C908AAAB31
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 03:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB64E4A5170
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 01:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E513AE5EF;
	Mon,  5 May 2025 23:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vbkc9Ve2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B31439527F;
	Mon,  5 May 2025 23:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486271; cv=none; b=jDKFBOHcxXP5bDfHujTT+Momm1i9VwPML32/5V8mgKMISbSAqTlV7Nkyx6Ip2U3VPnPwa+DXq21aoRSOYsM4iy6HvnKAYD15XrekLR80UJy9TlbHfkOM1yMeYswFlc4bWWOeHInv3/vdHkdxAOj15Fs91+TAyW3yS+0hqXuhDfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486271; c=relaxed/simple;
	bh=rNRQtODZcnpVBIPGRz8IF6cUXjg8GEwei8Nmbe8MrKE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GYd5m9wctK5U+tbc/phSdZtKe5l5nHmlSzjui6XvxqNMt8mWM1A8gP9ays3eUDgfHJPcURrVLHF99Lrbq+bpep/p8sefoJvJ0CVpD+KoQVIJVr72bJ7OVJ00pwUmN7SmOtnY4BvUMNrk5xfqAKJuAK1oN91LWwJQe313QjUDA0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vbkc9Ve2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29549C4CEE4;
	Mon,  5 May 2025 23:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486270;
	bh=rNRQtODZcnpVBIPGRz8IF6cUXjg8GEwei8Nmbe8MrKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vbkc9Ve2WFxcfg5sdFgkMjbOX5xyraOabkI6K/VGB6DGy7H3oSyZ5D+r8JnZyPjvl
	 vt4hPyPdUPSH/+NgzAdbZHg+jbtBPl0fnjcdsg6+kM9QDUd3p4HlOSyYoMELXfAhJV
	 C3Q6OGZqNlL0Eyc+RfmkplOqolmFsIqehLGG3zjQ/ryBs1F3IO/9tvMOGmxK2aW+o9
	 sAM/6w5aDA+2mjs3jcLyR1a4G1AJFPv3mx3jhg9n7s6TF3M3/FM6Bk0WD2RPJNf8/O
	 zkSj2mCkkFa/8B+eXMPCDXHWhqqzzrt1dt7+pM3Cc37q7g2UgEUQcri4HbqRxzy1A7
	 0VhLX1lDwOhyw==
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
Subject: [PATCH AUTOSEL 6.6 232/294] net/mlx5: Extend Ethtool loopback selftest to support non-linear SKB
Date: Mon,  5 May 2025 18:55:32 -0400
Message-Id: <20250505225634.2688578-232-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index 08a75654f5f18..c170503b3aace 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c
@@ -165,6 +165,9 @@ mlx5e_test_loopback_validate(struct sk_buff *skb,
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


