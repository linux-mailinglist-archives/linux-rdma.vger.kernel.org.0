Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2A26164FBF
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2020 21:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgBSUW3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Feb 2020 15:22:29 -0500
Received: from mail-am6eur05on2087.outbound.protection.outlook.com ([40.107.22.87]:38976
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726645AbgBSUW3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 Feb 2020 15:22:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hc9w1Rz5/pPKfukxlOasb1N5VC0k8zVU4/2YGmSzgzB89V7ILXT0wet/v7XaLjAyj7g2wQ399XTXUhJp5OgytEPutoWxFc/Bbh649ace1TXSuDZr13Pzb2eVYAi91qetZ8/GIZ2ajWerw6SxfXl0G/VtXaVgNwlyGdfRMhTkOjIXdcEfVGQrc6fxslcq96EPe5A9AeHoHESLy5cipH8eVHhPCyGaNKYYwDfF2HGtJnJNfxjwcaviJO6yo35BJSIQsi1KRP3+YMZaiH4rApnFtZvsZkzzDyG7fx9IC0F4gn5hSlJ+grpl1c9tSkPSOur/5jkqth3EsZ6W5a5gRNXRXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CK2weh+ZYJm1WPA+x8feDc8g+4tHDAKRtaICxOf/4Po=;
 b=EvimZlSdAKF5K+E0MtiyPsKT9o7wo1UXr9dZ+FzI4/WvqYCjXYGFy/XxTby4pv+9Czm2dZRCnlYRoLcSJunPvRGvaGrIDOyPFmkVSDYmIsCv27xFlGyY7j3Ahjt6t3tojDxN7wSKZFlfJl73JG2nCZgVFeczto2C/4QY5DqaXTjq9eB7mHmb8AVWvni5ZgBKpF242zxby9XTerjLmCwsDL34zlPYQQcJsv3apuEAuxiWYx0JJw8aDjnXWGheDCmzaZhNO7FveqCXhrZMpXQ2MNEiSjtXpT3SOhKsKAI9aMOVNSaF0C9KV/mT7cRQaH7N33BlPSpNLO/7LtAtnw5Kpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CK2weh+ZYJm1WPA+x8feDc8g+4tHDAKRtaICxOf/4Po=;
 b=OfIfupgVDSpppGBifHUqTbopzdKLH9evjq0Duv2dQi/SONNOPprBQ4tfTGM8AJsMVxsyMwvyoXst85rXH38zXXHVCoimC5ebfH9WThXu6M8qmWZ1WH8F5D2JoQgFlTXe7IoSgWB2PHRZv4IAb6RPHCKMc8u70ROSY6SFWYp+ol8=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB5422.eurprd05.prod.outlook.com (20.177.202.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Wed, 19 Feb 2020 20:22:26 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d%7]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 20:22:26 +0000
Received: from mlx.ziepe.ca (142.68.57.212) by BL0PR02CA0066.namprd02.prod.outlook.com (2603:10b6:207:3d::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend Transport; Wed, 19 Feb 2020 20:22:25 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1j4VrR-0006wg-OZ; Wed, 19 Feb 2020 16:22:21 -0400
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Eric Biggers <ebiggers@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] RDMA/ucma: Put a lock around every call to the rdma_cm
 layer
Thread-Topic: [PATCH] RDMA/ucma: Put a lock around every call to the rdma_cm
 layer
Thread-Index: AQHV5p8H4E9FGayyZkeKKgj/ShDofqgiCFuAgADu+oA=
Date:   Wed, 19 Feb 2020 20:22:25 +0000
Message-ID: <20200219202221.GN23930@mellanox.com>
References: <20200218210432.GA31966@ziepe.ca>
 <20200219060701.GG1075@sol.localdomain>
In-Reply-To: <20200219060701.GG1075@sol.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR02CA0066.namprd02.prod.outlook.com
 (2603:10b6:207:3d::43) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.68.57.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d9459092-9689-4ef8-f739-08d7b5796f38
x-ms-traffictypediagnostic: VI1PR05MB5422:
x-microsoft-antispam-prvs: <VI1PR05MB5422C2D498FF1EEBF927BD9FCF100@VI1PR05MB5422.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0318501FAE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(199004)(189003)(6916009)(26005)(36756003)(9786002)(9746002)(71200400001)(2906002)(1076003)(478600001)(8676002)(64756008)(66476007)(52116002)(186003)(4326008)(66946007)(81156014)(33656002)(86362001)(81166006)(8936002)(5660300002)(66556008)(2616005)(66446008)(316002)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5422;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wi5QHxzB4cLIU7W2xv1JsbfyRazy3WLuIDcaGTlwYWbyOKqgc0/PxRXSyyZSuVuFF9ruckHxGVX1dfSZ3u9LQWeTwPbW6IIMM9UOz3YdPFFk4VON5j/B01LTrfjwhNiCBBnZuB8QPi6HVYKectsbh1NnbHBoinutpqRMUxYSEoXzDmHgeyomQurhmGXALZSYHO3uQtXK2a2myIv94fSuq/NApcvjwgEfnueua6ZKBLX1wnf9fpX44l0auMl+d2Z9a/n53HuzpyLOsVwYIBt8SBalLCbuwlWfVrGFLMJnEHKe0BLSpygLOrLC650YI8AaVwM0Dy6fTn9eUrnk6NV/nEjmWC+oyZbuzThukleinZOKE5RZ2xbRq6Wlx57L/Q8AuwrEzJFkwQteI1op+FAHLOneA7Om4uMsvvFifeu4ZLbDyRMgRL8Ajph/SIDryqy8KQ/1UfRVXIE2HZwAiXTFxOgSdwwtRKcSr6RZlsWgvCUVNHskuacVOZ45++6MFz2/
x-ms-exchange-antispam-messagedata: cABqOdsGiSsRBVtFmYeV4qgDwgY/oSuRg2uBoAE4Ilq2QbS9TE2LuYJqef+4+LOb9kQQS0hvb7lVJvKzam9Hu6ft5SCBy3jMclfg4gkkf36S1zaqg2zwbWAeHKBrOPYLtOJPqa/eRUH8Mas3wZNt8w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <92FEEAA06080EB479C507B41AAA4EB9B@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9459092-9689-4ef8-f739-08d7b5796f38
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2020 20:22:26.0067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 060esr97cR7mvDyDZZcu3ivBurDazTfcNs7TCLzN5l5APRfDk2PQhDNMN3OHXML2UmkOiIkoKBuS/SZjLacVzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5422
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 18, 2020 at 10:07:01PM -0800, Eric Biggers wrote:
> > these 11 lets include them as  well. I wasn't able to find a way to
> > search for things, this list is from your past email, thanks.
> >=20
>=20
> Unfortunately I haven't had time to work on syzkaller bugs lately, so I c=
an't
> provide an updated list until I go through the long backlog of bugs.

Ok

> A comment on the patch below:
>=20
> > @@ -1112,13 +1134,17 @@ static ssize_t ucma_accept(struct ucma_file *fi=
le, const char __user *inbuf,
> >  	if (cmd.conn_param.valid) {
> >  		ucma_copy_conn_param(ctx->cm_id, &conn_param, &cmd.conn_param);
> >  		mutex_lock(&file->mut);
> > +		mutex_lock(&ctx->mutex);
> >  		ret =3D __rdma_accept(ctx->cm_id, &conn_param, NULL);
> > +		mutex_unlock(&ctx->mutex);
> >  		if (!ret)
> >  			ctx->uid =3D cmd.uid;
> >  		mutex_unlock(&file->mut);
>=20
> This is nesting the new ucma_context::mutex inside the existing ucma_file=
::mut.

Ah, indeed
=20
> > @@ -1403,6 +1443,7 @@ static ssize_t ucma_process_join(struct ucma_file=
 *file,
> >  	if (IS_ERR(ctx))
> >  		return PTR_ERR(ctx);
> > =20
> > +	mutex_lock(&ctx->mutex);
> >  	mutex_lock(&file->mut);
> >  	mc =3D ucma_alloc_multicast(ctx);
> >  	if (!mc) {
>=20
> ... but this is doing the opposite.  So it can deadlock.

Lets narrow this one to just rdma_join_multicast(), looks safe

> What's the intended order?

The code works better if mut is the exterior lock, it seems
=20
> Also, are these two separate mutexes actually needed?  I.e., did you cons=
ider
> using the existing ucma_file::mut, but it didn't work or it wasn't fine-g=
rained
> enough?  (It looks like one ucma_file can have multiple ucma_contexts.)

It would probably work, but it is not as fine grained as a per-ctx
lock, and some people do care about performance with this stuff.

The file->mut is protecting some global per-fd lists it seems.

Thanks,
Jason
