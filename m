Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61CF3282753
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Oct 2020 01:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgJCXUb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 3 Oct 2020 19:20:31 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:16004 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbgJCXUb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 3 Oct 2020 19:20:31 -0400
Received: from HKMAIL104.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f79073b0000>; Sun, 04 Oct 2020 07:20:27 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 3 Oct
 2020 23:20:21 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.50) by
 HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Sat, 3 Oct 2020 23:20:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9vRfTNFeqKNMIT+T/wlEF30pVnpXoRxUgTI/x9uBIWw7T4EyXlIsGnsKbnJ0XbRnWKOwctqf0z3C8xYpipMunZYwnxGn3njzzmUz+wafeHJA7K9mJc41DYgcih8sURjYyZ3jQ+BUE4hfyclEO9g1n/NdPMTZIFRWmPQJ9K9XEec935GMQvUiVyeG4QHKTwLZg99hRrt8rg3o/6VmSqfBsg2SPL4EsWnL/GzbJ8cICCvNJL21hpUXDUAzTKKSsLudbKRwFqn++v+l+I3FXJ1S1q0U73frzRZY8qvm7lThLjtDFF2tYURJSLAdbShOLYjbhnaImM1M2bTN7tBKeY9Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHg3Ragyp61K3CdejImAv7nXdMUCOOWhb7ZiODPekfE=;
 b=gmleRq8s4kRAzA2CFIb+DMg74M679BSJ7gT8fMSnsZGovTxeDvPItFxUAMeSAynDykn+ubCUat/YuE0u7UsNBfpO38H1t7yGv4naz4JQoESflO8qlreFcIlbmB8GCuuJirgjXeGQx0xBNGdZU4SQHUBHKaTqI+y/zS7GR3MG+6stt/L8u0k5xvFh5UfbI60iXYvk/LDCbWjcufJGJeUapmfu1EnOkj0MOjfHUGNy/mMzTXxWQYDmXo12SJgdLxiasPL7u7ArMG6timjyIfmRskBfgQILhbo61RB9ktiyHY2AvWP8u/kUQTadi3YbosGln32gpdQywpTPNew477tsMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2582.namprd12.prod.outlook.com (2603:10b6:4:b5::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Sat, 3 Oct
 2020 23:20:16 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.038; Sat, 3 Oct 2020
 23:20:16 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Doug Ledford <dledford@redhat.com>,
        Gal Pressman <galpress@amazon.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Leon Romanovsky <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, Weihang Li <liweihang@huawei.com>,
        Lijun Ou <oulijun@huawei.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH 02/11] RDMA: Remove uverbs_ex_cmd_mask values that are linked to functions
