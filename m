Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11FA01D2F06
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2020 14:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgENMDI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 May 2020 08:03:08 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:36990 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726128AbgENMDI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 May 2020 08:03:08 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 14 May 2020 15:03:05 +0300
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx [10.209.102.136])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 04EC35v4004171;
        Thu, 14 May 2020 15:03:05 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     bvanassche@acm.org, jgg@mellanox.com, linux-rdma@vger.kernel.org,
        dledford@redhat.com, leon@kernel.org
Cc:     sagi@grimberg.me, israelr@mellanox.com, shlomin@mellanox.com,
        Max Gurtovoy <maxg@mellanox.com>
Subject: [PATCH 0/8 v1] Remove FMR support from RDMA drivers
Date:   Thu, 14 May 2020 15:02:57 +0300
Message-Id: <20200514120305.189738-1-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series removes the support for FMR mode to register memory. This ancient
mode is unsafe and not maintained/tested in the last few years. It also doesn't
have any reasonable advantage over other memory registration methods such as
FRWR (that is implemented in all the recent RDMA adapters). This series should
be reviewed and approved by the maintainer of the effected drivers and I
suggest to test it as well.

The tests that I made for this series (fio benchmarks and fio verify data):
1. iSER initiator on ConnectX-4
2. iSER initiator on ConnectX-3
3. SRP initiator on ConnectX-4 (loopback to SRP target)
4. SRP initiator on ConnectX-3

Not tested:
1. RDS
2. mthca
3. rdmavt

Israel Rukshin (1):
  RDMA/iser: Remove support for FMR memory registration

Max Gurtovoy (7):
  RDMA/mlx4: remove FMR support for memory registration
  RDMA/rds: remove FMR support for memory registration
  RDMA/mthca: remove FMR support for memory registration
  RDMA/rdmavt: remove FMR memory registration
  RDMA/srp: remove support for FMR memory registration
  RDMA/core: remove FMR pool API
  RDMA/core: remove FMR device ops

 Documentation/driver-api/infiniband.rst      |   3 -
 Documentation/infiniband/core_locking.rst    |   2 -
 drivers/infiniband/core/Makefile             |   2 +-
 drivers/infiniband/core/device.c             |   4 -
 drivers/infiniband/core/fmr_pool.c           | 494 ---------------------------
 drivers/infiniband/core/verbs.c              |  48 ---
 drivers/infiniband/hw/mlx4/main.c            |  10 -
 drivers/infiniband/hw/mlx4/mlx4_ib.h         |  16 -
 drivers/infiniband/hw/mlx4/mr.c              |  93 -----
 drivers/infiniband/hw/mthca/mthca_dev.h      |  10 -
 drivers/infiniband/hw/mthca/mthca_mr.c       | 262 +-------------
 drivers/infiniband/hw/mthca/mthca_provider.c |  86 -----
 drivers/infiniband/sw/rdmavt/mr.c            | 154 ---------
 drivers/infiniband/sw/rdmavt/mr.h            |  15 -
 drivers/infiniband/sw/rdmavt/vt.c            |   4 -
 drivers/infiniband/ulp/iser/iscsi_iser.h     |  79 +----
 drivers/infiniband/ulp/iser/iser_initiator.c |  19 +-
 drivers/infiniband/ulp/iser/iser_memory.c    | 188 +---------
 drivers/infiniband/ulp/iser/iser_verbs.c     | 126 +------
 drivers/infiniband/ulp/srp/ib_srp.c          | 222 +-----------
 drivers/infiniband/ulp/srp/ib_srp.h          |  27 +-
 drivers/net/ethernet/mellanox/mlx4/mr.c      | 183 ----------
 include/linux/mlx4/device.h                  |  21 +-
 include/rdma/ib_fmr_pool.h                   |  93 -----
 include/rdma/ib_verbs.h                      |  45 ---
 net/rds/Makefile                             |   2 +-
 net/rds/ib.c                                 |  14 +-
 net/rds/ib.h                                 |   1 -
 net/rds/ib_cm.c                              |   4 +-
 net/rds/ib_fmr.c                             | 269 ---------------
 net/rds/ib_mr.h                              |  12 -
 net/rds/ib_rdma.c                            |  16 +-
 32 files changed, 77 insertions(+), 2447 deletions(-)
 delete mode 100644 drivers/infiniband/core/fmr_pool.c
 delete mode 100644 include/rdma/ib_fmr_pool.h
 delete mode 100644 net/rds/ib_fmr.c

-- 
1.8.3.1

