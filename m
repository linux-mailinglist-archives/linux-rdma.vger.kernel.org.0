Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3C987CD40
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2019 21:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfGaTzd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Jul 2019 15:55:33 -0400
Received: from mail-eopbgr60069.outbound.protection.outlook.com ([40.107.6.69]:41735
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727342AbfGaTzc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 31 Jul 2019 15:55:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ij1+UIlmRSVa5Nt37WNBqPWBAp5l4IwqGzMzM86A3BLI9PMwBaSJJTLIub1IMU3mFRm9CG8lEgbgwptkCxh359Ki2RvC9wm0UbisI9baHgeTaiv3y9AvZ24PqTdTZWYN3+jzBO7WERw6Cppe4/1b36thB2qaSzIRVPDD3AR6W8eHBOHzCaN51yV6vDcstzaydw3+N0pX0/nJDsjF62wmzicAX5mK1CzyYPj8+AjfTOMczNNBCrR+17wbzOrLEUXUo07EtUY4Dzb9yMWxcdudrRf+QGOTCcp+DLhwsmI7Bs8w1mouWjDSasxWKmbnHGd9npRaBZn0KpG4BbJkcwFUpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0CaH7tyVOu3rbT7WI0m8bE+hbj3ATALh+VXM0m50uk=;
 b=VYL4dqoQeAXiAN9QohSdJtH2y3QDHffAxJuK87YtQO0EAVvggFVpLpj2nves9FiOu1nMqLp5aQSNScE+ViqjmUlK0bzUkcuKXKG/txPf+RS/hB4mzKMmB2/T4JJ2g/tF6BrYUCpxbmVEY33gcwPp19rYDa6OT4w8ddpFAihhxzkn/kqMKAI9Hxf/6hiRne5voLSYXrfweD4yRQbS4CEcL16LRVISUdrQZy3BcgOva+DwLmUOkES9WGWXClQOJYa3nDui90aOyBJPPmXLI/D9eLWD8fOF1ymvfdpAsR5dLrJAMIUPjkgEjrwBYlv1sfkaX0EcJbExQ60HG/FsOCiPOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=mellanox.com;dmarc=pass action=none
 header.from=mellanox.com;dkim=pass header.d=mellanox.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0CaH7tyVOu3rbT7WI0m8bE+hbj3ATALh+VXM0m50uk=;
 b=gI9OtOyW214s4CWBSQWmITwA7cwnplvPejXQ+YcvyFry3sQLB2fy5Yt7hKo5xwPssb1GmowZi/UUvom2S8Y3lYW4VdMW09LMCK8HwjHhstQpsHq2BfqsZ1562bS0UvMD37XxWklreGOj0yhr5IBIZekFn9GGfDBn89ur4Pxc1Fw=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5437.eurprd05.prod.outlook.com (20.177.200.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.14; Wed, 31 Jul 2019 19:55:28 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880%4]) with mapi id 15.20.2136.010; Wed, 31 Jul 2019
 19:55:28 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Release locks during notifier
 unregister
Thread-Topic: [PATCH rdma-rc] RDMA/mlx5: Release locks during notifier
 unregister
Thread-Index: AQHVR3tn3qv1PGIyNEiC/uXBUZXM9qbk6WYAgAAKq4CAAAJ3AIAAA3+AgAAK8ACAAB/ZgA==
Date:   Wed, 31 Jul 2019 19:55:28 +0000
Message-ID: <20190731195523.GK22677@mellanox.com>
References: <20190731083852.584-1-leon@kernel.org>
 <44863abbef5c1e233cbedfdf959fe900f7722d74.camel@redhat.com>
 <20190731170054.GF22677@mellanox.com>
 <20190731170944.GC4832@mtr-leonro.mtl.com>
 <20190731172215.GJ22677@mellanox.com>
 <20190731180124.GE4832@mtr-leonro.mtl.com>
