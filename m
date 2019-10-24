Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58A17E34C5
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2019 15:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbfJXNvJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Oct 2019 09:51:09 -0400
Received: from mail-eopbgr140085.outbound.protection.outlook.com ([40.107.14.85]:41089
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727811AbfJXNvJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 24 Oct 2019 09:51:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPP+XERRqOXTTMeoOOyH53eYnrGor6v9iinJ/A8GlM4z//VctYN/IIxZ7Zuc03vO0fKU6EJwdkj4A9jPm8MW3Fxv/34rskEHAwDhpuCmb5greH0TjtdLVY8YjtzwuCVyhW+qz/TGl+LfNHGEbDhUHgp6zRydoaLOhQJ3zn9AtophsmuFr4eqrIz/bKCUZ9R5EgS78d6UwCMm+cOsc9x3o7PWZ/oFz0Yxf8UHQLK54AL7RjDdL1itcp6BZHG6jipSNgjng4l33if+TPakecb92I7AiPZXwLTPVrjMLal4+UHOkjr8/4uQxJiC73vugkHkpvfBW9pz90OyRb0/iqXRMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3EuWF+5jNdtO8MH9zK/hgZMC4+PQuqVfNlOnTM3sGj8=;
 b=HSTTkaMZOTpfDSHVWf8e2c1P0MOFeGKJfnshdVxYkPD3dX8e/fK+R9Q/0wvd12OUfSjjV4hgpwkT88sMtTbF7iyjwpneGogAHRBI1FUAY97/dZDUPGKwdmUWYl635HgVeggEwJEdldjh/ArbhLqVkP8TuEKrW1YpPO8hvilXB++t2jN2rRU96tVuJG8QMOWFbEFx9/u9KYQIF4zLqOyj6kfo3z9DJrWwto9M1QUQPt8fXYtbAKNyLI8M5NTF/U5CwVSJbmPWD3dR3eqsvX8VJV6pqVAGk5qF03LImqEykK1d1wRe7bhhKwXSarYnYOTgaZ1emI1CY/JcwE4RrkNIQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3EuWF+5jNdtO8MH9zK/hgZMC4+PQuqVfNlOnTM3sGj8=;
 b=kNCwh5ViNRZxhaqepann5TjqJoujNMEmXkzR1oEBveyCPToUzyJu4wKa21O3cjyB05+M2n/qkcvGYTl4qfv4nKYlFDT3NJh2NAFdxBJ4RSbtrGUFDN1rZYDI2oJiI0Suem6aWrzLvJ6RhOrpE6R5q7LO1SFLN4EzySMoLPCFsZk=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB3391.eurprd05.prod.outlook.com (10.175.245.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.24; Thu, 24 Oct 2019 13:51:03 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::75ae:b00b:69d8:3db0]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::75ae:b00b:69d8:3db0%7]) with mapi id 15.20.2367.027; Thu, 24 Oct 2019
 13:51:03 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: [PATCH] rdma: Remove nes ABI header
Thread-Topic: [PATCH] rdma: Remove nes ABI header
Thread-Index: AQHVinITy6VHpQeZFkCQPCIvBqJztQ==
Date:   Thu, 24 Oct 2019 13:51:03 +0000
Message-ID: <20191024135059.GA20084@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR10CA0022.namprd10.prod.outlook.com
 (2603:10b6:208:120::35) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 605a3cfd-62e5-4921-d67e-08d7588935c5
x-ms-traffictypediagnostic: VI1PR05MB3391:
x-microsoft-antispam-prvs: <VI1PR05MB33912A78F9060A3D5D738F13CF6A0@VI1PR05MB3391.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(199004)(189003)(2906002)(66476007)(25786009)(6506007)(316002)(66556008)(386003)(52116002)(66946007)(64756008)(66446008)(305945005)(81156014)(186003)(2351001)(81166006)(1076003)(6916009)(5660300002)(8676002)(99286004)(7736002)(66066001)(26005)(33656002)(6512007)(476003)(486006)(36756003)(5640700003)(102836004)(8936002)(9686003)(86362001)(2501003)(6436002)(6486002)(14444005)(71190400001)(14454004)(6116002)(3846002)(71200400001)(478600001)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3391;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9wxgFmJIJWVX5wLgLkIKxrV/FNb9EY5VnPj6f2qiE7ZuvY0wmnJyUMAdCBjw27n4EnqxBRQSiqAlleu9nUEmrSQBbZbmalSNPCqcLhZDuJ8YKZ9JnuViShH4DVZCcYVfw6bUFB1SBf/dCmGYlpV4/Nws1ud+S39PbMo9AGewwRypgy21vS2wsnj2SX036j+bda+Q/AAHOCnKlf1jl3nfnC4DXPgQ8M+Z9R4aJDl9mLBtz3zOpmB4hjv9kvIwzd5d0rnBYUV7MNvKpwTQy6hFqIM/hk4TFxjN5wlCWKdwHX7gYNJmqaFWk+uoPcSqy7PGgSvEj+cnJvulYvs3Zh6+Tw8DQF9dOLMHSv0bs0n/CE+g2WfarY53CJAos8+pJpIbj7Pj7P55B8pctphixs525zAUVMj7xZj7iJ3K/2GB2w9nm8oopgJrqJ3UVoJs5jNo
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0F6A8C0CC3FD1C41A4335F4986315D8B@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 605a3cfd-62e5-4921-d67e-08d7588935c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 13:51:03.4005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4jKxZr78y0AAk8hSLiH1GLduEGRWQjERCMwQbtqvHw0WXzm5R6WtjsvRnLPnUAxeGnLzNVAfVTedMXhp7GQDig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3391
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This was missed when nes was removed.

