Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 732A72DC5C5
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Dec 2020 18:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbgLPR6Q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Dec 2020 12:58:16 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:6801 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728590AbgLPR6Q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Dec 2020 12:58:16 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fda4a8f0000>; Wed, 16 Dec 2020 09:57:35 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 16 Dec
 2020 17:57:35 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 16 Dec 2020 17:57:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Srtb7sG2qHR4RyXzrCJISHpBoSRtTsCh1QbxJkRLt0jwYtMTWT+fx/SY5WIGQHteQZMCG4Tw2oLcZ08+2wBWLqfVv6aXauZT4wPCaVW23rWd/oYHvEX6eec6JpBzIofHoq+rRE1P0tzUSRizRnCl++hu7mhL8mn1JWdOjd1MlPOFgjkDSjYl+YklcyhgzuHLAhByQbGamCAqr98iMj1hXhunCif7bmkR5z/htR4u/+XL6EzZ276vozgaB/GYFbfBfdaoQKxF4hKO8PtlkdRQ8c8eM84zrX+lL2AhJjt9h8lBjc1WLGW4Iy9/M7DgV+/t9NLTk63BC7/gcKSbYRzV2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7mEA57zV63LKCtxyHpPx8uv/MZqiHz2vmMaBndwROwk=;
 b=g1puVtMRLIMwZeHyHGEy9iFNCbNwYnIBxeIs499vM3fSgA809MWMIQ/uYyn9/09Z4HtbhTryVZtDScvVe5ARw7enLCCaTC0+FHGww2RnFLjj4/kA4dWR3Ft+Rv2RUDYM8q8W8tlNMG2CrHjSTYEL7DKHW6Bv+sV09u6MKjPDZhSVe6Y3cpz40gY25pGZZdd/yHc4G8IaDjAzyYB8ke4gpAXqkyKdtIrP9OaK9AZX/HEPbPu3EtgUlrtOxeQcbCk3Dfsq8gvhbMZkZEWZj6GaT6dN29H6No+G2sBy+GmVb0vj8FFAEDxYUTCm9oj8L4jIH4s2Og25s5fhgz4OgF09vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1514.namprd12.prod.outlook.com (2603:10b6:4:f::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12; Wed, 16 Dec 2020 17:57:32 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433%3]) with mapi id 15.20.3654.025; Wed, 16 Dec 2020
 17:57:32 +0000
