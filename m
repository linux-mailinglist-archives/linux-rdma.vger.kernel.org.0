Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9910F5866
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Nov 2019 21:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389041AbfKHUTM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Nov 2019 15:19:12 -0500
Received: from mail-eopbgr30045.outbound.protection.outlook.com ([40.107.3.45]:52192
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388402AbfKHUTL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 8 Nov 2019 15:19:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Shdek16O9havtmmpIcPaNy0nMjZfNtQaHnmv+kvg/zzjzztNUaGgl1VsRdeq/KNBNTQRjBr818Vd0dP8mO2p23Czwmoo86E9VJKjBC6jj+vKWn8LHRsWTwugeQWpl1xb3iHxxo2MIWB0vdSOGvZ1aqZAykHdr8EJxzIfJ4W1aZ1cEj+fvIF8eqcML0FNRiDLHFexCl1xB4epfXyAxP/S8LMXsvQDMNomOFf7HSnZetVx5IyqNl3y8SpGzLip+8746qOCx3x8/MmkzDN+dd6SKbr4VQwJSr73+rx9oVXLFpsJHMd/K1umckOcmuNOiUkp8q4qo5bC3BtM0KhxUDbapA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXu1ftVqG84gk5mWA7L5dB+kOrKG7FI6r7w4CIV8Itk=;
 b=MGYWJDnlvTn0sIKQR+dsdqrnUNFRANEz4K7x0IqHSOPhf0oO2BIskWi1K/FHugxhKZMZR8BZTw+PIKMIMZ1ph5fYYl83tsMlwgr02LOXo7ozU+Pp8AFFR+jt68kCxMDgJcynDz3UWahoCwMj8yoJf/KwUrOjCxj5BvhzOTppaNaKgl9dyZX6HiQnTDxL/fbc8hGHGuBRFJUoh+tQSQcbUf7ayrD4YV9y3KmiZLfdu/sYRjCWqAp0JeGrxZxkVPB4kzM+N3flwJBHMyGs74zdGxj1B+zgK6m+9/NMVTVX3RyGNWZCA/RVKx6QnLCulYXhQa+8/511dbtaepYVLnHr3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXu1ftVqG84gk5mWA7L5dB+kOrKG7FI6r7w4CIV8Itk=;
 b=ejgWWnujEWLXP8SwiCcM0J9Vwypgncc+gaz/AMmBR4H+8/wWlaLJF03Oxp1iRjfzGDFTxyJOr0bcCHxxNrWp2GOZfF5+tR35fgI0GE0lN77VapkhH6kfHskDINvWNALckCrkexkVSMMYb98nDgQHbecF4TCECeoQ80PZfWGP7H0=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB5215.eurprd05.prod.outlook.com (20.178.9.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Fri, 8 Nov 2019 20:19:06 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d%5]) with mapi id 15.20.2430.023; Fri, 8 Nov 2019
 20:19:06 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Jerome Glisse <jglisse@redhat.com>
CC:     John Hubbard <jhubbard@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        =?iso-8859-1?Q?Christian_K=F6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Juergen Gross <jgross@suse.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Petr Cvek <petrcvekcz@gmail.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Christoph Hellwig <hch@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v2 02/15] mm/mmu_notifier: add an interval tree notifier
Thread-Topic: [PATCH v2 02/15] mm/mmu_notifier: add an interval tree notifier
Thread-Index: AQHVjcvJYOye0EiwZkisYK74G5bmhqd+54eAgAAdRYCAAS6QAIAADtYAgAA6K4CAABioAIABMugA
Date:   Fri, 8 Nov 2019 20:19:06 +0000
Message-ID: <20191108201902.GM21728@mellanox.com>
References: <20191028201032.6352-1-jgg@ziepe.ca>
 <20191028201032.6352-3-jgg@ziepe.ca>
 <35c2b322-004e-0e18-87e4-1920dc71bfd5@nvidia.com>
 <20191107020807.GA747656@redhat.com> <20191107201102.GC21728@mellanox.com>
 <20191107210408.GA4716@redhat.com> <20191108003219.GD21728@mellanox.com>
 <20191108020034.GA470884@redhat.com>
In-Reply-To: <20191108020034.GA470884@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR17CA0042.namprd17.prod.outlook.com
 (2603:10b6:405:75::31) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b986b512-2b45-41d3-b746-08d76488e780
