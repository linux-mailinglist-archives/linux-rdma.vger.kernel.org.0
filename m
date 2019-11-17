Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7D6FFF9E0
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Nov 2019 14:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbfKQNav (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 17 Nov 2019 08:30:51 -0500
Received: from mail-eopbgr70077.outbound.protection.outlook.com ([40.107.7.77]:21606
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726151AbfKQNav (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 17 Nov 2019 08:30:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OrMw5kfcQ+lHJiS//jzytCY7pXBNxxuUSg7ldBKoiabMTGEV09GfIDJjU/XBf+GyEOgiKh+gBRIQlKKiVP0mu/15VclZdgk02RecXA8bH7g9Gzn2EhGNJuxAk4iFIdxodMBjRAZLpgAYAuwlrTUQ7qNjj3OzuKVkIRiZv4otKPhd/2CxgLEFR+xxKMObKWX7UoJnnKf/ZaJlI8134cUF7kjd/7QjRk/2azwyLR3HuhI+2TX4ognFICEDwryeRjyjZX5T+lD/ygS1yWx5nbCPvWNQQiHPRCBOD443bxNtkadFm+HQ9kAEAW4i6e7Vqt5yG7MVuUhDJjKR9u1YuGuw5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dv03pcCsy/fpJTL+sSs3uMILuZjEKAfKh2GXUOF56Lk=;
 b=QbpXiEnUDqAutAOAykQRENfHCTUYspXG630b9yi1nf+tkifMdJNrtqIobyTKgWDZH1SW/dtDINSpCn0Qz/ntW6W4VaBjfy3pM8htxex6yikm9lHykFBfxnQ7QOYZm0l5I310y/oQ+TqyhKjn+knMvRYHXVzDs2tsaDHI7lSLoBDZVakJ35M4K4ENIeZETgiNoFlePh0P4Gad8E/a8pl52+UCytb5VRCra6eg9uLm5veYQqegd+0jMYDfjxGhRb7rJYMGCzAk8YXfmOuxlSMEtRwUb/g1oUkeLBEkDVRoJNdtAz/D2xVbO3PjmP52Er3SW5/B94+cmWyvi55wk35wUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dv03pcCsy/fpJTL+sSs3uMILuZjEKAfKh2GXUOF56Lk=;
 b=WxmoeHpC77V430JNrCLnsmC7jOI12hObLvhA3miLB0ok4s8iiF3fh1ibsMtcFvPkqdZI4+azvzuNw52zo8L7usieT5pGGkosk4Wu2ENKi7h3gPuWPSBc4XbObRXFkpeyvjVTaCv6MDIgpEAhmf9sfsujwOF3fdBfAl7YCkjsUM0=
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com (20.177.33.17) by
 AM6PR05MB6598.eurprd05.prod.outlook.com (20.179.3.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Sun, 17 Nov 2019 13:30:43 +0000
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::505f:e3f8:3f87:e3ff]) by AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::505f:e3f8:3f87:e3ff%7]) with mapi id 15.20.2451.029; Sun, 17 Nov 2019
 13:30:43 +0000
