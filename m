Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2E2E0D02
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2019 22:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733005AbfJVUGB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Oct 2019 16:06:01 -0400
Received: from mail-eopbgr680068.outbound.protection.outlook.com ([40.107.68.68]:10926
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731806AbfJVUGB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Oct 2019 16:06:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b314GpVVQwoZ/RGyp8NhYAnnoFgeUaDF1Cdc6/LX1ePKCauoMmy6xLlEGjSfXuQ/YRu7sJ1kroE0k83ChbZ6m8xMfsYL0xUa0kTYeOLrqsl8bmczW6VpthGkQeYszP2Xy4hy9Q7nIvJcVs1p+TrPVRCeK1VC4HfRDM1eisuFJ5d/8ASfDppZ256fDCKuwI8E2cTVYlfGyiAcZf5ldmpXX3wykj1FmoCToGjKC0YFgFaa8vaacpylNkwEj1u28RJsFZkpyc8jspdGfAigvqjpQ2VhfIa2NjTcQBkyDkN97EzMV8B5o8H6YJKy99EY9Lf9X6EN684t2m89u5FpiKBwdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5Gz3wUeHAVZJu/VBZv7HZmC4xqDQRT9uwhaarpTr08=;
 b=RO2KwjHBpr1wq43sUBSPGnfFVXljVUBhZ9MnpnSwfD9aF+OK21PY9sH+J/IqaMJltH/t3NSbOz/ojEcZQhndCwssuK6zP1S9vW0t3f+MLp5PMnbZmwK/hRcRBGM7MZ3E2hjfzRI0FWYqt/Mu/TgBWccBZ7PuThg49ynIDIZ07QNCQpzAFI6QiSyDzPpOlf27vKbGmJBEd5Dgun/lU3pjQlCI2Lolq2S61Wn9ZXBpDQ0SLivUXXnkS5DCwtNZkNR3m0TZPhdUatK/Hwl+M6+95j3z6vGsT4FnGmUICm6iBE+JZw5J/g4yUNYRq3YXiNk6b0fg/xA+uEtE/2108yisTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5Gz3wUeHAVZJu/VBZv7HZmC4xqDQRT9uwhaarpTr08=;
 b=Xt2DgTqu1HagDtlaIH5zyrUvoSns/mCOuFPuROClVB2THwRxCALKlre4yhf+ivkPx2xWOipW7QmYcaaqxdHwnc7FdV8QYS8cTk6ewqtygjFiDxUPPzH3ryCBGVTAqdo244USxY3iW3QcWbUZSnuPMjvK9Y3MxOluj3tAIzVXsJI=
Received: from BYAPR05MB5511.namprd05.prod.outlook.com (20.177.186.28) by
 BYAPR05MB5173.namprd05.prod.outlook.com (20.177.229.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.14; Tue, 22 Oct 2019 20:05:58 +0000
Received: from BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::c992:3ec7:35ca:d345]) by BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::c992:3ec7:35ca:d345%7]) with mapi id 15.20.2387.016; Tue, 22 Oct 2019
 20:05:58 +0000
From:   Adit Ranadive <aditr@vmware.com>
To:     "jgg@mellanox.com" <jgg@mellanox.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Bryan Tan <bryantan@vmware.com>, Adit Ranadive <aditr@vmware.com>
Subject: [PATCH rdma-core v3 3/3] vmw_pvrdma: Use resource ids from physical
 device if available
Thread-Topic: [PATCH rdma-core v3 3/3] vmw_pvrdma: Use resource ids from
 physical device if available
Thread-Index: AQHViRQe6BA3CRim/069+55xPVLXVw==
Date:   Tue, 22 Oct 2019 20:05:58 +0000
Message-ID: <2cffaf5538cc1a738c37b7982217bc349d643261.1571774292.git.aditr@vmware.com>
References: <cover.1571774291.git.aditr@vmware.com>
In-Reply-To: <cover.1571774291.git.aditr@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0047.namprd02.prod.outlook.com
 (2603:10b6:a03:54::24) To BYAPR05MB5511.namprd05.prod.outlook.com
 (2603:10b6:a03:1a::28)
