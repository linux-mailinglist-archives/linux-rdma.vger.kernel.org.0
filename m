Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAC73DA461
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jul 2021 15:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237531AbhG2Nbn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Jul 2021 09:31:43 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:13280 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237459AbhG2Nbn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 29 Jul 2021 09:31:43 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16TDVRjM017290;
        Thu, 29 Jul 2021 06:31:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=ysg19J8VxKEqoAhoR1M+e9B1bXKul3bcd7+/gfnPKYM=;
 b=fyljLWchuUO39kZ6LJxbC2vZlSbLwM3c7orL7O/o/4rwYrjWsVddiWrGoVZnUruPkTr+
 aSGf/OVqdcdxkUD3N3+n+Ly5C/372h+KMoUVOXJNiCdc7hR8OBGumk5y0WTMHImaLheq
 URJopmpZdQbO7c99uQ088I6BdBHZFkco8ye2Aq7LjdJXKM6ny0I2fpwZae4/qCDJIlLV
 VHfIltTM6BJxCq3dv50x+HQtTSKTeES1yaWqW+GPsCGrE7tiMz5sg7EfSZTPbBrHccwT
 9cMtTA+Cp3hBHVpWsia2UR31JnSUwbPZyGgdnLpdYT7C+wC5w1yIoBTxS0u0Pfzc5Ljf CQ== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 3a35pr4yua-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 29 Jul 2021 06:31:33 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 29 Jul
 2021 06:30:45 -0700
Received: from lbtlvb-pcie154.il.qlogic.org (10.69.176.80) by
 DC5-EXCH01.marvell.com (10.69.176.38) with Microsoft SMTP Server id
 15.0.1497.18 via Frontend Transport; Thu, 29 Jul 2021 06:30:42 -0700
From:   Shai Malin <smalin@marvell.com>
To:     <linux-rdma@vger.kernel.org>, <dledford@redhat.com>,
        <jgg@nvidia.com>, <mkalderon@marvell.com>
CC:     <davem@davemloft.net>, <kuba@kernel.org>, <smalin@marvell.com>,
        <aelior@marvell.com>, <pkushwaha@marvell.com>,
        <prabhakar.pkin@gmail.com>, <malin1024@gmail.com>
Subject: [PATCH for-next 2/3] qedr: Consider dscp priority for vlan priority
Date:   Thu, 29 Jul 2021 16:30:31 +0300
Message-ID: <20210729133032.26278-3-smalin@marvell.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20210729133032.26278-1-smalin@marvell.com>
References: <20210729133032.26278-1-smalin@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 8CebflyCZj_bGiLcf80yqeSPYoJvkuHx
X-Proofpoint-GUID: 8CebflyCZj_bGiLcf80yqeSPYoJvkuHx
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-29_10:2021-07-29,2021-07-29 signatures=0
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Prabhakar Kushwaha <pkushwaha@marvell.com>

if dscp is enabled, consider its priority while deciding
vlan priority.

Signed-off-by: Shai Malin <smalin@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
---
 drivers/infiniband/hw/qedr/qedr_roce_cm.c  | 11 +++++++++-
 drivers/net/ethernet/qlogic/qed/qed_dcbx.c |  7 ++++++
 drivers/net/ethernet/qlogic/qed/qed_dcbx.h |  5 +++--
 drivers/net/ethernet/qlogic/qed/qed_rdma.c | 25 ++++++++++++++++++++++
 include/linux/qed/qed_rdma_if.h            |  7 ++++++
 5 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/qedr/qedr_roce_cm.c b/drivers/infiniband/hw/qedr/qedr_roce_cm.c
