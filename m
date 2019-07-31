Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCEAF7CA38
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2019 19:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbfGaRWZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Jul 2019 13:22:25 -0400
Received: from mail-eopbgr150048.outbound.protection.outlook.com ([40.107.15.48]:10374
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726786AbfGaRWZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 31 Jul 2019 13:22:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iaaPXebtgx7rcyN/oMxzyxMtNZG9NNv0vNr3rzSM5qalW977kBS7QiqUk0St/TP0xNIOf2wbzGGPDCJ8ySfgG5TCUyTjvwArHdzlTaqr6djdeeBTwewTJFT3kC2XaJ2AVNaZ0n5KyMCoJv0BXtrUhVW9mDdfltDfv3iDNFxEgGMAwDINcG9+nwsTujALlDouM5iz3asSxixP5eS1UeRgIRvyitShIRd/cl1VGprex15D1vpJGN92AsqHgjwsM3Czfq/iWdANqoYBuZpOxY9dGBvVcmGDMY6efIudPyo+z3R8/VLszDa/hH0XW62Lo7FdvnA3zxmIx8pobyf1SdzFjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRkUp/7w34YLq+iZyT1wm6Ad1QQvneGv5QfQ5bNvMXI=;
 b=Ri5RdTMXl3ATFtfl4HUXQar0wv2FirtFbg1XYySQyTbBAHd+L93XoIAQlhO3LTk6MsVDfOrR3xLIYLkR0kKaWDWM7e1DBeZkVLKs7Brnsii4J6eaa8WvmeLxgt5e/o0JBFsEu+tDn/YV1LhSuQDffFd3Vt3KVqnNRilJxnZiF+Z8zWxQHoWhX5mOQS6kPNe7DAXVuQ5tYygALEGoj1KnYy82iYl4DBM9m7QUmRfckX0npfbj3qM84dnrZ5a5KV18yN4kMAXN9WCVhk51u41uFtmJ3Xv5EcW3b3pi5pl4eYThLuDiLvTuFQBBGRLiQPCiCgWwn9ezv/Y5Pbr5Qgj76Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=mellanox.com;dmarc=pass action=none
 header.from=mellanox.com;dkim=pass header.d=mellanox.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRkUp/7w34YLq+iZyT1wm6Ad1QQvneGv5QfQ5bNvMXI=;
 b=ED+cUBTIP5c2xgcYhfq0EgUKjfYOOmsvxDXEGK9rY2R5Ongv0K6pGNgWrNt47xoLdUBHdE9c/PjqHeXUn40NVnggllwZ3bUIdqYAa7qlNw2ka2t9XHl+d6OFlwDuXPMt8aAp/EjMRclY7hnem8u0O7HterDSbf9QPCsQ7W3PqsI=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4317.eurprd05.prod.outlook.com (52.133.12.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Wed, 31 Jul 2019 17:22:19 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880%4]) with mapi id 15.20.2136.010; Wed, 31 Jul 2019
 17:22:19 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Release locks during notifier
 unregister
Thread-Topic: [PATCH rdma-rc] RDMA/mlx5: Release locks during notifier
 unregister
Thread-Index: AQHVR3tn3qv1PGIyNEiC/uXBUZXM9qbk6WYAgAAKq4CAAAJ3AIAAA3+A
Date:   Wed, 31 Jul 2019 17:22:19 +0000
Message-ID: <20190731172215.GJ22677@mellanox.com>
References: <20190731083852.584-1-leon@kernel.org>
 <44863abbef5c1e233cbedfdf959fe900f7722d74.camel@redhat.com>
 <20190731170054.GF22677@mellanox.com>
 <20190731170944.GC4832@mtr-leonro.mtl.com>
