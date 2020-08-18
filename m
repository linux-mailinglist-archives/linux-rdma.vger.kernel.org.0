Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6667A24845C
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Aug 2020 14:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgHRMFc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Aug 2020 08:05:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:60884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbgHRMFb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Aug 2020 08:05:31 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75A76204EA;
        Tue, 18 Aug 2020 12:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597752331;
        bh=RG8k5N8jr2Ije4XNLGa5fF4PgNGEnTLxeO96UPPHtqI=;
        h=From:To:Cc:Subject:Date:From;
        b=Hf3BMha6+5e+xFzYO7irvAQfDRc/xg4HOtl3rV+y2sGbOEKl1d0oUWo7uJw5soDfn
         phn4Uh5Dh6iC/XwNdKxClKtMlWrZpwgLL8idZFSnOZTMvDSRcd20k1WXsL5QD9+o7H
         6/GR4YvrERrdhvZ/ZdDi7l10rg9LLYU2vpK2pdrk=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Roland Dreier <rolandd@cisco.com>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-next 00/14] Cleanup locking and events in ucma
Date:   Tue, 18 Aug 2020 15:05:12 +0300
Message-Id: <20200818120526.702120-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

From Jason:

Rework how the uevents for new connections are handled so all the locking
ends up simpler and a work queue can be removed. This should also speed up
destruction of ucma_context's as a flush_workqueue() was replaced with
cancel_work_sync().

The simpler locking comes from narrowing what file->mut covers and moving
other data to other locks, particularly by injecting the handler_mutex
from the RDMA CM core as a construct available to ULPs. The handler_mutex
directly prevents handlers from running without creating any ABBA locking
problems.

Fix various error cases and data races caused by missing locking.

Thanks

Jason Gunthorpe (14):
  RDMA/ucma: Fix refcount 0 incr in ucma_get_ctx()
  RDMA/ucma: Remove unnecessary locking of file->ctx_list in close
  RDMA/ucma: Consolidate the two destroy flows
  RDMA/ucma: Fix error cases around ucma_alloc_ctx()
  RDMA/ucma: Remove mc_list and rely on xarray
  RDMA/cma: Add missing locking to rdma_accept()
  RDMA/ucma: Do not use file->mut to lock destroying
  RDMA/ucma: Fix the locking of ctx->file
  RDMA/ucma: Fix locking for ctx->events_reported
  RDMA/ucma: Add missing locking around rdma_leave_multicast()
  RDMA/ucma: Change backlog into an atomic
  RDMA/ucma: Narrow file->mut in ucma_event_handler()
  RDMA/ucma: Rework how new connections are passed through event
    delivery
  RDMA/ucma: Remove closing and the close_wq

 drivers/infiniband/core/cma.c  |  25 +-
 drivers/infiniband/core/ucma.c | 444 +++++++++++++++------------------
 include/rdma/rdma_cm.h         |   5 +
 3 files changed, 226 insertions(+), 248 deletions(-)

--
2.26.2

