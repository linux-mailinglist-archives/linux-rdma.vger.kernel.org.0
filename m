Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95033377674
	for <lists+linux-rdma@lfdr.de>; Sun,  9 May 2021 13:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhEILka (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 9 May 2021 07:40:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:56168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229563AbhEILk3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 9 May 2021 07:40:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F8686128C;
        Sun,  9 May 2021 11:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620560366;
        bh=CW6/79/uay0ryKqIqGv5DyheSLCb88VpnKqt/nCWuPc=;
        h=From:To:Cc:Subject:Date:From;
        b=BWFMLbFgKi+yQmIaC4D1W6GELACpCf4PZf9vVtSotOt5CEMNvRoiJadcbQy2iW0e0
         P0gGfIiaFO20NJok26LvNk6gc50rvQ9D9rziqAE9VWFO0XsxfuaRCEsZQIbrzrzVQd
         UdwFQ7ZdsE491T0YhYBw7T9vFcxuwN1/PhG5peQqVSFBi8XsqHPx2bTUfUksLyD9/N
         sHamkFnX7D6o+1XMIF2XPXDmC+53jgC1qIHeowVn1V8ZGXsSAOqGF9AvAWGl6rDxIE
         GdH/yrAr248azBJEwTXW8v5+Zr2cNMSsyzA7m40vwM0S6CwSBd3fenfDXnkbo5w4TU
         oDPNoXBQKmLLQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-rc] RDMA/siw: Properly check send and receive CQ pointers
Date:   Sun,  9 May 2021 14:39:21 +0300
Message-Id: <a7535a82925f6f4c1f062abaa294f3ae6e54bdd2.1620560310.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

The check for the NULL of pointer received from container_of is
incorrect by definition as it points to some random memory.

Change such check with proper NULL check of SIW QP attributes.

Fixes: 303ae1cdfdf7 ("rdma/siw: application interface")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/sw/siw/siw_verbs.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index d2313efb26db..917c8a919f38 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -300,7 +300,6 @@ struct ib_qp *siw_create_qp(struct ib_pd *pd,
 	struct siw_ucontext *uctx =
 		rdma_udata_to_drv_context(udata, struct siw_ucontext,
 					  base_ucontext);
-	struct siw_cq *scq = NULL, *rcq = NULL;
 	unsigned long flags;
 	int num_sqe, num_rqe, rv = 0;
 	size_t length;
@@ -343,10 +342,8 @@ struct ib_qp *siw_create_qp(struct ib_pd *pd,
 		rv = -EINVAL;
 		goto err_out;
 	}
-	scq = to_siw_cq(attrs->send_cq);
-	rcq = to_siw_cq(attrs->recv_cq);
 
-	if (!scq || (!rcq && !attrs->srq)) {
+	if (!attrs->send_cq || (!attrs->recv_cq && !attrs->srq)) {
 		siw_dbg(base_dev, "send CQ or receive CQ invalid\n");
 		rv = -EINVAL;
 		goto err_out;
@@ -401,8 +398,8 @@ struct ib_qp *siw_create_qp(struct ib_pd *pd,
 		}
 	}
 	qp->pd = pd;
-	qp->scq = scq;
-	qp->rcq = rcq;
+	qp->scq = to_siw_cq(attrs->send_cq);
+	qp->rcq = to_siw_cq(attrs->recv_cq);
 
 	if (attrs->srq) {
 		/*
-- 
2.31.1

