Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE03105712
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Nov 2019 17:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfKUQbp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Nov 2019 11:31:45 -0500
Received: from mail-eopbgr40072.outbound.protection.outlook.com ([40.107.4.72]:23524
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726279AbfKUQbp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Nov 2019 11:31:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ntdui1vjs27RA80GaAmeH0AC5pRJ1j3+bt6259lOigJtz4qvW7aAjPGEJoINAQA9/4JZbSuFtb51Zutv6zyGMQdYoQm39wPztTXmsJyYut4CE2QI2VLvISYQeTsCK9a3/Mq6nOnuIenwDTkCAyaFNFl5vQ8/dsS2u+O3NB5JGcVymnhI8z8s2rj1MT/JzsU2kvD1D61Cdoy0UYyWVWjsbYwsVDf5jrsUzAKDwoNGgQJeWKvHTBa03YQQ+4/GP84zkVKlY+AgV+JR6FUz39M07LPGvw4e0lvv2kWYuIgpt6bd0s+rqhMVDiahlFqc9uF2eALVnTFU2d4uGJxxSG3MUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1yWAStZf3Qkg0043kApsl21OKKdoinsAMtZRCLiL1Y=;
 b=ZOJoQ0KScDJIv1ZLEEaXfOCPNefvxVlSljbDVgnh8JfQ5/xo3dFZ5UAPoGxv/gm1NZ/kd5GSxmHJ3jXZhB96UVYQ5aPgOdeUei5mtlhoOHr02DYvRpICZz/7kVhBydOgLhjNBOTbXN8/oZBTbq0Tb0vqv3gyVRiSewR+lxDvrXFc2cnXp3hABVSlENBgOGMGn5yptv/K0qOIqzZYlFhUkVkEvpYkqxCUbr+iz5Xwv+OEzIBwEjTSZ/qJ8beNDTUgb3eVEN4Af24WIVBic5PdFR47Zn+YvljeQ8Loj54ipW5rsLghdJdMZnmUa1ioxfqDq0JHc48qrI2UqZTv4PYRFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1yWAStZf3Qkg0043kApsl21OKKdoinsAMtZRCLiL1Y=;
 b=Imf+xetgfzG2IlBKf1vE7tp7Wl+PIay/AEtg0i3lFN47e0JZic6JjtAe6hzqVzbAUmZHqD2jhFINTCHdHqfC1xNIw1RnfigxZ43n15iw3xAV5m7w7gP6jlKeoG14Mew/H7YKKiNIFQeXcCzzHUStIeYT3HNe0g3Fh9wQ/buznAo=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB4317.eurprd05.prod.outlook.com (52.133.12.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Thu, 21 Nov 2019 16:31:40 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d%5]) with mapi id 15.20.2474.015; Thu, 21 Nov 2019
 16:31:40 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Edward Srouji <edwards@mellanox.com>
CC:     Noa Osherovich <noaos@mellanox.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Daria Velikovsky <daria@mellanox.com>
Subject: Re: [PATCH rdma-core 2/4] pyverbs: Introduce ParentDomain class
Thread-Topic: [PATCH rdma-core 2/4] pyverbs: Introduce ParentDomain class
Thread-Index: AQHVms8sIZmxpJN9xEuBJbuwT+tiy6eKrF8AgAA1FACAAAAmAIAK+hAAgAABAIA=
Date:   Thu, 21 Nov 2019 16:31:40 +0000
Message-ID: <20191121163135.GG7481@mellanox.com>
References: <20191114093732.12637-1-noaos@mellanox.com>
 <20191114093732.12637-3-noaos@mellanox.com>
 <20191114133954.GT21728@mellanox.com>
 <AM6PR05MB41527769B215FA0089CEBA90D7710@AM6PR05MB4152.eurprd05.prod.outlook.com>
 <20191114165024.GU21728@mellanox.com>
 <VI1PR05MB4157C8E9CA220454969633A6D74E0@VI1PR05MB4157.eurprd05.prod.outlook.com>
