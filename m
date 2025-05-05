Return-Path: <linux-rdma+bounces-10063-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A66AAAB533
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 07:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B20716D1DF
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 05:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8035A3A8848;
	Tue,  6 May 2025 00:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9MYIkFK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135752E688B;
	Mon,  5 May 2025 23:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487044; cv=none; b=R0tWpSo1RCZbpWQN8f5voUy0wZSfleSQhSv461OgmBuL6SJO6Bpf2YcVrPpXJFY3yys+N9S6VhuoN7/X1rQY54XUgxC0M7rHUNcxeXZw+0tder/HMFs6xq7cZyDx7a6xkK9NvC7E7hUrcj/z5OyyK+1kdjx26Obk1co0M7MmHR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487044; c=relaxed/simple;
	bh=EDmeW1Odctp79+4oJ8K+oDAGd4UCmE1KWx5Rr2il8sM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pxl4y9MNApIW39j2gzPYd6CiBXHYXV6oBibKKSuifEBNafrJGtIzuyGukdvoD7TTExhqqVYl6gQQiASirQ+vUMBeLTRQ5b4y9KTVr5Oz/c/uamLLhbtfKXjAl+aSrDrJLAnGtR0TbZdp8OiGIr4HPUHxSUi8/s4TBPotFUB3YXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i9MYIkFK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F2EC4CEF1;
	Mon,  5 May 2025 23:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487042;
	bh=EDmeW1Odctp79+4oJ8K+oDAGd4UCmE1KWx5Rr2il8sM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i9MYIkFKPFxiQAOtLyIZsBfwfpS1FOizp6+eBsuxJwBzcDMCbGKXWVkspueNn0SuI
	 qU8g6qrTHHmE6br0/PcuD09gxABxKvUDmm4+HcYA3vpB8KWDaZUh9rK4HP+2ALOJ+K
	 +0EfRRx+q3NW67xdiRetr81iS9fZRBNqSnSzrGY6GTO4y/5PEHbNsGvYx1EvMrYc8o
	 40M5R+gi6T7513lj9t+oo8x2H8rwvVSdTIVTBm5MrCbDXNyyGpJzN2RZV39L0h/Di9
	 U8YjzgQCvY1l5xPQcqk8hkXnhcKKWqpmBhPn2Ob1lBxKlY0v+CD/CyGowFFfJu9wd7
	 YXoBBptGRgikw==
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
Subject: [PATCH AUTOSEL 5.15 123/153] net/mlx5: Extend Ethtool loopback selftest to support non-linear SKB
Date: Mon,  5 May 2025 19:12:50 -0400
Message-Id: <20250505231320.2695319-123-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
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
index ce8ab1f018769..c380340b81665 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c
@@ -188,6 +188,9 @@ mlx5e_test_loopback_validate(struct sk_buff *skb,
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


