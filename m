Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2AB81ACE2E
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2020 18:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404113AbgDPQ5d (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Apr 2020 12:57:33 -0400
Received: from mga03.intel.com ([134.134.136.65]:59302 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731440AbgDPQ5d (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 Apr 2020 12:57:33 -0400
IronPort-SDR: RVr9OLikVma2fczk42yrBtP1sddJFXVgWlmWJmTOqtXbjopKpTipElNXW5cnTHy2eBy5OFuXHW
 a8zXD0UhVMzg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 09:57:32 -0700
IronPort-SDR: fMSh/2dfaS/1yOWVPfRxx7I1LucZnAyGlEfhSlOyGovBg9EMaxM/ii8qC6lX8wCcVjNv61CAVk
 A3Lblpueghvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,391,1580803200"; 
   d="scan'208";a="364053008"
Received: from cst-dev.jf.intel.com ([10.23.221.69])
  by fmsmga001.fm.intel.com with ESMTP; 16 Apr 2020 09:57:33 -0700
From:   Jianxin Xiong <jianxin.xiong@intel.com>
To:     linux-rdma@vger.kernel.org
Cc:     Jianxin Xiong <jianxin.xiong@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Leon Romanovsky <leon@kernel.org>
Subject: [RFC PATCH 0/3] RDMA: Add dma-buf support
Date:   Thu, 16 Apr 2020 10:09:30 -0700
Message-Id: <1587056973-101760-1-git-send-email-jianxin.xiong@intel.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch set adds dma-buf importer role to the RDMA driver and thus
provides a non-proprietary approach for supporting RDMA to/from buffers
allocated from device local memory (e.g. GPU VRAM). 

Dma-buf is a standard mechanism in Linux kernel for sharing buffers
among different device drivers. It is supported by mainstream GPU
drivers. By using ioctl calls over the devices under /dev/dri/, user
space applications can allocate and export GPU buffers as dma-buf
objetcs with associated file descriptors.

In order to use the exported GPU buffer for RDMA operations, the RDMA
driver needs to be able to import dma-buf objects. This happens at the
time of memory registration. A GPU buffer is registered as a special
type of user space memory region with the dma-buf file descriptor as
an extra parameter. The uverbs API needs to be extended to allow the
extra parameter be passed from user space to kernel.

Vendor RDMA drivers need to be modified in order to take advantage of
the new feature. A patch for the mlx5 driver is provided as an example.

Related user space RDMA library changes will be provided as a separate
patch set.

Jianxin Xiong (3):
  RDMA/umem: Support importing dma-buf as user memory region
  RDMA/uverbs: Add uverbs commands for fd-based MR registration
  RDMA/mlx5: Support new uverbs commands for registering fd-based MR

 drivers/infiniband/Kconfig            |  10 ++
 drivers/infiniband/core/Makefile      |   1 +
 drivers/infiniband/core/device.c      |   2 +
 drivers/infiniband/core/umem.c        |   3 +
 drivers/infiniband/core/umem_dmabuf.c | 100 +++++++++++++++++++
 drivers/infiniband/core/uverbs_cmd.c  | 179 +++++++++++++++++++++++++++++++++-
 drivers/infiniband/hw/mlx5/main.c     |   6 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h  |   7 ++
 drivers/infiniband/hw/mlx5/mr.c       |  85 ++++++++++++++--
 include/rdma/ib_umem.h                |   5 +
 include/rdma/ib_umem_dmabuf.h         |  50 ++++++++++
 include/rdma/ib_verbs.h               |   8 ++
 include/uapi/rdma/ib_user_verbs.h     |  28 ++++++
 13 files changed, 472 insertions(+), 12 deletions(-)
 create mode 100644 drivers/infiniband/core/umem_dmabuf.c
 create mode 100644 include/rdma/ib_umem_dmabuf.h

-- 
1.8.3.1

