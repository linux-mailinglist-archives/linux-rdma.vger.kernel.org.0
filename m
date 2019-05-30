Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75E7B2FC38
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2019 15:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfE3NZk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 May 2019 09:25:40 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:34899 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726320AbfE3NZk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 May 2019 09:25:40 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 30 May 2019 16:25:31 +0300
Received: from r-vnc08.mtr.labs.mlnx (r-vnc08.mtr.labs.mlnx [10.208.0.121])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x4UDPVZS007883;
        Thu, 30 May 2019 16:25:31 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     leonro@mellanox.com, linux-rdma@vger.kernel.org, jgg@mellanox.com,
        dledford@redhat.com, sagi@grimberg.me, hch@lst.de,
        bvanassche@acm.org
Cc:     maxg@mellanox.com, israelr@mellanox.com, idanb@mellanox.com,
        oren@mellanox.com, vladimirk@mellanox.com, shlomin@mellanox.com
Subject: [PATCH 00/20 V5] Introduce new API for T10-PI offload
Date:   Thu, 30 May 2019 16:25:11 +0300
Message-Id: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
X-Mailer: git-send-email 1.7.8.2
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Sagi, Christoph, Jason, Doug, Leon and Co

This patchset adds a new verbs API for T10-PI offload and
implementation for iSER initiator and iSER target (NVMe-oF/RDMA host side
was completed and will be sent on a different patchset).
This set starts with a few preparation commits to the RDMA/core layer.
It continues with introducing a new MR type IB_MR_TYPE_INTEGRITY.
Using this MR all the needed mappings will be done in the low level drivers
and not be visible to the ULP. Later patches implement the needed functionality
in the mlx5 layer. As suggested by Sagi, in the new API, the mlx5 driver
will allocate a single internal memory region for the UMR operation to
register both PI and data SG lists and it will look like:

    data start  meta start
    |           |
    -------------------------
    |d1|d2|d3|d4|m1|m2|m3|m4|
    -------------------------

The sig_mr stride block would be using the same lkey but different
offsets in it (offset 0 and offset d1+d2+d3+d4). The verbs layer will
use a special mr type that will describe everything and will replace
the old API, that enforce using 3 different memory regions (data_mr,
protection_mr, sig_mr) and their local invalidations. This will ease
the code in the ULP and will improve the abstraction of the HW (see
iSER code changes). 
The patchset contains also iSER initator and target patches that using
this new API.

For iSER, the code was tested vs. LIO iSER target using Mellanox's
ConnectX-4/ConnectX-5.

This series applies cleanly on top of kernel 5.2.0-rc2 tag plus patchest
"[PATCH 0/7] iser/isert/rw-api cleanups" that was applied to for-next (Jason).
We should aim to push this code during 5.3 merge window.

Next steps are:
 - merge NVMe-oF/RDMA host side after merging this patchset
 - Implement metadata support for NVMe-oF/RDMA target side with new API

