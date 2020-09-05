Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 350FE25E77B
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Sep 2020 14:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbgIEMQn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 5 Sep 2020 08:16:43 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10775 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726597AbgIEMQn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 5 Sep 2020 08:16:43 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 60A29CC98773454FEC5E;
        Sat,  5 Sep 2020 20:16:41 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Sat, 5 Sep 2020
 20:16:32 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <selvin.xavier@broadcom.com>, <devesh.sharma@broadcom.com>,
        <somnath.kotur@broadcom.com>, <sriharsha.basavapatna@broadcom.com>,
        <nareshkumar.pbs@broadcom.com>, <dledford@redhat.com>,
        <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] RDMA/bnxt_re: Remove set but not used variable 'qplib_ctx'
Date:   Sat, 5 Sep 2020 20:16:24 +0800
Message-ID: <20200905121624.32776-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

drivers/infiniband/hw/bnxt_re/main.c:1012:25:
 warning: variable ‘qplib_ctx’ set but not used [-Wunused-but-set-variable]

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/infiniband/hw/bnxt_re/main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 13bbeb42794f..53aee5a42ab8 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1009,7 +1009,6 @@ static void bnxt_re_free_res(struct bnxt_re_dev *rdev)
 static int bnxt_re_alloc_res(struct bnxt_re_dev *rdev)
 {
 	struct bnxt_re_ring_attr rattr = {};
-	struct bnxt_qplib_ctx *qplib_ctx;
 	int num_vec_created = 0;
 	int rc = 0, i;
 	u8 type;
@@ -1032,7 +1031,6 @@ static int bnxt_re_alloc_res(struct bnxt_re_dev *rdev)
 	if (rc)
 		goto dealloc_res;
 
-	qplib_ctx = &rdev->qplib_ctx;
 	for (i = 0; i < rdev->num_msix - 1; i++) {
 		struct bnxt_qplib_nq *nq;
 
-- 
2.17.1


