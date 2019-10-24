Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F611E2A33
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2019 08:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437661AbfJXGAw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Oct 2019 02:00:52 -0400
Received: from mail-eopbgr50068.outbound.protection.outlook.com ([40.107.5.68]:21413
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2437663AbfJXGAv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 24 Oct 2019 02:00:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hK9yWNh1gDYC29oHyp8kKgaayNZW6bZ2FyWhzByKlLbNkf8fxpgkIqIiN3fof3Gk5BrJRHdzixkjnbeQyk9pu//SqQ7Wz0ErjNeji3o3rhIUbjcd1AUBRpEhpwYgt9VEs+tn2N3GiOpOP/+NpHdkaIBo5WjzWgLPROGS+Ft2TRjj0fp4AnogHGgZc5k/FSCcbfHEu/6Ap/kG+l1EwTmGNJ17wPI6qR7WqfRVeppCiDab1s5PJbf0G8r73jJoNKHIRC1jyaVnzKC2VitRp/QzpkhzKPEzRcuKvFvPTWZsaZjlVYjNMKuHWBJN2YbGQgj0DK+7ff9UUYWPm1GbrXF9MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMzC2j8w0nMWxoSUxWSkRNp7TbYN6wWoeK7RW+TdxvA=;
 b=haorfkDigvphUD2jywPCXVhYo90Wj6vmi5KBAHsyarDK2eeE+cYDlcJ1ItcaDSj0vE5e8gYN6A93sVkNanB7wQQRzsHN86u1icgaJ3XU+4uFGOC9HQX7u1alvm2lFzBQH2Ze3+aJ3iBopY5ZTKosuI/jwdkQVJJHFV91QTZ1nWVRW0V9o8AVAN7tGrEK3n/y9E9LCfWu3zUxOt7lrvpGPPCnaNIO8KHMSzrcyzgIbJEdUC2j8eCmbxyaPWfHpZuVz68TviWVGvquzgZuM657bBSvB9LgTjlr3jBi8gotiqNvOAJ0tTemRj/yJTdDMTN+ROsFB+/+v6/SXgI8aQJm/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMzC2j8w0nMWxoSUxWSkRNp7TbYN6wWoeK7RW+TdxvA=;
 b=quwuPs78dDtsnx4Z9hOtZnC6hMwrJ+n9D5qaZG//qWrhkT3aqfrz2uFwlDYMT01Bqv6l3pzlPRI2pQBqVfJrjXnD/hhvzqcahNRwgdjUDlf4C3IkXIOxnNZqNZeu6gv/bvYo9z+3UZEDCohqRLqGubHGIjSHbHz5DPrYWKbc6TE=
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com (20.177.33.17) by
 AM6PR05MB4182.eurprd05.prod.outlook.com (52.135.164.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Thu, 24 Oct 2019 06:00:47 +0000
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::ecbd:11b3:e4e9:fa1a]) by AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::ecbd:11b3:e4e9:fa1a%5]) with mapi id 15.20.2347.029; Thu, 24 Oct 2019
 06:00:47 +0000
From:   Noa Osherovich <noaos@mellanox.com>
To:     "dledford@redhat.com" <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Noa Osherovich <noaos@mellanox.com>
Subject: [PATCH rdma-core 1/4] pyverbs: Add support for providers' context
Thread-Topic: [PATCH rdma-core 1/4] pyverbs: Add support for providers'
 context
Thread-Index: AQHVijBh7O5I5ByACUyBUhUUPcx13g==
Date:   Thu, 24 Oct 2019 06:00:47 +0000
Message-ID: <20191024060027.8696-2-noaos@mellanox.com>
References: <20191024060027.8696-1-noaos@mellanox.com>
In-Reply-To: <20191024060027.8696-1-noaos@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: AM0PR05CA0081.eurprd05.prod.outlook.com
 (2603:10a6:208:136::21) To AM6PR05MB4968.eurprd05.prod.outlook.com
 (2603:10a6:20b:4::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=noaos@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.188.199.18]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 34f912d1-d275-44c6-1a94-08d758478388
