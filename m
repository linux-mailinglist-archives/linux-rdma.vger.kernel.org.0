Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 786A2DF573
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Oct 2019 20:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730048AbfJUSya (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Oct 2019 14:54:30 -0400
Received: from mail-eopbgr00089.outbound.protection.outlook.com ([40.107.0.89]:58624
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729894AbfJUSya (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Oct 2019 14:54:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=exll6zXqG9QciNC0xs8f+K/it/HGkdh8z22e4P8rXYUtgv/NyyYMBIVAHl5hdsegW52UEZxU3UWEHRPHlTbHkP2GEq+QzQSDPmRQgjZ9sikv4m2Va6SKCdvWBywyCVy1EDGSpCNxFPFQoheSRgGtjKoZa5C/fMB1ROzp/q/S7efg2Mmv2pVOhn/fP1+7JO2bqu0+GK0aOiQPLh6AW5Nt/47E8kbI8cFcz/0wSYtMBKQC7XILyLrt9hkyOlkOEu5dcDOeyxBayM+0iadBTd/xvHp2oNOYvVxcoIQaKNspx0MQz2sgdi4MOOlMvo8iGNMTDooRXsNTNh5RPxUrRgkRLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFAD1vzDDPDJ4MUzEEAE8ugFlTaiSRQHLPRqglVLhjo=;
 b=YUcUrVTGLa3srhoN/hwvIKMOM/O5sblofQj+WUTsd60ASYo7O37liCUGhQp5mMoIvDU7fHakt4ebT6z4q5CI3DTz5bpSpjhnWqo76QDXGXobP3Fl7yi1riVd7P5l0EWu2PwJpG/P5rwRM7P4e3VGqSFclWWtn148rYsx+cOirOnkN8H5RrK6/JNfxp15Gow0gD/8YgjM+JO6yb/HgFI93EILEogGgGw262yuc4YE2mqbGVVmBUV9chTAQDVCXtJedmGHeXE4owPxmDWPN2ARk+cSki1EmjVXKDmL9OsG9hmunmuQ6LV6d0V6e51GMQBOK24KAAD9Y2y/HE4O3qeIQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFAD1vzDDPDJ4MUzEEAE8ugFlTaiSRQHLPRqglVLhjo=;
 b=GAcWDK0s9Xh/y91InRJvMnZvgWGdWwZ2mwDu+oTy0t492xW5VDfTpO6r7oXrAw9V4aNVoRd08lUN+tKOUyW7gk/YvsLwPVQeUiIXgFn0sXCp1YnJW8lCTdMSN/mz+PHznupQf25+9wCwQcRn0UrDqSiP55W64SPVyfu5KrxomEk=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB4783.eurprd05.prod.outlook.com (20.176.1.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.24; Mon, 21 Oct 2019 18:54:25 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::75ae:b00b:69d8:3db0]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::75ae:b00b:69d8:3db0%7]) with mapi id 15.20.2347.029; Mon, 21 Oct 2019
 18:54:25 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Jerome Glisse <jglisse@redhat.com>
CC:     Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH hmm 02/15] mm/mmu_notifier: add an interval tree notifier
Thread-Topic: [PATCH hmm 02/15] mm/mmu_notifier: add an interval tree notifier
Thread-Index: AQHVg4SuHCkuEaFxsk60wlfA7oiQWadldFEAgAAGi4A=
Date:   Mon, 21 Oct 2019 18:54:25 +0000
Message-ID: <20191021185421.GG6285@mellanox.com>
References: <20191015181242.8343-1-jgg@ziepe.ca>
 <20191015181242.8343-3-jgg@ziepe.ca> <20191021183056.GA3177@redhat.com>
