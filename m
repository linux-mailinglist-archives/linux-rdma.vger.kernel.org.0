Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3C04FF9E1
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Nov 2019 14:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfKQNay (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 17 Nov 2019 08:30:54 -0500
Received: from mail-eopbgr70077.outbound.protection.outlook.com ([40.107.7.77]:21606
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726174AbfKQNay (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 17 Nov 2019 08:30:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dwlHb6kZ1PK2Xa4lGeSYCt1gjTVBF0Xf9RrFd1lhrQ8U276SXYoMRFA/02vQwNZ6xHTYXUSrfhG9/b88Os3gN0ojTDgsIEA5zj0RvaAZbbXbj4ZiAqzrn4jOp3tVffteB49Zt4uH1lgpil1ABz1LOKByMEoClqU7YBQZJs5f/CFC+F6EwgfjjEazkYpYxSfGKEUOGA96OttnIrmEoFQ0LnjecW2kdOixdCMXIwEuS0bMhDzb8t0gs5NT0nJW7RZcVeq4ClqYa4UvMQavCVhR+EKYiM5f3yOnk3WvM71WLYTSJIfWk7ykwHJ565ioT0EetmJWIg5Up5cW9yC9I1OaLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUKXsDnEzb9OcPXJ4vaGdlfOm4th1l1XdoBIaPUPypc=;
 b=P5QI9+tdeVzfLmz4/g6wY2Aqygi8D3xzXV0oslnXmpND/pnB/ESGXdokRuUi7HY1JKmgLPhG3Z2RvnSTM47hCGNGMRL14rO9HrvRE6AsN4wSm0mATUrHEb9w3zZfeJVFHiHJ0CpQ7X+T9KXv8zIyMxDRPT7zF/APfyZURpWQr+0FBtndSyRAjUK5OpysUpHQXomAI2q3SptwrT2O1hAdLTqcyhT6mqY0rmvvqgRxZWO8cndvlsekb9jVJAUYbBFJaKKzvXsBcmynYuj8cGYQcspnjL1INXn4IgDfxEPN5rK1Hvy4u55X86Mk4YFa5V2mJrh/JeJXU86Ij5Idp9v7Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUKXsDnEzb9OcPXJ4vaGdlfOm4th1l1XdoBIaPUPypc=;
 b=a6xc4ezMLMmJzLk/V09m+dBkR/iFsQLkiAdyVvodePpX+hB++65tNNxQGLddQwgqX2xKow+AR+2471OADu8Lhc3fyI43/upjqSmGD7nMfLo7zwCKZctnujWX0wu2yn3B03NmRjb3geOjkHbPzURlpGRD6OPS7ZL7hkOxeKCDjew=
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
Subject: [PATCH rdma-core 4/7] pyverbs: Add support for provider extended CQ
Thread-Topic: [PATCH rdma-core 4/7] pyverbs: Add support for provider extended
 CQ
Thread-Index: AQHVnUs3PS8eq+vKdkWnXmj9xjzAow==
Date:   Sun, 17 Nov 2019 13:30:44 +0000
Message-ID: <20191117133030.10784-5-noaos@mellanox.com>
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
x-ms-office365-filtering-correlation-id: 1755bbe2-1a84-474d-e086-08d76b62596b
x-ms-traffictypediagnostic: AM6PR05MB6598:|AM6PR05MB6598:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR05MB659860AAED97F3B8F5F2CB9ED9720@AM6PR05MB6598.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 02243C58C6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(189003)(199004)(71200400001)(71190400001)(102836004)(6116002)(386003)(6506007)(256004)(11346002)(3846002)(2616005)(26005)(36756003)(446003)(5660300002)(86362001)(8936002)(186003)(64756008)(66556008)(66476007)(66946007)(7736002)(50226002)(66446008)(305945005)(66066001)(2501003)(81166006)(81156014)(8676002)(99286004)(6636002)(25786009)(76176011)(478600001)(14454004)(1076003)(2906002)(6436002)(6486002)(54906003)(6512007)(476003)(107886003)(110136005)(52116002)(486006)(316002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB6598;H:AM6PR05MB4968.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nIibDxyixxv/H4CYowjCe6VSHVL/TfDf+kz8Kos0R8CP1tr48/UwJHNkncbbkLmUQektW0BrtcwPsdy8lAkcPXpbcYST32DgZ2h6jHo7cbmfayECs5xtxsB0dQZVVQH/oVBZdj+cX9ylao/qXX6cY90waw7JmDPoEikQxYGZAmPt9udv9Mn/LPpmeiJkckDzVLryDBhVmighkOfoIkIwT/Cxz6i4OBUTUv35TAORT269PjNOuLNBEGjXjihvjOdd5hmITs66QYcpSKKBFCcvu4bBa4UJBg9VUiNqnfwSR7KfWQcxqofSq0YvExP5Mr1bC5MafP0OgpooX1EIUFE9wN65tKX4QR36VbO3cvJvKD8JRIXyNxEuUU1gml1VmyV4y+8sDnZfjzxHJJMK9orhfN1Bprrzw4ltflrYFhODM37WT3nUCoHNcmUQmx6Iv9kS
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1755bbe2-1a84-474d-e086-08d76b62596b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2019 13:30:44.9384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FzR6pi4a+Ly4QdoQMSghXeSepAc46CPzvhY1XcFoYMPwiTPc9jroGZatBZ3iPAU7K/Z8DAycZNHPTp3vauUUVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6598
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

An extended CQ can be created using either the generic interface or a
provider specific interface.
Provider CQs extend the legacy extended CQ, which in Cython means that
the legacy CQEX's __cinit__ will be called automatically. To avoid
initialization via legacy interface, add **kwargs to CQEX's
__cinit__(). If kwargs is not empty, the CQEX's __cinit__ will return
without creating the CQ, leaving the initialization to the provider.

Signed-off-by: Noa Osherovich <noaos@mellanox.com>
---
 pyverbs/cq.pyx | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/pyverbs/cq.pyx b/pyverbs/cq.pyx
index ecfef6d7fdb9..ac6baa618c3d 100755
--- a/pyverbs/cq.pyx
+++ b/pyverbs/cq.pyx
@@ -254,7 +254,8 @@ cdef class CqInitAttrEx(PyverbsObject):
=20
=20
 cdef class CQEX(PyverbsCM):
-    def __cinit__(self, Context context not None, CqInitAttrEx init_attr):
+    def __cinit__(self, Context context not None, CqInitAttrEx init_attr,
+                  **kwargs):
         """
         Initializes a CQEX object on the given device's context with the g=
iven
         attributes.
@@ -262,6 +263,11 @@ cdef class CQEX(PyverbsCM):
         :param init_attr: Initial attributes that describe the CQ
         :return: The newly created CQEX on success
         """
+        self.qps =3D weakref.WeakSet()
+        self.srqs =3D weakref.WeakSet()
+        if len(kwargs) > 0:
+            # Leave CQ initialization to the provider
+            return
         if init_attr is None:
             init_attr =3D CqInitAttrEx()
         self.cq =3D v.ibv_create_cq_ex(context.context, &init_attr.attr)
@@ -272,8 +278,6 @@ cdef class CQEX(PyverbsCM):
         self.ibv_cq =3D v.ibv_cq_ex_to_cq(self.cq)
         self.context =3D context
         context.add_ref(self)
-        self.qps =3D weakref.WeakSet()
-        self.srqs =3D weakref.WeakSet()
=20
     cdef add_ref(self, obj):
         if isinstance(obj, QP):
--=20
2.21.0

