Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE818F3942
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Nov 2019 21:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbfKGULO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Nov 2019 15:11:14 -0500
Received: from mail-eopbgr70073.outbound.protection.outlook.com ([40.107.7.73]:46082
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725906AbfKGULO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 7 Nov 2019 15:11:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nm8BTQc4XcVTH5AaIKywjzo0C9fWhL5LyHHaZXEcnqCacomefreNfCKYQ2Oa0s16aXW/c2911ukmgASDwn20ZW6cnBzvAqn8cyj8vO63bdPEgpPjdyVeLlt4Mak0civxWgMIpYwzLQ0KSDYPZ/gD4kroy5KkQif6whPF91zAh3v7+1YTYQdeiAtFx2lIKky2rwPSwPhs1FWpC8j3vAtxEKvCBxcP4DR77nl18J6wCkgZPeqZAg9BFa4zbCTv3vvDa7O2Ht5Mu1Ro18uRYhGu5yoRkzSf/MN+2W5ls0uPTsCZ/tO/eQHaoBAI3YU9UVv+c1l3kNpq3O4DTNIrHAiMHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xgxel6wzKCB7iAx3fWFDmhvkjcwH++biBi9chHqduk0=;
 b=Y1VPdXKJOiXfUGO+KcCfgfc7X6vspbWwExS7JeTNyrHYmgiqc7w5TOu7GYwxtKutUPCOrvzwGby8zAXw2DUmL5NwGjxi75ZkhmtsZyDuaaeny6JyRpQUL3o++LbgL0PUENxQSPmCYtMcp8cuYR7IsrhUjixrjELVOnX7uzHOdde30hIqPYLlJ8QILxJxMjkat5ZsHj1asY0s0JLc46RanLeTw1CMhdYjPBFj5oSSiiwjDot2qTz6s82GyCVoQss1X5F0X23FCAfRBSs5xpAoDfO9EK2RrbKnawEG0Lk2NSfgEg/bkf6pJ7vSnunTwOQiGdj209mcO6w4NJZbfnGpQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xgxel6wzKCB7iAx3fWFDmhvkjcwH++biBi9chHqduk0=;
 b=BNXsKXL9nJvqfGHHD/lPQbRXn/qd1yJwC3pT5azbBvdC35OPaGVyJz11549WonzkCt8RbubfZxch6PcjKWWnmHJTSZ38OOWd162SVBKSns8OP2ugL8tVb3WrTIhZUl9ji1XzNUD8Cpr2qo1jQvBAzvWBLCnkH2TiPtk2d3cY9Tw=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB3406.eurprd05.prod.outlook.com (10.175.245.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.23; Thu, 7 Nov 2019 20:11:06 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d%5]) with mapi id 15.20.2408.028; Thu, 7 Nov 2019
 20:11:06 +0000
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
Thread-Index: AQHVjcvJYOye0EiwZkisYK74G5bmhqd+54eAgAAdRYCAAS6QAA==
Date:   Thu, 7 Nov 2019 20:11:06 +0000
Message-ID: <20191107201102.GC21728@mellanox.com>
References: <20191028201032.6352-1-jgg@ziepe.ca>
 <20191028201032.6352-3-jgg@ziepe.ca>
 <35c2b322-004e-0e18-87e4-1920dc71bfd5@nvidia.com>
 <20191107020807.GA747656@redhat.com>
In-Reply-To: <20191107020807.GA747656@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN4PR13CA0015.namprd13.prod.outlook.com
 (2603:10b6:403:3::25) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4cdf982f-b6aa-4a1e-ead0-08d763be9f65
x-ms-traffictypediagnostic: VI1PR05MB3406:
x-microsoft-antispam-prvs: <VI1PR05MB340605F186CF3F42C41E3009CF780@VI1PR05MB3406.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(136003)(39850400004)(346002)(396003)(199004)(189003)(14454004)(25786009)(7416002)(305945005)(6916009)(478600001)(7736002)(6512007)(8936002)(6486002)(6436002)(36756003)(229853002)(86362001)(2906002)(81166006)(8676002)(81156014)(4326008)(6246003)(71190400001)(386003)(316002)(1076003)(66946007)(54906003)(99286004)(33656002)(5660300002)(256004)(14444005)(66066001)(52116002)(76176011)(3846002)(486006)(2616005)(476003)(71200400001)(11346002)(6116002)(66446008)(64756008)(66556008)(66476007)(186003)(26005)(6506007)(102836004)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3406;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H5+pRnFkA5QDCMKd68E5ZKcpCb4oVJ3md863xj2cktKvQTKyzXn1xrpDtS9RNSLvsS1j3UXr/9v9oIJDV32GgFLWBOgnOoFuBJ+0TqRXfuiiBoeTrLB2abbk55CpA8TFeZgPeHvt1+1YlT8wbXygJthoj7FkBQm05t2h9kPXeCtZFWApw4yQb1Jx9p8Z/fO9qNjtRHWosI+hnxeHeIk2HHUNKsPCCMlbVe9qBgUy/ZqunC95Ji8bAPUOKQ9idWmIDjErlGSbaD0b3lXAiatAeC7ND7VLBjyk5L52U3MpSGDpVj/2KbTxDZSmwMG6yjJ0dQFfPcQe2XNhIa+YATjVxGRONmg1JkQc4QttBO2T2/f5ekxfmYtl2Xw00zNQJpnN6h42OLr296dVCm7jMhiGk07NexaMqkbX4v7XUttzwHCpqBwhWvIRTlmxi9y91JRG
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <9C8D977ED7A453449570F9D0913CEE68@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cdf982f-b6aa-4a1e-ead0-08d763be9f65
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 20:11:06.8215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z8D1valdPpKPqSFVylDJ7wF0U0fhXCJCXosYRLsrWDT8na41aquw4LOQzKGcVcTaq+RimeECKXfXEcNqGoIfXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3406
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 06, 2019 at 09:08:07PM -0500, Jerome Glisse wrote:

