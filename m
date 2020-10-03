Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C61E282754
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Oct 2020 01:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbgJCXUd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 3 Oct 2020 19:20:33 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:48180 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbgJCXUd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 3 Oct 2020 19:20:33 -0400
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f79073d0000>; Sun, 04 Oct 2020 07:20:29 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 3 Oct
 2020 23:20:22 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.50) by
 HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Sat, 3 Oct 2020 23:20:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mqvrw6VCKvmcmIsZQ+H5AFc0v1BA5MFybVhYa44Mqja5gYsSjlzyX/DtfcMku4D4WCvmAR94vRunszdlKpCDBEGWyWGCofCKfYPTKDL0TFljZB4lpt1H5Pd8G/ns6XjxoLaj3xXI5Nd7QD7NSzvLWEw7Rj16/PEC5QEdLcduM/+SM2cdrDtPjyLeMUByOvHm8i3wGdfH6RtmX13Fi0jjxIQVK59w+I0OWmeKGTeXYVcrIkuhLV78ZMR54yK5aHOIYBJa92Lo3R487TQx62DxPHLudoqRjgaXeg4mB4Uf4zD8Lqb33slns45PdhWfE1+ZIH7sOHrnSVqsDcAj+NtJzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCxJRsKfDatrT7N2GEijRQLchBwOo0bZtuxiIwoDXbE=;
 b=RZu6mlUZvXsuc8yIzfHQSfkbK5YzXq3R8u1ShWB8++2hijokRRuY4x6htEtMNkI8SpJ/LRwcH5JFWj1ePfhpZxerVoU/dbR5fELGAQn0DEK3XqXlv2NiNaSYRqDeRh6kgGFY8oyk57tQcG+fuDrp5pbCr4ra0ip5HURTUHlMTfN/AHoZj4Mfk+CI2S+L0Jw7wo59+grFhKPJN4OEuMYa0rCwVJ5aZwQvtZ9wKiagXSlYBtILrH/fGTL7NJV07Sd0y34oocp4gUvIFw0HXlUyClJ43+XKlEvFkk9JNQtHsDxJR4A7pUIwhKEodfUI/wjs3k2kldw7ynf5bnCu6OvE3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2582.namprd12.prod.outlook.com (2603:10b6:4:b5::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Sat, 3 Oct
 2020 23:20:17 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.038; Sat, 3 Oct 2020
 23:20:17 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        "Gal Pressman" <galpress@amazon.com>,
        Leon Romanovsky <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        "Yossi Leybovich" <sleybo@amazon.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Zhu Yanjun <yanjunz@nvidia.com>
Subject: [PATCH 11/11] RDMA: Remove AH from uverbs_cmd_mask
Date:   Sat, 3 Oct 2020 20:20:11 -0300
Message-ID: <11-v1-caa70ba3d1ab+1436e-ucmd_mask_jgg@nvidia.com>
In-Reply-To: <0-v1-caa70ba3d1ab+1436e-ucmd_mask_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MN2PR20CA0002.namprd20.prod.outlook.com
 (2603:10b6:208:e8::15) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR20CA0002.namprd20.prod.outlook.com (2603:10b6:208:e8::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32 via Frontend Transport; Sat, 3 Oct 2020 23:20:14 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kOqp2-0075ct-1q; Sat, 03 Oct 2020 20:20:12 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601767229; bh=zq90pE0UTtXKD1fxafobqRHuaCioPbyR18LCsw0sJb0=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         Subject:Date:Message-ID:In-Reply-To:References:
         Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
         MIME-Version:X-MS-Exchange-MessageSentRepresentingType;
        b=pMnzqG6G2kxNXXGIsNxxW4vtrD15wNY7E5t7KnqpydPnLSgkTTCzOwi+mIdMKYTci
         bqq1IxTAoEO1tC0XF+TCdaW6T492VWBh2eByic439DdoG2E0h6n8d/E4apLT6bPsTZ
         JLrLRD71tf8VfS9xkJDe3rVQsJ0irteIL+hRBtajEoZxXzDVKmYIkXIuhuRKvlGu3P
         snp6sJFf51XSK8pvTBKy0Qqs2gDPHiQz9mAEvuG/FKH+aFlBGuEqYIXkrYgDj8aoWl
         6F6rUTTL+NicK+NYpbXgS9ivzrTYAZ9PtDppeTWnu0pyEpv29jAkq+jBwCmOKyW5wD
         rus/2jg/AGg9w==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Drivers that need a uverbs AH should instead set the create_user_ah() op
similar to reg_user_mr(). MODIFY_AH and QUERY_AH cmds were never
implemented so are just deleted.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/device.c           |  3 +++
 drivers/infiniband/core/uverbs_cmd.c       |  8 ++++----
 drivers/infiniband/core/verbs.c            |  5 ++++-
 drivers/infiniband/hw/bnxt_re/main.c       | 10 +---------
 drivers/infiniband/hw/efa/efa_main.c       |  5 +----
 drivers/infiniband/hw/mlx5/main.c          |  5 +----
 drivers/infiniband/hw/ocrdma/ocrdma_main.c |  7 +------
 drivers/infiniband/sw/rdmavt/ah.c          |  1 -
 drivers/infiniband/sw/rdmavt/vt.c          |  5 +----
 drivers/infiniband/sw/rxe/rxe_verbs.c      |  9 ++-------
 include/rdma/ib_verbs.h                    |  2 ++
 11 files changed, 20 insertions(+), 40 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/dev=
ice.c
index b2325e7a7f2db3..63e97fcfb80b91 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -606,6 +606,7 @@ struct ib_device *_ib_alloc_device(size_t size)
 		BIT_ULL(IB_USER_VERBS_CMD_ALLOC_PD) |
 		BIT_ULL(IB_USER_VERBS_CMD_ATTACH_MCAST) |
 		BIT_ULL(IB_USER_VERBS_CMD_CLOSE_XRCD) |
+		BIT_ULL(IB_USER_VERBS_CMD_CREATE_AH) |
 		BIT_ULL(IB_USER_VERBS_CMD_CREATE_COMP_CHANNEL) |
 		BIT_ULL(IB_USER_VERBS_CMD_CREATE_CQ) |
 		BIT_ULL(IB_USER_VERBS_CMD_CREATE_QP) |
@@ -614,6 +615,7 @@ struct ib_device *_ib_alloc_device(size_t size)
 		BIT_ULL(IB_USER_VERBS_CMD_DEALLOC_MW) |
 		BIT_ULL(IB_USER_VERBS_CMD_DEALLOC_PD) |
 		BIT_ULL(IB_USER_VERBS_CMD_DEREG_MR) |
+		BIT_ULL(IB_USER_VERBS_CMD_DESTROY_AH) |
 		BIT_ULL(IB_USER_VERBS_CMD_DESTROY_CQ) |
 		BIT_ULL(IB_USER_VERBS_CMD_DESTROY_QP) |
 		BIT_ULL(IB_USER_VERBS_CMD_DESTROY_SRQ) |
@@ -2635,6 +2637,7 @@ void ib_set_device_ops(struct ib_device *dev, const s=
truct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, create_qp);
 	SET_DEVICE_OP(dev_ops, create_rwq_ind_table);
 	SET_DEVICE_OP(dev_ops, create_srq);
+	SET_DEVICE_OP(dev_ops, create_user_ah);
 	SET_DEVICE_OP(dev_ops, create_wq);
 	SET_DEVICE_OP(dev_ops, dealloc_dm);
 	SET_DEVICE_OP(dev_ops, dealloc_driver);
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core=
/uverbs_cmd.c
index 54c3eb463da85d..72b209ca77c734 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -3689,13 +3689,13 @@ const struct uapi_definition uverbs_def_write_intf[=
] =3D {
 				     ib_uverbs_create_ah,
 				     UAPI_DEF_WRITE_UDATA_IO(
 					     struct ib_uverbs_create_ah,
-					     struct ib_uverbs_create_ah_resp),
-				     UAPI_DEF_METHOD_NEEDS_FN(create_ah)),
+					     struct ib_uverbs_create_ah_resp)),
 		DECLARE_UVERBS_WRITE(
 			IB_USER_VERBS_CMD_DESTROY_AH,
 			ib_uverbs_destroy_ah,
-			UAPI_DEF_WRITE_I(struct ib_uverbs_destroy_ah),
-			UAPI_DEF_METHOD_NEEDS_FN(destroy_ah))),
+			UAPI_DEF_WRITE_I(struct ib_uverbs_destroy_ah)),
+		UAPI_DEF_OBJ_NEEDS_FN(create_user_ah),
+		UAPI_DEF_OBJ_NEEDS_FN(destroy_ah)),
=20
 	DECLARE_UVERBS_OBJECT(
 		UVERBS_OBJECT_COMP_CHANNEL,
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verb=
s.c
index 740f8454b6b461..cfcfa3ae32cf21 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -533,7 +533,10 @@ static struct ib_ah *_rdma_create_ah(struct ib_pd *pd,
 	init_attr.flags =3D flags;
 	init_attr.xmit_slave =3D xmit_slave;
=20
-	ret =3D device->ops.create_ah(ah, &init_attr, udata);
+	if (udata)
+		ret =3D device->ops.create_user_ah(ah, &init_attr, udata);
+	else
+		ret =3D device->ops.create_ah(ah, &init_attr, NULL);
 	if (ret) {
 		kfree(ah);
 		return ERR_PTR(ret);
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/b=
nxt_re/main.c
index 2bee4ca6dcf5fe..eff4af28fd0c38 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -646,6 +646,7 @@ static const struct ib_device_ops bnxt_re_dev_ops =3D {
 	.create_cq =3D bnxt_re_create_cq,
 	.create_qp =3D bnxt_re_create_qp,
 	.create_srq =3D bnxt_re_create_srq,
+	.create_user_ah =3D bnxt_re_create_ah,
 	.dealloc_driver =3D bnxt_re_dealloc_driver,
 	.dealloc_pd =3D bnxt_re_dealloc_pd,
 	.dealloc_ucontext =3D bnxt_re_dealloc_ucontext,
@@ -701,15 +702,6 @@ static int bnxt_re_register_ib(struct bnxt_re_dev *rde=
v)
 	ibdev->dev.parent =3D &rdev->en_dev->pdev->dev;
 	ibdev->local_dma_lkey =3D BNXT_QPLIB_RSVD_LKEY;
=20
-	/* User space */
-	ibdev->uverbs_cmd_mask |=3D
-			(1ull << IB_USER_VERBS_CMD_CREATE_AH)		|
-			(1ull << IB_USER_VERBS_CMD_MODIFY_AH)		|
-			(1ull << IB_USER_VERBS_CMD_QUERY_AH)		|
-			(1ull << IB_USER_VERBS_CMD_DESTROY_AH);
-	/* POLL_CQ and REQ_NOTIFY_CQ is directly handled in libbnxt_re */
-
-
 	rdma_set_device_sysfs_group(ibdev, &bnxt_re_dev_attr_group);
 	ib_set_device_ops(ibdev, &bnxt_re_dev_ops);
 	ret =3D ib_device_set_netdev(&rdev->ibdev, rdev->netdev, 1);
diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/e=
fa/efa_main.c
index ebc0f9475d0969..43bfa912deda89 100644
--- a/drivers/infiniband/hw/efa/efa_main.c
+++ b/drivers/infiniband/hw/efa/efa_main.c
@@ -248,6 +248,7 @@ static const struct ib_device_ops efa_dev_ops =3D {
 	.create_ah =3D efa_create_ah,
 	.create_cq =3D efa_create_cq,
 	.create_qp =3D efa_create_qp,
+	.create_user_ah =3D efa_create_ah,
 	.dealloc_pd =3D efa_dealloc_pd,
 	.dealloc_ucontext =3D efa_dealloc_ucontext,
 	.dereg_mr =3D efa_dereg_mr,
@@ -308,10 +309,6 @@ static int efa_ib_device_add(struct efa_dev *dev)
 	dev->ibdev.num_comp_vectors =3D 1;
 	dev->ibdev.dev.parent =3D &pdev->dev;
=20
-	dev->ibdev.uverbs_cmd_mask |=3D
-		(1ull << IB_USER_VERBS_CMD_CREATE_AH) |
-		(1ull << IB_USER_VERBS_CMD_DESTROY_AH);
-
 	ib_set_device_ops(&dev->ibdev, &efa_dev_ops);
=20
 	err =3D ib_register_device(&dev->ibdev, "efa_%d");
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5=
/main.c
index 9cdc87fd99618c..932b0c24dddced 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4022,6 +4022,7 @@ static const struct ib_device_ops mlx5_ib_dev_ops =3D=
 {
 	.create_cq =3D mlx5_ib_create_cq,
 	.create_qp =3D mlx5_ib_create_qp,
 	.create_srq =3D mlx5_ib_create_srq,
+	.create_user_ah =3D mlx5_ib_create_ah,
 	.dealloc_pd =3D mlx5_ib_dealloc_pd,
 	.dealloc_ucontext =3D mlx5_ib_dealloc_ucontext,
 	.del_gid =3D mlx5_ib_del_gid,
@@ -4139,10 +4140,6 @@ static int mlx5_ib_stage_caps_init(struct mlx5_ib_de=
v *dev)
 	struct mlx5_core_dev *mdev =3D dev->mdev;
 	int err;
=20
-	dev->ib_dev.uverbs_cmd_mask |=3D
-		(1ull << IB_USER_VERBS_CMD_CREATE_AH)		|
-		(1ull << IB_USER_VERBS_CMD_DESTROY_AH);
-
 	if (MLX5_CAP_GEN(mdev, ipoib_enhanced_offloads) &&
 	    IS_ENABLED(CONFIG_MLX5_CORE_IPOIB))
 		ib_set_device_ops(&dev->ib_dev,
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_main.c b/drivers/infiniban=
d/hw/ocrdma/ocrdma_main.c
index d7dc7a76f9854c..ef072f08f18aa1 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_main.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_main.c
@@ -154,6 +154,7 @@ static const struct ib_device_ops ocrdma_dev_ops =3D {
 	.create_ah =3D ocrdma_create_ah,
 	.create_cq =3D ocrdma_create_cq,
 	.create_qp =3D ocrdma_create_qp,
+	.create_user_ah =3D ocrdma_create_ah,
 	.dealloc_pd =3D ocrdma_dealloc_pd,
 	.dealloc_ucontext =3D ocrdma_dealloc_ucontext,
 	.dereg_mr =3D ocrdma_dereg_mr,
@@ -205,12 +206,6 @@ static int ocrdma_register_device(struct ocrdma_dev *d=
ev)
 	memcpy(dev->ibdev.node_desc, OCRDMA_NODE_DESC,
 	       sizeof(OCRDMA_NODE_DESC));
=20
-	dev->ibdev.uverbs_cmd_mask |=3D
-	    OCRDMA_UVERBS(CREATE_AH) |
-	     OCRDMA_UVERBS(MODIFY_AH) |
-	     OCRDMA_UVERBS(QUERY_AH) |
-	     OCRDMA_UVERBS(DESTROY_AH);
-
 	dev->ibdev.node_type =3D RDMA_NODE_IB_CA;
 	dev->ibdev.phys_port_cnt =3D 1;
 	dev->ibdev.num_comp_vectors =3D dev->eq_cnt;
diff --git a/drivers/infiniband/sw/rdmavt/ah.c b/drivers/infiniband/sw/rdma=
vt/ah.c
index b938c4ffa99aa3..f9754dcd250b77 100644
--- a/drivers/infiniband/sw/rdmavt/ah.c
+++ b/drivers/infiniband/sw/rdmavt/ah.c
@@ -129,7 +129,6 @@ int rvt_create_ah(struct ib_ah *ibah, struct rdma_ah_in=
it_attr *init_attr,
  * rvt_destory_ah - Destory an address handle
  * @ibah: address handle
  * @destroy_flags: destroy address handle flags (see enum rdma_destroy_ah_=
flags)
- *
  * Return: 0 on success
  */
 int rvt_destroy_ah(struct ib_ah *ibah, u32 destroy_flags)
diff --git a/drivers/infiniband/sw/rdmavt/vt.c b/drivers/infiniband/sw/rdma=
vt/vt.c
index a0cb567cfc512b..3119540f906530 100644
--- a/drivers/infiniband/sw/rdmavt/vt.c
+++ b/drivers/infiniband/sw/rdmavt/vt.c
@@ -386,6 +386,7 @@ static const struct ib_device_ops rvt_dev_ops =3D {
 	.create_cq =3D rvt_create_cq,
 	.create_qp =3D rvt_create_qp,
 	.create_srq =3D rvt_create_srq,
+	.create_user_ah =3D rvt_create_ah,
 	.dealloc_pd =3D rvt_dealloc_pd,
 	.dealloc_ucontext =3D rvt_dealloc_ucontext,
 	.dereg_mr =3D rvt_dereg_mr,
@@ -594,10 +595,6 @@ int rvt_register_device(struct rvt_dev_info *rdi)
 	 * version, so we do all of this sort of stuff here.
 	 */
 	rdi->ibdev.uverbs_cmd_mask |=3D
-		(1ull << IB_USER_VERBS_CMD_CREATE_AH)           |
-		(1ull << IB_USER_VERBS_CMD_MODIFY_AH)           |
-		(1ull << IB_USER_VERBS_CMD_QUERY_AH)            |
-		(1ull << IB_USER_VERBS_CMD_DESTROY_AH)          |
 		(1ull << IB_USER_VERBS_CMD_POLL_CQ)             |
 		(1ull << IB_USER_VERBS_CMD_REQ_NOTIFY_CQ)       |
 		(1ull << IB_USER_VERBS_CMD_POST_SEND)           |
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/=
rxe/rxe_verbs.c
index 12dfaab1549f1e..bae8931424c3db 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1079,6 +1079,7 @@ static const struct ib_device_ops rxe_dev_ops =3D {
 	.create_cq =3D rxe_create_cq,
 	.create_qp =3D rxe_create_qp,
 	.create_srq =3D rxe_create_srq,
+	.create_user_ah =3D rxe_create_ah,
 	.dealloc_driver =3D rxe_dealloc,
 	.dealloc_pd =3D rxe_dealloc_pd,
 	.dealloc_ucontext =3D rxe_dealloc_ucontext,
@@ -1144,13 +1145,7 @@ int rxe_register_device(struct rxe_dev *rxe, const c=
har *ibdev_name)
 	dma_coerce_mask_and_coherent(&dev->dev,
 				     dma_get_required_mask(&dev->dev));
=20
-	dev->uverbs_cmd_mask |=3D
-	    BIT_ULL(IB_USER_VERBS_CMD_REQ_NOTIFY_CQ)
-	    | BIT_ULL(IB_USER_VERBS_CMD_CREATE_AH)
-	    | BIT_ULL(IB_USER_VERBS_CMD_MODIFY_AH)
-	    | BIT_ULL(IB_USER_VERBS_CMD_QUERY_AH)
-	    | BIT_ULL(IB_USER_VERBS_CMD_DESTROY_AH)
-	    ;
+	dev->uverbs_cmd_mask |=3D BIT_ULL(IB_USER_VERBS_CMD_REQ_NOTIFY_CQ);
=20
 	ib_set_device_ops(dev, &rxe_dev_ops);
 	err =3D ib_device_set_netdev(&rxe->ib_dev, rxe->ndev, 1);
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 437508290bc9bf..6c52eac6293c5f 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2403,6 +2403,8 @@ struct ib_device_ops {
 	int (*dealloc_pd)(struct ib_pd *pd, struct ib_udata *udata);
 	int (*create_ah)(struct ib_ah *ah, struct rdma_ah_init_attr *attr,
 			 struct ib_udata *udata);
+	int (*create_user_ah)(struct ib_ah *ah, struct rdma_ah_init_attr *attr,
+			      struct ib_udata *udata);
 	int (*modify_ah)(struct ib_ah *ah, struct rdma_ah_attr *ah_attr);
 	int (*query_ah)(struct ib_ah *ah, struct rdma_ah_attr *ah_attr);
 	int (*destroy_ah)(struct ib_ah *ah, u32 flags);
--=20
2.28.0

