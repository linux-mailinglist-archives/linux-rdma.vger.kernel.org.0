Return-Path: <linux-rdma+bounces-10060-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3BAAAB779
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 08:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A2A517CEE4
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 06:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E13488CDF;
	Tue,  6 May 2025 00:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MxXhmg1V"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A222F4F5F;
	Mon,  5 May 2025 23:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486963; cv=none; b=NfXRSmMOmfcb7h6YyBsPq0Mtr3Iivz4+3MzRJ2c+vISzauRMwHvnS1dhfKuc4L3ypaKDICS9AsLLngeQlMXpAMtkJWzgTwgAMt+pu/UC9qx0cN5IPvBXlyN9Z/PGCa+Fc0/f293LskLw0Os1ME7ib+l9zFqQBPEofeF+P1Qk3PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486963; c=relaxed/simple;
	bh=yXnrpblpUCPR/DQm/KS0JbHkePIGHb+ONn9ox3YVM/w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f38PQXtolnTpnc/dKiG4o98SYoeETtQPE4t1Cho2HwL8GjS9tQsmMz8j8Vuq3UB42JJLM+EqiIskk7cgp5iItw885l7sGQmyJWeXoAK9PzCanGITDhKRq5PRzZ1l/tm3nXD+7n4ezTFMjoNSPo+ExYi4nLOemEM8VIV3Sf0izp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MxXhmg1V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A846C4CEF1;
	Mon,  5 May 2025 23:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486963;
	bh=yXnrpblpUCPR/DQm/KS0JbHkePIGHb+ONn9ox3YVM/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MxXhmg1VcctwD0zjfKuDELevv3MUMF12KDgPmYGQejALHssd4goTpwBoY5kGxc0ed
	 5Dm/3WN7mne6dKU2/3KG07p22SBUnU3ZPJnOOhbHL1TNn0AqUIkbCX8GYh8UFOiRsE
	 jZT61k/8XTIA/ZLZEuh0TUSojK3M9J+MynvV9BdsqcGlPmeZVHHyOghD2bphBTx85L
	 GKd8nCelhBz1rn3j0UDYIrMf3Z0rIl7gwnR+7NBpw9evBQ3ebHGrRySOQHsgHb5i49
	 tfiLdN9NCoVHH2hF33MDCQ95STq36+xBl2TppAB7OzzEtxzk10lY0HH7dO5sgJNSYI
	 Nck9m45cwp5mA==
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
Subject: [PATCH AUTOSEL 5.15 082/153] net/mlx5: Avoid report two health errors on same syndrome
Date: Mon,  5 May 2025 19:12:09 -0400
Message-Id: <20250505231320.2695319-82-sashal@kernel.org>
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
index 1504856fafde4..2a0b111fbcd3c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/health.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/health.c
@@ -737,6 +737,7 @@ static void poll_health(struct timer_list *t)
 	health->prev = count;
 	if (health->miss_counter == MAX_MISSES) {
 		mlx5_core_err(dev, "device's health compromised - reached miss count\n");
+		health->synd = ioread8(&h->synd);
 		print_health_info(dev);
 		queue_work(health->wq, &health->report_work);
 	}
-- 
2.39.5


