Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B733282755
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Oct 2020 01:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgJCXUg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 3 Oct 2020 19:20:36 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:6871 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbgJCXUg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 3 Oct 2020 19:20:36 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7906db0000>; Sat, 03 Oct 2020 16:18:51 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 3 Oct
 2020 23:20:16 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.54) by
 HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Sat, 3 Oct 2020 23:20:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JrgVZjI35ylaqA9QDtZXlmdN4UZD7CMZ+w3zjmR4Jakr3x1s3lnYMdYcBzOgFLVDhxZSwuq/DtGdJVWAN2N8B1+thgno7auwAY5Vo1CRbr+TJzsHEGRVusBD0ZUhs/zgUObIpDHdv+zhlbj7a4RYnTjEphIei7o3C7V9PmdjEsQfRad2ccKxN1+Jch3PSmQMe83K+xXlfhz4RY+LSncazfrWOcyV7KBcluXM8PTPYCvxkFb0Eb18lcvGVm30guf6OagH+6Aoo+b7LWeuQgkKp4ukJ+ZCkEmM2BTojzwLKYxTt9dplfGetp8P43J6If7cbinoKLFyRSATt14Vo+QpZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emda/VWYiy9gddrpc9uUWox0RXORywtu2U4WWLEJCto=;
 b=QmDLIm2aZFQcef83d61qzYVf9s/ee6Bggv2nC/wLef7JFAMxzU6Ag7WaG7WSfOMytpX8eNHokZ4FJa9L+3FPjNOVifJXPihmHFM8VLJ40vfr3RCVpzgWaHhZ+DI9RYaCTfv4pHwlC+u+3vzFam46RdYZAYxsX3s0/j7pOGK9Yt/zJ3sNNidyXayYh8iqOaU4IlNfSbWSGEzI0Q+E5XKFQHOxeIVSTelXrmRK9lcOalg6oHZPjYaUdNGOTxh61UkQAv2/I3fVeYyra4d0nn1gDOoIAsDCgBOucMB/hJNYb/5UqDC61YJejrleRetXlO7RiIPl9pq2Y1tqhDqaiWmxLw==
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
        Faisal Latif <faisal.latif@intel.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        <linux-rdma@vger.kernel.org>, Weihang Li <liweihang@huawei.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        Lijun Ou <oulijun@huawei.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        "Shiraz Saleem" <shiraz.saleem@intel.com>,
        Zhu Yanjun <yanjunz@nvidia.com>
