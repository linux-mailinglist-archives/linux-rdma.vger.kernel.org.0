Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90988268A44
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Sep 2020 13:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbgINLmp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Sep 2020 07:42:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:51214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbgINLlU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 14 Sep 2020 07:41:20 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CA7A21741;
        Mon, 14 Sep 2020 11:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600083595;
        bh=jfYDZi4DW4IOpzXJuohR3BO8aZlZ4pA6gWH4B3GTn5U=;
        h=From:To:Cc:Subject:Date:From;
        b=gSIGuE3g1O06P/z1/XCMSefnqo/QtiYAaTwMUxaMsxFeLqfLrWuN8cX+7XBkq+MnA
         UAuGJWZjNXdYDaAIPFR0Nejsp3uIM4JWWJR9/PJAWAz23xqDMeqJsZt9DZW9Ywi+1y
         MzNdtkdxKyykwrjiiazJGYU2em1l+FqYTiKU1XAo=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH rdma-next 0/4] Improve ODP by using HMM API
Date:   Mon, 14 Sep 2020 14:39:45 +0300
Message-Id: <20200914113949.346562-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

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
 drivers/infiniband/core/umem_odp.c      | 286 ++++++++++--------------
 drivers/infiniband/hw/mlx5/mlx5_ib.h    |   6 +
 drivers/infiniband/hw/mlx5/mr.c         |  14 +-
 drivers/infiniband/hw/mlx5/odp.c        |  50 +++--
 include/rdma/ib_umem_odp.h              |  21 +-
 include/uapi/rdma/ib_user_ioctl_verbs.h |   1 +
 7 files changed, 178 insertions(+), 201 deletions(-)

--
2.26.2

