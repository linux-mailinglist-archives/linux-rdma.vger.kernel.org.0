Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2F85B826B
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Sep 2019 22:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404647AbfISU06 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Sep 2019 16:26:58 -0400
Received: from mail-eopbgr710068.outbound.protection.outlook.com ([40.107.71.68]:21083
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404646AbfISU06 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Sep 2019 16:26:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iXFSjOy+JeQxH7MAKR4C05KzRElxBkjZZOvizo30gb9iySJY4j8IuVI4BwdWMuZnmI1Hnw5JoWcR/tQMnjv6Nr/5CZJwkvpxMcKlyYgcW6fjj46K1u2PnfhTibTJs28sBs6ShHI67EXVXwGNpxqIDBQBU2gMBc2TV8SmKjXvb0JTMTSe/9IlpRAhY9z0hsIn90GN99RdiJRJyRZRNqQ0owbHTtgGPe9+SUerCl57fugYyIcSlFqb7MuuPoX5X6JCGNoVq0429SjAX0uKc5rbwcM37g0gspaKRie2t16erZmfmimFLkqcwtxMWXpw0Oeoh/9+KGUl429S/Algx3goCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSxybjY7gDPMS9lZKh4x/WJ0zsTLMKsBaTH2Shl8Ffc=;
 b=Mu7y+127m9Q3WqtimMcvMXXkN0KohJiFync2BAdg+yLA9Ga81BPlf5jRhPnBEZWiNeOcEGoYi6DoIg+k/mT++dEm5VO8GVyo+Il//MuyswRWmQA7Lng8Nug9qZmR9vnnYVNHZLGiqUOd2ShPnzo5fx1QZndaGTMA2p/YJ9JtvqwUFpDphkC6kaBum7Rdea+92P1rkrzvh1ghECLJwsvHn81e2KRa4+TpiejL2mjznhAs2KtTCOJkUDqs04Sql2s71ROfr8TrROvvNDt0UgRvZ6TIyRBIMklnhlCiLqDpCYfTSIjN/Rd3W6bl+8pUA0KqJIsH1RiQZYMzau4+Pv8vCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSxybjY7gDPMS9lZKh4x/WJ0zsTLMKsBaTH2Shl8Ffc=;
 b=zGDa69dfILtBT6TIIV3SRlJ/Kf3vaUVRVwKk4e9f5Pbh4quf9ZDOYYf3H3MBziAZ6fpKji2eE5Bfr33ICTAxTNgqOEQevqRYYwM+l8vVLeGpqE6H0us6Oz1FPRzCO9f8PhU2REMhrU5GyA1V/K7z8RGkuVjAQNzw/qxvN4YYpu4=
Received: from BYAPR05MB5511.namprd05.prod.outlook.com (20.177.186.28) by
 BYAPR05MB4005.namprd05.prod.outlook.com (52.135.197.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.5; Thu, 19 Sep 2019 20:26:52 +0000
Received: from BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::81ed:73c3:bc95:7d03]) by BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::81ed:73c3:bc95:7d03%5]) with mapi id 15.20.2284.009; Thu, 19 Sep 2019
 20:26:52 +0000
From:   Adit Ranadive <aditr@vmware.com>
To:     "jgg@mellanox.com" <jgg@mellanox.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Bryan Tan <bryantan@vmware.com>, Adit Ranadive <aditr@vmware.com>
Subject: [PATCH rdma-core v1 2/2] vmw_pvrdma: Use resource ids from physical
 device if available
Thread-Topic: [PATCH rdma-core v1 2/2] vmw_pvrdma: Use resource ids from
 physical device if available
Thread-Index: AQHVbyiS+mY9Q73GDEuGEj9eHwIfPA==
Date:   Thu, 19 Sep 2019 20:26:52 +0000
Message-ID: <ba895545c922c02dfc2ab6512857378e796e9a61.1568923914.git.aditr@vmware.com>
References: <cover.1568923914.git.aditr@vmware.com>
In-Reply-To: <cover.1568923914.git.aditr@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0022.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::35) To BYAPR05MB5511.namprd05.prod.outlook.com
 (2603:10b6:a03:1a::28)
x-mailer: git-send-email 1.8.3.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aditr@vmware.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f7bb9776-3756-4768-421c-08d73d3fb4d4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB4005;
x-ms-traffictypediagnostic: BYAPR05MB4005:|BYAPR05MB4005:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR05MB4005A28C8088DFA5A2521A41C5890@BYAPR05MB4005.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(199004)(189003)(6512007)(52116002)(107886003)(2501003)(25786009)(71200400001)(256004)(14444005)(316002)(54906003)(6116002)(110136005)(2906002)(3846002)(71190400001)(2201001)(86362001)(66946007)(66476007)(66556008)(64756008)(66446008)(50226002)(118296001)(305945005)(7736002)(4326008)(81166006)(8676002)(81156014)(4720700003)(36756003)(99286004)(6486002)(8936002)(66066001)(6436002)(11346002)(446003)(5660300002)(476003)(26005)(2616005)(186003)(102836004)(14454004)(386003)(6506007)(76176011)(486006)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4005;H:BYAPR05MB5511.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hhUA1pAtLViq4vrKk/p9uiDKmlD8vec9z3U+gO0xjCo3bgigXGqrPx5ICfzI3vtAUH9Q3pg2aEsoVAD/7JUHEyO+dLfnByAFtWoDurHoAHrB5xZ9pLCIT+YVUpGmqmrF0dBWnVwflS6iTHd2VuqlmFjJhJWWbEOVQAOVhysO3wCOfuaroPCe3DP2c29Wsmya1UuP5Nzl/QlH5rKvVAo3x6MmTfRXsyd4f7NvxERNg+NTuZqwM/JCiY2z1AFNpz3R59FnWwPeDS7o4/shyUjEH2yTdzMeDUREDQrZgk+tJNUOdVBT5D6UEn446nHqjuQvna7nVg0jRrriipP3/Ak9LgMBjzeuTf9yMvYkjU1VQExwoU7bLpsYXQ4KFp2VhyqheILJBwDvhr2xznyGpLbvDCn/2crveQ2nNpVa68TsQaY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7bb9776-3756-4768-421c-08d73d3fb4d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 20:26:52.4436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: duEP6WiiUKHRZREMUhKVzb+GGoEUoQu5wnEdC4T2pOnH85PGKlq+HiMBCzhffbWkfo4LH/WPdMhgKjiPfLgw0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4005
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Bryan Tan <bryantan@vmware.com>

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
1.8.3.1

