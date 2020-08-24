Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 578E724FB7F
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Aug 2020 12:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgHXKc6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Aug 2020 06:32:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:55352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgHXKcx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 24 Aug 2020 06:32:53 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CD0820639;
        Mon, 24 Aug 2020 10:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598265172;
        bh=8DeFfIcdXJghB7NzIwwL1peH2xcicQGi9Trx+qh88bw=;
        h=From:To:Cc:Subject:Date:From;
        b=itX1JqqAE3a9AUhs0yPJnkuAWn59y1FYNR6HgRgfHvIdOy0WSW6n4uzaojjHdWmLv
         j4X+sKax2zi3F1zB4vzIZyKa5KafozYOfAgNrrM8Pi5bPnKXdZDuT51tNh8UW4jqBE
         PhtO97eBwyAmN72yBpmDgpE5IZLXEIz2A1JfBrrs=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Christian Benvenuti <benve@cisco.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Eli Cohen <eli@mellanox.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Gal Pressman <galpress@amazon.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Leon Romanovsky <leonro@mellanox.com>,
        Lijun Ou <oulijun@huawei.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Parvi Kaustubhi <pkaustub@cisco.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Roland Dreier <roland@purestorage.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Weihang Li <liweihang@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Yuval Shaia <yuval.shaia@oracle.com>,
        Zhu Yanjun <yanjunz@nvidia.com>
Subject: [PATCH rdma-next 00/10] Restore failure of destroy commands
Date:   Mon, 24 Aug 2020 13:32:37 +0300
Message-Id: <20200824103247.1088464-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Hi,

This series restores the ability to fail on destroy commands, due to the
fact that mlx5_ib DEVX implementation interleaved ib_core objects
with FW objects without sharing reference counters.

In a retrospective, every part of the mlx5_ib flow is correct.

It started from IBTA which was written by HW engineers with HW in mind and
they allowed to fail in destruction. FW implemented it with symmetrical
interface like any other command and propagated error back to the kernel,
which forwarded it to the libibverbs and kernel ULPs.

Libibverbs was designed with IBTA spec in hand putting destroy errors in
stone. Up till mlx5_ib DEVX, it worked well, because the IB verbs objects
are counted by the kernel and ib_core ensures that FW destroy will success
by managing various reference counters on such objects.

The extension of the mlx5 driver changed this flow when allowed DEVX objects
that are not managed by ib_core to be interleaved with the ones under ib_core
responsibility.

The drivers that want to implement DEVX flows, must ensure that FW/HW
destroys are performed as early as possible before any other internal
cleanup. After HW destroys, drivers are not allowed to fail.

This series includes two patches (WQ and "potential race") that will
require extra work in mlx5_ib, they both theoretical. WQ is not in use
in DEVX, but is needed to make interface symmetrical to other objects.
"Potential race" is in ULP flow that ensures that SRQ is destoyed in
proper order.

Thanks

