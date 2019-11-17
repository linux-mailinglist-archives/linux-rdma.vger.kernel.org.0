Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFC4FF9DF
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Nov 2019 14:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbfKQNar (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 17 Nov 2019 08:30:47 -0500
Received: from mail-eopbgr70077.outbound.protection.outlook.com ([40.107.7.77]:21606
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726157AbfKQNaq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 17 Nov 2019 08:30:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ijvgSLZcRp+e9oNtCuicwnSIR3Lm28df6XXNhsnvHx1yrHzEj/YAqOV769+m0kr6UPv8OXgzqJ0G0qFDI0a1sS8RqvK1fp3CpeeXcETBxTmcPhfuGZZCz7632+TAhWoTIBuu/K6NZ0On98anzcUDDnGggLDf3HmS8SA4kKGDRheTmerY+kTDe4xlIwM2KmziiVQXE0xudWF2AMMoOldjGGJvRx1nX+LX+pRNmlf0Pf3oXG3GA9uJHlDwdYrtwfm0mjok/Ma0hKESLlMwV4zaqlJcPyMzazotyH/4bM20dOjXvT27O5aXmwl5MKkF8Z571Xwpjw+SCI0MDC5AGa0nhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZXzjWjneHPwZy1FROWJOFilDXmln5RAZ1QBYrizCqM=;
 b=WRXk/lSEDUotOg044YunxXVnX4TwKDczc9JVDR2p1tN/unya7eqZ53Vi0cb/eiuUUPldTkVNwtGoLvDsFyQG31ywSMq0T/8hyU5GXsFncbf0xmaU46ZntYWNpclIJi1dkwk5ZolNwflnuXJSXM5hKlrIMUnUadWNdXtde1OCvlZ5Ic5KUJ1O0FU7/ZsqYPu1WaoOtRTxW+sWDmDUwJ+r0WgQiZENz6pkIgwWHE4MYHRMB+zkzT5rFamPBwPgkfNexuaYS9NXuANfeE7bkPWcCZmy5WGSo1f8kIO3N34N6553qbdOtr97wi5yhj8r7T9yBPpun6I4Z6RqbfAFs5/OLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZXzjWjneHPwZy1FROWJOFilDXmln5RAZ1QBYrizCqM=;
 b=rh8MQYTMgtdCCU9cUekAqnS550ouKLMDm9onMs6+iBCDeZ57sVLo0XLlz08zRTyxvRc1Yjs4p/YPsJHMp2pmPYdnh8NOluibdA9D9kojTgQPnsGOXY2/CRcqMUB6tP1XtRxvQq/LO1f7FVVOoxkYxn5Tb/6jSkOskqmH6O1c9Ww=
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com (20.177.33.17) by
 AM6PR05MB6598.eurprd05.prod.outlook.com (20.179.3.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Sun, 17 Nov 2019 13:30:42 +0000
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::505f:e3f8:3f87:e3ff]) by AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::505f:e3f8:3f87:e3ff%7]) with mapi id 15.20.2451.029; Sun, 17 Nov 2019
 13:30:42 +0000
