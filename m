Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3289D1514F4
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2020 05:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgBDE1t (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Feb 2020 23:27:49 -0500
Received: from mail-eopbgr80054.outbound.protection.outlook.com ([40.107.8.54]:1774
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726984AbgBDE1t (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 3 Feb 2020 23:27:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ci7eQUCwN8+/N5ACSwDAhHfBtywsSOU2cbMp6qcHc0W0Z6d0DlyTVe7iQ2H2LXivE5uG4Ldumj/R8dISqbAiYyl7rAb4VpuwgyRescIYtVeSe6Bd6ErNYXdqGLx7s/NG3UJ14Uz4U4kslwntnEenfP0wqjDFx7tqpjslYxf8sobWRzF4dE5n99FA4d/XoPH8A722IgbeyjcvVKo7iU6lMHP9UhAb15yOisQiRlrDDa2G69nWhHwtIm2+aJSYcONfdUPKDB8+MYuPNV2v514EJC45DX5OXgxzPSJeKhJ7zXo9h1ieQhTULCHRrdY1N1diq1O5K6+c/BQ4dUS9kHbreg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQdaYCjklEYWZ6FFtSu5f+rkprNGQlyFB8wf5Z/9NJw=;
 b=ijk2Pap0lFMUxmWx+s09S/YeYrm6cbe74m21c+aHt0ByzM2zAbUFd8vdiw7mBcO8Vp2p71pSzU1nL6wn9zUoDLn9E6isEblkT0v4VJphpVukw1HoD3899U4A9Du81VXTHOZX2xv8wtc3UlnfkBRCI6JRBq7shsNf7Nq/7DCjwS9iq+oxlPoqxEeNA6igEu4VajoZTQL1ongNf/6Dfih0evUbmfyiX2is2Z9bggOwcHasisltEV3hZVRmUbmRkHsb5UnPWNBNdZoyFDtVzSlHBpnsOkMSv9rJASwpYMOl2dPVDgCDR6Fl0u5gBz8U6cpxYv7RYtdn9v4yQ93bvnTXuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQdaYCjklEYWZ6FFtSu5f+rkprNGQlyFB8wf5Z/9NJw=;
 b=c7J/kRbSz/zAemNvbg9xpMY89xKesYn34uOLByqwLB98D+TngMwvVni5G8eDFqshnIBKK8yQRnv+p6aZeycuQrT51v44nl2q9eWGG8fQKgDinPG4uhO6Z/q14VIrsBeZwpS951VszWf3ErXeMU17QmaO8QT2mF92NmpzhisYfqs=
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com (20.176.214.160) by
 AM0PR05MB5187.eurprd05.prod.outlook.com (20.178.17.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Tue, 4 Feb 2020 04:27:45 +0000
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::445c:4a14:1020:2346]) by AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::445c:4a14:1020:2346%7]) with mapi id 15.20.2686.031; Tue, 4 Feb 2020
 04:27:45 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>
CC:     linux-rdma <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>
Subject: RE: [PATCH v5] libibverbs: display gid type in ibv_devinfo
Thread-Topic: [PATCH v5] libibverbs: display gid type in ibv_devinfo
Thread-Index: AQHV2rqvR61k0ZnXAkKKwRApH3OosKgJwCuAgAACLwCAAADWAIAArK1w
Date:   Tue, 4 Feb 2020 04:27:45 +0000
Message-ID: <AM0PR05MB486694589EA1CBC66F598066D1030@AM0PR05MB4866.eurprd05.prod.outlook.com>
References: <1580752324-24742-1-git-send-email-devesh.sharma@broadcom.com>
 <20200203175317.GQ23346@mellanox.com>
 <CANjDDBh_Xv0BNhTYZ1xaaOCQ8-ijHUMqDE68_J4aqRF-EnT2Zg@mail.gmail.com>
 <20200203180405.GR23346@mellanox.com>
