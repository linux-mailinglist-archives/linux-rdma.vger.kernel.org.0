Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2B203DA462
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jul 2021 15:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237539AbhG2Nbo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Jul 2021 09:31:44 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:1866 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237459AbhG2Nbo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 29 Jul 2021 09:31:44 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16TDVRjL017290;
        Thu, 29 Jul 2021 06:31:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=GJdtlvHcnYMSTM2wdlplrHS4MgWPR4A2CMsdY9OyLDI=;
 b=Onk3ar8GwAOXEs2M3Cvq/UIal8GvL0CFtd+YQ0JkbfKkSmJE6eyAWistHGmqEuz7Cqvs
 AuUeTzJeqaay8CypKCMFYoEZu4/93CFz6QkXD02EvMe9A8hWLPvpDehnvol1IfIGThT/
 7cT/iIJIaeCBEwJvCmtO2zwJKUx6v5kBzZser3jqouQkyWt8olwAyQYfTYUFjXEqx4hI
 s9A6JvskmTsTX/XRouTDpRUr7vJF/rPYAckOGh+6Q6Q3MtWVAs+6as7nBPafbbHBk56O
 Mcpg5upz85efBIjYJpTNjoYw8fSudeoZG0giKn3GiT+fP6DGRpc0vovxVQeXvepYl7WG 7w== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 3a35pr4yua-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 29 Jul 2021 06:31:32 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 29 Jul
 2021 06:30:41 -0700
Received: from lbtlvb-pcie154.il.qlogic.org (10.69.176.80) by
 DC5-EXCH01.marvell.com (10.69.176.38) with Microsoft SMTP Server id
 15.0.1497.18 via Frontend Transport; Thu, 29 Jul 2021 06:30:38 -0700
From:   Shai Malin <smalin@marvell.com>
To:     <linux-rdma@vger.kernel.org>, <dledford@redhat.com>,
        <jgg@nvidia.com>, <mkalderon@marvell.com>
CC:     <davem@davemloft.net>, <kuba@kernel.org>, <smalin@marvell.com>,
        <aelior@marvell.com>, <pkushwaha@marvell.com>,
        <prabhakar.pkin@gmail.com>, <malin1024@gmail.com>
Subject: [PATCH for-next 1/3] qed: add get and set support for dscp priority
Date:   Thu, 29 Jul 2021 16:30:30 +0300
Message-ID: <20210729133032.26278-2-smalin@marvell.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20210729133032.26278-1-smalin@marvell.com>
References: <20210729133032.26278-1-smalin@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: g0W4ZgaRSngoo1yzt2gbmAkuyL182gov
X-Proofpoint-GUID: g0W4ZgaRSngoo1yzt2gbmAkuyL182gov
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-29_10:2021-07-29,2021-07-29 signatures=0
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Prabhakar Kushwaha <pkushwaha@marvell.com>

This patch add support of get or set priority value for a given
dscp index.

Signed-off-by: Shai Malin <smalin@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
---
 drivers/net/ethernet/qlogic/qed/qed_dcbx.c | 65 ++++++++++++++++++++++
 drivers/net/ethernet/qlogic/qed/qed_dcbx.h |  9 +++
 include/linux/qed/qed_if.h                 |  6 ++
 3 files changed, 80 insertions(+)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_dcbx.c b/drivers/net/ethernet/qlogic/qed/qed_dcbx.c
index e81dd34a3cac..ba9276599e72 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_dcbx.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_dcbx.c
@@ -1280,6 +1280,71 @@ int qed_dcbx_get_config_params(struct qed_hwfn *p_hwfn,
 	return 0;
 }
 
