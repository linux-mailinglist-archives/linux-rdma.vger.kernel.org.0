Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691DC5B0346
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Sep 2022 13:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiIGLiz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Sep 2022 07:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiIGLiy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Sep 2022 07:38:54 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F2619294
        for <linux-rdma@vger.kernel.org>; Wed,  7 Sep 2022 04:38:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZFj+wNGnqXAbamMMtkutHGomjBCd/Wt5oa4okchXboC1yJNSmGwyhp/vZUCJfN4SUvRr8iFTctDN2lfIi1y4fpb65TrZNAMd4rLDcCpK7L3793Z1zGouQo3BzUhm/hQhghcaslkYzYeMcOHGnVUMCYWBjfYSmoC7Kex/TdhZuZE3q0IXLK29ymFSqqu9hmCTBu6HMcjLawZKPkm/3i0XyWtmNBDNG7tSrVOrESsYePpo0LEAKYO/2L9rzLXOdzUydlsYwBgAnI9xW+RcTtj+Qxq4D0+iuWs3uDszTEC7l/UzqEauie1gRnJtWu9MLLBdEMgPipGtjvEcMaOZ0NBDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5QA4NzJ/9UbXm635TW5A7UQkUTpG42+yzqSTdQK+kAA=;
 b=Y5lmq6OoEhg4WE6wVH3l3LiwOj+JfzomhjJPsPpSgLgae3d69xzGLnyjsByFaxwIjUtL+pgSVKh/LFO8b0zEUCuWQrYMQzsx57wMoyyC7pQjhrxObcoQaOkSu6IqDRPrbVBmwQGmfqqGxTLybQU0ndAGeid4qnDhrcBtUkcsZFAYkXabDmBHiIY43iGrIeRcjRDZjtQSZmZyL9Q1h6mIBL9dT0fl5pqRWucFo+/sLGs4lG2Z0HaBAdIg4DePAoSQUWdyGFTtaWZGwlftiJGdkI5ixtYEN430CGWgTQ1ArEqPNH6DR1By5aO/aFQIBeUl9jro+rO54WIp4zdgBAXvMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5QA4NzJ/9UbXm635TW5A7UQkUTpG42+yzqSTdQK+kAA=;
 b=JMxHFQsOGdidBfjNTKdTuM1nb0lIDZMZOcep2UTflvuFoR7+2J/HXPqsN2HK0VGpC4pDGWGOkppRoUIg9Ro/cMsGiHNrupLCrq92MvyT7lSdDio94izAQHcd4dzJuBNj4z4PS7LivKyMkrnkbx1e7+dg3MYOCHpp96eFEEH+cIcSQCyqHSYWj/Dzs1G1Vj2aJqebYjn2BhXGDkOv/q99hVxqRNNd2RF5py02JfoPPv1jNNCh4ukXSSldnLl0Qoi5cAZOowrSyturZ0scwUudmmS+dUNu+RQxXv+E2uQ5b7Ej3yufYgvsA4b03dt6yIRxkQtC+ujgNJEjgYFktxHaJA==
