Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E637B22F2
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Sep 2023 18:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbjI1QvB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Sep 2023 12:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbjI1Quk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Sep 2023 12:50:40 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF9E1B5;
        Thu, 28 Sep 2023 09:50:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRq5k5CBUYYtCUyl8jazo45SZfs2jRFLaOnqnJB2kCEp5/yXFDM9ek9wT5SMv3OjtcQ+eAoF46DPblGazyrF9FUS2a3NsXnYf5UbMevRJbRYT1SKsPAZYY/06SaBCZUBnaIboqF6mCdG7UluW/jR3bi6zv6T5ZLB04QR1rS43Rzp+/DBhBMMSgYQx6HvbTZCNkNbzlLM/tUep0S6qcxmKOXmCSYFVzrp1F29vfWQqnhn0VVDgn6E+glFhKHojx/gyZYwxQAWebCEzhyoEiFZS+YVYVeQC3uevpI3H920DwSFtajLUuTJiHE1LP5uVp1X9oZelGSlgWsPG9okfCvJBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7XjABeOssKQEWLk+sMbqrIPh+wZaqt2PP7FPEk1w5k=;
 b=OKTjMX5MqF5uC7EVDFt2zferi2ZuImmxb8kYEglC+veFaAf0AhMWJ/cVh7Ys6KG/jhbhL4EtR4cuFYGd8hf1H9+U3YThocFXZ4yTQsrrrLAbkZ1HLrfer6LOfxTGI0dbEaQq0uJWapPUF9H+6O3cA2NTIoPOekx+NXSf6rNjXuWt4uZvYEE3fK5tsdha+jm9FEoV+HSwukykfE/JTowW39Bh8RBJcrv3RNSH09hE5jJ/4uXrBJt9FAobgqWo3fSCImJcznm7dagnUJo0MtLa0gqreTH9SQb+XOSFxWNC/iOegcI18BOCjyh3vUTd6ZuZCu6xh+l4fkpoZ/GjdFZ9Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7XjABeOssKQEWLk+sMbqrIPh+wZaqt2PP7FPEk1w5k=;
 b=G0wJWeiBIREas4vW7f/0t739y9vgwYUGJgU8DysCXhDBY3R4EqdsNpDgDm1nBS7m+wpu78joVY0xykDXpZ4wfTALLRECJFr7dhDMnjtJg5xoYq1Ocu4DwjbJbkZVPLjPY+dav83Lp33ahSsAKhVX2kO9luKWc/lOv7BFfxNbFlWsE6G7ZUkdzI11YZZpBzT3ZAhhqDE6LVn0bWd8AIcvz3ir1bV6JNm2o6HAvVWPrvSaYj4MWMR4/p+IE7P0U+oAP2hza4AUeN6Ta3lCOcXS7x9tyuYcCyaclXStgPxyX9ZkNgyztMsedkhQ5pQuOKdTZ11JHsIW9QxprsiSEhQtXA==