In-Reply-To: <20191021183056.GA3177@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR01CA0019.prod.exchangelabs.com (2603:10b6:208:10c::32)
 To VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1fbf9f65-56ac-47e1-4696-08d756581799
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: VI1PR05MB4783:
x-microsoft-antispam-prvs: <VI1PR05MB4783961125860D4D8380F28BCF690@VI1PR05MB4783.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0197AFBD92
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(189003)(199004)(14454004)(11346002)(446003)(86362001)(33656002)(1076003)(25786009)(6916009)(81156014)(8936002)(8676002)(81166006)(478600001)(64756008)(66066001)(66476007)(66556008)(66946007)(66446008)(486006)(186003)(5660300002)(386003)(256004)(14444005)(5024004)(2616005)(476003)(26005)(102836004)(6506007)(71190400001)(76176011)(99286004)(52116002)(71200400001)(3846002)(7416002)(305945005)(6116002)(7736002)(6486002)(4326008)(6246003)(36756003)(229853002)(6512007)(6436002)(2906002)(54906003)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4783;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 12Pj4hgoldSvQVPPXVnCdVZ7O3He2QOny5MLsSpPjGnriOWGioi8Vy3rgD/lFzAWFdxQFzOkYpXIe8+BUPTmdq+IrNM2xZgFI1NIkOkwGg1JAYj84CRzcETuyZe7YnRsGAGQ54ygSCTE0ultUXGvXyA8znvreycOSlVX7qlQWS6EDndrAC5ujawUNpeMNlmaKLF/VHW4EV2CADo6/Oy7Ii+2TvzyxUvKfit1Mqgbi5ugUTN+ax1s5hqi0wWfi0tUxjAX9i2Ml2gakVgQmJ8Z+UfKsyhDXziYlzhh17RyFkM4DgNJ+SEsjE5Q4HR8lMsocXuPoMQeYbIC8qbn5boeCRlrUpcIJ/JB2KSCRqTmu38qegTL8r84WUzveRN8cyw1LHj2nzybrDgFmt7Du/BjGBe+epu7fyEPtSOUqpO6fteMbbUtgBNpwM6ZXRQQYQda
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C691CD3ECAE8254783B3B4D0EA8D02E6@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fbf9f65-56ac-47e1-4696-08d756581799
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2019 18:54:25.6871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CsGDHQc+LIrneNeifg1aIbp5dK/n5j0zlXCz53IkdcLSt1572LiOobCwR6SH1GQsGz/8XQ4UTs3VfK80tI3Lqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4783
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 21, 2019 at 02:30:56PM -0400, Jerome Glisse wrote:

> > +/**
> > + * mmu_range_read_retry - End a read side critical section against a V=
A range
> > + * mrn: The range under lock
> > + * seq: The return of the paired mmu_range_read_begin()
> > + *
> > + * This MUST be called under a user provided lock that is also held
> > + * unconditionally by op->invalidate(). That lock provides the require=
d SMP
> > + * barrier for handling invalidate_seq.
> > + *
> > + * Each call should be paired with a single mmu_range_read_begin() and
> > + * should be used to conclude the read side.
> > + *
> > + * Returns true if an invalidation collided with this critical section=
, and
> > + * the caller should retry.
> > + */
> > +static inline bool mmu_range_read_retry(struct mmu_range_notifier *mrn=
,
> > +					unsigned long seq)
> > +{
> > +	return READ_ONCE(mrn->invalidate_seq) !=3D seq;
> > +}
>=20
> What about calling this mmu_range_read_end() instead ? To match
> with the mmu_range_read_begin().

_end make some sense too, but I picked _retry for symmetry with the
seqcount_* family of functions which used retry.

I think retry makes it clearer that it is expected to fail and retry
is required.

