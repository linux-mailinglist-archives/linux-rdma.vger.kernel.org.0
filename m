Return-Path: <linux-rdma+bounces-10059-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DC1AAB494
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 07:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55FDC1C05543
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 05:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C049947D4C9;
	Tue,  6 May 2025 00:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ur4Hk6/B"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B2D2F153C;
	Mon,  5 May 2025 23:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486732; cv=none; b=dbzC9G6p0p03bmAqNb32Aixjm/G/nKo949aqbzIt6Rgh6j6KTWd+z6hYhhDgaMB/NMS6tX1KnpzxJjccY4x44nJ51Yf8uJbcdIZculJ8rGlAV6S28CRCp08ED/uUPAk1RIy1jUcUOM6iGbBrbH0HPWNdZts3ryv4lO0N4VORdyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486732; c=relaxed/simple;
	bh=rNRQtODZcnpVBIPGRz8IF6cUXjg8GEwei8Nmbe8MrKE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d5HuUZgyJsPyNNGUIXxUpBi2uRObxXwoSr1t+UzYtZHVxiP7J1IyALkJFCOkYq1am9WFbSVTuABPFp+4FKpi8jZ5ZjYq8kfBN/uGTHCmTvoY4cEkSTR2tfPrr0hr/ohgKMIfqCrA7Pq73GspyRuq9udtexgk2FHnGlNDiuQWIZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ur4Hk6/B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17979C4CEEF;
	Mon,  5 May 2025 23:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486732;
	bh=rNRQtODZcnpVBIPGRz8IF6cUXjg8GEwei8Nmbe8MrKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ur4Hk6/BOJDIgymgvsjD/tBMJiCRkO9aIqYEoamWCGAxo6FA96TESPV5Jbc51NQ6w
	 XPqgUl44nC3T1TD7az2Yf2iQHUnZauTvydNgaG1y9AAs4g6DFXh2555+j5Bp5wn6lE
	 uECx24g90FzQcTvgsV20mW0tsuk6wWhlsESIKMLh5BLgQpbOl0SYRiiTncnVR/uHOE
	 Cm7Fss1KEDAzZnRPII/06KofAzjrdsWb7K+BX/xkm7ggpBbPr0XccPHbrxWs9IRva2
	 08pI8+YlhypK7hVheGrXbsugb66da4d/qNuErILPKxFBTMYsghQYvwX2rlOqjLjoQB
	 Np2u8KQRA77Pw==
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
Subject: [PATCH AUTOSEL 6.1 174/212] net/mlx5: Extend Ethtool loopback selftest to support non-linear SKB
Date: Mon,  5 May 2025 19:05:46 -0400
Message-Id: <20250505230624.2692522-174-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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


