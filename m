Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0CA124787
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Dec 2019 14:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfLRNCp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Dec 2019 08:02:45 -0500
Received: from mail-eopbgr30089.outbound.protection.outlook.com ([40.107.3.89]:39813
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726718AbfLRNCp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 18 Dec 2019 08:02:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hGq32mRPd3TCDFyS9L5ioVFfnYdk7QgOUilAIJ2wS5s2HWY7DYKKN4qNu0sBzn7l0NHTobv+uPPSp9cZV5lHIKkpQv78AouV5TvWWjRPzs9xxKKfc3wl+ylPC3r/aVnwhzISAP1O5IF+erOacyhVR/1bSOHQKEqldfVhQKnyqUYc9b5Ng4+bT4LrIs/ixr56vdA23w1SGtGVwQ1SoH74cO1hbERxti0x1qH9K4Ir5binPYjye9YXGTpVGMPu2haUjKL8W1/VBAArhWAU7YhBaNTi6UC61Guc8OhDTSeoq5+ZwA3BzS5jS22K4nwYuOLaq8LUat9wDD9qSsxheeo62Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2AqHPT2ohO1yS5/I9jQolFzli6iT1h5VnsuPXb+Bp0=;
 b=TAvYyne1hhMHPZJ+u3WM3iXzvPIs12+s+ZUM4nKW+PB/gQNYyXgSN8phACVKCnyWAN8BOcPTEPzlTjEKynrNbNICB55KCpewLR4pvLSLBGGMPuSa4zuOeNZgMzsw93nJ3w9XVa0NJwBRA5MzCLGX47Bn+Q6vq69z54DXyq9q7oE6DzfR6611Zm26pENxYGezjD06NfmlQjpBen00CwSqC2YcL/wdwjEFR7n+ayJMGwWFj3isYyn5jRFcLgM9Sh7PBmlgit1qmE1GxTgxmiZjLwD+GpNKT0+O8jzUdX6dkSghyR/+N7Hyp4C0FNyUsypie4rdqRptR38GpFR5bPpzJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2AqHPT2ohO1yS5/I9jQolFzli6iT1h5VnsuPXb+Bp0=;
 b=frErtVCyjXZfivM1jGcBx5dO7VBuwVP49B2+zYIwyFcT2iAVPRfHgZFHhD565HYlweZnzjNL1Os072gMqpJ1SOdHoMEJ2L66io39uWh9+knRfPphhMhYQcg0Ml1XUTsQTwZ+0X3YUmeNKcg7ct6OLJx81hahAm8obwMosd1fyNE=
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com (20.177.33.17) by
 AM6PR05MB5093.eurprd05.prod.outlook.com (20.177.35.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.20; Wed, 18 Dec 2019 13:02:30 +0000
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::bc8c:12ca:edd3:92ca]) by AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::bc8c:12ca:edd3:92ca%4]) with mapi id 15.20.2538.019; Wed, 18 Dec 2019
 13:02:30 +0000
From:   Noa Osherovich <noaos@mellanox.com>
To:     "dledford@redhat.com" <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Noa Osherovich <noaos@mellanox.com>,
        Edward Srouji <edwards@mellanox.com>
