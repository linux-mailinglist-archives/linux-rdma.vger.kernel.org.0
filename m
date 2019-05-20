Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0388922C55
	for <lists+linux-rdma@lfdr.de>; Mon, 20 May 2019 08:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730509AbfETGyj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 May 2019 02:54:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:38818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbfETGyj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 May 2019 02:54:39 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F2F220815;
        Mon, 20 May 2019 06:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558335278;
        bh=PPzOI31Tx6X4avGvIH7BUB7JNBqFfZvvNA0wk4B3mpg=;
        h=From:To:Cc:Subject:Date:From;
        b=vfdxlKSVOBJuPwF44MoTK8WwWBsCwTP3HYpdbtQ2Bc8zcDP6SBFFcACe3ioBI7+TM
         2zJUvnzoaxCKpLIWB6SBCF4HTvFdxt+SLHGrNVERIAqnSMRLgF96MAQcPZxtr95G8p
         yLb3afG9tDUWZ9nhAlEF4NEoOAj32dqslAgMuPtU=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Glenn Streiff <gstreiff@neteffect.com>,
        Steve Wise <swise@opengridcomputing.com>
Subject: [PATCH rdma-next 00/15] Convert CQ allocations
Date:   Mon, 20 May 2019 09:54:18 +0300
Message-Id: <20190520065433.8734-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Hi,

This is my next series of allocation conversion patches.

Thanks

Leon Romanovsky (15):
  rds: Don't check return value from destroy CQ
  RDMA/ipoib: Remove check of destroy CQ
  RDMA/core: Make ib_destroy_cq() void
  RDMA/efa: Remove check that prevents destroy of resources in error
    flows
  RDMA/nes: Remove useless NULL checks
  RDMA/i40iw: Remove useless NULL checks
  RDMA/nes: Remove second wait queue initialization call
  RDMA/nes: Avoid memory allocation during CQ destroy
  RDMA: Clean destroy CQ in drivers do not return errors
  RDMA/cxgb3: Use sizeof() notation instead of plain sizeof
  RDMA/cxgb3: Don't expose DMA addresses
  RDMA/cxgb3: Delete and properly mark unimplemented resize CQ function
  RDMA/cxgb4: Use sizeof() notation
  RDMA/cxgb4: Don't expose DMA addresses
  RDMA: Convert CQ allocations to be under core responsibility

 drivers/infiniband/core/cq.c                  |  33 ++--
 drivers/infiniband/core/device.c              |   1 +
 drivers/infiniband/core/uverbs_cmd.c          |  15 +-
 drivers/infiniband/core/uverbs_std_types_cq.c |  19 ++-
 drivers/infiniband/core/verbs.c               |  35 ++--
 drivers/infiniband/hw/bnxt_re/ib_verbs.c      |  33 ++--
 drivers/infiniband/hw/bnxt_re/ib_verbs.h      |   9 +-
 drivers/infiniband/hw/bnxt_re/main.c          |   1 +
 drivers/infiniband/hw/cxgb3/cxio_hal.c        |  30 +---
 drivers/infiniband/hw/cxgb3/cxio_hal.h        |   3 +-
 drivers/infiniband/hw/cxgb3/iwch_cm.c         |   2 +-
 drivers/infiniband/hw/cxgb3/iwch_provider.c   | 150 +++++-------------
 drivers/infiniband/hw/cxgb4/cm.c              |  12 +-
 drivers/infiniband/hw/cxgb4/cq.c              |  55 +++----
 drivers/infiniband/hw/cxgb4/device.c          |   9 +-
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h        |   7 +-
 drivers/infiniband/hw/cxgb4/mem.c             |   2 +-
 drivers/infiniband/hw/cxgb4/provider.c        |   2 +-
 drivers/infiniband/hw/cxgb4/qp.c              |  41 +++--
 drivers/infiniband/hw/cxgb4/resource.c        |  16 +-
 drivers/infiniband/hw/efa/efa.h               |   7 +-
 drivers/infiniband/hw/efa/efa_main.c          |   1 +
 drivers/infiniband/hw/efa/efa_verbs.c         |  96 +++--------
 drivers/infiniband/hw/hns/hns_roce_cq.c       |  69 ++++----
 drivers/infiniband/hw/hns/hns_roce_device.h   |  10 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c    |  35 ++--
 drivers/infiniband/hw/hns/hns_roce_main.c     |   1 +
 drivers/infiniband/hw/i40iw/i40iw_verbs.c     |  44 ++---
 drivers/infiniband/hw/mlx4/cq.c               |  29 ++--
 drivers/infiniband/hw/mlx4/main.c             |   1 +
 drivers/infiniband/hw/mlx4/mlx4_ib.h          |   7 +-
 drivers/infiniband/hw/mlx5/cq.c               |  36 ++---
 drivers/infiniband/hw/mlx5/main.c             |  21 ++-
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |   7 +-
 drivers/infiniband/hw/mthca/mthca_provider.c  |  40 ++---
 drivers/infiniband/hw/nes/nes_utils.c         |   5 +-
 drivers/infiniband/hw/nes/nes_verbs.c         | 114 +++++--------
 drivers/infiniband/hw/ocrdma/ocrdma_hw.c      |   8 +-
 drivers/infiniband/hw/ocrdma/ocrdma_hw.h      |   2 +-
 drivers/infiniband/hw/ocrdma/ocrdma_main.c    |   1 +
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c   |  35 ++--
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.h   |   7 +-
 drivers/infiniband/hw/qedr/main.c             |   1 +
 drivers/infiniband/hw/qedr/verbs.c            |  48 ++----
 drivers/infiniband/hw/qedr/verbs.h            |   7 +-
 drivers/infiniband/hw/usnic/usnic_ib.h        |   4 +
 drivers/infiniband/hw/usnic/usnic_ib_main.c   |   1 +
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c  |  22 +--
 drivers/infiniband/hw/usnic/usnic_ib_verbs.h  |   7 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c  |  40 ++---
 .../infiniband/hw/vmw_pvrdma/pvrdma_main.c    |   1 +
 .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.h   |   7 +-
 drivers/infiniband/sw/rdmavt/cq.c             |  57 ++-----
 drivers/infiniband/sw/rdmavt/cq.h             |   7 +-
 drivers/infiniband/sw/rdmavt/vt.c             |   1 +
 drivers/infiniband/sw/rxe/rxe_pool.c          |   1 +
 drivers/infiniband/sw/rxe/rxe_verbs.c         |  33 ++--
 drivers/infiniband/sw/rxe/rxe_verbs.h         |   2 +-
 drivers/infiniband/ulp/ipoib/ipoib_verbs.c    |   7 +-
 include/rdma/ib_verbs.h                       |  12 +-
 net/rds/ib_cm.c                               |   8 +-
 61 files changed, 490 insertions(+), 827 deletions(-)

--
2.20.1

