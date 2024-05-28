Return-Path: <linux-rdma+bounces-2630-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D92D8D1BB7
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2024 14:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32B421F22D18
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2024 12:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A60C16E86A;
	Tue, 28 May 2024 12:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6KF4x83"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B39116E866
	for <linux-rdma@vger.kernel.org>; Tue, 28 May 2024 12:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716900799; cv=none; b=fg/ms4KA0ITmseZV3lA03SW32LjTPnW2EtWfSjbLcxmDgYG12nCwscHdiAJRl25WCutIPzyf8zYdArfjJxaWAxmVl8gfvWoFBxVhtM4yttrqIIJN7pdpeitOoBtyDq+nJBFwm9UzMSj2RjOHQlXhTN9lruf7nRbSbQE9w3tGix4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716900799; c=relaxed/simple;
	bh=TM/gJtG2Qa0zhwgcXm0tDtj2n6FAF818ZS88FOkE+8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K3JKK1Ruryz8Q70KWw+6rWQc4ATvxmwfcwgfZYgrMdeTm7BrNZTiQSa0mr6t5/R2fS5YdOpisyHF7FOMVZIFvnEkS15+ORqS4L0Amz1XkLX3STdY+O9nwr5ZHo+4Oge7QP8rjoVH6rFxwLAodyOMTxH4qZgRYqUbdzcrLP+C5hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6KF4x83; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D313C4AF07;
	Tue, 28 May 2024 12:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716900799;
	bh=TM/gJtG2Qa0zhwgcXm0tDtj2n6FAF818ZS88FOkE+8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K6KF4x837hLn9wtgZiTwSdRFxZxDkxNXzOLJkS+zWfACMuxl05cEKHOnPtmghT4l/
	 EyX0FyAmGbufOWYeh+2d9vwQkQL1S+NoHXuw9Q8ugGkosKh2JCIECfmuLtQbGUBNgc
	 4GcVuABAIRPA2C9qSlbe/RzrZHOvahihh1v4wqMv87igIn9+blvBIWtKrCTC9brKk+
	 cFNAjebOXLNQfA8hi9H5EVdesGdzslEtGyxdCz3fR3GdOpEp1SQAZN7PhUhQTKBLN+
	 27nt6+SIbZd7v/4lPULbXPk08WEjIjTdTLzYccpn2SyDXUuZClmg1cvJXyO3kf+Skp
	 QP1NtAvDrixaA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-rdma@vger.kernel.org,
	Mark Zhang <markzhang@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-rc 4/6] RDMA/mlx5: Ensure created mkeys always have a populated rb_key
Date: Tue, 28 May 2024 15:52:54 +0300
Message-ID: <7778c02dfa0999a30d6746c79a23dd7140a9c729.1716900410.git.leon@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1716900410.git.leon@kernel.org>
References: <cover.1716900410.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Gunthorpe <jgg@nvidia.com>

cachable and mmkey.rb_key together are used by mlx5_revoke_mr() to put the
MR/mkey back into the cache. In all cases they should be set correctly.

alloc_cacheable_mr() was setting cachable but not filling rb_key,
resulting in cache_ent_find_and_store() bucketing them all into a 0 length
entry.

implicit_get_child_mr()/mlx5_ib_alloc_implicit_mr() failed to set cachable
or rb_key at all, so the cache was not working at all for implicit ODP.

Cc: stable@vger.kernel.org
Fixes: 8c1185fef68c ("RDMA/mlx5: Change check for cacheable mkeys")
Fixes: dd1b913fb0d0 ("RDMA/mlx5: Cache all user cacheable mkeys on dereg MR flow")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 35dcb9d9e12a..d3c1f63791a2 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -718,6 +718,8 @@ static struct mlx5_ib_mr *_mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
 	}
 	mr->mmkey.cache_ent = ent;
 	mr->mmkey.type = MLX5_MKEY_MR;
+	mr->mmkey.rb_key = ent->rb_key;
+	mr->mmkey.cacheable = true;
 	init_waitqueue_head(&mr->mmkey.wait);
 	return mr;
 }
@@ -1168,7 +1170,6 @@ static struct mlx5_ib_mr *alloc_cacheable_mr(struct ib_pd *pd,
 	mr->ibmr.pd = pd;
 	mr->umem = umem;
 	mr->page_shift = order_base_2(page_size);
-	mr->mmkey.cacheable = true;
 	set_mr_fields(dev, mr, umem->length, access_flags, iova);
 
 	return mr;
-- 
2.45.1


