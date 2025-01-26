Return-Path: <linux-rdma+bounces-7225-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B38BFA1CA63
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Jan 2025 16:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FB3E7A160C
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Jan 2025 15:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A283919C574;
	Sun, 26 Jan 2025 15:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BglAlWzv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFE019992C;
	Sun, 26 Jan 2025 15:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903683; cv=none; b=L+GVoDXFzrVDZHNuML87/zEU+vDrZj9aTHj+/ZUbfL7Pw1Bo629bR0J1SEJjjfUjCGQUTJrN3+VhMl8/h0GqVnAG5XBl/sx/gtOQGAktqjX/2DtHYKvUDg1QGIoM1llrkE+PopCxa+hPhMuQh7D9OImgYLzgguaIx3L8C/SCPw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903683; c=relaxed/simple;
	bh=R3aFH1ESDnx8HbJ794vbnL2NlubjNeI0tizQIxY15Zk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ndiblQ27i8gnDznZOkWumoG3b3HNYe3eV5BiOZbB6YXmU0WD5wwknSjdQbyVgnkJJDxwzGNLX66U928IdS+gABB6XJ7ESKKp0f2Vtcs0H3FFwxrQsCivSlJCyHG4ixFj2m1cF3EElvUJwOEky7bImbkCMItbum4Xdt6vN7h0ODo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BglAlWzv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EFD1C4CEE2;
	Sun, 26 Jan 2025 15:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903682;
	bh=R3aFH1ESDnx8HbJ794vbnL2NlubjNeI0tizQIxY15Zk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BglAlWzvcIyLfbpKFMrXilhydofpFOHHt3HgDWx4neiQNYpyC7v7RAe8jqNiWWQn7
	 PpNmLZ1c1tEIUdbx1reBt3+5yWQeWCKckyMyzNlHo3K0Nb+WcIGGrL6bTsD2FF8XIy
	 EpfDZcIjS/ovx7ad4xjjjtxu+qP+XHXazFECliQUiCy2jLZjyat8y13kkTpij/+tjS
	 2Y6jaq1p3tcD/ctgMLxApK0nMXHqE5PJ+3TT1zyJhkRROA3j7GnC8qMmTu4iAuM5yq
	 m0QCNLLZ68WZuCONJPJFZJX4/qIaNmmlCBMUbHT10ddmqNBEzMxrdKkkWSEWQFOz1o
	 9fotFoKNSWOXA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Erez Shitrit <erezsh@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	saeedm@nvidia.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	igozlan@nvidia.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 14/35] net/mlx5: HWS, num_of_rules counter on matcher should be atomic
Date: Sun, 26 Jan 2025 10:00:08 -0500
Message-Id: <20250126150029.953021-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150029.953021-1-sashal@kernel.org>
References: <20250126150029.953021-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
Content-Transfer-Encoding: 8bit

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

[ Upstream commit 61fb92701b8ac9174857c417cfa988adc24e32c2 ]

Rule counter in matcher's struct is used in two places:

1. As heuristics to decide when the number of rules have crossed a
certain percentage threshold and the matcher should be resized.
We don't mind here if the number will be off by 1-2 due to concurrency.

2. When destroying matcher, the counter value is checked and the
user is warned if it is not 0. Here we lock all the queues, so the
counter will be correct.

We don't need to always have *exact* number, but we do need this
number to not be corrupted, which is what is happening when the
counter isn't atomic, due to update by different threads.

Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Erez Shitrit <erezsh@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Link: https://patch.msgid.link/20250102181415.1477316-10-tariqt@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../mellanox/mlx5/core/steering/hws/bwc.c       | 17 +++++++++++------
 .../mellanox/mlx5/core/steering/hws/bwc.h       |  2 +-
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
index baacf662c0ab8..ae2849cf4dd49 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
@@ -152,6 +152,8 @@ mlx5hws_bwc_matcher_create(struct mlx5hws_table *table,
 	if (!bwc_matcher)
 		return NULL;
 
+	atomic_set(&bwc_matcher->num_of_rules, 0);
+
 	/* Check if the required match params can be all matched
 	 * in single STE, otherwise complex matcher is needed.
 	 */
@@ -199,10 +201,12 @@ int mlx5hws_bwc_matcher_destroy_simple(struct mlx5hws_bwc_matcher *bwc_matcher)
 
 int mlx5hws_bwc_matcher_destroy(struct mlx5hws_bwc_matcher *bwc_matcher)
 {
-	if (bwc_matcher->num_of_rules)
+	u32 num_of_rules = atomic_read(&bwc_matcher->num_of_rules);
+
+	if (num_of_rules)
 		mlx5hws_err(bwc_matcher->matcher->tbl->ctx,
 			    "BWC matcher destroy: matcher still has %d rules\n",
-			    bwc_matcher->num_of_rules);
+			    num_of_rules);
 
 	mlx5hws_bwc_matcher_destroy_simple(bwc_matcher);
 
@@ -309,7 +313,7 @@ static void hws_bwc_rule_list_add(struct mlx5hws_bwc_rule *bwc_rule, u16 idx)
 {
 	struct mlx5hws_bwc_matcher *bwc_matcher = bwc_rule->bwc_matcher;
 
-	bwc_matcher->num_of_rules++;
+	atomic_inc(&bwc_matcher->num_of_rules);
 	bwc_rule->bwc_queue_idx = idx;
 	list_add(&bwc_rule->list_node, &bwc_matcher->rules[idx]);
 }
@@ -318,7 +322,7 @@ static void hws_bwc_rule_list_remove(struct mlx5hws_bwc_rule *bwc_rule)
 {
 	struct mlx5hws_bwc_matcher *bwc_matcher = bwc_rule->bwc_matcher;
 
-	bwc_matcher->num_of_rules--;
+	atomic_dec(&bwc_matcher->num_of_rules);
 	list_del_init(&bwc_rule->list_node);
 }
 
@@ -704,7 +708,8 @@ hws_bwc_matcher_rehash_size(struct mlx5hws_bwc_matcher *bwc_matcher)
 	 * Need to check again if we really need rehash.
 	 * If the reason for rehash was size, but not any more - skip rehash.
 	 */
-	if (!hws_bwc_matcher_rehash_size_needed(bwc_matcher, bwc_matcher->num_of_rules))
+	if (!hws_bwc_matcher_rehash_size_needed(bwc_matcher,
+						atomic_read(&bwc_matcher->num_of_rules)))
 		return 0;
 
 	/* Now we're done all the checking - do the rehash:
@@ -797,7 +802,7 @@ int mlx5hws_bwc_rule_create_simple(struct mlx5hws_bwc_rule *bwc_rule,
 	}
 
 	/* check if number of rules require rehash */
-	num_of_rules = bwc_matcher->num_of_rules;
+	num_of_rules = atomic_read(&bwc_matcher->num_of_rules);
 
 	if (unlikely(hws_bwc_matcher_rehash_size_needed(bwc_matcher, num_of_rules))) {
 		mutex_unlock(queue_lock);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
index 0b745968e21e1..655fa7a22d84f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
@@ -19,7 +19,7 @@ struct mlx5hws_bwc_matcher {
 	u8 num_of_at;
 	u16 priority;
 	u8 size_log;
-	u32 num_of_rules; /* atomically accessed */
+	atomic_t num_of_rules;
 	struct list_head *rules;
 };
 
-- 
2.39.5


