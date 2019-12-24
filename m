Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 775FA129F04
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Dec 2019 09:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbfLXIdF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Dec 2019 03:33:05 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7750 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726234AbfLXIdE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 24 Dec 2019 03:33:04 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9C1B937CE8D2EC64512E;
        Tue, 24 Dec 2019 16:33:01 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Tue, 24 Dec 2019
 16:32:52 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <bmt@zurich.ibm.com>, <dledford@redhat.com>, <jgg@ziepe.ca>,
        <linux-rdma@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH 3/5] IB/iser: use true,false for bool variable
Date:   Tue, 24 Dec 2019 16:40:10 +0800
Message-ID: <1577176812-2238-4-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1577176812-2238-1-git-send-email-zhengbin13@huawei.com>
References: <1577176812-2238-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes coccicheck warning:

drivers/infiniband/ulp/iser/iser_memory.c:530:2-21: WARNING: Assignment of 0/1 to bool variable
drivers/infiniband/ulp/iser/iser_verbs.c:1096:2-21: WARNING: Assignment of 0/1 to bool variable

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 drivers/infiniband/ulp/iser/iser_memory.c | 2 +-
 drivers/infiniband/ulp/iser/iser_verbs.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/iser/iser_memory.c b/drivers/infiniband/ulp/iser/iser_memory.c
index 0f74dc6..7a8f24d 100644
--- a/drivers/infiniband/ulp/iser/iser_memory.c
+++ b/drivers/infiniband/ulp/iser/iser_memory.c
@@ -527,7 +527,7 @@ int iser_reg_rdma_mem(struct iscsi_iser_task *task,
 		if (unlikely(err))
 			goto err_reg;

-		desc->sig_protected = 1;
+		desc->sig_protected = true;
 	}

 	return 0;
diff --git a/drivers/infiniband/ulp/iser/iser_verbs.c b/drivers/infiniband/ulp/iser/iser_verbs.c
index 1f4a37a..127887c 100644
--- a/drivers/infiniband/ulp/iser/iser_verbs.c
+++ b/drivers/infiniband/ulp/iser/iser_verbs.c
@@ -1093,7 +1093,7 @@ u8 iser_check_task_pi_status(struct iscsi_iser_task *iser_task,
 	int ret;

 	if (desc && desc->sig_protected) {
-		desc->sig_protected = 0;
+		desc->sig_protected = false;
 		ret = ib_check_mr_status(desc->rsc.sig_mr,
 					 IB_MR_CHECK_SIG_STATUS, &mr_status);
 		if (ret) {
--
2.7.4