In-Reply-To: <VI1PR05MB4157C8E9CA220454969633A6D74E0@VI1PR05MB4157.eurprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM6PR11CA0042.namprd11.prod.outlook.com
 (2603:10b6:5:14c::19) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 213564fd-0b05-4dec-b504-08d76ea0495c
x-ms-traffictypediagnostic: VI1PR05MB4317:|VI1PR05MB4317:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB43174AAAB87ED0FCBB299D83CF4E0@VI1PR05MB4317.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0228DDDDD7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(376002)(396003)(39860400002)(346002)(189003)(199004)(26005)(54906003)(478600001)(33656002)(36756003)(3846002)(71190400001)(2616005)(66066001)(71200400001)(6116002)(11346002)(446003)(14454004)(2906002)(25786009)(66556008)(64756008)(66446008)(66946007)(66476007)(8676002)(8936002)(81166006)(37006003)(1076003)(81156014)(229853002)(52116002)(7736002)(4326008)(305945005)(76176011)(6486002)(6862004)(6436002)(102836004)(6512007)(99286004)(5660300002)(256004)(6246003)(107886003)(6636002)(386003)(6506007)(53546011)(316002)(86362001)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4317;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GpZBRN4N7mWnCioH64K+ui8L5X7MvZqWD5eRS/O7fuRSfCWYVGD2B+LTLIwqD232/AoyZf01dU5pH7tGC2VAVkwj+f5Z/ZkvR05yehsXPGl4AgPWmwQqrtgYf/AC65HerTOioulo6dbwG+nPonFkRLa4qQoSgvedX4giyKAS1wtz2lam5tEyDwJHHCm8cP3EpFHDJ6/w6iGDJFLXx3Xj/o4E3pSHZhfRYj2asGxf4Srq3Hre1wFWDPEnlMu+6JNiKREfIXMKO4i3YrZtiqZMe9/l44LuRf6+MRyTojX78McANTF2XJ8CXKoGdr79VefmMwwIQ8JUmkvNM5BEw6DuDYdyt2keSeXoio3USmcPu3POKvywDVtSncU0wZJxkUBWoynAh5yqWFIOhTils5iZlY7AbXpky1HnaOIcJPR2w9eB9ghjkummtW9rADsI4zQN
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5FE2E89802675E4FB63CA3F4D3C8BE5E@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 213564fd-0b05-4dec-b504-08d76ea0495c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2019 16:31:40.3128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DFsixARwL2Eo9UWm5DI+xKfvsCj8rNsa988BmRqhKi953VQusT6HSsmXVnvIo9vVfqIK+wlgYyhX7WU7bbkAAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4317
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

We rely on a C extension for enums larger than integers.

Jason

On Thu, Nov 21, 2019 at 04:28:00PM +0000, Edward Srouji wrote:
>    The C standard specifies that enums are integers (and are guaranteed t=
o
>    be large enough to hold int).
>=20
>    These #defines are larger than 32bits (they're 64bits), and even if
>    they're compiled with the driver, the Cythonization (of Pyverbs) would
>    treat the enums as integers and the values would be cut. (Cython throw=
s
>    compilation warnings related to that).
>=20
>    The PR was updated.
>      __________________________________________________________________
>=20
>    From: Jason Gunthorpe <jgg@mellanox.com>
>    Sent: Thursday, November 14, 2019 6:50 PM
>    To: Edward Srouji <edwards@mellanox.com>
>    Cc: Noa Osherovich <noaos@mellanox.com>; dledford@redhat.com
>    <dledford@redhat.com>; Leon Romanovsky <leonro@mellanox.com>;
>    linux-rdma@vger.kernel.org <linux-rdma@vger.kernel.org>; Daria
>    Velikovsky <daria@mellanox.com>
>    Subject: Re: [PATCH rdma-core 2/4] pyverbs: Introduce ParentDomain
>    class
>=20
>    On Thu, Nov 14, 2019 at 04:49:52PM +0000, Edward Srouji wrote:
>    > They are defined in mlx5dv with #define and not enums.
>    > I will change to cpdef though.
>    It is a mistake they are #define
>    Jason
