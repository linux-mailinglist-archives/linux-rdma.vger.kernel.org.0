Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 902BB10547
	for <lists+linux-rdma@lfdr.de>; Wed,  1 May 2019 07:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725535AbfEAFjx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 May 2019 01:39:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:41666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725298AbfEAFjx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 1 May 2019 01:39:53 -0400
Received: from localhost (unknown [77.138.135.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43E1221734;
        Wed,  1 May 2019 05:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556689192;
        bh=cYYwAEr5HpKn36L32ZTXzhrB9wxjv0Lzo0Lfd+PJ4GI=;
        h=From:To:Cc:Subject:Date:From;
        b=Km6puUPgXwFkbG75Ec3d16MVg5QPXja2aKeNKhWQ7uSojQksn1mUvC1tHM5qKFXdZ
         vFHlQHSIuDnCh93dlteI+oljbOzgjdCUrJ+bkxyZWbBCw3kHeTB33re7hXqBdYJKkh
         12W2LTInK3JSel+F89Ud+pLyrxqejga798+lVUQs=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Artemy Kovalyov <artemyko@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: [PATCH rdma-next] IB/core: Set qp->real_qp before it may be accessed
Date:   Wed,  1 May 2019 08:39:48 +0300
Message-Id: <20190501053948.8518-1-leon@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Artemy Kovalyov <artemyko@mellanox.com>

real_qp should be initialized before ib_destroy_qp() called.
ib_destroy_qp() may be called in error flow if ib_create_qp_security()
failed.

Signed-off-by: Artemy Kovalyov <artemyko@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/core_priv.h  | 1 +
 drivers/infiniband/core/uverbs_cmd.c | 1 -
 drivers/infiniband/core/verbs.c      | 1 -
 3 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
index d4dd360769cb..2764647056d8 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -304,6 +304,7 @@ static inline struct ib_qp *_ib_create_qp(struct ib_device *dev,
 	qp->device = dev;
 	qp->pd = pd;
 	qp->uobject = uobj;
+	qp->real_qp = qp;
 	/*
 	 * We don't track XRC QPs for now, because they don't have PD
 	 * and more importantly they are created internaly by driver,
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 04d08135b374..a24b81a10089 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -1416,7 +1416,6 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 		if (ret)
 			goto err_cb;
 
-		qp->real_qp	  = qp;
 		qp->pd		  = pd;
 		qp->send_cq	  = attr.send_cq;
 		qp->recv_cq	  = attr.recv_cq;
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 060d2f071ea7..83a320ad6912 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1172,7 +1172,6 @@ struct ib_qp *ib_create_qp_user(struct ib_pd *pd,
 	if (ret)
 		goto err;
 
-	qp->real_qp    = qp;
 	qp->qp_type    = qp_init_attr->qp_type;
 	qp->rwq_ind_tbl = qp_init_attr->rwq_ind_tbl;
 
-- 
2.20.1

