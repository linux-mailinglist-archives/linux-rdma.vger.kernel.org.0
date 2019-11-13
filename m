Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38EA1FB587
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Nov 2019 17:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbfKMQq3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Nov 2019 11:46:29 -0500
Received: from mail-eopbgr00040.outbound.protection.outlook.com ([40.107.0.40]:14318
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728425AbfKMQq3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 13 Nov 2019 11:46:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LuJF2uvmN2yaL2t/MMpryfHz60uTA8upKzuaipHG8RbgMaWw+Gtlrv18/ToPDpVQQgI4M+KhFDZo7a9+fs+kLRJlVUy8CUVWFf07Jztael147XMDA6z/E0MtItAVvwhhm3sU3mychIO1mStAr7By5eWrLmMXpYvYRZPR/vuIJVpf50LM/zSV4lZmLkTFhFCVekrqVwRbKq+651wBR8jrF9qUlg2c02q36e6o9Mv0VkKCA9tfmoMs2x3Ad/pODLiGryedfqtFAanCbF1GwERdYDBERcLmZJN7GJnSYjVGVmxvbhKtiRXzHR9YKQH15seRg/obiuQJ1rrT2zYVQWf/lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbnENZcVRebv/iFmPDxhhM2imQ94Y3I4TeLpbYNHeII=;
 b=beWKSZ4zAAubURVsbWfaGBNBT7wHp1KylNJv2A1muv67tJd8TuJCj6omMc8Ld1ZxAksm5lefla7g2qeDZyKGPE/TDcCIHIW5YXBpyKZf8nIp6A9bYw5jkBDClOOv5z9nJyL+fl4i76r1drQcUsQqfIBPPO6JeRHEn+qnH3QTy+m/1XywgxzXuO8on532fk3zZ3GxPnky8NZWETmgyEsLMP5RucD/EQFeFI8hlPltqcAezDv0XPyrC/OpV0qC2Sb/thseiWKg6gGG4JlOdzZ32zxJhGpQTvdp9YpaFNXJlFenYVMZDiQ9D3kSvibFCELsSUV7RQC7XQ6PuSw7zYs0SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbnENZcVRebv/iFmPDxhhM2imQ94Y3I4TeLpbYNHeII=;
 b=UFSPn3nd+XeIYwNtlI6SmptfxCR5JdXzaLc4wM0qUj++bzoPOZPpLu1Avejfnm8mvboDwjPhHlzCYMNIf7TzmzLzx8jioy3KYKl7I8NB8q9t5jWbJDArEO6zG/GAoxAnKpAvtq/07Eh/HMH3cE+XwBNHFTn4SylCNrswWagvx1Q=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB4624.eurprd05.prod.outlook.com (20.176.7.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.23; Wed, 13 Nov 2019 16:46:25 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d%5]) with mapi id 15.20.2430.027; Wed, 13 Nov 2019
 16:46:25 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
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
        Philip Yang <Philip.Yang@amd.com>
Subject: Re: [PATCH v3 02/14] mm/mmu_notifier: add an interval tree notifier
Thread-Topic: [PATCH v3 02/14] mm/mmu_notifier: add an interval tree notifier
Thread-Index: AQHVmZb2YQDWU76vNEuRDpxoc3xJraeJIg8AgAAugwA=
Date:   Wed, 13 Nov 2019 16:46:24 +0000
Message-ID: <20191113164620.GG21728@mellanox.com>
References: <20191112202231.3856-1-jgg@ziepe.ca>
 <20191112202231.3856-3-jgg@ziepe.ca> <20191113135952.GB20531@infradead.org>
In-Reply-To: <20191113135952.GB20531@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR1101CA0010.namprd11.prod.outlook.com
 (2603:10b6:405:4a::20) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 41a0e8c0-89bb-43c2-e281-08d76859054d
