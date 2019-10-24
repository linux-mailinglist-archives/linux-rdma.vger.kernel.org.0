Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3195E2A35
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2019 08:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437596AbfJXGA6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Oct 2019 02:00:58 -0400
Received: from mail-eopbgr50068.outbound.protection.outlook.com ([40.107.5.68]:21413
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2437663AbfJXGA5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 24 Oct 2019 02:00:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cy67AUs3CMD6MkpQx/f/VPfBNYDmsdIYlbneFNEz84pzg1K11u+GvMhuN5J6YuneIIivFOkK1/6sHbHFhE7fRDOYLbwpnR4lB5+qsv0Px602WS4yvkzd00a5UCn1sW0HVS7agR/O3FWE+1cKLNFfn6VAkx6X6VgDWSUNkfdpbXd768jga282lt9vrhXm/DVPBz02XnDo1pmcLiSRfda3pCq7x3Zm3868gabjUbBwA1OEHhlodfc5QEU03qsUV5EccTYP44458G8/refDmLsd09xxWDo6F0v1LprjRMpD1o1WPBbRUvFOsdL/0o2g877H0dBWKyHmZ6CP5GuDbBvnMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/D0im2QpL6zyzVDoUoXR3iX6byHwXojxBDZbq6WRE4=;
 b=MLtBuImiWh4yF4Ge9iIQpPO2h4uWyYCHVXQBQOYMqE+htdMajOcjcK3tCYL3dNjIDly/aTTwqQz3T28DSSQ3+kJltiVeQR4yXkMFtfU78BtN7bSMktGTFGzF/vR862Lp5LKuW1vFFrQXVqu+DWV8TxVclrUiHucoPZinFT0Ur8wHMAuwUYKtW57r82udQYiNJLLOOVOPbNP2ja/snwvKeU6GzIIFqIxORHPDJfvwlux4U0q1uVLcBGFPiJ9allcw8Pt1mxBVBr8/8yPlpMMHFtQBbD2OKWa4S+mqJ82UbESRafnPqyhn92AZpXMM6ULKM+0NRnAixMXROrB3RBRLLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/D0im2QpL6zyzVDoUoXR3iX6byHwXojxBDZbq6WRE4=;
 b=jwn8yx4EXCfYUzk7I0P1Sfs9F5JBE6iR777wa+GMUq8ePz7EiFNlnYyU/RxGDZ4GXg3KT27Kp8Yfoyl9qbuw+i6lq5Ae3HuAdsi0F0gzcwCI8FpRYFcC6r3EAK95/iNQV2FPig34Kv/NB0sqCvahF3GpGVXzequ812CIfsb/96M=
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com (20.177.33.17) by
 AM6PR05MB4182.eurprd05.prod.outlook.com (52.135.164.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Thu, 24 Oct 2019 06:00:49 +0000
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::ecbd:11b3:e4e9:fa1a]) by AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::ecbd:11b3:e4e9:fa1a%5]) with mapi id 15.20.2347.029; Thu, 24 Oct 2019
 06:00:49 +0000
From:   Noa Osherovich <noaos@mellanox.com>
To:     "dledford@redhat.com" <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Noa Osherovich <noaos@mellanox.com>
Subject: [PATCH rdma-core 3/4] pyverbs: Add providers to cmake build
Thread-Topic: [PATCH rdma-core 3/4] pyverbs: Add providers to cmake build
Thread-Index: AQHVijBicvr9tvojhUqvetli8muUrQ==
Date:   Thu, 24 Oct 2019 06:00:49 +0000
Message-ID: <20191024060027.8696-4-noaos@mellanox.com>
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
x-ms-office365-filtering-correlation-id: c01cf6e1-471d-437d-db85-08d7584784b2
x-ms-traffictypediagnostic: AM6PR05MB4182:|AM6PR05MB4182:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR05MB4182BD0176D9E86EB77B5D12D96A0@AM6PR05MB4182.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(199004)(189003)(478600001)(71200400001)(86362001)(486006)(71190400001)(2501003)(11346002)(2616005)(446003)(52116002)(476003)(4326008)(76176011)(110136005)(54906003)(66946007)(66476007)(66556008)(66446008)(64756008)(6636002)(14454004)(99286004)(19627235002)(107886003)(26005)(186003)(305945005)(7736002)(316002)(66066001)(6506007)(386003)(3846002)(36756003)(14444005)(256004)(102836004)(8936002)(50226002)(1076003)(6116002)(2906002)(81156014)(81166006)(6436002)(6512007)(6486002)(5660300002)(25786009)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB4182;H:AM6PR05MB4968.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hhth1woTKuarffSzh0UNMbskqMremziPK9xael6uabVAiGgwTC0U9zyLqqvZbQ5SJa3BPZwyocW1Xyybpkn6cwijYTIbH4z4NdPdeRD+kYGgg9IZFMXret7tLwr+X1dceSoKGfg6zVBrD0akCo73wZpr04zeH1ug+rtefkOLhpl51Gz86Wg9jN5NPdA7wwDdP/QsNuuSxxiYBoa98w1yurvGt/zs/99PGIRAyiOfKF9+QhC6Rb5ntUAfMRnpuGyDNEqQ4uP0nECz/98A1dXkh5O5nI53OmNTqXHZ2v7B433C1j+QcTZ/R8UGIprZjlhmHDSfgTfVC2Hr8SgEZY2E+Naj+nHST+WSZnMDsY0cJGQyovn+zsXGarm3+JJxg1rQvv4EB/i1Ke8ejPIJr2+CAPZ3eRmJdi6a7V2jfVIU0lKiQMw0JPGZmHtJ88gpY3Sz
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c01cf6e1-471d-437d-db85-08d7584784b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 06:00:49.1399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wIiQynS0Rn/5hNPQyQtDCjiluAXJWoYemXxC1xsViiOTA/4NSL1IPabAhRlkVqUX9R3lOrka98W8WPjxZfyXsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4182
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Adapt the building function to support subdirectories under pyverbs.
Add the needed CMakeLists file to pyverbs/providers.
Update pyverbs' CMakeLists to include the providers sub directory.

