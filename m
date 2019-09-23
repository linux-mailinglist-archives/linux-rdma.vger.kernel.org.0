Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3CBCBBF12
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Sep 2019 01:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408394AbfIWXtm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Sep 2019 19:49:42 -0400
Received: from mail-eopbgr690063.outbound.protection.outlook.com ([40.107.69.63]:12923
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729276AbfIWXtm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 23 Sep 2019 19:49:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nLzGpkW9zobVF0UC99zu80SVSm0dOO7Euq2Yu5LxumSz4gENgG+xssDHChdIsrCeDGzID7EVPHj3V2bIoIqiMhp3C2HCG6RXzxSn8pAwGNneH8xXCf/1iTrM/EuRBy1npHS9kCWsS+8VhEkuUuNzWt6+Gk1RqFdfOG3A5tniTRMKZHjF9jBiSXoZ26KmJNCv4/uJAqAml8MWVfPUF4jBHQyNVsYKeYVBALMWZEkgmylLjdqJ6MX6Jnz6uVVAP+SAP2aR4Kp3rtUIUrUyZc0767qy+wHbcgIRdNOwhx5vE3Ckds0yiJo0lfRi09h5uEBp/oV/1rXjE/Bh5CbaJljatw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yrH9YsM/4CewjflRkkV+obPBR2pM2j/tjQV8uVJ570=;
 b=HXfwxXZeUd5Z5wi9drkV07qgjVu8mqprn3bFTarGnxr5c1wIN9M+46Uw4dWonIpBoXwQ0xS+VBPa0/Zz5EgaRdM3wwW0gOt7rDvNYzA2a17mPDb9ZMfeHrJDBOOivzRb+D2iYcU3OZFaBIly2XkZ90KLT2Zn0Kk8RWRUiySWoqSXdLyxLzWjqor/O2whTbX0Rn6zqXMOr1I0xXsltMA8wAHYjZ/hRVYQLh1Q2l88AX+PPwkMQQerhHRnHsCAfdeVhtYGMYbIt5BC7lb13xxvBDQut/hQFQMRp+vaapfORgO44ze0dZKLPLwJJbXUAaiB+coqhtnIV3qptqWIv25tBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yrH9YsM/4CewjflRkkV+obPBR2pM2j/tjQV8uVJ570=;
 b=HEsUVZBgYJ7UTMuqrPPZL5ZUBOeexSoQ8FpHsOiK1pYrJ7np1yQFw6Q1AN8Y8gmenUBLBGU3at9GNlDZoL2CnPq8R8l9b4NvujpJvCP7nN3qQTbIerkNtqBwDUKSzrmZ1jLVHbBVMUn/2yJsURcH1ZvzMjmN/tqwabLRAzQUCeI=
Received: from BYAPR05MB5511.namprd05.prod.outlook.com (20.177.186.28) by
 BYAPR05MB4455.namprd05.prod.outlook.com (52.135.205.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.15; Mon, 23 Sep 2019 23:49:38 +0000
Received: from BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::81ed:73c3:bc95:7d03]) by BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::81ed:73c3:bc95:7d03%5]) with mapi id 15.20.2284.023; Mon, 23 Sep 2019
 23:49:38 +0000
From:   Adit Ranadive <aditr@vmware.com>
To:     "jgg@mellanox.com" <jgg@mellanox.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Bryan Tan <bryantan@vmware.com>, Adit Ranadive <aditr@vmware.com>
Subject: [PATCH rdma-core v2 2/2] vmw_pvrdma: Use resource ids from physical
 device if available
Thread-Topic: [PATCH rdma-core v2 2/2] vmw_pvrdma: Use resource ids from
 physical device if available
Thread-Index: AQHVcmmP5qJKSwXwkUuK/2qZiyULPA==
Date:   Mon, 23 Sep 2019 23:49:38 +0000
Message-ID: <ed279e065733c35eb59c76455f5f277965977ff0.1569282124.git.aditr@vmware.com>
References: <cover.1569282124.git.aditr@vmware.com>
In-Reply-To: <cover.1569282124.git.aditr@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR06CA0069.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::46) To BYAPR05MB5511.namprd05.prod.outlook.com
 (2603:10b6:a03:1a::28)
