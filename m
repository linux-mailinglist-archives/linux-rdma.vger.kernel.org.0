Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8F617F36C
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2020 10:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgCJJZv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Mar 2020 05:25:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:56908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbgCJJZu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 10 Mar 2020 05:25:50 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80C612051A;
        Tue, 10 Mar 2020 09:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583832350;
        bh=PSPfwum5/x4dNcsftF0CHx3K9wHY9pRGc4cv27myCYc=;
        h=From:To:Cc:Subject:Date:From;
        b=1TSF8fsOWygZ83JJvs6lWxRcq2lcTdrNNpU3RwnzrXuXF0l0SHHWY0eLpwIhSvuLe
         9avHWLhDV7S9XZ1AHPoX4bCAIDiacRh7TKu67cR49sU6LTImXm/QJGy5AJ4yzbJm9c
         dun0j/dQIVGbcU9ueaI9DN6egBODRv4gYe8GaJU0=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        Haggai Eran <haggaie@mellanox.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-next 00/15] Fix locking around cm_id.state in the ib_cm
Date:   Tue, 10 Mar 2020 11:25:30 +0200
Message-Id: <20200310092545.251365-1-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

From Jason:

cm_id.state is a non-atomic value that must always be read and written
under lock, or while the thread has the only pointer to the cm_id.

Critically, during MAD handling the cm_id.state is used to control when
MAD handlers can run, and in turn what data they can touch. Without
locking, an assignment to state can immediately allow concurrent MAD
handlers to execute, potentially creating a mess.

Several of these cases only risk load/store tearing, but create very
confusing code. For instance changing the state from IB_CM_IDLE to
IB_CM_LISTEN doesn't allow any MAD handlers to run in either state, but a
superficial audit would suggest that it is not locked properly.

This loose methodology has allowed two bugs to creep in. After creating an
ID the code did not lock the state transition, apparently mistakenly
assuming that the new ID could not be used concurrently. However, the ID
is immediately placed in the xarray and so a carefully crafted network
sequence could trigger races with the unlocked stores.

The main solution to many of these problems is to use the xarray to create
a two stage add - the first reserves the ID and the second publishes the
pointer. The second stage is either omitted entirely or moved after the
newly created ID is setup.

Where it is trivial to do so other places directly put the state
manipulation under lock, or add an assertion that it is, in fact, under
lock.

This also removes a number of places where the state is being read under
lock, then the lock dropped, reacquired and state tested again.

There remain other issues related to missing locking on cm_id data.

Thanks

------------------------------------------------------------------------
It is based on rdma-next + rdma-rc patch c14dfddbd869
("RMDA/cm: Fix missing ib_cm_destroy_id() in ib_cm_insert_listen()")

Jason Gunthorpe (15):
  RDMA/cm: Fix ordering of xa_alloc_cyclic() in ib_create_cm_id()
  RDMA/cm: Fix checking for allowed duplicate listens
  RDMA/cm: Remove a race freeing timewait_info
  RDMA/cm: Make the destroy_id flow more robust
  RDMA/cm: Simplify establishing a listen cm_id
  RDMA/cm: Read id.state under lock when doing pr_debug()
  RDMA/cm: Make it clear that there is no concurrency in
    cm_sidr_req_handler()
  RDMA/cm: Make it clearer how concurrency works in cm_req_handler()
  RDMA/cm: Add missing locking around id.state in cm_dup_req_handler
  RDMA/cm: Add some lockdep assertions for cm_id_priv->lock
  RDMA/cm: Allow ib_send_cm_dreq() to be done under lock
  RDMA/cm: Allow ib_send_cm_drep() to be done under lock
  RDMA/cm: Allow ib_send_cm_rej() to be done under lock
  RDMA/cm: Allow ib_send_cm_sidr_rep() to be done under lock
  RDMA/cm: Make sure the cm_id is in the IB_CM_IDLE state in destroy

 drivers/infiniband/core/cm.c | 732 ++++++++++++++++++++---------------
 1 file changed, 420 insertions(+), 312 deletions(-)

--
2.24.1

