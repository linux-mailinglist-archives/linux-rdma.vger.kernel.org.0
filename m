Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A367128275B
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Oct 2020 01:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbgJCXVI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 3 Oct 2020 19:21:08 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:19555 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbgJCXVH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 3 Oct 2020 19:21:07 -0400
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f79074c0000>; Sun, 04 Oct 2020 07:20:44 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 3 Oct
 2020 23:20:19 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.50) by
 HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Sat, 3 Oct 2020 23:20:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KVzpicy9qyoK4TVrudOUb5tE2c4TePQ/N9Or3+pwZq7OL3NPZks8Mn1JkqfN6locTNsog+CsP15FliflaLuQzAkgADjmmcWDJyKG4uH2lw6mtffQUU1wT7BUXccNJH4ox1crntpxpYlPEOLVihXoxFRkFJzt2GEqT3X312Q03hgAsdTyyMCxZxgq+hzXAneabvhpHhOWzoCmsJbinqiZS9Y0bW7j+1b+BFaMOkpQqytoJjWGl7jrbMRql09s7POtlyKwuuq3sSphWofNYsiYPBZebcpCoNyZ3Zxntk6HDhe0BIOZzo7Gdzek4GGV544lzwsd3KiNlmuOLVpqcoCMNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3y+2ZK7Qz3DqVWStrCi1hqES7PetR7mb65M6RZYU+ms=;
 b=dSByQpa5SwKVN3jhm+coA4qDrBSMhKwiyiCD0Mw1ydRQ+C4PV0KcC2Iov9Y6wMrIkBPpKvd4AKnVzBkC1QbkW+fLTozx4/+xArAIx6ueLI3mS2oj59zig95YKLGzEEuPiIjAU8hkE7XB+yYD2MCZhrW113RWt3KNNTe9+zxnxhxKfVAXEGPlI+l1LnoQz33N60Aka1TyIYUeKyya3+AxHHSB3QoqVNTsDOaQNvxmKcKlxWZpnWK0TmUxBCH7TJSh9/Uax5TF9GIS4oLA4Xg8Bg5+wBR5i5oZWetlK1pXwVI87F7aiRF/wcYZaxUAcjZurxCnwjlRROWvQ6bXm3ZtTA==
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
Subject: [PATCH 03/11] RDMA: Remove elements in uverbs_cmd_mask that all drivers set
Date:   Sat, 3 Oct 2020 20:20:03 -0300
Message-ID: <3-v1-caa70ba3d1ab+1436e-ucmd_mask_jgg@nvidia.com>
In-Reply-To: <0-v1-caa70ba3d1ab+1436e-ucmd_mask_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0001.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::14) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR15CA0001.namprd15.prod.outlook.com (2603:10b6:208:1b4::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32 via Frontend Transport; Sat, 3 Oct 2020 23:20:13 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kOqp1-0075cN-Jt; Sat, 03 Oct 2020 20:20:11 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601767244; bh=l9kpB1xRC00EPLgN8eadDrhdurkwR1Ekep3Xx+vVWlA=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         Subject:Date:Message-ID:In-Reply-To:References:
         Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
         MIME-Version:X-MS-Exchange-MessageSentRepresentingType;
        b=ek1emID2cC/WyTyf/S69+KVvl192xmbdVp/yEmfEO45CA4pfxE/FSjLO425xdN0WB
         Iz1ATttdhXvjfsHGowMjW9OqKUgZAkuRvHoOaVch6u8dFsK/M2yksYNSx6wmLFn4to
         MbTwwoCU+mUY58facuuK6xyYO0gd4JsCNIO36FKIjlmtif/ei6emQf17tIwNMcuzHw
         UmaNcJ63yuP96f31Looki/Y6J27SIrBGf7v1U7STBLGBZCThp+KqJ/55VpQDqlGVuN
         FSdXeYue7Cg7xpVls+5dQv1toJXKU69koM+H9EStik6WOAr6UBpbC0n+vmKLxVO19y
         lKu2NMlJdPcSA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This is a step toward eliminating uverbs_cmd_mask. Preset this list in the
core code. Only the op reg_user_mr wasn't already being required from the
drivers.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/device.c               | 16 ++++++++++++++++
 drivers/infiniband/hw/bnxt_re/main.c           | 16 +---------------
 drivers/infiniband/hw/cxgb4/provider.c         | 16 +---------------
 drivers/infiniband/hw/efa/efa_main.c           | 16 +---------------
 drivers/infiniband/hw/hns/hns_roce_main.c      | 15 ---------------
 drivers/infiniband/hw/i40iw/i40iw_verbs.c      | 16 +---------------
 drivers/infiniband/hw/mlx4/main.c              | 16 +---------------
 drivers/infiniband/hw/mlx5/main.c              | 16 +---------------
 drivers/infiniband/hw/mthca/mthca_provider.c   | 16 +---------------
 drivers/infiniband/hw/ocrdma/ocrdma_main.c     | 16 +---------------
 drivers/infiniband/hw/qedr/main.c              | 15 +--------------
 drivers/infiniband/hw/usnic/usnic_ib_main.c    | 16 +---------------
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c | 16 +---------------
 drivers/infiniband/sw/rdmavt/vt.c              | 16 +---------------
 drivers/infiniband/sw/rxe/rxe_verbs.c          | 17 ++---------------
 drivers/infiniband/sw/siw/siw_main.c           | 16 +---------------
 16 files changed, 31 insertions(+), 224 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/dev=
ice.c
index 647abbfc9a9c60..4b29c6b7aa6e7f 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -600,6 +600,22 @@ struct ib_device *_ib_alloc_device(size_t size)
 	init_completion(&device->unreg_completion);
 	INIT_WORK(&device->unregistration_work, ib_unregister_work);
=20
+	device->uverbs_cmd_mask =3D
+		BIT_ULL(IB_USER_VERBS_CMD_ALLOC_PD) |
+		BIT_ULL(IB_USER_VERBS_CMD_CREATE_COMP_CHANNEL) |
+		BIT_ULL(IB_USER_VERBS_CMD_CREATE_CQ) |
+		BIT_ULL(IB_USER_VERBS_CMD_CREATE_QP) |
+		BIT_ULL(IB_USER_VERBS_CMD_DEALLOC_PD) |
+		BIT_ULL(IB_USER_VERBS_CMD_DEREG_MR) |
+		BIT_ULL(IB_USER_VERBS_CMD_DESTROY_CQ) |
+		BIT_ULL(IB_USER_VERBS_CMD_DESTROY_QP) |
+		BIT_ULL(IB_USER_VERBS_CMD_GET_CONTEXT) |
+		BIT_ULL(IB_USER_VERBS_CMD_MODIFY_QP) |
+		BIT_ULL(IB_USER_VERBS_CMD_QUERY_DEVICE) |
+		BIT_ULL(IB_USER_VERBS_CMD_QUERY_PORT) |
+		BIT_ULL(IB_USER_VERBS_CMD_QUERY_QP) |
+		BIT_ULL(IB_USER_VERBS_CMD_REG_MR);
+
 	device->uverbs_ex_cmd_mask =3D
 		BIT_ULL(IB_USER_VERBS_EX_CMD_CREATE_FLOW) |
 		BIT_ULL(IB_USER_VERBS_EX_CMD_CREATE_RWQ_IND_TBL) |
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/b=
nxt_re/main.c
index 53aee5a42ab850..6bb524102832e6 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -702,23 +702,9 @@ static int bnxt_re_register_ib(struct bnxt_re_dev *rde=
v)
 	ibdev->local_dma_lkey =3D BNXT_QPLIB_RSVD_LKEY;
=20
 	/* User space */
-	ibdev->uverbs_cmd_mask =3D
-			(1ull << IB_USER_VERBS_CMD_GET_CONTEXT)		|
-			(1ull << IB_USER_VERBS_CMD_QUERY_DEVICE)	|
-			(1ull << IB_USER_VERBS_CMD_QUERY_PORT)		|
-			(1ull << IB_USER_VERBS_CMD_ALLOC_PD)		|
-			(1ull << IB_USER_VERBS_CMD_DEALLOC_PD)		|
-			(1ull << IB_USER_VERBS_CMD_REG_MR)		|
+	ibdev->uverbs_cmd_mask |=3D
 			(1ull << IB_USER_VERBS_CMD_REREG_MR)		|
-			(1ull << IB_USER_VERBS_CMD_DEREG_MR)		|
-			(1ull << IB_USER_VERBS_CMD_CREATE_COMP_CHANNEL) |
-			(1ull << IB_USER_VERBS_CMD_CREATE_CQ)		|
 			(1ull << IB_USER_VERBS_CMD_RESIZE_CQ)		|
-			(1ull << IB_USER_VERBS_CMD_DESTROY_CQ)		|
-			(1ull << IB_USER_VERBS_CMD_CREATE_QP)		|
-			(1ull << IB_USER_VERBS_CMD_MODIFY_QP)		|
-			(1ull << IB_USER_VERBS_CMD_QUERY_QP)		|
-			(1ull << IB_USER_VERBS_CMD_DESTROY_QP)		|
 			(1ull << IB_USER_VERBS_CMD_CREATE_SRQ)		|
 			(1ull << IB_USER_VERBS_CMD_MODIFY_SRQ)		|
 			(1ull << IB_USER_VERBS_CMD_QUERY_SRQ)		|
diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw=
/cxgb4/provider.c
index 3bdcdce9def2da..58b578d40bf63c 100644
--- a/drivers/infiniband/hw/cxgb4/provider.c
+++ b/drivers/infiniband/hw/cxgb4/provider.c
@@ -531,23 +531,9 @@ void c4iw_register_device(struct work_struct *work)
 	if (fastreg_support)
 		dev->device_cap_flags |=3D IB_DEVICE_MEM_MGT_EXTENSIONS;
 	dev->ibdev.local_dma_lkey =3D 0;
-	dev->ibdev.uverbs_cmd_mask =3D
-	    (1ull << IB_USER_VERBS_CMD_GET_CONTEXT) |
-	    (1ull << IB_USER_VERBS_CMD_QUERY_DEVICE) |
-	    (1ull << IB_USER_VERBS_CMD_QUERY_PORT) |
-	    (1ull << IB_USER_VERBS_CMD_ALLOC_PD) |
-	    (1ull << IB_USER_VERBS_CMD_DEALLOC_PD) |
-	    (1ull << IB_USER_VERBS_CMD_REG_MR) |
-	    (1ull << IB_USER_VERBS_CMD_DEREG_MR) |
-	    (1ull << IB_USER_VERBS_CMD_CREATE_COMP_CHANNEL) |
-	    (1ull << IB_USER_VERBS_CMD_CREATE_CQ) |
-	    (1ull << IB_USER_VERBS_CMD_DESTROY_CQ) |
+	dev->ibdev.uverbs_cmd_mask |=3D
 	    (1ull << IB_USER_VERBS_CMD_REQ_NOTIFY_CQ) |
-	    (1ull << IB_USER_VERBS_CMD_CREATE_QP) |
-	    (1ull << IB_USER_VERBS_CMD_MODIFY_QP) |
-	    (1ull << IB_USER_VERBS_CMD_QUERY_QP) |
 	    (1ull << IB_USER_VERBS_CMD_POLL_CQ) |
-	    (1ull << IB_USER_VERBS_CMD_DESTROY_QP) |
 	    (1ull << IB_USER_VERBS_CMD_POST_SEND) |
 	    (1ull << IB_USER_VERBS_CMD_POST_RECV) |
 	    (1ull << IB_USER_VERBS_CMD_CREATE_SRQ) |
diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/e=
fa/efa_main.c
index 5cc746a6327ece..ebc0f9475d0969 100644
--- a/drivers/infiniband/hw/efa/efa_main.c
+++ b/drivers/infiniband/hw/efa/efa_main.c
@@ -308,21 +308,7 @@ static int efa_ib_device_add(struct efa_dev *dev)
 	dev->ibdev.num_comp_vectors =3D 1;
 	dev->ibdev.dev.parent =3D &pdev->dev;
=20
-	dev->ibdev.uverbs_cmd_mask =3D
-		(1ull << IB_USER_VERBS_CMD_GET_CONTEXT) |
-		(1ull << IB_USER_VERBS_CMD_QUERY_DEVICE) |
-		(1ull << IB_USER_VERBS_CMD_QUERY_PORT) |
-		(1ull << IB_USER_VERBS_CMD_ALLOC_PD) |
-		(1ull << IB_USER_VERBS_CMD_DEALLOC_PD) |
-		(1ull << IB_USER_VERBS_CMD_REG_MR) |
-		(1ull << IB_USER_VERBS_CMD_DEREG_MR) |
-		(1ull << IB_USER_VERBS_CMD_CREATE_COMP_CHANNEL) |
-		(1ull << IB_USER_VERBS_CMD_CREATE_CQ) |
-		(1ull << IB_USER_VERBS_CMD_DESTROY_CQ) |
-		(1ull << IB_USER_VERBS_CMD_CREATE_QP) |
-		(1ull << IB_USER_VERBS_CMD_MODIFY_QP) |
-		(1ull << IB_USER_VERBS_CMD_QUERY_QP) |
-		(1ull << IB_USER_VERBS_CMD_DESTROY_QP) |
+	dev->ibdev.uverbs_cmd_mask |=3D
 		(1ull << IB_USER_VERBS_CMD_CREATE_AH) |
 		(1ull << IB_USER_VERBS_CMD_DESTROY_AH);
=20
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband=
/hw/hns/hns_roce_main.c
index f3fe5aeaab8445..d8083b320cf5a8 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -491,21 +491,6 @@ static int hns_roce_register_device(struct hns_roce_de=
v *hr_dev)
 	ib_dev->phys_port_cnt =3D hr_dev->caps.num_ports;
 	ib_dev->local_dma_lkey =3D hr_dev->caps.reserved_lkey;
 	ib_dev->num_comp_vectors =3D hr_dev->caps.num_comp_vectors;
-	ib_dev->uverbs_cmd_mask =3D
-		(1ULL << IB_USER_VERBS_CMD_GET_CONTEXT) |
-		(1ULL << IB_USER_VERBS_CMD_QUERY_DEVICE) |
-		(1ULL << IB_USER_VERBS_CMD_QUERY_PORT) |
-		(1ULL << IB_USER_VERBS_CMD_ALLOC_PD) |
-		(1ULL << IB_USER_VERBS_CMD_DEALLOC_PD) |
-		(1ULL << IB_USER_VERBS_CMD_REG_MR) |
-		(1ULL << IB_USER_VERBS_CMD_DEREG_MR) |
-		(1ULL << IB_USER_VERBS_CMD_CREATE_COMP_CHANNEL) |
-		(1ULL << IB_USER_VERBS_CMD_CREATE_CQ) |
-		(1ULL << IB_USER_VERBS_CMD_DESTROY_CQ) |
-		(1ULL << IB_USER_VERBS_CMD_CREATE_QP) |
-		(1ULL << IB_USER_VERBS_CMD_MODIFY_QP) |
-		(1ULL << IB_USER_VERBS_CMD_QUERY_QP) |
-		(1ULL << IB_USER_VERBS_CMD_DESTROY_QP);
=20
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_REREG_MR) {
 		ib_dev->uverbs_cmd_mask |=3D (1ULL << IB_USER_VERBS_CMD_REREG_MR);
diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband=
/hw/i40iw/i40iw_verbs.c
index 747b4de6faca00..be2bd843c58396 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -2684,25 +2684,11 @@ static struct i40iw_ib_device *i40iw_init_rdma_devi=
ce(struct i40iw_device *iwdev
 	iwibdev->ibdev.node_type =3D RDMA_NODE_RNIC;
 	ether_addr_copy((u8 *)&iwibdev->ibdev.node_guid, netdev->dev_addr);
=20
-	iwibdev->ibdev.uverbs_cmd_mask =3D
-	    (1ull << IB_USER_VERBS_CMD_GET_CONTEXT) |
-	    (1ull << IB_USER_VERBS_CMD_QUERY_DEVICE) |
-	    (1ull << IB_USER_VERBS_CMD_QUERY_PORT) |
-	    (1ull << IB_USER_VERBS_CMD_ALLOC_PD) |
-	    (1ull << IB_USER_VERBS_CMD_DEALLOC_PD) |
-	    (1ull << IB_USER_VERBS_CMD_REG_MR) |
-	    (1ull << IB_USER_VERBS_CMD_DEREG_MR) |
-	    (1ull << IB_USER_VERBS_CMD_CREATE_COMP_CHANNEL) |
-	    (1ull << IB_USER_VERBS_CMD_CREATE_CQ) |
-	    (1ull << IB_USER_VERBS_CMD_DESTROY_CQ) |
+	iwibdev->ibdev.uverbs_cmd_mask |=3D
 	    (1ull << IB_USER_VERBS_CMD_REQ_NOTIFY_CQ) |
-	    (1ull << IB_USER_VERBS_CMD_CREATE_QP) |
-	    (1ull << IB_USER_VERBS_CMD_MODIFY_QP) |
-	    (1ull << IB_USER_VERBS_CMD_QUERY_QP) |
 	    (1ull << IB_USER_VERBS_CMD_POLL_CQ) |
 	    (1ull << IB_USER_VERBS_CMD_CREATE_AH) |
 	    (1ull << IB_USER_VERBS_CMD_DESTROY_AH) |
-	    (1ull << IB_USER_VERBS_CMD_DESTROY_QP) |
 	    (1ull << IB_USER_VERBS_CMD_POST_RECV) |
 	    (1ull << IB_USER_VERBS_CMD_POST_SEND);
 	iwibdev->ibdev.phys_port_cnt =3D 1;
diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4=
/main.c
index 37d31d239a22e0..429f3c9b914c89 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -2657,23 +2657,9 @@ static void *mlx4_ib_add(struct mlx4_dev *dev)
 	ibdev->ib_dev.num_comp_vectors	=3D dev->caps.num_comp_vectors;
 	ibdev->ib_dev.dev.parent	=3D &dev->persist->pdev->dev;
=20
-	ibdev->ib_dev.uverbs_cmd_mask	=3D
-		(1ull << IB_USER_VERBS_CMD_GET_CONTEXT)		|
-		(1ull << IB_USER_VERBS_CMD_QUERY_DEVICE)	|
-		(1ull << IB_USER_VERBS_CMD_QUERY_PORT)		|
-		(1ull << IB_USER_VERBS_CMD_ALLOC_PD)		|
-		(1ull << IB_USER_VERBS_CMD_DEALLOC_PD)		|
-		(1ull << IB_USER_VERBS_CMD_REG_MR)		|
+	ibdev->ib_dev.uverbs_cmd_mask |=3D
 		(1ull << IB_USER_VERBS_CMD_REREG_MR)		|
-		(1ull << IB_USER_VERBS_CMD_DEREG_MR)		|
-		(1ull << IB_USER_VERBS_CMD_CREATE_COMP_CHANNEL)	|
-		(1ull << IB_USER_VERBS_CMD_CREATE_CQ)		|
 		(1ull << IB_USER_VERBS_CMD_RESIZE_CQ)		|
-		(1ull << IB_USER_VERBS_CMD_DESTROY_CQ)		|
-		(1ull << IB_USER_VERBS_CMD_CREATE_QP)		|
-		(1ull << IB_USER_VERBS_CMD_MODIFY_QP)		|
-		(1ull << IB_USER_VERBS_CMD_QUERY_QP)		|
-		(1ull << IB_USER_VERBS_CMD_DESTROY_QP)		|
 		(1ull << IB_USER_VERBS_CMD_ATTACH_MCAST)	|
 		(1ull << IB_USER_VERBS_CMD_DETACH_MCAST)	|
 		(1ull << IB_USER_VERBS_CMD_CREATE_SRQ)		|
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5=
/main.c
index 09e5d9e7859dcd..bcd6802e7eea54 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4139,25 +4139,11 @@ static int mlx5_ib_stage_caps_init(struct mlx5_ib_d=
ev *dev)
 	struct mlx5_core_dev *mdev =3D dev->mdev;
 	int err;
=20
-	dev->ib_dev.uverbs_cmd_mask	=3D
-		(1ull << IB_USER_VERBS_CMD_GET_CONTEXT)		|
-		(1ull << IB_USER_VERBS_CMD_QUERY_DEVICE)	|
-		(1ull << IB_USER_VERBS_CMD_QUERY_PORT)		|
-		(1ull << IB_USER_VERBS_CMD_ALLOC_PD)		|
-		(1ull << IB_USER_VERBS_CMD_DEALLOC_PD)		|
+	dev->ib_dev.uverbs_cmd_mask |=3D
 		(1ull << IB_USER_VERBS_CMD_CREATE_AH)		|
 		(1ull << IB_USER_VERBS_CMD_DESTROY_AH)		|
-		(1ull << IB_USER_VERBS_CMD_REG_MR)		|
 		(1ull << IB_USER_VERBS_CMD_REREG_MR)		|
-		(1ull << IB_USER_VERBS_CMD_DEREG_MR)		|
-		(1ull << IB_USER_VERBS_CMD_CREATE_COMP_CHANNEL)	|
-		(1ull << IB_USER_VERBS_CMD_CREATE_CQ)		|
 		(1ull << IB_USER_VERBS_CMD_RESIZE_CQ)		|
-		(1ull << IB_USER_VERBS_CMD_DESTROY_CQ)		|
-		(1ull << IB_USER_VERBS_CMD_CREATE_QP)		|
-		(1ull << IB_USER_VERBS_CMD_MODIFY_QP)		|
-		(1ull << IB_USER_VERBS_CMD_QUERY_QP)		|
-		(1ull << IB_USER_VERBS_CMD_DESTROY_QP)		|
 		(1ull << IB_USER_VERBS_CMD_ATTACH_MCAST)	|
 		(1ull << IB_USER_VERBS_CMD_DETACH_MCAST)	|
 		(1ull << IB_USER_VERBS_CMD_CREATE_SRQ)		|
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infinib=
and/hw/mthca/mthca_provider.c
index 31b558ff821852..ae03bc4afbc814 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -1158,22 +1158,8 @@ int mthca_register_device(struct mthca_dev *dev)
 	if (ret)
 		return ret;
=20
-	dev->ib_dev.uverbs_cmd_mask	 =3D
-		(1ull << IB_USER_VERBS_CMD_GET_CONTEXT)		|
-		(1ull << IB_USER_VERBS_CMD_QUERY_DEVICE)	|
-		(1ull << IB_USER_VERBS_CMD_QUERY_PORT)		|
-		(1ull << IB_USER_VERBS_CMD_ALLOC_PD)		|
-		(1ull << IB_USER_VERBS_CMD_DEALLOC_PD)		|
-		(1ull << IB_USER_VERBS_CMD_REG_MR)		|
-		(1ull << IB_USER_VERBS_CMD_DEREG_MR)		|
-		(1ull << IB_USER_VERBS_CMD_CREATE_COMP_CHANNEL)	|
-		(1ull << IB_USER_VERBS_CMD_CREATE_CQ)		|
+	dev->ib_dev.uverbs_cmd_mask |=3D
 		(1ull << IB_USER_VERBS_CMD_RESIZE_CQ)		|
-		(1ull << IB_USER_VERBS_CMD_DESTROY_CQ)		|
-		(1ull << IB_USER_VERBS_CMD_CREATE_QP)		|
-		(1ull << IB_USER_VERBS_CMD_QUERY_QP)		|
-		(1ull << IB_USER_VERBS_CMD_MODIFY_QP)		|
-		(1ull << IB_USER_VERBS_CMD_DESTROY_QP)		|
 		(1ull << IB_USER_VERBS_CMD_ATTACH_MCAST)	|
 		(1ull << IB_USER_VERBS_CMD_DETACH_MCAST);
 	dev->ib_dev.node_type            =3D RDMA_NODE_IB_CA;
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_main.c b/drivers/infiniban=
d/hw/ocrdma/ocrdma_main.c
index d8c47d24d6d66b..c9549ff1b24bc7 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_main.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_main.c
@@ -204,23 +204,9 @@ static int ocrdma_register_device(struct ocrdma_dev *d=
ev)
 	BUILD_BUG_ON(sizeof(OCRDMA_NODE_DESC) > IB_DEVICE_NODE_DESC_MAX);
 	memcpy(dev->ibdev.node_desc, OCRDMA_NODE_DESC,
 	       sizeof(OCRDMA_NODE_DESC));
-	dev->ibdev.uverbs_cmd_mask =3D
-	    OCRDMA_UVERBS(GET_CONTEXT) |
-	    OCRDMA_UVERBS(QUERY_DEVICE) |
-	    OCRDMA_UVERBS(QUERY_PORT) |
-	    OCRDMA_UVERBS(ALLOC_PD) |
-	    OCRDMA_UVERBS(DEALLOC_PD) |
-	    OCRDMA_UVERBS(REG_MR) |
-	    OCRDMA_UVERBS(DEREG_MR) |
-	    OCRDMA_UVERBS(CREATE_COMP_CHANNEL) |
-	    OCRDMA_UVERBS(CREATE_CQ) |
+	dev->ibdev.uverbs_cmd_mask |=3D
 	    OCRDMA_UVERBS(RESIZE_CQ) |
-	    OCRDMA_UVERBS(DESTROY_CQ) |
 	    OCRDMA_UVERBS(REQ_NOTIFY_CQ) |
-	    OCRDMA_UVERBS(CREATE_QP) |
-	    OCRDMA_UVERBS(MODIFY_QP) |
-	    OCRDMA_UVERBS(QUERY_QP) |
-	    OCRDMA_UVERBS(DESTROY_QP) |
 	    OCRDMA_UVERBS(POLL_CQ) |
 	    OCRDMA_UVERBS(POST_SEND) |
 	    OCRDMA_UVERBS(POST_RECV);
diff --git a/drivers/infiniband/hw/qedr/main.c b/drivers/infiniband/hw/qedr=
/main.c
index 7c0aac3e635bcb..f4afd6473eca4a 100644
--- a/drivers/infiniband/hw/qedr/main.c
+++ b/drivers/infiniband/hw/qedr/main.c
@@ -249,27 +249,14 @@ static int qedr_register_device(struct qedr_dev *dev)
 	dev->ibdev.node_guid =3D dev->attr.node_guid;
 	memcpy(dev->ibdev.node_desc, QEDR_NODE_DESC, sizeof(QEDR_NODE_DESC));
=20
-	dev->ibdev.uverbs_cmd_mask =3D QEDR_UVERBS(GET_CONTEXT) |
-				     QEDR_UVERBS(QUERY_DEVICE) |
-				     QEDR_UVERBS(QUERY_PORT) |
-				     QEDR_UVERBS(ALLOC_PD) |
-				     QEDR_UVERBS(DEALLOC_PD) |
-				     QEDR_UVERBS(CREATE_COMP_CHANNEL) |
-				     QEDR_UVERBS(CREATE_CQ) |
+	dev->ibdev.uverbs_cmd_mask |=3D
 				     QEDR_UVERBS(RESIZE_CQ) |
-				     QEDR_UVERBS(DESTROY_CQ) |
 				     QEDR_UVERBS(REQ_NOTIFY_CQ) |
-				     QEDR_UVERBS(CREATE_QP) |
-				     QEDR_UVERBS(MODIFY_QP) |
-				     QEDR_UVERBS(QUERY_QP) |
-				     QEDR_UVERBS(DESTROY_QP) |
 				     QEDR_UVERBS(CREATE_SRQ) |
 				     QEDR_UVERBS(DESTROY_SRQ) |
 				     QEDR_UVERBS(QUERY_SRQ) |
 				     QEDR_UVERBS(MODIFY_SRQ) |
 				     QEDR_UVERBS(POST_SRQ_RECV) |
-				     QEDR_UVERBS(REG_MR) |
-				     QEDR_UVERBS(DEREG_MR) |
 				     QEDR_UVERBS(POLL_CQ) |
 				     QEDR_UVERBS(POST_SEND) |
 				     QEDR_UVERBS(POST_RECV);
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_main.c b/drivers/infiniba=
nd/hw/usnic/usnic_ib_main.c
index 462ed71abf5318..5a75113af7ed80 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_main.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_main.c
@@ -398,21 +398,7 @@ static void *usnic_ib_device_add(struct pci_dev *dev)
 	us_ibdev->ib_dev.num_comp_vectors =3D USNIC_IB_NUM_COMP_VECTORS;
 	us_ibdev->ib_dev.dev.parent =3D &dev->dev;
=20
-	us_ibdev->ib_dev.uverbs_cmd_mask =3D
-		(1ull << IB_USER_VERBS_CMD_GET_CONTEXT) |
-		(1ull << IB_USER_VERBS_CMD_QUERY_DEVICE) |
-		(1ull << IB_USER_VERBS_CMD_QUERY_PORT) |
-		(1ull << IB_USER_VERBS_CMD_ALLOC_PD) |
-		(1ull << IB_USER_VERBS_CMD_DEALLOC_PD) |
-		(1ull << IB_USER_VERBS_CMD_REG_MR) |
-		(1ull << IB_USER_VERBS_CMD_DEREG_MR) |
-		(1ull << IB_USER_VERBS_CMD_CREATE_COMP_CHANNEL) |
-		(1ull << IB_USER_VERBS_CMD_CREATE_CQ) |
-		(1ull << IB_USER_VERBS_CMD_DESTROY_CQ) |
-		(1ull << IB_USER_VERBS_CMD_CREATE_QP) |
-		(1ull << IB_USER_VERBS_CMD_MODIFY_QP) |
-		(1ull << IB_USER_VERBS_CMD_QUERY_QP) |
-		(1ull << IB_USER_VERBS_CMD_DESTROY_QP) |
+	us_ibdev->ib_dev.uverbs_cmd_mask |=3D
 		(1ull << IB_USER_VERBS_CMD_ATTACH_MCAST) |
 		(1ull << IB_USER_VERBS_CMD_DETACH_MCAST) |
 		(1ull << IB_USER_VERBS_CMD_OPEN_QP);
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c b/drivers/infin=
iband/hw/vmw_pvrdma/pvrdma_main.c
index 780fd2dfc07eb0..eeb96fe95b4d93 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
@@ -205,23 +205,9 @@ static int pvrdma_register_device(struct pvrdma_dev *d=
ev)
 	dev->flags =3D 0;
 	dev->ib_dev.num_comp_vectors =3D 1;
 	dev->ib_dev.dev.parent =3D &dev->pdev->dev;
-	dev->ib_dev.uverbs_cmd_mask =3D
-		(1ull << IB_USER_VERBS_CMD_GET_CONTEXT)		|
-		(1ull << IB_USER_VERBS_CMD_QUERY_DEVICE)	|
-		(1ull << IB_USER_VERBS_CMD_QUERY_PORT)		|
-		(1ull << IB_USER_VERBS_CMD_ALLOC_PD)		|
-		(1ull << IB_USER_VERBS_CMD_DEALLOC_PD)		|
-		(1ull << IB_USER_VERBS_CMD_REG_MR)		|
-		(1ull << IB_USER_VERBS_CMD_DEREG_MR)		|
-		(1ull << IB_USER_VERBS_CMD_CREATE_COMP_CHANNEL)	|
-		(1ull << IB_USER_VERBS_CMD_CREATE_CQ)		|
+	dev->ib_dev.uverbs_cmd_mask |=3D
 		(1ull << IB_USER_VERBS_CMD_POLL_CQ)		|
 		(1ull << IB_USER_VERBS_CMD_REQ_NOTIFY_CQ)	|
-		(1ull << IB_USER_VERBS_CMD_DESTROY_CQ)		|
-		(1ull << IB_USER_VERBS_CMD_CREATE_QP)		|
-		(1ull << IB_USER_VERBS_CMD_MODIFY_QP)		|
-		(1ull << IB_USER_VERBS_CMD_QUERY_QP)		|
-		(1ull << IB_USER_VERBS_CMD_DESTROY_QP)		|
 		(1ull << IB_USER_VERBS_CMD_POST_SEND)		|
 		(1ull << IB_USER_VERBS_CMD_POST_RECV)		|
 		(1ull << IB_USER_VERBS_CMD_CREATE_AH)		|
diff --git a/drivers/infiniband/sw/rdmavt/vt.c b/drivers/infiniband/sw/rdma=
vt/vt.c
index f904bb34477ae7..b6706125ec6610 100644
--- a/drivers/infiniband/sw/rdmavt/vt.c
+++ b/drivers/infiniband/sw/rdmavt/vt.c
@@ -593,28 +593,14 @@ int rvt_register_device(struct rvt_dev_info *rdi)
 	 * exactly which functions rdmavt supports, nor do they know the ABI
 	 * version, so we do all of this sort of stuff here.
 	 */
-	rdi->ibdev.uverbs_cmd_mask =3D
-		(1ull << IB_USER_VERBS_CMD_GET_CONTEXT)         |
-		(1ull << IB_USER_VERBS_CMD_QUERY_DEVICE)        |
-		(1ull << IB_USER_VERBS_CMD_QUERY_PORT)          |
-		(1ull << IB_USER_VERBS_CMD_ALLOC_PD)            |
-		(1ull << IB_USER_VERBS_CMD_DEALLOC_PD)          |
+	rdi->ibdev.uverbs_cmd_mask |=3D
 		(1ull << IB_USER_VERBS_CMD_CREATE_AH)           |
 		(1ull << IB_USER_VERBS_CMD_MODIFY_AH)           |
 		(1ull << IB_USER_VERBS_CMD_QUERY_AH)            |
 		(1ull << IB_USER_VERBS_CMD_DESTROY_AH)          |
-		(1ull << IB_USER_VERBS_CMD_REG_MR)              |
-		(1ull << IB_USER_VERBS_CMD_DEREG_MR)            |
-		(1ull << IB_USER_VERBS_CMD_CREATE_COMP_CHANNEL) |
-		(1ull << IB_USER_VERBS_CMD_CREATE_CQ)           |
 		(1ull << IB_USER_VERBS_CMD_RESIZE_CQ)           |
-		(1ull << IB_USER_VERBS_CMD_DESTROY_CQ)          |
 		(1ull << IB_USER_VERBS_CMD_POLL_CQ)             |
 		(1ull << IB_USER_VERBS_CMD_REQ_NOTIFY_CQ)       |
-		(1ull << IB_USER_VERBS_CMD_CREATE_QP)           |
-		(1ull << IB_USER_VERBS_CMD_QUERY_QP)            |
-		(1ull << IB_USER_VERBS_CMD_MODIFY_QP)           |
-		(1ull << IB_USER_VERBS_CMD_DESTROY_QP)          |
 		(1ull << IB_USER_VERBS_CMD_POST_SEND)           |
 		(1ull << IB_USER_VERBS_CMD_POST_RECV)           |
 		(1ull << IB_USER_VERBS_CMD_ATTACH_MCAST)        |
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/=
rxe/rxe_verbs.c
index f368dc16281ab9..3aa83f4c47772b 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1135,31 +1135,18 @@ int rxe_register_device(struct rxe_dev *rxe, const =
char *ibdev_name)
 	dma_coerce_mask_and_coherent(&dev->dev,
 				     dma_get_required_mask(&dev->dev));
=20
-	dev->uverbs_cmd_mask =3D BIT_ULL(IB_USER_VERBS_CMD_GET_CONTEXT)
-	    | BIT_ULL(IB_USER_VERBS_CMD_CREATE_COMP_CHANNEL)
-	    | BIT_ULL(IB_USER_VERBS_CMD_QUERY_DEVICE)
-	    | BIT_ULL(IB_USER_VERBS_CMD_QUERY_PORT)
-	    | BIT_ULL(IB_USER_VERBS_CMD_ALLOC_PD)
-	    | BIT_ULL(IB_USER_VERBS_CMD_DEALLOC_PD)
-	    | BIT_ULL(IB_USER_VERBS_CMD_CREATE_SRQ)
+	dev->uverbs_cmd_mask |=3D
+	    BIT_ULL(IB_USER_VERBS_CMD_CREATE_SRQ)
 	    | BIT_ULL(IB_USER_VERBS_CMD_MODIFY_SRQ)
 	    | BIT_ULL(IB_USER_VERBS_CMD_QUERY_SRQ)
 	    | BIT_ULL(IB_USER_VERBS_CMD_DESTROY_SRQ)
 	    | BIT_ULL(IB_USER_VERBS_CMD_POST_SRQ_RECV)
-	    | BIT_ULL(IB_USER_VERBS_CMD_CREATE_QP)
-	    | BIT_ULL(IB_USER_VERBS_CMD_MODIFY_QP)
-	    | BIT_ULL(IB_USER_VERBS_CMD_QUERY_QP)
-	    | BIT_ULL(IB_USER_VERBS_CMD_DESTROY_QP)
 	    | BIT_ULL(IB_USER_VERBS_CMD_POST_SEND)
 	    | BIT_ULL(IB_USER_VERBS_CMD_POST_RECV)
-	    | BIT_ULL(IB_USER_VERBS_CMD_CREATE_CQ)
 	    | BIT_ULL(IB_USER_VERBS_CMD_RESIZE_CQ)
-	    | BIT_ULL(IB_USER_VERBS_CMD_DESTROY_CQ)
 	    | BIT_ULL(IB_USER_VERBS_CMD_POLL_CQ)
 	    | BIT_ULL(IB_USER_VERBS_CMD_PEEK_CQ)
 	    | BIT_ULL(IB_USER_VERBS_CMD_REQ_NOTIFY_CQ)
-	    | BIT_ULL(IB_USER_VERBS_CMD_REG_MR)
-	    | BIT_ULL(IB_USER_VERBS_CMD_DEREG_MR)
 	    | BIT_ULL(IB_USER_VERBS_CMD_CREATE_AH)
 	    | BIT_ULL(IB_USER_VERBS_CMD_MODIFY_AH)
 	    | BIT_ULL(IB_USER_VERBS_CMD_QUERY_AH)
diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/s=
iw/siw_main.c
index d862bec843766f..cf472118cb5364 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -346,23 +346,9 @@ static struct siw_device *siw_device_create(struct net=
_device *netdev)
 		addrconf_addr_eui48((unsigned char *)&base_dev->node_guid,
 				    addr);
 	}
-	base_dev->uverbs_cmd_mask =3D
-		(1ull << IB_USER_VERBS_CMD_QUERY_DEVICE) |
-		(1ull << IB_USER_VERBS_CMD_QUERY_PORT) |
-		(1ull << IB_USER_VERBS_CMD_GET_CONTEXT) |
-		(1ull << IB_USER_VERBS_CMD_ALLOC_PD) |
-		(1ull << IB_USER_VERBS_CMD_DEALLOC_PD) |
-		(1ull << IB_USER_VERBS_CMD_REG_MR) |
-		(1ull << IB_USER_VERBS_CMD_DEREG_MR) |
-		(1ull << IB_USER_VERBS_CMD_CREATE_COMP_CHANNEL) |
-		(1ull << IB_USER_VERBS_CMD_CREATE_CQ) |
+	base_dev->uverbs_cmd_mask |=3D
 		(1ull << IB_USER_VERBS_CMD_POLL_CQ) |
 		(1ull << IB_USER_VERBS_CMD_REQ_NOTIFY_CQ) |
-		(1ull << IB_USER_VERBS_CMD_DESTROY_CQ) |
-		(1ull << IB_USER_VERBS_CMD_CREATE_QP) |
-		(1ull << IB_USER_VERBS_CMD_QUERY_QP) |
-		(1ull << IB_USER_VERBS_CMD_MODIFY_QP) |
-		(1ull << IB_USER_VERBS_CMD_DESTROY_QP) |
 		(1ull << IB_USER_VERBS_CMD_POST_SEND) |
 		(1ull << IB_USER_VERBS_CMD_POST_RECV) |
 		(1ull << IB_USER_VERBS_CMD_CREATE_SRQ) |
--=20
2.28.0

