Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC47F273D23
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Sep 2020 10:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgIVIVL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Sep 2020 04:21:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:35822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726649AbgIVIVL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Sep 2020 04:21:11 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7BC9239E5;
        Tue, 22 Sep 2020 08:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600762870;
        bh=3QLL8aQkrAqPfbsgwUJzOk8p4FttaWYOcpkmauO5AVo=;
        h=From:To:Cc:Subject:Date:From;
        b=FAMpU/By/wVlV7ujhf4XG4KvG1UzMrLTCQ+uIFa9maMrItGB0dZpB5TqizJvf94EW
         UGWJYv2AjdOEbuHIea0yNSDonOLJKK78GZK3iKKScWnd+O5HrKgt2Vy0gc1ndfxS3p
         NxYJ80hHggxgrzdxKEpzBPzI7nbrbQN0zPK0221Y=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Yishai Hadas <yishaih@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH rdma-next v2 0/4] Improve ODP by using HMM API
Date:   Tue, 22 Sep 2020 11:21:00 +0300
Message-Id: <20200922082104.2148873-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Changelog:
v2:
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
 drivers/infiniband/core/umem_odp.c      | 285 ++++++++++--------------
 drivers/infiniband/hw/mlx5/mlx5_ib.h    |   5 +
 drivers/infiniband/hw/mlx5/mr.c         |  14 +-
 drivers/infiniband/hw/mlx5/odp.c        |  48 ++--
 include/rdma/ib_umem_odp.h              |  21 +-
 include/uapi/rdma/ib_user_ioctl_verbs.h |   1 +
 7 files changed, 173 insertions(+), 202 deletions(-)

--
2.26.2

