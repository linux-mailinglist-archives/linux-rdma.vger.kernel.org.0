Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A04FE2A34
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2019 08:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437665AbfJXGAz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Oct 2019 02:00:55 -0400
Received: from mail-eopbgr50068.outbound.protection.outlook.com ([40.107.5.68]:21413
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2437466AbfJXGAy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 24 Oct 2019 02:00:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSxKf+CmSuxxZAMpF9fWS8rPFCTrOOFoyPv+IzuVixnMRtskjvbyjoqa1gZFFJxdRP6H2zWx7l3Aokhz+HPiwPzpizr+2hWhGM3gcnruhMcHOL3m3IXhPvQcgR+EXeqT/npi9Oj/SbnZxUtrBZFwXjATwQIQT8TYpOKQCVCJafKAKZbm2ZHp28M3JkPUrwFXP6kKDGsYPBYCcjXPoJJ5ssIoGcI/SqLZ7M5T2VTDWvVRuTfGGYGC8PkC59tm3JXJ0Puubx7p2SuyQgLm6BWw5y8O9HAsgDrGPnVOSTtTrx25vVElXbzj6VXrLadxC6+0OI6lXHSq/VkrGum8RmMkOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEDcWfJAxbJAXmZR4CgGqIByR23UW7rzxEwOwopPDBs=;
 b=IBgkqarscMhvifepL/BKoawMwet09Ma3MAe+118pPbfs47tJsZ3y9pgU/MnFIxGcn+Yv27aT0sRi8eaxgxbYaSpifWxUULYN77ojnVkDdo+mGojvI1xGBfdWlk4tysVPCEXnvmy6guFdG2j4sgNbRYeikLqy/2T0kAR/Sp3a/SfU/cZTaWVEQSypf+2/aUBZJtep00qQZ2kR8j9eN8ZAlPfaZgCjF9rLUEUmgcVNthjYF9iLRSNjv+OX2OKh6kxMYdLnEHnTw/TFXnyHPXVUF1Rl7ch9VobjRdKC3rJBLhLVfXvIRCYObvS5u5L+j0KW+0av5fxJS80T8B0nxuozhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEDcWfJAxbJAXmZR4CgGqIByR23UW7rzxEwOwopPDBs=;
 b=X5vdN/BpHFd5jCPR335JnNYUS7tQjaT4F0UkVtvIfMsmli8RpC9mT7nfNH3vq2g6UF/Unjj1Q1guuw2dc65p2sOCRDEbf79B/X3WCKldBV2EhPssMuWZ7p3o4VL0AelpsS43CKd1jbVDTftsGQncfBvF5EbmO3rwPUUgeQ9l7fM=
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com (20.177.33.17) by
 AM6PR05MB4182.eurprd05.prod.outlook.com (52.135.164.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Thu, 24 Oct 2019 06:00:48 +0000
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::ecbd:11b3:e4e9:fa1a]) by AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::ecbd:11b3:e4e9:fa1a%5]) with mapi id 15.20.2347.029; Thu, 24 Oct 2019
 06:00:48 +0000
From:   Noa Osherovich <noaos@mellanox.com>
To:     "dledford@redhat.com" <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Noa Osherovich <noaos@mellanox.com>
Subject: [PATCH rdma-core 2/4] pyverbs/mlx5: Add support for driver-specific
 context
Thread-Topic: [PATCH rdma-core 2/4] pyverbs/mlx5: Add support for
 driver-specific context