x-mailer: git-send-email 2.18.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aditr@vmware.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2aa1e2e0-d397-424b-422d-08d7572b40f0
x-ms-traffictypediagnostic: BYAPR05MB5173:|BYAPR05MB5173:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR05MB51732BBB077E643D6C0551D5C5680@BYAPR05MB5173.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:619;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(199004)(189003)(71200400001)(110136005)(26005)(6116002)(7736002)(66066001)(6512007)(2501003)(71190400001)(52116002)(2906002)(102836004)(99286004)(6506007)(305945005)(76176011)(386003)(3846002)(6486002)(186003)(5660300002)(486006)(6436002)(476003)(2616005)(11346002)(446003)(14444005)(8676002)(66446008)(64756008)(66556008)(66476007)(66946007)(4326008)(81166006)(81156014)(8936002)(50226002)(316002)(256004)(36756003)(86362001)(25786009)(2201001)(118296001)(478600001)(107886003)(14454004)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5173;H:BYAPR05MB5511.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LnE1Hu/4cMUAc68q92ZClYApRyJbZYnnzhw5dHCiE7DjpeRKGz5R9wSTaY0C6eDRBEavyF56dYizqfUFxkA9rO7k8bFdEqrZr5C9gBA9287yMYMtbqU/a0wwd7HZq39pjW0ZptHqZ7X1F/SpNCE6MHnz/0jlQhYwv0shkT8kNnnIn3qpy4/hUZedRnI0TGmJ7w5NtW3B3RmK0sP3VvxTZVvJsN4VHc2+8FSx8iCyZw2t1N+7NF25fpREqfsBinoiAwMpWXvpl8joTdPge+dE/ZgUzswiuZWzZq8QCQDTF2+Y7Ue4y42yTObTlc/BVA6nyI6T3YSrH7fw75jhxkQIEV9UyBoiLoi5lh5VwrufcVJSp5WYRSXZ29IQGYdnYz4vnbi/vSsac1Wm4UkLxqt6EcuYAC7yi7un7v+381hZPaL6ZJU2URVHtNceGHsTb1EU
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aa1e2e0-d397-424b-422d-08d7572b40f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 20:05:58.3540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lJURx3Sv5nq7XjCpfX5OuEm/flQwzz+0BG0IK9dh36csas9vAfCKyeKCQ3GKHT1QWDO6MzWuueV6/ifOGCOUow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5173
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Bryan Tan <bryantan@vmware.com>

This is the accompanying userspace change to allow applications
use physical resource ids if provided by the driver/device.

