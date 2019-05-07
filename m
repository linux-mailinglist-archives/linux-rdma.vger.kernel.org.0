Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90606164C6
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2019 15:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfEGNjA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 May 2019 09:39:00 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:40499 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726795AbfEGNjA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 May 2019 09:39:00 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 7 May 2019 16:38:42 +0300
Received: from r-vnc08.mtr.labs.mlnx (r-vnc08.mtr.labs.mlnx [10.208.0.121])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x47DcdFI021865;
        Tue, 7 May 2019 16:38:41 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     leonro@mellanox.com, linux-rdma@vger.kernel.org, sagi@grimberg.me,
        jgg@mellanox.com, dledford@redhat.com, hch@lst.de,
        bvanassche@acm.org
Cc:     israelr@mellanox.com, idanb@mellanox.com, oren@mellanox.com,
        vladimirk@mellanox.com, shlomin@mellanox.com, maxg@mellanox.com
Subject: [PATCH 18/25] RDMA/core: Validate signature handover device cap
Date:   Tue,  7 May 2019 16:38:32 +0300
Message-Id: <1557236319-9986-19-git-send-email-maxg@mellanox.com>
X-Mailer: git-send-email 1.7.8.2
In-Reply-To: <1557236319-9986-1-git-send-email-maxg@mellanox.com>
References: <1557236319-9986-1-git-send-email-maxg@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Protect the case that a ULP tries to allocate a QP with signature
enabled flag while the LLD doesn't support this feature.

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/infiniband/core/verbs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 7397a20db000..e1dcbcc58e3e 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1142,10 +1142,12 @@ struct ib_qp *ib_create_qp(struct ib_pd *pd,
 	struct ib_qp *qp;
 	int ret;
 
-	if (qp_init_attr->rwq_ind_tbl &&
+	if ((qp_init_attr->rwq_ind_tbl &&
 	    (qp_init_attr->recv_cq ||
 	    qp_init_attr->srq || qp_init_attr->cap.max_recv_wr ||
-	    qp_init_attr->cap.max_recv_sge))
+	    qp_init_attr->cap.max_recv_sge)) ||
+	    ((qp_init_attr->create_flags & IB_QP_CREATE_SIGNATURE_EN) &&
+	     !(device->attrs.device_cap_flags & IB_DEVICE_SIGNATURE_HANDOVER)))
 		return ERR_PTR(-EINVAL);
 
 	/*
-- 
2.16.3