index 13e5e6bbec99..eb7d24742664 100644
--- a/drivers/infiniband/hw/qedr/qedr_roce_cm.c
+++ b/drivers/infiniband/hw/qedr/qedr_roce_cm.c
@@ -389,6 +389,7 @@ static inline int qedr_gsi_build_header(struct qedr_dev *dev,
 	const struct ib_global_route *grh = rdma_ah_read_grh(ah_attr);
 	const struct ib_gid_attr *sgid_attr = grh->sgid_attr;
 	int send_size = 0;
+	u8 vlan_pri, dscp;
 	u16 vlan_id = 0;
 	u16 ether_type;
 	int rc;
@@ -437,8 +438,16 @@ static inline int qedr_gsi_build_header(struct qedr_dev *dev,
 	ether_addr_copy(udh->eth.dmac_h, ah_attr->roce.dmac);
 	ether_addr_copy(udh->eth.smac_h, dev->ndev->dev_addr);
 	if (has_vlan) {
-		udh->eth.type = htons(ETH_P_8021Q);
+		dscp = GET_FIELD(grh->traffic_class, QED_RDMA_TC_TOS_DSCP);
+
+		/* get the vlan priority associated with the dscp value */
+		if (!dev->ops->rdma_get_dscp_priority(dev->rdma_ctx, dscp,
+						      &vlan_pri))
+			vlan_id |= vlan_pri << VLAN_PRIO_SHIFT;
+
 		udh->vlan.tag = htons(vlan_id);
+
+		udh->eth.type = htons(ETH_P_8021Q);
 		udh->vlan.type = htons(ether_type);
 	} else {
 		udh->eth.type = htons(ether_type);
diff --git a/drivers/net/ethernet/qlogic/qed/qed_dcbx.c b/drivers/net/ethernet/qlogic/qed/qed_dcbx.c
index ba9276599e72..cec4b890e69a 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_dcbx.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_dcbx.c
@@ -973,6 +973,13 @@ void qed_dcbx_set_pf_update_params(struct qed_dcbx_results *p_src,
 	qed_dcbx_update_protocol_data(p_dcb_data, p_src, DCBX_PROTOCOL_ETH);
 }
 
+bool qed_dcbx_get_dscp_state(struct qed_hwfn *p_hwfn)
+{
+	struct qed_dcbx_get *p_dcbx_info = &p_hwfn->p_dcbx_info->get;
+
+	return p_dcbx_info->dscp.enabled;
+}
+
 u8 qed_dcbx_get_priority_tc(struct qed_hwfn *p_hwfn, u8 pri)
 {
 	struct qed_dcbx_get *dcbx_info = &p_hwfn->p_dcbx_info->get;
diff --git a/drivers/net/ethernet/qlogic/qed/qed_dcbx.h b/drivers/net/ethernet/qlogic/qed/qed_dcbx.h
index 6d8ce9bb30bd..86a374c3ed86 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_dcbx.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_dcbx.h
@@ -102,8 +102,7 @@ void qed_dcbx_set_pf_update_params(struct qed_dcbx_results *p_src,
 				   struct pf_update_ramrod_data *p_dest);
 
 /* Returns priority value for a given dscp index */
-int qed_dcbx_get_dscp_priority(struct qed_hwfn *p_hwfn, u8 dscp_index,
-			       u8 *p_dscp_pri);
+int qed_dcbx_get_dscp_priority(struct qed_hwfn *p_hwfn, u8 dscp_index, u8 *pri);
 
 /* Sets priority value for a given dscp index */
 int qed_dcbx_set_dscp_priority(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt,
@@ -112,4 +111,6 @@ int qed_dcbx_set_dscp_priority(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt,
 #define QED_DCBX_DEFAULT_TC	0
 
 u8 qed_dcbx_get_priority_tc(struct qed_hwfn *p_hwfn, u8 pri);
+
+bool qed_dcbx_get_dscp_state(struct qed_hwfn *p_hwfn);
 #endif
diff --git a/drivers/net/ethernet/qlogic/qed/qed_rdma.c b/drivers/net/ethernet/qlogic/qed/qed_rdma.c
index da864d12916b..e904ba2e6242 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_rdma.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_rdma.c
@@ -32,6 +32,7 @@
 #include "qed_rdma.h"
 #include "qed_roce.h"
 #include "qed_sp.h"
+#include "qed_dcbx.h"
 
 
 int qed_rdma_bmap_alloc(struct qed_hwfn *p_hwfn,
@@ -1965,6 +1966,29 @@ static void qed_rdma_remove_user(void *rdma_cxt, u16 dpi)
 	spin_unlock_bh(&p_hwfn->p_rdma_info->lock);
 }
 
+#ifdef CONFIG_DCB
+static int qed_rdma_get_dscp_priority(void *rdma_cxt, u8 dscp_index, u8 *pri)
+{
+	struct qed_hwfn *p_hwfn = (struct qed_hwfn *)rdma_cxt;
+	int rc = -EINVAL;
+
+	if (qed_dcbx_get_dscp_state(p_hwfn)) {
+		rc = qed_dcbx_get_dscp_priority(p_hwfn, dscp_index, pri);
+		if (rc)
+			DP_INFO(p_hwfn,
+				"Failed to get priority val for dscp idx %d\n",
+				dscp_index);
+	}
+
+	return rc;
+}
+#else
+static int qed_rdma_get_dscp_priority(void *rdma_cxt, u8 dscp_index, u8 *pri)
+{
+	return -EINVAL;
+}
+#endif
+
 static int qed_roce_ll2_set_mac_filter(struct qed_dev *cdev,
 				       u8 *old_mac_address,
 				       u8 *new_mac_address)
@@ -2045,6 +2069,7 @@ static const struct qed_rdma_ops qed_rdma_ops_pass = {
 	.rdma_create_srq = &qed_rdma_create_srq,
 	.rdma_modify_srq = &qed_rdma_modify_srq,
 	.rdma_destroy_srq = &qed_rdma_destroy_srq,
+	.rdma_get_dscp_priority = &qed_rdma_get_dscp_priority,
 	.ll2_acquire_connection = &qed_ll2_acquire_connection,
 	.ll2_establish_connection = &qed_ll2_establish_connection,
 	.ll2_terminate_connection = &qed_ll2_terminate_connection,
diff --git a/include/linux/qed/qed_rdma_if.h b/include/linux/qed/qed_rdma_if.h
index aeb242cefebf..cd98e95ec2e3 100644
--- a/include/linux/qed/qed_rdma_if.h
+++ b/include/linux/qed/qed_rdma_if.h
@@ -363,6 +363,10 @@ struct qed_rdma_modify_qp_in_params {
 	u32 dest_qp;
 	bool lb_indication;
 	u16 mtu;
+#define QED_RDMA_TC_TOS_ECN_SHIFT 0
+#define QED_RDMA_TC_TOS_ECN_MASK 0x3
+#define QED_RDMA_TC_TOS_DSCP_SHIFT 2
+#define QED_RDMA_TC_TOS_DSCP_MASK 0x3f
 	u8 traffic_class_tos;
 	u8 hop_limit_ttl;
 	u32 flow_label;
@@ -639,6 +643,9 @@ struct qed_rdma_ops {
 	int (*rdma_modify_srq)(void *rdma_cxt,
 			       struct qed_rdma_modify_srq_in_params *iparams);
 
+	int (*rdma_get_dscp_priority)(void *rdma_cxt, u8 dscp_index,
+				      u8 *p_dscp_pri);
+
 	int (*ll2_acquire_connection)(void *rdma_cxt,
 				      struct qed_ll2_acquire_data *data);
 
-- 
2.24.1

