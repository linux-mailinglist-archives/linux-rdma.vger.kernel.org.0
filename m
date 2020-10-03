Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A31282757
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Oct 2020 01:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgJCXUp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 3 Oct 2020 19:20:45 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:14606 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbgJCXUp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 3 Oct 2020 19:20:45 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7907390000>; Sat, 03 Oct 2020 16:20:25 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 3 Oct
 2020 23:20:16 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.54) by
 HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Sat, 3 Oct 2020 23:20:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDWGN6NTuct+nKRI8DXVHbQ6Kru/SSD081ZzUTtC84Df3MqEw/nHIo8wq/BtY05JnhEqQwx6edG8byAtMwzAHQcEA2rsK9XOORqo5WMRvGXzuOiyiUr9Gquk20SuOMsb3pjmtXE54ONmNCAXWKdgo0L+k+vm+vS8RbseHZ/b9bNiXnUhjiFE+ebW9XoeUB9QbpegHMqygUsHlZmvTSUd9xXzDW9weWPD+66f6LV+iy1CSur0aLmfqrdzn7E/Fc0ZtqsK9/3jR0XWCJNxTPBdXc8pbJhoTg8e6a6sPC+ewMMUKGqCAF6Bj9KLEF9oB6SVBdRvtSI/DhC5YmGXjaXgTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEEXUJoCwq57g0RF4TekfHwhguU8pI9SHCwbl5QxEQE=;
 b=AUW83BnD7BOemkNKi7ZVTaex0C3196yZcMLZU3k/XCCAyhn15npDIqXk/cbjoBlk9asPr5w1sUZD0U0K1/4K7Dxy5TMMjKntpTMppjlxck+x8MULOso7Z4C5ppe49XVEOoQXLVgBz3C6cFRXAYcZVfTknTlPVBea7kHFnB1PCPXlytzUEHFGx+peb85nNutERWuNC1U4CiA1iH3jv4K9qmInSsHXKX4bRB5hMSUOAh1NrF/XaZbqO0bynpiHig7dbLXWaa+dP52AvgYXN2gANWr9mAQJJoGl46SloHKJh5IGAjBuS/1Z1VY4HrfW9AnyvFXIvbv2IScQjfSsVGDpEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2582.namprd12.prod.outlook.com (2603:10b6:4:b5::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Sat, 3 Oct
 2020 23:20:14 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.038; Sat, 3 Oct 2020
 23:20:14 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Adit Ranadive <aditr@vmware.com>, Ariel Elior <aelior@marvell.com>,
        Christian Benvenuti <benve@cisco.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        "Dennis Dalessandro" <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
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
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Zhu Yanjun <yanjunz@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH 04/11] RDMA: Move more uverbs_cmd_mask settings to the core
Date:   Sat, 3 Oct 2020 20:20:04 -0300
Message-ID: <4-v1-caa70ba3d1ab+1436e-ucmd_mask_jgg@nvidia.com>
In-Reply-To: <0-v1-caa70ba3d1ab+1436e-ucmd_mask_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0029.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::42) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR15CA0029.namprd15.prod.outlook.com (2603:10b6:208:1b4::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35 via Frontend Transport; Sat, 3 Oct 2020 23:20:12 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kOqp1-0075cQ-Lk; Sat, 03 Oct 2020 20:20:11 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601767225; bh=qfCgPl7K6tOsy2RDdq34XngQgvKTe4QHtmH9c1qUMIM=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         Subject:Date:Message-ID:In-Reply-To:References:
         Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
         MIME-Version:X-MS-Exchange-MessageSentRepresentingType;
        b=HJFzVjV3yY4zyWja0DvqPDqFmJz6qrqlWXEDwNSdhKoBHRSoynhEBfQr7Yr/NYuzL
         pjn1DU8H7AXIaSJaJWGCw8SNggUWFD28EKcuQMuuNXtDqVn0AYNiXYWJUxptrRXCF4
         cVlA+jBDl3nJdDN2+ubyJ7myx2BAtbHDfAbd0ZCSD8TAwkBqPWl5qh8kSjo7EI4T7v
         AY4zoIBZglOd+L6GCcqpBRnaSzP5BpqScDkb0tCekmuo3mMgALLOTCguIwOUttIDOE
         JNWhVKk3e96UypulyaqKX2JJvMqhm02ngSitlaZNb7SmPKrThmq80nldO5qtnFTMfg
         VfoVLrtZMT9xA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

These functions all depend on the driver providing a specific op:

- REREG_MR is rereg_user_mr(). bnxt_re set this without providing the op
- ATTACH/DEATCH_MCAST is attach_mcast()/detach_mcast(). usnic set this
  without providing the op
- OPEN_QP doesn't involve the driver but requires a XRCD. qedr provides
  xrcd but forgot to set it, usnic doesn't provide XRCD but set it anyhow.
- OPEN/CLOSE_XRCD are the ops alloc_xrcd()/dealloc_xrcd()
- CREATE_SRQ/DESTROY_SRQ are the ops create_srq()/destroy_srq()
- QUERY/MODIFY_SRQ is op query_srq()/modify_srq(). hns sets this but
  sometimes supplies a NULL op.
- RESIZE_CQ is op resize_cq(). bnxt_re sets this boes doesn't supply an op
- ALLOC/DEALLOC_MW is alloc_mw()/dealloc_mw(). cxgb4 provided an
  (now deleted) implementation but no userspace

All drivers were checked that no drivers provide the op without also
setting uverbs_cmd_mask so this should have no functional change.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/device.c              | 16 ++++++++++++-
 drivers/infiniband/core/uverbs_cmd.c          |  8 +++----
 drivers/infiniband/hw/bnxt_re/main.c          |  6 -----
 drivers/infiniband/hw/cxgb4/provider.c        |  5 +---
 drivers/infiniband/hw/hns/hns_roce_main.c     | 14 ++---------
 drivers/infiniband/hw/mlx4/main.c             | 20 ++--------------
 drivers/infiniband/hw/mlx5/main.c             | 23 +++----------------
 drivers/infiniband/hw/mthca/mthca_provider.c  | 10 --------
 drivers/infiniband/hw/ocrdma/ocrdma_main.c    |  5 ----
 drivers/infiniband/hw/qedr/main.c             |  8 +------
 drivers/infiniband/hw/usnic/usnic_ib_main.c   |  5 ----
 .../infiniband/hw/vmw_pvrdma/pvrdma_main.c    |  4 ----
 drivers/infiniband/sw/rdmavt/vt.c             |  7 ------
 drivers/infiniband/sw/rxe/rxe_verbs.c         |  9 +-------
 drivers/infiniband/sw/siw/siw_main.c          |  6 +----
 15 files changed, 30 insertions(+), 116 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/dev=
ice.c
index 4b29c6b7aa6e7f..7d70ecdc32cc2e 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -284,6 +284,7 @@ static void ib_device_check_mandatory(struct ib_device =
*device)
 		IB_MANDATORY_FUNC(poll_cq),
 		IB_MANDATORY_FUNC(req_notify_cq),
 		IB_MANDATORY_FUNC(get_dma_mr),
+		IB_MANDATORY_FUNC(reg_user_mr),
 		IB_MANDATORY_FUNC(dereg_mr),
 		IB_MANDATORY_FUNC(get_port_immutable)
 	};
