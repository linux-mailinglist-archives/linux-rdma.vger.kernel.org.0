Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3E9151670
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2020 08:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgBDHZy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Feb 2020 02:25:54 -0500
Received: from mail-eopbgr00056.outbound.protection.outlook.com ([40.107.0.56]:17292
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726151AbgBDHZy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 4 Feb 2020 02:25:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bD3gHOutmH3MCdNT1YJVZOlbaheP4/DyhpBIvwuRIw4KjUEQBDiYxSY0a3mb+NcTiHRRBrY0CTCB+v378ksvuz/xM8hg3ApeN2K7Nh8oBLO6cffZWiHYippZw4ax7YOIcNBPJKGcQsWRXjI8zKP/yyABJZ7bvyf1XA4sqyYw+xaYyd7xDMIBpO9Zx+hy+7pdjQ15ouypj4OEIiH7NPKVwSSna2jN9hjO+HGiXCuQpiOFEw2snajnl2cZ7tH4oRCq7nrN7/hjqQGDqAJ8PTVWLhGtI7rU+HLbwvNWfxZeDqQ5a8Gk7xP76D3pe/PRvxIGKF2BnFkZmY5qFNtmzVnddw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKTZbILtnSTX9l5cgzIPMEDO3XHVl3fBYDXwY+oeNTU=;
 b=UKIFxNX6T7TTSQnw6dNLts3bXaUsP5iNwOjGsgeghdpXs5YkipTNDHU99NJlNE/eRvYECh8mB2kmEnJHO14ArUeH6gNVa+Q/Hv2MMXYjonmF0UXeUMY6sG5Z6Zt/lUca/p1b+nVKisKn0Iv7qis7ci9zZkP3UidGGSepBLN4x5CtxFUuuyPXy8P0C5kPnxcM/iqIjOPXQMZnYGJSJfajsuAjQF309VI8qQ5JOip/l/XvuBsTyHfUzuNLQm77+QPZwfQ1Eiy57eKBrkT1TUHKslVg3vTvczhMCBdmWbTkenpjUIXE2JMqek7YrSuubH9QdrnNxJEO2Wj2R8Jg5ZH6dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKTZbILtnSTX9l5cgzIPMEDO3XHVl3fBYDXwY+oeNTU=;
 b=CJKTlAqlwd7fGSHmrnN6xh7pAnqB/VoeI39vZNb8Wl7//ntNHbKkT7zzcIAT6TmksSpkecn2zMEYVElJB5JLpDjyf4EzYi49ncaFgfXaCJEQJTkYDVNYqmD+anwuvCkh/JKyuolQYxbkhRUNIOU5tkjIaV1sziqsYWCldGO4j7A=
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com (20.176.214.160) by
 AM0PR05MB5090.eurprd05.prod.outlook.com (20.176.215.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Tue, 4 Feb 2020 07:25:47 +0000
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::445c:4a14:1020:2346]) by AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::445c:4a14:1020:2346%7]) with mapi id 15.20.2686.031; Tue, 4 Feb 2020
 07:25:47 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Jason Gunthorpe <jgg@mellanox.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH v5] libibverbs: display gid type in ibv_devinfo
Thread-Topic: [PATCH v5] libibverbs: display gid type in ibv_devinfo
Thread-Index: AQHV2rqvR61k0ZnXAkKKwRApH3OosKgJwCuAgAACLwCAAADWAIAArK1wgAAxCoCAAAF+8A==
Date:   Tue, 4 Feb 2020 07:25:47 +0000
Message-ID: <AM0PR05MB4866502B08D18DAF65D9A61FD1030@AM0PR05MB4866.eurprd05.prod.outlook.com>
References: <1580752324-24742-1-git-send-email-devesh.sharma@broadcom.com>
 <20200203175317.GQ23346@mellanox.com>
 <CANjDDBh_Xv0BNhTYZ1xaaOCQ8-ijHUMqDE68_J4aqRF-EnT2Zg@mail.gmail.com>
 <20200203180405.GR23346@mellanox.com>
 <AM0PR05MB486694589EA1CBC66F598066D1030@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <20200204071739.GV414821@unreal>
