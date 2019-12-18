Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFF9124785
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Dec 2019 14:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfLRNCg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Dec 2019 08:02:36 -0500
Received: from mail-eopbgr30089.outbound.protection.outlook.com ([40.107.3.89]:39813
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726723AbfLRNCg (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 18 Dec 2019 08:02:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZZ72V7ZlnB1TtdWfezyV31YVQ5PuQbwjyhgOy5L3RptUhfI9NKOMDQC3GwRol16YnYAK3X6HWA7w+dcsSulRTLMWj5qfF10LZRZ973OktOSWFWLfobfBPAM0sSbE/gpawBiay+zMeJ6UuVN7x+nlXF0wCWvtPJZjyEM3NEbRY3giWiaARZC5GOctN5HQl/4fM2k0ZVtx5pi2Vi5/E1vExcazaDjVdUh3I/75jkxkThzOuFcpr4DJ8ju2MMpk6dt6O4O5XSQsD62jS3S3SRy4VX7llkZSKY0sPpPCfCPa2RBIEiYMs56jbU2ruWzorGiSl6EirvG+8p5w+irmpz1Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g48Dua4AAFz6oqOM0TFX9iO8B7JeUSjFgPeMhKm1JOY=;
 b=JRtfvXsfyL0iaq1ylUjqpDQIMRIkX84dMfLXesNi8s19OVx9GvGffbMF45wof0UFWznkW9DM8J4OrE2szrqm1Y4+O1FF6PzsjLvbpw70k0OPkXHu+bpDo9jtfGnKgozHF+nGAMWThHIxV3ODTT416MypY962uIdZEGrnb0BZPKbUO+uL33wBWWI1it9hst/YGnDCVkfYRQ9OSB7IPiKUZUBofXKvoBkUzey4vBqq+s2EinZAi2YEK8JBuS2iTT/5/POWkrx4n1vPSWFA1RShNL2BgSXS99xAX091vXVe81RWIGxif4G13kditSc3hi7fzve+8DSHKrd70CZpt+5Mkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g48Dua4AAFz6oqOM0TFX9iO8B7JeUSjFgPeMhKm1JOY=;
 b=g/q/gHswtGC4/+adlj7Fvtxl4ELWWaUTVFzU6zJC6VnzD1MJafCv/b9Xgdvh/4sjSGqa5ohgjqQDbgvyGCrPWkDSEXSEgP1ki+DzMxiyXIGm2uMhlvYTesdsYHSvj/f+1ssUu8YGG22Go9Rad7OX3nHYPn11kByeq0RyPS+GHWQ=
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com (20.177.33.17) by
 AM6PR05MB5093.eurprd05.prod.outlook.com (20.177.35.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.20; Wed, 18 Dec 2019 13:02:29 +0000
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::bc8c:12ca:edd3:92ca]) by AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::bc8c:12ca:edd3:92ca%4]) with mapi id 15.20.2538.019; Wed, 18 Dec 2019
 13:02:29 +0000
From:   Noa Osherovich <noaos@mellanox.com>
To:     "dledford@redhat.com" <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Noa Osherovich <noaos@mellanox.com>,
        Edward Srouji <edwards@mellanox.com>
Subject: [PATCH rdma-core 1/3] pyverbs: Move close_weakrefs() out of the base
 object
Thread-Topic: [PATCH rdma-core 1/3] pyverbs: Move close_weakrefs() out of the
 base object
Thread-Index: AQHVtaNnC4QwGv1I4UyJa9/HDBVqAg==
Date:   Wed, 18 Dec 2019 13:02:29 +0000
Message-ID: <20191218130216.503-2-noaos@mellanox.com>
References: <20191218130216.503-1-noaos@mellanox.com>
In-Reply-To: <20191218130216.503-1-noaos@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: ZR0P278CA0009.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::19) To AM6PR05MB4968.eurprd05.prod.outlook.com
 (2603:10a6:20b:4::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=noaos@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.188.199.18]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 48b5d9bf-b358-44e7-a213-08d783ba899b