Thread-Index: AQHVijBheEMLLjx7j0K4/7pLDXTysA==
Date:   Thu, 24 Oct 2019 06:00:48 +0000
Message-ID: <20191024060027.8696-3-noaos@mellanox.com>
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
x-ms-office365-filtering-correlation-id: 50b83d3e-c0ef-41e4-fea0-08d758478428
x-ms-traffictypediagnostic: AM6PR05MB4182:|AM6PR05MB4182:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR05MB418237EFD4DE0DB5EB8FAEF4D96A0@AM6PR05MB4182.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(199004)(189003)(478600001)(71200400001)(86362001)(486006)(71190400001)(2501003)(11346002)(2616005)(446003)(52116002)(476003)(4326008)(76176011)(110136005)(54906003)(66946007)(66476007)(66556008)(66446008)(64756008)(6636002)(14454004)(99286004)(107886003)(26005)(186003)(305945005)(7736002)(316002)(66066001)(6506007)(386003)(3846002)(36756003)(256004)(102836004)(8936002)(50226002)(1076003)(6116002)(2906002)(81156014)(81166006)(6436002)(6512007)(6486002)(5660300002)(25786009)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB4182;H:AM6PR05MB4968.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZvbSvtPbaMCjyBPXvUipWjgimVwBm6ZTEl067akC6R34sfuRLOD/BgSPiGv8S41vm8PuLcz1jXWjz8lVwqgm+96aO33w7vUCYXi7tH2g9IYAZkxujrlgid/oBNOXIQGkmgTF/e8hu/iSoH34a5swiZdKB8oMAcQ84Jst9kQgwYJzjFs3u63zWAHTMRa9l9bFk7vTFopa1vwGFPgkBl/7wM6pnOr6sAIiyG3iRJrV4U3mlhmR2LhF0ntL9Gl4vGLBAF/L/ey9+xiWyaMJ6myFbRW/u6kjf3sWuZD5EuR3sWuauHpg3yly3FrptaaaDriLed9pl6BEM+uLqgh/0VxgWZY8oM3RjUVD/8k90bKbNuPRDQG0W+vIyFIo7lP0pGcz3p8taOTzdZIqt5LIzk2LP6V1vc7KJVqz7FBP9M1ShVlwAiZ1QZyDwAOxd4t4iHiH
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b83d3e-c0ef-41e4-fea0-08d758478428
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 06:00:48.1994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wULXfycjp/1mQ/D8asnK0NwPqT0XKmiVoK3w2eeJbJo1gA9rYju9vQw0z+FPJwXUMxKe69zKMYzC8qkcDLn4VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4182
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Allow users to open a device using mlx5dv_open_device. For this, two
new classes are introduced:
- Mlx5Context which inherits from Context.
- Mlx5DVContextAttr, which represents mlx5dv_context_attr struct,
  used by users to define driver-specific options for the device
  opening.

Signed-off-by: Noa Osherovich <noaos@mellanox.com>
---
 pyverbs/providers/__init__.pxd      |  0
 pyverbs/providers/__init__.py       |  0
 pyverbs/providers/mlx5/__init__.pxd |  0
 pyverbs/providers/mlx5/__init__.py  |  0
 pyverbs/providers/mlx5/libmlx5.pxd  | 17 +++++++++
 pyverbs/providers/mlx5/mlx5dv.pxd   | 14 +++++++
 pyverbs/providers/mlx5/mlx5dv.pyx   | 57 +++++++++++++++++++++++++++++
 7 files changed, 88 insertions(+)
 create mode 100644 pyverbs/providers/__init__.pxd
 create mode 100644 pyverbs/providers/__init__.py
 create mode 100644 pyverbs/providers/mlx5/__init__.pxd
 create mode 100644 pyverbs/providers/mlx5/__init__.py
 create mode 100644 pyverbs/providers/mlx5/libmlx5.pxd
 create mode 100644 pyverbs/providers/mlx5/mlx5dv.pxd
 create mode 100644 pyverbs/providers/mlx5/mlx5dv.pyx

