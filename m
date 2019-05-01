Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84F2710543
	for <lists+linux-rdma@lfdr.de>; Wed,  1 May 2019 07:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725535AbfEAFgY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 May 2019 01:36:24 -0400
Received: from mail-eopbgr50066.outbound.protection.outlook.com ([40.107.5.66]:45966
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725298AbfEAFgY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 1 May 2019 01:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vILmUTDPJcZJ/z0EqOulahUay9wjvGWRFExlpxBItYw=;
 b=ms0llaXEy/zccKnj/PRPpbyBGFLBsW//raOeyJdnh+XcuBiFV+856NyZ7Zg3FZW7/e6xChMbbA59XS9+MPH8UaViU52aj1N7uTTokQBXMTO+aG24/4S13IEJFLdhnuf8ExVTbnR5kDMqoN4quO+hb3QwCd6/On5A5IM61KDMzCQ=
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com (10.171.186.14) by
 AM4PR05MB3233.eurprd05.prod.outlook.com (10.171.188.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.15; Wed, 1 May 2019 05:36:17 +0000
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::edfd:88b8:1f9e:d5b1]) by AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::edfd:88b8:1f9e:d5b1%7]) with mapi id 15.20.1835.018; Wed, 1 May 2019
 05:36:17 +0000
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Parav Pandit <parav@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Huy Nguyen <huyn@mellanox.com>, Martin Wilck <mwilck@suse.com>
Subject: Re: [PATCH rdma-next 7/7] RDMA/core: Allow detaching gid attribute
 netdevice for RoCE
Thread-Topic: [PATCH rdma-next 7/7] RDMA/core: Allow detaching gid attribute
 netdevice for RoCE
Thread-Index: AQHU73/j9YmyZeIVxEu/ws607K+g5qY1aPwAgAACBoCAAAKPAIAAAnSAgAABpoCAAAGTgIAgbVWA
Date:   Wed, 1 May 2019 05:36:17 +0000
Message-ID: <20190501053613.GA7676@mtr-leonro.mtl.com>
References: <20190410081524.18737-1-leon@kernel.org>
 <20190410081524.18737-8-leon@kernel.org>
 <20190410092924.GL3201@mtr-leonro.mtl.com>
 <VI1PR0501MB22716B71DCDAD172090BA3D1D12E0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
 <20190410135507.GE8997@ziepe.ca> <20190410140416.GQ3201@mtr-leonro.mtl.com>
 <VI1PR0501MB2271247334248A6156AF2AB1D12E0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
 <20190410141857.GF8997@ziepe.ca> <20190410142435.GR3201@mtr-leonro.mtl.com>