@@ -601,20 +602,33 @@ struct ib_device *_ib_alloc_device(size_t size)
 	INIT_WORK(&device->unregistration_work, ib_unregister_work);
=20
 	device->uverbs_cmd_mask =3D
+		BIT_ULL(IB_USER_VERBS_CMD_ALLOC_MW) |
 		BIT_ULL(IB_USER_VERBS_CMD_ALLOC_PD) |
+		BIT_ULL(IB_USER_VERBS_CMD_ATTACH_MCAST) |
+		BIT_ULL(IB_USER_VERBS_CMD_CLOSE_XRCD) |
 		BIT_ULL(IB_USER_VERBS_CMD_CREATE_COMP_CHANNEL) |
 		BIT_ULL(IB_USER_VERBS_CMD_CREATE_CQ) |
 		BIT_ULL(IB_USER_VERBS_CMD_CREATE_QP) |
+		BIT_ULL(IB_USER_VERBS_CMD_CREATE_SRQ) |
+		BIT_ULL(IB_USER_VERBS_CMD_DEALLOC_MW) |
 		BIT_ULL(IB_USER_VERBS_CMD_DEALLOC_PD) |
 		BIT_ULL(IB_USER_VERBS_CMD_DEREG_MR) |
 		BIT_ULL(IB_USER_VERBS_CMD_DESTROY_CQ) |
 		BIT_ULL(IB_USER_VERBS_CMD_DESTROY_QP) |
