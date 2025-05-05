Return-Path: <linux-rdma+bounces-10034-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2E1AAB62C
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 07:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8326F4A545E
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 05:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B301529ACCB;
	Tue,  6 May 2025 00:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8zzJaAq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2283B2BE7B3;
	Mon,  5 May 2025 22:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485255; cv=none; b=YtMkanbQUWJwvdTQJ5tJur9G0BBrvoqjHBGAdMyNDdQ/jZIYFSk2CkOn7mjX+acIcgA2ecW8W3SzDdo9R68tXlDjwlmW1dZkGQdquvB2+ZeGaKGNpdZNpdDk07Nr3reVBiSryzs3iBNjduOgsvsIopwWQyQxFz/zLyUyslUOHLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485255; c=relaxed/simple;
	bh=VqUtpLEe/mjyl4FHZoKwz7jUI868mLWleMa5ecX/Mpw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iRJC8wBoTGRi8p71//hwrZ6EkFfJ7K7EZPDPDL1iAYBUDCe7eKigDMicm2oqpZEQVehHkSvTKi7ZrXegzcduh25GAn2OmVv1bhO85IRaHBLTOp5FVd9aAI6vVYN50Djf1SCSyN9ALKGdk5047lE9ovQXrcn7ZiSLol+tP9/FiNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8zzJaAq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A3BCC4CEEE;
	Mon,  5 May 2025 22:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485255;
	bh=VqUtpLEe/mjyl4FHZoKwz7jUI868mLWleMa5ecX/Mpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E8zzJaAqjkeJ13ftFWEWHmkVX8GT5ib6G9bl+kikg8oY6lmNKX0Dg+86anWq9zgI8
	 cqNi6lysJEOo7h3OdahCh0j4hJV5hSQu5c9ZSBfQDhJ2VtlGo+Ln+PTcEU7TYSeZDW
	 IyWZA5sS++TVw1fU0pS6H/8YkV8Ra35morVsK/OWM8/i5/ChTgJURK9FcVtpF4stzZ
	 0/YlYVXdMbQlB3B2t1CUqEmyqWX+5u+Uh6jwdVCBSbtl+ijk0F2ws4R0CcMxX10nKU
	 XtP6TtCenOD7IF7KxhW4W2M8Y9sPv0ExVvdtyeFtM1Q6rKIia+krIZDvbpF/3xy5Sw
	 4RPw3I0Icwn9A==
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
Subject: [PATCH AUTOSEL 6.12 238/486] net/mlx5: Avoid report two health errors on same syndrome
Date: Mon,  5 May 2025 18:35:14 -0400
Message-Id: <20250505223922.2682012-238-sashal@kernel.org>
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


