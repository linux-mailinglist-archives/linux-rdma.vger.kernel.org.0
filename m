Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1630FC2B9
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2019 10:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbfKNJht (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Nov 2019 04:37:49 -0500
Received: from mail-eopbgr60075.outbound.protection.outlook.com ([40.107.6.75]:2435
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726369AbfKNJhs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 14 Nov 2019 04:37:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EKfyTxbjR5DUFIQx38VWhlMmaeE9GryhegVWwWya03KNwuop81k5aWTbfM71p2zSSa7S+GWF7LBk4eH9JmU67b/G8TDuAU4sgIm99D9SWfa+GKlYd3eRp3BeEZpaue9TEcqd7dvckpqV4l1ptaIjXh9ZK7VodI3S0UlRp+7I0lif4tMW0TqLYKH8lLy+s4mv5mP7N56xesJwntx3tl0gr4Xqo8tf5v2tgkB0TlK3z5+DHFUPGUKG1NepP+Dh267UQgYbKSTWURe/ULJJt6LbiU22EUzUVpI890W1RQ/7/amSN+yeB5O21o0fO/+WScB15zcLPuQt3ue624JuXiX8tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uh8f8Zcqs4J3O6aCT6xGR+/7ZkJb0QQ8r9gkn6/r8EU=;
 b=N7i7J5GfXor5QQ0I5yMDW//VmSiiipqivb1bfnKIC/dAPLeVbmY2wWtTb2N3wBXWO4885dbWy/HS26tKVBldIV6+Kba73sL9+mOi7zov3jvEC14YSwqsvkj1JlKt7/4w3d6z8SdXIdn//eNH5AMoWHnQOZk6ehhOD3uaPWajAncid0ozVRXcm9IGg+7LcCDLicwZXVa01oCwuKUqn1LnZqlC6+ZmSwqfvSABrBWDTsg2osyxdw/Yc3DjUmNQLm219XrJg3EpiOa9b5fntdeLWH+BxImbb//ewWnRoUF5MfTTrvlIY3rA5aeZ7cj2imD1TplzqZFvynO2yzMeUJynIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uh8f8Zcqs4J3O6aCT6xGR+/7ZkJb0QQ8r9gkn6/r8EU=;
 b=PDHmlfnxnwsZxkxYK7vfLn3UtC0QeFr3OlmXpqdejLHru9l6f8JIlFkYCgq0eq1b9xT8JWwEsTRGzp2bSS/7eVEMsi9rWk1K4qMRUsQpzpwU9xfGQTyKXbudwszNgrrkxAkRfKggdLXbcjRTBmh/ub7HrXlqwr3IEcyXBKWetiM=
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com (20.177.33.17) by
 AM6PR05MB6230.eurprd05.prod.outlook.com (20.178.95.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Thu, 14 Nov 2019 09:37:45 +0000
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::505f:e3f8:3f87:e3ff]) by AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::505f:e3f8:3f87:e3ff%7]) with mapi id 15.20.2430.028; Thu, 14 Nov 2019
 09:37:45 +0000
From:   Noa Osherovich <noaos@mellanox.com>
To:     "dledford@redhat.com" <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Edward Srouji <edwards@mellanox.com>,
        Daria Velikovsky <daria@mellanox.com>,
        Noa Osherovich <noaos@mellanox.com>
Subject: [PATCH rdma-core 1/4] pyverbs: Add memory allocation class
Thread-Topic: [PATCH rdma-core 1/4] pyverbs: Add memory allocation class
Thread-Index: AQHVms8rzs2wkDxYSUeydp5vKVoinQ==
Date:   Thu, 14 Nov 2019 09:37:45 +0000
Message-ID: <20191114093732.12637-2-noaos@mellanox.com>
References: <20191114093732.12637-1-noaos@mellanox.com>
In-Reply-To: <20191114093732.12637-1-noaos@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: AM0PR0402CA0012.eurprd04.prod.outlook.com
 (2603:10a6:208:15::25) To AM6PR05MB4968.eurprd05.prod.outlook.com
 (2603:10a6:20b:4::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=noaos@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.188.199.18]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4cb834d4-459c-4278-e480-08d768e64d70
