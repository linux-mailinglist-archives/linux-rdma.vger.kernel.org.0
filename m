Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 866C4164C9
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2019 15:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfEGNjC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 May 2019 09:39:02 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:40525 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726808AbfEGNjB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 May 2019 09:39:01 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 7 May 2019 16:38:42 +0300
Received: from r-vnc08.mtr.labs.mlnx (r-vnc08.mtr.labs.mlnx [10.208.0.121])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x47DcdFK021865;
        Tue, 7 May 2019 16:38:42 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     leonro@mellanox.com, linux-rdma@vger.kernel.org, sagi@grimberg.me,
        jgg@mellanox.com, dledford@redhat.com, hch@lst.de,
        bvanassche@acm.org
Cc:     israelr@mellanox.com, idanb@mellanox.com, oren@mellanox.com,
        vladimirk@mellanox.com, shlomin@mellanox.com, maxg@mellanox.com
Subject: [PATCH 20/25] RDMA/rw: Print the correct number of sig MRs
Date:   Tue,  7 May 2019 16:38:34 +0300
Message-Id: <1557236319-9986-21-git-send-email-maxg@mellanox.com>
X-Mailer: git-send-email 1.7.8.2
In-Reply-To: <1557236319-9986-1-git-send-email-maxg@mellanox.com>
References: <1557236319-9986-1-git-send-email-maxg@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Israel Rukshin <israelr@mellanox.com>

A wrong value was printed in case of sig MR pool initialization failure.

Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/infiniband/core/rw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/rw.c b/drivers/infiniband/core/rw.c
index d08a4b015903..941a74282ed8 100644
--- a/drivers/infiniband/core/rw.c
+++ b/drivers/infiniband/core/rw.c
@@ -731,7 +731,7 @@ int rdma_rw_init_mrs(struct ib_qp *qp, struct ib_qp_init_attr *attr)
 				IB_MR_TYPE_SIGNATURE, 2, 0);
 		if (ret) {
 			pr_err("%s: failed to allocated %d SIG MRs\n",
-				__func__, nr_mrs);
+				__func__, nr_sig_mrs);
 			goto out_free_rdma_mrs;
 		}
 	}
-- 
2.16.3

