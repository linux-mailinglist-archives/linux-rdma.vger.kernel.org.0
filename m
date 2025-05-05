Return-Path: <linux-rdma+bounces-10053-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C57FEAAB40C
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 06:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5F317B1461
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 04:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AE6474F23;
	Tue,  6 May 2025 00:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WnEbR1i1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2C22EEBDC;
	Mon,  5 May 2025 23:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486605; cv=none; b=JUxD/Bp1ZNe7YkDPOmXCHesj4KkhnWoUIfeCOwJ+o84RTac9hEKYLca9kg49NSAAuYoTlZSzj0ubfM5xbzSKoF42lN8Ne7b1gc1+mG55/2z/Pc82M56mXwO91fXZoBHWQnWpcrVr45VjieS0sATMOf3PwBQS0873JuE5i9OJ+/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486605; c=relaxed/simple;
	bh=ZPRxVU0lKezTbs3m/k602XrKhy1fTRhX9BEl3kW1GfE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pwhoZoQ/CmN0kh+XegbZXAA84aiSaOYo8S/fPIeVecrnRH1YsVS28tN/rLRrnfhCFRg6V+M+wCfd7r6w12rFUkMj/CyqZGoHFgphYDNaj+Km9FLbNYUAKZ5dMIVlge3k9Lxakb8S8k9uPGtgT/kkj583x2bVUb1SGe/yJEMx43o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WnEbR1i1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7599C4CEEF;
	Mon,  5 May 2025 23:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486605;
	bh=ZPRxVU0lKezTbs3m/k602XrKhy1fTRhX9BEl3kW1GfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WnEbR1i1UbKG8IQ/TRwoUZNuHZ4gmY48q/YCK29IQ5/wV6AB2PGBIuDG9gxPh8uSb
	 nEYg9gMNT8BZvy/fdZr48MeGvLDN2kjn8tiZaw4B7x/xTnTfst/QH3HX/38ycO33ou
	 12rZKaDGr6LBVAYYCQ+m4J4uqmzHz8UN8KGFwkbEBjGtkQ/uUiPzFuV95tMAMimotc
	 j6ZIPLgrpvvN9TwXRJ+hhM8Ez48rOG4PaRp1a63GRVpfxXmYor4BKRbXI+Jgra830Q
	 YDJ3DZWq3sp/uZuig1MiB5peOQNmV3h3mX58ksjtp9JdwQCAkKWf/8crkvRSYlp4uQ
	 KtKhoFX3DtyMQ==
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
Subject: [PATCH AUTOSEL 6.1 114/212] net/mlx5: Avoid report two health errors on same syndrome
Date: Mon,  5 May 2025 19:04:46 -0400
Message-Id: <20250505230624.2692522-114-sashal@kernel.org>
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
index 65483dab90573..b4faac12789d9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/health.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/health.c
@@ -850,6 +850,7 @@ static void poll_health(struct timer_list *t)
 	health->prev = count;
 	if (health->miss_counter == MAX_MISSES) {
 		mlx5_core_err(dev, "device's health compromised - reached miss count\n");
+		health->synd = ioread8(&h->synd);
 		print_health_info(dev);
 		queue_work(health->wq, &health->report_work);
 	}
-- 
2.39.5