+int qed_dcbx_get_dscp_priority(struct qed_hwfn *p_hwfn, u8 dscp_index,
+			       u8 *p_dscp_pri)
+{
+	struct qed_dcbx_get *p_dcbx_info;
+	int rc;
+
+	if (IS_VF(p_hwfn->cdev)) {
+		DP_ERR(p_hwfn->cdev,
+		       "qed rdma get dscp priority not supported for VF.\n");
+		return -EINVAL;
+	}
+
+	if (dscp_index >= QED_DCBX_DSCP_SIZE) {
+		DP_ERR(p_hwfn, "Invalid dscp index %d\n", dscp_index);
+		return -EINVAL;
+	}
+
+	p_dcbx_info = kmalloc(sizeof(*p_dcbx_info), GFP_KERNEL);
+	if (!p_dcbx_info)
+		return -ENOMEM;
+
+	memset(p_dcbx_info, 0, sizeof(*p_dcbx_info));
+	rc = qed_dcbx_query_params(p_hwfn, p_dcbx_info,
+				   QED_DCBX_OPERATIONAL_MIB);
+	if (rc) {
+		kfree(p_dcbx_info);
+		return rc;
+	}
+
+	*p_dscp_pri = p_dcbx_info->dscp.dscp_pri_map[dscp_index];
+	kfree(p_dcbx_info);
+
+	return 0;
+}
+
+int qed_dcbx_set_dscp_priority(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt,
+			       u8 dscp_index, u8 pri_val)
+{
+	struct qed_dcbx_set dcbx_set;
+	int rc;
+
+	if (IS_VF(p_hwfn->cdev)) {
+		DP_ERR(p_hwfn->cdev,
+		       "qed rdma set dscp priority not supported for VF.\n");
+		return -EINVAL;
+	}
+
+	if (dscp_index >= QED_DCBX_DSCP_SIZE ||
+	    pri_val >= QED_MAX_PFC_PRIORITIES) {
+		DP_ERR(p_hwfn, "Invalid dscp params: index = %d pri = %d\n",
+		       dscp_index, pri_val);
+		return -EINVAL;
+	}
+
+	memset(&dcbx_set, 0, sizeof(dcbx_set));
+	rc = qed_dcbx_get_config_params(p_hwfn, &dcbx_set);
+	if (rc)
+		return rc;
+
+	dcbx_set.override_flags = QED_DCBX_OVERRIDE_DSCP_CFG;
+	dcbx_set.dscp.dscp_pri_map[dscp_index] = pri_val;
+
+	return qed_dcbx_config_params(p_hwfn, p_ptt, &dcbx_set, 1);
+}
+
 static struct qed_dcbx_get *qed_dcbnl_get_dcbx(struct qed_hwfn *hwfn,
 					       enum qed_mib_read_type type)
 {
diff --git a/drivers/net/ethernet/qlogic/qed/qed_dcbx.h b/drivers/net/ethernet/qlogic/qed/qed_dcbx.h
index e1798925b444..6d8ce9bb30bd 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_dcbx.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_dcbx.h
@@ -46,6 +46,7 @@ struct qed_dcbx_set {
 	bool enabled;
 	struct qed_dcbx_admin_params config;
 	u32 ver_num;
+	struct qed_dcbx_dscp_params dscp;
 };
 
 struct qed_dcbx_results {
@@ -100,6 +101,14 @@ void qed_dcbx_info_free(struct qed_hwfn *p_hwfn);
 void qed_dcbx_set_pf_update_params(struct qed_dcbx_results *p_src,
 				   struct pf_update_ramrod_data *p_dest);
 
+/* Returns priority value for a given dscp index */
+int qed_dcbx_get_dscp_priority(struct qed_hwfn *p_hwfn, u8 dscp_index,
+			       u8 *p_dscp_pri);
+
+/* Sets priority value for a given dscp index */
+int qed_dcbx_set_dscp_priority(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt,
+			       u8 dscp_index, u8 pri_val);
+
 #define QED_DCBX_DEFAULT_TC	0
 
 u8 qed_dcbx_get_priority_tc(struct qed_hwfn *p_hwfn, u8 pri);
diff --git a/include/linux/qed/qed_if.h b/include/linux/qed/qed_if.h
index 850b98991670..f7ce9a923d7c 100644
--- a/include/linux/qed/qed_if.h
+++ b/include/linux/qed/qed_if.h
@@ -124,12 +124,18 @@ struct qed_dcbx_operational_params {
 	u32 err;
 };
 
+struct qed_dcbx_dscp_params {
+	bool enabled;
+	u8 dscp_pri_map[QED_DCBX_DSCP_SIZE];
+};
+
 struct qed_dcbx_get {
 	struct qed_dcbx_operational_params operational;
 	struct qed_dcbx_lldp_remote lldp_remote;
 	struct qed_dcbx_lldp_local lldp_local;
 	struct qed_dcbx_remote_params remote;
 	struct qed_dcbx_admin_params local;
+	struct qed_dcbx_dscp_params dscp;
 };
 
 enum qed_nvm_images {
-- 
2.24.1

