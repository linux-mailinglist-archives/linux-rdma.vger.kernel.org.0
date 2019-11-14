Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E06DFC2BB
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2019 10:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfKNJhv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Nov 2019 04:37:51 -0500
Received: from mail-eopbgr60075.outbound.protection.outlook.com ([40.107.6.75]:2435
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726410AbfKNJhv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 14 Nov 2019 04:37:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kFoI9HyTr2eUbwhZ7hPhsR6nDMQWGEWQ+Cx+ASt8Ow5w/mvdhKS+huoI/MN6A0ZMDRE5I9Ewq55fcidkSx6IoDqabqTUHhD0nTVNFsSND5owjlWKZOmDS2SckRAaYSGikowhUKikYd5TAJyCC6BfFXySlpcKhh4ezwUC2JFYWoanumuk5xsCkeDFjD1zhuhR38CKvkCRp3ckAIutVtLPLzQ20YWNrhUma11KnmRWNHdHsOL1NEj/MaidQCpQGdcUH2soFWI4c4lRgaUsjYP1dxFDjhp+nXZJt6p3GM9G+Ke/3Ktkodbegr4rQaVReTIjmvRuNsvJWrQsoXjWrGejHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZcKBdP2dsVtvU086ZRfEL6XQZXH+w42iFgS6d+BBRo=;
 b=AwmZTkz72Z3umFDRLcCPTqYWDR+jsmv7sQ1NJsD7/JB0XCJBde+V9rJCb7/AMoH9xNrW1gWdjOOaxttyEW8KZSW//u11HNQyyFpCd4WQy0YcAVav06OWkbxPluiCrTSHoWpwaUPWh6xlcJZKTHcjRMLGc9tdIY/BGPhsx8EeL8P+o3p/y9PRBm7ZSdiXKB58HxPxrlo4YcXwinPwB3xYscCRe752KVKBcEbhQSXS7jaozz0mCVzgwJPdMGOLivU4yyeDRHZ+gq7bprHK+X79AxZS/wMPfhOf6NB49SJQ0n7kOVNTjf5VnwqnICTY04guOw0KJdKmQUCOxG04SQJZYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZcKBdP2dsVtvU086ZRfEL6XQZXH+w42iFgS6d+BBRo=;
 b=VAYhmn3I3JC/n2aAgrWpg6m3Is3rk+TXPvDgpaBH2ZBFCxQToG5xqP9OBsmQ5byFPsx/ZJ8YqJkJ5wPtnohBpeIA0bLxxwV7RW+RWa8QvxGbUk78QradVHpRyDGhDJDUz/lKBVhDoeUVaHsQjq3dLVNwP0ZmCx/cVLxN2OKL9XQ=
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com (20.177.33.17) by
 AM6PR05MB6230.eurprd05.prod.outlook.com (20.178.95.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Thu, 14 Nov 2019 09:37:47 +0000
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::505f:e3f8:3f87:e3ff]) by AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::505f:e3f8:3f87:e3ff%7]) with mapi id 15.20.2430.028; Thu, 14 Nov 2019
 09:37:47 +0000
From:   Noa Osherovich <noaos@mellanox.com>
To:     "dledford@redhat.com" <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Edward Srouji <edwards@mellanox.com>,
        Noa Osherovich <noaos@mellanox.com>
Subject: [PATCH rdma-core 3/4] pyverbs: Document ParentDomain class and add a
 simple example
Thread-Topic: [PATCH rdma-core 3/4] pyverbs: Document ParentDomain class and
 add a simple example
