Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7DF22C63
	for <lists+linux-rdma@lfdr.de>; Mon, 20 May 2019 08:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730831AbfETGzU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 May 2019 02:55:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:39184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730826AbfETGzU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 May 2019 02:55:20 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E7692081C;
        Mon, 20 May 2019 06:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558335319;
        bh=Jc+FQ0Auh4cwoPM+IAZdPIqDDg3p/bM+fFdGHjJ8GLE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zic8w12TBsSpaBCxvWF9hvJI8ZeFSuCpq7kKVM8q95cIR+BCncoTrg9Y1wlL/9fmG
         +x9cPTagYuotK6IjyDYMERBjR4o8u/lHUEyjLOty4y0zpwhRaNvD7UgjV/mIibj4I5
         fwZoScNEwfhxsYNTUZfHHl6E3npjMpWfG1URNZoU=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Glenn Streiff <gstreiff@neteffect.com>,
        Steve Wise <swise@opengridcomputing.com>
Subject: [PATCH rdma-next 06/15] RDMA/i40iw: Remove useless NULL checks
Date:   Mon, 20 May 2019 09:54:24 +0300
Message-Id: <20190520065433.8734-7-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520065433.8734-1-leon@kernel.org>
References: <20190520065433.8734-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

There is no need to check existence of structures to be destroyed.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/i40iw/i40iw_verbs.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
index 5689d742bafb..a10a30d44b32 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -1070,11 +1070,6 @@ static int i40iw_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 	struct i40iw_device *iwdev;
 	struct i40iw_sc_cq *cq;
 
-	if (!ib_cq) {
-		i40iw_pr_err("ib_cq == NULL\n");
-		return 0;
-	}
-
 	iwcq = to_iwcq(ib_cq);
 	iwdev = to_iwdev(ib_cq->device);
 	cq = &iwcq->sc_cq;
@@ -2771,9 +2766,6 @@ void i40iw_port_ibevent(struct i40iw_device *iwdev)
  */
 void i40iw_destroy_rdma_device(struct i40iw_ib_device *iwibdev)
 {
-	if (!iwibdev)
-		return;
-
 	ib_unregister_device(&iwibdev->ibdev);
 	wait_event_timeout(iwibdev->iwdev->close_wq,
 			   !atomic64_read(&iwibdev->iwdev->use_count),
-- 
2.20.1

