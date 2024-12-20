Return-Path: <linux-rdma+bounces-6678-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFA89F8FE1
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Dec 2024 11:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BDC17A1958
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Dec 2024 10:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EBC1B6CF3;
	Fri, 20 Dec 2024 10:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="ns9O69cM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FA01AAA1F;
	Fri, 20 Dec 2024 10:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734689411; cv=none; b=conj+oZzRIkDLQLCRMb10FUcfxExuU1O9hZlFFXT9fZKHlVZMlU6pxRWKjneAqoS5zH6pxxoBxY4YAdP+C9tU2WMxqruZX3m4cpDXv3XeGWJ0IRcTq34yUnJ1BBDCIFcRMcH8+oc1hu5yyekip3BVcbmbHfLqiWN9J29/PJxXbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734689411; c=relaxed/simple;
	bh=N+/eh0wL7A//QGHSRi1WclOleSajQNuW+yz5odY2uVA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bL2L1ngxtWSSoS4P0brq0lcQo7jRF5LVZiyElP3En89LybLKz9sn9I3zWpiBPGsM8WyHYXMKXCgGEXFyafVZQqxalgRjMo/yOubz2K4EMlvTO1jUzHuu86MNjdHkDN7TndRQ2y35+z24uU9mL/k8uSYLpkzjFKbmotn3S4OFGA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=ns9O69cM; arc=none smtp.client-ip=68.232.139.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1734689410; x=1766225410;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=N+/eh0wL7A//QGHSRi1WclOleSajQNuW+yz5odY2uVA=;
  b=ns9O69cMt0nODtaynSFMJyxXdAOIY3gX2xM0quKG6abdlgdgWCGrPSIL
   VRktHUL/gAVjedpUslx2E0dofBoWo41fSkp3zBdcAHPST8Fg9gIv2KINE
   0urLTu/ctZEvbNlRRNxJHk2ordGhqgVin0VMqQnEGCM/Zfq6mxNZrvVVA
   qC7gopDSRGJ8VcTlJIHiUxTbOFFu/M6aB0NNyOWPZYwvCDc20SWI7iVhR
   AaLkHSnfLdIgupsjilUadoewuqHzCpOafoQGyfroe7UU7CjsyU/FGK6pb
   IdrwgnSB5ClyLRSOOUKHQpD6C5Vyx3UkQmftwz3fh6HcvkZx1bTqytvk+
   A==;
X-CSE-ConnectionGUID: 5CZBR5ysQr+LjFcfsQeYUg==
X-CSE-MsgGUID: J6+QgIPcQSGdy8mLtptNww==
X-IronPort-AV: E=McAfee;i="6700,10204,11291"; a="184642815"
X-IronPort-AV: E=Sophos;i="6.12,250,1728918000"; 
   d="scan'208";a="184642815"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 19:10:00 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
	by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id CC6C8E428A;
	Fri, 20 Dec 2024 19:09:58 +0900 (JST)
Received: from m3003.s.css.fujitsu.com (sqmail-3003.b.css.fujitsu.com [10.128.233.114])
	by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id A0ABBD5117;
	Fri, 20 Dec 2024 19:09:58 +0900 (JST)
Received: from sm-x86-stp01.ssoft.mng.com (unknown [10.124.178.20])
	by m3003.s.css.fujitsu.com (Postfix) with ESMTP id 6D065200597B;
	Fri, 20 Dec 2024 19:09:58 +0900 (JST)
From: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To: linux-rdma@vger.kernel.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	zyjzyj2000@gmail.com
Cc: linux-kernel@vger.kernel.org,
	rpearsonhpe@gmail.com,
	lizhijian@fujitsu.com,
	Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH for-next v9 0/5] On-Demand Paging on SoftRoCE
Date: Fri, 20 Dec 2024 19:09:31 +0900
Message-Id: <20241220100936.2193541-1-matsuda-daisuke@fujitsu.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series implements the On-Demand Paging feature on SoftRoCE(rxe)
driver, which has been available only in mlx5 driver[1] so far.

This series has been blocked because of the hang issue of srp 002 test[2],
which was believed to be caused after applying the commit 9b4b7c1f9f54
("RDMA/rxe: Add workqueue support for rxe tasks"). My patches are dependent
on the commit because the ODP feature requires sleeping in kernel space,
and it is impossible with the former tasklet implementation.

According to the original reporter[3], the hang issue is already gone in
v6.10. Additionally, tasklet is marked deprecated[4]. I think the rxe
driver is ready to accept this series since there is no longer any reason
to consider reverting back to the old tasklet.

I omitted some contents like the motive behind this series from the cover-
letter. Please see the cover letter of v3 for more details[5].

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
write[6] and RDMA Flush[7] operations are not included in this patchset. I
will post them later after this patchset is merged. On UD connection, Send,
Recv, and SRQ-Recv are supported.