Received: from MW4PR03CA0284.namprd03.prod.outlook.com (2603:10b6:303:b5::19)
 by SJ0PR12MB5633.namprd12.prod.outlook.com (2603:10b6:a03:428::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Wed, 7 Sep
 2022 11:38:50 +0000
Received: from CO1NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::ce) by MW4PR03CA0284.outlook.office365.com
 (2603:10b6:303:b5::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Wed, 7 Sep 2022 11:38:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT079.mail.protection.outlook.com (10.13.175.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 11:38:50 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Wed, 7 Sep
 2022 11:38:49 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 7 Sep 2022
 04:38:49 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.29 via Frontend Transport; Wed, 7 Sep
 2022 04:38:46 -0700
From:   Patrisious Haddad <phaddad@nvidia.com>
To:     Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
CC:     Patrisious Haddad <phaddad@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux-nvme <linux-nvme@lists.infradead.org>,
        <linux-rdma@vger.kernel.org>,
        Michael Guralnik <michaelgur@nvidia.com>,
        Israel Rukshin <israelr@nvidia.com>,
        Maor Gottlieb <maorg@nvidia.com>,
        "Max Gurtovoy" <mgurtovoy@nvidia.com>
Subject: [PATCH rdma-next 3/4] RDMA/mlx5: Implement ib_get_qp_err_syndrome
Date:   Wed, 7 Sep 2022 14:37:59 +0300
Message-ID: <20220907113800.22182-4-phaddad@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20220907113800.22182-1-phaddad@nvidia.com>
References: <20220907113800.22182-1-phaddad@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT079:EE_|SJ0PR12MB5633:EE_
X-MS-Office365-Filtering-Correlation-Id: b4e5b724-df39-46aa-2b2e-08da90c588db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mDRLabMfT0wUpz/tq2uYDf87rLL585YxYc7wPtjxV8gH49i6hlE7lldKidjCaHofIs/zWiCoqWtlms/mMrqAOYeUSM0quEmA9io9clRpt9tLiqp/yqufY86ewEtN4mdgA9RaFc72TUvtEC3a2HgCAbvtfLpVDWuMOQYXYUxPRbkYkJu8YGRYf7cRZNmo6qRxWaqKxqPy7ArvYXO2Vopi3YHTPDpZ1aHIDKn66Q8bJago+J+/p4uXia+uq3f5EK0KLSAFfzdbOmYc1sRyl3jMbDgjeWj/1JByr91bCCN2daDsi4TLaJm9dENqviftw+RNIYv45+qkLG1375OPSMkqPM/psKje3buEsougMudCCvJMLog2Y8Miei1kd2rII6YB2L1Ly30rDn5f6O5nXUI1JF9gFcKXxNwmVAX2QTpJ6yV+YMrY7JEH6ywxtTPWEbjUol8XMnBSceAsz8m1yznjwV8dW7d346KdPlGvBhXQQp+O5Gkt9sNGtlwSQgESDorQRoHnbMi0j7MgnMHB5BtVUo3f513Nz+VZdZF3OTriurt84rRqOb6EnfoabMbKwwUwASoI9/6VJe+d3HOGsR3qV9rSkBRXDoGULIJJCYili5f8wWpp5mzHL+xFfKPj1xQLF9UdYC0Gl6Nb2ML3J4vwav4f/TmEkqprlmL/9lKimLxRPle9np0YcoDLwCkJUkDpMLtiUOh1N+cyoGqlBA1v3DXDgqa6vGzRRIx/O17Togu+SziGUcWkZfnTF1FSCnlttG7QAUhFvsxHGt7usqGAXG724cXzutZszsR3c2sCx1Y=
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(39860400002)(396003)(346002)(40470700004)(36840700001)(46966006)(41300700001)(426003)(7696005)(86362001)(81166007)(336012)(1076003)(2616005)(6666004)(186003)(26005)(356005)(36860700001)(40460700003)(83380400001)(47076005)(82310400005)(82740400003)(5660300002)(8936002)(316002)(54906003)(36756003)(70586007)(4326008)(40480700001)(107886003)(110136005)(70206006)(478600001)(2906002)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 11:38:50.4274
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e5b724-df39-46aa-2b2e-08da90c588db
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5633
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Implement ib_get_qp_err_syndrome using a query_qp FW call
and return the result in a human readable string.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c    |  1 +
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  1 +
 drivers/infiniband/hw/mlx5/qp.c      | 42 +++++++++++++++++++++++++++-
 drivers/infiniband/hw/mlx5/qp.h      |  2 +-
 drivers/infiniband/hw/mlx5/qpc.c     |  4 ++-
 5 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 7c40efae96a3..c18d3e36542b 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -3716,6 +3716,7 @@ static const struct ib_device_ops mlx5_ib_dev_ops = {
 	.get_dev_fw_str = get_dev_fw_str,
 	.get_dma_mr = mlx5_ib_get_dma_mr,
 	.get_link_layer = mlx5_ib_port_link_layer,
+	.get_qp_err_syndrome = mlx5_ib_get_qp_err_syndrome,
 	.map_mr_sg = mlx5_ib_map_mr_sg,
 	.map_mr_sg_pi = mlx5_ib_map_mr_sg_pi,
 	.mmap = mlx5_ib_mmap,
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 2e2ad3918385..bbd414cbd695 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1232,6 +1232,7 @@ int mlx5_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		      int attr_mask, struct ib_udata *udata);
 int mlx5_ib_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr, int qp_attr_mask,
 		     struct ib_qp_init_attr *qp_init_attr);
+int mlx5_ib_get_qp_err_syndrome(struct ib_qp *ibqp, char *str);
 int mlx5_ib_destroy_qp(struct ib_qp *qp, struct ib_udata *udata);
 void mlx5_ib_drain_sq(struct ib_qp *qp);
 void mlx5_ib_drain_rq(struct ib_qp *qp);
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 40d9410ec303..7cf2fe549b9a 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -4806,7 +4806,8 @@ static int query_qp_attr(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 	if (!outb)
 		return -ENOMEM;
 
-	err = mlx5_core_qp_query(dev, &qp->trans_qp.base.mqp, outb, outlen);
+	err = mlx5_core_qp_query(dev, &qp->trans_qp.base.mqp, outb, outlen,
+				 false);
 	if (err)
 		goto out;
 
@@ -4992,6 +4993,45 @@ int mlx5_ib_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 	return err;
 }
 
+int mlx5_ib_get_qp_err_syndrome(struct ib_qp *ibqp, char *str)
+{
+	struct mlx5_ib_dev *dev = to_mdev(ibqp->device);
+	int outlen = MLX5_ST_SZ_BYTES(query_qp_out);
+	struct mlx5_ib_qp *qp = to_mqp(ibqp);
+	void *pas_ext_union, *err_syn;
+	u32 *outb;
+	int err;
+
+	if (!MLX5_CAP_GEN(dev->mdev, qpc_extension) ||
+	    !MLX5_CAP_GEN(dev->mdev, qp_error_syndrome))
+		return -EOPNOTSUPP;
+
+	outb = kzalloc(outlen, GFP_KERNEL);
+	if (!outb)
+		return -ENOMEM;
+
+	err = mlx5_core_qp_query(dev, &qp->trans_qp.base.mqp, outb, outlen,
+				 true);
+	if (err)
+		goto out;
+
+	pas_ext_union =
+		MLX5_ADDR_OF(query_qp_out, outb, qp_pas_or_qpc_ext_and_pas);
+	err_syn = MLX5_ADDR_OF(qpc_extension_and_pas_list_in, pas_ext_union,
+			       qpc_data_extension.error_syndrome);
+
+	scnprintf(str, IB_ERR_SYNDROME_LENGTH, "%s (0x%x 0x%x 0x%x)\n",
+		  ib_wc_status_msg(
+			  MLX5_GET(cqe_error_syndrome, err_syn, syndrome)),
+		  MLX5_GET(cqe_error_syndrome, err_syn, vendor_error_syndrome),
+		  MLX5_GET(cqe_error_syndrome, err_syn, hw_syndrome_type),
+		  MLX5_GET(cqe_error_syndrome, err_syn, hw_error_syndrome));
+
+out:
+	kfree(outb);
+	return err;
+}
+
 int mlx5_ib_alloc_xrcd(struct ib_xrcd *ibxrcd, struct ib_udata *udata)
 {
 	struct mlx5_ib_dev *dev = to_mdev(ibxrcd->device);
diff --git a/drivers/infiniband/hw/mlx5/qp.h b/drivers/infiniband/hw/mlx5/qp.h
index 5d4e140db99c..8d792ca00b32 100644
--- a/drivers/infiniband/hw/mlx5/qp.h
+++ b/drivers/infiniband/hw/mlx5/qp.h
@@ -20,7 +20,7 @@ int mlx5_core_qp_modify(struct mlx5_ib_dev *dev, u16 opcode, u32 opt_param_mask,
 int mlx5_core_destroy_qp(struct mlx5_ib_dev *dev, struct mlx5_core_qp *qp);
 int mlx5_core_destroy_dct(struct mlx5_ib_dev *dev, struct mlx5_core_dct *dct);
 int mlx5_core_qp_query(struct mlx5_ib_dev *dev, struct mlx5_core_qp *qp,
-		       u32 *out, int outlen);
+		       u32 *out, int outlen, bool qpc_ext);
 int mlx5_core_dct_query(struct mlx5_ib_dev *dev, struct mlx5_core_dct *dct,
 			u32 *out, int outlen);
 
diff --git a/drivers/infiniband/hw/mlx5/qpc.c b/drivers/infiniband/hw/mlx5/qpc.c
index 542e4c63a8de..7a1854aab441 100644
--- a/drivers/infiniband/hw/mlx5/qpc.c
+++ b/drivers/infiniband/hw/mlx5/qpc.c
@@ -504,12 +504,14 @@ void mlx5_cleanup_qp_table(struct mlx5_ib_dev *dev)
 }
 
 int mlx5_core_qp_query(struct mlx5_ib_dev *dev, struct mlx5_core_qp *qp,
-		       u32 *out, int outlen)
+		       u32 *out, int outlen, bool qpc_ext)
 {
 	u32 in[MLX5_ST_SZ_DW(query_qp_in)] = {};
 
 	MLX5_SET(query_qp_in, in, opcode, MLX5_CMD_OP_QUERY_QP);
 	MLX5_SET(query_qp_in, in, qpn, qp->qpn);
+	MLX5_SET(query_qp_in, in, qpc_ext, qpc_ext);
+
 	return mlx5_cmd_exec(dev->mdev, in, sizeof(in), out, outlen);
 }
 
-- 
2.18.1