Date:   Sat, 3 Oct 2020 20:20:02 -0300
Message-ID: <2-v1-caa70ba3d1ab+1436e-ucmd_mask_jgg@nvidia.com>
In-Reply-To: <0-v1-caa70ba3d1ab+1436e-ucmd_mask_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0026.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::39) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR15CA0026.namprd15.prod.outlook.com (2603:10b6:208:1b4::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.36 via Frontend Transport; Sat, 3 Oct 2020 23:20:14 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kOqp1-0075cJ-IB; Sat, 03 Oct 2020 20:20:11 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601767227; bh=SnYxxjZU2go6MAvUVATu3RCcB7VRBhNg+qxhVLIwIBI=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         Subject:Date:Message-ID:In-Reply-To:References:
         Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
         MIME-Version:X-MS-Exchange-MessageSentRepresentingType;
        b=aSToz0H9/cGdOc6WJtTWh/44UYHm9U3qoRR/3FqvZ/WKzF4jY7qgVsGJq3l1HFLxv
         fWKTqkceLKQXMHgcfpJDjWYZNqFvNYMXxgCwi3Z2/u8Ibc1/pUzbsJgt6AZUj2CZFf
         gb/5MOJ8kqcm35CzFfXKev4oz6f1Qk/Iwa4FTGPDN4LXWALUI/6nuYb39UwNyE0Vu3
         BAJalnnzro16xyo5sG8Sw9fOqvR+ZXgE33PT7CLkmXHoiuM9Ps0VznILchj6UTllMV
         QyHrIHpROJYlp6OD88EWlBr/kcW8eRYFFJ/DxxfJ38OKy8SjPy5hySeyoLj577yDjS
         +RNY/u94gIc1A==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Since a while now the uverbs layer checks if the driver implements a
function before allowing the ucmd to proceed. This largely obsoletes the
cmd_mask stuff, but there is some tricky bits in drivers preventing it
from being removed.

Remove the easy elements of uverbs_ex_cmd_mask by pre-setting them in the
core code. These are triggered soley based on the related ops function
pointer.

query_device_ex is not triggered based on an op, but all drivers already
implement something compatible with the extension, so enable it globally
too.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/device.c           | 11 +++++++++++
 drivers/infiniband/core/uverbs_cmd.c       |  2 +-
 drivers/infiniband/hw/efa/efa_main.c       |  3 ---
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c |  7 -------
 drivers/infiniband/hw/hns/hns_roce_main.c  |  2 --
 drivers/infiniband/hw/mlx4/main.c          | 14 +-------------
 drivers/infiniband/hw/mlx5/main.c          | 14 ++------------
 7 files changed, 15 insertions(+), 38 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/dev=
ice.c
index ec3becf85cac42..647abbfc9a9c60 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -600,6 +600,17 @@ struct ib_device *_ib_alloc_device(size_t size)
 	init_completion(&device->unreg_completion);
 	INIT_WORK(&device->unregistration_work, ib_unregister_work);
=20
+	device->uverbs_ex_cmd_mask =3D
+		BIT_ULL(IB_USER_VERBS_EX_CMD_CREATE_FLOW) |
+		BIT_ULL(IB_USER_VERBS_EX_CMD_CREATE_RWQ_IND_TBL) |
+		BIT_ULL(IB_USER_VERBS_EX_CMD_CREATE_WQ) |
+		BIT_ULL(IB_USER_VERBS_EX_CMD_DESTROY_FLOW) |
+		BIT_ULL(IB_USER_VERBS_EX_CMD_DESTROY_RWQ_IND_TBL) |
+		BIT_ULL(IB_USER_VERBS_EX_CMD_DESTROY_WQ) |
+		BIT_ULL(IB_USER_VERBS_EX_CMD_MODIFY_CQ) |
+		BIT_ULL(IB_USER_VERBS_EX_CMD_MODIFY_WQ) |
+		BIT_ULL(IB_USER_VERBS_EX_CMD_QUERY_DEVICE);
+
 	return device;
 }
 EXPORT_SYMBOL(_ib_alloc_device);
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core=
/uverbs_cmd.c
index 418d133a8fb080..2f3f9b87922e92 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -3753,7 +3753,7 @@ const struct uapi_definition uverbs_def_write_intf[] =
=3D {
 			IB_USER_VERBS_EX_CMD_MODIFY_CQ,
 			ib_uverbs_ex_modify_cq,
 			UAPI_DEF_WRITE_I(struct ib_uverbs_ex_modify_cq),
-			UAPI_DEF_METHOD_NEEDS_FN(create_cq))),
+			UAPI_DEF_METHOD_NEEDS_FN(modify_cq))),
=20
 	DECLARE_UVERBS_OBJECT(
 		UVERBS_OBJECT_DEVICE,
diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/e=
fa/efa_main.c
index 92d7011463203c..5cc746a6327ece 100644
--- a/drivers/infiniband/hw/efa/efa_main.c
+++ b/drivers/infiniband/hw/efa/efa_main.c
@@ -326,9 +326,6 @@ static int efa_ib_device_add(struct efa_dev *dev)
 		(1ull << IB_USER_VERBS_CMD_CREATE_AH) |
 		(1ull << IB_USER_VERBS_CMD_DESTROY_AH);
=20
-	dev->ibdev.uverbs_ex_cmd_mask =3D
-		(1ull << IB_USER_VERBS_EX_CMD_QUERY_DEVICE);
-
 	ib_set_device_ops(&dev->ibdev, &efa_dev_ops);
=20
 	err =3D ib_register_device(&dev->ibdev, "efa_%d");
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniban=
d/hw/hns/hns_roce_hw_v1.c
index 5f4d8a32ed6d9d..b3d5ba8ef439a3 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -2062,11 +2062,6 @@ static void hns_roce_v1_write_cqc(struct hns_roce_de=
v *hr_dev,
 		       CQ_CONTEXT_CQC_BYTE_32_CQ_CONS_IDX_S, 0);
 }