+		BIT_ULL(IB_USER_VERBS_CMD_DESTROY_SRQ) |
+		BIT_ULL(IB_USER_VERBS_CMD_DETACH_MCAST) |
 		BIT_ULL(IB_USER_VERBS_CMD_GET_CONTEXT) |
 		BIT_ULL(IB_USER_VERBS_CMD_MODIFY_QP) |
+		BIT_ULL(IB_USER_VERBS_CMD_MODIFY_SRQ) |
+		BIT_ULL(IB_USER_VERBS_CMD_OPEN_QP) |
+		BIT_ULL(IB_USER_VERBS_CMD_OPEN_XRCD) |
 		BIT_ULL(IB_USER_VERBS_CMD_QUERY_DEVICE) |
 		BIT_ULL(IB_USER_VERBS_CMD_QUERY_PORT) |
 		BIT_ULL(IB_USER_VERBS_CMD_QUERY_QP) |
-		BIT_ULL(IB_USER_VERBS_CMD_REG_MR);
+		BIT_ULL(IB_USER_VERBS_CMD_QUERY_SRQ) |
+		BIT_ULL(IB_USER_VERBS_CMD_REG_MR) |
+		BIT_ULL(IB_USER_VERBS_CMD_REREG_MR) |
+		BIT_ULL(IB_USER_VERBS_CMD_RESIZE_CQ);
=20
 	device->uverbs_ex_cmd_mask =3D
 		BIT_ULL(IB_USER_VERBS_EX_CMD_CREATE_FLOW) |
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core=
/uverbs_cmd.c
index 2f3f9b87922e92..f85a6117577296 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -3999,8 +3999,7 @@ const struct uapi_definition uverbs_def_write_intf[] =
=3D {
 		DECLARE_UVERBS_WRITE(
 			IB_USER_VERBS_CMD_CLOSE_XRCD,
 			ib_uverbs_close_xrcd,
-			UAPI_DEF_WRITE_I(struct ib_uverbs_close_xrcd),
-			UAPI_DEF_METHOD_NEEDS_FN(dealloc_xrcd)),
+			UAPI_DEF_WRITE_I(struct ib_uverbs_close_xrcd)),
 		DECLARE_UVERBS_WRITE(IB_USER_VERBS_CMD_OPEN_QP,
 				     ib_uverbs_open_qp,
 				     UAPI_DEF_WRITE_UDATA_IO(
@@ -4010,8 +4009,9 @@ const struct uapi_definition uverbs_def_write_intf[] =
=3D {
 				     ib_uverbs_open_xrcd,
 				     UAPI_DEF_WRITE_UDATA_IO(
 					     struct ib_uverbs_open_xrcd,
-					     struct ib_uverbs_open_xrcd_resp),
-				     UAPI_DEF_METHOD_NEEDS_FN(alloc_xrcd))),
+					     struct ib_uverbs_open_xrcd_resp)),
+		UAPI_DEF_OBJ_NEEDS_FN(alloc_xrcd),
+		UAPI_DEF_OBJ_NEEDS_FN(dealloc_xrcd)),
=20
 	{},
 };
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/b=
nxt_re/main.c
index 6bb524102832e6..2bee4ca6dcf5fe 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -703,12 +703,6 @@ static int bnxt_re_register_ib(struct bnxt_re_dev *rde=
v)
=20
 	/* User space */
 	ibdev->uverbs_cmd_mask |=3D
-			(1ull << IB_USER_VERBS_CMD_REREG_MR)		|
-			(1ull << IB_USER_VERBS_CMD_RESIZE_CQ)		|
-			(1ull << IB_USER_VERBS_CMD_CREATE_SRQ)		|
-			(1ull << IB_USER_VERBS_CMD_MODIFY_SRQ)		|
-			(1ull << IB_USER_VERBS_CMD_QUERY_SRQ)		|
-			(1ull << IB_USER_VERBS_CMD_DESTROY_SRQ)		|
 			(1ull << IB_USER_VERBS_CMD_CREATE_AH)		|
 			(1ull << IB_USER_VERBS_CMD_MODIFY_AH)		|
 			(1ull << IB_USER_VERBS_CMD_QUERY_AH)		|
diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw=
/cxgb4/provider.c
index 58b578d40bf63c..d3a84fdd2396f3 100644
--- a/drivers/infiniband/hw/cxgb4/provider.c
+++ b/drivers/infiniband/hw/cxgb4/provider.c
@@ -535,10 +535,7 @@ void c4iw_register_device(struct work_struct *work)
 	    (1ull << IB_USER_VERBS_CMD_REQ_NOTIFY_CQ) |
 	    (1ull << IB_USER_VERBS_CMD_POLL_CQ) |
 	    (1ull << IB_USER_VERBS_CMD_POST_SEND) |
-	    (1ull << IB_USER_VERBS_CMD_POST_RECV) |
-	    (1ull << IB_USER_VERBS_CMD_CREATE_SRQ) |
-	    (1ull << IB_USER_VERBS_CMD_MODIFY_SRQ) |
-	    (1ull << IB_USER_VERBS_CMD_DESTROY_SRQ);
+	    (1ull << IB_USER_VERBS_CMD_POST_RECV);
 	dev->ibdev.node_type =3D RDMA_NODE_RNIC;
 	BUILD_BUG_ON(sizeof(C4IW_NODE_DESC) > IB_DEVICE_NODE_DESC_MAX);
 	memcpy(dev->ibdev.node_desc, C4IW_NODE_DESC, sizeof(C4IW_NODE_DESC));
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband=
/hw/hns/hns_roce_main.c
index d8083b320cf5a8..a75c09564447b3 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -492,18 +492,12 @@ static int hns_roce_register_device(struct hns_roce_d=
ev *hr_dev)
 	ib_dev->local_dma_lkey =3D hr_dev->caps.reserved_lkey;
 	ib_dev->num_comp_vectors =3D hr_dev->caps.num_comp_vectors;
=20
-	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_REREG_MR) {
-		ib_dev->uverbs_cmd_mask |=3D (1ULL << IB_USER_VERBS_CMD_REREG_MR);
+	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_REREG_MR)
 		ib_set_device_ops(ib_dev, &hns_roce_dev_mr_ops);
-	}
=20
 	/* MW */
-	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_MW) {
-		ib_dev->uverbs_cmd_mask |=3D
-					(1ULL << IB_USER_VERBS_CMD_ALLOC_MW) |
-					(1ULL << IB_USER_VERBS_CMD_DEALLOC_MW);
+	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_MW)
 		ib_set_device_ops(ib_dev, &hns_roce_dev_mw_ops);
