Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F29DB149AFF
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Jan 2020 15:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbgAZOPs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 26 Jan 2020 09:15:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:36258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727228AbgAZOPr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 26 Jan 2020 09:15:47 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A98B52071E;
        Sun, 26 Jan 2020 14:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580048147;
        bh=T2Ex1QdZFT01jD0Q6IZDRpNcgIZtWynLJ9HnvcbdRSI=;
        h=From:To:Cc:Subject:Date:From;
        b=Vv6yQEzBUCQBi1K2OEUPuhWJJQbIkOt+tq/FxmPj99M0jDOBklIuJU+1EXk6Ojo/4
         8Cey/t+K4B3fdmXYJc4BOtYWNeRbhTZDO/YR3dew62ylKCLH9418wBhium07QbY7/t
         j3RTv/Urs49JyTYDDyRIkmDCVFS6tT3GLVRm98ys=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-next v1] RDMA/ucma: Mask QPN to be 24 bits according to IBTA
Date:   Sun, 26 Jan 2020 16:15:42 +0200
Message-Id: <20200126141542.103655-1-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

IBTA declares QPN as 24bits, mask input to ensure that kernel
doesn't get higher bits and ensure by adding WANR_ONCE() that
other CM users do the same.

Fixes: 75216638572f ("RDMA/cma: Export rdma cm interface to userspace")
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 Changelog:
 v0: Rebase
---
 drivers/infiniband/core/cm.c   | 3 +++
 drivers/infiniband/core/ucma.c | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 68cc1b2d6824..33c0d9e7bb66 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -2188,6 +2188,9 @@ int ib_send_cm_rep(struct ib_cm_id *cm_id,
 	cm_id_priv->initiator_depth = param->initiator_depth;
 	cm_id_priv->responder_resources = param->responder_resources;
 	cm_id_priv->rq_psn = cpu_to_be32(IBA_GET(CM_REP_STARTING_PSN, rep_msg));
+	WARN_ONCE(param->qp_num & 0xFF000000,
+		  "IBTA declares QPN to be 24 bits, but it is 0x%X\n",
+		  param->qp_num);
 	cm_id_priv->local_qpn = cpu_to_be32(param->qp_num & 0xFFFFFF);

 out:	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index 0274e9b704be..57e68491a2fd 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -1045,7 +1045,7 @@ static void ucma_copy_conn_param(struct rdma_cm_id *id,
 	dst->retry_count = src->retry_count;
 	dst->rnr_retry_count = src->rnr_retry_count;
 	dst->srq = src->srq;
-	dst->qp_num = src->qp_num;
+	dst->qp_num = src->qp_num & 0xFFFFFF;
 	dst->qkey = (id->route.addr.src_addr.ss_family == AF_IB) ? src->qkey : 0;
 }

--
2.24.1