Subject: [PATCH rdma-core 2/3] pyverbs: Refactor objects creation process
Thread-Topic: [PATCH rdma-core 2/3] pyverbs: Refactor objects creation process
Thread-Index: AQHVtaNnhPbY37xMREm+zdBE3167bA==
Date:   Wed, 18 Dec 2019 13:02:30 +0000
Message-ID: <20191218130216.503-3-noaos@mellanox.com>
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
x-ms-office365-filtering-correlation-id: cfab58bd-5c3f-4c97-f10d-08d783ba8a40
x-ms-traffictypediagnostic: AM6PR05MB5093:|AM6PR05MB5093:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR05MB50933820772A3625D599A266D9530@AM6PR05MB5093.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1201;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(199004)(189003)(30864003)(86362001)(1076003)(316002)(6486002)(478600001)(6506007)(5660300002)(66446008)(64756008)(66556008)(66946007)(186003)(6636002)(2906002)(26005)(81166006)(107886003)(8676002)(81156014)(52116002)(66476007)(71200400001)(6512007)(54906003)(36756003)(2616005)(110136005)(4326008)(8936002)(569006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB5093;H:AM6PR05MB4968.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O+4NMrlWOfS9aV5/J1/ARYBA0BDuQdlY1FrycmeG/5eID6OGbaHN2gTNYY+pbhRTt+z5PKFAzRGEeF5u8efIAOCvbozi9oNEisWPbKY8QwvJ5nEHF6TQ3w+kr62ScpsCS7cwe45RKzZgp7dgUJnYHJpsKxl/eX/S/EWekh4FpPV7yLZo5BgOBeQSpOmqehTl1ngERPMdGypU8CD13snzzrB0e4K6kE5I7uUciOED3kGz9IbJStRqf5lQa/OZA7dJBxy7XZOKKKIXs9I3IR2JcTRZP/NU/fj9S++/5wgowGnyRyE84N75FQorUdGPG0+Hd7ui+OQDEtucydaI7segeGCou3Dp5QDCFMUFf8LbdPPgHz3XVeKDp58r1gz04wd6OMpRDpHLpO8d0PHIH4d/b76Xn6MRzuh+5CEHshDL48LB268y5WHsPn+SMwgKcQDuTLBYAGqjYtBCwVm/CjkuqdUqXvvEWcaXlBFxiv1ZtoE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfab58bd-5c3f-4c97-f10d-08d783ba8a40
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 13:02:30.6779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1aUOsqbsLUVESNRSeY1gP3HGah2tXPbhtQW4xVQmsznqbfaCTEySvoJTG2sJ/pIjRYQfCKLwmpIE7od+c0Znuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5093
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Pyverbs started out using Cython's __cinit__ method to initialize
the underlying C objects. This is not recommended as the Python
object may not be fully valid at this point.
Move initialization to Python's __init__ instead. In addition, using
__init__ allows us to control when and if the parent class's
constructor is called.

Signed-off-by: Noa Osherovich <noaos@mellanox.com>
Reviewed-by: Edward Srouji <edwards@mellanox.com>
---
 pyverbs/addr.pyx                  | 23 ++++----
 pyverbs/base.pyx                  |  4 +-
 pyverbs/cmid.pyx                  | 14 +++--
 pyverbs/cq.pyx                    | 26 +++++----
 pyverbs/device.pyx                | 37 +++++++------
 pyverbs/mr.pyx                    | 40 +++++++-------
 pyverbs/pd.pyx                    | 38 +++++++-------
 pyverbs/providers/mlx5/mlx5dv.pyx | 49 ++++++++++-------
 pyverbs/qp.pyx                    | 87 ++++++++++++++++---------------
 pyverbs/srq.pyx                   | 20 ++++---
 pyverbs/wr.pyx                    | 14 +++--
 pyverbs/xrcd.pyx                  |  6 ++-
 12 files changed, 200 insertions(+), 158 deletions(-)

diff --git a/pyverbs/addr.pyx b/pyverbs/addr.pyx
index 462a45bc7a4a..2ba611c26a89 100644
--- a/pyverbs/addr.pyx
+++ b/pyverbs/addr.pyx
@@ -18,7 +18,8 @@ cdef class GID(PyverbsObject):
     """
     GID class represents ibv_gid. It enables user to query for GIDs values=
.
     """
-    def __cinit__(self, val=3DNone):
+    def __init__(self, val=3DNone):
+        super().__init__()
         if val is not None:
             vals =3D gid_str_to_array(val)
=20
@@ -59,8 +60,8 @@ cdef class GRH(PyverbsObject):
     Represents ibv_grh struct. Used when creating or initializing an
     Address Handle from a Work Completion.
     """
-    def __cinit__(self, GID sgid=3DNone, GID dgid=3DNone, version_tclass_f=
low=3D0,
-                  paylen=3D0, next_hdr=3D0, hop_limit=3D1):
+    def __init__(self, GID sgid=3DNone, GID dgid=3DNone, version_tclass_fl=
ow=3D0,
+                 paylen=3D0, next_hdr=3D0, hop_limit=3D1):
         """
         Initializes a GRH object
         :param sgid: Source GID
@@ -78,6 +79,7 @@ cdef class GRH(PyverbsObject):
                           prior to being discarded
         :return: A GRH object
         """
+        super().__init__()
         self.grh.dgid =3D dgid.gid
         self.grh.sgid =3D sgid.gid
         self.grh.version_tclass_flow =3D version_tclass_flow
@@ -150,8 +152,8 @@ cdef class GlobalRoute(PyverbsObject):
     the values to be used in the GRH of the packets that will be sent usin=
g
     this Address Handle.
     """
-    def __cinit__(self, GID dgid=3DNone, flow_label=3D0, sgid_index=3D0, h=
op_limit=3D1,
-                  traffic_class=3D0):
+    def __init__(self, GID dgid=3DNone, flow_label=3D0, sgid_index=3D0, ho=
p_limit=3D1,
+                 traffic_class=3D0):
         """
         Initializes a GlobalRoute object with given parameters.
         :param dgid: Destination GID
@@ -167,6 +169,7 @@ cdef class GlobalRoute(PyverbsObject):
                               delivery priority for routers
         :return: A GlobalRoute object
         """
+        super().__init__()
         self.gr.dgid=3Ddgid.gid
         self.gr.flow_label =3D flow_label
         self.gr.sgid_index =3D sgid_index
@@ -222,8 +225,8 @@ cdef class GlobalRoute(PyverbsObject):
=20
 cdef class AHAttr(PyverbsObject):
     """ Represents ibv_ah_attr struct """
-    def __cinit__(self, dlid=3D0, sl=3D0, src_path_bits=3D0, static_rate=
=3D0,
-                  is_global=3D0, port_num=3D1, GlobalRoute gr=3DNone):
+    def __init__(self, dlid=3D0, sl=3D0, src_path_bits=3D0, static_rate=3D=
0,
+                 is_global=3D0, port_num=3D1, GlobalRoute gr=3DNone):
         """
         Initializes an AHAttr object.
         :param dlid: Destination LID, a 16b unsigned integer
@@ -242,6 +245,7 @@ cdef class AHAttr(PyverbsObject):
                     is_global is non zero.
         :return: An AHAttr object
         """
+        super().__init__()
         self.ah_attr.port_num =3D port_num
         self.ah_attr.sl =3D sl
         self.ah_attr.src_path_bits =3D src_path_bits
@@ -363,7 +367,7 @@ cdef class AHAttr(PyverbsObject):
=20
=20
 cdef class AH(PyverbsCM):
-    def __cinit__(self, PD pd, **kwargs):
+    def __init__(self, PD pd, **kwargs):
         """
         Initializes an AH object with the given values.
         Two creation methods are supported:
@@ -371,7 +375,7 @@ cdef class AH(PyverbsCM):
         - Creation via a WC object (calls ibv_create_ah_from_wc)
         :param pd: PD object this AH belongs to
         :param kwargs: Arguments:
-           * *attr* (AHAttr)
+            * *attr* (AHAttr)
                An AHAttr object (represents ibv_ah_attr struct)
             * *wc*
                A WC object to use for AH initialization
@@ -381,6 +385,7 @@ cdef class AH(PyverbsCM):
                Port number to be used for this AH (when using wc)
         :return: An AH object on success
         """
+        super().__init__()
         if len(kwargs) =3D=3D 1:
             # Create AH via ib_create_ah
             ah_attr =3D <AHAttr>kwargs['attr']
diff --git a/pyverbs/base.pyx b/pyverbs/base.pyx
index d69516285ece..c5b16795ddb6 100644
--- a/pyverbs/base.pyx
+++ b/pyverbs/base.pyx
@@ -5,9 +5,11 @@ import logging
 from pyverbs.pyverbs_error import PyverbsRDMAError
 from libc.errno cimport errno
=20
+
 cpdef PyverbsRDMAErrno(str msg):
     return PyverbsRDMAError(msg, errno)
=20
+
 LOG_LEVEL=3Dlogging.INFO
 LOG_FORMAT=3D'[%(levelname)s] %(asctime)s %(filename)s:%(lineno)s: %(messa=
ge)s'
 logging.basicConfig(format=3DLOG_FORMAT, level=3DLOG_LEVEL, datefmt=3D'%d =
%b %Y %H:%M:%S')
@@ -38,7 +40,7 @@ cdef close_weakrefs(iterables):
=20
 cdef class PyverbsObject(object):
=20
-    def __cinit__(self):
+    def __init__(self):
         self.logger =3D logging.getLogger(self.__class__.__name__)
=20
     def set_log_level(self, val):
diff --git a/pyverbs/cmid.pyx b/pyverbs/cmid.pyx
index c752feda8781..5e4401436105 100755
--- a/pyverbs/cmid.pyx
+++ b/pyverbs/cmid.pyx
@@ -13,8 +13,8 @@ from pyverbs.cq cimport WC
=20
 cdef class ConnParam(PyverbsObject):
=20
-    def __cinit__(self, resources=3D1, depth=3D1, flow_control=3D0, retry=
=3D5,
-                  rnr_retry=3D5, srq=3D0, qp_num=3D0):
+    def __init__(self, resources=3D1, depth=3D1, flow_control=3D0, retry=
=3D5,
+                 rnr_retry=3D5, srq=3D0, qp_num=3D0):
         """
         Initialize a ConnParam object over an underlying rdma_conn_param
         C object which contains connection parameters. There are a few typ=
es of
@@ -38,6 +38,7 @@ cdef class ConnParam(PyverbsObject):
                        CMID.
         :return: ConnParam object
         """
+        super().__init__()
         memset(&self.conn_param, 0, sizeof(cm.rdma_conn_param))
         self.conn_param.responder_resources =3D resources
         self.conn_param.initiator_depth =3D depth
@@ -60,7 +61,7 @@ cdef class ConnParam(PyverbsObject):
=20
=20
 cdef class AddrInfo(PyverbsObject):
-    def __cinit__(self, node=3DNone, service=3DNone, port_space=3D0, flags=
=3D0):
+    def __init__(self, node=3DNone, service=3DNone, port_space=3D0, flags=
=3D0):
         """
         Initialize an AddrInfo object over an underlying rdma_addrinfo C o=
bject.
         :param node: Name, dotted-decimal IPv4 or IPv6 hex address to reso=
lve.
@@ -75,6 +76,7 @@ cdef class AddrInfo(PyverbsObject):
         cdef cm.rdma_addrinfo hints
         cdef cm.rdma_addrinfo *hints_ptr =3D NULL
=20
+        super().__init__()
         if node is not None:
             node =3D node.encode('utf-8')
             address =3D <char*>node
@@ -102,8 +104,8 @@ cdef class AddrInfo(PyverbsObject):
=20
 cdef class CMID(PyverbsCM):
=20
-    def __cinit__(self, object creator=3DNone, QPInitAttr qp_init_attr=3DN=
one,
-                  PD pd=3DNone):
+    def __init__(self, object creator=3DNone, QPInitAttr qp_init_attr=3DNo=
ne,
+                 PD pd=3DNone):
         """
         Initialize a CMID object over an underlying rdma_cm_id C object.
         This is the main RDMA CM object which provides most of the rdmacm =
API.
@@ -118,6 +120,8 @@ cdef class CMID(PyverbsCM):
         """
         cdef v.ibv_qp_init_attr *init
         cdef v.ibv_pd *in_pd =3D NULL
+
+        super().__init__()
         self.pd =3D None
         self.ctx =3D None
         if creator is None:
diff --git a/pyverbs/cq.pyx b/pyverbs/cq.pyx
index 1ea443fc6966..dda47207507f 100755
--- a/pyverbs/cq.pyx
+++ b/pyverbs/cq.pyx
@@ -17,12 +17,13 @@ cdef class CompChannel(PyverbsCM):
     for a CQ, the event is delivered via the completion channel attached t=
o the
     CQ.
     """
-    def __cinit__(self, Context context not None):
+    def __init__(self, Context context not None):
         """
         Initializes a completion channel object on the given device.
         :param context: The device's context to use
         :return: A CompChannel object on success
         """
+        super().__init__()
         self.cc =3D v.ibv_create_comp_channel(context.context)
         if self.cc =3D=3D NULL:
             raise PyverbsRDMAErrno('Failed to create a completion channel'=
)
@@ -68,8 +69,8 @@ cdef class CQ(PyverbsCM):
     A Completion Queue is the notification mechanism for work request
     completions. A CQ can have 0 or more associated QPs.
     """
-    def __cinit__(self, Context context not None, cqe, cq_context=3DNone,
-                  CompChannel channel=3DNone, comp_vector=3D0):
+    def __init__(self, Context context not None, cqe, cq_context=3DNone,
+                 CompChannel channel=3DNone, comp_vector=3D0):
         """
         Initializes a CQ object with the given parameters.
         :param context: The device's context on which to open the CQ
@@ -81,6 +82,7 @@ cdef class CQ(PyverbsCM):
                             context's num_comp_vectors
         :return: The newly created CQ
         """
+        super().__init__()
         if channel is not None:
             self.cq =3D v.ibv_create_cq(context.context, cqe, <void*>cq_co=
ntext,
                                       channel.cc, comp_vector)
@@ -173,8 +175,8 @@ cdef class CQ(PyverbsCM):
=20
=20
 cdef class CqInitAttrEx(PyverbsObject):
-    def __cinit__(self, cqe =3D 100, CompChannel channel =3D None, comp_ve=
ctor =3D 0,
-                  wc_flags =3D 0, comp_mask =3D 0, flags =3D 0):
+    def __init__(self, cqe =3D 100, CompChannel channel =3D None, comp_vec=
tor =3D 0,
+                 wc_flags =3D 0, comp_mask =3D 0, flags =3D 0):
         """
         Initializes a CqInitAttrEx object with the given parameters.
         :param cqe: CQ's capacity
@@ -189,6 +191,7 @@ cdef class CqInitAttrEx(PyverbsObject):
                       ibv_create_cq_attr_flags enum
         :return:
         """
+        super().__init__()
         self.attr.cqe =3D cqe
         self.attr.cq_context =3D NULL
         self.attr.channel =3D NULL if channel is None else channel.cc
@@ -255,8 +258,7 @@ cdef class CqInitAttrEx(PyverbsObject):
=20
=20
 cdef class CQEX(PyverbsCM):
-    def __cinit__(self, Context context not None, CqInitAttrEx init_attr,
-                  **kwargs):
+    def __init__(self, Context context not None, CqInitAttrEx init_attr):
         """
         Initializes a CQEX object on the given device's context with the g=
iven
         attributes.
@@ -264,9 +266,10 @@ cdef class CQEX(PyverbsCM):
         :param init_attr: Initial attributes that describe the CQ
         :return: The newly created CQEX on success
         """
+        super().__init__()
         self.qps =3D weakref.WeakSet()
         self.srqs =3D weakref.WeakSet()
-        if len(kwargs) > 0:
+        if self.cq !=3D NULL:
             # Leave CQ initialization to the provider
             return
         if init_attr is None:
@@ -380,9 +383,10 @@ cdef class CQEX(PyverbsCM):
=20
=20
 cdef class WC(PyverbsObject):
-    def __cinit__(self, wr_id=3D0, status=3D0, opcode=3D0, vendor_err=3D0,=
 byte_len=3D0,
-                  qp_num=3D0, src_qp=3D0, imm_data=3D0, wc_flags=3D0, pkey=
_index=3D0,
-                  slid=3D0, sl=3D0, dlid_path_bits=3D0):
+    def __init__(self, wr_id=3D0, status=3D0, opcode=3D0, vendor_err=3D0, =
byte_len=3D0,
+                 qp_num=3D0, src_qp=3D0, imm_data=3D0, wc_flags=3D0, pkey_=
index=3D0,
+                 slid=3D0, sl=3D0, dlid_path_bits=3D0):
+        super().__init__()
         self.wc.wr_id =3D wr_id
         self.wc.status =3D status
         self.wc.opcode =3D opcode
diff --git a/pyverbs/device.pyx b/pyverbs/device.pyx
index 56d7540ceb6c..529c4e4597c9 100755
--- a/pyverbs/device.pyx
+++ b/pyverbs/device.pyx
@@ -70,7 +70,7 @@ cdef class Context(PyverbsCM):
     """
     Context class represents the C ibv_context.
     """
-    def __cinit__(self, **kwargs):
+    def __init__(self, **kwargs):
         """
         Initializes a Context object. The function searches the IB devices=
 list
         for a device with the name provided by the user. If such a device =
is
@@ -79,19 +79,22 @@ cdef class Context(PyverbsCM):
         initiated pointer, hence all we have to do is assign this pointer =
to
         Context's object pointer.
         :param kwargs: Arguments:
-            * *name* (str)
-               The RDMA device's name
-            * *attr* (object)
-               Device-specific attributes, meaning that the device is to b=
e
-               opened by the provider
-            * *cmid* (CMID)
-                A CMID object (represents rdma_cm_id struct)
+            * *name*
+              The device's name
+            * *attr*
+              Provider-specific attributes. If not None, it means that the
+              device will be opened by the provider and __init__ will retu=
rn
+              after locating the requested device.
+            * *cmid*
+              A CMID object. If not None, it means that the device was alr=
eady
+              opened by a CMID class, and only a pointer assignment is mis=
sing.
         :return: None
         """
         cdef int count
         cdef v.ibv_device **dev_list
         cdef CMID cmid
=20
+        super().__init__()
         self.pds =3D weakref.WeakSet()
         self.dms =3D weakref.WeakSet()
         self.ccs =3D weakref.WeakSet()
@@ -99,19 +102,16 @@ cdef class Context(PyverbsCM):
         self.qps =3D weakref.WeakSet()
         self.xrcds =3D weakref.WeakSet()
=20
-        dev_name =3D kwargs.get('name')
+        self.name =3D kwargs.get('name')
         provider_attr =3D kwargs.get('attr')
         cmid =3D kwargs.get('cmid')
-
         if cmid is not None:
             self.context =3D cmid.id.verbs
             cmid.ctx =3D self
             return
-        elif dev_name is not None:
-            self.name =3D dev_name
-        else:
-            raise PyverbsUserError('Device name must be provided')
=20
+        if self.name is None:
+            raise PyverbsUserError('Device name must be provided')
         dev_list =3D v.ibv_get_device_list(&count)
         if dev_list =3D=3D NULL:
             raise PyverbsRDMAError('Failed to get devices list')
@@ -393,7 +393,8 @@ cdef class DeviceAttr(PyverbsObject):
=20
=20
 cdef class QueryDeviceExInput(PyverbsObject):
-    def __cinit__(self, comp_mask):
+    def __init__(self, comp_mask):
+        super().__init__()
         self.ex_input.comp_mask =3D comp_mask
=20
=20
@@ -583,7 +584,7 @@ cdef class DeviceAttrEx(PyverbsObject):
=20
=20
 cdef class AllocDmAttr(PyverbsObject):
-    def __cinit__(self, length, log_align_req =3D 0, comp_mask =3D 0):
+    def __init__(self, length, log_align_req =3D 0, comp_mask =3D 0):
         """
         Creates an AllocDmAttr object with the given parameters. This obje=
ct
         can than be used to create a DM object.
@@ -592,6 +593,7 @@ cdef class AllocDmAttr(PyverbsObject):
         :param comp_mask: compatibility mask
         :return: An AllocDmAttr object
         """
+        super().__init__()
         self.alloc_dm_attr.length =3D length
         self.alloc_dm_attr.log_align_req =3D log_align_req
         self.alloc_dm_attr.comp_mask =3D comp_mask
@@ -622,13 +624,14 @@ cdef class AllocDmAttr(PyverbsObject):
=20
=20
 cdef class DM(PyverbsCM):
-    def __cinit__(self, Context context, AllocDmAttr dm_attr not None):
+    def __init__(self, Context context, AllocDmAttr dm_attr not None):
         """
         Allocate a device (direct) memory.
         :param context: The context of the device on which to allocate mem=
ory
         :param dm_attr: Attributes that define the DM
         :return: A DM object on success
         """
+        super().__init__()
         self.dm_mrs =3D weakref.WeakSet()
         device_attr =3D context.query_device_ex()
         if device_attr.max_dm_size <=3D 0:
diff --git a/pyverbs/mr.pyx b/pyverbs/mr.pyx
index 8747d9cb81f9..6b28c8173ef8 100644
--- a/pyverbs/mr.pyx
+++ b/pyverbs/mr.pyx
@@ -1,15 +1,17 @@
 # SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
 # Copyright (c) 2019, Mellanox Technologies. All rights reserved. See COPY=
ING file
=20
+import resource
+import logging
+
 from pyverbs.pyverbs_error import PyverbsRDMAError, PyverbsError
 from pyverbs.base import PyverbsRDMAErrno
-from pyverbs.device cimport DM
-from .pd cimport PD
-import resource
 from posix.stdlib cimport posix_memalign
-from libc.stdlib cimport free
 from libc.string cimport memcpy, memset
 from libc.stdint cimport uintptr_t
+from pyverbs.device cimport DM
+from libc.stdlib cimport free
+from .pd cimport PD
=20
=20
 cdef class MR(PyverbsCM):
@@ -17,7 +19,7 @@ cdef class MR(PyverbsCM):
     MR class represents ibv_mr. Buffer allocation in done in the c'tor. Fr=
eeing
     it is done in close().
     """
-    def __cinit__(self, PD pd not None, length, access, **kwargs):
+    def __init__(self, PD pd not None, length, access):
         """
         Allocate a user-level buffer of length <length> and register a Mem=
ory
         Region of the given length and access flags.
@@ -26,7 +28,8 @@ cdef class MR(PyverbsCM):
         :param access: Access flags, see ibv_access_flags enum
         :return: The newly created MR on success
         """
-        if len(kwargs) !=3D 0:
+        super().__init__()
+        if self.mr !=3D NULL:
             return
         #We want to enable registering an MR of size 0 but this fails with=
 a
         #buffer of size 0, so in this case lets increase the buffer
@@ -107,13 +110,14 @@ cdef class MR(PyverbsCM):
=20
=20
 cdef class MW(PyverbsCM):
-    def __cinit__(self, PD pd not None, v.ibv_mw_type mw_type):
+    def __init__(self, PD pd not None, v.ibv_mw_type mw_type):
         """
         Initializes a memory window object of the given type
         :param pd: A PD object
         :param mw_type: Type of of the memory window, see ibv_mw_type enum
         :return:
         """
+        super().__init__()
         self.mw =3D NULL
         self.mw =3D v.ibv_alloc_mw(pd.pd, mw_type)
         if self.mw =3D=3D NULL:
@@ -144,29 +148,27 @@ cdef class MW(PyverbsCM):
=20
=20
 cdef class DMMR(MR):
-    def __cinit__(self, PD pd not None, length, access, **kwargs):
+    def __init__(self, PD pd not None, length, access, DM dm, offset):
         """
         Initializes a DMMR (Device Memory Memory Region) of the given leng=
th
         and access flags using the given PD and DM objects.
         :param pd: A PD object
         :param length: Length in bytes
         :param access: Access flags, see ibv_access_flags enum
-        :param kwargs: see below
+        :param dm: A DM (device memory) object to be used for this DMMR
+        :param offset: Byte offset from the beginning of the allocated dev=
ice
+                       memory buffer
         :return: The newly create DMMR
-
-        :keyword Arguments:
-            * *dm* (DM)
-               A DM (device memory) object to be used for this DMMR
-            * *offset*
-               Byte offset from the beginning of the allocated device memo=
ry
-               buffer
         """
-        dm =3D <DM>kwargs['dm']
-        offset =3D kwargs['offset']
-        self.mr =3D v.ibv_reg_dm_mr(pd.pd, (<DM>dm).dm, offset, length, ac=
cess)
+        # Initialize the logger here as the parent's __init__ is called af=
ter
+        # the DMMR is allocated. Allocation can fail, which will lead to
+        # exceptions thrown during object's teardown.
+        self.logger =3D logging.getLogger(self.__class__.__name__)
+        self.mr =3D v.ibv_reg_dm_mr(pd.pd, dm.dm, offset, length, access)
         if self.mr =3D=3D NULL:
             raise PyverbsRDMAErrno('Failed to register a device MR. length=
: {len}, access flags: {flags}'.
                                    format(len=3Dlength, flags=3Daccess,))
+        super().__init__(pd, length, access)
         self.pd =3D pd
         self.dm =3D dm
         pd.add_ref(self)
diff --git a/pyverbs/pd.pyx b/pyverbs/pd.pyx
index 8c17ffcba7e8..96d0078e3dbd 100755
--- a/pyverbs/pd.pyx
+++ b/pyverbs/pd.pyx
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
 # Copyright (c) 2019, Mellanox Technologies. All rights reserved.
 import weakref
+import logging
=20
 from pyverbs.pyverbs_error import PyverbsUserError, PyverbsError
 from pyverbs.base import PyverbsRDMAErrno
@@ -15,20 +16,16 @@ from pyverbs.qp cimport QP
=20
=20
 cdef class PD(PyverbsCM):
-    def __cinit__(self, object creator not None, **kwargs):
+    def __init__(self, object creator not None):
         """
         Initializes a PD object. A reference for the creating Context is k=
ept
         so that Python's GC will destroy the objects in the right order.
-        :param context: The Context object creating the PD
-        :param kwargs: Arguments:
-            * *attr* (object)
-                If provided PD will not be allocated, leaving the allocati=
on to
-                be made by an inheriting class
+        :param creator: The Context/CMID object creating the PD
         """
+        super().__init__()
         if issubclass(type(creator), Context):
-            # If there's a Parent Domain attribute skip PD allocation
-            # since this is done by the Parent Domain class
-            if not kwargs.get('attr'):
+            # Check if the ibv_pd* was initialized by an inheriting class
+            if self.pd =3D=3D NULL:
                 self.pd =3D v.ibv_alloc_pd((<Context>creator).context)
                 if self.pd =3D=3D NULL:
                     raise PyverbsRDMAErrno('Failed to allocate PD')
@@ -130,7 +127,7 @@ cdef void pd_free(v.ibv_pd *pd, void *pd_context, void =
*ptr,
=20
=20
 cdef class ParentDomainContext(PyverbsObject):
-    def __cinit__(self, PD pd, alloc_func, free_func):
+    def __init__(self, PD pd, alloc_func, free_func):
         """
         Initializes ParentDomainContext object which is used as a pd_conte=
xt.
         It contains the relevant fields in order to allow the user to writ=
e
@@ -140,19 +137,21 @@ cdef class ParentDomainContext(PyverbsObject):
         :param alloc_func: Python alloc function
         :param free_func: Python free function
         """
+        super().__init__()
         self.pd =3D pd
         self.p_alloc =3D alloc_func
         self.p_free =3D free_func
=20
=20
 cdef class ParentDomainInitAttr(PyverbsObject):
-    def __cinit__(self, PD pd not None, ParentDomainContext pd_context=3DN=
one):
+    def __init__(self, PD pd not None, ParentDomainContext pd_context=3DNo=
ne):
         """
         Represents ibv_parent_domain_init_attr C struct
         :param pd: PD to initialize the ParentDomain with
         :param pd_context: ParentDomainContext object including the alloc =
and
                           free Python callbacks
         """
+        super().__init__()
         self.pd =3D pd
         self.init_attr.pd =3D <v.ibv_pd*>pd.pd
         if pd_context:
@@ -171,25 +170,24 @@ cdef class ParentDomainInitAttr(PyverbsObject):
=20
=20
 cdef class ParentDomain(PD):
-    def __cinit__(self, Context context not None, **kwargs):
+    def __init__(self, Context context not None, ParentDomainInitAttr attr=
 not None):
         """
         Initializes ParentDomain object which represents a parent domain o=
f
         ibv_pd C struct type
         :param context: Device context
-        :param kwargs: Arguments:
-            * *attr* (object)
-                Attribute of type ParentDomainInitAttr to initialize the
-                ParentDomain with
+        :param attr: Attribute of type ParentDomainInitAttr to initialize =
the
+                     ParentDomain with
         """
-        cdef ParentDomainInitAttr attr
-        attr =3D kwargs.get('attr')
-        if attr is None:
-            raise PyverbsUserError('ParentDomain must take attr')
+        # Initialize the logger here as the parent's __init__ is called af=
ter
+        # the PD is allocated. Allocation can fail, which will lead to exc=
eptions
+        # thrown during object's teardown.
+        self.logger =3D logging.getLogger(self.__class__.__name__)
         (<PD>attr.pd).add_ref(self)
         self.protection_domain =3D attr.pd
         self.pd =3D v.ibv_alloc_parent_domain(context.context, &attr.init_=
attr)
         if self.pd =3D=3D NULL:
             raise PyverbsRDMAErrno('Failed to allocate Parent Domain')
+        super().__init__(context)
         self.logger.debug('Allocated ParentDomain')
=20
     def __dealloc__(self):
diff --git a/pyverbs/providers/mlx5/mlx5dv.pyx b/pyverbs/providers/mlx5/mlx=
5dv.pyx
index e4500567ba23..775c5504c2bb 100644
--- a/pyverbs/providers/mlx5/mlx5dv.pyx
+++ b/pyverbs/providers/mlx5/mlx5dv.pyx
@@ -1,6 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
 # Copyright (c) 2019 Mellanox Technologies, Inc. All rights reserved. See =
COPYING file
=20
+import logging
+
 from pyverbs.pyverbs_error import PyverbsUserError
 cimport pyverbs.providers.mlx5.mlx5dv_enums as dve
 cimport pyverbs.providers.mlx5.libmlx5 as dv
@@ -16,7 +18,8 @@ cdef class Mlx5DVContextAttr(PyverbsObject):
     Represent mlx5dv_context_attr struct. This class is used to open an ml=
x5
     device.
     """
-    def __cinit__(self, flags=3D0, comp_mask=3D0):
+    def __init__(self, flags=3D0, comp_mask=3D0):
+        super().__init__()
         self.attr.flags =3D flags
         self.attr.comp_mask =3D comp_mask
=20
@@ -44,22 +47,16 @@ cdef class Mlx5Context(Context):
     """
     Represent mlx5 context, which extends Context.
     """
-    def __cinit__(self, **kwargs):
+    def __init__(self, Mlx5DVContextAttr attr not None, name=3D''):
         """
         Open an mlx5 device using the given attributes
-        :param kwargs: Arguments:
-            * *name* (str)
-               The RDMA device's name (used by parent class)
-            * *attr* (Mlx5DVContextAttr)
-               mlx5-specific device attributes
+        :param name: The RDMA device's name (used by parent class)
+        :param attr: mlx5-specific device attributes
         :return: None
         """
-        cdef Mlx5DVContextAttr attr
-        attr =3D kwargs.get('attr')
-        if not attr or not isinstance(attr, Mlx5DVContextAttr):
-            raise PyverbsUserError('Missing provider attributes')
         if not dv.mlx5dv_is_supported(self.device):
             raise PyverbsUserError('This is not an MLX5 device')
+        super().__init__(name=3Dname, attr=3Dattr)
         self.context =3D dv.mlx5dv_open_device(self.device, &attr.attr)
=20
     def query_mlx5_device(self, comp_mask=3D-1):
@@ -187,7 +184,7 @@ cdef class Mlx5DVDCInitAttr(PyverbsObject):
     Represents mlx5dv_dc_init_attr struct, which defines initial attribute=
s
     for DC QP creation.
     """
-    def __cinit__(self, dc_type=3Ddve.MLX5DV_DCTYPE_DCI, dct_access_key=3D=
0):
+    def __init__(self, dc_type=3Ddve.MLX5DV_DCTYPE_DCI, dct_access_key=3D0=
):
         """
         Initializes an Mlx5DVDCInitAttr object with the given DC type and =
DCT
         access key.
@@ -195,6 +192,7 @@ cdef class Mlx5DVDCInitAttr(PyverbsObject):
         :param dct_access_key: Access key to be used by the DCT
         :return: An initializes object
         """
+        super().__init__()
         self.attr.dc_type =3D dc_type
         self.attr.dct_access_key =3D dct_access_key
=20
@@ -223,8 +221,8 @@ cdef class Mlx5DVQPInitAttr(PyverbsObject):
     Represents mlx5dv_qp_init_attr struct, initial attributes used for mlx=
5 QP
     creation.
     """
-    def __cinit__(self, comp_mask=3D0, create_flags=3D0,
-                  Mlx5DVDCInitAttr dc_init_attr=3DNone, send_ops_flags=3D0=
):
+    def __init__(self, comp_mask=3D0, create_flags=3D0,
+                 Mlx5DVDCInitAttr dc_init_attr=3DNone, send_ops_flags=3D0)=
:
         """
         Initializes an Mlx5DVQPInitAttr object with the given user data.
         :param comp_mask: A bitmask specifying which fields are valid
@@ -233,6 +231,7 @@ cdef class Mlx5DVQPInitAttr(PyverbsObject):
         :param send_ops_flags: A bitwise OR of mlx5dv_qp_create_send_ops_f=
lags
         :return: An initialized Mlx5DVQPInitAttr object
         """
+        super().__init__()
         self.attr.comp_mask =3D comp_mask
         self.attr.create_flags =3D create_flags
         self.attr.send_ops_flags =3D send_ops_flags
@@ -291,8 +290,8 @@ cdef class Mlx5DVQPInitAttr(PyverbsObject):
=20
=20
 cdef class Mlx5QP(QP):
-    def __cinit__(self, Mlx5Context context, QPInitAttrEx init_attr,
-                  Mlx5DVQPInitAttr dv_init_attr):
+    def __init__(self, Mlx5Context context, QPInitAttrEx init_attr,
+                 Mlx5DVQPInitAttr dv_init_attr):
         """
         Initializes an mlx5 QP according to the user-provided data.
         :param context: mlx5 Context object
@@ -301,6 +300,11 @@ cdef class Mlx5QP(QP):
         :return: An initialized Mlx5QP
         """
         cdef PD pd
+
+        # Initialize the logger here as the parent's __init__ is called af=
ter
+        # the QP is allocated. Allocation can fail, which will lead to exc=
eptions
+        # thrown during object's teardown.
+        self.logger =3D logging.getLogger(self.__class__.__name__)
         self.dc_type =3D dv_init_attr.dc_type if dv_init_attr else 0
         if init_attr.pd is not None:
             pd =3D <PD>init_attr.pd
@@ -314,6 +318,7 @@ cdef class Mlx5QP(QP):
             raise PyverbsRDMAErrno('Failed to create MLX5 QP.\nQPInitAttrE=
x '
                                    'attributes:\n{}\nMLX5DVQPInitAttr:\n{}=
'.
                                    format(init_attr, dv_init_attr))
+        super().__init__(context, init_attr)
=20
     def _get_comp_mask(self, dst):
         masks =3D {dve.MLX5DV_DCTYPE_DCT: {'INIT': e.IBV_QP_PKEY_INDEX |
@@ -338,7 +343,7 @@ cdef class Mlx5DVCQInitAttr(PyverbsObject):
     Represents mlx5dv_cq_init_attr struct, initial attributes used for mlx=
5 CQ
     creation.
     """
-    def __cinit__(self, comp_mask=3D0, cqe_comp_res_format=3D0, flags=3D0,=
 cqe_size=3D0):
+    def __init__(self, comp_mask=3D0, cqe_comp_res_format=3D0, flags=3D0, =
cqe_size=3D0):
         """
         Initializes an Mlx5CQInitAttr object with zeroes as default values=
.
         :param comp_mask: Marks which of the following fields should be
@@ -353,6 +358,7 @@ cdef class Mlx5DVCQInitAttr(PyverbsObject):
                          Valid when MLX5DV_CQ_INIT_ATTR_MASK_CQE_SIZE is s=
et.
         :return: None
         """
+        super().__init__()
         self.attr.comp_mask =3D comp_mask
         self.attr.cqe_comp_res_format =3D cqe_comp_res_format
         self.attr.flags =3D flags
@@ -413,8 +419,12 @@ cdef class Mlx5DVCQInitAttr(PyverbsObject):
=20
=20
 cdef class Mlx5CQ(CQEX):
-    def __cinit__(self, Mlx5Context context, CqInitAttrEx init_attr,
-                  Mlx5DVCQInitAttr dv_init_attr):
+    def __init__(self, Mlx5Context context, CqInitAttrEx init_attr,
+                 Mlx5DVCQInitAttr dv_init_attr):
+        # Initialize the logger here as the parent's __init__ is called af=
ter
+        # the CQ is allocated. Allocation can fail, which will lead to exc=
eptions
+        # thrown during object's teardown.
+        self.logger =3D logging.getLogger(self.__class__.__name__)
         self.cq =3D \
             dv.mlx5dv_create_cq(context.context, &init_attr.attr,
                                 &dv_init_attr.attr if dv_init_attr is not =
None
@@ -426,6 +436,7 @@ cdef class Mlx5CQ(CQEX):
         self.ibv_cq =3D v.ibv_cq_ex_to_cq(self.cq)
         self.context =3D context
         context.add_ref(self)
+        super().__init__(context, init_attr)
=20
     def __str__(self):
         print_format =3D '{:<22}: {:<20}\n'
diff --git a/pyverbs/qp.pyx b/pyverbs/qp.pyx
index 36698d2119e8..9d368b62022d 100755
--- a/pyverbs/qp.pyx
+++ b/pyverbs/qp.pyx
@@ -18,8 +18,8 @@ from libc.string cimport memcpy
=20
=20
 cdef class QPCap(PyverbsObject):
-    def __cinit__(self, max_send_wr=3D1, max_recv_wr=3D10, max_send_sge=3D=
1,
-                      max_recv_sge=3D1, max_inline_data=3D0):
+    def __init__(self, max_send_wr=3D1, max_recv_wr=3D10, max_send_sge=3D1=
,
+                 max_recv_sge=3D1, max_inline_data=3D0):
         """
         Initializes a QPCap object with user-provided or default values.
         :param max_send_wr: max number of outstanding WRs in the SQ
@@ -32,6 +32,7 @@ cdef class QPCap(PyverbsObject):
                                 inline to the SQ, otherwise 0
         :return:
         """
+        super().__init__()
         self.cap.max_send_wr =3D max_send_wr
         self.cap.max_recv_wr =3D max_recv_wr
         self.cap.max_send_sge =3D max_send_sge
@@ -83,9 +84,9 @@ cdef class QPCap(PyverbsObject):
=20
=20
 cdef class QPInitAttr(PyverbsObject):
-    def __cinit__(self, qp_type=3De.IBV_QPT_UD, qp_context=3DNone,
-                  PyverbsObject scq=3DNone, PyverbsObject rcq=3DNone,
-                  SRQ srq=3DNone, QPCap cap=3DNone, sq_sig_all=3D1):
+    def __init__(self, qp_type=3De.IBV_QPT_UD, qp_context=3DNone,
+                 PyverbsObject scq=3DNone, PyverbsObject rcq=3DNone,
+                 SRQ srq=3DNone, QPCap cap=3DNone, sq_sig_all=3D1):
         """
         Initializes a QpInitAttr object representing ibv_qp_init_attr stru=
ct.
         Note that SRQ object is not yet supported in pyverbs so can't be p=
assed
@@ -100,6 +101,7 @@ cdef class QPInitAttr(PyverbsObject):
                            entry
         :return: A QpInitAttr object
         """
+        super().__init__()
         _copy_caps(cap, self)
         self.attr.qp_context =3D <void*>qp_context
         if scq is not None:
@@ -233,12 +235,12 @@ cdef class QPInitAttr(PyverbsObject):
=20
=20
 cdef class QPInitAttrEx(PyverbsObject):
-    def __cinit__(self, qp_type=3De.IBV_QPT_UD, qp_context=3DNone,
-                  PyverbsObject scq=3DNone, PyverbsObject rcq=3DNone,
-                  SRQ srq=3DNone, QPCap cap=3DNone, sq_sig_all=3D0, comp_m=
ask=3D0,
-                  PD pd=3DNone, XRCD xrcd=3DNone, create_flags=3D0,
-                  max_tso_header=3D0, source_qpn=3D0, object hash_conf=3DN=
one,
-                  object ind_table=3DNone):
+    def __init__(self, qp_type=3De.IBV_QPT_UD, qp_context=3DNone,
+                 PyverbsObject scq=3DNone, PyverbsObject rcq=3DNone,
+                 SRQ srq=3DNone, QPCap cap=3DNone, sq_sig_all=3D0, comp_ma=
sk=3D0,
+                 PD pd=3DNone, XRCD xrcd=3DNone, create_flags=3D0,
+                 max_tso_header=3D0, source_qpn=3D0, object hash_conf=3DNo=
ne,
+                 object ind_table=3DNone):
         """
         Initialize a QPInitAttrEx object with user-defined or default valu=
es.
         :param qp_type: QP type to be created
@@ -261,6 +263,7 @@ cdef class QPInitAttrEx(PyverbsObject):
         :param ind_table: Not yet supported
         :return: An initialized QPInitAttrEx object
         """
+        super().__init__()
         _copy_caps(cap, self)
         if scq is not None:
             if type(scq) is CQ:
@@ -481,8 +484,8 @@ cdef class QPInitAttrEx(PyverbsObject):
=20
=20
 cdef class QPAttr(PyverbsObject):
-    def __cinit__(self, qp_state=3De.IBV_QPS_INIT, cur_qp_state=3De.IBV_QP=
S_RESET,
-                  port_num=3D1, path_mtu=3De.IBV_MTU_1024):
+    def __init__(self, qp_state=3De.IBV_QPS_INIT, cur_qp_state=3De.IBV_QPS=
_RESET,
+                 port_num=3D1, path_mtu=3De.IBV_MTU_1024):
         """
         Initializes a QPQttr object which represents ibv_qp_attr structs. =
It
         can be used to modify a QP.
@@ -491,6 +494,7 @@ cdef class QPAttr(PyverbsObject):
         :param cur_qp_state: Current QP state
         :return: An initialized QpAttr object
         """
+        super().__init__()
         self.attr.qp_state =3D qp_state
         self.attr.cur_qp_state =3D cur_qp_state
         self.attr.port_num =3D port_num
@@ -854,8 +858,8 @@ cdef class QPAttr(PyverbsObject):
=20
=20
 cdef class QP(PyverbsCM):
-    def __cinit__(self, object creator not None, object init_attr not None=
,
-                  QPAttr qp_attr=3DNone, **kwargs):
+    def __init__(self, object creator not None, object init_attr not None,
+                 QPAttr qp_attr=3DNone):
         """
         Initializes a QP object and performs state transitions according t=
o
         user request.
@@ -875,39 +879,38 @@ cdef class QP(PyverbsCM):
                           using Context).
         :param qp_attr: Optional QPAttr object. Will be used for QP state
                         transitions after creation.
-        :param kwargs: Provider-specific QP creation attributes, meaning t=
hat
-                       the QP will be created by the provider.
         :return: An initialized QP object
         """
         cdef PD pd
         cdef Context ctx
+        super().__init__()
         self.update_cqs(init_attr)
-        if len(kwargs) > 0:
-            # Leave QP initialization to the provider
-            return
-        # In order to use cdef'd methods, a proper casting must be done, l=
et's
-        # infer the type.
-        if issubclass(type(creator), Context):
-            self._create_qp_ex(creator, init_attr)
-            ctx =3D <Context>creator
-            self.context =3D ctx
-            ctx.add_ref(self)
-            if init_attr.pd is not None:
-                pd =3D <PD>init_attr.pd
-                pd.add_ref(self)
-                self.pd =3D pd
-            if init_attr.xrcd is not None:
-                xrcd =3D <XRCD>init_attr.xrcd
-                xrcd.add_ref(self)
-                self.xrcd =3D xrcd
-        else:
-            self._create_qp(creator, init_attr)
-            pd =3D <PD>creator
-            self.pd =3D pd
-            pd.add_ref(self)
-            self.context =3D None
+        # QP initialization was not done by the provider, we should do it =
here
         if self.qp =3D=3D NULL:
-            raise PyverbsRDMAErrno('Failed to create QP')
+            # In order to use cdef'd methods, a proper casting must be don=
e,
+            # let's infer the type.
+            if issubclass(type(creator), Context):
+                self._create_qp_ex(creator, init_attr)
+                ctx =3D <Context>creator
+                self.context =3D ctx
+                ctx.add_ref(self)
+                if init_attr.pd is not None:
+                    pd =3D <PD>init_attr.pd
+                    pd.add_ref(self)
+                    self.pd =3D pd
+                if init_attr.xrcd is not None:
+                    xrcd =3D <XRCD>init_attr.xrcd
+                    xrcd.add_ref(self)
+                    self.xrcd =3D xrcd
+            else:
+                self._create_qp(creator, init_attr)
+                pd =3D <PD>creator
+                self.pd =3D pd
+                pd.add_ref(self)
+                self.context =3D None
+            if self.qp =3D=3D NULL:
+                raise PyverbsRDMAErrno('Failed to create QP')
+
         if qp_attr is not None:
             funcs =3D {e.IBV_QPT_RC: self.to_init, e.IBV_QPT_UC: self.to_i=
nit,
                      e.IBV_QPT_UD: self.to_rts,
diff --git a/pyverbs/srq.pyx b/pyverbs/srq.pyx
index a60aa5dcb0e5..7dc24d3849e4 100755
--- a/pyverbs/srq.pyx
+++ b/pyverbs/srq.pyx
@@ -10,7 +10,8 @@ from libc.string cimport memcpy
=20
=20
 cdef class SrqAttr(PyverbsObject):
-    def __cinit__(self, max_wr=3D100, max_sge=3D1, srq_limit=3D0):
+    def __init__(self, max_wr=3D100, max_sge=3D1, srq_limit=3D0):
+        super().__init__()
         self.attr.max_wr =3D max_wr
         self.attr.max_sge =3D max_sge
         self.attr.srq_limit =3D srq_limit
@@ -38,11 +39,12 @@ cdef class SrqAttr(PyverbsObject):
=20
=20
 cdef class SrqInitAttr(PyverbsObject):
-    def __cinit__(self, SrqAttr attr =3D None):
-         if attr is not None:
-             self.attr.attr.max_wr =3D attr.max_wr
-             self.attr.attr.max_sge =3D attr.max_sge
-             self.attr.attr.srq_limit =3D attr.srq_limit
+    def __init__(self, SrqAttr attr =3D None):
+        super().__init__()
+        if attr is not None:
+            self.attr.attr.max_wr =3D attr.max_wr
+            self.attr.attr.max_sge =3D attr.max_sge
+            self.attr.attr.srq_limit =3D attr.srq_limit
=20
     @property
     def max_wr(self):
@@ -58,7 +60,8 @@ cdef class SrqInitAttr(PyverbsObject):
=20
=20
 cdef class SrqInitAttrEx(PyverbsObject):
-    def __cinit__(self, max_wr=3D100, max_sge=3D1, srq_limit=3D0):
+    def __init__(self, max_wr=3D100, max_sge=3D1, srq_limit=3D0):
+        super().__init__()
         self.attr.attr.max_wr =3D max_wr
         self.attr.attr.max_sge =3D max_sge
         self.attr.attr.srq_limit =3D srq_limit
@@ -122,7 +125,8 @@ cdef class SrqInitAttrEx(PyverbsObject):
=20
=20
 cdef class SRQ(PyverbsCM):
-    def __cinit__(self, object creator not None, object attr not None):
+    def __init__(self, object creator not None, object attr not None):
+        super().__init__()
         self.srq =3D NULL
         self.cq =3D None
         if isinstance(creator, PD):
diff --git a/pyverbs/wr.pyx b/pyverbs/wr.pyx
index 8505c1cfddff..06186e9b0fd2 100644
--- a/pyverbs/wr.pyx
+++ b/pyverbs/wr.pyx
@@ -17,7 +17,7 @@ cdef class SGE(PyverbsCM):
     write can't be done using memcpy that relies on CPU-specific optimizat=
ions.
     A SGE has no way to tell which memory it is using.
     """
-    def __cinit__(self, addr, length, lkey):
+    def __init__(self, addr, length, lkey):
         """
         Initializes a SGE object.
         :param addr: The address to be used for read/write
@@ -25,6 +25,7 @@ cdef class SGE(PyverbsCM):
         :param lkey: Local key of the used MR/DMMR
         :return: A SGE object
         """
+        super().__init__()
         self.sge =3D <v.ibv_sge*>malloc(sizeof(v.ibv_sge))
         if self.sge =3D=3D NULL:
             raise PyverbsError('Failed to allocate an SGE')
@@ -80,8 +81,8 @@ cdef class SGE(PyverbsCM):
=20
=20
 cdef class RecvWR(PyverbsCM):
-    def __cinit__(self, wr_id=3D0, num_sge=3D0, sg=3DNone,
-                  RecvWR next_wr=3DNone):
+    def __init__(self, wr_id=3D0, num_sge=3D0, sg=3DNone,
+                 RecvWR next_wr=3DNone):
         """
         Initializes a RecvWR object.
         :param wr_id: A user-defined WR ID
@@ -90,6 +91,7 @@ cdef class RecvWR(PyverbsCM):
         :param: next_wr: The next WR in the list
         :return: A RecvWR object
         """
+        super().__init__()
         cdef v.ibv_sge *dst
         if num_sge < 1 or sg is None:
             raise PyverbsUserError('A WR needs at least one SGE')
@@ -141,8 +143,8 @@ cdef class RecvWR(PyverbsCM):
=20
=20
 cdef class SendWR(PyverbsCM):
-    def __cinit__(self, wr_id=3D0, opcode=3De.IBV_WR_SEND, num_sge=3D0, sg=
 =3D None,
-                  send_flags=3De.IBV_SEND_SIGNALED, SendWR next_wr =3D Non=
e):
+    def __init__(self, wr_id=3D0, opcode=3De.IBV_WR_SEND, num_sge=3D0, sg =
=3D None,
+                 send_flags=3De.IBV_SEND_SIGNALED, SendWR next_wr =3D None=
):
         """
         Initialize a SendWR object with user-provided or default values.
         :param wr_id: A user-defined WR ID
@@ -153,6 +155,8 @@ cdef class SendWR(PyverbsCM):
         :return: An initialized SendWR object
         """
         cdef v.ibv_sge *dst
+
+        super().__init__()
         if num_sge < 1 or sg is None:
             raise PyverbsUserError('A WR needs at least one SGE')
         self.send_wr.sg_list =3D <v.ibv_sge*>malloc(num_sge * sizeof(v.ibv=
_sge))
diff --git a/pyverbs/xrcd.pyx b/pyverbs/xrcd.pyx
index 91303daf3bc0..774f60e60dda 100755
--- a/pyverbs/xrcd.pyx
+++ b/pyverbs/xrcd.pyx
@@ -12,7 +12,8 @@ from libc.errno cimport errno
=20
=20
 cdef class XRCDInitAttr(PyverbsObject):
-    def __cinit__(self, comp_mask, oflags, fd):
+    def __init__(self, comp_mask, oflags, fd):
+        super().__init__()
         self.attr.fd =3D fd
         self.attr.comp_mask =3D comp_mask
         self.attr.oflags =3D oflags
@@ -40,12 +41,13 @@ cdef class XRCDInitAttr(PyverbsObject):
=20
=20
 cdef class XRCD(PyverbsCM):
-    def __cinit__(self, Context context not None, XRCDInitAttr init_attr n=
ot None):
+    def __init__(self, Context context not None, XRCDInitAttr init_attr no=
t None):
         """
         Initializes a XRCD object.
         :param context: The Context object creating the XRCD
         :return: The newly created XRCD on success
         """
+        super().__init__()
         self.xrcd =3D v.ibv_open_xrcd(<v.ibv_context*> context.context,
                                     &init_attr.attr)
         if self.xrcd =3D=3D NULL:
--=20
2.21.0

