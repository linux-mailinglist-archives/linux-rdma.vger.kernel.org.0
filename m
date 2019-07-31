Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B73417C9AC
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2019 19:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfGaRBG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Jul 2019 13:01:06 -0400
Received: from mail-eopbgr70075.outbound.protection.outlook.com ([40.107.7.75]:25123
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728336AbfGaRBF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 31 Jul 2019 13:01:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TygE0U3Nq6DwKSxPWzA72g6MoFl0Ys8Wwvchc9YFneGKV/yz6NmUR+zNbKcDOS8D3gPPq3HEynA9O213zBGOW6mfUwpgpHgLjmvhWJeR2ovgXBJFjiVi5zvKSyiTfIW//22/GHrhDqf6N2guVf1IqujdOBjCRDnjha9/8jOW/+azB7EI7t/Wz/X94dzxrzfUwRf53/nYKZ3dChCKaB5FRTA+OQs9hYgVsFJ47VCVJ0xKqDOEgjyCHElP6wkowavAZ3sqOZntBYOVyxupvGJmAY0Zh5AkKjC3c1Okz7CpWSWmz1W+zzqp26xbnUnbj/xKAbMF8a+bGcWLVUThLxWXSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tgvj8pbHb+sPI+mpLHEc9IJhKjZLddz9l0g32aoJeu8=;
 b=IFIhRssNFDB0cfeQVyoHxKHYFXd8r8zul+4TxJt0xjsZuuGZtscSN+62kW40zEt6m+jY5cJWqcd3kd9xqTaYMPlZywn0WY7b3/JMc9E671p4oARKPg109VIHjDP6AwA4k/ps5aoSK6P1ycoFUkL9sKbdjC3SWYrR/yQxG9/6sHNSX5xT9F+F2nOJZW8NB4+ZPq37Ehpe0rSqlCURv1VVS+yPPJFREDfeqFV4AsOM+sBt9IYtmimy9TIxYEKuh/xMOE4DLfPaPC5EggK6cPb7cIp6x/tOLC42B7pJORqbI8N2hPSg/AGAb8gAKS1QE7ceiUhclqNGNNvrQXq2NR0PcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=mellanox.com;dmarc=pass action=none
 header.from=mellanox.com;dkim=pass header.d=mellanox.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tgvj8pbHb+sPI+mpLHEc9IJhKjZLddz9l0g32aoJeu8=;
 b=jPgqk2e2Cn5zlb37T2drdFwHl7IIaCJWjYGvCoGQZkONI2p3Z4BR4vQyQhrW0h8i1URdS5LXBOV/f7IKFzf6d32cRG4WQf1p2QiTnttsNLlW+nRHQnye4Jk/Mu4KZRYItRhpg0CtkSqzUD34YBhCHjgIWg2Bk12i0IJ45Ddzljk=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB3231.eurprd05.prod.outlook.com (10.170.238.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Wed, 31 Jul 2019 17:01:00 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880%4]) with mapi id 15.20.2136.010; Wed, 31 Jul 2019
 17:01:00 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Doug Ledford <dledford@redhat.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Release locks during notifier
 unregister
Thread-Topic: [PATCH rdma-rc] RDMA/mlx5: Release locks during notifier
 unregister
Thread-Index: AQHVR3tn3qv1PGIyNEiC/uXBUZXM9qbk6WYAgAAKq4A=
Date:   Wed, 31 Jul 2019 17:00:59 +0000
Message-ID: <20190731170054.GF22677@mellanox.com>
References: <20190731083852.584-1-leon@kernel.org>
 <44863abbef5c1e233cbedfdf959fe900f7722d74.camel@redhat.com>
In-Reply-To: <44863abbef5c1e233cbedfdf959fe900f7722d74.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTOPR0101CA0033.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::46) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ac4549b-97e0-44f4-a94b-08d715d8a98a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB3231;
x-ms-traffictypediagnostic: VI1PR05MB3231:
x-microsoft-antispam-prvs: <VI1PR05MB32314D9667649E4DE9783828CFDF0@VI1PR05MB3231.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(189003)(199004)(6512007)(478600001)(66556008)(6916009)(6436002)(11346002)(14454004)(229853002)(446003)(14444005)(256004)(6116002)(3846002)(54906003)(53936002)(305945005)(36756003)(86362001)(316002)(486006)(2906002)(476003)(2616005)(66066001)(33656002)(81156014)(8676002)(102836004)(26005)(6506007)(66446008)(71200400001)(1076003)(386003)(6486002)(107886003)(81166006)(4326008)(99286004)(6246003)(52116002)(76176011)(68736007)(66476007)(64756008)(66946007)(25786009)(5660300002)(71190400001)(8936002)(186003)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3231;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jkZyIo/j3Yf/pjPyMtEjaGG/vgoMYSDhT7rEF4P2pRCGFMsl+jLR7R5VFaTS5KXuFTxxINa4lObuxridzK+br3TyKx+oYDbsj+uLpsXE5f0oZ3JcLBJaykrpGouQu5zdVNv8De7iytDKG4DrBnQKecdPqOGsfi7eC8yDEjezchOpb3i4YsegXpAP96T0gyk9gNERq0Rh5lySo08Qt7ioeqx8qBtcICd+GSBc5ZuA70z9PYpT9X6tcGMhO15Mk6uokFFlJpqwBlo7kdU8aqdfizw39qkcbpVkrBHZ5cTsMow1Iv/yeKo32ItH23WLiUBfQVjPkyKImifjQ54Z3UBRaTuf4IOCL9VeBOuUP46ygY5mfGrEFsSXrvLZuzDF/6GokjGMIx7tH94qoE4q8eSGl2RzmoSXKYnPuQhjMU9IDcM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9594B43FD85AB242A659C34204C41D0F@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac4549b-97e0-44f4-a94b-08d715d8a98a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 17:00:59.9569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3231
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 31, 2019 at 12:22:44PM -0400, Doug Ledford wrote:
> > diff --git a/drivers/infiniband/hw/mlx5/main.c
> > b/drivers/infiniband/hw/mlx5/main.c
> > index c2a5780cb394..e12a4404096b 100644
> > +++ b/drivers/infiniband/hw/mlx5/main.c
> > @@ -5802,13 +5802,12 @@ static void mlx5_ib_unbind_slave_port(struct
> > mlx5_ib_dev *ibdev,
> >  		return;
> >  	}
> > =20
> > -	if (mpi->mdev_events.notifier_call)
> > -		mlx5_notifier_unregister(mpi->mdev, &mpi->mdev_events);
> > -	mpi->mdev_events.notifier_call =3D NULL;
> > -
> >  	mpi->ibdev =3D NULL;
> > =20
> >  	spin_unlock(&port->mp.mpi_lock);
> > +	if (mpi->mdev_events.notifier_call)
> > +		mlx5_notifier_unregister(mpi->mdev, &mpi->mdev_events);
> > +	mpi->mdev_events.notifier_call =3D NULL;
>=20
> I can see where this fixes the problem at hand, but this gives the
> appearance of creating a new race.  Doing a check/unregister/set-null
> series outside of any locks is a red flag to someone investigating the
> code.  You should at least make note of the fact that calling unregister
> more than once is safe.  If you're fine with it, I can add a comment and
> take the patch, or you can resubmit.

Mucking about notifier_call like that is gross anyhow, maybe better to
delete it entirely.

Jason
