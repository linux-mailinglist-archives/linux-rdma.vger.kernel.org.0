Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10550C13F3
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Sep 2019 10:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbfI2Icp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 29 Sep 2019 04:32:45 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49908 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728534AbfI2Ico (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 29 Sep 2019 04:32:44 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 35443CDE84216671EA8D;
        Sun, 29 Sep 2019 16:32:43 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Sun, 29 Sep 2019 16:32:37 +0800
From:   Weihang Li <liweihang@hisilicon.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH v4 rdma-core 1/4] libhns: Add support of handling AH for hip08
Date:   Sun, 29 Sep 2019 16:29:11 +0800
Message-ID: <1569745754-45346-2-git-send-email-liweihang@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1569745754-45346-1-git-send-email-liweihang@hisilicon.com>
References: <1569745754-45346-1-git-send-email-liweihang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lijun Ou <oulijun@huawei.com>

This patch achieves two verbs create_ah and destroy_ah to support
allocation and destruction of Address Handle.

Signed-off-by: Lijun Ou <oulijun@huawei.com>
Signed-off-by: Weihang Li <liweihang@hisilicon.com>
---
 providers/hns/hns_roce_u.c       |  2 ++
 providers/hns/hns_roce_u.h       | 30 +++++++++++++++++++++++++++++
 providers/hns/hns_roce_u_verbs.c | 41 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+)

diff --git a/providers/hns/hns_roce_u.c b/providers/hns/hns_roce_u.c
index 5872599..8ba41de 100644
--- a/providers/hns/hns_roce_u.c
+++ b/providers/hns/hns_roce_u.c
@@ -81,6 +81,8 @@ static const struct verbs_context_ops hns_common_ops = {
 	.modify_srq = hns_roce_u_modify_srq,
 	.query_srq = hns_roce_u_query_srq,
 	.destroy_srq = hns_roce_u_destroy_srq,
+	.create_ah = hns_roce_u_create_ah,
+	.destroy_ah = hns_roce_u_destroy_ah,
 };
 
 static struct verbs_context *hns_roce_alloc_context(struct ibv_device *ibdev,
diff --git a/providers/hns/hns_roce_u.h b/providers/hns/hns_roce_u.h
index 23e0f13..45472fe 100644
--- a/providers/hns/hns_roce_u.h
+++ b/providers/hns/hns_roce_u.h
@@ -68,6 +68,8 @@
 #define HNS_ROCE_TPTR_OFFSET		0x1000
 #define HNS_ROCE_STATIC_RATE		3 /* Gbps */
 
+#define	ETH_ALEN			6
+
 #define roce_get_field(origin, mask, shift) \
 	(((le32toh(origin)) & (mask)) >> (shift))
 
@@ -244,6 +246,25 @@ struct hns_roce_qp {
 	unsigned long			flags;
 };
 
+struct hns_roce_av {
+	uint8_t				port;
+	uint8_t				gid_index;
+	uint8_t				static_rate;
+	uint8_t				hop_limit;
+	uint32_t			flowlabel;
+	uint8_t				sl;
+	uint8_t				tclass;
+	uint8_t				dgid[HNS_ROCE_GID_SIZE];
+	uint8_t				mac[ETH_ALEN];
+	uint16_t			vlan_id;
+	uint8_t				vlan_en;
+};
+
+struct hns_roce_ah {
+	struct ibv_ah			ibv_ah;
+	struct hns_roce_av		av;
+};
+
 struct hns_roce_u_hw {
 	uint32_t hw_version;
 	struct verbs_context_ops hw_ops;
@@ -280,6 +301,11 @@ static inline struct  hns_roce_qp *to_hr_qp(struct ibv_qp *ibv_qp)
 	return container_of(ibv_qp, struct hns_roce_qp, ibv_qp);
 }
 
+static inline struct hns_roce_ah *to_hr_ah(struct ibv_ah *ibv_ah)
+{
+	return container_of(ibv_ah, struct hns_roce_ah, ibv_ah);
+}
+
 int hns_roce_u_query_device(struct ibv_context *context,
 			    struct ibv_device_attr *attr);
 int hns_roce_u_query_port(struct ibv_context *context, uint8_t port,
@@ -319,6 +345,10 @@ struct ibv_qp *hns_roce_u_create_qp(struct ibv_pd *pd,
 int hns_roce_u_query_qp(struct ibv_qp *ibqp, struct ibv_qp_attr *attr,
 			int attr_mask, struct ibv_qp_init_attr *init_attr);
 
+struct ibv_ah *hns_roce_u_create_ah(struct ibv_pd *pd,
+				    struct ibv_ah_attr *attr);
+int hns_roce_u_destroy_ah(struct ibv_ah *ah);
+
 int hns_roce_alloc_buf(struct hns_roce_buf *buf, unsigned int size,
 		       int page_size);
 void hns_roce_free_buf(struct hns_roce_buf *buf);
diff --git a/providers/hns/hns_roce_u_verbs.c b/providers/hns/hns_roce_u_verbs.c
index 9d222c0..ef4b9e0 100644
--- a/providers/hns/hns_roce_u_verbs.c
+++ b/providers/hns/hns_roce_u_verbs.c
@@ -38,6 +38,7 @@
 #include <sys/mman.h>
 #include <ccan/ilog.h>
 #include <ccan/minmax.h>
+#include <ccan/array_size.h>
 #include <util/util.h>
 #include "hns_roce_u.h"
 #include "hns_roce_u_abi.h"
@@ -952,3 +953,43 @@ int hns_roce_u_query_qp(struct ibv_qp *ibqp, struct ibv_qp_attr *attr,
 
 	return ret;
 }
+
+struct ibv_ah *hns_roce_u_create_ah(struct ibv_pd *pd, struct ibv_ah_attr *attr)
+{
+	struct hns_roce_ah *ah;
+
+	ah = calloc(1, sizeof(*ah));
+	if (!ah)
+		return NULL;
+
+	ah->av.port = attr->port_num;
+	ah->av.sl = attr->sl;
+
+	if (attr->static_rate)
+		ah->av.static_rate = IBV_RATE_10_GBPS;
+
+	if (attr->is_global) {
+		ah->av.gid_index = attr->grh.sgid_index;
+		ah->av.hop_limit = attr->grh.hop_limit;
+		ah->av.tclass = attr->grh.traffic_class;
+		ah->av.flowlabel = attr->grh.flow_label;
+
+		memcpy(ah->av.dgid, attr->grh.dgid.raw,
+		       ARRAY_SIZE(ah->av.dgid));
+	}
+
+	return &ah->ibv_ah;
+}
+
+int hns_roce_u_destroy_ah(struct ibv_ah *ah)
+{
+	int ret;
+
+	ret = ibv_cmd_destroy_ah(ah);
+	if (ret)
+		return ret;
+
+	free(to_hr_ah(ah));
+
+	return 0;
+}
-- 
2.8.1

