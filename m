Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD5CA2BAFA
	for <lists+linux-rdma@lfdr.de>; Mon, 27 May 2019 21:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfE0T6r (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 May 2019 15:58:47 -0400
Received: from mail-eopbgr70072.outbound.protection.outlook.com ([40.107.7.72]:50276
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726817AbfE0T6r (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 May 2019 15:58:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HsTAO4MPFDORutqttq/+3p/7+cC2uB2dPdEX9r6irIM=;
 b=WnhCB7P7/VM1aLfLBU7fAcQjwdRIe7+AUL0o/KT/miMtsBBvX6vvpTztnucVt2R9/3EfS1CCpNuzLyDFM5ixsz94+o3N33E8A+hpHnNYeIaIhlPP0nvPOZ/WJ6oWf0c0MXTlQsCXWaPwSDmGI4e8MWNPyu5Bd5ahue5yBMdI4Hg=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6509.eurprd05.prod.outlook.com (20.179.25.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.17; Mon, 27 May 2019 19:58:35 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1%6]) with mapi id 15.20.1922.021; Mon, 27 May 2019
 19:58:35 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Jerome Glisse <jglisse@redhat.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [RFC PATCH 00/11] mm/hmm: Various revisions from a locking/code
 review
Thread-Topic: [RFC PATCH 00/11] mm/hmm: Various revisions from a locking/code
 review
Thread-Index: AQHVEX0JnOUAStpfyEOu2lSXF8F8eg==
Date:   Mon, 27 May 2019 19:58:35 +0000
Message-ID: <20190527195829.GB18019@mellanox.com>
References: <20190523153436.19102-1-jgg@ziepe.ca>
 <20190524143649.GA14258@ziepe.ca> <20190524164902.GA3346@redhat.com>
 <20190524165931.GF16845@ziepe.ca> <20190524170148.GB3346@redhat.com>
 <20190524175203.GG16845@ziepe.ca> <20190524180321.GD3346@redhat.com>
 <20190524183225.GI16845@ziepe.ca> <20190524184608.GE3346@redhat.com>
 <20190524220923.GA8519@ziepe.ca>
In-Reply-To: <20190524220923.GA8519@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTXPR0101CA0059.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::36) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f673fff-154c-46d3-c4a3-08d6e2ddb396
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR05MB6509;
x-ms-traffictypediagnostic: VI1PR05MB6509:
x-microsoft-antispam-prvs: <VI1PR05MB6509023C60CD9FBA109F2ECCCF1D0@VI1PR05MB6509.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0050CEFE70
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(136003)(346002)(366004)(189003)(199004)(66946007)(73956011)(102836004)(66476007)(66446008)(64756008)(66556008)(76176011)(53936002)(71190400001)(71200400001)(30864003)(1076003)(25786009)(305945005)(33656002)(53546011)(6246003)(6506007)(14444005)(7736002)(386003)(5660300002)(26005)(256004)(36756003)(54906003)(2906002)(6916009)(3846002)(229853002)(6486002)(2616005)(476003)(6512007)(81166006)(8676002)(81156014)(86362001)(68736007)(52116002)(486006)(6436002)(8936002)(4326008)(99286004)(186003)(316002)(14454004)(66066001)(478600001)(53946003)(11346002)(446003)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6509;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: q9wHYYuq1rYO/Y/hK3wCPijAjK56PCl9HC8VzjsNRvnNaUpu1nJ7nxBshRA4CJDZoDvDyNImYY3WjStevdvOH8lNGv6LW4fosWzXlgO4vUoKzmyrxT0MM/Laci8cxjeOiTpVt4hD5vjFGPU3FplOe9DvGJbjItFZDLvWQDTtprqQToober+N6uT+0tCYP2ech8w/YR/kk4XZ4mqaGqjtp1CrvxESzHzY0Bvf/AyuneGVRjAphQorEK6XddmqJUb8hsqEKESzlyQdaDnjH3iQrZvWBkOJLe8DmzbodFroBmYfXlB+euHzC+l+zN+meZPnhh1yTHIxBgCeAnMqulRAA2zeBCdTCK6VlGMnj4Nd1tWD47slSfRSjSW9A2SSGkqjKBrkn3ffl0uDHfCQ/Xs3BsZj/Jc1K7ZiikcC1KwP/Iw=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <15715ABBFF5EE1499FFD3F81450AAA32@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f673fff-154c-46d3-c4a3-08d6e2ddb396
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2019 19:58:35.5811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6509
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 24, 2019 at 07:09:23PM -0300, Jason Gunthorpe wrote:
> On Fri, May 24, 2019 at 02:46:08PM -0400, Jerome Glisse wrote:
> > > Here is the big 3 CPU ladder diagram that shows how 'valid' does not
> > > work:
> > >=20
> > >        CPU0                                               CPU1       =
                                   CPU2
> > >                                                         DEVICE PAGE F=
AULT
> > >                                                         range =3D hmm=
_range_register()
> > >
> > >   // Overlaps with range
> > >   hmm_invalidate_start()
> > >     range->valid =3D false
> > >     ops->sync_cpu_device_pagetables()
> > >       take_lock(driver->update);
> > >        // Wipe out page tables in device, enable faulting
> > >       release_lock(driver->update);
> > >                                                                      =
                              // Does not overlap with range
> > >                                                                      =
                              hmm_invalidate_start()
> > >                                                                      =
                              hmm_invalidate_end()
> > >                                                                      =
                                  list_for_each
> > >                                                                      =
                                      range->valid =3D  true
> >=20
> >                                                                        =
                                      ^
> > No this can not happen because CPU0 still has invalidate_range in progr=
ess and
> > thus hmm->notifiers > 0 so the hmm_invalidate_range_end() will not set =
the
> > range->valid as true.
>=20
> Oh, Okay, I now see how this all works, thank you
>=20
> > > And I can make this more complicated (ie overlapping parallel
> > > invalidates, etc) and show any 'bool' valid cannot work.
> >=20
> > It does work.=20
>=20
> Well, I ment the bool alone cannot work, but this is really bool + a
> counter.

I couldn't shake this unease that bool shouldn't work for this type of
locking, especially since odp also used a sequence lock as well as the
rwsem...

What about this situation:

       CPU0                                               CPU1
                                                        DEVICE PAGE FAULT
                                                        range =3D hmm_range=
_register()
							hmm_range_snapshot(&range);


   // Overlaps with range
   hmm_invalidate_start()
     range->valid =3D false
     ops->sync_cpu_device_pagetables()
       take_lock(driver->update);
        // Wipe out page tables in device, enable faulting
       release_lock(driver->update);
   hmm_invalidate_end()
      range->valid =3D true


							take_lock(driver->update);
							if (!hmm_range_valid(&range))
							    goto again
							ESTABLISH SPTES
                                                        release_lock(driver=
->update);


The ODP patch appears to follow this pattern as the dma_map and the
mlx5_ib_update_xlt are in different locking regions. We should dump
the result of rmm_range_snapshot in this case, certainly the driver
shouldn't be tasked with fixing this..

So, something like this is what I'm thinking about:

From 41b6a6120e30978e7335ada04fb9168db4e5fd29 Mon Sep 17 00:00:00 2001
From: Jason Gunthorpe <jgg@mellanox.com>
Date: Mon, 27 May 2019 16:48:53 -0300
Subject: [PATCH] RFC mm/hmm: Replace the range->valid with a seqcount

Instead of trying to use a single valid to keep track of parallel
invalidations use a traditional seqcount retry lock.

Replace the range->valid with the concept of a 'update critical region'
bounded by hmm_range_start_update() / hmm_range_end_update() which can
fail and need retry if it is ever interrupted by a parallel
invalidation. Updaters must create the critical section and can only
finish their update while holding the device_lock.

Continue to take a very loose approach to track invalidation, now with a
single global seqcount for all ranges. This is done to minimize the
overhead in the mmu notifier, and expects there will only be a small
number of ranges active at once. It could be converted to a seqcount per
range if necessary.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 Documentation/vm/hmm.rst | 22 +++++--------
 include/linux/hmm.h      | 60 ++++++++++++++++++++++++---------
 mm/hmm.c                 | 71 ++++++++++++++++++++++------------------
 3 files changed, 93 insertions(+), 60 deletions(-)

diff --git a/Documentation/vm/hmm.rst b/Documentation/vm/hmm.rst
index 7c1e929931a07f..7e827058964579 100644
--- a/Documentation/vm/hmm.rst
+++ b/Documentation/vm/hmm.rst
@@ -229,32 +229,27 @@ The usage pattern is::
        * will use the return value of hmm_range_snapshot() below under the
        * mmap_sem to ascertain the validity of the range.
        */
-      hmm_range_wait_until_valid(&range, TIMEOUT_IN_MSEC);
-
  again:
+       if (!hmm_range_start_update(&range, TIMEOUT_IN_MSEC))
+             goto err
+
       down_read(&mm->mmap_sem);
       ret =3D hmm_range_snapshot(&range);
       if (ret) {
           up_read(&mm->mmap_sem);
-          if (ret =3D=3D -EAGAIN) {
-            /*
-             * No need to check hmm_range_wait_until_valid() return value
-             * on retry we will get proper error with hmm_range_snapshot()
-             */
-            hmm_range_wait_until_valid(&range, TIMEOUT_IN_MSEC);
-            goto again;
-          }
+          if (ret =3D=3D -EAGAIN)
+              goto again;
           hmm_mirror_unregister(&range);
           return ret;
       }
       take_lock(driver->update);
-      if (!hmm_range_valid(&range)) {
+      if (!hmm_range_end_update(&range)) {
           release_lock(driver->update);
           up_read(&mm->mmap_sem);
           goto again;
       }
=20
-      // Use pfns array content to update device page table
+      // Use pfns array content to update device page table, must hold dri=
ver->update
=20
       hmm_mirror_unregister(&range);
       release_lock(driver->update);
@@ -264,7 +259,8 @@ The usage pattern is::
=20
 The driver->update lock is the same lock that the driver takes inside its
 sync_cpu_device_pagetables() callback. That lock must be held before calli=
ng
-hmm_range_valid() to avoid any race with a concurrent CPU page table updat=
e.
+hmm_range_end_update() to avoid any race with a concurrent CPU page table
+update.
=20
 HMM implements all this on top of the mmu_notifier API because we wanted a
 simpler API and also to be able to perform optimizations latter on like do=
ing
diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 26dfd9377b5094..9096113cfba8de 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -90,7 +90,9 @@
  * @mmu_notifier: mmu notifier to track updates to CPU page table
  * @mirrors_sem: read/write semaphore protecting the mirrors list
  * @wq: wait queue for user waiting on a range invalidation
- * @notifiers: count of active mmu notifiers
+ * @active_invalidates: count of active mmu notifier invalidations
+ * @range_invalidated: seqcount indicating that an active range was
+ *                     maybe invalidated
  */
 struct hmm {
 	struct mm_struct	*mm;
@@ -102,7 +104,8 @@ struct hmm {
 	struct rw_semaphore	mirrors_sem;
 	wait_queue_head_t	wq;
 	struct rcu_head		rcu;
-	long			notifiers;
+	unsigned int		active_invalidates;
+	seqcount_t		range_invalidated;
 };
=20
 /*
@@ -169,7 +172,7 @@ enum hmm_pfn_value_e {
  * @pfn_flags_mask: allows to mask pfn flags so that only default_flags ma=
tter
  * @page_shift: device virtual address shift value (should be >=3D PAGE_SH=
IFT)
  * @pfn_shifts: pfn shift value (should be <=3D PAGE_SHIFT)
- * @valid: pfns array did not change since it has been fill by an HMM func=
tion
+ * @update_seq: sequence number for the seqcount lock read side
  */
 struct hmm_range {
 	struct hmm		*hmm;
@@ -184,7 +187,7 @@ struct hmm_range {
 	uint64_t		pfn_flags_mask;
 	uint8_t			page_shift;
 	uint8_t			pfn_shift;
-	bool			valid;
+	unsigned int		update_seq;
 };
=20
 /*
@@ -208,27 +211,52 @@ static inline unsigned long hmm_range_page_size(const=
 struct hmm_range *range)
 }
=20
 /*
- * hmm_range_wait_until_valid() - wait for range to be valid
+ * hmm_range_start_update() - wait for range to be valid
  * @range: range affected by invalidation to wait on
  * @timeout: time out for wait in ms (ie abort wait after that period of t=
ime)
  * Return: true if the range is valid, false otherwise.
  */
-static inline bool hmm_range_wait_until_valid(struct hmm_range *range,
-					      unsigned long timeout)
+// FIXME: hmm should handle the timeout for the driver too.
+static inline unsigned int hmm_range_start_update(struct hmm_range *range,
+						  unsigned long timeout)
 {
-	wait_event_timeout(range->hmm->wq, range->valid,
+	wait_event_timeout(range->hmm->wq,
+			   READ_ONCE(range->hmm->active_invalidates) =3D=3D 0,
 			   msecs_to_jiffies(timeout));
-	return READ_ONCE(range->valid);
+
+	// FIXME: wants a non-raw seq helper
+	seqcount_lockdep_reader_access(&range->hmm->range_invalidated);
+	range->update_seq =3D raw_seqcount_begin(&range->hmm->range_invalidated);
+	return !read_seqcount_retry(&range->hmm->range_invalidated,
+				    range->update_seq);
 }
=20
 /*
- * hmm_range_valid() - test if a range is valid or not
+ * hmm_range_needs_retry() - test if a range that has begun update
+ *                 via hmm_range_start_update() needs to be retried.
  * @range: range
- * Return: true if the range is valid, false otherwise.
+ * Return: true if the update needs to be restarted from hmm_range_start_u=
pdate(),
+ *         false otherwise.
+ */
+static inline bool hmm_range_needs_retry(struct hmm_range *range)
+{
+	return read_seqcount_retry(&range->hmm->range_invalidated,
+				   range->update_seq);
+}
+
+/*
+ * hmm_range_end_update() - finish an update of a range
+ * @range: range
+ *
+ * This must only be called while holding the device lock as described in
+ * hmm.rst, and must be called before making any of the update visible.
+ *
+ * Return: true if the update was not interrupted by an invalidation of th=
e
+ * covered virtual memory range, false if the update needs to be retried.
  */
-static inline bool hmm_range_valid(struct hmm_range *range)
+static inline bool hmm_range_end_update(struct hmm_range *range)
 {
-	return range->valid;
+	return !hmm_range_needs_retry(range);
 }
=20
 /*
@@ -511,7 +539,7 @@ static inline int hmm_mirror_range_register(struct hmm_=
range *range,
 /* This is a temporary helper to avoid merge conflict between trees. */
 static inline bool hmm_vma_range_done(struct hmm_range *range)
 {
-	bool ret =3D hmm_range_valid(range);
+	bool ret =3D !hmm_range_needs_retry(range);
=20
 	hmm_range_unregister(range);
 	return ret;
@@ -537,7 +565,7 @@ static inline int hmm_vma_fault(struct hmm_range *range=
, bool block)
 	if (ret)
 		return (int)ret;
=20
-	if (!hmm_range_wait_until_valid(range, HMM_RANGE_DEFAULT_TIMEOUT)) {
+	if (!hmm_range_start_update(range, HMM_RANGE_DEFAULT_TIMEOUT)) {
 		hmm_range_unregister(range);
 		/*
 		 * The mmap_sem was taken by driver we release it here and
@@ -549,6 +577,8 @@ static inline int hmm_vma_fault(struct hmm_range *range=
, bool block)
 	}
=20
 	ret =3D hmm_range_fault(range, block);
+	if (!hmm_range_end_update(range))
+		ret =3D -EAGAIN;
 	if (ret <=3D 0) {
 		hmm_range_unregister(range);
 		if (ret =3D=3D -EBUSY || !ret) {
diff --git a/mm/hmm.c b/mm/hmm.c
index 8396a65710e304..09725774ff6112 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -79,7 +79,8 @@ static struct hmm *hmm_get_or_create(struct mm_struct *mm=
)
 	INIT_LIST_HEAD(&hmm->ranges);
 	mutex_init(&hmm->lock);
 	kref_init(&hmm->kref);
-	hmm->notifiers =3D 0;
+	hmm->active_invalidates =3D 0;
+	seqcount_init(&hmm->range_invalidated);
 	hmm->mm =3D mm;
 	mmgrab(mm);
=20
@@ -155,13 +156,22 @@ static void hmm_release(struct mmu_notifier *mn, stru=
ct mm_struct *mm)
 	hmm_put(hmm);
 }
=20
+static bool any_range_overlaps(struct hmm *hmm, unsigned long start, unsig=
ned long end)
+{
+	struct hmm_range *range;
+
+	list_for_each_entry(range, &hmm->ranges, list)
+		// FIXME: check me
+		if (range->start <=3D end && range->end < start)
+			return true;
+	return false;
+}
 static int hmm_invalidate_range_start(struct mmu_notifier *mn,
 			const struct mmu_notifier_range *nrange)
 {
 	struct hmm *hmm =3D container_of(mn, struct hmm, mmu_notifier);
 	struct hmm_mirror *mirror;
 	struct hmm_update update;
-	struct hmm_range *range;
 	int ret =3D 0;
=20
 	/* hmm is in progress to free */
@@ -179,13 +189,22 @@ static int hmm_invalidate_range_start(struct mmu_noti=
fier *mn,
 		ret =3D -EAGAIN;
 		goto out;
 	}
-	hmm->notifiers++;
-	list_for_each_entry(range, &hmm->ranges, list) {
-		if (update.end < range->start || update.start >=3D range->end)
-			continue;
-
-		range->valid =3D false;
-	}
+	/*
+	 * The seqcount is used as a fast but inaccurate indication that
+	 * another CPU working with a range needs to retry due to invalidation
+	 * of the same virtual address space covered by the range by this
+	 * CPU.
+	 *
+	 * It is based on the assumption that the ranges will be short lived,
+	 * so there is no need to be aggressively accurate in the mmu notifier
+	 * fast path. Any notifier intersection will cause all registered
+	 * ranges to retry.
+	 */
+	hmm->active_invalidates++;
+	// FIXME: needs a seqcount helper
+	if (!(hmm->range_invalidated.sequence & 1) &&
+	    any_range_overlaps(hmm, update.start, update.end))
+		write_seqcount_begin(&hmm->range_invalidated);
 	mutex_unlock(&hmm->lock);
=20
 	if (mmu_notifier_range_blockable(nrange))
@@ -218,15 +237,11 @@ static void hmm_invalidate_range_end(struct mmu_notif=
ier *mn,
 		return;
=20
 	mutex_lock(&hmm->lock);
-	hmm->notifiers--;
-	if (!hmm->notifiers) {
-		struct hmm_range *range;
-
-		list_for_each_entry(range, &hmm->ranges, list) {
-			if (range->valid)
-				continue;
-			range->valid =3D true;
-		}
+	hmm->active_invalidates--;
+	if (hmm->active_invalidates =3D=3D 0) {
+		// FIXME: needs a seqcount helper
+		if (hmm->range_invalidated.sequence & 1)
+			write_seqcount_end(&hmm->range_invalidated);
 		wake_up_all(&hmm->wq);
 	}
 	mutex_unlock(&hmm->lock);
@@ -882,7 +897,7 @@ int hmm_range_register(struct hmm_range *range,
 {
 	unsigned long mask =3D ((1UL << page_shift) - 1UL);
=20
-	range->valid =3D false;
+	range->update_seq =3D 0;
 	range->hmm =3D NULL;
=20
 	if ((start & mask) || (end & mask))
@@ -908,15 +923,7 @@ int hmm_range_register(struct hmm_range *range,
=20
 	/* Initialize range to track CPU page table updates. */
 	mutex_lock(&range->hmm->lock);
-
 	list_add(&range->list, &range->hmm->ranges);
-
-	/*
-	 * If there are any concurrent notifiers we have to wait for them for
-	 * the range to be valid (see hmm_range_wait_until_valid()).
-	 */
-	if (!range->hmm->notifiers)
-		range->valid =3D true;
 	mutex_unlock(&range->hmm->lock);
=20
 	return 0;
@@ -947,7 +954,6 @@ void hmm_range_unregister(struct hmm_range *range)
 	hmm_put(hmm);
=20
 	/* The range is now invalid, leave it poisoned. */
-	range->valid =3D false;
 	memset(&range->hmm, POISON_INUSE, sizeof(range->hmm));
 }
 EXPORT_SYMBOL(hmm_range_unregister);
@@ -981,7 +987,7 @@ long hmm_range_snapshot(struct hmm_range *range)
=20
 	do {
 		/* If range is no longer valid force retry. */
-		if (!range->valid)
+		if (hmm_range_needs_retry(range))
 			return -EAGAIN;
=20
 		vma =3D find_vma(hmm->mm, start);
@@ -1080,7 +1086,7 @@ long hmm_range_fault(struct hmm_range *range, bool bl=
ock)
=20
 	do {
 		/* If range is no longer valid force retry. */
-		if (!range->valid) {
+		if (hmm_range_needs_retry(range)) {
 			up_read(&hmm->mm->mmap_sem);
 			return -EAGAIN;
 		}
@@ -1134,7 +1140,7 @@ long hmm_range_fault(struct hmm_range *range, bool bl=
ock)
 			start =3D hmm_vma_walk.last;
=20
 			/* Keep trying while the range is valid. */
-		} while (ret =3D=3D -EBUSY && range->valid);
+		} while (ret =3D=3D -EBUSY && !hmm_range_needs_retry(range));
=20
 		if (ret) {
 			unsigned long i;
@@ -1195,7 +1201,8 @@ long hmm_range_dma_map(struct hmm_range *range,
 			continue;
=20
 		/* Check if range is being invalidated */
-		if (!range->valid) {
+		if (hmm_range_needs_retry(range)) {
+			// ?? EAGAIN??
 			ret =3D -EBUSY;
 			goto unmap;
 		}
--=20
2.21.0

