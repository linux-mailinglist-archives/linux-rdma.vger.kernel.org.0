Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55409FC2B8
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2019 10:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfKNJhs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Nov 2019 04:37:48 -0500
Received: from mail-eopbgr40065.outbound.protection.outlook.com ([40.107.4.65]:56641
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725977AbfKNJhs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 14 Nov 2019 04:37:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cMZFZGWFBYI9QxbhyHc14jqWYO1pk2NYmDB0uxmxpz83nBQHu/KgL4bKKDig30K1EUGJZyvlp7r7x3i8WEH9oeoK/ZasnriN0WSNbCvZHgxWxN5Fkn+ADqCylkKxGcsH9Mm8m4QCPpM4CkRtnH8XQnnT8sRgX+j4xnYlAbfY47SFeHfDBojx/hU4FWvuqIsDgmBXiKuqHeT7u37z5HzcmQpYLxk7JFnkkW/nc1qBu6bKhE3g5ALJLrQsVN8TWEHhGKT5V7uN+N79uIkRSeLUXMrVq7yCQeDEMWfkQIpKO+gSJlhArhCwwIS/6a8xXLL0kxqafakR7M5zwrRKIF3Qhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pCVVJn8x/tc+QcopN3nYhHVwlM99qZe2rSURGTVqr4Y=;
 b=g+fnikho5RgpGJCoAMVEAKLpxraty4d928pMzeG4eSXA4ScOdg0CSLf/kTJcJLTTDQ8RfAIb5Q2ac7u3wNSkQ33ne1Ti0eVQTIx6+e6Z5Y6iDzyAxPHKfBWDWeGws251UkvsARSLH74zmRfcTCB1UApHa67edjGOQ0muoKDX4oJeqZXS9QjtkUWjxZlsauF9bL22zaEFrsmDDI5pOoaMEL2AEjIEwGLaISPqCK3Re2iNoGXS0LkpAw9xpc4b2L3of5VUK+5wjUK2Imkb5ObybSe6JEC4v73cIAxMD3xn5OWix91jH4dP8rtdSNpN0tgKG6dPcBh2IGgIXIYM5VZOkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pCVVJn8x/tc+QcopN3nYhHVwlM99qZe2rSURGTVqr4Y=;
 b=I8uu1Tz6RrUypVDxriqTbUzvkkNNf4u/sGVofLnbxgkeJGYMcLi6Mt/CKEfL4BXIgu0wePpndfBt+tgt9cXnu+G1cE+VhwTyCSVoV5kb/6MFKeLM3EQa3ROJMbaOnZWLbfnbGI4GiwFDLm34w/GaTiQweF/ohb5lL9AuCjK2eq8=
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com (20.177.33.17) by
 AM6PR05MB5783.eurprd05.prod.outlook.com (20.178.86.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Thu, 14 Nov 2019 09:37:43 +0000
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::505f:e3f8:3f87:e3ff]) by AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::505f:e3f8:3f87:e3ff%7]) with mapi id 15.20.2430.028; Thu, 14 Nov 2019
 09:37:43 +0000
From:   Noa Osherovich <noaos@mellanox.com>
To:     "dledford@redhat.com" <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Noa Osherovich <noaos@mellanox.com>
Subject: [PATCH rdma-core 0/4] pyverbs: Introduce parent domain
Thread-Topic: [PATCH rdma-core 0/4] pyverbs: Introduce parent domain
Thread-Index: AQHVms8qVtpEX3kItUOO1C82KZnE4g==
Date:   Thu, 14 Nov 2019 09:37:43 +0000
Message-ID: <20191114093732.12637-1-noaos@mellanox.com>
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
x-ms-office365-filtering-correlation-id: 03a3c1c7-f08d-4e04-d1f1-08d768e64caa
x-ms-traffictypediagnostic: AM6PR05MB5783:|AM6PR05MB5783:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR05MB578319B03D953A655CEED61CD9710@AM6PR05MB5783.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 02213C82F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(136003)(366004)(346002)(39860400002)(189003)(199004)(52116002)(4326008)(8936002)(8676002)(81166006)(81156014)(50226002)(7736002)(3846002)(6116002)(6486002)(305945005)(36756003)(107886003)(2906002)(6436002)(6512007)(66946007)(478600001)(66476007)(66446008)(64756008)(66556008)(71200400001)(110136005)(99286004)(54906003)(316002)(256004)(25786009)(5660300002)(1076003)(71190400001)(6506007)(26005)(86362001)(186003)(14444005)(486006)(2501003)(476003)(2616005)(6636002)(66066001)(386003)(14454004)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB5783;H:AM6PR05MB4968.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zMx5++ZUk04gbs3WzpB1PuaZ2oMFE7db9SNo9XA/iPmtKCCjjmFQofQpxtdMN4EhB3q8oci0jMOdq020E6bsXlfvG3yiRdcfyp674l9FA8AzzcRnPW+d0X1zCYRHroIghwHCYi24BbxrG4VUT0odTRAhst4VJr/2MWBEmp82GApsoAkksHjDGDnmR3slliRRfvN3HiK56VN6Z7dGqOWwLPmZ1pVcCfzrKZzi4mYigGg0CZEUlG/c4TBNnHhQ6ZzSFP38uBbuX5rMDNR2ZBlgQcC0XV9NOYjoT+lKAGjpj4sSQcai8wK+UcI0wO1UsdYwZSRLUIBqCviMUv8RNnU7lBS+ksTySFAoX57B6n1IuId7efcXB6iCogbfyWnZ3RSw6QVGgTXo0aQZXUhjirhySmZCsTF6KBSKiHs+Om8p+Os7o4IDs7qshXbyrr7da6ZZ
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03a3c1c7-f08d-4e04-d1f1-08d768e64caa
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2019 09:37:43.8686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XYc0unJMvcYSGlF8IGjbSLibMjd8BIb0H03udXMdVr2XXcIBvbtS6LsTTkI/qz/96b1O2Y4k5DqU1dv+9b7e8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5783
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Parent domains extend protection domains with custom allocators
callbacks given by the user and override the provider's allocation.

This series adds support for parent domain in pyverbs, including
a basic test and a documentation.

In order to allow Python users to provide Python allocators, pyverbs
is using the pd_context object and an internal wrapper that makes the
Python functions to be called from the provider.

Edward Srouji (4):
  pyverbs: Add memory allocation class
  pyverbs: Introduce ParentDomain class
  pyverbs: Document ParentDomain class and add a simple example
  tests: Add a test for parent domain

 Documentation/pyverbs.md                |  27 +++++
 pyverbs/base.pxd                        |   3 +
 pyverbs/base.pyx                        |  26 ++++
 pyverbs/libibverbs.pxd                  |  11 ++
 pyverbs/libibverbs_enums.pxd            |   7 ++
 pyverbs/pd.pxd                          |  17 +++
 pyverbs/pd.pyx                          | 150 ++++++++++++++++++++++--
 pyverbs/providers/mlx5/mlx5dv_enums.pxd |  11 ++
 pyverbs/srq.pyx                         |   2 +-
 tests/CMakeLists.txt                    |   1 +
 tests/test_parent_domain.py             |  86 ++++++++++++++
 11 files changed, 330 insertions(+), 11 deletions(-)
 create mode 100644 tests/test_parent_domain.py

--=20
2.21.0