Leon Romanovsky (10):
  RDMA: Restore ability to fail on PD deallocate
  RDMA: Restore ability to fail on AH destroy
  RDMA/mlx5: Issue FW command to destroy SRQ on reentry
  RDMA/mlx5: Fix potential race between destroy and CQE poll
  RDMA: Restore ability to fail on SRQ destroy
  RDMA/core: Delete function indirection for alloc/free kernel CQ
  RDMA: Allow fail of destroy CQ
  RDMA: Change XRCD destroy return value
  RDMA: Restore ability to return error for destroy WQ
  RDMA: Make counters destroy symmetrical

 drivers/infiniband/core/cq.c                  |  36 +++---
 drivers/infiniband/core/uverbs_std_types.c    |   3 +-
 .../core/uverbs_std_types_counters.c          |   4 +-
 drivers/infiniband/core/uverbs_std_types_wq.c |   2 +-
 drivers/infiniband/core/verbs.c               |  56 +++++++---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c      |  12 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.h      |   8 +-
 drivers/infiniband/hw/cxgb4/cq.c              |   3 +-
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h        |   4 +-
 drivers/infiniband/hw/cxgb4/provider.c        |   3 +-
 drivers/infiniband/hw/cxgb4/qp.c              |   3 +-
 drivers/infiniband/hw/efa/efa.h               |   6 +-
 drivers/infiniband/hw/efa/efa_verbs.c         |  11 +-
 drivers/infiniband/hw/hns/hns_roce_ah.c       |   5 -
 drivers/infiniband/hw/hns/hns_roce_cq.c       |   3 +-
 drivers/infiniband/hw/hns/hns_roce_device.h   |  13 ++-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c    |   3 +-
 drivers/infiniband/hw/hns/hns_roce_pd.c       |   3 +-
 drivers/infiniband/hw/hns/hns_roce_srq.c      |   3 +-
 drivers/infiniband/hw/i40iw/i40iw_verbs.c     |   6 +-
 drivers/infiniband/hw/mlx4/ah.c               |   5 -
 drivers/infiniband/hw/mlx4/cq.c               |   3 +-
 drivers/infiniband/hw/mlx4/main.c             |   6 +-
 drivers/infiniband/hw/mlx4/mlx4_ib.h          |  11 +-
 drivers/infiniband/hw/mlx4/qp.c               |   3 +-
 drivers/infiniband/hw/mlx4/srq.c              |   3 +-
 drivers/infiniband/hw/mlx5/ah.c               |   5 -
 drivers/infiniband/hw/mlx5/cmd.c              |   4 +-
 drivers/infiniband/hw/mlx5/cmd.h              |   2 +-
 drivers/infiniband/hw/mlx5/counters.c         |   3 +-
 drivers/infiniband/hw/mlx5/cq.c               |  21 ++--
 drivers/infiniband/hw/mlx5/main.c             |   4 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |  13 ++-
 drivers/infiniband/hw/mlx5/qp.c               |  12 +-
 drivers/infiniband/hw/mlx5/qp.h               |   4 +-
 drivers/infiniband/hw/mlx5/qpc.c              |   5 +-
 drivers/infiniband/hw/mlx5/srq.c              |  26 ++---
 drivers/infiniband/hw/mlx5/srq.h              |   2 +-
 drivers/infiniband/hw/mlx5/srq_cmd.c          |  22 +++-
 drivers/infiniband/hw/mthca/mthca_provider.c  |  12 +-
 drivers/infiniband/hw/ocrdma/ocrdma_ah.c      |   3 +-
 drivers/infiniband/hw/ocrdma/ocrdma_ah.h      |   2 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c   |  11 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.h   |   6 +-
 drivers/infiniband/hw/qedr/verbs.c            |  14 ++-
 drivers/infiniband/hw/qedr/verbs.h            |   8 +-
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c  |   7 +-
 drivers/infiniband/hw/usnic/usnic_ib_verbs.h  |   4 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c  |   3 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c |   3 +-
 .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.c   |   8 +-
 .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.h   |   8 +-
 drivers/infiniband/sw/rdmavt/ah.c             |   3 +-
 drivers/infiniband/sw/rdmavt/ah.h             |   2 +-
 drivers/infiniband/sw/rdmavt/cq.c             |   3 +-
 drivers/infiniband/sw/rdmavt/cq.h             |   2 +-
 drivers/infiniband/sw/rdmavt/pd.c             |   3 +-
 drivers/infiniband/sw/rdmavt/pd.h             |   2 +-
 drivers/infiniband/sw/rdmavt/srq.c            |   3 +-
 drivers/infiniband/sw/rdmavt/srq.h            |   2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c         |  12 +-
 drivers/infiniband/sw/siw/siw_verbs.c         |   9 +-
 drivers/infiniband/sw/siw/siw_verbs.h         |   6 +-
 drivers/infiniband/ulp/ipoib/ipoib_cm.c       |   6 +-
 include/rdma/ib_verbs.h                       | 105 +++++-------------
 65 files changed, 313 insertions(+), 275 deletions(-)

--
2.26.2

