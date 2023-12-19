Return-Path: <linux-rdma+bounces-454-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C3881822F
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Dec 2023 08:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B69242852A4
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Dec 2023 07:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C382F8829;
	Tue, 19 Dec 2023 07:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="smVSQUxU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2052.outbound.protection.outlook.com [40.107.212.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2A18826
	for <linux-rdma@vger.kernel.org>; Tue, 19 Dec 2023 07:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfFzKx1Xn2VVS1zT/aL4wDDhlOUUdG52SKqffRO+KGQFnjiY8M8eGyZ0Ir8RnbWZyGHx5sHD7YsujOVveD9nm++L9cPx1iWHmLfH5opNEKNMSQlulOiYQOwwQY7Jwknk4JuVich14LGaTGl++Za/RV8dFGd6OS9xMP5o+PmhWsyMnbri7HW0/ShRkS6fLyyQ0nMQdLKToGcZd+kRLqQ44ZrkEYAXpdO3bb6qJ+V7RwBP9ZefRKjmfyjKg85gS/Spa2gocFCmeZSnLy4Eyj7R0zBffJOpH3aw0EsmqIJ25KtG85s542p+PUeZ05dZH5+XVCgOSshTKzA5Z6AQ6dz29A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tO6FzFpLEnCoMnCLwnW05O/mh9OqQipGpm0WqORa+Mg=;
 b=A9hr0jFdcoRSZs5HikJ/2MSjeTlPiifaNzNMow4dT0kZlTdSGYMjKPNVRFLgMSSpbAEryc4GYSngbT0HpHEGESaY3BFDc7H/6c4C7+kacplZZtTb65oWf7+MD5yVW2pNAxNe3EmywO/s2fY6ZDTnOzYOdrGraSs8YyLejuMET1BqmrZwEF3AMtsQEG/7W7N/IhP1KhYeFnIQbivUUvsbMmJ7lg9p8x1Zvmz5amsFvWrAuq1OeG987fTxajYQmX97tv0skNiLjjgjvKA3tD52d9FVQOJ82B6oPaQAYpZ2UPxsvX6KHrrlyUIBxT98vPVS6G9zC+iEJ1SX4rfEx/QZjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tO6FzFpLEnCoMnCLwnW05O/mh9OqQipGpm0WqORa+Mg=;
 b=smVSQUxUKUs9ayN4cEcFGLHUSM9V+7gZogkopnnt8wIayx3QJknz3hfok23vLwm5IRw7G5hcSiGta5R1dKo47SkD2RlSLM2SdFgjhUOlEkhO/mNLEjfOIsyZRb+MhTYA/5070I1nSPVhP2LfoVHN2dYyJso8R3Hws2xouEMz+Ww1d7IcJiJkukXizN0KqKMwJWTAjpAsc3vT6+TOJrFHqJHcFH17dhlzOcRpmFqQRfPjf4V3MHM60qmdqcY5tYZNFgGw7cPRnm5gCN/6qaIeNF5n9XG5oFillprxY+zOPIkKWCvJUmUUDISCZAtuCJFESVH1aj5s7P0eoEIbxbFOlQ==