[How to test ODP?]
There are only a few resources available for testing. pyverbs testcases in
rdma-core and perftest[8] are recommendable ones. Other than them, the
ibv_rc_pingpong command can also be used for testing. Note that you may
have to build perftest from upstream because old versions do not handle ODP
capabilities correctly.

The latest ODP tree is available from github:
https://github.com/ddmatsu/linux/tree/odp_v9

[Future work]
My next work is to enable the new Atomic write[6] and RDMA Flush[7]
operations with ODP. After that, I am going to implement the prefetch
feature. It allows applications to trigger page fault using
ibv_advise_mr(3) to optimize performance. Some existing software like
librpma[9] use this feature. Additionally, I think we can also add the
implicit ODP feature in the future.

[1] Understanding On Demand Paging (ODP)
https://enterprise-support.nvidia.com/s/article/understanding-on-demand-paging--odp-x

[2] [bug report] blktests srp/002 hang
https://lore.kernel.org/linux-rdma/dsg6rd66tyiei32zaxs6ddv5ebefr5vtxjwz6d2ewqrcwisogl@ge7jzan7dg5u/T/

[3] blktests failures with v6.10-rc1 kernel
https://lore.kernel.org/linux-block/wnucs5oboi4flje5yvtea7puvn6zzztcnlrfz3lpzlwgblrxgw@7wvqdzioejgl/

[4] [00/15] ethernet: Convert from tasklet to BH workqueue
https://patchwork.kernel.org/project/linux-rdma/cover/20240621050525.3720069-1-allen.lkml@gmail.com/

[5] [PATCH for-next v3 0/7] On-Demand Paging on SoftRoCE
https://lore.kernel.org/lkml/cover.1671772917.git.matsuda-daisuke@fujitsu.com/

[6] [PATCH v7 0/8] RDMA/rxe: Add atomic write operation
https://lore.kernel.org/linux-rdma/1669905432-14-1-git-send-email-yangx.jy@fujitsu.com/

[7] [for-next PATCH 00/10] RDMA/rxe: Add RDMA FLUSH operation
https://lore.kernel.org/lkml/20221206130201.30986-1-lizhijian@fujitsu.com/

[8] linux-rdma/perftest: Infiniband Verbs Performance Tests
https://github.com/linux-rdma/perftest

[9] librpma: Remote Persistent Memory Access Library
https://github.com/pmem/rpma

v8->v9:
 1) Addressed comments from Jason Gunthorpe
 cf. https://lore.kernel.org/lkml/20241209192152.GC2368570@nvidia.com/
 cf. https://lore.kernel.org/lkml/20241209193102.GD2368570@nvidia.com/
 2) rebased to 6.13.0-rc1

v7->v8:
 1) Dropped the first patch because the same change was made by Bob Pearson.
 cf. https://github.com/torvalds/linux/commit/23bc06af547f2ca3b7d345e09fd8d04575406274
 2) Rebased to 6.12.1-rc2

v6->v7:
 1) Rebased to 6.6.0
 2) Disabled using hugepages with ODP
 3) Addressed comments on v6 from Jason and Zhu
   cf. https://lore.kernel.org/lkml/cover.1694153251.git.matsuda-daisuke@fujitsu.com/

v5->v6:
 Fixed the implementation according to Jason's suggestions
   cf. https://lore.kernel.org/all/ZIdFXfDu4IMKE+BQ@nvidia.com/
   cf. https://lore.kernel.org/all/ZIdGU709e1h5h4JJ@nvidia.com/

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

Daisuke Matsuda (5):
  RDMA/rxe: Move some code to rxe_loc.h in preparation for ODP
  RDMA/rxe: Add page invalidation support
  RDMA/rxe: Allow registering MRs for On-Demand Paging
  RDMA/rxe: Add support for Send/Recv/Write/Read with ODP
  RDMA/rxe: Add support for the traditional Atomic operations with ODP

 drivers/infiniband/sw/rxe/Makefile    |   2 +
 drivers/infiniband/sw/rxe/rxe.c       |  18 ++
 drivers/infiniband/sw/rxe/rxe.h       |  37 ---
 drivers/infiniband/sw/rxe/rxe_loc.h   |  34 +++
 drivers/infiniband/sw/rxe/rxe_mr.c    |  13 +-
 drivers/infiniband/sw/rxe/rxe_odp.c   | 324 ++++++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_resp.c  |  18 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c |   5 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h |  37 +++
 9 files changed, 443 insertions(+), 45 deletions(-)
 create mode 100644 drivers/infiniband/sw/rxe/rxe_odp.c

-- 
2.43.0