In-Reply-To: <20190731170944.GC4832@mtr-leonro.mtl.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQBPR0101CA0034.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::47) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b78f02c-25b2-4895-4da6-08d715dba42b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR05MB4317;
x-ms-traffictypediagnostic: VI1PR05MB4317:
x-microsoft-antispam-prvs: <VI1PR05MB4317F2314C36B7CFF1D34741CFDF0@VI1PR05MB4317.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(189003)(199004)(102836004)(11346002)(66556008)(66446008)(53936002)(64756008)(5660300002)(26005)(66476007)(68736007)(54906003)(476003)(6916009)(81166006)(2616005)(8936002)(86362001)(6436002)(386003)(36756003)(446003)(66946007)(99286004)(6506007)(186003)(6486002)(8676002)(316002)(229853002)(81156014)(66066001)(6246003)(256004)(3846002)(4326008)(486006)(1076003)(52116002)(478600001)(107886003)(76176011)(25786009)(305945005)(14444005)(71200400001)(6116002)(7736002)(71190400001)(6512007)(33656002)(14454004)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4317;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xvJKJ8LSXedwV4UI1fb+wIZ8uYntlvp0fDP5opxc1ttq9YK/kWAX86+swcK5MRcQVrOYB3cmKeUOGtD2JANMFmq0iWFg3BbHk0gYdEkZjGye6TGMcsjzASjdr/kX+tTZonKO/BSo0EUCfuQqMSn5SGZeji2nDmCdfumW343NgUUG1vJlg60XmPHhh+Y16zGTtn3XzxeiSxc/sj4Dw+jz59sdOiy5FksKjQbaImadELyOBQdsugu5EV4uLHD9c25L5cF633mSkkJ9oDnSYb1x4RzNbFYoKOMhVHLADCcdoI+JQHn65waL1cmFcYSVDG1w2yFCn7SFgMmIhICjwK+fh61FfSM5ovkv+pMzn29hh0Z7ppQOb7kvWRmkNPUOAPIifhJjzEJgtPVRDWFxzQ+CnlPWx7SIRdOMelz7qba5t9A=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <36964C1F1886CF479BC0E17B8AD55D90@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b78f02c-25b2-4895-4da6-08d715dba42b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 17:22:19.3356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4317
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 31, 2019 at 08:09:44PM +0300, Leon Romanovsky wrote:
> On Wed, Jul 31, 2019 at 05:00:59PM +0000, Jason Gunthorpe wrote:
> > On Wed, Jul 31, 2019 at 12:22:44PM -0400, Doug Ledford wrote:
> > > > diff --git a/drivers/infiniband/hw/mlx5/main.c
> > > > b/drivers/infiniband/hw/mlx5/main.c
> > > > index c2a5780cb394..e12a4404096b 100644
> > > > +++ b/drivers/infiniband/hw/mlx5/main.c
> > > > @@ -5802,13 +5802,12 @@ static void mlx5_ib_unbind_slave_port(struc=
t
> > > > mlx5_ib_dev *ibdev,
> > > >  		return;
> > > >  	}
> > > >
> > > > -	if (mpi->mdev_events.notifier_call)
> > > > -		mlx5_notifier_unregister(mpi->mdev, &mpi->mdev_events);
> > > > -	mpi->mdev_events.notifier_call =3D NULL;
> > > > -
> > > >  	mpi->ibdev =3D NULL;
> > > >
> > > >  	spin_unlock(&port->mp.mpi_lock);
> > > > +	if (mpi->mdev_events.notifier_call)
> > > > +		mlx5_notifier_unregister(mpi->mdev, &mpi->mdev_events);
> > > > +	mpi->mdev_events.notifier_call =3D NULL;
> > >
> > > I can see where this fixes the problem at hand, but this gives the
> > > appearance of creating a new race.  Doing a check/unregister/set-null
> > > series outside of any locks is a red flag to someone investigating th=
e
> > > code.  You should at least make note of the fact that calling unregis=
ter
> > > more than once is safe.  If you're fine with it, I can add a comment =
and
> > > take the patch, or you can resubmit.
> >
> > Mucking about notifier_call like that is gross anyhow, maybe better to
> > delete it entirely.
>=20
> What do you propose to delete?

The 'mpi->mdev_events.notifier_call =3D NULL;' and 'if
(mpi->mdev_events.notifier_call)'

Once it leaves the lock it stops doing anything useful.

If you need it, then we can't drop the lock, if you don't, it is just
dead code, delete it.

Jason