x-ms-traffictypediagnostic: AM6PR05MB6230:|AM6PR05MB6230:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR05MB6230A3EB8F54A80D7A4B3D18D9710@AM6PR05MB6230.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 02213C82F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(199004)(189003)(3846002)(256004)(14444005)(71190400001)(6116002)(71200400001)(14454004)(2906002)(478600001)(81166006)(81156014)(50226002)(8676002)(8936002)(86362001)(66946007)(66476007)(66556008)(64756008)(66446008)(6512007)(4326008)(5660300002)(1076003)(6436002)(2501003)(107886003)(186003)(66066001)(476003)(446003)(2616005)(26005)(11346002)(6636002)(486006)(6486002)(36756003)(25786009)(110136005)(54906003)(316002)(305945005)(102836004)(386003)(52116002)(6506007)(7736002)(76176011)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB6230;H:AM6PR05MB4968.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XbNHoV0mCvmkGIddQ5hl62XBRssSSvdjnNnLjCc2e5SzZqcfgVDOqiTZrLkbGndkLe6+4L9JxmaQnTi8aftJxDhbBS5yA0NKGZzP3oF5Db7SCUeGS9y3ykmUdcbID4eRAxVKb6yICJlBVPe0LII1JVHWNtxf9rMhTlXaTharWsbnh/EHBCboR7YiwaesFAT7meNMnUYfte0Bo9IjZyB/buzaJXRSj2cYcEyfkftlLTdxN9d6a/txf0jkAhLyj3TSZwt7FUFW2KmGUKHbImegi6FapoFLnoP8hWgyxMnsoyJg+k17q/lSrh2YdhpFYvB2/gFB7P8yqlA4EPaTjohLngm9C6iHYa8QPt+5abnLxwIoBi6pPR7Pptt4PcPr1XN6GR84vfovbUM8h5etx8/OpS4DNkl7mDEzoIca9iUW1xFcK1BEiOPmCo1RcDEd3EV5
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb834d4-459c-4278-e480-08d768e64d70
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2019 09:37:45.3389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ew9QLxRzdyVIdsqXM/nrsTl1f6Bt+KMVLLDTlWDDi4tDz1BAveb1Oxzf5lBbaaxBJEfXzAdKUBa8o2+UiWEGBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6230
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Edward Srouji <edwards@mellanox.com>

Add new MemAlloc class which wraps some C memory allocation functions
such as aligned_alloc, malloc and free.
This allows Pyverbs' users to easily allocate and free memory in C
style, i.e when the memory address must be passed to a driver API.

Signed-off-by: Edward Srouji <edwards@mellanox.com>
Reviewd-by: Daria Velikovsky <daria@mellanox.com>
Reviewd-by: Noa Osherovich <noaos@mellanox.com>
---
 pyverbs/base.pxd |  3 +++
 pyverbs/base.pyx | 26 ++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/pyverbs/base.pxd b/pyverbs/base.pxd
index e85f7c020e1c..e956a79915ff 100644
--- a/pyverbs/base.pxd
+++ b/pyverbs/base.pxd
@@ -9,3 +9,6 @@ cdef class PyverbsObject(object):
=20
 cdef class PyverbsCM(PyverbsObject):
     cpdef close(self)
+
+cdef class MemAlloc(object):
+   pass
diff --git a/pyverbs/base.pyx b/pyverbs/base.pyx
index 8b3e6741ae19..a41cfc748ad0 100644
--- a/pyverbs/base.pyx
+++ b/pyverbs/base.pyx
@@ -3,8 +3,14 @@
=20
 import logging
 from pyverbs.pyverbs_error import PyverbsRDMAError
+from libc.stdlib cimport malloc, free
+from libc.stdint cimport uintptr_t
 from libc.errno cimport errno
=20
+cdef extern from 'stdlib.h':
+    void *aligned_alloc(size_t alignment, size_t size)
+
+
 cpdef PyverbsRDMAErrno(str msg):
     return PyverbsRDMAError(msg, errno)
=20
@@ -58,3 +64,23 @@ cdef class PyverbsCM(PyverbsObject):
=20
     cpdef close(self):
         pass
+
+
+cdef class MemAlloc(object):
+    @staticmethod
+    def malloc(size):
+        ptr =3D malloc(size)
+        if not ptr:
+            raise MemoryError('Failed to allocate memory')
+        return <uintptr_t>ptr
+
+    @staticmethod
+    def aligned_alloc(size, alignment=3D8):
+        ptr =3D aligned_alloc(alignment, size)
+        if not ptr:
+            raise MemoryError('Failed to allocate memory')
+        return <uintptr_t>ptr
+
+    @staticmethod
+    def free(ptr):
+        free(<void*><uintptr_t>ptr)
--=20
2.21.0

