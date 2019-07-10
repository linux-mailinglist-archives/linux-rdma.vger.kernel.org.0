Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5BB76410D
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2019 08:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbfGJGR0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Jul 2019 02:17:26 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49588 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725791AbfGJGR0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 10 Jul 2019 02:17:26 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C894C474AF813C3E5B24;
        Wed, 10 Jul 2019 14:17:23 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Wed, 10 Jul 2019
 14:17:14 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <bmt@zurich.ibm.com>, <dledford@redhat.com>, <jgg@ziepe.ca>,
        <leon@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] RDMA/siw: remove unnecessary print in iw_create_tx_threads
Date:   Wed, 10 Jul 2019 14:15:32 +0800
Message-ID: <20190710061532.55068-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20190710043554.GA7034@mtr-leonro.mtl.com>
References: <20190710043554.GA7034@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In iw_create_tx_threads(), failure to create kthread
is basic failure, which affect performance only. The
whole kthread creation spam in this driver looked
suspicious during submission and it continues to be.
This patch remove the failed print to fix gcc warning:

drivers/infiniband/sw/siw/siw_main.c: In function 'siw_create_tx_threads':
drivers/infiniband/sw/siw/siw_main.c:91:11: warning:
 variable 'rv' set but not used [-Wunused-but-set-variable]

Reported-by: Hulk Robot <hulkci@huawei.com>
Suggested-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/infiniband/sw/siw/siw_main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
index fd2552a..f55c4e8 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -88,7 +88,7 @@ static void siw_device_cleanup(struct ib_device *base_dev)
 
 static int siw_create_tx_threads(void)
 {
-	int cpu, rv, assigned = 0;
+	int cpu, assigned = 0;
 
 	for_each_online_cpu(cpu) {
 		/* Skip HT cores */
@@ -99,9 +99,7 @@ static int siw_create_tx_threads(void)
 			kthread_create(siw_run_sq, (unsigned long *)(long)cpu,
 				       "siw_tx/%d", cpu);
 		if (IS_ERR(siw_tx_thread[cpu])) {
-			rv = PTR_ERR(siw_tx_thread[cpu]);
 			siw_tx_thread[cpu] = NULL;
-			pr_info("Creating TX thread for CPU %d failed", cpu);
 			continue;
 		}
 		kthread_bind(siw_tx_thread[cpu], cpu);
-- 
2.7.4


