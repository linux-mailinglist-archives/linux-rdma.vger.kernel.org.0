Return-Path: <linux-rdma+bounces-10009-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E71BDAAAADC
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 03:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EE704640FD
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 01:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39BA3881C8;
	Mon,  5 May 2025 23:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhtwFRMm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60E238B4FD;
	Mon,  5 May 2025 23:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486080; cv=none; b=KN2ylKCQOfntdD0FfGK/BLcwHteDq+ilOSvlh2Ytd1C+KcFA6P+1nPdKSAI1RWZVwQLGE83111PcggO2CeEfqoTjKuhshZrOcdgSlJh5mzsrKf7ysnL6Tw8CL198ySKfFmSce+peBz/sK+6lxkiv82UA0dBaBAlqyWAjJDd3RBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486080; c=relaxed/simple;
	bh=xsG4rBM09c/xSobrtJti6SlHNoC4rRB/WiXU3ljircU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ObtThG8eKWZ7JxnQqhwuGu4cfNEqb/EFbJTIOKf8qQxdZsTTwimjYHgjIzDsL9D9pkAQyMOJhCsDN9EpScvKAggOJJ9VPedRBEXsjawaOZZ0SenDhbyvOFm1w4ap8Q8vFG5BsNL/16/InqxBejZQJfBT9oHnvkR+iZ1xR4Qn5gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhtwFRMm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766ADC4CEE4;
	Mon,  5 May 2025 23:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486079;
	bh=xsG4rBM09c/xSobrtJti6SlHNoC4rRB/WiXU3ljircU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BhtwFRMmadodhsO4nP3llLInoydD8syMIGNfM4pCUxXYhisiwmtd4Iwsu4IYmztzp
	 DmImDAyWpZtvvorwNd1LsUaUO3081cRn6Hr197Hse5Njg1AVuiIZPq4oPrmYqV7D1/
	 b75lfhAGhIUsd6/nkCPHxKbbjN9Yd2AsixSHv9XyaieMzff4BzfDdNv6FiZhrU81qk
	 X3SVKpMdrwcrM230yxf28OjWVnH9k4P888vWmvjdhmZ3CAptvwY6ByCP07cvllc7OO
	 EBoamDJ+0fwN44DRLAQQyy8Z6f8CQHSWLLDWbEtfuV7M4CVJ65DApC7tzOFfFNq46f
	 wmYoZ3AIAgTGA==
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
Subject: [PATCH AUTOSEL 6.6 144/294] net/mlx5: Avoid report two health errors on same syndrome
Date: Mon,  5 May 2025 18:54:04 -0400
Message-Id: <20250505225634.2688578-144-sashal@kernel.org>
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
index d798834c4e755..3ac8043f76dac 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/health.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/health.c
@@ -833,6 +833,7 @@ static void poll_health(struct timer_list *t)
 	health->prev = count;
 	if (health->miss_counter == MAX_MISSES) {
 		mlx5_core_err(dev, "device's health compromised - reached miss count\n");
+		health->synd = ioread8(&h->synd);
 		print_health_info(dev);
 		queue_work(health->wq, &health->report_work);
 	}
-- 
2.39.5


