Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252F04F1181
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Apr 2022 10:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245535AbiDDJAU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Apr 2022 05:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235945AbiDDJAU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Apr 2022 05:00:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCB83BA5D
        for <linux-rdma@vger.kernel.org>; Mon,  4 Apr 2022 01:58:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 660F8B808C5
        for <linux-rdma@vger.kernel.org>; Mon,  4 Apr 2022 08:58:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE424C34110;
        Mon,  4 Apr 2022 08:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649062702;
        bh=ZUKpPdjqMZfECHyOAIq0TofKSenKowcBPazC6skOMY4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ugTjo1vH02Q6BK3Mkss9WOUsABy4c0VV9H9y/g/pQ5pokowuYAHyqLYefKYEnRXaW
         RXJFXanN1NJ+eJmAlGgKs2BTr4O6O66fMTmNLmIU0CIGhYoGMcJDjptKF7cM5r7Sn9
         A+gWGftMJTkK3E4ih46+0f8JSgk3qWZSPPMTnBDP1tOMsD/0ADuxnYIteFm9op5wRo
         sstt370l82WM8A8YfYuwnuUeLeCbRpQqmMgr9yMZ0/gqyW1Mw4pOJxjvP2G7i0tYPC
         6gnV4FHqqgNf3AyQhxgkG9Ij/K8T1AKoCkFhSY/YP2Stqhqu1hjd2CgXHJl+OTm0M3
         npPG3TvtTXl0w==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Aharon Landau <aharonl@nvidia.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>,
        Mark Zhang <markzhang@nvidia.com>,
        Shay Drory <shayd@nvidia.com>
Subject: [PATCH rdma-rc v1 1/3] RDMA/mlx5: Don't remove cache MRs when a delay is needed
Date:   Mon,  4 Apr 2022 11:58:03 +0300
Message-Id: <c3087a90ff362c8796c7eaa2715128743ce36722.1649062436.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1649062436.git.leonro@nvidia.com>
References: <cover.1649062436.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Aharon Landau <aharonl@nvidia.com>

Don't remove MRs from the cache if need to delay the removal.

Fixes: b9358bdbc713 ("RDMA/mlx5: Fix locking in MR cache work queue")
Signed-off-by: Aharon Landau <aharonl@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 956f8e875daa..45b0680377ec 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -574,8 +574,10 @@ static void __cache_work_func(struct mlx5_cache_ent *ent)
 		spin_lock_irq(&ent->lock);
 		if (ent->disabled)
 			goto out;
-		if (need_delay)
+		if (need_delay) {
 			queue_delayed_work(cache->wq, &ent->dwork, 300 * HZ);
+			goto out;
+		}
 		remove_cache_mr_locked(ent);
 		queue_adjust_cache_locked(ent);
 	}
-- 
2.35.1