In-Reply-To: <20200204071739.GV414821@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [106.51.31.117]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 27ea73dc-7835-47cd-27d0-08d7a9437470
x-ms-traffictypediagnostic: AM0PR05MB5090:|AM0PR05MB5090:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR05MB5090CA69BFA890B5979798A4D1030@AM0PR05MB5090.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 03030B9493
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(189003)(199004)(186003)(4326008)(55016002)(316002)(9686003)(71200400001)(2906002)(55236004)(53546011)(33656002)(54906003)(6506007)(66476007)(66446008)(8676002)(5660300002)(52536014)(81156014)(66946007)(81166006)(6916009)(86362001)(76116006)(26005)(7696005)(8936002)(66556008)(64756008)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB5090;H:AM0PR05MB4866.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: alBuyHhVFQQhiAJs/23QvNyVseAduB4pSZpwBOEM9NTQRzKtvMCrdV61E5udgtPgMgtQaRkNInJCmDxH4G5ZtGA0r5tN5IPjc78GMN14nYnrS544Ul19madaSUXVHlqwKea8DWtqMztiwFd3AJ6PXmPS/J61wIvHOUCHp6CdA8PmTbA7JPvwofahHcc0WndETHFSSJP0ZpfO36nTwYV8GlgFF7mw7wg7JhONkwe1pjvSEhENcguYy9LM/BhkE6nTb6+kqbCQMbHo3avSCj1hQokQGo2bISBlENK3qllNI4eXhLyBg+9i90mgTqiLwESzYcUxZjw59T9haNxL0o6O/FxBVnna6BtTjqbDHT2MZTw8B01HGTcGbclwqObPqmq59IMOYUi2kUQccX1ow//0n3mmf1biiF1TZNIY5YbNpNw+lOACNqNXUNB0fg/Fl9jc
x-ms-exchange-antispam-messagedata: Ouexgy7CsksWMdS2+SF8mknhrMF9n5vjwhOLj3IePlnprzmy88Np0DoKqGuPfBFXIy+kW5RlGXfO7Z8XflZ54XI4fVkrSSt0PDqKOmLfXaBbBNIXhYk1SZAIb2+NHeajtzoi38R+bQo/GX6y/Hs5vA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27ea73dc-7835-47cd-27d0-08d7a9437470
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2020 07:25:47.5825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2bc9wGSQqPf9ZsW/WrHUZRrJlAg+92r1c7QNgDVebwdNVIl1sgyBmiye1mqCsvJnYmSSGAz6bsBZdvXcJTY41Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5090
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Leon,

> From: Leon Romanovsky <leon@kernel.org>
> Sent: Tuesday, February 4, 2020 12:48 PM
>=20
> On Tue, Feb 04, 2020 at 04:27:45AM +0000, Parav Pandit wrote:
> >
> >
> > > From: Jason Gunthorpe <jgg@mellanox.com>
> > > Sent: Monday, February 3, 2020 11:34 PM
> > >
> > > On Mon, Feb 03, 2020 at 11:31:06PM +0530, Devesh Sharma wrote:
> > > > On Mon, Feb 3, 2020 at 11:23 PM Jason Gunthorpe <jgg@mellanox.com>
> > > wrote:
> > > > >
> > > > > On Mon, Feb 03, 2020 at 12:52:04PM -0500, Devesh Sharma wrote:
> > > > > > It becomes difficult to make out from the output of
> > > > > > ibv_devinfo if a particular gid index is RoCE v2 or not.
> > > > > >
> > > > > > Adding a string to the output of ibv_devinfo -v to display the
> > > > > > gid type at the end of gid.
> > > > > >
> > > > > > The output would look something like below:
> > > > > > $ ibv_devinfo -v -d bnxt_re2
> > > > > > hca_id: bnxt_re2
> > > > > >  transport:             InfiniBand (0)
> > > > > >  fw_ver:                216.0.220.0
> > > > > >  node_guid:             b226:28ff:fed3:b0f0
> > > > > >  sys_image_guid:        b226:28ff:fed3:b0f0
> > > > > >   .
> > > > > >   .
> > > > > >   .
> > > > > >   .
> > > > > >        phys_state:      LINK_UP (5)
> > > > > >        GID[  0]:               fe80::b226:28ff:fed3:b0f0, IB/Ro=
CE v1
> > > > > >        GID[  1]:               fe80::b226:28ff:fed3:b0f0, RoCE =
v2
> > > > > >        GID[  2]:               ::ffff:192.170.1.101, IB/RoCE v1
> > > > > >        GID[  3]:               ::ffff:192.170.1.101, RoCE v2
> > > > >
> > > > > v1 GIDs are GIDs and should never be formed as IPv6 addreses..
> > > > So, V1 gids would fall back to old style of display and there will
> > > > be one more check for gid-type inside the loop...
> > >
> > > Yes
> > >
> > > Parav should we show both the v6 and classic format for a v2 GID? ie
> > >
> > >         GID[  3]:               0000:0000:0000:ffff:xxxx:xxxx:xxxx, R=
oCE v2
> > >                                 ::ffff:192.170.1.101
> > >
> > Due to lack of support of GID's netdev, v1/v2 type info in ibv_devinfo =
output,
> most users that I know of are using non upstream show_gids script.
> > So changing format here shouldn't break the existing users scripts.
> > There may be some scripts that may find this format different.
> > So I think printing both is likely a more safer option.
>=20
> I don't understand this argument. Output from example tool (ibv_devinfo)
> inside libibverbs can't be considered API and we can't live in constant f=
ear that
> some user script will break. Of course, we will try to keep it stable, bu=
t there is
> no such promise.
>=20
I agree with your point that ibv_devinfo output is not an API.
I haven't come across a user who uses ibv_devinfo output as an API given la=
ck of info in it.
I really do not have any strong opinion to keep both format or single forma=
t.
