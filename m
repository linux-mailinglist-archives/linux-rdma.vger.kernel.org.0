Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 964BB5E76D
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jul 2019 17:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfGCPIr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Jul 2019 11:08:47 -0400
Received: from mail-eopbgr80049.outbound.protection.outlook.com ([40.107.8.49]:40421
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725944AbfGCPIr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 3 Jul 2019 11:08:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4A4a5FfKWFEl4y6HvDegBvo5QJ9gJlXgx2xduCl6h5Y=;
 b=kY+5iWQbbxLWKp0tqgTmPpt5tRxyIus3ZsKPmVmcLnNrHuDGgMxv59SizeIQiBH0IMeZnOsv/DMoILISYgrqKUs5+ckpiveRZvQjG10Esz6Usy5KLwc+ji4a7aTaWiLSsClhhx0Jeza5fSBi6Q7x+98dp/cSTYBF5fUh7F3LDdI=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6351.eurprd05.prod.outlook.com (20.179.25.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Wed, 3 Jul 2019 15:08:41 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2032.019; Wed, 3 Jul 2019
 15:08:41 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     "Kuehling, Felix" <Felix.Kuehling@amd.com>
CC:     Christoph Hellwig <hch@lst.de>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [RFC] mm/hmm: pass mmu_notifier_range to
 sync_cpu_device_pagetables
Thread-Topic: [RFC] mm/hmm: pass mmu_notifier_range to
 sync_cpu_device_pagetables
Thread-Index: AQHVHY87cnj6rYaF00uB6DOqwK5J5aa35HaAgAAxJwCAAALKgIAAOioAgADUsAA=
Date:   Wed, 3 Jul 2019 15:08:41 +0000
Message-ID: <20190703150836.GM18688@mellanox.com>
References: <20190608001452.7922-1-rcampbell@nvidia.com>
 <20190702195317.GT31718@mellanox.com> <20190702224912.GA24043@lst.de>
 <20190702225911.GA11833@mellanox.com>
 <1dc82dc8-3e6f-1d6f-b14d-41ae3c1b2709@amd.com>
In-Reply-To: <1dc82dc8-3e6f-1d6f-b14d-41ae3c1b2709@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTOPR0101CA0030.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::43) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b5b764d1-dc0d-4af0-1bf8-08d6ffc85584
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB6351;
x-ms-traffictypediagnostic: VI1PR05MB6351:
x-microsoft-antispam-prvs: <VI1PR05MB635194713022BC0BC06D7F16CFFB0@VI1PR05MB6351.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 00872B689F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(189003)(199004)(386003)(6506007)(25786009)(7416002)(53546011)(316002)(8936002)(26005)(68736007)(76176011)(102836004)(486006)(476003)(2616005)(186003)(5660300002)(14454004)(66476007)(2906002)(4326008)(11346002)(6116002)(3846002)(54906003)(99286004)(52116002)(36756003)(33656002)(7736002)(66446008)(1076003)(8676002)(14444005)(6246003)(64756008)(256004)(86362001)(305945005)(478600001)(53936002)(66946007)(81166006)(71200400001)(66556008)(73956011)(6512007)(6486002)(71190400001)(229853002)(6436002)(81156014)(446003)(6916009)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6351;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: td0S6w4mHfCpfIiwq60twZyFZcsKDyypieDB8FahsjvXOncVtvZwm1IzVFYnIeWYVhnUUAhoGNboHpppDK4NYN5sWo4WY0k/RfzbuXciuXnTm8teFPegBZQJfPq+aA0UM74aKEgAKeaYbx1/PlikKwR5rgu+ZikULKOirR2H5ibffF0p2vSXVQS8TcqW8WkduqizhaS7qXX7A7WAlhuyWd/yHocH7Fj1OEXkuiriDidvL48WjKUejgR4i6pgsmZ6jfTWrQRiKg4rQmb3Lx8vp8pq/bspE06qzMZRGUC2uioevyKu4VPCpryhTmGFrbNzaZ2Me/Si1l4i8Mww5JqYxD7VH/9jCuUR0cFU3MjxKccrFIXn/pmb5o67h3BY3dcId0vINr7DiRUk9a6bhCj9xECu4ASFEntY23RP+eLFvZE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5850BAD4694CCA479493175E5B4779A2@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5b764d1-dc0d-4af0-1bf8-08d6ffc85584
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2019 15:08:41.6325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6351
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 03, 2019 at 02:27:22AM +0000, Kuehling, Felix wrote:
> On 2019-07-02 6:59 p.m., Jason Gunthorpe wrote:
> > On Wed, Jul 03, 2019 at 12:49:12AM +0200, Christoph Hellwig wrote:
> >> On Tue, Jul 02, 2019 at 07:53:23PM +0000, Jason Gunthorpe wrote:
> >>>> I'm sending this out now since we are updating many of the HMM APIs
> >>>> and I think it will be useful.
> >>> This make so much sense, I'd like to apply this in hmm.git, is there
> >>> any objection?
> >> As this creates a somewhat hairy conflict for amdgpu, wouldn't it be
> >> a better idea to wait a bit and apply it first thing for next merge
> >> window?
> > My thinking is that AMD GPU already has a monster conflict from this:
> >
> >   int hmm_range_register(struct hmm_range *range,
> > -                      struct mm_struct *mm,
> > +                      struct hmm_mirror *mirror,
> >                         unsigned long start,
> >                         unsigned long end,
> >                         unsigned page_shift);
> >
> > So, depending on how that is resolved we might want to do both API
> > changes at once.
>=20
> I just sent out a fix for the hmm_mirror API change.

I think if you follow my suggestion to apply a prep patch to AMD GPU
to make the conflict resolution simple, we should defer this patch
until next kernel for the reasons CH gave.

> > Or we may have to revert the above change at this late date.
> >
> > Waiting for AMDGPU team to discuss what process they want to use.
>=20
> Yeah, I'm wondering what the process is myself. With HMM and driver=20
> development happening on different branches these kinds of API changes=20
> are painful. There seems to be a built-in assumption in the current=20
> process, that code flows mostly in one direction amd-staging-drm-next ->=
=20
> drm-next -> linux-next -> linux. That assumption is broken with HMM code=
=20
> evolving rapidly in both amdgpu and mm.

It looks to me like AMD GPU uses a pull request model. So a goal as a
tree runner should be to work with the other trees (ie hmm.git, etc)
to minimize conflicts between the PR you will send and the PR other
trees will send.

Do not focus on linux-next, that is just an 'early warning system'
that conflicts are on the horizon, we knew about this one :) (well,
mostly, I was surprised how big it was, my bad)

So we must stay in co-ordination with patches in-flight on the list
and make the right decision, depending on the situation. Communication
here is key :)

We have lots of strategies available to deal with these situations.

> If we want to continue developing HMM driver changes in
> amd-staging-drm-next, we'll need to synchronize with hmm.git more=20
> frequently, both ways.

It can't really go both ways. hmm.git has to be only the hmm topic,
otherwise it doesn't really work.

> I believe part of the problem is, that there is a fairly long
> lead-time from getting changes from amd-staging-drm-next into
> linux-next, as they are held for one release cycle in drm-next.
> Pushing HMM-related changes through drm-fixes may offer a kind of
> shortcut. Philip and my latest fixup is just bypassing drm-next
> completely and going straight into linux-next, though.

I'm not so familiar with the DRM work flow to give you advice on this.

Jason
