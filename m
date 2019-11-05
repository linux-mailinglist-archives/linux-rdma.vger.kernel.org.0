Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEAD7F0839
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2019 22:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbfKEVXt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Nov 2019 16:23:49 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:2510 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729813AbfKEVXs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Nov 2019 16:23:48 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dc1e8280000>; Tue, 05 Nov 2019 13:22:48 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 05 Nov 2019 13:23:47 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 05 Nov 2019 13:23:47 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 5 Nov
 2019 21:23:46 +0000
Subject: Re: [PATCH v2 01/15] mm/mmu_notifier: define the header pre-processor
 parts even if disabled
To:     Jason Gunthorpe <jgg@ziepe.ca>, <linux-mm@kvack.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>, <Felix.Kuehling@amd.com>
CC:     <linux-rdma@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        "Dennis Dalessandro" <dennis.dalessandro@intel.com>,
        Juergen Gross <jgross@suse.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Petr Cvek <petrcvekcz@gmail.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        <nouveau@lists.freedesktop.org>, <xen-devel@lists.xenproject.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        Jason Gunthorpe <jgg@mellanox.com>
References: <20191028201032.6352-1-jgg@ziepe.ca>
 <20191028201032.6352-2-jgg@ziepe.ca>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <770248ae-efa1-efae-a978-f52d8510f7b1@nvidia.com>
Date:   Tue, 5 Nov 2019 13:23:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191028201032.6352-2-jgg@ziepe.ca>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1572988968; bh=aIPY8mqXA6lyZUc1rKx70R2LwJeuNYEhmJdJmillLnc=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=celvBsXjtms5s/fHMENIzqr1AZL6V3afb2TmXOj9/auCgSpw020ovgGj6sUJY6wUi
         8FZQW7VU2uJLmF0z7zWq5LTLWiAamnDIr/6bhHTVSgPpOmvUAR1oUqmuppIzNL3wJO
         ysV1KcarpWhwDx0XqrSBdFmymxTizUIpNIcN7AM6qREXee//lWIVE0AwpLY1l5ZIk7
         IOniAcaPCzRmZ2jCMf1W7i6xri8LcQzCVMPAcukyjxn/by0Q3PYe7Vbwx2OWpB8aKm
         Yd7LmkMXL2AGdGoFghJ6PsBH99PmbYY9fA0V8aX32R3g6ETbPcBT1SC2bBbbs4GWFg
         QOkJy1BbD1U0g==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/28/19 1:10 PM, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
>=20
> Now that we have KERNEL_HEADER_TEST all headers are generally compile
> tested, so relying on makefile tricks to avoid compiling code that depend=
s
> on CONFIG_MMU_NOTIFIER is more annoying.
>=20
> Instead follow the usual pattern and provide most of the header with only
> the functions stubbed out when CONFIG_MMU_NOTIFIER is disabled. This
> ensures code compiles no matter what the config setting is.
>=20
> While here, struct mmu_notifier_mm is private to mmu_notifier.c, move it.

and correct a minor spelling error in a comment. Good. :)

>=20
> Reviewed-by: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>  include/linux/mmu_notifier.h | 46 +++++++++++++-----------------------
>  mm/mmu_notifier.c            | 13 ++++++++++
>  2 files changed, 30 insertions(+), 29 deletions(-)
>=20

Because this is correct as-is, you can add:

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


...whether or not you take the following recommendation, which is:
you've only done part of the job of making struct mmu_notifier_mm=20
private to mmu_notifier.c. There's more:

* struct mmu_notifier_mm is referred to in two places now: mm_types.h
  and (still) mmu_notifier.h. Therefore:

    a) Move the last two traces of it out of mmu_notifier.h, and

    b) Put a forward declaration in mm_types.h, which is where it
       belongs because that's where it's referred to.

So if you apply this incremental patch on top, I think it's where
you want to be:

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 2222fa795284..df93a3cc0da9 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -25,6 +25,7 @@
=20
 struct address_space;
 struct mem_cgroup;