---------
Changes since v4:

 - Rebase the code over kernel 5.2.0-rc2
 - Remove some cleanups patches (they were applied to Jason's for-next)
 - Merge iser_create_fastreg_desc and iser_alloc_reg_res (patch 11/20)
 - Add meta_length to ib_sig_attrs structure (patch 5/20)
 - Fix RW API in case of sig_type IB_SIG_TYPE_NONE (patch 16/20)
 - Refactor MR descriptors allocation (patch 20/20)
---------
Changes since v3:

 - Add new mr types IB_MR_TYPE_USER and IB_MR_TYPE_DMA at patch 02/25
 - Fix kernel-doc syntax at include/rdma/signature.h
 - Remove struct ib_scaterlist
 - Rebase the code over kernel 5.1.0
 - Added Reviewed-by signatures
 - Use new API in iSER LIO target and remove the old API
 - If possibe, avoid doing a UMR operation to register data and
   protection buffers at patch 25/25
---------
Changes since v2:

 - Rename IB_MR_TYPE_PI to IB_MR_TYPE_INTEGRITY (Sagi)
 - Rename IB_WR_REG_PI_MR to IB_WR_REG_MR_INTEGRITY (Sagi)
 - Refactor iser_login_rsp (Christoph)
 - Unwind WR union at iser_tx_desc (patch 16/18 - Christoph)
 - Rebase the code over kernel 5.0 plus 2 iser fixes
 - Added Reviewed-by signatures
---------
Changes since v1:

 - Add a missing comma at patch 01/17
 - Fix coding style at patches 03/17, 05/17 and 09/17
 - Fix srp_map_finish_fr function at patch 04/17
 - Rebase the code over 5.0-rc5
---------

Israel Rukshin (7):
  RDMA/core: Introduce IB_MR_TYPE_INTEGRITY and ib_alloc_mr_integrity
    API
  IB/iser: Use IB_WR_REG_MR_INTEGRITY for PI handover
  IB/iser: Unwind WR union at iser_tx_desc
  RDMA/core: Add an integrity MR pool support
  RDMA/rw: Use IB_WR_REG_MR_INTEGRITY for PI handover
  RDMA/core: Remove unused IB_WR_REG_SIG_MR code
  RDMA/mlx5: Improve PI handover performance

Max Gurtovoy (13):
  RDMA/core: Introduce new header file for signature operations
  RDMA/core: Save the MR type in the ib_mr structure
  RDMA/core: Introduce ib_map_mr_sg_pi to map data/protection sgl's
  RDMA/core: Add signature attrs element for ib_mr structure
  RDMA/mlx5: Implement mlx5_ib_map_mr_sg_pi and
    mlx5_ib_alloc_mr_integrity
  RDMA/mlx5: Add attr for max number page list length for PI operation
  RDMA/mlx5: Pass UMR segment flags instead of boolean
  RDMA/mlx5: Update set_sig_data_segment attribute for new signature API
  RDMA/mlx5: Introduce and implement new IB_WR_REG_MR_INTEGRITY work
    request
  RDMA/mlx5: Move signature_en attribute from mlx5_qp to ib_qp
  RDMA/core: Validate signature handover device cap
  RDMA/mlx5: Use PA mapping for PI handover
  RDMA/mlx5: Refactor MR descriptors allocation

 drivers/infiniband/core/device.c              |   2 +
 drivers/infiniband/core/mr_pool.c             |   8 +-
 drivers/infiniband/core/rw.c                  | 195 +++++-----
 drivers/infiniband/core/uverbs_cmd.c          |   2 +
 drivers/infiniband/core/uverbs_std_types_mr.c |   1 +
 drivers/infiniband/core/verbs.c               | 109 +++++-
 drivers/infiniband/hw/mlx5/main.c             |   4 +
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |  20 +-
 drivers/infiniband/hw/mlx5/mr.c               | 533 ++++++++++++++++++++++----
 drivers/infiniband/hw/mlx5/qp.c               | 217 +++++++----
 drivers/infiniband/hw/vmw_pvrdma/pvrdma.h     |   2 +-
 drivers/infiniband/ulp/iser/iscsi_iser.c      |   3 +-
 drivers/infiniband/ulp/iser/iscsi_iser.h      |  64 +---
 drivers/infiniband/ulp/iser/iser_initiator.c  |  12 +-
 drivers/infiniband/ulp/iser/iser_memory.c     | 112 +++---
 drivers/infiniband/ulp/iser/iser_verbs.c      | 152 +++-----
 drivers/infiniband/ulp/isert/ib_isert.c       |   4 +-
 drivers/nvme/host/rdma.c                      |   2 +-
 include/linux/mlx5/qp.h                       |   3 +-
 include/rdma/ib_verbs.h                       | 165 ++------
 include/rdma/mr_pool.h                        |   2 +-
 include/rdma/rw.h                             |   9 -
 include/rdma/signature.h                      | 122 ++++++
 23 files changed, 1104 insertions(+), 639 deletions(-)
 create mode 100644 include/rdma/signature.h

-- 
2.16.3