=20
-static int hns_roce_v1_modify_cq(struct ib_cq *cq, u16 cq_count, u16 cq_pe=
riod)
-{
-	return -EOPNOTSUPP;
-}
-
 static int hns_roce_v1_req_notify_cq(struct ib_cq *ibcq,
 				     enum ib_cq_notify_flags flags)
 {
@@ -4347,7 +4342,6 @@ static void hns_roce_v1_cleanup_eq_table(struct hns_r=
oce_dev *hr_dev)
=20
 static const struct ib_device_ops hns_roce_v1_dev_ops =3D {
 	.destroy_qp =3D hns_roce_v1_destroy_qp,
-	.modify_cq =3D hns_roce_v1_modify_cq,
 	.poll_cq =3D hns_roce_v1_poll_cq,
 	.post_recv =3D hns_roce_v1_post_recv,
 	.post_send =3D hns_roce_v1_post_send,
@@ -4367,7 +4361,6 @@ static const struct hns_roce_hw hns_roce_hw_v1 =3D {
 	.set_mtu =3D hns_roce_v1_set_mtu,
 	.write_mtpt =3D hns_roce_v1_write_mtpt,
 	.write_cqc =3D hns_roce_v1_write_cqc,
-	.modify_cq =3D hns_roce_v1_modify_cq,
 	.clear_hem =3D hns_roce_v1_clear_hem,
 	.modify_qp =3D hns_roce_v1_modify_qp,
 	.query_qp =3D hns_roce_v1_query_qp,
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband=
/hw/hns/hns_roce_main.c
index 467c829000190b..f3fe5aeaab8445 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -507,8 +507,6 @@ static int hns_roce_register_device(struct hns_roce_dev=
 *hr_dev)
 		(1ULL << IB_USER_VERBS_CMD_QUERY_QP) |
 		(1ULL << IB_USER_VERBS_CMD_DESTROY_QP);
=20
-	ib_dev->uverbs_ex_cmd_mask |=3D (1ULL << IB_USER_VERBS_EX_CMD_MODIFY_CQ);
-
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_REREG_MR) {
 		ib_dev->uverbs_cmd_mask |=3D (1ULL << IB_USER_VERBS_CMD_REREG_MR);
 		ib_set_device_ops(ib_dev, &hns_roce_dev_mr_ops);
diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4=
/main.c
index 753c7040249887..37d31d239a22e0 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -2685,8 +2685,6 @@ static void *mlx4_ib_add(struct mlx4_dev *dev)
=20
 	ib_set_device_ops(&ibdev->ib_dev, &mlx4_ib_dev_ops);
 	ibdev->ib_dev.uverbs_ex_cmd_mask |=3D
-		(1ull << IB_USER_VERBS_EX_CMD_MODIFY_CQ) |
-		(1ull << IB_USER_VERBS_EX_CMD_QUERY_DEVICE) |
 		(1ull << IB_USER_VERBS_EX_CMD_CREATE_CQ) |
 		(1ull << IB_USER_VERBS_EX_CMD_CREATE_QP);
=20
@@ -2694,15 +2692,8 @@ static void *mlx4_ib_add(struct mlx4_dev *dev)
 	    ((mlx4_ib_port_link_layer(&ibdev->ib_dev, 1) =3D=3D
 	    IB_LINK_LAYER_ETHERNET) ||
 	    (mlx4_ib_port_link_layer(&ibdev->ib_dev, 2) =3D=3D
-	    IB_LINK_LAYER_ETHERNET))) {
-		ibdev->ib_dev.uverbs_ex_cmd_mask |=3D
-			(1ull << IB_USER_VERBS_EX_CMD_CREATE_WQ)	  |
-			(1ull << IB_USER_VERBS_EX_CMD_MODIFY_WQ)	  |
-			(1ull << IB_USER_VERBS_EX_CMD_DESTROY_WQ)	  |
-			(1ull << IB_USER_VERBS_EX_CMD_CREATE_RWQ_IND_TBL) |
-			(1ull << IB_USER_VERBS_EX_CMD_DESTROY_RWQ_IND_TBL);
+	    IB_LINK_LAYER_ETHERNET)))
 		ib_set_device_ops(&ibdev->ib_dev, &mlx4_ib_dev_wq_ops);
