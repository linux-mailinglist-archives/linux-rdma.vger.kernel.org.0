Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 283333F1021
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Aug 2021 03:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235556AbhHSB53 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Aug 2021 21:57:29 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:13443 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235258AbhHSB53 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Aug 2021 21:57:29 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Gqnpp6pVRzdc7Z;
        Thu, 19 Aug 2021 09:53:06 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 19 Aug 2021 09:56:52 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 19 Aug 2021 09:56:51 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH for-next] RDMA/hns: Restore mr status when rereg mr fails
Date:   Thu, 19 Aug 2021 09:53:03 +0800
Message-ID: <1629337984-24459-1-git-send-email-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yangyang Li <liyangyang20@huawei.com>

If rereg_user_mr fails, mr needs to stay in a safe state. The mr state is
backed up when entering the rereg_user_mr function, and the mr state is
restored when the rereg fails.

Fixes: 4e9fc1dae2a9 ("RDMA/hns: Optimize the MR registration process")
Reported-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_mr.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 006c84b..d0870b4 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -285,6 +285,27 @@ struct ib_mr *hns_roce_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	return ERR_PTR(ret);
 }
 
+static void copy_mr(struct hns_roce_mr *dst, struct hns_roce_mr *src)
+{
+	dst->enabled = src->enabled;
+	dst->iova = src->iova;
+	dst->size = src->size;
+	dst->pd = src->pd;
+	dst->access = src->access;
+}
+
+static void store_rereg_mr(struct hns_roce_mr *mr_bak,
+				  struct hns_roce_mr *mr)
+{
+	copy_mr(mr_bak, mr);
+}
+
+static void restore_rereg_mr(struct hns_roce_mr *mr_bak,
+				    struct hns_roce_mr *mr)
+{
+	copy_mr(mr, mr_bak);
+}
+
 struct ib_mr *hns_roce_rereg_user_mr(struct ib_mr *ibmr, int flags, u64 start,
 				     u64 length, u64 virt_addr,
 				     int mr_access_flags, struct ib_pd *pd,
@@ -294,9 +315,12 @@ struct ib_mr *hns_roce_rereg_user_mr(struct ib_mr *ibmr, int flags, u64 start,
 	struct ib_device *ib_dev = &hr_dev->ib_dev;
 	struct hns_roce_mr *mr = to_hr_mr(ibmr);
 	struct hns_roce_cmd_mailbox *mailbox;
+	struct hns_roce_mr mr_bak;
 	unsigned long mtpt_idx;
 	int ret;
 
+	store_rereg_mr(&mr_bak, mr);
+
 	if (!mr->enabled)
 		return ERR_PTR(-EINVAL);
 
@@ -349,7 +373,11 @@ struct ib_mr *hns_roce_rereg_user_mr(struct ib_mr *ibmr, int flags, u64 start,
 
 	mr->enabled = 1;
 
+	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
+	return NULL;
+
 free_cmd_mbox:
+	restore_rereg_mr(&mr_bak, mr);
 	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
 
 	return ERR_PTR(ret);
-- 
2.8.1

