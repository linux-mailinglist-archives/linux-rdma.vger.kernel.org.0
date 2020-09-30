Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C1F27EF60
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Sep 2020 18:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731249AbgI3Qii (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Sep 2020 12:38:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:38940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbgI3Qig (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 30 Sep 2020 12:38:36 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFB822072E;
        Wed, 30 Sep 2020 16:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601483914;
        bh=uYWnH3fAfUYgMfQ7r5kPERHuMO6ncg6kVqpzW2WgEwY=;
        h=From:To:Cc:Subject:Date:From;
        b=V7WF7Z7c4xxG12tn6pgHrtNdTxpBim/7VRdXyXqCbEmLwurg1W56OpMxyWj3Eahps
         8iszYo060dsI7E9FOuaBAZzmfc8PEIBG9o+sguzEZdPvMYqFDJVtvlpAYe3A7tMCkF
         KfM2USUJSPDtpyTWtIQ0BCq0iQaYSu6FrqijIpkg=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org,
        Yishai Hadas <yishaih@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH rdma-next v3 0/4] Improve ODP by using HMM API
Date:   Wed, 30 Sep 2020 19:38:24 +0300
Message-Id: <20200930163828.1336747-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Changelog:
v3:
 * Improve control flow in ib_umem_odp_map_dma_single_page() to be clearer and safer.
 * Replace pr_debug() by ibdev_dbg()
v2: https://lore.kernel.org/lkml/20200922082104.2148873-1-leon@kernel.org
 * Patch #1 – Drop redundant mask.
 * Patch #4 – Use address and length directly from umem_odp.
v1: https://lore.kernel.org/lkml/20200917112152.1075974-1-leon@kernel.org
 * Cleaned code.
 * Support a potential valid dma_address of NULL by flags detection,
   note was added to clarify things as was asked.
 * Fix 80 character lines in few places.
v0: https://lore.kernel.org/lkml/20200914113949.346562-1-leon@kernel.org

Based on:
https://lore.kernel.org/lkml/20200914112653.345244-1-leon@kernel.org/

---------------------------------------------------------------------------------------
From Yishai:

This series improves ODP performance by moving to use the HMM API as of below.

The get_user_pages_remote() functionality was replaced by HMM:
- No need anymore to allocate and free memory to hold its output per call.
- No need anymore to use the put_page() to unpin the pages.
- The logic to detect contiguous pages is done based on the returned order
  from HMM, no need to run per page, and evaluate.

Moving to use the HMM enables to reduce page faults in the system by using the
snapshot mode. This mode allows existing pages in the CPU to become presented
to the device without faulting.

This non-faulting mode may be used explicitly by an application with some new
option of advice MR (i.e. PREFETCH_NO_FAULT) and is used upon ODP MR
registration internally as part of initiating the device page table.

To achieve the above, internal changes in the ODP data structures were done
and some flows were cleaned-up/adapted accordingly.

Thanks

Yishai Hadas (4):
  IB/core: Improve ODP to use hmm_range_fault()
  IB/core: Enable ODP sync without faulting
  RDMA/mlx5: Extend advice MR to support non faulting mode
  RDMA/mlx5: Sync device with CPU pages upon ODP MR registration

 drivers/infiniband/Kconfig              |   1 +
 drivers/infiniband/core/umem_odp.c      | 293 ++++++++++--------------
 drivers/infiniband/hw/mlx5/mlx5_ib.h    |   5 +
 drivers/infiniband/hw/mlx5/mr.c         |  14 +-
 drivers/infiniband/hw/mlx5/odp.c        |  48 ++--
 include/rdma/ib_umem_odp.h              |  21 +-
 include/uapi/rdma/ib_user_ioctl_verbs.h |   1 +
 7 files changed, 182 insertions(+), 201 deletions(-)

--
2.26.2

