Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCBD28ED1
	for <lists+linux-rdma@lfdr.de>; Fri, 24 May 2019 03:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388141AbfEXBao (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 May 2019 21:30:44 -0400
Received: from mail-eopbgr140081.outbound.protection.outlook.com ([40.107.14.81]:56128
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387626AbfEXBan (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 23 May 2019 21:30:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VzdJV1RMXq4MW/uvxB9vlO3piV3Xs8vmDbD0B/J6Kzc=;
 b=EjrhpzPd9yMG8/M6fCfaFuYDi+VCbb+v3XrbBEiD/C5OboJYyeUBjLAH93ukUVFvDKo2Llu9re06Ky7dljZPXlQPKlwedS3KrfaPv2PrfJch+dBmDwjvGs/k20FWkuZFMaHUgSvLA6nMkTQA6mFjL4TiqAUOc9eYEWxyx/sHCUI=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4671.eurprd05.prod.outlook.com (20.176.3.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.15; Fri, 24 May 2019 01:30:39 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1%6]) with mapi id 15.20.1922.018; Fri, 24 May 2019
 01:30:39 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Gerd Rausch <gerd.rausch@oracle.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Aron Silverton <aron.silverton@oracle.com>,
        Sharon Liu <sharon.s.liu@oracle.com>
Subject: Re: <infiniband/verbs.h> & ICC
Thread-Topic: <infiniband/verbs.h> & ICC
Thread-Index: AQHVEbrqTWFNmJy0s0Wb8HoOeUZS36Z5fRmA
Date:   Fri, 24 May 2019 01:30:39 +0000
Message-ID: <20190524013033.GA13582@mellanox.com>
References: <54a40ca4-707b-d7a8-16b0-7d475e64f957@oracle.com>
In-Reply-To: <54a40ca4-707b-d7a8-16b0-7d475e64f957@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR16CA0007.namprd16.prod.outlook.com
 (2603:10b6:208:134::20) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.49.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a248778-6fe1-4bbd-1b56-08d6dfe76d6b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4671;
x-ms-traffictypediagnostic: VI1PR05MB4671:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR05MB46712DCF45CE4093088ABDEBCF020@VI1PR05MB4671.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0047BC5ADE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(136003)(366004)(396003)(199004)(189003)(76176011)(52116002)(7736002)(36756003)(316002)(53936002)(305945005)(6486002)(71200400001)(68736007)(71190400001)(73956011)(6916009)(6506007)(3846002)(6116002)(8676002)(6246003)(26005)(54906003)(186003)(386003)(4326008)(8936002)(99286004)(5660300002)(102836004)(2906002)(1076003)(81166006)(81156014)(486006)(446003)(25786009)(11346002)(2616005)(478600001)(476003)(14454004)(86362001)(966005)(33656002)(6512007)(6306002)(6436002)(66946007)(66476007)(66446008)(64756008)(66556008)(14444005)(256004)(66066001)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4671;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vXlNSnntuWx7MUXlFCJz2r6IdSVxf3qGLmzGquTwwW3LrTBElNZbhojgP+DsOxEXtRxKGvy1Q7qrDwDRZN/0RWs5pdh2J+fGupXY2W4Zg/pqOvQg7IwR+WNp6Hp0rnxhnndJWEw2lC5V78TJSwWtZfYyGfIo3YiUYL5eepRaAxvmAybSRbwEeG7s3ThsvZ4/mIujsU1XbjVb6Cj6scJ3DcP6F9ZNzGFEpDlLdTDQ4xS7u+Wpl/PNdryhXSNoCri7BiErdE5zEEIflAkH88Xdfq8kT2ehnS28cA9YJJBA3ZvcBxE1jK05ZVkTtngafDM5NjXOaz+0Gv1iLl9v+efKLfdZM9kuq6GkQya4eeUwDGTQGWJohusvQdCMSNQ4hBA59kMlouqY6xa8xriU/KNMX995qfCZOzo1aGl0Vm219kc=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8224327EF2CCD142900DFC95E53D612D@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a248778-6fe1-4bbd-1b56-08d6dfe76d6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2019 01:30:39.6103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4671
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 23, 2019 at 03:57:29PM -0700, Gerd Rausch wrote:
> Hi Jason,
>=20
> Trying to compile <infiniband/verbs.h> with ICC (Intel's C/C++ Compiler)
> leads to the following error:
>=20
> error: enumeration value is out of "int" range
>          IBV_RX_HASH_INNER =3D (1UL << 31),

I assume you are running with some higher warning flags and -Werror?
gcc will not emit this warning without -Wpedantic

Also, I think icc is broken to emit these kinds of pedantic warnings
on a system header, gcc does not do that.

> IMO, ICC is correct here, because according to ISO-C99:
> 6.4.4.3  Enumeration constants
>  Semantics
>   identifier declared as an enumeration constant has type int

Sure

> Since "int" is signed, it can't hold the unsigned value of 1UL<<31
> on target platforms with sizeof(int) <=3D 4.

Pedentically yes, but gcc and any compiler that can compile on linux
supports an extension where the underlying type of an enum constant is
automatically increased until it can hold the value of the
constant. In this case the constant is type promoted to long,
IIRC.

See my past writing on this topic:

https://www.spinics.net/lists/linux-rdma/msg36828.html

FOO_VALUE2 automatically has the type of long because it cannot be
represented by an int.

> (In other words: that would be the sign-bit on two's complement machines)=
.

No, either the compiler supports the extension or it should refuse to
compile the code.

> Can you shed some light on whether or not verbs.h is supposed
> to compile with ICC (i.e. if it's supported), and what the level
> of appetite is to make this work?

Generally we use many gcc extensions in verbs headers and expect the
compiler to support them, this is just one of many. So I'm not
particularly thrilled to have to support weird compilers. Particularly
if the compilers just need to use the right option flags.
=20
> It's trivial to fix this, but there's benefit in making this part
> of a regression test suite (e.g. Travis).

Can you clarify if icc is being run in some wonky mode that is causing
this warning? AFAIK icc will compile the linux kernel, and the kernel
makes extensive use of this extension. So I think the compiler is not
configured properly.

IIRC I looked at this once for -Wpedantic support and decided it was a
lot of work as there are more cases than just this.

Jason
