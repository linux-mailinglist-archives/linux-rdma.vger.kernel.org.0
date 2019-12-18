Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68DE9124784
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Dec 2019 14:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfLRNCc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Dec 2019 08:02:32 -0500
Received: from mail-eopbgr30089.outbound.protection.outlook.com ([40.107.3.89]:39813
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726682AbfLRNCb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 18 Dec 2019 08:02:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NnzdQQOFRYvk5P5SQHTI0AXjdf8hcGUQxa+OJ7wWz+tkDNTlusXS/CUhAY5S5W3UGtHoezQVuvhiYI5JGeG+NwaTNQIuKE2m0lG2Lsg3KEmm4hzb1vv5kiRTw+UkQ3x2KA70rObJED3Z1opfMlc+/q5GchGSHdOQ/ALoWpNkNzhUpT39XlrY/o2hUStEOhvA/mzHhv35Li9z8QHdXzL1MZPKVAr/RF4peeBpmnQf+iHLMkj1KJY3yoKTLHk9UuuvtFAmqlPGc1dBDbNcftGLsVlwMkxD4QDNFTUWtxIQd6rcVvtFVd1e73E5q+VN/zgTXcO6oR/RQNQtT2v/IdNTHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrINVtdldKPjuxoisTdLaSIiawt0qUmDP+UXbGcpe0U=;
 b=Qmgcle7y5rNH0DcOhPceTVFLcQHZA/9t36AhWs3oxKUB/kLfXUnqZ8Rs8wPXEoqUidwKL0XQ71AhB9ubpqqiLMfvQgy4xQ/spY5c/OgOUuPc6kbnjQgeDBXoveaBEqwPoyS9vZUdxtn5UxjweGKWy1Ik/pzO2O8RWkfvlEC/doDZ2SKRvPrX/6hPsGGd7YZTtClG5M/Ro4yQkh0bSj6z0bEcqEu4UenicFERErjrn4CckiqV9UmK9YRLtqzCXEkRu8pGaA0SUk2n+FcCIhNAjylRMKkG/ziwO+k7HAb7is7GyPSDzjmpLpOB5GTZpQoyvQx6lDjFiXmXq8/WkmWl0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrINVtdldKPjuxoisTdLaSIiawt0qUmDP+UXbGcpe0U=;
 b=Fey2c3dod9H6J5smRyQBBwrxWsPgmawJ5C6EZ0kIQax/Lx4MfOKKnGF9uHfLuoAwQ0gFYR+di//JuhREiTCzkR2i/UJH5c60sQ+S+1uGhjDSTyzzhZO0806uEG2wVXnFsK0ZT8T8nXwmmxyqO02/pSe3VR74huJuayjYgQNydQ0=
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com (20.177.33.17) by
 AM6PR05MB5093.eurprd05.prod.outlook.com (20.177.35.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.20; Wed, 18 Dec 2019 13:02:28 +0000
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::bc8c:12ca:edd3:92ca]) by AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::bc8c:12ca:edd3:92ca%4]) with mapi id 15.20.2538.019; Wed, 18 Dec 2019
 13:02:28 +0000
From:   Noa Osherovich <noaos@mellanox.com>
To:     "dledford@redhat.com" <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Noa Osherovich <noaos@mellanox.com>
Subject: [PATCH rdma-core 0/3] pyverbs: Code refactoring
Thread-Topic: [PATCH rdma-core 0/3] pyverbs: Code refactoring
Thread-Index: AQHVtaNmlXYr7KfgLkmXTfLrU9QfKA==
Date:   Wed, 18 Dec 2019 13:02:28 +0000
Message-ID: <20191218130216.503-1-noaos@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: ZR0P278CA0009.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::19) To AM6PR05MB4968.eurprd05.prod.outlook.com
 (2603:10a6:20b:4::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=noaos@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.188.199.18]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ded32d78-281d-4916-ddf5-08d783ba88f5
x-ms-traffictypediagnostic: AM6PR05MB5093:|AM6PR05MB5093:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR05MB50937B6A7D9B5A89325AA989D9530@AM6PR05MB5093.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(199004)(189003)(86362001)(1076003)(316002)(6486002)(478600001)(6506007)(5660300002)(66446008)(64756008)(66556008)(66946007)(186003)(6636002)(2906002)(26005)(81166006)(107886003)(8676002)(81156014)(52116002)(66476007)(71200400001)(6512007)(54906003)(36756003)(2616005)(110136005)(4326008)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB5093;H:AM6PR05MB4968.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zkcQT/jjt3qvVIRUNgj5seeukr3QssUY6WRVmcH27DbialtsXJQny7S11dY91luAQ6/keRC/mFPuKwhcU6HOMMbhj1ka4yQoG1+Y6P/4q5IPiHprwyGd4SikfEiNNBsjrP2W1sAdT50Hr2nDr8fWMcaSXISiflTU1Xb20Ima64D92B0uE223BWyyc8sr8He/v5N5BejAwUcZMwrCTlSXoIazTv8yVxZIqDPwvJ77gPsA8V/HPVs8ddPoLIwoSiZ/8tzDtzPcyblgnEHCUHeV3kmQE7q07hS3VPYhNxMjxTIaL16PBG//ZrlVSlH9ZIkMcbIHNr9g48h/JvxtqTobPut3Yp4gudT8080C1uUYWCIsIHvz0QnVtzbaMijq9Ssq5Rx/2smVob7q0+MGKM10CnPAGDVObbO2nNCg3KZUDBZyPIt0bhqDa0PRhtjbH98Q
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ded32d78-281d-4916-ddf5-08d783ba88f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 13:02:28.3273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W88hf8UgV9PKVlfqZt5wjsEWIhubTStr0A/GbmhU5xFdIwwMkMrYIvyfwvLhCIvkoCa4hmjdo3PZBWR0btvEuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5093
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The following series refactors pyverbs' objects creation process and
cleans up some redundant tests:

The first patch removes its close_weakrefs() out of the base objects,
as it doesn't use 'self' and is called during teardown, when the
object might not be fully valid.

The second patch switches pyverbs to use Python's init method rather
thab Cython's cinit method, during which the Python object is not yet
valid. Calling rdma-core's objects creation methods can be done in
init just as well.

The last patch removes some unneeded tests and adapts QP creation
tests to consider TSO existance when setting QP caps.

Noa Osherovich (3):
  pyverbs: Move close_weakrefs() out of the base object
  pyverbs: Refactor objects creation process
  tests: Some cleanup

 pyverbs/addr.pyx                  | 23 ++++----
 pyverbs/base.pxd                  |  2 +
 pyverbs/base.pyx                  | 50 ++++++++++--------
 pyverbs/cmid.pyx                  | 14 +++--
 pyverbs/cq.pyx                    | 33 +++++++-----
 pyverbs/device.pyx                | 44 +++++++++-------
 pyverbs/mr.pyx                    | 40 +++++++-------
 pyverbs/pd.pyx                    | 43 ++++++++-------
 pyverbs/providers/mlx5/mlx5dv.pyx | 49 ++++++++++-------
 pyverbs/qp.pyx                    | 87 ++++++++++++++++---------------
 pyverbs/srq.pyx                   | 20 ++++---
 pyverbs/wr.pyx                    | 14 +++--
 pyverbs/xrcd.pyx                  |  9 ++--
 tests/test_mr.py                  | 14 -----
 tests/test_pd.py                  | 12 -----
 tests/test_qp.py                  |  2 -
 tests/utils.py                    |  3 ++
 17 files changed, 242 insertions(+), 217 deletions(-)

--=20
2.21.0