Thread-Index: AQHVms8sn8Z/uBrjf0egaxUqQvxt5g==
Date:   Thu, 14 Nov 2019 09:37:47 +0000
Message-ID: <20191114093732.12637-4-noaos@mellanox.com>
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
x-ms-office365-filtering-correlation-id: 8d903c2e-5789-43f0-0cc2-08d768e64f0b
x-ms-traffictypediagnostic: AM6PR05MB6230:|AM6PR05MB6230:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR05MB6230D8F70B443AA556813FE2D9710@AM6PR05MB6230.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 02213C82F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(199004)(189003)(3846002)(256004)(71190400001)(6116002)(71200400001)(14454004)(2906002)(478600001)(81166006)(81156014)(50226002)(8676002)(8936002)(86362001)(66946007)(66476007)(66556008)(64756008)(66446008)(6512007)(4326008)(5660300002)(1076003)(6436002)(2501003)(107886003)(186003)(66066001)(476003)(446003)(2616005)(26005)(11346002)(6636002)(486006)(6486002)(36756003)(25786009)(110136005)(54906003)(316002)(305945005)(102836004)(386003)(52116002)(6506007)(7736002)(76176011)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB6230;H:AM6PR05MB4968.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: urWd002J+VM5GuDvROX4kvTCQ/ijDYvNzbbnMz55S8AAiy5EbKChIc1DKCvHBeFyrSxcwh9hHk/PUCAfEl9djq4x44e0HmTqC1SGdEYrenFgfRgdWShqOvQN94hqOdLW5j7MvQH4r4m6b/UEDCHVeSECTA2bU7vqQXCr2c7yZfZMt1ZTuR+8OiCjXJT1BSWhsRJRmEgZMqHu9tiMPCpDTpwORX9vjLxfffCT6EH/qHp0G8X5OPXt76geJ39j/FAitWC9u1wgVOkU1xq+NgvqRj33jCSmzIoXv+YC6MZYBARcTAiUMG44F+/gVydkNnV3TeejVw82CF44VRfaY/FLlxiNuz7qT52kyZghIqgXwsc6nXrZl0CUlC2Wn9YpKfvQjgdwY79EFy2148GRvH+ft0nPZMSiuysbA/WL4mBtxKcBMYOyY8KeaUK7Q59sNdUD
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d903c2e-5789-43f0-0cc2-08d768e64f0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2019 09:37:47.6271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zLIK4aQE2nFhuEI+pk5Dn/ju7xvetbbe3qamzNbDwn1Z46FYum3Z3JiUyQzmoZoZBsO3XcFSHc0FF9Mcpr4b2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6230
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Edward Srouji <edwards@mellanox.com>

Add a documentation for ParentDomain with a simple code snippet
demonstrating the creation of the object with Python defined allocators.

Signed-off-by: Edward Srouji <edwards@mellanox.com>
Reviewd-by: Noa Osherovich <noaos@mellanox.com>
---
 Documentation/pyverbs.md | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/pyverbs.md b/Documentation/pyverbs.md
index 29ab9592c53c..db6c6b99905e 100755
--- a/Documentation/pyverbs.md
+++ b/Documentation/pyverbs.md
@@ -390,3 +390,30 @@ srq_attr.comp_mask =3D e.IBV_SRQ_INIT_ATTR_TYPE | e.IB=
V_SRQ_INIT_ATTR_PD | \
                      e.IBV_SRQ_INIT_ATTR_CQ | e.IBV_SRQ_INIT_ATTR_XRCD
 srq =3D SRQ(ctx, srq_attr)
 ```
+
+##### ParentDomain
+The following code demonstrates the creation of Parent Domain object.
+In this example, a simple Python allocator is defined. It uses MemAlloc cl=
ass to
+allocate aligned memory using a C style aligned_alloc.
+```python
+from pyverbs.pd import PD, ParentDomainInitAttr, ParentDomain, \
+    ParentDomainContext
+from pyverbs.device import Context
+from pyverbs.base import MemAlloc
+
+
+def alloc_p_func(pd, context, size, alignment, resource_type):
+    p =3D MemAlloc.aligned_alloc(size, alignment)
+    return p
+
+
+def free_p_func(pd, context, ptr, resource_type):
+    MemAlloc.free(ptr)
+
+
+ctx =3D Context(name=3D'rocep0s8f0')
+pd =3D PD(ctx)
+pd_ctx =3D ParentDomainContext(pd, alloc_p_func, free_p_func)
+pd_attr =3D ParentDomainInitAttr(pd=3Dpd, pd_context=3Dpd_ctx)
+parent_domain =3D ParentDomain(ctx, attr=3Dpd_attr)
+```
--=20
2.21.0

