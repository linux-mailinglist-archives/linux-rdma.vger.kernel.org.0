Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C1D707BD8
	for <lists+linux-rdma@lfdr.de>; Thu, 18 May 2023 10:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjERIWb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 May 2023 04:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjERIWa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 18 May 2023 04:22:30 -0400
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com [207.54.90.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B78A9C;
        Thu, 18 May 2023 01:22:28 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="117094685"
X-IronPort-AV: E=Sophos;i="5.99,284,1677510000"; 
   d="scan'208";a="117094685"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 17:22:17 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 80C46C68E6;
        Thu, 18 May 2023 17:22:14 +0900 (JST)
Received: from m3004.s.css.fujitsu.com (m3004.s.css.fujitsu.com [10.128.233.124])
        by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id CBDF5CF7D9;
        Thu, 18 May 2023 17:22:13 +0900 (JST)
Received: from localhost.localdomain (unknown [10.118.237.106])
        by m3004.s.css.fujitsu.com (Postfix) with ESMTP id 98757200B2AE;
        Thu, 18 May 2023 17:22:13 +0900 (JST)
From:   Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To:     linux-rdma@vger.kernel.org, leonro@nvidia.com, jgg@nvidia.com,
        zyjzyj2000@gmail.com
Cc:     linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
        yangx.jy@fujitsu.com, lizhijian@fujitsu.com, y-goto@fujitsu.com,
        Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH for-next v5 0/7] On-Demand Paging on SoftRoCE
Date:   Thu, 18 May 2023 17:21:45 +0900
Message-Id: <cover.1684397037.git.matsuda-daisuke@fujitsu.com>
X-Mailer: git-send-email 2.39.1
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

This patch series implements the On-Demand Paging feature on SoftRoCE(rxe)
driver, which has been available only in mlx5 driver[1] so far.

There have been an obstacle to this series, but it has been finally solved.
The commit 9b4b7c1f9f54 ("RDMA/rxe: Add workqueue support for rxe tasks")
replaced the triple tasklets with a workqueue, and now it is ready to
merge the ODP patches on top of it.

I omitted some contents like the motive behind this series from the cover-
letter. Please see the cover letter of v3 for more details[2].

[Overview]
When applications register a memory region(MR), RDMA drivers normally pin
pages in the MR so that physical addresses are never changed during RDMA
communication. This requires the MR to fit in physical memory and
inevitably leads to memory pressure. On the other hand, On-Demand Paging
(ODP) allows applications to register MRs without pinning pages. They are
paged-in when the driver requires and paged-out when the OS reclaims. As a
result, it is possible to register a large MR that does not fit in physical
memory without taking up so much physical memory.

[How does ODP work?]
"struct ib_umem_odp" is used to manage pages. It is created for each
ODP-enabled MR on its registration. This struct holds a pair of arrays
(dma_list/pfn_list) that serve as a driver page table. DMA addresses and
PFNs are stored in the driver page table. They are updated on page-in and
page-out, both of which use the common interfaces in the ib_uverbs layer.

Page-in can occur when requester, responder or completer access an MR in
order to process RDMA operations. If they find that the pages being
accessed are not present on physical memory or requisite permissions are
not set on the pages, they provoke page fault to make the pages present
with proper permissions and at the same time update the driver page table.
After confirming the presence of the pages, they execute memory access such
as read, write or atomic operations.

Page-out is triggered by page reclaim or filesystem events (e.g. metadata
update of a file that is being used as an MR). When creating an ODP-enabled
MR, the driver registers an MMU notifier callback. When the kernel issues a
page invalidation notification, the callback is provoked to unmap DMA
addresses and update the driver page table. After that, the kernel releases
the pages.

[Supported operations]
All traditional operations are supported on RC connection. The new Atomic
write[3] and RDMA Flush[4] operations are not included in this patchset. I
will post them later after this patchset is merged. On UD connection, Send,
Recv, and SRQ-Recv are supported.

