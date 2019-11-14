Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E087FC2BA
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2019 10:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfKNJhu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Nov 2019 04:37:50 -0500
Received: from mail-eopbgr40065.outbound.protection.outlook.com ([40.107.4.65]:56641
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726386AbfKNJhu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 14 Nov 2019 04:37:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nE/9ylSlFOxKwaoqd63CnvkGwa4R8FN3UEsyVY08zh8uRzOUXNMZALCYl+cJYkf+caiiV1yDHpSVBOU/nh3/pvrGqN3ixxCKTzMEtDxh3EN+u7WjN6uzGVGeQVI/WoEMjpeu6vrYtA0Lb/DoiZTnOsQdUwUxrs+tNiSz0BoOypV2lcEW34g7ZnO1iKPo0FuePxwXTN0+XeEi4uplwKrEXxNYgG16i7SQCHw9+1/y9/Uk5z9NNcSkCNNlJXJYl9X5+28WXx1VSaF9rYq7KpHwGZyIB40SmiwKxuInS1wimMA2Bc9N1vaVVIE4fWKFe6Xve555qfqPZylSfjpkAHsd3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLM7NKUd4C5O18cSQwepSE5NVLblO9P4T2v2EAtus3w=;
 b=SnKteHlvIdu3ZmudhAdpBuJZ4z7VkVy0tk/nVx07BIYCkvIBgvzk6+KUV1dr5pTw++LQpmKZ7jwMhb83ATBWTUa5zpHmokLIo+avKW3qDd3YB3WdFLVp/rBrpuOiLL7Mlszjw7rfJ+J8g1wECm8OaQGzfQH7WFz83dotFp6ekB7Fm3pi4Q6ZnJS2gSuShcYqWgTtg3VNhB1aq+2JoWL2sWEr7WCAY4D4V4Qsed69Q4rMEeaelnKhJv1gwRBph47bX8PXQvWWDiWn++CfxW53+TTbv2sOFLd2XT5XG5kIWx8d0RKUeS4YgPGDBIG/PPmBh9tWQiiwJRiYIBhv5W9R/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLM7NKUd4C5O18cSQwepSE5NVLblO9P4T2v2EAtus3w=;
 b=QQyQpFGiYszE8tJtJIZY81AEeUtR64gl7ziENcMQVB5F21wPTkUUBJwNnmNtrxWshjHlWGl5lJew8zRk6ykPPuIN+8uDlVAoPPK02lfcBLiTI4i686XmI2uy/xxuuVSd2mpp0RbpSIsx6g/2J8vYhcfZ04z7VaJPagz3NSuTK+Q=
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com (20.177.33.17) by
 AM6PR05MB5783.eurprd05.prod.outlook.com (20.178.86.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Thu, 14 Nov 2019 09:37:46 +0000
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::505f:e3f8:3f87:e3ff]) by AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::505f:e3f8:3f87:e3ff%7]) with mapi id 15.20.2430.028; Thu, 14 Nov 2019
 09:37:46 +0000
From:   Noa Osherovich <noaos@mellanox.com>
To:     "dledford@redhat.com" <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Edward Srouji <edwards@mellanox.com>,
        Daria Velikovsky <daria@mellanox.com>,
        Noa Osherovich <noaos@mellanox.com>
