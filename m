Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5F07EDCAB
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Nov 2019 11:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfKDKha (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Nov 2019 05:37:30 -0500
Received: from mail-eopbgr150084.outbound.protection.outlook.com ([40.107.15.84]:57608
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726441AbfKDKha (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 4 Nov 2019 05:37:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5Ptr9x5GVwTSvtyJU3me6wED7YR4JPY+3d1dy6I88f4wsq69VUYcyFm6pln3tiTyFMagNiHBRdZNByxhg2m3pie1/COAGoBA8oKOzHqkmBJ+7FDaDXcV0hRzZbXENnaPpk4STKKUay8Aevmqs39BJsRBcyeHGNDaEFpJA/qPAjLu9UPTetGGRCklRBCD55VddxMzUBUDZWGKXwOP2BRgaHLtB9PiYjqQKnKmwkw77ZdayPQYBaxrwQ7EYdo+ri15Mf0SNgfGHMtSAED1Y5mW5BekhOKkIT9SYwdH3El4Em7pAwVLBz4egau8a/y9rG6GwLJdEcUILU3FfIfsOXj5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWsoJEh5wWHvyFi5zZcvYn8IuYj2g+tdlbSINEB0Eys=;
 b=nv7ptxJnwKUXvs8AejQcgKsoOZks8+1OfrlJtL6VA3KmH2dP1vStxcZaPWjpAxYKYXTTKMmNu15lwbdWqEtY5UbkdxWl2kU6vTDb92A9gqvOz5k9vTK/HcrwtmKtQx6LSWdO0Tl+WDIRnxJ/C6AoyeN2rMJ/wMlpS3u/LY+CcNyW0CdzAoEyxA0H3krkraaS9rSCqzDDcC1ZPKvNc3BvReX0ML9lpOU/9/RpiKfZbbmga1qUzNySj/FRoNOIXLq3+/GKnbqxGfoxORqTkJThJ6GEwPGRljOFfuqQycqMkY3KGk5BQz/bXfXfBSrX6uNLQkhoybXma6BZ3xzASI9ppg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWsoJEh5wWHvyFi5zZcvYn8IuYj2g+tdlbSINEB0Eys=;
 b=R8z0Hxu0V5MxKG/WwZZPeBucvsmhtbhTHrJEtZp5UEPwPnEf63iCC+PLUBy4NmITaLJwXFI+rhHQH1DTKBGRM9Ck8VFyeghKI6A0ZsozMyKXHI14ObtWIW562qeyFPkyRfHstNklloZYOidI5BXZRPegkR4F4cz6uB9hMoyWkJA=
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com (20.177.33.17) by
 AM6PR05MB6232.eurprd05.prod.outlook.com (20.178.86.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Mon, 4 Nov 2019 10:37:25 +0000
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::505f:e3f8:3f87:e3ff]) by AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::505f:e3f8:3f87:e3ff%7]) with mapi id 15.20.2408.024; Mon, 4 Nov 2019
 10:37:24 +0000
From:   Noa Osherovich <noaos@mellanox.com>
To:     "dledford@redhat.com" <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Noa Osherovich <noaos@mellanox.com>
Subject: [PATCH rdma-core 0/5] Introducing RDMACM support in pyverbs
Thread-Topic: [PATCH rdma-core 0/5] Introducing RDMACM support in pyverbs
Thread-Index: AQHVkvvYxWkFX3LlMU+guc/HuoS1tQ==
Date:   Mon, 4 Nov 2019 10:37:24 +0000
Message-ID: <20191104103710.11196-1-noaos@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: AM4PR0701CA0039.eurprd07.prod.outlook.com
 (2603:10a6:200:42::49) To AM6PR05MB4968.eurprd05.prod.outlook.com
 (2603:10a6:20b:4::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=noaos@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.188.199.18]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 367949a7-ecb3-4cc7-3bfd-08d76112fb1e
