Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5379520F1C7
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2020 11:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732036AbgF3JjW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Jun 2020 05:39:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:39126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731616AbgF3JjW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 30 Jun 2020 05:39:22 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B64E2206A1;
        Tue, 30 Jun 2020 09:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593509961;
        bh=zcFyweTu/Wd1j3+rxX1bMxZh2mGAoRTczca7ZVHYJok=;
        h=From:To:Cc:Subject:Date:From;
        b=tz2wl9qtszMKPQDu6x4EolZVoaWVv4gKidF81T0Xxt2KYK96pEa+JAjFtmDyQv7n2
         aUfYIbzplPwY0VmlGl0LZP4G6C9TYsH8Gegp6A1CTd6lx0+352A5ablMQtaYwZgPOe
         O5f5du0mAuXtNLnGTYog/i8GeRthYIEZSLxUAY3o=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Steve Wise <larrystevenwise@gmail.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH rdma-next v1 0/7] Introduce UAPIs to query UCONTEXT, PD and MR properties
Date:   Tue, 30 Jun 2020 12:39:09 +0300
Message-Id: <20200630093916.332097-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Changelog
v1:
 * Replaced "KABI" word with "UAPI".
 * Set IOVA as an optional attribute upon query MR.
v0:
https://lore.kernel.org/lkml/20200616105531.2428010-1-leon@kernel.org

------------------------------------------------------------------------------
From Yishai,

This series introduce UAPIs to query existing UCONTEXT, PD and MR for
their properties.

By those UAPIs a user space application which owns the command FD of the
device can retrieve and rebuild the above objects despite that it wasn't
their creator. As of that, PDs and MRs can be shared by any process who
owns the command FD of their creator.

This functionality enables to utilize and optimize some application
flows, few examples below.

Any solution which is a single business logic based on multi-process
design needs this. Example include NGINX, with TCP load balancing, sharing the
RSS indirection table with RQ per process. HPC frameworks with multi-rank
(process) solution on single hosts. UCX can share IB resources using the shared
PD and can help dispatch data to multiple processes/MR's in single RDMA
operation. Also, there are use cases when a primary processes registered a large
shared memory range, and each worker process spawned will create a private QP
on the shared PD, and use the shared MR to save the registration time
per-process.

The matching verbs APIs were introduced in the mailing list by the below RFC [1].

In addition, the series enables CQ ioctl commands by default as this
functionality is fully mature for a long time and sets IOVA on IB MR in
the uverbs layer to let all drivers have it.

[1] https://patchwork.kernel.org/patch/11540665/

Yishai

Yishai Hadas (7):
  IB/uverbs: Enable CQ ioctl commands by default
  IB/uverbs: Set IOVA on IB MR in uverbs layer
  IB/uverbs: Expose UAPI to query ucontext
  RDMA/mlx5: Refactor mlx5_ib_alloc_ucontext() response
  RDMA/mlx5: Implement the query ucontext functionality
  RDMA/mlx5: Introduce UAPI to query PD attributes
  IB/uverbs: Expose UAPI to query MR

 drivers/infiniband/Kconfig                    |   8 -
 drivers/infiniband/core/device.c              |   1 +
 drivers/infiniband/core/uverbs_cmd.c          |   4 +
 drivers/infiniband/core/uverbs_ioctl.c        |   1 +
 drivers/infiniband/core/uverbs_std_types_cq.c |   3 -
 .../infiniband/core/uverbs_std_types_device.c |  41 +++-
 drivers/infiniband/core/uverbs_std_types_mr.c |  52 +++-
 drivers/infiniband/hw/cxgb4/mem.c             |   1 -
 drivers/infiniband/hw/mlx4/mr.c               |   1 -
 drivers/infiniband/hw/mlx5/Makefile           |   3 +-
 drivers/infiniband/hw/mlx5/main.c             | 232 ++++++++++--------
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |   2 +
 drivers/infiniband/hw/mlx5/std_types.c        |  45 ++++
 include/rdma/ib_verbs.h                       |   4 +
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  15 ++
 include/uapi/rdma/mlx5_user_ioctl_cmds.h      |  14 ++
 16 files changed, 308 insertions(+), 119 deletions(-)
 create mode 100644 drivers/infiniband/hw/mlx5/std_types.c

--
2.26.2