Received: from MW4PR03CA0047.namprd03.prod.outlook.com (2603:10b6:303:8e::22)
 by CH2PR12MB4279.namprd12.prod.outlook.com (2603:10b6:610:af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Thu, 28 Sep
 2023 16:50:18 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:303:8e:cafe::7e) by MW4PR03CA0047.outlook.office365.com
 (2603:10b6:303:8e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22 via Frontend
 Transport; Thu, 28 Sep 2023 16:50:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.9 via Frontend Transport; Thu, 28 Sep 2023 16:50:18 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 28 Sep
 2023 09:50:08 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 28 Sep 2023 09:50:08 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41
 via Frontend Transport; Thu, 28 Sep 2023 09:50:05 -0700
From:   Dragos Tatulea <dtatulea@nvidia.com>
To:     <eperezma@redhat.com>, <gal@nvidia.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Leon Romanovsky <leon@kernel.org>,
        "Saeed Mahameed" <saeedm@nvidia.com>
CC:     <virtualization@lists.linux-foundation.org>,
        Dragos Tatulea <dtatulea@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <netdev@vger.kernel.org>
Subject: [PATCH vhost 14/16] vdpa/mlx5: Enable hw support for vq descriptor mapping
Date:   Thu, 28 Sep 2023 19:45:25 +0300
Message-ID: <20230928164550.980832-16-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928164550.980832-2-dtatulea@nvidia.com>
References: <20230928164550.980832-2-dtatulea@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|CH2PR12MB4279:EE_
X-MS-Office365-Filtering-Correlation-Id: 87dc1fef-c389-46c2-ca05-08dbc042ff11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yhotgiu8Gcj++CnZr5z6D/r06CpAS7Hm4nyOHG+FODr0/RHwZhkQ8BH8L+aqJoYQcCqmfxr7RJ+0e/nkHt5P30avZkAlmxUZs8UhzEoojnCLL0hmVf61KsnIk7Tl6m7a9n+bzF7YOsWzsMCiA6ZChhtgGBX3Fbe8NO5kqT2Yy28uaGDQVUDxij11ZUsqy7D8QzmcrcZ0cWAvrlYpiTIGtOLZkLsGSrdhDmLRQ5m6DLsoVgFd9aCawJv+RjvlVxG5pj/XCc1gDsXGJpEd4lJhPRtkgKw6aI7smMHA4XUYP4icCjyf48efhHmHoM5Qf4y40Stm0vp9+0EGwC0EJhY6K1G1LvV9ij+EVkerZsxklNIjPZqoRdHHTY0SMzOtSxyL8MSg1+u0HcaV2PG5OXyE2GY61rY/yQ5QdXaacY/P2L8nt/oHKRtnnvHsO4M0TJhiG9yIywzEA4094ltPjzrPJ3OFpQVHntbOJzgDMyNMbMo5YdPTTsaUHMzHcUPY2Nv+wgVPcdQRBiw9myhFfF/dZIVp0nLuMSbZssFJ33Ea7I84dbtneAcIp0YtpdJHWJRxAilPRDm1fGPXUkQ9W/ECZISsZ7vjb5MbBjUG1MNacZcNQZzcFxdKlxIbxSTh8hhpLGSfuAyXAm6nGEN2dTx19mqpBIS1Qt27wBohn93X7uyFfe17GCmGACiZmdHiUpqyqMnBrEBzmfWfQKkQsfPpVRs3U5ieUfmIyPCfofO0qJ6MWnW9hE1iZwvQwk11nXDV
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(82310400011)(186009)(40470700004)(46966006)(36840700001)(36860700001)(2906002)(336012)(426003)(36756003)(83380400001)(47076005)(86362001)(82740400003)(26005)(2616005)(1076003)(356005)(7636003)(6666004)(40460700003)(478600001)(5660300002)(6636002)(316002)(8676002)(8936002)(4326008)(40480700001)(54906003)(70206006)(110136005)(70586007)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 16:50:18.1850
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87dc1fef-c389-46c2-ca05-08dbc042ff11
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4279
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Vq descriptor mappings are supported in hardware by filling in an
additional mkey which contains the descriptor mappings to the hw vq.

A previous patch in this series added support for hw mkey (mr) creation
for ASID 1.

This patch fills in both the vq data and vq descriptor mkeys based on
group ASID mapping.

The feature is signaled to the vdpa core through the presence of the
.get_vq_desc_group op.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 26 ++++++++++++++++++++++++--
 include/linux/mlx5/mlx5_ifc_vdpa.h |  7 ++++++-
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 25bd2c324f5b..46441e41892c 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -823,6 +823,7 @@ static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
 	u32 out[MLX5_ST_SZ_DW(create_virtio_net_q_out)] = {};
 	struct mlx5_vdpa_dev *mvdev = &ndev->mvdev;
 	struct mlx5_vdpa_mr *vq_mr;
+	struct mlx5_vdpa_mr *vq_desc_mr;
 	void *obj_context;
 	u16 mlx_features;
 	void *cmd_hdr;
@@ -878,6 +879,11 @@ static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
 	vq_mr = mvdev->mr[mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP]];
 	if (vq_mr)
 		MLX5_SET(virtio_q, vq_ctx, virtio_q_mkey, vq_mr->mkey);
+
+	vq_desc_mr = mvdev->mr[mvdev->group2asid[MLX5_VDPA_DATAVQ_DESC_GROUP]];
+	if (vq_desc_mr)
+		MLX5_SET(virtio_q, vq_ctx, desc_group_mkey, vq_desc_mr->mkey);
+
 	MLX5_SET(virtio_q, vq_ctx, umem_1_id, mvq->umem1.id);
 	MLX5_SET(virtio_q, vq_ctx, umem_1_size, mvq->umem1.size);
 	MLX5_SET(virtio_q, vq_ctx, umem_2_id, mvq->umem2.id);
@@ -2265,6 +2271,16 @@ static u32 mlx5_vdpa_get_vq_group(struct vdpa_device *vdev, u16 idx)
 	return MLX5_VDPA_DATAVQ_GROUP;
 }
 
