Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 374C5E7830
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 19:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731405AbfJ1SPB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 14:15:01 -0400
Received: from mail-eopbgr700048.outbound.protection.outlook.com ([40.107.70.48]:14362
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730690AbfJ1SPA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 28 Oct 2019 14:15:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hiMXUaxpk5Qnh9yZU0Ofp7qWCBlMy72w+/lNSGDdheoo4lFD/Z6vwhgNLYl4ppGYto/DVftVHWkcaFNJc3LU54QSrnbFXhbdJ3zB+eHkkKvQoiKzw7hunYI7XxPdDh4tvs9UWWrkxnx5Q7RvIl8A+RFzJt8VKMICg1w+XNympmj2wruBYYlWG0lzR6UCJ6tzZUEXdGnRRu6w5EV9Oh7Enzmn6XEYykyHFCvaK2OLF0XfAqQ5TpnMKeCMEWxdgj/lgwBrdiqqvxTIb43gKIYNTBIorbmTEa6u3TprR+lJj7XAWXPt4hNrzuGlBGNiL7vSzA2tMGSNSPSV5UTUJqD1IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0OWuVR2+bHN4uDHLPO7Bae//gwQPu3zee6cPnB1ozxc=;
 b=ZZid7rpa8JShr+ra1butK+sguEgEo7/Hs7PnUCmBBUk6bpzrmz7gXHWSnM5lRDcJ+pIzwTlg6dHA+GAjZisARA6tA4BQEOPYSqpbGFHdGvmAhiZADQYJ27RvqIir22dPTSisqs2Hn/bxv7Duxb70c3kBdaPEHJCp8L38v2ZvbL1bCqfGwOUdRoL5MrZQnCEbOfAs2aMhPaV+NNE0P5XKmiWADnCS34GVskU7GjY7vz3aS2md9fQE3nYOhLLd5UCmnJ5wV8Fv9EpIWJU07SALpem8oLZBf0fWxL1huoUfFpLwMtkVKF8fCFjjUIjLL7VMC1qF9/WeqhTE5AIsPvoKzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0OWuVR2+bHN4uDHLPO7Bae//gwQPu3zee6cPnB1ozxc=;
 b=ykS7AKVY6gnyXn6KOSf8DrDoJEdopCA2tZPYgxAFra9GobFUjbhCdxolCHzF6eIZzSE513/Osvd5gI4ZUnsjn2SxDGO08JyO0fVOleDPwez74Yfd1wdIu81CayXXDz6JUyH92YgKU1ncrR39FKn6p8xayQjyYCUK5tw5cBcm6K8=
Received: from BYAPR05MB5511.namprd05.prod.outlook.com (20.177.186.28) by
 BYAPR05MB5654.namprd05.prod.outlook.com (20.177.185.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.10; Mon, 28 Oct 2019 18:14:52 +0000
Received: from BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::f149:5b68:407b:e494]) by BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::f149:5b68:407b:e494%3]) with mapi id 15.20.2408.012; Mon, 28 Oct 2019
 18:14:52 +0000
From:   Adit Ranadive <aditr@vmware.com>
To:     "jgg@mellanox.com" <jgg@mellanox.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Bryan Tan <bryantan@vmware.com>,
        Pv-drivers <Pv-drivers@vmware.com>,
        Adit Ranadive <aditr@vmware.com>
Subject: [PATCH v3 for-next] RDMA/vmw_pvrdma: Use resource ids from physical
 device if available
Thread-Topic: [PATCH v3 for-next] RDMA/vmw_pvrdma: Use resource ids from
 physical device if available
Thread-Index: AQHVjbuXeycPE9XXtU+zc/m6Wa7sag==
Date:   Mon, 28 Oct 2019 18:14:52 +0000
Message-ID: <20191028181444.19448-1-aditr@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BY5PR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::25) To BYAPR05MB5511.namprd05.prod.outlook.com
 (2603:10b6:a03:1a::28)
