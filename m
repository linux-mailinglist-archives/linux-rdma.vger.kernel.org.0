Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0B43171120
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2020 07:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgB0Gwe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Feb 2020 01:52:34 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10702 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726575AbgB0Gwe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 Feb 2020 01:52:34 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BC019EDEFA79C8F59EC9;
        Thu, 27 Feb 2020 14:52:30 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Thu, 27 Feb 2020 14:52:24 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Selvin Xavier <selvin.xavier@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     YueHaibing <yuehaibing@huawei.com>, <linux-rdma@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] RDMA/bnxt_re: Remove set but not used variable 'dev_attr'
Date:   Thu, 27 Feb 2020 06:45:42 +0000
Message-ID: <20200227064542.91205-1-yuehaibing@huawei.com>
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

drivers/infiniband/hw/bnxt_re/ib_verbs.c: In function 'bnxt_re_create_gsi_qp':
drivers/infiniband/hw/bnxt_re/ib_verbs.c:1283:30: warning:
 variable 'dev_attr' set but not used [-Wunused-but-set-variable]

commit 8dae419f9ec7 ("RDMA/bnxt_re: Refactor queue pair creation code")
involved this, but not used, so remove it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index ad3e524187e3..7e74efd15d6d 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1280,14 +1280,12 @@ static int bnxt_re_create_shadow_gsi(struct bnxt_re_qp *qp,
 static int bnxt_re_create_gsi_qp(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 				 struct ib_qp_init_attr *init_attr)
 {
-	struct bnxt_qplib_dev_attr *dev_attr;
 	struct bnxt_re_dev *rdev;
 	struct bnxt_qplib_qp *qplqp;
 	int rc = 0;
 
 	rdev = qp->rdev;
 	qplqp = &qp->qplib_qp;
-	dev_attr = &rdev->dev_attr;
 
 	qplqp->rq_hdr_buf_size = BNXT_QPLIB_MAX_QP1_RQ_HDR_SIZE_V2;
 	qplqp->sq_hdr_buf_size = BNXT_QPLIB_MAX_QP1_SQ_HDR_SIZE_V2;



