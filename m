Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2175AFA14
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Sep 2022 04:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiIGCoN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Sep 2022 22:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiIGCoM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Sep 2022 22:44:12 -0400
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB4898A6F
        for <linux-rdma@vger.kernel.org>; Tue,  6 Sep 2022 19:44:10 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="75355808"
X-IronPort-AV: E=Sophos;i="5.93,295,1654527600"; 
   d="scan'208";a="75355808"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP; 07 Sep 2022 11:44:07 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
        by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 82812D4326;
        Wed,  7 Sep 2022 11:44:06 +0900 (JST)
Received: from m3002.s.css.fujitsu.com (msm3.b.css.fujitsu.com [10.128.233.104])
        by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id B1B79A4E91;
        Wed,  7 Sep 2022 11:44:05 +0900 (JST)
Received: from localhost.localdomain (unknown [10.19.3.107])
        by m3002.s.css.fujitsu.com (Postfix) with ESMTP id 6A386200B3AC;
        Wed,  7 Sep 2022 11:44:05 +0900 (JST)
From:   Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To:     linux-rdma@vger.kernel.org, leonro@nvidia.com, jgg@nvidia.com,
        zyjzyj2000@gmail.com
Cc:     nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
        rpearsonhpe@gmail.com, yangx.jy@fujitsu.com, lizhijian@fujitsu.com,
        y-goto@fujitsu.com, Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [RFC PATCH 0/7] RDMA/rxe: On-Demand Paging on SoftRoCE
Date:   Wed,  7 Sep 2022 11:42:58 +0900
Message-Id: <cover.1662461897.git.matsuda-daisuke@fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi everyone,

This patch series implements the On-Demand Paging feature on SoftRoCE(rxe)
driver, which has been available only in mlx5 driver[1] so far.

[Overview]
When applications register a memory region(MR), RDMA drivers normally pin
pages in the MR so that physical addresses are never changed during RDMA
communication. This requires the MR to fit in physical memory and
inevitably leads to memory pressure. On the other hand, On-Demand Paging
(ODP) allows applications to register MRs without pinning pages. They are
paged-in when the driver requires and paged-out when the OS reclaims. As a
result, it is possible to register a large MR that does not fit in physical
memory without taking up so much physical memory.

[Why to add this feature?]
We, Fujitsu, have contributed to RDMA with a view to using it with
persistent memory. Persistent memory can host a filesystem that allows
applications to read/write files directly without involving page cache.
This is called FS-DAX(filesystem direct access) mode. There is a problem
that data on DAX-enabled filesystem cannot be duplicated with software RAID
or other hardware methods. Data replication with RDMA, which features
high-speed connections, is the best solution for the problem.

However, there is a known issue that hinders using RDMA with FS-DAX. When
RDMA operations to a file and update of the file metadata are processed
concurrently on the same node, illegal memory accesses can be executed,
disregarding the updated metadata. This is because RDMA operations do not
go through page cache but access data directly. There was an effort[2] to
solve this problem, but it was rejected in the end. Though there is no
general solution available, it is possible to work around the problem using
the ODP feature that has been available only in mlx5. ODP enables drivers
to update metadata before processing RDMA operations.

We have enhanced the rxe to expedite the usage of persistent memory. Our
contribution to rxe includes RDMA Atomic write[3] and RDMA Flush[4]. With
them being merged to rxe along with ODP, an environment will be ready for
developers to create and test software for RDMA with FS-DAX. There is a
library(librpma)[5] being developed for this purpose. This environment
can be used by anybody without any special hardware but an ordinary
computer with a normal NIC though it is inferior to hardware
implementations in terms of performance.

[Design considerations]
ODP has been available only in mlx5, but functions and data structures
that can be used commonly are provided in ib_uverbs(infiniband/core). The
interface is heavily dependent on HMM infrastructure[6], and this patchset
use them as much as possible. While mlx5 has both Explicit and Implicit ODP
features along with prefetch feature, this patchset implements the Explicit
ODP feature only.

As an important change, it is necessary to convert triple tasklets
(requester, responder and completer) to workqueues because they must be
able to sleep in order to trigger page fault before accessing MRs. I did a
test shown in the 2nd patch and found that the change makes the latency
higher while improving the bandwidth. Though it may be possible to create a
new independent workqueue for page fault execution, it is a not very
sensible solution since the tasklets have to busy-wait its completion in
that case.

If responder and completer sleep, it becomes more likely that packet drop
occurs because of overflow in receiver queue. There are multiple queues
involved, but, as SoftRoCE uses UDP, the most important one would be the
UDP buffers. The size can be configured in net.core.rmem_default and
net.core.rmem_max sysconfig parameters. Users should change these values in
case of packet drop, but page fault would be typically not so long as to
cause the problem.

[How does ODP work?]
"struct ib_umem_odp" is used to manage pages. It is created for each
ODP-enabled MR on its registration. This struct holds a pair of arrays
(dma_list/pfn_list) that serve as a driver page table. DMA addresses and
PFNs are stored in the driver page table. They are updated on page-in and
page-out, both of which use the common interface in ib_uverbs.