x-mailer: git-send-email 2.18.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aditr@vmware.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 15a81adf-556f-4701-78e5-08d75bd2ba14
x-ms-traffictypediagnostic: BYAPR05MB5654:|BYAPR05MB5654:
x-ms-exchange-purlcount: 1
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR05MB5654B38455D813070F368B2AC5660@BYAPR05MB5654.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(189003)(199004)(71190400001)(186003)(71200400001)(5660300002)(50226002)(25786009)(36756003)(2501003)(6486002)(6436002)(6306002)(14454004)(107886003)(3846002)(6512007)(6116002)(64756008)(66446008)(4326008)(99286004)(1076003)(2906002)(478600001)(966005)(2616005)(486006)(54906003)(8676002)(8936002)(476003)(14444005)(102836004)(26005)(52116002)(7736002)(305945005)(256004)(386003)(6506007)(2201001)(66556008)(66476007)(81156014)(110136005)(81166006)(66066001)(316002)(66946007)(86362001)(309714004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5654;H:BYAPR05MB5511.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 31tqvfhWwwCFdAXkPUjIiu3B7K8XnFAsHKodZr81g9j17leEAsun/MzuZwhfSaWyFUdiKyQzB9gWts84HYgXMsJM42Ujcp7AaYYpeqsPdnPjpEqPjVziPmUVxGO2KFAC3NydBpIOkVarXzj67D5gwEmQZjf9wLkMZUIuCCNNzZJVXHxfLytD5mwjWvbiG8zSJ5AlPHO/DqV+gDmNWerNo4RlgqguGwrkD3Vec4lqwqi767DpymGdXKH++SwI1tA7i/OTeu78SPW4ZH4J1eFiYpSXP/FDKAWv8xMj+3HkJ+OvXiUMGtm00ZEuzqI8Ci7Oumiz7vAhNMM1TbUtcOpI0z/6U5E6SB6mtsfTdv/i2KeYSeRjahEolZ3vEBp2efvEeyEVR+vqwU+869C8A+Z/X48/ZXnWfqmk4hQm5R/GYmpQnMbTAQwDM79FterU0Oc9vuMpeWxMT2WlV85vHaVpWqPc5Dy2eOppmX56SZgrKwQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a81adf-556f-4701-78e5-08d75bd2ba14
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 18:14:52.5354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b3UOIb0a56oH5Ush46X10J2WjvSoz/zsgbedg4C1y/iLzRFdL42lvrcrXZ1xaR65BK1uqqCKt7NgiZCv2e/rgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5654
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Bryan Tan <bryantan@vmware.com>

This change allows the RDMA stack to use physical resource numbers if
they are passed up from the device. This is accomplished by separating
the concept of the QP number from the QP handle. Previously, the two
were the same, as the QP number was exposed to the guest and also used
to reference a virtual QP in the device backend.

With physical resource numbers exposed, the QP number given to the guest
is the number assigned from the physical HCA's QP, while the QP handle
is still the internal handle used to reference a virtual QP. Regardless
of whether the device is exposing physical ids, the driver will still
try to pick up the QP handle from the backend if possible. The MR keys
exposed to the guest will also be the MR keys created by the physical
HCA, instead of virtual MR keys. The distinction between handle and keys
is already present for MRs so there is no need to do anything special
here.

A new version of the create QP response has been added to the device
API to pass up the QP number and handle. The driver will also report
these to userspace in the udata response if userspace supports it
or not create the queuepair if not. I also had to do a refactor of the
destroy qp code to reuse it if we fail to copy to userspace.

Reviewed-by: Jorgen Hansen <jhansen@vmware.com>
Signed-off-by: Adit Ranadive <aditr@vmware.com>
Signed-off-by: Bryan Tan <bryantan@vmware.com>
---

Github PR for rdma-core:
 - https://github.com/linux-rdma/rdma-core/pull/581

Changes:
v2 -> v3:
 - Use < for size check for outlen and minimum for copying to udata
v1 -> v2:
 - Dropped the create qp flag
v0 -> v1:
 - Dropped the ABI version bump
 - Added a new create qp flag to indicate userspace support
 - Refactor of destroy/free qp
 - Updated commit description

 .../infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h |  15 ++-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c  | 118 +++++++++++++-----
 include/uapi/rdma/vmw_pvrdma-abi.h            |   5 +
 3 files changed, 109 insertions(+), 29 deletions(-)

diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h b/drivers/in=
finiband/hw/vmw_pvrdma/pvrdma_dev_api.h
index 8f9749d54688..86a6c054ea26 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h
@@ -58,7 +58,8 @@
 #define PVRDMA_ROCEV1_VERSION		17
 #define PVRDMA_ROCEV2_VERSION		18
 #define PVRDMA_PPN64_VERSION		19
-#define PVRDMA_VERSION			PVRDMA_PPN64_VERSION
+#define PVRDMA_QPHANDLE_VERSION		20
+#define PVRDMA_VERSION			PVRDMA_QPHANDLE_VERSION
=20
 #define PVRDMA_BOARD_ID			1
 #define PVRDMA_REV_ID			1
@@ -581,6 +582,17 @@ struct pvrdma_cmd_create_qp_resp {
 	u32 max_inline_data;
 };
=20
+struct pvrdma_cmd_create_qp_resp_v2 {
+	struct pvrdma_cmd_resp_hdr hdr;
+	u32 qpn;
+	u32 qp_handle;
+	u32 max_send_wr;
+	u32 max_recv_wr;
+	u32 max_send_sge;
+	u32 max_recv_sge;
+	u32 max_inline_data;
+};
+
 struct pvrdma_cmd_modify_qp {
 	struct pvrdma_cmd_hdr hdr;
 	u32 qp_handle;
@@ -663,6 +675,7 @@ union pvrdma_cmd_resp {
 	struct pvrdma_cmd_create_cq_resp create_cq_resp;
 	struct pvrdma_cmd_resize_cq_resp resize_cq_resp;
 	struct pvrdma_cmd_create_qp_resp create_qp_resp;
+	struct pvrdma_cmd_create_qp_resp_v2 create_qp_resp_v2;
 	struct pvrdma_cmd_query_qp_resp query_qp_resp;
 	struct pvrdma_cmd_destroy_qp_resp destroy_qp_resp;
 	struct pvrdma_cmd_create_srq_resp create_srq_resp;
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c b/drivers/infinib=
and/hw/vmw_pvrdma/pvrdma_qp.c
index bca6a58a442e..496c6ec0610f 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
@@ -52,6 +52,9 @@
=20
 #include "pvrdma.h"
=20
+static void __pvrdma_destroy_qp(struct pvrdma_dev *dev,
+				struct pvrdma_qp *qp);
+
 static inline void get_cqs(struct pvrdma_qp *qp, struct pvrdma_cq **send_c=
q,
 			   struct pvrdma_cq **recv_cq)
 {
@@ -195,7 +198,9 @@ struct ib_qp *pvrdma_create_qp(struct ib_pd *pd,
 	union pvrdma_cmd_resp rsp;
 	struct pvrdma_cmd_create_qp *cmd =3D &req.create_qp;
 	struct pvrdma_cmd_create_qp_resp *resp =3D &rsp.create_qp_resp;
+	struct pvrdma_cmd_create_qp_resp_v2 *resp_v2 =3D &rsp.create_qp_resp_v2;
 	struct pvrdma_create_qp ucmd;
+	struct pvrdma_create_qp_resp qp_resp =3D {};
 	unsigned long flags;
 	int ret;
 	bool is_srq =3D !!init_attr->srq;
@@ -260,6 +265,15 @@ struct ib_qp *pvrdma_create_qp(struct ib_pd *pd,
 				goto err_qp;
 			}
=20
+			/* Userspace supports qpn and qp handles? */
+			if (dev->dsr_version >=3D PVRDMA_QPHANDLE_VERSION &&
+			    udata->outlen < sizeof(qp_resp)) {
+				dev_warn(&dev->pdev->dev,
+					 "create queuepair not supported\n");
+				ret =3D -EOPNOTSUPP;
+				goto err_qp;
+			}
+
 			if (!is_srq) {
 				/* set qp->sq.wqe_cnt, shift, buf_size.. */
 				qp->rumem =3D ib_umem_get(udata, ucmd.rbuf_addr,
@@ -379,13 +393,36 @@ struct ib_qp *pvrdma_create_qp(struct ib_pd *pd,
 	}
=20
 	/* max_send_wr/_recv_wr/_send_sge/_recv_sge/_inline_data */
-	qp->qp_handle =3D resp->qpn;
 	qp->port =3D init_attr->port_num;
-	qp->ibqp.qp_num =3D resp->qpn;
+
+	if (dev->dsr_version >=3D PVRDMA_QPHANDLE_VERSION) {
+		qp->ibqp.qp_num =3D resp_v2->qpn;
+		qp->qp_handle =3D resp_v2->qp_handle;
+	} else {
+		qp->ibqp.qp_num =3D resp->qpn;
+		qp->qp_handle =3D resp->qpn;
+	}
+
 	spin_lock_irqsave(&dev->qp_tbl_lock, flags);
 	dev->qp_tbl[qp->qp_handle % dev->dsr->caps.max_qp] =3D qp;
 	spin_unlock_irqrestore(&dev->qp_tbl_lock, flags);
=20
+	if (!qp->is_kernel) {
+		if (udata->outlen >=3D sizeof(qp_resp)) {
+			qp_resp.qpn =3D qp->ibqp.qp_num;
+			qp_resp.qp_handle =3D qp->qp_handle;
+
+			if (ib_copy_to_udata(udata, &qp_resp,
+					     min(udata->outlen,
+						 sizeof(qp_resp)))) {
+				dev_warn(&dev->pdev->dev,
+					 "failed to copy back udata\n");
+				__pvrdma_destroy_qp(dev, qp);
+				return ERR_PTR(-EINVAL);
+			}
+		}
+	}
+
 	return &qp->ibqp;
=20
 err_pdir:
@@ -400,27 +437,15 @@ struct ib_qp *pvrdma_create_qp(struct ib_pd *pd,
 	return ERR_PTR(ret);
 }
=20
-static void pvrdma_free_qp(struct pvrdma_qp *qp)
+static void _pvrdma_free_qp(struct pvrdma_qp *qp)
 {
+	unsigned long flags;
 	struct pvrdma_dev *dev =3D to_vdev(qp->ibqp.device);
-	struct pvrdma_cq *scq;
-	struct pvrdma_cq *rcq;
-	unsigned long flags, scq_flags, rcq_flags;
-
-	/* In case cq is polling */
-	get_cqs(qp, &scq, &rcq);
-	pvrdma_lock_cqs(scq, rcq, &scq_flags, &rcq_flags);
-
-	_pvrdma_flush_cqe(qp, scq);
-	if (scq !=3D rcq)
-		_pvrdma_flush_cqe(qp, rcq);
=20
 	spin_lock_irqsave(&dev->qp_tbl_lock, flags);
 	dev->qp_tbl[qp->qp_handle] =3D NULL;
 	spin_unlock_irqrestore(&dev->qp_tbl_lock, flags);
=20
-	pvrdma_unlock_cqs(scq, rcq, &scq_flags, &rcq_flags);
-
 	if (refcount_dec_and_test(&qp->refcnt))
 		complete(&qp->free);
 	wait_for_completion(&qp->free);
@@ -435,34 +460,71 @@ static void pvrdma_free_qp(struct pvrdma_qp *qp)
 	atomic_dec(&dev->num_qps);
 }
=20
-/**
- * pvrdma_destroy_qp - destroy a queue pair
- * @qp: the queue pair to destroy
- * @udata: user data or null for kernel object
- *
- * @return: 0 on success.
- */
-int pvrdma_destroy_qp(struct ib_qp *qp, struct ib_udata *udata)
+static void pvrdma_free_qp(struct pvrdma_qp *qp)
+{
+	struct pvrdma_cq *scq;
+	struct pvrdma_cq *rcq;
+	unsigned long scq_flags, rcq_flags;
+
+	/* In case cq is polling */
+	get_cqs(qp, &scq, &rcq);
+	pvrdma_lock_cqs(scq, rcq, &scq_flags, &rcq_flags);
+
+	_pvrdma_flush_cqe(qp, scq);
+	if (scq !=3D rcq)
+		_pvrdma_flush_cqe(qp, rcq);
+
+	/*
+	 * We're now unlocking the CQs before clearing out the qp handle this
+	 * should still be safe. We have destroyed the backend QP and flushed
+	 * the CQEs so there should be no other completions for this QP.
+	 */
+	pvrdma_unlock_cqs(scq, rcq, &scq_flags, &rcq_flags);
+
+	_pvrdma_free_qp(qp);
+}
+
+static inline void _pvrdma_destroy_qp_work(struct pvrdma_dev *dev,
+					   u32 qp_handle)
 {
-	struct pvrdma_qp *vqp =3D to_vqp(qp);
 	union pvrdma_cmd_req req;
 	struct pvrdma_cmd_destroy_qp *cmd =3D &req.destroy_qp;
 	int ret;
=20
 	memset(cmd, 0, sizeof(*cmd));
 	cmd->hdr.cmd =3D PVRDMA_CMD_DESTROY_QP;
-	cmd->qp_handle =3D vqp->qp_handle;
+	cmd->qp_handle =3D qp_handle;
=20
-	ret =3D pvrdma_cmd_post(to_vdev(qp->device), &req, NULL, 0);
+	ret =3D pvrdma_cmd_post(dev, &req, NULL, 0);
 	if (ret < 0)
-		dev_warn(&to_vdev(qp->device)->pdev->dev,
+		dev_warn(&dev->pdev->dev,
 			 "destroy queuepair failed, error: %d\n", ret);
+}
=20
+/**
+ * pvrdma_destroy_qp - destroy a queue pair
+ * @qp: the queue pair to destroy
+ * @udata: user data or null for kernel object
+ *
+ * @return: always 0.
+ */
+int pvrdma_destroy_qp(struct ib_qp *qp, struct ib_udata *udata)
+{
+	struct pvrdma_qp *vqp =3D to_vqp(qp);
+
+	_pvrdma_destroy_qp_work(to_vdev(qp->device), vqp->qp_handle);
 	pvrdma_free_qp(vqp);
=20
 	return 0;
 }
=20
+static void __pvrdma_destroy_qp(struct pvrdma_dev *dev,
+				struct pvrdma_qp *qp)
+{
+	_pvrdma_destroy_qp_work(dev, qp->qp_handle);
+	_pvrdma_free_qp(qp);
+}
+
 /**
  * pvrdma_modify_qp - modify queue pair attributes
  * @ibqp: the queue pair
diff --git a/include/uapi/rdma/vmw_pvrdma-abi.h b/include/uapi/rdma/vmw_pvr=
dma-abi.h
index 6e73f0274e41..f8b638c73371 100644
--- a/include/uapi/rdma/vmw_pvrdma-abi.h
+++ b/include/uapi/rdma/vmw_pvrdma-abi.h
@@ -179,6 +179,11 @@ struct pvrdma_create_qp {
 	__aligned_u64 qp_addr;
 };
=20
+struct pvrdma_create_qp_resp {
+	__u32 qpn;
+	__u32 qp_handle;
+};
+
 /* PVRDMA masked atomic compare and swap */
 struct pvrdma_ex_cmp_swap {
 	__aligned_u64 swap_val;
--=20
2.18.1