x-ms-traffictypediagnostic: AM6PR05MB5093:|AM6PR05MB5093:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR05MB50939A21BC9C32D670CA59EBD9530@AM6PR05MB5093.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(199004)(189003)(86362001)(1076003)(316002)(6486002)(478600001)(6506007)(5660300002)(66446008)(64756008)(66556008)(66946007)(186003)(6636002)(2906002)(26005)(81166006)(107886003)(8676002)(81156014)(52116002)(66476007)(71200400001)(6512007)(54906003)(36756003)(2616005)(110136005)(4326008)(8936002)(6606295002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB5093;H:AM6PR05MB4968.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6pTHVMHFxrz3HGvez40UeNA8+zj0jGdfU+CgINMur9+BJv8P3BDk06XDEWGE7auuk6Xv/Zpa56/YbRXqp7Pi+Eonyzn3eW8wEi4HcdekOsVH5G3Ix2qRrsU0UU+B/+vzzVHUyHpT2EJD8hSoFmYmNMZFcAr3smcd1nSOC248o+rQpU4bcPlqlJ+gcr/a/AgRf9ifooEcskeAkU2sejvJvlId8M4Ay4zgCde9yuPb5DclSPv/F5AzD31OtEKUMqFWuaA5y2axJIfiwDzo3YYSbcVK8t+nw3f5dF8NHnSmU4W4st+oUaFYTasZkh4otpKWtlJNr+t6atsGoJxOFKYSYO2Iw0uNz6u4xsYUuiKla2xvK9yNp5T7RGiMty9tJSBzdrdnb02Pw/RJbZ3WyIxOP6wwo05sBVO2w3vMtbHZ6rJ7kOkJxuYz6oc+T6LIryR3gYwimszU3cJqgV+nEgPjBo5wDg/hFHV8abjxqHyzAZUSweNVlyalQ7tE8714YZRQ
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b5d9bf-b358-44e7-a213-08d783ba899b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 13:02:29.4287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8QHi1d+WfbIYpsJ2ZNzmqvRqHWDTVQI2padjpg8+WlrtSFaSMhbehe2Hy0vPCW8UPIGRk2H2t2MfDJd+hwJ2sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5093
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

close_weakrefs() is called during __dealloc__(). During that time, the
object might be partially destroyed. Since close_weakrefs() doesn't use
'self', there's no prevention to move it outside of the object.

Signed-off-by: Noa Osherovich <noaos@mellanox.com>
Reviewed-by: Edward Srouji <edwards@mellanox.com>
---
 pyverbs/base.pxd   |  2 ++
 pyverbs/base.pyx   | 46 ++++++++++++++++++++++++----------------------
 pyverbs/cq.pyx     |  7 ++++---
 pyverbs/device.pyx |  7 ++++---
 pyverbs/pd.pyx     |  5 +++--
 pyverbs/xrcd.pyx   |  3 ++-
 6 files changed, 39 insertions(+), 31 deletions(-)

diff --git a/pyverbs/base.pxd b/pyverbs/base.pxd
index e85f7c020e1c..efa63236810c 100644
--- a/pyverbs/base.pxd
+++ b/pyverbs/base.pxd
@@ -9,3 +9,5 @@ cdef class PyverbsObject(object):
=20
 cdef class PyverbsCM(PyverbsObject):
     cpdef close(self)
+
+cdef close_weakrefs(iterables)
diff --git a/pyverbs/base.pyx b/pyverbs/base.pyx
index 8b3e6741ae19..d69516285ece 100644
--- a/pyverbs/base.pyx
+++ b/pyverbs/base.pyx
@@ -12,6 +12,30 @@ LOG_LEVEL=3Dlogging.INFO
 LOG_FORMAT=3D'[%(levelname)s] %(asctime)s %(filename)s:%(lineno)s: %(messa=
ge)s'
 logging.basicConfig(format=3DLOG_FORMAT, level=3DLOG_LEVEL, datefmt=3D'%d =
%b %Y %H:%M:%S')
=20
+
+cdef close_weakrefs(iterables):
+    """
+    For each iterable element of iterables, pop each element and
+    call its close() method. This method is used when an object is being
+    closed while other objects still hold C references to it; the object
+    holds weakrefs to such other object, and closes them before trying to
+    teardown the C resources.
+    :param iterables: an array of WeakSets
+    :return: None
+    """
+    # None elements can be present if an object's close() was called more
+    # than once (e.g. GC and by another object)
+    for it in iterables:
+        if it is None:
+            continue
+        while True:
+            try:
+                tmp =3D it.pop()
+                tmp.close()
+            except KeyError: # popping an empty set
+                break
+
+
 cdef class PyverbsObject(object):
=20
     def __cinit__(self):
@@ -20,28 +44,6 @@ cdef class PyverbsObject(object):
     def set_log_level(self, val):
         self.logger.setLevel(val)
=20
-    def close_weakrefs(self, iterables):
-        """
-        For each iterable element of iterables, pop each element and
-        call its close() method. This method is used when an object is bei=
ng
-        closed while other objects still hold C references to it; the obje=
ct
-        holds weakrefs to such other object, and closes them before trying=
 to
-        teardown the C resources.
-        :param iterables: an array of WeakSets
-        :return: None
-        """
-        # None elements can be present if an object's close() was called m=
ore
-        # than once (e.g. GC and by another object)
-        for it in iterables:
-            if it is None:
-                continue
-            while True:
-                try:
-                    tmp =3D it.pop()
-                    tmp.close()
-                except KeyError: # popping an empty set
-                    break
-
=20
 cdef class PyverbsCM(PyverbsObject):
     """
diff --git a/pyverbs/cq.pyx b/pyverbs/cq.pyx
index ac6baa618c3d..1ea443fc6966 100755
--- a/pyverbs/cq.pyx
+++ b/pyverbs/cq.pyx
@@ -4,6 +4,7 @@ import weakref
=20
 from pyverbs.pyverbs_error import PyverbsError
 from pyverbs.base import PyverbsRDMAErrno
+from pyverbs.base cimport close_weakrefs
 cimport pyverbs.libibverbs_enums as e
 from pyverbs.device cimport Context
 from pyverbs.srq cimport SRQ
@@ -35,7 +36,7 @@ cdef class CompChannel(PyverbsCM):
=20
     cpdef close(self):
         self.logger.debug('Closing completion channel')
-        self.close_weakrefs([self.cqs])
+        close_weakrefs([self.cqs])
         if self.cc !=3D NULL:
             rc =3D v.ibv_destroy_comp_channel(self.cc)
             if rc !=3D 0:
@@ -108,7 +109,7 @@ cdef class CQ(PyverbsCM):
=20
     cpdef close(self):
         self.logger.debug('Closing CQ')
-        self.close_weakrefs([self.qps, self.srqs])
+        close_weakrefs([self.qps, self.srqs])
         if self.cq !=3D NULL:
             rc =3D v.ibv_destroy_cq(self.cq)
             if rc !=3D 0:
@@ -292,7 +293,7 @@ cdef class CQEX(PyverbsCM):
=20
     cpdef close(self):
         self.logger.debug('Closing CQEx')
-        self.close_weakrefs([self.srqs, self.qps])
+        close_weakrefs([self.srqs, self.qps])
         if self.cq !=3D NULL:
             rc =3D v.ibv_destroy_cq(<v.ibv_cq*>self.cq)
             if rc !=3D 0:
diff --git a/pyverbs/device.pyx b/pyverbs/device.pyx
index 33d133fd24da..56d7540ceb6c 100755
--- a/pyverbs/device.pyx
+++ b/pyverbs/device.pyx
@@ -12,6 +12,7 @@ from .pyverbs_error import PyverbsRDMAError, PyverbsError
 from pyverbs.cq cimport CQEX, CQ, CompChannel
 from .pyverbs_error import PyverbsUserError
 from pyverbs.base import PyverbsRDMAErrno
+from pyverbs.base cimport close_weakrefs
 cimport pyverbs.libibverbs_enums as e
 cimport pyverbs.libibverbs as v
 from pyverbs.cmid cimport CMID
@@ -144,8 +145,8 @@ cdef class Context(PyverbsCM):
=20
     cpdef close(self):
         self.logger.debug('Closing Context')
-        self.close_weakrefs([self.qps, self.ccs, self.cqs, self.dms, self.=
pds,
-                             self.xrcds])
+        close_weakrefs([self.qps, self.ccs, self.cqs, self.dms, self.pds,
+                        self.xrcds])
         if self.context !=3D NULL:
             rc =3D v.ibv_close_device(self.context)
             if rc !=3D 0:
@@ -647,7 +648,7 @@ cdef class DM(PyverbsCM):
=20
     cpdef close(self):
         self.logger.debug('Closing DM')
-        self.close_weakrefs([self.dm_mrs])
+        close_weakrefs([self.dm_mrs])
         if self.dm !=3D NULL:
             rc =3D v.ibv_free_dm(self.dm)
             if rc !=3D 0:
diff --git a/pyverbs/pd.pyx b/pyverbs/pd.pyx
index 4a33587b7df0..8c17ffcba7e8 100755
--- a/pyverbs/pd.pyx
+++ b/pyverbs/pd.pyx
@@ -4,6 +4,7 @@ import weakref
=20
 from pyverbs.pyverbs_error import PyverbsUserError, PyverbsError
 from pyverbs.base import PyverbsRDMAErrno
+from pyverbs.base cimport close_weakrefs
 from pyverbs.device cimport Context
 from libc.stdint cimport uintptr_t
 from pyverbs.cmid cimport CMID
@@ -65,8 +66,8 @@ cdef class PD(PyverbsCM):
         :return: None
         """
         self.logger.debug('Closing PD')
-        self.close_weakrefs([self.parent_domains, self.qps, self.ahs, self=
.mws,
-                             self.mrs, self.srqs])
+        close_weakrefs([self.parent_domains, self.qps, self.ahs, self.mws,
+                        self.mrs, self.srqs])
         if self.pd !=3D NULL:
             rc =3D v.ibv_dealloc_pd(self.pd)
             if rc !=3D 0:
diff --git a/pyverbs/xrcd.pyx b/pyverbs/xrcd.pyx
index 70b0c9adbbaa..91303daf3bc0 100755
--- a/pyverbs/xrcd.pyx
+++ b/pyverbs/xrcd.pyx
@@ -4,6 +4,7 @@ import weakref
=20
 from pyverbs.pyverbs_error import PyverbsRDMAError, PyverbsError
 from pyverbs.base import PyverbsRDMAErrno
+from pyverbs.base cimport close_weakrefs
 from pyverbs.device cimport Context
 from pyverbs.srq cimport SRQ
 from pyverbs.qp cimport QP
@@ -68,7 +69,7 @@ cdef class XRCD(PyverbsCM):
         :return: None
         """
         self.logger.debug('Closing XRCD')
-        self.close_weakrefs([self.qps, self.srqs])
+        close_weakrefs([self.qps, self.srqs])
         # XRCD may be deleted directly or indirectly by closing its contex=
t,
         # which leaves the Python XRCD object without the underlying C obj=
ect,
         # so during destruction, need to check whether or not the C object
--=20
2.21.0

