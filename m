Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE9C279844
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Sep 2020 12:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgIZKTp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 26 Sep 2020 06:19:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:35974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725208AbgIZKTo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 26 Sep 2020 06:19:44 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A4FA238E2;
        Sat, 26 Sep 2020 10:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601115584;
        bh=gFlyd1DVt3Rvdc0DUq+u9rBUBu1g9efr1klF3OCDtgM=;
        h=From:To:Cc:Subject:Date:From;
        b=Nflp3iaxjMwVtFjOoWWgMGH5ce9o71CuF3qq0LRlCElb0CL+sc63byKZ7MfniXGa8
         iuZtkSoBZfssWfVekNj57EMCiacUQIKUbBVRDQl79fzl8ZeRWk9z9QeG0iqhPwShwW
         +lH38RYjwBkJrNkrkSxch620VNW0CvnYOR34YcUk=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Ariel Levkovich <lariel@mellanox.com>,
        Gal Pressman <galpress@amazon.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Mark Zhang <markz@nvidia.com>,
        Sean Hefty <sean.hefty@intel.com>,
        Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-next v3 0/9] Track memory allocation with restrack DB help
Date:   Sat, 26 Sep 2020 13:19:29 +0300
Message-Id: <20200926101938.2964394-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Changelog:
v3:
 * Rebased on already accepted patches.
 * Added mlx4 special QPs to the list of not-tracked QPs (dropped previous mlx4 special QP patch).
 * Separated to two patches change in return value of cma_listen_* routines.
 * Changed commit messages and added Fixes as Jason requested.
v2: https://lore.kernel.org/linux-rdma/20200907122156.478360-1-leon@kernel.org/
 * Added new patch to fix mlx4 failure on SR-IOV, it didn't have port set.
 * Changed "RDMA/cma: Delete from restrack DB after successful destroy" patch.
v1: https://lore.kernel.org/lkml/20200830101436.108487-1-leon@kernel.org
 * Fixed rebase error, deleted second assignment of qp_type.
 * Rebased code on latests rdma-next, the changes in cma.c caused to change
   in patch "RDMA/cma: Delete from restrack DB after successful destroy".
 * Dropped patch of port assignment, it is already done as part of this
   series.
 * I didn't add @calller description, regular users should not use _named() funciton.
v0: https://lore.kernel.org/lkml/20200824104415.1090901-1-leon@kernel.org

----------------------------------------------------------------------------------
Hi,

The resource tracker has built-in kref counter to synchronize object
release. It makes restrack perfect choice to be responsible for the
memory lifetime of any object in which restrack entry is embedded.

In order to make it, the restrack was changed to be mandatory and all
callers of rdma_restrack_add() started to rely on result returned from
that call. Being mandatory means that all objects specific to restrack
type must be tracked.

Before this series, the restrack and rdmatool were aid tools in debug
session of user space applications, this caused to some of the
functionality to be left behind, like support XRC QPs, device memory MRs
and QP0/QP1 in multi-port devices.

This series fixes all mentioned above without extending rdmatool at all.

Thanks

Leon Romanovsky (9):
  RDMA/core: Allow drivers to disable restrack DB
  RDMA/counter: Combine allocation and bind logic
  RDMA/restrack: Store all special QPs in restrack DB
  RDMA/cma: Add missing error handling of listen_id
  RDMA/cma: Be strict with attaching to CMA device
  RDMA/restrack: Add error handling while adding restrack object
  RDMA/restrack: Support all QP types
  RDMA/core: Track device memory MRs
  RDMA/restrack: Drop valid restrack field as source of ambiguity

 drivers/infiniband/core/cma.c                 | 226 +++++++++++-------
 drivers/infiniband/core/core_priv.h           |  32 ++-
 drivers/infiniband/core/counters.c            | 167 ++++++-------
 drivers/infiniband/core/cq.c                  |  17 +-
 drivers/infiniband/core/rdma_core.c           |   3 +-
 drivers/infiniband/core/restrack.c            |  64 ++---
 drivers/infiniband/core/restrack.h            |   2 +-
 drivers/infiniband/core/uverbs_cmd.c          |  31 ++-
 drivers/infiniband/core/uverbs_std_types_cq.c |   6 +-
 drivers/infiniband/core/uverbs_std_types_mr.c |  10 +
 drivers/infiniband/core/uverbs_std_types_qp.c |   4 +-
 drivers/infiniband/core/verbs.c               |  74 ++++--
 drivers/infiniband/hw/mlx4/qp.c               |   5 +
 drivers/infiniband/hw/mlx5/qp.c               |   2 +-
 include/rdma/ib_verbs.h                       |  10 +-
 include/rdma/restrack.h                       |  27 ++-
 16 files changed, 416 insertions(+), 264 deletions(-)

--
2.26.2

