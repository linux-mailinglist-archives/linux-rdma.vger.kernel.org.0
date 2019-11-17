Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82796FF9E3
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Nov 2019 14:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfKQNay (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 17 Nov 2019 08:30:54 -0500
Received: from mail-eopbgr70084.outbound.protection.outlook.com ([40.107.7.84]:28158
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726151AbfKQNay (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 17 Nov 2019 08:30:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMnADNJx8MC1B+WAvopaAEyxh2xnde/uMWW3MNrAhE2cmzMGrvvPJBpM5G8ikfC1FLIQuw/U0PcfjCZjdOCKfQBeHKOMEPdJea5epqhGycbrECFCJJxUVRSG8LLrk5OHh1a2NKEViE5XzZKBaCnpcRXyPVuJYsZnMktiwtJQCbRa9dwmhooM75gDnnL4mbgNSAgP+uf76rSSywTHnjCHiQDnZhCn5Ij7LK/PUKzG2PFxG4H2iQiRbOmTyknqS4OnMokwPqQAjSz5K3eAdQbj1beIJfknzV/7rrwP1PdMpL14I5dzyTBNLucNIbw2o5GRrBT/4pGzb3gaPfLv/yTEyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgH329SK/w2fFHAN0xCJQZQNwlTyeuVFoXoCG1Nawsk=;
 b=lz4OaIZ9ctTP/koO6KPoH8hXq8jRTw5dSYh0cwNx78heAtBrqx4JF0HHuJEy0ia+CjcNkLUXxeFbkrE22iF7fO2sU5kJfPerVKYgIwgO48QgwLxrzOAGFi1qaUIIEJTARWSF5dX1l4QMANYbW4cZgVg4Rf/zkNEUHDxl904O5CrHlxvEBKxtUbijCVWaF3l52dlNdZBWvogIFD+JoKUiKdkLN5QIGYDO6rzHMqXveB14QJi9UYMkJvCUyUCEaCdJFnZTXKToe9PTH7SaF0rdgc8U+JyGqfjYC1WWvpBu1YvDEJ24bVrYZIu3xTtnINoeRKsQqJrs7NmS8FyFQgEMRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgH329SK/w2fFHAN0xCJQZQNwlTyeuVFoXoCG1Nawsk=;
 b=EQGPGcLQIZ5Ii+zxAJsnByqLVpZHFKdTEBVOz538VXoSl4Tzyxunqrey1+XaY8NUXaLaNRcqIRD+yhnqovLZgdo9v//xKyM1vz359JTwi7WUGzT/Z5CzUrR21Apo2ZlajGJ7/u8r41/nPu9vaamILaon9pPojDRhUTrkYE2nTEU=
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com (20.177.33.17) by
 AM6PR05MB6598.eurprd05.prod.outlook.com (20.179.3.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Sun, 17 Nov 2019 13:30:45 +0000
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::505f:e3f8:3f87:e3ff]) by AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::505f:e3f8:3f87:e3ff%7]) with mapi id 15.20.2451.029; Sun, 17 Nov 2019
 13:30:45 +0000
From:   Noa Osherovich <noaos@mellanox.com>
To:     "dledford@redhat.com" <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Noa Osherovich <noaos@mellanox.com>
Subject: [PATCH rdma-core 5/7] pyverbs/mlx5: Add support for mlx5 CQ
Thread-Topic: [PATCH rdma-core 5/7] pyverbs/mlx5: Add support for mlx5 CQ
Thread-Index: AQHVnUs3/8Fv5u9dJEigHceLDHNXGw==
Date:   Sun, 17 Nov 2019 13:30:45 +0000
Message-ID: <20191117133030.10784-6-noaos@mellanox.com>
References: <20191117133030.10784-1-noaos@mellanox.com>
In-Reply-To: <20191117133030.10784-1-noaos@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: AM0PR01CA0088.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::29) To AM6PR05MB4968.eurprd05.prod.outlook.com
 (2603:10a6:20b:4::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=noaos@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.188.199.18]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1675ef01-9e9f-425a-2c7f-08d76b6259ee
