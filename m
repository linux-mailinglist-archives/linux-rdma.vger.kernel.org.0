Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C231F3929
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Nov 2019 21:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbfKGUGS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Nov 2019 15:06:18 -0500
Received: from mail-eopbgr130089.outbound.protection.outlook.com ([40.107.13.89]:31087
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725823AbfKGUGS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 7 Nov 2019 15:06:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XbYR/uRivvAfvGKhO6vEH5IoVw52viT8SbTkxoUdnPU5seHSfhOvS2pOsgI7vWXVHIxG8+eaJw8xtq9dJW7R/kVLdusfK9tD6Z4kgQZnuTTEXDZQFXIjB0tFb5TuCVN8xGcmwE5gYYj67+hYV+TPwvT/qKIdL4J7iu0hGyxFT6XcFhlwOm2+vLj9VDpSJp9bT5bd+oYvfN4QmlI06xTqyqtMJ9Q4E9aTTmukC1nScZtQKYa53HybhzO92PBWCFLsD2kOHuBvrd4W5Ho5133vt1WwvIVANMNiiy1eFWh9EL156Ic4Vc2efxwulllFMoQSEe9fgXadBQ7uIV3Ta6Oh6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZLGtICPXHQeYMx3zwEUZ2kEBvqnlPF/xDCnKoeEU1Y=;
 b=FMGEdkApgkM+8CTxEC4sr0tb6phrZTIvf9VXG0mLTfnbMU6u7iAGzjR65ihQBvgTRsbnTmpr0l1EJ+766Buy7vse76t6FVgFElI8cNqi1KgKjIre76WBrjPWG8dbxsGPP9l5p9BtLEsAADhX6k7yWXA74vLtX7xxlapDkN7E+ki9U+QhAW2VDbIxzM1pdjn7NHa+iotezNzepsZ7bOjxNxgcxQPpeLQzL9IrCYEt33bWBvMGaSs6xJ6S5Rke8aUtmWlcl5Vm/lx46i5WIngLBE1iPeWTyrJN27c563sqvoXlqfRf79p7RVQ7wYMT+jW75ytqGn5ULIaP6aBzCD3yYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZLGtICPXHQeYMx3zwEUZ2kEBvqnlPF/xDCnKoeEU1Y=;
 b=jYDOc+HBZxt1WV25q8ShhQioI8qPveMDugD/wyFzOh+eQjHsx+PF5jCAKTLEC3m5Bi5ymyLIM96x9SqxS79eYhdiTQ76YSSclVoxJ/0Hfp3ckpgkI0G6Io5ZevRDAoiCEW8T8T7qjY9uIpY2bycj8Z8Hu+zqMI1gIvSB5AFl2y0=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB6653.eurprd05.prod.outlook.com (10.141.128.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Thu, 7 Nov 2019 20:06:09 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d%5]) with mapi id 15.20.2408.028; Thu, 7 Nov 2019
 20:06:09 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     John Hubbard <jhubbard@nvidia.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Jerome Glisse <jglisse@redhat.com>,
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
Thread-Index: AQHVjcvJYOye0EiwZkisYK74G5bmhqd+54eAgAFKcgA=
Date:   Thu, 7 Nov 2019 20:06:08 +0000
Message-ID: <20191107200604.GB21728@mellanox.com>
References: <20191028201032.6352-1-jgg@ziepe.ca>
 <20191028201032.6352-3-jgg@ziepe.ca>
 <35c2b322-004e-0e18-87e4-1920dc71bfd5@nvidia.com>
In-Reply-To: <35c2b322-004e-0e18-87e4-1920dc71bfd5@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR1501CA0002.namprd15.prod.outlook.com
 (2603:10b6:207:17::15) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 689fa69c-2ee1-4f94-10df-08d763bdedcc