x-mailer: git-send-email 2.18.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aditr@vmware.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7c44e7db-e7bb-4cf1-5658-08d74080b1fb
x-ms-traffictypediagnostic: BYAPR05MB4455:|BYAPR05MB4455:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR05MB4455D2A642091AD01CD51F41C5850@BYAPR05MB4455.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 0169092318
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(136003)(39850400004)(376002)(366004)(199004)(189003)(54906003)(8936002)(110136005)(14454004)(316002)(7736002)(25786009)(305945005)(4326008)(6486002)(256004)(2201001)(6436002)(6512007)(14444005)(107886003)(36756003)(478600001)(66066001)(3846002)(6116002)(81166006)(8676002)(81156014)(71190400001)(186003)(66946007)(76176011)(52116002)(86362001)(26005)(99286004)(6506007)(102836004)(386003)(486006)(11346002)(71200400001)(476003)(5660300002)(2906002)(446003)(66446008)(66556008)(64756008)(50226002)(2616005)(2501003)(118296001)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4455;H:BYAPR05MB5511.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uJ130zzCjawNWiLo+fpyqiXtasDWJwrnGExuGrsTXk2SpafS1wiWlO+mN4FzSu47o2uwyFDs+u5AwXsK7ul6USMhOVePl8JMF1CMS+l8plFqSFZ982KKMLlWQ05mEgJmTBaYkk4d8PRjDP1xFRxcDMQDVVNLcLmj28Xgy3pqbZGtb9c62SYvbCohf7nKRWjU9ffv1QjGBre4DJGHp68gem5+WIoEMeNmkTkGC+FP1NiZgSW+tV5k9tZfIFl//5xxVfmqzhiITfYdFmVMzfoil3clJ0FUJ/lrEV5V04sT4j0Vjiq2y0trbT2rxoaX7hwDtWDkCJ++X2pD8m9AXq9rqfVIiOE4WvPc50notxgamk4SENcFy5Z40sNi5GIx/mHd3dH9MICzUtl34S2IgRZszdK+NRptLCeGkwgt7YbyI2U=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c44e7db-e7bb-4cf1-5658-08d74080b1fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2019 23:49:38.3674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hoPYvoarY7/NlRt0XukwUNxzCxGtvRXHdeqWxwwkdw+K2rgyLtbOvhZc0F218U3eqCckIOkZUQ7JZ6DeESOCPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4455
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Bryan Tan <bryantan@vmware.com>

This is the accompanying userspace change to allow applications
use physical resource ids if provided by the driver/device.

The create QP command is modified to specify a flag that tells
the driver to send back the physical HCA's QPN and the hypervisor-
generated QP handle separately.

Reviewed-by: Jorgen Hansen <jhansen@vmware.com>
Signed-off-by: Adit Ranadive <aditr@vmware.com>
Signed-off-by: Bryan Tan <bryantan@vmware.com>
---
 providers/vmw_pvrdma/pvrdma-abi.h |  2 +-
 providers/vmw_pvrdma/pvrdma.h     |  1 +
 providers/vmw_pvrdma/qp.c         | 24 +++++++++++++-----------
 3 files changed, 15 insertions(+), 12 deletions(-)

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
index ef429db93a43..966480f5abaa 100644
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
@@ -281,15 +280,18 @@ struct ibv_qp *pvrdma_create_qp(struct ibv_pd *pd,
 	cmd.rbuf_addr =3D (uintptr_t)qp->rbuf.buf;
 	cmd.rbuf_size =3D qp->rbuf.length;
 	cmd.qp_addr =3D (uintptr_t) qp;
+	cmd.flags =3D PVRDMA_USER_QP_CREATE_USE_RESP;
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
+	if (resp.drv_payload.qpn_valid =3D=3D PVRDMA_USER_QP_CREATE_USE_RESP)
+		qp->qp_handle =3D resp.drv_payload.qp_handle;
+	else
+		qp->qp_handle =3D qp->ibv_qp.qp_num;
+
+	to_vctx(pd->context)->qp_tbl[qp->qp_handle & 0xFFFF] =3D qp;
=20
 	/* If set, each WR submitted to the SQ generate a completion entry */
 	if (attr->sq_sig_all)
@@ -414,7 +416,7 @@ int pvrdma_destroy_qp(struct ibv_qp *ibqp)
 	free(qp->rq.wrid);
 	pvrdma_free_buf(&qp->rbuf);
 	pvrdma_free_buf(&qp->sbuf);
-	ctx->qp_tbl[ibqp->qp_num & 0xFFFF] =3D NULL;
+	ctx->qp_tbl[qp->qp_handle & 0xFFFF] =3D NULL;
 	free(qp);
=20
 	return 0;
@@ -547,7 +549,7 @@ out:
 	if (nreq) {
 		udma_to_device_barrier();
 		pvrdma_write_uar_qp(ctx->uar,
-				    PVRDMA_UAR_QP_SEND | ibqp->qp_num);
+				    PVRDMA_UAR_QP_SEND | qp->qp_handle);
 	}
=20
 	pthread_spin_unlock(&qp->sq.lock);
@@ -630,7 +632,7 @@ int pvrdma_post_recv(struct ibv_qp *ibqp, struct ibv_re=
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

