Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8D6BA31F8
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Aug 2019 10:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfH3IQU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Aug 2019 04:16:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:36136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbfH3IQU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 30 Aug 2019 04:16:20 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1492B2173E;
        Fri, 30 Aug 2019 08:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567152979;
        bh=CHEoQfCm1YYks5m9CE0FAV+k2+1u+Owj1fKCuWM7S9Y=;
        h=From:To:Cc:Subject:Date:From;
        b=DDnn6vZjyVJX4MMNZ7r2ZWMxpyqXO/tQIc49Os6xpXPG+N3PlemZgQFZCxCzqZgoj
         LTDGM4nymZbCjUjUWSsrSypEzMCEqvTsmgucE4RbJ8PTEFpc1SIYItTuMt/+CO5X87
         F+nxl2F/b7rK1kkU8EZV/nsnW1GuLi0ms/ex8pH4=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Erez Alfasi <ereza@mellanox.com>
Subject: [PATCH rdma-next v1 0/4] ODP information and statistics
Date:   Fri, 30 Aug 2019 11:16:08 +0300
Message-Id: <20190830081612.2611-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Changelog:
 v1:
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
  RDMA/nldev: Provide MR statistics
  RDMA/mlx5: Return ODP type per MR

 drivers/infiniband/core/device.c      |   1 +
 drivers/infiniband/core/nldev.c       | 109 ++++++++++++++++++++++----
 drivers/infiniband/hw/mlx5/Makefile   |   2 +-
 drivers/infiniband/hw/mlx5/main.c     |  17 ++++
 drivers/infiniband/hw/mlx5/mlx5_ib.h  |   2 +
 drivers/infiniband/hw/mlx5/odp.c      |  18 +++++
 drivers/infiniband/hw/mlx5/restrack.c |  48 ++++++++++++
 include/rdma/ib_umem_odp.h            |  14 ++++
 include/rdma/ib_verbs.h               |   9 +++
 include/rdma/restrack.h               |   3 +
 10 files changed, 207 insertions(+), 16 deletions(-)
 create mode 100644 drivers/infiniband/hw/mlx5/restrack.c

--
2.20.1

