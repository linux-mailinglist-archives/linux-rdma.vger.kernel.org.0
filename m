Return-Path: <linux-rdma+bounces-7369-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27859A2633A
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2025 20:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AFFE3A4B88
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2025 19:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38471D5CC4;
	Mon,  3 Feb 2025 19:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="gfoTcEMX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF151552FA;
	Mon,  3 Feb 2025 19:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738609213; cv=none; b=j64eOSYsQVYs8Y6JtLOeY1OgahPpb4RiqhRwYX1Rlpp+DMr3VEv5n3IFZ4pYOih4Z1hEwb7uAnEJKGCMA3M+zt1WcWPOf6cTcyh7XdrjtnZj98q++tWVaR/RDBTpkezEhdQjo9QfJ/ewY4uFLvZRUXMomw6fRsxatitSkff8eNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738609213; c=relaxed/simple;
	bh=th+jmuLRTdg0eMmnU2szpdUNNk3XBFQArnJCcQynsWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i8ZquEgjPxoQxxCxFTl/YegRMfOcjFF4rWwxtGEZbvQyyin1dE4eKpzk26ble5VN8bVo8nveuM7ZiHsXyE8eSEI4guRCEKGfonmbH3RcarwYpmhXI6M2/dkTpJLdctk9KSgTHE+6pKs9zhQsgT5GSmdklSkhycuez1tM11TDGts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=gfoTcEMX; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=TjppAuWd3XEkG6npc1wSulnYtx9dkF3mAxWmfa91O/o=; b=gfoTcEMXtxxGtd1c
	Y1I7tciGp8bHoHJaWLi8ML2OggZ3f/yuw3pxXEj+cXqn75keAUC3/OYSlSmug1sxWTSs/q47JgcOf
	sXwhCnxJBLf4uVondRveQNLUzgB9lnQsddLjPsimX1I9FYeXJdh2cyU8ZygYRyAxGUdNGdG+T3JLY
	uQFdrOfrFIv1APpj17lwkrnHabk6xseL2tzNCGfjv2LVU30ltTZo9yQaPC8QWPduI0f8ar+LkEb0v
	UIN6NJt7W85UilZNq+k8rT6tWBJIm6F/Tl3uLdRUYw2IkPxnYknMh0L9ZL5je9VW5LQp5mfBqJ+C5
	HB6y495st1kMAYxd5w==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tf1fr-00DLzG-1z;
	Mon, 03 Feb 2025 18:59:59 +0000
From: linux@treblig.org
To: leon@kernel.org,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH net-next] net/mlx5: Remove unused mlx5dr_domain_sync
Date: Mon,  3 Feb 2025 18:59:58 +0000
Message-ID: <20250203185958.204794-1-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

mlx5dr_domain_sync() was added in 2019 by
commit 70605ea545e8 ("net/mlx5: DR, Expose APIs for direct rule managing")
but hasn't been used.

Remove it.

mlx5dr_domain_sync() was the only user of
mlx5dr_send_ring_force_drain().
Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 .../mlx5/core/steering/sws/dr_domain.c        | 24 --------------
 .../mellanox/mlx5/core/steering/sws/dr_send.c | 33 -------------------
 .../mlx5/core/steering/sws/dr_types.h         |  1 -
 .../mellanox/mlx5/core/steering/sws/mlx5dr.h  |  2 --
 4 files changed, 60 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
index 60cb4527588a..65740bb68b09 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
@@ -516,30 +516,6 @@ mlx5dr_domain_create(struct mlx5_core_dev *mdev, enum mlx5dr_domain_type type)
 	return NULL;
 }
 
-/* Assure synchronization of the device steering tables with updates made by SW
- * insertion.
- */
-int mlx5dr_domain_sync(struct mlx5dr_domain *dmn, u32 flags)
-{
-	int ret = 0;
-
-	if (flags & MLX5DR_DOMAIN_SYNC_FLAGS_SW) {
-		mlx5dr_domain_lock(dmn);
-		ret = mlx5dr_send_ring_force_drain(dmn);
-		mlx5dr_domain_unlock(dmn);
-		if (ret) {
-			mlx5dr_err(dmn, "Force drain failed flags: %d, ret: %d\n",
-				   flags, ret);
-			return ret;
-		}
-	}
-
-	if (flags & MLX5DR_DOMAIN_SYNC_FLAGS_HW)
-		ret = mlx5dr_cmd_sync_steering(dmn->mdev);
-
-	return ret;
-}
-
 int mlx5dr_domain_destroy(struct mlx5dr_domain *dmn)
 {
 	if (WARN_ON_ONCE(refcount_read(&dmn->refcount) > 1))
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_send.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_send.c
index f57c84e5128b..4fd4e8483382 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_send.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_send.c
@@ -1331,36 +1331,3 @@ void mlx5dr_send_ring_free(struct mlx5dr_domain *dmn,
 	kfree(send_ring->sync_buff);
 	kfree(send_ring);
 }
-
-int mlx5dr_send_ring_force_drain(struct mlx5dr_domain *dmn)
-{
-	struct mlx5dr_send_ring *send_ring = dmn->send_ring;
-	struct postsend_info send_info = {};
-	u8 data[DR_STE_SIZE];
-	int num_of_sends_req;
-	int ret;
-	int i;
-
-	/* Sending this amount of requests makes sure we will get drain */
-	num_of_sends_req = send_ring->signal_th * TH_NUMS_TO_DRAIN / 2;
-
-	/* Send fake requests forcing the last to be signaled */
-	send_info.write.addr = (uintptr_t)data;
-	send_info.write.length = DR_STE_SIZE;
-	send_info.write.lkey = 0;
-	/* Using the sync_mr in order to write/read */
-	send_info.remote_addr = (uintptr_t)send_ring->sync_mr->addr;
-	send_info.rkey = send_ring->sync_mr->mkey;
-
-	for (i = 0; i < num_of_sends_req; i++) {
-		ret = dr_postsend_icm_data(dmn, &send_info);
-		if (ret)
-			return ret;
-	}
-
-	spin_lock(&send_ring->lock);
-	ret = dr_handle_pending_wc(dmn, send_ring);
-	spin_unlock(&send_ring->lock);
-
-	return ret;
-}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_types.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_types.h
index 7618c6147f86..cc328292bf84 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_types.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_types.h
@@ -1473,7 +1473,6 @@ struct mlx5dr_send_ring {
 int mlx5dr_send_ring_alloc(struct mlx5dr_domain *dmn);
 void mlx5dr_send_ring_free(struct mlx5dr_domain *dmn,
 			   struct mlx5dr_send_ring *send_ring);
-int mlx5dr_send_ring_force_drain(struct mlx5dr_domain *dmn);
 int mlx5dr_send_postsend_ste(struct mlx5dr_domain *dmn,
 			     struct mlx5dr_ste *ste,
 			     u8 *data,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/mlx5dr.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/mlx5dr.h
index 0bb3724c10c2..fc8a2169d1a1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/mlx5dr.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/mlx5dr.h
@@ -45,8 +45,6 @@ mlx5dr_domain_create(struct mlx5_core_dev *mdev, enum mlx5dr_domain_type type);
 
 int mlx5dr_domain_destroy(struct mlx5dr_domain *domain);
 
-int mlx5dr_domain_sync(struct mlx5dr_domain *domain, u32 flags);
-
 void mlx5dr_domain_set_peer(struct mlx5dr_domain *dmn,
 			    struct mlx5dr_domain *peer_dmn,
 			    u16 peer_vhca_id);
-- 
2.48.1


