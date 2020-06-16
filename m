Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D15E1FAEBF
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2020 12:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgFPK6Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Jun 2020 06:58:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:37520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbgFPK6Y (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 16 Jun 2020 06:58:24 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13DAD20786;
        Tue, 16 Jun 2020 10:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592305103;
        bh=8qNxrnp6z6ekXhfP+uczjm8VmbyvtGHqi7Kjq8Sflzw=;
        h=From:To:Cc:Subject:Date:From;
        b=VQVoElO5ym3X1nZDI9kDkBuC+GEfV02LAoBvx7AEBgiDsZQVmbD7k/DVQjrIoMmby
         WgkPMAa7ObpenSRy3ei9G/pKegGSnTaKLLnpjw8hvAeTzfR0N6DGQVUMOIhY5PsKFD
         +KMlFA6U92Qsgj9J0H1v9NTMM0v2E8EBfU07ETMM=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Steve Wise <larrystevenwise@gmail.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH rdma-next 0/7] Introduce KABIs to query UCONTEXT, PD and MR properties
Date:   Tue, 16 Jun 2020 13:55:24 +0300
Message-Id: <20200616105531.2428010-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

From Yishai,

This series introduce KABIs to query existing UCONTEXT, PD and MR for their
properties.

By those KABIs a user space application which owns the command FD of the device
can retrieve and rebuild the above objects despite that it wasn't their creator.
As of that, PDs and MRs can be shared by any process who owns the command FD of
their creator.

This functionality enables to utilize and optimize some application flows, few
examples below.

Any solution which is a single business logic based on multi-process design
needs this. Example include NGINX, with TCP load balancing, sharing the RSS
indirection table with RQ per process. HPC frameworks with multi-rank (process)
solution on single hosts. UCX can share IB resources using the shared PD and
can help dispatch data to multiple processes/MR's in single RDMA operation.
Also, there are use cases when a primary processes registered a large shared
memory range, and each worker process spawned will create a private QP on the
shared PD, and use the shared MR to save the registration time per-process.

The matching verbs APIs were introduced in the mailing list by the below RFC [1].

In addition, the series enables CQ ioctl commands by default as this
functionality is fully mature for a long time and sets IOVA on IB MR in the uverbs
layer to let all drivers have it.

[1] https://patchwork.kernel.org/patch/11540665/

Yishai

Yishai Hadas (7):
  IB/uverbs: Enable CQ ioctl commands by default
  IB/uverbs: Set IOVA on IB MR in uverbs layer
  IB/uverbs: Expose KABI to query ucontext
  RDMA/mlx5: Refactor mlx5_ib_alloc_ucontext() response
  RDMA/mlx5: Implement the query ucontext functionality
  RDMA/mlx5: Introduce KABI to query PD attributes
  IB/uverbs: Expose KABI to query MR

 drivers/infiniband/Kconfig                    |   8 -
 drivers/infiniband/core/device.c              |   1 +
 drivers/infiniband/core/uverbs_cmd.c          |   4 +
 drivers/infiniband/core/uverbs_ioctl.c        |   1 +
 drivers/infiniband/core/uverbs_std_types_cq.c |   3 -
 .../infiniband/core/uverbs_std_types_device.c |  41 +++-
 drivers/infiniband/core/uverbs_std_types_mr.c |  50 +++-
 drivers/infiniband/hw/cxgb4/mem.c             |   1 -
 drivers/infiniband/hw/mlx4/mr.c               |   1 -
 drivers/infiniband/hw/mlx5/Makefile           |   3 +-
 drivers/infiniband/hw/mlx5/main.c             | 232 ++++++++++--------
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |   2 +
 drivers/infiniband/hw/mlx5/std_types.c        |  45 ++++
 include/rdma/ib_verbs.h                       |   4 +
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  15 ++
 include/uapi/rdma/mlx5_user_ioctl_cmds.h      |  14 ++
 16 files changed, 306 insertions(+), 119 deletions(-)
 create mode 100644 drivers/infiniband/hw/mlx5/std_types.c

--
2.26.2