x-ms-traffictypediagnostic: VI1PR05MB6653:
x-microsoft-antispam-prvs: <VI1PR05MB6653E71C85FA5307B0ED08F4CF780@VI1PR05MB6653.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39850400004)(136003)(396003)(366004)(376002)(199004)(189003)(476003)(1076003)(6916009)(71190400001)(486006)(71200400001)(305945005)(4326008)(7736002)(25786009)(30864003)(7416002)(446003)(6246003)(5660300002)(36756003)(186003)(81166006)(8676002)(256004)(14444005)(26005)(81156014)(386003)(102836004)(11346002)(33656002)(86362001)(2906002)(66946007)(76176011)(66446008)(478600001)(2616005)(99286004)(229853002)(66476007)(316002)(6116002)(6486002)(8936002)(6506007)(14454004)(6436002)(3846002)(52116002)(64756008)(66556008)(66066001)(6512007)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6653;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OhxIMxuIpy97a6eE8TxWtNSzY1GNivpNQHbZMy5HgAaLZV7EjFuJJFhhRC0eSEkk23Ucrn5O6/y8uDahQtqSzMgby5NIybxB6oNl3Tiy9YpQ/HGz6LjYfXGxr+iGWymZI46KuUjyOEW/Artb2IvH838mCDoq8r/svTaI9YTzMoGfguXhtoXCRR2ZOl4cPQW4zzQnaswTnKGwLrR9BdOni57n5G2KiYnbGGwYqSbn0Rs5er02tMs9PEHo7T/ry3vJoUO2MT6fwulWLcEBzzME2jiqevWPh/jL7N29Zz0Lfa7yO93RO3mb4XY7TTNSLSLcodhCWMlcIHdfW6qsnUZNPApRfktRwlTqrwII+xDEB2VTJvyQQRQ+APx9dokWh8wQ2QUibNnfvufJ6YYEtzs6Pk2B1CDbux6O3Qrw39NEUdcxxSykQOPIvJ+iZGKXilMy
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <6113418291CBA3499D9869CD0CC8D233@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 689fa69c-2ee1-4f94-10df-08d763bdedcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 20:06:09.1763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +TuBIUtrktnBKZ6NZvy1veC+LPb7Nd6ABDYqCTCaNtlIuaUguMa6aZ8NnTlNlDmfIufFo0WoiB5EsbzpMF64bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6653
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 06, 2019 at 04:23:21PM -0800, John Hubbard wrote:
=20
> Nice design, I love the seq foundation! So far, I'm not able to spot anyt=
hing
> actually wrong with the implementation, sorry about that.=20

Alas :( I feel there must be a bug in here still, but onwards!

One of the main sad points was it didn't make sense to use the
existing seqlock/seqcount primitives as they have both the wrong write
concurrancy model and extra barriers that are not needed when it is
always manipulated under a spinlock
=20
> 1. There is a rather severe naming overlap (not technically a naming conf=
lict,
> but still) with existing mmn work, which already has, for example:
>=20
>     struct mmu_notifier_range
>=20
> ...and you're adding:
>=20
>     struct mmu_range_notifier
>=20
> ...so I'll try to help sort that out.

Yes, I've been sad about this too.

> So this should read:
>=20
> enum mmu_range_notifier_event {
> 	MMU_NOTIFY_RELEASE,
> };
>=20
> ...assuming that we stay with "mmu_range_notifier" as a core name for thi=
s=20
> whole thing.
>=20
> Also, it is best moved down to be next to the new MNR structs, so that al=
l the
> MNR stuff is in one group.

I agree with Jerome, this enum is part of the 'struct
mmu_notifier_range' (ie the description of the invalidation) and it
doesn't really matter that only these new notifiers can be called with
this type, it is still part of the mmu_notifier_range.

The comment already says it only applies to the mmu_range_notifier
scheme..

> >  #define MMU_NOTIFIER_RANGE_BLOCKABLE (1 << 0)
> > @@ -222,6 +228,26 @@ struct mmu_notifier {
> >  	unsigned int users;
> >  };
> > =20
>=20
> That should also be moved down, next to the new structs.

Which this?

> > +/**
> > + * struct mmu_range_notifier_ops
> > + * @invalidate: Upon return the caller must stop using any SPTEs withi=
n this
> > + *              range, this function can sleep. Return false if blocki=
ng was
> > + *              required but range is non-blocking
> > + */
>=20
> How about this (I'm not sure I fully understand the return value, though)=
:
>=20
> /**
>  * struct mmu_range_notifier_ops
>  * @invalidate: Upon return the caller must stop using any SPTEs within t=
his
>  * 		range.
>  *
>  * 		This function is permitted to sleep.
>  *
>  *      	@Return: false if blocking was required, but @range is
>  *			non-blocking.
>  *
>  */

Is this kdoc format for function pointers?
=20
>=20
> > +struct mmu_range_notifier_ops {
> > +	bool (*invalidate)(struct mmu_range_notifier *mrn,
> > +			   const struct mmu_notifier_range *range,
> > +			   unsigned long cur_seq);
> > +};
> > +
> > +struct mmu_range_notifier {
> > +	struct interval_tree_node interval_tree;
> > +	const struct mmu_range_notifier_ops *ops;
> > +	struct hlist_node deferred_item;
> > +	unsigned long invalidate_seq;
> > +	struct mm_struct *mm;
> > +};
> > +
>=20
> Again, now we have the new struct mmu_range_notifier, and the old=20
> struct mmu_notifier_range, and it's not good.
>=20
> Ideas:
>=20
> a) Live with it.
>=20
> b) (Discarded, too many callers): rename old one. Nope.
>=20
> c) Rename new one. Ideas:
>=20
>     struct mmu_interval_notifier
>     struct mmu_range_intersection
>     ...other ideas?

