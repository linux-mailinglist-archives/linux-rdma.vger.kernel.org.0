Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3BB312D74C
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Dec 2019 10:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfLaJTf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 31 Dec 2019 04:19:35 -0500
Received: from mail-eopbgr00084.outbound.protection.outlook.com ([40.107.0.84]:29969
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725913AbfLaJTf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 31 Dec 2019 04:19:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+zgIbPLSwC2FyLwRUetwD/I3CVe+qDKRGsZnj8YxSyk0WzU8+XRnp2PmvjDV3+XVHEMAwQ8/jDaVXH/cimO/2rWOzP/wvPWz1WfQjBhlVoR8OCLuTPa2T6oH2R/K97RDmy9bDKRAO+JQUNqAI/7Uu9/z36bqto2c3lfOoJRiB9JlbIEPYtqjPATmuHsT/ZKK9g8EppfLlwcX4YjpBjCiZ5dLveThSdrvadGkcKX83cS8GpIu9ReiOr7Ne6HzwTwvR2ne31N9nuPCC0zZjr5+GvHy6kn/tBoRJmSGdfm9YL4WDsh1wG8uyHINtNmyGD0P1+d5WNFHRiP+ZPak973QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3whX9ucftG5Xnd6awRC/e6ZjEbmN/OmGdyeK2auodw=;
 b=XG34jxbbRMZoFav5WTP/6/I6WYL42vsvg0CDA4o0vRIBJNME2CQYQpTIztS0noVMeNiB/RMUsE1FfFXIJBeNivCobA7G/XgoZDyl71IuBm290IpqQX0aujkfdVhsPQ8KOypN4iKTotza6AlbDylOxOB/ImA8PCCozft0CFDINDhJVKAv6wDRegKyk5TcaBJvREc51o5YizBYZ+pUr1buj4CQbQieV8dL7UcT/mxcDhW4yA0aPT0nQNFuutxkR7hTpc5qXS9D6jXmOOtpwxY6LQqwIFzpUWU2lGc44+JNDR7JejeeIisu2riE6ZNxKDeyXXs3SdgPr+nbpwHGgacz7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3whX9ucftG5Xnd6awRC/e6ZjEbmN/OmGdyeK2auodw=;
 b=qd6Fm7YgXfOEzWYuYr9MjMEAKiqk08t4swBq8kMg2l7tlaiEA4irZa0otT5idT9JmQBeySiyfoCwIZ17VyiRCDya5zZnCoVKZkVO7HJn4PLDIQeBJg5BN0ZhxiHtJcsZtxOIMzltSetwdwGQY6TgLUApOTfASeSqJO1H2GOu+nA=
Received: from VI1PR0502MB3006.eurprd05.prod.outlook.com (10.175.21.136) by
 VI1PR0502MB3742.eurprd05.prod.outlook.com (52.134.1.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.10; Tue, 31 Dec 2019 09:19:28 +0000
Received: from VI1PR0502MB3006.eurprd05.prod.outlook.com
 ([fe80::b9ec:a465:4659:7427]) by VI1PR0502MB3006.eurprd05.prod.outlook.com
 ([fe80::b9ec:a465:4659:7427%5]) with mapi id 15.20.2581.013; Tue, 31 Dec 2019
 09:19:28 +0000
Received: from reg-l-vrt-059-007.mtl.labs.mlnx (94.188.199.18) by AM0PR0102CA0016.eurprd01.prod.exchangelabs.com (2603:10a6:208:14::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11 via Frontend Transport; Tue, 31 Dec 2019 09:19:27 +0000
From:   Noa Osherovich <noaos@mellanox.com>
To:     "dledford@redhat.com" <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Noa Osherovich <noaos@mellanox.com>,
        Ahmad Ghazawi <ahmadg@mellanox.com>,
        Edward Srouji <edwards@mellanox.com>
Subject: [PATCH rdma-core 2/8] pyverbs: Add TSO support
Thread-Topic: [PATCH rdma-core 2/8] pyverbs: Add TSO support
Thread-Index: AQHVv7tmpQaVDC8JoU2+hf84//wQxg==
Date:   Tue, 31 Dec 2019 09:19:28 +0000
Message-ID: <20191231091915.23874-3-noaos@mellanox.com>
References: <20191231091915.23874-1-noaos@mellanox.com>
In-Reply-To: <20191231091915.23874-1-noaos@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: AM0PR0102CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:14::29) To VI1PR0502MB3006.eurprd05.prod.outlook.com
 (2603:10a6:800:b2::8)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=noaos@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.188.199.18]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 87965adb-4a3b-4a80-ecab-08d78dd28936
x-ms-traffictypediagnostic: VI1PR0502MB3742:|VI1PR0502MB3742:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB37428E72311F54AB763C3F94D9260@VI1PR0502MB3742.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0268246AE7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(199004)(189003)(54906003)(1076003)(316002)(107886003)(36756003)(6636002)(2616005)(956004)(110136005)(478600001)(52116002)(71200400001)(66476007)(4326008)(66946007)(81156014)(81166006)(6506007)(64756008)(86362001)(5660300002)(2906002)(8676002)(186003)(66446008)(8936002)(6486002)(66556008)(16526019)(26005)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0502MB3742;H:VI1PR0502MB3006.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tQezGePAh3NQIc3rzAOAg8Glbrzk/hb7doxORtuWIN0haAednUL6SxnhJtxHRGHTvQqsDY90zfvOmYA2NTzq3lN4hwAHA6P00MKArdpJZIoaMr73h0aYSugcytPtsmRtkFeiB0c7ig9YDN071U9vd4NY0WEmuRVVGsUSnhnyUV5pe/cFF1d3VG4gwN2NqUFXwu+IXQO+vJFchcWm7ZY48NGHisbV3NYx4EF9Yk1OGqGpHm2yhPgMWqkyHi9Th/h9Cr86yuuz5j3i8js4Fu0mueGZofHurwY+But/L7YcK2MgYDOQeRaK4SUB48DIUwNVVuvkfFuUWp70ThuJmBvR9ZEysM/SZuDRkBESzhT2IqQOdMxK4eS8aUPt2+ETNXcyrdkM2A1/5Jgj5OqkmoBFMoBip3NyfYz+L7M7ndwRL7ykoJ5eK2QHCP0PIRISCwdy
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87965adb-4a3b-4a80-ecab-08d78dd28936
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Dec 2019 09:19:28.4049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 99NSu201FaHezyWRZPjFAPmQX++/+CESW0OXhY5KgfhsGjD2lbXhOzUWlUDdwe14A1RaJznr2D+NlskdC3TYtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3742
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add TSO class to allow users to easily set the TSO field in a send
work request.

Signed-off-by: Ahmad Ghazawi <ahmadg@mellanox.com>
Signed-off-by: Noa Osherovich <noaos@mellanox.com>
Reviewed-by: Edward Srouji <edwards@mellanox.com>
---
 pyverbs/libibverbs.pxd |  7 ++---
 pyverbs/wr.pxd         |  6 +++++
 pyverbs/wr.pyx         | 60 ++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 66 insertions(+), 7 deletions(-)

diff --git a/pyverbs/libibverbs.pxd b/pyverbs/libibverbs.pxd
index fea8a1b408da..8949759511a5 100755
--- a/pyverbs/libibverbs.pxd
+++ b/pyverbs/libibverbs.pxd
@@ -311,10 +311,6 @@ cdef extern from 'infiniband/verbs.h':
         unsigned short  hdr_sz
         unsigned short  mss
=20
-    cdef union unnamed:
-        bind_mw         bind_mw
-        tso             tso
-
     cdef struct xrc:
         unsigned int    remote_srqn
=20
@@ -330,7 +326,8 @@ cdef extern from 'infiniband/verbs.h':
         unsigned int    send_flags
         wr              wr
         qp_type         qp_type
-        unnamed         unnamed
+        bind_mw         bind_mw
+        tso             tso
=20
     cdef struct ibv_qp_cap:
         unsigned int    max_send_wr
diff --git a/pyverbs/wr.pxd b/pyverbs/wr.pxd
index e259249ef7f8..5cb282dc65c3 100644
--- a/pyverbs/wr.pxd
+++ b/pyverbs/wr.pxd
@@ -16,3 +16,9 @@ cdef class RecvWR(PyverbsCM):
=20
 cdef class SendWR(PyverbsCM):
     cdef v.ibv_send_wr send_wr
+
+cdef class TSO(PyverbsCM):
+    cdef void* buf
+    cdef int length
+    cdef int mss
+    cpdef alloc_buf(self, content, length)
diff --git a/pyverbs/wr.pyx b/pyverbs/wr.pyx
index 06186e9b0fd2..b1df3677fce3 100644
--- a/pyverbs/wr.pyx
+++ b/pyverbs/wr.pyx
@@ -1,12 +1,16 @@
 # SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
 # Copyright (c) 2019 Mellanox Technologies Inc. All rights reserved. See C=
OPYING file
=20
+import resource
+
+from cpython.pycapsule cimport PyCapsule_New
+from libc.stdlib cimport free, malloc
+from libc.string cimport memcpy
+
 from pyverbs.pyverbs_error import PyverbsUserError, PyverbsError
 from pyverbs.base import PyverbsRDMAErrno
 cimport pyverbs.libibverbs_enums as e
 from pyverbs.addr cimport AH
-from libc.stdlib cimport free, malloc
-from libc.string cimport memcpy
=20
=20
 cdef class SGE(PyverbsCM):
@@ -281,6 +285,58 @@ cdef class SendWR(PyverbsCM):
         """
         self.send_wr.qp_type.xrc.remote_srqn =3D remote_srqn
=20
+    def set_tso(self, TSO tso not None):
+        """
+        Set the members of the tso struct in the send_wr's anonymous union=
.
+        :param tso: A TSO object to copy to the work request
+        :return: None
+        """
+        self.send_wr.tso.hdr =3D tso.buf
+        self.send_wr.tso.hdr_sz =3D tso.length
+        self.send_wr.tso.mss =3D tso.mss
+
+
+cdef class TSO(PyverbsCM):
+    """ Represents the 'tso' anonymous struct inside a send WR """
+    def __init__(self, data, length, mss):
+        super().__init__()
+        self.alloc_buf(data, length)
+        self.length =3D length
+        self.mss =3D mss
+
+    cpdef alloc_buf(self, data, length):
+        if self.buf !=3D NULL:
+            free(self.buf)
+        self.buf =3D malloc(length)
+        if self.buf =3D=3D NULL:
+            raise PyverbsError('Failed to allocate TSO buffer of length {l=
}'.\
+                                format(l=3Dlength))
+        if isinstance(data, str):
+            data =3D data.encode()
+        memcpy(self.buf, <char*>data, length)
+        self.length =3D length
+
+    def __dealloc__(self):
+        self.close()
+
+    cpdef close(self):
+        if self.buf !=3D NULL:
+            free(self.buf)
+            self.buf =3D NULL
+
+    @property
+    def buf(self):
+        return PyCapsule_New(self.buf, NULL, NULL)
+
+    def __str__(self):
+        print_format =3D '{:22}: {:<20}\n'
+        data =3D <char*>(self.buf)
+        data =3D data[:self.length].decode()
+        return print_format.format('MSS', self.mss) +\
+               print_format.format('Length', self.length) +\
+               print_format.format('Data', data)
+
+
 def send_flags_to_str(flags):
     send_flags =3D {e.IBV_SEND_FENCE: 'IBV_SEND_FENCE',
                   e.IBV_SEND_SIGNALED: 'IBV_SEND_SIGNALED',
--=20
2.21.0