x-ms-traffictypediagnostic: AM6PR05MB6232:|AM6PR05MB6232:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR05MB623201EBFB8F68D0E102F012D97F0@AM6PR05MB6232.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 0211965D06
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(199004)(189003)(25786009)(8676002)(2501003)(66066001)(386003)(6506007)(71200400001)(71190400001)(99286004)(6436002)(8936002)(2616005)(476003)(107886003)(1076003)(5660300002)(50226002)(6636002)(316002)(6512007)(54906003)(81166006)(81156014)(110136005)(4326008)(14454004)(6116002)(186003)(3846002)(86362001)(256004)(36756003)(6486002)(52116002)(486006)(478600001)(66446008)(64756008)(66556008)(66476007)(66946007)(102836004)(305945005)(26005)(2906002)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB6232;H:AM6PR05MB4968.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ptc+N71+B0tZpzGWmgAfXsN5NVZSbdvgrMY687opsjz2cDFyEn64tz3Fuqo3WUfplPsHdTgRVHubzL/K9MyDJvorp904kvOnHRWQ5So394v7+aDGbnuP9CkZ+0bn7mABR34cfLk893fobGwuYylOWm7XFM+igVPsn3Br6DscbCs9L33urWJAZNrzguhoAEVu8+9h+wZd5WXq8qL2g/Z0qKGBMnThSYLSebdeVod7s1EAIL/jtzVcXHlYy/w/8kKDNJgzlMbe6vn13eTBzk/cwVXWHId/HtJAzLabjMMk68nrjW7zLBMA4C4IifkPY3nEWT47wmh1ikY07HH/e+p0NBnAq0uqHqLPZ75CkSLVFOIaWELSjbIX2Av1Zd/NiubAptNfJfG1Qvtdyn2f+LbuNMdb197CW1/rRUG3XjSyNHFjGvy4D5vvUOSGYISndtXa
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 367949a7-ecb3-4cc7-3bfd-08d76112fb1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2019 10:37:24.8753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1sounFERB4cLZBkAIyPAeXkpLdISx7hIH3+40kJFHj2VormdCmjjeUKpkEpS6UhRhl6e4TbJ6nMyWH6HUyB1cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6232
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The following patches add support for RDMACM in pyverbs. Currently
only synchronous data path is supported (creation using rdma_create_ep).
Testing infrastructure for RDMACM is also added as well as a synchronous
traffic test.


Maxim Chicherin (5):
  pyverbs: New CMID class
  tests: Fix PD API test
  tests: New CMResources Class
  tests: Add RDMACM synchronous traffic test
  Documentation: Document creation of CMID

 Documentation/pyverbs.md         |  30 ++++
 buildlib/pyverbs_functions.cmake |   2 +-
 pyverbs/CMakeLists.txt           |   2 +
 pyverbs/cm_enums.pyx             |   1 +
 pyverbs/cmid.pxd                 |  25 +++
 pyverbs/cmid.pyx                 | 285 +++++++++++++++++++++++++++++++
 pyverbs/device.pyx               |  15 +-
 pyverbs/librdmacm.pxd            | 106 ++++++++++++
 pyverbs/librdmacm_enums.pxd      |  32 ++++
 pyverbs/pd.pyx                   |  24 ++-
 tests/CMakeLists.txt             |   2 +
 tests/base.py                    |  52 ++++++
 tests/rdmacm_utils.py            |  43 +++++
 tests/test_pd.py                 |   3 +-
 tests/test_rdmacm.py             |  57 +++++++
 15 files changed, 668 insertions(+), 11 deletions(-)
 create mode 120000 pyverbs/cm_enums.pyx
 create mode 100755 pyverbs/cmid.pxd
 create mode 100755 pyverbs/cmid.pyx
 create mode 100755 pyverbs/librdmacm.pxd
 create mode 100755 pyverbs/librdmacm_enums.pxd
 mode change 100644 =3D> 100755 pyverbs/pd.pyx
 mode change 100644 =3D> 100755 tests/CMakeLists.txt
 create mode 100755 tests/rdmacm_utils.py
 mode change 100644 =3D> 100755 tests/test_pd.py
 create mode 100755 tests/test_rdmacm.py

--=20
2.21.0

