Return-Path: <linux-rdma+bounces-9989-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C22B1AAA44D
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 01:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24A38174530
	for <lists+linux-rdma@lfdr.de>; Mon,  5 May 2025 23:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7470128C2A2;
	Mon,  5 May 2025 22:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nsWQuOy9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B7E2882D3;
	Mon,  5 May 2025 22:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483973; cv=none; b=DaHDorOIyVeVZ/AsrS3Cr5j+Zv1ql6Qh4wAEnsnE39EdfpCp4oIZ3s1A+XcZpdoHDNFItvGkU8qkbPTToZWEwK41guacnyf7u8GTL6HsewR+KoEdix8dlq1NHRX4EPJHrfLRdLdPEWxikWUjmp9MwHA6xPeLktOS8CVccklyNrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483973; c=relaxed/simple;
	bh=VqUtpLEe/mjyl4FHZoKwz7jUI868mLWleMa5ecX/Mpw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WXUiLNpdACCrKO2GKp2dPkrGZIsmm2dvpCY3QINQDhPgzoem3hs/kMegyNEAI2Vom61kV9RseF2FOLZjZES6W3UW45wZA9Essky0mrC7qO/D+IyttsJQqaKKpfQ0mp1ywZmPn2ymBB4o7ABlcfdovTH4bT/F26T1I8Xja+SUYkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nsWQuOy9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06BA4C4CEED;
	Mon,  5 May 2025 22:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483972;
	bh=VqUtpLEe/mjyl4FHZoKwz7jUI868mLWleMa5ecX/Mpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nsWQuOy9JccJzSNrvdSbLE7jQGNgo3JCogBinjaVv+p7S7rsEIJCA0RSkDGk9alsu
	 ehSe41Xupz6nVKlZ47BhVPrq/nyr6DBlsFhter+sTmJTUTwlxYkmxQnGbJSk3erh1k
	 cZRQMOxMTJV1bi0WH9Xoq3GjBPq4v4awQMtO5taX2n1W7RN4YKs9KwA2dfaobl+1Gy
	 ym0Xl3GWFs9POHV0/ElfvSUQAQu/QUYBDjm+mrsuHMrcZURst3y+9KSi8cYRixaZBc
	 UkoxnxhtT84Z5pwJy/BcXG9jkJc6txAimjA/uhgoqSQ1BnzqLM67QIHuGLtdeijvub
	 G0iQ2vWuH+jNw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Moshe Shemesh <moshe@nvidia.com>,
	Shahar Shitrit <shshitrit@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	saeedm@nvidia.com,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 299/642] net/mlx5: Avoid report two health errors on same syndrome
Date: Mon,  5 May 2025 18:08:35 -0400
Message-Id: <20250505221419.2672473-299-sashal@kernel.org>
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

From: Moshe Shemesh <moshe@nvidia.com>

[ Upstream commit b5d7b2f04ebcff740f44ef4d295b3401aeb029f4 ]

In case health counter has not increased for few polling intervals, miss
counter will reach max misses threshold and health report will be
triggered for FW health reporter. In case syndrome found on same health
poll another health report will be triggered.

Avoid two health reports on same syndrome by marking this syndrome as
already known.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/health.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/health.c b/drivers/net/ethernet/mellanox/mlx5/core/health.c
index a6329ca2d9bff..52c8035547be5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/health.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/health.c
@@ -799,6 +799,7 @@ static void poll_health(struct timer_list *t)
 	health->prev = count;
 	if (health->miss_counter == MAX_MISSES) {
 		mlx5_core_err(dev, "device's health compromised - reached miss count\n");
+		health->synd = ioread8(&h->synd);
 		print_health_info(dev);
 		queue_work(health->wq, &health->report_work);
 	}
-- 
2.39.5