+struct mmu_notifier_mm;
=20
 /*
  * Each physical page in the system has a struct page associated with
diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index 51b92ba013dd..84efd2c51f5c 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -8,7 +8,6 @@
 #include <linux/srcu.h>
 #include <linux/interval_tree.h>
=20
-struct mmu_notifier_mm;
 struct mmu_notifier;
 struct mmu_notifier_range;
 struct mmu_range_notifier;
@@ -263,10 +262,7 @@ struct mmu_notifier_range {
        enum mmu_notifier_event event;
 };
=20
-static inline int mm_has_notifiers(struct mm_struct *mm)
-{
-       return unlikely(mm->mmu_notifier_mm);
-}
+int mm_has_notifiers(struct mm_struct *mm);
=20
 struct mmu_notifier *mmu_notifier_get_locked(const struct mmu_notifier_ops=
 *ops,
                                             struct mm_struct *mm);
@@ -477,10 +473,7 @@ static inline void mmu_notifier_invalidate_range(struc=
t mm_struct *mm,
                __mmu_notifier_invalidate_range(mm, start, end);
 }
=20
-static inline void mmu_notifier_mm_init(struct mm_struct *mm)
-{
-       mm->mmu_notifier_mm =3D NULL;
-}
+void mmu_notifier_mm_init(struct mm_struct *mm);
=20
 static inline void mmu_notifier_mm_destroy(struct mm_struct *mm)
 {
diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index 2b7485919ecf..107f9406a92d 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -47,6 +47,16 @@ struct mmu_notifier_mm {
        struct hlist_head deferred_list;
 };
=20
+int mm_has_notifiers(struct mm_struct *mm)
+{
+       return unlikely(mm->mmu_notifier_mm);
+}
+
+void mmu_notifier_mm_init(struct mm_struct *mm)
+{
+       mm->mmu_notifier_mm =3D NULL;
+}
+
 /*
  * This is a collision-retry read-side/write-side 'lock', a lot like a
  * seqcount, however this allows multiple write-sides to hold it at


thanks,

John Hubbard
NVIDIA

> diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
> index 1bd8e6a09a3c27..12bd603d318ce7 100644
> --- a/include/linux/mmu_notifier.h
> +++ b/include/linux/mmu_notifier.h
> @@ -7,8 +7,9 @@
>  #include <linux/mm_types.h>
>  #include <linux/srcu.h>
> =20
> +struct mmu_notifier_mm;
>  struct mmu_notifier;
> -struct mmu_notifier_ops;
> +struct mmu_notifier_range;
> =20
>  /**
>   * enum mmu_notifier_event - reason for the mmu notifier callback
> @@ -40,36 +41,8 @@ enum mmu_notifier_event {
>  	MMU_NOTIFY_SOFT_DIRTY,
>  };
> =20
> -#ifdef CONFIG_MMU_NOTIFIER
> -
> -#ifdef CONFIG_LOCKDEP
> -extern struct lockdep_map __mmu_notifier_invalidate_range_start_map;
> -#endif
> -
> -/*
> - * The mmu notifier_mm structure is allocated and installed in
> - * mm->mmu_notifier_mm inside the mm_take_all_locks() protected
> - * critical section and it's released only when mm_count reaches zero
> - * in mmdrop().
> - */
> -struct mmu_notifier_mm {
> -	/* all mmu notifiers registerd in this mm are queued in this list */
> -	struct hlist_head list;
> -	/* to serialize the list modifications and hlist_unhashed */
> -	spinlock_t lock;
> -};
> -
>  #define MMU_NOTIFIER_RANGE_BLOCKABLE (1 << 0)
> =20
> -struct mmu_notifier_range {
> -	struct vm_area_struct *vma;
> -	struct mm_struct *mm;
> -	unsigned long start;
> -	unsigned long end;
> -	unsigned flags;
> -	enum mmu_notifier_event event;
> -};
> -
>  struct mmu_notifier_ops {
>  	/*
>  	 * Called either by mmu_notifier_unregister or when the mm is
> @@ -249,6 +222,21 @@ struct mmu_notifier {
>  	unsigned int users;
>  };
> =20
> +#ifdef CONFIG_MMU_NOTIFIER
> +
> +#ifdef CONFIG_LOCKDEP
> +extern struct lockdep_map __mmu_notifier_invalidate_range_start_map;
> +#endif
> +
> +struct mmu_notifier_range {
> +	struct vm_area_struct *vma;
> +	struct mm_struct *mm;
> +	unsigned long start;
> +	unsigned long end;
> +	unsigned flags;
> +	enum mmu_notifier_event event;
> +};
> +
>  static inline int mm_has_notifiers(struct mm_struct *mm)
>  {
>  	return unlikely(mm->mmu_notifier_mm);
> diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
> index 7fde88695f35d6..367670cfd02b7b 100644
> --- a/mm/mmu_notifier.c
> +++ b/mm/mmu_notifier.c
> @@ -27,6 +27,19 @@ struct lockdep_map __mmu_notifier_invalidate_range_sta=
rt_map =3D {
>  };
>  #endif
> =20
> +/*
> + * The mmu notifier_mm structure is allocated and installed in
> + * mm->mmu_notifier_mm inside the mm_take_all_locks() protected
> + * critical section and it's released only when mm_count reaches zero
> + * in mmdrop().
> + */
> +struct mmu_notifier_mm {
> +	/* all mmu notifiers registered in this mm are queued in this list */
> +	struct hlist_head list;
> +	/* to serialize the list modifications and hlist_unhashed */
> +	spinlock_t lock;
> +};
> +
>  /*
>   * This function can't run concurrently against mmu_notifier_register
>   * because mm->mm_users > 0 during mmu_notifier_register and exit_mmap
>=20