+static u32 mlx5_vdpa_get_vq_desc_group(struct vdpa_device *vdev, u16 idx)
+{
+	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
+
+	if (is_ctrl_vq_idx(mvdev, idx))
+		return MLX5_VDPA_CVQ_GROUP;
+
+	return MLX5_VDPA_DATAVQ_DESC_GROUP;
+}
+
 static u64 mlx_to_vritio_features(u16 dev_features)
 {
 	u64 result = 0;
@@ -3139,7 +3155,7 @@ static int mlx5_set_group_asid(struct vdpa_device *vdev, u32 group,
 {
 	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
 
-	if (group >= MLX5_VDPA_NUMVQ_GROUPS)
+	if (group >= MLX5_VDPA_NUMVQ_GROUPS || asid >= MLX5_VDPA_NUM_AS)
 		return -EINVAL;
 
 	mvdev->group2asid[group] = asid;
@@ -3160,6 +3176,7 @@ static const struct vdpa_config_ops mlx5_vdpa_ops = {
 	.get_vq_irq = mlx5_get_vq_irq,
 	.get_vq_align = mlx5_vdpa_get_vq_align,
 	.get_vq_group = mlx5_vdpa_get_vq_group,
+	.get_vq_desc_group = mlx5_vdpa_get_vq_desc_group, /* Op disabled if not supported. */
 	.get_device_features = mlx5_vdpa_get_device_features,
 	.set_driver_features = mlx5_vdpa_set_driver_features,
 	.get_driver_features = mlx5_vdpa_get_driver_features,
@@ -3258,6 +3275,7 @@ struct mlx5_vdpa_mgmtdev {
 	struct vdpa_mgmt_dev mgtdev;
 	struct mlx5_adev *madev;
 	struct mlx5_vdpa_net *ndev;
+	struct vdpa_config_ops vdpa_ops;
 };
 
 static int config_func_mtu(struct mlx5_core_dev *mdev, u16 mtu)
@@ -3371,7 +3389,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 		max_vqs = 2;
 	}
 
-	ndev = vdpa_alloc_device(struct mlx5_vdpa_net, mvdev.vdev, mdev->device, &mlx5_vdpa_ops,
+	ndev = vdpa_alloc_device(struct mlx5_vdpa_net, mvdev.vdev, mdev->device, &mgtdev->vdpa_ops,
 				 MLX5_VDPA_NUMVQ_GROUPS, MLX5_VDPA_NUM_AS, name, false);
 	if (IS_ERR(ndev))
 		return PTR_ERR(ndev);
@@ -3546,6 +3564,10 @@ static int mlx5v_probe(struct auxiliary_device *adev,
 		MLX5_CAP_DEV_VDPA_EMULATION(mdev, max_num_virtio_queues) + 1;
 	mgtdev->mgtdev.supported_features = get_supported_features(mdev);
 	mgtdev->madev = madev;
+	mgtdev->vdpa_ops = mlx5_vdpa_ops;
+
+	if (!MLX5_CAP_DEV_VDPA_EMULATION(mdev, desc_group_mkey_supported))
+		mgtdev->vdpa_ops.get_vq_desc_group = NULL;
 
 	err = vdpa_mgmtdev_register(&mgtdev->mgtdev);
 	if (err)
diff --git a/include/linux/mlx5/mlx5_ifc_vdpa.h b/include/linux/mlx5/mlx5_ifc_vdpa.h
index 9becdc3fa503..b86d51a855f6 100644
--- a/include/linux/mlx5/mlx5_ifc_vdpa.h
+++ b/include/linux/mlx5/mlx5_ifc_vdpa.h
@@ -74,7 +74,11 @@ struct mlx5_ifc_virtio_q_bits {
 	u8    reserved_at_320[0x8];
 	u8    pd[0x18];
 
-	u8    reserved_at_340[0xc0];
+	u8    reserved_at_340[0x20];
+
+	u8    desc_group_mkey[0x20];
+
+	u8    reserved_at_380[0x80];
 };
 
 struct mlx5_ifc_virtio_net_q_object_bits {
@@ -141,6 +145,7 @@ enum {
 	MLX5_VIRTQ_MODIFY_MASK_STATE                    = (u64)1 << 0,
 	MLX5_VIRTQ_MODIFY_MASK_DIRTY_BITMAP_PARAMS      = (u64)1 << 3,
 	MLX5_VIRTQ_MODIFY_MASK_DIRTY_BITMAP_DUMP_ENABLE = (u64)1 << 4,
+	MLX5_VIRTQ_MODIFY_MASK_DESC_GROUP_MKEY          = (u64)1 << 14,
 };
 
 enum {
-- 
2.41.0

