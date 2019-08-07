Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A98BF846E1
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2019 10:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbfHGIJ5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Aug 2019 04:09:57 -0400
Received: from mail-eopbgr30050.outbound.protection.outlook.com ([40.107.3.50]:4553
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728078AbfHGIJ4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 7 Aug 2019 04:09:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZaNavVQmirlPu8o5KV7bJETtd+GCbKRu6lADJL3REuZzR8UK/o8rNkzyAyW0vUGxavGct4pbymQW0qPPaj/bTyy5zUOoXzk40ldsvmaVibMXCA4BqWNp4DABcm4MfeStzB2F3aZWouQpvHIHzaaAp2nyq71L4BSPI7mtO8v2oQX06SC/j8hFonE8tjYCko6eUCxNtnFodTsiLP3CcGq1I7bMmmIisGGlyro4bztkETJNKNNvf+1L3MZ5HrfncDfrfr2ZJxujRTDHYic4ZQm6H5oe1DaeWrJogz9ZEFJuAPIjzoY5M9UNHXOJR10wW5DvlvdjHIC7o6fnp29YBD4fQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MI0nPPtEauu82jRGWVBjR2wjC67U+4nFX7SCsoYQiqA=;
 b=ktwPPVUMrCNfBVQG8f2KeXUD9Wo04/hKEL3IOr7dwodoDCD7C1RVZ0/4UN/FPkqGGqjj2N0xQkv0Z3bKeeGbk3ZVFs3H6cXXoivSpbn3bSs9Evd2zijKyJ3E0aZSrTIFi3N9atK9MpIVUIoCIhjVhGvi3f09vmOHfOxk3ITTO7FkqOwbrBPbGwlVi30EbyqBlUWsIMW5jb2TzqDUlcDCqy84lmrRBEaL/uNR5Om88OT7ED1PpMnADYfEcdhx/R1T3VOC9PbNFzHTUUQYUJUak0muxzUacmg65do+R6+wHlGx6nR/0uOaJ2RXY3hSAWH074TThnvui0FF7A2kA5op2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=mellanox.com;dmarc=pass action=none
 header.from=mellanox.com;dkim=pass header.d=mellanox.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MI0nPPtEauu82jRGWVBjR2wjC67U+4nFX7SCsoYQiqA=;
 b=oKGUZgyk4QcoU02Dm52t9iNDq5G+87tDi/NyrzRhpEKpBAjBaFjYKmUBOO5GPbd34u2NbS3a9rh52IXre+m5GRFwWxzD625N8c8zYthxd7G//53PoDKByONEeTa9j/yXPn28yyDXbJz9Tgtk5AL22pGBpxYjdXV4RtiF9B9HwPQ=
Received: from AM5PR0502MB2931.eurprd05.prod.outlook.com (10.175.40.12) by
 AM5PR0502MB2883.eurprd05.prod.outlook.com (10.175.44.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.17; Wed, 7 Aug 2019 08:09:52 +0000
Received: from AM5PR0502MB2931.eurprd05.prod.outlook.com
 ([fe80::e85f:70d5:5157:f3bf]) by AM5PR0502MB2931.eurprd05.prod.outlook.com
 ([fe80::e85f:70d5:5157:f3bf%4]) with mapi id 15.20.2136.018; Wed, 7 Aug 2019
 08:09:52 +0000
From:   Vladimir Koushnir <vladimirk@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Haim Boozaglo <haimbo@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Yael Shavit <yaelsh@mellanox.com>,
        Sasha Kotchubievsky <sashakot@mellanox.com>,
        Daniel Klein <danielk@mellanox.com>
Subject: RE: [PATCH 1/3] libibumad: Support arbitrary number of IB devices
Thread-Topic: [PATCH 1/3] libibumad: Support arbitrary number of IB devices
Thread-Index: AQHVTGS1dlbRQYFwGUWbpTsg4FFs4KbuRQEAgAEEEkCAAAYSgIAABgZw
Date:   Wed, 7 Aug 2019 08:09:52 +0000
Message-ID: <AM5PR0502MB29315DB149BC2E6FA28C4B52CED40@AM5PR0502MB2931.eurprd05.prod.outlook.com>
References: <1565102334-20903-1-git-send-email-haimbo@mellanox.com>
 <20190806155206.GZ4832@mtr-leonro.mtl.com>
 <AM5PR0502MB2931A53B02F2615B967F3B30CED40@AM5PR0502MB2931.eurprd05.prod.outlook.com>
 <20190807074439.GB32366@mtr-leonro.mtl.com>
In-Reply-To: <20190807074439.GB32366@mtr-leonro.mtl.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vladimirk@mellanox.com; 
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b33dd63-54f3-4092-8e9f-08d71b0ea049
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM5PR0502MB2883;
x-ms-traffictypediagnostic: AM5PR0502MB2883:
x-microsoft-antispam-prvs: <AM5PR0502MB28835F0E3492E54831139716CED40@AM5PR0502MB2883.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01221E3973
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(199004)(189003)(13464003)(7736002)(446003)(53936002)(305945005)(186003)(476003)(11346002)(107886003)(6916009)(66066001)(14454004)(26005)(486006)(478600001)(4326008)(33656002)(5660300002)(6246003)(25786009)(8676002)(81156014)(81166006)(86362001)(66946007)(55016002)(68736007)(256004)(14444005)(6506007)(66446008)(53546011)(71200400001)(71190400001)(66476007)(102836004)(66556008)(229853002)(64756008)(6116002)(3846002)(76176011)(54906003)(6436002)(99286004)(76116006)(7696005)(52536014)(74316002)(9686003)(2906002)(8936002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0502MB2883;H:AM5PR0502MB2931.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3RTf6qM77bsuiWDhaJlEwQr1yziDXxFOcDiEn4emECsMBZregAtUCIenKQRabY1grFhEtxbPX1xb8wb2nhsoo3mXYkmJiAoyFgFIthqlTkUSBCjqNOHwN24kpFGkm0rJfrBdpkq65zI8WI+SIOTi3zAV/AsO2uVYwcz2JHxTczbwCuHWT1H78rs/rjxcDlyIFCLZU/Z5wxJqs9fe4whmVvP2HOGUjajvcgURaO7FuKU2iKQA+t/6Uoj2Z2DcHe1PsSPpgr7CdEig8WRT5qHPjTGgwJEng3t4Qyzk3lI9ypi6aKzX4NxNHMf2uXR2PLkBXhkMC2AmVfBhQw4w+4l6Bavbv3YE7Nq6Ja4qq+KCo3ast5vmqT0A2M7vAulxjx2akVqjftyztGoX0T0aUJKqIVGs614rEwQUy/YfRq2ZjZc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b33dd63-54f3-4092-8e9f-08d71b0ea049
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2019 08:09:52.7982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vladimirk@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0502MB2883
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

After discussing with Leon, libibumad and probably infiniband-diags should =
be redesigned to follow new rdma-core policy of using netlink API.

This redesign will be added to the POR and will be provided on top of provi=
ded patches.

So in short-term, the patches will be accepted after fixing comments #1-#2.
In long-term, libibumad support for netlink API will be provided.

-----Original Message-----
From: Leon Romanovsky <leon@kernel.org>=20
Sent: Wednesday, August 7, 2019 10:45 AM
To: Vladimir Koushnir <vladimirk@mellanox.com>
Cc: Haim Boozaglo <haimbo@mellanox.com>; linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/3] libibumad: Support arbitrary number of IB devices

On Wed, Aug 07, 2019 at 07:26:35AM +0000, Vladimir Koushnir wrote:
> Leon,
>
> For comment #3:
> We are not planning to change implementation of libibumad.
> The patches were developed with existing libibumad code and extending=20
> existing capability to provide list of devices on the node beyond 32=20
> devocs

You are proposing patches for inclusion in upstream rdma-core and our reque=
st is to use the same functionality as already available in rdma-core. We d=
on't ask you to rewrite existing libibumad code, but don't submit wrong cod=
e.

>
> For comment #4:
> Hot-plug is out-of-scope of the libibumad as no persistent data is mainta=
ined by libibumad.

Fair enough.

Thanks

>
> -----Original Message-----
> From: Leon Romanovsky <leon@kernel.org>
> Sent: Tuesday, August 6, 2019 6:52 PM
> To: Haim Boozaglo <haimbo@mellanox.com>
> Cc: linux-rdma@vger.kernel.org; Vladimir Koushnir=20
> <vladimirk@mellanox.com>
> Subject: Re: [PATCH 1/3] libibumad: Support arbitrary number of IB=20
> devices
>
> On Tue, Aug 06, 2019 at 02:38:52PM +0000, Haim Boozaglo wrote:
> > From: Vladimir Koushnir <vladimirk@mellanox.com>
> >
> > Added new function returning a list of available InfiniBand device name=
s.
> > The returned list is not limited to 32 devices.
> >
> > Signed-off-by: Vladimir Koushnir <vladimirk@mellanox.com>
> > Signed-off-by: Haim Boozaglo <haimbo@mellanox.com>
> > ---
> >  libibumad/CMakeLists.txt              |  2 +-
> >  libibumad/libibumad.map               |  6 +++++
> >  libibumad/man/umad_free_ca_namelist.3 | 28 ++++++++++++++++++++++++
> >  libibumad/man/umad_get_ca_namelist.3  | 34 +++++++++++++++++++++++++++=
++
> >  libibumad/umad.c                      | 41 +++++++++++++++++++++++++++=
++++++++
> >  libibumad/umad.h                      |  2 ++
> >  6 files changed, 112 insertions(+), 1 deletion(-)  create mode=20
> > 100644
> > libibumad/man/umad_free_ca_namelist.3
> >  create mode 100644 libibumad/man/umad_get_ca_namelist.3
>
> 1. Please use cover letter for patch series.
> 2. There is a need to update debian package too.
> 3. Need to use the same discovery mechanism as used in libibverbs - netli=
nk based.
> 4. Does it work with hot-plug where device name can change?
>
> Thanks
