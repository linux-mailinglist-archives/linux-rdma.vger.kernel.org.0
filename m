Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 624F2E0D04
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2019 22:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731822AbfJVUG6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Oct 2019 16:06:58 -0400
Received: from mail-eopbgr680076.outbound.protection.outlook.com ([40.107.68.76]:26180
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729726AbfJVUG6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Oct 2019 16:06:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MTrpWT+hoZ4dFf1s0pRDSTClSNY7muZmjONQDbuzcpysKv2wgfYTjR0m4aOlH4SgV3u1NIOn7ZkD9wFYZ6Y693Z1LlvBEJteAADdXascVSLEECIldQnfQzUCZYDJzbjwFS4RVG5myDZl43N8ch4upQf6sYXhSDkuf1SBX8TS/+1+FKLmLKvZBYEyiDzZuTa7Ecd7HAJ5RMquoYZ9/gfr0rAQqq88gqPdFCtOKZQRzfyYhAIcjyn34t+cCZaNUn6Tqc6w+ABPNFSKt2vi8nXhFIwlhZO7iuGd+saHWUBkR5cAAMlPdfgzTLkVIQCw+iPCfttfOKsgKXmVxNgfiOcxkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fpa+MXdjZf+iOda+5hf2wyL9fvaQUi9QRa5nQDl39p0=;
 b=QeyyIZ04xFJ3hYXGRnrmZnJkOjLv5k7EH+UOfRhjPmdCUr5u1ULyYAfRvMm/dUidKMJmbnCvp4+1bYR1SPOf8CxQnalZka2SZKZRwzZp5Yx3WqJlvBFIeXv33Pj+5KU2p5MzqI3Dbsca/AB6lxgOAK/huBCA1PNqG2Ebux2otKsw+ZBUn7elYfxY3yqY7RIEWVz/AybiZCr1gAK4jI2xlb/A348mtjaP7iiV9k7Hy/IQ/ERGUjTSseRj+H6jekRNSTrP+jlzPUjPoADJdGYJ6Hj2G0BkMwOmMfI2fq7VnItcAeofp6y1oLY0r02AbNO+aJP40/WNLTzJBGR4mJa9rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fpa+MXdjZf+iOda+5hf2wyL9fvaQUi9QRa5nQDl39p0=;
 b=mL7aun0UtWotBzcSma2NJ0YRMQW/o2/WcauNNWgPMARX/oXzSWGfi/j41tGWuJE/M8ag3l1ND38husIyqwxUlpQL/0q9AKdLjAIaAYF4rlhQTT7fuq2PzefaJFfQQN0An0/PVWcm88VLAiu8z0bVhorQVYGR2tbl8IhO/Hoz5FA=
Received: from BYAPR05MB5511.namprd05.prod.outlook.com (20.177.186.28) by
 BYAPR05MB5173.namprd05.prod.outlook.com (20.177.229.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.14; Tue, 22 Oct 2019 20:06:51 +0000
Received: from BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::c992:3ec7:35ca:d345]) by BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::c992:3ec7:35ca:d345%7]) with mapi id 15.20.2387.016; Tue, 22 Oct 2019
 20:06:51 +0000
From:   Adit Ranadive <aditr@vmware.com>
To:     "jgg@mellanox.com" <jgg@mellanox.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Bryan Tan <bryantan@vmware.com>,
        Pv-drivers <Pv-drivers@vmware.com>,
        Adit Ranadive <aditr@vmware.com>
Subject: [PATCH v2] RDMA/vmw_pvrdma: Use resource ids from physical device if
 available
Thread-Topic: [PATCH v2] RDMA/vmw_pvrdma: Use resource ids from physical
 device if available
Thread-Index: AQHViRQ9NYXZypIt40K4gJBX9Hr5Pw==
Date:   Tue, 22 Oct 2019 20:06:50 +0000
Message-ID: <20191022200642.22762-1-aditr@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR06CA0056.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::33) To BYAPR05MB5511.namprd05.prod.outlook.com
 (2603:10b6:a03:1a::28)