> > +	/*
> > +	 * The inv_end incorporates a deferred mechanism like rtnl. Adds and
>=20
> The rtnl reference is lost on people unfamiliar with the network :)
> code maybe like rtnl_lock()/rtnl_unlock() so people have a chance to
> grep the right function. Assuming i am myself getting the right
> reference :)

Yep, you got it, I will update

> > +	/*
> > +	 * mrn->invalidate_seq is always set to an odd value. This ensures
> > +	 * that if seq does wrap we will always clear the below sleep in some
> > +	 * reasonable time as mmn_mm->invalidate_seq is even in the idle
> > +	 * state.
>=20
> I think this comment should be with the struct mmu_range_notifier
> definition and you should just point to it from here as the same
> comment would be useful down below.

I had it here because it is critical to understanding the wait_event
and why it doesn't just block indefinitely, but yes this property
comes up below too which refers back here.

Fundamentally this wait event is why this approach to keep an odd
value in the mrn is used.

> > -int __mmu_notifier_invalidate_range_start(struct mmu_notifier_range *r=
ange)
> > +static int mn_itree_invalidate(struct mmu_notifier_mm *mmn_mm,
> > +				     const struct mmu_notifier_range *range)
> > +{
> > +	struct mmu_range_notifier *mrn;
> > +	unsigned long cur_seq;
> > +
> > +	for (mrn =3D mn_itree_inv_start_range(mmn_mm, range, &cur_seq); mrn;
> > +	     mrn =3D mn_itree_inv_next(mrn, range)) {
> > +		bool ret;
> > +
> > +		WRITE_ONCE(mrn->invalidate_seq, cur_seq);
> > +		ret =3D mrn->ops->invalidate(mrn, range);
> > +		if (!ret && !WARN_ON(mmu_notifier_range_blockable(range)))
>=20
> Isn't the logic wrong here ? We want to warn if the range
> was mark as blockable and invalidate returned false. Also
> we went to backoff no matter what if the invalidate return
> false ie:

If invalidate returned false and the caller is blockable then we do
not want to return, we must continue processing other ranges - to try
to cope with the defective driver.

Callers in blocking mode ignore the return value and go ahead to
invalidate..

Would it be clearer as=20

if (!ret) {
   if (WARN_ON(mmu_notifier_range_blockable(range)))
       continue;
   goto out_would_block;
}

?

> > @@ -284,21 +589,22 @@ int __mmu_notifier_register(struct mmu_notifier *=
mn, struct mm_struct *mm)
> >  		 * the write side of the mmap_sem.
> >  		 */
> >  		mmu_notifier_mm =3D
> > -			kmalloc(sizeof(struct mmu_notifier_mm), GFP_KERNEL);
> > +			kzalloc(sizeof(struct mmu_notifier_mm), GFP_KERNEL);
> >  		if (!mmu_notifier_mm)
> >  			return -ENOMEM;
> > =20
> >  		INIT_HLIST_HEAD(&mmu_notifier_mm->list);
> >  		spin_lock_init(&mmu_notifier_mm->lock);
> > +		mmu_notifier_mm->invalidate_seq =3D 2;
>=20
> Why starting at 2 ?

Good question. If everything is coded properly the starting value
doesn't matter

I left it like this because it makes debugging a tiny bit simpler, ie
if you print the seq number then the first mmu_range_notififers will
get 1 as their intial seq (see __mmu_range_notifier_insert) instead of
ULONG_MAX

