Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAED46E9AB
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Dec 2021 15:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhLIOPN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Dec 2021 09:15:13 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:32896 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhLIOPN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Dec 2021 09:15:13 -0500
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4J8wv03hbszcbv2;
        Thu,  9 Dec 2021 22:11:24 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 9 Dec 2021 22:11:37 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 9 Dec 2021 22:11:37 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH for-rc] RDMA/hns: Fix RNR retransmission issue for HIP08
Date:   Thu, 9 Dec 2021 22:06:55 +0800
Message-ID: <20211209140655.49493-1-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.33.0
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

From: Yangyang Li <liyangyang20@huawei.com>

Due to the discrete nature of the HIP08 timer unit, a requester might
finish the timeout period sooner, in elapsed real time, than its responder
does, even when both sides share the identical RNR timeout length included
in the RNR Nak packet and the responder indeed starts the timing prior to
the requester. Furthermore, if a 'providential' resend packet arrived
before the responder's timeout period expired, the responder is certainly
entitled to drop the packet silently in the light of IB protocol.

To address this problem, our team made good use of certain hardware facts:
1) The timing resolution regards the transmission arrangements is 1
microsecond, e.g. if cq_period field is set to 3, it would be interpreted
as 3 microsecond by hardware;
2) A QPC field shall inform the hardware how many timing unit (ticks)
constitutes a full microsecond, which, by default, is 1000;
3) It takes 14ns for the processor to handle a packet in the buffer, so the
RNR timeout length of 10ns would ensure our processing mechanism is
disabled during the entire timeout period and the packet won't be dropped
silently;

To achieve (3), we permanently set the QPC field mentioned in (2) to zero
which nominally indicates every time tick is equivalent to a microsecond
in wall-clock time; now, a RNR timeout period at face value of 10 would
only last 10 ticks, which is 10ns in wall-clock time.

It's worth noting that we adapt the driver by magnifying certain
configuration parameters(cq_period, eq_period and ack_timeout)by 1000 given
the user assumes the configuring timing unit to be microseconds.

Also, this particular improvisation is only deployed on HIP08 since other
hardware has already solved this issue.

Fixes: cfc85f3e4b7f ("RDMA/hns: Add profile support for hip08 driver")
Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 64 +++++++++++++++++++---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  8 +++
 2 files changed, 65 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index bbfa1332dedc..eb0defa80d0d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1594,11 +1594,17 @@ static int hns_roce_config_global_param(struct hns_roce_dev *hr_dev)
 {
 	struct hns_roce_cmq_desc desc;
 	struct hns_roce_cmq_req *req = (struct hns_roce_cmq_req *)desc.data;
+	u32 clock_cycles_of_1us;
 
 	hns_roce_cmq_setup_basic_desc(&desc, HNS_ROCE_OPC_CFG_GLOBAL_PARAM,
 				      false);
 
-	hr_reg_write(req, CFG_GLOBAL_PARAM_1US_CYCLES, 0x3e8);
+	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08)
+		clock_cycles_of_1us = HNS_ROCE_1NS_CFG;
+	else
+		clock_cycles_of_1us = HNS_ROCE_1US_CFG;
+
+	hr_reg_write(req, CFG_GLOBAL_PARAM_1US_CYCLES, clock_cycles_of_1us);
 	hr_reg_write(req, CFG_GLOBAL_PARAM_UDP_PORT, ROCE_V2_UDP_DPORT);
 
 	return hns_roce_cmq_send(hr_dev, &desc, 1);
@@ -4802,6 +4808,30 @@ static int hns_roce_v2_set_abs_fields(struct ib_qp *ibqp,
 	return ret;
 }
 
