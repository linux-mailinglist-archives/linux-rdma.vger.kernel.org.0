Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45651282758
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Oct 2020 01:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbgJCXUq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 3 Oct 2020 19:20:46 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:24986 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbgJCXUq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 3 Oct 2020 19:20:46 -0400
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7907480000>; Sun, 04 Oct 2020 07:20:41 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 3 Oct
 2020 23:20:20 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.50) by
 HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Sat, 3 Oct 2020 23:20:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2UgdwUwDnfowi81n6f/eSW1wW22xS1tl+4gBVln2/rfGUHjB4+992D+t2jdD7pYXomCQnd1HPNjkgp4vgtKe0JFmZQRakrOouYGL6OQmuppjtSs9tc9+202QI3sa/jVLs8Lb9wBf9JA5PZIS6dnywkB69Cw0aK84jZOgOaoLuPkRdr4DGo8tr2d+dWGLYCdwi10CGaRCCJhfPSKUwTvZ3IKK0Ie77lk0Dtuje2BxVov8uGIuBtALKc9jitDKrIar+fwk1CWt9TBdZpRB9GLd/hLFPwxuWzcu/BpLmlXiPnHy8XXsubZCuFhurqGcV1QKDKd6AV8+3ESLybY+rIiFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWdGcMN9KNGZNWYyui31Hf1CuFWw+nxd3RGSJ2HIsKA=;
 b=LBmBbSqFSioYA1z4l6ERSIrkMSQYZlnaWbKBMDXeB3YiOKW/6yUEMmCyksQNsq80pJwiZ67uOu47SxBW/3iF1B+fe5BQUosCWxOeodTm9PYxRHyNrxCmxPeio0y12RuKisWw42DXKWOVND/cNTkQff+yfRdTPfuHByo62aUxKiacKyCrC3l7HqCZ+P6PX8rJYDb0bbJTIEoMpMjnSsy0i3xVELptvkELIw6oz6FQYOdS/OJ+ntJvbnHg0HpfzISO8fUQjKPpCCVtP7enmgFD5ayuGt1khTH7Zfy7E2mkPgKu/seHOq6HFDeuckpImmP0Vcs7ZpFiN2y5toLFjmHPeg==
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
To:     Adit Ranadive <aditr@vmware.com>, Ariel Elior <aelior@marvell.com>,
        Christian Benvenuti <benve@cisco.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        "Dennis Dalessandro" <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        "Faisal Latif" <faisal.latif@intel.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Leon Romanovsky <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, Weihang Li <liweihang@huawei.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Lijun Ou <oulijun@huawei.com>,
        Parvi Kaustubhi <pkaustub@cisco.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Zhu Yanjun <yanjunz@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH 08/11] RDMA: Check create_flags during create_qp