From:   Noa Osherovich <noaos@mellanox.com>
To:     "dledford@redhat.com" <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Noa Osherovich <noaos@mellanox.com>
Subject: [PATCH rdma-core 2/7] pyverbs/mlx5: Add support for mlx5 QP
Thread-Topic: [PATCH rdma-core 2/7] pyverbs/mlx5: Add support for mlx5 QP
Thread-Index: AQHVnUs18TufquZgWEKZii7MQLBD6Q==
Date:   Sun, 17 Nov 2019 13:30:43 +0000
Message-ID: <20191117133030.10784-3-noaos@mellanox.com>
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
x-ms-office365-filtering-correlation-id: 237b8f74-ff81-4d8e-cef9-08d76b625851
x-ms-traffictypediagnostic: AM6PR05MB6598:|AM6PR05MB6598:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR05MB6598BE4D7A2A30E54CDB4AA0D9720@AM6PR05MB6598.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 02243C58C6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(189003)(199004)(71200400001)(71190400001)(102836004)(6116002)(386003)(6506007)(256004)(11346002)(3846002)(2616005)(26005)(36756003)(446003)(5660300002)(86362001)(8936002)(186003)(64756008)(66556008)(66476007)(66946007)(7736002)(50226002)(66446008)(305945005)(66066001)(2501003)(81166006)(81156014)(8676002)(99286004)(6636002)(25786009)(76176011)(478600001)(14454004)(1076003)(2906002)(6436002)(6486002)(14444005)(54906003)(6512007)(476003)(107886003)(110136005)(52116002)(30864003)(486006)(316002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB6598;H:AM6PR05MB4968.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nYubCniFrFGsIzT/OjQYL7HlvUBoyFnVoSj7J2a5KOGoWq+cXg3+IsoNX+zKkBeY62p6nC2aKVapynbDsWvBVuzyVGH0M8dbKx+yr2pqYX3db4GS/gHW6oUuvK7SdwwjgGcL/5PfeyfSvt2LOEwqN6OKni3odb38vHWFUFNIAft6aZCRjgWJkX1nlvPyZLYDrbjQgeZPZ+FZvqYmk6FbO8fOIGsk3/3ZJJquA4rbp8vk3sBhzDyXJGI1ZVgVKE2BhR8LdLnlcr5BUdAK7aLsEHdN76lnObTpuQ030WLpHEcePzx9iGfB7CONg6y+sHHULRs8CEx9/8kexhvy+S2JKYIOxCxGgjKmlAZHUFmovJh8qYll+duJ6YFzGUhFVBEyHlD9YxmUU0XtMgqr9QZxugrh8bO4JjrIF++Iyj0pzPjyufA8+8uLXgeummcYepwc
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 237b8f74-ff81-4d8e-cef9-08d76b625851
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2019 13:30:43.1847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i2zdzB6h1nwKf2iTmiAZ7hUMZVJUdIYNkasbN/3mLToqB5CPToHh8aWYdhmIQjE6S94JLwAM+EtPM68Rsv6yug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6598
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add the needed declarations and structs to allow users to create a QP
via the mlx5dv interface.
Creation process is similar to that of a legacy QP but the user shall
use an Mlx5Context and provide an Mlx5DVQPInitAttr object as well as
a QPInitAttrEx object.

Signed-off-by: Noa Osherovich <noaos@mellanox.com>
---
 pyverbs/providers/mlx5/libmlx5.pxd      |  15 ++
 pyverbs/providers/mlx5/mlx5dv.pxd       |  11 ++
 pyverbs/providers/mlx5/mlx5dv.pyx       | 192 +++++++++++++++++++++++-
 pyverbs/providers/mlx5/mlx5dv_enums.pxd |  21 +++
 4 files changed, 236 insertions(+), 3 deletions(-)

diff --git a/pyverbs/providers/mlx5/libmlx5.pxd b/pyverbs/providers/mlx5/li=
bmlx5.pxd
index aaf75620a9bb..2c5be241a3ec 100644
--- a/pyverbs/providers/mlx5/libmlx5.pxd
+++ b/pyverbs/providers/mlx5/libmlx5.pxd
@@ -1,6 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
 # Copyright (c) 2019 Mellanox Technologies, Inc. All rights reserved. See =
COPYING file
=20
+include 'mlx5dv_enums.pxd'
+
 from libcpp cimport bool
=20
 cimport pyverbs.libibverbs as v
@@ -40,7 +42,20 @@ cdef extern from 'infiniband/mlx5dv.h':
         unsigned int            flow_action_flags
         unsigned int            dc_odp_caps
=20
+    cdef struct mlx5dv_dc_init_attr:
+        mlx5dv_dc_type      dc_type
+        unsigned long       dct_access_key
+
+    cdef struct mlx5dv_qp_init_attr:
+        unsigned long       comp_mask
+        unsigned int        create_flags
+        mlx5dv_dc_init_attr dc_init_attr
+        unsigned long       send_ops_flags
+
     bool mlx5dv_is_supported(v.ibv_device *device)
     v.ibv_context* mlx5dv_open_device(v.ibv_device *device,
                                       mlx5dv_context_attr *attr)
     int mlx5dv_query_device(v.ibv_context *ctx, mlx5dv_context *attrs_out)
+    v.ibv_qp *mlx5dv_create_qp(v.ibv_context *context,
+                               v.ibv_qp_init_attr_ex *qp_attr,
+                               mlx5dv_qp_init_attr *mlx5_qp_attr)
diff --git a/pyverbs/providers/mlx5/mlx5dv.pxd b/pyverbs/providers/mlx5/mlx=
5dv.pxd
index d9fea82af894..918065012d30 100644
--- a/pyverbs/providers/mlx5/mlx5dv.pxd
+++ b/pyverbs/providers/mlx5/mlx5dv.pxd
@@ -6,6 +6,8 @@
 cimport pyverbs.providers.mlx5.libmlx5 as dv
 from pyverbs.base cimport PyverbsObject
 from pyverbs.device cimport Context
+from pyverbs.qp cimport QP
+
=20
 cdef class Mlx5Context(Context):
     pass
@@ -15,3 +17,12 @@ cdef class Mlx5DVContextAttr(PyverbsObject):
=20
 cdef class Mlx5DVContext(PyverbsObject):
     cdef dv.mlx5dv_context dv
+
+cdef class Mlx5DVDCInitAttr(PyverbsObject):
+    cdef dv.mlx5dv_dc_init_attr attr
+
+cdef class Mlx5DVQPInitAttr(PyverbsObject):
+    cdef dv.mlx5dv_qp_init_attr attr
+
+cdef class Mlx5QP(QP):
+    cdef object dc_type
diff --git a/pyverbs/providers/mlx5/mlx5dv.pyx b/pyverbs/providers/mlx5/mlx=
5dv.pyx
index dadc9cdcceee..b4a971a5b935 100644
--- a/pyverbs/providers/mlx5/mlx5dv.pyx
+++ b/pyverbs/providers/mlx5/mlx5dv.pyx
@@ -6,7 +6,8 @@ cimport pyverbs.providers.mlx5.mlx5dv_enums as dve
 cimport pyverbs.providers.mlx5.libmlx5 as dv
 from pyverbs.base import PyverbsRDMAErrno
 cimport pyverbs.libibverbs_enums as e
-
+from pyverbs.qp cimport QPInitAttrEx
+from pyverbs.pd cimport PD
=20
 cdef class Mlx5DVContextAttr(PyverbsObject):
     """
@@ -179,8 +180,159 @@ cdef class Mlx5DVContext(PyverbsObject):
                print_format.format('DC ODP caps', self.dv.dc_odp_caps)
=20
=20
+cdef class Mlx5DVDCInitAttr(PyverbsObject):
+    """
+    Represents mlx5dv_dc_init_attr struct, which defines initial attribute=
s
+    for DC QP creation.
+    """
+    def __cinit__(self, dc_type=3Ddve.MLX5DV_DCTYPE_DCI, dct_access_key=3D=
0):
+        """
+        Initializes an Mlx5DVDCInitAttr object with the given DC type and =
DCT
+        access key.
+        :param dc_type: Which DC QP to create (DCI/DCT).
+        :param dct_access_key: Access key to be used by the DCT
+        :return: An initializes object
+        """
+        self.attr.dc_type =3D dc_type
+        self.attr.dct_access_key =3D dct_access_key
+
+    def __str__(self):
+        print_format =3D '{:20}: {:<20}\n'
+        return print_format.format('DC type', dc_type_to_str(self.attr.dc_=
type)) +\
+               print_format.format('DCT access key', self.attr.dct_access_=
key)
+
+    @property
+    def dc_type(self):
+        return self.attr.dc_type
+    @dc_type.setter
+    def dc_type(self, val):
+        self.attr.dc_type =3D val
+
+    @property
+    def dct_access_key(self):
+        return self.attr.dct_access_key
+    @dct_access_key.setter
+    def dct_access_key(self, val):
+        self.attr.dct_access_key =3D val
+
+
+cdef class Mlx5DVQPInitAttr(PyverbsObject):
+    """
+    Represents mlx5dv_qp_init_attr struct, initial attributes used for mlx=
5 QP
+    creation.
+    """
+    def __cinit__(self, comp_mask=3D0, create_flags=3D0,
+                  Mlx5DVDCInitAttr dc_init_attr=3DNone, send_ops_flags=3D0=
):
+        """
+        Initializes an Mlx5DVQPInitAttr object with the given user data.
+        :param comp_mask: A bitmask specifying which fields are valid
+        :param create_flags: A bitwise OR of mlx5dv_qp_create_flags
+        :param dc_init_attr: Mlx5DVDCInitAttr object
+        :param send_ops_flags: A bitwise OR of mlx5dv_qp_create_send_ops_f=
lags
+        :return: An initialized Mlx5DVQPInitAttr object
+        """
+        self.attr.comp_mask =3D comp_mask
+        self.attr.create_flags =3D create_flags
+        self.attr.send_ops_flags =3D send_ops_flags
+        if dc_init_attr is not None:
+            self.attr.dc_init_attr.dc_type =3D dc_init_attr.dc_type
+            self.attr.dc_init_attr.dct_access_key =3D dc_init_attr.dct_acc=
ess_key
+
+    def __str__(self):
+        print_format =3D '{:20}: {:<20}\n'
+        return print_format.format('Comp mask',
+                                   qp_comp_mask_to_str(self.attr.comp_mask=
)) +\
+               print_format.format('Create flags',
+                                   qp_create_flags_to_str(self.attr.create=
_flags)) +\
+               'DC init attr:\n' +\
+               print_format.format('  DC type',
+                                   dc_type_to_str(self.attr.dc_init_attr.d=
c_type)) +\
+               print_format.format('  DCT access key',
+                                   self.attr.dc_init_attr.dct_access_key) =
+\
+               print_format.format('Send ops flags',
+                                   send_ops_flags_to_str(self.attr.send_op=
s_flags))
+
+    @property
+    def comp_mask(self):
+        return self.attr.comp_mask
+    @comp_mask.setter
+    def comp_mask(self, val):
+        self.attr.comp_mask =3D val
+
+    @property
+    def create_flags(self):
+        return self.attr.create_flags
+    @create_flags.setter
+    def create_flags(self, val):
+        self.attr.create_flags =3D val
+
+    @property
+    def send_ops_flags(self):
+        return self.attr.send_ops_flags
+    @send_ops_flags.setter
+    def send_ops_flags(self, val):
+        self.attr.send_ops_flags =3D val
+
+    @property
+    def dc_type(self):
+        return self.attr.dc_init_attr.dc_type
+    @dc_type.setter
+    def dc_type(self, val):
+        self.attr.dc_init_attr.dc_type =3D val
+
+    @property
+    def dct_access_key(self):
+        return self.attr.dc_init_attr.dct_access_key
+    @dct_access_key.setter
+    def dct_access_key(self, val):
+        self.attr.dc_init_attr.dct_access_key =3D val
+
+
+cdef class Mlx5QP(QP):
+    def __cinit__(self, Mlx5Context context, QPInitAttrEx init_attr,
+                  Mlx5DVQPInitAttr dv_init_attr):
+        """
+        Initializes an mlx5 QP according to the user-provided data.
+        :param context: mlx5 Context object
+        :param init_attr: QPInitAttrEx object
+        :param dv_init_attr: Mlx5DVQPInitAttr object
+        :return: An initialized Mlx5QP
+        """
+        cdef PD pd
+        self.dc_type =3D dv_init_attr.dc_type if dv_init_attr else 0
+        if init_attr.pd is not None:
+            pd =3D <PD>init_attr.pd
+            pd.add_ref(self)
+        self.qp =3D \
+            dv.mlx5dv_create_qp(context.context,
+                                &init_attr.attr,
+                                &dv_init_attr.attr if dv_init_attr is not =
None
+                                else NULL)
+        if self.qp =3D=3D NULL:
+            raise PyverbsRDMAErrno('Failed to create MLX5 QP.\nQPInitAttrE=
x '
+                                   'attributes:\n{}\nMLX5DVQPInitAttr:\n{}=
'.
+                                   format(init_attr, dv_init_attr))
+
+    def _get_comp_mask(self, dst):
+        masks =3D {dve.MLX5DV_DCTYPE_DCT: {'INIT': e.IBV_QP_PKEY_INDEX |
+                                         e.IBV_QP_PORT | e.IBV_QP_ACCESS_F=
LAGS,
+                                         'RTR': e.IBV_QP_AV |\
+                                         e.IBV_QP_PATH_MTU |\
+                                         e.IBV_QP_MIN_RNR_TIMER},
+                 dve.MLX5DV_DCTYPE_DCI: {'INIT': e.IBV_QP_PKEY_INDEX |\
+                                         e.IBV_QP_PORT,
+                                         'RTR': e.IBV_QP_PATH_MTU,
+                                         'RTS': e.IBV_QP_TIMEOUT |\
+                                         e.IBV_QP_RETRY_CNT |\
+                                         e.IBV_QP_RNR_RETRY | e.IBV_QP_SQ_=
PSN |\
+                                         e.IBV_QP_MAX_QP_RD_ATOMIC}}
+        if self.dc_type =3D=3D 0:
+            return super()._get_comp_mask(dst)
+        return masks[self.dc_type][dst] | e.IBV_QP_STATE
+
+
 def qpts_to_str(qp_types):
-    numberic_types =3D qp_types
+    numeric_types =3D qp_types
     qpts_str =3D ''
     qpts =3D {e.IBV_QPT_RC: 'RC', e.IBV_QPT_UC: 'UC', e.IBV_QPT_UD: 'UD',
             e.IBV_QPT_RAW_PACKET: 'Raw Packet', e.IBV_QPT_XRC_SEND: 'XRC S=
end',
@@ -191,7 +343,7 @@ def qpts_to_str(qp_types):
             qp_types -=3D t
         if qp_types =3D=3D 0:
             break
-    return qpts_str[:-2] + ' ({})'.format(numberic_types)
+    return qpts_str[:-2] + ' ({})'.format(numeric_types)
=20
=20
 def bitmask_to_str(bits, values):
@@ -251,3 +403,37 @@ def tunnel_offloads_to_str(tun):
          dve.MLX5DV_RAW_PACKET_CAP_TUNNELED_OFFLOAD_CW_MPLS_OVER_UDP:\
          'Ctrl word + MPLS over UDP'}
     return bitmask_to_str(tun, l)
+
+
+def dc_type_to_str(dctype):
+    l =3D {dve.MLX5DV_DCTYPE_DCT: 'DCT', dve.MLX5DV_DCTYPE_DCI: 'DCI'}
+    try:
+        return l[dctype]
+    except KeyError:
+        return 'Unknown DC type ({dc})'.format(dc=3Ddctype)
+
+
+def qp_comp_mask_to_str(flags):
+    l =3D {dve.MLX5DV_QP_INIT_ATTR_MASK_QP_CREATE_FLAGS: 'Create flags',
+         dve.MLX5DV_QP_INIT_ATTR_MASK_DC: 'DC',
+         dve.MLX5DV_QP_INIT_ATTR_MASK_SEND_OPS_FLAGS: 'Send ops flags'}
+    return bitmask_to_str(flags, l)
+
+
+def qp_create_flags_to_str(flags):
+    l =3D {dve.MLX5DV_QP_CREATE_TUNNEL_OFFLOADS: 'Tunnel offloads',
+         dve.MLX5DV_QP_CREATE_TIR_ALLOW_SELF_LOOPBACK_UC:
+             'Allow UC self loopback',
+         dve.MLX5DV_QP_CREATE_TIR_ALLOW_SELF_LOOPBACK_MC:
+             'Allow MC self loopback',
+         dve.MLX5DV_QP_CREATE_DISABLE_SCATTER_TO_CQE: 'Disable scatter to =
CQE',
+         dve.MLX5DV_QP_CREATE_ALLOW_SCATTER_TO_CQE: 'Allow scatter to CQE'=
,
+         dve.MLX5DV_QP_CREATE_PACKET_BASED_CREDIT_MODE:
+             'Packet based credit mode'}
+    return bitmask_to_str(flags, l)
+
+
+def send_ops_flags_to_str(flags):
+    l =3D {dve.MLX5DV_QP_EX_WITH_MR_INTERLEAVED: 'With MR interleaved',
+         dve.MLX5DV_QP_EX_WITH_MR_LIST: 'With MR list'}
+    return bitmask_to_str(flags, l)
diff --git a/pyverbs/providers/mlx5/mlx5dv_enums.pxd b/pyverbs/providers/ml=
x5/mlx5dv_enums.pxd
index 038a49111a3b..3f7f591e23a5 100644
--- a/pyverbs/providers/mlx5/mlx5dv_enums.pxd
+++ b/pyverbs/providers/mlx5/mlx5dv_enums.pxd
@@ -45,3 +45,24 @@ cdef extern from 'infiniband/mlx5dv.h':
         MLX5DV_FLOW_ACTION_FLAGS_ESP_AES_GCM_SPI_STEERING   =3D 1 << 2
         MLX5DV_FLOW_ACTION_FLAGS_ESP_AES_GCM_FULL_OFFLOAD   =3D 1 << 3
         MLX5DV_FLOW_ACTION_FLAGS_ESP_AES_GCM_TX_IV_IS_ESN   =3D 1 << 4
+
+    cpdef enum mlx5dv_qp_init_attr_mask:
+        MLX5DV_QP_INIT_ATTR_MASK_QP_CREATE_FLAGS    =3D 1 << 0
+        MLX5DV_QP_INIT_ATTR_MASK_DC                 =3D 1 << 1
+        MLX5DV_QP_INIT_ATTR_MASK_SEND_OPS_FLAGS     =3D 1 << 2
+
+    cpdef enum mlx5dv_qp_create_flags:
+        MLX5DV_QP_CREATE_TUNNEL_OFFLOADS            =3D 1 << 0
+        MLX5DV_QP_CREATE_TIR_ALLOW_SELF_LOOPBACK_UC =3D 1 << 1
+        MLX5DV_QP_CREATE_TIR_ALLOW_SELF_LOOPBACK_MC =3D 1 << 2
+        MLX5DV_QP_CREATE_DISABLE_SCATTER_TO_CQE     =3D 1 << 3
+        MLX5DV_QP_CREATE_ALLOW_SCATTER_TO_CQE       =3D 1 << 4
+        MLX5DV_QP_CREATE_PACKET_BASED_CREDIT_MODE   =3D 1 << 5
+
+    cpdef enum mlx5dv_dc_type:
+        MLX5DV_DCTYPE_DCT   =3D 1
+        MLX5DV_DCTYPE_DCI   =3D 2
+
+    cpdef enum mlx5dv_qp_create_send_ops_flags:
+        MLX5DV_QP_EX_WITH_MR_INTERLEAVED    =3D 1 << 0
+        MLX5DV_QP_EX_WITH_MR_LIST           =3D 1 << 1
--=20
2.21.0