[How to test ODP?]
There are only a few resources available for testing. pyverbs testcases in
rdma-core and perftest[5] are recommendable ones. Other than them, the
ibv_rc_pingpong command can also be used for testing. Note that you may
have to build perftest from upstream because older versions do not handle
ODP capabilities correctly.

The ODP tree is available from github:
https://github.com/daimatsuda/linux/tree/odp_v5

[Future work]
My next work is to enable the new Atomic write[3] and RDMA Flush[4]
operations with ODP. After that, I am going to implement the prefetch
feature. It allows applications to trigger page fault using
ibv_advise_mr(3) to optimize performance. Some existing software like
librpma[6] use this feature. Additionally, I think we can also add the
implicit ODP feature in the future.

[1] [RFC 00/20] On demand paging
https://www.spinics.net/lists/linux-rdma/msg18906.html

[2] [PATCH for-next v3 0/7] On-Demand Paging on SoftRoCE
https://lore.kernel.org/lkml/cover.1671772917.git.matsuda-daisuke@fujitsu.com/

[3] [PATCH v7 0/8] RDMA/rxe: Add atomic write operation
https://lore.kernel.org/linux-rdma/1669905432-14-1-git-send-email-yangx.jy@fujitsu.com/

[4] [for-next PATCH 00/10] RDMA/rxe: Add RDMA FLUSH operation
https://lore.kernel.org/lkml/20221206130201.30986-1-lizhijian@fujitsu.com/

[5] linux-rdma/perftest: Infiniband Verbs Performance Tests
https://github.com/linux-rdma/perftest

[6] librpma: Remote Persistent Memory Access Library
https://github.com/pmem/rpma

v4->v5:
 1) Rebased to 6.4.0-rc2+
 2) Changed to schedule all works on responder and completer to workqueue

v3->v4:
 1) Re-designed functions that access MRs to use the MR xarray.
 2) Rebased onto the latest jgg-for-next tree.

v2->v3:
 1) Removed a patch that changes the common ib_uverbs layer.
 2) Re-implemented patches for conversion to workqueue.
 3) Fixed compile errors (happened when CONFIG_INFINIBAND_ON_DEMAND_PAGING=n).
 4) Fixed some functions that returned incorrect errors.
 5) Temporarily disabled ODP for RDMA Flush and Atomic Write.

v1->v2:
 1) Fixed a crash issue reported by Haris Iqbal.
 2) Tried to make lock patters clearer as pointed out by Romanovsky.
 3) Minor clean ups and fixes.

Daisuke Matsuda (7):
  RDMA/rxe: Always defer tasks on responder and completer to workqueue
  RDMA/rxe: Make MR functions accessible from other rxe source code
  RDMA/rxe: Move resp_states definition to rxe_verbs.h
  RDMA/rxe: Add page invalidation support
  RDMA/rxe: Allow registering MRs for On-Demand Paging
  RDMA/rxe: Add support for Send/Recv/Write/Read with ODP
  RDMA/rxe: Add support for the traditional Atomic operations with ODP

 drivers/infiniband/sw/rxe/Makefile          |   2 +
 drivers/infiniband/sw/rxe/rxe.c             |  18 ++
 drivers/infiniband/sw/rxe/rxe.h             |  37 ---
 drivers/infiniband/sw/rxe/rxe_comp.c        |  12 +-
 drivers/infiniband/sw/rxe/rxe_hw_counters.c |   1 -
 drivers/infiniband/sw/rxe/rxe_hw_counters.h |   1 -
 drivers/infiniband/sw/rxe/rxe_loc.h         |  45 +++
 drivers/infiniband/sw/rxe/rxe_mr.c          |  27 +-
 drivers/infiniband/sw/rxe/rxe_odp.c         | 311 ++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_resp.c        |  31 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c       |   5 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h       |  39 +++
 12 files changed, 447 insertions(+), 82 deletions(-)
 create mode 100644 drivers/infiniband/sw/rxe/rxe_odp.c

base-commit: a7dae5daf4bf50de01ebdd192bf52c2e8cd80c75

-- 
2.39.1

