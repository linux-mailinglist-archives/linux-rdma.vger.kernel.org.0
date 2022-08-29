Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23AC25A4790
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Aug 2022 12:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiH2KvD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Aug 2022 06:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiH2KvC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Aug 2022 06:51:02 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6EC4454B
        for <linux-rdma@vger.kernel.org>; Mon, 29 Aug 2022 03:51:00 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MGRw94XY1zkWYY;
        Mon, 29 Aug 2022 18:47:21 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 29 Aug 2022 18:50:58 +0800
Received: from localhost.localdomain (10.67.165.2) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 29 Aug 2022 18:50:58 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH for-next 4/4] RDMA/hns: Remove redundant member doorbell_qpn of struct hns_roce_qp
Date:   Mon, 29 Aug 2022 18:50:21 +0800
Message-ID: <20220829105021.1427804-5-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20220829105021.1427804-1-liangwenpeng@huawei.com>
References: <20220829105021.1427804-1-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The value of doorbell_qpn is always equal to qpn on current hardware
versions. So remove it.

Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h | 1 -
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 2 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 3 ---
 3 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 22c5e9a564e0..80b3fe031f0f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -599,7 +599,6 @@ struct hns_roce_qp {
 	struct hns_roce_db	rdb;
 	struct hns_roce_db	sdb;
 	unsigned long		en_flags;
-	u32			doorbell_qpn;
 	enum ib_sig_type	sq_signal_bits;
 	struct hns_roce_wq	sq;
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 9b71ea8040c1..c257eb01adb6 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -637,7 +637,7 @@ static inline void update_sq_db(struct hns_roce_dev *hr_dev,
 	} else {
 		struct hns_roce_v2_db sq_db = {};
 
-		hr_reg_write(&sq_db, DB_TAG, qp->doorbell_qpn);
+		hr_reg_write(&sq_db, DB_TAG, qp->qpn);
 		hr_reg_write(&sq_db, DB_CMD, HNS_ROCE_V2_SQ_DB);
 		hr_reg_write(&sq_db, DB_PI, qp->sq.head);
 		hr_reg_write(&sq_db, DB_SL, qp->sl);
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 7bee7f6c5e70..3b35fb387566 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -218,7 +218,6 @@ static int alloc_qpn(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 
 	if (hr_qp->ibqp.qp_type == IB_QPT_GSI) {
 		num = 1;
-		hr_qp->doorbell_qpn = 1;
 	} else {
 		mutex_lock(&qp_table->bank_mutex);
 		bankid = get_least_load_bankid_for_qp(qp_table->bank);
@@ -234,8 +233,6 @@ static int alloc_qpn(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 
 		qp_table->bank[bankid].inuse++;
 		mutex_unlock(&qp_table->bank_mutex);
-
-		hr_qp->doorbell_qpn = (u32)num;
 	}
 
 	hr_qp->qpn = num;
-- 
2.30.0