> > +		mmu_notifier_mm->itree =3D RB_ROOT_CACHED;
> > +		init_waitqueue_head(&mmu_notifier_mm->wq);
> > +		INIT_HLIST_HEAD(&mmu_notifier_mm->deferred_list);
> >  	}
> > =20
> >  	ret =3D mm_take_all_locks(mm);
> >  	if (unlikely(ret))
> >  		goto out_clean;
> > =20
> > -	/* Pairs with the mmdrop in mmu_notifier_unregister_* */
> > -	mmgrab(mm);
> > -
> >  	/*
> >  	 * Serialize the update against mmu_notifier_unregister. A
> >  	 * side note: mmu_notifier_release can't run concurrently with
> > @@ -306,13 +612,26 @@ int __mmu_notifier_register(struct mmu_notifier *=
mn, struct mm_struct *mm)
> >  	 * current->mm or explicitly with get_task_mm() or similar).
> >  	 * We can't race against any other mmu notifier method either
> >  	 * thanks to mm_take_all_locks().
> > +	 *
> > +	 * release semantics are provided for users not inside a lock covered
> > +	 * by mm_take_all_locks(). acquire can only be used while holding the
> > +	 * mmgrab or mmget, and is safe because once created the
> > +	 * mmu_notififer_mm is not freed until the mm is destroyed.
> >  	 */
> >  	if (mmu_notifier_mm)
> > -		mm->mmu_notifier_mm =3D mmu_notifier_mm;
> > +		smp_store_release(&mm->mmu_notifier_mm, mmu_notifier_mm);
>=20
> I do not understand why you need the release semantics here, we
> are under the mmap_sem in write mode when we release it the lock
> barrier will make sure anyone else sees the new mmu_notifier_mm

It pairs with the smp_load_acquire() in mmu_range_notifier_insert()
which is not called with the mmap_sem held.=20

Since that reader is not locked we need release semantics here to
ensure the unlocked reader sees a fully initinalized mmu_notifier_mm
structure when it observes the pointer.

> > +/**
> > + * mmu_range_notifier_insert - Insert a range notifier
> > + * @mrn: Range notifier to register
> > + * @start: Starting virtual address to monitor
> > + * @length: Length of the range to monitor
> > + * @mm : mm_struct to attach to
> > + *
> > + * This function subscribes the range notifier for notifications from =
the mm.
> > + * Upon return the ops related to mmu_range_notifier will be called wh=
enever
> > + * an event that intersects with the given range occurs.
> > + *
> > + * Upon return the range_notifier may not be present in the interval t=
ree yet.
> > + * The caller must use the normal range notifier locking flow via
> > + * mmu_range_read_begin() to establish SPTEs for this range.
> > + */
> > +int mmu_range_notifier_insert(struct mmu_range_notifier *mrn,
> > +			      unsigned long start, unsigned long length,
> > +			      struct mm_struct *mm)
> > +{
> > +	struct mmu_notifier_mm *mmn_mm;
> > +	int ret;
> > +
> > +	might_lock(&mm->mmap_sem);
> > +
> > +	mmn_mm =3D smp_load_acquire(&mm->mmu_notifier_mm);

Right here we don't have the mmap_sem so this load is unlocked.

If we observe !mmn_mm we must also observe all stores done to set it
up. Ie we have to observe the spin_lock_init, RB_ROOT_CACHED/etc

> > +	if (!mmn_mm || !mmn_mm->has_interval) {
> > +		ret =3D mmu_notifier_register(NULL, mm);
> > +		if (ret)
> > +			return ret;
> > +		mmn_mm =3D mm->mmu_notifier_mm;
> > +	}
> > +	return __mmu_range_notifier_insert(mrn, start, length, mmn_mm, mm);
> > +}
> > +EXPORT_SYMBOL_GPL(mmu_range_notifier_insert);
> > +
> > +int mmu_range_notifier_insert_locked(struct mmu_range_notifier *mrn,
> > +				     unsigned long start, unsigned long length,
> > +				     struct mm_struct *mm)
> > +{
> > +	struct mmu_notifier_mm *mmn_mm;
> > +	int ret;
> > +
> > +	lockdep_assert_held_write(&mm->mmap_sem);
> > +
> > +	mmn_mm =3D mm->mmu_notifier_mm;
>=20
> Shouldn't you be using smp_load_acquire() ?

This function is called while holding the mmap_sem. As you noted above
all writers to mm->mmu_notifier_mm hold the write side of mmap_sem,
thus here the read side is fully locked and doesn't need the acquire.

Note the lockdep annotations marking the expected locking enviroment
for the two functions.

Thanks,
Jason
