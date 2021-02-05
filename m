Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 464EB31083B
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Feb 2021 10:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhBEJrM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Feb 2021 04:47:12 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:12847 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhBEJpL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Feb 2021 04:45:11 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DX9QB0c1mz7hVt;
        Fri,  5 Feb 2021 17:40:34 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Fri, 5 Feb 2021 17:41:50 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH for-next 08/12] RDMA/hns: Move HIP06 related definitions into hns_roce_hw_v1.h
Date:   Fri, 5 Feb 2021 17:39:30 +0800
Message-ID: <1612517974-31867-9-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1612517974-31867-1-git-send-email-liweihang@huawei.com>
References: <1612517974-31867-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

hns_roce_device.h is not specific to hardware, some definitions are only
used for HIP06, they should be moved into hns_roce_hw_v1.h.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h | 41 ---------------------------
 drivers/infiniband/hw/hns/hns_roce_hw_v1.h  | 43 +++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 41 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 74eb08f..315c013 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -170,44 +170,6 @@ enum hns_roce_event {
 	HNS_ROCE_EVENT_TYPE_FLR			      = 0x15,
 };
 
-/* Local Work Queue Catastrophic Error,SUBTYPE 0x5 */
-enum {
-	HNS_ROCE_LWQCE_QPC_ERROR		= 1,
-	HNS_ROCE_LWQCE_MTU_ERROR		= 2,
-	HNS_ROCE_LWQCE_WQE_BA_ADDR_ERROR	= 3,
-	HNS_ROCE_LWQCE_WQE_ADDR_ERROR		= 4,
-	HNS_ROCE_LWQCE_SQ_WQE_SHIFT_ERROR	= 5,
-	HNS_ROCE_LWQCE_SL_ERROR			= 6,
-	HNS_ROCE_LWQCE_PORT_ERROR		= 7,
-};
-
-/* Local Access Violation Work Queue Error,SUBTYPE 0x7 */
-enum {
-	HNS_ROCE_LAVWQE_R_KEY_VIOLATION		= 1,
-	HNS_ROCE_LAVWQE_LENGTH_ERROR		= 2,
-	HNS_ROCE_LAVWQE_VA_ERROR		= 3,
-	HNS_ROCE_LAVWQE_PD_ERROR		= 4,
-	HNS_ROCE_LAVWQE_RW_ACC_ERROR		= 5,
-	HNS_ROCE_LAVWQE_KEY_STATE_ERROR		= 6,
-	HNS_ROCE_LAVWQE_MR_OPERATION_ERROR	= 7,
-};
-
-/* DOORBELL overflow subtype */
-enum {
-	HNS_ROCE_DB_SUBTYPE_SDB_OVF		= 1,
-	HNS_ROCE_DB_SUBTYPE_SDB_ALM_OVF		= 2,
-	HNS_ROCE_DB_SUBTYPE_ODB_OVF		= 3,
-	HNS_ROCE_DB_SUBTYPE_ODB_ALM_OVF		= 4,
-	HNS_ROCE_DB_SUBTYPE_SDB_ALM_EMP		= 5,
-	HNS_ROCE_DB_SUBTYPE_ODB_ALM_EMP		= 6,
-};
-
-enum {
-	/* RQ&SRQ related operations */
-	HNS_ROCE_OPCODE_SEND_DATA_RECEIVE	= 0x06,
-	HNS_ROCE_OPCODE_RDMA_WITH_IMM_RECEIVE	= 0x07,
-};
-
 #define HNS_ROCE_CAP_FLAGS_EX_SHIFT 12
 
 enum {
@@ -260,9 +222,6 @@ enum {
 
 #define HNS_ROCE_CMD_SUCCESS			1
 
-#define HNS_ROCE_PORT_DOWN			0
-#define HNS_ROCE_PORT_UP			1
-
 /* The minimum page size is 4K for hardware */
 #define HNS_HW_PAGE_SHIFT			12
 #define HNS_HW_PAGE_SIZE			(1 << HNS_HW_PAGE_SHIFT)
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.h b/drivers/infiniband/hw/hns/hns_roce_hw_v1.h
index 46ab0a3..8438323 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.h
@@ -193,6 +193,49 @@
 #define HNS_ROCE_AEQE_EVENT_CE_EVENT_CEQE_CEQN_S 0
 #define HNS_ROCE_AEQE_EVENT_CE_EVENT_CEQE_CEQN_M GENMASK(4, 0)
 
+/* Local Work Queue Catastrophic Error,SUBTYPE 0x5 */
+enum {
+	HNS_ROCE_LWQCE_QPC_ERROR = 1,
+	HNS_ROCE_LWQCE_MTU_ERROR,
+	HNS_ROCE_LWQCE_WQE_BA_ADDR_ERROR,
+	HNS_ROCE_LWQCE_WQE_ADDR_ERROR,
+	HNS_ROCE_LWQCE_SQ_WQE_SHIFT_ERROR,
+	HNS_ROCE_LWQCE_SL_ERROR,
+	HNS_ROCE_LWQCE_PORT_ERROR,
+};
+
+/* Local Access Violation Work Queue Error,SUBTYPE 0x7 */
+enum {
+	HNS_ROCE_LAVWQE_R_KEY_VIOLATION = 1,
+	HNS_ROCE_LAVWQE_LENGTH_ERROR,
+	HNS_ROCE_LAVWQE_VA_ERROR,
+	HNS_ROCE_LAVWQE_PD_ERROR,
+	HNS_ROCE_LAVWQE_RW_ACC_ERROR,
+	HNS_ROCE_LAVWQE_KEY_STATE_ERROR,
+	HNS_ROCE_LAVWQE_MR_OPERATION_ERROR,
+};
+
+/* DOORBELL overflow subtype */
+enum {
+	HNS_ROCE_DB_SUBTYPE_SDB_OVF = 1,
+	HNS_ROCE_DB_SUBTYPE_SDB_ALM_OVF,
+	HNS_ROCE_DB_SUBTYPE_ODB_OVF,
+	HNS_ROCE_DB_SUBTYPE_ODB_ALM_OVF,
+	HNS_ROCE_DB_SUBTYPE_SDB_ALM_EMP,
+	HNS_ROCE_DB_SUBTYPE_ODB_ALM_EMP,
+};
+
+enum {
+	/* RQ&SRQ related operations */
+	HNS_ROCE_OPCODE_SEND_DATA_RECEIVE = 0x06,
+	HNS_ROCE_OPCODE_RDMA_WITH_IMM_RECEIVE,
+};
+
+enum {
+	HNS_ROCE_PORT_DOWN = 0,
+	HNS_ROCE_PORT_UP,
+};
+
 struct hns_roce_cq_context {
 	__le32 cqc_byte_4;
 	__le32 cq_bt_l;
-- 
2.8.1

