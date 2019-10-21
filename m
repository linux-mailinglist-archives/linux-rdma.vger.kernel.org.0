Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEF7DF538
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Oct 2019 20:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbfJUSij (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Oct 2019 14:38:39 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39490 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727211AbfJUSij (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Oct 2019 14:38:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571683116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Oe6n9GNO3tq7+Ws0m2nz5EXI0lFRurAPgB7xY0bHjcg=;
        b=c7kuMLoR8osAsq5Iiv8SWWfO0EelNVUhEf3L+gl7fp5ZcCf0Sbk3/EQlcsVOwZQZwdOM5Z
        qTtBHUEePyAJrzUWLYUh1Z+BDCTstmVx90gTzKHjVzPwfWHH8bJaCE+Fc5XCFPGC6PiqnK
        vhcNwwtyZIXCfOc61VhZgKktOEaNXyI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-Eb7EqaHZP567Hpt9ExBGXg-1; Mon, 21 Oct 2019 14:38:30 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A09EA1800D79;
        Mon, 21 Oct 2019 18:38:28 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.178])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 199FD5DA2C;
        Mon, 21 Oct 2019 18:38:26 +0000 (UTC)
Date:   Mon, 21 Oct 2019 14:38:24 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH hmm 15/15] mm/hmm: remove hmm_mirror and related
Message-ID: <20191021183824.GE3177@redhat.com>
References: <20191015181242.8343-1-jgg@ziepe.ca>
 <20191015181242.8343-16-jgg@ziepe.ca>
MIME-Version: 1.0
In-Reply-To: <20191015181242.8343-16-jgg@ziepe.ca>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: Eb7EqaHZP567Hpt9ExBGXg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 15, 2019 at 03:12:42PM -0300, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
>=20
> The only two users of this are now converted to use mmu_range_notifier,
> delete all the code and update hmm.rst.

I guess i should point out that the reasons for hmm_mirror and hmm
was for:
    1) Maybe define a common API for userspace to provide memory
       placement hints (NUMA for GPU)
    2) multi-devices sharing same mirror page table

But support for multi-GPU in nouveau is way behind and i guess such
optimization will have to re-materialize what is necessary once that
happens.

Note this patch should also update kernel/fork.c and the mm_struct
definition AFAICT. With those changes you can add my:

Reviewed-by: J=E9r=F4me Glisse <jglisse@redhat.com>

