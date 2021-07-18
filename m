Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E17C3CC8EC
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Jul 2021 14:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbhGRMEC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 18 Jul 2021 08:04:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:43640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232685AbhGRMEC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 18 Jul 2021 08:04:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D1D1F6108B;
        Sun, 18 Jul 2021 12:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626609664;
        bh=/spI8vZJgOx7Hs/83Yoh38VeyXJQKdnrhpEDBIKz6po=;
        h=From:To:Cc:Subject:Date:From;
        b=DRSLBE4n25jljqBDXpb1gcTVJ8DsbHAQG/jS9pP4qjiZXPSYGpT93xOuVLIdCNRL1
         sy66tLe6TgEr03s5ih8zXvBb15hlaKA216RZoeGNR1nLL6AzsSo27mvgX6ABORbQN5
         YgSqAxfgE3SX/NYYG1DXmbKnLm2S7xUfctDIaI6IZHE6Xmdm0mpCuYTvx+pDFZs+32
         86uckcWXWj81BQ5I9NCL9ydYK8cX8YxbtoIKWsWtGcfljjdbDFdKhg0gaR5k2kIvbn
         iPZmG3cr3GJDDZjYkvrpRPTBmx605WhZjXrqa7+fDRaeMMuQq91eEaXnEtkmwpRlDu
         ALZBvugkArycg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Christian Benvenuti <benve@cisco.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Gal Pressman <galpress@amazon.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Steve Wise <larrystevenwise@gmail.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Weihang Li <liweihang@huawei.com>,
        Wenpeng Liang <liangwenpeng@huawei.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: [PATCH rdma-next 0/9] QP allocation changes
Date:   Sun, 18 Jul 2021 15:00:50 +0300
Message-Id: <cover.1626609283.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Hi,

This series convert IB/core to use core allocation scheme for the QP
objects.

@Dennis, rdmavt is slightly changed from the previous variant and
preserves the node-aware allocation now.

@hns, please double check the changes in your driver, the mlx4 driver
clearly showed me that XRC flow needs serious rethinking.

Thanks

Leon Romanovsky (9):
  RDMA/hns: Don't skip IB creation flow for regular RC QP
  RDMA/hns: Don't overwrite supplied QP attributes
  RDMA/efa: Remove double QP type assignment
  RDMA/mlx5: Cancel pkey work before destroying device resources
  RDMA/mlx5: Delete device resource mutex that didn't protect anything
  RDMA/mlx5: Rework custom driver QP type creation
  RDMA/rdmavt: Decouple QP and SGE lists allocations
  RDMA: Globally allocate and release QP memory
  RDMA/mlx5: Drop in-driver verbs object creations

 drivers/infiniband/core/core_priv.h           |  27 +++-
 drivers/infiniband/core/device.c              |   2 +
 drivers/infiniband/core/restrack.c            |   2 +-
 drivers/infiniband/core/verbs.c               |  47 +++---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c      |  26 ++--
 drivers/infiniband/hw/bnxt_re/ib_verbs.h      |   7 +-
 drivers/infiniband/hw/bnxt_re/main.c          |   1 +
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h        |   5 +-
 drivers/infiniband/hw/cxgb4/provider.c        |   1 +
 drivers/infiniband/hw/cxgb4/qp.c              |  37 ++---
 drivers/infiniband/hw/efa/efa.h               |   5 +-
 drivers/infiniband/hw/efa/efa_main.c          |   1 +
 drivers/infiniband/hw/efa/efa_verbs.c         |  29 ++--
 drivers/infiniband/hw/hns/hns_roce_device.h   |   5 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c    |   6 +-
 drivers/infiniband/hw/hns/hns_roce_main.c     |   1 +
 drivers/infiniband/hw/hns/hns_roce_qp.c       |  34 ++---
 drivers/infiniband/hw/irdma/utils.c           |   3 -
 drivers/infiniband/hw/irdma/verbs.c           |  31 ++--
 drivers/infiniband/hw/mlx4/main.c             |   1 +
 drivers/infiniband/hw/mlx4/mlx4_ib.h          |   5 +-
 drivers/infiniband/hw/mlx4/qp.c               |  25 ++--
 drivers/infiniband/hw/mlx5/gsi.c              |  51 ++-----
 drivers/infiniband/hw/mlx5/main.c             | 135 ++++++------------
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |   7 +-
 drivers/infiniband/hw/mlx5/qp.c               |  62 +++-----
 drivers/infiniband/hw/mthca/mthca_provider.c  |  77 ++++------
 drivers/infiniband/hw/ocrdma/ocrdma_main.c    |   1 +
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c   |  25 ++--
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.h   |   5 +-
 drivers/infiniband/hw/qedr/main.c             |   1 +
 drivers/infiniband/hw/qedr/qedr_roce_cm.c     |  13 +-
 drivers/infiniband/hw/qedr/qedr_roce_cm.h     |   5 +-
 drivers/infiniband/hw/qedr/verbs.c            |  49 ++-----
 drivers/infiniband/hw/qedr/verbs.h            |   4 +-
 drivers/infiniband/hw/usnic/usnic_ib_main.c   |   1 +
 drivers/infiniband/hw/usnic/usnic_ib_qp_grp.c |  34 ++---
 drivers/infiniband/hw/usnic/usnic_ib_qp_grp.h |  10 +-
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c  |  69 +++++----
 drivers/infiniband/hw/usnic/usnic_ib_verbs.h  |   5 +-
 .../infiniband/hw/vmw_pvrdma/pvrdma_main.c    |   1 +
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c  |  53 +++----
 .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.h   |   5 +-
 drivers/infiniband/sw/rdmavt/qp.c             | 102 ++++++-------
 drivers/infiniband/sw/rdmavt/qp.h             |   5 +-
 drivers/infiniband/sw/rdmavt/vt.c             |   9 ++
 drivers/infiniband/sw/rxe/rxe_pool.c          |   2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c         |  48 +++----
 drivers/infiniband/sw/rxe/rxe_verbs.h         |   2 +-
 drivers/infiniband/sw/siw/siw_main.c          |   1 +
 drivers/infiniband/sw/siw/siw_qp.c            |   2 -
 drivers/infiniband/sw/siw/siw_verbs.c         |  54 +++----
 drivers/infiniband/sw/siw/siw_verbs.h         |   5 +-
 include/rdma/ib_verbs.h                       |  30 +++-
 include/rdma/rdmavt_qp.h                      |   2 +-
 55 files changed, 480 insertions(+), 696 deletions(-)

-- 
2.31.1

