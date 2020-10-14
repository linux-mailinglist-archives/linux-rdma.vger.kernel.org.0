Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F3628E3D2
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Oct 2020 18:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbgJNQBW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 14 Oct 2020 12:01:22 -0400
Received: from mga18.intel.com ([134.134.136.126]:6156 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728225AbgJNQBW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 14 Oct 2020 12:01:22 -0400
IronPort-SDR: flAQz+weIbItdYTu612QyFZc/SPPYT5rWOyQdX+802Nkw8L7AEO5/0MuQ6OlooTUPS6WuMk08h
 aZb1fAV/1X0w==
X-IronPort-AV: E=McAfee;i="6000,8403,9773"; a="153963578"
X-IronPort-AV: E=Sophos;i="5.77,375,1596524400"; 
   d="scan'208";a="153963578"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2020 09:01:00 -0700
IronPort-SDR: ULsI3OX7atfYJ9yEVD6jKoLqN1G75PD6FmPyp0kPRiZzH4lgppheX1vm5fhYoAHQZ3bn2OPh3B
 fumdXWZq1DVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,375,1596524400"; 
   d="scan'208";a="351533191"
Received: from cst-dev.jf.intel.com ([10.23.221.69])
  by fmsmga002.fm.intel.com with ESMTP; 14 Oct 2020 09:00:59 -0700
From:   Jianxin Xiong <jianxin.xiong@intel.com>
To:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Jianxin Xiong <jianxin.xiong@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH v4 0/5] RDMA: Add dma-buf support
Date:   Wed, 14 Oct 2020 09:14:51 -0700
Message-Id: <1602692091-106889-1-git-send-email-jianxin.xiong@intel.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This is the fourth version of the patch set. Changelog:

v4:
* Add a new ib_device method reg_user_mr_dmabuf() instead of expanding
  the existing method reg_user_mr()
* Use a separate code flow for dma-buf instead of adding special cases
  to the ODP memory region code path
* In invalidation callback, new mapping is updated as whole using work
  queue instead of being updated in page granularity in the page fault
  handler
* Use dma_resv_get_excl() and dma_fence_wait() to ensure the content of
  the pages have been moved to the new location before the new mapping
  is programmed into the NIC
* Add code to the ODP page fault handler to check the mapping status
* The new access flag added in v3 is removed.
* The checking for on-demand paging support in the new uverbs command
  is removed because it is implied by implementing the new ib_device
  method
* Clarify that dma-buf sg lists are page aligned

v3: https://www.spinics.net/lists/linux-rdma/msg96330.html
* Use dma_buf_dynamic_attach() instead of dma_buf_attach()
* Use on-demand paging mechanism to avoid pinning the GPU memory
* Instead of adding a new parameter to the device method for memory
  registration, pass all the attributes including the file descriptor
  as a structure
* Define a new access flag for dma-buf based memory region
* Check for on-demand paging support in the new uverbs command

v2: https://www.spinics.net/lists/linux-rdma/msg93643.html
* The Kconfig option is removed. There is no dependence issue since
  dma-buf driver is always enabled.
* The declaration of new data structure and functions is reorganized to
  minimize the visibility of the changes.
* The new uverbs command now goes through ioctl() instead of write().
* The rereg functionality is removed.
* Instead of adding new device method for dma-buf specific registration,
  existing method is extended to accept an extra parameter. 
* The correct function is now used for address range checking. 

v1: https://www.spinics.net/lists/linux-rdma/msg90720.html
* The initial patch set
* Implement core functions for importing and mapping dma-buf
* Use dma-buf static attach interface
* Add two ib_device methods reg_user_mr_fd() and rereg_user_mr_fd()
* Add two uverbs commands via the write() interface
* Add Kconfig option
* Add dma-buf support to mlx5 device

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
specialized page structures, but what can be done with these page
structures may be different from system memory. ZONE_DEVICE is further
specialized into multiple memory types, such as one type for PCI
p2pmem/p2pdma and one type for HMM.

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
is currently not supported by HMM.

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
Pinning would simply cause the backing storage to migrate to system RAM.
True peer-to-peer access is only possible using dynamic attach, which
requires on-demand paging support from the NIC to work. For this reason,
this series only works with ODP capable NICs.

This series consists of five patches. The first patch adds the common
code for importing dma-buf from a file descriptor and mapping the
dma-buf pages. Patch 2 add the new driver method reg_user_mr_dmabuf().
Patch 3 adds a new uverbs command for registering dma-buf based memory
region. Patch 4 adds dma-buf support to the mlx5 driver. Patch 5 adds
clarification to the dma-buf API documentation that dma-buf sg lists
are page aligned.

Related user space RDMA library changes will be provided as a separate
patch series.

Jianxin Xiong (5):
  RDMA/umem: Support importing dma-buf as user memory region
  RDMA/core: Add device method for registering dma-buf base memory
    region
  RDMA/uverbs: Add uverbs command for dma-buf based MR registration
  RDMA/mlx5: Support dma-buf based userspace memory region
  dma-buf: Clarify that dma-buf sg lists are page aligned

 drivers/dma-buf/dma-buf.c                     |  21 +++
 drivers/infiniband/core/Makefile              |   2 +-
 drivers/infiniband/core/device.c              |   1 +
 drivers/infiniband/core/umem.c                |   4 +
 drivers/infiniband/core/umem_dmabuf.c         | 200 ++++++++++++++++++++++++++
 drivers/infiniband/core/umem_dmabuf.h         |  11 ++
 drivers/infiniband/core/uverbs_std_types_mr.c | 112 +++++++++++++++
 drivers/infiniband/hw/mlx5/main.c             |   2 +
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |   5 +
 drivers/infiniband/hw/mlx5/mr.c               | 119 +++++++++++++++
 drivers/infiniband/hw/mlx5/odp.c              |  42 ++++++
 include/linux/dma-buf.h                       |   3 +-
 include/rdma/ib_umem.h                        |  32 ++++-
 include/rdma/ib_verbs.h                       |   6 +-
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  14 ++
 15 files changed, 570 insertions(+), 4 deletions(-)
 create mode 100644 drivers/infiniband/core/umem_dmabuf.c
 create mode 100644 drivers/infiniband/core/umem_dmabuf.h

-- 
1.8.3.1

