Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB0EFF9E2
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Nov 2019 14:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbfKQNaw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 17 Nov 2019 08:30:52 -0500
Received: from mail-eopbgr70084.outbound.protection.outlook.com ([40.107.7.84]:28158
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726157AbfKQNaw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 17 Nov 2019 08:30:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mogX2760Vz6mmfIDBDIgtSkI+3UzbCBF3f0VAc1kdkJrsUu7Xs7/ZNzpzBJ+RJUKC5YQLJsdsio0VNzp03BGl5nngsdyx/+BWYLrYVt2YFU0g7sGBFT5gGihkmDUnuwug6zNtcQwGKA63uilZfyjSSD6oQUS1tvBHlloTZb6WKSyt4Q2IIAgzCBJ7LtOBIFrf9EgkQPAuBYHLw5ZA5vm+VA/Lx3kwRs+0kZ9SWquT/PsuzGWmiM8z1QgwM/aac6HrFg4Iz6o5vSfHq4x9lmF0lhcjhoy6MJvMwzG6V2uuGXqVPpoz7/+7Jk+7KLYQw6nNnq2WTgRN/iwb7vkdBkCsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7SIayCHYhC20fF9Qzm1ju2qFQXjWxBlEGRdL01Kx4c=;
 b=ecz89g8bLyk4KLU0Wt+hUh2Jkm01gZEDgWICwy0sQlLlFZFpknw9eCBcxlJm6ZzZBhW7U4nOAmrJhzHxDmUr7ikrY0YhNsoWV7Pw2RyHdjT2cHHvEbKLIIH9FcWwPOpc9XhWxk0D+NyVhtljLGAMEisgYC1riP677dLl3gWwgei+/b5YSpAuXYJu4WxeIjxMB86kcTAxYvbu4R6b9yS1uB8lJvB99XcPBLBnZLTy5nCZ5lK8Shnmql5/DRo96nWItL2jr+yaHhkKI5d1wBkVS4yJL2YxVPodGVrunEGdcrDgLTrWmZyTbxyxg0i/HthTxWiwJKFwCbAi+ouzith8sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7SIayCHYhC20fF9Qzm1ju2qFQXjWxBlEGRdL01Kx4c=;
 b=DebWZwvn5+SJX/Vsa4Gbioq+C/JHx8Foa5yP+5mQdm/SUweCrOBbDCjuvcmD8r9f1x7Xb/IC+Q9wGWipcSqTnyTrbgrE3SPaY9W12p+AARtSOup1rwYO3Ny/tKbWo52wicjK9HvEmXyRPctkFng96DOTT9uGhizA7NNGWhYWup4=
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com (20.177.33.17) by
 AM6PR05MB6598.eurprd05.prod.outlook.com (20.179.3.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Sun, 17 Nov 2019 13:30:44 +0000
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::505f:e3f8:3f87:e3ff]) by AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::505f:e3f8:3f87:e3ff%7]) with mapi id 15.20.2451.029; Sun, 17 Nov 2019
 13:30:44 +0000
From:   Noa Osherovich <noaos@mellanox.com>
To:     "dledford@redhat.com" <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Noa Osherovich <noaos@mellanox.com>
Subject: [PATCH rdma-core 3/7] pyverbs: Add default values for CQ creation
Thread-Topic: [PATCH rdma-core 3/7] pyverbs: Add default values for CQ
 creation
Thread-Index: AQHVnUs2z/rCsrWdA02rkqgt36Zsig==
Date:   Sun, 17 Nov 2019 13:30:44 +0000
Message-ID: <20191117133030.10784-4-noaos@mellanox.com>
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
x-ms-office365-filtering-correlation-id: 7191e802-4157-4e11-35a4-08d76b6258e8
x-ms-traffictypediagnostic: AM6PR05MB6598:|AM6PR05MB6598:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR05MB6598ABE618E5F698BABBAF98D9720@AM6PR05MB6598.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 02243C58C6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(189003)(199004)(71200400001)(71190400001)(102836004)(6116002)(386003)(6506007)(256004)(11346002)(3846002)(2616005)(26005)(36756003)(446003)(5660300002)(86362001)(8936002)(186003)(64756008)(66556008)(66476007)(66946007)(7736002)(50226002)(66446008)(305945005)(66066001)(2501003)(81166006)(81156014)(8676002)(99286004)(6636002)(25786009)(76176011)(478600001)(14454004)(1076003)(2906002)(6436002)(6486002)(14444005)(54906003)(4744005)(6512007)(476003)(107886003)(110136005)(52116002)(486006)(316002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB6598;H:AM6PR05MB4968.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EuwbtuS4dmHucDuIWRu+SqSMR/tT0XxKKWBvlFsiD/tGKMf0XRxmMvgWQObY4rFi7Ffxdnqt8lGasS+NsPPkcmZ54eoDq6S1UXKuEL6L4GOjhL+XDmnH52ykpgigZ1cS3RRC5Qnd4cOaA8O0KeGi1eXAC9XtSaElqKGc/3RqoYy+/YHxj4iz1Q4Dzzk/GkgdIyd/aA2+31i2vpYCIP12+tQnRz8/zJ8zQmT8Tlw9DwNoQRBsdox0yo+TLQrTaDzAa+dnKMrPxahpT4M2kd9MNnIJgyhWpBagYRW+B6qjGe0GxgzzOeN9Xe1dxFXRlqqvizNnn09szPu56n2+zygY7+Is8YL7RjMrOlWLcXnnnfZ+XcwnV7O6EX9Zc3/zsYu3UJIUXHOhgxZBG/wjxCSZkoUjSnc1dbQNSu8r04KSMcEjbqu3VfV4JLy1CiDUs0C9
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7191e802-4157-4e11-35a4-08d76b6258e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2019 13:30:44.1090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EyfjmkEzzHSSJRgOI5jxWsCS9oHUhliejM4rxb9+szes1TEO6Z4wyjD8jDqI4KjoT/pcI82iFjAfQYuGIjH03g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6598
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When creating a CQ, set CQ context and completion channel to None and
completion vector to 0 by default, to make the simple CQ creation
shorter.

Signed-off-by: Noa Osherovich <noaos@mellanox.com>
---
 pyverbs/cq.pyx | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/pyverbs/cq.pyx b/pyverbs/cq.pyx
index 6a96347ee979..ecfef6d7fdb9 100755
--- a/pyverbs/cq.pyx
+++ b/pyverbs/cq.pyx
@@ -67,8 +67,8 @@ cdef class CQ(PyverbsCM):
     A Completion Queue is the notification mechanism for work request
     completions. A CQ can have 0 or more associated QPs.
     """
-    def __cinit__(self, Context context not None, cqe, cq_context,
-                  CompChannel channel, comp_vector):
+    def __cinit__(self, Context context not None, cqe, cq_context=3DNone,
+                  CompChannel channel=3DNone, comp_vector=3D0):
         """
         Initializes a CQ object with the given parameters.
         :param context: The device's context on which to open the CQ
--=20
2.21.0

