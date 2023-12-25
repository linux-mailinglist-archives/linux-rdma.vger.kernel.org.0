Return-Path: <linux-rdma+bounces-488-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1B981DEF1
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Dec 2023 08:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 695132819E3
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Dec 2023 07:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE2A15BB;
	Mon, 25 Dec 2023 07:58:35 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFA3DF54;
	Mon, 25 Dec 2023 07:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Sz9Gx5T0Fz1R5ns;
	Mon, 25 Dec 2023 15:57:13 +0800 (CST)
Received: from kwepemi500006.china.huawei.com (unknown [7.221.188.68])
	by mail.maildlp.com (Postfix) with ESMTPS id EBD981A019C;
	Mon, 25 Dec 2023 15:58:16 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Dec 2023 15:57:17 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-next 5/6] RDMA/hns: Support adaptive PBL hopnum
Date: Mon, 25 Dec 2023 15:53:29 +0800
Message-ID: <20231225075330.4116470-6-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20231225075330.4116470-1-huangjunxian6@hisilicon.com>
References: <20231225075330.4116470-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500006.china.huawei.com (7.221.188.68)

From: Chengchang Tang <tangchengchang@huawei.com>

In the current implementation, a fixed addressing level is used for
PBL. But in fact, the necessary addressing level is related to page
size and the size of MR.

This patch calculates the addressing level according to page size
and the size of MR, and uses the addressing level to configure the
PBL.

Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_mr.c | 57 +++++++++++++++++++++++--
 1 file changed, 54 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index d3a8b342c38c..2a8e02dd6884 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -112,10 +112,13 @@ static int alloc_mr_pbl(struct hns_roce_dev *hr_dev, struct hns_roce_mr *mr,
 	err = hns_roce_mtr_create(hr_dev, &mr->pbl_mtr, &buf_attr,
 				  hr_dev->caps.pbl_ba_pg_sz + PAGE_SHIFT,
 				  udata, start);
-	if (err)
+	if (err) {
 		ibdev_err(ibdev, "failed to alloc pbl mtr, ret = %d.\n", err);
-	else
-		mr->npages = mr->pbl_mtr.hem_cfg.buf_pg_count;
+		return err;
+	}
+
+	mr->npages = mr->pbl_mtr.hem_cfg.buf_pg_count;
+	mr->pbl_hop_num = buf_attr.region[0].hopnum;
 
 	return err;
 }
@@ -990,6 +993,50 @@ static int get_best_page_shift(struct hns_roce_dev *hr_dev,
 	return 0;
 }
 
+static int get_best_hop_num(struct hns_roce_dev *hr_dev,
+			    struct hns_roce_mtr *mtr,
+			    struct hns_roce_buf_attr *buf_attr,
+			    unsigned int ba_pg_shift)
+{
+#define INVALID_HOPNUM -1
+#define MIN_BA_CNT 1
+	size_t buf_pg_sz = 1 << buf_attr->page_shift;
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+	size_t ba_pg_sz = 1 << ba_pg_shift;
+	int hop_num = INVALID_HOPNUM;
+	size_t unit = MIN_BA_CNT;
+	size_t ba_cnt;
+	int j;
+
+	if (!buf_attr->adaptive || buf_attr->type != MTR_PBL)
+		return 0;
+
+	/* Caculating the number of buf pages, each buf page need a BA */
+	if (mtr->umem)
+		ba_cnt = ib_umem_num_dma_blocks(mtr->umem, buf_pg_sz);
+	else
+		ba_cnt = DIV_ROUND_UP(buf_attr->region[0].size, buf_pg_sz);
+
+	for (j = 0; j <= HNS_ROCE_MAX_HOP_NUM; j++) {
+		if (ba_cnt <= unit) {
+			hop_num = j;
+			break;
+		}
+		/* Number of BAs can be represented at per hop */
+		unit *= ba_pg_sz / BA_BYTE_LEN;
+	}
+
+	if (hop_num < 0) {
+		ibdev_err(ibdev,
+			  "failed to calculate a valid hopnum.\n");
+		return -EINVAL;
+	}
+
+	buf_attr->region[0].hopnum = hop_num;
+
+	return 0;
+}
+
 static bool is_buf_attr_valid(struct hns_roce_dev *hr_dev,
 			      struct hns_roce_buf_attr *attr)
 {
@@ -1163,6 +1210,10 @@ int hns_roce_mtr_create(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 		ret = get_best_page_shift(hr_dev, mtr, buf_attr);
 		if (ret)
 			goto err_init_buf;
+
+		ret = get_best_hop_num(hr_dev, mtr, buf_attr, ba_page_shift);
+		if (ret)
+			goto err_init_buf;
 	}
 
 	ret = mtr_init_buf_cfg(hr_dev, mtr, buf_attr);
-- 
2.30.0


