Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB3D828275A
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Oct 2020 01:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbgJCXUy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 3 Oct 2020 19:20:54 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:43467 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbgJCXUx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 3 Oct 2020 19:20:53 -0400
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f79074d0000>; Sun, 04 Oct 2020 07:20:45 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 3 Oct
 2020 23:20:23 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.50) by
 HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Sat, 3 Oct 2020 23:20:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VGn40GzqcEig9Q1ftK2QPFqJaY0NV3czxhqK7zH4NMWrz6o7Y9Aj0R7SHlioyBalMAgptaYu6CME01oW+kcGjz5x8ji+wmO8N2skiXawoWSjX0vySUWXKh6usW93uF2xIquXKg6dxGGt3S0L6X4A8UO/b54rkcC1bTGdmqanUsLKOjzSfWm7TVN+OdhMjtcsPH/0NsoXt0RvBKZDM1sdnbKu6/tGxMcBo9uUv6kgA9WepYFpfVyLXf6XmMnh3tp8Tz+kwdti6KnAnvDGxRKolJQT7YTyNQ1/4pPySwgBO1DnXwjP4DXzuWVF0bW6CGWFJWUn2f+sz0iwkKjfMxxnaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qS99nrSqsxQBA8eLYvTPsoltzx++8PnVVMNH79LJ8TA=;
 b=Xr+aE5cRTeWcy1QgfBBV8RqN8im7+szucm4c+Dq5p2qxMP/W4A92JxT5tKSVYKJEeEsgUe44ZeubL40HSuKFOsesUMtxQ1f0WEDql6QQjvT1GOPn1rcKY8KDSv7z9Cyphg53dobmHy+Ct+3HXYRPPQQRVE1xN23SxISAwbNaydb2iS3TAWzEkZN4NILzjqDNDDF7Oxh3m9oT1nIwy56Qa2j5ZIgHzrOEb4iZN2ofZZZJQt2iWnNZP9c+ljB3YXnnVqdlbx6Add/rbExDU/S0BeRSM439lHNa7q3VoN8prts+2EtRyfNkZ7nJJzwRZ/UJFnqFfu+397ouQgkAYt3o8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2582.namprd12.prod.outlook.com (2603:10b6:4:b5::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Sat, 3 Oct
 2020 23:20:18 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.038; Sat, 3 Oct 2020
 23:20:17 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Adit Ranadive <aditr@vmware.com>, Ariel Elior <aelior@marvell.com>,
        Christian Benvenuti <benve@cisco.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        "Dennis Dalessandro" <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        "Faisal Latif" <faisal.latif@intel.com>,
        Gal Pressman <galpress@amazon.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Leon Romanovsky <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, Weihang Li <liweihang@huawei.com>,
        "Mike Marciniszyn" <mike.marciniszyn@intel.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Lijun Ou <oulijun@huawei.com>,
        "Parvi Kaustubhi" <pkaustub@cisco.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        "Yossi Leybovich" <sleybo@amazon.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Zhu Yanjun <yanjunz@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH 07/11] RDMA: Check flags during create_cq