Subject: [PATCH rdma-core 2/4] pyverbs: Introduce ParentDomain class
Thread-Topic: [PATCH rdma-core 2/4] pyverbs: Introduce ParentDomain class
Thread-Index: AQHVms8sbhl+P+e5bkW4yXUEEbCwjg==
Date:   Thu, 14 Nov 2019 09:37:46 +0000
Message-ID: <20191114093732.12637-3-noaos@mellanox.com>
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
x-ms-office365-filtering-correlation-id: c813bb2a-c96c-4715-1e97-08d768e64e46
x-ms-traffictypediagnostic: AM6PR05MB5783:|AM6PR05MB5783:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR05MB5783AF01833681D21E1FDA1ED9710@AM6PR05MB5783.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 02213C82F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(136003)(366004)(346002)(39860400002)(189003)(199004)(52116002)(4326008)(8936002)(8676002)(81166006)(81156014)(50226002)(7736002)(3846002)(6116002)(6486002)(305945005)(36756003)(107886003)(2906002)(6436002)(6512007)(66946007)(478600001)(66476007)(66446008)(64756008)(66556008)(71200400001)(110136005)(99286004)(54906003)(316002)(256004)(25786009)(5660300002)(1076003)(71190400001)(6506007)(26005)(86362001)(186003)(76176011)(14444005)(486006)(2501003)(476003)(11346002)(2616005)(6636002)(66066001)(386003)(14454004)(30864003)(446003)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB5783;H:AM6PR05MB4968.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YpaCULZjTjYV1/eckutPMQBaQFrEXLdGA2L1696E5hU4boqlBZIiIPN2Cb12oi6xl9eqNM8E6NftZgzT3VgFnXKvxvQEwMQ3InrLi+qlq8Sa2857Y5N4Q/LrjcWPsfLk716i7TS0erv68rH7vw+s4qsS+9hC/0L2Fv2Vf96GEDQk2BhMtpiMWloaBXf4g8+W178DlxE51wlOoqSzT9wtCDoy+Nylhp6QntQmbwj5qYYgPJAVTLbqGeJW0aQvAeGOPXMo+/WO73m4ywc9huTZp3oIpGvksw2GJCJNPdr2Pgmg0eBgBnbKoAXQdUXtTl0TWk0TlfjIuG2dDhpPilhjmJtHe2QYz3x/Ltxq/r7fiY90Sd+2BcvKTF5jT3BIYnxA1zZCszrxKupNE+M4cRomXIKNo2r2VOpPiG7+/ABIoiYPKVPhXekm5iAuSCpNzH+1
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c813bb2a-c96c-4715-1e97-08d768e64e46
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2019 09:37:46.6779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NW+LWoJHbH1qP3HF8KvrSThs0hccfUnzo2wJVozaL+I6y6K9EY5gbL8fEFLGNHXENkg43sber32ejCzgGwTyRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5783
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Edward Srouji <edwards@mellanox.com>

The parent domain object extends the normal PD (protection domain) and
can be used interchangeably with it.
This patch adds ParentDomain class, in order to allow the user to
allocate parent domain in a user-friendly way.

In addition, ParentDomainContext class was added which is used as the
pd_context and it includes PD (protection domain) object, alloc and
free Python functions.
This allows the user to implement allocators in Python that are
callable from the C callbacks wrappers via driver code.

Signed-off-by: Edward Srouji <edwards@mellanox.com>
Reviewd-by: Daria Velikovsky <daria@mellanox.com>
Reviewd-by: Noa Osherovich <noaos@mellanox.com>
---
 pyverbs/libibverbs.pxd                  |  11 ++
 pyverbs/libibverbs_enums.pxd            |   7 ++
 pyverbs/pd.pxd                          |  17 +++
 pyverbs/pd.pyx                          | 150 ++++++++++++++++++++++--
 pyverbs/providers/mlx5/mlx5dv_enums.pxd |  11 ++
 pyverbs/srq.pyx                         |   2 +-
 6 files changed, 187 insertions(+), 11 deletions(-)

diff --git a/pyverbs/libibverbs.pxd b/pyverbs/libibverbs.pxd
index 02137d81e2d3..ad8d8bacc541 100755
--- a/pyverbs/libibverbs.pxd
+++ b/pyverbs/libibverbs.pxd
@@ -454,6 +454,15 @@ cdef extern from 'infiniband/verbs.h':
         ibv_qp_type     qp_type;
         unsigned int    events_completed;
=20
+    cdef struct ibv_parent_domain_init_attr:
+        ibv_pd          *pd;
+        uint32_t        comp_mask;
+        void            *(*alloc)(ibv_pd *pd, void *pd_context, size_t siz=
e,
+                                  size_t alignment, uint64_t resource_type=
);
+        void            (*free)(ibv_pd *pd, void *pd_context, void *ptr,
+                                uint64_t resource_type);
+        void            *pd_context;
+
     ibv_device **ibv_get_device_list(int *n)
     void ibv_free_device_list(ibv_device **list)
     ibv_context *ibv_open_device(ibv_device *device)
@@ -540,3 +549,5 @@ cdef extern from 'infiniband/verbs.h':
     int ibv_destroy_srq(ibv_srq *srq)
     int ibv_post_srq_recv(ibv_srq *srq, ibv_recv_wr *recv_wr,
                           ibv_recv_wr **bad_recv_wr)