x-ms-traffictypediagnostic: AM6PR05MB4182:|AM6PR05MB4182:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR05MB4182335333FF49DD2542350AD96A0@AM6PR05MB4182.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(199004)(189003)(478600001)(71200400001)(86362001)(486006)(71190400001)(2501003)(11346002)(2616005)(446003)(52116002)(476003)(4326008)(76176011)(110136005)(54906003)(66946007)(66476007)(66556008)(66446008)(64756008)(6636002)(14454004)(99286004)(107886003)(26005)(186003)(305945005)(7736002)(316002)(66066001)(6506007)(386003)(3846002)(36756003)(14444005)(256004)(102836004)(8936002)(50226002)(1076003)(6116002)(2906002)(81156014)(81166006)(6436002)(6512007)(6486002)(5660300002)(25786009)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB4182;H:AM6PR05MB4968.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4flK3L7Jh8oAMayaLHsAXERArxVqRNQ52OshnMi9+nP0XzZP7PlTZpBK8rM99cIIZXCF8l+h2DJSzuorIgp2zp6KSxSMbSqNkv+9mXXxcujhvMvyngCdDz+Ci9u/GLeh9opRmxOtBAQi234l4mJnNi2BIQgERvx2bgRRYE87hwIDbV+DunZdFfPHcK/DWgZwS3l8YCEgNQL7Bw6js10ITLEyI7qYoQw443deOIOnXSXUofFw1zPjVdvTxx7X9aM4IIJ1B0jZUCC+EUHEwN/Nj+gPVuOkptwrtYJ1JsN5tW4O3TViDN1a/YwY4TORQMCcGv8FVFT+u1HWx5RrCdkCt3CWGwIcaUxuQ+kyt0iDpZ/WntjSYOM74bWq3e8jKxSlx7fjkJ2RxAKDs2jDkAc8ahkaDjc2xgk85NUQW7mS4Bz5q0aw56aVQe3WRhSMiR/O
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34f912d1-d275-44c6-1a94-08d758478388
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 06:00:47.2239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ny93vdmwUkCvd9kEjtOTAkYNjNicN3/g4PRMm9oca12zFL9Cvh3s6Mj/kcOL3SaIVNPk67qBT4a+T+MW3okglA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4182
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Providers can supply an API for a driver-specific context, extending
ibv_context.
To allow the provider to open the device given provider-specific
attributes, Context class will only locate the right ibv_device but
will not open it, leaving the provider to open it in any way it finds
fit.

Signed-off-by: Noa Osherovich <noaos@mellanox.com>
---
 pyverbs/device.pxd |  1 +
 pyverbs/device.pyx | 17 +++++++++++++----
 pyverbs/qp.pyx     |  2 +-
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/pyverbs/device.pxd b/pyverbs/device.pxd
index 5cc13acb4331..a701a3deeabd 100755
--- a/pyverbs/device.pxd
+++ b/pyverbs/device.pxd
@@ -9,6 +9,7 @@ cimport pyverbs.libibverbs as v
=20
 cdef class Context(PyverbsCM):
     cdef v.ibv_context *context
+    cdef v.ibv_device *device
     cdef object name
     cdef add_ref(self, obj)
     cdef object pds
diff --git a/pyverbs/device.pyx b/pyverbs/device.pyx
index 084086bdbc69..58a2aca27fcc 100755
--- a/pyverbs/device.pyx
+++ b/pyverbs/device.pyx
@@ -78,9 +78,13 @@ cdef class Context(PyverbsCM):
         """
         Initializes a Context object. The function searches the IB devices=
 list
         for a device with the name provided by the user. If such a device =
is
-        found, it is opened.
-        :param kwargs: Currently supports 'name' argument only, the IB dev=
ice's
-                       name.
+        found, it is opened (unless provider attributes were given).
+        :param kwargs: Arguments:
+            * *name* (str)
+               The RDMA device's name
+            * *attr* (object)
+               Device-specific attributes, meaning that the device is to b=
e
+               opened by the provider
         :return: None
         """
         cdef int count
@@ -94,7 +98,7 @@ cdef class Context(PyverbsCM):
         self.xrcds =3D weakref.WeakSet()
=20
         dev_name =3D kwargs.get('name')
-
+        provider_attr =3D kwargs.get('attr')
         if dev_name is not None:
             self.name =3D dev_name
         else:
@@ -106,6 +110,11 @@ cdef class Context(PyverbsCM):
         try:
             for i in range(count):
                 if dev_list[i].name.decode() =3D=3D self.name:
+                    if provider_attr is not None:
+                        # A provider opens its own context, we're just
+                        # setting its IB device
+                        self.device =3D dev_list[i]
+                        return
                     self.context =3D v.ibv_open_device(dev_list[i])
                     if self.context =3D=3D NULL:
                         raise PyverbsRDMAErrno('Failed to open device {dev=
}'.
diff --git a/pyverbs/qp.pyx b/pyverbs/qp.pyx
index 961e0d59c589..9167e5f2bd01 100755
--- a/pyverbs/qp.pyx
+++ b/pyverbs/qp.pyx
@@ -812,7 +812,7 @@ cdef class QP(PyverbsCM):
         self.update_cqs(init_attr)
         # In order to use cdef'd methods, a proper casting must be done, l=
et's
         # infer the type.
-        if type(creator) =3D=3D Context:
+        if issubclass(type(creator), Context):
             self._create_qp_ex(creator, init_attr)
             ctx =3D <Context>creator
             self.context =3D ctx
--=20
2.21.0