-	}
=20
 	if (dev->caps.flags & MLX4_DEV_CAP_FLAG_MEM_WINDOW ||
 	    dev->caps.bmme_flags & MLX4_BMME_FLAG_TYPE_2_WIN) {
@@ -2721,9 +2712,6 @@ static void *mlx4_ib_add(struct mlx4_dev *dev)
=20
 	if (check_flow_steering_support(dev)) {
 		ibdev->steering_support =3D MLX4_STEERING_MODE_DEVICE_MANAGED;
-		ibdev->ib_dev.uverbs_ex_cmd_mask	|=3D
-			(1ull << IB_USER_VERBS_EX_CMD_CREATE_FLOW) |
-			(1ull << IB_USER_VERBS_EX_CMD_DESTROY_FLOW);
 		ib_set_device_ops(&ibdev->ib_dev, &mlx4_ib_dev_fs_ops);
 	}
=20
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5=
/main.c
index 7082172b5b61a1..09e5d9e7859dcd 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4166,14 +4166,10 @@ static int mlx5_ib_stage_caps_init(struct mlx5_ib_d=
ev *dev)
 		(1ull << IB_USER_VERBS_CMD_DESTROY_SRQ)		|
 		(1ull << IB_USER_VERBS_CMD_CREATE_XSRQ)		|
 		(1ull << IB_USER_VERBS_CMD_OPEN_QP);
-	dev->ib_dev.uverbs_ex_cmd_mask =3D
-		(1ull << IB_USER_VERBS_EX_CMD_QUERY_DEVICE)	|
+	dev->ib_dev.uverbs_ex_cmd_mask |=3D
 		(1ull << IB_USER_VERBS_EX_CMD_CREATE_CQ)	|
 		(1ull << IB_USER_VERBS_EX_CMD_CREATE_QP)	|
-		(1ull << IB_USER_VERBS_EX_CMD_MODIFY_QP)	|
-		(1ull << IB_USER_VERBS_EX_CMD_MODIFY_CQ)	|
-		(1ull << IB_USER_VERBS_EX_CMD_CREATE_FLOW)	|
-		(1ull << IB_USER_VERBS_EX_CMD_DESTROY_FLOW);
+		(1ull << IB_USER_VERBS_EX_CMD_MODIFY_QP);
=20
 	if (MLX5_CAP_GEN(mdev, ipoib_enhanced_offloads) &&
 	    IS_ENABLED(CONFIG_MLX5_CORE_IPOIB))
@@ -4276,12 +4272,6 @@ static int mlx5_ib_roce_init(struct mlx5_ib_dev *dev=
)
 	ll =3D mlx5_port_type_cap_to_rdma_ll(port_type_cap);
=20
 	if (ll =3D=3D IB_LINK_LAYER_ETHERNET) {
-		dev->ib_dev.uverbs_ex_cmd_mask |=3D
-			(1ull << IB_USER_VERBS_EX_CMD_CREATE_WQ) |
-			(1ull << IB_USER_VERBS_EX_CMD_MODIFY_WQ) |
-			(1ull << IB_USER_VERBS_EX_CMD_DESTROY_WQ) |
-			(1ull << IB_USER_VERBS_EX_CMD_CREATE_RWQ_IND_TBL) |
-			(1ull << IB_USER_VERBS_EX_CMD_DESTROY_RWQ_IND_TBL);
 		ib_set_device_ops(&dev->ib_dev, &mlx5_ib_dev_common_roce_ops);
=20
 		port_num =3D mlx5_core_native_port_num(dev->mdev) - 1;
--=20
2.28.0

