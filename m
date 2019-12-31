Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6902C12D74B
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Dec 2019 10:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbfLaJTc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 31 Dec 2019 04:19:32 -0500
Received: from mail-eopbgr00084.outbound.protection.outlook.com ([40.107.0.84]:29969
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725770AbfLaJTc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 31 Dec 2019 04:19:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EVW14xLvKF8ZHllU3sK/vj80L59RkgjGY5FjSazlUu35XjsyQwQ7KX3A8Hjk7bqKebj7TOcKXC1Ldk/FtwdZX6y61AUY4Tbq3DfYkAC8QfmeTHZEhJgipOL50viuvvFvgIjcxXAfwBPK3duQlYlPkOc6mLiyi+Ucni8rBLQUvjQcOwo5gLFGxcmjIHVYgshfxMVWVPxOAlc9C2gFQ6hFQUzvTkhYvtecGl5H+L9IH8jS/cTj64Vxs4rwn5bUYzKKf1KdKaJN5xBFruc6OVEwYza1OyyRRlagQ/sIBsREMicnnbF6wFH4j0WhT2Wrfiq7v1QWkvESqzE5ix39trt6hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFPF/+OHuqYEXNhiR50T2dFbCGfy8lxMpiogq5dy4Dc=;
 b=VJAq41aKepn3LA9DhuwB3i4XtfYymTOCR1Hem8EnGPVedHq0j8NwYL8yFyYTi3gWFyQn9QG75g/JMq9fTLTG2zQA8U+lmaaYj7PYXyLA106GfG5gxhsFfVnvEWIni2DTrSQzpQ74ZPm+ICKZLEMcxkNx9baz3oBIziMTR7MBHzxO7CMkc8wB10Iipz4Ghr7UDvE1h+ASmXeY3ps6VC9NVSltj9MA6R/03WoRVQIjG/aD+xsWXVHy0sX/HcI6IWT3Vn1jPADlRfMURovKE3fRAnIbmGBWqEFF43V/vDh6gPYZDvLMgZAse+WE5mMmLFMT7BjXteE9Y0EoeKGxyItp6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFPF/+OHuqYEXNhiR50T2dFbCGfy8lxMpiogq5dy4Dc=;
 b=dbrLe5bvkd+GxtqOWjALv7hkRQOdiFtFdojO2SEfZbzs7lephfuWuMoGyVKwRUJxX/LGRk15KZNmFuXJV0ilZUixQVNIk3Bxkch3QaEx7n2oLIbzyN9VjDGLt92P4XIgT/ZDZ4Vq0Kmg6GTKICjCBqIzRZAPsiRvuc8nvFEU5tc=
Received: from VI1PR0502MB3006.eurprd05.prod.outlook.com (10.175.21.136) by
 VI1PR0502MB3742.eurprd05.prod.outlook.com (52.134.1.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.10; Tue, 31 Dec 2019 09:19:27 +0000
Received: from VI1PR0502MB3006.eurprd05.prod.outlook.com
 ([fe80::b9ec:a465:4659:7427]) by VI1PR0502MB3006.eurprd05.prod.outlook.com
 ([fe80::b9ec:a465:4659:7427%5]) with mapi id 15.20.2581.013; Tue, 31 Dec 2019
 09:19:27 +0000
Received: from reg-l-vrt-059-007.mtl.labs.mlnx (94.188.199.18) by AM0PR0102CA0016.eurprd01.prod.exchangelabs.com (2603:10a6:208:14::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11 via Frontend Transport; Tue, 31 Dec 2019 09:19:26 +0000
From:   Noa Osherovich <noaos@mellanox.com>
To:     "dledford@redhat.com" <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Noa Osherovich <noaos@mellanox.com>,
        Ahmad Ghazawi <ahmadg@mellanox.com>,
        Edward Srouji <edwards@mellanox.com>
Subject: [PATCH rdma-core 1/8] pyverbs: Add support for memory window
Thread-Topic: [PATCH rdma-core 1/8] pyverbs: Add support for memory window
Thread-Index: AQHVv7tmn2YCFkle0UW8WitzMlXreA==
Date:   Tue, 31 Dec 2019 09:19:27 +0000
Message-ID: <20191231091915.23874-2-noaos@mellanox.com>
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
x-ms-office365-filtering-correlation-id: 8b591b5c-dc79-46c3-6cff-08d78dd28881
x-ms-traffictypediagnostic: VI1PR0502MB3742:|VI1PR0502MB3742:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB3742859844FEB09FD26255E9D9260@VI1PR0502MB3742.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-forefront-prvs: 0268246AE7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(199004)(189003)(54906003)(1076003)(316002)(107886003)(36756003)(6636002)(2616005)(956004)(110136005)(478600001)(52116002)(71200400001)(66476007)(4326008)(66946007)(81156014)(81166006)(6506007)(64756008)(86362001)(5660300002)(2906002)(8676002)(186003)(66446008)(8936002)(6486002)(66556008)(16526019)(26005)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0502MB3742;H:VI1PR0502MB3006.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C8xahsOiNO17lCiR7Fsdgfa9zLvT0jWmwjQK1ijHb/DkEnEvYiH+F9pbpfx7c0bjbCWg+C3sNW/wVT8Zr3849bIK6eF93of6ToLStSFLe6WCvNHDAVQR2B7AAWobTbs86ez/BTZLpgrHc9dsSW4v4cReCjEahevPTpBHhYHkJAY/YwBQqcf51O8luGlJkJQWQmes5Iqh7mMw+/0KE2CEA7pRJifv/MJHFUK/zFEXbwGm4FDqCvZC+K30zobxFAZk7rYg40An0J/vRNoyDKkCz2V1MLgxEE6XCzNWGxxm11Jwvu47xaqi2xpUBC6VFzSOi/HAbgiByv3IGmMHXsSs5QQ8CCLTneOLvK7BfjhtjmNv5umfKmD2memNB69HYlx9yjT/c9R+P7vB6mlhb5lk59bZzPMyLIJk+ml/ZcYYiI4FLDENqt/Xpmrr2izkhAdm
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b591b5c-dc79-46c3-6cff-08d78dd28881
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Dec 2019 09:19:27.1805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z0ct9m/vL39m/6BxC8a74JYTFr5chE/e4NLnYu4lJtGHitoy9WWQqZPNJ8punNW7ds/0voTg6E2NgOPlrchd0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3742
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In order to use memory window, some additions were needed:
- Allow pyverbs users to create MWBindInfo, the Python representation
  of ibv_mw_bind_info.
- Expose ibv_inc_rkey, which creates a new rkey from a given one by
  increasing its 8 LSBs while keeping the same index.
- Expose the memory window's rkey and handle properties.

Signed-off-by: Ahmad Ghazawi <ahmadg@mellanox.com>
Signed-off-by: Noa Osherovich <noaos@mellanox.com>
Reviewed-by: Edward Srouji <edwards@mellanox.com>
---
 pyverbs/base.pyx       |  8 +++++++-
 pyverbs/libibverbs.pxd |  1 +
 pyverbs/mr.pxd         |  6 ++++++
 pyverbs/mr.pyx         | 19 +++++++++++++++++++
 4 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/pyverbs/base.pyx b/pyverbs/base.pyx
index c5b16795ddb6..790ba4153dea 100644
--- a/pyverbs/base.pyx
+++ b/pyverbs/base.pyx
@@ -1,9 +1,15 @@
 # SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
 # Copyright (c) 2019, Mellanox Technologies. All rights reserved.
=20
+from libc.errno cimport errno
 import logging
+
 from pyverbs.pyverbs_error import PyverbsRDMAError
-from libc.errno cimport errno
+cimport pyverbs.libibverbs as v
+
+
+def inc_rkey(rkey):
+    return v.ibv_inc_rkey(rkey)
=20
=20
 cpdef PyverbsRDMAErrno(str msg):
diff --git a/pyverbs/libibverbs.pxd b/pyverbs/libibverbs.pxd
index ad8d8bacc541..fea8a1b408da 100755
--- a/pyverbs/libibverbs.pxd
+++ b/pyverbs/libibverbs.pxd
@@ -551,3 +551,4 @@ cdef extern from 'infiniband/verbs.h':
                           ibv_recv_wr **bad_recv_wr)
     ibv_pd *ibv_alloc_parent_domain(ibv_context *context,
                                     ibv_parent_domain_init_attr *attr)
+    uint32_t ibv_inc_rkey(uint32_t rkey)
diff --git a/pyverbs/mr.pxd b/pyverbs/mr.pxd
index fb46611e6f42..402df4492425 100644
--- a/pyverbs/mr.pxd
+++ b/pyverbs/mr.pxd
@@ -12,6 +12,12 @@ cdef class MR(PyverbsCM):
     cdef v.ibv_mr *mr
     cdef void *buf
     cpdef read(self, length, offset)
+    cdef add_ref(self, obj)
+    cdef object bind_infos
+
+cdef class MWBindInfo(PyverbsCM):
+    cdef v.ibv_mw_bind_info info
+    cdef object mr
=20
 cdef class MW(PyverbsCM):
     cdef object pd
diff --git a/pyverbs/mr.pyx b/pyverbs/mr.pyx
index 6b28c8173ef8..9b1277f0882f 100644
--- a/pyverbs/mr.pyx
+++ b/pyverbs/mr.pyx
@@ -3,10 +3,12 @@
=20
 import resource
 import logging
+import weakref
=20
 from pyverbs.pyverbs_error import PyverbsRDMAError, PyverbsError
 from pyverbs.base import PyverbsRDMAErrno
 from posix.stdlib cimport posix_memalign
+from pyverbs.base cimport close_weakrefs
 from libc.string cimport memcpy, memset
 from libc.stdint cimport uintptr_t
 from pyverbs.device cimport DM
@@ -29,6 +31,7 @@ cdef class MR(PyverbsCM):
         :return: The newly created MR on success
         """
         super().__init__()
+        self.bind_infos =3D weakref.WeakSet()
         if self.mr !=3D NULL:
             return
         #We want to enable registering an MR of size 0 but this fails with=
 a
@@ -61,6 +64,7 @@ cdef class MR(PyverbsCM):
         :return: None
         """
         self.logger.debug('Closing MR')
+        close_weakrefs([self.bind_infos])
         if self.mr !=3D NULL:
             rc =3D v.ibv_dereg_mr(self.mr)
             if rc !=3D 0:
@@ -96,6 +100,10 @@ cdef class MR(PyverbsCM):
         data =3D <char*>(self.buf + off)
         return data[:length]
=20
+    cdef add_ref(self, obj):
+        if isinstance(obj, MWBindInfo):
+            self.bind_infos.add(obj)
+
     @property
     def buf(self):
         return <uintptr_t>self.buf
@@ -109,6 +117,17 @@ cdef class MR(PyverbsCM):
         return self.mr.rkey
=20
=20
+cdef class MWBindInfo(PyverbsCM):
+    def __init__(self, MR mr not None, addr, length, mw_access_flags):
+        super().__init__()
+        self.mr =3D mr
+        self.info.mr =3D mr.mr
+        self.info.addr =3D addr
+        self.info.length =3D length
+        self.info.mw_access_flags =3D mw_access_flags
+        mr.add_ref(self)
+
+
 cdef class MW(PyverbsCM):
     def __init__(self, PD pd not None, v.ibv_mw_type mw_type):
         """
--=20
2.21.0

