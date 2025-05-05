Return-Path: <linux-rdma+bounces-10066-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E5AAAB7D0
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 08:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 197281BA8024
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 06:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602004A4E72;
	Tue,  6 May 2025 00:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ewfl4VnR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5877C3AF413;
	Mon,  5 May 2025 23:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487211; cv=none; b=JZj3C/9ZoeQJmUXz7JJcVWbsHa2L0ABFjhi4FilWqVUF2IzoCahvVvoi9CDv+HD2o8BzGFOin6ZFpb+vye/VLR+Bl43EukDp3gLFCElwqXyks6I1WWmYoUCcriMmmeVYiUMhEpGVd5j5aOA76PRdVekXMCW0A2k8XpLqFtjcZpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487211; c=relaxed/simple;
	bh=2yE7zy2FWQ3AXCJ6jui9QnR9f1PfghpII4uGE+xFPO4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KzE+4LDGvtEi9LQkJA8V5brPcTkZ0C3ts6czcAneZkJHb1JsMS/PMF4GBVP9ySelN4c7QkvPEpMfXK/MOCDbw48iwsbFsQIMSZ67rqKxIeosFy1R2K6HB9M/UdTvDtqHZUOvE0bUHZ6T5BdiesSlILTrkLWKiu7cIjsh0Ic7K7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ewfl4VnR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98425C4CEED;
	Mon,  5 May 2025 23:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487211;
	bh=2yE7zy2FWQ3AXCJ6jui9QnR9f1PfghpII4uGE+xFPO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ewfl4VnRIeAARoPMNjwvb62j8zOQ6ARTZjFtG0ysAaEDdmxv0oXZU1AMWfuTUi4fh
	 62JrYa3iLJRNjVbLlyYaWBa2HGGwlDfPWdU636NtNVP+XnyvsWjnrfRfOdS+UBBlFT
	 CG+xiSYghbas3pUmYdvkEXA4T+M4vkm/AQd13d/GvjU/PQYYDECADj2TQ+/NrpP+il
	 3TV8eLYG52EVPxOQyQbgpwj+0X7BHNCazODKZCuXqrmoi1rh7npaBvPK5YQdB9WElY
	 WFIm8CB6RmDYaNkHiOVqnG6u+b2Jo3XFaMqLmuEUCfumZeAZ/98NjPgMpgYECNzSlD
	 FVKU/ZsOW0fVw==
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
Subject: [PATCH AUTOSEL 5.10 059/114] net/mlx5: Avoid report two health errors on same syndrome
Date: Mon,  5 May 2025 19:17:22 -0400
Message-Id: <20250505231817.2697367-59-sashal@kernel.org>
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
index f42e118f32901..d48912d7afe54 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/health.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/health.c
@@ -733,6 +733,7 @@ static void poll_health(struct timer_list *t)
 	health->prev = count;
 	if (health->miss_counter == MAX_MISSES) {
 		mlx5_core_err(dev, "device's health compromised - reached miss count\n");
+		health->synd = ioread8(&h->synd);
 		print_health_info(dev);
 		queue_work(health->wq, &health->report_work);
 	}
-- 
2.39.5


