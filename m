Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6413AE476
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jun 2021 10:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhFUIDd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Jun 2021 04:03:33 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:8284 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbhFUID3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Jun 2021 04:03:29 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4G7hfs6DKPz1BQ8q;
        Mon, 21 Jun 2021 15:56:05 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 21 Jun 2021 16:01:13 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 21 Jun 2021 16:01:12 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Weihang Li <liweihang@huawei.com>
Subject: [PATCH v5 for-next 1/9] RDMA/hns: Fix sparse warnings when calling hr_reg_write()
Date:   Mon, 21 Jun 2021 16:00:35 +0800
Message-ID: <1624262443-24528-2-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1624262443-24528-1-git-send-email-liweihang@huawei.com>
References: <1624262443-24528-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There is no need to use "!!" before "eq->eqe_size == HNS_ROCE_V3_EQE_SIZE",
or sparse will complain about "dubious: x & !y".

Fixes: 782832f25404 ("RDMA/hns: Simplify the function config_eqc()")
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index f67b175..de2af11 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -6264,8 +6264,7 @@ static int config_eqc(struct hns_roce_dev *hr_dev, struct hns_roce_eq *eq,
 	hr_reg_write(eqc, EQC_EQ_CONS_INDX, HNS_ROCE_EQ_INIT_CONS_IDX);
 	hr_reg_write(eqc, EQC_NEX_EQE_BA_L, eqe_ba[1] >> 12);
 	hr_reg_write(eqc, EQC_NEX_EQE_BA_H, eqe_ba[1] >> 44);
-	hr_reg_write(eqc, EQC_EQE_SIZE,
-		     !!(eq->eqe_size == HNS_ROCE_V3_EQE_SIZE));
+	hr_reg_write(eqc, EQC_EQE_SIZE, eq->eqe_size == HNS_ROCE_V3_EQE_SIZE);
 
 	return 0;
 }
-- 
2.7.4