Date:   Sat, 3 Oct 2020 20:20:08 -0300
Message-ID: <8-v1-caa70ba3d1ab+1436e-ucmd_mask_jgg@nvidia.com>
In-Reply-To: <0-v1-caa70ba3d1ab+1436e-ucmd_mask_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MN2PR20CA0036.namprd20.prod.outlook.com
 (2603:10b6:208:e8::49) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR20CA0036.namprd20.prod.outlook.com (2603:10b6:208:e8::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.36 via Frontend Transport; Sat, 3 Oct 2020 23:20:13 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kOqp1-0075ch-Tx; Sat, 03 Oct 2020 20:20:11 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601767241; bh=SQuGnuHcdBTH6Fk1Y67JtB3rHMCX7satBoVF850MDdQ=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         Subject:Date:Message-ID:In-Reply-To:References:
         Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
         MIME-Version:X-MS-Exchange-MessageSentRepresentingType;
        b=g0mn/9Y1tv3KVYvfE98Zyez6Re6P+MICcvOXKWmu6f5XbEbwV2kRnkBGUiM/IpUTW
         9xskh7QA9Okzr78boy9wVC/RrxkXxvyXEyxsKNZ8uRZrrW97fgixZ+RdlPJbpRgvMF
         UzKoI4IPyvyz457hcGWm1RI3wEnEWX2P7CodNsNSC1M4TAYh+jYzUBezqruq/hlH1Q
         tPZ/Ji4HSIDA+W04kP/9tlNkUxT98+sH76eC1xnB+8HJOcaVPslm/uOJKu7cnexOn5
         gSyxD/ZfNbA6Owa3Po4/2alrdFj0xab+pbynqEy4ggUArt8wl3fyqopXdHMhnFY6Au
         Xcuq6Daloz7XQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Each driver should check that the QP attrs create_flags is supported.
Unfortuantely when create_flags was added to the QP attrs the drivers were
not updated. uverbs_ex_cmd_mask was used to block it - even though kernel
drivers use these flags too.

Check that flags is zero in all drivers that don't use it, remove
IB_USER_VERBS_EX_CMD_CREATE_QP from uverbs_ex_cmd_mask. Fix the error code
to be EOPNOTSUPP.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/device.c             |  1 +
 drivers/infiniband/hw/bnxt_re/ib_verbs.c     |  4 +++-
 drivers/infiniband/hw/cxgb4/qp.c             |  2 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c      | 14 +++-----------
 drivers/infiniband/hw/i40iw/i40iw_verbs.c    |  2 +-
 drivers/infiniband/hw/mlx4/main.c            |  2 --
 drivers/infiniband/hw/mlx4/qp.c              |  2 +-
 drivers/infiniband/hw/mlx5/main.c            |  2 --
 drivers/infiniband/hw/mlx5/qp.c              |  7 ++++---
 drivers/infiniband/hw/mthca/mthca_provider.c |  2 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c  |  3 +++
 drivers/infiniband/hw/qedr/verbs.c           |  3 +++
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c |  2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c |  2 +-
 drivers/infiniband/sw/rdmavt/qp.c            |  7 ++++---
 drivers/infiniband/sw/rxe/rxe_verbs.c        |  3 +++
 drivers/infiniband/sw/siw/siw_verbs.c        |  3 +++
 17 files changed, 33 insertions(+), 28 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/dev=
ice.c
index 0a888574674281..4b808827ffcae5 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -634,6 +634,7 @@ struct ib_device *_ib_alloc_device(size_t size)
 	device->uverbs_ex_cmd_mask =3D
 		BIT_ULL(IB_USER_VERBS_EX_CMD_CREATE_CQ) |
 		BIT_ULL(IB_USER_VERBS_EX_CMD_CREATE_FLOW) |
+		BIT_ULL(IB_USER_VERBS_EX_CMD_CREATE_QP) |
 		BIT_ULL(IB_USER_VERBS_EX_CMD_CREATE_RWQ_IND_TBL) |
 		BIT_ULL(IB_USER_VERBS_EX_CMD_CREATE_WQ) |
 		BIT_ULL(IB_USER_VERBS_EX_CMD_DESTROY_FLOW) |
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/=
hw/bnxt_re/ib_verbs.c
index 6263885ff61d57..335ba485cd3be7 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1276,10 +1276,12 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *=
qp, struct bnxt_re_pd *pd,
 	}
 	qplqp->mtu =3D ib_mtu_enum_to_int(iboe_get_mtu(rdev->netdev->mtu));
 	qplqp->dpi =3D &rdev->dpi_privileged; /* Doorbell page */
