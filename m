Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55E99282752
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Oct 2020 01:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgJCXU3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 3 Oct 2020 19:20:29 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:14534 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbgJCXU3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 3 Oct 2020 19:20:29 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7907300001>; Sat, 03 Oct 2020 16:20:16 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 3 Oct
 2020 23:20:16 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.54) by
 HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Sat, 3 Oct 2020 23:20:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJjEwIgrzofR53D72HSRZOjAkg7jImSM5ZFPBOiyZp09oAAixQU5ApV/u3nC/J3ij9F0BQJz3G3Nbkx9V73b4nMc1rvZ9oZ6T5i+xvghWQLd9J+o0rgqpZCG4wzmixX462+Agqyh7fXezX7qXPZwmRzjgD6OrC5GiqRobjMqNpTfhjzBrUNWSEH/YzgCIA5zwCKpxUkf0xizO+jT0MTuHWi5n3K4ftrK2Cb4QciX0x2GN9E494DoJnuPSooNWtLCJasGODuCnbcl8xHYOihAofzkvdEGwIExNLHI51rbr4mWcQuS2MTJOLe4mI7lXmqf2yDQYwZengoaogBQ0LvARw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqK9n6eiARrxM8GBAoR33zuRawEJX6VIhOkjT9VNsm8=;
 b=Z1UTM1UiELXEyHO7z/Ts8RagwZso6PuFxIYiOHePLPvNw7QNYPhsfXSD1xat/lDqX24BEcSoKsVpzckm02MfjD7Ei19ODhBXN4iFjyUEYtzWOjGPH6zA5VD7Jwg60ufLvhMnUVK7Wt7/33CYq4AieIs6DG+r7GrMA+/nvtJUrFfxVaQh8RMRwN4NidOJo+pGf5hD8KEJWV6fzRQuMGkKfY483UA58LNWkSz/3w58K1wIvbJGJGb2tiwU2J7IFHfTqiasRYj7EsZxRTNj7HrChOen7GX0X7zWpiEQLkuWNN7Sa2ojR19yT9ohs9VOpGi0x3l+3bdZjObzyKPGz+0ifA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2582.namprd12.prod.outlook.com (2603:10b6:4:b5::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Sat, 3 Oct
 2020 23:20:15 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.038; Sat, 3 Oct 2020
 23:20:15 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Adit Ranadive <aditr@vmware.com>, Ariel Elior <aelior@marvell.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        "Doug Ledford" <dledford@redhat.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Leon Romanovsky <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, Weihang Li <liweihang@huawei.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        Lijun Ou <oulijun@huawei.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        "Zhu Yanjun" <yanjunz@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH 05/11] RDMA: Check srq_type during create_srq
