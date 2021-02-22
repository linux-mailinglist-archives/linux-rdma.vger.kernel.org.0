Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD91321AB2
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Feb 2021 16:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhBVPAV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Feb 2021 10:00:21 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:11175 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbhBVPAR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Feb 2021 10:00:17 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6033c6cd0000>; Mon, 22 Feb 2021 06:59:25 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 22 Feb
 2021 14:59:25 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 22 Feb 2021 14:59:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PhO8Dnyb7VaMNZCZ/Zukty3RLvqV5kA19M/v5RAeTgvl5EnZXx3eLfsnZfjUljmrG0+cnNZVDmDdIzHrDga2dCgJFRvuS+zwL7gptZCgm4lzXvuyZZd9TpSbp2oiGYrc/IMcAfhPaE5rk4lim5HkLw1fLyRycopyUn5JDS30RPe/8L/TLL4oL0ksxSPmVoKqlA5TGZn6Y+egFEtFllPgd0iJ+gC1+nJ6b4E/bO/ZcFOHlByHYh7bLJv45IbJqav5J+3jXj4u2jPsy8kL9SkDo/F/XcZWiyv+qZ6R7LjwP12/TLN1i2urL/MYFKoidGjIQBMUoPV4t+vq/HInn3Vf1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hKZwS0wLoPjqukAbsI9OUwg5nOXvz0wY43DEtrXhUA=;
 b=dlDrgOzq8JpnHDtGO9808UamaWU1+h7oEcIyz+7vwnp/BuR4Eb6xcklOa4zTcchQ6Wc1Oi/n4m1P4YrD9S0wGLQxc2F9MyKEXWl6XweglwL5UQ0SW0RJdrgMNiyS/MuqJKcGXZt1cAJilZnlOF3f5mIobF1ZRmpG1Bhojw+ysTFQtUdSxaqU0DaPXnaoqWPjwUCi1EGVOx/bB5yOshoyZy3M333kEM8VT3r0xKOsia/UdAKnd6xR8xwFmWbsWbDIXgKzVxBozTIQ9+YT6q0zUWwwqXYRH+1mh8q/RDBHj/8lMOx+f5NB6qZ3zzSJMAwpQAsUrhxwZ4hZo98TCeF3fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0202.namprd12.prod.outlook.com (2603:10b6:4:4d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Mon, 22 Feb
 2021 14:59:23 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4%7]) with mapi id 15.20.3846.045; Mon, 22 Feb 2021
 14:59:23 +0000