Page-in can occur when requester, responder or completer access an MR in
order to process RDMA operations. If they find that the pages being
accessed are not present on physical memory or requisite permissions are
not set on the pages, they provoke page fault to make pages present with
proper permissions and at the same time update the driver page table. After
confirming the presence of the pages, they execute memory access such as
read, write or atomic operations.

Page-out is triggered by page reclaim or filesystem events (e.g. metadata
update of a file that is being used as an MR). When creating an ODP-enabled
MR, the driver registers an MMU notifier callback. When the kernel issues a
page invalidation notification, the callback is provoked to unmap DMA
addresses and update the driver page table. After that, the kernel releases
the pages.

[Supported operations]
All operations are supported on RC connection. Atomic write[3] and Flush[4]
operations, which are still under discussion, are also going to be
supported after their patches are merged. On UD connection, Send, Recv,
SRQ-Recv are supported. Because other operations are not supported on mlx5,
I take after the decision right now.

[How to test ODP?]
There are only a few resources available for testing. pyverbs testcases in
rdma-core and perftest[7] are recommendable ones. Note that you may have to
build perftest from upstream since older versions do not handle ODP
capabilities correctly.

[Future work]
My next work will be the prefetch feature. It allows applications to
trigger page fault using ibv_advise_mr(3) to optimize performance. Some
existing software like librpma use this feature. Additionally, I think we
can also add the implicit ODP feature in the future.

[1] [RFC 00/20] On demand paging
https://www.spinics.net/lists/linux-rdma/msg18906.html

[2] [RFC PATCH v2 00/19] RDMA/FS DAX truncate proposal V1,000,002 ;-)
https://lore.kernel.org/nvdimm/20190809225833.6657-1-ira.weiny@intel.com/

[3] [RESEND PATCH v5 0/2] RDMA/rxe: Add RDMA Atomic Write operation
https://www.spinics.net/lists/linux-rdma/msg111428.html

[4] [PATCH v4 0/6] RDMA/rxe: Add RDMA FLUSH operation
https://www.spinics.net/lists/kernel/msg4462045.html

[5] librpma: Remote Persistent Memory Access Library
https://github.com/pmem/rpma

[6] Heterogeneous Memory Management (HMM)
https://www.kernel.org/doc/html/latest/mm/hmm.html

[7] linux-rdma/perftest: Infiniband Verbs Performance Tests
https://github.com/linux-rdma/perftest

Daisuke Matsuda (7):
  IB/mlx5: Change ib_umem_odp_map_dma_single_page() to retain umem_mutex
  RDMA/rxe: Convert the triple tasklets to workqueues
  RDMA/rxe: Cleanup code for responder Atomic operations
  RDMA/rxe: Add page invalidation support
  RDMA/rxe: Allow registering MRs for On-Demand Paging
  RDMA/rxe: Add support for Send/Recv/Write/Read operations with ODP
  RDMA/rxe: Add support for the traditional Atomic operations with ODP

 drivers/infiniband/core/umem_odp.c    |   6 +-
 drivers/infiniband/hw/mlx5/odp.c      |   4 +-
 drivers/infiniband/sw/rxe/Makefile    |   5 +-
 drivers/infiniband/sw/rxe/rxe.c       |  18 ++
 drivers/infiniband/sw/rxe/rxe_comp.c  |  42 +++-
 drivers/infiniband/sw/rxe/rxe_loc.h   |  11 +-
 drivers/infiniband/sw/rxe/rxe_mr.c    |   7 +-
 drivers/infiniband/sw/rxe/rxe_net.c   |   4 +-
 drivers/infiniband/sw/rxe/rxe_odp.c   | 329 ++++++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_param.h |   2 +-
 drivers/infiniband/sw/rxe/rxe_qp.c    |  68 +++---
 drivers/infiniband/sw/rxe/rxe_recv.c  |   2 +-
 drivers/infiniband/sw/rxe/rxe_req.c   |  14 +-
 drivers/infiniband/sw/rxe/rxe_resp.c  | 175 +++++++-------
 drivers/infiniband/sw/rxe/rxe_resp.h  |  44 ++++
 drivers/infiniband/sw/rxe/rxe_task.c  | 152 ------------
 drivers/infiniband/sw/rxe/rxe_task.h  |  69 ------
 drivers/infiniband/sw/rxe/rxe_verbs.c |  16 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h |  10 +-
 drivers/infiniband/sw/rxe/rxe_wq.c    | 161 +++++++++++++
 drivers/infiniband/sw/rxe/rxe_wq.h    |  71 ++++++
 21 files changed, 824 insertions(+), 386 deletions(-)
 create mode 100644 drivers/infiniband/sw/rxe/rxe_odp.c
 create mode 100644 drivers/infiniband/sw/rxe/rxe_resp.h
 delete mode 100644 drivers/infiniband/sw/rxe/rxe_task.c
 delete mode 100644 drivers/infiniband/sw/rxe/rxe_task.h
 create mode 100644 drivers/infiniband/sw/rxe/rxe_wq.c
 create mode 100644 drivers/infiniband/sw/rxe/rxe_wq.h

-- 
2.31.1

