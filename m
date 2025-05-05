Return-Path: <linux-rdma+bounces-10041-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D34BEAAB1F7
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 06:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 306E73A75FE
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 04:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCB841A9B3;
	Tue,  6 May 2025 00:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qiQJvbqH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9582D3F85;
	Mon,  5 May 2025 22:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485601; cv=none; b=RiVnbRDrqxVXDCDhG2re9bx85t414+zuROQN+5Ej1oo/8NN6OMdDL64siPSGB3In229W6tbmorjfE+4s9FVNYsnmHqpGKMuUPX2NLIS7jMdkX0HQqw4Sb5GChYYZX0hohR6ojEqwyMIp6oBNWSatf8YupJ8Zyf43l4u3VrxkhOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485601; c=relaxed/simple;
	bh=EmCvoM54o0Hc3u6jIcjuGXPnlYegD/VTwsBsxC1EqLw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VSNs3ngD9n7wSAYBhhNz/l+XyW+YUhxdq6fANTm/4B6+rKEXVMBYsfxYq0h0KTYRdZI0pzwqwEFNNwUk7ZK+Xf6VZmmPcqTvSIU480Q0oVzugpo7dPgmqH95zfxl1mGUzdbTJ7TiCiZ+EgR5gLF1NszBM5ITFsuWkfshPQ116Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qiQJvbqH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19AE9C4CEEF;
	Mon,  5 May 2025 22:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485600;
	bh=EmCvoM54o0Hc3u6jIcjuGXPnlYegD/VTwsBsxC1EqLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qiQJvbqH3Dvj9I2xQLU+T//pUTofWwhs0MVn5rHk1Syt+oVAH9uwdzOanIB9OcVI6
	 M8Dbo/CN010tZyt+J4MsxjjPgi0UfKrLGQGnwHIpFx5Xv4/FasxfZKCFR1set9XioM
	 FIzyhcuG3vDdcKebuP0UsHW/cYdY3JNVeA0KL2xIsvwN+jo8q1AeKvfMEN4TyC7SuW
	 1xXUS6hIUziqDy8pfBreD4XMg5qTfc4jeVmx59DBo9Z8ttaT7tnFaz5SUYPgThVBSB
	 1X01kIkJVTN/TLLCvdagSwduib3EVP4oNHXXrVktNW9D6yhiflVhDb7Be7zpNnwuXs
	 zET021uPGPWHQ==
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
Subject: [PATCH AUTOSEL 6.12 380/486] net/mlx5: Extend Ethtool loopback selftest to support non-linear SKB
Date: Mon,  5 May 2025 18:37:36 -0400
Message-Id: <20250505223922.2682012-380-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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


