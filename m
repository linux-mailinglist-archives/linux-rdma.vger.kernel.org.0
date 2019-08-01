Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7727DAC9
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2019 14:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731113AbfHAMAR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Aug 2019 08:00:17 -0400
Received: from mail-eopbgr50060.outbound.protection.outlook.com ([40.107.5.60]:36929
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727455AbfHAMAQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 1 Aug 2019 08:00:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VqlsRYSG0FAPpix1K6JMAbUQsha003bVbU35hXtu/35tlinItBEtmmGO6HjbEnfiqbGsTAa/CgqwbFPfcS9kYEwXQ5zNHXvw3+OYJqv03ndipRoQtKpX9qs7eyX3T8/vmp2aiELStPUV6wGAw/xmiaL3uccx7rxAmImtID6jvtmk7rCW9rQWE34Hl4YiTwE7gTQcU7QTdp8L8ms9UHMYm174w55dtkESb6fMkUssfO1uSMPZeBXTzMuZDt2vqPHi7Ebr+IG3tsGRhr7oP/+1IRi5GxLU7JiUVI73w00Glz8K9c7YTMJoRwAbES/cS4Y6GENGzq7OIKHwvdl1u1ZGTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kknZZv6JqR7VzjsMGUaHnFk0TpSwFKodm8KnxU64Jxs=;
 b=LcGqEThix24aBx9iMKCXmzUPKKRp0nLnFC2zmybkKbQm3p+sVz9IerGJIpiNYgydq2vfTe0McfiE+Kh1aSvnXkb6ax91XuZu1kmuulum4QT8eKiVsdpDmpWsJM7w/YEme8DyZZhuZJqfviGyR/3YCz9V+MNNM50y421D/JgmR1OSWNXB4Gd2TWIVQibasjUT5SRmOlfYp2hGovMKbUGjteoXSMjQu3RAnig3YEbwtcwfm/8ra1NCvkMklGUZ9uBewQwofbWjEvmG78PVB+vfBDgrownnY5Z69dFao5z1z7Ebwiz/yo0xz4KpF6YTfddCgcQLLnNnjQj0BYL68YGg+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=mellanox.com;dmarc=pass action=none
 header.from=mellanox.com;dkim=pass header.d=mellanox.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kknZZv6JqR7VzjsMGUaHnFk0TpSwFKodm8KnxU64Jxs=;
 b=bp16IxuKsp3DqcKC7hPBlYlX47wMkRgdWQZ+PWWCdym4UMihIkl2EzyUCDjfPKgMbGTXSEtTZ3omwsaVBvRSyYdXFRZPUZG9bjrIjfk9sNanU4rFpKJPEJnR/bqMGhssniSz5mVMtaDhU1uTNslaQ/QjjYigg+uOHcPE3n+lOFU=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5648.eurprd05.prod.outlook.com (20.178.120.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Thu, 1 Aug 2019 12:00:12 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880%4]) with mapi id 15.20.2136.010; Thu, 1 Aug 2019
 12:00:12 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Release locks during notifier
 unregister
Thread-Topic: [PATCH rdma-rc] RDMA/mlx5: Release locks during notifier
 unregister
Thread-Index: AQHVR3tn3qv1PGIyNEiC/uXBUZXM9qbk6WYAgAAKq4CAAAJ3AIAAA3+AgAAK8ACAAB/ZgIAA0jqAgAA7UYA=
Date:   Thu, 1 Aug 2019 12:00:12 +0000
Message-ID: <20190801120007.GB23885@mellanox.com>
References: <20190731083852.584-1-leon@kernel.org>
 <44863abbef5c1e233cbedfdf959fe900f7722d74.camel@redhat.com>
 <20190731170054.GF22677@mellanox.com>
 <20190731170944.GC4832@mtr-leonro.mtl.com>
 <20190731172215.GJ22677@mellanox.com>
 <20190731180124.GE4832@mtr-leonro.mtl.com>
 <20190731195523.GK22677@mellanox.com>
 <20190801082749.GH4832@mtr-leonro.mtl.com>
In-Reply-To: <20190801082749.GH4832@mtr-leonro.mtl.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YT1PR01CA0018.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::31)
 To VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa89b33e-31c6-4884-f6cb-08d71677cef8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB5648;