+    ibv_pd *ibv_alloc_parent_domain(ibv_context *context,
+                                    ibv_parent_domain_init_attr *attr)
diff --git a/pyverbs/libibverbs_enums.pxd b/pyverbs/libibverbs_enums.pxd
index 114915d0a751..66066e2c37fd 100755
--- a/pyverbs/libibverbs_enums.pxd
+++ b/pyverbs/libibverbs_enums.pxd
@@ -401,6 +401,13 @@ cdef extern from '<infiniband/verbs.h>':
     cdef unsigned long long IBV_DEVICE_RAW_SCATTER_FCS
     cdef unsigned long long IBV_DEVICE_PCI_WRITE_END_PADDING
=20
+    cpdef enum ibv_parent_domain_init_attr_mask:
+        IBV_PARENT_DOMAIN_INIT_ATTR_ALLOCATORS
+        IBV_PARENT_DOMAIN_INIT_ATTR_PD_CONTEXT
+
+    cdef void *IBV_ALLOCATOR_USE_DEFAULT
+
=20
 _IBV_DEVICE_RAW_SCATTER_FCS =3D IBV_DEVICE_RAW_SCATTER_FCS
 _IBV_DEVICE_PCI_WRITE_END_PADDING =3D IBV_DEVICE_PCI_WRITE_END_PADDING
+_IBV_ALLOCATOR_USE_DEFAULT =3D <size_t>IBV_ALLOCATOR_USE_DEFAULT
diff --git a/pyverbs/pd.pxd b/pyverbs/pd.pxd
index 6dd9c2959ed3..cb0b4715ba0d 100644
--- a/pyverbs/pd.pxd
+++ b/pyverbs/pd.pxd
@@ -3,6 +3,7 @@
=20
 #cython: language_level=3D3
=20
+from pyverbs.base cimport PyverbsObject
 from pyverbs.device cimport Context
 cimport pyverbs.libibverbs as v
 from .base cimport PyverbsCM
@@ -17,3 +18,19 @@ cdef class PD(PyverbsCM):
     cdef object mws
     cdef object ahs
     cdef object qps
+    cdef object parent_domains
+
+cdef class ParentDomainInitAttr(PyverbsObject):
+    cdef v.ibv_parent_domain_init_attr init_attr
+    cdef object pd
+    cdef object alloc
+    cdef object dealloc
+
+cdef class ParentDomain(PD):
+    cdef object protection_domain
+    pass
+
+cdef class ParentDomainContext(PyverbsObject):
+    cdef object p_alloc
+    cdef object p_free
+    cdef object pd
diff --git a/pyverbs/pd.pyx b/pyverbs/pd.pyx
index a4fc76f0fe5b..b639c3dcc74d 100644
--- a/pyverbs/pd.pyx
+++ b/pyverbs/pd.pyx
@@ -2,35 +2,43 @@
 # Copyright (c) 2019, Mellanox Technologies. All rights reserved.
 import weakref
=20
-from pyverbs.pyverbs_error import PyverbsRDMAError, PyverbsError
+from pyverbs.pyverbs_error import PyverbsError, PyverbsUserError
 from pyverbs.base import PyverbsRDMAErrno
-from pyverbs.device cimport Context, DM
+from pyverbs.device cimport Context
+from libc.stdint cimport uintptr_t
+from libc.errno cimport errno
 from .mr cimport MR, MW, DMMR
 from pyverbs.srq cimport SRQ
 from pyverbs.addr cimport AH
 from pyverbs.qp cimport QP
-from libc.errno cimport errno
=20
=20
 cdef class PD(PyverbsCM):
-    def __cinit__(self, Context context not None):
+    def __cinit__(self, Context context not None, **kwargs):
         """
         Initializes a PD object. A reference for the creating Context is k=
ept
         so that Python's GC will destroy the objects in the right order.
         :param context: The Context object creating the PD
-        :return: The newly created PD on success
+        :param kwargs: Arguments:
+            * *attr* (object)
+                If provided PD will not be allocated, leaving the allocati=
on to
+                be made by an inheriting class
         """
-        self.pd =3D v.ibv_alloc_pd(<v.ibv_context*>context.context)
-        if self.pd =3D=3D NULL:
-            raise PyverbsRDMAErrno('Failed to allocate PD', errno)
+        # If there's a Parent Domain attribute skip PD allocation
+        # since this is done by the Parent Domain class
+        if not kwargs.get('attr'):
+            self.pd =3D v.ibv_alloc_pd(<v.ibv_context*>context.context)
+            if self.pd =3D=3D NULL:
+                raise PyverbsRDMAErrno('Failed to allocate PD', errno)
+            self.logger.debug('PD: Allocated ibv_pd')
         self.ctx =3D context
         context.add_ref(self)
