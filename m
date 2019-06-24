Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05C4850A1E
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2019 13:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbfFXLuy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Jun 2019 07:50:54 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42334 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728807AbfFXLux (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 24 Jun 2019 07:50:53 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A732B1A7926177317BA6;
        Mon, 24 Jun 2019 19:50:49 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Mon, 24 Jun 2019 19:50:41 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 2/8] RDMA/hns: Fixup qp release bug
Date:   Mon, 24 Jun 2019 19:47:46 +0800
Message-ID: <1561376872-111496-3-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1561376872-111496-1-git-send-email-oulijun@huawei.com>
References: <1561376872-111496-1-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: chenglang <chenglang@huawei.com>

Hip06 reserve 12 qps, Hip08 reserve 8 qps. When the QP is
released, the chip model is not judged, and the Hip08
cannot release the qpn 8~12

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Lijun Ou <oulijun@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c | 1 +
 drivers/infiniband/hw/hns/hns_roce_qp.c    | 8 ++------
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index 2c0bc25..5517f34 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -1558,6 +1558,7 @@ static int hns_roce_v1_profile(struct hns_roce_dev *hr_dev)
 	caps->reserved_mrws	= 1;
 	caps->reserved_uars	= 0;
 	caps->reserved_cqs	= 0;
+	caps->reserved_qps	= 12; /* 2 SQP per port, six ports total 12 */
 	caps->chunk_sz		= HNS_ROCE_V1_TABLE_CHUNK_SIZE;
 
 	for (i = 0; i < caps->num_ports; i++)
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 7e9db82..305be42 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -267,7 +267,7 @@ void hns_roce_release_range_qp(struct hns_roce_dev *hr_dev, int base_qpn,
 {
 	struct hns_roce_qp_table *qp_table = &hr_dev->qp_table;
 
-	if (base_qpn < SQP_NUM)
+	if (base_qpn < hr_dev->caps.reserved_qps)
 		return;
 
 	hns_roce_bitmap_free_range(&qp_table->bitmap, base_qpn, cnt, BITMAP_RR);
@@ -1239,11 +1239,7 @@ int hns_roce_init_qp_table(struct hns_roce_dev *hr_dev)
 	mutex_init(&qp_table->scc_mutex);
 	xa_init(&hr_dev->qp_table_xa);
 
-	/* In hw v1, a port include two SQP, six ports total 12 */
-	if (hr_dev->caps.max_sq_sg <= 2)
-		reserved_from_bot = SQP_NUM;
-	else
-		reserved_from_bot = hr_dev->caps.reserved_qps;
+	reserved_from_bot = hr_dev->caps.reserved_qps;
 
 	ret = hns_roce_bitmap_init(&qp_table->bitmap, hr_dev->caps.num_qps,
 				   hr_dev->caps.num_qps - 1, reserved_from_bot,
-- 
1.9.1

