Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 472717DFFC
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2019 18:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731915AbfHAQVB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Aug 2019 12:21:01 -0400
Received: from mail-eopbgr130078.outbound.protection.outlook.com ([40.107.13.78]:21893
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731933AbfHAQVA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 1 Aug 2019 12:21:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ItO562Z9G9Nqs9oYS/GSymTZn8E0xKp075xbCAZJBRNghjSkm26rEZq8eoYda/Z2kAaowmeU7ojtIRagt8zhl27hyMg46vqhrYpk1z2rc84X38piXI+jQSqgEkyS5h8sNdQfeYSxWhSlX/EceWjI/DwUJ8a9pmjBp5F/TH7tSCcPgQMOkZMmcBN/rtviGH77/HPuTaaH9YxcHDS/hIJKBmSOKKmrUQ8QhK9ApNfy1MoPrRpK+RI1GSa6k3UAezTTCtq553KmYpuNxmGgn9JKTqhGGb5NlQM7YCpxWTzLURwgAYTgPQxyp2fTgM4OfI7AAsvVBjfKRXHlQ1mX5wKN2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7lnPmEGy9Ib43H3wF6ziPmssjjcA8X0ORbtQwkLWdc=;
 b=bUG1ariU2FDXLOTpxehYsus3CauXKg7Ik/GAvtMm2N1w0IytfrvIvetBmCnOfLW+92McJ87U6wPsrgFys1W97Mb6yde+UrWwA8s0dZE/ofBTlwMkeZa9+AfdiTYn+99NVG5fynKqzF4bNWNoySpdKdxXckvl6euojRzsWEkqG0laODmrSvbJZ/8L+sbHEiN5SyfUNL8zOJvrvTMRuoXr+FcswUTAXn9Y7kyValG7fvaAjUJqa+joQqC/9Aie0Pq5AI78TXu3AH0R6bU/Vx3DkZdYHxkwZ0ZtqGLS+vhl7//gkF2vCRGeNZaADo3aU6mPKuO7Cf50P0R1Ep3tqpOlFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=mellanox.com;dmarc=pass action=none
 header.from=mellanox.com;dkim=pass header.d=mellanox.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7lnPmEGy9Ib43H3wF6ziPmssjjcA8X0ORbtQwkLWdc=;
 b=osvlvraFIoyBDX98XGsgGbRO+BphMC5ACESZm6kLzmVrswsRqHwx2czOr8UWgM+nx5tMdBI3S8MnW3J5P95VBYrOb289W0eqdet6E/ZYIFLszaGhMFCnunSg7RWT1XwL8Qr7SSPX/6qfxFW+YGkq+bQ97YQhLX6p2wSGVlUlVKQ=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4925.eurprd05.prod.outlook.com (20.177.51.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.17; Thu, 1 Aug 2019 16:20:13 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880%4]) with mapi id 15.20.2136.010; Thu, 1 Aug 2019
 16:20:13 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Doug Ledford <dledford@redhat.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Release locks during notifier
 unregister
Thread-Topic: [PATCH rdma-rc] RDMA/mlx5: Release locks during notifier
 unregister
Thread-Index: AQHVR3tn3qv1PGIyNEiC/uXBUZXM9qbk6WYAgAAKq4CAAAJ3AIAAA3+AgAAK8ACAAB/ZgIAA0jqAgAA7UYCAAAJNgIAAI8aAgAAcugCAAANkAIAAAnUA
Date:   Thu, 1 Aug 2019 16:20:13 +0000
Message-ID: <20190801162008.GF23885@mellanox.com>
References: <20190731170944.GC4832@mtr-leonro.mtl.com>
 <20190731172215.GJ22677@mellanox.com>
 <20190731180124.GE4832@mtr-leonro.mtl.com>
 <20190731195523.GK22677@mellanox.com>
 <20190801082749.GH4832@mtr-leonro.mtl.com>
 <20190801120007.GB23885@mellanox.com>
 <20190801120821.GK4832@mtr-leonro.mtl.com>
 <060b3e8fbe48312e9af33b88ba7ba62a6b64b493.camel@redhat.com>
 <20190801155912.GS4832@mtr-leonro.mtl.com>
 <a0dc81b63fdef1b7e877d5172be13792dda763d2.camel@redhat.com>
