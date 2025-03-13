Return-Path: <linux-rdma+bounces-8671-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A71D0A5F831
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 15:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FA7F7B02F4
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 14:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611512686BE;
	Thu, 13 Mar 2025 14:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rNtxoSEA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7DE2686B4
	for <linux-rdma@vger.kernel.org>; Thu, 13 Mar 2025 14:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876217; cv=none; b=r4JL9kNOtW18a65bgztrN18QFEZu+djr6dhKYjT6URZ6ioYgPPeTCeva/E8lqP244n15s3HCiKoZ5csv48Sk3lSq+dDotRaje728jIARbTBjX8QUs+bMywphGRZxkLX9XM6zY4POG0qKUgvdcuCwKpgoO8yINfBLW8uCJmGfcfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876217; c=relaxed/simple;
	bh=pTtu9lmpykaTX8f8iysRrsuGGInskIpgSENyOrFga9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RTWbPfrmwcdcsQjttZy1B0uMmqWJVY1+qPltJiZFyy2/WKi4irqzEetFyB6oaDjFRMUi1+RyAlTQbwMaDWGI/HCAfJK0OrqQJEdZGLhJENHq+iWsaVE3ogsSrVw68Wwp7KrhOYzGiwsQ+UaEMwEXTtSy9NKkUOiu01P+lQCIljQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rNtxoSEA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10937C4CEDD;
	Thu, 13 Mar 2025 14:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741876215;
	bh=pTtu9lmpykaTX8f8iysRrsuGGInskIpgSENyOrFga9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rNtxoSEAAispjKqGUKL/CALwzE09UIA7HtxOkVeyoyHK8GdV+RwB9nQc2UIb+2hVr
	 QAGbtC2cMP3hJl4shrmGTW/whaZ1IsOmu9kGF6l/9wk5DEYtuNpl/91fgb84tQYqaj
	 VrtFg4Z3JdcBnvA5DlG1xHjMY5xK66qNoqg20W2iibNuj2uuv4Gpz0G7ekOvNZTtzt
	 +A27P+pkJuJ2A+HtGyk14Eo4EmMkRi+XIvD3xpwc27CHUsZExpIjb1N9DE78W1c4S2
	 HVJJhQKRuG1Jy+clgN1oP5ZdMklCEl7msYeZ8M0IUOQCMix7rVg4oSh5lyYFaYPq5F
	 WJoda7RxCglYA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Michael Guralnik <michaelgur@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Or Har-Toov <ohartoov@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-next 2/7] RDMA/mlx5: Fix cache entry update on dereg error
Date: Thu, 13 Mar 2025 16:29:49 +0200
Message-ID: <97e979dff636f232ff4c83ce709c17c727da1fdb.1741875692.git.leon@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741875692.git.leon@kernel.org>
References: <cover.1741875692.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Guralnik <michaelgur@nvidia.com>

Fix double decrement of 'in_use' counter on push_mkey_locked() failure
while deregistering an MR.
If we fail to return an mkey to the cache in cache_ent_find_and_store()
it'll update the 'in_use' counter. Its caller, revoke_mr(), also updates
it, thus having double decrement.

Wrong value of 'in_use' counter will be exposed through debugfs and can
also cause wrong resizing of the cache when users try to set cache
entry size using the 'size' debugfs.

To address this issue, the 'in_use' counter is now decremented within
mlx5_revoke_mr() also after a successful call to
cache_ent_find_and_store() and not within cache_ent_find_and_store().
Other success or failure flows remains unchanged where it was also
decremented.

Fixes: 8c1185fef68c ("RDMA/mlx5: Change check for cacheable mkeys")
Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 1ffa4b3d0f76..cbab0240c7e5 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1967,7 +1967,6 @@ static int cache_ent_find_and_store(struct mlx5_ib_dev *dev,
 
 	if (mr->mmkey.cache_ent) {
 		spin_lock_irq(&mr->mmkey.cache_ent->mkeys_queue.lock);
-		mr->mmkey.cache_ent->in_use--;
 		goto end;
 	}
 
@@ -2042,6 +2041,7 @@ static int mlx5_revoke_mr(struct mlx5_ib_mr *mr)
 		ent = mr->mmkey.cache_ent;
 		/* upon storing to a clean temp entry - schedule its cleanup */
 		spin_lock_irq(&ent->mkeys_queue.lock);
+		ent->in_use--;
 		if (ent->is_tmp && !ent->tmp_cleanup_scheduled) {
 			mod_delayed_work(ent->dev->cache.wq, &ent->dwork,
 					 msecs_to_jiffies(30 * 1000));
-- 
2.48.1


