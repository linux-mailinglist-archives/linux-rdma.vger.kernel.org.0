Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B32A03F8939
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Aug 2021 15:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242696AbhHZNmc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Aug 2021 09:42:32 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:18980 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242738AbhHZNmb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Aug 2021 09:42:31 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GwP6l58FjzbjH9;
        Thu, 26 Aug 2021 21:37:51 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 26 Aug 2021 21:41:28 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 26 Aug 2021 21:41:28 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH for-next 7/7] RDMA/hns: Delete unnecessary blank lines.
Date:   Thu, 26 Aug 2021 21:37:36 +0800
Message-ID: <1629985056-57004-8-git-send-email-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1629985056-57004-1-git-send-email-liangwenpeng@huawei.com>
References: <1629985056-57004-1-git-send-email-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xinhao Liu <liuxinhao5@hisilicon.com>

Just delete unnecessary blank lines.

Signed-off-by: Xinhao Liu <liuxinhao5@hisilicon.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 2 --
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h | 1 -
 drivers/infiniband/hw/hns/hns_roce_qp.c    | 1 -
 3 files changed, 4 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index c27dc68..5b99531 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5220,7 +5220,6 @@ static int hns_roce_v2_destroy_qp_common(struct hns_roce_dev *hr_dev,
 
 		if (send_cq && send_cq != recv_cq)
 			__hns_roce_v2_cq_clean(send_cq, hr_qp->qpn, NULL);
-
 	}
 
 	hns_roce_qp_remove(hr_dev, hr_qp);
@@ -6360,7 +6359,6 @@ static int hns_roce_hw_v2_init_instance(struct hnae3_handle *handle)
 
 	handle->rinfo.instance_state = HNS_ROCE_STATE_INITED;
 
-
 	return 0;
 
 reset_chk_err:
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 0b91a1a..4d904d5 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -1407,7 +1407,6 @@ struct hns_roce_cmq_desc {
 			__le32 rsv[4];
 		} func_info;
 	};
-
 };
 
 struct hns_roce_v2_cmq_ring {
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 74c9101..9af4509 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -715,7 +715,6 @@ static int alloc_rq_inline_buf(struct hns_roce_qp *hr_qp,
 	/* allocate recv inline buf */
 	wqe_list = kcalloc(wqe_cnt, sizeof(struct hns_roce_rinl_wqe),
 			   GFP_KERNEL);
-
 	if (!wqe_list)
 		goto err;
 
-- 
2.8.1