In-Reply-To: <a0dc81b63fdef1b7e877d5172be13792dda763d2.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTOPR0101CA0052.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::29) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd530e74-ab3e-4c2e-fe1c-08d7169c21d6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4925;
x-ms-traffictypediagnostic: VI1PR05MB4925:
x-microsoft-antispam-prvs: <VI1PR05MB49259EDA084DC7F718959E2ACFDE0@VI1PR05MB4925.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01165471DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(346002)(39860400002)(366004)(136003)(199004)(189003)(81166006)(66476007)(66446008)(26005)(2616005)(25786009)(76176011)(6916009)(5660300002)(1076003)(36756003)(54906003)(66946007)(316002)(486006)(99286004)(476003)(186003)(68736007)(66556008)(66066001)(52116002)(229853002)(2906002)(33656002)(446003)(64756008)(11346002)(86362001)(6506007)(14454004)(53936002)(14444005)(6436002)(6246003)(386003)(71190400001)(3846002)(6486002)(305945005)(6116002)(71200400001)(81156014)(4326008)(256004)(8936002)(107886003)(7736002)(102836004)(8676002)(6512007)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4925;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 55NrSZUmHXLaFcrmKjvokqR89nO/vpwZx/RhU/TR6w/rLMQuoyqzbCKk8ZSr+0AIZlIbCum5tPxVA9bMEnxSuXEUeGKx/EdvLeqUCf8HCT1JbwACEU7o50MW/2UJZnjHynHy8vWrwwbCq+OjIpfWz2TS2tKI3KqJkZpE4+YT8m6WpEu8+2+EaIlQNcD6eI0WvFrRokJXSgXc33oJFzUqe3JjfM3RO5vAsN8h7n9b2syrRAPEL1Tz7ONvC7v+xa550Cjvk5oIcX1vLUJvXKB+teCkTxkv6g+1LAtPMD2pAJPorVGPrVktAPfb+r+lws4rjCgza8MFDGjqx32KT2BlTPdpwfWir4jedzqmptPqSC1Xxp/+4FkLYLulMaGbXVCnbB2dAdTQRzCeEW2arEdkiZvB7kU8qBraW+5KaCtvtRI=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D3F26372620A7B45BC3CE620434DA143@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd530e74-ab3e-4c2e-fe1c-08d7169c21d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2019 16:20:13.7669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4925
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 01, 2019 at 12:11:20PM -0400, Doug Ledford wrote:
> On Thu, 2019-08-01 at 18:59 +0300, Leon Romanovsky wrote:
> > > There's no need for a lockdep.  The removal of the notifier callback
> > > entry is re-entrant safe.  The core removal routines have their own
> > > spinlock they use to protect the actual notifier list.  If you call
> > > it
> > > more than once, the second and subsequent calls merely scan the
> > > list,
> > > find no matching entry, and return ENOENT.  The only reason this
> > > might
> > > need a lock and a lockdep entry is if you are protecting against a
> > > race
> > > with the *add* notifier code in the mlx5 driver specifically (the
> > > core
> > > add code won't have an issue, but since you only have a single place
> > > to
> > > store the notifier callback pointer, if it would be possible for you
> > > to
> > > add two callbacks and write over the first callback pointer with the
> > > second without removing the first, then you would leak a callback
> > > notifier in the core notifier list).
> >=20
> > atomic_notifier_chain_unregister() unconditionally calls to
> > syncronize_rcu() and I'm not so sure that it is best thing to do
> > for every port unbind.
> >=20
> > Actually, I'm completely lost here, we are all agree that the patch
> > fixes issue correctly, and it returns the code to be exactly as
> > it was before commit df097a278c75 ("IB/mlx5: Use the new mlx5 core
> > notifier
> > API"). Can we simply merge it and fix the kernel panic?
>=20
> As long as you are OK with me adding a comment to the patch so people
> coming back later won't scratch their head about how can it possible be
> right to do that sequence without a lock held, I'm fine merging the fix.
>=20
> Something like:
>=20
> /*
>  * The check/unregister/set-NULL sequence below does not need to be
>  * locked for correctness as it's only an optimization, and can't
>  * be under a lock or will throw a scheduling while atomic error.
>  */

It does have a lock though, the caller holds it, hence the request for
the lockdep.

Jason
