Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A68C586B1
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2019 18:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfF0QI0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jun 2019 12:08:26 -0400
Received: from mail-eopbgr30040.outbound.protection.outlook.com ([40.107.3.40]:60324
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726384AbfF0QI0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 Jun 2019 12:08:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SGkwwmIV/4fRYXD3CmAb3unUE9sRM30TVndBfnniR9c=;
 b=YYHP3GuHzhGbdXg5reCYsFPDUhmA+DkLJMKhGo171UBxov93hTdGb9lzYbfpx15vIH56YObbLbddwRj8Jjxiqb64DqhjWLjq2/WoMO039+b4Eut9nIgJ794XWhDzUs9KH8cP3yzu45Im7TwuMKm+75XbDRpscHqJRolGU7s3UTI=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB3311.eurprd05.prod.outlook.com (10.170.238.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Thu, 27 Jun 2019 16:06:42 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2008.014; Thu, 27 Jun 2019
 16:06:42 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Ralph Campbell <rcampbell@nvidia.com>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Philip Yang <Philip.Yang@amd.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v4 hmm 12/12] mm/hmm: Fix error flows in
 hmm_invalidate_range_start
Thread-Topic: [PATCH v4 hmm 12/12] mm/hmm: Fix error flows in
 hmm_invalidate_range_start
Thread-Index: AQHVKtAWpiTCnV8eRE6ctCBvYteNVqauQXSAgAFtgAA=
Date:   Thu, 27 Jun 2019 16:06:41 +0000
Message-ID: <20190627160634.GA9499@mellanox.com>
References: <20190624210110.5098-1-jgg@ziepe.ca>
 <20190624210110.5098-13-jgg@ziepe.ca>
 <035fa354-6caa-3738-b84d-20804813009a@nvidia.com>
In-Reply-To: <035fa354-6caa-3738-b84d-20804813009a@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BY5PR13CA0008.namprd13.prod.outlook.com
 (2603:10b6:a03:180::21) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [12.199.206.50]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec3a211b-e371-4553-1307-08d6fb197147
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB3311;
x-ms-traffictypediagnostic: VI1PR05MB3311:
x-microsoft-antispam-prvs: <VI1PR05MB331172A51AD9181A847209B3CFFD0@VI1PR05MB3311.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 008184426E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(366004)(39860400002)(376002)(199004)(189003)(66556008)(71190400001)(5660300002)(14454004)(66476007)(86362001)(25786009)(71200400001)(6512007)(53936002)(7736002)(446003)(316002)(486006)(8936002)(229853002)(76176011)(52116002)(186003)(66946007)(6246003)(476003)(64756008)(73956011)(6436002)(1076003)(8676002)(81166006)(81156014)(386003)(6506007)(99286004)(14444005)(7416002)(66446008)(256004)(3846002)(6486002)(26005)(53546011)(66066001)(2906002)(6116002)(11346002)(33656002)(2616005)(54906003)(36756003)(102836004)(6916009)(478600001)(4326008)(68736007)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3311;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VJ2RNZDvbOtGDnH5zaCy4+jCp5cRcLYjsaVcAs/UMu9JgFJ1f4JIhp268n6UEI5OFpUKGQV1qZihqzGoc+i//WsW/MzunRnK/xd8lPnB186y9kxEji8mXcJbIdTK3ttNN9wsvo3srsfMH5fiIn2pH5+2uk7y9hauHE42fRuwddeYa5/7D7qddIq78nMyprVFStLoaC7ApAsWEWAAvV+1LzD4rHxRAiC3UmCzVRfd/QpsmJb2HQnwS6XRk7e618LwARA3ER67uw3hAsT/RoJslQNcZ4iVEjTgg5XSe2cbF075P9Pu72qDOWxtRG7ejrbfv/CdwBzcVSHZ4UhJrpAqhQlpCdFNk+yiPynFGgVO4D3PEmt/wK1b/aLmoaW1Y+ZeX/iOL0bPDncQZbgSt94bZOSKTtB2b8sxouslJl7cf7g=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <93A213DE25C0DA43B1A6F1B8214CA1F7@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec3a211b-e371-4553-1307-08d6fb197147
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2019 16:06:42.0067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3311
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 26, 2019 at 11:18:23AM -0700, Ralph Campbell wrote:
> > diff --git a/mm/hmm.c b/mm/hmm.c
> > index b224ea635a7716..89549eac03d506 100644
> > +++ b/mm/hmm.c
> > @@ -64,7 +64,7 @@ static struct hmm *hmm_get_or_create(struct mm_struct=
 *mm)
> >   	init_rwsem(&hmm->mirrors_sem);
> >   	hmm->mmu_notifier.ops =3D NULL;
> >   	INIT_LIST_HEAD(&hmm->ranges);
> > -	mutex_init(&hmm->lock);
> > +	spin_lock_init(&hmm->ranges_lock);
> >   	kref_init(&hmm->kref);
> >   	hmm->notifiers =3D 0;
> >   	hmm->mm =3D mm;
> > @@ -144,6 +144,23 @@ static void hmm_release(struct mmu_notifier *mn, s=
truct mm_struct *mm)
> >   	hmm_put(hmm);
> >   }
> > +static void notifiers_decrement(struct hmm *hmm)
> > +{
> > +	lockdep_assert_held(&hmm->ranges_lock);
> > +
>=20
> Why not acquire the lock here and release at the end instead
> of asserting the lock is held?
> It looks like everywhere notifiers_decrement() is called does
> that.

Yes, this is just some left over mistake, thanks

From aa371c720a9e3c632dcd9a6a2c73e325b9b2b98c Mon Sep 17 00:00:00 2001
From: Jason Gunthorpe <jgg@mellanox.com>
Date: Fri, 7 Jun 2019 12:10:33 -0300
Subject: [PATCH] mm/hmm: Fix error flows in hmm_invalidate_range_start

If the trylock on the hmm->mirrors_sem fails the function will return
without decrementing the notifiers that were previously incremented. Since
the caller will not call invalidate_range_end() on EAGAIN this will result
in notifiers becoming permanently incremented and deadlock.

If the sync_cpu_device_pagetables() required blocking the function will
not return EAGAIN even though the device continues to touch the
pages. This is a violation of the mmu notifier contract.

Switch, and rename, the ranges_lock to a spin lock so we can reliably
obtain it without blocking during error unwind.

The error unwind is necessary since the notifiers count must be held
incremented across the call to sync_cpu_device_pagetables() as we cannot
allow the range to become marked valid by a parallel
invalidate_start/end() pair while doing sync_cpu_device_pagetables().

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Philip Yang <Philip.Yang@amd.com>
---
v4
 - Move lock into notifiers_decrement() (Ralph)
---
 include/linux/hmm.h |  2 +-
 mm/hmm.c            | 69 ++++++++++++++++++++++++++-------------------
 2 files changed, 41 insertions(+), 30 deletions(-)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index bf013e96525771..0fa8ea34ccef6d 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -86,7 +86,7 @@
 struct hmm {
 	struct mm_struct	*mm;
 	struct kref		kref;
-	struct mutex		lock;
+	spinlock_t		ranges_lock;
 	struct list_head	ranges;
 	struct list_head	mirrors;
 	struct mmu_notifier	mmu_notifier;
diff --git a/mm/hmm.c b/mm/hmm.c
index b224ea635a7716..de35289df20d43 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -64,7 +64,7 @@ static struct hmm *hmm_get_or_create(struct mm_struct *mm=
)
 	init_rwsem(&hmm->mirrors_sem);
 	hmm->mmu_notifier.ops =3D NULL;
 	INIT_LIST_HEAD(&hmm->ranges);
-	mutex_init(&hmm->lock);
+	spin_lock_init(&hmm->ranges_lock);
 	kref_init(&hmm->kref);
 	hmm->notifiers =3D 0;
 	hmm->mm =3D mm;
@@ -144,6 +144,25 @@ static void hmm_release(struct mmu_notifier *mn, struc=
t mm_struct *mm)
 	hmm_put(hmm);
 }
=20
+static void notifiers_decrement(struct hmm *hmm)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&hmm->ranges_lock, flags);
+	hmm->notifiers--;
+	if (!hmm->notifiers) {
+		struct hmm_range *range;
+
+		list_for_each_entry(range, &hmm->ranges, list) {
+			if (range->valid)
+				continue;
+			range->valid =3D true;
+		}
+		wake_up_all(&hmm->wq);
+	}
+	spin_unlock_irqrestore(&hmm->ranges_lock, flags);
+}
+
 static int hmm_invalidate_range_start(struct mmu_notifier *mn,
 			const struct mmu_notifier_range *nrange)
 {
@@ -151,6 +170,7 @@ static int hmm_invalidate_range_start(struct mmu_notifi=
er *mn,
 	struct hmm_mirror *mirror;
 	struct hmm_update update;
 	struct hmm_range *range;
+	unsigned long flags;
 	int ret =3D 0;
=20
 	if (!kref_get_unless_zero(&hmm->kref))
@@ -161,12 +181,7 @@ static int hmm_invalidate_range_start(struct mmu_notif=
ier *mn,
 	update.event =3D HMM_UPDATE_INVALIDATE;
 	update.blockable =3D mmu_notifier_range_blockable(nrange);
=20
-	if (mmu_notifier_range_blockable(nrange))
-		mutex_lock(&hmm->lock);
-	else if (!mutex_trylock(&hmm->lock)) {
-		ret =3D -EAGAIN;
-		goto out;
-	}
+	spin_lock_irqsave(&hmm->ranges_lock, flags);
 	hmm->notifiers++;
 	list_for_each_entry(range, &hmm->ranges, list) {
 		if (update.end < range->start || update.start >=3D range->end)
@@ -174,7 +189,7 @@ static int hmm_invalidate_range_start(struct mmu_notifi=
er *mn,
=20
 		range->valid =3D false;
 	}
-	mutex_unlock(&hmm->lock);
+	spin_unlock_irqrestore(&hmm->ranges_lock, flags);
=20
 	if (mmu_notifier_range_blockable(nrange))
 		down_read(&hmm->mirrors_sem);
@@ -182,16 +197,23 @@ static int hmm_invalidate_range_start(struct mmu_noti=
fier *mn,
 		ret =3D -EAGAIN;
 		goto out;
 	}
+
 	list_for_each_entry(mirror, &hmm->mirrors, list) {
-		int ret;
+		int rc;
=20
-		ret =3D mirror->ops->sync_cpu_device_pagetables(mirror, &update);
-		if (!update.blockable && ret =3D=3D -EAGAIN)
+		rc =3D mirror->ops->sync_cpu_device_pagetables(mirror, &update);
+		if (rc) {
+			if (WARN_ON(update.blockable || rc !=3D -EAGAIN))
+				continue;
+			ret =3D -EAGAIN;
 			break;
+		}
 	}
 	up_read(&hmm->mirrors_sem);
=20
 out:
+	if (ret)
+		notifiers_decrement(hmm);
 	hmm_put(hmm);
 	return ret;
 }
@@ -204,20 +226,7 @@ static void hmm_invalidate_range_end(struct mmu_notifi=
er *mn,
 	if (!kref_get_unless_zero(&hmm->kref))
 		return;
=20
-	mutex_lock(&hmm->lock);
-	hmm->notifiers--;
-	if (!hmm->notifiers) {
-		struct hmm_range *range;
-
-		list_for_each_entry(range, &hmm->ranges, list) {
-			if (range->valid)
-				continue;
-			range->valid =3D true;
-		}
-		wake_up_all(&hmm->wq);
-	}
-	mutex_unlock(&hmm->lock);
-
+	notifiers_decrement(hmm);
 	hmm_put(hmm);
 }
=20
@@ -868,6 +877,7 @@ int hmm_range_register(struct hmm_range *range,
 {
 	unsigned long mask =3D ((1UL << page_shift) - 1UL);
 	struct hmm *hmm =3D mirror->hmm;
+	unsigned long flags;
=20
 	range->valid =3D false;
 	range->hmm =3D NULL;
@@ -886,7 +896,7 @@ int hmm_range_register(struct hmm_range *range,
 		return -EFAULT;
=20
 	/* Initialize range to track CPU page table updates. */
-	mutex_lock(&hmm->lock);
+	spin_lock_irqsave(&hmm->ranges_lock, flags);
=20
 	range->hmm =3D hmm;
 	kref_get(&hmm->kref);
@@ -898,7 +908,7 @@ int hmm_range_register(struct hmm_range *range,
 	 */
 	if (!hmm->notifiers)
 		range->valid =3D true;
-	mutex_unlock(&hmm->lock);
+	spin_unlock_irqrestore(&hmm->ranges_lock, flags);
=20
 	return 0;
 }
@@ -914,10 +924,11 @@ EXPORT_SYMBOL(hmm_range_register);
 void hmm_range_unregister(struct hmm_range *range)
 {
 	struct hmm *hmm =3D range->hmm;
+	unsigned long flags;
=20
-	mutex_lock(&hmm->lock);
+	spin_lock_irqsave(&hmm->ranges_lock, flags);
 	list_del_init(&range->list);
-	mutex_unlock(&hmm->lock);
+	spin_unlock_irqrestore(&hmm->ranges_lock, flags);
=20
 	/* Drop reference taken by hmm_range_register() */
 	mmput(hmm->mm);
--=20
2.22.0




