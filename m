Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED6845703F
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Nov 2021 15:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235635AbhKSOJp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Nov 2021 09:09:45 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:26336 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235642AbhKSOJo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 Nov 2021 09:09:44 -0500
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Hwdd42Tzwzbht3;
        Fri, 19 Nov 2021 22:01:44 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 19 Nov 2021 22:06:41 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 19 Nov 2021 22:06:41 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH for-next 9/9] RDMA/hns: Remove magic number
Date:   Fri, 19 Nov 2021 22:02:08 +0800
Message-ID: <20211119140208.40416-10-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211119140208.40416-1-liangwenpeng@huawei.com>
References: <20211119140208.40416-1-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xinhao Liu <liuxinhao5@hisilicon.com>

Don't use unintelligible constants.

Signed-off-by: Xinhao Liu <liuxinhao5@hisilicon.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 978913fc7587..66393b97a469 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -677,6 +677,7 @@ static void hns_roce_write512(struct hns_roce_dev *hr_dev, u64 *val,
 static void write_dwqe(struct hns_roce_dev *hr_dev, struct hns_roce_qp *qp,
 		       void *wqe)
 {
+#define HNS_ROCE_SL_SHIFT 2
 	struct hns_roce_v2_rc_send_wqe *rc_sq_wqe = wqe;
 
 	/* All kinds of DirectWQE have the same header field layout */
@@ -684,7 +685,8 @@ static void write_dwqe(struct hns_roce_dev *hr_dev, struct hns_roce_qp *qp,
 	roce_set_field(rc_sq_wqe->byte_4, V2_RC_SEND_WQE_BYTE_4_DB_SL_L_M,
 		       V2_RC_SEND_WQE_BYTE_4_DB_SL_L_S, qp->sl);
 	roce_set_field(rc_sq_wqe->byte_4, V2_RC_SEND_WQE_BYTE_4_DB_SL_H_M,
-		       V2_RC_SEND_WQE_BYTE_4_DB_SL_H_S, qp->sl >> 2);
+		       V2_RC_SEND_WQE_BYTE_4_DB_SL_H_S,
+		       qp->sl >> HNS_ROCE_SL_SHIFT);
 	roce_set_field(rc_sq_wqe->byte_4, V2_RC_SEND_WQE_BYTE_4_WQE_INDEX_M,
 		       V2_RC_SEND_WQE_BYTE_4_WQE_INDEX_S, qp->sq.head);
 
-- 
2.33.0