+static bool check_qp_timeout_cfg_range(struct hns_roce_dev *hr_dev, u8 *timeout)
+{
+#define QP_ACK_TIMEOUT_MAX_HIP08 20
+#define QP_ACK_TIMEOUT_OFFSET 10
+#define QP_ACK_TIMEOUT_MAX 31
+
+	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08) {
+		if (*timeout > QP_ACK_TIMEOUT_MAX_HIP08) {
+			ibdev_warn(&hr_dev->ib_dev,
+				   "Local ACK timeout shall be 0 to 20.\n");
+			return false;
+		}
+		*timeout += QP_ACK_TIMEOUT_OFFSET;
+	} else if (hr_dev->pci_dev->revision > PCI_REVISION_ID_HIP08) {
+		if (*timeout > QP_ACK_TIMEOUT_MAX) {
+			ibdev_warn(&hr_dev->ib_dev,
+				   "Local ACK timeout shall be 0 to 31.\n");
+			return false;
+		}
+	}
+
+	return true;
+}
+
 static int hns_roce_v2_set_opt_fields(struct ib_qp *ibqp,
 				      const struct ib_qp_attr *attr,
 				      int attr_mask,
@@ -4811,6 +4841,7 @@ static int hns_roce_v2_set_opt_fields(struct ib_qp *ibqp,
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
 	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
 	int ret = 0;
+	u8 timeout;
 
 	if (attr_mask & IB_QP_AV) {
 		ret = hns_roce_v2_set_path(ibqp, attr, attr_mask, context,
@@ -4820,12 +4851,10 @@ static int hns_roce_v2_set_opt_fields(struct ib_qp *ibqp,
 	}
 
 	if (attr_mask & IB_QP_TIMEOUT) {
-		if (attr->timeout < 31) {
-			hr_reg_write(context, QPC_AT, attr->timeout);
+		timeout = attr->timeout;
+		if (check_qp_timeout_cfg_range(hr_dev, &timeout)) {
+			hr_reg_write(context, QPC_AT, timeout);
 			hr_reg_clear(qpc_mask, QPC_AT);
-		} else {
-			ibdev_warn(&hr_dev->ib_dev,
-				   "Local ACK timeout shall be 0 to 30.\n");
 		}
 	}
 
@@ -4882,7 +4911,9 @@ static int hns_roce_v2_set_opt_fields(struct ib_qp *ibqp,
 		set_access_flags(hr_qp, context, qpc_mask, attr, attr_mask);
 
 	if (attr_mask & IB_QP_MIN_RNR_TIMER) {
-		hr_reg_write(context, QPC_MIN_RNR_TIME, attr->min_rnr_timer);
+		hr_reg_write(context, QPC_MIN_RNR_TIME,
+			    hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08 ?
+			    HNS_ROCE_RNR_TIMER_10NS : attr->min_rnr_timer);
 		hr_reg_clear(qpc_mask, QPC_MIN_RNR_TIME);
 	}
 
@@ -5499,6 +5530,16 @@ static int hns_roce_v2_modify_cq(struct ib_cq *cq, u16 cq_count, u16 cq_period)
 
 	hr_reg_write(cq_context, CQC_CQ_MAX_CNT, cq_count);
 	hr_reg_clear(cqc_mask, CQC_CQ_MAX_CNT);
+
+	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08) {
+		if (cq_period * HNS_ROCE_CLOCK_ADJUST > USHRT_MAX) {
+			dev_info(hr_dev->dev,
+				 "cq_period(%u) reached the upper limit, adjusted to 65.\n",
+				 cq_period);
+			cq_period = HNS_ROCE_MAX_CQ_PERIOD;
+		}
+		cq_period *= HNS_ROCE_CLOCK_ADJUST;
+	}
 	hr_reg_write(cq_context, CQC_CQ_PERIOD, cq_period);
 	hr_reg_clear(cqc_mask, CQC_CQ_PERIOD);
 
@@ -5894,6 +5935,15 @@ static int config_eqc(struct hns_roce_dev *hr_dev, struct hns_roce_eq *eq,
 	hr_reg_write(eqc, EQC_EQ_PROD_INDX, HNS_ROCE_EQ_INIT_PROD_IDX);
 	hr_reg_write(eqc, EQC_EQ_MAX_CNT, eq->eq_max_cnt);
 
+	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08) {
+		if (eq->eq_period * HNS_ROCE_CLOCK_ADJUST > USHRT_MAX) {
+			dev_info(hr_dev->dev, "eq_period(%u) reached the upper limit, adjusted to 65.\n",
+				 eq->eq_period);
+			eq->eq_period = HNS_ROCE_MAX_EQ_PERIOD;
+		}
+		eq->eq_period *= HNS_ROCE_CLOCK_ADJUST;
+	}
+
 	hr_reg_write(eqc, EQC_EQ_PERIOD, eq->eq_period);
 	hr_reg_write(eqc, EQC_EQE_REPORT_TIMER, HNS_ROCE_EQ_INIT_REPORT_TIMER);
 	hr_reg_write(eqc, EQC_EQE_BA_L, bt_ba >> 3);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 4d904d5e82be..35c61da7ba15 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -1444,6 +1444,14 @@ struct hns_roce_dip {
 	struct list_head node;	/* all dips are on a list */
 };
 
+/* only for RNR timeout issue of HIP08 */
+#define HNS_ROCE_CLOCK_ADJUST 1000
+#define HNS_ROCE_MAX_CQ_PERIOD 65
+#define HNS_ROCE_MAX_EQ_PERIOD 65
+#define HNS_ROCE_RNR_TIMER_10NS 1
+#define HNS_ROCE_1US_CFG 999
+#define HNS_ROCE_1NS_CFG 0
+
 #define HNS_ROCE_AEQ_DEFAULT_BURST_NUM	0x0
 #define HNS_ROCE_AEQ_DEFAULT_INTERVAL	0x0
 #define HNS_ROCE_CEQ_DEFAULT_BURST_NUM	0x0
-- 
2.33.0

