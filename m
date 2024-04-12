Return-Path: <linux-rdma+bounces-1934-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 094758A2B09
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Apr 2024 11:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88CFA1F2226B
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Apr 2024 09:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6618A56473;
	Fri, 12 Apr 2024 09:20:55 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08A852F68;
	Fri, 12 Apr 2024 09:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712913655; cv=none; b=SLvNY1JWFofykgPco5/qY87gilPgH/CExma4YAh3RVDLIWs0qXXh4ksIMEMqwvMsK+/6dAYhQh7C6uUHSl1fxN9Uqa8s1lmuct8MZ1Y+y5HpNOqhfBl8pzJLWPl5V23Sk8OlvIV/QfKHVlBtUo8LjAsu35ZzdCahTMe+kbT85TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712913655; c=relaxed/simple;
	bh=CeDO4sdjE7RG6Fiqifpe7R2m7Rig6nkuBfwN+cuJdLs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wl/jFwj14NmZLFER60qOLlPRDuKhd7lhjcgK57W7zwz0g3TyWWT/2iREJ2dxQXgJwW4jLa/fGT3PqMkyC4Cfw2ctx2+oSPiFU4n4rFyb/6IkVdZaH9wjNLgyQiLQC4yC3+Jlng5gWCI5Op1ru/rPleaBdf37e/yu6/2uC4SDmbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VG9wS1X1Gz1ynLl;
	Fri, 12 Apr 2024 17:18:32 +0800 (CST)
Received: from kwepemi500006.china.huawei.com (unknown [7.221.188.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 01BB5140156;
	Fri, 12 Apr 2024 17:20:50 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 17:20:49 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-next 08/10] RDMA/hns: Add mutex_destroy()
Date: Fri, 12 Apr 2024 17:16:14 +0800
Message-ID: <20240412091616.370789-9-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240412091616.370789-1-huangjunxian6@hisilicon.com>
References: <20240412091616.370789-1-huangjunxian6@hisilicon.com>
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

From: wenglianfa <wenglianfa@huawei.com>

Add mutex_destroy().

Signed-off-by: wenglianfa <wenglianfa@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_cq.c    |  1 +
 drivers/infiniband/hw/hns/hns_roce_hem.c   |  2 ++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c |  6 +++++-
 drivers/infiniband/hw/hns/hns_roce_main.c  | 24 ++++++++++++++++++++--
 drivers/infiniband/hw/hns/hns_roce_qp.c    |  9 ++++++--
 drivers/infiniband/hw/hns/hns_roce_srq.c   |  2 ++
 6 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index 68e22f368d43..56dc3908da2f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -536,4 +536,5 @@ void hns_roce_cleanup_cq_table(struct hns_roce_dev *hr_dev)
 
 	for (i = 0; i < HNS_ROCE_CQ_BANK_NUM; i++)
 		ida_destroy(&hr_dev->cq_table.bank[i].ida);
+	mutex_destroy(&hr_dev->cq_table.bank_mutex);
 }
diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index 1c2ec803e030..02baa853a76c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -877,6 +877,7 @@ void hns_roce_cleanup_hem_table(struct hns_roce_dev *hr_dev,
 
 	if (hns_roce_check_whether_mhop(hr_dev, table->type)) {
 		hns_roce_cleanup_mhop_hem_table(hr_dev, table);
+		mutex_destroy(&table->mutex);
 		return;
 	}
 
@@ -891,6 +892,7 @@ void hns_roce_cleanup_hem_table(struct hns_roce_dev *hr_dev,
 			hns_roce_free_hem(hr_dev, table->hem[i]);
 		}
 
+	mutex_destroy(&table->mutex);
 	kfree(table->hem);
 }
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 89d0f5b8be75..5d526b5c4b81 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -2667,6 +2667,8 @@ static void free_mr_exit(struct hns_roce_dev *hr_dev)
 		kfree(free_mr->rsv_pd);
 		free_mr->rsv_pd = NULL;
 	}
+
+	mutex_destroy(&free_mr->mutex);
 }
 
 static int free_mr_alloc_res(struct hns_roce_dev *hr_dev)
@@ -2817,8 +2819,10 @@ static int free_mr_init(struct hns_roce_dev *hr_dev)
 	mutex_init(&free_mr->mutex);
 
 	ret = free_mr_alloc_res(hr_dev);
-	if (ret)
+	if (ret) {
+		mutex_destroy(&free_mr->mutex);
 		return ret;
+	}
 
 	ret = free_mr_modify_qp(hr_dev);
 	if (ret)
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index d202258368ed..4cb0af733587 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -429,6 +429,9 @@ static int hns_roce_alloc_ucontext(struct ib_ucontext *uctx,
 	return 0;
 
 error_fail_copy_to_udata:
+	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_CQ_RECORD_DB ||
+	    hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_QP_RECORD_DB)
+		mutex_destroy(&context->page_mutex);
 	hns_roce_dealloc_uar_entry(context);
 
 error_fail_uar_entry:
