Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFA1110FC
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2019 03:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfEBBu2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 May 2019 21:50:28 -0400
Received: from mail-eopbgr130053.outbound.protection.outlook.com ([40.107.13.53]:50053
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726152AbfEBBu1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 1 May 2019 21:50:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8oO2qCWfWdN34oxN9OJzixjvK2PplHDIxAVYIuYzL6k=;
 b=BfZndMiFXkanpPKp8LVbOEH4PEhw9Oo6WNgHPB0+2OVJHYe0m+U9a+Kvc319GBH2GT4ksogUIbRcZumatZP1TlHZ2BZ3J+vknhyvq2IYEQAO3svM6eaUB51HJMAxcDmcntVuQ4ErH7geIZRNb51hWwZISgb2A+vdwC+sZKTW+rU=
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com (10.169.134.149) by
 VI1PR0501MB2863.eurprd05.prod.outlook.com (10.172.12.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.10; Thu, 2 May 2019 01:50:22 +0000
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::8810:9799:ab77:9494]) by VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::8810:9799:ab77:9494%2]) with mapi id 15.20.1856.008; Thu, 2 May 2019
 01:50:22 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>
CC:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH rdma-next] RDMA/device: Don't fire uevent before device is
 fully initialized
Thread-Topic: [PATCH rdma-next] RDMA/device: Don't fire uevent before device
 is fully initialized
Thread-Index: AQHU/+E7QsYo34KmxEKFJkgoUS0uU6ZWQ+OAgABDwgCAAIo/MA==
Date:   Thu, 2 May 2019 01:50:22 +0000
Message-ID: <VI1PR0501MB227160596CFF8DF1C72AAAF3D1340@VI1PR0501MB2271.eurprd05.prod.outlook.com>
References: <20190501054619.14838-1-leon@kernel.org>
 <20190501115049.GA10407@mellanox.com>
 <20190501173126.GD7676@mtr-leonro.mtl.com>
In-Reply-To: <20190501173126.GD7676@mtr-leonro.mtl.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [68.203.16.89]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 95150f84-f102-46ac-54c9-08d6cea08a11
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR0501MB2863;
x-ms-traffictypediagnostic: VI1PR0501MB2863:
x-microsoft-antispam-prvs: <VI1PR0501MB2863C3518E91BDF3881E9B8FD1340@VI1PR0501MB2863.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0025434D2D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39860400002)(376002)(396003)(136003)(189003)(199004)(13464003)(76176011)(316002)(3846002)(66066001)(6506007)(476003)(52536014)(68736007)(6116002)(486006)(53546011)(229853002)(55016002)(9686003)(71200400001)(71190400001)(6246003)(4326008)(74316002)(11346002)(446003)(53936002)(6636002)(102836004)(25786009)(26005)(5660300002)(81166006)(6436002)(33656002)(64756008)(186003)(66446008)(66556008)(73956011)(2906002)(478600001)(14454004)(8936002)(66946007)(66476007)(76116006)(99286004)(86362001)(256004)(54906003)(7736002)(305945005)(7696005)(8676002)(81156014)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0501MB2863;H:VI1PR0501MB2271.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zUF+70r/7ffwpmINPND/CfmjERSDANrORLV1FcaL5uWCQa/LXyL8W9whIxVBjewyCWUxW2VEYK2ijCfPw/oOCn4BFdN3JpTCCzm1jGfurQxMPkhnd4JRnwR6ZPnnslvY+9pFezf2SlHuAoPpq4loygOsCm/OJsB/ULR+Ip7K92P9Rfe1+JMMDQXqyqji1LY8o6qvEvSF4kjY7vs+EnGilQoPqMaSwlw7tqIIa91I5vidZqb6M0Tdw1vqpwcEkxtaj6EucMv5rzv++QvEu5W+jupkO50y8snanSr9qT4yUKIHBsVzxcddrl/n0ZlR5xvSDdhWuo5D3mkiYx0PgV0YzDZ4ncjs14ILBcV6oC1BOWQ0B+SqiMhcDQ1oqbWxmsZAcabVccq7Kc5S0b2O8dCfnfRlkjixjzda9rJioxXR4Ko=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95150f84-f102-46ac-54c9-08d6cea08a11
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2019 01:50:22.5103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2863
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Leon,

> -----Original Message-----
> From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> owner@vger.kernel.org> On Behalf Of Leon Romanovsky
> Sent: Wednesday, May 1, 2019 12:31 PM
> To: Jason Gunthorpe <jgg@mellanox.com>
> Cc: Doug Ledford <dledford@redhat.com>; RDMA mailing list <linux-
> rdma@vger.kernel.org>
> Subject: Re: [PATCH rdma-next] RDMA/device: Don't fire uevent before
> device is fully initialized
>=20
> On Wed, May 01, 2019 at 01:28:55PM +0000, Jason Gunthorpe wrote:
> > On Wed, May 01, 2019 at 08:46:19AM +0300, Leon Romanovsky wrote:
> > > From: Leon Romanovsky <leonro@mellanox.com>
> > >
> > > When the refcount is 0 the device is invisible to netlink. However
> > > in the patch below the refcount =3D 1 was moved to after the device_a=
dd().
> > > This creates a race where userspace can issue a netlink query after
> > > the
> > > device_add() event and not see the device as visible.
> > >
> > > Ensure that no uevent is fired before device is fully registered.
> > >
> > > Fixes: d79af7242bb2 ("RDMA/device: Expose ib_device_try_get(()")
> > > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > > drivers/infiniband/core/device.c | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > >
> > > diff --git a/drivers/infiniband/core/device.c
> > > b/drivers/infiniband/core/device.c
> > > index 8ae4906a60e7..4cdc8588df7f 100644
> > > +++ b/drivers/infiniband/core/device.c
> > > @@ -808,6 +808,7 @@ static int add_one_compat_dev(struct ib_device
> *device,
> > >  	cdev->dev.release =3D compatdev_release;
> > >  	dev_set_name(&cdev->dev, "%s", dev_name(&device->dev));
> > >
> > > +	dev_set_uevent_suppress(&device->dev, true);
> > >  	ret =3D device_add(&cdev->dev);
> > >  	if (ret)
> > >  		goto add_err;
> >
> > compat devices definitely should not be doing this..
>=20
> Why? They have the same problematic pattern:
>  device_add -> ..... -> enable_device.
>=20
compat devices are added in enable_device_and_get() after refcount is set.
ib_register_device()
   enable_device_and_get()
       refcount=3D2
       [...]
       add_compat_devs()
