Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF04612D753
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Dec 2019 10:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725770AbfLaJUP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 31 Dec 2019 04:20:15 -0500
Received: from mail-eopbgr00084.outbound.protection.outlook.com ([40.107.0.84]:29969
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726119AbfLaJUO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 31 Dec 2019 04:20:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Szt5zSPyT+zQX4KJAgNir9MBDsYkLFJygawh6ZBzE+c+gI8B49UN0s96fb9VvQw6y+0xMOugSwmBjHvNztdUI9+q6/uJBQrWdnKcwfbe7CD4p5t8hDOX68xVRzqJWFR0CsafX/3U9FDHdyTfJwuIvTH4GSTipmA4TtViLQ0MbYgrdCEBzWtJ36aL14jPaT8cf09gSLXR7NqaM5fsUBqpvjwXq+GM9lv5P6OXvr9aE6qFpL5MptD0WezYeXqHudzev97P700krY8KZSl7002a441jxGXpK2HuQuunW+CH0q5sIqrQHFJ1sG0ZvnaGrsB6AUtI+SBcXWgRxdLesLmClA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOguSGTf2d92nL53hUQRyuP0hehh4fKcBPfAaQnJmXg=;
 b=UcV5x2D8vEnTlaMIIUUFsHaPtjumuQZowWESnWpqMLj+lDJ8Mw/HDvrkdBK/q3wKVpHv6VPsQkk/p2lHvXHMylkyAt+yceEbQIFJbRkntiM4SURjvW0C66xOQHrBKYEjeCr8/88chnjxpncDU+D1ZIl143W5qpL2KPb3SWHUS3BzOqDjCXN8QBZJg+dQCpspv5IiPo4pnKnkl2gli4IGXGv31dTku2nfUup3aAwkc/vSaABv6aZLSODnnC7FeFUNT5hTk/3rB3ZewGIAk9ZwQlbgao+/uBryUpmeho9jdUn/ogY5vj5YoWqZNLGgG35WlB9He357ePRpit+1Qrukhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOguSGTf2d92nL53hUQRyuP0hehh4fKcBPfAaQnJmXg=;
 b=t+lcV3UpaZk61D9nJ1pnX3EohZCsxZAXWgYl139PxXKvrRYbXc8IrHQUeWptuhqVwFe4GaFDcGmemsmK1y5MukE3Z4GcW/KLoJrsn8mMBtGM6R3Fu3ZtEIy4s+6HYZ7qyCQATdRLjG7oik1mb2CxhQZ+zap8nCtGZVHvBAevt3Q=
Received: from VI1PR0502MB3006.eurprd05.prod.outlook.com (10.175.21.136) by
 VI1PR0502MB3742.eurprd05.prod.outlook.com (52.134.1.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.10; Tue, 31 Dec 2019 09:19:33 +0000
Received: from VI1PR0502MB3006.eurprd05.prod.outlook.com
 ([fe80::b9ec:a465:4659:7427]) by VI1PR0502MB3006.eurprd05.prod.outlook.com
 ([fe80::b9ec:a465:4659:7427%5]) with mapi id 15.20.2581.013; Tue, 31 Dec 2019
 09:19:33 +0000
Received: from reg-l-vrt-059-007.mtl.labs.mlnx (94.188.199.18) by AM0PR0102CA0016.eurprd01.prod.exchangelabs.com (2603:10a6:208:14::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11 via Frontend Transport; Tue, 31 Dec 2019 09:19:32 +0000
From:   Noa Osherovich <noaos@mellanox.com>
To:     "dledford@redhat.com" <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Noa Osherovich <noaos@mellanox.com>,
        Ahmad Ghazawi <ahmadg@mellanox.com>,
        Edward Srouji <edwards@mellanox.com>
Subject: [PATCH rdma-core 6/8] pyverbs: Introduce extended QP and new post
 send
Thread-Topic: [PATCH rdma-core 6/8] pyverbs: Introduce extended QP and new
 post send
Thread-Index: AQHVv7tpOl0kENfoMkGUB4suYS0ybg==
Date:   Tue, 31 Dec 2019 09:19:33 +0000
Message-ID: <20191231091915.23874-7-noaos@mellanox.com>
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
x-ms-office365-filtering-correlation-id: 586f3946-8e78-4168-2bf4-08d78dd28c1c
x-ms-traffictypediagnostic: VI1PR0502MB3742:|VI1PR0502MB3742:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB3742D51850A88BE7ED3C132ED9260@VI1PR0502MB3742.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0268246AE7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(199004)(189003)(54906003)(1076003)(316002)(107886003)(36756003)(6636002)(2616005)(956004)(110136005)(478600001)(52116002)(71200400001)(66476007)(30864003)(4326008)(66946007)(81156014)(81166006)(6506007)(64756008)(86362001)(5660300002)(2906002)(8676002)(186003)(66446008)(8936002)(6486002)(66556008)(16526019)(26005)(6512007)(6606295002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0502MB3742;H:VI1PR0502MB3006.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xN21rkUlZAidcCMcu4uiMsR4N2NGbI4lKZn3m0OT2gquCv+xC1Pa9E3+hUBcu4zmUf5wQS5ecKtuvKA5hjTto/EGUJ0FO2FmEKFtK3FlT4h7bppdwC7AgzwM4ICbU+DgPaay/XrBKcx7Oz0i0Xq8F4hVxfxQZ0ld7O9veINIWpmr/6jflCVDqlLT6vgG50iRaOYULb7wmDaJapj/zdjhIPpG70F7Rl0nJMTY05omRTA3YpVxbzwFal6tEObj8AeyzorJfA7Lq6vEUP2TRziaSyhFgXIskX7ytmRcEOMtWCn7Doesn6FDoepeW83yc9cF0OfsFdc1tFqKO4XPVU8k0VgQ0V+ztVQ0ZAbW6j8Jcx4nCEOuEdjOdyWhQgSAog9SBL07lU6hEDeA5IeJclXdsnGip71TyXB6pwEKjmsDpu4S4SAhrPqzEZ2sUjiZ6war2XTGCC7hSj2inspNcwlWBi+E8ABYfZK/PV9Pj/F1jKv6+6EKHmr1xi2cnxlPWgBJ
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 586f3946-8e78-4168-2bf4-08d78dd28c1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Dec 2019 09:19:33.2638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qY99RgUCxsSSTy9aJ4x8/vBVr0Z6BLXXfSTtVzqWILF0VquuhqEQ1L3nat/kkJQLd+B0FtzlXSrhtoLbl8Wfnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3742
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add QPEx class alongside the new post send functions.
The new post send flow is as follows:
- Create a WR on the extended QP.
- Set the WR's attributes.
- Commit the entries in the send buffer and ring the doorbell.
QPEx class exposes the relevant methods (wr_*) for that.

Signed-off-by: Ahmad Ghazawi <ahmadg@mellanox.com>
Signed-off-by: Noa Osherovich <noaos@mellanox.com>
Reviewed-by: Edward Srouji <edwards@mellanox.com>
---
 pyverbs/libibverbs.pxd       |  40 +++++++++
 pyverbs/libibverbs_enums.pxd |  14 ++++
 pyverbs/qp.pxd               |   6 ++
 pyverbs/qp.pyx               | 154 +++++++++++++++++++++++++++++++++--
 4 files changed, 209 insertions(+), 5 deletions(-)

diff --git a/pyverbs/libibverbs.pxd b/pyverbs/libibverbs.pxd
index 8949759511a5..c038c4aa4d5b 100755
--- a/pyverbs/libibverbs.pxd
+++ b/pyverbs/libibverbs.pxd
@@ -438,6 +438,10 @@ cdef extern from 'infiniband/verbs.h':
         unsigned int    handle
         unsigned int    events_completed
=20
+    cdef struct ibv_data_buf:
+        void    *addr
+        size_t  length
+
     cdef struct ibv_qp:
         ibv_context     *context;
         void            *qp_context;
@@ -460,6 +464,12 @@ cdef extern from 'infiniband/verbs.h':
                                 uint64_t resource_type);
         void            *pd_context;
=20
+    cdef struct ibv_qp_ex:
+        ibv_qp          qp_base
+        uint64_t        comp_mask
+        uint64_t        wr_id
+        unsigned int    wr_flags
+
     ibv_device **ibv_get_device_list(int *n)
     void ibv_free_device_list(ibv_device **list)
     ibv_context *ibv_open_device(ibv_device *device)
@@ -549,3 +559,33 @@ cdef extern from 'infiniband/verbs.h':
     ibv_pd *ibv_alloc_parent_domain(ibv_context *context,
                                     ibv_parent_domain_init_attr *attr)
     uint32_t ibv_inc_rkey(uint32_t rkey)
+    ibv_qp_ex *ibv_qp_to_qp_ex(ibv_qp *qp)
+    void ibv_wr_atomic_cmp_swp(ibv_qp_ex *qp, uint32_t rkey,
+                               uint64_t remote_addr, uint64_t compare,
+                               uint64_t swap)
+    void ibv_wr_atomic_fetch_add(ibv_qp_ex *qp, uint32_t rkey,
+                                 uint64_t remote_addr, uint64_t add)
+    void ibv_wr_bind_mw(ibv_qp_ex *qp, ibv_mw *mw, uint32_t rkey,
+                        ibv_mw_bind_info *bind_info)
+    void ibv_wr_local_inv(ibv_qp_ex *qp, uint32_t invalidate_rkey)
+    void ibv_wr_rdma_read(ibv_qp_ex *qp, uint32_t rkey, uint64_t remote_ad=
dr)
+    void ibv_wr_rdma_write(ibv_qp_ex *qp, uint32_t rkey, uint64_t remote_a=
ddr)
+    void ibv_wr_rdma_write_imm(ibv_qp_ex *qp, uint32_t rkey,
+                               uint64_t remote_addr, uint32_t imm_data)
+    void ibv_wr_send(ibv_qp_ex *qp)
+    void ibv_wr_send_imm(ibv_qp_ex *qp, uint32_t imm_data)
+    void ibv_wr_send_inv(ibv_qp_ex *qp, uint32_t invalidate_rkey)
+    void ibv_wr_send_tso(ibv_qp_ex *qp, void *hdr, uint16_t hdr_sz,
+                         uint16_t mss)
+    void ibv_wr_set_ud_addr(ibv_qp_ex *qp, ibv_ah *ah, uint32_t remote_qpn=
,
+                            uint32_t remote_qkey)
+    void ibv_wr_set_xrc_srqn(ibv_qp_ex *qp, uint32_t remote_srqn)
+    void ibv_wr_set_inline_data(ibv_qp_ex *qp, void *addr, size_t length)
+    void ibv_wr_set_inline_data_list(ibv_qp_ex *qp, size_t num_buf,
+                                     ibv_data_buf *buf_list)
+    void ibv_wr_set_sge(ibv_qp_ex *qp, uint32_t lkey, uint64_t addr,
+                        uint32_t length)
+    void ibv_wr_set_sge_list(ibv_qp_ex *qp, size_t num_sge, ibv_sge *sg_li=
st)
+    void ibv_wr_start(ibv_qp_ex *qp)
+    int ibv_wr_complete(ibv_qp_ex *qp)
+    void ibv_wr_abort(ibv_qp_ex *qp)
diff --git a/pyverbs/libibverbs_enums.pxd b/pyverbs/libibverbs_enums.pxd
index fd6a6f49a163..a706cec0aba8 100755
--- a/pyverbs/libibverbs_enums.pxd
+++ b/pyverbs/libibverbs_enums.pxd
@@ -236,6 +236,7 @@ cdef extern from '<infiniband/verbs.h>':
         IBV_QP_INIT_ATTR_MAX_TSO_HEADER
         IBV_QP_INIT_ATTR_IND_TABLE
         IBV_QP_INIT_ATTR_RX_HASH
+        IBV_QP_INIT_ATTR_SEND_OPS_FLAGS
=20
     cpdef enum ibv_qp_create_flags:
         IBV_QP_CREATE_BLOCK_SELF_MCAST_LB
@@ -401,6 +402,19 @@ cdef extern from '<infiniband/verbs.h>':
     cpdef enum:
         IBV_WC_STANDARD_FLAGS
=20
+    cpdef enum ibv_qp_create_send_ops_flags:
+        IBV_QP_EX_WITH_RDMA_WRITE
+        IBV_QP_EX_WITH_RDMA_WRITE_WITH_IMM
+        IBV_QP_EX_WITH_SEND
+        IBV_QP_EX_WITH_SEND_WITH_IMM
+        IBV_QP_EX_WITH_RDMA_READ
+        IBV_QP_EX_WITH_ATOMIC_CMP_AND_SWP
+        IBV_QP_EX_WITH_ATOMIC_FETCH_AND_ADD
+        IBV_QP_EX_WITH_LOCAL_INV
+        IBV_QP_EX_WITH_BIND_MW
+        IBV_QP_EX_WITH_SEND_WITH_INV
+        IBV_QP_EX_WITH_TSO
+
     cdef unsigned long long IBV_DEVICE_RAW_SCATTER_FCS
     cdef unsigned long long IBV_DEVICE_PCI_WRITE_END_PADDING
=20
diff --git a/pyverbs/qp.pxd b/pyverbs/qp.pxd
index 52aab503e40d..209a2438dd83 100644
--- a/pyverbs/qp.pxd
+++ b/pyverbs/qp.pxd
@@ -37,3 +37,9 @@ cdef class QP(PyverbsCM):
     cdef update_cqs(self, init_attr)
     cdef object scq
     cdef object rcq
+
+cdef class DataBuffer(PyverbsCM):
+    cdef v.ibv_data_buf data
+
+cdef class QPEx(QP):
+    cdef v.ibv_qp_ex *qp_ex
diff --git a/pyverbs/qp.pyx b/pyverbs/qp.pyx
index 9d368b62022d..1fcb23909758 100755
--- a/pyverbs/qp.pyx
+++ b/pyverbs/qp.pyx
@@ -1,20 +1,30 @@
 # SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
 # Copyright (c) 2019 Mellanox Technologies, Inc. All rights reserved.
+
+from libc.stdlib cimport malloc, free
+from libc.string cimport memcpy
+
 from pyverbs.utils import gid_str, qp_type_to_str, qp_state_to_str, mtu_to=
_str
+from pyverbs.pyverbs_error import PyverbsUserError, PyverbsError
 from pyverbs.utils import access_flags_to_str, mig_state_to_str
-from pyverbs.pyverbs_error import PyverbsUserError
+from pyverbs.wr cimport RecvWR, SendWR, SGE
 from pyverbs.base import PyverbsRDMAErrno
-from pyverbs.wr cimport RecvWR, SendWR
+from pyverbs.addr cimport AHAttr, GID, AH
+from pyverbs.mr cimport MW, MWBindInfo
 cimport pyverbs.libibverbs_enums as e
-from pyverbs.addr cimport AHAttr, GID
 from pyverbs.addr cimport GlobalRoute
 from pyverbs.device cimport Context
+from cpython.ref cimport PyObject
 from pyverbs.cq cimport CQ, CQEX
 cimport pyverbs.libibverbs as v
 from pyverbs.xrcd cimport XRCD
 from pyverbs.srq cimport SRQ
 from pyverbs.pd cimport PD
-from libc.string cimport memcpy
+
+cdef extern from 'Python.h':
+    void* PyLong_AsVoidPtr(object)
+cdef extern from 'endian.h':
+    unsigned long htobe32(unsigned long host_32bits)
=20
=20
 cdef class QPCap(PyverbsObject):
@@ -240,7 +250,7 @@ cdef class QPInitAttrEx(PyverbsObject):
                  SRQ srq=3DNone, QPCap cap=3DNone, sq_sig_all=3D0, comp_ma=
sk=3D0,
                  PD pd=3DNone, XRCD xrcd=3DNone, create_flags=3D0,
                  max_tso_header=3D0, source_qpn=3D0, object hash_conf=3DNo=
ne,
-                 object ind_table=3DNone):
+                 object ind_table=3DNone, send_ops_flags=3D0):
         """
         Initialize a QPInitAttrEx object with user-defined or default valu=
es.
         :param qp_type: QP type to be created
@@ -261,6 +271,8 @@ cdef class QPInitAttrEx(PyverbsObject):
                            set in create_flags)
         :param hash_conf: Not yet supported
         :param ind_table: Not yet supported
+        :param send_ops_flags: Send opcodes to be supported by the extende=
d QP.
+                               Use ibv_qp_create_send_ops_flags enum
         :return: An initialized QPInitAttrEx object
         """
         super().__init__()
@@ -302,6 +314,7 @@ cdef class QPInitAttrEx(PyverbsObject):
         self.attr.create_flags =3D create_flags
         self.attr.max_tso_header =3D max_tso_header
         self.attr.source_qpn =3D source_qpn
+        self.attr.send_ops_flags =3D send_ops_flags
=20
     @property
     def send_cq(self):
@@ -1141,6 +1154,137 @@ cdef class QP(PyverbsCM):
                print_format.format('  state', qp_state_to_str(self.qp_stat=
e))
=20
=20
+cdef class DataBuffer(PyverbsCM):
+    def __init__(self, addr, length):
+        super().__init__()
+        self.data.addr =3D PyLong_AsVoidPtr(addr)
+        self.data.length =3D length
+
+
+cdef class QPEx(QP):
+    def __init__(self, object creator not None, object init_attr not None,
+                 QPAttr qp_attr=3DNone):
+        """
+        Initializes a QPEx object. Since this is an extension of a QP, QP
+        creation is done in the parent class. The extended QP is retrieved=
 by
+        casting the ibv_qp to ibv_qp_ex.
+        :return: An initialized QPEx object
+        """
+        super().__init__(creator, init_attr, qp_attr)
+        self.qp_ex =3D v.ibv_qp_to_qp_ex(self.qp)
+        if self.qp_ex =3D=3D NULL:
+            raise PyverbsRDMAErrno('Failed to create extended QP')
+
+    @property
+    def comp_mask(self):
+        return self.qp_ex.comp_mask
+    @comp_mask.setter
+    def comp_mask(self, val):
+        self.qp_ex.comp_mask =3D val
+
+    @property
+    def wr_id(self):
+        return self.qp_ex.wr_id
+    @wr_id.setter
+    def wr_id(self, val):
+        self.qp_ex.wr_id =3D val
+
+    @property
+    def wr_flags(self):
+        return self.qp_ex.wr_flags
+    @wr_flags.setter
+    def wr_flags(self, val):
+        self.qp_ex.wr_flags =3D val
+
+    def wr_atomic_cmp_swp(self, rkey, remote_addr, compare, swap):
+        v.ibv_wr_atomic_cmp_swp(self.qp_ex, rkey, remote_addr, compare, sw=
ap)
+
+    def wr_atomic_fetch_add(self, rkey, remote_addr, add):
+        v.ibv_wr_atomic_fetch_add(self.qp_ex, rkey, remote_addr, add)
+
+    def wr_bind_mw(self, MW mw, rkey, MWBindInfo bind_info):
+        cdef v.ibv_mw_bind_info *info
+        info =3D &bind_info.info
+        v.ibv_wr_bind_mw(self.qp_ex, <v.ibv_mw*>mw.mw, rkey,
+                         <v.ibv_mw_bind_info*>info)
+
+    def wr_local_inv(self, invalidate_rkey):
+        v.ibv_wr_local_inv(self.qp_ex, invalidate_rkey)
+
+    def wr_rdma_read(self, rkey, remote_addr):
+        v.ibv_wr_rdma_read(self.qp_ex, rkey, remote_addr)
+
+    def wr_rdma_write(self, rkey, remote_addr):
+        v.ibv_wr_rdma_write(self.qp_ex, rkey, remote_addr)
+
+    def wr_rdma_write_imm(self, rkey, remote_addr, data):
+        cdef unsigned int imm_data =3D htobe32(data)
+        v.ibv_wr_rdma_write_imm(self.qp_ex, rkey, remote_addr, imm_data)
+
+    def wr_send(self):
+        v.ibv_wr_send(self.qp_ex)
+
+    def wr_send_imm(self, data):
+        cdef unsigned int imm_data =3D htobe32(data)
+        return v.ibv_wr_send_imm(self.qp_ex, imm_data)
+
+    def wr_send_inv(self, invalidate_rkey):
+        v.ibv_wr_send_inv(self.qp_ex, invalidate_rkey)
+
+    def wr_send_tso(self, hdr, hdr_sz, mss):
+        ptr =3D PyLong_AsVoidPtr(hdr)
+        v.ibv_wr_send_tso(self.qp_ex, ptr, hdr_sz, mss)
+
+    def wr_set_ud_addr(self, AH ah, remote_qpn, remote_rkey):
+        v.ibv_wr_set_ud_addr(self.qp_ex, ah.ah, remote_qpn, remote_rkey)
+
+    def wr_set_xrc_srqn(self, remote_srqn):
+        v.ibv_wr_set_xrc_srqn(self.qp_ex, remote_srqn)
+
+    def wr_set_inline_data(self, addr, length):
+        ptr =3D PyLong_AsVoidPtr(addr)
+        v.ibv_wr_set_inline_data(self.qp_ex, ptr, length)
+
+    def wr_set_inline_data_list(self, num_buf, buf_list):
+        cdef v.ibv_data_buf *data =3D NULL
+        data =3D <v.ibv_data_buf*>malloc(num_buf * sizeof(v.ibv_data_buf))
+        if data =3D=3D NULL:
+            raise PyverbsError('Failed to allocate data buffer')
+        for i in range(num_buf):
+            data_buf =3D <DataBuffer>buf_list[i]
+            data[i].addr =3D data_buf.data.addr
+            data[i].length =3D data_buf.data.length
+        v.ibv_wr_set_inline_data_list(self.qp_ex, num_buf, data)
+        free(data)
+
+    def wr_set_sge(self, SGE sge not None):
+        v.ibv_wr_set_sge(self.qp_ex, sge.lkey, sge.addr, sge.length)
+
+    def wr_set_sge_list(self, num_sge, sg_list):
+        cdef v.ibv_sge *sge =3D NULL
+        sge =3D <v.ibv_sge*>malloc(num_sge * sizeof(v.ibv_sge))
+        if sge =3D=3D NULL:
+            raise PyverbsError('Failed to allocate SGE buffer')
+        for i in range(num_sge):
+            sge[i].addr =3D sg_list[i].addr
+            sge[i].length =3D sg_list[i].length
+            sge[i].lkey =3D sg_list[i].lkey
+        v.ibv_wr_set_sge_list(self.qp_ex, num_sge, sge)
+        free(sge)
+
+    def wr_start(self):
+        v.ibv_wr_start(self.qp_ex)
+
+    def wr_complete(self):
+        rc =3D v.ibv_wr_complete(self.qp_ex)
+        if rc !=3D 0:
+            raise PyverbsRDMAErrno('ibv_wr_complete failed , returned {}'.
+                                   format(rc))
+
+    def wr_abort(self):
+        v.ibv_wr_abort(self.qp_ex)
+
+
 def _copy_caps(QPCap src, dst):
     """
     Copy the QPCaps values of src into the inner ibv_qp_cap struct of dst.
--=20
2.21.0