diff --git a/pyverbs/providers/__init__.pxd b/pyverbs/providers/__init__.px=
d
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/pyverbs/providers/__init__.py b/pyverbs/providers/__init__.py
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/pyverbs/providers/mlx5/__init__.pxd b/pyverbs/providers/mlx5/_=
_init__.pxd
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/pyverbs/providers/mlx5/__init__.py b/pyverbs/providers/mlx5/__=
init__.py
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/pyverbs/providers/mlx5/libmlx5.pxd b/pyverbs/providers/mlx5/li=
bmlx5.pxd
new file mode 100644
index 000000000000..54d91e288590
--- /dev/null
+++ b/pyverbs/providers/mlx5/libmlx5.pxd
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
+# Copyright (c) 2019 Mellanox Technologies, Inc. All rights reserved. See =
COPYING file
+
+from libcpp cimport bool
+
+cimport pyverbs.libibverbs as v
+
+
+cdef extern from 'infiniband/mlx5dv.h':
+
+    cdef struct mlx5dv_context_attr:
+        unsigned int    flags
+        unsigned long   comp_mask
+
+    bool mlx5dv_is_supported(v.ibv_device *device)
+    v.ibv_context* mlx5dv_open_device(v.ibv_device *device,
+                                      mlx5dv_context_attr *attr)
diff --git a/pyverbs/providers/mlx5/mlx5dv.pxd b/pyverbs/providers/mlx5/mlx=
5dv.pxd
new file mode 100644
index 000000000000..6ab94b6484b0
--- /dev/null
+++ b/pyverbs/providers/mlx5/mlx5dv.pxd
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
+# Copyright (c) 2019 Mellanox Technologies, Inc. All rights reserved. See =
COPYING file
+
+#cython: language_level=3D3
+
+cimport pyverbs.providers.mlx5.libmlx5 as dv
+from pyverbs.base cimport PyverbsObject
+from pyverbs.device cimport Context
+
+cdef class Mlx5Context(Context):
+    pass
+
+cdef class Mlx5DVContextAttr(PyverbsObject):
+    cdef dv.mlx5dv_context_attr attr
diff --git a/pyverbs/providers/mlx5/mlx5dv.pyx b/pyverbs/providers/mlx5/mlx=
5dv.pyx
new file mode 100644
index 000000000000..0c6b28be1d5a
--- /dev/null
+++ b/pyverbs/providers/mlx5/mlx5dv.pyx
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
+# Copyright (c) 2019 Mellanox Technologies, Inc. All rights reserved. See =
COPYING file
+
+from pyverbs.pyverbs_error import PyverbsUserError
+cimport pyverbs.providers.mlx5.libmlx5 as dv
+
+
+cdef class Mlx5DVContextAttr(PyverbsObject):
+    """
+    Represent mlx5dv_context_attr struct. This class is used to open an ml=
x5
+    device.
+    """
+    def __cinit__(self, flags=3D0, comp_mask=3D0):
+        self.attr.flags =3D flags
+        self.attr.comp_mask =3D comp_mask
+
+    def __str__(self):
+        print_format =3D '{:20}: {:<20}\n'
+        return print_format.format('flags', self.attr.flags) +\
+               print_format.format('comp_mask', self.attr.comp_mask)
+
+    @property
+    def flags(self):
+        return self.attr.flags
+    @flags.setter
+    def flags(self, val):
+        self.attr.flags =3D val
+
+    @property
+    def comp_mask(self):
+        return self.attr.comp_mask
+    @comp_mask.setter
+    def comp_mask(self, val):
+        self.attr.comp_mask =3D val
+
+
+cdef class Mlx5Context(Context):
+    """
+    Represent mlx5 context, which extends Context.
+    """
+    def __cinit__(self, **kwargs):
+        """
+        Open an mlx5 device using the given attributes
+        :param kwargs: Arguments:
+            * *name* (str)
+               The RDMA device's name (used by parent class)
+            * *attr* (Mlx5DVContextAttr)
+               mlx5-specific device attributes
+        :return: None
+        """
+        cdef Mlx5DVContextAttr attr
+        attr =3D kwargs.get('attr')
+        if not attr or not isinstance(attr, Mlx5DVContextAttr):
+            raise PyverbsUserError('Missing provider attributes')
+        if not dv.mlx5dv_is_supported(self.device):
+            raise PyverbsUserError('This is not an MLX5 device')
+        self.context =3D dv.mlx5dv_open_device(self.device, &attr.attr)
--=20
2.21.0

