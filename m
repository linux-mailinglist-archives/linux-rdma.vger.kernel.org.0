Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED41354E75
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Apr 2021 10:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239733AbhDFIWi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Apr 2021 04:22:38 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:15914 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239762AbhDFIWh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Apr 2021 04:22:37 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FF0pL1XBLzkgVv;
        Tue,  6 Apr 2021 16:20:42 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Tue, 6 Apr 2021 16:22:17 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 3/6] RDMA/core: Add necessary spaces
Date:   Tue, 6 Apr 2021 16:19:41 +0800
Message-ID: <1617697184-48683-4-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1617697184-48683-1-git-send-email-liweihang@huawei.com>
References: <1617697184-48683-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Wenpeng Liang <liangwenpeng@huawei.com>

Space is required before '(', around '==' and around '='.

Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/core/cm.c      | 2 +-
 drivers/infiniband/core/cm_msgs.h | 4 ++--
 drivers/infiniband/core/iwcm.c    | 2 +-
 drivers/infiniband/core/ucma.c    | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 32c836b..28c8d13 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -3099,7 +3099,7 @@ int ib_send_cm_mra(struct ib_cm_id *cm_id,
 	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
 
 	spin_lock_irqsave(&cm_id_priv->lock, flags);
-	switch(cm_id_priv->id.state) {
+	switch (cm_id_priv->id.state) {
 	case IB_CM_REQ_RCVD:
 		cm_state = IB_CM_MRA_REQ_SENT;
 		lap_state = cm_id->lap_state;
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index 0cc4065..8462de7 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -22,7 +22,7 @@
 static inline enum ib_qp_type cm_req_get_qp_type(struct cm_req_msg *req_msg)
 {
 	u8 transport_type = IBA_GET(CM_REQ_TRANSPORT_SERVICE_TYPE, req_msg);
-	switch(transport_type) {
+	switch (transport_type) {
 	case 0: return IB_QPT_RC;
 	case 1: return IB_QPT_UC;
 	case 3:
@@ -37,7 +37,7 @@ static inline enum ib_qp_type cm_req_get_qp_type(struct cm_req_msg *req_msg)
 static inline void cm_req_set_qp_type(struct cm_req_msg *req_msg,
 				      enum ib_qp_type qp_type)
 {
-	switch(qp_type) {
+	switch (qp_type) {
 	case IB_QPT_UC:
 		IBA_SET(CM_REQ_TRANSPORT_SERVICE_TYPE, req_msg, 1);
 		break;
diff --git a/drivers/infiniband/core/iwcm.c b/drivers/infiniband/core/iwcm.c
index da8adad..ee5ab1c 100644
--- a/drivers/infiniband/core/iwcm.c
+++ b/drivers/infiniband/core/iwcm.c
@@ -211,7 +211,7 @@ static void free_cm_id(struct iwcm_id_private *cm_id_priv)
  */
 static int iwcm_deref_id(struct iwcm_id_private *cm_id_priv)
 {
-	BUG_ON(atomic_read(&cm_id_priv->refcount)==0);
+	BUG_ON(atomic_read(&cm_id_priv->refcount) == 0);
 	if (atomic_dec_and_test(&cm_id_priv->refcount)) {
 		BUG_ON(!list_empty(&cm_id_priv->work_list));
 		free_cm_id(cm_id_priv);
diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index 21dda69..15d57ba 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -231,7 +231,7 @@ static void ucma_copy_conn_event(struct rdma_ucm_conn_param *dst,
 		memcpy(dst->private_data, src->private_data,
 		       src->private_data_len);
 	dst->private_data_len = src->private_data_len;
-	dst->responder_resources =src->responder_resources;
+	dst->responder_resources = src->responder_resources;
 	dst->initiator_depth = src->initiator_depth;
 	dst->flow_control = src->flow_control;
 	dst->retry_count = src->retry_count;
@@ -1034,7 +1034,7 @@ static void ucma_copy_conn_param(struct rdma_cm_id *id,
 {
 	dst->private_data = src->private_data;
 	dst->private_data_len = src->private_data_len;
-	dst->responder_resources =src->responder_resources;
+	dst->responder_resources = src->responder_resources;
 	dst->initiator_depth = src->initiator_depth;
 	dst->flow_control = src->flow_control;
 	dst->retry_count = src->retry_count;
-- 
2.8.1