Date:   Mon, 22 Feb 2021 10:59:21 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20210222145921.GA3435145@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
X-ClientProxiedBy: MN2PR08CA0016.namprd08.prod.outlook.com
 (2603:10b6:208:239::21) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR08CA0016.namprd08.prod.outlook.com (2603:10b6:208:239::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Mon, 22 Feb 2021 14:59:22 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lECgD-00EQJF-LV; Mon, 22 Feb 2021 10:59:21 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614005965; bh=8hKZwS0wLoPjqukAbsI9OUwg5nOXvz0wY43DEtrXhUA=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:Content-Type:Content-Disposition:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=Gsc4ESUb62GWpxltP02ZYPFYoFZM7JU2rAaqIq3JI5za7NrommPDY5NeN29yzSwvK
         urzf0pXuDBvK3MUMyWjSt9zAEkugA6AUjp4iA0BGDg7pZddOKRKTo+gDJ0etn3l7hf
         B4FcvwBFkk7Qx/J//0WOVFehTBVnkHu7uRR7+aPyKElugZv7LcOHyd7Z3Hb6ee60Gp
         FylH9S7R15zc6/QnSSl74nldgQNmHuEjqUsrqH8DBxjZkjnet53+OLuGfinGexviko
         8nG3RmFki4GyCAIsX1mP5DXso3zsIgadhpf6b/fS+dcVotCNcrIuwmVyghzzLenoQG
         G2Qa7xAZOxdEg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

These are the proposed RDMA patches for 5.12.

This is quite a small cycle, if not for Lee's 70 patches cleaning the kdocs it
would be well below typical for patch count.

Most of the interesting work here was in the HNS and rxe drivers which got
fairly major internal changes.

As before there was a slightly tricky conflict with the rdma for-rc
tree, which I've resolved by merging in v5.11 at the top.

The following changes since commit a6a217dddcd544f6b75f0e2a60b6e84c1d494b7e:

  net/mlx5: Add new timestamp mode bits (2021-02-16 16:10:39 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 7289e26f395b583f68b676d4d12a0971e4f6f65c:

  Merge tag 'v5.11' into rdma.git for-next (2021-02-18 11:19:29 -0400)

----------------------------------------------------------------
RDMA 5.12 merge window  pull request

- Driver updates and bug fixes: siw, hns, bnxt_re, mlx5, efa

- Significant rework in rxe to get it ready to have XRC support added

- Several rts bug fixes

- Big series to get to 'make W=1' cleanness, primarily updating kdocs

- Support for creating a RDMA MR from a DMABUF fd to allow PCI peer to
  peer transfers to GPU VRAM

- Device disassociation now works properly with umad

- Work to support more than 255 ports on a RDMA device

- Further support for the new HNS HIP09 hardware

- Coding style cleanups: comma to semicolon, unneded semicolon/blank
  lines, remove 'h' printk format, don't check for NULL before kfree,
  use true/false for bool.

----------------------------------------------------------------
Aharon Landau (1):
      RDMA/mlx5: Fail QP creation if the device can not support the CQE TS

Avihai Horon (1):
      RDMA/ucma: Fix use-after-free bug in ucma_create_uevent

Bernard Metzler (1):
      RDMA/siw: Fix handling of zero-sized Read and Receive Queues.

Bob Pearson (21):
      RDMA/rxe: Remove unneeded RXE_POOL_ATOMIC flag
      RDMA/rxe: Let pools support both keys and indices
      RDMA/rxe: Add elem_offset field to rxe_type_info
      RDMA/rxe: Make pool lookup and alloc APIs type safe
      RDMA/rxe: Make add/drop key/index APIs type safe
      RDMA/rxe: Add unlocked versions of pool APIs
      RDMA/rxe: Fix race in rxe_mcast.c
      RDMA/rxe: Fix bug in rxe_alloc()
      RDMA/rxe: Fix misleading comments and names
      RDMA/rxe: Remove RXE_POOL_ATOMIC
      RDMA/rxe: Remove references to ib_device and pool
      RDMA/rxe: Remove unneeded pool->state
      RDMA/rxe: Replace missing rxe_pool_get_index_locked
      RDMA/rxe: Fix coding error in rxe_recv.c
      RDMA/rxe: Remove useless code in rxe_recv.c
      RDMA/rxe: Fix coding error in rxe_rcv_mcast_pkt
      RDMA/rxe: Correct skb on loopback path
      RDMA/rxe: Fix FIXME in rxe_udp_encap_recv()
      RDMA/rxe: Fix minor coding style issues
      RDMA/rxe: Cleanup init_send_wqe
      RDMA/rxe: Remove unused pkt->offset

Christoph Lameter (1):
      RDMA/ipoib: Remove racy Subnet Manager sendonly join checks

Gal Pressman (5):
      RDMA/efa: Remove redundant NULL pointer check of CQE
      RDMA/efa: Remove duplication of upper/lower_32_bits
      RDMA/efa: Remove unnecessary indentation in defs comments
      RDMA/efa: Remove unused 'select' field from get/set feature command descriptor
      RDMA/efa: Remove unused syndrome enum values

Gioh Kim (2):
      RDMA/rtrs-srv: fix memory leak by missing kobject free
      RDMA/rtrs-srv-sysfs: fix missing put_device

Guoqing Jiang (8):
      RDMA/rtrs-srv: Jump to dereg_mr label if allocate iu fails
      RDMA/rtrs: Call kobject_put in the failure path
      RDMA/rtrs-clt: Consolidate rtrs_clt_destroy_sysfs_root_{folder,files}
      RDMA/rtrs-clt: Kill wait_for_inflight_permits
      RDMA/rtrs-clt: Remove unnecessary 'goto out'
      RDMA/rtrs-clt: Kill rtrs_clt_change_state
      RDMA/rtrs-clt: Rename __rtrs_clt_change_state to rtrs_clt_change_state
      RDMA/rtrs-clt: Refactor the failure cases in alloc_clt

Jack Wang (12):
      RDMA/rtrs: Extend ibtrs_cq_qp_create
      RDMA/rtrs-srv: Release lock before call into close_sess
      RDMA/rtrs-srv: Use sysfs_remove_file_self for disconnect
      RDMA/rtrs-clt: Set mininum limit when create QP
      RDMA/rtrs-srv: Fix missing wr_cqe
      RDMA/rtrs: Do not signal for heatbeat
      RDMA/rtrs-clt: Use bitmask to check sess->flags
      RDMA/rtrs-srv: Do not signal REG_MR
      RDMA/rtrs-srv: Init wr_cnt as 1
      RDMA/rtrs: Fix KASAN: stack-out-of-bounds bug
      RDMA/rtrs-srv: Fix stack-out-of-bounds
      RDMA/rtrs-srv: Do not pass a valid pointer to PTR_ERR()

Jason Gunthorpe (3):
      Merge branch 'devx_set_get' into rdma.git for-next
      Merge branch 'mlx5_timestamp' into rdma.git for-next
      Merge tag 'v5.11' into rdma.git for-next

Jianxin Xiong (4):
      RDMA/umem: Support importing dma-buf as user memory region
      RDMA/core: Add device method for registering dma-buf based memory region
      RDMA/uverbs: Add uverbs command for dma-buf based MR registration
      RDMA/mlx5: Support dma-buf based userspace memory region

Jiapeng Chong (1):
      RDMA/qedr: Use true and false for bool variable

Kamal Heib (1):
      RDMA/siw: Fix calculation of tx_valid_cpus size

Lang Cheng (12):
      RDMA/hns: Optimize the MR registration process
      RDMA/hns: Use new interface to set MPT related fields
      RDMA/hns: Allocate one more recv SGE for HIP08
      RDMA/hns: Use new interfaces to write SRQC
      RDMA/hns: Replace wmb&__raw_writeq with writeq
      RDMA/hns: Move HIP06 related definitions into hns_roce_hw_v1.h
      RDMA/hns: Avoid unnecessary memset on WQEs in post_send
      RDMA/hns: Remove unused member and variable of CMDQ
      RDMA/hns: Fixes missing error code of CMDQ
      RDMA/hns: Remove redundant operations on CMDQ
      RDMA/hns: Adjust fields and variables about CMDQ tail/head
      RDMA/hns: Refactor process of posting CMDQ

Lee Jones (70):
      RDMA/hw: i40iw_hmc: Fix misspellings of '*idx' args
      RDMA/core: device: Fix formatting in worthy kernel-doc header and demote another
      RDMA/hw/i40iw/i40iw_ctrl: Fix a bunch of misspellings and formatting issues
      RDMA/hw/i40iw/i40iw_cm: Fix a bunch of function documentation issues
      RDMA/core/cache: Fix some misspellings, missing and superfluous param descriptions
      RDMA/hw/i40iw/i40iw_hw: Provide description for 'ipv4', remove 'user_pri' and fix 'iwcq'
      RDMA/hw/i40iw/i40iw_main: Rectify some kernel-doc misdemeanours
      RDMA/core/roce_gid_mgmt: Fix misnaming of 'rdma_roce_rescan_device()'s param 'ib_dev'
      RDMA/hw/i40iw/i40iw_pble: Provide description for 'dev' and fix formatting issues
      RDMA/hw/i40iw/i40iw_puda: Fix some misspellings and provide missing descriptions
      RDMA/core/multicast: Provide description for 'ib_init_ah_from_mcmember()'s 'rec' param
      RDMA/core/sa_query: Demote non-conformant kernel-doc header
      RDMA/hw/i40iw/i40iw_uk: Clean-up some function documentation headers
      RDMA/hw/i40iw/i40iw_virtchnl: Fix a bunch of kernel-doc issues
      RDMA/hw/i40iw/i40iw_utils: Fix some misspellings and missing param descriptions
      RDMA/core/restrack: Fix kernel-doc formatting issue
      RDMA/hw/i40iw/i40iw_verbs: Fix worthy function headers and demote some others
      RDMA/core/counters: Demote non-conformant kernel-doc headers
      RDMA/core/iwpm_util: Fix some param description misspellings
      RDMA/core/iwpm_msg: Add proper descriptions for 'skb' param
      RDMA/hw/mlx5/odp: Fix formatting and add missing descriptions in 'pagefault_data_segments()'
      RDMA/hw/mlx5/qp: Demote non-conformant kernel-doc header
      RDMA/hw/efa/efa_com: Stop using param description notation for non-params
      RDMA/hw/hns/hns_roce_hw_v1: Fix doc-rot issue relating to 'rereset'
      RDMA/hw/hns/hns_roce_mr: Add missing description for 'hr_dev' param
      RDMA/hw/qib/qib_driver: Fix misspelling in 'ppd's param description
      RDMA/sw/rdmavt/vt: Fix formatting issue and update description for 'context'
      RDMA/hw/qib/qib_eeprom: Fix misspelling of 'buff' in 'qib_eeprom_{read,write}()'
      RDMA/hw/qib/qib_mad: Fix a few misspellings and supply missing descriptions
      RDMA/hw/qib/qib_intr: Fix a bunch of formatting issues
      RDMA/hw/qib/qib_pcie: Demote obvious kernel-doc abuse
      RDMA/hw/qib/qib_qp: Fix some issues in worthy kernel-doc headers and demote another
      RDMA/sw/rdmavt/cq: Demote hardly complete kernel-doc header
      RDMA/hw/qib/qib_rc: Fix some worthy kernel-docs demote hardly complete one
      RDMA/hw/hfi1/chip: Fix a bunch of kernel-doc formatting and spelling issues
      RDMA/hw/qib/qib_twsi: Provide description for missing param 'last'
      RDMA/hw/qib/qib_tx: Provide description for 'qib_chg_pioavailkernel()'s 'rcd' param
      RDMA/hw/qib/qib_uc: Provide description for missing 'flags' param
      RDMA/hw/qib/qib_ud: Provide description for 'qib_make_ud_req's 'flags' param
      RDMA/sw/rdmavt/mad: Fix 'rvt_process_mad()'s documentation header
      RDMA/hw/qib/qib_user_pages: Demote non-conformant documentation header
      RDMA/sw/rdmavt/mcast: Demote incomplete kernel-doc header
      RDMA/hw/hfi1/exp_rcv: Fix some kernel-doc formatting issues
      RDMA/hw/qib/qib_iba7220: Fix some kernel-doc issues
      RDMA/hw/hfi1/file_ops: Fix' manage_rcvq()'s 'arg' param
      RDMA/sw/rdmavt/mr: Fix some issues related to formatting and missing descriptions
      RDMA/hw/qib/qib_iba7322: Fix a bunch of copy/paste issues
      RDMA/hw/qib/qib_verbs: Repair some formatting problems
      RDMA/hw/qib/qib_iba6120: Fix some repeated (copy/paste) kernel-doc issues
      RDMA/sw/rdmavt/qp: Fix a bunch of kernel-doc misdemeanours
      RDMA/hw/hfi1/intr: Fix some kernel-doc formatting issues
      RDMA/sw/rdmavt/srq: Fix a couple of kernel-doc issues
      RDMA/hw/hfi1/iowait: Demote half-completed kernel-doc and fix formatting issue in another
      RDMA/hw/hfi1/mad: Demote half-completed kernel-doc header fix another
      RDMA/hw/hfi1/msix: Add description for 'name' and remove superfluous param 'idx'
      RDMA/sw/rdmavt/mad: Fix misspelling of 'rvt_process_mad()'s 'in_mad_size' param
      RDMA/sw/rdmavt/qp: Fix kernel-doc formatting problem
      RDMA/hw/hfi1/netdev_rx: Fix misdocumentation of the 'start_id' param
      RDMA/hw/hfi1/pcie: Demote kernel-doc abuses
      RDMA/hw/hfi1/pio_copy: Provide entry for 'pio_copy()'s 'dd' param
      RDMA/hw/hfi1/rc: Fix a few function documentation issues
      RDMA/hw/hfi1/qp: Fix some formatting issues and demote kernel-doc abuse
      RDMA/hw/hfi1/ruc: Fix a small formatting and description issues
      RDMA/hw/hfi1/sdma: Fix misnaming of 'sdma_send_txlist()'s 'count_out' param
      RDMA/hw/hfi1/tid_rdma: Fix a plethora of kernel-doc issues
      RDMA/hw/hfi1/uc: Fix a little doc-rot
      RDMA/hw/hfi1/ud: Fix a little more doc-rot
      RDMA/hw/hfi1/user_exp_rcv: Demote half-documented and kernel-doc abuses
      RDMA/hw/hfi1/verbs: Demote non-conforming doc header and fix a misspelling
      RDMA/hw/hfi1/rc: Demote incorrectly populated kernel-doc header

Leon Romanovsky (1):
      RDMA/core: Fix kernel doc warnings for ib_port_immutable_read()

Lijun Ou (1):
      RDMA/hns: Disable RQ inline by default

Maor Gottlieb (1):
      tools/testing/scatterlist: Fix overflow of max segment size

Mark Bloch (1):
      RDMA/mlx5: Allow creating all QPs even when non RDMA profile is used

Max Gurtovoy (7):
      IB/isert: Remove unneeded new lines
      IB/isert: Remove unneeded semicolon
      IB/isert: Simplify signature cap check
      IB/iser: Remove unneeded semicolons
      IB/iser: Protect iscsi_max_lun module param using callback
      IB/iser: Enforce iser_max_sectors to be greater than 0
      IB/iser: Simplify prot_caps setting

Md Haris Iqbal (1):
      RDMA/rtrs: Only allow addition of path to an already established session

Nicolas Morey-Chaisemartin (1):
      RDMA/srp: Fix support for unpopulated and unbalanced NUMA nodes

Parav Pandit (12):
      IB/mlx5: Add mutex destroy call to cap_mask_mutex mutex
      IB/mlx5: Make function static
      IB/mlx5: Return appropriate error code instead of ENOMEM
      IB/cm: Avoid a loop when device has 255 ports
      IB/mlx4: Use port iterator and validation APIs
      IB/core: Use valid port number to check link layer
      IB/mlx5: Support default partition key for representor port
      IB/mlx5: Move mlx5_port_caps from mlx5_core_dev to mlx5_ib_dev
      IB/mlx5: Avoid calling query device for reading pkey table length
      IB/mlx5: Improve query port for representor port
      RDMA/core: Introduce and use API to read port immutable data
      IB/mlx5: Use rdma_for_each_port for port iteration

Patrisious Haddad (2):
      RDMA/nldev: Return an error message on failure to turn auto mode
      RDMA/mlx5: Support 400Gbps IB rate in mlx5 driver

Sebastian Andrzej Siewior (1):
      RDMA/qedr: Remove in_irq() usage from debug output

Selvin Xavier (2):
      RDMA/bnxt_re: Code refactor while populating user MRs
      RDMA/bnxt_re: Allow bigger MR creation

Shay Drory (2):
      IB/umad: Return EIO in case of when device disassociated
      IB/umad: Return EPOLLERR in case of when device disassociated

Tal Gilboa (1):
      RDMA/mlx5: Allow CQ creation without attached EQs

Tom Rix (2):
      RDMA/hns: remove h from printk format specifier
      RDMA/hfi1: remove h from printk format specifier

Weihang Li (3):
      RDMA/pvrdma: Replace spin_lock_irqsave with spin_lock in hard IRQ
      RDMA/hns: Avoid filling sgid index when modifying QP to RTR
      RDMA/hns: Fix type of sq_signal_bits

Wenpeng Liang (8):
      RDMA/hns: Bugfix for checking whether the srq is full when post wr
      RDMA/hns: Force srq_limit to 0 when creating SRQ
      RDMA/hns: Fixed wrong judgments in the goto branch
      RDMA/hns: Remove the reserved WQE of SRQ
      RDMA/hns: Refactor hns_roce_create_srq()
      RDMA/hns: Refactor code about SRQ Context
      RDMA/hns: Refactor hns_roce_v2_post_srq_recv()
      RDMA/hns: Add verification of QP type when post_recv

Xi Wang (4):
      RDMA/hns: Refactor the MTR creation flow
      RDMA/hns: Refactor post recv flow
      RDMA/hns: Clear remaining unused sges when post_recv
      RDMA/hns: Add mapped page count checking for MTR

Xiao Yang (2):
      RDMA/rxe: Add check for supported QP types
      RDMA/uverbs: Don't set rcq for a QP if qp_type is IB_QPT_XRC_INI

Xinhao Liu (2):
      RDMA/hns: Remove some magic numbers
      RDMA/hns: Delete redundant judgment when preparing descriptors

Yangyang Li (1):
      RDMA/hns: Create CQ with selected CQN for bank load balance

Yishai Hadas (3):
      RDMA/mlx5: Use the correct obj_id upon DEVX TIR creation
      RDMA/mlx5: Use strict get/set operations for obj_id
      RDMA/mlx5: Cleanup the synchronize_srcu() from the ODP flow

Yixian Liu (1):
      RDMA/hns: Remove unnecessary wrap around for EQ's consumer index

Yixing Liu (3):
      RDMA/hns: Add support of direct wqe
      RDMA/hns: Skip qp_flow_control_init() for HIP09
      RDMA/hns: Adjust definition of FRMR fields

Zheng Yongjun (3):
      RDMA: Convert comma to semicolon
      RDMA/cma: Delete useless kfree code
      RDMA: Use kzalloc for allocating only one thing

 drivers/infiniband/Kconfig                      |   1 +
 drivers/infiniband/core/Makefile                |   2 +-
 drivers/infiniband/core/cache.c                 |   9 +-
 drivers/infiniband/core/cm.c                    |   8 +-
 drivers/infiniband/core/cma.c                   |  81 +--
 drivers/infiniband/core/cma_configfs.c          |  12 +-
 drivers/infiniband/core/counters.c              |  78 +--
 drivers/infiniband/core/device.c                |  23 +-
 drivers/infiniband/core/iwpm_msg.c              |  16 +-
 drivers/infiniband/core/iwpm_util.c             |   6 +-
 drivers/infiniband/core/multicast.c             |   1 +
 drivers/infiniband/core/nldev.c                 |   4 +-
 drivers/infiniband/core/restrack.c              |   4 +-
 drivers/infiniband/core/roce_gid_mgmt.c         |   2 +-
 drivers/infiniband/core/rw.c                    |   2 +-
 drivers/infiniband/core/sa_query.c              |  26 +-
 drivers/infiniband/core/umem.c                  |   3 +
 drivers/infiniband/core/umem_dmabuf.c           | 174 ++++++
 drivers/infiniband/core/user_mad.c              |  17 +-
 drivers/infiniband/core/uverbs_cmd.c            |   2 +-
 drivers/infiniband/core/uverbs_std_types_mr.c   | 117 +++-
 drivers/infiniband/core/verbs.c                 |   4 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c        |  49 +-
 drivers/infiniband/hw/bnxt_re/qplib_sp.c        |  29 +-
 drivers/infiniband/hw/bnxt_re/qplib_sp.h        |   2 +-
 drivers/infiniband/hw/cxgb4/restrack.c          |   2 +-
 drivers/infiniband/hw/efa/efa_admin_cmds_defs.h |  25 +-
 drivers/infiniband/hw/efa/efa_admin_defs.h      |   4 +-
 drivers/infiniband/hw/efa/efa_com.c             |  33 +-
 drivers/infiniband/hw/hfi1/chip.c               |  46 +-
 drivers/infiniband/hw/hfi1/exp_rcv.c            |   8 +-
 drivers/infiniband/hw/hfi1/file_ops.c           |   2 +-
 drivers/infiniband/hw/hfi1/intr.c               |  16 +-
 drivers/infiniband/hw/hfi1/iowait.c             |   4 +-
 drivers/infiniband/hw/hfi1/mad.c                |   4 +-
 drivers/infiniband/hw/hfi1/msix.c               |   2 +-
 drivers/infiniband/hw/hfi1/netdev_rx.c          |   2 +-
 drivers/infiniband/hw/hfi1/pcie.c               |   4 +-
 drivers/infiniband/hw/hfi1/pio_copy.c           |   1 +
 drivers/infiniband/hw/hfi1/qp.c                 |  14 +-
 drivers/infiniband/hw/hfi1/qsfp.c               |   4 +-
 drivers/infiniband/hw/hfi1/rc.c                 |   7 +-
 drivers/infiniband/hw/hfi1/ruc.c                |   5 +-
 drivers/infiniband/hw/hfi1/sdma.c               |  12 +-
 drivers/infiniband/hw/hfi1/tid_rdma.c           |  47 +-
 drivers/infiniband/hw/hfi1/uc.c                 |   8 +-
 drivers/infiniband/hw/hfi1/ud.c                 |   8 +-
 drivers/infiniband/hw/hfi1/user_exp_rcv.c       |  10 +-
 drivers/infiniband/hw/hfi1/verbs.c              |   6 +-
 drivers/infiniband/hw/hns/hns_roce_common.h     |  26 +-
 drivers/infiniband/hw/hns/hns_roce_cq.c         | 116 +++-
 drivers/infiniband/hw/hns/hns_roce_device.h     |  82 +--
 drivers/infiniband/hw/hns/hns_roce_hem.c        |   9 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c      |  33 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.h      |  43 ++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c      | 791 ++++++++++++------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h      | 141 ++++-
 drivers/infiniband/hw/hns/hns_roce_main.c       |  30 +-
 drivers/infiniband/hw/hns/hns_roce_mr.c         | 458 ++++++--------
 drivers/infiniband/hw/hns/hns_roce_qp.c         |  38 +-
 drivers/infiniband/hw/hns/hns_roce_srq.c        | 331 +++++-----
 drivers/infiniband/hw/i40iw/i40iw_cm.c          |  21 +-
 drivers/infiniband/hw/i40iw/i40iw_ctrl.c        |  18 +-
 drivers/infiniband/hw/i40iw/i40iw_hmc.c         |   4 +-
 drivers/infiniband/hw/i40iw/i40iw_hw.c          |   4 +-
 drivers/infiniband/hw/i40iw/i40iw_main.c        |  13 +-
 drivers/infiniband/hw/i40iw/i40iw_pble.c        |   5 +-
 drivers/infiniband/hw/i40iw/i40iw_puda.c        |  13 +-
 drivers/infiniband/hw/i40iw/i40iw_uk.c          |   5 +-
 drivers/infiniband/hw/i40iw/i40iw_utils.c       |  22 +-
 drivers/infiniband/hw/i40iw/i40iw_verbs.c       |  19 +-
 drivers/infiniband/hw/i40iw/i40iw_virtchnl.c    |  19 +-
 drivers/infiniband/hw/mlx4/main.c               |   2 +-
 drivers/infiniband/hw/mlx4/sysfs.c              |   4 +-
 drivers/infiniband/hw/mlx5/devx.c               | 227 +++++--
 drivers/infiniband/hw/mlx5/mad.c                |  14 +-
 drivers/infiniband/hw/mlx5/main.c               | 147 ++---
 drivers/infiniband/hw/mlx5/mlx5_ib.h            |  60 +-
 drivers/infiniband/hw/mlx5/mr.c                 | 137 +++-
 drivers/infiniband/hw/mlx5/odp.c                | 325 +++++-----
 drivers/infiniband/hw/mlx5/qp.c                 | 160 ++++-
 drivers/infiniband/hw/mlx5/wr.c                 |   2 +-
 drivers/infiniband/hw/qedr/qedr.h               |   8 +-
 drivers/infiniband/hw/qedr/qedr_roce_cm.c       |   4 +-
 drivers/infiniband/hw/qib/qib_driver.c          |   2 +-
 drivers/infiniband/hw/qib/qib_eeprom.c          |   4 +-
 drivers/infiniband/hw/qib/qib_iba6120.c         |  18 +-
 drivers/infiniband/hw/qib/qib_iba7220.c         |  16 +-
 drivers/infiniband/hw/qib/qib_iba7322.c         |  14 +-
 drivers/infiniband/hw/qib/qib_intr.c            |  16 +-
 drivers/infiniband/hw/qib/qib_mad.c             |  10 +-
 drivers/infiniband/hw/qib/qib_pcie.c            |   2 +-
 drivers/infiniband/hw/qib/qib_qp.c              |  12 +-
 drivers/infiniband/hw/qib/qib_rc.c              |   5 +-
 drivers/infiniband/hw/qib/qib_twsi.c            |   1 +
 drivers/infiniband/hw/qib/qib_tx.c              |   1 +
 drivers/infiniband/hw/qib/qib_uc.c              |   1 +
 drivers/infiniband/hw/qib/qib_ud.c              |   1 +
 drivers/infiniband/hw/qib/qib_user_pages.c      |   2 +-
 drivers/infiniband/hw/qib/qib_verbs.c           |   6 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c  |   5 +-
 drivers/infiniband/sw/rdmavt/cq.c               |   2 +-
 drivers/infiniband/sw/rdmavt/mad.c              |   7 +-
 drivers/infiniband/sw/rdmavt/mcast.c            |   2 +-
 drivers/infiniband/sw/rdmavt/mr.c               |  21 +-
 drivers/infiniband/sw/rdmavt/qp.c               |  34 +-
 drivers/infiniband/sw/rdmavt/srq.c              |   7 +-
 drivers/infiniband/sw/rdmavt/vt.c               |   2 +-
 drivers/infiniband/sw/rxe/rxe_comp.c            |  49 +-
 drivers/infiniband/sw/rxe/rxe_hdr.h             | 178 +++---
 drivers/infiniband/sw/rxe/rxe_mcast.c           |  64 +-
 drivers/infiniband/sw/rxe/rxe_net.c             |  24 +-
 drivers/infiniband/sw/rxe/rxe_pool.c            | 300 +++++----
 drivers/infiniband/sw/rxe/rxe_pool.h            | 103 ++-
 drivers/infiniband/sw/rxe/rxe_qp.c              |  11 +
 drivers/infiniband/sw/rxe/rxe_recv.c            |  40 +-
 drivers/infiniband/sw/rxe/rxe_req.c             |   1 -
 drivers/infiniband/sw/rxe/rxe_resp.c            |   6 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c           |  68 +-
 drivers/infiniband/sw/siw/siw.h                 |   2 +-
 drivers/infiniband/sw/siw/siw_main.c            |   4 +-
 drivers/infiniband/sw/siw/siw_qp.c              | 271 ++++----
 drivers/infiniband/sw/siw/siw_qp_rx.c           |  26 +-
 drivers/infiniband/sw/siw/siw_qp_tx.c           |   4 +-
 drivers/infiniband/sw/siw/siw_verbs.c           |  20 +-
 drivers/infiniband/ulp/ipoib/ipoib.h            |   1 -
 drivers/infiniband/ulp/ipoib/ipoib_main.c       |   2 -
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c  |  15 +-
 drivers/infiniband/ulp/iser/iscsi_iser.c        |  53 +-
 drivers/infiniband/ulp/iser/iser_memory.c       |   3 +-
 drivers/infiniband/ulp/iser/iser_verbs.c        |   2 +-
 drivers/infiniband/ulp/isert/ib_isert.c         |  10 +-
 drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c |   2 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c    |  11 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt.c          | 127 ++--
 drivers/infiniband/ulp/rtrs/rtrs-clt.h          |   4 +-
 drivers/infiniband/ulp/rtrs/rtrs-pri.h          |   9 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c    |   9 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv.c          | 123 ++--
 drivers/infiniband/ulp/rtrs/rtrs.c              |  32 +-
 drivers/infiniband/ulp/srp/ib_srp.c             | 110 ++--
 drivers/net/ethernet/mellanox/mlx5/core/mr.c    |   1 +
 include/linux/mlx5/driver.h                     |  10 +-
 include/linux/mlx5/mlx5_ifc.h                   |   5 +-
 include/rdma/ib_sa.h                            |   4 -
 include/rdma/ib_umem.h                          |  48 +-
 include/rdma/ib_verbs.h                         |   9 +-
 include/rdma/rdma_counter.h                     |   3 +-
 include/uapi/rdma/ib_user_ioctl_cmds.h          |  14 +
 tools/testing/scatterlist/main.c                |   1 -
 150 files changed, 3580 insertions(+), 2667 deletions(-)
(diffstat from tag for-linus-merged)

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAmAzxsYACgkQOG33FX4g
mxoqZg/+LhoLXpJje3LZI/X00dpTYxsEJe5mjkMCG5M5tAks7yvTPSCOJbQpila2
yJlkA3TUc9G0DxFU5hRp5A5QGaIeO9d710OCWp3WJ3KVVuEzTckDw+7doRjbciq6
arVZxQAbDZMfYwINvAO99KEwHkyY3BYH0+8irQSQhZ+qELJV/ksiBFUn+8AuaF/z
q+eBcAQgze9Uw6e7/CClSJTm8TsOnLX2XzlWRgXt/NVuJR21F/wTU4eUow4Lqbr4
i8NC1USchCQQotV66ohWd8svkaqP7xNvCWeoURRRAsJlD8qWeIqT/YAhOqr1lrse
J4fThy0zf6B5iErHik9fi8GJQVRzOER8a2ohBNiNON/C3JfhGvJkaMh3BAsNrQSN
T0GmE9bvw/jGYf7einfhXmt/INXGkmriBimm7knTgDP3w8IR3jRM4hrMa154fQr+
2oefPFr61RDrDJLsZzjI+/xAkCfFhbuA8lA+t6yyVMR9Y5KDvzSI3SyQlYgtEkjt
rrqc+QOX58yamcurxZSLCVnj+dBrc2DCP8FggyLgrCse1OkKwz8Q27j3WwqRe+Xi
t5+QLHcPvmF2Opg5jJmQs1uyjllA0mq4hNXRT31gz0AK/6wL7rROWYPECndiiWnn
XJtgQhCRbsP4XGcLDPseSgwjFy7jvhlcBDZdUgo1w4+jdBZa8ZE=
=VLyc
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