This odd duality has already cause some confusion, but names here are
hard.  mmu_interval_notifier is the best alternative I've heard.

Changing this name is a lot of work - are we happy
'mmu_interval_notifier' is the right choice?

> > +/**
> > + * mmu_range_set_seq - Save the invalidation sequence
>=20
> How about:
>=20
>  * mmu_range_set_seq - Set the .invalidate_seq to a new value.

It is not a 'new value', it is a value that is provided to the
invalidate callback

>=20
> > + * @mrn - The mrn passed to invalidate
> > + * @cur_seq - The cur_seq passed to invalidate
> > + *
> > + * This must be called unconditionally from the invalidate callback of=
 a
> > + * struct mmu_range_notifier_ops under the same lock that is used to c=
all
> > + * mmu_range_read_retry(). It updates the sequence number for later us=
e by
> > + * mmu_range_read_retry().
> > + *
> > + * If the user does not call mmu_range_read_begin() or mmu_range_read_=
retry()
>=20
> nit: "caller" is better than "user", when referring to...well, callers. "=
user"=20
> most often refers to user space, whereas a call stack and function callin=
g is=20
> clearly what you're referring to here (and in other places, especially "u=
ser lock").

Done

> > +/**
> > + * mmu_range_check_retry - Test if a collision has occurred
> > + * mrn: The range under lock
> > + * seq: The return of the matching mmu_range_read_begin()
> > + *
> > + * This can be used in the critical section between mmu_range_read_beg=
in() and
> > + * mmu_range_read_retry().  A return of true indicates an invalidation=
 has
> > + * collided with this lock and a future mmu_range_read_retry() will re=
turn
> > + * true.
> > + *
> > + * False is not reliable and only suggests a collision has not happene=
d. It
>=20
> let's say "suggests that a collision *may* not have occurred." =20

Sure

> > +/*
> > + * This is a collision-retry read-side/write-side 'lock', a lot like a
> > + * seqcount, however this allows multiple write-sides to hold it at
> > + * once. Conceptually the write side is protecting the values of the P=
TEs in
> > + * this mm, such that PTES cannot be read into SPTEs while any writer =
exists.
>=20
> Just to be kind, can we say "SPTEs (shadow PTEs)", just this once? :)

Haha, sure, why not

> > + * The write side has two states, fully excluded:
> > + *  - mm->active_invalidate_ranges !=3D 0
> > + *  - mnn->invalidate_seq & 1 =3D=3D True
> > + *  - some range on the mm_struct is being invalidated
> > + *  - the itree is not allowed to change
> > + *
> > + * And partially excluded:
> > + *  - mm->active_invalidate_ranges !=3D 0
>=20
> I assume this implies mnn->invalidate_seq & 1 =3D=3D False in this case? =
If so,
> let's say so. I'm probably getting that wrong, too.

Yes that is right, done

>=20
> > + *  - some range on the mm_struct is being invalidated
> > + *  - the itree is allowed to change
> > + *
> > + * The later state avoids some expensive work on inv_end in the common=
 case of
> > + * no mrn monitoring the VA.
> > + */
> > +static bool mn_itree_is_invalidating(struct mmu_notifier_mm *mmn_mm)
> > +{
> > +	lockdep_assert_held(&mmn_mm->lock);
> > +	return mmn_mm->invalidate_seq & 1;
> > +}
> > +
> > +static struct mmu_range_notifier *
> > +mn_itree_inv_start_range(struct mmu_notifier_mm *mmn_mm,
> > +			 const struct mmu_notifier_range *range,
> > +			 unsigned long *seq)
> > +{
> > +	struct interval_tree_node *node;
> > +	struct mmu_range_notifier *res =3D NULL;
> > +
> > +	spin_lock(&mmn_mm->lock);
> > +	mmn_mm->active_invalidate_ranges++;
> > +	node =3D interval_tree_iter_first(&mmn_mm->itree, range->start,
> > +					range->end - 1);
> > +	if (node) {
> > +		mmn_mm->invalidate_seq |=3D 1;
>=20
>=20
> OK, this either needs more documentation and assertions, or a different
> approach. Because I see addition, subtraction, AND, OR and booleans
> all being applied to this field, and it's darn near hopeless to figure
> out whether or not it really is even or odd at the right times.

This is a standard design for a seqlock scheme and follows the
existing design of the linux seq lock.

The lower bit indicates the lock'd state and the upper bits indicate
the generation of the lock

The operations on the lock itself are then:
   seq |=3D 1  # Take the lock
   seq++     # Release an acquired lock
   seq & 1   # True if locked

Which is how this is written

> Different approach: why not just add a mmn_mm->is_invalidating=20
> member variable? It's not like you're short of space in that struct.

Splitting it makes alot of stuff more complex and unnatural.

The ops above could be put in inline wrappers, but they only occur
only in functions already called mn_itree_inv_start_range() and
mn_itree_inv_end() and mn_itree_is_invalidating().

There is the one 'take the lock' outlier in
__mmu_range_notifier_insert() though

> > +static void mn_itree_inv_end(struct mmu_notifier_mm *mmn_mm)
> > +{
> > +	struct mmu_range_notifier *mrn;
> > +	struct hlist_node *next;
> > +	bool need_wake =3D false;
> > +
> > +	spin_lock(&mmn_mm->lock);
> > +	if (--mmn_mm->active_invalidate_ranges ||
> > +	    !mn_itree_is_invalidating(mmn_mm)) {
> > +		spin_unlock(&mmn_mm->lock);
> > +		return;
> > +	}
> > +
> > +	mmn_mm->invalidate_seq++;
>=20
> Is this the right place for an assertion that this is now an even value?

Yes, but I'm reluctant to add such a runtime check on this fastish path..
How about a comment?

> > +	need_wake =3D true;
> > +
> > +	/*
> > +	 * The inv_end incorporates a deferred mechanism like
> > +	 * rtnl_lock(). Adds and removes are queued until the final inv_end
>=20
> Let me point out that rtnl_lock() itself is a one-liner that calls mutex_=
lock().
> But I suppose if one studies that file closely there is more. :)

Lets change that to rtnl_unlock() then

> > +	spin_lock(&mmn_mm->lock);
> > +	/* Pairs with the WRITE_ONCE in mmu_range_set_seq() */
> > +	seq =3D READ_ONCE(mrn->invalidate_seq);
> > +	is_invalidating =3D seq =3D=3D mmn_mm->invalidate_seq;
> > +	spin_unlock(&mmn_mm->lock);
> > +
> > +	/*
> > +	 * mrn->invalidate_seq is always set to an odd value. This ensures
>=20
> This claim just looks wrong the first N times one reads the code, given t=
hat
> there is mmu_range_set_seq() to set it to an arbitrary value!  Maybe
> you mean

mmu_range_set_seq() is NOT to be used to set to an arbitary value, it
must only be used to set to the value provided in the invalidate()
callback and that value is always odd. Lets make this super clear:

	/*
	 * mrn->invalidate_seq must always be set to an odd value via
	 * mmu_range_set_seq() using the provided cur_seq from
	 * mn_itree_inv_start_range(). This ensures that if seq does wrap we
	 * will always clear the below sleep in some reasonable time as
	 * mmn_mm->invalidate_seq is even in the idle state.
	 */

The invarient is that the 'struct mmu_range_notifier' always has an
odd 'seq'

> > +	 * that if seq does wrap we will always clear the below sleep in some
> > +	 * reasonable time as mmn_mm->invalidate_seq is even in the idle
> > +	 * state.
> > +	 */
>=20
> Let's move that comment higher up. The code that follows it has nothing t=
o
> do with it, so it's confusing here.

The comment is explaining why the wait_event is safe, even if we wrap
the sequence number, which is a significant and very subtle corner
case. This is really why we have the even/odd thing at all.

> > +	spin_lock(&mmn_mm->lock);
> > +	if (mmn_mm->active_invalidate_ranges) {
> > +		if (mn_itree_is_invalidating(mmn_mm))
> > +			hlist_add_head(&mrn->deferred_item,
> > +				       &mmn_mm->deferred_list);
> > +		else {
> > +			mmn_mm->invalidate_seq |=3D 1;
> > +			interval_tree_insert(&mrn->interval_tree,
> > +					     &mmn_mm->itree);
> > +		}
> > +		mrn->invalidate_seq =3D mmn_mm->invalidate_seq;
> > +	} else {
> > +		WARN_ON(mn_itree_is_invalidating(mmn_mm));
> > +		mrn->invalidate_seq =3D mmn_mm->invalidate_seq - 1;
>=20
> Ohhh, checkmate. I lose. Why is *subtracting* the right thing to do
> for seq numbers here?  I'm acutely unhappy trying to figure this out.
> I suspect it's another unfortunate side effect of trying to use the
> lower bit of the seq number (even/odd) for something else.

No, this is actually done for the seq number itself. We need to
generate a seq number that is !=3D the current invalidate_seq as this
new mrn is not invalidating.

The best seq to use is one that the invalidate_seq will not reach for
a long time, ie 'invalidate_seq + MAX' which is expressed as -1

The even/odd thing just takes care of itself naturally here as
invalidate_seq is guarenteed even and -1 creates both an odd mrn value
and a good seq number.

The algorithm would actually work correctly if this was
'mrn->invalidate_seq =3D 1', but occasionally things would block when
they don't need to block.

Lets add a comment:

		/*
		 * The starting seq for a mrn not under invalidation should be
		 * odd, not equal to the current invalidate_seq and
		 * invalidate_seq should not 'wrap' to the new seq any time
		 * soon.
		 */

> > +int mmu_range_notifier_insert(struct mmu_range_notifier *mrn,
> > +			      unsigned long start, unsigned long length,
> > +			      struct mm_struct *mm)
> > +{
> > +	struct mmu_notifier_mm *mmn_mm;
> > +	int ret;
>=20
> Hmmm, I think a later patch improperly changes the above to "int ret =3D =
0;".
> I'll check on that. It's correct here, though.

Looks OK in my tree?

> > +	might_lock(&mm->mmap_sem);
> > +
> > +	mmn_mm =3D smp_load_acquire(&mm->mmu_notifier_mm);
>=20
> What does the above pair with? Should have a comment that specifies that.

smp_load_acquire() always pairs with smp_store_release() to the same
memory, there is only one store, is a comment really needed?

Below are the comment updates I made, thanks!

Jason

diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index 51b92ba013ddce..065c95002e9602 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -302,15 +302,15 @@ void mmu_range_notifier_remove(struct mmu_range_notif=
ier *mrn);
 /**
  * mmu_range_set_seq - Save the invalidation sequence
  * @mrn - The mrn passed to invalidate
- * @cur_seq - The cur_seq passed to invalidate
+ * @cur_seq - The cur_seq passed to the invalidate() callback
  *
  * This must be called unconditionally from the invalidate callback of a
  * struct mmu_range_notifier_ops under the same lock that is used to call
  * mmu_range_read_retry(). It updates the sequence number for later use by
- * mmu_range_read_retry().
+ * mmu_range_read_retry(). The provided cur_seq will always be odd.
  *
- * If the user does not call mmu_range_read_begin() or mmu_range_read_retr=
y()
- * then this call is not required.
+ * If the caller does not call mmu_range_read_begin() or
+ * mmu_range_read_retry() then this call is not required.
  */
 static inline void mmu_range_set_seq(struct mmu_range_notifier *mrn,
 				     unsigned long cur_seq)
@@ -348,8 +348,9 @@ static inline bool mmu_range_read_retry(struct mmu_rang=
e_notifier *mrn,
  * collided with this lock and a future mmu_range_read_retry() will return
  * true.
  *
- * False is not reliable and only suggests a collision has not happened. I=
t
- * can be called many times and does not have to hold the user provided lo=
ck.
+ * False is not reliable and only suggests a collision may not have
+ * occured. It can be called many times and does not have to hold the user
+ * provided lock.
  *
  * This call can be used as part of loops and other expensive operations t=
o
  * expedite a retry.
diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index 2b7485919ecfeb..afe1e2d94183f8 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -51,7 +51,8 @@ struct mmu_notifier_mm {
  * This is a collision-retry read-side/write-side 'lock', a lot like a
  * seqcount, however this allows multiple write-sides to hold it at
  * once. Conceptually the write side is protecting the values of the PTEs =
in
- * this mm, such that PTES cannot be read into SPTEs while any writer exis=
ts.
+ * this mm, such that PTES cannot be read into SPTEs (shadow PTEs) while a=
ny
+ * writer exists.
  *
  * Note that the core mm creates nested invalidate_range_start()/end() reg=
ions
  * within the same thread, and runs invalidate_range_start()/end() in para=
llel
@@ -64,12 +65,13 @@ struct mmu_notifier_mm {
  *
  * The write side has two states, fully excluded:
  *  - mm->active_invalidate_ranges !=3D 0
- *  - mnn->invalidate_seq & 1 =3D=3D True
+ *  - mnn->invalidate_seq & 1 =3D=3D True (odd)
  *  - some range on the mm_struct is being invalidated
  *  - the itree is not allowed to change
  *
  * And partially excluded:
  *  - mm->active_invalidate_ranges !=3D 0
+ *  - mnn->invalidate_seq & 1 =3D=3D False (even)
  *  - some range on the mm_struct is being invalidated
  *  - the itree is allowed to change
  *
@@ -131,12 +133,13 @@ static void mn_itree_inv_end(struct mmu_notifier_mm *=
mmn_mm)
 		return;
 	}
=20
+	/* Make invalidate_seq even */
 	mmn_mm->invalidate_seq++;
 	need_wake =3D true;
=20
 	/*
 	 * The inv_end incorporates a deferred mechanism like
-	 * rtnl_lock(). Adds and removes are queued until the final inv_end
+	 * rtnl_unlock(). Adds and removes are queued until the final inv_end
 	 * happens then they are progressed. This arrangement for tree updates
 	 * is used to avoid using a blocking lock during
 	 * invalidate_range_start.
@@ -230,10 +233,11 @@ unsigned long mmu_range_read_begin(struct mmu_range_n=
otifier *mrn)
 	spin_unlock(&mmn_mm->lock);
=20
 	/*
-	 * mrn->invalidate_seq is always set to an odd value. This ensures
-	 * that if seq does wrap we will always clear the below sleep in some
-	 * reasonable time as mmn_mm->invalidate_seq is even in the idle
-	 * state.
+	 * mrn->invalidate_seq must always be set to an odd value via
+	 * mmu_range_set_seq() using the provided cur_seq from
+	 * mn_itree_inv_start_range(). This ensures that if seq does wrap we
+	 * will always clear the below sleep in some reasonable time as
+	 * mmn_mm->invalidate_seq is even in the idle state.
 	 */
 	lock_map_acquire(&__mmu_notifier_invalidate_range_start_map);
 	lock_map_release(&__mmu_notifier_invalidate_range_start_map);
@@ -892,6 +896,12 @@ static int __mmu_range_notifier_insert(struct mmu_rang=
e_notifier *mrn,
 		mrn->invalidate_seq =3D mmn_mm->invalidate_seq;
 	} else {
 		WARN_ON(mn_itree_is_invalidating(mmn_mm));
+		/*
+		 * The starting seq for a mrn not under invalidation should be
+		 * odd, not equal to the current invalidate_seq and
+		 * invalidate_seq should not 'wrap' to the new seq any time
+		 * soon.
+		 */
 		mrn->invalidate_seq =3D mmn_mm->invalidate_seq - 1;
 		interval_tree_insert(&mrn->interval_tree, &mmn_mm->itree);
 	}
