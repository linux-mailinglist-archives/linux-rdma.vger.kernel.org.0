Return-Path: <linux-rdma+bounces-5665-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A7B9B7BCD
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Oct 2024 14:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CF48B2109E
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Oct 2024 13:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B289A19F108;
	Thu, 31 Oct 2024 13:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrViPP/4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4EA19D8BB;
	Thu, 31 Oct 2024 13:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730381832; cv=none; b=qQXwhrnx7Y64IHaPHyqiMN6Snb6aOdlPZ4sFqfVlvjnNzdvVFyyoP5i1CtrSD+73DCxRuQSGwVP+C/oyydnQlke7Y/EBGBIS+feMyxPXQ8paAD1ym1lX39ORV5xGXE+liLs7P6CCBP9oAvuvr5jhJBHESS5gDhcseMEpYlUCLdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730381832; c=relaxed/simple;
	bh=OxHUI/+j/MU/gl8XbfjrQVpEchUdlai4hnUxohVx8Mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pxx0eIj6gsUtp9ErppG03ZZUCHYGxq/rBnSjupykRki7xk9yPsoC0F1Y1LGGC9J0C7FViJFkxNr4dK0Hufl+RBh7Ow1XCJwYrMa+Q7ZlnHC07NUOqHKe1TvEhUvnopV6oE5dGgmAu9ng9OFjrEQrcFlU1PwvCT60fDBwTk9u9Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TrViPP/4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7805FC4FDE5;
	Thu, 31 Oct 2024 13:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730381832;
	bh=OxHUI/+j/MU/gl8XbfjrQVpEchUdlai4hnUxohVx8Mk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TrViPP/4KB88CeGzrw8btqVezOixMS2zmKo0nvvCqDUStIOsgUCjWoJB/3+glw/Kh
	 NYh75Q5a5rv/QadEdAk4uZryECIHImL9Dpr4z6rX4N1gxZKvEPdKOH6rjSsO4bsPLC
	 ewtKKJ1y4L6RwKwapsW1ZKBWhdfPajWbqPu3f4BRtfvKs5SvFVEVjYV5nqIZ4g/pyv
	 N6fw7G4aJ/yJ5jdba2m6mXTZKNtxX+VA39Obg4X60hLNMQ1g4MMXHEvR+zICIN938A
	 aX5xYRzw990W5p+mGVpf6OWx3GRjhMx7kgGYk2X88chktSQZg8yh4HUKDAMADsfz9b
	 kUNdLya/hmfZg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Chiara Meiohas <cmeiohas@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-rdma@vger.kernel.org,
	Michael Guralnik <michaelgur@nvidia.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH mlx5-next 1/3] RDMA/mlx5: Call dev_put() after the blocking notifier
Date: Thu, 31 Oct 2024 15:36:50 +0200
Message-ID: <342ff94b3dcbb07da1c7dab862a73933d604b717.1730381292.git.leon@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1730381292.git.leon@kernel.org>
References: <cover.1730381292.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chiara Meiohas <cmeiohas@nvidia.com>

Move dev_put() call to occur directly after the blocking
notifier, instead of within the event handler.

Fixes: 8d159eb2117b ("RDMA/mlx5: Use IB set_netdev and get_netdev functions")
Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c                 | 1 -
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index b4476df96ed5..5f7fe32b9051 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -3242,7 +3242,6 @@ static int lag_event(struct notifier_block *nb, unsigned long event, void *data)
 			}
 			err = ib_device_set_netdev(&dev->ib_dev, ndev,
 						   portnum + 1);
-			dev_put(ndev);
 			if (err)
 				return err;
 			/* Rescan gids after new netdev assignment */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index 8577db3308cc..d661267d98ff 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -516,6 +516,7 @@ void mlx5_modify_lag(struct mlx5_lag *ldev,
 		blocking_notifier_call_chain(&dev0->priv.lag_nh,
 					     MLX5_DRIVER_EVENT_ACTIVE_BACKUP_LAG_CHANGE_LOWERSTATE,
 					     ndev);
+		dev_put(ndev);
 	}
 }
 
-- 
2.46.2


