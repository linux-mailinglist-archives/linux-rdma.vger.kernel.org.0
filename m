Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB0EA3CF5FF
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jul 2021 10:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbhGTHht (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jul 2021 03:37:49 -0400
Received: from mail-bn1nam07on2080.outbound.protection.outlook.com ([40.107.212.80]:20242
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234508AbhGTHhn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Jul 2021 03:37:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FsDDjj9LXBUEEMUuybE6ZnU8PYO7Oy7xD/YovV4CwHj62xzYFGYysVHIED6pCIXIC4+Yc9dnVs9P/5gXXWStHMFKtLKDiphx8aO25gmNcyx/0h3GuUR5l2HVWW/WNTZ5hL8yCLVTiWSwzTjiw9J5sIygQP8tZFwcc2brA/PvMzFeNq4k3hHavrVqJ5qZiQWehx36y9TrxSacD/xiiWCWU2u6pUI818dpEY1LCFZvwoVvK/l7G60EtmNxDgxwYrEzrADW8kFy9OYgldy4REmVk3WXegmppB1lZvxdViLcmtZCdL2GyxHZW3niuQGQSi/vSHJd9m3lMpZ5+wmKSr/Ufw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+DJbJq5s/J942C6JDjj5QnqeyreN3DgAelYuzmO5fM=;
 b=C2N2JcVltkb1TY3TdyN51p24VlP+j5978dJRLB5BVxVQGBCBk3wJZnI8eB3rXaxkos/3AnZNoaqjPneMjDQDasckJVNZ9fB8iHai/II6xBLURvUV0Xh9L4UQwY70fx3y556mYV/os3j/Xwy8dh8hrlgLt/7s3XbekiY+bcV0Z4ZYR2x5MtoGmVoPyiWqNfpLvXrOgaCp2GdSRdbrS5kbnMZ/VjNFUe+lKWOgQ/MGV+ueeQGj9DU4J/Ufdn56dVkelETks7FdqnZYyFpvYVeta8bLkAjrpImI1QuU0yi6iIwyAy6QcTBCB67drt03/C/dJeWH/j7tO2zkJPIgw+6wjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+DJbJq5s/J942C6JDjj5QnqeyreN3DgAelYuzmO5fM=;
 b=cMFZuwNGHLqyLQJCRR9dWjiI0YyM1pPIL5zWj/K0EmwTwqLl0iq6HBtDZv4TTt4ZJ78elCLOp2EzLjNRHidErxxZjOd6KOWy39ZrSPXmaRHQSTBf+pJYWvaGLGtB8DrgKxlibvrrZ5TJ8dSHPykpSubozgaF8/6PnwsoB8vH2y09mT6yW+VcKJny5guEXJoS41TBaEhpV2I3ejXquvystYtH5+HeZqB7XnPh/jcUrG+FH1vIsxO3FpEl7XZCta9oqI/xYt0xE4VdgtG4ifuvZnyfKmahEf0qQoiADr9hMD3nqBKQAAG6g1XsEZ1kL7OpxBDeCwGrBwTQ2qdrOFugdg==
Received: from MWHPR22CA0062.namprd22.prod.outlook.com (2603:10b6:300:12a::24)
 by MN2PR12MB3821.namprd12.prod.outlook.com (2603:10b6:208:16f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Tue, 20 Jul
 2021 08:18:06 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12a:cafe::35) by MWHPR22CA0062.outlook.office365.com
 (2603:10b6:300:12a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend
 Transport; Tue, 20 Jul 2021 08:18:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 08:18:06 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 20 Jul
 2021 08:18:03 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 20 Jul
 2021 08:18:02 +0000
Received: from vdi.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 20 Jul 2021 01:18:00 -0700
From:   Yishai Hadas <yishaih@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@nvidia.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
        <markzhang@nvidia.com>, <edwards@nvidia.com>
Subject: [PATCH rdma-core 15/27] mlx5: Set DV context ops
Date:   Tue, 20 Jul 2021 11:16:35 +0300
Message-ID: <20210720081647.1980-16-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210720081647.1980-1-yishaih@nvidia.com>
References: <20210720081647.1980-1-yishaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fefca204-b0b2-472d-627f-08d94b56e6f5
X-MS-TrafficTypeDiagnostic: MN2PR12MB3821:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3821E6961F29B2D51FCECF08C3E29@MN2PR12MB3821.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zf3cC8/4RcSS6vZc9erAHc2eFQmtmBRbqhLiTHTkdsVVCf0F03OYO7Vor42lJJd/Gz29dH9NyB9nnkJrgsAF2+l7PWo4j15G9az3yU2+sJRmL9T2Gq7oupXEylpLaa5pCf9Jc+9z0FY0ctRel9jzMXS/5lE087JMcJ/nCVq0oXJJdbVuN5JbjwyP+Na5/EKGukB1EFm3aCjVR5mmaC3UF+4jR81Wehqqj++rFXuLupd21syySG2T96jmNv9zmENsfSfGEycIisXO/IAFKn1tlhMLQyF7Q1R/kWD39qsiD/85QX3EBwylmE9GakKKzxh/Duk+cSxhj/hY31A3vcTF1fRHihXWNCa/i67/RyWGFYStpFxnkeoPM8j19fx3wyQRl7MhDQdMHHPXh+fMRExs8CuC+Pq/1fvNKDMejd/yiqEpaQNHkA7phkxGSI14xT/6IglipaBXZBeSa1pkFhEnNgeolMz6UwtuLLdbDKjtPGtlJM9FGQvGDl8Wmdhl/zPI1KizaXyjBE5iW6EEkBcI8Y5a+tGYQobQUPIWq5RwC2lIhaiJM2Z7hOjZU/4n9lk8Q6ofZua5HoMirHx5lGlRL9uRlXq9a7MepCHjV4HeG/UJhamdT6lEbhcBew9fEuS90aJInzmEVy1L7lPAm59oM/LwzABAcITzuWHzUmMvx7dhXpR0e7UA8CwGSo5cc2TuXNyUnFCj7n74QR6BPq2rzA==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(39860400002)(376002)(46966006)(36840700001)(186003)(4326008)(82740400003)(82310400003)(8936002)(7696005)(6916009)(36860700001)(70206006)(478600001)(36756003)(2906002)(5660300002)(30864003)(7636003)(6666004)(1076003)(426003)(336012)(2616005)(356005)(107886003)(70586007)(83380400001)(36906005)(26005)(316002)(8676002)(47076005)(54906003)(86362001)(559001)(579004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 08:18:06.2708
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fefca204-b0b2-472d-627f-08d94b56e6f5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3821
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Zhang <markzhang@nvidia.com>

Wrap DV APIs and call the matching function pointer if supported.
This comes to handle both rdma and vfio flows.

Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
---
 providers/mlx5/dr_rule.c   |  10 +-
 providers/mlx5/mlx5.c      | 344 ++++++++++++----
 providers/mlx5/mlx5.h      | 180 ++++++++-
 providers/mlx5/mlx5_vfio.c |  27 ++
 providers/mlx5/mlx5_vfio.h |   1 +
 providers/mlx5/verbs.c     | 966 +++++++++++++++++++++++++++++++++++++--------
 6 files changed, 1287 insertions(+), 241 deletions(-)

diff --git a/providers/mlx5/dr_rule.c b/providers/mlx5/dr_rule.c
index f763399..6291685 100644
--- a/providers/mlx5/dr_rule.c
+++ b/providers/mlx5/dr_rule.c
@@ -1341,11 +1341,11 @@ dr_rule_create_rule_root(struct mlx5dv_dr_matcher *matcher,
 	if (ret)
 		goto free_attr_aux;
 
-	rule->flow = __mlx5dv_create_flow(matcher->dv_matcher,
-					  value,
-					  num_actions,
-					  attr,
-					  attr_aux);
+	rule->flow = _mlx5dv_create_flow(matcher->dv_matcher,
+					 value,
+					 num_actions,
+					 attr,
+					 attr_aux);
 	if (!rule->flow)
 		goto remove_action_members;
 
diff --git a/providers/mlx5/mlx5.c b/providers/mlx5/mlx5.c
index 1abaa8c..963581a 100644
--- a/providers/mlx5/mlx5.c
+++ b/providers/mlx5/mlx5.c
@@ -50,8 +50,10 @@
 #include "mlx5-abi.h"
 #include "wqe.h"
 #include "mlx5_ifc.h"
+#include "mlx5_vfio.h"
 
 static void mlx5_free_context(struct ibv_context *ibctx);
+static bool is_mlx5_dev(struct ibv_device *device);
 
 #ifndef CPU_OR
 #define CPU_OR(x, y, z) do {} while (0)
@@ -819,15 +821,12 @@ static uint32_t get_dc_odp_caps(struct ibv_context *ctx)
 	return ret;
 }
 
-int mlx5dv_query_device(struct ibv_context *ctx_in,
-			 struct mlx5dv_context *attrs_out)
+static int _mlx5dv_query_device(struct ibv_context *ctx_in,
+				struct mlx5dv_context *attrs_out)
 {
 	struct mlx5_context *mctx = to_mctx(ctx_in);
 	uint64_t comp_mask_out = 0;
 
-	if (!is_mlx5_dev(ctx_in->device))
-		return EOPNOTSUPP;
-
 	attrs_out->version   = 0;
 	attrs_out->flags     = 0;
 
@@ -921,15 +920,23 @@ int mlx5dv_query_device(struct ibv_context *ctx_in,
 	return 0;
 }
 
+int mlx5dv_query_device(struct ibv_context *ctx_in,
+			struct mlx5dv_context *attrs_out)
+{
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(ctx_in);
+
+	if (!dvops || !dvops->query_device)
+		return EOPNOTSUPP;
+
+	return dvops->query_device(ctx_in, attrs_out);
+}
+
 static int mlx5dv_get_qp(struct ibv_qp *qp_in,
 			 struct mlx5dv_qp *qp_out)
 {
 	struct mlx5_qp *mqp = to_mqp(qp_in);
 	uint64_t mask_out = 0;
 
-	if (!is_mlx5_dev(qp_in->context->device))
-		return EOPNOTSUPP;
-
 	qp_out->dbrec     = mqp->db;
 
 	if (mqp->sq_buf_size)
@@ -980,9 +987,6 @@ static int mlx5dv_get_cq(struct ibv_cq *cq_in,
 	struct mlx5_cq *mcq = to_mcq(cq_in);
 	struct mlx5_context *mctx = to_mctx(cq_in->context);
 
-	if (!is_mlx5_dev(cq_in->context->device))
-		return EOPNOTSUPP;
-
 	cq_out->comp_mask = 0;
 	cq_out->cqn       = mcq->cqn;
 	cq_out->cqe_cnt   = mcq->verbs_cq.cq.cqe + 1;
@@ -1001,9 +1005,6 @@ static int mlx5dv_get_rwq(struct ibv_wq *wq_in,
 {
 	struct mlx5_rwq *mrwq = to_mrwq(wq_in);
 
-	if (!is_mlx5_dev(wq_in->context->device))
-		return EOPNOTSUPP;
-
 	rwq_out->comp_mask = 0;
 	rwq_out->buf       = mrwq->pbuff;
 	rwq_out->dbrec     = mrwq->recv_db;
@@ -1019,9 +1020,6 @@ static int mlx5dv_get_srq(struct ibv_srq *srq_in,
 	struct mlx5_srq *msrq;
 	uint64_t mask_out = 0;
 
-	if (!is_mlx5_dev(srq_in->context->device))
-		return EOPNOTSUPP;
-
 	msrq = container_of(srq_in, struct mlx5_srq, vsrq.srq);
 
 	srq_out->buf       = msrq->buf.buf;
@@ -1045,9 +1043,6 @@ static int mlx5dv_get_dm(struct ibv_dm *dm_in,
 	struct mlx5_dm *mdm = to_mdm(dm_in);
 	uint64_t mask_out = 0;
 
-	if (!is_mlx5_dev(dm_in->context->device))
-		return EOPNOTSUPP;
-
 	dm_out->buf       = mdm->start_va;
 	dm_out->length    = mdm->length;
 
@@ -1066,9 +1061,6 @@ static int mlx5dv_get_av(struct ibv_ah *ah_in,
 {
 	struct mlx5_ah *mah = to_mah(ah_in);
 
-	if (!is_mlx5_dev(ah_in->context->device))
-		return EOPNOTSUPP;
-
 	ah_out->comp_mask = 0;
 	ah_out->av	  = &mah->av;
 
@@ -1080,9 +1072,6 @@ static int mlx5dv_get_pd(struct ibv_pd *pd_in,
 {
 	struct mlx5_pd *mpd = to_mpd(pd_in);
 
-	if (!is_mlx5_dev(pd_in->context->device))
-		return EOPNOTSUPP;
-
 	pd_out->comp_mask = 0;
 	pd_out->pdn = mpd->pdn;
 
@@ -1119,8 +1108,7 @@ static bool lag_operation_supported(struct ibv_qp *qp)
 	struct mlx5_context *mctx = to_mctx(qp->context);
 	struct mlx5_qp *mqp = to_mqp(qp);
 
-	if (!is_mlx5_dev(qp->context->device) ||
-	    (mctx->entropy_caps.num_lag_ports <= 1))
+	if (mctx->entropy_caps.num_lag_ports <= 1)
 		return false;
 
 	if ((qp->qp_type == IBV_QPT_RC) ||
@@ -1136,8 +1124,8 @@ static bool lag_operation_supported(struct ibv_qp *qp)
 }
 
 
-int mlx5dv_query_qp_lag_port(struct ibv_qp *qp, uint8_t *port_num,
-			     uint8_t *active_port_num)
+static int _mlx5dv_query_qp_lag_port(struct ibv_qp *qp, uint8_t *port_num,
+				     uint8_t *active_port_num)
 {
 	uint8_t lag_state, tx_remap_affinity_1, tx_remap_affinity_2;
 	uint32_t in_tis[DEVX_ST_SZ_DW(query_tis_in)] = {};
@@ -1201,6 +1189,18 @@ int mlx5dv_query_qp_lag_port(struct ibv_qp *qp, uint8_t *port_num,
 	return 0;
 }
 
+int mlx5dv_query_qp_lag_port(struct ibv_qp *qp, uint8_t *port_num,
+			     uint8_t *active_port_num)
+{
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(qp->context);
+
+	if (!dvops || !dvops->query_qp_lag_port)
+		return EOPNOTSUPP;
+
+	return dvops->query_qp_lag_port(qp, port_num,
+					active_port_num);
+}
+
 static int modify_tis_lag_port(struct ibv_qp *qp, uint8_t port_num)
 {
 	uint32_t out[DEVX_ST_SZ_DW(modify_tis_out)] = {};
@@ -1232,7 +1232,7 @@ static int modify_qp_lag_port(struct ibv_qp *qp, uint8_t port_num)
 	return mlx5dv_devx_qp_modify(qp, in, sizeof(in), out, sizeof(out));
 }
 
-int mlx5dv_modify_qp_lag_port(struct ibv_qp *qp, uint8_t port_num)
+static int _mlx5dv_modify_qp_lag_port(struct ibv_qp *qp, uint8_t port_num)
 {
 	uint8_t curr_configured, curr_active;
 	struct mlx5_qp *mqp = to_mqp(qp);
@@ -1263,15 +1263,23 @@ int mlx5dv_modify_qp_lag_port(struct ibv_qp *qp, uint8_t port_num)
 	}
 }
 
-int mlx5dv_modify_qp_udp_sport(struct ibv_qp *qp, uint16_t udp_sport)
+int mlx5dv_modify_qp_lag_port(struct ibv_qp *qp, uint8_t port_num)
+{
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(qp->context);
+
+	if (!dvops || !dvops->modify_qp_lag_port)
+		return EOPNOTSUPP;
+
+	return dvops->modify_qp_lag_port(qp, port_num);
+
+}
+
+static int _mlx5dv_modify_qp_udp_sport(struct ibv_qp *qp, uint16_t udp_sport)
 {
 	uint32_t in[DEVX_ST_SZ_DW(rts2rts_qp_in)] = {};
 	uint32_t out[DEVX_ST_SZ_DW(rts2rts_qp_out)] = {};
 	struct mlx5_context *mctx = to_mctx(qp->context);
 
-	if (!is_mlx5_dev(qp->context->device))
-		return EOPNOTSUPP;
-
 	switch (qp->qp_type) {
 	case IBV_QPT_RC:
 	case IBV_QPT_UC:
@@ -1293,6 +1301,16 @@ int mlx5dv_modify_qp_udp_sport(struct ibv_qp *qp, uint16_t udp_sport)
 				     sizeof(out));
 }
 
+int mlx5dv_modify_qp_udp_sport(struct ibv_qp *qp, uint16_t udp_sport)
+{
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(qp->context);
+
+	if (!dvops || !dvops->modify_qp_udp_sport)
+		return EOPNOTSUPP;
+
+	return dvops->modify_qp_udp_sport(qp, udp_sport);
+}
+
 static bool sched_supported(struct ibv_context *ctx)
 {
 	struct mlx5_qos_caps *qc = &to_mctx(ctx)->qos_caps;
@@ -1412,18 +1430,13 @@ static bool sched_attr_valid(const struct mlx5dv_sched_attr *attr, bool node)
 	return true;
 }
 
-struct mlx5dv_sched_node *
-mlx5dv_sched_node_create(struct ibv_context *ctx,
-			 const struct mlx5dv_sched_attr *attr)
+static struct mlx5dv_sched_node *
+_mlx5dv_sched_node_create(struct ibv_context *ctx,
+			   const struct mlx5dv_sched_attr *attr)
 {
 	struct mlx5dv_sched_node *node;
 	struct mlx5dv_devx_obj *obj;
 
-	if (!is_mlx5_dev(ctx->device)) {
-		errno = EOPNOTSUPP;
-		return NULL;
-	}
-
 	if (!sched_attr_valid(attr, true)) {
 		errno = EINVAL;
 		return NULL;
@@ -1453,10 +1466,24 @@ err_sched_nic_create:
 	return NULL;
 }
 
-struct mlx5dv_sched_leaf *
-mlx5dv_sched_leaf_create(struct ibv_context *ctx,
+struct mlx5dv_sched_node *
+mlx5dv_sched_node_create(struct ibv_context *ctx,
 			 const struct mlx5dv_sched_attr *attr)
 {
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(ctx);
+
+	if (!dvops || !dvops->sched_node_create) {
+		errno = EOPNOTSUPP;
+		return NULL;
+	}
+
+	return dvops->sched_node_create(ctx, attr);
+}
+
+static struct mlx5dv_sched_leaf *
+_mlx5dv_sched_leaf_create(struct ibv_context *ctx,
+			   const struct mlx5dv_sched_attr *attr)
+{
 	struct mlx5dv_sched_leaf *leaf;
 	struct mlx5dv_devx_obj *obj;
 
@@ -1490,8 +1517,22 @@ err_sched_nic_create:
 	return NULL;
 }
 
-int mlx5dv_sched_node_modify(struct mlx5dv_sched_node *node,
-			     const struct mlx5dv_sched_attr *attr)
+struct mlx5dv_sched_leaf *
+mlx5dv_sched_leaf_create(struct ibv_context *ctx,
+			 const struct mlx5dv_sched_attr *attr)
+{
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(ctx);
+
+	if (!dvops || !dvops->sched_leaf_create) {
+		errno = EOPNOTSUPP;
+		return NULL;
+	}
+
+	return dvops->sched_leaf_create(ctx, attr);
+}
+
+static int _mlx5dv_sched_node_modify(struct mlx5dv_sched_node *node,
+				     const struct mlx5dv_sched_attr *attr)
 {
 	if (!node || !sched_attr_valid(attr, true)) {
 		errno = EINVAL;
@@ -1507,9 +1548,20 @@ int mlx5dv_sched_node_modify(struct mlx5dv_sched_node *node,
 				       MLX5_SCHED_ELEM_TYPE_TSAR);
 }
 
-int mlx5dv_sched_leaf_modify(struct mlx5dv_sched_leaf *leaf,
+int mlx5dv_sched_node_modify(struct mlx5dv_sched_node *node,
 			     const struct mlx5dv_sched_attr *attr)
 {
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(node->obj->context);
+
+	if (!dvops || !dvops->sched_node_modify)
+		return EOPNOTSUPP;
+
+	return dvops->sched_node_modify(node, attr);
+}
+
+static int _mlx5dv_sched_leaf_modify(struct mlx5dv_sched_leaf *leaf,
+				     const struct mlx5dv_sched_attr *attr)
+{
 	if (!leaf || !sched_attr_valid(attr, false)) {
 		errno = EINVAL;
 		return errno;
@@ -1524,7 +1576,18 @@ int mlx5dv_sched_leaf_modify(struct mlx5dv_sched_leaf *leaf,
 				       MLX5_SCHED_ELEM_TYPE_QUEUE_GROUP);
 }
 
-int mlx5dv_sched_node_destroy(struct mlx5dv_sched_node *node)
+int mlx5dv_sched_leaf_modify(struct mlx5dv_sched_leaf *leaf,
+			     const struct mlx5dv_sched_attr *attr)
+{
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(leaf->obj->context);
+
+	if (!dvops || !dvops->sched_leaf_modify)
+		return EOPNOTSUPP;
+
+	return dvops->sched_leaf_modify(leaf, attr);
+}
+
+static int _mlx5dv_sched_node_destroy(struct mlx5dv_sched_node *node)
 {
 	int ret;
 
@@ -1536,7 +1599,17 @@ int mlx5dv_sched_node_destroy(struct mlx5dv_sched_node *node)
 	return 0;
 }
 
-int mlx5dv_sched_leaf_destroy(struct mlx5dv_sched_leaf *leaf)
+int mlx5dv_sched_node_destroy(struct mlx5dv_sched_node *node)
+{
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(node->obj->context);
+
+	if (!dvops || !dvops->sched_node_destroy)
+		return EOPNOTSUPP;
+
+	return dvops->sched_node_destroy(node);
+}
+
+static int _mlx5dv_sched_leaf_destroy(struct mlx5dv_sched_leaf *leaf)
 {
 	int ret;
 
@@ -1548,6 +1621,16 @@ int mlx5dv_sched_leaf_destroy(struct mlx5dv_sched_leaf *leaf)
 	return 0;
 }
 
+int mlx5dv_sched_leaf_destroy(struct mlx5dv_sched_leaf *leaf)
+{
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(leaf->obj->context);
+
+	if (!dvops || !dvops->sched_leaf_destroy)
+		return EOPNOTSUPP;
+
+	return dvops->sched_leaf_destroy(leaf);
+}
+
 static int modify_ib_qp_sched_elem_init(struct ibv_qp *qp,
 					uint32_t req_id, uint32_t resp_id)
 {
@@ -1630,9 +1713,9 @@ static int modify_raw_qp_sched_elem(struct ibv_qp *qp, uint32_t qos_id)
 	return mlx5dv_devx_qp_modify(qp, min, sizeof(min), mout, sizeof(mout));
 }
 
-int mlx5dv_modify_qp_sched_elem(struct ibv_qp *qp,
-				const struct mlx5dv_sched_leaf *requestor,
-				const struct mlx5dv_sched_leaf *responder)
+static int _mlx5dv_modify_qp_sched_elem(struct ibv_qp *qp,
+					const struct mlx5dv_sched_leaf *requestor,
+					const struct mlx5dv_sched_leaf *responder)
 {
 	struct mlx5_qos_caps *qc = &to_mctx(qp->context)->qos_caps;
 
@@ -1659,6 +1742,18 @@ int mlx5dv_modify_qp_sched_elem(struct ibv_qp *qp,
 	}
 }
 
+int mlx5dv_modify_qp_sched_elem(struct ibv_qp *qp,
+				const struct mlx5dv_sched_leaf *requestor,
+				const struct mlx5dv_sched_leaf *responder)
+{
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(qp->context);
+
+	if (!dvops || !dvops->modify_qp_sched_elem)
+		return EOPNOTSUPP;
+
+	return dvops->modify_qp_sched_elem(qp, requestor, responder);
+}
+
 int mlx5_modify_qp_drain_sigerr(struct ibv_qp *qp)
 {
 	uint64_t mask = MLX5_QPC_OPT_MASK_INIT2INIT_DRAIN_SIGERR;
@@ -1750,15 +1845,14 @@ static void reserved_qpn_blks_free(struct mlx5_context *mctx)
  * always starts from last allocation position, to make sure the QPN
  * always move forward to prevent stale QPN.
  */
-int mlx5dv_reserved_qpn_alloc(struct ibv_context *ctx, uint32_t *qpn)
+static int _mlx5dv_reserved_qpn_alloc(struct ibv_context *ctx, uint32_t *qpn)
 {
 	struct mlx5_context *mctx = to_mctx(ctx);
 	struct reserved_qpn_blk *blk;
 	uint32_t qpns_per_obj;
 	int ret = 0;
 
-	if (!is_mlx5_dev(ctx->device) ||
-	    !(mctx->general_obj_types_caps & (1ULL << MLX5_OBJ_TYPE_RESERVED_QPN)))
+	if (!(mctx->general_obj_types_caps & (1ULL << MLX5_OBJ_TYPE_RESERVED_QPN)))
 		return EOPNOTSUPP;
 
 	qpns_per_obj = 1 << mctx->hca_cap_2_caps.log_reserved_qpns_per_obj;
@@ -1786,11 +1880,21 @@ end:
 	return ret;
 }
 
+int mlx5dv_reserved_qpn_alloc(struct ibv_context *ctx, uint32_t *qpn)
+{
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(ctx);
+
+	if (!dvops || !dvops->reserved_qpn_alloc)
+		return EOPNOTSUPP;
+
+	return dvops->reserved_qpn_alloc(ctx, qpn);
+}
+
 /**
  * Deallocate a reserved QPN. The FW object is destroyed only when all QPNs
  * in this object were used and freed.
  */
-int mlx5dv_reserved_qpn_dealloc(struct ibv_context *ctx, uint32_t qpn)
+static int _mlx5dv_reserved_qpn_dealloc(struct ibv_context *ctx, uint32_t qpn)
 {
 	struct mlx5_context *mctx = to_mctx(ctx);
 	struct reserved_qpn_blk *blk, *tmp;
@@ -1829,9 +1933,17 @@ end:
 	return ret;
 }
 
-LATEST_SYMVER_FUNC(mlx5dv_init_obj, 1_2, "MLX5_1.2",
-		   int,
-		   struct mlx5dv_obj *obj, uint64_t obj_type)
+int mlx5dv_reserved_qpn_dealloc(struct ibv_context *ctx, uint32_t qpn)
+{
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(ctx);
+
+	if (!dvops || !dvops->reserved_qpn_dealloc)
+		return EOPNOTSUPP;
+
+	return dvops->reserved_qpn_dealloc(ctx, qpn);
+}
+
+static int _mlx5dv_init_obj(struct mlx5dv_obj *obj, uint64_t obj_type)
 {
 	int ret = 0;
 
@@ -1853,6 +1965,46 @@ LATEST_SYMVER_FUNC(mlx5dv_init_obj, 1_2, "MLX5_1.2",
 	return ret;
 }
 
+static struct ibv_context *
+get_context_from_obj(struct mlx5dv_obj *obj, uint64_t obj_type)
+{
+	if (obj_type & MLX5DV_OBJ_QP)
+		return obj->qp.in->context;
+	if (obj_type & MLX5DV_OBJ_CQ)
+		return obj->cq.in->context;
+	if (obj_type & MLX5DV_OBJ_SRQ)
+		return obj->srq.in->context;
+	if (obj_type & MLX5DV_OBJ_RWQ)
+		return obj->rwq.in->context;
+	if (obj_type & MLX5DV_OBJ_DM)
+		return obj->dm.in->context;
+	if (obj_type & MLX5DV_OBJ_AH)
+		return obj->ah.in->context;
+	if (obj_type & MLX5DV_OBJ_PD)
+		return obj->pd.in->context;
+
+	return NULL;
+}
+
+LATEST_SYMVER_FUNC(mlx5dv_init_obj, 1_2, "MLX5_1.2",
+		   int,
+		   struct mlx5dv_obj *obj, uint64_t obj_type)
+{
+	struct mlx5_dv_context_ops *dvops;
+	struct ibv_context *ctx;
+
+	ctx = get_context_from_obj(obj, obj_type);
+	if (!ctx)
+		return EINVAL;
+
+	dvops = mlx5_get_dv_ops(ctx);
+
+	if (!dvops || !dvops->init_obj)
+		return EOPNOTSUPP;
+
+	return dvops->init_obj(obj, obj_type);
+}
+
 COMPAT_SYMVER_FUNC(mlx5dv_init_obj, 1_0, "MLX5_1.0",
 		   int,
 		   struct mlx5dv_obj *obj, uint64_t obj_type)
@@ -1922,14 +2074,12 @@ out:
 	return uar->reg;
 }
 
-int mlx5dv_set_context_attr(struct ibv_context *ibv_ctx,
-			enum mlx5dv_set_ctx_attr_type type, void *attr)
+static int _mlx5dv_set_context_attr(struct ibv_context *ibv_ctx,
+				    enum mlx5dv_set_ctx_attr_type type,
+				    void *attr)
 {
 	struct mlx5_context *ctx = to_mctx(ibv_ctx);
 
-	if (!is_mlx5_dev(ibv_ctx->device))
-		return EOPNOTSUPP;
-
 	switch (type) {
 	case MLX5DV_CTX_ATTR_BUF_ALLOCATORS:
 		ctx->extern_alloc = *((struct mlx5dv_ctx_allocators *)attr);
@@ -1941,8 +2091,19 @@ int mlx5dv_set_context_attr(struct ibv_context *ibv_ctx,
 	return 0;
 }
 
-int mlx5dv_get_clock_info(struct ibv_context *ctx_in,
-			  struct mlx5dv_clock_info *clock_info)
+int mlx5dv_set_context_attr(struct ibv_context *ibv_ctx,
+			    enum mlx5dv_set_ctx_attr_type type, void *attr)
+{
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(ibv_ctx);
+
+	if (!dvops || !dvops->set_context_attr)
+		return EOPNOTSUPP;
+
+	return dvops->set_context_attr(ibv_ctx, type, attr);
+}
+
+static int _mlx5dv_get_clock_info(struct ibv_context *ctx_in,
+				  struct mlx5dv_clock_info *clock_info)
 {
 	struct mlx5_context *ctx = to_mctx(ctx_in);
 	const struct mlx5_ib_clock_info *ci;
@@ -1980,6 +2141,41 @@ repeat:
 	return 0;
 }
 
+int mlx5dv_get_clock_info(struct ibv_context *ctx_in,
+			  struct mlx5dv_clock_info *clock_info)
+{
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(ctx_in);
+
+	if (!dvops || !dvops->get_clock_info)
+		return EOPNOTSUPP;
+
+	return dvops->get_clock_info(ctx_in, clock_info);
+}
+
+static struct mlx5_dv_context_ops mlx5_dv_ctx_ops = {
+	.query_device = _mlx5dv_query_device,
+
+	.query_qp_lag_port = _mlx5dv_query_qp_lag_port,
+	.modify_qp_lag_port = _mlx5dv_modify_qp_lag_port,
+
+	.modify_qp_udp_sport = _mlx5dv_modify_qp_udp_sport,
+
+	.sched_node_create = _mlx5dv_sched_node_create,
+	.sched_leaf_create = _mlx5dv_sched_leaf_create,
+	.sched_node_modify = _mlx5dv_sched_node_modify,
+	.sched_leaf_modify = _mlx5dv_sched_leaf_modify,
+	.sched_node_destroy = _mlx5dv_sched_node_destroy,
+	.sched_leaf_destroy = _mlx5dv_sched_leaf_destroy,
+	.modify_qp_sched_elem = _mlx5dv_modify_qp_sched_elem,
+
+	.reserved_qpn_alloc = _mlx5dv_reserved_qpn_alloc,
+	.reserved_qpn_dealloc = _mlx5dv_reserved_qpn_dealloc,
+
+	.set_context_attr = _mlx5dv_set_context_attr,
+	.get_clock_info = _mlx5dv_get_clock_info,
+	.init_obj = _mlx5dv_init_obj,
+};
+
 static void adjust_uar_info(struct mlx5_device *mdev,
 			    struct mlx5_context *context,
 			    struct mlx5_ib_alloc_ucontext_resp *resp)
@@ -2234,6 +2430,7 @@ bf_done:
 		else
 			goto err_free;
 	}
+	context->dv_ctx_ops = &mlx5_dv_ctx_ops;
 
 	mlx5_query_device_ctx(context);
 
@@ -2403,6 +2600,7 @@ static struct verbs_device *mlx5_device_alloc(struct verbs_sysfs_dev *sysfs_dev)
 	dev->page_size   = sysconf(_SC_PAGESIZE);
 	dev->driver_abi_ver = sysfs_dev->abi_ver;
 
+	mlx5_set_dv_ctx_ops(&mlx5_dv_ctx_ops);
 	return &dev->verbs_dev;
 }
 
@@ -2417,10 +2615,20 @@ static const struct verbs_device_ops mlx5_dev_ops = {
 	.import_context = mlx5_import_context,
 };
 
-bool is_mlx5_dev(struct ibv_device *device)
+static bool is_mlx5_dev(struct ibv_device *device)
 {
 	struct verbs_device *verbs_device = verbs_get_device(device);
 
 	return verbs_device->ops == &mlx5_dev_ops;
 }
+
+struct mlx5_dv_context_ops *mlx5_get_dv_ops(struct ibv_context *ibctx)
+{
+	if (is_mlx5_dev(ibctx->device))
+		return to_mctx(ibctx)->dv_ctx_ops;
+	else if (is_mlx5_vfio_dev(ibctx->device))
+		return to_mvfio_ctx(ibctx)->dv_ctx_ops;
+	else
+		return NULL;
+}
 PROVIDER_DRIVER(mlx5, mlx5_dev_ops);
diff --git a/providers/mlx5/mlx5.h b/providers/mlx5/mlx5.h
index 7e7d70d..fd02199 100644
--- a/providers/mlx5/mlx5.h
+++ b/providers/mlx5/mlx5.h
@@ -302,6 +302,8 @@ struct mlx5_reserved_qpns {
 	pthread_mutex_t mutex;
 };
 
+struct mlx5_dv_context_ops;
+
 struct mlx5_context {
 	struct verbs_context		ibv_ctx;
 	int				max_num_qps;
@@ -403,6 +405,7 @@ struct mlx5_context {
 	void				*cq_uar_reg;
 	struct mlx5_reserved_qpns	reserved_qpns;
 	uint8_t				qp_data_in_order_cap:1;
+	struct mlx5_dv_context_ops	*dv_ctx_ops;
 };
 
 struct mlx5_bitmap {
@@ -865,11 +868,11 @@ struct mlx5dv_sched_leaf {
 };
 
 struct ibv_flow *
-__mlx5dv_create_flow(struct mlx5dv_flow_matcher *flow_matcher,
-		     struct mlx5dv_flow_match_parameters *match_value,
-		     size_t num_actions,
-		     struct mlx5dv_flow_action_attr actions_attr[],
-		     struct mlx5_flow_action_attr_aux actions_attr_aux[]);
+_mlx5dv_create_flow(struct mlx5dv_flow_matcher *flow_matcher,
+		    struct mlx5dv_flow_match_parameters *match_value,
+		    size_t num_actions,
+		    struct mlx5dv_flow_action_attr actions_attr[],
+		    struct mlx5_flow_action_attr_aux actions_attr_aux[]);
 
 extern int mlx5_stall_num_loop;
 extern int mlx5_stall_cq_poll_min;
@@ -992,7 +995,7 @@ static inline struct mlx5_flow *to_mflow(struct ibv_flow *flow_id)
 	return container_of(flow_id, struct mlx5_flow, flow_id);
 }
 
-bool is_mlx5_dev(struct ibv_device *device);
+bool is_mlx5_vfio_dev(struct ibv_device *device);
 
 void mlx5_open_debug_file(FILE **dbg_fp);
 void mlx5_close_debug_file(FILE *dbg_fp);
@@ -1340,4 +1343,169 @@ static inline bool srq_has_waitq(struct mlx5_srq *srq)
 
 bool srq_cooldown_wqe(struct mlx5_srq *srq, int ind);
 
+struct mlx5_dv_context_ops {
+	int (*devx_general_cmd)(struct ibv_context *context, const void *in,
+				size_t inlen, void *out, size_t outlen);
+
+	struct mlx5dv_devx_obj *(*devx_obj_create)(struct ibv_context *context,
+						   const void *in, size_t inlen,
+						   void *out, size_t outlen);
+	int (*devx_obj_query)(struct mlx5dv_devx_obj *obj, const void *in,
+			      size_t inlen, void *out, size_t outlen);
+	int (*devx_obj_modify)(struct mlx5dv_devx_obj *obj, const void *in,
+			       size_t inlen, void *out, size_t outlen);
+	int (*devx_obj_destroy)(struct mlx5dv_devx_obj *obj);
+
+	int (*devx_query_eqn)(struct ibv_context *context, uint32_t vector,
+			      uint32_t *eqn);
+
+	int (*devx_cq_query)(struct ibv_cq *cq, const void *in, size_t inlen,
+			     void *out, size_t outlen);
+	int (*devx_cq_modify)(struct ibv_cq *cq, const void *in, size_t inlen,
+			      void *out, size_t outlen);
+
+	int (*devx_qp_query)(struct ibv_qp *qp, const void *in, size_t inlen,
+			     void *out, size_t outlen);
+	int (*devx_qp_modify)(struct ibv_qp *qp, const void *in, size_t inlen,
+			      void *out, size_t outlen);
+
+	int (*devx_srq_query)(struct ibv_srq *srq, const void *in, size_t inlen,
+			      void *out, size_t outlen);
+	int (*devx_srq_modify)(struct ibv_srq *srq, const void *in, size_t inlen,
+			       void *out, size_t outlen);
+
+	int (*devx_wq_query)(struct ibv_wq *wq, const void *in, size_t inlen,
+			     void *out, size_t outlen);
+	int (*devx_wq_modify)(struct ibv_wq *wq, const void *in, size_t inlen,
+			      void *out, size_t outlen);
+
+	int (*devx_ind_tbl_query)(struct ibv_rwq_ind_table *ind_tbl, const void *in,
+				  size_t inlen, void *out, size_t outlen);
+	int (*devx_ind_tbl_modify)(struct ibv_rwq_ind_table *ind_tbl, const void *in,
+				   size_t inlen, void *out, size_t outlen);
+
+	struct mlx5dv_devx_cmd_comp *(*devx_create_cmd_comp)(struct ibv_context *context);
+	void (*devx_destroy_cmd_comp)(struct mlx5dv_devx_cmd_comp *cmd_comp);
+
+	struct mlx5dv_devx_event_channel *(*devx_create_event_channel)(struct ibv_context *context,
+								       enum mlx5dv_devx_create_event_channel_flags flags);
+	void (*devx_destroy_event_channel)(struct mlx5dv_devx_event_channel *dv_event_channel);
+	int (*devx_subscribe_devx_event)(struct mlx5dv_devx_event_channel *dv_event_channel,
+					 struct mlx5dv_devx_obj *obj,
+					 uint16_t events_sz,
+					 uint16_t events_num[],
+					 uint64_t cookie);
+	int (*devx_subscribe_devx_event_fd)(struct mlx5dv_devx_event_channel *dv_event_channel,
+					    int fd,
+					    struct mlx5dv_devx_obj *obj,
+					    uint16_t event_num);
+
+	int (*devx_obj_query_async)(struct mlx5dv_devx_obj *obj, const void *in,
+				    size_t inlen, size_t outlen,
+				    uint64_t wr_id,
+				    struct mlx5dv_devx_cmd_comp *cmd_comp);
+	int (*devx_get_async_cmd_comp)(struct mlx5dv_devx_cmd_comp *cmd_comp,
+				       struct mlx5dv_devx_async_cmd_hdr *cmd_resp,
+				       size_t cmd_resp_len);
+
+	ssize_t (*devx_get_event)(struct mlx5dv_devx_event_channel *event_channel,
+				  struct mlx5dv_devx_async_event_hdr *event_data,
+				  size_t event_resp_len);
+
+	struct mlx5dv_devx_uar *(*devx_alloc_uar)(struct ibv_context *context,
+						       uint32_t flags);
+	void (*devx_free_uar)(struct mlx5dv_devx_uar *dv_devx_uar);
+
+	struct mlx5dv_devx_umem *(*devx_umem_reg)(struct ibv_context *context,
+						  void *addr, size_t size, uint32_t access);
+	struct mlx5dv_devx_umem *(*devx_umem_reg_ex)(struct ibv_context *ctx,
+						     struct mlx5dv_devx_umem_in *umem_in);
+	int (*devx_umem_dereg)(struct mlx5dv_devx_umem *dv_devx_umem);
+
+	struct mlx5dv_mkey *(*create_mkey)(struct mlx5dv_mkey_init_attr *mkey_init_attr);
+	int (*destroy_mkey)(struct mlx5dv_mkey *dv_mkey);
+
+	struct mlx5dv_var *(*alloc_var)(struct ibv_context *context, uint32_t flags);
+	void (*free_var)(struct mlx5dv_var *dv_var);
+
+	struct mlx5dv_pp *(*pp_alloc)(struct ibv_context *context, size_t pp_context_sz,
+				      const void *pp_context, uint32_t flags);
+	void (*pp_free)(struct mlx5dv_pp *dv_pp);
+
+	int (*init_obj)(struct mlx5dv_obj *obj, uint64_t obj_type);
+	struct ibv_cq_ex *(*create_cq)(struct ibv_context *context,
+				       struct ibv_cq_init_attr_ex *cq_attr,
+				       struct mlx5dv_cq_init_attr *mlx5_cq_attr);
+	struct ibv_qp *(*create_qp)(struct ibv_context *context,
+				    struct ibv_qp_init_attr_ex *qp_attr,
+				    struct mlx5dv_qp_init_attr *mlx5_qp_attr);
+	struct mlx5dv_qp_ex *(*qp_ex_from_ibv_qp_ex)(struct ibv_qp_ex *qp); /* Is this needed? */
+	struct ibv_wq *(*create_wq)(struct ibv_context *context,
+				    struct ibv_wq_init_attr *attr,
+				    struct mlx5dv_wq_init_attr *mlx5_wq_attr);
+
+	struct ibv_dm *(*alloc_dm)(struct ibv_context *context,
+				   struct ibv_alloc_dm_attr *dm_attr,
+				   struct mlx5dv_alloc_dm_attr *mlx5_dm_attr);
+	void *(*dm_map_op_addr)(struct ibv_dm *dm, uint8_t op);
+
+	struct ibv_flow_action *
+	(*create_flow_action_esp)(struct ibv_context *ctx,
+				  struct ibv_flow_action_esp_attr *esp,
+				  struct mlx5dv_flow_action_esp *mlx5_attr);
+	struct ibv_flow_action *
+	(*create_flow_action_modify_header)(struct ibv_context *ctx,
+					    size_t actions_sz,
+					    uint64_t actions[],
+					    enum mlx5dv_flow_table_type ft_type);
+	struct ibv_flow_action *
+	(*create_flow_action_packet_reformat)(struct ibv_context *ctx,
+					      size_t data_sz,
+					      void *data,
+					      enum mlx5dv_flow_action_packet_reformat_type reformat_type,
+					      enum mlx5dv_flow_table_type ft_type);
+
+	struct mlx5dv_flow_matcher *(*create_flow_matcher)(struct ibv_context *context,
+							   struct mlx5dv_flow_matcher_attr *attr);
+	int (*destroy_flow_matcher)(struct mlx5dv_flow_matcher *flow_matcher);
+	struct ibv_flow *(*create_flow)(struct mlx5dv_flow_matcher *flow_matcher,
+					struct mlx5dv_flow_match_parameters *match_value,
+					size_t num_actions,
+					struct mlx5dv_flow_action_attr actions_attr[],
+					struct mlx5_flow_action_attr_aux actions_attr_aux[]);
+
+	int (*query_device)(struct ibv_context *ctx_in, struct mlx5dv_context *attrs_out);
+
+	int (*query_qp_lag_port)(struct ibv_qp *qp, uint8_t *port_num,
+				 uint8_t *active_port_num);
+	int (*modify_qp_lag_port)(struct ibv_qp *qp, uint8_t port_num);
+	int (*modify_qp_udp_sport)(struct ibv_qp *qp, uint16_t udp_sport);
+
+	struct mlx5dv_sched_node *(*sched_node_create)(struct ibv_context *ctx,
+						       const struct mlx5dv_sched_attr *attr);
+	struct mlx5dv_sched_leaf *(*sched_leaf_create)(struct ibv_context *ctx,
+						       const struct mlx5dv_sched_attr *attr);
+	int (*sched_node_modify)(struct mlx5dv_sched_node *node,
+				 const struct mlx5dv_sched_attr *attr);
+	int (*sched_leaf_modify)(struct mlx5dv_sched_leaf *leaf,
+				 const struct mlx5dv_sched_attr *attr);
+	int (*sched_node_destroy)(struct mlx5dv_sched_node *node);
+	int (*sched_leaf_destroy)(struct mlx5dv_sched_leaf *leaf);
+	int (*modify_qp_sched_elem)(struct ibv_qp *qp,
+				    const struct mlx5dv_sched_leaf *requestor,
+				    const struct mlx5dv_sched_leaf *responder);
+	int (*reserved_qpn_alloc)(struct ibv_context *ctx, uint32_t *qpn);
+	int (*reserved_qpn_dealloc)(struct ibv_context *ctx, uint32_t qpn);
+	int (*set_context_attr)(struct ibv_context *ibv_ctx,
+				enum mlx5dv_set_ctx_attr_type type, void *attr);
+	int (*get_clock_info)(struct ibv_context *ctx_in,
+			      struct mlx5dv_clock_info *clock_info);
+	int (*query_port)(struct ibv_context *context, uint32_t port_num,
+			  struct mlx5dv_port *info, size_t info_len);
+	int (*map_ah_to_qp)(struct ibv_ah *ah, uint32_t qp_num);
+};
+
+struct mlx5_dv_context_ops *mlx5_get_dv_ops(struct ibv_context *context);
+void mlx5_set_dv_ctx_ops(struct mlx5_dv_context_ops *ops);
+
 #endif /* MLX5_H */
diff --git a/providers/mlx5/mlx5_vfio.c b/providers/mlx5/mlx5_vfio.c
index e85a8cc..23c6eeb 100644
--- a/providers/mlx5/mlx5_vfio.c
+++ b/providers/mlx5/mlx5_vfio.c
@@ -2459,6 +2459,25 @@ end:
 	return NULL;
 }
 
+static struct mlx5dv_devx_obj *
+vfio_devx_obj_create(struct ibv_context *context, const void *in,
+		     size_t inlen, void *out, size_t outlen)
+{
+	errno = EOPNOTSUPP;
+	return NULL;
+}
+
+static int vfio_devx_obj_query(struct mlx5dv_devx_obj *obj, const void *in,
+				size_t inlen, void *out, size_t outlen)
+{
+	return EOPNOTSUPP;
+}
+
+static struct mlx5_dv_context_ops mlx5_vfio_dv_ctx_ops = {
+	.devx_obj_create = vfio_devx_obj_create,
+	.devx_obj_query = vfio_devx_obj_query,
+};
+
 static void mlx5_vfio_uninit_context(struct mlx5_vfio_context *ctx)
 {
 	mlx5_close_debug_file(ctx->dbg_fp);
@@ -2524,6 +2543,7 @@ mlx5_vfio_alloc_context(struct ibv_device *ibdev,
 		goto func_teardown;
 
 	verbs_set_ops(&mctx->vctx, &mlx5_vfio_common_ops);
+	mctx->dv_ctx_ops = &mlx5_vfio_dv_ctx_ops;
 	return &mctx->vctx;
 
 func_teardown:
@@ -2729,3 +2749,10 @@ end:
 	free(list);
 	return NULL;
 }
+
+bool is_mlx5_vfio_dev(struct ibv_device *device)
+{
+	struct verbs_device *verbs_device = verbs_get_device(device);
+
+	return verbs_device->ops == &mlx5_vfio_dev_ops;
+}
diff --git a/providers/mlx5/mlx5_vfio.h b/providers/mlx5/mlx5_vfio.h
index 5311c6f..79b8033 100644
--- a/providers/mlx5/mlx5_vfio.h
+++ b/providers/mlx5/mlx5_vfio.h
@@ -290,6 +290,7 @@ struct mlx5_vfio_context {
 	struct mlx5_eq async_eq;
 	struct mlx5_vfio_eqs_uar eqs_uar;
 	pthread_mutex_t eq_lock;
+	struct mlx5_dv_context_ops *dv_ctx_ops;
 };
 
 static inline struct mlx5_vfio_device *to_mvfio_dev(struct ibv_device *ibdev)
diff --git a/providers/mlx5/verbs.c b/providers/mlx5/verbs.c
index 833b7cb..33b19df 100644
--- a/providers/mlx5/verbs.c
+++ b/providers/mlx5/verbs.c
@@ -1169,17 +1169,12 @@ struct ibv_cq_ex *mlx5_create_cq_ex(struct ibv_context *context,
 	return create_cq(context, cq_attr, MLX5_CQ_FLAGS_EXTENDED, NULL);
 }
 
-struct ibv_cq_ex *mlx5dv_create_cq(struct ibv_context *context,
-				      struct ibv_cq_init_attr_ex *cq_attr,
-				      struct mlx5dv_cq_init_attr *mlx5_cq_attr)
+static struct ibv_cq_ex *_mlx5dv_create_cq(struct ibv_context *context,
+					   struct ibv_cq_init_attr_ex *cq_attr,
+					   struct mlx5dv_cq_init_attr *mlx5_cq_attr)
 {
 	struct ibv_cq_ex *cq;
 
-	if (!is_mlx5_dev(context->device)) {
-		errno = EOPNOTSUPP;
-		return NULL;
-	}
-
 	cq = create_cq(context, cq_attr, MLX5_CQ_FLAGS_EXTENDED, mlx5_cq_attr);
 	if (!cq)
 		return NULL;
@@ -1189,6 +1184,20 @@ struct ibv_cq_ex *mlx5dv_create_cq(struct ibv_context *context,
 	return cq;
 }
 
+struct ibv_cq_ex *mlx5dv_create_cq(struct ibv_context *context,
+				      struct ibv_cq_init_attr_ex *cq_attr,
+				      struct mlx5dv_cq_init_attr *mlx5_cq_attr)
+{
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(context);
+
+	if (!dvops || !dvops->create_cq) {
+		errno = EOPNOTSUPP;
+		return NULL;
+	}
+
+	return dvops->create_cq(context, cq_attr, mlx5_cq_attr);
+}
+
 int mlx5_resize_cq(struct ibv_cq *ibcq, int cqe)
 {
 	struct mlx5_cq *cq = to_mcq(ibcq);
@@ -3112,7 +3121,7 @@ int mlx5_destroy_ah(struct ibv_ah *ah)
 	return 0;
 }
 
-int mlx5dv_map_ah_to_qp(struct ibv_ah *ah, uint32_t qp_num)
+static int _mlx5dv_map_ah_to_qp(struct ibv_ah *ah, uint32_t qp_num)
 {
 	uint32_t out[DEVX_ST_SZ_DW(general_obj_out_cmd_hdr)] = {};
 	uint32_t in[DEVX_ST_SZ_DW(create_av_qp_mapping_in)] = {};
@@ -3122,9 +3131,6 @@ int mlx5dv_map_ah_to_qp(struct ibv_ah *ah, uint32_t qp_num)
 	void *attr;
 	int ret = 0;
 
-	if (!is_mlx5_dev(ah->context->device))
-		return EOPNOTSUPP;
-
 	if (!(mctx->general_obj_types_caps &
 	      (1ULL << MLX5_OBJ_TYPE_AV_QP_MAPPING)) ||
 	    !mah->is_global)
@@ -3159,6 +3165,16 @@ int mlx5dv_map_ah_to_qp(struct ibv_ah *ah, uint32_t qp_num)
 	return ret;
 }
 
+int mlx5dv_map_ah_to_qp(struct ibv_ah *ah, uint32_t qp_num)
+{
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(ah->context);
+
+	if (!dvops || !dvops->map_ah_to_qp)
+		return EOPNOTSUPP;
+
+	return dvops->map_ah_to_qp(ah, qp_num);
+}
+
 int mlx5_attach_mcast(struct ibv_qp *qp, const union ibv_gid *gid, uint16_t lid)
 {
 	return ibv_cmd_attach_mcast(qp, gid, lid);
@@ -3175,16 +3191,25 @@ struct ibv_qp *mlx5_create_qp_ex(struct ibv_context *context,
 	return create_qp(context, attr, NULL);
 }
 
+static struct ibv_qp *_mlx5dv_create_qp(struct ibv_context *context,
+				struct ibv_qp_init_attr_ex *qp_attr,
+				struct mlx5dv_qp_init_attr *mlx5_qp_attr)
+{
+	return create_qp(context, qp_attr, mlx5_qp_attr);
+}
+
 struct ibv_qp *mlx5dv_create_qp(struct ibv_context *context,
 				struct ibv_qp_init_attr_ex *qp_attr,
 				struct mlx5dv_qp_init_attr *mlx5_qp_attr)
 {
-	if (!is_mlx5_dev(context->device)) {
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(context);
+
+	if (!dvops || !dvops->create_qp) {
 		errno = EOPNOTSUPP;
 		return NULL;
 	}
 
-	return create_qp(context, qp_attr, mlx5_qp_attr);
+	return dvops->create_qp(context, qp_attr, mlx5_qp_attr);
 }
 
 struct mlx5dv_qp_ex *mlx5dv_qp_ex_from_ibv_qp_ex(struct ibv_qp_ex *qp)
@@ -4009,16 +4034,25 @@ struct ibv_wq *mlx5_create_wq(struct ibv_context *context,
 	return create_wq(context, attr, NULL);
 }
 
+static struct ibv_wq *_mlx5dv_create_wq(struct ibv_context *context,
+					struct ibv_wq_init_attr *attr,
+					struct mlx5dv_wq_init_attr *mlx5_wq_attr)
+{
+	return create_wq(context, attr, mlx5_wq_attr);
+}
+
 struct ibv_wq *mlx5dv_create_wq(struct ibv_context *context,
 				struct ibv_wq_init_attr *attr,
 				struct mlx5dv_wq_init_attr *mlx5_wq_attr)
 {
-	if (!is_mlx5_dev(context->device)) {
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(context);
+
+	if (!dvops || !dvops->create_wq) {
 		errno = EOPNOTSUPP;
 		return NULL;
 	}
 
-	return create_wq(context, attr, mlx5_wq_attr);
+	return dvops->create_wq(context, attr, mlx5_wq_attr);
 }
 
 int mlx5_modify_wq(struct ibv_wq *wq, struct ibv_wq_attr *attr)
@@ -4298,9 +4332,10 @@ struct ibv_flow_action *mlx5_create_flow_action_esp(struct ibv_context *ctx,
 	return _mlx5_create_flow_action_esp(ctx, attr, NULL);
 }
 
-struct ibv_flow_action *mlx5dv_create_flow_action_esp(struct ibv_context *ctx,
-						      struct ibv_flow_action_esp_attr *esp,
-						      struct mlx5dv_flow_action_esp *mlx5_attr)
+static struct ibv_flow_action *
+_mlx5dv_create_flow_action_esp(struct ibv_context *ctx,
+			       struct ibv_flow_action_esp_attr *esp,
+			       struct mlx5dv_flow_action_esp *mlx5_attr)
 {
 	DECLARE_COMMAND_BUFFER_LINK(driver_attr, UVERBS_OBJECT_FLOW_ACTION,
 				    UVERBS_METHOD_FLOW_ACTION_ESP_CREATE, 1,
@@ -4325,6 +4360,21 @@ struct ibv_flow_action *mlx5dv_create_flow_action_esp(struct ibv_context *ctx,
 	return _mlx5_create_flow_action_esp(ctx, esp, driver_attr);
 }
 
+struct ibv_flow_action *mlx5dv_create_flow_action_esp(struct ibv_context *ctx,
+						      struct ibv_flow_action_esp_attr *esp,
+						      struct mlx5dv_flow_action_esp *mlx5_attr)
+{
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(ctx);
+
+	if (!dvops || !dvops->create_flow_action_esp) {
+		errno = EOPNOTSUPP;
+		return NULL;
+	}
+
+	return dvops->create_flow_action_esp(ctx, esp,
+						      mlx5_attr);
+}
+
 int mlx5_modify_flow_action_esp(struct ibv_flow_action *action,
 				struct ibv_flow_action_esp_attr *attr)
 {
@@ -4337,10 +4387,11 @@ int mlx5_modify_flow_action_esp(struct ibv_flow_action *action,
 	return ibv_cmd_modify_flow_action_esp(vaction, attr, NULL);
 }
 
-struct ibv_flow_action *mlx5dv_create_flow_action_modify_header(struct ibv_context *ctx,
-								size_t actions_sz,
-								uint64_t actions[],
-								enum mlx5dv_flow_table_type ft_type)
+static struct ibv_flow_action *
+_mlx5dv_create_flow_action_modify_header(struct ibv_context *ctx,
+					 size_t actions_sz,
+					 uint64_t actions[],
+					 enum mlx5dv_flow_table_type ft_type)
 {
 	DECLARE_COMMAND_BUFFER(cmd, UVERBS_OBJECT_FLOW_ACTION,
 			       MLX5_IB_METHOD_FLOW_ACTION_CREATE_MODIFY_HEADER,
@@ -4375,12 +4426,29 @@ struct ibv_flow_action *mlx5dv_create_flow_action_modify_header(struct ibv_conte
 	return &action->action;
 }
 
-struct ibv_flow_action *
-mlx5dv_create_flow_action_packet_reformat(struct ibv_context *ctx,
-					  size_t data_sz,
-					  void *data,
-					  enum mlx5dv_flow_action_packet_reformat_type reformat_type,
-					  enum mlx5dv_flow_table_type ft_type)
+struct ibv_flow_action *mlx5dv_create_flow_action_modify_header(struct ibv_context *ctx,
+								size_t actions_sz,
+								uint64_t actions[],
+								enum mlx5dv_flow_table_type ft_type)
+{
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(ctx);
+
+	if (!dvops || !dvops->create_flow_action_modify_header) {
+		errno = EOPNOTSUPP;
+		return NULL;
+	}
+
+	return dvops->create_flow_action_modify_header(ctx, actions_sz,
+								actions, ft_type);
+
+}
+
+static struct ibv_flow_action *
+_mlx5dv_create_flow_action_packet_reformat(struct ibv_context *ctx,
+					   size_t data_sz,
+					   void *data,
+					   enum mlx5dv_flow_action_packet_reformat_type reformat_type,
+					   enum mlx5dv_flow_table_type ft_type)
 {
 	DECLARE_COMMAND_BUFFER(cmd, UVERBS_OBJECT_FLOW_ACTION,
 			       MLX5_IB_METHOD_FLOW_ACTION_CREATE_PACKET_REFORMAT, 4);
@@ -4425,6 +4493,24 @@ mlx5dv_create_flow_action_packet_reformat(struct ibv_context *ctx,
 	return &action->action;
 }
 
+struct ibv_flow_action *
+mlx5dv_create_flow_action_packet_reformat(struct ibv_context *ctx,
+					  size_t data_sz,
+					  void *data,
+					  enum mlx5dv_flow_action_packet_reformat_type reformat_type,
+					  enum mlx5dv_flow_table_type ft_type)
+{
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(ctx);
+
+	if (!dvops || !dvops->create_flow_action_packet_reformat) {
+		errno = EOPNOTSUPP;
+		return NULL;
+	}
+
+	return dvops->create_flow_action_packet_reformat(ctx, data_sz, data,
+								  reformat_type, ft_type);
+}
+
 int mlx5_destroy_flow_action(struct ibv_flow_action *action)
 {
 	struct verbs_flow_action *vaction =
@@ -4502,7 +4588,7 @@ static void *dm_mmap(struct ibv_context *context, struct mlx5_dm *mdm,
 		    context->cmd_fd, page_size * offset);
 }
 
-void *mlx5dv_dm_map_op_addr(struct ibv_dm *dm, uint8_t op)
+static void *_mlx5dv_dm_map_op_addr(struct ibv_dm *dm, uint8_t op)
 {
 	int page_size = to_mdev(dm->context->device)->page_size;
 	struct mlx5_dm *mdm = to_mdm(dm);
@@ -4511,11 +4597,6 @@ void *mlx5dv_dm_map_op_addr(struct ibv_dm *dm, uint8_t op)
 	void *va;
 	int ret;
 
-	if (!is_mlx5_dev(dm->context->device)) {
-		errno = EOPNOTSUPP;
-		return NULL;
-	}
-
 	DECLARE_COMMAND_BUFFER(cmdb, UVERBS_OBJECT_DM,
 			       MLX5_IB_METHOD_DM_MAP_OP_ADDR, 4);
 	fill_attr_in_obj(cmdb, MLX5_IB_ATTR_DM_MAP_OP_ADDR_REQ_HANDLE,
@@ -4538,6 +4619,18 @@ void *mlx5dv_dm_map_op_addr(struct ibv_dm *dm, uint8_t op)
 	return va + (start_offset & (page_size - 1));
 }
 
+void *mlx5dv_dm_map_op_addr(struct ibv_dm *dm, uint8_t op)
+{
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(dm->context);
+
+	if (!dvops || !dvops->dm_map_op_addr) {
+		errno = EOPNOTSUPP;
+		return NULL;
+	}
+
+	return dvops->dm_map_op_addr(dm, op);
+}
+
 void mlx5_unimport_dm(struct ibv_dm *ibdm)
 {
 	struct mlx5_dm *dm = to_mdm(ibdm);
@@ -4653,10 +4746,10 @@ static int alloc_dm_steering_sw_icm(struct ibv_context *ctx,
 	return 0;
 }
 
-struct ibv_dm *
-mlx5dv_alloc_dm(struct ibv_context *context,
-		struct ibv_alloc_dm_attr *dm_attr,
-		struct mlx5dv_alloc_dm_attr *mlx5_dm_attr)
+static struct ibv_dm *
+_mlx5dv_alloc_dm(struct ibv_context *context,
+		 struct ibv_alloc_dm_attr *dm_attr,
+		 struct mlx5dv_alloc_dm_attr *mlx5_dm_attr)
 {
 	DECLARE_COMMAND_BUFFER(cmdb, UVERBS_OBJECT_DM, UVERBS_METHOD_DM_ALLOC,
 			       3);
@@ -4706,6 +4799,21 @@ err_free_mem:
 	return NULL;
 }
 
+struct ibv_dm *
+mlx5dv_alloc_dm(struct ibv_context *context,
+		struct ibv_alloc_dm_attr *dm_attr,
+		struct mlx5dv_alloc_dm_attr *mlx5_dm_attr)
+{
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(context);
+
+	if (!dvops || !dvops->alloc_dm) {
+		errno = EOPNOTSUPP;
+		return NULL;
+	}
+
+	return dvops->alloc_dm(context, dm_attr, mlx5_dm_attr);
+}
+
 int mlx5_free_dm(struct ibv_dm *ibdm)
 {
 	struct mlx5_device *mdev = to_mdev(ibdm->context->device);
@@ -4845,9 +4953,9 @@ int mlx5_read_counters(struct ibv_counters *counters,
 
 }
 
-struct mlx5dv_flow_matcher *
-mlx5dv_create_flow_matcher(struct ibv_context *context,
-			   struct mlx5dv_flow_matcher_attr *attr)
+static struct mlx5dv_flow_matcher *
+_mlx5dv_create_flow_matcher(struct ibv_context *context,
+			    struct mlx5dv_flow_matcher_attr *attr)
 {
 	DECLARE_COMMAND_BUFFER(cmd, MLX5_IB_OBJECT_FLOW_MATCHER,
 			       MLX5_IB_METHOD_FLOW_MATCHER_CREATE,
@@ -4904,7 +5012,21 @@ err:
 	return NULL;
 }
 
-int mlx5dv_destroy_flow_matcher(struct mlx5dv_flow_matcher *flow_matcher)
+struct mlx5dv_flow_matcher *
+mlx5dv_create_flow_matcher(struct ibv_context *context,
+			   struct mlx5dv_flow_matcher_attr *attr)
+{
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(context);
+
+	if (!dvops || !dvops->create_flow_matcher) {
+		errno = EOPNOTSUPP;
+		return NULL;
+	}
+
+	return dvops->create_flow_matcher(context, attr);
+}
+
+static int _mlx5dv_destroy_flow_matcher(struct mlx5dv_flow_matcher *flow_matcher)
 {
 	DECLARE_COMMAND_BUFFER(cmd, MLX5_IB_OBJECT_FLOW_MATCHER,
 			       MLX5_IB_METHOD_FLOW_MATCHER_DESTROY,
@@ -4922,13 +5044,23 @@ int mlx5dv_destroy_flow_matcher(struct mlx5dv_flow_matcher *flow_matcher)
 	return 0;
 }
 
+int mlx5dv_destroy_flow_matcher(struct mlx5dv_flow_matcher *flow_matcher)
+{
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(flow_matcher->context);
+
+	if (!dvops || !dvops->destroy_flow_matcher)
+		return EOPNOTSUPP;
+
+	return dvops->destroy_flow_matcher(flow_matcher);
+}
+
 #define CREATE_FLOW_MAX_FLOW_ACTIONS_SUPPORTED 8
 struct ibv_flow *
-__mlx5dv_create_flow(struct mlx5dv_flow_matcher *flow_matcher,
-		     struct mlx5dv_flow_match_parameters *match_value,
-		     size_t num_actions,
-		     struct mlx5dv_flow_action_attr actions_attr[],
-		     struct mlx5_flow_action_attr_aux actions_attr_aux[])
+_mlx5dv_create_flow(struct mlx5dv_flow_matcher *flow_matcher,
+		    struct mlx5dv_flow_match_parameters *match_value,
+		    size_t num_actions,
+		    struct mlx5dv_flow_action_attr actions_attr[],
+		    struct mlx5_flow_action_attr_aux actions_attr_aux[])
 {
 	uint32_t flow_actions[CREATE_FLOW_MAX_FLOW_ACTIONS_SUPPORTED];
 	struct verbs_flow_action *vaction;
@@ -5074,15 +5206,22 @@ mlx5dv_create_flow(struct mlx5dv_flow_matcher *flow_matcher,
 		   size_t num_actions,
 		   struct mlx5dv_flow_action_attr actions_attr[])
 {
-	return __mlx5dv_create_flow(flow_matcher,
-				    match_value,
-				    num_actions,
-				    actions_attr,
-				    NULL);
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(flow_matcher->context);
+
+	if (!dvops || !dvops->create_flow) {
+		errno = EOPNOTSUPP;
+		return NULL;
+	}
+
+	return dvops->create_flow(flow_matcher,
+				  match_value,
+				  num_actions,
+				  actions_attr,
+				  NULL);
 }
 
 static struct mlx5dv_devx_umem *
-_mlx5dv_devx_umem_reg_ex(struct ibv_context *context,
+__mlx5dv_devx_umem_reg_ex(struct ibv_context *context,
 			 struct mlx5dv_devx_umem_in *in,
 			 bool legacy)
 {
@@ -5139,8 +5278,8 @@ err:
 	return NULL;
 }
 
-struct mlx5dv_devx_umem *
-mlx5dv_devx_umem_reg(struct ibv_context *context, void *addr, size_t size, uint32_t access)
+static struct mlx5dv_devx_umem *
+_mlx5dv_devx_umem_reg(struct ibv_context *context, void *addr, size_t size, uint32_t access)
 {
 	struct mlx5dv_devx_umem_in umem_in = {};
 
@@ -5150,16 +5289,43 @@ mlx5dv_devx_umem_reg(struct ibv_context *context, void *addr, size_t size, uint3
 
 	umem_in.pgsz_bitmap = UINT64_MAX & ~(MLX5_ADAPTER_PAGE_SIZE - 1);
 
-	return _mlx5dv_devx_umem_reg_ex(context, &umem_in, true);
+	return __mlx5dv_devx_umem_reg_ex(context, &umem_in, true);
+}
+
+static struct mlx5dv_devx_umem *
+_mlx5dv_devx_umem_reg_ex(struct ibv_context *ctx, struct mlx5dv_devx_umem_in *umem_in)
+{
+	return __mlx5dv_devx_umem_reg_ex(ctx, umem_in, false);
 }
 
 struct mlx5dv_devx_umem *
 mlx5dv_devx_umem_reg_ex(struct ibv_context *ctx, struct mlx5dv_devx_umem_in *umem_in)
 {
-	return _mlx5dv_devx_umem_reg_ex(ctx, umem_in, false);
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(ctx);
+
+	if (!dvops || !dvops->devx_umem_reg_ex) {
+		errno = EOPNOTSUPP;
+		return NULL;
+	}
+
+	return dvops->devx_umem_reg_ex(ctx, umem_in);
+}
+
+struct mlx5dv_devx_umem *
+mlx5dv_devx_umem_reg(struct ibv_context *context, void *addr, size_t size, uint32_t access)
+{
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(context);
+
+	if (!dvops || !dvops->devx_umem_reg) {
+		errno = EOPNOTSUPP;
+		return NULL;
+	}
+
+	return dvops->devx_umem_reg(context, addr, size, access);
+
 }
 
-int mlx5dv_devx_umem_dereg(struct mlx5dv_devx_umem *dv_devx_umem)
+static int _mlx5dv_devx_umem_dereg(struct mlx5dv_devx_umem *dv_devx_umem)
 {
 	DECLARE_COMMAND_BUFFER(cmd,
 			       MLX5_IB_OBJECT_DEVX_UMEM,
@@ -5179,6 +5345,19 @@ int mlx5dv_devx_umem_dereg(struct mlx5dv_devx_umem *dv_devx_umem)
 	return 0;
 }
 
+int mlx5dv_devx_umem_dereg(struct mlx5dv_devx_umem *dv_devx_umem)
+{
+	struct mlx5_devx_umem *umem = container_of(dv_devx_umem, struct mlx5_devx_umem,
+						   dv_devx_umem);
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(umem->context);
+
+	if (!dvops || !dvops->devx_umem_dereg)
+		return EOPNOTSUPP;
+
+	return dvops->devx_umem_dereg(dv_devx_umem);
+
+}
+
 static void set_devx_obj_info(const void *in, const void *out,
 			      struct mlx5dv_devx_obj *obj)
 {
@@ -5241,9 +5420,9 @@ static void set_devx_obj_info(const void *in, const void *out,
 	}
 }
 
-struct mlx5dv_devx_obj *
-mlx5dv_devx_obj_create(struct ibv_context *context, const void *in, size_t inlen,
-				void *out, size_t outlen)
+static struct mlx5dv_devx_obj *
+_mlx5dv_devx_obj_create(struct ibv_context *context, const void *in,
+			size_t inlen, void *out, size_t outlen)
 {
 	DECLARE_COMMAND_BUFFER(cmd,
 			       MLX5_IB_OBJECT_DEVX_OBJ,
@@ -5270,14 +5449,30 @@ mlx5dv_devx_obj_create(struct ibv_context *context, const void *in, size_t inlen
 	obj->handle = read_attr_obj(MLX5_IB_ATTR_DEVX_OBJ_CREATE_HANDLE, handle);
 	obj->context = context;
 	set_devx_obj_info(in, out, obj);
+
 	return obj;
 err:
 	free(obj);
 	return NULL;
 }
 
-int mlx5dv_devx_obj_query(struct mlx5dv_devx_obj *obj, const void *in, size_t inlen,
-				void *out, size_t outlen)
+struct mlx5dv_devx_obj *
+mlx5dv_devx_obj_create(struct ibv_context *context, const void *in,
+			 size_t inlen, void *out, size_t outlen)
+{
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(context);
+
+	if (!dvops || !dvops->devx_obj_create) {
+		errno = EOPNOTSUPP;
+		return NULL;
+	}
+
+	return dvops->devx_obj_create(context, in, inlen, out, outlen);
+}
+
+static int
+_mlx5dv_devx_obj_query(struct mlx5dv_devx_obj *obj, const void *in,
+		       size_t inlen, void *out, size_t outlen)
 {
 	DECLARE_COMMAND_BUFFER(cmd,
 			       MLX5_IB_OBJECT_DEVX_OBJ,
@@ -5291,8 +5486,19 @@ int mlx5dv_devx_obj_query(struct mlx5dv_devx_obj *obj, const void *in, size_t in
 	return execute_ioctl(obj->context, cmd);
 }
 
-int mlx5dv_devx_obj_modify(struct mlx5dv_devx_obj *obj, const void *in, size_t inlen,
-				void *out, size_t outlen)
+int mlx5dv_devx_obj_query(struct mlx5dv_devx_obj *obj, const void *in, size_t inlen,
+			  void *out, size_t outlen)
+{
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(obj->context);
+
+	if (!dvops || !dvops->devx_obj_query)
+		return EOPNOTSUPP;
+
+	return dvops->devx_obj_query(obj, in, inlen, out, outlen);
+}
+
+static int _mlx5dv_devx_obj_modify(struct mlx5dv_devx_obj *obj, const void *in,
+				   size_t inlen, void *out, size_t outlen)
 {
 	DECLARE_COMMAND_BUFFER(cmd,
 			       MLX5_IB_OBJECT_DEVX_OBJ,
@@ -5306,7 +5512,18 @@ int mlx5dv_devx_obj_modify(struct mlx5dv_devx_obj *obj, const void *in, size_t i
 	return execute_ioctl(obj->context, cmd);
 }
 
-int mlx5dv_devx_obj_destroy(struct mlx5dv_devx_obj *obj)
+int mlx5dv_devx_obj_modify(struct mlx5dv_devx_obj *obj, const void *in,
+			   size_t inlen, void *out, size_t outlen)
+{
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(obj->context);
+
+	if (!dvops || !dvops->devx_obj_modify)
+		return EOPNOTSUPP;
+
+	return dvops->devx_obj_modify(obj, in, inlen, out, outlen);
+}
+
+static int _mlx5dv_devx_obj_destroy(struct mlx5dv_devx_obj *obj)
 {
 	DECLARE_COMMAND_BUFFER(cmd,
 			       MLX5_IB_OBJECT_DEVX_OBJ,
@@ -5323,8 +5540,18 @@ int mlx5dv_devx_obj_destroy(struct mlx5dv_devx_obj *obj)
 	return 0;
 }
 
-int mlx5dv_devx_general_cmd(struct ibv_context *context, const void *in, size_t inlen,
-			void *out, size_t outlen)
+int mlx5dv_devx_obj_destroy(struct mlx5dv_devx_obj *obj)
+{
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(obj->context);
+
+	if (!dvops || !dvops->devx_obj_destroy)
+		return EOPNOTSUPP;
+
+	return dvops->devx_obj_destroy(obj);
+}
+
+static int _mlx5dv_devx_general_cmd(struct ibv_context *context, const void *in,
+				    size_t inlen, void *out, size_t outlen)
 {
 	DECLARE_COMMAND_BUFFER(cmd,
 			       MLX5_IB_OBJECT_DEVX,
@@ -5337,24 +5564,44 @@ int mlx5dv_devx_general_cmd(struct ibv_context *context, const void *in, size_t
 	return execute_ioctl(context, cmd);
 }
 
-int _mlx5dv_query_port(struct ibv_context *context,
-		       uint32_t port_num,
-		       struct mlx5dv_port *info, size_t info_len)
+int mlx5dv_devx_general_cmd(struct ibv_context *context, const void *in, size_t inlen,
+			    void *out, size_t outlen)
+{
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(context);
+
+	if (!dvops || !dvops->devx_general_cmd)
+		return EOPNOTSUPP;
+
+	return dvops->devx_general_cmd(context, in, inlen, out, outlen);
+}
+
+static int __mlx5dv_query_port(struct ibv_context *context,
+			       uint32_t port_num,
+			       struct mlx5dv_port *info, size_t info_len)
 {
 	DECLARE_COMMAND_BUFFER(cmd,
 			       UVERBS_OBJECT_DEVICE,
 			       MLX5_IB_METHOD_QUERY_PORT,
 			       2);
 
-	if (!is_mlx5_dev(context->device))
-		return EOPNOTSUPP;
-
 	fill_attr_in_uint32(cmd, MLX5_IB_ATTR_QUERY_PORT_PORT_NUM, port_num);
 	fill_attr_out(cmd, MLX5_IB_ATTR_QUERY_PORT, info, info_len);
 
 	return execute_ioctl(context, cmd);
 }
 
+int _mlx5dv_query_port(struct ibv_context *context,
+		       uint32_t port_num,
+		       struct mlx5dv_port *info, size_t info_len)
+{
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(context);
+
+	if (!dvops || !dvops->query_port)
+		return EOPNOTSUPP;
+
+	return dvops->query_port(context, port_num, info, info_len);
+}
+
 void clean_dyn_uars(struct ibv_context *context)
 {
 	struct mlx5_context *ctx = to_mctx(context);
@@ -5379,8 +5626,8 @@ void clean_dyn_uars(struct ibv_context *context)
 		mlx5_free_uar(context, ctx->nc_uar);
 }
 
-struct mlx5dv_devx_uar *mlx5dv_devx_alloc_uar(struct ibv_context *context,
-					      uint32_t flags)
+static struct mlx5dv_devx_uar *
+_mlx5dv_devx_alloc_uar(struct ibv_context *context, uint32_t flags)
 {
 	DECLARE_COMMAND_BUFFER(cmd,
 			       MLX5_IB_OBJECT_DEVX,
@@ -5390,11 +5637,6 @@ struct mlx5dv_devx_uar *mlx5dv_devx_alloc_uar(struct ibv_context *context,
 	int ret;
 	struct mlx5_bf *bf;
 
-	if (!is_mlx5_dev(context->device)) {
-		errno = EOPNOTSUPP;
-		return NULL;
-	}
-
 	if (!check_comp_mask(flags, MLX5_IB_UAPI_UAR_ALLOC_TYPE_NC)) {
 		errno = EOPNOTSUPP;
 		return NULL;
@@ -5430,7 +5672,20 @@ struct mlx5dv_devx_uar *mlx5dv_devx_alloc_uar(struct ibv_context *context,
 	return &bf->devx_uar.dv_devx_uar;
 }
 
-void mlx5dv_devx_free_uar(struct mlx5dv_devx_uar *dv_devx_uar)
+struct mlx5dv_devx_uar *
+mlx5dv_devx_alloc_uar(struct ibv_context *context, uint32_t flags)
+{
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(context);
+
+	if (!dvops || !dvops->devx_alloc_uar) {
+		errno = EOPNOTSUPP;
+		return NULL;
+	}
+
+	return dvops->devx_alloc_uar(context, flags);
+}
+
+static void _mlx5dv_devx_free_uar(struct mlx5dv_devx_uar *dv_devx_uar)
 {
 	struct mlx5_bf *bf = container_of(dv_devx_uar, struct mlx5_bf,
 					  devx_uar.dv_devx_uar);
@@ -5441,8 +5696,20 @@ void mlx5dv_devx_free_uar(struct mlx5dv_devx_uar *dv_devx_uar)
 	mlx5_detach_dedicated_uar(bf->devx_uar.context, bf);
 }
 
-int mlx5dv_devx_query_eqn(struct ibv_context *context, uint32_t vector,
-			  uint32_t *eqn)
+void mlx5dv_devx_free_uar(struct mlx5dv_devx_uar *dv_devx_uar)
+{
+	struct mlx5_devx_uar *uar = container_of(dv_devx_uar, struct mlx5_devx_uar,
+						 dv_devx_uar);
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(uar->context);
+
+	if (!dvops || !dvops->devx_free_uar)
+		return;
+
+	dvops->devx_free_uar(dv_devx_uar);
+}
+
+static int _mlx5dv_devx_query_eqn(struct ibv_context *context,
+				   uint32_t vector, uint32_t *eqn)
 {
 	DECLARE_COMMAND_BUFFER(cmd,
 			       MLX5_IB_OBJECT_DEVX,
@@ -5455,8 +5722,19 @@ int mlx5dv_devx_query_eqn(struct ibv_context *context, uint32_t vector,
 	return execute_ioctl(context, cmd);
 }
 
-int mlx5dv_devx_cq_query(struct ibv_cq *cq, const void *in, size_t inlen,
-				void *out, size_t outlen)
+int mlx5dv_devx_query_eqn(struct ibv_context *context, uint32_t vector,
+			  uint32_t *eqn)
+{
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(context);
+
+	if (!dvops || !dvops->devx_query_eqn)
+		return EOPNOTSUPP;
+
+	return dvops->devx_query_eqn(context, vector, eqn);
+}
+
+static int _mlx5dv_devx_cq_query(struct ibv_cq *cq, const void *in,
+				  size_t inlen, void *out, size_t outlen)
 {
 	DECLARE_COMMAND_BUFFER(cmd,
 			       MLX5_IB_OBJECT_DEVX_OBJ,
@@ -5470,9 +5748,20 @@ int mlx5dv_devx_cq_query(struct ibv_cq *cq, const void *in, size_t inlen,
 	return execute_ioctl(cq->context, cmd);
 }
 
-int mlx5dv_devx_cq_modify(struct ibv_cq *cq, const void *in, size_t inlen,
+int mlx5dv_devx_cq_query(struct ibv_cq *cq, const void *in, size_t inlen,
 				void *out, size_t outlen)
 {
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(cq->context);
+
+	if (!dvops || !dvops->devx_cq_query)
+		return EOPNOTSUPP;
+
+	return dvops->devx_cq_query(cq, in, inlen, out, outlen);
+}
+
+static int _mlx5dv_devx_cq_modify(struct ibv_cq *cq, const void *in,
+				   size_t inlen, void *out, size_t outlen)
+{
 	DECLARE_COMMAND_BUFFER(cmd,
 			       MLX5_IB_OBJECT_DEVX_OBJ,
 			       MLX5_IB_METHOD_DEVX_OBJ_MODIFY,
@@ -5485,9 +5774,20 @@ int mlx5dv_devx_cq_modify(struct ibv_cq *cq, const void *in, size_t inlen,
 	return execute_ioctl(cq->context, cmd);
 }
 
-int mlx5dv_devx_qp_query(struct ibv_qp *qp, const void *in, size_t inlen,
+int mlx5dv_devx_cq_modify(struct ibv_cq *cq, const void *in, size_t inlen,
 				void *out, size_t outlen)
 {
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(cq->context);
+
+	if (!dvops || !dvops->devx_cq_modify)
+		return EOPNOTSUPP;
+
+	return dvops->devx_cq_modify(cq, in, inlen, out, outlen);
+}
+
+static int _mlx5dv_devx_qp_query(struct ibv_qp *qp, const void *in,
+				  size_t inlen, void *out, size_t outlen)
+{
 	DECLARE_COMMAND_BUFFER(cmd,
 			       MLX5_IB_OBJECT_DEVX_OBJ,
 			       MLX5_IB_METHOD_DEVX_OBJ_QUERY,
@@ -5500,9 +5800,20 @@ int mlx5dv_devx_qp_query(struct ibv_qp *qp, const void *in, size_t inlen,
 	return execute_ioctl(qp->context, cmd);
 }
 
-int mlx5dv_devx_qp_modify(struct ibv_qp *qp, const void *in, size_t inlen,
+int mlx5dv_devx_qp_query(struct ibv_qp *qp, const void *in, size_t inlen,
 				void *out, size_t outlen)
 {
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(qp->context);
+
+	if (!dvops || !dvops->devx_qp_query)
+		return EOPNOTSUPP;
+
+	return dvops->devx_qp_query(qp, in, inlen, out, outlen);
+}
+
+static int _mlx5dv_devx_qp_modify(struct ibv_qp *qp, const void *in,
+				   size_t inlen, void *out, size_t outlen)
+{
 	DECLARE_COMMAND_BUFFER(cmd,
 			       MLX5_IB_OBJECT_DEVX_OBJ,
 			       MLX5_IB_METHOD_DEVX_OBJ_MODIFY,
@@ -5515,8 +5826,19 @@ int mlx5dv_devx_qp_modify(struct ibv_qp *qp, const void *in, size_t inlen,
 	return execute_ioctl(qp->context, cmd);
 }
 
-int mlx5dv_devx_srq_query(struct ibv_srq *srq, const void *in, size_t inlen,
-				void *out, size_t outlen)
+int mlx5dv_devx_qp_modify(struct ibv_qp *qp, const void *in, size_t inlen,
+			  void *out, size_t outlen)
+{
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(qp->context);
+
+	if (!dvops || !dvops->devx_qp_modify)
+		return EOPNOTSUPP;
+
+	return dvops->devx_qp_modify(qp, in, inlen, out, outlen);
+}
+
+static int _mlx5dv_devx_srq_query(struct ibv_srq *srq, const void *in,
+				   size_t inlen, void *out, size_t outlen)
 {
 	DECLARE_COMMAND_BUFFER(cmd,
 			       MLX5_IB_OBJECT_DEVX_OBJ,
@@ -5530,8 +5852,19 @@ int mlx5dv_devx_srq_query(struct ibv_srq *srq, const void *in, size_t inlen,
 	return execute_ioctl(srq->context, cmd);
 }
 
-int mlx5dv_devx_srq_modify(struct ibv_srq *srq, const void *in, size_t inlen,
-				void *out, size_t outlen)
+int mlx5dv_devx_srq_query(struct ibv_srq *srq, const void *in, size_t inlen,
+			  void *out, size_t outlen)
+{
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(srq->context);
+
+	if (!dvops || !dvops->devx_srq_query)
+		return EOPNOTSUPP;
+
+	return dvops->devx_srq_query(srq, in, inlen, out, outlen);
+}
+
+static int _mlx5dv_devx_srq_modify(struct ibv_srq *srq, const void *in,
+				    size_t inlen, void *out, size_t outlen)
 {
 	DECLARE_COMMAND_BUFFER(cmd,
 			       MLX5_IB_OBJECT_DEVX_OBJ,
@@ -5545,8 +5878,19 @@ int mlx5dv_devx_srq_modify(struct ibv_srq *srq, const void *in, size_t inlen,
 	return execute_ioctl(srq->context, cmd);
 }
 
-int mlx5dv_devx_wq_query(struct ibv_wq *wq, const void *in, size_t inlen,
-				void *out, size_t outlen)
+int mlx5dv_devx_srq_modify(struct ibv_srq *srq, const void *in, size_t inlen,
+			   void *out, size_t outlen)
+{
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(srq->context);
+
+	if (!dvops || !dvops->devx_srq_modify)
+		return EOPNOTSUPP;
+
+	return dvops->devx_srq_modify(srq, in, inlen, out, outlen);
+}
+
+static int _mlx5dv_devx_wq_query(struct ibv_wq *wq, const void *in, size_t inlen,
+				  void *out, size_t outlen)
 {
 	DECLARE_COMMAND_BUFFER(cmd,
 			       MLX5_IB_OBJECT_DEVX_OBJ,
@@ -5560,8 +5904,19 @@ int mlx5dv_devx_wq_query(struct ibv_wq *wq, const void *in, size_t inlen,
 	return execute_ioctl(wq->context, cmd);
 }
 
-int mlx5dv_devx_wq_modify(struct ibv_wq *wq, const void *in, size_t inlen,
-				void *out, size_t outlen)
+int mlx5dv_devx_wq_query(struct ibv_wq *wq, const void *in, size_t inlen,
+			 void *out, size_t outlen)
+{
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(wq->context);
+
+	if (!dvops || !dvops->devx_wq_query)
+		return EOPNOTSUPP;
+
+	return dvops->devx_wq_query(wq, in, inlen, out, outlen);
+}
+
+static int _mlx5dv_devx_wq_modify(struct ibv_wq *wq, const void *in,
+				   size_t inlen, void *out, size_t outlen)
 {
 	DECLARE_COMMAND_BUFFER(cmd,
 			       MLX5_IB_OBJECT_DEVX_OBJ,
@@ -5575,8 +5930,20 @@ int mlx5dv_devx_wq_modify(struct ibv_wq *wq, const void *in, size_t inlen,
 	return execute_ioctl(wq->context, cmd);
 }
 
-int mlx5dv_devx_ind_tbl_query(struct ibv_rwq_ind_table *ind_tbl, const void *in, size_t inlen,
-				void *out, size_t outlen)
+int mlx5dv_devx_wq_modify(struct ibv_wq *wq, const void *in, size_t inlen,
+			  void *out, size_t outlen)
+{
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(wq->context);
+
+	if (!dvops || !dvops->devx_wq_modify)
+		return EOPNOTSUPP;
+
+	return dvops->devx_wq_modify(wq, in, inlen, out, outlen);
+}
+
+static int _mlx5dv_devx_ind_tbl_query(struct ibv_rwq_ind_table *ind_tbl,
+				       const void *in, size_t inlen,
+				       void *out, size_t outlen)
 {
 	DECLARE_COMMAND_BUFFER(cmd,
 			       MLX5_IB_OBJECT_DEVX_OBJ,
@@ -5590,8 +5957,21 @@ int mlx5dv_devx_ind_tbl_query(struct ibv_rwq_ind_table *ind_tbl, const void *in,
 	return execute_ioctl(ind_tbl->context, cmd);
 }
 
-int mlx5dv_devx_ind_tbl_modify(struct ibv_rwq_ind_table *ind_tbl, const void *in, size_t inlen,
-				void *out, size_t outlen)
+
+int mlx5dv_devx_ind_tbl_query(struct ibv_rwq_ind_table *ind_tbl, const void *in,
+			      size_t inlen, void *out, size_t outlen)
+{
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(ind_tbl->context);
+
+	if (!dvops || !dvops->devx_ind_tbl_query)
+		return EOPNOTSUPP;
+
+	return dvops->devx_ind_tbl_query(ind_tbl, in, inlen, out, outlen);
+}
+
+static int _mlx5dv_devx_ind_tbl_modify(struct ibv_rwq_ind_table *ind_tbl,
+					const void *in, size_t inlen,
+					void *out, size_t outlen)
 {
 	DECLARE_COMMAND_BUFFER(cmd,
 			       MLX5_IB_OBJECT_DEVX_OBJ,
@@ -5605,8 +5985,20 @@ int mlx5dv_devx_ind_tbl_modify(struct ibv_rwq_ind_table *ind_tbl, const void *in
 	return execute_ioctl(ind_tbl->context, cmd);
 }
 
-struct mlx5dv_devx_cmd_comp *
-mlx5dv_devx_create_cmd_comp(struct ibv_context *context)
+int mlx5dv_devx_ind_tbl_modify(struct ibv_rwq_ind_table *ind_tbl,
+			       const void *in, size_t inlen,
+			       void *out, size_t outlen)
+{
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(ind_tbl->context);
+
+	if (!dvops || !dvops->devx_ind_tbl_modify)
+		return EOPNOTSUPP;
+
+	return dvops->devx_ind_tbl_modify(ind_tbl, in, inlen, out, outlen);
+}
+
+static struct mlx5dv_devx_cmd_comp *
+_mlx5dv_devx_create_cmd_comp(struct ibv_context *context)
 {
 	DECLARE_COMMAND_BUFFER(cmd,
 			       MLX5_IB_OBJECT_DEVX_ASYNC_CMD_FD,
@@ -5638,16 +6030,35 @@ err:
 	return NULL;
 }
 
-void mlx5dv_devx_destroy_cmd_comp(
+struct mlx5dv_devx_cmd_comp *
+mlx5dv_devx_create_cmd_comp(struct ibv_context *context)
+{
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(context);
+
+	if (!dvops || !dvops->devx_create_cmd_comp) {
+		errno = EOPNOTSUPP;
+		return NULL;
+	}
+
+	return dvops->devx_create_cmd_comp(context);
+}
+
+static void _mlx5dv_devx_destroy_cmd_comp(
 			struct mlx5dv_devx_cmd_comp *cmd_comp)
 {
 	close(cmd_comp->fd);
 	free(cmd_comp);
 }
 
-struct mlx5dv_devx_event_channel *
-mlx5dv_devx_create_event_channel(struct ibv_context *context,
-				 enum mlx5dv_devx_create_event_channel_flags flags)
+void mlx5dv_devx_destroy_cmd_comp(
+			struct mlx5dv_devx_cmd_comp *cmd_comp)
+{
+	_mlx5dv_devx_destroy_cmd_comp(cmd_comp);
+}
+
+static struct mlx5dv_devx_event_channel *
+_mlx5dv_devx_create_event_channel(struct ibv_context *context,
+				   enum mlx5dv_devx_create_event_channel_flags flags)
 {
 	DECLARE_COMMAND_BUFFER(cmd,
 			       MLX5_IB_OBJECT_DEVX_ASYNC_EVENT_FD,
@@ -5682,7 +6093,21 @@ err:
 	return NULL;
 }
 
-void mlx5dv_devx_destroy_event_channel(
+struct mlx5dv_devx_event_channel *
+mlx5dv_devx_create_event_channel(struct ibv_context *context,
+				 enum mlx5dv_devx_create_event_channel_flags flags)
+{
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(context);
+
+	if (!dvops || !dvops->devx_create_event_channel) {
+		errno = EOPNOTSUPP;
+		return NULL;
+	}
+
+	return dvops->devx_create_event_channel(context, flags);
+}
+
+static void _mlx5dv_devx_destroy_event_channel(
 			struct mlx5dv_devx_event_channel *dv_event_channel)
 {
 	struct mlx5_devx_event_channel *event_channel =
@@ -5693,11 +6118,26 @@ void mlx5dv_devx_destroy_event_channel(
 	free(event_channel);
 }
 
-int mlx5dv_devx_subscribe_devx_event(struct mlx5dv_devx_event_channel *dv_event_channel,
-				     struct mlx5dv_devx_obj *obj, /* can be NULL for unaffiliated events */
-				     uint16_t events_sz,
-				     uint16_t events_num[],
-				     uint64_t cookie)
+void mlx5dv_devx_destroy_event_channel(
+			struct mlx5dv_devx_event_channel *dv_event_channel)
+{
+	struct mlx5_devx_event_channel *ech =
+			container_of(dv_event_channel, struct mlx5_devx_event_channel,
+				     dv_event_channel);
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(ech->context);
+
+	if (!dvops || !dvops->devx_destroy_event_channel)
+		return;
+
+	return dvops->devx_destroy_event_channel(dv_event_channel);
+}
+
+static int
+_mlx5dv_devx_subscribe_devx_event(struct mlx5dv_devx_event_channel *dv_event_channel,
+				  struct mlx5dv_devx_obj *obj, /* can be NULL for unaffiliated events */
+				  uint16_t events_sz,
+				  uint16_t events_num[],
+				  uint64_t cookie)
 {
 	struct mlx5_devx_event_channel *event_channel =
 			container_of(dv_event_channel, struct mlx5_devx_event_channel,
@@ -5717,10 +6157,26 @@ int mlx5dv_devx_subscribe_devx_event(struct mlx5dv_devx_event_channel *dv_event_
 	return execute_ioctl(event_channel->context, cmd);
 }
 
-int mlx5dv_devx_subscribe_devx_event_fd(struct mlx5dv_devx_event_channel *dv_event_channel,
-					int fd,
-					struct mlx5dv_devx_obj *obj, /* can be NULL for unaffiliated events */
-					uint16_t event_num)
+int mlx5dv_devx_subscribe_devx_event(struct mlx5dv_devx_event_channel *dv_event_channel,
+				     struct mlx5dv_devx_obj *obj, /* can be NULL for unaffiliated events */
+				     uint16_t events_sz,
+				     uint16_t events_num[],
+				     uint64_t cookie)
+{
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(obj->context);
+
+	if (!dvops || !dvops->devx_subscribe_devx_event)
+		return EOPNOTSUPP;
+
+	return dvops->devx_subscribe_devx_event(dv_event_channel, obj,
+							 events_sz, events_num,
+							 cookie);
+}
+
+static int _mlx5dv_devx_subscribe_devx_event_fd(struct mlx5dv_devx_event_channel *dv_event_channel,
+						int fd,
+						struct mlx5dv_devx_obj *obj, /* can be NULL for unaffiliated events */
+						uint16_t event_num)
 {
 	struct mlx5_devx_event_channel *event_channel =
 			container_of(dv_event_channel, struct mlx5_devx_event_channel,
@@ -5740,10 +6196,24 @@ int mlx5dv_devx_subscribe_devx_event_fd(struct mlx5dv_devx_event_channel *dv_eve
 	return execute_ioctl(event_channel->context, cmd);
 }
 
-int mlx5dv_devx_obj_query_async(struct mlx5dv_devx_obj *obj, const void *in,
-				size_t inlen, size_t outlen,
-				uint64_t wr_id,
-				struct mlx5dv_devx_cmd_comp *cmd_comp)
+int mlx5dv_devx_subscribe_devx_event_fd(struct mlx5dv_devx_event_channel *dv_event_channel,
+					int fd,
+					struct mlx5dv_devx_obj *obj, /* can be NULL for unaffiliated events */
+					uint16_t event_num)
+{
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(obj->context);
+
+	if (!dvops || !dvops->devx_subscribe_devx_event_fd)
+		return EOPNOTSUPP;
+
+	return dvops->devx_subscribe_devx_event_fd(dv_event_channel, fd,
+							    obj, event_num);
+}
+
+static int _mlx5dv_devx_obj_query_async(struct mlx5dv_devx_obj *obj, const void *in,
+					size_t inlen, size_t outlen,
+					uint64_t wr_id,
+					struct mlx5dv_devx_cmd_comp *cmd_comp)
 {
 	DECLARE_COMMAND_BUFFER(cmd,
 			       MLX5_IB_OBJECT_DEVX_OBJ,
@@ -5759,9 +6229,23 @@ int mlx5dv_devx_obj_query_async(struct mlx5dv_devx_obj *obj, const void *in,
 	return execute_ioctl(obj->context, cmd);
 }
 
-int mlx5dv_devx_get_async_cmd_comp(struct mlx5dv_devx_cmd_comp *cmd_comp,
-				   struct mlx5dv_devx_async_cmd_hdr *cmd_resp,
-				   size_t cmd_resp_len)
+int mlx5dv_devx_obj_query_async(struct mlx5dv_devx_obj *obj, const void *in,
+				size_t inlen, size_t outlen,
+				uint64_t wr_id,
+				struct mlx5dv_devx_cmd_comp *cmd_comp)
+{
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(obj->context);
+
+	if (!dvops || !dvops->devx_obj_query_async)
+		return EOPNOTSUPP;
+
+	return dvops->devx_obj_query_async(obj, in, inlen, outlen,
+						    wr_id, cmd_comp);
+}
+
+static int _mlx5dv_devx_get_async_cmd_comp(struct mlx5dv_devx_cmd_comp *cmd_comp,
+					   struct mlx5dv_devx_async_cmd_hdr *cmd_resp,
+					   size_t cmd_resp_len)
 {
 	ssize_t bytes;
 
@@ -5775,24 +6259,12 @@ int mlx5dv_devx_get_async_cmd_comp(struct mlx5dv_devx_cmd_comp *cmd_comp,
 	return 0;
 }
 
-ssize_t mlx5dv_devx_get_event(struct mlx5dv_devx_event_channel *event_channel,
-				   struct mlx5dv_devx_async_event_hdr *event_data,
-				   size_t event_resp_len)
+int mlx5dv_devx_get_async_cmd_comp(struct mlx5dv_devx_cmd_comp *cmd_comp,
+				   struct mlx5dv_devx_async_cmd_hdr *cmd_resp,
+				   size_t cmd_resp_len)
 {
-	ssize_t bytes;
-
-	bytes = read(event_channel->fd, event_data, event_resp_len);
-	if (bytes < 0)
-		return -1;
-
-	/* cookie should be always exist */
-	if (bytes < sizeof(*event_data)) {
-		errno = EINVAL;
-		return -1;
-	}
-
-	/* event data may be omitted in case no EQE data exists (e.g. completion event on a CQ) */
-	return bytes;
+	return _mlx5dv_devx_get_async_cmd_comp(cmd_comp, cmd_resp,
+					       cmd_resp_len);
 }
 
 static int mlx5_destroy_sig_psvs(struct mlx5_sig_ctx *sig)
@@ -5880,7 +6352,37 @@ static int mlx5_destroy_sig_ctx(struct mlx5_sig_ctx *sig)
 	return ret;
 }
 
-struct mlx5dv_mkey *mlx5dv_create_mkey(struct mlx5dv_mkey_init_attr *mkey_init_attr)
+static ssize_t _mlx5dv_devx_get_event(struct mlx5dv_devx_event_channel *event_channel,
+				      struct mlx5dv_devx_async_event_hdr *event_data,
+				      size_t event_resp_len)
+{
+	ssize_t bytes;
+
+	bytes = read(event_channel->fd, event_data, event_resp_len);
+	if (bytes < 0)
+		return -1;
+
+	/* cookie should be always exist */
+	if (bytes < sizeof(*event_data)) {
+		errno = EINVAL;
+		return -1;
+	}
+
+	/* event data may be omitted in case no EQE data exists (e.g. completion event on a CQ) */
+	return bytes;
+}
+
+ssize_t mlx5dv_devx_get_event(struct mlx5dv_devx_event_channel *event_channel,
+			      struct mlx5dv_devx_async_event_hdr *event_data,
+			      size_t event_resp_len)
+{
+	return _mlx5dv_devx_get_event(event_channel,
+				      event_data,
+				      event_resp_len);
+}
+
+static struct mlx5dv_mkey *
+_mlx5dv_create_mkey(struct mlx5dv_mkey_init_attr *mkey_init_attr)
 {
 	uint32_t out[DEVX_ST_SZ_DW(create_mkey_out)] = {};
 	uint32_t in[DEVX_ST_SZ_DW(create_mkey_in)] = {};
@@ -5953,7 +6455,19 @@ err_free_mkey:
 	return NULL;
 }
 
-int mlx5dv_destroy_mkey(struct mlx5dv_mkey *dv_mkey)
+struct mlx5dv_mkey *mlx5dv_create_mkey(struct mlx5dv_mkey_init_attr *mkey_init_attr)
+{
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(mkey_init_attr->pd->context);
+
+	if (!dvops || !dvops->create_mkey) {
+		errno = EOPNOTSUPP;
+		return NULL;
+	}
+
+	return dvops->create_mkey(mkey_init_attr);
+}
+
+static int _mlx5dv_destroy_mkey(struct mlx5dv_mkey *dv_mkey)
 {
 	struct mlx5_mkey *mkey = container_of(dv_mkey, struct mlx5_mkey,
 					  dv_mkey);
@@ -5977,6 +6491,18 @@ int mlx5dv_destroy_mkey(struct mlx5dv_mkey *dv_mkey)
 	return 0;
 }
 
+int mlx5dv_destroy_mkey(struct mlx5dv_mkey *dv_mkey)
+{
+	struct mlx5_mkey *mkey = container_of(dv_mkey, struct mlx5_mkey,
+					      dv_mkey);
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(mkey->devx_obj->context);
+
+	if (!dvops || !dvops->destroy_mkey)
+		return EOPNOTSUPP;
+
+	return dvops->destroy_mkey(dv_mkey);
+}
+
 enum {
 	MLX5_SIGERR_CQE_SYNDROME_REFTAG = 1 << 11,
 	MLX5_SIGERR_CQE_SYNDROME_APPTAG = 1 << 12,
@@ -6088,8 +6614,8 @@ int _mlx5dv_mkey_check(struct mlx5dv_mkey *dv_mkey,
 	return 0;
 }
 
-struct mlx5dv_var *
-mlx5dv_alloc_var(struct ibv_context *context, uint32_t flags)
+static struct mlx5dv_var *
+_mlx5dv_alloc_var(struct ibv_context *context, uint32_t flags)
 {
 	DECLARE_COMMAND_BUFFER(cmd,
 			       MLX5_IB_OBJECT_VAR,
@@ -6100,11 +6626,6 @@ mlx5dv_alloc_var(struct ibv_context *context, uint32_t flags)
 	struct mlx5_var_obj *obj;
 	int ret;
 
-	if (!is_mlx5_dev(context->device)) {
-		errno = EOPNOTSUPP;
-		return NULL;
-	}
-
 	if (flags) {
 		errno = EOPNOTSUPP;
 		return NULL;
@@ -6138,8 +6659,20 @@ err:
 	return NULL;
 }
 
+struct mlx5dv_var *
+mlx5dv_alloc_var(struct ibv_context *context, uint32_t flags)
+{
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(context);
 
-void mlx5dv_free_var(struct mlx5dv_var *dv_var)
+	if (!dvops || !dvops->alloc_var) {
+		errno = EOPNOTSUPP;
+		return NULL;
+	}
+
+	return dvops->alloc_var(context, flags);
+}
+
+static void _mlx5dv_free_var(struct mlx5dv_var *dv_var)
 {
 	DECLARE_COMMAND_BUFFER(cmd,
 			       MLX5_IB_OBJECT_VAR,
@@ -6156,10 +6689,22 @@ void mlx5dv_free_var(struct mlx5dv_var *dv_var)
 	free(obj);
 }
 
-struct mlx5dv_pp *mlx5dv_pp_alloc(struct ibv_context *context,
-				  size_t pp_context_sz,
-				  const void *pp_context,
-				  uint32_t flags)
+void mlx5dv_free_var(struct mlx5dv_var *dv_var)
+{
+	struct mlx5_var_obj *obj = container_of(dv_var, struct mlx5_var_obj,
+						dv_var);
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(obj->context);
+
+	if (!dvops || !dvops->free_var)
+		return;
+
+	return dvops->free_var(dv_var);
+}
+
+static struct mlx5dv_pp *_mlx5dv_pp_alloc(struct ibv_context *context,
+					  size_t pp_context_sz,
+					  const void *pp_context,
+					  uint32_t flags)
 {
 	DECLARE_COMMAND_BUFFER(cmd,
 			       MLX5_IB_OBJECT_PP,
@@ -6170,11 +6715,6 @@ struct mlx5dv_pp *mlx5dv_pp_alloc(struct ibv_context *context,
 	struct mlx5_pp_obj *obj;
 	int ret;
 
-	if (!is_mlx5_dev(context->device)) {
-		errno = EOPNOTSUPP;
-		return NULL;
-	}
-
 	if (!check_comp_mask(flags,
 	    MLX5_IB_UAPI_PP_ALLOC_FLAGS_DEDICATED_INDEX)) {
 		errno = EOPNOTSUPP;
@@ -6208,7 +6748,23 @@ err:
 	return NULL;
 }
 
-void mlx5dv_pp_free(struct mlx5dv_pp *dv_pp)
+struct mlx5dv_pp *mlx5dv_pp_alloc(struct ibv_context *context,
+				  size_t pp_context_sz,
+				  const void *pp_context,
+				  uint32_t flags)
+{
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(context);
+
+	if (!dvops || !dvops->pp_alloc) {
+		errno = EOPNOTSUPP;
+		return NULL;
+	}
+
+	return dvops->pp_alloc(context, pp_context_sz,
+			       pp_context, flags);
+}
+
+static void _mlx5dv_pp_free(struct mlx5dv_pp *dv_pp)
 {
 	DECLARE_COMMAND_BUFFER(cmd,
 			       MLX5_IB_OBJECT_PP,
@@ -6224,3 +6780,89 @@ void mlx5dv_pp_free(struct mlx5dv_pp *dv_pp)
 
 	free(obj);
 }
+
+void mlx5dv_pp_free(struct mlx5dv_pp *dv_pp)
+{
+	struct mlx5_pp_obj *obj = container_of(dv_pp, struct mlx5_pp_obj, dv_pp);
+	struct mlx5_dv_context_ops *dvops = mlx5_get_dv_ops(obj->context);
+
+	if (!dvops || !dvops->pp_free)
+		return;
+
+	dvops->pp_free(dv_pp);
+}
+
+void mlx5_set_dv_ctx_ops(struct mlx5_dv_context_ops *ops)
+{
+	ops->devx_general_cmd = _mlx5dv_devx_general_cmd;
+
+	ops->devx_obj_create = _mlx5dv_devx_obj_create;
+
+	ops->devx_obj_query = _mlx5dv_devx_obj_query;
+	ops->devx_obj_modify = _mlx5dv_devx_obj_modify;
+	ops->devx_obj_destroy = _mlx5dv_devx_obj_destroy;
+
+	ops->devx_query_eqn = _mlx5dv_devx_query_eqn;
+
+	ops->devx_cq_query = _mlx5dv_devx_cq_query;
+	ops->devx_cq_modify = _mlx5dv_devx_cq_modify;
+
+	ops->devx_qp_query = _mlx5dv_devx_qp_query;
+	ops->devx_qp_modify = _mlx5dv_devx_qp_modify;
+
+	ops->devx_srq_query = _mlx5dv_devx_srq_query;
+	ops->devx_srq_modify = _mlx5dv_devx_srq_modify;
+
+	ops->devx_wq_query = _mlx5dv_devx_wq_query;
+	ops->devx_wq_modify = _mlx5dv_devx_wq_modify;
+
+	ops->devx_ind_tbl_query = _mlx5dv_devx_ind_tbl_query;
+	ops->devx_ind_tbl_modify = _mlx5dv_devx_ind_tbl_modify;
+
+	ops->devx_create_cmd_comp = _mlx5dv_devx_create_cmd_comp;
+	ops->devx_destroy_cmd_comp = _mlx5dv_devx_destroy_cmd_comp;
+
+	ops->devx_create_event_channel = _mlx5dv_devx_create_event_channel;
+	ops->devx_destroy_event_channel = _mlx5dv_devx_destroy_event_channel;
+
+	ops->devx_subscribe_devx_event = _mlx5dv_devx_subscribe_devx_event;
+	ops->devx_subscribe_devx_event_fd = _mlx5dv_devx_subscribe_devx_event_fd;
+
+	ops->devx_obj_query_async = _mlx5dv_devx_obj_query_async;
+	ops->devx_get_async_cmd_comp = _mlx5dv_devx_get_async_cmd_comp;
+
+	ops->devx_get_event = _mlx5dv_devx_get_event;
+
+	ops->devx_alloc_uar = _mlx5dv_devx_alloc_uar;
+	ops->devx_free_uar = _mlx5dv_devx_free_uar;
+
+	ops->devx_umem_reg = _mlx5dv_devx_umem_reg;
+	ops->devx_umem_reg_ex = _mlx5dv_devx_umem_reg_ex;
+	ops->devx_umem_dereg = _mlx5dv_devx_umem_dereg;
+
+	ops->create_mkey = _mlx5dv_create_mkey;
+	ops->destroy_mkey = _mlx5dv_destroy_mkey;
+
+	ops->alloc_var = _mlx5dv_alloc_var;
+	ops->free_var = _mlx5dv_free_var;
+
+	ops->pp_alloc = _mlx5dv_pp_alloc;
+	ops->pp_free = _mlx5dv_pp_free;
+
+	ops->create_cq = _mlx5dv_create_cq;
+	ops->create_qp = _mlx5dv_create_qp;
+	ops->create_wq = _mlx5dv_create_wq;
+
+	ops->alloc_dm = _mlx5dv_alloc_dm;
+	ops->dm_map_op_addr = _mlx5dv_dm_map_op_addr;
+
+	ops->create_flow_action_esp = _mlx5dv_create_flow_action_esp;
+	ops->create_flow_action_modify_header = _mlx5dv_create_flow_action_modify_header;
+	ops->create_flow_action_packet_reformat = _mlx5dv_create_flow_action_packet_reformat;
+	ops->create_flow_matcher = _mlx5dv_create_flow_matcher;
+	ops->destroy_flow_matcher = _mlx5dv_destroy_flow_matcher;
+	ops->create_flow = _mlx5dv_create_flow;
+
+	ops->map_ah_to_qp = _mlx5dv_map_ah_to_qp;
+	ops->query_port = __mlx5dv_query_port;
+}
-- 
1.8.3.1

