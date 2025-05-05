Return-Path: <linux-rdma+bounces-10026-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 172DAAAB022
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 05:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FDCE1A8726D
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 03:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78CB308A62;
	Mon,  5 May 2025 23:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pEEGu1r7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEA12F8DFB;
	Mon,  5 May 2025 23:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487276; cv=none; b=I68uOEl3SB1ZfZM9IziJqWCgCTw6ZZxb2kLi82cTebT0LqngSZApIhMJ2rmIFRt/pkaKnTz4SnsVDg09Q9ZAJRiWUHNvh4xZa3ny8FKwMnzQAOm1Zu/vuPX13pSt+HIhLZe8M+4+03x5OOQqdBvzlUD9MLOK+J2SbVb0qjDwpeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487276; c=relaxed/simple;
	bh=EDmeW1Odctp79+4oJ8K+oDAGd4UCmE1KWx5Rr2il8sM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HsmtujtzABxBX65XmlBssTrjQp+1r/1CwQWhdqNKVoav/bFogvlu/suCB8bv9AveMEmtEcyOsx/R2ktsQ6uI4f8pgHFDlm7Siux9nH+fJe2cBNZFCZvq1l9W3xzyMHruzudjN9x39k5DHXw/fFNtYWUjUbbO6oiJ0PlHOfW9EBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pEEGu1r7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72071C4CEEE;
	Mon,  5 May 2025 23:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487274;
	bh=EDmeW1Odctp79+4oJ8K+oDAGd4UCmE1KWx5Rr2il8sM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pEEGu1r7lposS7MlCRggpbijKMbQEQxaYegedQkhHk8AKHuAkGEvb9UXasxntHj7c
	 BlfSsb/5umHvbLRKZcfnbtZs+ilkwNxFDRSH2xdkSbiOnmFsQm52tkyVYMtPp3Gk9g
	 4SEuiW0UitKXvaAGs2ZEWoKwomVvrfaYZfcof28DQKgBit2e84S5gMYFIIP++7qtwV
	 oAJQJRTkQxv2Hid7YnA2yY+q3rar/+zqDjKQ0cGZYG+/G/uhLfqt7+saknGKs0G0rq
	 DCTs8n/Xsv37PJe6RWz0jzMdo3K8kDFFbsDWvcHKL1LLIn3dOzxq/r0qpUcL7njcUp
	 +9ZtS1E67oZzQ==
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
Subject: [PATCH AUTOSEL 5.10 093/114] net/mlx5: Extend Ethtool loopback selftest to support non-linear SKB
Date: Mon,  5 May 2025 19:17:56 -0400
Message-Id: <20250505231817.2697367-93-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231817.2697367-1-sashal@kernel.org>
References: <20250505231817.2697367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
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