-	}
=20
 	/* FRMR */
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_FRMR)
@@ -512,10 +506,6 @@ static int hns_roce_register_device(struct hns_roce_de=
v *hr_dev)
 	/* SRQ */
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_SRQ) {
 		ib_dev->uverbs_cmd_mask |=3D
-				(1ULL << IB_USER_VERBS_CMD_CREATE_SRQ) |
-				(1ULL << IB_USER_VERBS_CMD_MODIFY_SRQ) |
-				(1ULL << IB_USER_VERBS_CMD_QUERY_SRQ) |
-				(1ULL << IB_USER_VERBS_CMD_DESTROY_SRQ) |
 				(1ULL << IB_USER_VERBS_CMD_POST_SRQ_RECV);
 		ib_set_device_ops(ib_dev, &hns_roce_dev_srq_ops);
 		ib_set_device_ops(ib_dev, hr_dev->hw->hns_roce_dev_srq_ops);
diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4=
/main.c
index 429f3c9b914c89..f251a57478f3e7 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -2658,16 +2658,7 @@ static void *mlx4_ib_add(struct mlx4_dev *dev)
 	ibdev->ib_dev.dev.parent	=3D &dev->persist->pdev->dev;
=20
 	ibdev->ib_dev.uverbs_cmd_mask |=3D
-		(1ull << IB_USER_VERBS_CMD_REREG_MR)		|
-		(1ull << IB_USER_VERBS_CMD_RESIZE_CQ)		|
-		(1ull << IB_USER_VERBS_CMD_ATTACH_MCAST)	|
-		(1ull << IB_USER_VERBS_CMD_DETACH_MCAST)	|
-		(1ull << IB_USER_VERBS_CMD_CREATE_SRQ)		|
-		(1ull << IB_USER_VERBS_CMD_MODIFY_SRQ)		|
-		(1ull << IB_USER_VERBS_CMD_QUERY_SRQ)		|
-		(1ull << IB_USER_VERBS_CMD_DESTROY_SRQ)		|
-		(1ull << IB_USER_VERBS_CMD_CREATE_XSRQ)		|
-		(1ull << IB_USER_VERBS_CMD_OPEN_QP);
+		(1ull << IB_USER_VERBS_CMD_CREATE_XSRQ);
=20
 	ib_set_device_ops(&ibdev->ib_dev, &mlx4_ib_dev_ops);
 	ibdev->ib_dev.uverbs_ex_cmd_mask |=3D
@@ -2682,17 +2673,10 @@ static void *mlx4_ib_add(struct mlx4_dev *dev)
 		ib_set_device_ops(&ibdev->ib_dev, &mlx4_ib_dev_wq_ops);
=20
 	if (dev->caps.flags & MLX4_DEV_CAP_FLAG_MEM_WINDOW ||
-	    dev->caps.bmme_flags & MLX4_BMME_FLAG_TYPE_2_WIN) {
-		ibdev->ib_dev.uverbs_cmd_mask |=3D
-			(1ull << IB_USER_VERBS_CMD_ALLOC_MW) |
-			(1ull << IB_USER_VERBS_CMD_DEALLOC_MW);
+	    dev->caps.bmme_flags & MLX4_BMME_FLAG_TYPE_2_WIN)
 		ib_set_device_ops(&ibdev->ib_dev, &mlx4_ib_dev_mw_ops);
-	}
=20
 	if (dev->caps.flags & MLX4_DEV_CAP_FLAG_XRC) {
-		ibdev->ib_dev.uverbs_cmd_mask |=3D
-			(1ull << IB_USER_VERBS_CMD_OPEN_XRCD) |
-			(1ull << IB_USER_VERBS_CMD_CLOSE_XRCD);
 		ib_set_device_ops(&ibdev->ib_dev, &mlx4_ib_dev_xrc_ops);
 	}
=20
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5=
/main.c
index bcd6802e7eea54..83434d080023a8 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4142,16 +4142,7 @@ static int mlx5_ib_stage_caps_init(struct mlx5_ib_de=
v *dev)
 	dev->ib_dev.uverbs_cmd_mask |=3D
 		(1ull << IB_USER_VERBS_CMD_CREATE_AH)		|
 		(1ull << IB_USER_VERBS_CMD_DESTROY_AH)		|
-		(1ull << IB_USER_VERBS_CMD_REREG_MR)		|
-		(1ull << IB_USER_VERBS_CMD_RESIZE_CQ)		|
-		(1ull << IB_USER_VERBS_CMD_ATTACH_MCAST)	|
-		(1ull << IB_USER_VERBS_CMD_DETACH_MCAST)	|
-		(1ull << IB_USER_VERBS_CMD_CREATE_SRQ)		|
-		(1ull << IB_USER_VERBS_CMD_MODIFY_SRQ)		|
-		(1ull << IB_USER_VERBS_CMD_QUERY_SRQ)		|
-		(1ull << IB_USER_VERBS_CMD_DESTROY_SRQ)		|
-		(1ull << IB_USER_VERBS_CMD_CREATE_XSRQ)		|
-		(1ull << IB_USER_VERBS_CMD_OPEN_QP);
+		(1ull << IB_USER_VERBS_CMD_CREATE_XSRQ);
 	dev->ib_dev.uverbs_ex_cmd_mask |=3D
 		(1ull << IB_USER_VERBS_EX_CMD_CREATE_CQ)	|
 		(1ull << IB_USER_VERBS_EX_CMD_CREATE_QP)	|
@@ -4167,19 +4158,11 @@ static int mlx5_ib_stage_caps_init(struct mlx5_ib_d=
ev *dev)
=20
 	dev->umr_fence =3D mlx5_get_umr_fence(MLX5_CAP_GEN(mdev, umr_fence));
