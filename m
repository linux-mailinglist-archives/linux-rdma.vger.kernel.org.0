Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1430D70350
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2019 17:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfGVPOf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jul 2019 11:14:35 -0400
Received: from os.inf.tu-dresden.de ([141.76.48.99]:58220 "EHLO
        os.inf.tu-dresden.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727244AbfGVPOe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Jul 2019 11:14:34 -0400
Received: from [195.176.96.199] (helo=jupiter)
        by os.inf.tu-dresden.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92)
        id 1hpa1J-00089G-Jg; Mon, 22 Jul 2019 17:14:33 +0200
From:   Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
To:     Moni Shoua <monis@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
Subject: [PATCH 00/10] Refactor rxe driver to remove multiple race conditions
Date:   Mon, 22 Jul 2019 17:14:16 +0200
Message-Id: <20190722151426.5266-1-mplaneta@os.inf.tu-dresden.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patchset helps to get rid of following race condition situations:
                                             
  1. Tasklet functions were incrementing reference counting after entering
  running the tasklet.                       
  2. Getting a pointer to reference counted object (kref) was done without
  protecting kref_put with a lock.
  3. QP cleanup was sometimes scheduling cleanup for later execution in
  rxe_qp_do_cleaunpm, although this QP's memory could be freed immediately after
  returning from rxe_qp_cleanup.
  4. Non-atomic cleanup functions could be called in SoftIRQ context
  5. Manipulating with reference counter inside a critical section could have
  been done both inside and outside of SoftIRQ region. Such behavior may end up
  in a deadlock.

The easiest way to observe these problems is to compile the kernel with KASAN
and lockdep and abruptly stop an application using SoftRoCE during the
communication phase. For my system this often resulted in kernel crash of a
deadlock inside the kernel.

To fix the above mentioned problems, this patch does following things:

  1. Replace tasklets with workqueues
  2. Adds locks to kref_put
  3. Aquires reference counting in an appropriate place

As a shortcomming, the performance is slightly reduced, because instead of
trying to execute tasklet function directly the new version always puts it onto
the queue.

TBH, I'm not sure that I removed all of the problems, but the driver
deffinetely behaves much more stable now. I would be glad to get some
help with additional testing.

 drivers/infiniband/sw/rxe/rxe_comp.c        |  38 ++----
 drivers/infiniband/sw/rxe/rxe_cq.c          |  17 ++-
 drivers/infiniband/sw/rxe/rxe_hw_counters.c |   1 -
 drivers/infiniband/sw/rxe/rxe_hw_counters.h |   1 -
 drivers/infiniband/sw/rxe/rxe_loc.h         |   3 +-
 drivers/infiniband/sw/rxe/rxe_mcast.c       |  22 ++--
 drivers/infiniband/sw/rxe/rxe_mr.c          |  10 +-
 drivers/infiniband/sw/rxe/rxe_net.c         |  21 ++-
 drivers/infiniband/sw/rxe/rxe_pool.c        |  40 ++++--
 drivers/infiniband/sw/rxe/rxe_pool.h        |  16 ++-
 drivers/infiniband/sw/rxe/rxe_qp.c          | 130 +++++++++---------
 drivers/infiniband/sw/rxe/rxe_recv.c        |   8 +-
 drivers/infiniband/sw/rxe/rxe_req.c         |  17 +--
 drivers/infiniband/sw/rxe/rxe_resp.c        |  54 ++++----
 drivers/infiniband/sw/rxe/rxe_task.c        | 139 +++++++-------------
 drivers/infiniband/sw/rxe/rxe_task.h        |  40 ++----
 drivers/infiniband/sw/rxe/rxe_verbs.c       |  81 ++++++------
 drivers/infiniband/sw/rxe/rxe_verbs.h       |   8 +-
 18 files changed, 302 insertions(+), 344 deletions(-)

-- 
2.20.1