In-Reply-To: <20200203180405.GR23346@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [106.51.31.117]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 97c05387-7894-4d59-b016-08d7a92a957b
x-ms-traffictypediagnostic: AM0PR05MB5187:|AM0PR05MB5187:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR05MB5187FA74AD0E1E49E13D6458D1030@AM0PR05MB5187.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 03030B9493
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(199004)(189003)(76116006)(66946007)(71200400001)(66556008)(66446008)(66476007)(54906003)(110136005)(52536014)(81166006)(8936002)(81156014)(86362001)(5660300002)(64756008)(8676002)(26005)(186003)(53546011)(9686003)(55016002)(316002)(6506007)(7696005)(2906002)(33656002)(55236004)(478600001)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB5187;H:AM0PR05MB4866.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eQWCG97g0kH9TEPbQpy28kl0Okbuzb42f5If8n8W5jZUzWv/yqDeUjTFx7oOqZCtaBWNoaTaTUMkHy+v4GSpBJKJHPaVKdDmYaEjsn9EsU8q6p7m88sCE3S9A1veYci/f+A+6021aI46Z70MkZ82MqgnuOGz1nWvq3lRla02ayyKoI34xeLFOjZof3NqH81GuEGCQr6oNxkgqzO0hRfHT2o4z75pQN4WFuZ/Y1vX16DtkBuAav18WjCWqym3488Ekw8ZF28li5uHNnOPoPc0KsHs8vugK8/geARBUrVjsjcQV6mdVzw7V2rX6VERU6It4dbYFX6RLDGHVKxui3UNmiv5NySxSsCvfo80BRf6j0X1GQhcm/ixNrnDejw9amj7a/UiowhEH2StAOJ4Re5aM+Wi8UtJ8gXtm2rQ9jR14UVAX6kBSDhIQ5uaMfTpsj9w
x-ms-exchange-antispam-messagedata: rTX0vLIhqsm0Pmg9viEcERhHJPaAY16KEV67Zu4dOwsd30L6iViRvasEusxH5JyOIzDnphfpmf2X605VbJab+I3MNc0fUmG+udU5MfPoDc32PWV8GPSUhqWpYNFUEuSw/1nqkWQ6IxaAinz3b48Mlg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c05387-7894-4d59-b016-08d7a92a957b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2020 04:27:45.6187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lha+tGSTt1DGEHUbhj8XZW23tFGGnGHpQiQ3S3JfAyL71KGS3Q0Ryh1alUX2DJGwX2C4YYU8wLwsPlbyhUBkjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5187
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> From: Jason Gunthorpe <jgg@mellanox.com>
> Sent: Monday, February 3, 2020 11:34 PM
>=20
> On Mon, Feb 03, 2020 at 11:31:06PM +0530, Devesh Sharma wrote:
> > On Mon, Feb 3, 2020 at 11:23 PM Jason Gunthorpe <jgg@mellanox.com>
> wrote:
> > >
> > > On Mon, Feb 03, 2020 at 12:52:04PM -0500, Devesh Sharma wrote:
> > > > It becomes difficult to make out from the output of ibv_devinfo if
> > > > a particular gid index is RoCE v2 or not.
> > > >
> > > > Adding a string to the output of ibv_devinfo -v to display the gid
> > > > type at the end of gid.
> > > >
> > > > The output would look something like below:
> > > > $ ibv_devinfo -v -d bnxt_re2
> > > > hca_id: bnxt_re2
> > > >  transport:             InfiniBand (0)
> > > >  fw_ver:                216.0.220.0
> > > >  node_guid:             b226:28ff:fed3:b0f0
> > > >  sys_image_guid:        b226:28ff:fed3:b0f0
> > > >   .
> > > >   .
> > > >   .
> > > >   .
> > > >        phys_state:      LINK_UP (5)
> > > >        GID[  0]:               fe80::b226:28ff:fed3:b0f0, IB/RoCE v=
1
> > > >        GID[  1]:               fe80::b226:28ff:fed3:b0f0, RoCE v2
> > > >        GID[  2]:               ::ffff:192.170.1.101, IB/RoCE v1
> > > >        GID[  3]:               ::ffff:192.170.1.101, RoCE v2
> > >
> > > v1 GIDs are GIDs and should never be formed as IPv6 addreses..
> > So, V1 gids would fall back to old style of display and there will be
> > one more check for gid-type inside the loop...
>=20
> Yes
>=20
> Parav should we show both the v6 and classic format for a v2 GID? ie
>=20
>         GID[  3]:               0000:0000:0000:ffff:xxxx:xxxx:xxxx, RoCE =
v2
>                                 ::ffff:192.170.1.101
>=20
Due to lack of support of GID's netdev, v1/v2 type info in ibv_devinfo outp=
ut, most users that I know of are using non upstream show_gids script.
So changing format here shouldn't break the existing users scripts.
There may be some scripts that may find this format different.
So I think printing both is likely a more safer option.

> Lets also supress the 'IB/RoCE v1' string on !roce device. IB only has on=
e GID
> type, there is no reason to print anything
>=20
> Jason