x-mailer: git-send-email 2.18.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aditr@vmware.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d301d35b-5594-49d8-b87b-08d7572b5f84
x-ms-traffictypediagnostic: BYAPR05MB5173:|BYAPR05MB5173:
x-ms-exchange-purlcount: 1
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR05MB517347ADE026DCF8E545773DC5680@BYAPR05MB5173.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(199004)(189003)(71200400001)(110136005)(26005)(6116002)(7736002)(66066001)(6512007)(2501003)(71190400001)(52116002)(2906002)(102836004)(99286004)(6506007)(305945005)(386003)(3846002)(6306002)(6486002)(186003)(1076003)(5660300002)(486006)(6436002)(476003)(2616005)(14444005)(8676002)(66446008)(64756008)(66556008)(66476007)(66946007)(4326008)(81166006)(81156014)(8936002)(50226002)(316002)(256004)(36756003)(86362001)(25786009)(2201001)(478600001)(107886003)(966005)(14454004)(54906003)(309714004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5173;H:BYAPR05MB5511.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3MwPdSetLppUMNjtumexV3J+vSv2nOU4on56xd7ZhzIeWSoi3ArXc/NnIOSHhMhq+bsdD2YEoN5In1bMuJ31dF8Woz462NSrvmbUD5gedO1vboZ0a9GeEvBcJuObn4SNtDQPnnLGTgquDenghiXWD9W547kyiD+vLB5kbn9Ts6kHABaT4xsI7MQ/rm+XI/YsmnE2So5YlJbx+BKjUVNRg09464hxGNqwD8nJAA6LpdhnOka4eXiZyqcHqsw+Ps/8os95ZC0UfGklgXyRz03O3z/a0QV1Ws4uHDpNpS5sOoTVRntaQbVwyg8vL9lIhz5Waw3UdwNwfZiB3u8JV7HoROUCHz0HFZclNxHvL/1CURnf31Bj5oWH0ZduNzNmINUMns2o1OAzEz0oL3jS5+yBAXZojbKvEHMKn1igX97mdtc/2vYOKzwQoFuOHjynfqYFd/YR9etMOqOmGbvsUvEpC0AsyBaKfUPnJYIOMlcUEwA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d301d35b-5594-49d8-b87b-08d7572b5f84
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 20:06:50.5011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HAvwEBjTuV5FlUELxFnU4fcxwiJmkh2Jwp8YDch2db9UP4qul8Gm/QuTFzVN2Pnk4+s+A8wkgglb6mGRxOTuMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5173
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
v1 -> v2:
 - Dropped the create qp flag
v0 -> v1:
 - Dropped the ABI version bump
 - Added a new create qp flag to indicate userspace support
 - Refactor of destroy/free qp
 - Updated commit description

 .../infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h |  15 ++-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c  | 117 +++++++++++++-----
 include/uapi/rdma/vmw_pvrdma-abi.h            |   5 +
 3 files changed, 108 insertions(+), 29 deletions(-)

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
index bca6a58a442e..0a726b48c97c 100644
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
+			    udata->outlen !=3D sizeof(qp_resp)) {
+				dev_warn(&dev->pdev->dev,
+					 "create queuepair not supported\n");
+				ret =3D -EOPNOTSUPP;
+				goto err_qp;
+			}
+
 			if (!is_srq) {
 				/* set qp->sq.wqe_cnt, shift, buf_size.. */
 				qp->rumem =3D ib_umem_get(udata, ucmd.rbuf_addr,
@@ -379,13 +393,35 @@ struct ib_qp *pvrdma_create_qp(struct ib_pd *pd,
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
+		if (udata->outlen =3D=3D sizeof(qp_resp)) {
+			qp_resp.qpn =3D qp->ibqp.qp_num;
+			qp_resp.qp_handle =3D qp->qp_handle;
+
+			if (ib_copy_to_udata(udata, &qp_resp,
+					     sizeof(qp_resp))) {
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
@@ -400,27 +436,15 @@ struct ib_qp *pvrdma_create_qp(struct ib_pd *pd,
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
@@ -435,34 +459,71 @@ static void pvrdma_free_qp(struct pvrdma_qp *qp)
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