x-ms-traffictypediagnostic: VI1PR05MB4624:
x-microsoft-antispam-prvs: <VI1PR05MB462449384838F815B46902A2CF760@VI1PR05MB4624.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(189003)(199004)(446003)(11346002)(2616005)(476003)(66066001)(386003)(486006)(186003)(102836004)(52116002)(33656002)(26005)(6506007)(76176011)(6512007)(66476007)(66556008)(64756008)(66446008)(81156014)(81166006)(4326008)(71190400001)(6246003)(71200400001)(8936002)(66946007)(6116002)(14444005)(3846002)(256004)(2906002)(229853002)(6436002)(6486002)(8676002)(25786009)(6916009)(7736002)(1076003)(305945005)(5660300002)(7416002)(478600001)(54906003)(316002)(99286004)(36756003)(14454004)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4624;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rrpWD1R1BMlPUpSs+o9RwczVXIunSTF9I87HA2n6H0asbRnvCtGbH7kTNXevBRN5UXRJ85ed/CoUa/GkxIDmlsNhT8/BFwQT8jYOx1pKML7KkJ7QLjQv8YTSlg00PMtLDr30fBD+oXvZjM0yrB+WvYQnHyXNBQcL/kJoAlyara7/H4vXFEKsVAXZtI15ikeFnPSewk+Z3WCo7pOn6moAVerZX4dVpwCQsoqH+XXDYsRjNDfKm3nQaePLJhy7J1oAQwStWOSnrPOLFKa+YPaprzqrw2ScXhi6mURMYWS83Aqx2M4+lmXNY+iNO0ScH9di3IQFHPpHUe8+jPdL1yL0x3TnbIHPatYMCA4yG1OoLtfYl6SDqE/hwA7/SwskvoBnVJogZ1R2ehmz+lRkP8CQ0lqlWf0cb5RUJpxws9Xmwxdt3a5Wuv7JEyhIcVEORD5E
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <677ADF67690D0A479A50627A2BA23A42@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41a0e8c0-89bb-43c2-e281-08d76859054d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 16:46:25.0220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ba94nU8rdIiqv94wJYo3wuHzhbwYz4DidvxEUagXnQ7vuBLqWh3vACBpecSu/wnrY8ZWsrUyClgrItanutUhSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4624
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 13, 2019 at 05:59:52AM -0800, Christoph Hellwig wrote:
> > +int mmu_interval_notifier_insert(struct mmu_interval_notifier *mni,
> > +				      struct mm_struct *mm, unsigned long start,
> > +				      unsigned long length,
> > +				      const struct mmu_interval_notifier_ops *ops);
> > +int mmu_interval_notifier_insert_locked(
> > +	struct mmu_interval_notifier *mni, struct mm_struct *mm,
> > +	unsigned long start, unsigned long length,
> > +	const struct mmu_interval_notifier_ops *ops);
>=20
> Very inconsistent indentation between these two related functions.

clang-format.. The kernel config is set to prefer a line up under the
( if all the arguments will fit within the 80 cols otherwise it does a
1 tab continuation indent.

> > +	/*
> > +	 * The inv_end incorporates a deferred mechanism like
> > +	 * rtnl_unlock(). Adds and removes are queued until the final inv_end
> > +	 * happens then they are progressed. This arrangement for tree update=
s
> > +	 * is used to avoid using a blocking lock during
> > +	 * invalidate_range_start.
>=20
> Nitpick:  That comment can be condensed into one less line:

The rtnl_unlock can move up a line too. My editor is failing me on
this.

> > +	/*
> > +	 * TODO: Since we already have a spinlock above, this would be faster
> > +	 * as wake_up_q
> > +	 */
> > +	if (need_wake)
> > +		wake_up_all(&mmn_mm->wq);
>=20
> So why is this important enough for a TODO comment, but not important
> enough to do right away?

Lets drop the comment, I'm noto sure wake_up_q is even a function this
layer should be calling.
=20
> > +	 * release semantics on the initialization of the mmu_notifier_mm's
> > +         * contents are provided for unlocked readers.  acquire can on=
ly be
> > +         * used while holding the mmgrab or mmget, and is safe because=
 once
> > +         * created the mmu_notififer_mm is not freed until the mm is
> > +         * destroyed.  As above, users holding the mmap_sem or one of =
the
> > +         * mm_take_all_locks() do not need to use acquire semantics.
> >  	 */
>=20
> Some spaces instead of tabs here.

Got it

> > +static int __mmu_interval_notifier_insert(
> > +	struct mmu_interval_notifier *mni, struct mm_struct *mm,
> > +	struct mmu_notifier_mm *mmn_mm, unsigned long start,
> > +	unsigned long length, const struct mmu_interval_notifier_ops *ops)
>=20
> Odd indentation - we usuall do two tabs (my preference) or align after
> the opening brace.

This is one tab. I don't think one tab is odd, it seems pretty popular
even just in mm/.

But two tabs is considered usual? I didn't even know that.

> > + * This function must be paired with mmu_interval_notifier_insert(). I=
t cannot be
>=20
> line > 80 chars.

got it, was missed during the rename

> Otherwise this looks good and very similar to what I reviewed earlier:
>=20
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks a bunch, your comments have been very helpful on this series!

Jason