Reviewed-by: Jorgen Hansen <jhansen@vmware.com>
Signed-off-by: Adit Ranadive <aditr@vmware.com>
Signed-off-by: Bryan Tan <bryantan@vmware.com>
---
 providers/vmw_pvrdma/pvrdma-abi.h |  2 +-
 providers/vmw_pvrdma/pvrdma.h     |  1 +
 providers/vmw_pvrdma/qp.c         | 23 ++++++++++++-----------
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/providers/vmw_pvrdma/pvrdma-abi.h b/providers/vmw_pvrdma/pvrdm=
a-abi.h
index 77db9ddd1bb7..1a4c3c8a98f2 100644
--- a/providers/vmw_pvrdma/pvrdma-abi.h
+++ b/providers/vmw_pvrdma/pvrdma-abi.h
@@ -55,7 +55,7 @@ DECLARE_DRV_CMD(user_pvrdma_alloc_pd, IB_USER_VERBS_CMD_A=
LLOC_PD,
 DECLARE_DRV_CMD(user_pvrdma_create_cq, IB_USER_VERBS_CMD_CREATE_CQ,
 		pvrdma_create_cq, pvrdma_create_cq_resp);
 DECLARE_DRV_CMD(user_pvrdma_create_qp, IB_USER_VERBS_CMD_CREATE_QP,
-		pvrdma_create_qp, empty);
+		pvrdma_create_qp, pvrdma_create_qp_resp);
 DECLARE_DRV_CMD(user_pvrdma_create_srq, IB_USER_VERBS_CMD_CREATE_SRQ,
 		pvrdma_create_srq, pvrdma_create_srq_resp);
 DECLARE_DRV_CMD(user_pvrdma_alloc_ucontext, IB_USER_VERBS_CMD_GET_CONTEXT,
diff --git a/providers/vmw_pvrdma/pvrdma.h b/providers/vmw_pvrdma/pvrdma.h
index d90bd8096664..bb4a2db08d14 100644
--- a/providers/vmw_pvrdma/pvrdma.h
+++ b/providers/vmw_pvrdma/pvrdma.h
@@ -170,6 +170,7 @@ struct pvrdma_qp {
 	struct pvrdma_wq		sq;
 	struct pvrdma_wq		rq;
 	int				is_srq;
+	uint32_t			qp_handle;
 };
=20
 struct pvrdma_ah {
diff --git a/providers/vmw_pvrdma/qp.c b/providers/vmw_pvrdma/qp.c
index ef429db93a43..10784314f5b5 100644
--- a/providers/vmw_pvrdma/qp.c
+++ b/providers/vmw_pvrdma/qp.c
@@ -211,9 +211,8 @@ struct ibv_qp *pvrdma_create_qp(struct ibv_pd *pd,
 {
 	struct pvrdma_device *dev =3D to_vdev(pd->context->device);
 	struct user_pvrdma_create_qp cmd;
-	struct ib_uverbs_create_qp_resp resp;
+	struct user_pvrdma_create_qp_resp resp =3D {};
 	struct pvrdma_qp *qp;
-	int ret;
 	int is_srq =3D !!(attr->srq);
=20
 	attr->cap.max_send_sge =3D max_t(uint32_t, 1U, attr->cap.max_send_sge);
@@ -282,14 +281,16 @@ struct ibv_qp *pvrdma_create_qp(struct ibv_pd *pd,
 	cmd.rbuf_size =3D qp->rbuf.length;
 	cmd.qp_addr =3D (uintptr_t) qp;
=20
-	ret =3D ibv_cmd_create_qp(pd, &qp->ibv_qp, attr,
-				&cmd.ibv_cmd, sizeof(cmd),
-				&resp, sizeof(resp));
-
-	if (ret)
+	if (ibv_cmd_create_qp(pd, &qp->ibv_qp, attr, &cmd.ibv_cmd, sizeof(cmd),
+			      &resp.ibv_resp, sizeof(resp)))
 		goto err_free;
=20
-	to_vctx(pd->context)->qp_tbl[qp->ibv_qp.qp_num & 0xFFFF] =3D qp;
+	if (resp.drv_payload.qp_handle !=3D 0)
+		qp->qp_handle =3D resp.drv_payload.qp_handle;
+	else
+		qp->qp_handle =3D qp->ibv_qp.qp_num;
+
+	to_vctx(pd->context)->qp_tbl[qp->qp_handle & 0xFFFF] =3D qp;
=20
 	/* If set, each WR submitted to the SQ generate a completion entry */
 	if (attr->sq_sig_all)
@@ -414,7 +415,7 @@ int pvrdma_destroy_qp(struct ibv_qp *ibqp)
 	free(qp->rq.wrid);
 	pvrdma_free_buf(&qp->rbuf);
 	pvrdma_free_buf(&qp->sbuf);
-	ctx->qp_tbl[ibqp->qp_num & 0xFFFF] =3D NULL;
+	ctx->qp_tbl[qp->qp_handle & 0xFFFF] =3D NULL;
 	free(qp);
=20
 	return 0;
@@ -547,7 +548,7 @@ out:
 	if (nreq) {
 		udma_to_device_barrier();
 		pvrdma_write_uar_qp(ctx->uar,
-				    PVRDMA_UAR_QP_SEND | ibqp->qp_num);
+				    PVRDMA_UAR_QP_SEND | qp->qp_handle);
 	}
=20
 	pthread_spin_unlock(&qp->sq.lock);
@@ -630,7 +631,7 @@ int pvrdma_post_recv(struct ibv_qp *ibqp, struct ibv_re=
cv_wr *wr,
 out:
 	if (nreq)
 		pvrdma_write_uar_qp(ctx->uar,
-				    PVRDMA_UAR_QP_RECV | ibqp->qp_num);
+				    PVRDMA_UAR_QP_RECV | qp->qp_handle);
=20
 	pthread_spin_unlock(&qp->rq.lock);
 	return ret;
--=20
2.18.1

