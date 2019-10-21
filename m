Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4D98DF526
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Oct 2019 20:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730081AbfJUSch (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Oct 2019 14:32:37 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22392 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730079AbfJUScg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Oct 2019 14:32:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571682755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I1SVWUxl8bSg5tpSz0mHn09kXdQtCr9UWEBqRSeB3w4=;
        b=HnWk/ORUJa2M3RKP4Dq/VXNDyIYajDdg92LqVPaxFkxAcuV2z09pa6sSDCfdXCKYZ1AAeT
        Bi09Fc+UqvrJVEvhE45l1cewO0EGha/EjG85a1aCgdrVnU8TYincQ9hN1ra5iA3tOh/j/c
        zMmUPaycJU7utkvQ8L5B5vJqKoevtRk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-EkGRMG7VMGe6fypj4XgZZA-1; Mon, 21 Oct 2019 14:32:29 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9679800D41;
        Mon, 21 Oct 2019 18:32:27 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.178])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E27BA194BE;
        Mon, 21 Oct 2019 18:32:26 +0000 (UTC)
Date:   Mon, 21 Oct 2019 14:32:25 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH hmm 01/15] mm/mmu_notifier: define the header
 pre-processor parts even if disabled
Message-ID: <20191021183225.GC3177@redhat.com>
References: <20191015181242.8343-1-jgg@ziepe.ca>
 <20191015181242.8343-2-jgg@ziepe.ca>
MIME-Version: 1.0
In-Reply-To: <20191015181242.8343-2-jgg@ziepe.ca>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: EkGRMG7VMGe6fypj4XgZZA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 15, 2019 at 03:12:28PM -0300, Jason Gunthorpe wrote:
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
>=20
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>

Reviewed-by: J=E9r=F4me Glisse <jglisse@redhat.com>

> ---
>  include/linux/mmu_notifier.h | 46 +++++++++++++-----------------------
>  mm/mmu_notifier.c            | 13 ++++++++++
>  2 files changed, 30 insertions(+), 29 deletions(-)
>=20
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
>  =09MMU_NOTIFY_SOFT_DIRTY,
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
> -=09/* all mmu notifiers registerd in this mm are queued in this list */
> -=09struct hlist_head list;
> -=09/* to serialize the list modifications and hlist_unhashed */
> -=09spinlock_t lock;
> -};
> -
>  #define MMU_NOTIFIER_RANGE_BLOCKABLE (1 << 0)
> =20
> -struct mmu_notifier_range {
> -=09struct vm_area_struct *vma;
> -=09struct mm_struct *mm;
> -=09unsigned long start;
> -=09unsigned long end;
> -=09unsigned flags;
> -=09enum mmu_notifier_event event;
> -};
> -
>  struct mmu_notifier_ops {
>  =09/*
>  =09 * Called either by mmu_notifier_unregister or when the mm is
> @@ -249,6 +222,21 @@ struct mmu_notifier {
>  =09unsigned int users;
>  };
> =20
> +#ifdef CONFIG_MMU_NOTIFIER
> +
> +#ifdef CONFIG_LOCKDEP
> +extern struct lockdep_map __mmu_notifier_invalidate_range_start_map;
> +#endif
> +
> +struct mmu_notifier_range {
> +=09struct vm_area_struct *vma;
> +=09struct mm_struct *mm;
> +=09unsigned long start;
> +=09unsigned long end;
> +=09unsigned flags;
> +=09enum mmu_notifier_event event;
> +};
> +
>  static inline int mm_has_notifiers(struct mm_struct *mm)
>  {
>  =09return unlikely(mm->mmu_notifier_mm);
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
> +=09/* all mmu notifiers registered in this mm are queued in this list */
> +=09struct hlist_head list;
> +=09/* to serialize the list modifications and hlist_unhashed */
> +=09spinlock_t lock;
> +};
> +
>  /*
>   * This function can't run concurrently against mmu_notifier_register
>   * because mm->mm_users > 0 during mmu_notifier_register and exit_mmap
> --=20
> 2.23.0
>=20

