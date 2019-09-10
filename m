Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92DCCAEA43
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Sep 2019 14:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbfIJMYV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Sep 2019 08:24:21 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44144 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731259AbfIJMYU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 10 Sep 2019 08:24:20 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 67073F75EC9B54A89409;
        Tue, 10 Sep 2019 20:24:19 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Tue, 10 Sep 2019 20:24:10 +0800
From:   Weihang Li <liweihang@hisilicon.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH rdma-core 5/5] libhns: Support configuring loopback mode by user
Date:   Tue, 10 Sep 2019 20:20:52 +0800
Message-ID: <1568118052-33380-6-git-send-email-liweihang@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1568118052-33380-1-git-send-email-liweihang@hisilicon.com>
References: <1568118052-33380-1-git-send-email-liweihang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

User can configure whether hardware working on loopback mode or not
by export an environment variable "HNS_ROCE_LOOPBACK".

Signed-off-by: Weihang Li <liweihang@hisilicon.com>
---
 providers/hns/hns_roce_u.c       | 15 +++++++++++++++
 providers/hns/hns_roce_u.h       |  2 ++
 providers/hns/hns_roce_u_hw_v2.c |  3 ++-
 providers/hns/hns_roce_u_verbs.c |  1 +
 4 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/providers/hns/hns_roce_u.c b/providers/hns/hns_roce_u.c
index 8ba41de..f68c84b 100644
--- a/providers/hns/hns_roce_u.c
+++ b/providers/hns/hns_roce_u.c
@@ -40,6 +40,8 @@
 #include "hns_roce_u.h"
 #include "hns_roce_u_abi.h"
 
+bool loopback;
+
 #define HID_LEN			15
 #define DEV_MATCH_LEN		128
 
@@ -85,6 +87,17 @@ static const struct verbs_context_ops hns_common_ops = {
 	.destroy_ah = hns_roce_u_destroy_ah,
 };
 
+static bool get_param_config(const char *var)
+{
+	char *env;
+
+	env = getenv(var);
+	if (env)
+		return strcmp(env, "true") ? true : false;
+
+	return false;
+}
+
 static struct verbs_context *hns_roce_alloc_context(struct ibv_device *ibdev,
 						    int cmd_fd,
 						    void *private_data)
@@ -105,6 +118,8 @@ static struct verbs_context *hns_roce_alloc_context(struct ibv_device *ibdev,
 				&resp.ibv_resp, sizeof(resp)))
 		goto err_free;
 
+	loopback = get_param_config("HNS_ROCE_LOOPBACK");
+
 	context->num_qps = resp.qp_tab_size;
 	context->qp_table_shift = ffs(context->num_qps) - 1 -
 				  HNS_ROCE_QP_TABLE_BITS;
diff --git a/providers/hns/hns_roce_u.h b/providers/hns/hns_roce_u.h
index 9d8f72e..624bdaa 100644
--- a/providers/hns/hns_roce_u.h
+++ b/providers/hns/hns_roce_u.h
@@ -43,6 +43,7 @@
 #include <ccan/bitmap.h>
 #include <ccan/container_of.h>
 
+extern bool loopback;
 #define HNS_ROCE_HW_VER1		('h' << 24 | 'i' << 16 | '0' << 8 | '6')
 
 #define HNS_ROCE_HW_VER2		('h' << 24 | 'i' << 16 | '0' << 8 | '8')
@@ -265,6 +266,7 @@ struct hns_roce_av {
 	uint8_t				mac[ETH_ALEN];
 	uint16_t			vlan_id;
 	uint8_t				vlan_en;
+	uint8_t				loopback;
 };
 
 struct hns_roce_ah {
diff --git a/providers/hns/hns_roce_u_hw_v2.c b/providers/hns/hns_roce_u_hw_v2.c
index dd7545f..62e8561 100644
--- a/providers/hns/hns_roce_u_hw_v2.c
+++ b/providers/hns/hns_roce_u_hw_v2.c
@@ -685,7 +685,8 @@ static void set_ud_wqe(void *wqe, struct hns_roce_qp *qp,
 	roce_set_bit(ud_sq_wqe->lbi_flow_label, UD_SQ_WQE_VLAN_EN_S,
 		     ah->av.vlan_en ? 1 : 0);
 
-	roce_set_bit(ud_sq_wqe->lbi_flow_label, UD_SQ_WQE_LBI_S, 0);
+	roce_set_bit(ud_sq_wqe->lbi_flow_label, UD_SQ_WQE_LBI_S,
+		     ah->av.loopback);
 
 	roce_set_field(ud_sq_wqe->lbi_flow_label, UD_SQ_WQE_SL_M,
 		       UD_SQ_WQE_SL_S, ah->av.sl);
diff --git a/providers/hns/hns_roce_u_verbs.c b/providers/hns/hns_roce_u_verbs.c
index 5255fff..ff24ae3 100644
--- a/providers/hns/hns_roce_u_verbs.c
+++ b/providers/hns/hns_roce_u_verbs.c
@@ -970,6 +970,7 @@ struct ibv_ah *hns_roce_u_create_ah(struct ibv_pd *pd, struct ibv_ah_attr *attr)
 
 	ah->av.port = attr->port_num;
 	ah->av.sl = attr->sl;
+	ah->av.loopback = loopback ? 1 : 0;
 
 	if (attr->static_rate)
 		ah->av.static_rate = IBV_RATE_10_GBPS;
-- 
2.8.1

