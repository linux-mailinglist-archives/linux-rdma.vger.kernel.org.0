Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14D292C583
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2019 13:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfE1Lhi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 May 2019 07:37:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:39444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbfE1Lhh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 28 May 2019 07:37:37 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D09DB2070D;
        Tue, 28 May 2019 11:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559043456;
        bh=ez4QsmLJtdx8GpBKed9zdhWgYCcYCZo22qO4Uvv19hA=;
        h=From:To:Cc:Subject:Date:From;
        b=abCXDaiG8cYmj2I3UPlCqZF21ti7xXrx5HwIajNTRl4m2wzxvbfHiEUS56ryH7swD
         cqHfFqJjYNKY8ov4oHI+Fb6pBaICBicf5CQeVkw1YuhMX11Tubh0e+q75ipWJbR0S9
         lZuI+nJkhorb7PEgvS7SEhjfqNRJGh564ifF4CHM=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-next v1 0/3] Convert CQ allocations
Date:   Tue, 28 May 2019 14:37:26 +0300
Message-Id: <20190528113729.13314-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Hi,

This is second version of my CQ allocation patches, rebased to latest
rdma/wip/for-next branch with changes requested by Gal.

Thanks

Leon Romanovsky (3):
  RDMA/nes: Avoid memory allocation during CQ destroy
  RDMA: Clean destroy CQ in drivers do not return errors
  RDMA: Convert CQ allocations to be under core responsibility

 drivers/infiniband/core/cq.c                  |  33 +++---
 drivers/infiniband/core/device.c              |   1 +
 drivers/infiniband/core/uverbs_cmd.c          |  15 ++-
 drivers/infiniband/core/uverbs_std_types_cq.c |  19 ++-
 drivers/infiniband/core/verbs.c               |  35 +++---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c      |  33 ++----
 drivers/infiniband/hw/bnxt_re/ib_verbs.h      |   9 +-
 drivers/infiniband/hw/bnxt_re/main.c          |   1 +
 drivers/infiniband/hw/cxgb3/cxio_hal.c        |   6 +-
 drivers/infiniband/hw/cxgb3/cxio_hal.h        |   2 +-
 drivers/infiniband/hw/cxgb3/iwch_provider.c   |  46 +++-----
 drivers/infiniband/hw/cxgb4/cq.c              |  40 +++----
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h        |   7 +-
 drivers/infiniband/hw/cxgb4/provider.c        |   1 +
 drivers/infiniband/hw/efa/efa.h               |   7 +-
 drivers/infiniband/hw/efa/efa_main.c          |   1 +
 drivers/infiniband/hw/efa/efa_verbs.c         |  59 +++-------
 drivers/infiniband/hw/hns/hns_roce_cq.c       |  69 +++++------
 drivers/infiniband/hw/hns/hns_roce_device.h   |  10 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c    |  35 +++---
 drivers/infiniband/hw/hns/hns_roce_main.c     |   1 +
 drivers/infiniband/hw/i40iw/i40iw_verbs.c     |  36 +++---
 drivers/infiniband/hw/mlx4/cq.c               |  29 ++---
 drivers/infiniband/hw/mlx4/main.c             |   1 +
 drivers/infiniband/hw/mlx4/mlx4_ib.h          |   7 +-
 drivers/infiniband/hw/mlx5/cq.c               |  36 ++----
 drivers/infiniband/hw/mlx5/main.c             |  21 ++--
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |   7 +-
 drivers/infiniband/hw/mthca/mthca_provider.c  |  40 +++----
 drivers/infiniband/hw/nes/nes_utils.c         |   4 +-
 drivers/infiniband/hw/nes/nes_verbs.c         | 108 ++++++------------
 drivers/infiniband/hw/ocrdma/ocrdma_hw.c      |   8 +-
 drivers/infiniband/hw/ocrdma/ocrdma_hw.h      |   2 +-
 drivers/infiniband/hw/ocrdma/ocrdma_main.c    |   1 +
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c   |  35 +++---
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.h   |   7 +-
 drivers/infiniband/hw/qedr/main.c             |   1 +
 drivers/infiniband/hw/qedr/verbs.c            |  48 ++------
 drivers/infiniband/hw/qedr/verbs.h            |   7 +-
 drivers/infiniband/hw/usnic/usnic_ib.h        |   4 +
 drivers/infiniband/hw/usnic/usnic_ib_main.c   |   1 +
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c  |  22 +---
 drivers/infiniband/hw/usnic/usnic_ib_verbs.h  |   7 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c  |  40 +++----
 .../infiniband/hw/vmw_pvrdma/pvrdma_main.c    |   1 +
 .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.h   |   7 +-
 drivers/infiniband/sw/rdmavt/cq.c             |  57 +++------
 drivers/infiniband/sw/rdmavt/cq.h             |   7 +-
 drivers/infiniband/sw/rdmavt/vt.c             |   1 +
 drivers/infiniband/sw/rxe/rxe_pool.c          |   1 +
 drivers/infiniband/sw/rxe/rxe_verbs.c         |  33 ++----
 drivers/infiniband/sw/rxe/rxe_verbs.h         |   2 +-
 include/rdma/ib_verbs.h                       |   8 +-
 53 files changed, 405 insertions(+), 614 deletions(-)

--
2.20.1

