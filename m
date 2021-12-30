Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B31FE481BA9
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Dec 2021 12:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238884AbhL3LXc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Dec 2021 06:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235325AbhL3LXc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Dec 2021 06:23:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE25C061574
        for <linux-rdma@vger.kernel.org>; Thu, 30 Dec 2021 03:23:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 396B261640
        for <linux-rdma@vger.kernel.org>; Thu, 30 Dec 2021 11:23:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D40C36AEA;
        Thu, 30 Dec 2021 11:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640863410;
        bh=fZv2VfIXjQcyLAqwoA2OuUsuIbneLIyOw0TwRQH7MvE=;
        h=From:To:Cc:Subject:Date:From;
        b=HR2flGcl3blBwuXnJ6MmBr5To5U5QCPdvjry3d7cnNaZCqWlp7lOppOC0OdSpow2r
         7XhIoYnSYsXZDMc3Rw4AItXrbJE+ipEJSbyOfJqDZpdCIPBmIZ3LgEFyFZlGRrTzeL
         NbauvTStdr7vM5YcmQ1SlbcvvhQZbydH90v244OS27W+8NN2z04uAi5jxHJj50jzDD
         GYym22Kclc0hGmUv09bPLbAX+YdUx8cSZBqxNqw84P2RelpWKRfxP7u0HOvp4k4zfR
         Lx+5eFwKcJAKI/9ZYB6+0eX5qTq2H8T2ElsqH+0IVG/YkEcX41yhgHg9t+jg/0WGDT
         h8q7hHnVNY06g==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Aharon Landau <aharonl@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 0/7] MR cache enhancement
Date:   Thu, 30 Dec 2021 13:23:17 +0200
Message-Id: <cover.1640862842.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Changelog:
v1:
 * Based on DM revert https://lore.kernel.org/all/20211222101312.1358616-1-maorg@nvidia.com
v0: https://lore.kernel.org/all/cover.1638781506.git.leonro@nvidia.com

---------------------------------------------------------
Hi,

This series from Aharon refactors mlx5 MR cache management logic to
speedup deregistration significantly.

Thanks

Aharon Landau (7):
  RDMA/mlx5: Merge similar flows of allocating MR from the cache
  RDMA/mlx5: Replace cache list with Xarray
  RDMA/mlx5: Store in the cache mkeys instead of mrs
  RDMA/mlx5: Reorder calls to pcie_relaxed_ordering_enabled()
  RDMA/mlx5: Change the cache structure to an RB-tree
  RDMA/mlx5: Delay the deregistration of a non-cache mkey
  RDMA/mlx5: Rename the mkey cache variables and functions

 drivers/infiniband/hw/mlx5/main.c    |    4 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h |   76 +-
 drivers/infiniband/hw/mlx5/mr.c      | 1021 +++++++++++++++++---------
 drivers/infiniband/hw/mlx5/odp.c     |   72 +-
 include/linux/mlx5/driver.h          |    7 +-
 5 files changed, 741 insertions(+), 439 deletions(-)

-- 
2.33.1

