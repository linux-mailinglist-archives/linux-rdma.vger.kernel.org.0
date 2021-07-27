Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93033D7022
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jul 2021 09:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235633AbhG0HQL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Jul 2021 03:16:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:41000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235558AbhG0HQL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 27 Jul 2021 03:16:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DFA7261185;
        Tue, 27 Jul 2021 07:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627370171;
        bh=AA44r1tSFZ2btuSUiz3iN39BjCmB7y1GExfOMV+WzlA=;
        h=From:To:Cc:Subject:Date:From;
        b=FXkRJcryuEj9q5LkPsNh0jyCmk4N2o7VHCZMAyt9cTh+VLoKRnlJhu4duQ8LdG7mn
         PCeg0FOWJ/TkJVG/09cKY9TCXBfibHThMCzFZ6vZztfWwmBG0tiBVgdi/gDMqCJ6IV
         WViDTNetD4GV6WlIa31zlk0SgGg4Ee4TxbZP3RIWwahF9KKODxaXU7GV/uVdG+9Lvn
         9Oyw5Q0WwMgkUWGTCJ+H/V8XB1rxHxO7UPZZwCj/c+K9JodQyrDMzWnIAaCwmXo2ZJ
         Ka1hv09/3veAp03FZrGxMZBo8eixEgagIcGXdYIkAH/jvk5VA4Z0KXnf0ZPaLfSGH+
         Ays9gKOSvFXTg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Aharon Landau <aharonl@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>
Subject: [PATCH rdma-rc] RDMA/mlx5: Delay emptying a cache entry when a new MR is added to it recently
Date:   Tue, 27 Jul 2021 10:16:06 +0300
Message-Id: <fcb546986be346684a016f5ca23a0567399145fa.1627370131.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Aharon Landau <aharonl@nvidia.com>

Fixing a typo that causes a cache entry to shrink immediately after
adding to it new MRs if the entry size exceeds the high limit.
In doing so, the cache misses its purpose to prevent the creation of new
mkeys on the runtime by using the cached ones.

Fixes: b9358bdbc713 ("RDMA/mlx5: Fix locking in MR cache work queue")
Signed-off-by: Aharon Landau <aharonl@nvidia.com>
Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 3263851ea574..3f1c5a4f158b 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -531,8 +531,8 @@ static void __cache_work_func(struct mlx5_cache_ent *ent)
 		 */
 		spin_unlock_irq(&ent->lock);
 		need_delay = need_resched() || someone_adding(cache) ||
-			     time_after(jiffies,
-					READ_ONCE(cache->last_add) + 300 * HZ);
+			     !time_after(jiffies,
+					 READ_ONCE(cache->last_add) + 300 * HZ);
 		spin_lock_irq(&ent->lock);
 		if (ent->disabled)
 			goto out;
-- 
2.31.1