In-Reply-To: <20190731180124.GE4832@mtr-leonro.mtl.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTXPR0101CA0001.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::14) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9cc88772-81c3-467d-636b-08d715f1094a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB5437;
x-ms-traffictypediagnostic: VI1PR05MB5437:
x-microsoft-antispam-prvs: <VI1PR05MB54373FBA88E0F34C3ED7D91ECFDF0@VI1PR05MB5437.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(346002)(39860400002)(136003)(366004)(189003)(199004)(486006)(8936002)(476003)(6506007)(54906003)(81166006)(8676002)(71190400001)(14444005)(14454004)(2616005)(68736007)(6916009)(2906002)(1076003)(66066001)(4326008)(71200400001)(256004)(11346002)(25786009)(446003)(36756003)(86362001)(66446008)(316002)(6116002)(478600001)(386003)(107886003)(229853002)(6436002)(6486002)(81156014)(99286004)(53936002)(6246003)(102836004)(7736002)(5660300002)(305945005)(66946007)(66556008)(66476007)(64756008)(6512007)(33656002)(186003)(76176011)(3846002)(26005)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5437;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ipbup4etKx15AMFgSSlq7D5gQ+pKUuR2Bjh46KtSKluboXE9ZY8AyitQNfddvo1UwCl6gewi3RzK/st+vKpnwytYzF8N0+TR72sT+none5E5XjmfmveRKY85uAVf8Tlek4lLNFJczK+xEgHS16mv1nnA+C9t4+nFzGT4fWrBfF0QURNGgDbHCRBFU8J47FaZGz7ybA/i5WxFVHk2Ipr+7HTdDTuTEY/PiR3v+wM+1GvC6ZK0OfpNxe0dBRT49ZmbjEZ7qeoSjqtJFEqP0yxAdqs3F+La1hfG4eezb4kIaueRKvPUSyS2Vk7yKpa0maYliFpApY9q+1bx+kmkYBEvMWKHAgRxx8QsESdgaJtnAj3Nw//exbxcNN4Owse4CBKqZVwec70MftsopKFDGGj6SZ5PZtu6kqKdp+Tgj32HRmM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EC5592D837260B478A1747F1A0B25C7D@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cc88772-81c3-467d-636b-08d715f1094a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 19:55:28.5485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5437
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 31, 2019 at 09:01:24PM +0300, Leon Romanovsky wrote:
> On Wed, Jul 31, 2019 at 05:22:19PM +0000, Jason Gunthorpe wrote:
> > On Wed, Jul 31, 2019 at 08:09:44PM +0300, Leon Romanovsky wrote:
> > > On Wed, Jul 31, 2019 at 05:00:59PM +0000, Jason Gunthorpe wrote:
> > > > On Wed, Jul 31, 2019 at 12:22:44PM -0400, Doug Ledford wrote:
> > > > > > diff --git a/drivers/infiniband/hw/mlx5/main.c
> > > > > > b/drivers/infiniband/hw/mlx5/main.c
> > > > > > index c2a5780cb394..e12a4404096b 100644
> > > > > > +++ b/drivers/infiniband/hw/mlx5/main.c
> > > > > > @@ -5802,13 +5802,12 @@ static void mlx5_ib_unbind_slave_port(s=
truct
> > > > > > mlx5_ib_dev *ibdev,
> > > > > >  		return;
> > > > > >  	}
> > > > > >
> > > > > > -	if (mpi->mdev_events.notifier_call)
> > > > > > -		mlx5_notifier_unregister(mpi->mdev, &mpi->mdev_events);
> > > > > > -	mpi->mdev_events.notifier_call =3D NULL;
> > > > > > -
> > > > > >  	mpi->ibdev =3D NULL;
> > > > > >
> > > > > >  	spin_unlock(&port->mp.mpi_lock);
> > > > > > +	if (mpi->mdev_events.notifier_call)
> > > > > > +		mlx5_notifier_unregister(mpi->mdev, &mpi->mdev_events);
> > > > > > +	mpi->mdev_events.notifier_call =3D NULL;
> > > > >
> > > > > I can see where this fixes the problem at hand, but this gives th=
e
> > > > > appearance of creating a new race.  Doing a check/unregister/set-=
null
> > > > > series outside of any locks is a red flag to someone investigatin=
g the
> > > > > code.  You should at least make note of the fact that calling unr=
egister
> > > > > more than once is safe.  If you're fine with it, I can add a comm=
ent and
> > > > > take the patch, or you can resubmit.
> > > >
> > > > Mucking about notifier_call like that is gross anyhow, maybe better=
 to
> > > > delete it entirely.
> > >
> > > What do you propose to delete?
> >
> > The 'mpi->mdev_events.notifier_call =3D NULL;' and 'if
> > (mpi->mdev_events.notifier_call)'
> >
> > Once it leaves the lock it stops doing anything useful.
> >
> > If you need it, then we can't drop the lock, if you don't, it is just
> > dead code, delete it.
>=20
> This specific notifier_call is protected outside
> of mlx5_ib_unbind_slave_port() by mlx5_ib_multiport_mutex and NULL check
> is needed to ensure single call to mlx5_notifier_unregister, because
> calls to mlx5_ib_unbind_slave_port() will be serialized.

If this routine is now relying on locking that is not obvious in the
function itself then add a lockdep too.

Jason