In-Reply-To: <20190410142435.GR3201@mtr-leonro.mtl.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM3PR05CA0089.eurprd05.prod.outlook.com
 (2603:10a6:207:1::15) To AM4PR05MB3137.eurprd05.prod.outlook.com
 (2603:10a6:205:3::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [77.138.135.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e77bc516-ab28-4dc3-a6b9-08d6cdf6ee8e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(49563074)(7193020);SRVR:AM4PR05MB3233;
x-ms-traffictypediagnostic: AM4PR05MB3233:
x-microsoft-antispam-prvs: <AM4PR05MB323375BADA42EF48536D2E52B03B0@AM4PR05MB3233.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:211;
x-forefront-prvs: 00246AB517
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(366004)(136003)(376002)(189003)(199004)(6246003)(99936001)(53936002)(256004)(305945005)(52116002)(14444005)(76176011)(478600001)(99286004)(1076003)(6512007)(14454004)(8936002)(6116002)(3846002)(7736002)(81166006)(81156014)(8676002)(6916009)(6486002)(6436002)(4326008)(25786009)(5660300002)(71190400001)(229853002)(71200400001)(9686003)(486006)(316002)(64756008)(66946007)(73956011)(446003)(186003)(11346002)(476003)(66446008)(6506007)(102836004)(66556008)(386003)(66616009)(54906003)(66476007)(66066001)(33656002)(68736007)(2906002)(86362001)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR05MB3233;H:AM4PR05MB3137.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Xzfwcw2eXj1xVVEQFNqbDosEWodLvtEwvdlNSIKl8zSRRHL66Ee/nAn00l6Mmm0EQEvBRfFWAyhZsgNs/PE4rN9xSzU18NrBy7W2Lk/WZbX9m3whXWVOW1MLYvPuMkQk29NhuVOjLSe5pBzMIL6/e/EOj+JGr+s6ldQoP9I58/2fH2Nw65zwChkggpVbWxi2dwc55dHI3CwUiATTKSvnIJWWBmVQDgd8P7sUbeXb8RdYMh5+RVCea/tWOfYnenkg7A4VndQfEGw+RKcEDifjRXv9B6TYKWiDu4l3keob1hawamBVJCD0PL+nBrtnUYNiP3fPf9Ukg7okC9ZixeekE1KwlUe7QcQq0/uRlUBy6EQzRssSPUIM4JbdvujNPe1o9HVKpHg6flp2WTN8i0C9w4b7dpZabU4fofANyBLCVgQ=
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e77bc516-ab28-4dc3-a6b9-08d6cdf6ee8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2019 05:36:17.0836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB3233
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 10, 2019 at 02:24:36PM +0000, Leon Romanovsky wrote:
> On Wed, Apr 10, 2019 at 11:18:57AM -0300, Jason Gunthorpe wrote:
> > On Wed, Apr 10, 2019 at 02:13:03PM +0000, Parav Pandit wrote:
> >
> > > > Parav,
> > > >
> > > > Boot with rcu_dereference produces the following warning.
> > > >
> > > > [    7.921247] mlx5_core 0000:00:0c.0: firmware version: 3.10.9999
> > > > [    7.921730] mlx5_core 0000:00:0c.0: 0.000 Gb/s available PCIe bandwidth
> > > > (Unknown speed x255 link)
> > > > [    8.299897] mlx5_ib: Mellanox Connect-IB Infiniband driver v5.0-0
> > > > [    8.307859]
> > > > [    8.307989] =============================
> > > > [    8.308084] WARNING: suspicious RCU usage
> > > > [    8.308193] 5.1.0-rc2+ #278 Not tainted
> > > > [    8.308302] -----------------------------
> > > > [    8.308446] drivers/infiniband/core/cache.c:302 suspicious
> > > > rcu_dereference_check() usage!
> > > >
> > > > >
> > > Yes. So lets do
> > >
> > > rcu_dereference_protected(attr->ndev, 1);
> > >
> > > with below updated comment?
> > >
> > > +	/* rcu_dereference is not needed because GID attr being passed as input during
> > > +	 *  GID addition cannot change. It is used only to avoid smatch complain.
> > > +	 */
> >
> > Why cannot it change?
> >
> > You don't need to talk about smatch, the use of
> > rcu_dereference_protected is self-explanatory.
>
> While you are discussing the best comment, I tried it and it worked.
>
> Jason, do I need to resend v2?

Jason?

>
> Thanks
>
> >
> > Jason



--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcyTBNAAoJEORje4g2clinxtQQALj6iz1zc5ejDolwFMCjIZgm
a0le2wi0+fJnuxDKz252Vy2A5xLCvOuef+wXCOSJ1fvsfOqCnqwc+l03MhbVVara
a3kx9ITPgYmOb2aBtUaGJVXYXEGimPWAxStqEQc1M8i1w2mupTj9RHuFsD8AZDtE
NuPtK1LM6Wp8IIR8VHodV0v3RY/5KhkxIu5XA5URpj93ObHnL4PulBlz6DpVywrW
K+itzEGS2GG0ZC6AgZNESK780wEcvERgBkHFkJ8GPWZIlQPQltDQaf8abT2sbWHj
DLUxfocQmbwZNQVcginXffUb4hSaADvZ9aFlQ44aL4HgYXmv0qQgNfrE+G0ZxaBW
doUzW1+l3Ypy/xNSNKBf5r/pMxVXZmKlmInt1CIPXrSsIl3U4Xhw0KHCWWzUo3zA
mMxliBK6XUa+22Jol8/kk9FG6bAnk50eamRm5kxN9R5NX5YfJgBmHEDMqiAlov22
4vO3olCmUILR7iVEU8aqC4X//0VxAEwO/95XHXPKbh40qoweQDWCjmM+BytPxIZe
b3c3+tnvws1RDYhik3uA7/FZ/hcc54MBX5rEBdWrBVRHaR4KkdlAD4/OqwFoS4kB
94Tp+PuKEwh3lC+i50dj8UF4uYzbkZeGheM+zEXFvihQs4hu7lkLkPjExFN9XQOZ
Tp0rTXilPgHSBxlsdtmO
=R4C9
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
