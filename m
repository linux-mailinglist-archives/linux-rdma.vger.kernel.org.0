Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03E36195C4E
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2020 18:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgC0RP7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Mar 2020 13:15:59 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:51186 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727585AbgC0RPw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Mar 2020 13:15:52 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 27 Mar 2020 20:15:46 +0300
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx [10.209.102.136])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 02RHFjj2004869;
        Fri, 27 Mar 2020 20:15:45 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, martin.petersen@oracle.com, jsmart2021@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     idanb@mellanox.com, axboe@kernel.dk, maxg@mellanox.com,
        vladimirk@mellanox.com, oren@mellanox.com, shlomin@mellanox.com,
        israelr@mellanox.com, jgg@mellanox.com
Subject: [PATCH 00/17 V5] nvme-rdma/nvmet-rdma: Add metadata/T10-PI support
Date:   Fri, 27 Mar 2020 20:15:27 +0300
Message-Id: <20200327171545.98970-1-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Sagi, Christoph, Keith, Martin, James and Co

This patchset adds metadata (T10-PI) support for NVMeoF/RDMA host side
and target side, using signature verbs API. This set starts with a few
preparation commits to the NVMe host core layer. It continues with
NVMeoF/RDMA host implementation + few preparation commits to the RDMA/rw
API and to NVMe target core layer. The patchset ends with NVMeoF/RDMA
target implementation. Also patch for NVMe-cli added to this series.

In V5 I mainly did some renamings and removed 2 patches to get_mdts that
were already merged to main branch. I tried get some inspiration from
James suggestion of the settings in NVMe core, but unfortunately couldn't
take much from there and I stayed with Christoph suggestion for features
flag per namespace. I found the code more readable in this form and
hopefully we can continue with the review and the merge soon.

Configuration:
Host:
 - nvme connect --pi_enable --transport=rdma --traddr=10.0.1.1 --nqn=test-nvme

Target:
 - echo 1 > /config/nvmet/subsystems/${NAME}/attr_pi_enable
 - echo 1 > /config/nvmet/ports/${PORT_NUM}/param_pi_enable

The code was tested using Mellanox's ConnectX-4/ConnectX-5 HCAs.
This series applies on top of nvme_5.7 branch cleanly.

Changes from v4:
 - removed get_mdts patches (merged)
 - added enum nvme_ns_features instead of defines (patch 1/17)
 - rename pi/prot to md (patches 2/17 + 6/17 + 8/17 + 9/17 + 10/17)
 - another rebase

Changes from v3:
 - Added Reviewed-by signatures
 - New RDMA/rw patch (Patch 17/19)
 - Add mdts setting op for controllers (Patches 14/19, 18/19)
 - Rename NVME_NS_DIX_SUPPORTED to NVME_NS_MD_HOST_SUPPORTED and
   NVME_NS_DIF_SUPPORTED to NVME_NS_MD_CTRL_SUPPORTED (Patch 01/19)
 - Split "nvme: Introduce namespace features flag" patch (patch 02/19)
 - Rename nvmet_rdma_set_diff_domain to nvmet_rdma_set_sig_domain
   and nvme_rdma_set_diff_domain to nvme_rdma_set_sig_domain
   (Patches 08/19, 19/19)
 - Remove ns parameter from nvme_rdma_set_sig_domain/nvmet_rdma_set_sig_domain
   functions (patch 08/19, 19/19)
 - Rebase over nvme-5.7 branch

Changes from v2:
 - Convert the virtual start sector (which passed to bip_set_seed function)
   to be in integrity interval units (Patch 14/15)
 - Clarify some commit messages

Changes from v1:
 - Added Reviewed-by signatures
 - Added namespace features flag (Patch 01/15)
 - Remove nvme_ns_has_pi function (Patch 01/15)
 - Added has_pi field to struct nvme_request (Patch 01/15)
 - Subject change for patch 02/15
 - Fix comment for PCI metadata (Patch 03/15)
 - Rebase over "nvme: Avoid preallocating big SGL for data" patchset
 - Introduce NVME_INLINE_PROT_SG_CNT flag (Patch 05/15)
 - Introduce nvme_rdma_sgl structure (Patch 06/15)
 - Remove first_sgl pointer from struct nvme_rdma_request (Patch 06/15)
 - Split nvme-rdma patches (Patches 06/15, 07/15)
 - Rename is_protected to use_pi (Patch 07/15)
 - Refactor nvme_rdma_get_max_fr_pages function (Patch 07/15)
 - Added ifdef CONFIG_BLK_DEV_INTEGRITY (Patches 07/15, 09/15, 13/15,
   14/15, 15/15)
 - Added port configfs pi_enable (Patch 14/15)


Israel Rukshin (12):
  nvme: introduce namespace features flag
  nvme: Add has_md field to the nvme_req structure
  nvme-fabrics: Allow user enabling metadata/T10-PI support
  nvme: introduce NVME_INLINE_MD_SG_CNT
  nvme-rdma: Introduce nvme_rdma_sgl structure
  nvmet: prepare metadata request
  nvmet: add metadata characteristics for a namespace
  nvmet: Rename nvmet_rw_len to nvmet_rw_data_len
  nvmet: Rename nvmet_check_data_len to nvmet_check_transfer_len
  nvme: Add Metadata Capabilities enumerations
  nvmet: Add metadata/T10-PI support
  nvmet: Add metadata support for block devices

Max Gurtovoy (5):
  nvme: Enforce extended LBA format for fabrics metadata
  nvme: introduce max_integrity_segments ctrl attribute
  nvme-rdma: add metadata/T10-PI support
  RDMA/rw: Expose maximal page list for a device per 1 MR
  nvmet-rdma: Add metadata/T10-PI support

 drivers/infiniband/core/rw.c      |  14 +-
 drivers/nvme/host/core.c          |  79 +++++---
 drivers/nvme/host/fabrics.c       |  11 ++
 drivers/nvme/host/fabrics.h       |   3 +
 drivers/nvme/host/nvme.h          |  12 +-
 drivers/nvme/host/pci.c           |   7 +
 drivers/nvme/host/rdma.c          | 367 +++++++++++++++++++++++++++++++++-----
 drivers/nvme/target/admin-cmd.c   |  33 +++-
 drivers/nvme/target/configfs.c    |  61 +++++++
 drivers/nvme/target/core.c        |  54 ++++--
 drivers/nvme/target/discovery.c   |   8 +-
 drivers/nvme/target/fabrics-cmd.c |  19 +-
 drivers/nvme/target/io-cmd-bdev.c | 113 +++++++++++-
 drivers/nvme/target/io-cmd-file.c |   6 +-
 drivers/nvme/target/nvmet.h       |  38 +++-
 drivers/nvme/target/rdma.c        | 245 +++++++++++++++++++++++--
 include/linux/nvme.h              |   2 +
 include/rdma/rw.h                 |   1 +
 18 files changed, 946 insertions(+), 127 deletions(-)

-- 
1.8.3.1