Received: from DM6PR07CA0094.namprd07.prod.outlook.com (2603:10b6:5:337::27)
 by SA3PR12MB9107.namprd12.prod.outlook.com (2603:10b6:806:381::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 07:24:00 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:5:337:cafe::34) by DM6PR07CA0094.outlook.office365.com
 (2603:10b6:5:337::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38 via Frontend
 Transport; Tue, 19 Dec 2023 07:24:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.14 via Frontend Transport; Tue, 19 Dec 2023 07:24:00 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 18 Dec
 2023 23:23:50 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 18 Dec
 2023 23:23:49 -0800
Received: from rsws38-eth1.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 18 Dec 2023 23:23:48 -0800
From: Sergey Gorenko <sergeygo@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: <linux-rdma@vger.kernel.org>, Sergey Gorenko <sergeygo@nvidia.com>, "Max
 Gurtovoy" <mgurtovoy@nvidia.com>
Subject: [PATCH] IB/iser: Prevent invalidating wrong MR
Date: Tue, 19 Dec 2023 09:23:11 +0200
Message-ID: <20231219072311.40989-1-sergeygo@nvidia.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|SA3PR12MB9107:EE_
X-MS-Office365-Filtering-Correlation-Id: d1a6bb76-1573-4c7d-2cef-08dc00637891
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TsLTC00QO/HjrxCbRf1XjyOUYIeMjMbAA5VZz13SIiCAAmwxxD6MehhsR/w1khRivkO+Aoz87r4fHbLmiGLe08dzxPZNCKIQkaiJWtKSs5QDz7O86fbp+pDhXcCtH3m86tvCL+IWngLW7ngbBwwot0fmBGnbp0ZWm0MoiyMBmSKT3AAK05XbKDoyqr/K2cKSOYzrsKl+/QoVXj+1ytpiCRRvYPhLZK/AxdH+AP9qInrLpkKU6rcuXnUGHPPb0ujBxL/wPzp6o0HZOGbG7EEuVpaZzfERzcGTTnR+26w1AlvHYAF1bz8xk0rIB7TSp0S4vLEFvNIzuS0JCFPu5d7NPuL92r5QzhV3b+73tsxNhh3inlYgC+ntnLAPFChB1vF1UC7Dtpt7AmaRXolFIRfdADrElIPgLEsri5toHlwaV7catPDipNut4jZ5UJTQdy3J2OPGzAbDqEq7sjFu5psD8sgs3ac6G+wizh3a6+K8GIZQ1FxjGjzVGtn8eD9UeV1GMKG0YPDcv82aEqp/ZGVAw3WPDd6XAg5cGc7CU1HwljkYW/XUeCDethzU3FqT6oFDsARWeku3ULqWbGbNNEkOhCrulo7fZRgHFm2WUVf7bm9yr/bVAwuW5F4A2TSJBmpopm5d2w2KNh/1gNAdN2rUngHbzqv5X6tpTtY+wy8dYl2Gqe0GaWG5kYkHYihfSdsvHMi6wSz3uVgZ86fwUZgriwU5MIIw8k0PMLunxmyBS6KAyL92fAb9wg1MXFU7IXHG
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(136003)(376002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(82310400011)(36840700001)(46966006)(40470700004)(8936002)(4326008)(47076005)(8676002)(82740400003)(356005)(36756003)(7636003)(41300700001)(86362001)(2906002)(36860700001)(5660300002)(1076003)(478600001)(26005)(2616005)(40480700001)(107886003)(70586007)(54906003)(70206006)(316002)(40460700003)(6916009)(83380400001)(6666004)(336012)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 07:24:00.2904
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a6bb76-1573-4c7d-2cef-08dc00637891
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9107

The iser_reg_resources structure has two pointers to MR but only one
mr_valid field. The implementation assumes that we use only *sig_mr when
pi_enable is true. Otherwise, we use only *mr. However, it is only
sometimes correct. Read commands without protection information occur
even when pi_enble is true. For example, the following SCSI commands
have a Data-In buffer but never have protection information: READ
CAPACITY (16), INQUIRY, MODE SENSE(6), MAINTENANCE IN. So, we use
*sig_mr for some SCSI commands and *mr for the other SCSI commands.

In most cases, it works fine because the remote invalidation is applied.
However, there are two cases when the remote invalidation is not
applicable.
 1. Small write commands when all data is sent as an immediate.
 2. The target does not support the remote invalidation feature.

The lazy invalidation is used if the remote invalidation is impossible.
Since, at the lazy invalidation, we always invalidate the MR we want to
use, the wrong MR may be invalidated.

To fix the issue, we need a field per MR that indicates the MR needs
invalidation. Since the ib_mr structure already has such a field, let's
use ib_mr.need_inval instead of iser_reg_resources.mr_valid.

Fixes: b76a439982f8 ("IB/iser: Use IB_WR_REG_MR_INTEGRITY for PI handover")
Acked-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Sergey Gorenko <sergeygo@nvidia.com>
---
 drivers/infiniband/ulp/iser/iscsi_iser.h     | 2 --
 drivers/infiniband/ulp/iser/iser_initiator.c | 5 ++++-
 drivers/infiniband/ulp/iser/iser_memory.c    | 8 ++++----
 drivers/infiniband/ulp/iser/iser_verbs.c     | 1 -
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.h b/drivers/infiniband/ulp/iser/iscsi_iser.h
index dee8c97ff056..d967d5532459 100644
--- a/drivers/infiniband/ulp/iser/iscsi_iser.h
+++ b/drivers/infiniband/ulp/iser/iscsi_iser.h
@@ -317,12 +317,10 @@ struct iser_device {
  *
  * @mr:         memory region
  * @sig_mr:     signature memory region
- * @mr_valid:   is mr valid indicator
  */
 struct iser_reg_resources {
 	struct ib_mr                     *mr;
 	struct ib_mr                     *sig_mr;
-	u8				  mr_valid:1;
 };
 
 /**
diff --git a/drivers/infiniband/ulp/iser/iser_initiator.c b/drivers/infiniband/ulp/iser/iser_initiator.c
index 39ea73f69016..f5f090dc4f1e 100644
--- a/drivers/infiniband/ulp/iser/iser_initiator.c
+++ b/drivers/infiniband/ulp/iser/iser_initiator.c
@@ -581,7 +581,10 @@ static inline int iser_inv_desc(struct iser_fr_desc *desc, u32 rkey)
 		return -EINVAL;
 	}
 
-	desc->rsc.mr_valid = 0;
+	if (desc->sig_protected)
+		desc->rsc.sig_mr->need_inval = false;
+	else
+		desc->rsc.mr->need_inval = false;
 
 	return 0;
 }
diff --git a/drivers/infiniband/ulp/iser/iser_memory.c b/drivers/infiniband/ulp/iser/iser_memory.c
index 29ae2c6a250a..6efcb79c8efe 100644
--- a/drivers/infiniband/ulp/iser/iser_memory.c
+++ b/drivers/infiniband/ulp/iser/iser_memory.c
@@ -264,7 +264,7 @@ static int iser_reg_sig_mr(struct iscsi_iser_task *iser_task,
 
 	iser_set_prot_checks(iser_task->sc, &sig_attrs->check_mask);
 
-	if (rsc->mr_valid)
+	if (rsc->sig_mr->need_inval)
 		iser_inv_rkey(&tx_desc->inv_wr, mr, cqe, &wr->wr);
 
 	ib_update_fast_reg_key(mr, ib_inc_rkey(mr->rkey));
@@ -288,7 +288,7 @@ static int iser_reg_sig_mr(struct iscsi_iser_task *iser_task,
 	wr->access = IB_ACCESS_LOCAL_WRITE |
 		     IB_ACCESS_REMOTE_READ |
 		     IB_ACCESS_REMOTE_WRITE;
-	rsc->mr_valid = 1;
+	rsc->sig_mr->need_inval = true;
 
 	sig_reg->sge.lkey = mr->lkey;
 	sig_reg->rkey = mr->rkey;
@@ -313,7 +313,7 @@ static int iser_fast_reg_mr(struct iscsi_iser_task *iser_task,
 	struct ib_reg_wr *wr = &tx_desc->reg_wr;
 	int n;
 
-	if (rsc->mr_valid)
+	if (rsc->mr->need_inval)
 		iser_inv_rkey(&tx_desc->inv_wr, mr, cqe, &wr->wr);
 
 	ib_update_fast_reg_key(mr, ib_inc_rkey(mr->rkey));
@@ -336,7 +336,7 @@ static int iser_fast_reg_mr(struct iscsi_iser_task *iser_task,
 		     IB_ACCESS_REMOTE_WRITE |
 		     IB_ACCESS_REMOTE_READ;
 
-	rsc->mr_valid = 1;
+	rsc->mr->need_inval = true;
 
 	reg->sge.lkey = mr->lkey;
 	reg->rkey = mr->rkey;
diff --git a/drivers/infiniband/ulp/iser/iser_verbs.c b/drivers/infiniband/ulp/iser/iser_verbs.c
index 95b8eebf7e04..6801b70dc9e0 100644
--- a/drivers/infiniband/ulp/iser/iser_verbs.c
+++ b/drivers/infiniband/ulp/iser/iser_verbs.c
@@ -129,7 +129,6 @@ iser_create_fastreg_desc(struct iser_device *device,
 			goto err_alloc_mr_integrity;
 		}
 	}
-	desc->rsc.mr_valid = 0;
 
 	return desc;
 
-- 
2.41.0


