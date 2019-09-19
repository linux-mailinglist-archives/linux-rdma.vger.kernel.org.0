Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14332B8261
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Sep 2019 22:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404636AbfISUZF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Sep 2019 16:25:05 -0400
Received: from mail-eopbgr820041.outbound.protection.outlook.com ([40.107.82.41]:53695
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404462AbfISUZE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Sep 2019 16:25:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUUTSLhCSQIcadutn2/bFbCTU9XekyoQi83/wjdPUm7qbOcGIhQVv76tu0/dl6Jw/XSXAqpcdAP3ZOIOfuHpGqIPpoDZSNWDMnApSlnrD1ilwF8/+wELWAdrmK3UJIBGkWPBJO7+ODTXIlFTDx1jBjFipL/gIAgWwKHZAd3SXUAXpn6hmfP0eaKPzSpCzQKjK535UCtTcUxeltpqOYth6hLKdMWSBGUcYruTOPyV5A/ICgf/Ky3zFK0CPyg/sEadxv/82XAkoQlP6Xek6ZkldcpzsqvqkYeNYp3KgPyvZ/oG9XhYu25gB/fMPxW0H5dUIrQ24bFVP7l/grOrbYUDpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/r6ItOzttYqOwrg5nvVBL2DhOISbCXIRSSfOqrPmVo=;
 b=Fpv+B9LSAZPXvSbElzVhVLDUDw508ldEC3Eg+BsFsTKTYkfy4JI5988fz4A/OachhNkCVQt+rn1zIqp0RZoOsWCGJe+eHuS071cBceRqP3vX2S3qxjkU7iovQNH23VHKRl3a40UazOFsdlARphteF3Ws2/aLJS71g81v82xVSvwB3qM+6d3RHRCXfKd+FKvEX7dRPGWB8S+E7wVtHcJGnU2NYvuNmgV9+JMOQz1SLM74jZ3nlx+VrYCwl0n+pT/PSuzJwo3KKxTBlM1ath4ea3R89mbZWfQx3nhynaouK7EFOfty21zM3ARWDHMOowDpNSyRUllVLdb4Mugr/GxPTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/r6ItOzttYqOwrg5nvVBL2DhOISbCXIRSSfOqrPmVo=;
 b=N2/Xs5m+/Lexlpy/x4mDei/rzVMu6K5swbXdORdsUEJLba6rL90iR9AEwxG5Ulna8H9lUwXygXRwIX/AFkFEiT/eMqipYWLGXx9ehwWOATmv0Eu0cXTpPHEGlCc6+2ycpttLhjDnqmEKg9eTya6tobfBhpg6GC4fc/YtnkdASYo=
Received: from BYAPR05MB5511.namprd05.prod.outlook.com (20.177.186.28) by
 BYAPR05MB6455.namprd05.prod.outlook.com (20.178.233.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.16; Thu, 19 Sep 2019 20:24:56 +0000
Received: from BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::81ed:73c3:bc95:7d03]) by BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::81ed:73c3:bc95:7d03%5]) with mapi id 15.20.2284.009; Thu, 19 Sep 2019
 20:24:56 +0000
From:   Adit Ranadive <aditr@vmware.com>
To:     "jgg@mellanox.com" <jgg@mellanox.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Bryan Tan <bryantan@vmware.com>,
        Pv-drivers <Pv-drivers@vmware.com>,
        Adit Ranadive <aditr@vmware.com>
Subject: [PATCH for-next v1] RDMA/vmw_pvrdma: Use resource ids from physical
 device if available
Thread-Topic: [PATCH for-next v1] RDMA/vmw_pvrdma: Use resource ids from
 physical device if available
Thread-Index: AQHVbyhNYSy/DHAt80igdHIsy3KW2g==
Date:   Thu, 19 Sep 2019 20:24:56 +0000
Message-ID: <1568924678-16356-1-git-send-email-aditr@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BY5PR16CA0027.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::40) To BYAPR05MB5511.namprd05.prod.outlook.com
 (2603:10b6:a03:1a::28)