Signed-off-by: Noa Osherovich <noaos@mellanox.com>
---
 buildlib/pyverbs_functions.cmake      | 11 ++++++++---
 pyverbs/CMakeLists.txt                |  7 ++++++-
 pyverbs/providers/mlx5/CMakeLists.txt |  6 ++++++
 3 files changed, 20 insertions(+), 4 deletions(-)
 create mode 100644 pyverbs/providers/mlx5/CMakeLists.txt

diff --git a/buildlib/pyverbs_functions.cmake b/buildlib/pyverbs_functions.=
cmake
index 8ea5dc0df7de..4c255054fe94 100644
--- a/buildlib/pyverbs_functions.cmake
+++ b/buildlib/pyverbs_functions.cmake
@@ -1,10 +1,15 @@
 # SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
 # Copyright (c) 2018, Mellanox Technologies. All rights reserved.  See COP=
YING file
=20
-function(rdma_cython_module PY_MODULE)
+function(rdma_cython_module PY_MODULE LINKER_FLAGS)
   foreach(PYX_FILE ${ARGN})
     get_filename_component(FILENAME ${PYX_FILE} NAME_WE)
-    set(PYX "${CMAKE_CURRENT_SOURCE_DIR}/${FILENAME}.pyx")
+    get_filename_component(DIR ${PYX_FILE} DIRECTORY)
+	if (DIR)
+		set(PYX "${CMAKE_CURRENT_SOURCE_DIR}/${DIR}/${FILENAME}.pyx")
+	else()
+	    set(PYX "${CMAKE_CURRENT_SOURCE_DIR}/${FILENAME}.pyx")
+	endif()
     set(CFILE "${CMAKE_CURRENT_BINARY_DIR}/${FILENAME}.c")
     include_directories(${PYTHON_INCLUDE_DIRS})
     add_custom_command(
@@ -20,7 +25,7 @@ function(rdma_cython_module PY_MODULE)
       COMPILE_FLAGS "${CMAKE_C_FLAGS} -fPIC -fno-strict-aliasing -Wno-unus=
ed-function -Wno-redundant-decls -Wno-shadow -Wno-cast-function-type -Wno-i=
mplicit-fallthrough -Wno-unknown-warning -Wno-unknown-warning-option ${NO_V=
AR_TRACKING_FLAGS}"
       LIBRARY_OUTPUT_DIRECTORY "${BUILD_PYTHON}/${PY_MODULE}"
       PREFIX "")
-    target_link_libraries(${SONAME} LINK_PRIVATE ${PYTHON_LIBRARIES} ibver=
bs)
+    target_link_libraries(${SONAME} LINK_PRIVATE ${PYTHON_LIBRARIES} ibver=
bs ${LINKER_FLAGS})
     install(TARGETS ${SONAME}
       DESTINATION ${CMAKE_INSTALL_PYTHON_ARCH_LIB}/${PY_MODULE})
   endforeach()
diff --git a/pyverbs/CMakeLists.txt b/pyverbs/CMakeLists.txt
index 90293982b280..7bbb5fc841c0 100755
--- a/pyverbs/CMakeLists.txt
+++ b/pyverbs/CMakeLists.txt
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
 # Copyright (c) 2019, Mellanox Technologies. All rights reserved. See COPY=
ING file
=20
-rdma_cython_module(pyverbs
+rdma_cython_module(pyverbs ""
   addr.pyx
   base.pyx
   cq.pyx
@@ -20,3 +20,8 @@ rdma_python_module(pyverbs
   pyverbs_error.py
   utils.py
   )
+
+# mlx5 provider is not built without coherent DMA, e.g. ARM32 build.
+if (HAVE_COHERENT_DMA)
+add_subdirectory(providers/mlx5)
+endif()
diff --git a/pyverbs/providers/mlx5/CMakeLists.txt b/pyverbs/providers/mlx5=
/CMakeLists.txt
new file mode 100644
index 000000000000..f6536de8a932
--- /dev/null
+++ b/pyverbs/providers/mlx5/CMakeLists.txt
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
+# Copyright (c) 2019, Mellanox Technologies. All rights reserved. See COPY=
ING file
+
+rdma_cython_module(pyverbs/providers/mlx5 mlx5
+  mlx5dv.pyx
+)
--=20
2.21.0

