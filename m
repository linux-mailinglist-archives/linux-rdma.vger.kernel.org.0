Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10251E2A36
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2019 08:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437663AbfJXGBU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Oct 2019 02:01:20 -0400
Received: from mail-bgr052101136076.outbound.protection.outlook.com ([52.101.136.76]:57230
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2437466AbfJXGBT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 24 Oct 2019 02:01:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7Y4SBKsgKQErzT1/AGRAtH8Qn+2gWihCHiQ4mHCd+uRDw3xgeVrDHpMRpZvKZPQ4WHTnbQLwCbbZXr65LDpoymwv3uLyPmVpufUlGI6zlwlIe/941pwO1ZkLrT5d+0+cSg38Qf40ukbiwS1Jk1dkW1cZtz8u15itWLM/fqYOaIZKcDnwp9/+5GMm4Z+6Mw+k2Nh+QuhhwlJRRHx0mwtNA6liyWVLpWvYYcs4lBscIM8JQ/jb411G/wQU+rqkSfoMK3N+tx7nBX1pZOnGH6eZ5Z2/yer/rOE/KBJDxg2oukdoYihudlldYcAo2KbUoVFLRqfi57in36EH/CeoyttHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zia2IuMcFxEl3YU5RLOgDR5oZjZ55MXudN4nOr3HlhU=;
 b=URbYNvTC0Mz2yLLY56P5OjO6jHMTcHCOom06aLuPfleTGkqCMsyU/HnID68/HLGY3rbaO2fwDGUi3uIEtqvX18qtynFinJbZfKBEteMgJBE2uo8BdyZvG4A1Z+hYv6pRwGUGC0/kRT3X90Xlnl6o8c9d01nIEEPm68HagAizWQlXcD/3iK/2BrEYoiM08n6OyLhhyU+0GRHjsxy71DZii9nmDUl8MGxNNlGPgeon+QjEPWe46mXlDXpbjD4lF//xznCxaJh2UXSdmC7BsmkBkG/7z+N2jrVWd/XCf5P+9lQQgyDJKiclT7edquGk+rDpqvepku5bzcLAE8lZgxJaPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zia2IuMcFxEl3YU5RLOgDR5oZjZ55MXudN4nOr3HlhU=;
 b=PTSswJIORQQo8FFEqBKvwe3uqSlrff1c9bq0I7ySyzJbY/gq/z8ntg9g03HmZv7aaVNmaVd30NAmABeKKrR9uTGIAQ50MrmnSGAUpujy2uAIb8NCDgqrDH3gkrQiMt+opEtFSEZU9kZMPUTMpu4COou4ov6LPa9Tgl/6CWFEjSs=
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com (20.177.33.17) by
 AM6PR05MB4182.eurprd05.prod.outlook.com (52.135.164.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Thu, 24 Oct 2019 06:00:50 +0000
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::ecbd:11b3:e4e9:fa1a]) by AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::ecbd:11b3:e4e9:fa1a%5]) with mapi id 15.20.2347.029; Thu, 24 Oct 2019
 06:00:50 +0000
