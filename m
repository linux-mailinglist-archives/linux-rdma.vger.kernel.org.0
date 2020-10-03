Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E06C282759
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Oct 2020 01:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbgJCXUr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 3 Oct 2020 19:20:47 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:14642 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbgJCXUr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 3 Oct 2020 19:20:47 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7907410001>; Sat, 03 Oct 2020 16:20:33 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 3 Oct
 2020 23:20:24 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.57) by
 HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Sat, 3 Oct 2020 23:20:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDr8k47wMo9bGhtqtemzlhIQKT8rSyXeV+M31AsW152QNFN3rsbosmYH3lY6O33ZuX58AcBuSMnvWdEMyyHtzpxN+7H7xxoZOZvx1Wx4hJFEoqI08+h/u5MTJ1zlOLGWYRSbBQ3F9U3Mcp+yWkONgE54371SdeocBlxXAD+BwQYVkd465dtuRxvnwbPshVsa6qZDhoM/flT0Z771y7eVYyiu582k/hFWyQ0yYKnC/6HshF22no5E6wKGjTXmeAuv5QkkUaccS+8mb+q01bo/Lx8xPd+V8NqZN83gSgdghQPj/uBwMMr35Cf6G+9dY4EzlzGyUlkj9VJf2lqDP91G8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YIL5D5Wi3zcAUZoQTjI4x3stiVwAmbpdbBCOulK564=;
 b=jzw2PWwUPR/mYQOEfxud3VRjh3VTh0F0cAgA3/TGRcGhYXlPavsIH1KuGxdQQpbMDaA0k+x/P9kUj2ZrbIX3EJH7JbGX5yaSxS6sIMrzmKrj1/Dt9EHg24d9dgK8FuptZncTtNw2GG9rqn/wRGdex5okRMVkZGoiNfmrofawdNLvRvmJEvln0eO2tB8pVoe6ZlBjWqNP8nJwNdRIa+YuD2vUEu7NW2VhGvaIOkl2sCTRNLPFoyvlSbdfnUYy2OV83126o1rMXzxzsM8LhFn5UL4kpds5O2YqPFEy2YFk6eT9PRfWatudj1O1toUQISBW/rSlMOrb2hNPaBc9Ig0URg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2582.namprd12.prod.outlook.com (2603:10b6:4:b5::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Sat, 3 Oct
 2020 23:20:19 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.038; Sat, 3 Oct 2020
 23:20:19 +0000
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
Subject: [PATCH 06/11] RDMA: Check attr_mask during modify_qp
Date:   Sat, 3 Oct 2020 20:20:06 -0300
Message-ID: <6-v1-caa70ba3d1ab+1436e-ucmd_mask_jgg@nvidia.com>
In-Reply-To: <0-v1-caa70ba3d1ab+1436e-ucmd_mask_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MN2PR20CA0006.namprd20.prod.outlook.com
 (2603:10b6:208:e8::19) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR20CA0006.namprd20.prod.outlook.com (2603:10b6:208:e8::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34 via Frontend Transport; Sat, 3 Oct 2020 23:20:18 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kOqp1-0075cZ-QE; Sat, 03 Oct 2020 20:20:11 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601767233; bh=KdykNv0afDAz7awLGi1wl9fEIIHglaKZ+hpO4SA871k=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         Subject:Date:Message-ID:In-Reply-To:References:
         Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
         MIME-Version:X-MS-Exchange-MessageSentRepresentingType;
        b=Yi4kjrrt+65SMhbTiVf9hAN3iFx11watGzzGznQXlAsP6fR3S8SydFPWhf0OqAh1N
         eXgFA/1ScmqPdJXAQKxZpHA6SttCYY6l783k0MNfL5gn7YbBM9yle9CzoJLdZma7YO
         0v2kkhPJfiwhzi2RByopP3a95VDj4NH0/CQXeJSM3UsiVwrmAfobe8TFJ5iKc6sk1Z
         CMV0f+tb0PzJFGNKxWLFwntJaskmE4jqdfjWfgeNQDPrbLYhg12mLHfksfSVCWxD1N
         kHEt2Ajg9YTsGbk8Ehz2KVvMEni3mmCXmdyIuVzVm4/SbPs1vw+hcmCSe8dQsFf99V
         tIUFt3kYAN1BA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Each driver should check that it can support the provided attr_mask during
modify_qp. IB_USER_VERBS_EX_CMD_MODIFY_QP was being used to block
modify_qp_ex because the driver didn't check RATE_LIMIT.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/device.c             |  1 +
 drivers/infiniband/core/uverbs_cmd.c         |  8 ++------
 drivers/infiniband/hw/bnxt_re/ib_verbs.c     |  3 +++
 drivers/infiniband/hw/cxgb4/qp.c             |  3 +++
 drivers/infiniband/hw/efa/efa_verbs.c        |  3 +++
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c   |  2 ++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c   |  3 +++
 drivers/infiniband/hw/i40iw/i40iw_verbs.c    |  3 +++
 drivers/infiniband/hw/mlx4/qp.c              |  3 +++
 drivers/infiniband/hw/mlx5/main.c            |  3 +--
 drivers/infiniband/hw/mlx5/qp.c              |  3 +++
 drivers/infiniband/hw/mthca/mthca_qp.c       |  3 +++
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c  |  3 +++
 drivers/infiniband/hw/qedr/verbs.c           |  3 +++
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c |  3 +++
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c |  3 +++
 drivers/infiniband/sw/rdmavt/qp.c            |  3 +++
 drivers/infiniband/sw/rxe/rxe_verbs.c        |  3 +++
 drivers/infiniband/sw/siw/siw_verbs.c        |  3 +++
 include/rdma/ib_verbs.h                      |  2 ++
 include/uapi/rdma/ib_user_verbs.h            | 14 --------------
 21 files changed, 53 insertions(+), 22 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/dev=
ice.c
index 75e6e68688c6d0..44c3c3ecb9d6a6 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -639,6 +639,7 @@ struct ib_device *_ib_alloc_device(size_t size)
 		BIT_ULL(IB_USER_VERBS_EX_CMD_DESTROY_RWQ_IND_TBL) |
 		BIT_ULL(IB_USER_VERBS_EX_CMD_DESTROY_WQ) |
 		BIT_ULL(IB_USER_VERBS_EX_CMD_MODIFY_CQ) |
+		BIT_ULL(IB_USER_VERBS_EX_CMD_MODIFY_QP) |
 		BIT_ULL(IB_USER_VERBS_EX_CMD_MODIFY_WQ) |
 		BIT_ULL(IB_USER_VERBS_EX_CMD_QUERY_DEVICE);
=20
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core=
/uverbs_cmd.c
index f85a6117577296..54c3eb463da85d 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -1906,8 +1906,7 @@ static int ib_uverbs_modify_qp(struct uverbs_attr_bun=
dle *attrs)
 	if (ret)
 		return ret;
=20
-	if (cmd.base.attr_mask &
-	    ~((IB_USER_LEGACY_LAST_QP_ATTR_MASK << 1) - 1))
+	if (cmd.base.attr_mask & ~IB_QP_ATTR_STANDARD_BITS)
 		return -EOPNOTSUPP;
=20
 	return modify_qp(attrs, &cmd);
@@ -1929,10 +1928,7 @@ static int ib_uverbs_ex_modify_qp(struct uverbs_attr=
_bundle *attrs)
 	 * Last bit is reserved for extending the attr_mask by
 	 * using another field.
 	 */
-	BUILD_BUG_ON(IB_USER_LAST_QP_ATTR_MASK =3D=3D (1ULL << 31));
-
-	if (cmd.base.attr_mask &
-	    ~((IB_USER_LAST_QP_ATTR_MASK << 1) - 1))
+	if (cmd.base.attr_mask & ~(IB_QP_ATTR_STANDARD_BITS | IB_QP_RATE_LIMIT))
 		return -EOPNOTSUPP;
=20
 	ret =3D modify_qp(attrs, &cmd);
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/=
hw/bnxt_re/ib_verbs.c
index a0e8d93595d8e8..580cf541e225dc 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1836,6 +1836,9 @@ int bnxt_re_modify_qp(struct ib_qp *ib_qp, struct ib_=
qp_attr *qp_attr,
 	unsigned int flags;
 	u8 nw_type;
=20
+	if (qp_attr_mask & ~IB_QP_ATTR_STANDARD_BITS)
+		return -EOPNOTSUPP;
+
 	qp->qplib_qp.modify_flags =3D 0;
 	if (qp_attr_mask & IB_QP_STATE) {
 		curr_qp_state =3D __to_ib_qp_state(qp->qplib_qp.cur_qp_state);
diff --git a/drivers/infiniband/hw/cxgb4/qp.c b/drivers/infiniband/hw/cxgb4=
/qp.c
index d2b46c5c1645e4..79e69d449b0748 100644
--- a/drivers/infiniband/hw/cxgb4/qp.c
+++ b/drivers/infiniband/hw/cxgb4/qp.c
@@ -2374,6 +2374,9 @@ int c4iw_ib_modify_qp(struct ib_qp *ibqp, struct ib_q=
p_attr *attr,
=20
 	pr_debug("ib_qp %p\n", ibqp);
=20
+	if (attr_mask & ~IB_QP_ATTR_STANDARD_BITS)
+		return -EOPNOTSUPP;
+
 	/* iwarp does not support the RTR state */
 	if ((attr_mask & IB_QP_STATE) && (attr->qp_state =3D=3D IB_QPS_RTR))
 		attr_mask &=3D ~IB_QP_STATE;
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/=
efa/efa_verbs.c
index 191e0843f090c8..e3d9a5a5f4d992 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -917,6 +917,9 @@ int efa_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr=
 *qp_attr,
 	enum ib_qp_state new_state;
 	int err;
=20
+	if (qp_attr_mask & ~IB_QP_ATTR_STANDARD_BITS)
+		return -EOPNOTSUPP;
+
 	if (udata->inlen &&
 	    !ib_is_udata_cleared(udata, 0, udata->inlen)) {
 		ibdev_dbg(&dev->ibdev,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniban=
d/hw/hns/hns_roce_hw_v1.c
index b3d5ba8ef439a3..f18380f827dd87 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -3256,6 +3256,8 @@ static int hns_roce_v1_modify_qp(struct ib_qp *ibqp,
 				 enum ib_qp_state cur_state,
 				 enum ib_qp_state new_state)
 {
+	if (attr_mask & ~IB_QP_ATTR_STANDARD_BITS)
+		return -EOPNOTSUPP;
=20
 	if (ibqp->qp_type =3D=3D IB_QPT_GSI || ibqp->qp_type =3D=3D IB_QPT_SMI)
 		return hns_roce_v1_m_sqp(ibqp, attr, attr_mask, cur_state,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniban=
d/hw/hns/hns_roce_hw_v2.c
index 6d30850696c518..a0b679254a8e56 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4757,6 +4757,9 @@ static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
 	unsigned long rq_flag =3D 0;
 	int ret;
=20
+	if (attr_mask & ~IB_QP_ATTR_STANDARD_BITS)
+		return -EOPNOTSUPP;
+
 	/*
 	 * In v2 engine, software pass context and context mask to hardware
 	 * when modifying qp. If software need modify some fields in context,
diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband=
/hw/i40iw/i40iw_verbs.c
index be2bd843c58396..26a61af2d3977f 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -855,6 +855,9 @@ int i40iw_modify_qp(struct ib_qp *ibqp, struct ib_qp_at=
tr *attr,
 	u32 err;
 	unsigned long flags;
=20
+	if (attr_mask & ~IB_QP_ATTR_STANDARD_BITS)
+		return -EOPNOTSUPP;
+
 	memset(&info, 0, sizeof(info));
 	ctx_info =3D &iwqp->ctx_info;
 	iwarp_info =3D &iwqp->iwarp_info;
diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/q=
p.c
index 5cb8e602294ca9..8834629615bc6d 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -2787,6 +2787,9 @@ int mlx4_ib_modify_qp(struct ib_qp *ibqp, struct ib_q=
p_attr *attr,
 	struct mlx4_ib_qp *mqp =3D to_mqp(ibqp);
 	int ret;
=20
+	if (attr_mask & ~IB_QP_ATTR_STANDARD_BITS)
+		return -EOPNOTSUPP;
+
 	ret =3D _mlx4_ib_modify_qp(ibqp, attr, attr_mask, udata);
=20
 	if (mqp->mlx4_ib_qp_type =3D=3D MLX4_IB_QPT_GSI) {
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5=
/main.c
index 7f03ffabddbe87..39950d5230c0af 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4144,8 +4144,7 @@ static int mlx5_ib_stage_caps_init(struct mlx5_ib_dev=
 *dev)
 		(1ull << IB_USER_VERBS_CMD_DESTROY_AH);
 	dev->ib_dev.uverbs_ex_cmd_mask |=3D
 		(1ull << IB_USER_VERBS_EX_CMD_CREATE_CQ)	|
-		(1ull << IB_USER_VERBS_EX_CMD_CREATE_QP)	|
-		(1ull << IB_USER_VERBS_EX_CMD_MODIFY_QP);
+		(1ull << IB_USER_VERBS_EX_CMD_CREATE_QP);
=20
 	if (MLX5_CAP_GEN(mdev, ipoib_enhanced_offloads) &&
 	    IS_ENABLED(CONFIG_MLX5_CORE_IPOIB))
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/q=
p.c
index 600e056798c0a1..19361132336cb9 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -4247,6 +4247,9 @@ int mlx5_ib_modify_qp(struct ib_qp *ibqp, struct ib_q=
p_attr *attr,
 	int err =3D -EINVAL;
 	int port;
=20
+	if (attr_mask & ~(IB_QP_ATTR_STANDARD_BITS | IB_QP_RATE_LIMIT))
+		return -EOPNOTSUPP;
+
 	if (ibqp->rwq_ind_tbl)
 		return -ENOSYS;
=20
diff --git a/drivers/infiniband/hw/mthca/mthca_qp.c b/drivers/infiniband/hw=
/mthca/mthca_qp.c
index 08a2a7afafd3d2..07cfc0934b17d5 100644
--- a/drivers/infiniband/hw/mthca/mthca_qp.c
+++ b/drivers/infiniband/hw/mthca/mthca_qp.c
@@ -863,6 +863,9 @@ int mthca_modify_qp(struct ib_qp *ibqp, struct ib_qp_at=
tr *attr, int attr_mask,
 	enum ib_qp_state cur_state, new_state;
 	int err =3D -EINVAL;
=20
+	if (attr_mask & ~IB_QP_ATTR_STANDARD_BITS)
+		return -EOPNOTSUPP;
+
 	mutex_lock(&qp->mutex);
 	if (attr_mask & IB_QP_CUR_STATE) {
 		cur_state =3D attr->cur_qp_state;
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniba=
nd/hw/ocrdma/ocrdma_verbs.c
index b392e15d7592b6..244dd22d53efa7 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -1391,6 +1391,9 @@ int ocrdma_modify_qp(struct ib_qp *ibqp, struct ib_qp=
_attr *attr,
 	struct ocrdma_dev *dev;
 	enum ib_qp_state old_qps, new_qps;
=20
+	if (attr_mask & ~IB_QP_ATTR_STANDARD_BITS)
+		return -EOPNOTSUPP;
+
 	qp =3D get_ocrdma_qp(ibqp);
 	dev =3D get_ocrdma_dev(ibqp->device);
=20
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qed=
r/verbs.c
index 29a96ff6fc66b6..34c07a18c2c218 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -2472,6 +2472,9 @@ int qedr_modify_qp(struct ib_qp *ibqp, struct ib_qp_a=
ttr *attr,
 		 "modify qp: qp %p attr_mask=3D0x%x, state=3D%d", qp, attr_mask,
 		 attr->qp_state);
=20
+	if (attr_mask & ~IB_QP_ATTR_STANDARD_BITS)
+		return -EOPNOTSUPP;
+
 	old_qp_state =3D qedr_get_ibqp_state(qp->state);
 	if (attr_mask & IB_QP_STATE)
 		new_qp_state =3D attr->qp_state;
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c b/drivers/infinib=
and/hw/usnic/usnic_ib_verbs.c
index 9e961f8ffa10de..a89d5816685af6 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
@@ -557,6 +557,9 @@ int usnic_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp=
_attr *attr,
 	int status;
 	usnic_dbg("\n");
=20
+	if (attr_mask & ~IB_QP_ATTR_STANDARD_BITS)
+		return -EOPNOTSUPP;
+
 	qp_grp =3D to_uqp_grp(ibqp);
=20
 	mutex_lock(&qp_grp->vf->pf->usdev_lock);
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c b/drivers/infinib=
and/hw/vmw_pvrdma/pvrdma_qp.c
index 428256c5506571..9fdec5b9553c4e 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
@@ -544,6 +544,9 @@ int pvrdma_modify_qp(struct ib_qp *ibqp, struct ib_qp_a=
ttr *attr,
 	enum ib_qp_state cur_state, next_state;
 	int ret;
=20
+	if (attr_mask & ~IB_QP_ATTR_STANDARD_BITS)
+		return -EOPNOTSUPP;
+
 	/* Sanity checking. Should need lock here */
 	mutex_lock(&qp->mutex);
 	cur_state =3D (attr_mask & IB_QP_CUR_STATE) ? attr->cur_qp_state :
diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdma=
vt/qp.c
index ee48befc897861..7b93e7bb0072a2 100644
--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -1469,6 +1469,9 @@ int rvt_modify_qp(struct ib_qp *ibqp, struct ib_qp_at=
tr *attr,
 	int pmtu =3D 0; /* for gcc warning only */
 	int opa_ah;
=20
+	if (attr_mask & ~IB_QP_ATTR_STANDARD_BITS)
+		return -EOPNOTSUPP;
+
 	spin_lock_irq(&qp->r_lock);
 	spin_lock(&qp->s_hlock);
 	spin_lock(&qp->s_lock);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/=
rxe/rxe_verbs.c
index 38e603260cfc43..fa4a0dd2e08c00 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -436,6 +436,9 @@ static int rxe_modify_qp(struct ib_qp *ibqp, struct ib_=
qp_attr *attr,
 	struct rxe_dev *rxe =3D to_rdev(ibqp->device);
 	struct rxe_qp *qp =3D to_rqp(ibqp);
=20
+	if (mask & ~IB_QP_ATTR_STANDARD_BITS)
+		return -EOPNOTSUPP;
+
 	err =3D rxe_qp_chk_attr(rxe, qp, attr, mask);
 	if (err)
 		goto err1;
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/=
siw/siw_verbs.c
index 1c469f967ab9b2..947b8b1cbe9af6 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -544,6 +544,9 @@ int siw_verbs_modify_qp(struct ib_qp *base_qp, struct i=
b_qp_attr *attr,
 	if (!attr_mask)
 		return 0;
=20
+	if (attr_mask & ~IB_QP_ATTR_STANDARD_BITS)
+		return -EOPNOTSUPP;
+
 	memset(&new_attrs, 0, sizeof(new_attrs));
=20
 	if (attr_mask & IB_QP_ACCESS_FLAGS) {
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index ce935d70fdc879..ddcd0478c00dc3 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1234,6 +1234,8 @@ enum ib_qp_attr_mask {
 	IB_QP_RESERVED3			=3D (1<<23),
 	IB_QP_RESERVED4			=3D (1<<24),
 	IB_QP_RATE_LIMIT		=3D (1<<25),
+
+	IB_QP_ATTR_STANDARD_BITS =3D GENMASK(20, 0),
 };
=20
 enum ib_qp_state {
diff --git a/include/uapi/rdma/ib_user_verbs.h b/include/uapi/rdma/ib_user_=
verbs.h
index 456438c18c2c35..7ee73a0652f1af 100644
--- a/include/uapi/rdma/ib_user_verbs.h
+++ b/include/uapi/rdma/ib_user_verbs.h
@@ -596,20 +596,6 @@ enum {
 	IB_UVERBS_CREATE_QP_SUP_COMP_MASK =3D IB_UVERBS_CREATE_QP_MASK_IND_TABLE,
 };
=20
-enum {
-	/*
-	 * This value is equal to IB_QP_DEST_QPN.
-	 */
-	IB_USER_LEGACY_LAST_QP_ATTR_MASK =3D 1ULL << 20,
-};
-
-enum {
-	/*
-	 * This value is equal to IB_QP_RATE_LIMIT.
-	 */
-	IB_USER_LAST_QP_ATTR_MASK =3D 1ULL << 25,
-};
-
 struct ib_uverbs_ex_create_qp {
 	__aligned_u64 user_handle;
 	__u32 pd_handle;
--=20
2.28.0