-        self.logger.debug('PD: Allocated ibv_pd')
         self.srqs =3D weakref.WeakSet()
         self.mrs =3D weakref.WeakSet()
         self.mws =3D weakref.WeakSet()
         self.ahs =3D weakref.WeakSet()
         self.qps =3D weakref.WeakSet()
+        self.parent_domains =3D weakref.WeakSet()
=20
     def __dealloc__(self):
         """
@@ -48,7 +56,8 @@ cdef class PD(PyverbsCM):
         :return: None
         """
         self.logger.debug('Closing PD')
-        self.close_weakrefs([self.qps, self.ahs, self.mws, self.mrs, self.=
srqs])
+        self.close_weakrefs([self.parent_domains, self.qps, self.ahs, self=
.mws,
+                             self.mrs, self.srqs])
         if self.pd !=3D NULL:
             rc =3D v.ibv_dealloc_pd(self.pd)
             if rc !=3D 0:
@@ -67,5 +76,126 @@ cdef class PD(PyverbsCM):
             self.qps.add(obj)
         elif isinstance(obj, SRQ):
             self.srqs.add(obj)
+        elif isinstance(obj, ParentDomain):
+            self.parent_domains.add(obj)
         else:
             raise PyverbsError('Unrecognized object type')
+
+
+cdef void *pd_alloc(v.ibv_pd *pd, void *pd_context, size_t size,
+                  size_t alignment, v.uint64_t resource_type):
+    """
+    Parent Domain allocator wrapper. This function is used to wrap a
+    user-defined Python alloc function which should be a part of pd_contex=
t.
+    :param pd: Parent domain
+    :param pd_context: User-specific context of type ParentDomainContext
+    :param size: Size of the requested buffer
+    :param alignment: Alignment of the requested buffer
+    :param resource_type: Vendor-specific resource type
+    :return: Pointer to the allocated buffer, or NULL to designate an erro=
r.
+             It may also return IBV_ALLOCATOR_USE_DEFAULT asking the calle=
e to
+             allocate the buffer using the default allocator.
+
+    """
+    cdef ParentDomainContext pd_ctx
+    pd_ctx =3D <object>pd_context
+    ptr =3D <uintptr_t>pd_ctx.p_alloc(pd_ctx.pd, pd_ctx, size, alignment,
+                                    resource_type)
+    return <void*>ptr
+
+
+cdef void pd_free(v.ibv_pd *pd, void *pd_context, void *ptr,
+                     v.uint64_t resource_type):
+    """
+    Parent Domain deallocator wrapper. This function is used to wrap a
+    user-defined Python free function which should be part of pd_context.
+    :param pd: Parent domain
+    :param pd_context: User-specific context of type ParentDomainContext
+    :param ptr: Pointer to the buffer to be freed
+    :param resource_type: Vendor-specific resource type
+    """
+    cdef ParentDomainContext pd_ctx
+    pd_ctx =3D <object>pd_context
+    pd_ctx.p_free(pd_ctx.pd, pd_ctx, <uintptr_t>ptr, resource_type)
+
+
+cdef class ParentDomainContext(PyverbsObject):
+    def __cinit__(self, PD pd, alloc_func, free_func):
+        """
+        Initializes ParentDomainContext object which is used as a pd_conte=
xt.
+        It contains the relevant fields in order to allow the user to writ=
e
+        alloc and free functions in Python
+        :param pd: PD object that represents the ibv_pd which is passed to=
 the
+                  creation of the Parent Domain
+        :param alloc_func: Python alloc function
+        :param free_func: Python free function
+        """
+        self.pd =3D pd
+        self.p_alloc =3D alloc_func
+        self.p_free =3D free_func
+
+
+cdef class ParentDomainInitAttr(PyverbsObject):
+    def __cinit__(self, PD pd not None, ParentDomainContext pd_context=3DN=
one):
+        """
+        Represents ibv_parent_domain_init_attr C struct
+        :param pd: PD to initialize the ParentDomain with
+        :param pd_context: ParentDomainContext object including the alloc =
and
+                          free Python callbacks
+        """
+        self.pd =3D pd
+        self.init_attr.pd =3D <v.ibv_pd*>pd.pd
+        if pd_context:
+            self.init_attr.alloc =3D pd_alloc
+            self.init_attr.free =3D pd_free
+            self.init_attr.pd_context =3D <void*>pd_context
+            # The only way to use Python callbacks is to pass the (Python)
+            # functions through pd_context. Hence, we must set PD_CONTEXT
+            # in the comp mask.
+            self.init_attr.comp_mask =3D v.IBV_PARENT_DOMAIN_INIT_ATTR_PD_=
CONTEXT | \
+                                       v.IBV_PARENT_DOMAIN_INIT_ATTR_ALLOC=
ATORS
+
+    @property
+    def comp_mask(self):
+        return self.init_attr.comp_mask
+
+
+cdef class ParentDomain(PD):
+    def __cinit__(self, Context context not None, **kwargs):
+        """
+        Initializes ParentDomain object which represents a parent domain o=
f
+        ibv_pd C struct type
+        :param context: Device context
+        :param kwargs: Arguments:
+            * *attr* (object)
+                Attribute of type ParentDomainInitAttr to initialize the
+                ParentDomain with
+        """
+        cdef ParentDomainInitAttr attr
+        attr =3D kwargs.get('attr')
+        if attr is None:
+            raise PyverbsUserError('ParentDomain must take attr')
+        (<PD>attr.pd).add_ref(self)
+        self.protection_domain =3D attr.pd
+        self.pd =3D v.ibv_alloc_parent_domain(context.context, &attr.init_=
attr)
+        if self.pd =3D=3D NULL:
+            raise PyverbsRDMAErrno('Failed to allocate Parent Domain')
+        self.logger.debug('Allocated ParentDomain')
+
+    def __dealloc__(self):
+        self.__close(True)
+
+    cpdef close(self):
+        self.__close()
+
+    def __close(self, from_dealloc=3DFalse):
+        """
+        The close function can be called either explicitly by the user, or
+        implicitly (from __dealloc__). In the case it was called by deallo=
c,
+        the close function of the PD would have been already called, thus
+        freeing the PD of this parent domain and no need to dealloc it aga=
in
+        :param from_dealloc: Indicates whether the close was called via de=
alloc
+        """
+        self.logger.debug('Closing ParentDomain')
+        if not from_dealloc:
+            super(ParentDomain, self).close()
diff --git a/pyverbs/providers/mlx5/mlx5dv_enums.pxd b/pyverbs/providers/ml=
x5/mlx5dv_enums.pxd
index 038a49111a3b..b02da9bf5001 100644
--- a/pyverbs/providers/mlx5/mlx5dv_enums.pxd
+++ b/pyverbs/providers/mlx5/mlx5dv_enums.pxd
@@ -45,3 +45,14 @@ cdef extern from 'infiniband/mlx5dv.h':
         MLX5DV_FLOW_ACTION_FLAGS_ESP_AES_GCM_SPI_STEERING   =3D 1 << 2
         MLX5DV_FLOW_ACTION_FLAGS_ESP_AES_GCM_FULL_OFFLOAD   =3D 1 << 3
         MLX5DV_FLOW_ACTION_FLAGS_ESP_AES_GCM_TX_IV_IS_ESN   =3D 1 << 4