Subject: [PATCH 10/11] RDMA: Remove uverbs cmds from drivers that don't use them
Date:   Sat, 3 Oct 2020 20:20:10 -0300
Message-ID: <10-v1-caa70ba3d1ab+1436e-ucmd_mask_jgg@nvidia.com>
In-Reply-To: <0-v1-caa70ba3d1ab+1436e-ucmd_mask_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BL0PR0102CA0037.prod.exchangelabs.com
 (2603:10b6:208:25::14) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR0102CA0037.prod.exchangelabs.com (2603:10b6:208:25::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32 via Frontend Transport; Sat, 3 Oct 2020 23:20:13 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kOqp2-0075cp-0D; Sat, 03 Oct 2020 20:20:12 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601767131; bh=0j4p42Xhx55O1cks1R/qseLBvXtU8PJKMU8qTBXOHxI=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         Subject:Date:Message-ID:In-Reply-To:References:
         Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
         MIME-Version:X-MS-Exchange-MessageSentRepresentingType;
        b=n97yjhigJwsqG4XZ0/AMMT8iFb5+k1fHJWVHYO6Ndw+6ehLfmPTWSR9v3qnAXTXjm
         5IgbBltOAJI1PxNL4/psiTZ3Q+NmRIyUbqVSx1p1rfLSuNzCGd/tWxEmFpRJcB8LSs
         F/KYNWu4TdwyqSheaAlaBP6sQuuvZYk28nxkmcj/5dmBX8k6Qstx7l3AL75IgDnGP/
         Y6FuSUxObsuRDykzBrbTY8PBoatFv0LiryX87NEiN/+ntad3XGCsvm6CpqgapcNcsS
         KSYN2ELJS2P1MtO18r4cw3La0fc4dFUX4+8kmkkBD4Cq4/5aqCct+1lACpHT9hCyDw
         dai6tgOjOLmXA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Allowing userspace to invoke these commands is probably going to crash
these drivers as they are not tested and not expecting to use them on a
user object.

For example pvrdma touches cq->ring_state which is not initialized for
user QPs.

These commands are effected:

- IB_USER_VERBS_CMD_REQ_NOTIFY_CQ is ibv_cmd_req_notify_cq() in
  rdma-core, only hfi1, ipath and rxe calls it.

- IB_USER_VERBS_CMD_POLL_CQ is ibv_cmd_poll_cq() in rdma-core, only
  ipath and hfi1 calls it.

- IB_USER_VERBS_CMD_POST_SEND/RECV is ibv_cmd_post_send/recv() in
  rdma-core, only ipath and hfi1 call them.

- IB_USER_VERBS_CMD_POST_SRQ_RECV is ibv_cmd_post_srq_recv() in
  rdma-core, only ipath and hfi1 calls it.

- IB_USER_VERBS_CMD_PEEK_CQ isn't even implemented anywhere

- IB_USER_VERBS_CMD_CREATE/DESTROY_AH is ibv_cmd_create/destroy_ah() in
  rdma-core, only bnxt_re, efa, hfi1, ipath, mlx5, orcrdma, and rxe call
  it.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/cxgb4/provider.c         |  5 -----
 drivers/infiniband/hw/hns/hns_roce_main.c      |  2 --
 drivers/infiniband/hw/i40iw/i40iw_verbs.c      |  7 -------
 drivers/infiniband/hw/ocrdma/ocrdma_main.c     | 12 ++----------
 drivers/infiniband/hw/qedr/main.c              |  7 -------
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c | 10 ----------
 drivers/infiniband/sw/rxe/rxe_verbs.c          |  7 +------
 drivers/infiniband/sw/siw/siw_main.c           |  6 ------
 8 files changed, 3 insertions(+), 53 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw=
/cxgb4/provider.c
index d3a84fdd2396f3..2591ecead3d82a 100644
--- a/drivers/infiniband/hw/cxgb4/provider.c
+++ b/drivers/infiniband/hw/cxgb4/provider.c
@@ -531,11 +531,6 @@ void c4iw_register_device(struct work_struct *work)
 	if (fastreg_support)
 		dev->device_cap_flags |=3D IB_DEVICE_MEM_MGT_EXTENSIONS;
 	dev->ibdev.local_dma_lkey =3D 0;
-	dev->ibdev.uverbs_cmd_mask |=3D
-	    (1ull << IB_USER_VERBS_CMD_REQ_NOTIFY_CQ) |
-	    (1ull << IB_USER_VERBS_CMD_POLL_CQ) |
-	    (1ull << IB_USER_VERBS_CMD_POST_SEND) |
-	    (1ull << IB_USER_VERBS_CMD_POST_RECV);
 	dev->ibdev.node_type =3D RDMA_NODE_RNIC;
 	BUILD_BUG_ON(sizeof(C4IW_NODE_DESC) > IB_DEVICE_NODE_DESC_MAX);
 	memcpy(dev->ibdev.node_desc, C4IW_NODE_DESC, sizeof(C4IW_NODE_DESC));
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband=
/hw/hns/hns_roce_main.c
index a75c09564447b3..25c727d1ac8a6e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -505,8 +505,6 @@ static int hns_roce_register_device(struct hns_roce_dev=
 *hr_dev)
=20
 	/* SRQ */
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_SRQ) {
-		ib_dev->uverbs_cmd_mask |=3D
-				(1ULL << IB_USER_VERBS_CMD_POST_SRQ_RECV);
 		ib_set_device_ops(ib_dev, &hns_roce_dev_srq_ops);
 		ib_set_device_ops(ib_dev, hr_dev->hw->hns_roce_dev_srq_ops);
 	}
diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband=
/hw/i40iw/i40iw_verbs.c
index 65c9e010d4d5b1..ce60c5ef88261f 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -2690,13 +2690,6 @@ static struct i40iw_ib_device *i40iw_init_rdma_devic=
e(struct i40iw_device *iwdev
 	iwibdev->ibdev.node_type =3D RDMA_NODE_RNIC;
 	ether_addr_copy((u8 *)&iwibdev->ibdev.node_guid, netdev->dev_addr);
=20
-	iwibdev->ibdev.uverbs_cmd_mask |=3D
-	    (1ull << IB_USER_VERBS_CMD_REQ_NOTIFY_CQ) |
-	    (1ull << IB_USER_VERBS_CMD_POLL_CQ) |
-	    (1ull << IB_USER_VERBS_CMD_CREATE_AH) |
-	    (1ull << IB_USER_VERBS_CMD_DESTROY_AH) |
-	    (1ull << IB_USER_VERBS_CMD_POST_RECV) |
-	    (1ull << IB_USER_VERBS_CMD_POST_SEND);
 	iwibdev->ibdev.phys_port_cnt =3D 1;
 	iwibdev->ibdev.num_comp_vectors =3D iwdev->ceqs_count;
 	iwibdev->ibdev.dev.parent =3D &pcidev->dev;
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_main.c b/drivers/infiniban=
d/hw/ocrdma/ocrdma_main.c
index 40ed7a42f1e1ca..d7dc7a76f9854c 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_main.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_main.c
@@ -204,11 +204,6 @@ static int ocrdma_register_device(struct ocrdma_dev *d=
ev)
 	BUILD_BUG_ON(sizeof(OCRDMA_NODE_DESC) > IB_DEVICE_NODE_DESC_MAX);
 	memcpy(dev->ibdev.node_desc, OCRDMA_NODE_DESC,
 	       sizeof(OCRDMA_NODE_DESC));
-	dev->ibdev.uverbs_cmd_mask |=3D
-	    OCRDMA_UVERBS(REQ_NOTIFY_CQ) |
-	    OCRDMA_UVERBS(POLL_CQ) |
-	    OCRDMA_UVERBS(POST_SEND) |
-	    OCRDMA_UVERBS(POST_RECV);
=20
 	dev->ibdev.uverbs_cmd_mask |=3D
 	    OCRDMA_UVERBS(CREATE_AH) |
@@ -225,12 +220,9 @@ static int ocrdma_register_device(struct ocrdma_dev *d=
ev)
=20
 	ib_set_device_ops(&dev->ibdev, &ocrdma_dev_ops);
=20
-	if (ocrdma_get_asic_type(dev) =3D=3D OCRDMA_ASIC_GEN_SKH_R) {
-		dev->ibdev.uverbs_cmd_mask |=3D
-		     OCRDMA_UVERBS(POST_SRQ_RECV);
-
+	if (ocrdma_get_asic_type(dev) =3D=3D OCRDMA_ASIC_GEN_SKH_R)
 		ib_set_device_ops(&dev->ibdev, &ocrdma_dev_srq_ops);
-	}
+
 	rdma_set_device_sysfs_group(&dev->ibdev, &ocrdma_attr_group);
 	ret =3D ib_device_set_netdev(&dev->ibdev, dev->nic_info.netdev, 1);
 	if (ret)
diff --git a/drivers/infiniband/hw/qedr/main.c b/drivers/infiniband/hw/qedr=
/main.c
index d50ee9eacd463d..ee674648208daa 100644
--- a/drivers/infiniband/hw/qedr/main.c
+++ b/drivers/infiniband/hw/qedr/main.c
@@ -245,13 +245,6 @@ static int qedr_register_device(struct qedr_dev *dev)
 	dev->ibdev.node_guid =3D dev->attr.node_guid;
 	memcpy(dev->ibdev.node_desc, QEDR_NODE_DESC, sizeof(QEDR_NODE_DESC));
=20
-	dev->ibdev.uverbs_cmd_mask |=3D
-				     QEDR_UVERBS(REQ_NOTIFY_CQ) |
-				     QEDR_UVERBS(POST_SRQ_RECV) |
-				     QEDR_UVERBS(POLL_CQ) |
-				     QEDR_UVERBS(POST_SEND) |
-				     QEDR_UVERBS(POST_RECV);
-
 	if (IS_IWARP(dev)) {
 		rc =3D qedr_iw_register_device(dev);
 		if (rc)
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c b/drivers/infin=
iband/hw/vmw_pvrdma/pvrdma_main.c
index 41836811a71d55..aa18ab53c6f149 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
@@ -205,13 +205,6 @@ static int pvrdma_register_device(struct pvrdma_dev *d=
ev)
 	dev->flags =3D 0;
 	dev->ib_dev.num_comp_vectors =3D 1;
 	dev->ib_dev.dev.parent =3D &dev->pdev->dev;
-	dev->ib_dev.uverbs_cmd_mask |=3D
-		(1ull << IB_USER_VERBS_CMD_POLL_CQ)		|
-		(1ull << IB_USER_VERBS_CMD_REQ_NOTIFY_CQ)	|
-		(1ull << IB_USER_VERBS_CMD_POST_SEND)		|
-		(1ull << IB_USER_VERBS_CMD_POST_RECV)		|
-		(1ull << IB_USER_VERBS_CMD_CREATE_AH)		|
-		(1ull << IB_USER_VERBS_CMD_DESTROY_AH);
=20
 	dev->ib_dev.node_type =3D RDMA_NODE_IB_CA;
 	dev->ib_dev.phys_port_cnt =3D dev->dsr->caps.phys_port_cnt;
@@ -235,9 +228,6 @@ static int pvrdma_register_device(struct pvrdma_dev *de=
v)
=20
 	/* Check if SRQ is supported by backend */
 	if (dev->dsr->caps.max_srq) {
-		dev->ib_dev.uverbs_cmd_mask |=3D
-			(1ull << IB_USER_VERBS_CMD_POST_SRQ_RECV);
-
 		ib_set_device_ops(&dev->ib_dev, &pvrdma_dev_srq_ops);
=20
 		dev->srq_tbl =3D kcalloc(dev->dsr->caps.max_srq,
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/=
rxe/rxe_verbs.c
index 9100a39f9cb9fe..12dfaab1549f1e 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1145,12 +1145,7 @@ int rxe_register_device(struct rxe_dev *rxe, const c=
har *ibdev_name)
 				     dma_get_required_mask(&dev->dev));
=20
 	dev->uverbs_cmd_mask |=3D
-	    BIT_ULL(IB_USER_VERBS_CMD_POST_SRQ_RECV)
-	    | BIT_ULL(IB_USER_VERBS_CMD_POST_SEND)
-	    | BIT_ULL(IB_USER_VERBS_CMD_POST_RECV)
-	    | BIT_ULL(IB_USER_VERBS_CMD_POLL_CQ)
-	    | BIT_ULL(IB_USER_VERBS_CMD_PEEK_CQ)
-	    | BIT_ULL(IB_USER_VERBS_CMD_REQ_NOTIFY_CQ)
+	    BIT_ULL(IB_USER_VERBS_CMD_REQ_NOTIFY_CQ)
 	    | BIT_ULL(IB_USER_VERBS_CMD_CREATE_AH)
 	    | BIT_ULL(IB_USER_VERBS_CMD_MODIFY_AH)
 	    | BIT_ULL(IB_USER_VERBS_CMD_QUERY_AH)
diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/s=
iw/siw_main.c
index faef91ba031ca7..c08f9a2877992b 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -346,12 +346,6 @@ static struct siw_device *siw_device_create(struct net=
_device *netdev)
 		addrconf_addr_eui48((unsigned char *)&base_dev->node_guid,
 				    addr);
 	}
-	base_dev->uverbs_cmd_mask |=3D
-		(1ull << IB_USER_VERBS_CMD_POLL_CQ) |
-		(1ull << IB_USER_VERBS_CMD_REQ_NOTIFY_CQ) |
-		(1ull << IB_USER_VERBS_CMD_POST_SEND) |
-		(1ull << IB_USER_VERBS_CMD_POST_RECV) |
-		(1ull << IB_USER_VERBS_CMD_POST_SRQ_RECV);
=20
 	base_dev->node_type =3D RDMA_NODE_RNIC;
 	memcpy(base_dev->node_desc, SIW_NODE_DESC_COMMON,
--=20
2.28.0

