Return-Path: <linux-rdma+bounces-136-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA067FD32C
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Nov 2023 10:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD706283031
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Nov 2023 09:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8DF18E13;
	Wed, 29 Nov 2023 09:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C719719BC;
	Wed, 29 Nov 2023 01:48:11 -0800 (PST)
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.54])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SgDsL5CSTzMnVg;
	Wed, 29 Nov 2023 17:43:18 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 29 Nov 2023 17:48:09 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-rc 6/6] RDMA/hns: Improve the readability of free mr uninit
Date: Wed, 29 Nov 2023 17:44:34 +0800
Message-ID: <20231129094434.134528-7-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20231129094434.134528-1-huangjunxian6@hisilicon.com>
References: <20231129094434.134528-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500006.china.huawei.com (7.221.188.68)
X-CFilter-Loop: Reflected

From: Chengchang Tang <tangchengchang@huawei.com>

Extract uninit functions of free mr qp, cq and pd to improve
readability.

Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 73 ++++++++++++++--------
 1 file changed, 47 insertions(+), 26 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 538f3e8949fc..be02034a8818 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -2573,6 +2573,19 @@ static struct ib_pd *free_mr_init_pd(struct hns_roce_dev *hr_dev)
 	return pd;
 }
 
+static void free_mr_uninit_pd(struct hns_roce_dev *hr_dev)
+{
+	struct hns_roce_v2_priv *priv = hr_dev->priv;
+	struct hns_roce_v2_free_mr *free_mr = &priv->free_mr;
+
+	if (!free_mr->rsv_pd)
+		return;
+
+	hns_roce_dealloc_pd(&free_mr->rsv_pd->ibpd, NULL);
+	kfree(free_mr->rsv_pd);
+	free_mr->rsv_pd = NULL;
+}
+
 static struct ib_cq *free_mr_init_cq(struct hns_roce_dev *hr_dev)
 {
 	struct hns_roce_v2_priv *priv = hr_dev->priv;
@@ -2607,6 +2620,19 @@ static struct ib_cq *free_mr_init_cq(struct hns_roce_dev *hr_dev)
 	return cq;
 }
 
+static void free_mr_uninit_cq(struct hns_roce_dev *hr_dev)
+{
+	struct hns_roce_v2_priv *priv = hr_dev->priv;
+	struct hns_roce_v2_free_mr *free_mr = &priv->free_mr;
+
+	if (!free_mr->rsv_cq)
+		return;
+
+	hns_roce_destroy_cq(&free_mr->rsv_cq->ib_cq, NULL);
+	kfree(free_mr->rsv_cq);
+	free_mr->rsv_cq = NULL;
+}
+
 static int free_mr_init_qp(struct hns_roce_dev *hr_dev, struct ib_cq *cq,
 			   struct ib_qp_init_attr *init_attr, int i)
 {
@@ -2638,6 +2664,19 @@ static int free_mr_init_qp(struct hns_roce_dev *hr_dev, struct ib_cq *cq,
 	return 0;
 }
 
+static void free_mr_uninit_qp(struct hns_roce_dev *hr_dev, int i)
+{
+	struct hns_roce_v2_priv *priv = hr_dev->priv;
+	struct hns_roce_v2_free_mr *free_mr = &priv->free_mr;
+
+	if (!free_mr->rsv_qp[i])
+		return;
+
+	hns_roce_v2_destroy_qp(&free_mr->rsv_qp[i]->ibqp, NULL);
+	kfree(free_mr->rsv_qp[i]);
+	free_mr->rsv_qp[i] = NULL;
+}
+
 static void free_mr_exit(struct hns_roce_dev *hr_dev)
 {
 	struct hns_roce_v2_priv *priv = hr_dev->priv;
@@ -2645,26 +2684,12 @@ static void free_mr_exit(struct hns_roce_dev *hr_dev)
 	struct ib_qp *qp;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(free_mr->rsv_qp); i++) {
-		if (free_mr->rsv_qp[i]) {
-			qp = &free_mr->rsv_qp[i]->ibqp;
-			hns_roce_v2_destroy_qp(qp, NULL);
-			kfree(free_mr->rsv_qp[i]);
-			free_mr->rsv_qp[i] = NULL;
-		}
-	}
+	for (i = 0; i < ARRAY_SIZE(free_mr->rsv_qp); i++)
+		free_mr_uninit_qp(hr_dev, i);
 
-	if (free_mr->rsv_cq) {
-		hns_roce_destroy_cq(&free_mr->rsv_cq->ib_cq, NULL);
-		kfree(free_mr->rsv_cq);
-		free_mr->rsv_cq = NULL;
-	}
+	free_mr_uninit_cq(hr_dev);
 
-	if (free_mr->rsv_pd) {
-		hns_roce_dealloc_pd(&free_mr->rsv_pd->ibpd, NULL);
-		kfree(free_mr->rsv_pd);
-		free_mr->rsv_pd = NULL;
-	}
+	free_mr_uninit_pd(hr_dev);
 }
 
 static int free_mr_alloc_res(struct hns_roce_dev *hr_dev)
@@ -2705,16 +2730,12 @@ static int free_mr_alloc_res(struct hns_roce_dev *hr_dev)
 	return 0;
 
 create_failed_qp:
-	for (i--; i >= 0; i--) {
-		hns_roce_v2_destroy_qp(&free_mr->rsv_qp[i]->ibqp, NULL);
-		kfree(free_mr->rsv_qp[i]);
-	}
-	hns_roce_destroy_cq(cq, NULL);
-	kfree(cq);
+	for (i--; i >= 0; i--)
+		free_mr_uninit_qp(hr_dev, i);
+	free_mr_uninit_cq(hr_dev);
 
 create_failed_cq:
-	hns_roce_dealloc_pd(pd, NULL);
-	kfree(pd);
+	free_mr_uninit_pd(hr_dev);
 
 	return ret;
 }
-- 
2.30.0