>=20
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>  Documentation/vm/hmm.rst | 105 ++++-----------
>  include/linux/hmm.h      | 183 +------------------------
>  mm/Kconfig               |   1 -
>  mm/hmm.c                 | 284 +--------------------------------------
>  4 files changed, 33 insertions(+), 540 deletions(-)
>=20
> diff --git a/Documentation/vm/hmm.rst b/Documentation/vm/hmm.rst
> index 0a5960beccf76d..a247643035c4e2 100644
> --- a/Documentation/vm/hmm.rst
> +++ b/Documentation/vm/hmm.rst
> @@ -147,49 +147,16 @@ Address space mirroring implementation and API
>  Address space mirroring's main objective is to allow duplication of a ra=
nge of
>  CPU page table into a device page table; HMM helps keep both synchronize=
d. A
>  device driver that wants to mirror a process address space must start wi=
th the
> -registration of an hmm_mirror struct::
> -
> - int hmm_mirror_register(struct hmm_mirror *mirror,
> -                         struct mm_struct *mm);
> -
> -The mirror struct has a set of callbacks that are used
> -to propagate CPU page tables::
> -
> - struct hmm_mirror_ops {
> -     /* release() - release hmm_mirror
> -      *
> -      * @mirror: pointer to struct hmm_mirror
> -      *
> -      * This is called when the mm_struct is being released.  The callba=
ck
> -      * must ensure that all access to any pages obtained from this mirr=
or
> -      * is halted before the callback returns. All future access should
> -      * fault.
> -      */
> -     void (*release)(struct hmm_mirror *mirror);
> -
> -     /* sync_cpu_device_pagetables() - synchronize page tables
> -      *
> -      * @mirror: pointer to struct hmm_mirror
> -      * @update: update information (see struct mmu_notifier_range)
> -      * Return: -EAGAIN if update.blockable false and callback need to
> -      *         block, 0 otherwise.
> -      *
> -      * This callback ultimately originates from mmu_notifiers when the =
CPU
> -      * page table is updated. The device driver must update its page ta=
ble
> -      * in response to this callback. The update argument tells what act=
ion
> -      * to perform.
> -      *
> -      * The device driver must not return from this callback until the d=
evice
> -      * page tables are completely updated (TLBs flushed, etc); this is =
a
> -      * synchronous call.
> -      */
> -     int (*sync_cpu_device_pagetables)(struct hmm_mirror *mirror,
> -                                       const struct hmm_update *update);
> - };
> -
> -The device driver must perform the update action to the range (mark rang=
e
> -read only, or fully unmap, etc.). The device must complete the update be=
fore
> -the driver callback returns.
> +registration of a mmu_range_notifier::
> +
> + mrn->ops =3D &driver_ops;
> + int mmu_range_notifier_insert(struct mmu_range_notifier *mrn,
> +=09=09=09      unsigned long start, unsigned long length,
> +=09=09=09      struct mm_struct *mm);
> +
> +During the driver_ops->invalidate() callback the device driver must perf=
orm
> +the update action to the range (mark range read only, or fully unmap,
> +etc.). The device must complete the update before the driver callback re=
turns.
> =20
>  When the device driver wants to populate a range of virtual addresses, i=
t can
>  use::
> @@ -216,70 +183,46 @@ The usage pattern is::
>        struct hmm_range range;
>        ...
> =20
> +      range.notifier =3D &mrn;
>        range.start =3D ...;
>        range.end =3D ...;
>        range.pfns =3D ...;
>        range.flags =3D ...;
>        range.values =3D ...;
>        range.pfn_shift =3D ...;
> -      hmm_range_register(&range, mirror);
> =20
> -      /*
> -       * Just wait for range to be valid, safe to ignore return value as=
 we
> -       * will use the return value of hmm_range_fault() below under the
> -       * mmap_sem to ascertain the validity of the range.
> -       */
> -      hmm_range_wait_until_valid(&range, TIMEOUT_IN_MSEC);
> +      if (!mmget_not_zero(mrn->notifier.mm))
> +          return -EFAULT;
> =20
>   again:
> +      range.notifier_seq =3D mmu_range_read_begin(&mrn);
>        down_read(&mm->mmap_sem);
>        ret =3D hmm_range_fault(&range, HMM_RANGE_SNAPSHOT);
>        if (ret) {
>            up_read(&mm->mmap_sem);
> -          if (ret =3D=3D -EBUSY) {
> -            /*
> -             * No need to check hmm_range_wait_until_valid() return valu=
e
> -             * on retry we will get proper error with hmm_range_fault()
> -             */
> -            hmm_range_wait_until_valid(&range, TIMEOUT_IN_MSEC);
> -            goto again;
> -          }
> -          hmm_range_unregister(&range);
> +          if (ret =3D=3D -EBUSY)
> +                 goto again;
>            return ret;
>        }
> +      up_read(&mm->mmap_sem);
> +
>        take_lock(driver->update);
> -      if (!hmm_range_valid(&range)) {
> +      if (mmu_range_read_retry(&mrn, range.notifier_seq) {
>            release_lock(driver->update);
> -          up_read(&mm->mmap_sem);
>            goto again;
>        }
> =20
> -      // Use pfns array content to update device page table
> +      /* Use pfns array content to update device page table,
> +       * under the update lock */
> =20
> -      hmm_range_unregister(&range);
>        release_lock(driver->update);
> -      up_read(&mm->mmap_sem);
>        return 0;
>   }
> =20
>  The driver->update lock is the same lock that the driver takes inside it=
s
> -sync_cpu_device_pagetables() callback. That lock must be held before cal=
ling
> -hmm_range_valid() to avoid any race with a concurrent CPU page table upd=
ate.
> -
> -HMM implements all this on top of the mmu_notifier API because we wanted=
 a
> -simpler API and also to be able to perform optimizations latter on like =
doing
> -concurrent device updates in multi-devices scenario.
> -
> -HMM also serves as an impedance mismatch between how CPU page table upda=
tes
> -are done (by CPU write to the page table and TLB flushes) and how device=
s
> -update their own page table. Device updates are a multi-step process. Fi=
rst,
> -appropriate commands are written to a buffer, then this buffer is schedu=
led for
> -execution on the device. It is only once the device has executed command=
s in
> -the buffer that the update is done. Creating and scheduling the update c=
ommand
> -buffer can happen concurrently for multiple devices. Waiting for each de=
vice to
> -report commands as executed is serialized (there is no point in doing th=
is
> -concurrently).
> -
> +invalidate() callback. That lock must be held before calling
> +mmu_range_read_retry() to avoid any race with a concurrent CPU page tabl=
e
> +update.
> =20
>  Leverage default_flags and pfn_flags_mask
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/include/linux/hmm.h b/include/linux/hmm.h
> index 2666eb08a40615..b4af5173523232 100644
> --- a/include/linux/hmm.h
> +++ b/include/linux/hmm.h
> @@ -68,29 +68,6 @@
>  #include <linux/completion.h>
>  #include <linux/mmu_notifier.h>
> =20
> -
> -/*
> - * struct hmm - HMM per mm struct
> - *
> - * @mm: mm struct this HMM struct is bound to
> - * @lock: lock protecting ranges list
> - * @ranges: list of range being snapshotted
> - * @mirrors: list of mirrors for this mm
> - * @mmu_notifier: mmu notifier to track updates to CPU page table
> - * @mirrors_sem: read/write semaphore protecting the mirrors list
> - * @wq: wait queue for user waiting on a range invalidation
> - * @notifiers: count of active mmu notifiers
> - */
> -struct hmm {
> -=09struct mmu_notifier=09mmu_notifier;
> -=09spinlock_t=09=09ranges_lock;
> -=09struct list_head=09ranges;
> -=09struct list_head=09mirrors;
> -=09struct rw_semaphore=09mirrors_sem;
> -=09wait_queue_head_t=09wq;
> -=09long=09=09=09notifiers;
> -};
> -
>  /*
>   * hmm_pfn_flag_e - HMM flag enums
>   *
> @@ -143,9 +120,8 @@ enum hmm_pfn_value_e {
>  /*
>   * struct hmm_range - track invalidation lock on virtual address range
>   *
> - * @notifier: an optional mmu_range_notifier
> - * @notifier_seq: when notifier is used this is the result of
> - *                mmu_range_read_begin()
> + * @notifier: a mmu_range_notifier that includes the start/end
> + * @notifier_seq: result of mmu_range_read_begin()
>   * @hmm: the core HMM structure this range is active against
>   * @vma: the vm area struct for the range
>   * @list: all range lock are on a list
> @@ -162,8 +138,6 @@ enum hmm_pfn_value_e {
>  struct hmm_range {
>  =09struct mmu_range_notifier *notifier;
>  =09unsigned long=09=09notifier_seq;
> -=09struct hmm=09=09*hmm;
> -=09struct list_head=09list;
>  =09unsigned long=09=09start;
>  =09unsigned long=09=09end;
>  =09uint64_t=09=09*pfns;
> @@ -172,32 +146,8 @@ struct hmm_range {
>  =09uint64_t=09=09default_flags;
>  =09uint64_t=09=09pfn_flags_mask;
>  =09uint8_t=09=09=09pfn_shift;
> -=09bool=09=09=09valid;
>  };
> =20
> -/*
> - * hmm_range_wait_until_valid() - wait for range to be valid
> - * @range: range affected by invalidation to wait on
> - * @timeout: time out for wait in ms (ie abort wait after that period of=
 time)
> - * Return: true if the range is valid, false otherwise.
> - */
> -static inline bool hmm_range_wait_until_valid(struct hmm_range *range,
> -=09=09=09=09=09      unsigned long timeout)
> -{
> -=09return wait_event_timeout(range->hmm->wq, range->valid,
> -=09=09=09=09  msecs_to_jiffies(timeout)) !=3D 0;
> -}
> -
> -/*
> - * hmm_range_valid() - test if a range is valid or not
> - * @range: range
> - * Return: true if the range is valid, false otherwise.
> - */
> -static inline bool hmm_range_valid(struct hmm_range *range)
> -{
> -=09return range->valid;
> -}
> -
>  /*
>   * hmm_device_entry_to_page() - return struct page pointed to by a devic=
e entry
>   * @range: range use to decode device entry value
> @@ -267,111 +217,6 @@ static inline uint64_t hmm_device_entry_from_pfn(co=
nst struct hmm_range *range,
>  =09=09range->flags[HMM_PFN_VALID];
>  }
> =20
> -/*
> - * Mirroring: how to synchronize device page table with CPU page table.
> - *
> - * A device driver that is participating in HMM mirroring must always
> - * synchronize with CPU page table updates. For this, device drivers can=
 either
> - * directly use mmu_notifier APIs or they can use the hmm_mirror API. De=
vice
> - * drivers can decide to register one mirror per device per process, or =
just
> - * one mirror per process for a group of devices. The pattern is:
> - *
> - *      int device_bind_address_space(..., struct mm_struct *mm, ...)
> - *      {
> - *          struct device_address_space *das;
> - *
> - *          // Device driver specific initialization, and allocation of =
das
> - *          // which contains an hmm_mirror struct as one of its fields.
> - *          ...
> - *
> - *          ret =3D hmm_mirror_register(&das->mirror, mm, &device_mirror=
_ops);
> - *          if (ret) {
> - *              // Cleanup on error
> - *              return ret;
> - *          }
> - *
> - *          // Other device driver specific initialization
> - *          ...
> - *      }
> - *
> - * Once an hmm_mirror is registered for an address space, the device dri=
ver
> - * will get callbacks through sync_cpu_device_pagetables() operation (se=
e
> - * hmm_mirror_ops struct).
> - *
> - * Device driver must not free the struct containing the hmm_mirror stru=
ct
> - * before calling hmm_mirror_unregister(). The expected usage is to do t=
hat when
> - * the device driver is unbinding from an address space.
> - *
> - *
> - *      void device_unbind_address_space(struct device_address_space *da=
s)
> - *      {
> - *          // Device driver specific cleanup
> - *          ...
> - *
> - *          hmm_mirror_unregister(&das->mirror);
> - *
> - *          // Other device driver specific cleanup, and now das can be =
freed
> - *          ...
> - *      }
> - */
> -
> -struct hmm_mirror;
> -
> -/*
> - * struct hmm_mirror_ops - HMM mirror device operations callback
> - *
> - * @update: callback to update range on a device
> - */
> -struct hmm_mirror_ops {
> -=09/* release() - release hmm_mirror
> -=09 *
> -=09 * @mirror: pointer to struct hmm_mirror
> -=09 *
> -=09 * This is called when the mm_struct is being released.  The callback
> -=09 * must ensure that all access to any pages obtained from this mirror
> -=09 * is halted before the callback returns. All future access should
> -=09 * fault.
> -=09 */
> -=09void (*release)(struct hmm_mirror *mirror);
> -
> -=09/* sync_cpu_device_pagetables() - synchronize page tables
> -=09 *
> -=09 * @mirror: pointer to struct hmm_mirror
> -=09 * @update: update information (see struct mmu_notifier_range)
> -=09 * Return: -EAGAIN if mmu_notifier_range_blockable(update) is false
> -=09 * and callback needs to block, 0 otherwise.
> -=09 *
> -=09 * This callback ultimately originates from mmu_notifiers when the CP=
U
> -=09 * page table is updated. The device driver must update its page tabl=
e
> -=09 * in response to this callback. The update argument tells what actio=
n
> -=09 * to perform.
> -=09 *
> -=09 * The device driver must not return from this callback until the dev=
ice
> -=09 * page tables are completely updated (TLBs flushed, etc); this is a
> -=09 * synchronous call.
> -=09 */
> -=09int (*sync_cpu_device_pagetables)(
> -=09=09struct hmm_mirror *mirror,
> -=09=09const struct mmu_notifier_range *update);
> -};
> -
> -/*
> - * struct hmm_mirror - mirror struct for a device driver
> - *
> - * @hmm: pointer to struct hmm (which is unique per mm_struct)
> - * @ops: device driver callback for HMM mirror operations
> - * @list: for list of mirrors of a given mm
> - *
> - * Each address space (mm_struct) being mirrored by a device must regist=
er one
> - * instance of an hmm_mirror struct with HMM. HMM will track the list of=
 all
> - * mirrors for each mm_struct.
> - */
> -struct hmm_mirror {
> -=09struct hmm=09=09=09*hmm;
> -=09const struct hmm_mirror_ops=09*ops;
> -=09struct list_head=09=09list;
> -};
> -
>  /*
>   * Retry fault if non-blocking, drop mmap_sem and return -EAGAIN in that=
 case.
>   */
> @@ -381,15 +226,9 @@ struct hmm_mirror {
>  #define HMM_FAULT_SNAPSHOT=09=09(1 << 1)
> =20
>  #ifdef CONFIG_HMM_MIRROR
> -int hmm_mirror_register(struct hmm_mirror *mirror, struct mm_struct *mm)=
;
> -void hmm_mirror_unregister(struct hmm_mirror *mirror);
> -
>  /*
>   * Please see Documentation/vm/hmm.rst for how to use the range API.
>   */
> -int hmm_range_register(struct hmm_range *range, struct hmm_mirror *mirro=
r);
> -void hmm_range_unregister(struct hmm_range *range);
> -
>  long hmm_range_fault(struct hmm_range *range, unsigned int flags);
> =20
>  long hmm_range_dma_map(struct hmm_range *range,
> @@ -401,24 +240,6 @@ long hmm_range_dma_unmap(struct hmm_range *range,
>  =09=09=09 dma_addr_t *daddrs,
>  =09=09=09 bool dirty);
>  #else
> -int hmm_mirror_register(struct hmm_mirror *mirror, struct mm_struct *mm)
> -{
> -=09return -EOPNOTSUPP;
> -}
> -
> -void hmm_mirror_unregister(struct hmm_mirror *mirror)
> -{
> -}
> -
> -int hmm_range_register(struct hmm_range *range, struct hmm_mirror *mirro=
r)
> -{
> -=09return -EOPNOTSUPP;
> -}
> -
> -void hmm_range_unregister(struct hmm_range *range)
> -{
> -}
> -
>  static inline long hmm_range_fault(struct hmm_range *range, unsigned int=
 flags)
>  {
>  =09return -EOPNOTSUPP;
> diff --git a/mm/Kconfig b/mm/Kconfig
> index d0b5046d9aeffd..e38ff1d5968dbf 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -675,7 +675,6 @@ config DEV_PAGEMAP_OPS
>  config HMM_MIRROR
>  =09bool
>  =09depends on MMU
> -=09depends on MMU_NOTIFIER
> =20
>  config DEVICE_PRIVATE
>  =09bool "Unaddressable device memory (GPU memory, ...)"
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 22ac3595771feb..75d15a820e182e 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -26,193 +26,6 @@
>  #include <linux/mmu_notifier.h>
>  #include <linux/memory_hotplug.h>
> =20
> -static struct mmu_notifier *hmm_alloc_notifier(struct mm_struct *mm)
> -{
> -=09struct hmm *hmm;
> -
> -=09hmm =3D kzalloc(sizeof(*hmm), GFP_KERNEL);
> -=09if (!hmm)
> -=09=09return ERR_PTR(-ENOMEM);
> -
> -=09init_waitqueue_head(&hmm->wq);
> -=09INIT_LIST_HEAD(&hmm->mirrors);
> -=09init_rwsem(&hmm->mirrors_sem);
> -=09INIT_LIST_HEAD(&hmm->ranges);
> -=09spin_lock_init(&hmm->ranges_lock);
> -=09hmm->notifiers =3D 0;
> -=09return &hmm->mmu_notifier;
> -}
> -
> -static void hmm_free_notifier(struct mmu_notifier *mn)
> -{
> -=09struct hmm *hmm =3D container_of(mn, struct hmm, mmu_notifier);
> -
> -=09WARN_ON(!list_empty(&hmm->ranges));
> -=09WARN_ON(!list_empty(&hmm->mirrors));
> -=09kfree(hmm);
> -}
> -
> -static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
> -{
> -=09struct hmm *hmm =3D container_of(mn, struct hmm, mmu_notifier);
> -=09struct hmm_mirror *mirror;
> -
> -=09/*
> -=09 * Since hmm_range_register() holds the mmget() lock hmm_release() is
> -=09 * prevented as long as a range exists.
> -=09 */
> -=09WARN_ON(!list_empty_careful(&hmm->ranges));
> -
> -=09down_read(&hmm->mirrors_sem);
> -=09list_for_each_entry(mirror, &hmm->mirrors, list) {
> -=09=09/*
> -=09=09 * Note: The driver is not allowed to trigger
> -=09=09 * hmm_mirror_unregister() from this thread.
> -=09=09 */
> -=09=09if (mirror->ops->release)
> -=09=09=09mirror->ops->release(mirror);
> -=09}
> -=09up_read(&hmm->mirrors_sem);
> -}
> -
> -static void notifiers_decrement(struct hmm *hmm)
> -{
> -=09unsigned long flags;
> -
> -=09spin_lock_irqsave(&hmm->ranges_lock, flags);
> -=09hmm->notifiers--;
> -=09if (!hmm->notifiers) {
> -=09=09struct hmm_range *range;
> -
> -=09=09list_for_each_entry(range, &hmm->ranges, list) {
> -=09=09=09if (range->valid)
> -=09=09=09=09continue;
> -=09=09=09range->valid =3D true;
> -=09=09}
> -=09=09wake_up_all(&hmm->wq);
> -=09}
> -=09spin_unlock_irqrestore(&hmm->ranges_lock, flags);
> -}
> -
> -static int hmm_invalidate_range_start(struct mmu_notifier *mn,
> -=09=09=09const struct mmu_notifier_range *nrange)
> -{
> -=09struct hmm *hmm =3D container_of(mn, struct hmm, mmu_notifier);
> -=09struct hmm_mirror *mirror;
> -=09struct hmm_range *range;
> -=09unsigned long flags;
> -=09int ret =3D 0;
> -
> -=09spin_lock_irqsave(&hmm->ranges_lock, flags);
> -=09hmm->notifiers++;
> -=09list_for_each_entry(range, &hmm->ranges, list) {
> -=09=09if (nrange->end < range->start || nrange->start >=3D range->end)
> -=09=09=09continue;
> -
> -=09=09range->valid =3D false;
> -=09}
> -=09spin_unlock_irqrestore(&hmm->ranges_lock, flags);
> -
> -=09if (mmu_notifier_range_blockable(nrange))
> -=09=09down_read(&hmm->mirrors_sem);
> -=09else if (!down_read_trylock(&hmm->mirrors_sem)) {
> -=09=09ret =3D -EAGAIN;
> -=09=09goto out;
> -=09}
> -
> -=09list_for_each_entry(mirror, &hmm->mirrors, list) {
> -=09=09int rc;
> -
> -=09=09rc =3D mirror->ops->sync_cpu_device_pagetables(mirror, nrange);
> -=09=09if (rc) {
> -=09=09=09if (WARN_ON(mmu_notifier_range_blockable(nrange) ||
> -=09=09=09    rc !=3D -EAGAIN))
> -=09=09=09=09continue;
> -=09=09=09ret =3D -EAGAIN;
> -=09=09=09break;
> -=09=09}
> -=09}
> -=09up_read(&hmm->mirrors_sem);
> -
> -out:
> -=09if (ret)
> -=09=09notifiers_decrement(hmm);
> -=09return ret;
> -}
> -
> -static void hmm_invalidate_range_end(struct mmu_notifier *mn,
> -=09=09=09const struct mmu_notifier_range *nrange)
> -{
> -=09struct hmm *hmm =3D container_of(mn, struct hmm, mmu_notifier);
> -
> -=09notifiers_decrement(hmm);
> -}
> -
> -static const struct mmu_notifier_ops hmm_mmu_notifier_ops =3D {
> -=09.release=09=09=3D hmm_release,
> -=09.invalidate_range_start=09=3D hmm_invalidate_range_start,
> -=09.invalidate_range_end=09=3D hmm_invalidate_range_end,
> -=09.alloc_notifier=09=09=3D hmm_alloc_notifier,
> -=09.free_notifier=09=09=3D hmm_free_notifier,
> -};
> -
> -/*
> - * hmm_mirror_register() - register a mirror against an mm
> - *
> - * @mirror: new mirror struct to register
> - * @mm: mm to register against
> - * Return: 0 on success, -ENOMEM if no memory, -EINVAL if invalid argume=
nts
> - *
> - * To start mirroring a process address space, the device driver must re=
gister
> - * an HMM mirror struct.
> - *
> - * The caller cannot unregister the hmm_mirror while any ranges are
> - * registered.
> - *
> - * Callers using this function must put a call to mmu_notifier_synchroni=
ze()
> - * in their module exit functions.
> - */
> -int hmm_mirror_register(struct hmm_mirror *mirror, struct mm_struct *mm)
> -{
> -=09struct mmu_notifier *mn;
> -
> -=09lockdep_assert_held_write(&mm->mmap_sem);
> -
> -=09/* Sanity check */
> -=09if (!mm || !mirror || !mirror->ops)
> -=09=09return -EINVAL;
> -
> -=09mn =3D mmu_notifier_get_locked(&hmm_mmu_notifier_ops, mm);
> -=09if (IS_ERR(mn))
> -=09=09return PTR_ERR(mn);
> -=09mirror->hmm =3D container_of(mn, struct hmm, mmu_notifier);
> -
> -=09down_write(&mirror->hmm->mirrors_sem);
> -=09list_add(&mirror->list, &mirror->hmm->mirrors);
> -=09up_write(&mirror->hmm->mirrors_sem);
> -
> -=09return 0;
> -}
> -EXPORT_SYMBOL(hmm_mirror_register);
> -
> -/*
> - * hmm_mirror_unregister() - unregister a mirror
> - *
> - * @mirror: mirror struct to unregister
> - *
> - * Stop mirroring a process address space, and cleanup.
> - */
> -void hmm_mirror_unregister(struct hmm_mirror *mirror)
> -{
> -=09struct hmm *hmm =3D mirror->hmm;
> -
> -=09down_write(&hmm->mirrors_sem);
> -=09list_del(&mirror->list);
> -=09up_write(&hmm->mirrors_sem);
> -=09mmu_notifier_put(&hmm->mmu_notifier);
> -}
> -EXPORT_SYMBOL(hmm_mirror_unregister);
> -
>  struct hmm_vma_walk {
>  =09struct hmm_range=09*range;
>  =09struct dev_pagemap=09*pgmap;
> @@ -779,87 +592,6 @@ static void hmm_pfns_clear(struct hmm_range *range,
>  =09=09*pfns =3D range->values[HMM_PFN_NONE];
>  }
> =20
> -/*
> - * hmm_range_register() - start tracking change to CPU page table over a=
 range
> - * @range: range
> - * @mm: the mm struct for the range of virtual address
> - *
> - * Return: 0 on success, -EFAULT if the address space is no longer valid
> - *
> - * Track updates to the CPU page table see include/linux/hmm.h
> - */
> -int hmm_range_register(struct hmm_range *range, struct hmm_mirror *mirro=
r)
> -{
> -=09struct hmm *hmm =3D mirror->hmm;
> -=09unsigned long flags;
> -
> -=09range->valid =3D false;
> -=09range->hmm =3D NULL;
> -
> -=09if ((range->start & (PAGE_SIZE - 1)) || (range->end & (PAGE_SIZE - 1)=
))
> -=09=09return -EINVAL;
> -=09if (range->start >=3D range->end)
> -=09=09return -EINVAL;
> -
> -=09/* Prevent hmm_release() from running while the range is valid */
> -=09if (!mmget_not_zero(hmm->mmu_notifier.mm))
> -=09=09return -EFAULT;
> -
> -=09/* Initialize range to track CPU page table updates. */
> -=09spin_lock_irqsave(&hmm->ranges_lock, flags);
> -
> -=09range->hmm =3D hmm;
> -=09list_add(&range->list, &hmm->ranges);
> -
> -=09/*
> -=09 * If there are any concurrent notifiers we have to wait for them for
> -=09 * the range to be valid (see hmm_range_wait_until_valid()).
> -=09 */
> -=09if (!hmm->notifiers)
> -=09=09range->valid =3D true;
> -=09spin_unlock_irqrestore(&hmm->ranges_lock, flags);
> -
> -=09return 0;
> -}
> -EXPORT_SYMBOL(hmm_range_register);
> -
> -/*
> - * hmm_range_unregister() - stop tracking change to CPU page table over =
a range
> - * @range: range
> - *
> - * Range struct is used to track updates to the CPU page table after a c=
all to
> - * hmm_range_register(). See include/linux/hmm.h for how to use it.
> - */
> -void hmm_range_unregister(struct hmm_range *range)
> -{
> -=09struct hmm *hmm =3D range->hmm;
> -=09unsigned long flags;
> -
> -=09spin_lock_irqsave(&hmm->ranges_lock, flags);
> -=09list_del_init(&range->list);
> -=09spin_unlock_irqrestore(&hmm->ranges_lock, flags);
> -
> -=09/* Drop reference taken by hmm_range_register() */
> -=09mmput(hmm->mmu_notifier.mm);
> -
> -=09/*
> -=09 * The range is now invalid and the ref on the hmm is dropped, so
> -=09 * poison the pointer.  Leave other fields in place, for the caller's
> -=09 * use.
> -=09 */
> -=09range->valid =3D false;
> -=09memset(&range->hmm, POISON_INUSE, sizeof(range->hmm));
> -}
> -EXPORT_SYMBOL(hmm_range_unregister);
> -
> -static bool needs_retry(struct hmm_range *range)
> -{
> -=09if (range->notifier)
> -=09=09return mmu_range_check_retry(range->notifier,
> -=09=09=09=09=09     range->notifier_seq);
> -=09return !range->valid;
> -}
> -
>  static const struct mm_walk_ops hmm_walk_ops =3D {
>  =09.pud_entry=09=3D hmm_vma_walk_pud,
>  =09.pmd_entry=09=3D hmm_vma_walk_pmd,
> @@ -900,20 +632,15 @@ long hmm_range_fault(struct hmm_range *range, unsig=
ned int flags)
>  =09const unsigned long device_vma =3D VM_IO | VM_PFNMAP | VM_MIXEDMAP;
>  =09unsigned long start =3D range->start, end;
>  =09struct hmm_vma_walk hmm_vma_walk;
> -=09struct mm_struct *mm;
> +=09struct mm_struct *mm =3D range->notifier->mm;
>  =09struct vm_area_struct *vma;
>  =09int ret;
> =20
> -=09if (range->notifier)
> -=09=09mm =3D range->notifier->mm;
> -=09else
> -=09=09mm =3D range->hmm->mmu_notifier.mm;
> -
>  =09lockdep_assert_held(&mm->mmap_sem);
> =20
>  =09do {
>  =09=09/* If range is no longer valid force retry. */
> -=09=09if (needs_retry(range))
> +=09=09if (mmu_range_check_retry(range->notifier, range->notifier_seq))
>  =09=09=09return -EBUSY;
> =20
>  =09=09vma =3D find_vma(mm, start);
> @@ -946,7 +673,9 @@ long hmm_range_fault(struct hmm_range *range, unsigne=
d int flags)
>  =09=09=09start =3D hmm_vma_walk.last;
> =20
>  =09=09=09/* Keep trying while the range is valid. */
> -=09=09} while (ret =3D=3D -EBUSY && !needs_retry(range));
> +=09=09} while (ret =3D=3D -EBUSY &&
> +=09=09=09 !mmu_range_check_retry(range->notifier,
> +=09=09=09=09=09=09range->notifier_seq));
> =20
>  =09=09if (ret) {
>  =09=09=09unsigned long i;
> @@ -1004,7 +733,8 @@ long hmm_range_dma_map(struct hmm_range *range, stru=
ct device *device,
>  =09=09=09continue;
> =20
>  =09=09/* Check if range is being invalidated */
> -=09=09if (needs_retry(range)) {
> +=09=09if (mmu_range_check_retry(range->notifier,
> +=09=09=09=09=09  range->notifier_seq)) {
>  =09=09=09ret =3D -EBUSY;
>  =09=09=09goto unmap;
>  =09=09}
> --=20
> 2.23.0
>=20