Date:   Sat, 3 Oct 2020 20:20:05 -0300
Message-ID: <5-v1-caa70ba3d1ab+1436e-ucmd_mask_jgg@nvidia.com>
In-Reply-To: <0-v1-caa70ba3d1ab+1436e-ucmd_mask_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BL0PR0102CA0070.prod.exchangelabs.com
 (2603:10b6:208:25::47) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR0102CA0070.prod.exchangelabs.com (2603:10b6:208:25::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34 via Frontend Transport; Sat, 3 Oct 2020 23:20:13 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kOqp1-0075cU-Nw; Sat, 03 Oct 2020 20:20:11 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601767216; bh=bdGr59aEIg1a3BbhFBv8mW8wI7pQa4gn5/l5n5kxRMs=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         Subject:Date:Message-ID:In-Reply-To:References:
         Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
         MIME-Version:X-MS-Exchange-MessageSentRepresentingType;
        b=XDFtNNjhukoCqT0FPIIAE+WyEOwzbXKdM5Y/wF2OsOtdiJzSEir+3u13QoTbia5q6
         c3bPbvW5gsji8gaj0e9/fEiJDDL5VNxQlqhjEkoG6E0OUavM2XwpwtpIdKZ1DjIpQX
         elL9nPYNH72ikHBZH5nUlZ/w4qcmcCV3zZQ5jDF7jt2RqBgsXAWGivXm8Kfm8HVCgm
         HnB2lYY+uEJKuk7oMiQhfvHU/QWUeL0k9RUICwH+6tSsNhTeQSZvOI/wqbhwGlHleb
         PTIRgvHwDQ+99xJShzA0UaicTTOYcfQdOadMJQb7kYuXUBs0XArR4IW6HnyooZ2Fbj
         NCpktq+8hUNpQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

uverbs was blocking srq_types the driver doesn't support based on the
CREATE_XSRQ cmd_mask. Fix all drivers to check for supported srq_types
during create_srq and move CREATE_XSRQ to the core code.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/device.c              | 1 +
 drivers/infiniband/hw/cxgb4/qp.c              | 3 +++
 drivers/infiniband/hw/hns/hns_roce_srq.c      | 4 ++++
 drivers/infiniband/hw/mlx4/main.c             | 3 ---
 drivers/infiniband/hw/mlx4/srq.c              | 4 ++++
 drivers/infiniband/hw/mlx5/main.c             | 3 +--
 drivers/infiniband/hw/mlx5/srq.c              | 5 +++++
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c   | 3 +++
 drivers/infiniband/hw/qedr/main.c             | 3 ---
 drivers/infiniband/hw/qedr/verbs.c            | 4 ++++
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c | 2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c         | 3 +++
 drivers/infiniband/sw/siw/siw_verbs.c         | 3 +++
 13 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/dev=
ice.c
index 7d70ecdc32cc2e..75e6e68688c6d0 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -610,6 +610,7 @@ struct ib_device *_ib_alloc_device(size_t size)
 		BIT_ULL(IB_USER_VERBS_CMD_CREATE_CQ) |
 		BIT_ULL(IB_USER_VERBS_CMD_CREATE_QP) |
 		BIT_ULL(IB_USER_VERBS_CMD_CREATE_SRQ) |
+		BIT_ULL(IB_USER_VERBS_CMD_CREATE_XSRQ) |
 		BIT_ULL(IB_USER_VERBS_CMD_DEALLOC_MW) |
 		BIT_ULL(IB_USER_VERBS_CMD_DEALLOC_PD) |
 		BIT_ULL(IB_USER_VERBS_CMD_DEREG_MR) |
diff --git a/drivers/infiniband/hw/cxgb4/qp.c b/drivers/infiniband/hw/cxgb4=
/qp.c
index f20379e4e2ec22..d2b46c5c1645e4 100644
--- a/drivers/infiniband/hw/cxgb4/qp.c
+++ b/drivers/infiniband/hw/cxgb4/qp.c
@@ -2680,6 +2680,9 @@ int c4iw_create_srq(struct ib_srq *ib_srq, struct ib_=
srq_init_attr *attrs,
 	int ret;
 	int wr_len;
=20
+	if (attrs->srq_type !=3D IB_SRQT_BASIC)
+		return -EOPNOTSUPP;
+
 	pr_debug("%s ib_pd %p\n", __func__, pd);
=20
 	php =3D to_c4iw_pd(pd);
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/=
hw/hns/hns_roce_srq.c
index 8caf74e44efd96..27646b9e35dfd2 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -288,6 +288,10 @@ int hns_roce_create_srq(struct ib_srq *ib_srq,
 	int ret;
 	u32 cqn;
=20
+	if (init_attr->srq_type !=3D IB_SRQT_BASIC &&
+	    init_attr->srq_type !=3D IB_SRQT_XRC)
+		return -EOPNOTSUPP;
+
 	/* Check the actual SRQ wqe and SRQ sge num */
 	if (init_attr->attr.max_wr >=3D hr_dev->caps.max_srq_wrs ||
 	    init_attr->attr.max_sge > hr_dev->caps.max_srq_sges)
diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4=
/main.c
index f251a57478f3e7..6216dfe6e9c79c 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -2657,9 +2657,6 @@ static void *mlx4_ib_add(struct mlx4_dev *dev)
 	ibdev->ib_dev.num_comp_vectors	=3D dev->caps.num_comp_vectors;
 	ibdev->ib_dev.dev.parent	=3D &dev->persist->pdev->dev;
=20
-	ibdev->ib_dev.uverbs_cmd_mask |=3D
-		(1ull << IB_USER_VERBS_CMD_CREATE_XSRQ);
-
 	ib_set_device_ops(&ibdev->ib_dev, &mlx4_ib_dev_ops);
 	ibdev->ib_dev.uverbs_ex_cmd_mask |=3D
 		(1ull << IB_USER_VERBS_EX_CMD_CREATE_CQ) |
diff --git a/drivers/infiniband/hw/mlx4/srq.c b/drivers/infiniband/hw/mlx4/=
srq.c
index bf618529e734d2..6a381751c0d8ee 100644
--- a/drivers/infiniband/hw/mlx4/srq.c
+++ b/drivers/infiniband/hw/mlx4/srq.c
@@ -86,6 +86,10 @@ int mlx4_ib_create_srq(struct ib_srq *ib_srq,
 	int err;
 	int i;
=20
+	if (init_attr->srq_type !=3D IB_SRQT_BASIC &&
+	    init_attr->srq_type !=3D IB_SRQT_XRC)
+		return -EOPNOTSUPP;
+
 	/* Sanity check SRQ size before proceeding */
 	if (init_attr->attr.max_wr  >=3D dev->dev->caps.max_srq_wqes ||
 	    init_attr->attr.max_sge >  dev->dev->caps.max_srq_sge)
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5=
/main.c
index 83434d080023a8..7f03ffabddbe87 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4141,8 +4141,7 @@ static int mlx5_ib_stage_caps_init(struct mlx5_ib_dev=
 *dev)
=20
 	dev->ib_dev.uverbs_cmd_mask |=3D
 		(1ull << IB_USER_VERBS_CMD_CREATE_AH)		|
-		(1ull << IB_USER_VERBS_CMD_DESTROY_AH)		|
-		(1ull << IB_USER_VERBS_CMD_CREATE_XSRQ);
+		(1ull << IB_USER_VERBS_CMD_DESTROY_AH);
 	dev->ib_dev.uverbs_ex_cmd_mask |=3D
 		(1ull << IB_USER_VERBS_EX_CMD_CREATE_CQ)	|
 		(1ull << IB_USER_VERBS_EX_CMD_CREATE_QP)	|
diff --git a/drivers/infiniband/hw/mlx5/srq.c b/drivers/infiniband/hw/mlx5/=
srq.c
index e2f720eec1e18b..12d485872e7716 100644
--- a/drivers/infiniband/hw/mlx5/srq.c
+++ b/drivers/infiniband/hw/mlx5/srq.c
@@ -226,6 +226,11 @@ int mlx5_ib_create_srq(struct ib_srq *ib_srq,
 	struct mlx5_srq_attr in =3D {};
 	__u32 max_srq_wqes =3D 1 << MLX5_CAP_GEN(dev->mdev, log_max_srq_sz);
=20
+	if (init_attr->srq_type !=3D IB_SRQT_BASIC &&
+	    init_attr->srq_type !=3D IB_SRQT_XRC &&
+	    init_attr->srq_type !=3D IB_SRQT_TM)
+		return -EOPNOTSUPP;
+
 	/* Sanity check SRQ size before proceeding */
 	if (init_attr->attr.max_wr >=3D max_srq_wqes) {
 		mlx5_ib_dbg(dev, "max_wr %d, cap %d\n",
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniba=
nd/hw/ocrdma/ocrdma_verbs.c
index 7350fe16f164d3..b392e15d7592b6 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -1770,6 +1770,9 @@ int ocrdma_create_srq(struct ib_srq *ibsrq, struct ib=
_srq_init_attr *init_attr,
 	struct ocrdma_dev *dev =3D get_ocrdma_dev(ibsrq->device);
 	struct ocrdma_srq *srq =3D get_ocrdma_srq(ibsrq);
=20
+	if (init_attr->srq_type !=3D IB_SRQT_BASIC)
+		return -EOPNOTSUPP;
+
 	if (init_attr->attr.max_sge > dev->attr.max_recv_sge)
 		return -EINVAL;
 	if (init_attr->attr.max_wr > dev->attr.max_rqe)
diff --git a/drivers/infiniband/hw/qedr/main.c b/drivers/infiniband/hw/qedr=
/main.c
index 81d7d64fabc98f..d50ee9eacd463d 100644
--- a/drivers/infiniband/hw/qedr/main.c
+++ b/drivers/infiniband/hw/qedr/main.c
@@ -188,9 +188,6 @@ static void qedr_roce_register_device(struct qedr_dev *=
dev)
 	dev->ibdev.node_type =3D RDMA_NODE_IB_CA;
=20
 	ib_set_device_ops(&dev->ibdev, &qedr_roce_dev_ops);
-
-	dev->ibdev.uverbs_cmd_mask |=3D
-		QEDR_UVERBS(CREATE_XSRQ);
 }
=20
 static const struct ib_device_ops qedr_dev_ops =3D {
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qed=
r/verbs.c
index 019642ff24a704..29a96ff6fc66b6 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -1546,6 +1546,10 @@ int qedr_create_srq(struct ib_srq *ibsrq, struct ib_=
srq_init_attr *init_attr,
 		 "create SRQ called from %s (pd %p)\n",
 		 (udata) ? "User lib" : "kernel", pd);
=20
+	if (init_attr->srq_type !=3D IB_SRQT_BASIC &&
+	    init_attr->srq_type !=3D IB_SRQT_XRC)
+		return -EOPNOTSUPP;
+
 	rc =3D qedr_check_srq_params(dev, init_attr, udata);
 	if (rc)
 		return -EINVAL;
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c b/drivers/infini=
band/hw/vmw_pvrdma/pvrdma_srq.c
index 082208f9aa9006..bdc2703532c6cc 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c
@@ -121,7 +121,7 @@ int pvrdma_create_srq(struct ib_srq *ibsrq, struct ib_s=
rq_init_attr *init_attr,
 		dev_warn(&dev->pdev->dev,
 			 "shared receive queue type %d not supported\n",
 			 init_attr->srq_type);
-		return -EINVAL;
+		return -EOPNOTSUPP;
 	}
=20
 	if (init_attr->attr.max_wr  > dev->dsr->caps.max_srq_wr ||
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/=
rxe/rxe_verbs.c
index 5f47f21c2958d3..38e603260cfc43 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -265,6 +265,9 @@ static int rxe_create_srq(struct ib_srq *ibsrq, struct =
ib_srq_init_attr *init,
 	struct rxe_srq *srq =3D to_rsrq(ibsrq);
 	struct rxe_create_srq_resp __user *uresp =3D NULL;
=20
+	if (init->srq_type !=3D IB_SRQT_BASIC)
+		return -EOPNOTSUPP;
+
 	if (udata) {
 		if (udata->outlen < sizeof(*uresp))
 			return -EINVAL;
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/=
siw/siw_verbs.c
index 7cf3242ffb41f9..1c469f967ab9b2 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -1555,6 +1555,9 @@ int siw_create_srq(struct ib_srq *base_srq,
 					  base_ucontext);
 	int rv;
=20
+	if (init_attrs->srq_type !=3D IB_SRQT_BASIC)
+		return -EOPNOTSUPP;
+
 	if (atomic_inc_return(&sdev->num_srq) > SIW_MAX_SRQ) {
 		siw_dbg_pd(base_srq->pd, "too many SRQ's\n");
 		rv =3D -ENOMEM;
--=20
2.28.0