Date:   Sat, 3 Oct 2020 20:20:07 -0300
Message-ID: <7-v1-caa70ba3d1ab+1436e-ucmd_mask_jgg@nvidia.com>
In-Reply-To: <0-v1-caa70ba3d1ab+1436e-ucmd_mask_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MN2PR20CA0007.namprd20.prod.outlook.com
 (2603:10b6:208:e8::20) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR20CA0007.namprd20.prod.outlook.com (2603:10b6:208:e8::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34 via Frontend Transport; Sat, 3 Oct 2020 23:20:16 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kOqp1-0075cc-Rl; Sat, 03 Oct 2020 20:20:11 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601767246; bh=YXa6h2tTwHB+po5IcwlOzpCcsQt61+/pF3mqwOfMHbM=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         Subject:Date:Message-ID:In-Reply-To:References:
         Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
         MIME-Version:X-MS-Exchange-MessageSentRepresentingType;
        b=D3ZPZj5eKATGg4ugH8EOFrn34gzNKQtWa7uGH5wn4/KSBD7Lgx4kOzROMz2OMotfT
         xxRec3XWDf8+dAiKP9cw0WWVZGu85IgXKG6fAFh33fhKAU2JaLypMcsymkAQHHuMgg
         d5FYB+4HmKmSG/1duAjzKtCk+DFJAVAwylg/naz6g2OMz+3LqQhE54Psgcx8swLyDD
         /jDeJqJcmuvOHooua59UeiZ1czba3kLLbkHXmwkgYc1neN42I+TeTsLMJNz40xVXil
         q9aEyh7Y4tan/DLeJj1tNtTwIsoQM7ZL0Q0bpqiwzHlhV3rY3rzbQCRqHTRXouJph9
         AOpYOVy2xcyDA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Each driver should check that the CQ attrs is supported. Unfortuantely
when flags was added to the CQ attrs the drivers were not updated,
uverbs_ex_cmd_mask was used to block it. This was missed when create CQ
was converted to ioctl, so non-zero flags could have been passed into
drivers.

Check that flags is zero in all drivers that don't use it, remove
IB_USER_VERBS_EX_CMD_CREATE_CQ from uverbs_ex_cmd_mask.

Fixes: 41b2a71fc848 ("IB/uverbs: Move ioctl path of create_cq and destroy_c=
q to a new file")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/device.c             | 1 +
 drivers/infiniband/hw/bnxt_re/ib_verbs.c     | 3 +++
 drivers/infiniband/hw/cxgb4/cq.c             | 2 +-
 drivers/infiniband/hw/efa/efa_verbs.c        | 3 +++
 drivers/infiniband/hw/hns/hns_roce_cq.c      | 3 +++
 drivers/infiniband/hw/i40iw/i40iw_verbs.c    | 3 +++
 drivers/infiniband/hw/mlx4/main.c            | 1 -
 drivers/infiniband/hw/mlx5/main.c            | 1 -
 drivers/infiniband/hw/mthca/mthca_provider.c | 2 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c  | 2 +-
 drivers/infiniband/hw/qedr/verbs.c           | 3 +++
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c | 2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c | 3 +++
 drivers/infiniband/sw/rdmavt/cq.c            | 2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c        | 2 +-
 drivers/infiniband/sw/siw/siw_verbs.c        | 3 +++
 16 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/dev=
ice.c
index 44c3c3ecb9d6a6..0a888574674281 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -632,6 +632,7 @@ struct ib_device *_ib_alloc_device(size_t size)
 		BIT_ULL(IB_USER_VERBS_CMD_RESIZE_CQ);
=20
 	device->uverbs_ex_cmd_mask =3D
+		BIT_ULL(IB_USER_VERBS_EX_CMD_CREATE_CQ) |
 		BIT_ULL(IB_USER_VERBS_EX_CMD_CREATE_FLOW) |
 		BIT_ULL(IB_USER_VERBS_EX_CMD_CREATE_RWQ_IND_TBL) |
 		BIT_ULL(IB_USER_VERBS_EX_CMD_CREATE_WQ) |
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/=
hw/bnxt_re/ib_verbs.c
index 580cf541e225dc..6263885ff61d57 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -2837,6 +2837,9 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struc=
t ib_cq_init_attr *attr,
 	struct bnxt_qplib_nq *nq =3D NULL;
 	unsigned int nq_alloc_cnt;
=20
+	if (attr->flags)
+		return -EOPNOTSUPP;
+
 	/* Validate CQ fields */
 	if (cqe < 1 || cqe > dev_attr->max_cq_wqes) {
 		ibdev_err(&rdev->ibdev, "Failed to create CQ -max exceeded");
diff --git a/drivers/infiniband/hw/cxgb4/cq.c b/drivers/infiniband/hw/cxgb4=
/cq.c
index 28349ed5088540..2cb65be24770f1 100644
--- a/drivers/infiniband/hw/cxgb4/cq.c
+++ b/drivers/infiniband/hw/cxgb4/cq.c
@@ -1006,7 +1006,7 @@ int c4iw_create_cq(struct ib_cq *ibcq, const struct i=
b_cq_init_attr *attr,
=20
 	pr_debug("ib_dev %p entries %d\n", ibdev, entries);
 	if (attr->flags)
-		return -EINVAL;
+		return -EOPNOTSUPP;
=20
 	if (vector >=3D rhp->rdev.lldi.nciq)
 		return -EINVAL;
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/=
efa/efa_verbs.c
index e3d9a5a5f4d992..2fe5708b2d9d8c 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1032,6 +1032,9 @@ int efa_create_cq(struct ib_cq *ibcq, const struct ib=
_cq_init_attr *attr,
=20
 	ibdev_dbg(ibdev, "create_cq entries %d\n", entries);
=20
+	if (attr->flags)
+		return -EOPNOTSUPP;
+
 	if (entries < 1 || entries > dev->dev_attr.max_cq_depth) {
 		ibdev_dbg(ibdev,
 			  "cq: requested entries[%u] non-positive or greater than max[%u]\n",
diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/h=
w/hns/hns_roce_cq.c
index 809b22aa5056c4..68f355fba425b5 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -251,6 +251,9 @@ int hns_roce_create_cq(struct ib_cq *ib_cq, const struc=
t ib_cq_init_attr *attr,
 	u32 cq_entries =3D attr->cqe;
 	int ret;
=20
+	if (attr->flags)
+		return -EOPNOTSUPP;
+
 	if (cq_entries < 1 || cq_entries > hr_dev->caps.max_cqes) {
 		ibdev_err(ibdev, "Failed to check CQ count %d max=3D%d\n",
 			  cq_entries, hr_dev->caps.max_cqes);
diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband=
/hw/i40iw/i40iw_verbs.c
index 26a61af2d3977f..4aade66ad2aea8 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -1107,6 +1107,9 @@ static int i40iw_create_cq(struct ib_cq *ibcq,
 	int err_code;
 	int entries =3D attr->cqe;
=20
+	if (attr->flags)
+		return -EOPNOTSUPP;
+
 	if (iwdev->closing)
 		return -ENODEV;
=20
diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4=
/main.c
index 6216dfe6e9c79c..a6ae21721b124a 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -2659,7 +2659,6 @@ static void *mlx4_ib_add(struct mlx4_dev *dev)
=20
 	ib_set_device_ops(&ibdev->ib_dev, &mlx4_ib_dev_ops);
 	ibdev->ib_dev.uverbs_ex_cmd_mask |=3D
-		(1ull << IB_USER_VERBS_EX_CMD_CREATE_CQ) |
 		(1ull << IB_USER_VERBS_EX_CMD_CREATE_QP);
=20
 	if ((dev->caps.flags2 & MLX4_DEV_CAP_FLAG2_RSS) &&
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5=
/main.c
index 39950d5230c0af..9e2f6a7967a61b 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4143,7 +4143,6 @@ static int mlx5_ib_stage_caps_init(struct mlx5_ib_dev=
 *dev)
 		(1ull << IB_USER_VERBS_CMD_CREATE_AH)		|
 		(1ull << IB_USER_VERBS_CMD_DESTROY_AH);
 	dev->ib_dev.uverbs_ex_cmd_mask |=3D
-		(1ull << IB_USER_VERBS_EX_CMD_CREATE_CQ)	|
 		(1ull << IB_USER_VERBS_EX_CMD_CREATE_QP);
=20
 	if (MLX5_CAP_GEN(mdev, ipoib_enhanced_offloads) &&
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infinib=
and/hw/mthca/mthca_provider.c
index a01898ac99e224..5e798a6f75d715 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -612,7 +612,7 @@ static int mthca_create_cq(struct ib_cq *ibcq,
 		udata, struct mthca_ucontext, ibucontext);
=20
 	if (attr->flags)
-		return -EINVAL;
+		return -EOPNOTSUPP;
=20
 	if (entries < 1 || entries > to_mdev(ibdev)->limits.max_cqes)
 		return -EINVAL;
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniba=
nd/hw/ocrdma/ocrdma_verbs.c
index 244dd22d53efa7..29ec0a808a19d8 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -974,7 +974,7 @@ int ocrdma_create_cq(struct ib_cq *ibcq, const struct i=
b_cq_init_attr *attr,
 	struct ocrdma_create_cq_ureq ureq;
=20
 	if (attr->flags)
-		return -EINVAL;
+		return -EOPNOTSUPP;
=20
 	if (udata) {
 		if (ib_copy_from_udata(&ureq, udata, sizeof(ureq)))
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qed=
r/verbs.c
index 34c07a18c2c218..80373170ce51f5 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -928,6 +928,9 @@ int qedr_create_cq(struct ib_cq *ibcq, const struct ib_=
cq_init_attr *attr,
 		 "create_cq: called from %s. entries=3D%d, vector=3D%d\n",
 		 udata ? "User Lib" : "Kernel", entries, vector);
=20
+	if (attr->flags)
+		return -EOPNOTSUPP;
+
 	if (entries > QEDR_MAX_CQES) {
 		DP_ERR(dev,
 		       "create cq: the number of entries %d is too high. Must be equal o=
r below %d.\n",
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c b/drivers/infinib=
and/hw/usnic/usnic_ib_verbs.c
index a89d5816685af6..d6708d1db73af2 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
@@ -584,7 +584,7 @@ int usnic_ib_create_cq(struct ib_cq *ibcq, const struct=
 ib_cq_init_attr *attr,
 		       struct ib_udata *udata)
 {
 	if (attr->flags)
-		return -EINVAL;
+		return -EOPNOTSUPP;
=20
 	return 0;
 }
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c b/drivers/infinib=
and/hw/vmw_pvrdma/pvrdma_cq.c
index 319546a39a0d5c..a119ac3e103c8d 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c
@@ -119,6 +119,9 @@ int pvrdma_create_cq(struct ib_cq *ibcq, const struct i=
b_cq_init_attr *attr,
=20
 	BUILD_BUG_ON(sizeof(struct pvrdma_cqe) !=3D 64);
=20
+	if (attr->flags)
+		return -EOPNOTSUPP;
+
 	entries =3D roundup_pow_of_two(entries);
 	if (entries < 1 || entries > dev->dsr->caps.max_cqe)
 		return -EINVAL;
diff --git a/drivers/infiniband/sw/rdmavt/cq.c b/drivers/infiniband/sw/rdma=
vt/cq.c
index 19248be1409335..20cc0799ac4bc4 100644
--- a/drivers/infiniband/sw/rdmavt/cq.c
+++ b/drivers/infiniband/sw/rdmavt/cq.c
@@ -211,7 +211,7 @@ int rvt_create_cq(struct ib_cq *ibcq, const struct ib_c=
q_init_attr *attr,
 	int err;
=20
 	if (attr->flags)
-		return -EINVAL;
+		return -EOPNOTSUPP;
=20
 	if (entries < 1 || entries > rdi->dparms.props.max_cqe)
 		return -EINVAL;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/=
rxe/rxe_verbs.c
index fa4a0dd2e08c00..7baa8f5cba813e 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -771,7 +771,7 @@ static int rxe_create_cq(struct ib_cq *ibcq, const stru=
ct ib_cq_init_attr *attr,
 	}
=20
 	if (attr->flags)
-		return -EINVAL;
+		return -EOPNOTSUPP;
=20
 	err =3D rxe_cq_chk_attr(rxe, NULL, attr->cqe, attr->comp_vector);
 	if (err)
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/=
siw/siw_verbs.c
index 947b8b1cbe9af6..bcea5c5ace2b6b 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -1097,6 +1097,9 @@ int siw_create_cq(struct ib_cq *base_cq, const struct=
 ib_cq_init_attr *attr,
 	struct siw_cq *cq =3D to_siw_cq(base_cq);
 	int rv, size =3D attr->cqe;
=20
+	if (attr->flags)
+		return -EOPNOTSUPP;
+
 	if (atomic_inc_return(&sdev->num_cq) > SIW_MAX_CQ) {
 		siw_dbg(base_cq->device, "too many CQ's\n");
 		rv =3D -ENOMEM;
--=20
2.28.0