x-ms-traffictypediagnostic: AM6PR05MB6598:|AM6PR05MB6598:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR05MB6598FC1D9F011ED0CF96E2B1D9720@AM6PR05MB6598.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 02243C58C6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(189003)(199004)(71200400001)(71190400001)(102836004)(6116002)(386003)(6506007)(256004)(11346002)(3846002)(2616005)(26005)(36756003)(446003)(5660300002)(86362001)(8936002)(186003)(64756008)(66556008)(66476007)(66946007)(7736002)(50226002)(66446008)(305945005)(66066001)(2501003)(81166006)(81156014)(8676002)(99286004)(6636002)(25786009)(76176011)(478600001)(14454004)(1076003)(2906002)(6436002)(6486002)(54906003)(6512007)(476003)(107886003)(110136005)(52116002)(486006)(316002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB6598;H:AM6PR05MB4968.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nCtKg9tS37ImdoaDmclouXxBRCUR/bDKZhwmvyfMPzHFlRGA0OsRHIWHBsFUvnPvuw06ajyZQO3w23P795fG9jJwSp8FkpMaKuegHXXi1uJ6DVZ+LaAAywCi3Kls4LIHb7yXfbjfN/PZoUc9liBTMYpsnZ+wxlngg7fpHxARQv94y4HseM7zZlPPxlstfvEmoUitywOxpnyjUn5sCNvtzKf6Jv2GpiOM7LXsuNicTXnZEu0o0oFJcJKJ/OajwuicqIsPG69+4G93XMLzTQDjJK0+zgKluC8ddIizSLpb0WXEkPsSHTjZWS79Dm0TaNc9gHZueu8iWDpOZ18SL1VxiGLakbjDZexkkxEv9CDw4yZ2vcqGFu1MOjJVd1EW8K5cRz4gR4z9WeFiPzn9hl6hCnNi3uyd6rUur4jiuGEal4Xx1hCETHdM/GhHWeenp4QP
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1675ef01-9e9f-425a-2c7f-08d76b6259ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2019 13:30:45.8213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LzyHO2dXAFayySJRwwWZGYAFfzj7+hLE9f/5g5OFMGDBZ0vpHKCuP2TfDcMTUJpuf5gWsj2rrbiVwJ6QiB7/aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6598
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add the needed infrastructure to allow users to create a CQ via the
mlx5dv interface.
Creation process requires CQInitAttrEx, similarly to the creation of
an extended CQ, but requires an Mlx5DVCQInitAttr object as well
(provided as kwargs, i.e. dv_init_attr=3D<your object>).

Signed-off-by: Noa Osherovich <noaos@mellanox.com>
---
 pyverbs/providers/mlx5/libmlx5.pxd      |   9 +++
 pyverbs/providers/mlx5/mlx5dv.pxd       |   7 ++
 pyverbs/providers/mlx5/mlx5dv.pyx       | 103 ++++++++++++++++++++++++
 pyverbs/providers/mlx5/mlx5dv_enums.pxd |   9 +++
 4 files changed, 128 insertions(+)

diff --git a/pyverbs/providers/mlx5/libmlx5.pxd b/pyverbs/providers/mlx5/li=
bmlx5.pxd
index 2c5be241a3ec..f471f2453e38 100644
--- a/pyverbs/providers/mlx5/libmlx5.pxd
+++ b/pyverbs/providers/mlx5/libmlx5.pxd
@@ -52,6 +52,12 @@ cdef extern from 'infiniband/mlx5dv.h':
         mlx5dv_dc_init_attr dc_init_attr
         unsigned long       send_ops_flags
=20
+    cdef struct mlx5dv_cq_init_attr:
+        unsigned long   comp_mask
+        unsigned char   cqe_comp_res_format
+        unsigned int    flags
+        unsigned short  cqe_size
+
     bool mlx5dv_is_supported(v.ibv_device *device)
     v.ibv_context* mlx5dv_open_device(v.ibv_device *device,
                                       mlx5dv_context_attr *attr)
@@ -59,3 +65,6 @@ cdef extern from 'infiniband/mlx5dv.h':
     v.ibv_qp *mlx5dv_create_qp(v.ibv_context *context,
                                v.ibv_qp_init_attr_ex *qp_attr,
                                mlx5dv_qp_init_attr *mlx5_qp_attr)
+    v.ibv_cq_ex *mlx5dv_create_cq(v.ibv_context *context,
+                                  v.ibv_cq_init_attr_ex *cq_attr,
+                                  mlx5dv_cq_init_attr *mlx5_cq_attr)
diff --git a/pyverbs/providers/mlx5/mlx5dv.pxd b/pyverbs/providers/mlx5/mlx=
5dv.pxd
index 918065012d30..cc9c89d82fa6 100644
--- a/pyverbs/providers/mlx5/mlx5dv.pxd
+++ b/pyverbs/providers/mlx5/mlx5dv.pxd
@@ -6,6 +6,7 @@
 cimport pyverbs.providers.mlx5.libmlx5 as dv
 from pyverbs.base cimport PyverbsObject
 from pyverbs.device cimport Context
+from pyverbs.cq cimport CQEX
 from pyverbs.qp cimport QP
=20
=20
@@ -26,3 +27,9 @@ cdef class Mlx5DVQPInitAttr(PyverbsObject):
=20
 cdef class Mlx5QP(QP):
     cdef object dc_type
+
+cdef class Mlx5DVCQInitAttr(PyverbsObject):
+    cdef dv.mlx5dv_cq_init_attr attr
+
+cdef class Mlx5CQ(CQEX):
+    pass
diff --git a/pyverbs/providers/mlx5/mlx5dv.pyx b/pyverbs/providers/mlx5/mlx=
5dv.pyx
index b4a971a5b935..e4500567ba23 100644
--- a/pyverbs/providers/mlx5/mlx5dv.pyx
+++ b/pyverbs/providers/mlx5/mlx5dv.pyx
@@ -7,6 +7,8 @@ cimport pyverbs.providers.mlx5.libmlx5 as dv
 from pyverbs.base import PyverbsRDMAErrno
 cimport pyverbs.libibverbs_enums as e
 from pyverbs.qp cimport QPInitAttrEx
+from pyverbs.cq cimport CqInitAttrEx
+cimport pyverbs.libibverbs as v
 from pyverbs.pd cimport PD
=20
 cdef class Mlx5DVContextAttr(PyverbsObject):
@@ -331,6 +333,107 @@ cdef class Mlx5QP(QP):
         return masks[self.dc_type][dst] | e.IBV_QP_STATE
=20
=20
+cdef class Mlx5DVCQInitAttr(PyverbsObject):
+    """
+    Represents mlx5dv_cq_init_attr struct, initial attributes used for mlx=
5 CQ
+    creation.
+    """
+    def __cinit__(self, comp_mask=3D0, cqe_comp_res_format=3D0, flags=3D0,=
 cqe_size=3D0):
+        """
+        Initializes an Mlx5CQInitAttr object with zeroes as default values=
.
+        :param comp_mask: Marks which of the following fields should be
+                          considered. Use mlx5dv_cq_init_attr_mask enum.
+        :param cqe_comp_res_format: The various CQE response formats of th=
e
+                                    responder side. Use
+                                    mlx5dv_cqe_comp_res_format enum.
+        :param flags: A bitwise OR of the various values described in
+                      mlx5dv_cq_init_attr_flags.
+        :param cqe_size: Configure the CQE size to be 64 or 128 bytes, oth=
er
+                         values will cause the CQ creation process to fail=
.
+                         Valid when MLX5DV_CQ_INIT_ATTR_MASK_CQE_SIZE is s=
et.
+        :return: None
+        """
+        self.attr.comp_mask =3D comp_mask
+        self.attr.cqe_comp_res_format =3D cqe_comp_res_format
+        self.attr.flags =3D flags
+        self.attr.cqe_size =3D cqe_size
+
+    @property
+    def comp_mask(self):
+        return self.attr.comp_mask
+    @comp_mask.setter
+    def comp_mask(self, val):
+        self.attr.comp_mask =3D val
+
+    @property
+    def cqe_comp_res_format(self):
+        return self.attr.cqe_comp_res_format
+    @cqe_comp_res_format.setter
+    def cqe_comp_res_format(self, val):
+        self.attr.cqe_comp_res_format =3D val
+
+    @property
+    def flags(self):
+        return self.attr.flags
+    @flags.setter
+    def flags(self, val):
+        self.attr.flags =3D val
+
+    @property
+    def cqe_size(self):
+        return self.attr.cqe_size
+    @cqe_size.setter
+    def cqe_size(self, val):
+        self.attr.cqe_size =3D val
+
+    def __str__(self):
+        print_format =3D '{:22}: {:<20}\n'
+        flags =3D {dve.MLX5DV_CQ_INIT_ATTR_FLAGS_CQE_PAD:
+                     "MLX5DV_CQ_INIT_ATTR_FLAGS_CQE_PAD}"}
+        mask =3D {dve.MLX5DV_CQ_INIT_ATTR_MASK_COMPRESSED_CQE:
+                    "MLX5DV_CQ_INIT_ATTR_MASK_COMPRESSED_CQE",
+                dve.MLX5DV_CQ_INIT_ATTR_MASK_FLAGS:
+                    "MLX5DV_CQ_INIT_ATTR_MASK_FLAGS",
+                dve.MLX5DV_CQ_INIT_ATTR_MASK_CQE_SIZE:
+                    "MLX5DV_CQ_INIT_ATTR_MASK_CQE_SIZE"}
+        fmt =3D {dve.MLX5DV_CQE_RES_FORMAT_HASH: "MLX5DV_CQE_RES_FORMAT_HA=
SH",
+               dve.MLX5DV_CQE_RES_FORMAT_CSUM: "MLX5DV_CQE_RES_FORMAT_CSUM=
",
+               dve.MLX5DV_CQE_RES_FORMAT_CSUM_STRIDX:
+                   "MLX5DV_CQE_RES_FORMAT_CSUM_STRIDX"}
+
+        return 'Mlx5DVCQInitAttr:\n' +\
+               print_format.format('comp_mask', bitmask_to_str(self.comp_m=
ask,
+                                                               mask)) +\
+               print_format.format('CQE compression format',
+                                   bitmask_to_str(self.cqe_comp_res_format=
,
+                                                  fmt)) +\
+               print_format.format('flags', bitmask_to_str(self.flags,
+                                                           flags)) + \
+               print_format.format('CQE size', self.cqe_size)
+
+
+cdef class Mlx5CQ(CQEX):
+    def __cinit__(self, Mlx5Context context, CqInitAttrEx init_attr,
+                  Mlx5DVCQInitAttr dv_init_attr):
+        self.cq =3D \
+            dv.mlx5dv_create_cq(context.context, &init_attr.attr,
+                                &dv_init_attr.attr if dv_init_attr is not =
None
+                                else NULL)
+        if self.cq =3D=3D NULL:
+            raise PyverbsRDMAErrno('Failed to create MLX5 CQ.\nCQInitAttrE=
x:\n'
+                                   '{}\nMLX5DVCQInitAttr:\n{}'.
+                                   format(init_attr, dv_init_attr))
+        self.ibv_cq =3D v.ibv_cq_ex_to_cq(self.cq)
+        self.context =3D context
+        context.add_ref(self)
+
+    def __str__(self):
+        print_format =3D '{:<22}: {:<20}\n'
+        return 'Mlx5 CQ:\n' +\
+               print_format.format('Handle', self.cq.handle) +\
+               print_format.format('CQEs', self.cq.cqe)
+
+
 def qpts_to_str(qp_types):
     numeric_types =3D qp_types
     qpts_str =3D ''
diff --git a/pyverbs/providers/mlx5/mlx5dv_enums.pxd b/pyverbs/providers/ml=
x5/mlx5dv_enums.pxd
index 3f7f591e23a5..3859dff81ad1 100644
--- a/pyverbs/providers/mlx5/mlx5dv_enums.pxd
+++ b/pyverbs/providers/mlx5/mlx5dv_enums.pxd
@@ -66,3 +66,12 @@ cdef extern from 'infiniband/mlx5dv.h':
     cpdef enum mlx5dv_qp_create_send_ops_flags:
         MLX5DV_QP_EX_WITH_MR_INTERLEAVED    =3D 1 << 0
         MLX5DV_QP_EX_WITH_MR_LIST           =3D 1 << 1
+
+    cpdef enum mlx5dv_cq_init_attr_mask:
+        MLX5DV_CQ_INIT_ATTR_MASK_COMPRESSED_CQE =3D 1 << 0
+        MLX5DV_CQ_INIT_ATTR_MASK_FLAGS          =3D 1 << 1
+        MLX5DV_CQ_INIT_ATTR_MASK_CQE_SIZE       =3D 1 << 2
+
+    cpdef enum mlx5dv_cq_init_attr_flags:
+        MLX5DV_CQ_INIT_ATTR_FLAGS_CQE_PAD   =3D 1 << 0
+        MLX5DV_CQ_INIT_ATTR_FLAGS_RESERVED  =3D 1 << 1
--=20
2.21.0

