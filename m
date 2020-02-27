Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4A1171124
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2020 07:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgB0Gz4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Feb 2020 01:55:56 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11115 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726575AbgB0Gzz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 Feb 2020 01:55:55 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 70B1A8CB637F1FBEB6AB;
        Thu, 27 Feb 2020 14:55:52 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Thu, 27 Feb 2020 14:55:42 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Selvin Xavier <selvin.xavier@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     YueHaibing <yuehaibing@huawei.com>, <linux-rdma@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] RDMA/bnxt_re: Remove set but not used variables 'pg' and 'idx'
Date:   Thu, 27 Feb 2020 06:49:00 +0000
Message-ID: <20200227064900.92255-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/infiniband/hw/bnxt_re/qplib_rcfw.c: In function '__send_message':
drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:101:10: warning:
 variable 'idx' set but not used [-Wunused-but-set-variable]
drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:101:6: warning:
 variable 'pg' set but not used [-Wunused-but-set-variable]

commit cee0c7bba486 ("RDMA/bnxt_re: Refactor command queue management code")
involved this, but not used.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index b0b050e5cd12..f01e864bb611 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -98,7 +98,6 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw, struct cmdq_base *req,
 	unsigned long flags;
 	u32 size, opcode;
 	u16 cookie, cbit;
-	int pg, idx;
 	u8 *preq;
 
 	pdev = rcfw->pdev;
@@ -167,9 +166,6 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw, struct cmdq_base *req,
 	hwq_ptr = (struct bnxt_qplib_cmdqe **)hwq->pbl_ptr;
 	preq = (u8 *)req;
 	do {
-		pg = 0;
-		idx = 0;
-
 		/* Locate the next cmdq slot */
 		sw_prod = HWQ_CMP(hwq->prod, hwq);
 		cmdqe = &hwq_ptr[get_cmdq_pg(sw_prod, cmdq_depth)]