x-mailer: git-send-email 1.8.3.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aditr@vmware.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e01b6076-b429-4092-bf11-08d73d3f6f89
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB6455;
x-ms-traffictypediagnostic: BYAPR05MB6455:|BYAPR05MB6455:
x-ms-exchange-purlcount: 1
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR05MB64553005C5E8DE51DB6301B8C5890@BYAPR05MB6455.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(199004)(189003)(4720700003)(305945005)(2906002)(2201001)(7736002)(3846002)(6116002)(50226002)(8676002)(71200400001)(71190400001)(8936002)(5660300002)(81166006)(81156014)(86362001)(99286004)(2501003)(36756003)(478600001)(25786009)(14454004)(66556008)(66066001)(52116002)(486006)(107886003)(966005)(4326008)(2616005)(476003)(54906003)(64756008)(66946007)(316002)(6506007)(6486002)(102836004)(6436002)(26005)(186003)(6306002)(66446008)(14444005)(110136005)(66476007)(256004)(386003)(6512007)(309714004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB6455;H:BYAPR05MB5511.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HIdVc/LC5DHoraafieZR0UgHYohUNBgQiaaRvd8LyQ55ZswYr5hi4Ye3e/X9dE1RWBwhi160OlKLXMFRVKt2z3FCWlhBbLfZVC7ZxO+Ulo1UqMY0zgxKaXWE58Vswf0MHmlSWrH1DviyUJJY7JHCQYu/6wF3Js6WXxi5+vfQtfZbTdjKXtXDgk5OVrDQ7Ba494AKwiaTS07knhM7GY+QMRZS2THUiR6AinyCtmLbvRrGln1+3jB53nVDSdw67ZQ7Nz+M+21qrGPbvMbZyHqobqeqLhHvIc49rfH68kMSYpVS1Edd4h71Y9Czq+wWAI64ebzDsVVBQSpcoRR57dEHERAaURCIwAFqmYu5XvhZQqDAkQ0LQ8c5kAOh2KyFEeokqNE8fFBnmlKzRi2n64PsIRY7IVj803uqRagvZlnUc9s=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e01b6076-b429-4092-bf11-08d73d3f6f89
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 20:24:56.3164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4y2BUs9+7EdwA6LCo8eSfMa/vDqPEQvXTqQ/Pqg/NQNe1h4NtBkVmWzQXMm8jV03V96+Itx0yKgYw14M0h24JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6455
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Bryan Tan <bryantan@vmware.com>

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
v0 -> v1:
 - Dropped the ABI version bump (suggested by Jason)
 - Added a new create qp flag to indicate userspace support
 - Refactor of destroy/free qp
 - Updated commit description (suggested by Yuval)

 drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h |  15 ++-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c      | 118 +++++++++++++++++-=
----
 include/uapi/rdma/vmw_pvrdma-abi.h                |  13 +++
 3 files changed, 117 insertions(+), 29 deletions(-)

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
@@ -663,6 +675,7 @@ struct pvrdma_cmd_destroy_bind {
 	struct pvrdma_cmd_create_cq_resp create_cq_resp;
 	struct pvrdma_cmd_resize_cq_resp resize_cq_resp;
 	struct pvrdma_cmd_create_qp_resp create_qp_resp;
+	struct pvrdma_cmd_create_qp_resp_v2 create_qp_resp_v2;
 	struct pvrdma_cmd_query_qp_resp query_qp_resp;
 	struct pvrdma_cmd_destroy_qp_resp destroy_qp_resp;
 	struct pvrdma_cmd_create_srq_resp create_srq_resp;
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c b/drivers/infinib=
and/hw/vmw_pvrdma/pvrdma_qp.c
index bca6a58a442e..6ca7014bf368 100644
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
+			    ucmd.flags !=3D PVRDMA_USER_QP_CREATE_USE_RESP) {
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
+		if (ucmd.flags =3D=3D PVRDMA_USER_QP_CREATE_USE_RESP) {
+			qp_resp.qpn =3D qp->ibqp.qp_num;
+			qp_resp.qp_handle =3D qp->qp_handle;
+			qp_resp.qpn_valid =3D PVRDMA_USER_QP_CREATE_USE_RESP;
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
index 6e73f0274e41..1d339285550e 100644
--- a/include/uapi/rdma/vmw_pvrdma-abi.h
+++ b/include/uapi/rdma/vmw_pvrdma-abi.h
@@ -133,6 +133,10 @@ enum pvrdma_wc_flags {
 	PVRDMA_WC_FLAGS_MAX		=3D PVRDMA_WC_WITH_NETWORK_HDR_TYPE,
 };
=20
+enum pvrdma_user_qp_create_flags {
+	PVRDMA_USER_QP_CREATE_USE_RESP	=3D 1 << 0,
+};
+
 struct pvrdma_alloc_ucontext_resp {
 	__u32 qp_tab_size;
 	__u32 reserved;
@@ -177,6 +181,15 @@ struct pvrdma_create_qp {
 	__u32 rbuf_size;
 	__u32 sbuf_size;
 	__aligned_u64 qp_addr;
+	__u32 flags;
+	__u32 reserved;
+};
+
+struct pvrdma_create_qp_resp {
+	__u32 qpn;
+	__u32 qp_handle;
+	__u32 qpn_valid;
+	__u32 reserved;
 };
=20
 /* PVRDMA masked atomic compare and swap */
--=20
1.8.3.1