+
+    cdef unsigned long long MLX5DV_RES_TYPE_QP
+    cdef unsigned long long MLX5DV_RES_TYPE_RWQ
+    cdef unsigned long long MLX5DV_RES_TYPE_DBR
+    cdef unsigned long long MLX5DV_RES_TYPE_SRQ
+
+
+_MLX5DV_RES_TYPE_QP =3D MLX5DV_RES_TYPE_QP
+_MLX5DV_RES_TYPE_RWQ =3D MLX5DV_RES_TYPE_RWQ
+_MLX5DV_RES_TYPE_DBR =3D MLX5DV_RES_TYPE_DBR
+_MLX5DV_RES_TYPE_SRQ =3D MLX5DV_RES_TYPE_SRQ
diff --git a/pyverbs/srq.pyx b/pyverbs/srq.pyx
index 9cad4cafdd83..a60aa5dcb0e5 100755
--- a/pyverbs/srq.pyx
+++ b/pyverbs/srq.pyx
@@ -125,7 +125,7 @@ cdef class SRQ(PyverbsCM):
     def __cinit__(self, object creator not None, object attr not None):
         self.srq =3D NULL
         self.cq =3D None
-        if type(creator) =3D=3D PD:
+        if isinstance(creator, PD):
             self._create_srq(creator, attr)
         elif type(creator) =3D=3D Context:
             self._create_srq_ex(creator, attr)
--=20
2.21.0

