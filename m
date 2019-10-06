Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D14C3CD1F6
	for <lists+linux-rdma@lfdr.de>; Sun,  6 Oct 2019 14:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfJFM4Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 6 Oct 2019 08:56:24 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:48697 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726275AbfJFM4Y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 6 Oct 2019 08:56:24 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 6 Oct 2019 14:56:21 +0200
Received: from r-vnc12.mtr.labs.mlnx (r-vnc12.mtr.labs.mlnx [10.208.0.12])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x96CuKfm001215;
        Sun, 6 Oct 2019 15:56:20 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     jgg@mellanox.com, linux-rdma@vger.kernel.org, dledford@redhat.com,
        leonro@mellanox.com, sagi@grimberg.me
Cc:     Max Gurtovoy <maxg@mellanox.com>
Subject: [PATCH 1/1] IB/iser: use iser_err instead of pr_err for logging
Date:   Sun,  6 Oct 2019 15:56:20 +0300
Message-Id: <1570366580-24097-1-git-send-email-maxg@mellanox.com>
X-Mailer: git-send-email 1.7.1
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Make sure all the debug prints in ib_iser module use the common driver
logger.

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/infiniband/ulp/iser/iser_verbs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/iser/iser_verbs.c b/drivers/infiniband/ulp/iser/iser_verbs.c
index 94b5011..2531449 100644
--- a/drivers/infiniband/ulp/iser/iser_verbs.c
+++ b/drivers/infiniband/ulp/iser/iser_verbs.c
@@ -1081,7 +1081,7 @@ u8 iser_check_task_pi_status(struct iscsi_iser_task *iser_task,
 		ret = ib_check_mr_status(desc->rsc.sig_mr,
 					 IB_MR_CHECK_SIG_STATUS, &mr_status);
 		if (ret) {
-			pr_err("ib_check_mr_status failed, ret %d\n", ret);
+			iser_err("ib_check_mr_status failed, ret %d\n", ret);
 			/* Not a lot we can do, return ambiguous guard error */
 			*sector = 0;
 			return 0x1;
@@ -1093,7 +1093,7 @@ u8 iser_check_task_pi_status(struct iscsi_iser_task *iser_task,
 			sector_div(sector_off, sector_size + 8);
 			*sector = scsi_get_lba(iser_task->sc) + sector_off;
 
-			pr_err("PI error found type %d at sector %llx "
+			iser_err("PI error found type %d at sector %llx "
 			       "expected %x vs actual %x\n",
 			       mr_status.sig_err.err_type,
 			       (unsigned long long)*sector,
-- 
1.8.3.1

