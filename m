Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032123B040A
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 14:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbhFVMSu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Jun 2021 08:18:50 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:8292 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbhFVMSu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Jun 2021 08:18:50 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4G8QGz0vS6z1BQWB;
        Tue, 22 Jun 2021 20:11:23 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 22 Jun 2021 20:16:32 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 22 Jun 2021 20:16:31 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Yixing Liu <liuyixing1@huawei.com>,
        Weihang Li <liweihang@huawei.com>
Subject: [PATCH for-next] RDMA/hns: Add window selection field of congestion control
Date:   Tue, 22 Jun 2021 20:16:03 +0800
Message-ID: <1624364163-44185-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yixing Liu <liuyixing1@huawei.com>

The window selection field is necessary for congestion control of HIP09, it
is got from firmware and then filled into QPC. Some algorithms need it to
decide whether to limit the number of windows.

Fixes: f91696f2f053 ("RDMA/hns: Support congestion control type selection according to the FW")
Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 12 ++++++++++++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 069c7cd..e057ede 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4585,6 +4585,11 @@ enum {
 	DIP_VALID,
 };
 
+enum {
+	WND_LIMIT,
+	WND_UNLIMIT,
+};
+
 static int check_cong_type(struct ib_qp *ibqp,
 			   struct hns_roce_congestion_algorithm *cong_alg)
 {
@@ -4596,21 +4601,25 @@ static int check_cong_type(struct ib_qp *ibqp,
 		cong_alg->alg_sel = CONG_DCQCN;
 		cong_alg->alg_sub_sel = UNSUPPORT_CONG_LEVEL;
 		cong_alg->dip_vld = DIP_INVALID;
+		cong_alg->wnd_mode_sel = WND_LIMIT;
 		break;
 	case CONG_TYPE_LDCP:
 		cong_alg->alg_sel = CONG_WINDOW;
 		cong_alg->alg_sub_sel = CONG_LDCP;
 		cong_alg->dip_vld = DIP_INVALID;
+		cong_alg->wnd_mode_sel = WND_UNLIMIT;
 		break;
 	case CONG_TYPE_HC3:
 		cong_alg->alg_sel = CONG_WINDOW;
 		cong_alg->alg_sub_sel = CONG_HC3;
 		cong_alg->dip_vld = DIP_INVALID;
+		cong_alg->wnd_mode_sel = WND_LIMIT;
 		break;
 	case CONG_TYPE_DIP:
 		cong_alg->alg_sel = CONG_DCQCN;
 		cong_alg->alg_sub_sel = UNSUPPORT_CONG_LEVEL;
 		cong_alg->dip_vld = DIP_VALID;
+		cong_alg->wnd_mode_sel = WND_LIMIT;
 		break;
 	default:
 		ibdev_err(&hr_dev->ib_dev,
@@ -4651,6 +4660,9 @@ static int fill_cong_field(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
 	hr_reg_clear(&qpc_mask->ext, QPCEX_CONG_ALG_SUB_SEL);
 	hr_reg_write(&context->ext, QPCEX_DIP_CTX_IDX_VLD, cong_field.dip_vld);
 	hr_reg_clear(&qpc_mask->ext, QPCEX_DIP_CTX_IDX_VLD);
+	hr_reg_write(&context->ext, QPCEX_SQ_RQ_NOT_FORBID_EN,
+		     cong_field.wnd_mode_sel);
+	hr_reg_clear(&qpc_mask->ext, QPCEX_SQ_RQ_NOT_FORBID_EN);
 
 	/* if dip is disabled, there is no need to set dip idx */
 	if (cong_field.dip_vld == 0)
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 04b4ad4..82a2fe4 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -700,6 +700,7 @@ struct hns_roce_v2_qp_context {
 #define QPCEX_CONG_ALG_SUB_SEL QPCEX_FIELD_LOC(1, 1)
 #define QPCEX_DIP_CTX_IDX_VLD QPCEX_FIELD_LOC(2, 2)
 #define QPCEX_DIP_CTX_IDX QPCEX_FIELD_LOC(22, 3)
+#define QPCEX_SQ_RQ_NOT_FORBID_EN QPCEX_FIELD_LOC(23, 23)
 #define QPCEX_STASH QPCEX_FIELD_LOC(82, 82)
 
 #define	V2_QP_RWE_S 1 /* rdma write enable */
@@ -1337,6 +1338,7 @@ struct hns_roce_congestion_algorithm {
 	u8 alg_sel;
 	u8 alg_sub_sel;
 	u8 dip_vld;
+	u8 wnd_mode_sel;
 };
 
 #define V2_QUERY_PF_CAPS_D_CEQ_DEPTH_S 0
-- 
2.7.4