From:   Noa Osherovich <noaos@mellanox.com>
To:     "dledford@redhat.com" <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Noa Osherovich <noaos@mellanox.com>
Subject: [PATCH rdma-core 1/7] pyverbs: Allow QP creation by provider
Thread-Topic: [PATCH rdma-core 1/7] pyverbs: Allow QP creation by provider
Thread-Index: AQHVnUs1srj4BUSP/E2KE4hBogqBHg==
Date:   Sun, 17 Nov 2019 13:30:42 +0000
Message-ID: <20191117133030.10784-2-noaos@mellanox.com>
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
x-ms-office365-filtering-correlation-id: 0baa527e-1c2e-41bc-555e-08d76b6257ca
x-ms-traffictypediagnostic: AM6PR05MB6598:|AM6PR05MB6598:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR05MB6598740DAEB8380EB795ED1DD9720@AM6PR05MB6598.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 02243C58C6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(189003)(199004)(71200400001)(71190400001)(102836004)(6116002)(386003)(6506007)(256004)(11346002)(3846002)(2616005)(26005)(36756003)(446003)(5660300002)(86362001)(8936002)(186003)(64756008)(66556008)(66476007)(66946007)(7736002)(50226002)(66446008)(305945005)(66066001)(2501003)(81166006)(81156014)(8676002)(99286004)(6636002)(25786009)(76176011)(478600001)(14454004)(1076003)(2906002)(6436002)(6486002)(14444005)(54906003)(6512007)(476003)(107886003)(110136005)(52116002)(486006)(316002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB6598;H:AM6PR05MB4968.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u/0/eJ/9+ya+3wFoJU8CEG+VAfV79lgt0ACFwqg1wW8746eed3SGd/x9SyErdz6QT9gt4AL3QhVCxUuDa1GVtAhH3ylknuDj2kmWynePmpAQO0kGl7YTP+NisNImGQcXQcvwmeEXe1K7tihJrW2+vPnmsDTku5SSZOYdR0IpdVDPP/lzweHHHB+UHT/ZDRVkNzhHP73cwlVymsIRJFbFbz9Cufjkc1AT4XewMyUdn1Qzv+TBDyLlSjDtsUnCnDoRzxHL6XPjdcEOczHR5XKKmYN8gfjDgTTzY2ixXwNVYkbfNh5Q6rD6KOSWEYZCemcGXz+bk+oKUgnOS+Cj/t+by5TFEi+KOtedgGREg8sLtH40WFU/+gv/mtu3KskbodhvYN99UpVkmzon9ippuHO0VYxgFuEAcJbT6Ee3mFUEh9hcRK2ggU2I4Kn5KI1YCmZc
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0baa527e-1c2e-41bc-555e-08d76b6257ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2019 13:30:42.2644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dI9fDe8pCeUKi/cUq/OdbU88nxxivNv3sMdvSZl15hQEP9+1ek5ZBhztnih8oP4OnWznIkSw9/YDiR/1aPdLNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6598
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

A QP can be created using either the generic interface or a provider
specific interface.
Provider QPs extend the legacy QP, which in Cython means that the
legacy QP's __cinit__ will be called automatically. To avoid QP being
initialized via legacy interface, add **kwargs to QP's __cinit__(). If
kwargs is not empty, the QP's __cinit__ will return without creating
the QP, leaving the initialization to the provider.

Signed-off-by: Noa Osherovich <noaos@mellanox.com>
---
 pyverbs/qp.pyx | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/pyverbs/qp.pyx b/pyverbs/qp.pyx
index c526f0ad1bb6..74e2ce76665e 100755
--- a/pyverbs/qp.pyx
+++ b/pyverbs/qp.pyx
@@ -783,7 +783,7 @@ cdef class QPAttr(PyverbsObject):
=20
 cdef class QP(PyverbsCM):
     def __cinit__(self, object creator not None, object init_attr not None=
,
-                  QPAttr qp_attr=3DNone):
+                  QPAttr qp_attr=3DNone, **kwargs):
         """
         Initializes a QP object and performs state transitions according t=
o
         user request.
@@ -803,11 +803,16 @@ cdef class QP(PyverbsCM):
                           using Context).
         :param qp_attr: Optional QPAttr object. Will be used for QP state
                         transitions after creation.
+        :param kwargs: Provider-specific QP creation attributes, meaning t=
hat
+                       the QP will be created by the provider.
         :return: An initialized QP object
         """
         cdef PD pd
         cdef Context ctx
         self.update_cqs(init_attr)
+        if len(kwargs) > 0:
+            # Leave QP initialization to the provider
+            return
         # In order to use cdef'd methods, a proper casting must be done, l=
et's
         # infer the type.
         if issubclass(type(creator), Context):
--=20
2.21.0

