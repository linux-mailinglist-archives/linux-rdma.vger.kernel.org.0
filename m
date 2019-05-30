Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 942882FC46
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2019 15:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfE3NZt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 May 2019 09:25:49 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:35077 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726673AbfE3NZt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 May 2019 09:25:49 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 30 May 2019 16:25:33 +0300
Received: from r-vnc08.mtr.labs.mlnx (r-vnc08.mtr.labs.mlnx [10.208.0.121])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x4UDPVZh007883;
        Thu, 30 May 2019 16:25:33 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     leonro@mellanox.com, linux-rdma@vger.kernel.org, jgg@mellanox.com,
        dledford@redhat.com, sagi@grimberg.me, hch@lst.de,
        bvanassche@acm.org
Cc:     maxg@mellanox.com, israelr@mellanox.com, idanb@mellanox.com,
        oren@mellanox.com, vladimirk@mellanox.com, shlomin@mellanox.com
Subject: [PATCH 15/20] RDMA/core: Validate signature handover device cap
Date:   Thu, 30 May 2019 16:25:26 +0300
Message-Id: <1559222731-16715-16-git-send-email-maxg@mellanox.com>
X-Mailer: git-send-email 1.7.8.2
In-Reply-To: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Protect the case that a ULP tries to allocate a QP with signature
enabled flag while the LLD doesn't support this feature.

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/infiniband/core/verbs.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 936498c3f9cb..4e933ea70159 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1152,10 +1152,12 @@ struct ib_qp *ib_create_qp_user(struct ib_pd *pd,
 	struct ib_qp *qp;
 	int ret;
 
-	if (qp_init_attr->rwq_ind_tbl &&
-	    (qp_init_attr->recv_cq ||
-	    qp_init_attr->srq || qp_init_attr->cap.max_recv_wr ||
-	    qp_init_attr->cap.max_recv_sge))
+	if ((qp_init_attr->rwq_ind_tbl &&
+	     (qp_init_attr->recv_cq ||
+	      qp_init_attr->srq || qp_init_attr->cap.max_recv_wr ||
+	      qp_init_attr->cap.max_recv_sge)) ||
+	    ((qp_init_attr->create_flags & IB_QP_CREATE_SIGNATURE_EN) &&
+	     !(device->attrs.device_cap_flags & IB_DEVICE_SIGNATURE_HANDOVER)))
 		return ERR_PTR(-EINVAL);
 
 	/*
-- 
2.16.3