x-ms-traffictypediagnostic: VI1PR05MB5648:
x-microsoft-antispam-prvs: <VI1PR05MB56487764AC74AA8DDDAF5F68CFDE0@VI1PR05MB5648.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 01165471DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(199004)(189003)(53936002)(99286004)(2906002)(6436002)(52116002)(8936002)(2616005)(71190400001)(81166006)(11346002)(81156014)(25786009)(68736007)(3846002)(6246003)(86362001)(6916009)(14454004)(6116002)(478600001)(305945005)(476003)(256004)(76176011)(8676002)(446003)(1076003)(386003)(6506007)(6486002)(316002)(66446008)(64756008)(66556008)(107886003)(5660300002)(7736002)(14444005)(6512007)(33656002)(486006)(102836004)(54906003)(66946007)(26005)(71200400001)(4326008)(36756003)(186003)(229853002)(66476007)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5648;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qRYVmdp3xw4uErz17VJXA9R0gemkQ5cfKPtt+gGvaaRsHZnCozq87DsbOKLtjq7QyN0FyZkMj+v1MHmSx9PsrZgHk+AURGM05HrCmhz7RmjFWnFhh+PtI2jDbd+pIWf2+EdexYovKhomvsRYFvL/+F8MiAjwR7lk3eXgCSBkKfz+jgltMuliDUy21LgQE1tmVmiWDJVKv7ma6ErNQt2hITaHhD2qYlOZdK5mufiKvI29bnYFw/6caFeCZnl7N2vYTRFUhAYhH0AYfa56GJkNYG7d2GwAlCOxzicRz0KK7r9JrGusF7o2GDmRNKJ05INLqPgUoodahRZV0Tl5T2tkGLfhygmGJJQZyl53k19rQFTnUksMLVNlyDPH4E1WOHmD2cMoRLGGO5wRQoagRl8Uf3tRNG4r5ovBPWwcIOhLnVM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7739C390E401804095F84CD4D72C50AF@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa89b33e-31c6-4884-f6cb-08d71677cef8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2019 12:00:12.7365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5648
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 01, 2019 at 11:27:49AM +0300, Leon Romanovsky wrote:
> On Wed, Jul 31, 2019 at 07:55:28PM +0000, Jason Gunthorpe wrote:
> > On Wed, Jul 31, 2019 at 09:01:24PM +0300, Leon Romanovsky wrote:
> > > On Wed, Jul 31, 2019 at 05:22:19PM +0000, Jason Gunthorpe wrote:
> > > > On Wed, Jul 31, 2019 at 08:09:44PM +0300, Leon Romanovsky wrote:
> > > > > On Wed, Jul 31, 2019 at 05:00:59PM +0000, Jason Gunthorpe wrote:
> > > > > > On Wed, Jul 31, 2019 at 12:22:44PM -0400, Doug Ledford wrote:
> > > > > > > > diff --git a/drivers/infiniband/hw/mlx5/main.c
> > > > > > > > b/drivers/infiniband/hw/mlx5/main.c
> > > > > > > > index c2a5780cb394..e12a4404096b 100644
> > > > > > > > +++ b/drivers/infiniband/hw/mlx5/main.c
> > > > > > > > @@ -5802,13 +5802,12 @@ static void mlx5_ib_unbind_slave_po=
rt(struct
> > > > > > > > mlx5_ib_dev *ibdev,
> > > > > > > >  		return;
> > > > > > > >  	}
> > > > > > > >
> > > > > > > > -	if (mpi->mdev_events.notifier_call)
> > > > > > > > -		mlx5_notifier_unregister(mpi->mdev, &mpi->mdev_events);
> > > > > > > > -	mpi->mdev_events.notifier_call =3D NULL;
> > > > > > > > -
> > > > > > > >  	mpi->ibdev =3D NULL;
> > > > > > > >
> > > > > > > >  	spin_unlock(&port->mp.mpi_lock);
> > > > > > > > +	if (mpi->mdev_events.notifier_call)
> > > > > > > > +		mlx5_notifier_unregister(mpi->mdev, &mpi->mdev_events);
> > > > > > > > +	mpi->mdev_events.notifier_call =3D NULL;
> > > > > > >
> > > > > > > I can see where this fixes the problem at hand, but this give=
s the
> > > > > > > appearance of creating a new race.  Doing a check/unregister/=
set-null
> > > > > > > series outside of any locks is a red flag to someone investig=
ating the
> > > > > > > code.  You should at least make note of the fact that calling=
 unregister
> > > > > > > more than once is safe.  If you're fine with it, I can add a =
comment and
> > > > > > > take the patch, or you can resubmit.
> > > > > >
> > > > > > Mucking about notifier_call like that is gross anyhow, maybe be=
tter to
> > > > > > delete it entirely.
> > > > >
> > > > > What do you propose to delete?
> > > >
> > > > The 'mpi->mdev_events.notifier_call =3D NULL;' and 'if
> > > > (mpi->mdev_events.notifier_call)'
> > > >
> > > > Once it leaves the lock it stops doing anything useful.
> > > >
> > > > If you need it, then we can't drop the lock, if you don't, it is ju=
st
> > > > dead code, delete it.
> > >
> > > This specific notifier_call is protected outside
> > > of mlx5_ib_unbind_slave_port() by mlx5_ib_multiport_mutex and NULL ch=
eck
> > > is needed to ensure single call to mlx5_notifier_unregister, because
> > > calls to mlx5_ib_unbind_slave_port() will be serialized.
> >
> > If this routine is now relying on locking that is not obvious in the
> > function itself then add a lockdep too.
>=20
> It was "before" without lockdep and we are
> protecting "mpi->mdev_events.notifier_call =3D NULL;"

Before the locking was relying on mpi_lock inside this function now
this patch changes it to relies on mlx5_ib_multiport_mutex, so it
needs a lockdep

Jason
