Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA2E4FF9DE
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Nov 2019 14:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbfKQNap (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 17 Nov 2019 08:30:45 -0500
Received: from mail-eopbgr70077.outbound.protection.outlook.com ([40.107.7.77]:21606
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726151AbfKQNap (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 17 Nov 2019 08:30:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dqkT3y8aGoZDcIUXoJvnY1jWvE+HACd2D8PRkK0tmYiMj6z2SHY2zxADnkAjNtX3fpRhzamYwsIgK5lZ/cBdKn9InGtgJ5en1vLRBB4dtG1yS+lYS1IDLMeX/6WjstfDOzNE9eavJ7QIfflJ3NDdqs8m5NLnoCMqDtNmxQ6v/io1C4gsuYzxYHSsyljlmoN4IYsiHcIg7Ho8yMlSSAKyhRIdGc8I/CiRysOnMhbQf/8e4uyEcH272cU5qIry6uwn+RZhdeFsVC/6QZt4Qh4aSaYyUT+eFpk+v3W7ShUsupqhNGDtniC72ML/WWKFb7U+TXjnXNBf5U3k/zY78qlNog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7svd09yKxAEQXlbXklcvzxbCLWC8KVXHSiPC8Ps+iY=;
 b=Fu7Ua2TzJ7AWxnpyGU3df32sJwb5JAW6i165LxPf6RIgs3GMYkat4m/U5j+GuLIhNlC7M9akJt15nd3tmJs9rezxFWW240VMQofyWEFdACXE33bUUavH/N6mjmNV110EBQJmFugAR7Iwctus1uTIEjgZsA2NwUhW+W3/t/L84yTTenJsBc41eriB2tjCYj2ieaNF8WZH4jfRN2WGGqRTl80Y/mKYh4bTQD2P9Ma/CuSEAJoX9OhMsDkWWGoi/H1mcKcw8LVbHTeckZz3Ej7QrDl8q0oUGBOmYgfhw7+SoYGnQkh0NdIhR+t3cS3gka85EE++59TRp+JBXrVdLtTq4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7svd09yKxAEQXlbXklcvzxbCLWC8KVXHSiPC8Ps+iY=;
 b=hUaFrSeCcNLuzFdTPQzqCJ0JWZ8eQ2WkYSmcCjPnG0uuFNUG6L+lLwqwmj9fNp4hQo8VdkCm0QsSceufVPbU7dVzgmbe9NCqM6hs5GAA7fH78c806+IFX1D7DbNVbtKrJBvDJl5fCMqZ2M4eK3FxUMheo7yih7icMXQyyGAEPk0=
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com (20.177.33.17) by
 AM6PR05MB6598.eurprd05.prod.outlook.com (20.179.3.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Sun, 17 Nov 2019 13:30:41 +0000
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::505f:e3f8:3f87:e3ff]) by AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::505f:e3f8:3f87:e3ff%7]) with mapi id 15.20.2451.029; Sun, 17 Nov 2019
 13:30:41 +0000
From:   Noa Osherovich <noaos@mellanox.com>
To:     "dledford@redhat.com" <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Noa Osherovich <noaos@mellanox.com>
Subject: [PATCH rdma-core 0/7] pyverbs/mlx5: Support mlx5 CQ and QP
Thread-Topic: [PATCH rdma-core 0/7] pyverbs/mlx5: Support mlx5 CQ and QP
Thread-Index: AQHVnUs0LYTePuOhekqwcjiDS/oJxA==
Date:   Sun, 17 Nov 2019 13:30:41 +0000
Message-ID: <20191117133030.10784-1-noaos@mellanox.com>
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
x-ms-office365-filtering-correlation-id: d36d503b-a97b-4785-b8d4-08d76b625748
x-ms-traffictypediagnostic: AM6PR05MB6598:|AM6PR05MB6598:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR05MB659806C5F75FDC3F000906F9D9720@AM6PR05MB6598.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 02243C58C6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(189003)(199004)(71200400001)(71190400001)(102836004)(6116002)(386003)(6506007)(256004)(3846002)(2616005)(26005)(36756003)(5660300002)(86362001)(8936002)(186003)(64756008)(66556008)(66476007)(66946007)(7736002)(50226002)(66446008)(305945005)(66066001)(2501003)(81166006)(81156014)(8676002)(99286004)(6636002)(25786009)(478600001)(14454004)(1076003)(2906002)(6436002)(6486002)(54906003)(4744005)(6512007)(476003)(107886003)(110136005)(52116002)(486006)(316002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB6598;H:AM6PR05MB4968.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1gWPDyoQhTg0rQ3/L86Br/agnzRCYeTQ5alYUXG3I+2HYU3Q69X0IPkeEqDYWB+fEjHcx2L0K/RUAjE/85k7AD351RA+A5dO/Ll4GBSEoAFQWdYjXUmPf2wwrms4LgaJwbB2zUd8FZt5MxZ0chf7olPDYB2b0+gy68T59FxC8dN0cKhrmELnnPFcXXzrPDSPBUfIrLoVRVJy7CiPW5pRcJykdFRH1RHY4KtqmPuR85egqk704+6dqzTD3Ze+IC1SBYEyICY+uNrlKOBxgYa6+7NpmKny3Qc53tMwkbRDBdtEAK2pKxNamHqTHcafg3nhXCANOIefaBq2IudW06wqOrCocZSEvboykCHakmrAfcAtmE3sZnYwcpHYBg7XNRbk+edU9Yu3gyonIZDMFKn2778Ti2+Sta2VFvhQXlIptiTaxqC5omF3V8MSsldqdwrR
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d36d503b-a97b-4785-b8d4-08d76b625748
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2019 13:30:41.3751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6q49nhvu23Dm611ujyyPW0cFA4MtEMJ/H4ww/SrL8tdVP15o11DX7qgSbLjyy2uxFzIRxY1SdtWV5ooo7bdPfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6598
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series adds the needed infrastructure to pyverbs to allow users
to create mlx5 CQ and QP.

Tests using the extended CQ were added as well.

Noa Osherovich (7):
  pyverbs: Allow QP creation by provider
  pyverbs/mlx5: Add support for mlx5 QP
  pyverbs: Add default values for CQ creation
  pyverbs: Add support for provider extended CQ
  pyverbs/mlx5: Add support for mlx5 CQ
  Documentation: Add mlx5 provider to documentation
  tests: Add traffic tests using extended CQ

 Documentation/pyverbs.md                | 105 +++++++++
 pyverbs/cq.pyx                          |  14 +-
 pyverbs/libibverbs_enums.pxd            |   3 +
 pyverbs/providers/mlx5/libmlx5.pxd      |  24 ++
 pyverbs/providers/mlx5/mlx5dv.pxd       |  18 ++
 pyverbs/providers/mlx5/mlx5dv.pyx       | 295 +++++++++++++++++++++++-
 pyverbs/providers/mlx5/mlx5dv_enums.pxd |  30 +++
 pyverbs/qp.pyx                          |   7 +-
 tests/CMakeLists.txt                    |   1 +
 tests/test_cqex.py                      |  75 ++++++
 tests/utils.py                          |  56 ++++-
 11 files changed, 609 insertions(+), 19 deletions(-)
 create mode 100644 tests/test_cqex.py

--=20
2.21.0