Fixes: 2d3c72ed5041 ("rdma: Remove nes")
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 include/uapi/rdma/nes-abi.h | 115 ------------------------------------
 1 file changed, 115 deletions(-)
 delete mode 100644 include/uapi/rdma/nes-abi.h

diff --git a/include/uapi/rdma/nes-abi.h b/include/uapi/rdma/nes-abi.h
deleted file mode 100644
index f80495baa9697e..00000000000000
--- a/include/uapi/rdma/nes-abi.h
+++ /dev/null
@@ -1,115 +0,0 @@
-/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR Linux-Op=
enIB) */
-/*
- * Copyright (c) 2006 - 2011 Intel Corporation.  All rights reserved.
- * Copyright (c) 2005 Topspin Communications.  All rights reserved.
- * Copyright (c) 2005 Cisco Systems.  All rights reserved.
- * Copyright (c) 2005 Open Grid Computing, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *      - Redistributions of source code must retain the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer.
- *
- *      - Redistributions in binary form must reproduce the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer in the documentation and/or other materials
- *        provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
- *
- */
-
-#ifndef NES_ABI_USER_H
-#define NES_ABI_USER_H
-
-#include <linux/types.h>
-
-#define NES_ABI_USERSPACE_VER 2
-#define NES_ABI_KERNEL_VER    2
-
-/*
- * Make sure that all structs defined in this file remain laid out so
- * that they pack the same way on 32-bit and 64-bit architectures (to
- * avoid incompatibility between 32-bit userspace and 64-bit kernels).
- * In particular do not use pointer types -- pass pointers in __u64
- * instead.
- */
-
-struct nes_alloc_ucontext_req {
-	__u32 reserved32;
-	__u8  userspace_ver;
-	__u8  reserved8[3];
-};
-
-struct nes_alloc_ucontext_resp {
-	__u32 max_pds; /* maximum pds allowed for this user process */
-	__u32 max_qps; /* maximum qps allowed for this user process */
-	__u32 wq_size; /* size of the WQs (sq+rq) allocated to the mmaped area */
-	__u8  virtwq;  /* flag to indicate if virtual WQ are to be used or not */
-	__u8  kernel_ver;
-	__u8  reserved[2];
-};
-
-struct nes_alloc_pd_resp {
-	__u32 pd_id;
-	__u32 mmap_db_index;
-};
-
-struct nes_create_cq_req {
-	__aligned_u64 user_cq_buffer;
-	__u32 mcrqf;
-	__u8 reserved[4];
-};
-
-struct nes_create_qp_req {
-	__aligned_u64 user_wqe_buffers;
-	__aligned_u64 user_qp_buffer;
-};
-
-enum iwnes_memreg_type {
-	IWNES_MEMREG_TYPE_MEM =3D 0x0000,
-	IWNES_MEMREG_TYPE_QP =3D 0x0001,
-	IWNES_MEMREG_TYPE_CQ =3D 0x0002,
-	IWNES_MEMREG_TYPE_MW =3D 0x0003,
-	IWNES_MEMREG_TYPE_FMR =3D 0x0004,
-	IWNES_MEMREG_TYPE_FMEM =3D 0x0005,
-};
-
-struct nes_mem_reg_req {
-	__u32 reg_type;	/* indicates if id is memory, QP or CQ */
-	__u32 reserved;
-};
-
-struct nes_create_cq_resp {
-	__u32 cq_id;
-	__u32 cq_size;
-	__u32 mmap_db_index;
-	__u32 reserved;
-};
-
-struct nes_create_qp_resp {
-	__u32 qp_id;
-	__u32 actual_sq_size;
-	__u32 actual_rq_size;
-	__u32 mmap_sq_db_index;
-	__u32 mmap_rq_db_index;
-	__u32 nes_drv_opt;
-};
-
-#endif	/* NES_ABI_USER_H */
--=20
2.23.0