> >=20
> > Extra credit: IMHO, this clearly deserves to all be in a new mmu_range_=
notifier.h
> > header file, but I know that's extra work. Maybe later as a follow-up p=
atch,
> > if anyone has the time.
>=20
> The range notifier should get the event too, it would be a waste, i think=
 it is
> an oversight here. The release event is fine so NAK to you separate event=
. Event
> is really an helper for notifier i had a set of patch for nouveau to leve=
rage
> this i need to resucite them. So no need to split thing, i would just for=
ward
> the event ie add event to mmu_range_notifier_ops.invalidate() i failed to=
 catch
> that in v1 sorry.

I think what you mean is already done?

struct mmu_range_notifier_ops {
	bool (*invalidate)(struct mmu_range_notifier *mrn,
			   const struct mmu_notifier_range *range,
			   unsigned long cur_seq);

> No it is always odd, you must call mmu_range_set_seq() only from the
> op->invalidate_range() callback at which point the seq is odd. As well
> when mrn is added and its seq first set it is set to an odd value
> always. Maybe the comment, should read:
>=20
>  * mrn->invalidate_seq is always, yes always, set to an odd value. This e=
nsures
>=20
> To stress that it is not an error.

I went with this:

	/*
	 * mrn->invalidate_seq must always be set to an odd value via
	 * mmu_range_set_seq() using the provided cur_seq from
	 * mn_itree_inv_start_range(). This ensures that if seq does wrap we
	 * will always clear the below sleep in some reasonable time as
	 * mmn_mm->invalidate_seq is even in the idle state.
	 */

> > > +	spin_lock(&mmn_mm->lock);
> > > +	if (mmn_mm->active_invalidate_ranges) {
> > > +		if (mn_itree_is_invalidating(mmn_mm))
> > > +			hlist_add_head(&mrn->deferred_item,
> > > +				       &mmn_mm->deferred_list);
> > > +		else {
> > > +			mmn_mm->invalidate_seq |=3D 1;
> > > +			interval_tree_insert(&mrn->interval_tree,
> > > +					     &mmn_mm->itree);
> > > +		}
> > > +		mrn->invalidate_seq =3D mmn_mm->invalidate_seq;
> > > +	} else {
> > > +		WARN_ON(mn_itree_is_invalidating(mmn_mm));
> > > +		mrn->invalidate_seq =3D mmn_mm->invalidate_seq - 1;
> >=20
> > Ohhh, checkmate. I lose. Why is *subtracting* the right thing to do
> > for seq numbers here?  I'm acutely unhappy trying to figure this out.
> > I suspect it's another unfortunate side effect of trying to use the
> > lower bit of the seq number (even/odd) for something else.
>=20
> If there is no mmn_mm->active_invalidate_ranges then it means that
> mmn_mm->invalidate_seq is even and thus mmn_mm->invalidate_seq - 1
> is an odd number which means that mrn->invalidate_seq is initialized
> to odd value and if you follow the rule for calling mmu_range_set_seq()
> then it will _always_ be an odd number and this close the loop with
> the above comments :)

The key thing is that it is an odd value that will take a long time
before mmn_mm->invalidate seq reaches it

> > > +	might_lock(&mm->mmap_sem);
> > > +
> > > +	mmn_mm =3D smp_load_acquire(&mm->mmu_notifier_mm);
> >=20
> > What does the above pair with? Should have a comment that specifies tha=
t.
>=20
> It was discussed in v1 but maybe a comment of what was said back then wou=
ld
> be helpful. Something like:
>=20
> /*
>  * We need to insure that all writes to mm->mmu_notifier_mm are visible b=
efore
>  * any checks we do on mmn_mm below as otherwise CPU might re-order write=
 done
>  * by another CPU core to mm->mmu_notifier_mm structure fields after the =
read
>  * belows.
>  */

This comment made it, just at the store side:

	/*
	 * Serialize the update against mmu_notifier_unregister. A
	 * side note: mmu_notifier_release can't run concurrently with
	 * us because we hold the mm_users pin (either implicitly as
	 * current->mm or explicitly with get_task_mm() or similar).
	 * We can't race against any other mmu notifier method either
	 * thanks to mm_take_all_locks().
	 *
	 * release semantics on the initialization of the mmu_notifier_mm's
         * contents are provided for unlocked readers.  acquire can only be
         * used while holding the mmgrab or mmget, and is safe because once
         * created the mmu_notififer_mm is not freed until the mm is
         * destroyed.  As above, users holding the mmap_sem or one of the
         * mm_take_all_locks() do not need to use acquire semantics.
	 */
	if (mmu_notifier_mm)
		smp_store_release(&mm->mmu_notifier_mm, mmu_notifier_mm);

Which I think is really overly belaboring the typical smp
store/release pattern, but people do seem unfamiliar with them...

Thanks,
Jason
