Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFEDC25A76B
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Sep 2020 10:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgIBIL2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Sep 2020 04:11:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:34006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgIBIL2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 2 Sep 2020 04:11:28 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA2BF2072A;
        Wed,  2 Sep 2020 08:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599034287;
        bh=/kbh7IvQHNBhwATreOI8CPiuQC2q08fvANf2M+lhQxw=;
        h=From:To:Cc:Subject:Date:From;
        b=cf6rR8SDpzuSHCX5L+kKdOEY94dO3oh9d2rIXfm+HWULp4L0pWw9WhAmJKQ6wQJE8
         zkuadQfl4aO1T8yMb/fz2v0WK4Sr1O+70ZTQU/S0N9hBZHfYHYPfbey++VEg4zXcwp
         XBOMvK4P0NRusNDTECU4aorLOitadPjWU/dHP4o0=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Eli Cohen <eli@dev.mellanox.co.il>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Roland Dreier <rolandd@cisco.com>
Subject: [PATCH rdma-next 0/8] Cleanup and fix the CMA state machine
Date:   Wed,  2 Sep 2020 11:11:14 +0300
Message-Id: <20200902081122.745412-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

From Jason:

The RDMA CMA continues to attract syzkaller bugs due to its somewhat loose
operation of its FSM. Audit and scrub the whole thing to follow modern
expectations.

Overall the design elements are broadly:

- The ULP entry points MUST NOT run in parallel with each other. The ULP
  is solely responsible for preventing this.

- If the ULP returns !0 from it's event callback it MUST guarentee that no
  other ULP threads are touching the cm_id or calling into any RDMA CM
  entry point.

- ULP entry points can sometimes run conurrently with handler callbacks,
  although it is tricky because there are many entry points that exist
  in the flow before the handler is registered.

- Some ULP entry points are called from the ULP event handler callback,
  under the handler_mutex. (however ucma never does this)

- state uses a weird double locking scheme, in most cases one should hold
  the handler_mutex. (It is somewhat unclear what exactly the spinlock is
  for)

- Reading the state without holding the spinlock should use READ_ONCE,
  even if the handler_mutex is held.

- There are certain states which are 'stable' under the handler_mutex,
  exit from that state requires also holding the handler_mutex. This
  explains why testing the test under only the handler_mutex makes sense.

Thanks

Jason Gunthorpe (8):
  RDMA/cma: Fix locking for the RDMA_CM_CONNECT state
  RDMA/cma: Make the locking for automatic state transition more clear
  RDMA/cma: Fix locking for the RDMA_CM_LISTEN state
  RDMA/cma: Remove cma_comp()
  RDMA/cma: Combine cma_ndev_work with cma_work
  RDMA/cma: Remove dead code for kernel rdmacm multicast
  RDMA/cma: Consolidate the destruction of a cma_multicast in one place
  RDMA/cma: Fix use after free race in roce multicast join

 drivers/infiniband/core/cma.c | 466 ++++++++++++++++------------------
 1 file changed, 218 insertions(+), 248 deletions(-)

--
2.26.2