@@ -445,6 +448,10 @@ static void hns_roce_dealloc_ucontext(struct ib_ucontext *ibcontext)
 	struct hns_roce_ucontext *context = to_hr_ucontext(ibcontext);
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibcontext->device);
 
+	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_CQ_RECORD_DB ||
+	    hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_QP_RECORD_DB)
+		mutex_destroy(&context->page_mutex);
+
 	hns_roce_dealloc_uar_entry(context);
 
 	ida_free(&hr_dev->uar_ida.ida, (int)context->uar.logic_idx);
@@ -933,6 +940,15 @@ static int hns_roce_init_hem(struct hns_roce_dev *hr_dev)
 	return ret;
 }
 
+static void hns_roce_teardown_hca(struct hns_roce_dev *hr_dev)
+{
+	hns_roce_cleanup_bitmap(hr_dev);
+
+	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_CQ_RECORD_DB ||
+	    hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_QP_RECORD_DB)
+		mutex_destroy(&hr_dev->pgdir_mutex);
+}
+
 /**
  * hns_roce_setup_hca - setup host channel adapter
  * @hr_dev: pointer to hns roce device
@@ -981,6 +997,10 @@ static int hns_roce_setup_hca(struct hns_roce_dev *hr_dev)
 
 err_uar_table_free:
 	ida_destroy(&hr_dev->uar_ida.ida);
+	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_CQ_RECORD_DB ||
+	    hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_QP_RECORD_DB)
+		mutex_destroy(&hr_dev->pgdir_mutex);
+
 	return ret;
 }
 
@@ -1126,7 +1146,7 @@ int hns_roce_init(struct hns_roce_dev *hr_dev)
 		hr_dev->hw->hw_exit(hr_dev);
 
 error_failed_engine_init:
-	hns_roce_cleanup_bitmap(hr_dev);
+	hns_roce_teardown_hca(hr_dev);
 
 error_failed_setup_hca:
 	hns_roce_cleanup_hem(hr_dev);
@@ -1156,7 +1176,7 @@ void hns_roce_exit(struct hns_roce_dev *hr_dev)
 
 	if (hr_dev->hw->hw_exit)
 		hr_dev->hw->hw_exit(hr_dev);
-	hns_roce_cleanup_bitmap(hr_dev);
+	hns_roce_teardown_hca(hr_dev);
 	hns_roce_cleanup_hem(hr_dev);
 
 	if (hr_dev->cmd_mod)
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index dc3cb26f434e..db34665d1dfb 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -1140,7 +1140,7 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 	ret = set_qp_param(hr_dev, hr_qp, init_attr, udata, &ucmd);
 	if (ret) {
 		ibdev_err(ibdev, "failed to set QP param, ret = %d.\n", ret);
-		return ret;
+		goto err_out;
 	}
 
 	if (!udata) {
@@ -1148,7 +1148,7 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 		if (ret) {
 			ibdev_err(ibdev, "failed to alloc wrid, ret = %d.\n",
 				  ret);
-			return ret;
+			goto err_out;
 		}
 	}
 
@@ -1219,6 +1219,8 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 	free_qp_buf(hr_dev, hr_qp);
 err_buf:
 	free_kernel_wrid(hr_qp);
+err_out:
+	mutex_destroy(&hr_qp->mutex);
 	return ret;
 }
 
@@ -1234,6 +1236,7 @@ void hns_roce_qp_destroy(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 	free_qp_buf(hr_dev, hr_qp);
 	free_kernel_wrid(hr_qp);
 	free_qp_db(hr_dev, hr_qp, udata);
+	mutex_destroy(&hr_qp->mutex);
 }
 
 static int check_qp_type(struct hns_roce_dev *hr_dev, enum ib_qp_type type,
@@ -1573,5 +1576,7 @@ void hns_roce_cleanup_qp_table(struct hns_roce_dev *hr_dev)
 
 	for (i = 0; i < HNS_ROCE_QP_BANK_NUM; i++)
 		ida_destroy(&hr_dev->qp_table.bank[i].ida);
+	mutex_destroy(&hr_dev->qp_table.bank_mutex);
+	mutex_destroy(&hr_dev->qp_table.scc_mutex);
 	kfree(hr_dev->qp_table.idx_table.spare_idx);
 }
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index 7210e53a82f3..f1997abc97ca 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -518,6 +518,7 @@ int hns_roce_create_srq(struct ib_srq *ib_srq,
 err_srq_buf:
 	free_srq_buf(hr_dev, srq);
 err_out:
+	mutex_destroy(&srq->mutex);
 	atomic64_inc(&hr_dev->dfx_cnt[HNS_ROCE_DFX_SRQ_CREATE_ERR_CNT]);
 
 	return ret;
@@ -532,6 +533,7 @@ int hns_roce_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
 	free_srqn(hr_dev, srq);
 	free_srq_db(hr_dev, srq, udata);
 	free_srq_buf(hr_dev, srq);
+	mutex_destroy(&srq->mutex);
 	return 0;
 }
 
-- 
2.30.0