-	if (init_attr->create_flags)
+	if (init_attr->create_flags) {
 		ibdev_dbg(&rdev->ibdev,
 			  "QP create flags 0x%x not supported",
 			  init_attr->create_flags);
+		return -EOPNOTSUPP;
+	}
=20
 	/* Setup CQs */
 	if (init_attr->send_cq) {
diff --git a/drivers/infiniband/hw/cxgb4/qp.c b/drivers/infiniband/hw/cxgb4=
/qp.c
index 79e69d449b0748..a7401398cb344a 100644
--- a/drivers/infiniband/hw/cxgb4/qp.c
+++ b/drivers/infiniband/hw/cxgb4/qp.c
@@ -2126,7 +2126,7 @@ struct ib_qp *c4iw_create_qp(struct ib_pd *pd, struct=
 ib_qp_init_attr *attrs,
=20
 	pr_debug("ib_pd %p\n", pd);
=20
-	if (attrs->qp_type !=3D IB_QPT_RC)
+	if (attrs->qp_type !=3D IB_QPT_RC || attrs->create_flags)
 		return ERR_PTR(-EOPNOTSUPP);
=20
 	php =3D to_c4iw_pd(pd);
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/h=
w/hns/hns_roce_qp.c
index 6c081dd985fc94..04a70681bea1bd 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -869,17 +869,6 @@ static int set_qp_param(struct hns_roce_dev *hr_dev, s=
truct hns_roce_qp *hr_qp,
 		if (ret)
 			ibdev_err(ibdev, "Failed to set user SQ size\n");
 	} else {
-		if (init_attr->create_flags &
-		    IB_QP_CREATE_BLOCK_MULTICAST_LOOPBACK) {
-			ibdev_err(ibdev, "Failed to check multicast loopback\n");
-			return -EINVAL;
-		}
-
-		if (init_attr->create_flags & IB_QP_CREATE_IPOIB_UD_LSO) {
-			ibdev_err(ibdev, "Failed to check ipoib ud lso\n");
-			return -EINVAL;
-		}
-
 		ret =3D set_kernel_sq_size(hr_dev, &init_attr->cap, hr_qp);
 		if (ret)
 			ibdev_err(ibdev, "Failed to set kernel SQ size\n");
@@ -906,6 +895,9 @@ static int hns_roce_create_qp_common(struct hns_roce_de=
v *hr_dev,
 	hr_qp->state =3D IB_QPS_RESET;
 	hr_qp->flush_flag =3D 0;
=20
+	if (init_attr->create_flags)
+		return -EOPNOTSUPP;
+
 	ret =3D set_qp_param(hr_dev, hr_qp, init_attr, udata, &ucmd);
 	if (ret) {
 		ibdev_err(ibdev, "Failed to set QP param\n");
diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband=
/hw/i40iw/i40iw_verbs.c
index 4aade66ad2aea8..65c9e010d4d5b1 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -556,7 +556,7 @@ static struct ib_qp *i40iw_create_qp(struct ib_pd *ibpd=
,
 		return ERR_PTR(-ENODEV);
=20
 	if (init_attr->create_flags)
-		return ERR_PTR(-EINVAL);
+		return ERR_PTR(-EOPNOTSUPP);
 	if (init_attr->cap.max_inline_data > I40IW_MAX_INLINE_DATA_SIZE)
 		init_attr->cap.max_inline_data =3D I40IW_MAX_INLINE_DATA_SIZE;
=20
diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4=
/main.c
index a6ae21721b124a..15508036c83b18 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -2658,8 +2658,6 @@ static void *mlx4_ib_add(struct mlx4_dev *dev)
 	ibdev->ib_dev.dev.parent	=3D &dev->persist->pdev->dev;
=20
 	ib_set_device_ops(&ibdev->ib_dev, &mlx4_ib_dev_ops);
-	ibdev->ib_dev.uverbs_ex_cmd_mask |=3D
-		(1ull << IB_USER_VERBS_EX_CMD_CREATE_QP);
=20
 	if ((dev->caps.flags2 & MLX4_DEV_CAP_FLAG2_RSS) &&
 	    ((mlx4_ib_port_link_layer(&ibdev->ib_dev, 1) =3D=3D
diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/q=
p.c
index 8834629615bc6d..47b9ed5599b396 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -1493,7 +1493,7 @@ static int _mlx4_ib_create_qp(struct ib_pd *pd, struc=
t mlx4_ib_qp *qp,
 					MLX4_IB_SRIOV_SQP |
 					MLX4_IB_QP_NETIF |
 					MLX4_IB_QP_CREATE_ROCE_V2_GSI))
-		return -EINVAL;
+		return -EOPNOTSUPP;
=20
 	if (init_attr->create_flags & IB_QP_CREATE_NETIF_QP) {
 		if (init_attr->qp_type !=3D IB_QPT_UD)
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5=
/main.c
index 9e2f6a7967a61b..9cdc87fd99618c 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4142,8 +4142,6 @@ static int mlx5_ib_stage_caps_init(struct mlx5_ib_dev=
 *dev)
 	dev->ib_dev.uverbs_cmd_mask |=3D
 		(1ull << IB_USER_VERBS_CMD_CREATE_AH)		|
 		(1ull << IB_USER_VERBS_CMD_DESTROY_AH);
-	dev->ib_dev.uverbs_ex_cmd_mask |=3D
-		(1ull << IB_USER_VERBS_EX_CMD_CREATE_QP);
=20
 	if (MLX5_CAP_GEN(mdev, ipoib_enhanced_offloads) &&
 	    IS_ENABLED(CONFIG_MLX5_CORE_IPOIB))
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/q=
p.c
index 19361132336cb9..251421dd6f1d5e 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -2712,11 +2712,12 @@ static int process_create_flags(struct mlx5_ib_dev =
*dev, struct mlx5_ib_qp *qp,
 	process_create_flag(dev, &create_flags, MLX5_IB_QP_CREATE_SQPN_QP1,
 			    true, qp);
=20
-	if (create_flags)
+	if (create_flags) {
 		mlx5_ib_dbg(dev, "Create QP has unsupported flags 0x%X\n",
 			    create_flags);
-
-	return (create_flags) ? -EINVAL : 0;
+		return -EOPNOTSUPP;
+	}
+	return 0;
 }
=20
 static int process_udata_size(struct mlx5_ib_dev *dev,
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infinib=
and/hw/mthca/mthca_provider.c
index 5e798a6f75d715..a4a0ac3a25a06a 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -470,7 +470,7 @@ static struct ib_qp *mthca_create_qp(struct ib_pd *pd,
 	int err;
=20
 	if (init_attr->create_flags)
-		return ERR_PTR(-EINVAL);
+		return ERR_PTR(-EOPNOTSUPP);
=20
 	switch (init_attr->qp_type) {
 	case IB_QPT_RC:
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniba=
nd/hw/ocrdma/ocrdma_verbs.c
index 29ec0a808a19d8..bc98bd950d99fa 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -1299,6 +1299,9 @@ struct ib_qp *ocrdma_create_qp(struct ib_pd *ibpd,
 	struct ocrdma_create_qp_ureq ureq;
 	u16 dpp_credit_lmt, dpp_offset;
=20
+	if (attrs->create_flags)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	status =3D ocrdma_check_qp_params(ibpd, dev, attrs, udata);
 	if (status)
 		goto gen_err;
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qed=
r/verbs.c
index 80373170ce51f5..2e85bb5104cb68 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -2239,6 +2239,9 @@ struct ib_qp *qedr_create_qp(struct ib_pd *ibpd,
 	struct ib_qp *ibqp;
 	int rc =3D 0;
=20
+	if (attrs->create_flags)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	if (attrs->qp_type =3D=3D IB_QPT_XRC_TGT) {
 		xrcd =3D get_qedr_xrcd(attrs->xrcd);
 		dev =3D get_qedr_dev(xrcd->ibxrcd.device);
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c b/drivers/infinib=
and/hw/usnic/usnic_ib_verbs.c
index d6708d1db73af2..38a37770c01627 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
@@ -474,7 +474,7 @@ struct ib_qp *usnic_ib_create_qp(struct ib_pd *pd,
 	us_ibdev =3D to_usdev(pd->device);
=20
 	if (init_attr->create_flags)
-		return ERR_PTR(-EINVAL);
+		return ERR_PTR(-EOPNOTSUPP);
=20
 	err =3D ib_copy_from_udata(&cmd, udata, sizeof(cmd));
 	if (err) {
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c b/drivers/infinib=
and/hw/vmw_pvrdma/pvrdma_qp.c
index 9fdec5b9553c4e..1d3bdd7bb51d96 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
@@ -209,7 +209,7 @@ struct ib_qp *pvrdma_create_qp(struct ib_pd *pd,
 		dev_warn(&dev->pdev->dev,
 			 "invalid create queuepair flags %#x\n",
 			 init_attr->create_flags);
-		return ERR_PTR(-EINVAL);
+		return ERR_PTR(-EOPNOTSUPP);
 	}
=20
 	if (init_attr->qp_type !=3D IB_QPT_RC &&
diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdma=
vt/qp.c
index 7b93e7bb0072a2..e9db6bf106186f 100644
--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -1083,10 +1083,11 @@ struct ib_qp *rvt_create_qp(struct ib_pd *ibpd,
 	if (!rdi)
 		return ERR_PTR(-EINVAL);
=20
+	if (init_attr->create_flags & ~IB_QP_CREATE_NETDEV_USE)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	if (init_attr->cap.max_send_sge > rdi->dparms.props.max_send_sge ||
-	    init_attr->cap.max_send_wr > rdi->dparms.props.max_qp_wr ||
-	    (init_attr->create_flags &&
-	     init_attr->create_flags !=3D IB_QP_CREATE_NETDEV_USE))
+	    init_attr->cap.max_send_wr > rdi->dparms.props.max_qp_wr)
 		return ERR_PTR(-EINVAL);
=20
 	/* Check receive queue parameters if no SRQ is specified. */
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/=
rxe/rxe_verbs.c
index 7baa8f5cba813e..9100a39f9cb9fe 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -395,6 +395,9 @@ static struct ib_qp *rxe_create_qp(struct ib_pd *ibpd,
 		uresp =3D udata->outbuf;
 	}
=20
+	if (init->create_flags)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	err =3D rxe_qp_chk_init(rxe, init);
 	if (err)
 		goto err1;
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/=
siw/siw_verbs.c
index bcea5c5ace2b6b..68fd053fc7748a 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -307,6 +307,9 @@ struct ib_qp *siw_create_qp(struct ib_pd *pd,
=20
 	siw_dbg(base_dev, "create new QP\n");
=20
+	if (attrs->create_flags)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	if (atomic_inc_return(&sdev->num_qp) > SIW_MAX_QP) {
 		siw_dbg(base_dev, "too many QP's\n");
 		rv =3D -ENOMEM;
--=20
2.28.0

