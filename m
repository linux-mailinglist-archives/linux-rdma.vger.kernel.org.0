Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9019F64C246
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Dec 2022 03:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236975AbiLNCcD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Dec 2022 21:32:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236915AbiLNCcB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 13 Dec 2022 21:32:01 -0500
X-Greylist: delayed 500 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 13 Dec 2022 18:31:58 PST
Received: from out-89.mta0.migadu.com (out-89.mta0.migadu.com [91.218.175.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6191E3F7
        for <linux-rdma@vger.kernel.org>; Tue, 13 Dec 2022 18:31:58 -0800 (PST)
Message-ID: <7601dc11-f1b5-5488-727a-13b4016c8aa5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1670984614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oUymLFUZx2/BQLR14wsx1WE0PTysukwpvqOldTskhGo=;
        b=PzJbS12drN3oC7G03IQK2PWXJfboAiZJwjmtwsLiyBZYTgSPV4DplNbi0VVo3G2QPyaAeW
        RJj0RBJPUuXrX23EqtTEUHsYPQ0g4VufjvNobzUNrn/dXbjpbUoRGAtCOQQ5E7okwrwaLv
        dY/kumYfRJIjSg/Fk0U0XTfKXycPzHA=
Date:   Wed, 14 Dec 2022 10:23:29 +0800
MIME-Version: 1.0
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>
References: <Y5jpKmpwhTAf+r8B@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <Y5jpKmpwhTAf+r8B@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2022/12/14 5:05, Jason Gunthorpe 写道:
> Hi Linus,
> 
> This cycle saw a new driver called MANA get merged and more fixing to
> the other recently merged drivers. rxe continues to see a lot of
> interest and fixing. Lots more rxe patches already in the works for
> the next cycle.
> 
> Thanks,
> Jason
> 
> The following changes since commit 76dcd734eca23168cb008912c0f69ff408905235:
> 
>    Linux 6.1-rc8 (2022-12-04 14:48:12 -0800)
> 
> are available in the Git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
> 
> for you to fetch changes up to dbc94a0fb81771a38733c0e8f2ea8c4fa6934dc1:
> 
>    IB/IPoIB: Fix queue count inconsistency for PKEY child interfaces (2022-12-11 11:04:19 +0200)
> 
> ----------------------------------------------------------------
> v6.2 merge window  pull request
> 
> Usual size of updates, a new driver a most of the bulk focusing on rxe:
> 
> - Usual typos, style, and language updates
> 
> - Driver updates for mlx5, irdma, siw, rts, srp, hfi1, hns, erdma, mlx4, srp
> 
> - Lots of RXE updates
>    * Improve reply error handling for bad MR operations
>    * Code tidying
>    * Debug printing uses common loggers
>    * Remove half implemented RD related stuff
>    * Support IBA's recently defined Atomic Write and Flush operations
> 
> - erdma support for atomic operations
> 
> - New driver "mana" for Ethernet HW available in Azure VMs. This driver
>    only supports DPDK
> 
> ----------------------------------------------------------------
> Ajay Sharma (3):
>        net: mana: Set the DMA device max segment size
>        net: mana: Define and process GDMA response code GDMA_STATUS_MORE_ENTRIES
>        net: mana: Define data structures for protection domain and memory registration
> 
> Arumugam Kolappan (1):
>        RDMA/mlx5: Change debug log level for remote access error syndromes
> 
> Bernard Metzler (2):
>        RDMA/siw: Fix immediate work request flush to completion queue
>        RDMA/siw: Set defined status for work completion with undefined status
> 
> Bob Pearson (23):
>        RDMA/rxe: Remove redundant header files
>        RDMA/rxe: Remove init of task locks from rxe_qp.c
>        RDMA/rxe: Removed unused name from rxe_task struct
>        RDMA/rxe: Split rxe_run_task() into two subroutines
>        RDMA/rxe: Make rxe_do_task static
>        RDMA/rxe: Rename task->state_lock to task->lock
>        RDMA/rxe: Add ibdev_dbg macros for rxe
>        RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_comp.c
>        RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_cq.c
>        RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_mr.c
>        RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_mw.c
>        RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_net.c
>        RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_qp.c
>        RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_req.c
>        RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_resp.c
>        RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_srq.c
>        RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_verbs.c
>        RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_av.c
>        RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_task.c
>        RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe.c
>        RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_icrc.c
>        RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_mmap.c
>        RDMA/rxe: Fix incorrect responder length checking
> 
> Chao Leng (1):
>        RDMA/cma: Change RoCE packet life time from 18 to 16
> 
> Cheng Xu (7):
>        RDMA/erdma: Extend access right field of FRMR and REG MR to support atomic
>        RDMA/erdma: Report atomic capacity when hardware supports atomic feature
>        RDMA/erdma: Implement atomic operations support
>        RDMA/erdma: Fix a typo in annotation
>        RDMA/erdma: Add a workqueue for WRs reflushing
>        RDMA/erdma: Implement the lifecycle of reflushing work for each QP
>        RDMA/erdma: Notify the latest PI to FW for reflushing when necessary
> 
> Chengchang Tang (5):
>        RDMA/hns: Fix AH attr queried by query_qp
>        RDMA/hns: Fix PBL page MTR find
>        RDMA/hns: Fix page size cap from firmware
>        RDMA/hns: Fix error code of CMD
>        RDMA/hns: Fix XRC caps on HIP08
> 
> Colin Ian King (2):
>        RDMA/qib: Remove not-used variable n
>        RDMA/qib: Remove not-used variable freeze_cnt
> 
> Daisuke Matsuda (4):
>        RDMA/rxe: Make responder handle RDMA Read failures
>        RDMA/rxe: Handle remote errors in the midst of a Read reply sequence
>        RDMA/rxe: Implement packet length validation on responder
>        RDMA/rxe: Fix oops with zero length reads
> 
> Deming Wang (1):
>        IB/uverbs: fix the typo of optional
> 
> Dragos Tatulea (1):
>        IB/IPoIB: Fix queue count inconsistency for PKEY child interfaces
> 
> Guoqing Jiang (8):
>        RDMA/rtrs-srv: Refactor rtrs_srv_rdma_cm_handler
>        RDMA/rtrs-srv: Refactor the handling of failure case in map_cont_bufs
>        RDMA/rtrs-srv: Correct the checking of ib_map_mr_sg
>        RDMA/rtrs-clt: Correct the checking of ib_map_mr_sg
>        RDMA/rtrs-srv: Remove outdated comments from create_con
>        RDMA/rtrs: Clean up rtrs_rdma_dev_pd_ops
>        RDMA/rtrs-srv: Fix several issues in rtrs_srv_destroy_path_files
>        RDMA/rtrs-srv: Remove kobject_del from rtrs_srv_destroy_once_sysfs_root_folders
> 
> Jason Gunthorpe (4):
>        RDMA/rxe: Do not NULL deref on debugging failure path
>        RDMA: Add netdevice_tracker to ib_device_set_netdev()
>        Merge tag 'v6.1-rc8' into rdma.git for-next
>        RDMA: Add missed netdev_put() for the netdevice_tracker
> 
> Jiangshan Yi (1):
>        RDMA/opa_vnic: fix spelling typo in comment
> 
> Kees Cook (1):
>        IB/hfi1: Replace 1-element array with singleton
> 
> Leon Romanovsky (3):
>        RDMA/core: Fix order of nldev_exit call
>        Merge branch 'mana-shared-6.2' of https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma
>        RDMA/mana: Remove redefinition of basic u64 type
> 
> Leonid Ravich (1):
>        IB/mad: Don't call to function that might sleep while in atomic context
> 
> Li Zhijian (15):
>        RDMA/core: return -EOPNOSUPP for ODP unsupported device
>        RDMA/rxe: Remove unnecessary mr testing
>        RDMA/rxe: Make sure requested access is a subset of {mr,mw}->access
>        RDMA/rxe: Fix mr->map double free
>        RDMA/mlx5: no need to kfree NULL pointer
>        RDMA: Extend RDMA user ABI to support flush
>        RDMA: Extend RDMA kernel verbs ABI to support flush
>        RDMA/rxe: Extend rxe user ABI to support flush
>        RDMA/rxe: Allow registering persistent flag for pmem MR only
>        RDMA/rxe: Extend rxe packet format to support flush
>        RDMA/rxe: Implement RC RDMA FLUSH service in requester side
>        RDMA/rxe: Implement flush execution in responder side
>        RDMA/rxe: Implement flush completion
>        RDMA/cm: Make QP FLUSHABLE for supported device
>        RDMA/rxe: Enable RDMA FLUSH capability for rxe device
> 
> Long Li (9):
>        net: mana: Add support for auxiliary device
>        net: mana: Record the physical address for doorbell page region
>        net: mana: Handle vport sharing between devices
>        net: mana: Export Work Queue functions for use by RDMA driver
>        net: mana: Record port number in netdev
>        net: mana: Move header files to a common location
>        net: mana: Define max values for SGL entries
>        net: mana: Define data structures for allocating doorbell page from GDMA
>        RDMA/mana_ib: Add a driver for Microsoft Azure Network Adapter
> 
> Luoyouming (2):
>        RDMA/hns: Fix ext_sge num error when post send
>        RDMA/hns: Fix incorrect sge nums calculation
> 
> Mark Zhang (4):
>        RDMA/restrack: Release MR restrack when delete
>        RDMA/core: Make sure "ib_port" is valid when access sysfs node
>        RDMA/nldev: Return "-EAGAIN" if the cm_id isn't from expected port
>        RDMA/nldev: Fix failure to send large messages
> 
> Maurizio Lombardi (1):
>        IB/isert: use the ISCSI_LOGIN_CURRENT_STAGE macro
> 
> Max Gurtovoy (2):
>        IB/iser: add safety checks for state_mutex lock
>        IB/iser: open code iser_disconnected_handler
> 
> Mustafa Ismail (4):
>        RDMA/irdma: Fix inline for multiple SGE's
>        RDMA/irdma: Fix RQ completion opcode
>        RDMA/irdma: Do not request 2-level PBLEs for CQ alloc
>        RDMA/irdma: Initialize net_type before checking it
> 
> Or Har-Toov (1):
>        RDMA/nldev: Add NULL check to silence false warnings
> 
> Randy Dunlap (1):
>        RDMA: Disable IB HW for UML
> 
> Sergey Gorenko (1):
>        IB/iser: open code iser_conn_state_comp_exch
> 
> Shiraz Saleem (1):
>        RDMA/irdma: Report the correct link speed
> 
> Wang Yufen (2):
>        RDMA/hfi1: Fix error return code in parse_platform_config()
>        RDMA/srp: Fix error return code in srp_parse_options()
> 
> Xiao Yang (9):
>        RDMA/rxe: Remove the duplicate assignment of mr->map_shift
>        RDMA: Extend RDMA user ABI to support atomic write
>        RDMA: Extend RDMA kernel ABI to support atomic write
>        RDMA/rxe: Extend rxe user ABI to support atomic write
>        RDMA/rxe: Extend rxe packet format to support atomic write
>        RDMA/rxe: Make requester support atomic write on RC service
>        RDMA/rxe: Make responder support atomic write on RC service
>        RDMA/rxe: Implement atomic write completion
>        RDMA/rxe: Enable atomic write capability for rxe device
> 
> Xiongfeng Wang (1):
>        RDMA/hfi: Decrease PCI device reference count in error path
> 
> Yang Yang (1):
>        IB/hfi1: Switch to netif_napi_add()
> 
> Yixing Liu (1):
>        RDMA/hns: Fix the gid problem caused by free mr
> 
> Yuan Can (1):
>        RDMA/nldev: Add checks for nla_nest_start() in fill_stat_counter_qps()
> 
> Yunsheng Lin (1):
>        RDMA/rxe: cleanup some error handling in rxe_verbs.c
> 
> Zhang Xiaoxu (1):
>        RDMA/rxe: Fix NULL-ptr-deref in rxe_qp_do_cleanup() when socket create failed
> 
> Zhengchao Shao (1):
>        RDMA/hns: fix memory leak in hns_roce_alloc_mr()
> 
> Zhu Yanjun (2):
>        RDMA/rxe: Remove reliable datagram support
>        RDMA/mlx5: Remove not-used IB_FLOW_SPEC_IB define

I do not like this subject. I still like my old one.
With the old one, it suggests that IB_FLOW_SPEC is not supported in MLX5 
in subject line.

Thanks and Regards,
Zhu Yanjun

> 
> wangjianli (3):
>        RDMA/qib: fix repeated words in comments
>        RDMA/core: fix repeated words in comments
>        RDMA/qedr: fix repeated words in comments
> 
> yangx.jy@fujitsu.com (1):
>        RDMA/rxe: Remove the member 'type' of struct rxe_mr
> 
> ye xingchen (1):
>        RDMA/hfi1: use sysfs_emit() to instead of scnprintf()
> 
> zhang songyi (1):
>        RDMA/mlx4: Remove NULL check before dev_{put, hold}
> 
>   MAINTAINERS                                        |  10 +
>   drivers/infiniband/Kconfig                         |   3 +
>   drivers/infiniband/core/cache.c                    |   2 +-
>   drivers/infiniband/core/cm.c                       |  13 +-
>   drivers/infiniband/core/cma.c                      |   2 +-
>   drivers/infiniband/core/device.c                   |  10 +-
>   drivers/infiniband/core/mad.c                      |   5 -
>   drivers/infiniband/core/nldev.c                    |  50 +-
>   drivers/infiniband/core/restrack.c                 |   2 -
>   drivers/infiniband/core/sysfs.c                    |  17 +-
>   drivers/infiniband/core/uverbs_std_types_qp.c      |   2 +-
>   drivers/infiniband/hw/Makefile                     |   1 +
>   drivers/infiniband/hw/erdma/erdma.h                |   4 +-
>   drivers/infiniband/hw/erdma/erdma_cq.c             |   2 +
>   drivers/infiniband/hw/erdma/erdma_hw.h             |  37 +-
>   drivers/infiniband/hw/erdma/erdma_main.c           |  15 +-
>   drivers/infiniband/hw/erdma/erdma_qp.c             |  73 ++-
>   drivers/infiniband/hw/erdma/erdma_verbs.c          |  25 +-
>   drivers/infiniband/hw/erdma/erdma_verbs.h          |  19 +-
>   drivers/infiniband/hw/hfi1/affinity.c              |   2 +
>   drivers/infiniband/hw/hfi1/driver.c                |   2 +-
>   drivers/infiniband/hw/hfi1/firmware.c              |   6 +
>   drivers/infiniband/hw/hfi1/mad.c                   |  22 +-
>   drivers/infiniband/hw/hfi1/netdev_rx.c             |   2 +-
>   drivers/infiniband/hw/hns/hns_roce_device.h        |   3 +
>   drivers/infiniband/hw/hns/hns_roce_hw_v2.c         | 217 +++++++--
>   drivers/infiniband/hw/hns/hns_roce_hw_v2.h         |  13 +-
>   drivers/infiniband/hw/hns/hns_roce_main.c          |  18 +-
>   drivers/infiniband/hw/hns/hns_roce_mr.c            |   4 +-
>   drivers/infiniband/hw/hns/hns_roce_qp.c            | 107 ++++-
>   drivers/infiniband/hw/irdma/uk.c                   | 170 ++++---
>   drivers/infiniband/hw/irdma/user.h                 |  20 +-
>   drivers/infiniband/hw/irdma/utils.c                |   2 +
>   drivers/infiniband/hw/irdma/verbs.c                | 145 ++----
>   drivers/infiniband/hw/irdma/verbs.h                |  53 +++
>   drivers/infiniband/hw/mana/Kconfig                 |  10 +
>   drivers/infiniband/hw/mana/Makefile                |   4 +
>   drivers/infiniband/hw/mana/cq.c                    |  79 ++++
>   drivers/infiniband/hw/mana/device.c                | 117 +++++
>   drivers/infiniband/hw/mana/main.c                  | 521 +++++++++++++++++++++
>   drivers/infiniband/hw/mana/mana_ib.h               | 162 +++++++
>   drivers/infiniband/hw/mana/mr.c                    | 197 ++++++++
>   drivers/infiniband/hw/mana/qp.c                    | 506 ++++++++++++++++++++
>   drivers/infiniband/hw/mana/wq.c                    | 115 +++++
>   drivers/infiniband/hw/mlx4/main.c                  |  12 +-
>   drivers/infiniband/hw/mlx5/cq.c                    |  27 +-
>   drivers/infiniband/hw/mlx5/fs.c                    |   1 -
>   drivers/infiniband/hw/mlx5/mlx5_ib.h               |   4 +
>   drivers/infiniband/hw/mlx5/mr.c                    |   6 +-
>   drivers/infiniband/hw/qedr/main.c                  |   2 +-
>   drivers/infiniband/hw/qib/qib_iba6120.c            |   7 +-
>   drivers/infiniband/hw/qib/qib_tx.c                 |   5 +-
>   drivers/infiniband/hw/qib/qib_user_sdma.c          |   2 +-
>   drivers/infiniband/sw/rxe/rxe.c                    |   4 +-
>   drivers/infiniband/sw/rxe/rxe.h                    |  19 +
>   drivers/infiniband/sw/rxe/rxe_av.c                 |  43 +-
>   drivers/infiniband/sw/rxe/rxe_comp.c               |  47 +-
>   drivers/infiniband/sw/rxe/rxe_cq.c                 |   8 +-
>   drivers/infiniband/sw/rxe/rxe_hdr.h                |  48 +-
>   drivers/infiniband/sw/rxe/rxe_icrc.c               |   4 +-
>   drivers/infiniband/sw/rxe/rxe_loc.h                |   9 +-
>   drivers/infiniband/sw/rxe/rxe_mmap.c               |   6 +-
>   drivers/infiniband/sw/rxe/rxe_mr.c                 | 122 +++--
>   drivers/infiniband/sw/rxe/rxe_mw.c                 |  23 +-
>   drivers/infiniband/sw/rxe/rxe_net.c                |  42 +-
>   drivers/infiniband/sw/rxe/rxe_opcode.c             |  35 ++
>   drivers/infiniband/sw/rxe/rxe_opcode.h             |  17 +-
>   drivers/infiniband/sw/rxe/rxe_param.h              |   7 +
>   drivers/infiniband/sw/rxe/rxe_qp.c                 |  98 ++--
>   drivers/infiniband/sw/rxe/rxe_req.c                |  50 +-
>   drivers/infiniband/sw/rxe/rxe_resp.c               | 329 +++++++++++--
>   drivers/infiniband/sw/rxe/rxe_srq.c                |  20 +-
>   drivers/infiniband/sw/rxe/rxe_task.c               |  52 +-
>   drivers/infiniband/sw/rxe/rxe_task.h               |  19 +-
>   drivers/infiniband/sw/rxe/rxe_verbs.c              | 106 ++---
>   drivers/infiniband/sw/rxe/rxe_verbs.h              |   7 +-
>   drivers/infiniband/sw/siw/siw_cq.c                 |  24 +-
>   drivers/infiniband/sw/siw/siw_verbs.c              |  40 +-
>   drivers/infiniband/ulp/ipoib/ipoib_netlink.c       |   7 +
>   drivers/infiniband/ulp/iser/iser_verbs.c           |  67 ++-
>   drivers/infiniband/ulp/isert/ib_isert.c            |   5 +-
>   drivers/infiniband/ulp/rtrs/rtrs-clt.c             |   6 +-
>   drivers/infiniband/ulp/rtrs/rtrs-pri.h             |   3 -
>   drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c       |  13 +-
>   drivers/infiniband/ulp/rtrs/rtrs-srv.c             |  72 ++-
>   drivers/infiniband/ulp/rtrs/rtrs.c                 |  22 +-
>   drivers/infiniband/ulp/srp/ib_srp.c                |  96 +++-
>   drivers/net/ethernet/microsoft/Kconfig             |   1 +
>   drivers/net/ethernet/microsoft/mana/gdma_main.c    |  39 +-
>   drivers/net/ethernet/microsoft/mana/hw_channel.c   |   6 +-
>   drivers/net/ethernet/microsoft/mana/mana_bpf.c     |   2 +-
>   drivers/net/ethernet/microsoft/mana/mana_en.c      | 175 ++++++-
>   drivers/net/ethernet/microsoft/mana/mana_ethtool.c |   2 +-
>   drivers/net/ethernet/microsoft/mana/shm_channel.c  |   2 +-
>   .../ethernet/microsoft => include/net}/mana/gdma.h | 153 +++++-
>   .../microsoft => include/net}/mana/hw_channel.h    |   0
>   .../ethernet/microsoft => include/net}/mana/mana.h |  23 +-
>   include/net/mana/mana_auxiliary.h                  |  10 +
>   .../microsoft => include/net}/mana/shm_channel.h   |   0
>   include/rdma/ib_pack.h                             |   5 +
>   include/rdma/ib_verbs.h                            |  24 +-
>   include/rdma/opa_vnic.h                            |   2 +-
>   include/trace/events/ib_mad.h                      |  13 +-
>   include/uapi/rdma/hns-abi.h                        |  15 +
>   include/uapi/rdma/ib_user_ioctl_verbs.h            |   3 +
>   include/uapi/rdma/ib_user_verbs.h                  |  21 +
>   include/uapi/rdma/mana-abi.h                       |  66 +++
>   include/uapi/rdma/rdma_user_rxe.h                  |   8 +
>   108 files changed, 3973 insertions(+), 922 deletions(-)
>   create mode 100644 drivers/infiniband/hw/mana/Kconfig
>   create mode 100644 drivers/infiniband/hw/mana/Makefile
>   create mode 100644 drivers/infiniband/hw/mana/cq.c
>   create mode 100644 drivers/infiniband/hw/mana/device.c
>   create mode 100644 drivers/infiniband/hw/mana/main.c
>   create mode 100644 drivers/infiniband/hw/mana/mana_ib.h
>   create mode 100644 drivers/infiniband/hw/mana/mr.c
>   create mode 100644 drivers/infiniband/hw/mana/qp.c
>   create mode 100644 drivers/infiniband/hw/mana/wq.c
>   rename {drivers/net/ethernet/microsoft => include/net}/mana/gdma.h (82%)
>   rename {drivers/net/ethernet/microsoft => include/net}/mana/hw_channel.h (100%)
>   rename {drivers/net/ethernet/microsoft => include/net}/mana/mana.h (95%)
>   create mode 100644 include/net/mana/mana_auxiliary.h
>   rename {drivers/net/ethernet/microsoft => include/net}/mana/shm_channel.h (100%)
>   create mode 100644 include/uapi/rdma/mana-abi.h

