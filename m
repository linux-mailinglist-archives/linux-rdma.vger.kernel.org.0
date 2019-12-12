Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 182B111C965
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2019 10:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbfLLJir (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Dec 2019 04:38:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:38548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728329AbfLLJir (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Dec 2019 04:38:47 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4642322527;
        Thu, 12 Dec 2019 09:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576143526;
        bh=KgjoelqVhEOaIDgNkKTIDlSDroSND8RxZdzw6cH0C4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YFuK5/UIWc8e6B5MtVUqL+9kquyZJRnFGm8ryg8m3VDR6haFBkj8G93iNnGG3oxu4
         m1JTNdDBHUgaCywXtBjDCKfrNWLBKf9lKVt4BJeltjHMqH4zPktTQVzXfK4SnidwsH
         lpNvGnUz2AhHNVwBzb45awO3d6YGzynpEMzlGCDg=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-rc v2 03/48] RDMA/ucma: Mask QPN to be 24 bits according to IBTA
Date:   Thu, 12 Dec 2019 11:37:45 +0200
Message-Id: <20191212093830.316934-4-leon@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191212093830.316934-1-leon@kernel.org>
References: <20191212093830.316934-1-leon@kernel.org>
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
 drivers/infiniband/core/cm.c   | 5 ++++-
 drivers/infiniband/core/ucma.c | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index c341a68b6f97..efa2d329da30 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -2102,7 +2102,10 @@ int ib_send_cm_rep(struct ib_cm_id *cm_id,
 	cm_id_priv->initiator_depth = param->initiator_depth;
 	cm_id_priv->responder_resources = param->responder_resources;
 	cm_id_priv->rq_psn = cm_rep_get_starting_psn(rep_msg);
-	cm_id_priv->local_qpn = cpu_to_be32(param->qp_num & 0xFFFFFF);
+	WARN_ONCE(param->qp_num & 0xFF000000,
+		  "IBTA declares QPN to be 24 bits, but it is 0x%X\n",
+		  param->qp_num);
+	cm_id_priv->local_qpn = cpu_to_be32(param->qp_num);
 
 out:	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
 	return ret;
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
2.20.1

