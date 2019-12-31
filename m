Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2360B12D74A
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Dec 2019 10:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbfLaJTa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 31 Dec 2019 04:19:30 -0500
Received: from mail-eopbgr00084.outbound.protection.outlook.com ([40.107.0.84]:29969
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725770AbfLaJT3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 31 Dec 2019 04:19:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bt/ge9AjY0mWlblnBjChZ/4jDBJaHFGUE4td7UcCn1WEPBh5rtw06LbhswKbRBHEG+aClp5gC5qmrpj7efOhAI9ddvazjTBt0Q/o4mU3Qy++l5lotXDKpHxE+TkCcdEdMfMPfF93oJVhBGnkBI7DMl3XFEtd5FxhRV3HiJ6kuLaRonxclHYiSl8AI52EsxAEO5/2H7tiurLDTK0TanlmJe0MpEvgwTGg4Tat8vJ/KhKTg/KaGvaCddXwS+BUhjDiiNzD1vZIrPMJ9WVAX8JujDcvjMJ9CYufUzRWE0FwkkE27kp9rVUBJ3Oe1UxE/P6WyOlGrIf59SfLt0slQ1p7hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBsh+Kq66tHxdu8oh45wvmTaoKMEZpzu3hstZX+TyPw=;
 b=Ag9TcCDqBVO/48Ac1pLtzAyxi9VkQUnZ3Iq8MGdvmSVZiSeDMGmZ7N1zCLDIw2/pnsLUgnjVTux/lQpzFm3LDmZ9/4N9Hm2XjK91RCm9MeYJEvEjN+SZTdkMMCy2KwhZmWlSxiBy0PJCPYVpYa2qzBNO9EEh3QxQVj87qBGcaPQIwW8hjnVewfQfGN/mSQnaKf5xLAc0mMAVxS/uAPC/gXpzVgeHZP5u1pa19XoakUkhwaA1O2LCVxUjxl14yRKb77kpujKQQ2uguiT9ZXETZ+df4FJ9SFpgyOS86D++1IOg+ReyDmDiGVQKQv9q1/S+DUg/esYfwqtMxdpi+7QJpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBsh+Kq66tHxdu8oh45wvmTaoKMEZpzu3hstZX+TyPw=;
 b=CFZOuvF60raERb97kBxQ7vgYiDfYcds/FmcVHjSYj5sN0DNYiAjLN7JxmE6G8vovhOddxiEognSuOc3BR2n6pH2x8aIFkcxo3JDcwY1DOiKC4Js/34BwU28uzCaA8hnaCGIcTdmgnMuX4OkCJroncgxOKjF/Y3ENUJwZyimZ9WM=
Received: from VI1PR0502MB3006.eurprd05.prod.outlook.com (10.175.21.136) by
 VI1PR0502MB3742.eurprd05.prod.outlook.com (52.134.1.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.10; Tue, 31 Dec 2019 09:19:26 +0000
Received: from VI1PR0502MB3006.eurprd05.prod.outlook.com
 ([fe80::b9ec:a465:4659:7427]) by VI1PR0502MB3006.eurprd05.prod.outlook.com
 ([fe80::b9ec:a465:4659:7427%5]) with mapi id 15.20.2581.013; Tue, 31 Dec 2019
 09:19:26 +0000
Received: from reg-l-vrt-059-007.mtl.labs.mlnx (94.188.199.18) by AM0PR0102CA0016.eurprd01.prod.exchangelabs.com (2603:10a6:208:14::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11 via Frontend Transport; Tue, 31 Dec 2019 09:19:25 +0000
From:   Noa Osherovich <noaos@mellanox.com>
To:     "dledford@redhat.com" <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Noa Osherovich <noaos@mellanox.com>
Subject: [PATCH rdma-core 0/8] pyverbs: Add support for the new post send API
Thread-Topic: [PATCH rdma-core 0/8] pyverbs: Add support for the new post send
 API
Thread-Index: AQHVv7tlpMlqjJMoRk2OZv2IHbVzNA==
Date:   Tue, 31 Dec 2019 09:19:25 +0000
Message-ID: <20191231091915.23874-1-noaos@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: AM0PR0102CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:14::29) To VI1PR0502MB3006.eurprd05.prod.outlook.com
 (2603:10a6:800:b2::8)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=noaos@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.188.199.18]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 560b366b-06e8-4244-32e4-08d78dd287c7
x-ms-traffictypediagnostic: VI1PR0502MB3742:|VI1PR0502MB3742:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB3742A2027ACD93AE6F2A8627D9260@VI1PR0502MB3742.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0268246AE7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(199004)(189003)(54906003)(1076003)(316002)(107886003)(36756003)(6636002)(2616005)(956004)(110136005)(478600001)(52116002)(71200400001)(66476007)(4326008)(66946007)(81156014)(81166006)(6506007)(64756008)(86362001)(5660300002)(2906002)(8676002)(186003)(66446008)(8936002)(6486002)(66556008)(16526019)(26005)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0502MB3742;H:VI1PR0502MB3006.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZbRBxEqWCMwYV7cTLi1cXWUGahUU5awvoRgeq/hRtQUnCRy4/UhKRalmZeMdX//7LZrRHrxm2BT1DECfXbnz5XqpRlcIbRGcix9ZFbKotU7F882Vl3AuCN7ou1M6TwWW1a8fDENMoEvyoCpY/a91e5rRrnTHX/ffC5ZFJJrgsuOxgEe+YqV2qfSKaNCq+9VUgrgUr6j3gW1f3+QRtdzh6dGHwzrf1DQZCIoSs62B7TCX37oIZvT+wD9e6K4vd2Do/J/CgBua8NDDYQZCrTMJs+1EhZiyosONfnfDxFtXYRAWhK8UqR9QEWZ12yV8cUHkSriQU8oDasaKU5wEmjoPiGV/eU/Zd60vcKO5QuaQ4ALa8QzkfmH+P5wLjjgvZWLH36gYZlL6HOqWNKFPSBfYi+3P/xKoATQP7ilM9IgoVyuxsMWTfveaAbiB9il07NYV
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 560b366b-06e8-4244-32e4-08d78dd287c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Dec 2019 09:19:25.9810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qf7LiNygrFd9H4u9KDqdnPYHQrpZhlSuC9CrYHu/wtRvaE0NK4VY7rMhjhlGR0tOjxcPuVL56A3dWK/KY/HeEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3742
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The following series adds pyverbs support for the new post send API.
The first 5 patches add unrelated but needed support (e.g. memory
window) and fixes for bugs that were found along the way.
These patches are followed by the feature itself, a documentation and
a test.

Noa Osherovich (8):
  pyverbs: Add support for memory window
  pyverbs: Add TSO support
  tests: Decrease maximal TSO header size
  tests: Use post_recv in the right place
  pyverbs: Expose MR's length property
  pyverbs: Introduce extended QP and new post send
  Documentation: Add extended QP to pyverbs's doc
  tests: Add test using the new post send API

 Documentation/pyverbs.md     |  24 +++
 pyverbs/base.pyx             |   8 +-
 pyverbs/libibverbs.pxd       |  48 +++++-
 pyverbs/libibverbs_enums.pxd |  14 ++
 pyverbs/mr.pxd               |   6 +
 pyverbs/mr.pyx               |  23 +++
 pyverbs/qp.pxd               |   6 +
 pyverbs/qp.pyx               | 154 +++++++++++++++++-
 pyverbs/wr.pxd               |   6 +
 pyverbs/wr.pyx               |  60 ++++++-
 tests/CMakeLists.txt         |   1 +
 tests/test_odp.py            |  13 +-
 tests/test_qpex.py           | 295 +++++++++++++++++++++++++++++++++++
 tests/utils.py               | 213 +++++++++++++++++++++----
 14 files changed, 817 insertions(+), 54 deletions(-)
 mode change 100755 =3D> 100644 tests/CMakeLists.txt
 create mode 100644 tests/test_qpex.py

--=20
2.21.0