=20
-	if (MLX5_CAP_GEN(mdev, imaicl)) {
-		dev->ib_dev.uverbs_cmd_mask |=3D
-			(1ull << IB_USER_VERBS_CMD_ALLOC_MW)	|
-			(1ull << IB_USER_VERBS_CMD_DEALLOC_MW);
+	if (MLX5_CAP_GEN(mdev, imaicl))
 		ib_set_device_ops(&dev->ib_dev, &mlx5_ib_dev_mw_ops);
-	}
=20
-	if (MLX5_CAP_GEN(mdev, xrc)) {
-		dev->ib_dev.uverbs_cmd_mask |=3D
-			(1ull << IB_USER_VERBS_CMD_OPEN_XRCD) |
-			(1ull << IB_USER_VERBS_CMD_CLOSE_XRCD);
+	if (MLX5_CAP_GEN(mdev, xrc))
 		ib_set_device_ops(&dev->ib_dev, &mlx5_ib_dev_xrc_ops);
-	}
=20
 	if (MLX5_CAP_DEV_MEM(mdev, memic) ||
 	    MLX5_CAP_GEN_64(dev->mdev, general_obj_types) &
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infinib=
and/hw/mthca/mthca_provider.c
index ae03bc4afbc814..a01898ac99e224 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -1158,22 +1158,12 @@ int mthca_register_device(struct mthca_dev *dev)
 	if (ret)
 		return ret;
=20
-	dev->ib_dev.uverbs_cmd_mask |=3D
-		(1ull << IB_USER_VERBS_CMD_RESIZE_CQ)		|
-		(1ull << IB_USER_VERBS_CMD_ATTACH_MCAST)	|
-		(1ull << IB_USER_VERBS_CMD_DETACH_MCAST);
 	dev->ib_dev.node_type            =3D RDMA_NODE_IB_CA;
 	dev->ib_dev.phys_port_cnt        =3D dev->limits.num_ports;
 	dev->ib_dev.num_comp_vectors     =3D 1;
 	dev->ib_dev.dev.parent           =3D &dev->pdev->dev;
=20
 	if (dev->mthca_flags & MTHCA_FLAG_SRQ) {
-		dev->ib_dev.uverbs_cmd_mask	|=3D
-			(1ull << IB_USER_VERBS_CMD_CREATE_SRQ)		|
-			(1ull << IB_USER_VERBS_CMD_MODIFY_SRQ)		|
-			(1ull << IB_USER_VERBS_CMD_QUERY_SRQ)		|
-			(1ull << IB_USER_VERBS_CMD_DESTROY_SRQ);
-
 		if (mthca_is_memfree(dev))
 			ib_set_device_ops(&dev->ib_dev,
 					  &mthca_dev_arbel_srq_ops);
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_main.c b/drivers/infiniban=
d/hw/ocrdma/ocrdma_main.c
index c9549ff1b24bc7..40ed7a42f1e1ca 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_main.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_main.c
@@ -205,7 +205,6 @@ static int ocrdma_register_device(struct ocrdma_dev *de=
v)
 	memcpy(dev->ibdev.node_desc, OCRDMA_NODE_DESC,
 	       sizeof(OCRDMA_NODE_DESC));
 	dev->ibdev.uverbs_cmd_mask |=3D
-	    OCRDMA_UVERBS(RESIZE_CQ) |
 	    OCRDMA_UVERBS(REQ_NOTIFY_CQ) |
 	    OCRDMA_UVERBS(POLL_CQ) |
 	    OCRDMA_UVERBS(POST_SEND) |
@@ -228,10 +227,6 @@ static int ocrdma_register_device(struct ocrdma_dev *d=
ev)
=20
 	if (ocrdma_get_asic_type(dev) =3D=3D OCRDMA_ASIC_GEN_SKH_R) {
 		dev->ibdev.uverbs_cmd_mask |=3D
-		     OCRDMA_UVERBS(CREATE_SRQ) |
-		     OCRDMA_UVERBS(MODIFY_SRQ) |
-		     OCRDMA_UVERBS(QUERY_SRQ) |
-		     OCRDMA_UVERBS(DESTROY_SRQ) |
 		     OCRDMA_UVERBS(POST_SRQ_RECV);
=20
 		ib_set_device_ops(&dev->ibdev, &ocrdma_dev_srq_ops);
diff --git a/drivers/infiniband/hw/qedr/main.c b/drivers/infiniband/hw/qedr=
/main.c
index f4afd6473eca4a..81d7d64fabc98f 100644
--- a/drivers/infiniband/hw/qedr/main.c
+++ b/drivers/infiniband/hw/qedr/main.c
@@ -189,8 +189,7 @@ static void qedr_roce_register_device(struct qedr_dev *=
dev)
=20
 	ib_set_device_ops(&dev->ibdev, &qedr_roce_dev_ops);
=20
-	dev->ibdev.uverbs_cmd_mask |=3D QEDR_UVERBS(OPEN_XRCD) |
-		QEDR_UVERBS(CLOSE_XRCD) |
+	dev->ibdev.uverbs_cmd_mask |=3D
 		QEDR_UVERBS(CREATE_XSRQ);
 }
=20
@@ -250,12 +249,7 @@ static int qedr_register_device(struct qedr_dev *dev)
 	memcpy(dev->ibdev.node_desc, QEDR_NODE_DESC, sizeof(QEDR_NODE_DESC));
=20
 	dev->ibdev.uverbs_cmd_mask |=3D
-				     QEDR_UVERBS(RESIZE_CQ) |
 				     QEDR_UVERBS(REQ_NOTIFY_CQ) |
-				     QEDR_UVERBS(CREATE_SRQ) |
-				     QEDR_UVERBS(DESTROY_SRQ) |
-				     QEDR_UVERBS(QUERY_SRQ) |
-				     QEDR_UVERBS(MODIFY_SRQ) |
 				     QEDR_UVERBS(POST_SRQ_RECV) |
 				     QEDR_UVERBS(POLL_CQ) |
 				     QEDR_UVERBS(POST_SEND) |
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_main.c b/drivers/infiniba=
nd/hw/usnic/usnic_ib_main.c
index 5a75113af7ed80..4b820a0eefeac5 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_main.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_main.c
@@ -398,11 +398,6 @@ static void *usnic_ib_device_add(struct pci_dev *dev)
 	us_ibdev->ib_dev.num_comp_vectors =3D USNIC_IB_NUM_COMP_VECTORS;
 	us_ibdev->ib_dev.dev.parent =3D &dev->dev;
=20
-	us_ibdev->ib_dev.uverbs_cmd_mask |=3D
-		(1ull << IB_USER_VERBS_CMD_ATTACH_MCAST) |
-		(1ull << IB_USER_VERBS_CMD_DETACH_MCAST) |
-		(1ull << IB_USER_VERBS_CMD_OPEN_QP);
-
 	ib_set_device_ops(&us_ibdev->ib_dev, &usnic_dev_ops);
=20
 	rdma_set_device_sysfs_group(&us_ibdev->ib_dev, &usnic_attr_group);
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c b/drivers/infin=
iband/hw/vmw_pvrdma/pvrdma_main.c
index eeb96fe95b4d93..41836811a71d55 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
@@ -236,10 +236,6 @@ static int pvrdma_register_device(struct pvrdma_dev *d=
ev)
 	/* Check if SRQ is supported by backend */
 	if (dev->dsr->caps.max_srq) {
 		dev->ib_dev.uverbs_cmd_mask |=3D
-			(1ull << IB_USER_VERBS_CMD_CREATE_SRQ)	|
-			(1ull << IB_USER_VERBS_CMD_MODIFY_SRQ)	|
-			(1ull << IB_USER_VERBS_CMD_QUERY_SRQ)	|
-			(1ull << IB_USER_VERBS_CMD_DESTROY_SRQ)	|
 			(1ull << IB_USER_VERBS_CMD_POST_SRQ_RECV);
=20
 		ib_set_device_ops(&dev->ib_dev, &pvrdma_dev_srq_ops);
diff --git a/drivers/infiniband/sw/rdmavt/vt.c b/drivers/infiniband/sw/rdma=
vt/vt.c
index b6706125ec6610..a0cb567cfc512b 100644
--- a/drivers/infiniband/sw/rdmavt/vt.c
+++ b/drivers/infiniband/sw/rdmavt/vt.c
@@ -598,17 +598,10 @@ int rvt_register_device(struct rvt_dev_info *rdi)
 		(1ull << IB_USER_VERBS_CMD_MODIFY_AH)           |
 		(1ull << IB_USER_VERBS_CMD_QUERY_AH)            |
 		(1ull << IB_USER_VERBS_CMD_DESTROY_AH)          |
-		(1ull << IB_USER_VERBS_CMD_RESIZE_CQ)           |
 		(1ull << IB_USER_VERBS_CMD_POLL_CQ)             |
 		(1ull << IB_USER_VERBS_CMD_REQ_NOTIFY_CQ)       |
 		(1ull << IB_USER_VERBS_CMD_POST_SEND)           |
 		(1ull << IB_USER_VERBS_CMD_POST_RECV)           |
-		(1ull << IB_USER_VERBS_CMD_ATTACH_MCAST)        |
-		(1ull << IB_USER_VERBS_CMD_DETACH_MCAST)        |
-		(1ull << IB_USER_VERBS_CMD_CREATE_SRQ)          |
-		(1ull << IB_USER_VERBS_CMD_MODIFY_SRQ)          |
-		(1ull << IB_USER_VERBS_CMD_QUERY_SRQ)           |
-		(1ull << IB_USER_VERBS_CMD_DESTROY_SRQ)         |
 		(1ull << IB_USER_VERBS_CMD_POST_SRQ_RECV);
 	rdi->ibdev.node_type =3D RDMA_NODE_IB_CA;
 	if (!rdi->ibdev.num_comp_vectors)
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/=
rxe/rxe_verbs.c
index 3aa83f4c47772b..5f47f21c2958d3 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1136,14 +1136,9 @@ int rxe_register_device(struct rxe_dev *rxe, const c=
har *ibdev_name)
 				     dma_get_required_mask(&dev->dev));
=20
 	dev->uverbs_cmd_mask |=3D
-	    BIT_ULL(IB_USER_VERBS_CMD_CREATE_SRQ)
-	    | BIT_ULL(IB_USER_VERBS_CMD_MODIFY_SRQ)
-	    | BIT_ULL(IB_USER_VERBS_CMD_QUERY_SRQ)
-	    | BIT_ULL(IB_USER_VERBS_CMD_DESTROY_SRQ)
-	    | BIT_ULL(IB_USER_VERBS_CMD_POST_SRQ_RECV)
+	    BIT_ULL(IB_USER_VERBS_CMD_POST_SRQ_RECV)
 	    | BIT_ULL(IB_USER_VERBS_CMD_POST_SEND)
 	    | BIT_ULL(IB_USER_VERBS_CMD_POST_RECV)
-	    | BIT_ULL(IB_USER_VERBS_CMD_RESIZE_CQ)
 	    | BIT_ULL(IB_USER_VERBS_CMD_POLL_CQ)
 	    | BIT_ULL(IB_USER_VERBS_CMD_PEEK_CQ)
 	    | BIT_ULL(IB_USER_VERBS_CMD_REQ_NOTIFY_CQ)
@@ -1151,8 +1146,6 @@ int rxe_register_device(struct rxe_dev *rxe, const ch=
ar *ibdev_name)
 	    | BIT_ULL(IB_USER_VERBS_CMD_MODIFY_AH)
 	    | BIT_ULL(IB_USER_VERBS_CMD_QUERY_AH)
 	    | BIT_ULL(IB_USER_VERBS_CMD_DESTROY_AH)
-	    | BIT_ULL(IB_USER_VERBS_CMD_ATTACH_MCAST)
-	    | BIT_ULL(IB_USER_VERBS_CMD_DETACH_MCAST)
 	    ;
=20
 	ib_set_device_ops(dev, &rxe_dev_ops);
diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/s=
iw/siw_main.c
index cf472118cb5364..faef91ba031ca7 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -351,11 +351,7 @@ static struct siw_device *siw_device_create(struct net=
_device *netdev)
 		(1ull << IB_USER_VERBS_CMD_REQ_NOTIFY_CQ) |
 		(1ull << IB_USER_VERBS_CMD_POST_SEND) |
 		(1ull << IB_USER_VERBS_CMD_POST_RECV) |
-		(1ull << IB_USER_VERBS_CMD_CREATE_SRQ) |
-		(1ull << IB_USER_VERBS_CMD_POST_SRQ_RECV) |
-		(1ull << IB_USER_VERBS_CMD_MODIFY_SRQ) |
-		(1ull << IB_USER_VERBS_CMD_QUERY_SRQ) |
-		(1ull << IB_USER_VERBS_CMD_DESTROY_SRQ);
+		(1ull << IB_USER_VERBS_CMD_POST_SRQ_RECV);
=20
 	base_dev->node_type =3D RDMA_NODE_RNIC;
 	memcpy(base_dev->node_desc, SIW_NODE_DESC_COMMON,
--=20
2.28.0

