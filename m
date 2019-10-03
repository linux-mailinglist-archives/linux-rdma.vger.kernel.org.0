Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF68ECA525
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Oct 2019 18:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403883AbfJCQbj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Oct 2019 12:31:39 -0400
Received: from mail-eopbgr00050.outbound.protection.outlook.com ([40.107.0.50]:54918
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2403868AbfJCQbf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 3 Oct 2019 12:31:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABZh74Xl/auCWjwONH/CZHnG/QjaeSzBbtEcOUUXVsQpCDH6/TnYA5fgI7a7tlaCzPRXOKTsL5KtjwmDX278pOAebl/ETNM8/EcQMOnwVVCN8M/m+Ts2QGbjfGqj868wZL7KJALql9dpougg5/9qg0tZh5ioNrXys1WrjL01OPO0PcQqUvJaROGmbctd/icXWrnQ8KhOhjxshG7Qs4pwc6TL6HbxXmhe0l3TLcqziXZJ3uu13jtTRPo5xGZTMy1/Ie1KO2BABoC4jZSjaYsEhRBwO04mDR3RHfN6CWcUb+a3ucvgkerM8bIjXKjg6908wWpRw0HALBvENRW3tQ9R+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJzOQE0sJ6AEU2DbjooMe6DAXYHTjodlUcDLZmnsJ2U=;
 b=IBgaR/X8O9QOplX1UFtKmPdFpVskwWKlHcPwELL/+9TXflCKD0zq5evGSP0ta5DXKtIz0xohYNWM4J6+GAzipcvid4WLwutnrc3bshdPoHaRS4Y8Ge5YIPz2oUaGe/xRrsytj7wv08RJ0vqd8X3Q4IysgrNfzk9y7DcDmx+RNnYZo53/rNYW9eY8lQ9gNtFj1ssklz3t0h6fkxquZU5E2grupho2DQeTo4O9Y9m3INvJMgVuVebu3UTmdXQG9fIgtb9ZGyy495u7Y5OJfPT67lG1L7/WVfSfV+kohlejM7HPCCEhL2PJEUdBdiDjYWtgqbDFYrFZhIfBdcewoD2TyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJzOQE0sJ6AEU2DbjooMe6DAXYHTjodlUcDLZmnsJ2U=;
 b=LRJ4iSOqU0OrfwC2HLgO467Bklbw4RuS+baCYO7UobUAOn7ghJDf+muCl/jneMy2z4FRUdvVI08UcSCHvWI+R613v5SNsSBXajxB2FLI7HL+qIId+g2J5El2woiAZM88ORguB91XY76coPf//R2lcYqqkVQhtYuGfUpcQBW9m2Q=
Received: from DB7PR05MB4138.eurprd05.prod.outlook.com (52.135.129.16) by
 DB7PR05MB4123.eurprd05.prod.outlook.com (52.135.129.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Thu, 3 Oct 2019 16:31:32 +0000
Received: from DB7PR05MB4138.eurprd05.prod.outlook.com
 ([fe80::18c2:3d9e:4f04:4043]) by DB7PR05MB4138.eurprd05.prod.outlook.com
 ([fe80::18c2:3d9e:4f04:4043%3]) with mapi id 15.20.2305.023; Thu, 3 Oct 2019
 16:31:32 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Jonathan Toppins <jtoppins@redhat.com>,
        Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-core] kernel-boot: Tighten check if device is virtual
Thread-Topic: [PATCH rdma-core] kernel-boot: Tighten check if device is
 virtual
Thread-Index: AQHVdE7LmtT4Pt5d2kujr9uOMkraD6c95NqAgABalACAAxKtAIAH1UmA
Date:   Thu, 3 Oct 2019 16:31:32 +0000
Message-ID: <20191003163127.GE26151@mellanox.com>
References: <20190926094253.31145-1-leon@kernel.org>
 <20190926123427.GD19509@mellanox.com>
 <9c582ae3-8214-f9b8-d403-cf443b70284e@redhat.com>
 <20190928165416.GL14368@unreal>
In-Reply-To: <20190928165416.GL14368@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQBPR0101CA0014.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::27) To DB7PR05MB4138.eurprd05.prod.outlook.com
 (2603:10a6:5:23::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a2e347f-ea76-4ea1-960a-08d7481f267a
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: DB7PR05MB4123:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <DB7PR05MB41238484795FD3832FD60FA3CF9F0@DB7PR05MB4123.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01792087B6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(39850400004)(396003)(366004)(136003)(189003)(199004)(2616005)(33656002)(386003)(6506007)(53546011)(476003)(14454004)(66446008)(26005)(66946007)(3846002)(81166006)(6486002)(81156014)(6116002)(186003)(8676002)(64756008)(36756003)(66556008)(66476007)(54906003)(305945005)(99286004)(102836004)(486006)(6916009)(7736002)(71200400001)(2906002)(71190400001)(316002)(4326008)(76176011)(6246003)(256004)(52116002)(25786009)(478600001)(66066001)(229853002)(5660300002)(11346002)(6436002)(446003)(6306002)(8936002)(86362001)(6512007)(966005)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR05MB4123;H:DB7PR05MB4138.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wWYRE8iivrd2qmRI930l2usbxdm8Tw7AUEu7LKwvCO251IhRTvKEuaqA+V+FTHe0LrUHGgv3ZpVtGIC8vTA+heIPgDgi+KlJ5nB6pOcO3HmrTusmtDskoO6sDEV7IVi8rd02/yk+RypfuP5s1e0Zkn2xKO28qkzDMLx3TBWtiX8H15+0cMHUZ8poWtKoD0ey9ISnB9oHXeOiyu3j0G6W7tpCqd5/8Fl7E78hEAA0pl59k/mFgOleYJHNoZ6/RhOiKPSAuteDV1hVRZgPXGoGte2WOsX5XiOA2OvGejXaB8zDEdJoQNk4cAQvTXU+UqCTetvqXDNiuMGe5rKbT3igLTypdqoYwzDcNnvBayz6dS+GDKqbW2IqWrwKJS34eu6Ni8vdcn35YIdK5Pwc88v/gL+veOmghe5KAnInQLrFi3MKUvzKVIZdkz8A0iuDO84M6AzgAbHcHU6+b3vdQ08oPw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5EE36EF0A25D834B9CC5913A307A1C81@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a2e347f-ea76-4ea1-960a-08d7481f267a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2019 16:31:32.5167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n7YS53Ndrw/t5QC7ayUB/lbSivhv5fqvzZxvMc5/szSx1ofjUl2XOwbSx3kaEHYmo+tEIgSqKMa/KtvKeWjU+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB4123
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Sep 28, 2019 at 07:54:16PM +0300, Leon Romanovsky wrote:
> On Thu, Sep 26, 2019 at 01:58:38PM -0400, Jonathan Toppins wrote:
> > On 09/26/2019 08:34 AM, Jason Gunthorpe wrote:
> > > On Thu, Sep 26, 2019 at 12:42:53PM +0300, Leon Romanovsky wrote:
> > >> From: Leon Romanovsky <leonro@mellanox.com>
> > >>
> > >> Virtual devices like SIW or RXE don't set FW version because
> > >> they don't have one, use that fact to rely on having empty
> > >> fw_ver file to sense such virtual devices.
> > >
> > > Have you checked that every physical device does set fw version?
> > >
> > > Seems hacky
> >
> > agreed, how are tuntap devices handled, is there a similar handling tha=
t
> > can be applied here?
>=20
> Unfortunately, we can't do the same, RDMA doesn't have notion of stacked =
devices.
>=20
> 1.
> TUN devices are initialized with ARPHRD_NONE type.
> https://elixir.bootlin.com/linux/latest/source/drivers/net/tun.c#L1396
>=20
> It causes for systemd-udev to skip their rename.
> https://github.com/systemd/systemd/blob/master/src/udev/udev-builtin-net_=
id.c#L781
>=20
> 2.
> TAP devices are skipped due to the fact that iflink !=3D ifindex on such =
devices.
> https://github.com/systemd/systemd/blob/master/src/udev/udev-builtin-net_=
id.c#L810
>=20
> So, yes hacky, but the solution is tailored to RDMA subsystem where ALL
> devices have FW and we can ensure that ALL future devices will report any
> sort of string through fw_ver file.

It still seems really hacky, why not add some device flag or something
instead? Is this better because it works with old kernels?

Jason
