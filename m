Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3314F2B59F9
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Nov 2020 08:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgKQHBz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Nov 2020 02:01:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:57454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbgKQHBy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 17 Nov 2020 02:01:54 -0500
Received: from localhost (thunderhill.nvidia.com [216.228.112.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22FF4241A6;
        Tue, 17 Nov 2020 07:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605596513;
        bh=F9nczTQGYkSFtNatdOGDtmL3fXRqk522Wwk8t9ZSgD4=;
        h=From:To:Cc:Subject:Date:From;
        b=EKvG/6RRxoZkJdDAAE7nVFcOzZnEbrVziizhvLF7Kn1QmWasYfrmo2g+pNXGInijq
         +7APxZ7QKauXmTKu5q4mLn3dYFpm+eFHOU3+GTA4Itye3lhE2WAs4oR81tF7O4L0Ck
         sH+9onwF4zPk4Cz5DCKg79mBaiMUqKq/JRWXyylA=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Ariel Levkovich <lariel@mellanox.com>,
        Gal Pressman <galpress@amazon.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Mark Zhang <markz@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-next v5 0/3] Track memory allocation with restrack DB help (Part II)
Date:   Tue, 17 Nov 2020 09:01:45 +0200
Message-Id: <20201117070148.1974114-1-leon@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Changelog:
v5:
 * Reorder patches to postpone changes in rdma_restrack_add to be in next series.
v4: https://lore.kernel.org/linux-rdma/20201104144008.3808124-1-leon@kernel.org/
 * Rebased on latest for-upstream, all that time the patches were in
 our regression and didn't introduce any issues.
 * Took first five patches that hadn't any comments
v3: https://lore.kernel.org/lkml/20200926101938.2964394-1-leon@kernel.org
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

Leon Romanovsky (3):
  RDMA/core: Track device memory MRs
  RDMA/core: Allow drivers to disable restrack DB
  RDMA/restrack: Support all QP types

 drivers/infiniband/core/core_priv.h           | 25 ++++++-------------
 drivers/infiniband/core/counters.c            |  2 +-
 drivers/infiniband/core/restrack.c            | 12 +++++++--
 drivers/infiniband/core/uverbs_cmd.c          |  4 +--
 drivers/infiniband/core/uverbs_std_types_mr.c |  4 +++
 drivers/infiniband/core/uverbs_std_types_qp.c |  4 +--
 drivers/infiniband/core/verbs.c               | 11 ++++----
 drivers/infiniband/hw/mlx4/qp.c               |  5 ++++
 drivers/infiniband/hw/mlx5/qp.c               |  2 +-
 include/rdma/ib_verbs.h                       | 10 ++++++--
 include/rdma/restrack.h                       | 24 ++++++++++++++++++
 11 files changed, 70 insertions(+), 33 deletions(-)

--
2.28.0

