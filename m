Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1E617111C
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2020 07:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgB0GtF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Feb 2020 01:49:05 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:50762 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726575AbgB0GtE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 Feb 2020 01:49:04 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 98224C915E07E5706AD8;
        Thu, 27 Feb 2020 14:48:59 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Thu, 27 Feb 2020 14:48:51 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Selvin Xavier <selvin.xavier@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     YueHaibing <yuehaibing@huawei.com>, <linux-rdma@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] RDMA/bnxt_re: Remove set but not used variable 'pg_size'
Date:   Thu, 27 Feb 2020 06:42:09 +0000
Message-ID: <20200227064209.87893-1-yuehaibing@huawei.com>
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

drivers/infiniband/hw/bnxt_re/qplib_res.c: In function '__alloc_pbl':
drivers/infiniband/hw/bnxt_re/qplib_res.c:109:13: warning:
 variable 'pg_size' set but not used [-Wunused-but-set-variable]

commit 0c4dcd602817 ("RDMA/bnxt_re: Refactor hardware queue memory allocation")
involved this, but not used, so remove it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_res.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband/hw/bnxt_re/qplib_res.c
index fc5909c7f2e0..cab1adf1fed9 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
@@ -106,13 +106,12 @@ static int __alloc_pbl(struct bnxt_qplib_res *res,
 	struct pci_dev *pdev = res->pdev;
 	struct scatterlist *sghead;
 	bool is_umem = false;
-	u32 pages, pg_size;
+	u32 pages;
 	int i;
 
 	if (sginfo->nopte)
 		return 0;
 	pages = sginfo->npages;
-	pg_size = sginfo->pgsize;
 	sghead = sginfo->sghead;
 	/* page ptr arrays */
 	pbl->pg_arr = vmalloc(pages * sizeof(void *));



