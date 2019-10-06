Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2911ACD338
	for <lists+linux-rdma@lfdr.de>; Sun,  6 Oct 2019 17:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbfJFPvr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 6 Oct 2019 11:51:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:33860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbfJFPvr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 6 Oct 2019 11:51:47 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8101620862;
        Sun,  6 Oct 2019 15:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570377106;
        bh=s0dZxSQw6wQL7v4WypS30ekVth2ufGU5dC9WZWUuAC0=;
        h=From:To:Cc:Subject:Date:From;
        b=b0xkxXJ9y3gr4uZFyt9Ftk8tCAx2Ny0tb2s+TP+DIjoWM2oXC4Vm49DEHH8JSzs/g
         QeZ7zoA/S34a0L25cAIyRUZXqrsrS10VICS1MtryDYy3r03/s1lvmXUMEq0TGOQAzB
         lSJbLnfuxY6gUpy4dhbXuS7jtSGKl5+mpCZHkDvE=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Erez Alfasi <ereza@mellanox.com>
Subject: [PATCH rdma-next v2 0/4] ODP information and statistics
Date:   Sun,  6 Oct 2019 18:51:35 +0300
Message-Id: <20191006155139.30632-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Changelog:
 v2:
 * Since umems can disappear during rereg flow and the fact that we
   are not locking its during our counter usage (uverbs prevents this
   by holding the uobject write lock), expose possible race bugs. Move
   the counters into mlx5_ib_mr to avoid racing bugs (related patches
   - #1, #3 & #4).
 * Fix page invalidation counting (Patch #1).
 * Make the code more elegant by defining fill_function type and use it
   within res_common_{dumpit, doit} (Patch #2).
 * Put an ODP implicit indicator within mlx5 reg MR operation,
   indicating when a given MR is ODP implicit registered and use
   its indication when dumping ODP type.
 * Since the counters has been moved to mlx5_ib_mr, the ODP stats are now
   filled with internal to mlx5 driver function. Remove the fill_odp_stats
   device operation from the reason mentioned above.
 v1: https://lore.kernel.org/linux-rdma/20190830081612.2611-1-leon@kernel.org
 * Dropped umem patch, because it doesn't follow our IB model, where
   UMEM is driver object and ib_core object (Jason).
 * Removed the ODP type indicator from ib_umem_odp not needed after
   commit fd7dbf035edc ("RDMA/odp: Make it clearer when a umem is an implicit ODP umem")
 * Since umems are not part of core MR (from the reason mentioned
   above) there is no way to access the odp type as was previously done via nldev
   (old patch #3). Instead, patch #4 is adding mlx5 implementation for fill_res_entry
   and dumping ODP type as part of the driver table entry, as its driver details.
 * Counter types are now atomic64_t instead of u64.
 v0: https://lore.kernel.org/linux-rdma/20190807103403.8102-1-leon@kernel.org

-----------------------------------------------------------------------------
Hi,

This series from Erez refactors exposes ODP type information (explicit,
implicit) and statistics through netlink interface.

Thanks



Erez Alfasi (4):
  IB/mlx5: Introduce ODP diagnostic counters
  RDMA/nldev: Allow different fill function per resource
  RDMA/mlx5: Return ODP type per MR
  RDMA/nldev: Provide MR statistics

 drivers/infiniband/core/device.c      |  1 +
 drivers/infiniband/core/nldev.c       | 98 ++++++++++++++++++++-------
 drivers/infiniband/hw/mlx5/Makefile   |  2 +-
 drivers/infiniband/hw/mlx5/main.c     |  3 +
 drivers/infiniband/hw/mlx5/mlx5_ib.h  |  9 +++
 drivers/infiniband/hw/mlx5/odp.c      | 20 ++++++
 drivers/infiniband/hw/mlx5/restrack.c | 92 +++++++++++++++++++++++++
 include/rdma/ib_verbs.h               | 13 ++++
 include/rdma/restrack.h               |  6 ++
 9 files changed, 218 insertions(+), 26 deletions(-)
 create mode 100644 drivers/infiniband/hw/mlx5/restrack.c

--
2.20.1