x-ms-traffictypediagnostic: VI1PR05MB5215:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR05MB5215A383E16B61C1949A18AFCF7B0@VI1PR05MB5215.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0215D7173F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(199004)(189003)(316002)(99286004)(386003)(486006)(305945005)(66446008)(7736002)(229853002)(2616005)(71200400001)(6246003)(71190400001)(86362001)(476003)(6506007)(102836004)(26005)(1076003)(6436002)(66556008)(7416002)(76176011)(64756008)(66946007)(6916009)(446003)(6512007)(6306002)(54906003)(186003)(5660300002)(14444005)(256004)(11346002)(52116002)(6486002)(66476007)(6116002)(81156014)(81166006)(25786009)(8676002)(33656002)(4326008)(66066001)(36756003)(3846002)(2906002)(478600001)(8936002)(966005)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5215;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: deARcU8CVWe9irQLX8J1FwM7UgKWuCcJuxHyyVmGNZwHSq7P575eWWnZVkV/JtA7nzbny3mhni67QSL5gFP9LUS0WgE/FQiVk+qXiL9GI52Jrui8uS9mMQgyu9iXRiqGi/HhSL7kuAd+QP3xYNI1HmLMD6ZC/BTWar4l9Ob2Q8pVojuwvk1d0DbD9HiRnKNUHwqaouBstOWCBYjxoQuBQtC4nzmswKIrFIM1dXStrjFtpNzZTU1zwQwlg5gqDNA7EOLyX19cclPKL5IvLOfgr8NISyDtqPNJgS4fw69ym6ql+bmRM6Yt1Cx9WiAZTxmfKQV79m1HirPVTdBLrIzZafXeyDjLg1Cj+yJ9bQeNsMynCjtPTzhCHHFD9sjznCw7R3UQFCeyZp4Bf8STfOuT70HlwYk5O1iKB101C0xkaOdP1DMhKdbvXJuKGDO5Bs5chT65xcMj2J89t1mdhvzsk0Y/RXQrznwk1X90hs4srjg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <4A274D8A173AC34180928F1E00490803@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b986b512-2b45-41d3-b746-08d76488e780
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2019 20:19:06.0725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8CdqcksxZm0V0FsWFGI1qc0P7nV5ILTdo+MvFOiFbnxSrDdSkJm+yyhgv9ItjaUuzBBxRkxXIQTO3pxa5dmtNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5215
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 07, 2019 at 09:00:34PM -0500, Jerome Glisse wrote:
> On Fri, Nov 08, 2019 at 12:32:25AM +0000, Jason Gunthorpe wrote:
> > On Thu, Nov 07, 2019 at 04:04:08PM -0500, Jerome Glisse wrote:
> > > On Thu, Nov 07, 2019 at 08:11:06PM +0000, Jason Gunthorpe wrote:
> > > > On Wed, Nov 06, 2019 at 09:08:07PM -0500, Jerome Glisse wrote:
> > > >=20
> > > > > >=20
> > > > > > Extra credit: IMHO, this clearly deserves to all be in a new mm=
u_range_notifier.h
> > > > > > header file, but I know that's extra work. Maybe later as a fol=
low-up patch,
> > > > > > if anyone has the time.
> > > > >=20
> > > > > The range notifier should get the event too, it would be a waste,=
 i think it is
> > > > > an oversight here. The release event is fine so NAK to you separa=
te event. Event
> > > > > is really an helper for notifier i had a set of patch for nouveau=
 to leverage
> > > > > this i need to resucite them. So no need to split thing, i would =
just forward
> > > > > the event ie add event to mmu_range_notifier_ops.invalidate() i f=
ailed to catch
> > > > > that in v1 sorry.
> > > >=20
> > > > I think what you mean is already done?
> > > >=20
> > > > struct mmu_range_notifier_ops {
> > > > 	bool (*invalidate)(struct mmu_range_notifier *mrn,
> > > > 			   const struct mmu_notifier_range *range,
> > > > 			   unsigned long cur_seq);
> > >=20
> > > Yes it is sorry, i got confuse with mmu_range_notifier and mmu_notifi=
er_range :)
> > > It is almost a palyndrome structure ;)
> >=20
> > Lets change the name then, this is clearly not working. I'll reflow
> > everything tomorrow
>=20
> Semantic patch to do that run from your linux kernel directory with your =
patch
> applied (you can run it one patch after the other and the git commit -a -=
-fixup HEAD)
>=20
> spatch --sp-file name-of-the-file-below --dir . --all-includes --in-place
>=20
> %< ------------------------------------------------------------------
> @@
> @@
> struct
> -mmu_range_notifier
> +mmu_interval_notifier
>=20
> @@
> @@
> struct
> -mmu_range_notifier
> +mmu_interval_notifier
> {...};
>=20
> // Change mrn name to mmu_in
> @@
> struct mmu_interval_notifier *mrn;
> @@
> -mrn
> +mmu_in
>=20
> @@
> identifier fn;
> @@
> fn(...,=20
> -struct mmu_interval_notifier *mrn,
> +struct mmu_interval_notifier *mmu_in,
> ...) {...}
>=20
> You need coccinelle (which provides spatch). It is untested but it should=
 work
> also i could not come up with a nice name to update mrn as min is way too
> confusing. If you have better name feel free to use it.

I used 'mni' as we already use 'mn' to refer to the notifier, and
'mmu_in' looks like some input parameter or something

It mostly worked, lots of comments to fix manually though:

https://github.com/jgunthorpe/linux/commits/mmu_notifier

Thanks,
Jason