From:   Noa Osherovich <noaos@mellanox.com>
To:     "dledford@redhat.com" <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Noa Osherovich <noaos@mellanox.com>
Subject: [PATCH rdma-core 4/4] pyverbs/mlx5: Add query device capability
Thread-Topic: [PATCH rdma-core 4/4] pyverbs/mlx5: Add query device capability
Thread-Index: AQHVijBiXOVVE4M5R0SRpwb7EsH5AA==
Date:   Thu, 24 Oct 2019 06:00:50 +0000
Message-ID: <20191024060027.8696-5-noaos@mellanox.com>
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
x-ms-office365-filtering-correlation-id: 7dd8e1d2-dbfb-44b4-8ce8-08d75847853e
x-ms-traffictypediagnostic: AM6PR05MB4182:|AM6PR05MB4182:|AM6PR05MB4182:|AM6PR05MB4182:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR05MB418232B737625F58E21BF64DD96A0@AM6PR05MB4182.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:SPM;SFS:(10009020)(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(199004)(189003)(478600001)(71200400001)(86362001)(486006)(71190400001)(2501003)(11346002)(2616005)(446003)(52116002)(476003)(4326008)(76176011)(110136005)(54906003)(66946007)(66476007)(66556008)(66446008)(64756008)(6636002)(14454004)(99286004)(19627235002)(107886003)(26005)(186003)(305945005)(7736002)(316002)(66066001)(6506007)(386003)(3846002)(36756003)(14444005)(256004)(102836004)(8936002)(50226002)(1076003)(6116002)(2906002)(81156014)(81166006)(6436002)(6512007)(6486002)(30864003)(5660300002)(25786009)(8676002)(98050200001);DIR:OUT;SFP:1501;SCL:5;SRVR:AM6PR05MB4182;H:AM6PR05MB4968.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zfSFsMjRhQk+wzInlj5e53hJDqLm9O9mpeeeGPMl3j/sSi6ZqtMnqxVil7gwuiVrXhUGa0TTdjlPf7vBva9ARfWc57es4u/Ms7RA0AoUB10XKq6c7UqpJonXBcYt54XSn7I1xH1flfwQiKW/KYdz3kjDKmKg6+tAXro/1SY/DHRWx52pXlIvS4Wjgmy8yRx53DTqO3ud+NEJv1moi0blg0xuyX0HkS5nMD+IRMX6FYbUPyfuiCAkI/3HrKBFOBH2Qhoy7aPa6CNrhDBmpubRGTHAXVC10RL516buse2zfzV9GQvcx+n5vmhOMGr7PM9bG97kQe9n5QwU+4UgRdqBTuvfYp3AvQdTCyi2Y66BV8iPyYaqnGTobACLXr/xDAVSahYZces27DRzj4BD5UJ4ByDFeDXkXPLSyfCmD5AqwzLI+XDvgVnAO4iML27tfn8xeEpSBA+ufhj5LBKAwSJ8OG22P9ZbXVVfkdzqf8ksVdwzdcOLWTAYLEmPdL+hXmmnIstHS3xYPmnahZPAGkZPiA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dd8e1d2-dbfb-44b4-8ce8-08d75847853e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 06:00:50.0344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sEt1sUvyQz3Qxws8bbJg7kGuOlT4eLzW1Em5vQTCHQKQUwai5vYsLNo2P/8+pqvh8bmwa3fWU6bUoHtwEFMVrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4182
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Allow users to use the mlx5-specific query_device() function via
Mlx5Context's query_mlx5_device method. This device querying exposes
device properties that are not available via legacy query such as
software parsing and CQE compression capabilities.
This method returns an Mlx5DVContext object which supports a
user-friendly print format.

Signed-off-by: Noa Osherovich <noaos@mellanox.com>
---
 pyverbs/providers/mlx5/CMakeLists.txt   |   1 +
 pyverbs/providers/mlx5/libmlx5.pxd      |  29 ++++
 pyverbs/providers/mlx5/mlx5_enums.pyx   |   1 +
 pyverbs/providers/mlx5/mlx5dv.pxd       |   3 +
 pyverbs/providers/mlx5/mlx5dv.pyx       | 196 ++++++++++++++++++++++++
 pyverbs/providers/mlx5/mlx5dv_enums.pxd |  47 ++++++
 6 files changed, 277 insertions(+)
 create mode 120000 pyverbs/providers/mlx5/mlx5_enums.pyx
 create mode 100644 pyverbs/providers/mlx5/mlx5dv_enums.pxd

diff --git a/pyverbs/providers/mlx5/CMakeLists.txt b/pyverbs/providers/mlx5=
/CMakeLists.txt
index f6536de8a932..d9b0849f02dc 100644
--- a/pyverbs/providers/mlx5/CMakeLists.txt
+++ b/pyverbs/providers/mlx5/CMakeLists.txt
@@ -3,4 +3,5 @@
=20
 rdma_cython_module(pyverbs/providers/mlx5 mlx5
   mlx5dv.pyx
+  mlx5_enums.pyx
 )
diff --git a/pyverbs/providers/mlx5/libmlx5.pxd b/pyverbs/providers/mlx5/li=
bmlx5.pxd
index 54d91e288590..aaf75620a9bb 100644
--- a/pyverbs/providers/mlx5/libmlx5.pxd
+++ b/pyverbs/providers/mlx5/libmlx5.pxd
@@ -12,6 +12,35 @@ cdef extern from 'infiniband/mlx5dv.h':
         unsigned int    flags
         unsigned long   comp_mask
=20
+    cdef struct mlx5dv_cqe_comp_caps:
+        unsigned int    max_num
+        unsigned int    supported_format
+
+    cdef struct mlx5dv_sw_parsing_caps:
+        unsigned int    sw_parsing_offloads
+        unsigned int    supported_qpts
+
+    cdef struct mlx5dv_striding_rq_caps:
+        unsigned int    min_single_stride_log_num_of_bytes
+        unsigned int    max_single_stride_log_num_of_bytes
+        unsigned int    min_single_wqe_log_num_of_strides
+        unsigned int    max_single_wqe_log_num_of_strides
+        unsigned int    supported_qpts
+
+    cdef struct mlx5dv_context:
+        unsigned char           version
+        unsigned long           flags
+        unsigned long           comp_mask
+        mlx5dv_cqe_comp_caps    cqe_comp_caps
+        mlx5dv_sw_parsing_caps  sw_parsing_caps
+        mlx5dv_striding_rq_caps striding_rq_caps
+        unsigned int            tunnel_offloads_caps
+        unsigned int            max_dynamic_bfregs
+        unsigned long           max_clock_info_update_nsec
+        unsigned int            flow_action_flags
+        unsigned int            dc_odp_caps
+
     bool mlx5dv_is_supported(v.ibv_device *device)
     v.ibv_context* mlx5dv_open_device(v.ibv_device *device,
                                       mlx5dv_context_attr *attr)
+    int mlx5dv_query_device(v.ibv_context *ctx, mlx5dv_context *attrs_out)
diff --git a/pyverbs/providers/mlx5/mlx5_enums.pyx b/pyverbs/providers/mlx5=
/mlx5_enums.pyx
new file mode 120000
index 000000000000..ba0e916f9e62
--- /dev/null
+++ b/pyverbs/providers/mlx5/mlx5_enums.pyx
@@ -0,0 +1 @@
+mlx5dv_enums.pxd
\ No newline at end of file
diff --git a/pyverbs/providers/mlx5/mlx5dv.pxd b/pyverbs/providers/mlx5/mlx=
5dv.pxd
index 6ab94b6484b0..d9fea82af894 100644
--- a/pyverbs/providers/mlx5/mlx5dv.pxd
+++ b/pyverbs/providers/mlx5/mlx5dv.pxd
@@ -12,3 +12,6 @@ cdef class Mlx5Context(Context):
=20
 cdef class Mlx5DVContextAttr(PyverbsObject):
     cdef dv.mlx5dv_context_attr attr
+
+cdef class Mlx5DVContext(PyverbsObject):
+    cdef dv.mlx5dv_context dv
diff --git a/pyverbs/providers/mlx5/mlx5dv.pyx b/pyverbs/providers/mlx5/mlx=
5dv.pyx
index 0c6b28be1d5a..dadc9cdcceee 100644
--- a/pyverbs/providers/mlx5/mlx5dv.pyx
+++ b/pyverbs/providers/mlx5/mlx5dv.pyx
@@ -2,7 +2,10 @@
 # Copyright (c) 2019 Mellanox Technologies, Inc. All rights reserved. See =
COPYING file
=20
 from pyverbs.pyverbs_error import PyverbsUserError
+cimport pyverbs.providers.mlx5.mlx5dv_enums as dve
 cimport pyverbs.providers.mlx5.libmlx5 as dv
+from pyverbs.base import PyverbsRDMAErrno
+cimport pyverbs.libibverbs_enums as e
=20
=20
 cdef class Mlx5DVContextAttr(PyverbsObject):
@@ -55,3 +58,196 @@ cdef class Mlx5Context(Context):
         if not dv.mlx5dv_is_supported(self.device):
             raise PyverbsUserError('This is not an MLX5 device')
         self.context =3D dv.mlx5dv_open_device(self.device, &attr.attr)
+
+    def query_mlx5_device(self, comp_mask=3D-1):
+        """
+        Queries the provider for device-specific attributes.
+        :param comp_mask: Which attributes to query. Default value is -1. =
If
+                          not changed by user, pyverbs will pass a bitwise=
 OR
+                          of all available enum entries.
+        :return: A Mlx5DVContext containing the attributes.
+        """
+        dv_attr =3D Mlx5DVContext()
+        if comp_mask =3D=3D -1:
+            dv_attr.comp_mask =3D \
+                dve.MLX5DV_CONTEXT_MASK_CQE_COMPRESION |\
+                dve.MLX5DV_CONTEXT_MASK_SWP |\
+                dve.MLX5DV_CONTEXT_MASK_STRIDING_RQ |\
+                dve.MLX5DV_CONTEXT_MASK_TUNNEL_OFFLOADS |\
+                dve.MLX5DV_CONTEXT_MASK_DYN_BFREGS |\
+                dve.MLX5DV_CONTEXT_MASK_CLOCK_INFO_UPDATE |\
+                dve.MLX5DV_CONTEXT_MASK_FLOW_ACTION_FLAGS
+        else:
+            dv_attr.comp_mask =3D comp_mask
+        rc =3D dv.mlx5dv_query_device(self.context, &dv_attr.dv)
+        if rc !=3D 0:
+            raise PyverbsRDMAErrno('Failed to query mlx5 device {name}, go=
t {rc}'.
+                                   format(name=3Dself.name, rc=3Drc))
+        return dv_attr
+
+
+cdef class Mlx5DVContext(PyverbsObject):
+    """
+    Represents mlx5dv_context struct, which exposes mlx5-specific capabili=
ties,
+    reported by mlx5dv_query_device.
+    """
+    @property
+    def version(self):
+        return self.dv.version
+
+    @property
+    def flags(self):
+        return self.dv.flags
+
+    @property
+    def comp_mask(self):
+        return self.dv.comp_mask
+    @comp_mask.setter
+    def comp_mask(self, val):
+        self.dv.comp_mask =3D val
+
+    @property
+    def cqe_comp_caps(self):
+        return self.dv.cqe_comp_caps
+
+    @property
+    def sw_parsing_caps(self):
+        return self.dv.sw_parsing_caps
+
+    @property
+    def striding_rq_caps(self):
+        return self.dv.striding_rq_caps
+
+    @property
+    def tunnel_offload_caps(self):
+        return self.dv.tunnel_offloads_caps
+
+    @property
+    def max_dynamic_bfregs(self):
+        return self.dv.max_dynamic_bfregs
+
+    @property
+    def max_clock_info_update_nsec(self):
+        return self.dv.max_clock_info_update_nsec
+
+    @property
+    def flow_action_flags(self):
+        return self.dv.flow_action_flags
+
+    @property
+    def dc_odp_caps(self):
+        return self.dv.dc_odp_caps
+
+    def __str__(self):
+        print_format =3D '{:20}: {:<20}\n'
+        ident_format =3D '  {:20}: {:<20}\n'
+        cqe =3D 'CQE compression caps:\n' +\
+              ident_format.format('max num',
+                                  self.dv.cqe_comp_caps.max_num) +\
+              ident_format.format('supported formats',
+                                  cqe_comp_to_str(self.dv.cqe_comp_caps.su=
pported_format))
+        swp =3D 'SW parsing caps:\n' +\
+              ident_format.format('SW parsing offloads',
+                                  swp_to_str(self.dv.sw_parsing_caps.sw_pa=
rsing_offloads)) +\
+              ident_format.format('supported QP types',
+                                  qpts_to_str(self.dv.sw_parsing_caps.supp=
orted_qpts))
+        strd =3D 'Striding RQ caps:\n' +\
+               ident_format.format('min single stride log num of bytes',
+                                   self.dv.striding_rq_caps.min_single_str=
ide_log_num_of_bytes) +\
+               ident_format.format('max single stride log num of bytes',
+                                   self.dv.striding_rq_caps.max_single_str=
ide_log_num_of_bytes) +\
+               ident_format.format('min single wqe log num of strides',
+                                   self.dv.striding_rq_caps.min_single_wqe=
_log_num_of_strides) +\
+               ident_format.format('max single wqe log num of strides',
+                                   self.dv.striding_rq_caps.max_single_wqe=
_log_num_of_strides) +\
+               ident_format.format('supported QP types',
+                                   qpts_to_str(self.dv.striding_rq_caps.su=
pported_qpts))
+        return print_format.format('Version', self.dv.version) +\
+               print_format.format('Flags',
+                                   context_flags_to_str(self.dv.flags)) +\
+               print_format.format('comp mask',
+                                   context_comp_mask_to_str(self.dv.comp_m=
ask)) +\
+               cqe + swp + strd +\
+               print_format.format('Tunnel offloads caps',
+                                   tunnel_offloads_to_str(self.dv.tunnel_o=
ffloads_caps)) +\
+               print_format.format('Max dynamic BF registers',
+                                   self.dv.max_dynamic_bfregs) +\
+               print_format.format('Max clock info update [nsec]',
+                                   self.dv.max_clock_info_update_nsec) +\
+               print_format.format('Flow action flags',
+                                   self.dv.flow_action_flags) +\
+               print_format.format('DC ODP caps', self.dv.dc_odp_caps)
+
+
+def qpts_to_str(qp_types):
+    numberic_types =3D qp_types
+    qpts_str =3D ''
+    qpts =3D {e.IBV_QPT_RC: 'RC', e.IBV_QPT_UC: 'UC', e.IBV_QPT_UD: 'UD',
+            e.IBV_QPT_RAW_PACKET: 'Raw Packet', e.IBV_QPT_XRC_SEND: 'XRC S=
end',
+            e.IBV_QPT_XRC_RECV: 'XRC Recv', e.IBV_QPT_DRIVER: 'Driver QPT'=
}
+    for t in qpts.keys():
+        if (1 << t) & qp_types:
+            qpts_str +=3D qpts[t] + ', '
+            qp_types -=3D t
+        if qp_types =3D=3D 0:
+            break
+    return qpts_str[:-2] + ' ({})'.format(numberic_types)
+
+
+def bitmask_to_str(bits, values):
+    numeric_bits =3D bits
+    res =3D ''
+    for t in values.keys():
+        if t & bits:
+            res +=3D values[t] + ', '
+            bits -=3D t
+        if bits =3D=3D 0:
+            break
+    return res[:-2] + ' ({})'.format(numeric_bits) # Remove last comma and=
 space
+
+
+def context_comp_mask_to_str(mask):
+    l =3D {dve.MLX5DV_CONTEXT_MASK_CQE_COMPRESION: 'CQE compression',
+         dve.MLX5DV_CONTEXT_MASK_SWP: 'SW parsing',
+         dve.MLX5DV_CONTEXT_MASK_STRIDING_RQ: 'Striding RQ',
+         dve.MLX5DV_CONTEXT_MASK_TUNNEL_OFFLOADS: 'Tunnel offloads',
+         dve.MLX5DV_CONTEXT_MASK_DYN_BFREGS: 'Dynamic BF regs',
+         dve.MLX5DV_CONTEXT_MASK_CLOCK_INFO_UPDATE: 'Clock info update',
+         dve.MLX5DV_CONTEXT_MASK_FLOW_ACTION_FLAGS: 'Flow action flags'}
+    return bitmask_to_str(mask, l)
+
+
+def context_flags_to_str(flags):
+    l =3D {dve.MLX5DV_CONTEXT_FLAGS_CQE_V1: 'CQE v1',
+         dve.MLX5DV_CONTEXT_FLAGS_MPW_ALLOWED: 'Multi packet WQE allowed',
+         dve.MLX5DV_CONTEXT_FLAGS_ENHANCED_MPW: 'Enhanced multi packet WQE=
',
+         dve.MLX5DV_CONTEXT_FLAGS_CQE_128B_COMP: 'Support CQE 128B compres=
sion',
+         dve.MLX5DV_CONTEXT_FLAGS_CQE_128B_PAD: 'Support CQE 128B padding'=
,
+         dve.MLX5DV_CONTEXT_FLAGS_PACKET_BASED_CREDIT_MODE:
+         'Support packet based credit mode (in RC QP)'}
+    return bitmask_to_str(flags, l)
+
+
+def swp_to_str(swps):
+    l =3D {dve.MLX5DV_SW_PARSING: 'SW Parsing',
+         dve.MLX5DV_SW_PARSING_CSUM: 'SW Parsing CSUM',
+         dve.MLX5DV_SW_PARSING_LSO: 'SW Parsing LSO'}
+    return bitmask_to_str(swps, l)
+
+
+def cqe_comp_to_str(cqe):
+    l =3D {dve.MLX5DV_CQE_RES_FORMAT_HASH: 'with hash',
+         dve.MLX5DV_CQE_RES_FORMAT_CSUM: 'with RX checksum CSUM',
+         dve.MLX5DV_CQE_RES_FORMAT_CSUM_STRIDX: 'with stride index'}
+    return bitmask_to_str(cqe, l)
+
+
+def tunnel_offloads_to_str(tun):
+    l =3D {dve.MLX5DV_RAW_PACKET_CAP_TUNNELED_OFFLOAD_VXLAN: 'VXLAN',
+         dve.MLX5DV_RAW_PACKET_CAP_TUNNELED_OFFLOAD_GRE: 'GRE',
+         dve.MLX5DV_RAW_PACKET_CAP_TUNNELED_OFFLOAD_GENEVE: 'Geneve',
+         dve.MLX5DV_RAW_PACKET_CAP_TUNNELED_OFFLOAD_CW_MPLS_OVER_GRE:\
+         'Ctrl word + MPLS over GRE',
+         dve.MLX5DV_RAW_PACKET_CAP_TUNNELED_OFFLOAD_CW_MPLS_OVER_UDP:\
+         'Ctrl word + MPLS over UDP'}
+    return bitmask_to_str(tun, l)
diff --git a/pyverbs/providers/mlx5/mlx5dv_enums.pxd b/pyverbs/providers/ml=
x5/mlx5dv_enums.pxd
new file mode 100644
index 000000000000..038a49111a3b
--- /dev/null
+++ b/pyverbs/providers/mlx5/mlx5dv_enums.pxd
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
+# Copyright (c) 2019 Mellanox Technologies, Inc. All rights reserved. See =
COPYING file
+
+#cython: language_level=3D3
+
+cdef extern from 'infiniband/mlx5dv.h':
+
+    cpdef enum mlx5dv_context_comp_mask:
+        MLX5DV_CONTEXT_MASK_CQE_COMPRESION      =3D 1 << 0
+        MLX5DV_CONTEXT_MASK_SWP                 =3D 1 << 1
+        MLX5DV_CONTEXT_MASK_STRIDING_RQ         =3D 1 << 2
+        MLX5DV_CONTEXT_MASK_TUNNEL_OFFLOADS     =3D 1 << 3
+        MLX5DV_CONTEXT_MASK_DYN_BFREGS          =3D 1 << 4
+        MLX5DV_CONTEXT_MASK_CLOCK_INFO_UPDATE   =3D 1 << 5
+        MLX5DV_CONTEXT_MASK_FLOW_ACTION_FLAGS   =3D 1 << 6
+
+    cpdef enum mlx5dv_context_flags:
+        MLX5DV_CONTEXT_FLAGS_CQE_V1                     =3D 1 << 0
+        MLX5DV_CONTEXT_FLAGS_MPW_ALLOWED                =3D 1 << 2
+        MLX5DV_CONTEXT_FLAGS_ENHANCED_MPW               =3D 1 << 3
+        MLX5DV_CONTEXT_FLAGS_CQE_128B_COMP              =3D 1 << 4
+        MLX5DV_CONTEXT_FLAGS_CQE_128B_PAD               =3D 1 << 5
+        MLX5DV_CONTEXT_FLAGS_PACKET_BASED_CREDIT_MODE   =3D 1 << 6
+
+    cpdef enum mlx5dv_sw_parsing_offloads:
+        MLX5DV_SW_PARSING       =3D 1 << 0
+        MLX5DV_SW_PARSING_CSUM  =3D 1 << 1
+        MLX5DV_SW_PARSING_LSO   =3D 1 << 2
+
+    cpdef enum mlx5dv_cqe_comp_res_format:
+        MLX5DV_CQE_RES_FORMAT_HASH          =3D 1 << 0
+        MLX5DV_CQE_RES_FORMAT_CSUM          =3D 1 << 1
+        MLX5DV_CQE_RES_FORMAT_CSUM_STRIDX   =3D 1 << 2
+
+    cpdef enum mlx5dv_tunnel_offloads:
+        MLX5DV_RAW_PACKET_CAP_TUNNELED_OFFLOAD_VXLAN            =3D 1 << 0
+        MLX5DV_RAW_PACKET_CAP_TUNNELED_OFFLOAD_GRE              =3D 1 << 1
+        MLX5DV_RAW_PACKET_CAP_TUNNELED_OFFLOAD_GENEVE           =3D 1 << 2
+        MLX5DV_RAW_PACKET_CAP_TUNNELED_OFFLOAD_CW_MPLS_OVER_GRE =3D 1 << 3
+        MLX5DV_RAW_PACKET_CAP_TUNNELED_OFFLOAD_CW_MPLS_OVER_UDP =3D 1 << 4
+
+    cpdef enum mlx5dv_flow_action_cap_flags:
+        MLX5DV_FLOW_ACTION_FLAGS_ESP_AES_GCM                =3D 1 << 0
+        MLX5DV_FLOW_ACTION_FLAGS_ESP_AES_GCM_REQ_METADATA   =3D 1 << 1
+        MLX5DV_FLOW_ACTION_FLAGS_ESP_AES_GCM_SPI_STEERING   =3D 1 << 2
+        MLX5DV_FLOW_ACTION_FLAGS_ESP_AES_GCM_FULL_OFFLOAD   =3D 1 << 3
+        MLX5DV_FLOW_ACTION_FLAGS_ESP_AES_GCM_TX_IV_IS_ESN   =3D 1 << 4
--=20
2.21.0

