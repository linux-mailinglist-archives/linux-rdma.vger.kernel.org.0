Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78FF420DE6F
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jun 2020 23:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732197AbgF2UZp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Jun 2020 16:25:45 -0400
Received: from mga04.intel.com ([192.55.52.120]:36335 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729129AbgF2TZ1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Jun 2020 15:25:27 -0400
IronPort-SDR: uxoGpSwsEuK9x8xqS4yFiPknMOJ+ZFu21XSnRyCRyKN8sgUkofkKpKw/A8TTDW8GQYqtxdhlNu
 B9AjBS+cHGVA==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="143489435"
X-IronPort-AV: E=Sophos;i="5.75,295,1589266800"; 
   d="scan'208";a="143489435"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 10:19:45 -0700
IronPort-SDR: nBU2k8tqByVUJxpr+2WnOiDA1oYAOrRHgEpz7gSAHHjGaoYWcVQB2aEcvvJwTui6+tAsdBisu+
 j8i4CcKPWZsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,295,1589266800"; 
   d="scan'208";a="320698606"
Received: from cst-dev.jf.intel.com ([10.23.221.69])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Jun 2020 10:19:45 -0700
From:   Jianxin Xiong <jianxin.xiong@intel.com>
To:     linux-rdma@vger.kernel.org
Cc:     Jianxin Xiong <jianxin.xiong@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Leon Romanovsky <leon@kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [RFC PATCH v2 0/3] RDMA: add dma-buf support
Date:   Mon, 29 Jun 2020 10:31:40 -0700
Message-Id: <1593451903-30959-1-git-send-email-jianxin.xiong@intel.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When enabled, an RDMA capable NIC can perform peer-to-peer transactions
over PCIe to access the local memory located on another device. This can
often lead to better performance than using a system memory buffer for
RDMA and copying data between the buffer and device memory.

Current kernel RDMA stack uses get_user_pages() to pin the physical
pages backing the user buffer and uses dma_map_sg_attrs() to get the
dma addresses for memory access. This usually doesn't work for peer
device memory due to the lack of associated page structures.

Several mechanisms exist today to facilitate device memory access.

ZONE_DEVICE is a new zone for device memory in the memory management
subsystem. It allows pages from device memory being described with
specialized page structures. As the result, calls like get_user_pages()
can succeed, but what can be done with these page structures may be
different from system memory. It is further specialized into multiple
memory types, such as one type for PCI p2pmem/p2pdma and one type for
HMM.

PCI p2pmem/p2pdma uses ZONE_DEVICE to represent device memory residing
in a PCI BAR and provides a set of calls to publish, discover, allocate,
and map such memory for peer-to-peer transactions. One feature of the
API is that the buffer is allocated by the side that does the DMA
transfer. This works well with the storage usage case, but is awkward
with GPU-NIC communication, where typically the buffer is allocated by
the GPU driver rather than the NIC driver.

Heterogeneous Memory Management (HMM) utilizes mmu_interval_notifier
and ZONE_DEVICE to support shared virtual address space and page
migration between system memory and device memory. HMM doesn't support
pinning device memory because pages located on device must be able to
migrate to system memory when accessed by CPU. Peer-to-peer access
is possible if the peer can handle page fault. For RDMA, that means
the NIC must support on-demand paging.

Dma-buf is a standard mechanism for sharing buffers among different
device drivers. The buffer to be shared is exported by the owning
driver and imported by the driver that wants to use it. The exporter
provides a set of ops that the importer can call to pin and map the
buffer. In addition, a file descriptor can be associated with a dma-
buf object as the handle that can be passed to user space.

This patch series adds dma-buf importer role to the RDMA driver in
attempt to support RDMA using device memory such as GPU VRAM. Dma-buf is
chosen for a few reasons: first, the API is relatively simple and allows
a lot of flexibility in implementing the buffer manipulation ops.
Second, it doesn't require page structure. Third, dma-buf is already
supported in many GPU drivers. However, we are aware that existing GPU
drivers don't allow pinning device memory via the dma-buf interface.
Pinning and mapping a dma-buf would cause the backing storage to migrate
to system RAM. This is due to the lack of knowledge about whether the
importer can perform peer-to-peer access and the lack of resource limit
control measure for GPU. For the first part, the latest dma-buf driver
has a peer-to-peer flag for the importer, but the flag is currently tied
to dynamic mapping support, which requires on-demand paging support from
the NIC to work. There are a few possible ways to address these issues,
such as decoupling peer-to-peer flag from dynamic mapping, allowing more
leeway for individual drivers to make the pinning decision and adding
GPU resource limit control via cgroup. We would like to get comments on
this patch series with the assumption that device memory pinning via
dma-buf is supported by some GPU drivers, and at the same time welcome
open discussions on how to address the aforementioned issues as well as
GPU-NIC peer-to-peer access solutions in general.

This is the second version of the patch series. Here are the changes
from the previous version:
* The Kconfig option is removed. There is no dependence issue since
dma-buf driver is always enabled.
* The declaration of new data structure and functions is reorganized to
minimize the visibility of the changes.
* The new uverbs command now goes through ioctl() instead of write().
* The rereg functionality is removed.
* Instead of adding new device method for dma-buf specific registration,
existing method is extended to accept an extra parameter. 
* The correct function is now used for address range checking. 

This series is organized as follows. The first patch adds the common
code for importing dma-buf from a file descriptor and pinning and
mapping the dma-buf pages. Patch 2 extends the reg_user_mr() method
of the ib_device structure to accept dma-buf file descriptor as an extra
parameter. Vendor drivers are updated with the change. Patch 3 adds a
new uverbs command for registering dma-buf based memory region.

Related user space RDMA library changes will be provided as a separate
patch series.

Jianxin Xiong (3):
  RDMA/umem: Support importing dma-buf as user memory region
  RDMA/core: Expand the driver method 'reg_user_mr' to support dma-buf
  RDMA/uverbs: Add uverbs command for dma-buf based MR registration

 drivers/infiniband/core/Makefile                |   2 +-
 drivers/infiniband/core/umem.c                  |   4 +
 drivers/infiniband/core/umem_dmabuf.c           | 105 ++++++++++++++++++++++
 drivers/infiniband/core/umem_dmabuf.h           |  11 +++
 drivers/infiniband/core/uverbs_cmd.c            |   2 +-
 drivers/infiniband/core/uverbs_std_types_mr.c   | 112 ++++++++++++++++++++++++
 drivers/infiniband/core/verbs.c                 |   2 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c        |   7 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.h        |   2 +-
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h          |   3 +-
 drivers/infiniband/hw/cxgb4/mem.c               |   8 +-
 drivers/infiniband/hw/efa/efa.h                 |   2 +-
 drivers/infiniband/hw/efa/efa_verbs.c           |   7 +-
 drivers/infiniband/hw/hns/hns_roce_device.h     |   2 +-
 drivers/infiniband/hw/hns/hns_roce_mr.c         |   7 +-
 drivers/infiniband/hw/i40iw/i40iw_verbs.c       |   6 ++
 drivers/infiniband/hw/mlx4/mlx4_ib.h            |   2 +-
 drivers/infiniband/hw/mlx4/mr.c                 |   7 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h            |   2 +-
 drivers/infiniband/hw/mlx5/mr.c                 |  45 +++++++++-
 drivers/infiniband/hw/mthca/mthca_provider.c    |   8 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c     |   9 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.h     |   3 +-
 drivers/infiniband/hw/qedr/verbs.c              |   8 +-
 drivers/infiniband/hw/qedr/verbs.h              |   3 +-
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c    |   8 +-
 drivers/infiniband/hw/usnic/usnic_ib_verbs.h    |   2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c    |   6 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h |   2 +-
 drivers/infiniband/sw/rdmavt/mr.c               |   6 +-
 drivers/infiniband/sw/rdmavt/mr.h               |   2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c           |   6 ++
 drivers/infiniband/sw/siw/siw_verbs.c           |   8 +-
 drivers/infiniband/sw/siw/siw_verbs.h           |   3 +-
 include/rdma/ib_umem.h                          |  14 ++-
 include/rdma/ib_verbs.h                         |   4 +-
 include/uapi/rdma/ib_user_ioctl_cmds.h          |  14 +++
 37 files changed, 410 insertions(+), 34 deletions(-)
 create mode 100644 drivers/infiniband/core/umem_dmabuf.c
 create mode 100644 drivers/infiniband/core/umem_dmabuf.h

-- 
1.8.3.1

