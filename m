Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF6345074
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jun 2019 02:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725835AbfFNAN4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Jun 2019 20:13:56 -0400
Received: from mail-eopbgr70071.outbound.protection.outlook.com ([40.107.7.71]:54647
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725801AbfFNAN4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 13 Jun 2019 20:13:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/g9zrkdAN/RHsyKgnzuwsKuakF9Bik2aP1Bvv/d7yK0=;
 b=FhP+ZysnRkFQj/VyEl87gWNAm5aBNdE8CNf/xQSzyfuVIe2KfEpaGgewQFZ79d8GBCJDmwhN1Q0+3dTDVHHh8dpcU/qKK019hLcH1+Vk9wWf6Pt2eWviN763CJEF93fxY6YxMAgdtoQ77HhZ79B/XVUJEcFqqwm61BrQMxQUe/4=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6303.eurprd05.prod.outlook.com (20.179.24.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Fri, 14 Jun 2019 00:13:51 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1%6]) with mapi id 15.20.1987.012; Fri, 14 Jun 2019
 00:13:51 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: [PATCH] RDMA/uverbs: Use offsetofend instead of opencoding
Thread-Topic: [PATCH] RDMA/uverbs: Use offsetofend instead of opencoding
Thread-Index: AQHVIkYLMY2U/2OZrEe5dh50m5NV5A==
Date:   Fri, 14 Jun 2019 00:13:51 +0000
Message-ID: <20190614001347.GA20629@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR0102CA0069.prod.exchangelabs.com
 (2603:10b6:208:25::46) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69c89855-5b63-4f03-8b43-08d6f05d2dcd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB6303;
x-ms-traffictypediagnostic: VI1PR05MB6303:
x-microsoft-antispam-prvs: <VI1PR05MB6303B7343592C56133C19910CFEE0@VI1PR05MB6303.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 0068C7E410
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39860400002)(396003)(366004)(199004)(189003)(52116002)(9686003)(25786009)(6916009)(5660300002)(2351001)(53936002)(2906002)(99286004)(305945005)(3846002)(6512007)(478600001)(14454004)(5640700003)(66066001)(2501003)(66946007)(1076003)(73956011)(6116002)(66476007)(64756008)(66556008)(7736002)(81166006)(186003)(8936002)(26005)(81156014)(33656002)(36756003)(66446008)(68736007)(476003)(486006)(316002)(6486002)(8676002)(6506007)(102836004)(386003)(86362001)(256004)(71200400001)(6436002)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6303;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7sgMiZk+r8Z+FzqpoS2O/NO6PQwJwYunjgWztxRMRRZs93bgewq3N82+LrkP21BzGcEF+Rh9h1gT3HxnwIqBymZu4n2fiOFnsEob616Ou1H83Cbkg5c8Ys+sIZSWLFDjKxzGYcHExFQBj4dI5ywrHgFEMmAYWaIjg12oWqoEvB9Wsz1YiCnG0Zxqk6xrvua3YfpEu2A3iNkw9xIUtUVPgS/CUUEZKAoDtEzAZnCn14r0dxHXmeHaVtPfo6Cdkoabcp0zSVghbeR3NFYFq+dXNPd8Myc/NK5K7FdB4y7ixYC2bLi4lJE+xfBqobPAdVSUG92+c+gjonMM7FcjX8T1WkYzuW+1vi3GPv4t6XgB8otLQFdbyp7OtMlihuPfatPp24dYrp8ZSDkcLcPYzB46VlSNbeb1nh9PLqW3SWrps14=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9AFC2B8AC02E9741BB89BAF22A0EB2FB@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69c89855-5b63-4f03-8b43-08d6f05d2dcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2019 00:13:51.2852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6303
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Discovered this was available already.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/core/uverbs_cmd.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core=
/uverbs_cmd.c
index 5a3a1780ceea4d..059015c4515944 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -3703,9 +3703,6 @@ static int ib_uverbs_ex_modify_cq(struct uverbs_attr_=
bundle *attrs)
  * trailing driver_data flex array. In this case the size of the base stru=
ct
  * cannot be changed.
  */
-#define offsetof_after(_struct, _member)                                  =
     \
-	(offsetof(_struct, _member) + sizeof(((_struct *)NULL)->_member))
-
 #define UAPI_DEF_WRITE_IO(req, resp)                                      =
     \
 	.write.has_resp =3D 1 +                                                  =
\
 			  BUILD_BUG_ON_ZERO(offsetof(req, response) !=3D 0) +    \
@@ -3736,11 +3733,11 @@ static int ib_uverbs_ex_modify_cq(struct uverbs_att=
r_bundle *attrs)
  */
 #define UAPI_DEF_WRITE_IO_EX(req, req_last_member, resp, resp_last_member)=
     \
 	.write.has_resp =3D 1,                                                   =
\
-	.write.req_size =3D offsetof_after(req, req_last_member),                =
\
-	.write.resp_size =3D offsetof_after(resp, resp_last_member)
+	.write.req_size =3D offsetofend(req, req_last_member),                   =
\
+	.write.resp_size =3D offsetofend(resp, resp_last_member)
=20
 #define UAPI_DEF_WRITE_I_EX(req, req_last_member)                         =
     \
-	.write.req_size =3D offsetof_after(req, req_last_member)
+	.write.req_size =3D offsetofend(req, req_last_member)
=20
 const struct uapi_definition uverbs_def_write_intf[] =3D {
 	DECLARE_UVERBS_OBJECT(
--=20
2.21.0

