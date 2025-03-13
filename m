Return-Path: <linux-rdma+bounces-8675-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AF0A5F857
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 15:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 767453B5F30
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 14:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA606269AED;
	Thu, 13 Mar 2025 14:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZyWqqJn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A812269AE3
	for <linux-rdma@vger.kernel.org>; Thu, 13 Mar 2025 14:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876232; cv=none; b=TBJ7US6PGdPzXJXDTd0jX9pUy3yhl0cc3LCUbX9WGRehEH9rFwn6pLsLll1hkIlvQGOkq/A77vGqFkkBhQs8ZYFfcDA68vQh6sJxm67J4tqfEKfQwmu8UeMde3LDSHlf7tQKAYta1LVAzvaaXlJe6X7E6s0M87yoT8nrjxYKLn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876232; c=relaxed/simple;
	bh=oXVOGJL9o2ay1SkT7DMJJ+0fLaiDP3Ta/ia4qwVM2yQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pzDSt0KXgDBEpKNkLUDyWMlPhVFDz8pficT3/hMfq4tbyW1jJgRjzxP7zH4jYIVTFHKVAcB6bEJ3B3jDm+YxzKGxvliIwC7Vu86CjXQXRr3zR7XrJvUHPsOLq+GmsFSQFGCOr/Fjimtpn7zcDdHbCGikyOnP44T4Q3rf3cUXFfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZyWqqJn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD49C4CEEA;
	Thu, 13 Mar 2025 14:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741876232;
	bh=oXVOGJL9o2ay1SkT7DMJJ+0fLaiDP3Ta/ia4qwVM2yQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HZyWqqJnl5ovgE15uY3tBqaxWsd0lofmtYuWnEGeNQkPtuD+Qd8Sz8ubfvuPPXJxw
	 6DhETgnTU4vDH6z+4I3kgOM1JLbTcV2oTDGfVmMeiC+ut3lFUegHGApx1Nqi7Pa+dj
	 v68i71p6kNYzz3Se8H1bFuHGEjLH40lpojjjxyHCAitUTRzDwC7WtzntoHOwFHDVkx
	 TKh4VXPFlm9yhu9OqmjYVwgZ3VIvsR1BvvkAhW/DelS0k/Fi8T0+hiXY8s+UKCT7NM
	 j3NWGNAP9ytKlDrxR+NVIytetJkMiic4gneJeorhT9VcMizMyIYjEfzyFNfsUSxBe6
	 FNFmyblhIRB7A==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Chiara Meiohas <cmeiohas@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next 7/7] RDMA/mlx5: Fix calculation of total invalidated pages
Date: Thu, 13 Mar 2025 16:29:54 +0200
Message-ID: <560deb2433318e5947282b070c915f3c81fef77f.1741875692.git.leon@kernel.org>
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

From: Chiara Meiohas <cmeiohas@nvidia.com>

When invalidating an address range in mlx5, there is an optimization to
do UMR operations in chunks.
Previously, the invalidation counter was incorrectly updated for the
same indexes within a chunk. Now, the invalidation counter is updated
only when a chunk is complete and mlx5r_umr_update_xlt() is called.
This ensures that the counter accurately represents the number of pages
invalidated using UMR.

Fixes: a3de94e3d61e ("IB/mlx5: Introduce ODP diagnostic counters")
Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/odp.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index f1e23583e6c0..de9683344f5e 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -308,9 +308,6 @@ static bool mlx5_ib_invalidate_range(struct mmu_interval_notifier *mni,
 				blk_start_idx = idx;
 				in_block = 1;
 			}
-
-			/* Count page invalidations */
-			invalidations += idx - blk_start_idx + 1;
 		} else {
 			u64 umr_offset = idx & umr_block_mask;
 
@@ -320,14 +317,19 @@ static bool mlx5_ib_invalidate_range(struct mmu_interval_notifier *mni,
 						     MLX5_IB_UPD_XLT_ZAP |
 						     MLX5_IB_UPD_XLT_ATOMIC);
 				in_block = 0;
+				/* Count page invalidations */
+				invalidations += idx - blk_start_idx + 1;
 			}
 		}
 	}
-	if (in_block)
+	if (in_block) {
 		mlx5r_umr_update_xlt(mr, blk_start_idx,
 				     idx - blk_start_idx + 1, 0,
 				     MLX5_IB_UPD_XLT_ZAP |
 				     MLX5_IB_UPD_XLT_ATOMIC);
+		/* Count page invalidations */
+		invalidations += idx - blk_start_idx + 1;
+	}
 
 	mlx5_update_odp_stats_with_handled(mr, invalidations, invalidations);
 
-- 
2.48.1