Date:   Wed, 16 Dec 2020 13:57:30 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20201216175730.GA2787107@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
X-ClientProxiedBy: BL1PR13CA0253.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::18) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0253.namprd13.prod.outlook.com (2603:10b6:208:2ba::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.9 via Frontend Transport; Wed, 16 Dec 2020 17:57:31 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kpb3K-00Bh96-BL; Wed, 16 Dec 2020 13:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1608141455; bh=7mEA57zV63LKCtxyHpPx8uv/MZqiHz2vmMaBndwROwk=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:Content-Type:Content-Disposition:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=dQASL5A1k0R/CrxCm0R1ueXA0gZjqo9qwvCe1ToxktNFNeBTScQA4QgQp4Er1LgaF
         qCkl5oSAsutxks5McumjYowaqHr2TDazPf3e6qw0ecqaI9bJtpN550rm7kygJha3Uo
         riGiBqfXTG623SjeUiT/TPDEnNxOyus+PFOt1YTX/a7rI6jB0bzCKsNxQhUuWRKLu9
         FXw6X5V0TtZtGHD+9GKdtQ1pzmrqYf2OLzU59XSRVP2RYI3H6gPUL8JDI7sf1qd2Kv
         tbW0zcOQYhYWsGhUTrXlrfSCAWTWDHJM8kDRttSPe2zMQiM2cCJuLHZAHzrkvYoT9s
         HQVC3FfDcV0Fw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

These are the proposed RDMA patches for 5.12.

The biggest item in this PR would be the new HIP09 HW support from
HNS, otherwise it was pretty quiet for new work here.

Thanks,
Jason

The following changes since commit b65054597872ce3aefbc6a666385eabdf9e288da:

  Linux 5.10-rc6 (2020-11-29 15:50:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to e246b7c035d74abfb3507fa10082d0c42cc016c3:

  RDMA/cma: Don't overwrite sgid_attr after device is released (2020-12-14 15:23:06 -0400)

----------------------------------------------------------------
RDMA 5.11 pull request

A smaller set of patches, nothing stands out as being particularly major
this cycle:

- Driver bug fixes and updates: bnxt_re, cxgb4, rxe, hns, i40iw, cxgb4,
  mlx4 and mlx5

- Bug fixes and polishing for the new rts ULP

- Cleanup of uverbs checking for allowed driver operations

- Use sysfs_emit all over the place

- Lots of bug fixes and clarity improvements for hns

- hip09 support for hns

- NDR and 50/100Gb signaling rates

- Remove dma_virt_ops and go back to using the IB DMA wrappers

- mlx5 optimizations for contiguous DMA regions

----------------------------------------------------------------
Arnd Bergmann (2):
      IB/verbs: avoid nested container_of()
      RDMa/mthca: Work around -Wenum-conversion warning

Avihai Horon (3):
      RDMA/mlx5: Enable querying AH for XRC QP types
      RDMA/mlx4: Enable querying AH for XRC QP types
      RDMA/uverbs: Fix incorrect variable type

Bob Pearson (3):
      RDMA/rxe: Remove unused RXE_MR_TYPE_FMR
      RDMA/rxe: Compute PSN windows correctly
      RDMA/rxe: Use acquire/release for memory ordering

Christoph Hellwig (9):
      RDMA/umem: Use ib_dma_max_seg_size instead of dma_get_max_seg_size
      RDMA/core: Remove ib_dma_{alloc,free}_coherent
      RDMA: Lift ibdev_to_node from rds to common code
      nvme-rdma: Use ibdev_to_node instead of dereferencing ->dma_device
      rds: stop using dmapool
      RDMA/core: remove use of dma_virt_ops
      PCI/P2PDMA: Remove the DMA_VIRT_OPS hacks
      PCI/P2PDMA: Cleanup __pci_p2pdma_map_sg a bit
      dma-mapping: remove dma_virt_ops

Christophe JAILLET (1):
      IB/qib: Use dma_set_mask_and_coherent to simplify code

Danil Kipnis (1):
      RDMA/rtrs-clt: Remove destroy_con_cq_qp in case route resolving failed

Gal Pressman (2):
      RDMA/efa: Remove .create_ah callback assignment
      RDMA/efa: Use dma_set_mask_and_coherent() to simplify code

Gioh Kim (4):
      RDMA/rtrs-clt: Missing error from rtrs_rdma_conn_established
      RDMA/rtrs: Remove unnecessary argument dir of rtrs_iu_free
      RDMA/rtrs-clt: Remove duplicated switch-case handling for CM error events
      RDMA/rtrs-clt: Remove duplicated code

Guoqing Jiang (5):
      RDMA/rtrs-srv: Don't guard the whole __alloc_srv with srv_mutex
      RDMA/rtrs-srv: Fix typo
      RDMA/rtrs-srv: Kill rtrs_srv_change_state_get_old
      RDMA/rtrs: Introduce rtrs_post_send
      RDMA/rtrs-clt: Remove 'addr' from rtrs_clt_add_path_to_arr

Gustavo A. R. Silva (4):
      IB/hfi1: Fix fall-through warnings for Clang
      IB/mlx4: Fix fall-through warnings for Clang
      IB/qedr: Fix fall-through warnings for Clang
      IB/mlx5: Fix fall-through warnings for Clang

Jack Morgenstein (2):
      RDMA/core: Clean up cq pool mechanism
      RDMA/core: Do not indicate device ready when device enablement fails

Jack Wang (3):
      RDMA/rtrs-clt: Remove outdated comment in create_con_cq_qp
      RDMA/rtrs-clt: Avoid run destroy_con_cq_qp/create_con_cq_qp in parallel
      RDMA/ipoib: Distribute cq completion vector better

Jason Gunthorpe (43):
      RDMA/cxgb4: Remove MW support
      RDMA: Remove uverbs_ex_cmd_mask values that are linked to functions
      RDMA: Remove elements in uverbs_cmd_mask that all drivers set
      RDMA: Move more uverbs_cmd_mask settings to the core
      RDMA: Check srq_type during create_srq
      RDMA: Check attr_mask during modify_qp
      RDMA: Check flags during create_cq
      RDMA: Check create_flags during create_qp
      RDMA/core Remove uverbs_ex_cmd_mask
      RDMA: Remove uverbs cmds from drivers that don't use them
      RDMA: Remove AH from uverbs_cmd_mask
      RDMA/mlx5: Remove mlx5_ib_mr->order
      RDMA/mlx5: Fix corruption of reg_pages in mlx5_ib_rereg_user_mr()
      RDMA/mlx5: Remove mlx5_ib_mr->npages
      RDMA/mlx5: Move mlx5_ib_cont_pages() to the creation of the mlx5_ib_mr
      RDMA/mlx5: Remove order from mlx5_ib_cont_pages()
      RDMA/mlx5: Remove ncont from mlx5_ib_cont_pages()
      RDMA/mlx5: Remove npages from mlx5_ib_cont_pages()
      RDMA/mlx5: Change mlx5_ib_populate_pas() to use rdma_for_each_block()
      RDMA/mlx5: Move xlt_emergency_page_mutex into mr.c
      RDMA/mlx5: Split the WR setup out of mlx5_ib_update_xlt()
      RDMA/mlx5: Split mlx5_ib_update_xlt() into ODP and non-ODP cases
      RDMA/mlx5: Use ib_umem_find_best_pgsz() for mkc's
      RDMA/rxe,siw: Restore uverbs_cmd_mask IB_USER_VERBS_CMD_POST_SEND
      RDMA/mlx5: Use ib_umem_find_best_pgoff() for SRQ
      RDMA/mlx5: Use mlx5_umem_find_best_quantized_pgoff() for WQ
      RDMA/mlx5: Directly compute the PAS list for raw QP RQ's
      RDMA/mlx5: Use mlx5_umem_find_best_quantized_pgoff() for QP
      RDMA/mlx5: mlx5_umem_find_best_quantized_pgoff() for CQ
      RDMA/mlx5: Use ib_umem_find_best_pgsz() for devx
      RDMA/mlx5: Lower setting the umem's PAS for SRQ
      Merge branch 'for-rc' into rdma.git
      RDMA/siw,rxe: Make emulated devices virtual in the device tree
      Merge tag 'v5.10-rc5' into rdma.git for-next
      RDMA/cma: Fix deadlock on &lock in rdma_cma_listen_on_all() error unwind
      RDMA/mlx5: Check for ERR_PTR from uverbs_zalloc()
      Merge tag 'v5.10-rc6' into rdma.git for-next
      RDMA/uverbs: Tidy input validation of ib_uverbs_rereg_mr()
      RDMA/uverbs: Check ODP in ib_check_mr_access() as well
      RDMA/uverbs: Allow drivers to create a new HW object during rereg_mr
      RDMA/mlx5: Reorganize mlx5_ib_reg_user_mr()
      RDMA/mlx5: Fix error unwinds for rereg_mr
      Merge tag 'mlx5-next-2020-12-02' of git://git.kernel.org/.../mellanox/linux

Jing Xiangfeng (1):
      RDMA/core: Fix error return in _ib_modify_qp()

Joe Perches (4):
      RDMA: Convert sysfs device * show functions to use sysfs_emit()
      RDMA: Convert sysfs kobject * show functions to use sysfs_emit()
      RDMA: Manual changes for sysfs_emit and neatening
      RDMA: Convert various random sprintf sysfs _show uses to sysfs_emit

Kamal Heib (2):
      RDMA/bnxt_re: Set queue pair state when being queried
      RDMA/cxgb4: Validate the number of CQEs

Lang Cheng (6):
      RDMA/hns: Support owner mode doorbell
      RDMA/hns: Add new PCI device ID matching for HIP09
      RDMA/hns: Add support for CQ stash
      RDMA/hns: Add support for QP stash
      RDMA/hns: Fix 0-length sge calculation error
      RDMA/hns: Fix coding style issues

Leon Romanovsky (10):
      RDMA/core: Postpone uobject cleanup on failure till FD close
      RDMA/core: Make FD destroy callback void
      RDMA/counter: Combine allocation and bind logic
      RDMA/restrack: Store all special QPs in restrack DB
      RDMA/cma: Add missing error handling of listen_id
      RDMA/mlx5: Silence the overflow warning while building offset mask
      RDMA/core: Track device memory MRs
      RDMA/core: Allow drivers to disable restrack DB
      RDMA/restrack: Support all QP types
      RDMA/cma: Don't overwrite sgid_attr after device is released

Lukas Bulwahn (1):
      RDMA/core: Update kernel documentation for ib_create_named_qp()

Maor Gottlieb (3):
      tools/testing/scatterlist: Test dynamic __sg_alloc_table_from_pages
      RDMA/mlx5: Assign dev to DM MR
      RDMA/mlx5: Fix MR cache memory leak

Mauro Carvalho Chehab (1):
      IB: Fix kernel-doc markups

Max Gurtovoy (1):
      IB/isert: add module param to set sg_tablesize for IO cmd

Meir Lichtinger (3):
      RDMA/ipoib: Add 50Gb and 100Gb link speeds to ethtool
      IB/core: Add support for NDR link speed
      IB/mlx5: Add support for NDR link speed

Parav Pandit (1):
      RDMA/mlx5: Use PCI device for dma mappings

Rikard Falkeborn (1):
      RDMA/i40iw: Constify ops structs

Sebastian Andrzej Siewior (1):
      RDMA/iser: Remove in_interrupt() usage

Selvin Xavier (2):
      RDMA/bnxt_re: Fix entry size during SRQ create
      RDMA/bnxt_re: Fix max_qp_wrs reported

Shiraz Saleem (1):
      RDMA/i40iw: Remove push code from i40iw

Tom Rix (1):
      RDMA/mlx5: Remove unneeded semicolon

Vladimir Oltean (1):
      RDMA/mlx4: Remove bogus dev_base_lock usage

Weihang Li (14):
      RDMA/hns: Add support for configuring GMV table
      RDMA/hns: Add support for filling GMV table
      RDMA/hns: Fix double free of the pointer to TSQ/TPQ
      RDMA/hns: Only record vlan info for HIP08
      RDMA/hns: Fix missing fields in address vector
      RDMA/hns: Avoid setting loopback indicator when smac is same as dmac
      RDMA/hns: Remove the portn field in UD SQ WQE
      RDMA/hns: Simplify process of filling UD SQ WQE
      RDMA/hns: Add UD support for HIP09
      RDMA/hns: Refactor process of setting extended sge
      RDMA/hns: Move capability flags of QP and CQ to hns-abi.h
      RDMA/hns: Do shift on traffic class when using RoCEv2
      RDMA/hns: Avoid filling sl in high 3 bits of vlan_id
      RDMA/hns: WARN_ON if get a reserved sl from users

Wenpeng Liang (3):
      RDMA/hns: Limit the length of data copied between kernel and userspace
      RDMA/hns: Normalization the judgment of some features
      RDMA/hns: Fix incorrect symbol types

Xi Wang (1):
      RDMA/hns: Refactor the hns_roce_buf allocation flow

Xinhao Liu (1):
      RDMA/hns: Clear redundant variable initialization

Yangyang Li (2):
      RDMA/hns: Create QP with selected QPN for bank load balance
      RDMA/hns: Bugfix for calculation of extended sge

Yejune Deng (1):
      RDMA/i40iw: Replace atomic_add_return(1, ..)

Yixian Liu (2):
      RDMA/hns: Remove unnecessary access right set during INIT2INIT
      RDMA/hns: Simplify AEQE process for different types of queue

Yixing Liu (1):
      RDMA/hns: Fix inaccurate prints

Zhang Qilong (1):
      RDMA/siw: Fix typo of EAGAIN not -EAGAIN in siw_cm_work_handler()

Zhu Yanjun (2):
      RDMA/rxe: Remove VLAN code leftovers from RXE
      MAINTAINERS: SOFT-ROCE: Change Zhu Yanjun's email address

Zou Wei (1):
      IB/isert: Do not excplicitly check == false for bool

 .mailmap                                           |   1 +
 MAINTAINERS                                        |   2 +-
 drivers/infiniband/core/cm.c                       |   9 +-
 drivers/infiniband/core/cma.c                      | 195 +++--
 drivers/infiniband/core/cma_configfs.c             |   4 +-
 drivers/infiniband/core/core_priv.h                |  28 +-
 drivers/infiniband/core/counters.c                 | 138 ++-
 drivers/infiniband/core/cq.c                       |  16 +-
 drivers/infiniband/core/device.c                   |  92 +-
 drivers/infiniband/core/iwpm_util.h                |   2 +-
 drivers/infiniband/core/rdma_core.c                | 101 ++-
 drivers/infiniband/core/restrack.c                 |  23 +-
 drivers/infiniband/core/rw.c                       |   5 +-
 drivers/infiniband/core/sa_query.c                 |   3 +-
 drivers/infiniband/core/sysfs.c                    | 166 ++--
 drivers/infiniband/core/ucma.c                     |   2 +-
 drivers/infiniband/core/umem.c                     |  17 +-
 drivers/infiniband/core/user_mad.c                 |   6 +-
 drivers/infiniband/core/uverbs_cmd.c               | 149 ++--
 drivers/infiniband/core/uverbs_main.c              |   4 +-
 drivers/infiniband/core/uverbs_std_types.c         |  18 +-
 .../infiniband/core/uverbs_std_types_async_fd.c    |   5 +-
 .../infiniband/core/uverbs_std_types_counters.c    |   5 +-
 drivers/infiniband/core/uverbs_std_types_cq.c      |   4 +-
 drivers/infiniband/core/uverbs_std_types_device.c  |  14 +-
 drivers/infiniband/core/uverbs_std_types_dm.c      |   6 +-
 .../infiniband/core/uverbs_std_types_flow_action.c |   6 +-
 drivers/infiniband/core/uverbs_std_types_mr.c      |   6 +-
 drivers/infiniband/core/uverbs_std_types_qp.c      |   8 +-
 drivers/infiniband/core/uverbs_std_types_srq.c     |   4 +-
 drivers/infiniband/core/uverbs_std_types_wq.c      |   4 +-
 drivers/infiniband/core/uverbs_uapi.c              |   5 +-
 drivers/infiniband/core/verbs.c                    |  27 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c           |  15 +-
 drivers/infiniband/hw/bnxt_re/main.c               |  34 +-
 drivers/infiniband/hw/bnxt_re/qplib_sp.c           |   2 +-
 drivers/infiniband/hw/cxgb4/cq.c                   |   3 +
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h             |   2 -
 drivers/infiniband/hw/cxgb4/mem.c                  |  84 --
 drivers/infiniband/hw/cxgb4/provider.c             |  35 +-
 drivers/infiniband/hw/cxgb4/qp.c                   |   8 +-
 drivers/infiniband/hw/efa/efa_main.c               |  34 +-
 drivers/infiniband/hw/efa/efa_verbs.c              |   6 +
 drivers/infiniband/hw/hfi1/qp.c                    |   1 +
 drivers/infiniband/hw/hfi1/sysfs.c                 |  62 +-
 drivers/infiniband/hw/hfi1/tid_rdma.c              |   5 +
 drivers/infiniband/hw/hns/hns_roce_ah.c            |  55 +-
 drivers/infiniband/hw/hns/hns_roce_alloc.c         | 132 +--
 drivers/infiniband/hw/hns/hns_roce_cmd.c           |  37 +-
 drivers/infiniband/hw/hns/hns_roce_cmd.h           |   6 +-
 drivers/infiniband/hw/hns/hns_roce_common.h        |  26 +-
 drivers/infiniband/hw/hns/hns_roce_cq.c            |  46 +-
 drivers/infiniband/hw/hns/hns_roce_db.c            |   8 +-
 drivers/infiniband/hw/hns/hns_roce_device.h        | 178 ++--
 drivers/infiniband/hw/hns/hns_roce_hem.c           |  59 +-
 drivers/infiniband/hw/hns/hns_roce_hem.h           |   3 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c         |  50 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.h         |   2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c         | 554 ++++++------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h         | 265 +++---
 drivers/infiniband/hw/hns/hns_roce_main.c          |  82 +-
 drivers/infiniband/hw/hns/hns_roce_mr.c            |  79 +-
 drivers/infiniband/hw/hns/hns_roce_pd.c            |  14 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c            | 300 ++++---
 drivers/infiniband/hw/hns/hns_roce_srq.c           |  53 +-
 drivers/infiniband/hw/i40iw/i40iw.h                |   1 -
 drivers/infiniband/hw/i40iw/i40iw_cm.c             |   6 +-
 drivers/infiniband/hw/i40iw/i40iw_ctrl.c           |  72 +-
 drivers/infiniband/hw/i40iw/i40iw_d.h              |  35 +-
 drivers/infiniband/hw/i40iw/i40iw_status.h         |   1 -
 drivers/infiniband/hw/i40iw/i40iw_type.h           |  38 +-
 drivers/infiniband/hw/i40iw/i40iw_uk.c             |  41 +-
 drivers/infiniband/hw/i40iw/i40iw_user.h           |   8 -
 drivers/infiniband/hw/i40iw/i40iw_verbs.c          | 121 +--
 drivers/infiniband/hw/mlx4/mad.c                   |   1 +
 drivers/infiniband/hw/mlx4/main.c                  |  64 +-
 drivers/infiniband/hw/mlx4/mcg.c                   |  82 +-
 drivers/infiniband/hw/mlx4/mlx4_ib.h               |   8 +-
 drivers/infiniband/hw/mlx4/mr.c                    |  16 +-
 drivers/infiniband/hw/mlx4/qp.c                    |  14 +-
 drivers/infiniband/hw/mlx4/srq.c                   |   4 +
 drivers/infiniband/hw/mlx4/sysfs.c                 |  66 +-
 drivers/infiniband/hw/mlx5/cq.c                    |  77 +-
 drivers/infiniband/hw/mlx5/devx.c                  |  90 +-
 drivers/infiniband/hw/mlx5/fs.c                    |   6 +-
 drivers/infiniband/hw/mlx5/main.c                  | 105 +--
 drivers/infiniband/hw/mlx5/mem.c                   | 192 ++---
 drivers/infiniband/hw/mlx5/mlx5_ib.h               | 102 ++-
 drivers/infiniband/hw/mlx5/mr.c                    | 960 ++++++++++++---------
 drivers/infiniband/hw/mlx5/odp.c                   |  56 +-
 drivers/infiniband/hw/mlx5/qp.c                    | 197 ++---
 drivers/infiniband/hw/mlx5/restrack.c              |   2 +-
 drivers/infiniband/hw/mlx5/srq.c                   |  34 +-
 drivers/infiniband/hw/mlx5/srq.h                   |   1 +
 drivers/infiniband/hw/mlx5/srq_cmd.c               |  80 +-
 drivers/infiniband/hw/mthca/mthca_cq.c             |   2 +-
 drivers/infiniband/hw/mthca/mthca_dev.h            |   1 -
 drivers/infiniband/hw/mthca/mthca_provider.c       |  61 +-
 drivers/infiniband/hw/mthca/mthca_qp.c             |   3 +
 drivers/infiniband/hw/ocrdma/ocrdma_main.c         |  42 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c        |  11 +-
 drivers/infiniband/hw/qedr/main.c                  |  39 +-
 drivers/infiniband/hw/qedr/verbs.c                 |  13 +
 drivers/infiniband/hw/qib/qib_pcie.c               |  11 +-
 drivers/infiniband/hw/qib/qib_sysfs.c              |  96 +--
 drivers/infiniband/hw/usnic/usnic_ib_main.c        |  19 -
 drivers/infiniband/hw/usnic/usnic_ib_sysfs.c       | 100 +--
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c       |   7 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c       |   3 +
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c     |  34 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c       |   5 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c      |   2 +-
 drivers/infiniband/sw/rdmavt/Kconfig               |   1 -
 drivers/infiniband/sw/rdmavt/ah.c                  |   3 +-
 drivers/infiniband/sw/rdmavt/cq.c                  |   2 +-
 drivers/infiniband/sw/rdmavt/mcast.c               |  12 +-
 drivers/infiniband/sw/rdmavt/mr.c                  |   6 +-
 drivers/infiniband/sw/rdmavt/qp.c                  |  18 +-
 drivers/infiniband/sw/rdmavt/vt.c                  |  36 +-
 drivers/infiniband/sw/rxe/Kconfig                  |   1 -
 drivers/infiniband/sw/rxe/rxe_cq.c                 |   5 -
 drivers/infiniband/sw/rxe/rxe_mr.c                 |   1 -
 drivers/infiniband/sw/rxe/rxe_net.c                |  18 -
 drivers/infiniband/sw/rxe/rxe_queue.h              |  94 +-
 drivers/infiniband/sw/rxe/rxe_req.c                |   3 +-
 drivers/infiniband/sw/rxe/rxe_resp.c               |   5 -
 drivers/infiniband/sw/rxe/rxe_verbs.c              |  67 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h              |   2 -
 drivers/infiniband/sw/siw/Kconfig                  |   1 -
 drivers/infiniband/sw/siw/siw.h                    |   1 -
 drivers/infiniband/sw/siw/siw_cm.c                 |   2 +-
 drivers/infiniband/sw/siw/siw_main.c               |  52 +-
 drivers/infiniband/sw/siw/siw_verbs.c              |  12 +
 drivers/infiniband/ulp/ipoib/ipoib_cm.c            |   4 +-
 drivers/infiniband/ulp/ipoib/ipoib_ethtool.c       |   4 +
 drivers/infiniband/ulp/ipoib/ipoib_main.c          |   7 +-
 drivers/infiniband/ulp/ipoib/ipoib_verbs.c         |   4 +-
 drivers/infiniband/ulp/ipoib/ipoib_vlan.c          |   2 +-
 drivers/infiniband/ulp/iser/iscsi_iser.c           |  24 +-
 drivers/infiniband/ulp/isert/ib_isert.c            |  29 +-
 drivers/infiniband/ulp/isert/ib_isert.h            |   6 +
 drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h   |   2 +-
 .../infiniband/ulp/opa_vnic/opa_vnic_vema_iface.c  |   2 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c       |  62 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt.c             |  74 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt.h             |   1 +
 drivers/infiniband/ulp/rtrs/rtrs-pri.h             |   3 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c       |  21 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv.c             | 119 +--
 drivers/infiniband/ulp/rtrs/rtrs-srv.h             |   2 +-
 drivers/infiniband/ulp/rtrs/rtrs.c                 |  61 +-
 drivers/infiniband/ulp/srp/ib_srp.c                |  48 +-
 drivers/infiniband/ulp/srpt/ib_srpt.c              |  14 +-
 drivers/infiniband/ulp/srpt/ib_srpt.h              |   2 +-
 drivers/nvme/host/rdma.c                           |   2 +-
 drivers/nvme/target/rdma.c                         |   3 +-
 drivers/pci/p2pdma.c                               |  25 +-
 include/linux/dma-mapping.h                        |   2 -
 include/rdma/ib_umem.h                             |  42 +
 include/rdma/ib_verbs.h                            | 198 +++--
 include/rdma/restrack.h                            |  24 +
 include/rdma/uverbs_ioctl.h                        |  25 +-
 include/rdma/uverbs_types.h                        |   9 +-
 include/uapi/rdma/hns-abi.h                        |  10 +
 include/uapi/rdma/ib_user_verbs.h                  |  14 -
 include/uapi/rdma/rdma_user_rxe.h                  |  21 +
 kernel/dma/Kconfig                                 |   5 -
 kernel/dma/Makefile                                |   1 -
 kernel/dma/virt.c                                  |  61 --
 net/rds/ib.c                                       |  10 -
 net/rds/ib.h                                       |  13 -
 net/rds/ib_cm.c                                    | 128 +--
 net/rds/ib_recv.c                                  |  18 +-
 net/rds/ib_send.c                                  |   8 +
 tools/testing/scatterlist/main.c                   |  64 +-
 175 files changed, 3845 insertions(+), 3915 deletions(-)
(diffstat from tag for-linus-merged)

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAl/aSocACgkQOG33FX4g
mxqUIw/+PvTdtvx4WvGNou12LIxto8fUY0JUhBp4lDxCYyETE3K0cum8iuudJbCh
sYk6zR1gHbBOC/xoitaF0RF3hmbykDheWfhhEmMxoW0RCjKYGyo0bGfZiKcJJsUN
cKhMBg2Vt+5iG0S34Z2x3Ph+BpSt3vOQBh1W/b9FNHa2omptSAdllSPS35dOUKhm
ob4kJyE4H5yggrhK11QICaE3ugh5FPyC/LMghqaW917cIFX5ZVX+eBV3J3wCpl83
7oVt26WZhQyKSialGCdziUPqSH614V1KL+RZnbYqCHENSQ3Zt+MsCUHWg14vqDZ+
Rh2tsTuFc3O0s5xPZhFm58bkZaeRDCzkOL4sZGN7AH8pU09Qu2eJeSZRquQjHFoV
+kw6TCrh/1FJ1pUEGd/tTRe4j9LaQgVEuRONvEPQmkyTk8p3OjWLkpPKrwv/7TT7
nGR0hy0g1BkzENSD9wH88ENu43Lovo598XukvXMZccII1pUlrycAn0ZVWsWJ0ALy
40DHbgjfW39iTMYqG3QJWg2WWywoVnse4XfBNQeNVMgmTCIF5UuP4pJlCUf912UM
AAJJIZD/h1NyvzAeifL/vZ+3V2gV9DJDhBscYcldXyLwfO4q9dGKZAdnGdln9blI
rlU74GzyAnfu7dCtJfbcweoD4abqkFLJEeX9YWPqEUrerL7Vo0o=
=TPYM
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
