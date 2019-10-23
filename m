Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B44B4E2496
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Oct 2019 22:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfJWU2d (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Oct 2019 16:28:33 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22079 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388677AbfJWU2c (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 23 Oct 2019 16:28:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571862506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TIHISFLEIjObRhFYugN2Knlv3+VYz6RODqTi8r820Ng=;
        b=cPELsmjRtmEwGdQ3QV8YL3jfQBFnKC1X9ko8moZinrnxq6OaxHV+vVXJe1bXBlCp9oAOuB
        VzIGPSKyp5Blzf36f/ujGh8+v8PBJ1Qk4Cya/c5Nxd36QVUXyUE2h7TsZ9g2RidseDgFQE
        NgDR4j4jBnvdS6tvgx9HwkD0CmBloqw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-Dr8SXdnEMkCJ2XdLJW7vSQ-1; Wed, 23 Oct 2019 16:28:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F2AA80183D;
        Wed, 23 Oct 2019 20:28:20 +0000 (UTC)
Received: from redhat.com (ovpn-123-188.rdu2.redhat.com [10.10.123.188])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 113D25DA8D;
        Wed, 23 Oct 2019 20:28:18 +0000 (UTC)
Date:   Wed, 23 Oct 2019 16:28:17 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     John Hubbard <jhubbard@nvidia.com>, Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] mm/hmm/test: add self tests for HMM
Message-ID: <20191023202817.GC3200@redhat.com>
References: <20191023195515.13168-1-rcampbell@nvidia.com>
 <20191023195515.13168-4-rcampbell@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20191023195515.13168-4-rcampbell@nvidia.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: Dr8SXdnEMkCJ2XdLJW7vSQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 23, 2019 at 12:55:15PM -0700, Ralph Campbell wrote:
> Add self tests for HMM.
>=20
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>

You can add my signoff

Signed-off-by: J=E9r=F4me Glisse <jglisse@redhat.com>


> ---
>  MAINTAINERS                            |    3 +
>  drivers/char/Kconfig                   |   11 +
>  drivers/char/Makefile                  |    1 +
>  drivers/char/hmm_dmirror.c             | 1566 ++++++++++++++++++++++++
>  include/Kbuild                         |    1 +
>  include/uapi/linux/hmm_dmirror.h       |   74 ++
>  tools/testing/selftests/vm/.gitignore  |    1 +
>  tools/testing/selftests/vm/Makefile    |    3 +
>  tools/testing/selftests/vm/config      |    3 +
>  tools/testing/selftests/vm/hmm-tests.c | 1311 ++++++++++++++++++++
>  tools/testing/selftests/vm/run_vmtests |   16 +
>  tools/testing/selftests/vm/test_hmm.sh |   97 ++
>  12 files changed, 3087 insertions(+)
>  create mode 100644 drivers/char/hmm_dmirror.c
>  create mode 100644 include/uapi/linux/hmm_dmirror.h
>  create mode 100644 tools/testing/selftests/vm/hmm-tests.c
>  create mode 100755 tools/testing/selftests/vm/test_hmm.sh
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 296de2b51c83..9890b6b8eea0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7427,8 +7427,11 @@ M:=09J=E9r=F4me Glisse <jglisse@redhat.com>
>  L:=09linux-mm@kvack.org
>  S:=09Maintained
>  F:=09mm/hmm*
> +F:=09drivers/char/hmm*
>  F:=09include/linux/hmm*
> +F:=09include/uapi/linux/hmm*
>  F:=09Documentation/vm/hmm.rst
> +F:=09tools/testing/selftests/vm/*hmm*
> =20
>  HOST AP DRIVER
>  M:=09Jouni Malinen <j@w1.fi>
> diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
> index df0fc997dc3e..cc8ddb99550d 100644
> --- a/drivers/char/Kconfig
> +++ b/drivers/char/Kconfig
> @@ -535,6 +535,17 @@ config ADI
>  =09  and SSM (Silicon Secured Memory).  Intended consumers of this
>  =09  driver include crash and makedumpfile.
> =20
> +config HMM_DMIRROR
> +=09tristate "HMM driver for testing Heterogeneous Memory Management"
> +=09depends on HMM_MIRROR
> +=09depends on DEVICE_PRIVATE
> +=09help
> +=09  This is a pseudo device driver solely for testing HMM.
> +=09  Say Y here if you want to build the HMM test driver.
> +=09  Doing so will allow you to run tools/testing/selftest/vm/hmm-tests.
> +
> +=09  If in doubt, say "N".
> +
>  endmenu
> =20
>  config RANDOM_TRUST_CPU
> diff --git a/drivers/char/Makefile b/drivers/char/Makefile
> index 7c5ea6f9df14..d4a168c0c138 100644
> --- a/drivers/char/Makefile
> +++ b/drivers/char/Makefile
> @@ -52,3 +52,4 @@ js-rtc-y =3D rtc.o
>  obj-$(CONFIG_XILLYBUS)=09=09+=3D xillybus/
>  obj-$(CONFIG_POWERNV_OP_PANEL)=09+=3D powernv-op-panel.o
>  obj-$(CONFIG_ADI)=09=09+=3D adi.o
> +obj-$(CONFIG_HMM_DMIRROR)=09+=3D hmm_dmirror.o
> diff --git a/drivers/char/hmm_dmirror.c b/drivers/char/hmm_dmirror.c
> new file mode 100644
> index 000000000000..5a1ed34e72e1
> --- /dev/null
> +++ b/drivers/char/hmm_dmirror.c
> @@ -0,0 +1,1566 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2013 Red Hat Inc.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * Authors: J=E9r=F4me Glisse <jglisse@redhat.com>
> + */
> +/*
> + * This is a driver to exercice the HMM (heterogeneous memory management=
)
> + * mirror and zone device private memory migration APIs of the kernel.
> + * Userspace programs can register with the driver to mirror their own a=
ddress
> + * space and can use the device to read/write any valid virtual address.
> + *
> + * In some ways it can also serve as an example driver for people wantin=
g to use
> + * HMM inside their own device driver.
> + */
> +#include <linux/init.h>
> +#include <linux/fs.h>
> +#include <linux/mm.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/cdev.h>
> +#include <linux/device.h>
> +#include <linux/mutex.h>
> +#include <linux/rwsem.h>
> +#include <linux/sched.h>
> +#include <linux/slab.h>
> +#include <linux/highmem.h>
> +#include <linux/delay.h>
> +#include <linux/pagemap.h>
> +#include <linux/hmm.h>
> +#include <linux/vmalloc.h>
> +#include <linux/swap.h>
> +#include <linux/swapops.h>
> +#include <linux/sched/mm.h>
> +#include <linux/platform_device.h>
> +
> +#include <uapi/linux/hmm_dmirror.h>
> +
> +#define DMIRROR_NDEVICES=09=092
> +#define DMIRROR_RANGE_FAULT_TIMEOUT=091000
> +#define DEVMEM_CHUNK_SIZE=09=09(256 * 1024 * 1024U)
> +#define DEVMEM_CHUNKS_RESERVE=09=0916
> +
> +static const struct dev_pagemap_ops dmirror_devmem_ops;
> +static dev_t dmirror_dev;
> +static struct platform_device *dmirror_platform_devices[DMIRROR_NDEVICES=
];
> +static struct page *dmirror_zero_page;
> +
> +struct dmirror_device;
> +
> +struct dmirror_bounce {
> +=09void=09=09=09*ptr;
> +=09unsigned long=09=09size;
> +=09unsigned long=09=09addr;
> +=09unsigned long=09=09cpages;
> +};
> +
> +#define DPT_SHIFT PAGE_SHIFT
> +#define DPT_VALID (1UL << 0)
> +#define DPT_WRITE (1UL << 1)
> +#define DPT_DPAGE (1UL << 2)
> +#define DPT_ZPAGE 0x20UL
> +
> +const uint64_t dmirror_hmm_flags[HMM_PFN_FLAG_MAX] =3D {
> +=09[HMM_PFN_VALID] =3D DPT_VALID,
> +=09[HMM_PFN_WRITE] =3D DPT_WRITE,
> +=09[HMM_PFN_DEVICE_PRIVATE] =3D DPT_DPAGE,
> +};
> +
> +static const uint64_t dmirror_hmm_values[HMM_PFN_VALUE_MAX] =3D {
> +=09[HMM_PFN_NONE]    =3D 0,
> +=09[HMM_PFN_ERROR]   =3D 0x10,
> +=09[HMM_PFN_SPECIAL] =3D 0x10,
> +};
> +
> +struct dmirror_pt {
> +=09u64=09=09=09pgd[PTRS_PER_PGD];
> +=09struct rw_semaphore=09lock;
> +};
> +
> +/*
> + * Data attached to the open device file.
> + * Note that it might be shared after a fork().
> + */
> +struct dmirror {
> +=09struct hmm_mirror=09mirror;
> +=09struct dmirror_device=09*mdevice;
> +=09struct dmirror_pt=09pt;
> +=09struct mutex=09=09mutex;
> +};
> +
> +/*
> + * ZONE_DEVICE pages for migration and simulating device memory.
> + */
> +struct dmirror_chunk {
> +=09struct dev_pagemap=09pagemap;
> +=09struct dmirror_device=09*mdevice;
> +};
> +
> +/*
> + * Per device data.
> + */
> +struct dmirror_device {
> +=09struct cdev=09=09cdevice;
> +=09struct hmm_devmem=09*devmem;
> +=09struct platform_device=09*pdevice;
> +
> +=09unsigned int=09=09devmem_capacity;
> +=09unsigned int=09=09devmem_count;
> +=09struct dmirror_chunk=09**devmem_chunks;
> +=09struct mutex=09=09devmem_lock;=09/* protects the above */
> +
> +=09unsigned long=09=09calloc;
> +=09unsigned long=09=09cfree;
> +=09struct page=09=09*free_pages;
> +=09spinlock_t=09=09lock;=09=09/* protects the above */
> +};
> +
> +static inline unsigned long dmirror_pt_pgd(unsigned long addr)
> +{
> +=09return (addr >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1);
> +}
> +
> +static inline unsigned long dmirror_pt_pud(unsigned long addr)
> +{
> +=09return (addr >> PUD_SHIFT) & (PTRS_PER_PUD - 1);
> +}
> +
> +static inline unsigned long dmirror_pt_pmd(unsigned long addr)
> +{
> +=09return (addr >> PMD_SHIFT) & (PTRS_PER_PMD - 1);
> +}
> +
> +static inline unsigned long dmirror_pt_pte(unsigned long addr)
> +{
> +=09return (addr >> PAGE_SHIFT) & (PTRS_PER_PTE - 1);
> +}
> +
> +static inline struct page *dmirror_pt_page(u64 *dptep)
> +{
> +=09u64 dpte =3D *dptep;
> +
> +=09if (dpte =3D=3D DPT_ZPAGE)
> +=09=09return dmirror_zero_page;
> +=09if (!(dpte & DPT_VALID))
> +=09=09return NULL;
> +=09return pfn_to_page((u64)dpte >> DPT_SHIFT);
> +}
> +
> +static inline struct page *dmirror_pt_page_write(u64 *dptep)
> +{
> +=09u64 dpte =3D *dptep;
> +
> +=09if (!(dpte & DPT_VALID) || !(dpte & DPT_WRITE))
> +=09=09return NULL;
> +=09return pfn_to_page((u64)dpte >> DPT_SHIFT);
> +}
> +
> +static inline u64 dmirror_pt_from_page(struct page *page)
> +{
> +=09if (!page)
> +=09=09return 0;
> +=09return (page_to_pfn(page) << DPT_SHIFT) | DPT_VALID;
> +}
> +
> +static struct page *populate_pt(struct dmirror *dmirror, u64 *dptep)
> +{
> +=09struct page *page;
> +
> +=09/*
> +=09 * Since we don't free page tables until the process exits,
> +=09 * we can unlock and relock without the page table being freed
> +=09 * from under us.
> +=09 */
> +=09mutex_unlock(&dmirror->mutex);
> +=09page =3D alloc_page(GFP_HIGHUSER | __GFP_ZERO);
> +=09mutex_lock(&dmirror->mutex);
> +=09if (page) {
> +=09=09if (unlikely(*dptep)) {
> +=09=09=09__free_page(page);
> +=09=09=09page =3D dmirror_pt_page(dptep);
> +=09=09} else
> +=09=09=09*dptep =3D dmirror_pt_from_page(page);
> +=09} else if (*dptep)
> +=09=09page =3D dmirror_pt_page(dptep);
> +=09return page;
> +}
> +
> +static inline unsigned long dmirror_pt_pud_end(unsigned long addr)
> +{
> +=09return (addr & PGDIR_MASK) + ((unsigned long)PTRS_PER_PUD << PUD_SHIF=
T);
> +}
> +
> +static inline unsigned long dmirror_pt_pmd_end(unsigned long addr)
> +{
> +=09return (addr & PUD_MASK) + ((unsigned long)PTRS_PER_PMD << PMD_SHIFT)=
;
> +}
> +
> +static inline unsigned long dmirror_pt_pte_end(unsigned long addr)
> +{
> +=09return (addr & PMD_MASK) + ((unsigned long)PTRS_PER_PTE << PAGE_SHIFT=
);
> +}
> +
> +typedef int (*dmirror_walk_cb_t)(struct dmirror *dmirror,
> +=09=09=09=09 unsigned long start,
> +=09=09=09=09 unsigned long end,
> +=09=09=09=09 u64 *dptep,
> +=09=09=09=09 void *private);
> +
> +static int dmirror_pt_walk(struct dmirror *dmirror,
> +=09=09=09   dmirror_walk_cb_t cb,
> +=09=09=09   unsigned long start,
> +=09=09=09   unsigned long end,
> +=09=09=09   void *private,
> +=09=09=09   bool populate)
> +{
> +=09u64 *dpgdp =3D &dmirror->pt.pgd[dmirror_pt_pgd(start)];
> +=09unsigned long addr;
> +=09int ret =3D -ENOENT;
> +
> +=09for (addr =3D start; addr < end; dpgdp++) {
> +=09=09u64 *dpudp;
> +=09=09unsigned long pud_end;
> +=09=09struct page *pud_page;
> +
> +=09=09pud_end =3D min(end, dmirror_pt_pud_end(addr));
> +=09=09pud_page =3D dmirror_pt_page(dpgdp);
> +=09=09if (!pud_page) {
> +=09=09=09if (!populate) {
> +=09=09=09=09addr =3D pud_end;
> +=09=09=09=09continue;
> +=09=09=09}
> +=09=09=09pud_page =3D populate_pt(dmirror, dpgdp);
> +=09=09=09if (!pud_page)
> +=09=09=09=09return -ENOMEM;
> +=09=09}
> +=09=09dpudp =3D kmap(pud_page);
> +=09=09dpudp +=3D dmirror_pt_pud(addr);
> +=09=09for (; addr !=3D pud_end; dpudp++) {
> +=09=09=09u64 *dpmdp;
> +=09=09=09unsigned long pmd_end;
> +=09=09=09struct page *pmd_page;
> +
> +=09=09=09pmd_end =3D min(end, dmirror_pt_pmd_end(addr));
> +=09=09=09pmd_page =3D dmirror_pt_page(dpudp);
> +=09=09=09if (!pmd_page) {
> +=09=09=09=09if (!populate) {
> +=09=09=09=09=09addr =3D pmd_end;
> +=09=09=09=09=09continue;
> +=09=09=09=09}
> +=09=09=09=09pmd_page =3D populate_pt(dmirror, dpudp);
> +=09=09=09=09if (!pmd_page) {
> +=09=09=09=09=09kunmap(pud_page);
> +=09=09=09=09=09return -ENOMEM;
> +=09=09=09=09}
> +=09=09=09}
> +=09=09=09dpmdp =3D kmap(pmd_page);
> +=09=09=09dpmdp +=3D dmirror_pt_pmd(addr);
> +=09=09=09for (; addr !=3D pmd_end; dpmdp++) {
> +=09=09=09=09u64 *dptep;
> +=09=09=09=09unsigned long pte_end;
> +=09=09=09=09struct page *pte_page;
> +
> +=09=09=09=09pte_end =3D min(end, dmirror_pt_pte_end(addr));
> +=09=09=09=09pte_page =3D dmirror_pt_page(dpmdp);
> +=09=09=09=09if (!pte_page) {
> +=09=09=09=09=09if (!populate) {
> +=09=09=09=09=09=09addr =3D pte_end;
> +=09=09=09=09=09=09continue;
> +=09=09=09=09=09}
> +=09=09=09=09=09pte_page =3D populate_pt(dmirror, dpmdp);
> +=09=09=09=09=09if (!pte_page) {
> +=09=09=09=09=09=09kunmap(pmd_page);
> +=09=09=09=09=09=09kunmap(pud_page);
> +=09=09=09=09=09=09return -ENOMEM;
> +=09=09=09=09=09}
> +=09=09=09=09}
> +=09=09=09=09if (!cb) {
> +=09=09=09=09=09addr =3D pte_end;
> +=09=09=09=09=09continue;
> +=09=09=09=09}
> +=09=09=09=09dptep =3D kmap(pte_page);
> +=09=09=09=09dptep +=3D dmirror_pt_pte(addr);
> +=09=09=09=09ret =3D cb(dmirror, addr, pte_end, dptep,
> +=09=09=09=09=09 private);
> +=09=09=09=09kunmap(pte_page);
> +=09=09=09=09if (ret) {
> +=09=09=09=09=09kunmap(pmd_page);
> +=09=09=09=09=09kunmap(pud_page);
> +=09=09=09=09=09return ret;
> +=09=09=09=09}
> +=09=09=09=09addr =3D pte_end;
> +=09=09=09}
> +=09=09=09kunmap(pmd_page);
> +=09=09=09addr =3D pmd_end;
> +=09=09}
> +=09=09kunmap(pud_page);
> +=09=09addr =3D pud_end;
> +=09}
> +
> +=09return ret;
> +}
> +
> +static void dmirror_pt_free(struct dmirror *dmirror)
> +{
> +=09u64 *dpgdp =3D dmirror->pt.pgd;
> +
> +=09for (; dpgdp !=3D dmirror->pt.pgd + PTRS_PER_PGD; dpgdp++) {
> +=09=09u64 *dpudp, *dpudp_orig;
> +=09=09u64 *dpudp_end;
> +=09=09struct page *pud_page;
> +
> +=09=09pud_page =3D dmirror_pt_page(dpgdp);
> +=09=09if (!pud_page)
> +=09=09=09continue;
> +
> +=09=09dpudp_orig =3D kmap_atomic(pud_page);
> +=09=09dpudp =3D dpudp_orig;
> +=09=09dpudp_end =3D dpudp + PTRS_PER_PUD;
> +=09=09for (; dpudp !=3D dpudp_end; dpudp++) {
> +=09=09=09u64 *dpmdp, *dpmdp_orig;
> +=09=09=09u64 *dpmdp_end;
> +=09=09=09struct page *pmd_page;
> +
> +=09=09=09pmd_page =3D dmirror_pt_page(dpudp);
> +=09=09=09if (!pmd_page)
> +=09=09=09=09continue;
> +
> +=09=09=09dpmdp_orig =3D kmap_atomic(pmd_page);
> +=09=09=09dpmdp =3D dpmdp_orig;
> +=09=09=09dpmdp_end =3D dpmdp + PTRS_PER_PMD;
> +=09=09=09for (; dpmdp !=3D dpmdp_end; dpmdp++) {
> +=09=09=09=09struct page *pte_page;
> +
> +=09=09=09=09pte_page =3D dmirror_pt_page(dpmdp);
> +=09=09=09=09if (!pte_page)
> +=09=09=09=09=09continue;
> +
> +=09=09=09=09*dpmdp =3D 0;
> +=09=09=09=09__free_page(pte_page);
> +=09=09=09}
> +=09=09=09kunmap_atomic(dpmdp_orig);
> +=09=09=09*dpudp =3D 0;
> +=09=09=09__free_page(pmd_page);
> +=09=09}
> +=09=09kunmap_atomic(dpudp_orig);
> +=09=09*dpgdp =3D 0;
> +=09=09__free_page(pud_page);
> +=09}
> +}
> +
> +static int dmirror_bounce_init(struct dmirror_bounce *bounce,
> +=09=09=09       unsigned long addr,
> +=09=09=09       unsigned long size)
> +{
> +=09bounce->addr =3D addr;
> +=09bounce->size =3D size;
> +=09bounce->cpages =3D 0;
> +=09bounce->ptr =3D vmalloc(size);
> +=09if (!bounce->ptr)
> +=09=09return -ENOMEM;
> +=09return 0;
> +}
> +
> +static int dmirror_bounce_copy_from(struct dmirror_bounce *bounce,
> +=09=09=09=09    unsigned long addr)
> +{
> +=09unsigned long end =3D addr + bounce->size;
> +=09char __user *uptr =3D (void __user *)addr;
> +=09void *ptr =3D bounce->ptr;
> +
> +=09for (; addr < end; addr +=3D PAGE_SIZE, ptr +=3D PAGE_SIZE,
> +=09=09=09=09=09      uptr +=3D PAGE_SIZE) {
> +=09=09int ret;
> +
> +=09=09ret =3D copy_from_user(ptr, uptr, PAGE_SIZE);
> +=09=09if (ret)
> +=09=09=09return ret;
> +=09}
> +
> +=09return 0;
> +}
> +
> +static int dmirror_bounce_copy_to(struct dmirror_bounce *bounce,
> +=09=09=09=09  unsigned long addr)
> +{
> +=09unsigned long end =3D addr + bounce->size;
> +=09char __user *uptr =3D (void __user *)addr;
> +=09void *ptr =3D bounce->ptr;
> +
> +=09for (; addr < end; addr +=3D PAGE_SIZE, ptr +=3D PAGE_SIZE,
> +=09=09=09=09=09      uptr +=3D PAGE_SIZE) {
> +=09=09int ret;
> +
> +=09=09ret =3D copy_to_user(uptr, ptr, PAGE_SIZE);
> +=09=09if (ret)
> +=09=09=09return ret;
> +=09}
> +
> +=09return 0;
> +}
> +
> +static void dmirror_bounce_fini(struct dmirror_bounce *bounce)
> +{
> +=09vfree(bounce->ptr);
> +}
> +
> +static int dmirror_do_update(struct dmirror *dmirror,
> +=09=09=09     unsigned long addr,
> +=09=09=09     unsigned long end,
> +=09=09=09     u64 *dptep,
> +=09=09=09     void *private)
> +{
> +=09/*
> +=09 * The page table doesn't hold references to pages since it relies on
> +=09 * the mmu notifier to clear pointers when they become stale.
> +=09 * Therefore, it is OK to just clear the pte.
> +=09 */
> +=09for (; addr < end; addr +=3D PAGE_SIZE, ++dptep)
> +=09=09*dptep =3D 0;
> +
> +=09return 0;
> +}
> +
> +static int dmirror_update(struct hmm_mirror *mirror,
> +=09=09=09  const struct mmu_notifier_range *update)
> +{
> +=09struct dmirror *dmirror =3D container_of(mirror, struct dmirror, mirr=
or);
> +
> +=09if (mmu_notifier_range_blockable(update))
> +=09=09mutex_lock(&dmirror->mutex);
> +=09else if (!mutex_trylock(&dmirror->mutex))
> +=09=09return -EAGAIN;
> +
> +=09dmirror_pt_walk(dmirror, dmirror_do_update, update->start,
> +=09=09=09update->end, NULL, false);
> +=09mutex_unlock(&dmirror->mutex);
> +=09return 0;
> +}
> +
> +static const struct hmm_mirror_ops dmirror_ops =3D {
> +=09.sync_cpu_device_pagetables=09=3D &dmirror_update,
> +};
> +
> +/*
> + * dmirror_new() - allocate and initialize dmirror struct.
> + *
> + * @mdevice: The device this mirror is associated with.
> + * @filp: The active device file descriptor this mirror is associated wi=
th.
> + */
> +static struct dmirror *dmirror_new(struct dmirror_device *mdevice)
> +{
> +=09struct mm_struct *mm =3D get_task_mm(current);
> +=09struct dmirror *dmirror;
> +=09int ret;
> +
> +=09if (!mm)
> +=09=09goto err;
> +
> +=09/* Mirror this process address space */
> +=09dmirror =3D kzalloc(sizeof(*dmirror), GFP_KERNEL);
> +=09if (dmirror =3D=3D NULL)
> +=09=09goto err_mmput;
> +
> +=09dmirror->mdevice =3D mdevice;
> +=09dmirror->mirror.ops =3D &dmirror_ops;
> +=09mutex_init(&dmirror->mutex);
> +
> +=09down_write(&mm->mmap_sem);
> +=09ret =3D hmm_mirror_register(&dmirror->mirror, mm);
> +=09up_write(&mm->mmap_sem);
> +=09if (ret)
> +=09=09goto err_free;
> +
> +=09mmput(mm);
> +=09return dmirror;
> +
> +err_free:
> +=09kfree(dmirror);
> +err_mmput:
> +=09mmput(mm);
> +err:
> +=09return NULL;
> +}
> +
> +static void dmirror_del(struct dmirror *dmirror)
> +{
> +=09hmm_mirror_unregister(&dmirror->mirror);
> +=09dmirror_pt_free(dmirror);
> +=09kfree(dmirror);
> +}
> +
> +/*
> + * Below are the file operation for the dmirror device file. Only ioctl =
matters.
> + *
> + * Note this is highly specific to the dmirror device driver and should =
not be
> + * construed as an example on how to design the API a real device driver=
 would
> + * expose to userspace.
> + */
> +static ssize_t dmirror_fops_read(struct file *filp,
> +=09=09=09       char __user *buf,
> +=09=09=09       size_t count,
> +=09=09=09       loff_t *ppos)
> +{
> +=09return -EINVAL;
> +}
> +
> +static ssize_t dmirror_fops_write(struct file *filp,
> +=09=09=09=09const char __user *buf,
> +=09=09=09=09size_t count,
> +=09=09=09=09loff_t *ppos)
> +{
> +=09return -EINVAL;
> +}
> +
> +static int dmirror_fops_mmap(struct file *filp, struct vm_area_struct *v=
ma)
> +{
> +=09/* Forbid mmap of the dmirror device file. */
> +=09return -EINVAL;
> +}
> +
> +static int dmirror_fops_open(struct inode *inode, struct file *filp)
> +{
> +=09struct cdev *cdev =3D inode->i_cdev;
> +=09struct dmirror_device *mdevice;
> +=09struct dmirror *dmirror;
> +
> +=09/* No exclusive opens. */
> +=09if (filp->f_flags & O_EXCL)
> +=09=09return -EINVAL;
> +
> +=09mdevice =3D container_of(cdev, struct dmirror_device, cdevice);
> +=09dmirror =3D dmirror_new(mdevice);
> +=09if (!dmirror)
> +=09=09return -ENOMEM;
> +
> +=09/* Only the first open registers the address space. */
> +=09mutex_lock(&mdevice->devmem_lock);
> +=09if (filp->private_data)
> +=09=09goto err_busy;
> +=09filp->private_data =3D dmirror;
> +=09mutex_unlock(&mdevice->devmem_lock);
> +
> +=09return 0;
> +
> +err_busy:
> +=09mutex_unlock(&mdevice->devmem_lock);
> +=09dmirror_del(dmirror);
> +=09return -EBUSY;
> +}
> +
> +static int dmirror_fops_release(struct inode *inode, struct file *filp)
> +{
> +=09struct dmirror *dmirror =3D filp->private_data;
> +
> +=09if (!dmirror)
> +=09=09return 0;
> +
> +=09dmirror_del(dmirror);
> +=09filp->private_data =3D NULL;
> +
> +=09return 0;
> +}
> +
> +static inline struct dmirror_device *dmirror_page_to_device(struct page =
*page)
> +
> +{
> +=09struct dmirror_chunk *devmem;
> +
> +=09devmem =3D container_of(page->pgmap, struct dmirror_chunk, pagemap);
> +=09return devmem->mdevice;
> +}
> +
> +static bool dmirror_device_is_mine(struct dmirror_device *mdevice,
> +=09=09=09=09   struct page *page)
> +{
> +=09if (!is_zone_device_page(page))
> +=09=09return false;
> +=09return page->pgmap->ops =3D=3D &dmirror_devmem_ops &&
> +=09=09dmirror_page_to_device(page) =3D=3D mdevice;
> +}
> +
> +static int dmirror_do_fault(struct dmirror *dmirror,
> +=09=09=09    unsigned long addr,
> +=09=09=09    unsigned long end,
> +=09=09=09    u64 *dptep,
> +=09=09=09    void *private)
> +{
> +=09struct hmm_range *range =3D private;
> +=09unsigned long idx =3D (addr - range->start) >> PAGE_SHIFT;
> +=09uint64_t *pfns =3D range->pfns;
> +
> +=09for (; addr < end; addr +=3D PAGE_SIZE, ++dptep, ++idx) {
> +=09=09struct page *page;
> +=09=09u64 dpte;
> +
> +=09=09/*
> +=09=09 * HMM_PFN_ERROR is returned if it is accessing invalid memory
> +=09=09 * either because of memory error (hardware detected memory
> +=09=09 * corruption) or more likely because of truncate on mmap
> +=09=09 * file.
> +=09=09 */
> +=09=09if (pfns[idx] =3D=3D range->values[HMM_PFN_ERROR])
> +=09=09=09return -EFAULT;
> +=09=09/*
> +=09=09 * The only special PFN HMM returns is the read-only zero page
> +=09=09 * which doesn't have a matching struct page.
> +=09=09 */
> +=09=09if (pfns[idx] =3D=3D range->values[HMM_PFN_SPECIAL]) {
> +=09=09=09*dptep =3D DPT_ZPAGE;
> +=09=09=09continue;
> +=09=09}
> +=09=09if (!(pfns[idx] & range->flags[HMM_PFN_VALID]))
> +=09=09=09return -EFAULT;
> +=09=09page =3D hmm_device_entry_to_page(range, pfns[idx]);
> +=09=09/* We asked for pages to be populated but check anyway. */
> +=09=09if (!page)
> +=09=09=09return -EFAULT;
> +=09=09dpte =3D dmirror_pt_from_page(page);
> +=09=09if (is_zone_device_page(page)) {
> +=09=09=09if (!dmirror_device_is_mine(dmirror->mdevice, page))
> +=09=09=09=09continue;
> +=09=09=09dpte |=3D DPT_DPAGE;
> +=09=09}
> +=09=09if (pfns[idx] & range->flags[HMM_PFN_WRITE])
> +=09=09=09dpte |=3D DPT_WRITE;
> +=09=09else if (range->default_flags & range->flags[HMM_PFN_WRITE])
> +=09=09=09return -EFAULT;
> +=09=09*dptep =3D dpte;
> +=09}
> +
> +=09return 0;
> +}
> +
> +static int dmirror_fault(struct dmirror *dmirror,
> +=09=09=09 unsigned long start,
> +=09=09=09 unsigned long end,
> +=09=09=09 bool write)
> +{
> +=09struct mm_struct *mm =3D dmirror->mirror.hmm->mmu_notifier.mm;
> +=09unsigned long addr;
> +=09unsigned long next;
> +=09uint64_t pfns[64];
> +=09struct hmm_range range =3D {
> +=09=09.pfns =3D pfns,
> +=09=09.flags =3D dmirror_hmm_flags,
> +=09=09.values =3D dmirror_hmm_values,
> +=09=09.pfn_shift =3D DPT_SHIFT,
> +=09=09.pfn_flags_mask =3D ~(dmirror_hmm_flags[HMM_PFN_VALID] |
> +=09=09=09=09    dmirror_hmm_flags[HMM_PFN_WRITE]),
> +=09=09.default_flags =3D dmirror_hmm_flags[HMM_PFN_VALID] |
> +=09=09=09=09(write ? dmirror_hmm_flags[HMM_PFN_WRITE] : 0),
> +=09};
> +=09int ret =3D 0;
> +
> +=09for (addr =3D start; addr < end; ) {
> +=09=09long count;
> +
> +=09=09next =3D min(addr + (ARRAY_SIZE(pfns) << PAGE_SHIFT), end);
> +=09=09range.start =3D addr;
> +=09=09range.end =3D next;
> +
> +=09=09down_read(&mm->mmap_sem);
> +
> +=09=09ret =3D hmm_range_register(&range, &dmirror->mirror);
> +=09=09if (ret) {
> +=09=09=09up_read(&mm->mmap_sem);
> +=09=09=09break;
> +=09=09}
> +
> +=09=09if (!hmm_range_wait_until_valid(&range,
> +=09=09=09=09=09=09DMIRROR_RANGE_FAULT_TIMEOUT)) {
> +=09=09=09hmm_range_unregister(&range);
> +=09=09=09up_read(&mm->mmap_sem);
> +=09=09=09continue;
> +=09=09}
> +
> +=09=09count =3D hmm_range_fault(&range, 0);
> +=09=09if (count < 0) {
> +=09=09=09ret =3D count;
> +=09=09=09hmm_range_unregister(&range);
> +=09=09=09up_read(&mm->mmap_sem);
> +=09=09=09break;
> +=09=09}
> +
> +=09=09if (!hmm_range_valid(&range)) {
> +=09=09=09hmm_range_unregister(&range);
> +=09=09=09up_read(&mm->mmap_sem);
> +=09=09=09continue;
> +=09=09}
> +=09=09mutex_lock(&dmirror->mutex);
> +=09=09ret =3D dmirror_pt_walk(dmirror, dmirror_do_fault,
> +=09=09=09=09      addr, next, &range, true);
> +=09=09mutex_unlock(&dmirror->mutex);
> +=09=09hmm_range_unregister(&range);
> +=09=09up_read(&mm->mmap_sem);
> +=09=09if (ret)
> +=09=09=09break;
> +
> +=09=09addr =3D next;
> +=09}
> +
> +=09return ret;
> +}
> +
> +static int dmirror_do_read(struct dmirror *dmirror,
> +=09=09=09   unsigned long addr,
> +=09=09=09   unsigned long end,
> +=09=09=09   u64 *dptep,
> +=09=09=09   void *private)
> +{
> +=09struct dmirror_bounce *bounce =3D private;
> +=09void *ptr;
> +
> +=09ptr =3D bounce->ptr + ((addr - bounce->addr) & PAGE_MASK);
> +
> +=09for (; addr < end; addr +=3D PAGE_SIZE, ++dptep) {
> +=09=09struct page *page;
> +=09=09void *tmp;
> +
> +=09=09page =3D dmirror_pt_page(dptep);
> +=09=09if (!page)
> +=09=09=09return -ENOENT;
> +
> +=09=09tmp =3D kmap(page);
> +=09=09memcpy(ptr, tmp, PAGE_SIZE);
> +=09=09kunmap(page);
> +
> +=09=09ptr +=3D PAGE_SIZE;
> +=09=09bounce->cpages++;
> +=09}
> +
> +=09return 0;
> +}
> +
> +static int dmirror_read(struct dmirror *dmirror,
> +=09=09=09struct hmm_dmirror_cmd *cmd)
> +{
> +=09struct dmirror_bounce bounce;
> +=09unsigned long start, end;
> +=09unsigned long size =3D cmd->npages << PAGE_SHIFT;
> +=09int ret;
> +
> +=09start =3D cmd->addr;
> +=09end =3D start + size;
> +=09if (end < start)
> +=09=09return -EINVAL;
> +
> +=09ret =3D dmirror_bounce_init(&bounce, start, size);
> +=09if (ret)
> +=09=09return ret;
> +
> +again:
> +=09mutex_lock(&dmirror->mutex);
> +=09ret =3D dmirror_pt_walk(dmirror, dmirror_do_read, start, end, &bounce=
,
> +=09=09=09=09false);
> +=09mutex_unlock(&dmirror->mutex);
> +=09if (ret =3D=3D 0)
> +=09=09ret =3D dmirror_bounce_copy_to(&bounce, cmd->ptr);
> +=09else if (ret =3D=3D -ENOENT) {
> +=09=09start =3D cmd->addr + (bounce.cpages << PAGE_SHIFT);
> +=09=09ret =3D dmirror_fault(dmirror, start, end, false);
> +=09=09if (ret =3D=3D 0) {
> +=09=09=09cmd->faults++;
> +=09=09=09goto again;
> +=09=09}
> +=09}
> +
> +=09cmd->cpages =3D bounce.cpages;
> +=09dmirror_bounce_fini(&bounce);
> +=09return ret;
> +}
> +
> +static int dmirror_do_write(struct dmirror *dmirror,
> +=09=09=09    unsigned long addr,
> +=09=09=09    unsigned long end,
> +=09=09=09    u64 *dptep,
> +=09=09=09    void *private)
> +{
> +=09struct dmirror_bounce *bounce =3D private;
> +=09void *ptr;
> +
> +=09ptr =3D bounce->ptr + ((addr - bounce->addr) & PAGE_MASK);
> +
> +=09for (; addr < end; addr +=3D PAGE_SIZE, ++dptep) {
> +=09=09struct page *page;
> +=09=09void *tmp;
> +
> +=09=09page =3D dmirror_pt_page_write(dptep);
> +=09=09if (!page)
> +=09=09=09return -ENOENT;
> +
> +=09=09tmp =3D kmap(page);
> +=09=09memcpy(tmp, ptr, PAGE_SIZE);
> +=09=09kunmap(page);
> +
> +=09=09ptr +=3D PAGE_SIZE;
> +=09=09bounce->cpages++;
> +=09}
> +
> +=09return 0;
> +}
> +
> +static int dmirror_write(struct dmirror *dmirror,
> +=09=09=09 struct hmm_dmirror_cmd *cmd)
> +{
> +=09struct dmirror_bounce bounce;
> +=09unsigned long start, end;
> +=09unsigned long size =3D cmd->npages << PAGE_SHIFT;
> +=09int ret;
> +
> +=09start =3D cmd->addr;
> +=09end =3D start + size;
> +=09if (end < start)
> +=09=09return -EINVAL;
> +
> +=09ret =3D dmirror_bounce_init(&bounce, start, size);
> +=09if (ret)
> +=09=09return ret;
> +=09ret =3D dmirror_bounce_copy_from(&bounce, cmd->ptr);
> +=09if (ret)
> +=09=09return ret;
> +
> +again:
> +=09mutex_lock(&dmirror->mutex);
> +=09ret =3D dmirror_pt_walk(dmirror, dmirror_do_write,
> +=09=09=09      start, end, &bounce, false);
> +=09mutex_unlock(&dmirror->mutex);
> +=09if (ret =3D=3D -ENOENT) {
> +=09=09start =3D cmd->addr + (bounce.cpages << PAGE_SHIFT);
> +=09=09ret =3D dmirror_fault(dmirror, start, end, true);
> +=09=09if (ret =3D=3D 0) {
> +=09=09=09cmd->faults++;
> +=09=09=09goto again;
> +=09=09}
> +=09}
> +
> +=09cmd->cpages =3D bounce.cpages;
> +=09dmirror_bounce_fini(&bounce);
> +=09return ret;
> +}
> +
> +static bool dmirror_allocate_chunk(struct dmirror_device *mdevice,
> +=09=09=09=09   struct page **ppage)
> +{
> +=09struct dmirror_chunk *devmem;
> +=09struct resource *res;
> +=09unsigned long pfn;
> +=09unsigned long pfn_first;
> +=09unsigned long pfn_last;
> +=09void *ptr;
> +
> +=09mutex_lock(&mdevice->devmem_lock);
> +
> +=09if (mdevice->devmem_count =3D=3D mdevice->devmem_capacity) {
> +=09=09struct dmirror_chunk **new_chunks;
> +=09=09unsigned int new_capacity;
> +
> +=09=09new_capacity =3D mdevice->devmem_capacity +
> +=09=09=09=09DEVMEM_CHUNKS_RESERVE;
> +=09=09new_chunks =3D krealloc(mdevice->devmem_chunks,
> +=09=09=09=09sizeof(new_chunks[0]) * new_capacity,
> +=09=09=09=09GFP_KERNEL);
> +=09=09if (!new_chunks)
> +=09=09=09goto err;
> +=09=09mdevice->devmem_capacity =3D new_capacity;
> +=09=09mdevice->devmem_chunks =3D new_chunks;
> +=09}
> +
> +=09res =3D devm_request_free_mem_region(&mdevice->pdevice->dev,
> +=09=09=09=09=09&iomem_resource, DEVMEM_CHUNK_SIZE);
> +=09if (IS_ERR(res))
> +=09=09goto err;
> +
> +=09devmem =3D kzalloc(sizeof(*devmem), GFP_KERNEL);
> +=09if (!devmem)
> +=09=09goto err;
> +
> +=09devmem->pagemap.type =3D MEMORY_DEVICE_PRIVATE;
> +=09devmem->pagemap.res =3D *res;
> +=09devmem->pagemap.ops =3D &dmirror_devmem_ops;
> +=09ptr =3D devm_memremap_pages(&mdevice->pdevice->dev, &devmem->pagemap)=
;
> +=09if (IS_ERR(ptr))
> +=09=09goto err_free;
> +
> +=09devmem->mdevice =3D mdevice;
> +=09pfn_first =3D devmem->pagemap.res.start >> PAGE_SHIFT;
> +=09pfn_last =3D pfn_first +
> +=09=09(resource_size(&devmem->pagemap.res) >> PAGE_SHIFT);
> +=09mdevice->devmem_chunks[mdevice->devmem_count++] =3D devmem;
> +
> +=09mutex_unlock(&mdevice->devmem_lock);
> +
> +=09pr_info("added new %u MB chunk (total %u chunks, %u MB) PFNs [0x%lx 0=
x%lx)\n",
> +=09=09DEVMEM_CHUNK_SIZE / (1024 * 1024),
> +=09=09mdevice->devmem_count,
> +=09=09mdevice->devmem_count * (DEVMEM_CHUNK_SIZE / (1024 * 1024)),
> +=09=09pfn_first, pfn_last);
> +
> +=09spin_lock(&mdevice->lock);
> +=09for (pfn =3D pfn_first; pfn < pfn_last; pfn++) {
> +=09=09struct page *page =3D pfn_to_page(pfn);
> +
> +=09=09page->zone_device_data =3D mdevice->free_pages;
> +=09=09mdevice->free_pages =3D page;
> +=09}
> +=09if (ppage) {
> +=09=09*ppage =3D mdevice->free_pages;
> +=09=09mdevice->free_pages =3D (*ppage)->zone_device_data;
> +=09=09mdevice->calloc++;
> +=09}
> +=09spin_unlock(&mdevice->lock);
> +
> +=09return true;
> +
> +err_free:
> +=09kfree(devmem);
> +err:
> +=09mutex_unlock(&mdevice->devmem_lock);
> +=09return false;
> +}
> +
> +static struct page *dmirror_devmem_alloc_page(struct dmirror_device *mde=
vice)
> +{
> +=09struct page *dpage =3D NULL;
> +=09struct page *rpage;
> +
> +=09/*
> +=09 * This is a fake device so we alloc real system memory to store
> +=09 * our device memory.
> +=09 */
> +=09rpage =3D alloc_page(GFP_HIGHUSER);
> +=09if (!rpage)
> +=09=09return NULL;
> +
> +=09spin_lock(&mdevice->lock);
> +
> +=09if (mdevice->free_pages) {
> +=09=09dpage =3D mdevice->free_pages;
> +=09=09mdevice->free_pages =3D dpage->zone_device_data;
> +=09=09mdevice->calloc++;
> +=09=09spin_unlock(&mdevice->lock);
> +=09} else {
> +=09=09spin_unlock(&mdevice->lock);
> +=09=09if (!dmirror_allocate_chunk(mdevice, &dpage))
> +=09=09=09goto error;
> +=09}
> +
> +=09dpage->zone_device_data =3D rpage;
> +=09get_page(dpage);
> +=09lock_page(dpage);
> +=09return dpage;
> +
> +error:
> +=09__free_page(rpage);
> +=09return NULL;
> +}
> +
> +static void dmirror_migrate_alloc_and_copy(struct migrate_vma *args,
> +=09=09=09=09=09   struct dmirror *dmirror)
> +{
> +=09struct dmirror_device *mdevice =3D dmirror->mdevice;
> +=09const unsigned long *src =3D args->src;
> +=09unsigned long *dst =3D args->dst;
> +=09unsigned long addr;
> +
> +=09for (addr =3D args->start; addr < args->end; addr +=3D PAGE_SIZE,
> +=09=09=09=09=09=09   src++, dst++) {
> +=09=09struct page *spage;
> +=09=09struct page *dpage;
> +=09=09struct page *rpage;
> +
> +=09=09if (!(*src & MIGRATE_PFN_MIGRATE))
> +=09=09=09continue;
> +
> +=09=09/*
> +=09=09 * Note that spage might be NULL which is OK since it is an
> +=09=09 * unallocated pte_none() or read-only zero page.
> +=09=09 */
> +=09=09spage =3D migrate_pfn_to_page(*src);
> +
> +=09=09/*
> +=09=09 * Don't migrate device private pages from our own driver or
> +=09=09 * others. For our own we would do a device private memory copy
> +=09=09 * not a migration and for others, we would need to fault the
> +=09=09 * other device's page into system memory first.
> +=09=09 */
> +=09=09if (spage && is_zone_device_page(spage))
> +=09=09=09continue;
> +
> +=09=09dpage =3D dmirror_devmem_alloc_page(mdevice);
> +=09=09if (!dpage)
> +=09=09=09continue;
> +
> +=09=09rpage =3D dpage->zone_device_data;
> +=09=09if (spage)
> +=09=09=09copy_highpage(rpage, spage);
> +=09=09else
> +=09=09=09clear_highpage(rpage);
> +
> +=09=09/*
> +=09=09 * Normally, a device would use the page->zone_device_data to
> +=09=09 * point to the mirror but here we use it to hold the page for
> +=09=09 * the simulated device memory and that page holds the pointer
> +=09=09 * to the mirror.
> +=09=09 */
> +=09=09rpage->zone_device_data =3D dmirror;
> +
> +=09=09*dst =3D migrate_pfn(page_to_pfn(dpage)) |
> +=09=09=09    MIGRATE_PFN_LOCKED;
> +=09=09if ((*src & MIGRATE_PFN_WRITE) ||
> +=09=09    (!spage && args->vma->vm_flags & VM_WRITE))
> +=09=09=09*dst |=3D MIGRATE_PFN_WRITE;
> +=09}
> +=09/* Try to pre-allocate page tables. */
> +=09mutex_lock(&dmirror->mutex);
> +=09dmirror_pt_walk(dmirror, NULL, args->start, args->end, NULL, true);
> +=09mutex_unlock(&dmirror->mutex);
> +}
> +
> +struct dmirror_migrate {
> +=09struct hmm_dmirror_cmd=09=09*cmd;
> +=09const unsigned long=09=09*src;
> +=09const unsigned long=09=09*dst;
> +=09unsigned long=09=09=09start;
> +};
> +
> +static int dmirror_do_migrate(struct dmirror *dmirror,
> +=09=09=09      unsigned long addr,
> +=09=09=09      unsigned long end,
> +=09=09=09      u64 *dptep,
> +=09=09=09      void *private)
> +{
> +=09struct dmirror_migrate *migrate =3D private;
> +=09const unsigned long *src =3D migrate->src;
> +=09const unsigned long *dst =3D migrate->dst;
> +=09unsigned long idx =3D (addr - migrate->start) >> PAGE_SHIFT;
> +
> +=09for (; addr < end; addr +=3D PAGE_SIZE, ++dptep, ++idx) {
> +=09=09struct page *page;
> +=09=09u64 dpte;
> +
> +=09=09if (!(src[idx] & MIGRATE_PFN_MIGRATE))
> +=09=09=09continue;
> +
> +=09=09page =3D migrate_pfn_to_page(dst[idx]);
> +=09=09if (!page)
> +=09=09=09continue;
> +
> +=09=09/*
> +=09=09 * Map the page that holds the data so dmirror_pt_walk()
> +=09=09 * doesn't have to deal with ZONE_DEVICE private pages.
> +=09=09 */
> +=09=09page =3D page->zone_device_data;
> +=09=09dpte =3D dmirror_pt_from_page(page) | DPT_DPAGE;
> +=09=09if (dst[idx] & MIGRATE_PFN_WRITE)
> +=09=09=09dpte |=3D DPT_WRITE;
> +=09=09*dptep =3D dpte;
> +=09}
> +
> +=09return 0;
> +}
> +
> +static void dmirror_migrate_finalize_and_map(struct migrate_vma *args,
> +=09=09=09=09=09     struct dmirror *dmirror,
> +=09=09=09=09=09     struct hmm_dmirror_cmd *cmd)
> +{
> +=09struct dmirror_migrate migrate;
> +
> +=09migrate.cmd =3D cmd;
> +=09migrate.src =3D args->src;
> +=09migrate.dst =3D args->dst;
> +=09migrate.start =3D args->start;
> +
> +=09/* Map the migrated pages into the device's page tables. */
> +=09mutex_lock(&dmirror->mutex);
> +=09dmirror_pt_walk(dmirror, dmirror_do_migrate, args->start, args->end,
> +=09=09=09&migrate, true);
> +=09mutex_unlock(&dmirror->mutex);
> +}
> +
> +static int dmirror_migrate(struct dmirror *dmirror,
> +=09=09=09   struct hmm_dmirror_cmd *cmd)
> +{
> +=09unsigned long start, end, addr;
> +=09unsigned long size =3D cmd->npages << PAGE_SHIFT;
> +=09struct mm_struct *mm =3D dmirror->mirror.hmm->mmu_notifier.mm;
> +=09struct vm_area_struct *vma;
> +=09unsigned long src_pfns[64];
> +=09unsigned long dst_pfns[64];
> +=09struct dmirror_bounce bounce;
> +=09struct migrate_vma args;
> +=09unsigned long next;
> +=09int ret;
> +
> +=09start =3D cmd->addr;
> +=09end =3D start + size;
> +=09if (end < start)
> +=09=09return -EINVAL;
> +
> +=09down_read(&mm->mmap_sem);
> +=09for (addr =3D start; addr < end; addr =3D next) {
> +=09=09next =3D min(end, addr + (ARRAY_SIZE(src_pfns) << PAGE_SHIFT));
> +
> +=09=09vma =3D find_vma(mm, addr);
> +=09=09if (!vma || addr < vma->vm_start) {
> +=09=09=09ret =3D -EINVAL;
> +=09=09=09goto out;
> +=09=09}
> +=09=09if (next > vma->vm_end)
> +=09=09=09next =3D vma->vm_end;
> +
> +=09=09args.vma =3D vma;
> +=09=09args.src =3D src_pfns;
> +=09=09args.dst =3D dst_pfns;
> +=09=09args.start =3D addr;
> +=09=09args.end =3D next;
> +=09=09ret =3D migrate_vma_setup(&args);
> +=09=09if (ret)
> +=09=09=09goto out;
> +
> +=09=09dmirror_migrate_alloc_and_copy(&args, dmirror);
> +=09=09migrate_vma_pages(&args);
> +=09=09dmirror_migrate_finalize_and_map(&args, dmirror, cmd);
> +=09=09migrate_vma_finalize(&args);
> +=09}
> +=09up_read(&mm->mmap_sem);
> +
> +=09/* Return the migrated data for verification. */
> +=09ret =3D dmirror_bounce_init(&bounce, start, size);
> +=09if (ret)
> +=09=09return ret;
> +=09mutex_lock(&dmirror->mutex);
> +=09ret =3D dmirror_pt_walk(dmirror, dmirror_do_read, start, end, &bounce=
,
> +=09=09=09=09false);
> +=09mutex_unlock(&dmirror->mutex);
> +=09if (ret =3D=3D 0)
> +=09=09ret =3D dmirror_bounce_copy_to(&bounce, cmd->ptr);
> +=09cmd->cpages =3D bounce.cpages;
> +=09dmirror_bounce_fini(&bounce);
> +=09return ret;
> +
> +out:
> +=09up_read(&mm->mmap_sem);
> +=09return ret;
> +}
> +
> +static void dmirror_mkentry(struct dmirror *dmirror,
> +=09=09=09    struct hmm_range *range,
> +=09=09=09    unsigned char *perm,
> +=09=09=09    uint64_t entry)
> +{
> +=09struct page *page;
> +
> +=09if (entry =3D=3D range->values[HMM_PFN_ERROR]) {
> +=09=09*perm =3D HMM_DMIRROR_PROT_ERROR;
> +=09=09return;
> +=09}
> +=09page =3D hmm_device_entry_to_page(range, entry);
> +=09if (!page) {
> +=09=09*perm =3D HMM_DMIRROR_PROT_NONE;
> +=09=09return;
> +=09}
> +=09if (entry & range->flags[HMM_PFN_DEVICE_PRIVATE]) {
> +=09=09/* Is the page migrated to this device or some other? */
> +=09=09if (dmirror->mdevice =3D=3D dmirror_page_to_device(page))
> +=09=09=09*perm =3D HMM_DMIRROR_PROT_DEV_PRIVATE_LOCAL;
> +=09=09else
> +=09=09=09*perm =3D HMM_DMIRROR_PROT_DEV_PRIVATE_REMOTE;
> +=09} else if (is_zero_pfn(page_to_pfn(page)))
> +=09=09*perm =3D HMM_DMIRROR_PROT_ZERO;
> +=09else
> +=09=09*perm =3D HMM_DMIRROR_PROT_NONE;
> +=09if (entry & range->flags[HMM_PFN_WRITE])
> +=09=09*perm |=3D HMM_DMIRROR_PROT_WRITE;
> +=09else
> +=09=09*perm |=3D HMM_DMIRROR_PROT_READ;
> +}
> +
> +static int dmirror_snapshot(struct dmirror *dmirror,
> +=09=09=09    struct hmm_dmirror_cmd *cmd)
> +{
> +=09struct mm_struct *mm =3D dmirror->mirror.hmm->mmu_notifier.mm;
> +=09unsigned long start, end;
> +=09unsigned long size =3D cmd->npages << PAGE_SHIFT;
> +=09unsigned long addr;
> +=09unsigned long next;
> +=09uint64_t pfns[64];
> +=09unsigned char perm[64];
> +=09char __user *uptr;
> +=09struct hmm_range range =3D {
> +=09=09.pfns =3D pfns,
> +=09=09.flags =3D dmirror_hmm_flags,
> +=09=09.values =3D dmirror_hmm_values,
> +=09=09.pfn_shift =3D DPT_SHIFT,
> +=09=09.pfn_flags_mask =3D ~0ULL,
> +=09};
> +=09int ret =3D 0;
> +
> +=09start =3D cmd->addr;
> +=09end =3D start + size;
> +=09uptr =3D (void __user *)cmd->ptr;
> +
> +=09for (addr =3D start; addr < end; ) {
> +=09=09long count;
> +=09=09unsigned long i;
> +=09=09unsigned long n;
> +
> +=09=09next =3D min(addr + (ARRAY_SIZE(pfns) << PAGE_SHIFT), end);
> +=09=09range.start =3D addr;
> +=09=09range.end =3D next;
> +
> +=09=09down_read(&mm->mmap_sem);
> +
> +=09=09ret =3D hmm_range_register(&range, &dmirror->mirror);
> +=09=09if (ret) {
> +=09=09=09up_read(&mm->mmap_sem);
> +=09=09=09break;
> +=09=09}
> +
> +=09=09if (!hmm_range_wait_until_valid(&range,
> +=09=09=09=09=09=09DMIRROR_RANGE_FAULT_TIMEOUT)) {
> +=09=09=09hmm_range_unregister(&range);
> +=09=09=09up_read(&mm->mmap_sem);
> +=09=09=09continue;
> +=09=09}
> +
> +=09=09count =3D hmm_range_fault(&range, HMM_FAULT_SNAPSHOT);
> +=09=09if (count < 0) {
> +=09=09=09ret =3D count;
> +=09=09=09hmm_range_unregister(&range);
> +=09=09=09up_read(&mm->mmap_sem);
> +=09=09=09if (ret =3D=3D -EBUSY)
> +=09=09=09=09continue;
> +=09=09=09break;
> +=09=09}
> +
> +=09=09if (!hmm_range_valid(&range)) {
> +=09=09=09hmm_range_unregister(&range);
> +=09=09=09up_read(&mm->mmap_sem);
> +=09=09=09continue;
> +=09=09}
> +
> +=09=09n =3D (next - addr) >> PAGE_SHIFT;
> +=09=09for (i =3D 0; i < n; i++)
> +=09=09=09dmirror_mkentry(dmirror, &range, perm + i, pfns[i]);
> +=09=09hmm_range_unregister(&range);
> +=09=09up_read(&mm->mmap_sem);
> +
> +=09=09ret =3D copy_to_user(uptr, perm, n);
> +=09=09if (ret)
> +=09=09=09break;
> +
> +=09=09cmd->cpages +=3D n;
> +=09=09uptr +=3D n;
> +=09=09addr =3D next;
> +=09}
> +
> +=09return ret;
> +}
> +
> +static long dmirror_fops_unlocked_ioctl(struct file *filp,
> +=09=09=09=09=09unsigned int command,
> +=09=09=09=09=09unsigned long arg)
> +{
> +=09void __user *uarg =3D (void __user *)arg;
> +=09struct hmm_dmirror_cmd cmd;
> +=09struct dmirror *dmirror;
> +=09int ret;
> +
> +=09dmirror =3D filp->private_data;
> +=09if (!dmirror)
> +=09=09return -EINVAL;
> +
> +=09ret =3D copy_from_user(&cmd, uarg, sizeof(cmd));
> +=09if (ret)
> +=09=09return ret;
> +
> +=09if (cmd.addr & ~PAGE_MASK)
> +=09=09return -EINVAL;
> +=09if (cmd.addr >=3D (cmd.addr + (cmd.npages << PAGE_SHIFT)))
> +=09=09return -EINVAL;
> +
> +=09cmd.cpages =3D 0;
> +=09cmd.faults =3D 0;
> +
> +=09switch (command) {
> +=09case HMM_DMIRROR_READ:
> +=09=09ret =3D dmirror_read(dmirror, &cmd);
> +=09=09break;
> +
> +=09case HMM_DMIRROR_WRITE:
> +=09=09ret =3D dmirror_write(dmirror, &cmd);
> +=09=09break;
> +
> +=09case HMM_DMIRROR_MIGRATE:
> +=09=09ret =3D dmirror_migrate(dmirror, &cmd);
> +=09=09break;
> +
> +=09case HMM_DMIRROR_SNAPSHOT:
> +=09=09ret =3D dmirror_snapshot(dmirror, &cmd);
> +=09=09break;
> +
> +=09default:
> +=09=09return -EINVAL;
> +=09}
> +=09if (ret)
> +=09=09return ret;
> +
> +=09return copy_to_user(uarg, &cmd, sizeof(cmd));
> +}
> +
> +static const struct file_operations dmirror_fops =3D {
> +=09.read=09=09=3D dmirror_fops_read,
> +=09.write=09=09=3D dmirror_fops_write,
> +=09.mmap=09=09=3D dmirror_fops_mmap,
> +=09.open=09=09=3D dmirror_fops_open,
> +=09.release=09=3D dmirror_fops_release,
> +=09.unlocked_ioctl =3D dmirror_fops_unlocked_ioctl,
> +=09.llseek=09=09=3D default_llseek,
> +=09.owner=09=09=3D THIS_MODULE,
> +};
> +
> +static void dmirror_devmem_free(struct page *page)
> +{
> +=09struct page *rpage =3D page->zone_device_data;
> +=09struct dmirror_device *mdevice;
> +
> +=09if (rpage)
> +=09=09__free_page(rpage);
> +
> +=09mdevice =3D dmirror_page_to_device(page);
> +
> +=09spin_lock(&mdevice->lock);
> +=09mdevice->cfree++;
> +=09page->zone_device_data =3D mdevice->free_pages;
> +=09mdevice->free_pages =3D page;
> +=09spin_unlock(&mdevice->lock);
> +}
> +
> +static vm_fault_t dmirror_devmem_fault_alloc_and_copy(struct migrate_vma=
 *args,
> +=09=09=09=09=09=09struct dmirror_device *mdevice)
> +{
> +=09struct vm_area_struct *vma =3D args->vma;
> +=09const unsigned long *src =3D args->src;
> +=09unsigned long *dst =3D args->dst;
> +=09unsigned long start =3D args->start;
> +=09unsigned long end =3D args->end;
> +=09unsigned long addr;
> +
> +=09for (addr =3D start; addr < end; addr +=3D PAGE_SIZE,
> +=09=09=09=09       src++, dst++) {
> +=09=09struct page *dpage, *spage;
> +
> +=09=09spage =3D migrate_pfn_to_page(*src);
> +=09=09if (!spage || !(*src & MIGRATE_PFN_MIGRATE))
> +=09=09=09continue;
> +=09=09if (!dmirror_device_is_mine(mdevice, spage))
> +=09=09=09continue;
> +=09=09spage =3D spage->zone_device_data;
> +
> +=09=09dpage =3D alloc_page_vma(GFP_HIGHUSER_MOVABLE, vma, addr);
> +=09=09if (!dpage)
> +=09=09=09continue;
> +
> +=09=09lock_page(dpage);
> +=09=09copy_highpage(dpage, spage);
> +=09=09*dst =3D migrate_pfn(page_to_pfn(dpage)) |
> +=09=09=09    MIGRATE_PFN_LOCKED;
> +=09=09if (*src & MIGRATE_PFN_WRITE)
> +=09=09=09*dst |=3D MIGRATE_PFN_WRITE;
> +=09}
> +=09return 0;
> +}
> +
> +static void dmirror_devmem_fault_finalize_and_map(struct migrate_vma *ar=
gs,
> +=09=09=09=09=09=09  struct dmirror *dmirror)
> +{
> +=09/* Invalidate the device's page table mapping. */
> +=09mutex_lock(&dmirror->mutex);
> +=09dmirror_pt_walk(dmirror, dmirror_do_update, args->start, args->end,
> +=09=09=09NULL, false);
> +=09mutex_unlock(&dmirror->mutex);
> +}
> +
> +static vm_fault_t dmirror_devmem_fault(struct vm_fault *vmf)
> +{
> +=09struct migrate_vma args;
> +=09unsigned long src_pfns;
> +=09unsigned long dst_pfns;
> +=09struct page *rpage;
> +=09struct dmirror *dmirror;
> +=09vm_fault_t ret;
> +
> +=09/* FIXME demonstrate how we can adjust migrate range */
> +=09args.vma =3D vmf->vma;
> +=09args.start =3D vmf->address;
> +=09args.end =3D args.start + PAGE_SIZE;
> +=09args.src =3D &src_pfns;
> +=09args.dst =3D &dst_pfns;
> +
> +=09if (migrate_vma_setup(&args))
> +=09=09return VM_FAULT_SIGBUS;
> +
> +=09/*
> +=09 * Normally, a device would use the page->zone_device_data to point t=
o
> +=09 * the mirror but here we use it to hold the page for the simulated
> +=09 * device memory and that page holds the pointer to the mirror.
> +=09 */
> +=09rpage =3D vmf->page->zone_device_data;
> +=09dmirror =3D rpage->zone_device_data;
> +
> +=09ret =3D dmirror_devmem_fault_alloc_and_copy(&args, dmirror->mdevice);
> +=09if (ret)
> +=09=09return ret;
> +=09migrate_vma_pages(&args);
> +=09dmirror_devmem_fault_finalize_and_map(&args, dmirror);
> +=09migrate_vma_finalize(&args);
> +=09return 0;
> +}
> +
> +static const struct dev_pagemap_ops dmirror_devmem_ops =3D {
> +=09.page_free=09=3D dmirror_devmem_free,
> +=09.migrate_to_ram=09=3D dmirror_devmem_fault,
> +};
> +
> +static void dmirror_pdev_del(void *arg)
> +{
> +=09struct dmirror_device *mdevice =3D arg;
> +=09unsigned int i;
> +
> +=09if (mdevice->devmem_chunks) {
> +=09=09for (i =3D 0; i < mdevice->devmem_count; i++)
> +=09=09=09kfree(mdevice->devmem_chunks[i]);
> +=09=09kfree(mdevice->devmem_chunks);
> +=09}
> +
> +=09cdev_del(&mdevice->cdevice);
> +=09kfree(mdevice);
> +}
> +
> +static int dmirror_probe(struct platform_device *pdev)
> +{
> +=09struct dmirror_device *mdevice;
> +=09int ret;
> +
> +=09mdevice =3D kzalloc(sizeof(*mdevice), GFP_KERNEL);
> +=09if (!mdevice)
> +=09=09return -ENOMEM;
> +
> +=09mdevice->pdevice =3D pdev;
> +=09mutex_init(&mdevice->devmem_lock);
> +=09spin_lock_init(&mdevice->lock);
> +
> +=09cdev_init(&mdevice->cdevice, &dmirror_fops);
> +=09ret =3D cdev_add(&mdevice->cdevice, pdev->dev.devt, 1);
> +=09if (ret) {
> +=09=09kfree(mdevice);
> +=09=09return ret;
> +=09}
> +
> +=09platform_set_drvdata(pdev, mdevice);
> +=09ret =3D devm_add_action_or_reset(&pdev->dev, dmirror_pdev_del, mdevic=
e);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09/* Build list of free struct page */
> +=09dmirror_allocate_chunk(mdevice, NULL);
> +
> +=09return 0;
> +}
> +
> +static int dmirror_remove(struct platform_device *pdev)
> +{
> +=09/* all probe actions are unwound by devm */
> +=09return 0;
> +}
> +
> +static struct platform_driver dmirror_device_driver =3D {
> +=09.probe=09=09=3D dmirror_probe,
> +=09.remove=09=09=3D dmirror_remove,
> +=09.driver=09=09=3D {
> +=09=09.name=09=3D "HMM_DMIRROR",
> +=09},
> +};
> +
> +static int __init hmm_dmirror_init(void)
> +{
> +=09int ret;
> +=09int id;
> +
> +=09ret =3D platform_driver_register(&dmirror_device_driver);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09ret =3D alloc_chrdev_region(&dmirror_dev, 0, DMIRROR_NDEVICES,
> +=09=09=09=09  "HMM_DMIRROR");
> +=09if (ret)
> +=09=09goto err_unreg;
> +
> +=09for (id =3D 0; id < DMIRROR_NDEVICES; id++) {
> +=09=09struct platform_device *pd;
> +
> +=09=09pd =3D platform_device_alloc("HMM_DMIRROR", id);
> +=09=09if (!pd) {
> +=09=09=09ret =3D -ENOMEM;
> +=09=09=09goto err_chrdev;
> +=09=09}
> +=09=09pd->dev.devt =3D MKDEV(MAJOR(dmirror_dev), id);
> +=09=09ret =3D platform_device_add(pd);
> +=09=09if (ret) {
> +=09=09=09platform_device_put(pd);
> +=09=09=09goto err_chrdev;
> +=09=09}
> +=09=09dmirror_platform_devices[id] =3D pd;
> +=09}
> +
> +=09/*
> +=09 * Allocate a zero page to simulate a reserved page of device private
> +=09 * memory which is always zero. The zero_pfn page isn't used just to
> +=09 * make the code here simpler (i.e., we need a struct page for it).
> +=09 */
> +=09dmirror_zero_page =3D alloc_page(GFP_HIGHUSER | __GFP_ZERO);
> +=09if (!dmirror_zero_page)
> +=09=09goto err_chrdev;
> +
> +=09pr_info("hmm_dmirror loaded. This is only for testing HMM.\n");
> +=09return 0;
> +
> +err_chrdev:
> +=09while (--id >=3D 0) {
> +=09=09platform_device_unregister(dmirror_platform_devices[id]);
> +=09=09dmirror_platform_devices[id] =3D NULL;
> +=09}
> +=09unregister_chrdev_region(dmirror_dev, 1);
> +err_unreg:
> +=09platform_driver_unregister(&dmirror_device_driver);
> +=09return ret;
> +}
> +
> +static void __exit hmm_dmirror_exit(void)
> +{
> +=09int id;
> +
> +=09if (dmirror_zero_page)
> +=09=09__free_page(dmirror_zero_page);
> +=09for (id =3D 0; id < DMIRROR_NDEVICES; id++)
> +=09=09platform_device_unregister(dmirror_platform_devices[id]);
> +=09unregister_chrdev_region(dmirror_dev, DMIRROR_NDEVICES);
> +=09platform_driver_unregister(&dmirror_device_driver);
> +=09mmu_notifier_synchronize();
> +}
> +
> +module_init(hmm_dmirror_init);
> +module_exit(hmm_dmirror_exit);
> +MODULE_LICENSE("GPL");
> diff --git a/include/Kbuild b/include/Kbuild
> index ffba79483cc5..6ffb44a45957 100644
> --- a/include/Kbuild
> +++ b/include/Kbuild
> @@ -1063,6 +1063,7 @@ header-test-=09=09=09+=3D uapi/linux/coda_psdev.h
>  header-test-=09=09=09+=3D uapi/linux/errqueue.h
>  header-test-=09=09=09+=3D uapi/linux/eventpoll.h
>  header-test-=09=09=09+=3D uapi/linux/hdlc/ioctl.h
> +header-test-=09=09=09+=3D uapi/linux/hmm_dmirror.h
>  header-test-=09=09=09+=3D uapi/linux/input.h
>  header-test-=09=09=09+=3D uapi/linux/kvm.h
>  header-test-=09=09=09+=3D uapi/linux/kvm_para.h
> diff --git a/include/uapi/linux/hmm_dmirror.h b/include/uapi/linux/hmm_dm=
irror.h
> new file mode 100644
> index 000000000000..61d3643aff95
> --- /dev/null
> +++ b/include/uapi/linux/hmm_dmirror.h
> @@ -0,0 +1,74 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Copyright 2013 Red Hat Inc.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * Authors: J=E9r=F4me Glisse <jglisse@redhat.com>
> + */
> +/*
> + * This is a dummy driver to exercise the HMM (heterogeneous memory mana=
gement)
> + * API of the kernel. It allows a userspace program to expose its entire=
 address
> + * space through the HMM dummy driver file.
> + */
> +#ifndef _UAPI_LINUX_HMM_DMIRROR_H
> +#define _UAPI_LINUX_HMM_DMIRROR_H
> +
> +#include <linux/types.h>
> +#include <linux/ioctl.h>
> +
> +/*
> + * Structure to pass to the HMM test driver to mimic a device accessing
> + * system memory and ZONE_DEVICE private memory through device page tabl=
es.
> + *
> + * @addr: (in) user address the device will read/write
> + * @ptr: (in) user address where device data is copied to/from
> + * @npages: (in) number of pages to read/write
> + * @cpages: (out) number of pages copied
> + * @faults: (out) number of device page faults seen
> + */
> +struct hmm_dmirror_cmd {
> +=09__u64=09=09addr;
> +=09__u64=09=09ptr;
> +=09__u64=09=09npages;
> +=09__u64=09=09cpages;
> +=09__u64=09=09faults;
> +};
> +
> +/* Expose the address space of the calling process through hmm dummy dev=
 file */
> +#define HMM_DMIRROR_READ=09=09_IOWR('H', 0x00, struct hmm_dmirror_cmd)
> +#define HMM_DMIRROR_WRITE=09=09_IOWR('H', 0x01, struct hmm_dmirror_cmd)
> +#define HMM_DMIRROR_MIGRATE=09=09_IOWR('H', 0x02, struct hmm_dmirror_cmd=
)
> +#define HMM_DMIRROR_SNAPSHOT=09=09_IOWR('H', 0x03, struct hmm_dmirror_cm=
d)
> +
> +/*
> + * Values returned in hmm_dmirror_cmd.ptr for HMM_DMIRROR_SNAPSHOT.
> + * HMM_DMIRROR_PROT_ERROR: no valid mirror PTE for this page
> + * HMM_DMIRROR_PROT_NONE: unpopulated PTE or PTE with no access
> + * HMM_DMIRROR_PROT_READ: read-only PTE
> + * HMM_DMIRROR_PROT_WRITE: read/write PTE
> + * HMM_DMIRROR_PROT_ZERO: special read-only zero page
> + * HMM_DMIRROR_PROT_DEV_PRIVATE_LOCAL: Migrated device private page on t=
he
> + *=09=09=09=09=09device the ioctl() is made
> + * HMM_DMIRROR_PROT_DEV_PRIVATE_REMOTE: Migrated device private page on =
some
> + *=09=09=09=09=09other device
> + */
> +enum {
> +=09HMM_DMIRROR_PROT_ERROR=09=09=09=3D 0xFF,
> +=09HMM_DMIRROR_PROT_NONE=09=09=09=3D 0x00,
> +=09HMM_DMIRROR_PROT_READ=09=09=09=3D 0x01,
> +=09HMM_DMIRROR_PROT_WRITE=09=09=09=3D 0x02,
> +=09HMM_DMIRROR_PROT_ZERO=09=09=09=3D 0x10,
> +=09HMM_DMIRROR_PROT_DEV_PRIVATE_LOCAL=09=3D 0x20,
> +=09HMM_DMIRROR_PROT_DEV_PRIVATE_REMOTE=09=3D 0x30,
> +};
> +
> +#endif /* _UAPI_LINUX_HMM_DMIRROR_H */
> diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/selfte=
sts/vm/.gitignore
> index 31b3c98b6d34..3054565b3f07 100644
> --- a/tools/testing/selftests/vm/.gitignore
> +++ b/tools/testing/selftests/vm/.gitignore
> @@ -14,3 +14,4 @@ virtual_address_range
>  gup_benchmark
>  va_128TBswitch
>  map_fixed_noreplace
> +hmm-tests
> diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftest=
s/vm/Makefile
> index 9534dc2bc929..5643cfb5e3d6 100644
> --- a/tools/testing/selftests/vm/Makefile
> +++ b/tools/testing/selftests/vm/Makefile
> @@ -5,6 +5,7 @@ CFLAGS =3D -Wall -I ../../../../usr/include $(EXTRA_CFLAG=
S)
>  LDLIBS =3D -lrt
>  TEST_GEN_FILES =3D compaction_test
>  TEST_GEN_FILES +=3D gup_benchmark
> +TEST_GEN_FILES +=3D hmm-tests
>  TEST_GEN_FILES +=3D hugepage-mmap
>  TEST_GEN_FILES +=3D hugepage-shm
>  TEST_GEN_FILES +=3D map_hugetlb
> @@ -26,6 +27,8 @@ TEST_FILES :=3D test_vmalloc.sh
>  KSFT_KHDR_INSTALL :=3D 1
>  include ../lib.mk
> =20
> +$(OUTPUT)/hmm-tests: LDLIBS +=3D -lhugetlbfs -lpthread
> +
>  $(OUTPUT)/userfaultfd: LDLIBS +=3D -lpthread
> =20
>  $(OUTPUT)/mlock-random-test: LDLIBS +=3D -lcap
> diff --git a/tools/testing/selftests/vm/config b/tools/testing/selftests/=
vm/config
> index 1c0d76cb5adf..34cfab18e737 100644
> --- a/tools/testing/selftests/vm/config
> +++ b/tools/testing/selftests/vm/config
> @@ -1,2 +1,5 @@
>  CONFIG_SYSVIPC=3Dy
>  CONFIG_USERFAULTFD=3Dy
> +CONFIG_HMM_MIRROR=3Dy
> +CONFIG_DEVICE_PRIVATE=3Dy
> +CONFIG_HMM_DMIRROR=3Dm
> diff --git a/tools/testing/selftests/vm/hmm-tests.c b/tools/testing/selft=
ests/vm/hmm-tests.c
> new file mode 100644
> index 000000000000..f4ae6188fd0e
> --- /dev/null
> +++ b/tools/testing/selftests/vm/hmm-tests.c
> @@ -0,0 +1,1311 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2013 Red Hat Inc.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * Authors: J=E9r=F4me Glisse <jglisse@redhat.com>
> + */
> +
> +/*
> + * HMM stands for Heterogeneous Memory Management, it is a helper layer =
inside
> + * the linux kernel to help device drivers mirror a process address spac=
e in
> + * the device. This allows the device to use the same address space whic=
h
> + * makes communication and data exchange a lot easier.
> + *
> + * This framework's sole purpose is to exercise various code paths insid=
e
> + * the kernel to make sure that HMM performs as expected and to flush ou=
t any
> + * bugs.
> + */
> +
> +#include "../kselftest_harness.h"
> +
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <stdint.h>
> +#include <unistd.h>
> +#include <strings.h>
> +#include <time.h>
> +#include <pthread.h>
> +#include <hugetlbfs.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <sys/mman.h>
> +#include <sys/ioctl.h>
> +#include <linux/hmm_dmirror.h>
> +
> +struct hmm_buffer {
> +=09void=09=09*ptr;
> +=09void=09=09*mirror;
> +=09unsigned long=09size;
> +=09int=09=09fd;
> +=09uint64_t=09cpages;
> +=09uint64_t=09faults;
> +};
> +
> +#define TWOMEG=09=09(1 << 21)
> +#define HMM_BUFFER_SIZE (1024 << 12)
> +#define HMM_PATH_MAX    64
> +#define NTIMES=09=09256
> +
> +#define ALIGN(x, a) (((x) + (a - 1)) & (~((a) - 1)))
> +
> +FIXTURE(hmm)
> +{
> +=09int=09=09fd;
> +=09unsigned int=09page_size;
> +=09unsigned int=09page_shift;
> +};
> +
> +FIXTURE(hmm2)
> +{
> +=09int=09=09fd0;
> +=09int=09=09fd1;
> +=09unsigned int=09page_size;
> +=09unsigned int=09page_shift;
> +};
> +
> +static int hmm_open(int unit)
> +{
> +=09char pathname[HMM_PATH_MAX];
> +=09int fd;
> +
> +=09snprintf(pathname, sizeof(pathname), "/dev/hmm_dmirror%d", unit);
> +=09fd =3D open(pathname, O_RDWR, 0);
> +=09if (fd < 0)
> +=09=09fprintf(stderr, "could not open hmm dmirror driver (%s)\n",
> +=09=09=09pathname);
> +=09return fd;
> +}
> +
> +FIXTURE_SETUP(hmm)
> +{
> +=09self->page_size =3D sysconf(_SC_PAGE_SIZE);
> +=09self->page_shift =3D ffs(self->page_size) - 1;
> +
> +=09self->fd =3D hmm_open(0);
> +=09ASSERT_GE(self->fd, 0);
> +}
> +
> +FIXTURE_SETUP(hmm2)
> +{
> +=09self->page_size =3D sysconf(_SC_PAGE_SIZE);
> +=09self->page_shift =3D ffs(self->page_size) - 1;
> +
> +=09self->fd0 =3D hmm_open(0);
> +=09ASSERT_GE(self->fd0, 0);
> +=09self->fd1 =3D hmm_open(1);
> +=09ASSERT_GE(self->fd1, 0);
> +}
> +
> +FIXTURE_TEARDOWN(hmm)
> +{
> +=09int ret =3D close(self->fd);
> +
> +=09ASSERT_EQ(ret, 0);
> +=09self->fd =3D -1;
> +}
> +
> +FIXTURE_TEARDOWN(hmm2)
> +{
> +=09int ret =3D close(self->fd0);
> +
> +=09ASSERT_EQ(ret, 0);
> +=09self->fd0 =3D -1;
> +
> +=09ret =3D close(self->fd1);
> +=09ASSERT_EQ(ret, 0);
> +=09self->fd1 =3D -1;
> +}
> +
> +static int hmm_dmirror_cmd(int fd,
> +=09=09=09   unsigned long request,
> +=09=09=09   struct hmm_buffer *buffer,
> +=09=09=09   unsigned long npages)
> +{
> +=09struct hmm_dmirror_cmd cmd;
> +=09int ret;
> +
> +=09/* Simulate a device reading system memory. */
> +=09cmd.addr =3D (__u64)buffer->ptr;
> +=09cmd.ptr =3D (__u64)buffer->mirror;
> +=09cmd.npages =3D npages;
> +
> +=09for (;;) {
> +=09=09ret =3D ioctl(fd, request, &cmd);
> +=09=09if (ret =3D=3D 0)
> +=09=09=09break;
> +=09=09if (errno =3D=3D EINTR)
> +=09=09=09continue;
> +=09=09return -errno;
> +=09}
> +=09buffer->cpages =3D cmd.cpages;
> +=09buffer->faults =3D cmd.faults;
> +
> +=09return 0;
> +}
> +
> +static void hmm_buffer_free(struct hmm_buffer *buffer)
> +{
> +=09if (buffer =3D=3D NULL)
> +=09=09return;
> +
> +=09if (buffer->ptr)
> +=09=09munmap(buffer->ptr, buffer->size);
> +=09free(buffer->mirror);
> +=09free(buffer);
> +}
> +
> +/*
> + * Create a temporary file that will be deleted on close.
> + */
> +static int hmm_create_file(unsigned long size)
> +{
> +=09char path[HMM_PATH_MAX];
> +=09int fd;
> +
> +=09strcpy(path, "/tmp");
> +=09fd =3D open(path, O_TMPFILE | O_EXCL | O_RDWR, 0600);
> +=09if (fd >=3D 0) {
> +=09=09int r;
> +
> +=09=09do {
> +=09=09=09r =3D ftruncate(fd, size);
> +=09=09} while (r =3D=3D -1 && errno =3D=3D EINTR);
> +=09=09if (!r)
> +=09=09=09return fd;
> +=09=09close(fd);
> +=09}
> +=09return -1;
> +}
> +
> +/*
> + * Return a random unsigned number.
> + */
> +static unsigned int hmm_random(void)
> +{
> +=09static int fd =3D -1;
> +=09unsigned int r;
> +
> +=09if (fd < 0) {
> +=09=09fd =3D open("/dev/urandom", O_RDONLY);
> +=09=09if (fd < 0) {
> +=09=09=09fprintf(stderr, "%s:%d failed to open /dev/urandom\n",
> +=09=09=09=09=09__FILE__, __LINE__);
> +=09=09=09return ~0U;
> +=09=09}
> +=09}
> +=09read(fd, &r, sizeof(r));
> +=09return r;
> +}
> +
> +static void hmm_nanosleep(unsigned int n)
> +{
> +=09struct timespec t;
> +
> +=09t.tv_sec =3D 0;
> +=09t.tv_nsec =3D n;
> +=09nanosleep(&t, NULL);
> +}
> +
> +/*
> + * Simple NULL test of device open/close.
> + */
> +TEST_F(hmm, open_close)
> +{
> +}
> +
> +/*
> + * Read private anonymous memory.
> + */
> +TEST_F(hmm, anon_read)
> +{
> +=09struct hmm_buffer *buffer;
> +=09unsigned long npages;
> +=09unsigned long size;
> +=09unsigned long i;
> +=09int *ptr;
> +=09int ret;
> +=09int val;
> +
> +=09npages =3D ALIGN(HMM_BUFFER_SIZE, self->page_size) >> self->page_shif=
t;
> +=09ASSERT_NE(npages, 0);
> +=09size =3D npages << self->page_shift;
> +
> +=09buffer =3D malloc(sizeof(*buffer));
> +=09ASSERT_NE(buffer, NULL);
> +
> +=09buffer->fd =3D -1;
> +=09buffer->size =3D size;
> +=09buffer->mirror =3D malloc(size);
> +=09ASSERT_NE(buffer->mirror, NULL);
> +
> +=09buffer->ptr =3D mmap(NULL, size,
> +=09=09=09   PROT_READ | PROT_WRITE,
> +=09=09=09   MAP_PRIVATE | MAP_ANONYMOUS,
> +=09=09=09   buffer->fd, 0);
> +=09ASSERT_NE(buffer->ptr, MAP_FAILED);
> +
> +=09/*
> +=09 * Initialize buffer in system memory but leave the first two pages
> +=09 * zero (pte_none and pfn_zero).
> +=09 */
> +=09i =3D 2 * self->page_size / sizeof(*ptr);
> +=09for (ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
> +=09=09ptr[i] =3D i;
> +
> +=09/* Set buffer permission to read-only. */
> +=09ret =3D mprotect(buffer->ptr, size, PROT_READ);
> +=09ASSERT_EQ(ret, 0);
> +
> +=09/* Populate the CPU page table with a special zero page. */
> +=09val =3D *(int *)(buffer->ptr + self->page_size);
> +=09ASSERT_EQ(val, 0);
> +
> +=09/* Simulate a device reading system memory. */
> +=09ret =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_READ, buffer, npages);
> +=09ASSERT_EQ(ret, 0);
> +=09ASSERT_EQ(buffer->cpages, npages);
> +=09ASSERT_EQ(buffer->faults, 1);
> +
> +=09/* Check what the device read. */
> +=09ptr =3D buffer->mirror;
> +=09for (i =3D 0; i < 2 * self->page_size / sizeof(*ptr); ++i)
> +=09=09ASSERT_EQ(ptr[i], 0);
> +=09for (; i < size / sizeof(*ptr); ++i)
> +=09=09ASSERT_EQ(ptr[i], i);
> +
> +=09hmm_buffer_free(buffer);
> +}
> +
> +/*
> + * Read private anonymous memory which has been protected with
> + * mprotect() PROT_NONE.
> + */
> +TEST_F(hmm, anon_read_prot)
> +{
> +=09struct hmm_buffer *buffer;
> +=09unsigned long npages;
> +=09unsigned long size;
> +=09unsigned long i;
> +=09int *ptr;
> +=09int ret;
> +
> +=09npages =3D ALIGN(HMM_BUFFER_SIZE, self->page_size) >> self->page_shif=
t;
> +=09ASSERT_NE(npages, 0);
> +=09size =3D npages << self->page_shift;
> +
> +=09buffer =3D malloc(sizeof(*buffer));
> +=09ASSERT_NE(buffer, NULL);
> +
> +=09buffer->fd =3D -1;
> +=09buffer->size =3D size;
> +=09buffer->mirror =3D malloc(size);
> +=09ASSERT_NE(buffer->mirror, NULL);
> +
> +=09buffer->ptr =3D mmap(NULL, size,
> +=09=09=09   PROT_READ | PROT_WRITE,
> +=09=09=09   MAP_PRIVATE | MAP_ANONYMOUS,
> +=09=09=09   buffer->fd, 0);
> +=09ASSERT_NE(buffer->ptr, MAP_FAILED);
> +
> +=09/* Initialize buffer in system memory. */
> +=09for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
> +=09=09ptr[i] =3D i;
> +
> +=09/* Initialize mirror buffer so we can verify it isn't written. */
> +=09for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
> +=09=09ptr[i] =3D -i;
> +
> +=09/* Protect buffer from reading. */
> +=09ret =3D mprotect(buffer->ptr, size, PROT_NONE);
> +=09ASSERT_EQ(ret, 0);
> +
> +=09/* Simulate a device reading system memory. */
> +=09ret =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_READ, buffer, npages);
> +=09ASSERT_EQ(ret, -EFAULT);
> +
> +=09/* Allow CPU to read the buffer so we can check it. */
> +=09ret =3D mprotect(buffer->ptr, size, PROT_READ);
> +=09ASSERT_EQ(ret, 0);
> +=09for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
> +=09=09ASSERT_EQ(ptr[i], i);
> +
> +=09/* Check what the device read. */
> +=09for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
> +=09=09ASSERT_EQ(ptr[i], -i);
> +
> +=09hmm_buffer_free(buffer);
> +}
> +
> +/*
> + * Write private anonymous memory.
> + */
> +TEST_F(hmm, anon_write)
> +{
> +=09struct hmm_buffer *buffer;
> +=09unsigned long npages;
> +=09unsigned long size;
> +=09unsigned long i;
> +=09int *ptr;
> +=09int ret;
> +
> +=09npages =3D ALIGN(HMM_BUFFER_SIZE, self->page_size) >> self->page_shif=
t;
> +=09ASSERT_NE(npages, 0);
> +=09size =3D npages << self->page_shift;
> +
> +=09buffer =3D malloc(sizeof(*buffer));
> +=09ASSERT_NE(buffer, NULL);
> +
> +=09buffer->fd =3D -1;
> +=09buffer->size =3D size;
> +=09buffer->mirror =3D malloc(size);
> +=09ASSERT_NE(buffer->mirror, NULL);
> +
> +=09buffer->ptr =3D mmap(NULL, size,
> +=09=09=09   PROT_READ | PROT_WRITE,
> +=09=09=09   MAP_PRIVATE | MAP_ANONYMOUS,
> +=09=09=09   buffer->fd, 0);
> +=09ASSERT_NE(buffer->ptr, MAP_FAILED);
> +
> +=09/* Initialize data that the device will write to buffer->ptr. */
> +=09for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
> +=09=09ptr[i] =3D i;
> +
> +=09/* Simulate a device writing system memory. */
> +=09ret =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_WRITE, buffer, npages);
> +=09ASSERT_EQ(ret, 0);
> +=09ASSERT_EQ(buffer->cpages, npages);
> +=09ASSERT_EQ(buffer->faults, 1);
> +
> +=09/* Check what the device wrote. */
> +=09for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
> +=09=09ASSERT_EQ(ptr[i], i);
> +
> +=09hmm_buffer_free(buffer);
> +}
> +
> +/*
> + * Write private anonymous memory which has been protected with
> + * mprotect() PROT_READ.
> + */
> +TEST_F(hmm, anon_write_prot)
> +{
> +=09struct hmm_buffer *buffer;
> +=09unsigned long npages;
> +=09unsigned long size;
> +=09unsigned long i;
> +=09int *ptr;
> +=09int ret;
> +
> +=09npages =3D ALIGN(HMM_BUFFER_SIZE, self->page_size) >> self->page_shif=
t;
> +=09ASSERT_NE(npages, 0);
> +=09size =3D npages << self->page_shift;
> +
> +=09buffer =3D malloc(sizeof(*buffer));
> +=09ASSERT_NE(buffer, NULL);
> +
> +=09buffer->fd =3D -1;
> +=09buffer->size =3D size;
> +=09buffer->mirror =3D malloc(size);
> +=09ASSERT_NE(buffer->mirror, NULL);
> +
> +=09buffer->ptr =3D mmap(NULL, size,
> +=09=09=09   PROT_READ,
> +=09=09=09   MAP_PRIVATE | MAP_ANONYMOUS,
> +=09=09=09   buffer->fd, 0);
> +=09ASSERT_NE(buffer->ptr, MAP_FAILED);
> +
> +=09/* Simulate a device reading a zero page of memory. */
> +=09ret =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_READ, buffer, 1);
> +=09ASSERT_EQ(ret, 0);
> +=09ASSERT_EQ(buffer->cpages, 1);
> +=09ASSERT_EQ(buffer->faults, 1);
> +
> +=09/* Initialize data that the device will write to buffer->ptr. */
> +=09for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
> +=09=09ptr[i] =3D i;
> +
> +=09/* Simulate a device writing system memory. */
> +=09ret =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_WRITE, buffer, npages);
> +=09ASSERT_EQ(ret, -EPERM);
> +
> +=09/* Check what the device wrote. */
> +=09for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
> +=09=09ASSERT_EQ(ptr[i], 0);
> +
> +=09/* Now allow writing and see that the zero page is replaced. */
> +=09ret =3D mprotect(buffer->ptr, size, PROT_WRITE | PROT_READ);
> +=09ASSERT_EQ(ret, 0);
> +
> +=09/* Simulate a device writing system memory. */
> +=09ret =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_WRITE, buffer, npages);
> +=09ASSERT_EQ(ret, 0);
> +=09ASSERT_EQ(buffer->cpages, npages);
> +=09ASSERT_EQ(buffer->faults, 1);
> +
> +=09/* Check what the device wrote. */
> +=09for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
> +=09=09ASSERT_EQ(ptr[i], i);
> +
> +=09hmm_buffer_free(buffer);
> +}
> +
> +/*
> + * Check that a device writing an anonymous private mapping
> + * will copy-on-write if a child process inherits the mapping.
> + */
> +TEST_F(hmm, anon_write_child)
> +{
> +=09struct hmm_buffer *buffer;
> +=09unsigned long npages;
> +=09unsigned long size;
> +=09unsigned long i;
> +=09int *ptr;
> +=09pid_t pid;
> +=09int child_fd;
> +=09int ret;
> +
> +=09npages =3D ALIGN(HMM_BUFFER_SIZE, self->page_size) >> self->page_shif=
t;
> +=09ASSERT_NE(npages, 0);
> +=09size =3D npages << self->page_shift;
> +
> +=09buffer =3D malloc(sizeof(*buffer));
> +=09ASSERT_NE(buffer, NULL);
> +
> +=09buffer->fd =3D -1;
> +=09buffer->size =3D size;
> +=09buffer->mirror =3D malloc(size);
> +=09ASSERT_NE(buffer->mirror, NULL);
> +
> +=09buffer->ptr =3D mmap(NULL, size,
> +=09=09=09   PROT_READ | PROT_WRITE,
> +=09=09=09   MAP_PRIVATE | MAP_ANONYMOUS,
> +=09=09=09   buffer->fd, 0);
> +=09ASSERT_NE(buffer->ptr, MAP_FAILED);
> +
> +=09/* Initialize buffer->ptr so we can tell if it is written. */
> +=09for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
> +=09=09ptr[i] =3D i;
> +
> +=09/* Initialize data that the device will write to buffer->ptr. */
> +=09for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
> +=09=09ptr[i] =3D -i;
> +
> +=09pid =3D fork();
> +=09if (pid =3D=3D -1)
> +=09=09ASSERT_EQ(pid, 0);
> +=09if (pid !=3D 0) {
> +=09=09waitpid(pid, &ret, 0);
> +=09=09ASSERT_EQ(WIFEXITED(ret), 1);
> +
> +=09=09/* Check that the parent's buffer did not change. */
> +=09=09for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
> +=09=09=09ASSERT_EQ(ptr[i], i);
> +=09=09return;
> +=09}
> +
> +=09/* Check that we see the parent's values. */
> +=09for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
> +=09=09ASSERT_EQ(ptr[i], i);
> +=09for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
> +=09=09ASSERT_EQ(ptr[i], -i);
> +
> +=09/* The child process needs its own mirror to its own mm. */
> +=09child_fd =3D hmm_open(0);
> +=09ASSERT_GE(child_fd, 0);
> +
> +=09/* Simulate a device writing system memory. */
> +=09ret =3D hmm_dmirror_cmd(child_fd, HMM_DMIRROR_WRITE, buffer, npages);
> +=09ASSERT_EQ(ret, 0);
> +=09ASSERT_EQ(buffer->cpages, npages);
> +=09ASSERT_EQ(buffer->faults, 1);
> +
> +=09/* Check what the device wrote. */
> +=09for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
> +=09=09ASSERT_EQ(ptr[i], -i);
> +
> +=09close(child_fd);
> +=09exit(0);
> +}
> +
> +/*
> + * Check that a device writing an anonymous shared mapping
> + * will not copy-on-write if a child process inherits the mapping.
> + */
> +TEST_F(hmm, anon_write_child_shared)
> +{
> +=09struct hmm_buffer *buffer;
> +=09unsigned long npages;
> +=09unsigned long size;
> +=09unsigned long i;
> +=09int *ptr;
> +=09pid_t pid;
> +=09int child_fd;
> +=09int ret;
> +
> +=09npages =3D ALIGN(HMM_BUFFER_SIZE, self->page_size) >> self->page_shif=
t;
> +=09ASSERT_NE(npages, 0);
> +=09size =3D npages << self->page_shift;
> +
> +=09buffer =3D malloc(sizeof(*buffer));
> +=09ASSERT_NE(buffer, NULL);
> +
> +=09buffer->fd =3D -1;
> +=09buffer->size =3D size;
> +=09buffer->mirror =3D malloc(size);
> +=09ASSERT_NE(buffer->mirror, NULL);
> +
> +=09buffer->ptr =3D mmap(NULL, size,
> +=09=09=09   PROT_READ | PROT_WRITE,
> +=09=09=09   MAP_SHARED | MAP_ANONYMOUS,
> +=09=09=09   buffer->fd, 0);
> +=09ASSERT_NE(buffer->ptr, MAP_FAILED);
> +
> +=09/* Initialize buffer->ptr so we can tell if it is written. */
> +=09for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
> +=09=09ptr[i] =3D i;
> +
> +=09/* Initialize data that the device will write to buffer->ptr. */
> +=09for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
> +=09=09ptr[i] =3D -i;
> +
> +=09pid =3D fork();
> +=09if (pid =3D=3D -1)
> +=09=09ASSERT_EQ(pid, 0);
> +=09if (pid !=3D 0) {
> +=09=09waitpid(pid, &ret, 0);
> +=09=09ASSERT_EQ(WIFEXITED(ret), 1);
> +
> +=09=09/* Check that the parent's buffer did change. */
> +=09=09for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
> +=09=09=09ASSERT_EQ(ptr[i], -i);
> +=09=09return;
> +=09}
> +
> +=09/* Check that we see the parent's values. */
> +=09for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
> +=09=09ASSERT_EQ(ptr[i], i);
> +=09for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
> +=09=09ASSERT_EQ(ptr[i], -i);
> +
> +=09/* The child process needs its own mirror to its own mm. */
> +=09child_fd =3D hmm_open(0);
> +=09ASSERT_GE(child_fd, 0);
> +
> +=09/* Simulate a device writing system memory. */
> +=09ret =3D hmm_dmirror_cmd(child_fd, HMM_DMIRROR_WRITE, buffer, npages);
> +=09ASSERT_EQ(ret, 0);
> +=09ASSERT_EQ(buffer->cpages, npages);
> +=09ASSERT_EQ(buffer->faults, 1);
> +
> +=09/* Check what the device wrote. */
> +=09for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
> +=09=09ASSERT_EQ(ptr[i], -i);
> +
> +=09close(child_fd);
> +=09exit(0);
> +}
> +
> +/*
> + * Write private anonymous huge page.
> + */
> +TEST_F(hmm, anon_write_huge)
> +{
> +=09struct hmm_buffer *buffer;
> +=09unsigned long npages;
> +=09unsigned long size;
> +=09unsigned long i;
> +=09void *old_ptr;
> +=09void *map;
> +=09int *ptr;
> +=09int ret;
> +
> +=09size =3D 2 * TWOMEG;
> +
> +=09buffer =3D malloc(sizeof(*buffer));
> +=09ASSERT_NE(buffer, NULL);
> +
> +=09buffer->fd =3D -1;
> +=09buffer->size =3D size;
> +=09buffer->mirror =3D malloc(size);
> +=09ASSERT_NE(buffer->mirror, NULL);
> +
> +=09buffer->ptr =3D mmap(NULL, size,
> +=09=09=09   PROT_READ | PROT_WRITE,
> +=09=09=09   MAP_PRIVATE | MAP_ANONYMOUS,
> +=09=09=09   buffer->fd, 0);
> +=09ASSERT_NE(buffer->ptr, MAP_FAILED);
> +
> +=09size =3D TWOMEG;
> +=09npages =3D size >> self->page_shift;
> +=09map =3D (void *)ALIGN((uintptr_t)buffer->ptr, size);
> +=09ret =3D madvise(map, size, MADV_HUGEPAGE);
> +=09ASSERT_EQ(ret, 0);
> +=09old_ptr =3D buffer->ptr;
> +=09buffer->ptr =3D map;
> +
> +=09/* Initialize data that the device will write to buffer->ptr. */
> +=09for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
> +=09=09ptr[i] =3D i;
> +
> +=09/* Simulate a device writing system memory. */
> +=09ret =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_WRITE, buffer, npages);
> +=09ASSERT_EQ(ret, 0);
> +=09ASSERT_EQ(buffer->cpages, npages);
> +=09ASSERT_EQ(buffer->faults, 1);
> +
> +=09/* Check what the device wrote. */
> +=09for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
> +=09=09ASSERT_EQ(ptr[i], i);
> +
> +=09buffer->ptr =3D old_ptr;
> +=09hmm_buffer_free(buffer);
> +}
> +
> +/*
> + * Write huge TLBFS page.
> + */
> +TEST_F(hmm, anon_write_hugetlbfs)
> +{
> +=09struct hmm_buffer *buffer;
> +=09unsigned long npages;
> +=09unsigned long size;
> +=09unsigned long i;
> +=09int *ptr;
> +=09int ret;
> +=09long pagesizes[4];
> +=09int n, idx;
> +
> +=09/* Skip test if we can't allocate a hugetlbfs page. */
> +
> +=09n =3D gethugepagesizes(pagesizes, 4);
> +=09if (n <=3D 0)
> +=09=09return;
> +=09for (idx =3D 0; --n > 0; ) {
> +=09=09if (pagesizes[n] < pagesizes[idx])
> +=09=09=09idx =3D n;
> +=09}
> +=09size =3D ALIGN(TWOMEG, pagesizes[idx]);
> +=09npages =3D size >> self->page_shift;
> +
> +=09buffer =3D malloc(sizeof(*buffer));
> +=09ASSERT_NE(buffer, NULL);
> +
> +=09buffer->ptr =3D get_hugepage_region(size, GHR_STRICT);
> +=09if (buffer->ptr =3D=3D NULL) {
> +=09=09free(buffer);
> +=09=09return;
> +=09}
> +
> +=09buffer->fd =3D -1;
> +=09buffer->size =3D size;
> +=09buffer->mirror =3D malloc(size);
> +=09ASSERT_NE(buffer->mirror, NULL);
> +
> +=09/* Initialize data that the device will write to buffer->ptr. */
> +=09for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
> +=09=09ptr[i] =3D i;
> +
> +=09/* Simulate a device writing system memory. */
> +=09ret =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_WRITE, buffer, npages);
> +=09ASSERT_EQ(ret, 0);
> +=09ASSERT_EQ(buffer->cpages, npages);
> +=09ASSERT_EQ(buffer->faults, 1);
> +
> +=09/* Check what the device wrote. */
> +=09for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
> +=09=09ASSERT_EQ(ptr[i], i);
> +
> +=09free_hugepage_region(buffer->ptr);
> +=09buffer->ptr =3D NULL;
> +=09hmm_buffer_free(buffer);
> +}
> +
> +/*
> + * Read mmap'ed file memory.
> + */
> +TEST_F(hmm, file_read)
> +{
> +=09struct hmm_buffer *buffer;
> +=09unsigned long npages;
> +=09unsigned long size;
> +=09unsigned long i;
> +=09int *ptr;
> +=09int ret;
> +=09int fd;
> +=09off_t off;
> +=09ssize_t len;
> +
> +=09npages =3D ALIGN(HMM_BUFFER_SIZE, self->page_size) >> self->page_shif=
t;
> +=09ASSERT_NE(npages, 0);
> +=09size =3D npages << self->page_shift;
> +
> +=09fd =3D hmm_create_file(size);
> +=09ASSERT_GE(fd, 0);
> +
> +=09buffer =3D malloc(sizeof(*buffer));
> +=09ASSERT_NE(buffer, NULL);
> +
> +=09buffer->fd =3D fd;
> +=09buffer->size =3D size;
> +=09buffer->mirror =3D malloc(size);
> +=09ASSERT_NE(buffer->mirror, NULL);
> +
> +=09/* Write initial contents of the file. */
> +=09for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
> +=09=09ptr[i] =3D i;
> +=09off =3D lseek(fd, 0, SEEK_SET);
> +=09ASSERT_EQ(off, 0);
> +=09len =3D write(fd, buffer->mirror, size);
> +=09ASSERT_EQ(len, size);
> +=09memset(buffer->mirror, 0, size);
> +
> +=09buffer->ptr =3D mmap(NULL, size,
> +=09=09=09   PROT_READ,
> +=09=09=09   MAP_SHARED,
> +=09=09=09   buffer->fd, 0);
> +=09ASSERT_NE(buffer->ptr, MAP_FAILED);
> +
> +=09/* Simulate a device reading system memory. */
> +=09ret =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_READ, buffer, npages);
> +=09ASSERT_EQ(ret, 0);
> +=09ASSERT_EQ(buffer->cpages, npages);
> +=09ASSERT_EQ(buffer->faults, 1);
> +
> +=09/* Check what the device read. */
> +=09for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
> +=09=09ASSERT_EQ(ptr[i], i);
> +
> +=09hmm_buffer_free(buffer);
> +}
> +
> +/*
> + * Write mmap'ed file memory.
> + */
> +TEST_F(hmm, file_write)
> +{
> +=09struct hmm_buffer *buffer;
> +=09unsigned long npages;
> +=09unsigned long size;
> +=09unsigned long i;
> +=09int *ptr;
> +=09int ret;
> +=09int fd;
> +=09off_t off;
> +=09ssize_t len;
> +
> +=09npages =3D ALIGN(HMM_BUFFER_SIZE, self->page_size) >> self->page_shif=
t;
> +=09ASSERT_NE(npages, 0);
> +=09size =3D npages << self->page_shift;
> +
> +=09fd =3D hmm_create_file(size);
> +=09ASSERT_GE(fd, 0);
> +
> +=09buffer =3D malloc(sizeof(*buffer));
> +=09ASSERT_NE(buffer, NULL);
> +
> +=09buffer->fd =3D fd;
> +=09buffer->size =3D size;
> +=09buffer->mirror =3D malloc(size);
> +=09ASSERT_NE(buffer->mirror, NULL);
> +
> +=09buffer->ptr =3D mmap(NULL, size,
> +=09=09=09   PROT_READ | PROT_WRITE,
> +=09=09=09   MAP_SHARED,
> +=09=09=09   buffer->fd, 0);
> +=09ASSERT_NE(buffer->ptr, MAP_FAILED);
> +
> +=09/* Initialize data that the device will write to buffer->ptr. */
> +=09for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
> +=09=09ptr[i] =3D i;
> +
> +=09/* Simulate a device writing system memory. */
> +=09ret =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_WRITE, buffer, npages);
> +=09ASSERT_EQ(ret, 0);
> +=09ASSERT_EQ(buffer->cpages, npages);
> +=09ASSERT_EQ(buffer->faults, 1);
> +
> +=09/* Check what the device wrote. */
> +=09for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
> +=09=09ASSERT_EQ(ptr[i], i);
> +
> +=09/* Check that the device also wrote the file. */
> +=09off =3D lseek(fd, 0, SEEK_SET);
> +=09ASSERT_EQ(off, 0);
> +=09len =3D read(fd, buffer->mirror, size);
> +=09ASSERT_EQ(len, size);
> +=09for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
> +=09=09ASSERT_EQ(ptr[i], i);
> +
> +=09hmm_buffer_free(buffer);
> +}
> +
> +/*
> + * Migrate anonymous memory to device private memory.
> + */
> +TEST_F(hmm, migrate)
> +{
> +=09struct hmm_buffer *buffer;
> +=09unsigned long npages;
> +=09unsigned long size;
> +=09unsigned long i;
> +=09int *ptr;
> +=09int ret;
> +
> +=09npages =3D ALIGN(HMM_BUFFER_SIZE, self->page_size) >> self->page_shif=
t;
> +=09ASSERT_NE(npages, 0);
> +=09size =3D npages << self->page_shift;
> +
> +=09buffer =3D malloc(sizeof(*buffer));
> +=09ASSERT_NE(buffer, NULL);
> +
> +=09buffer->fd =3D -1;
> +=09buffer->size =3D size;
> +=09buffer->mirror =3D malloc(size);
> +=09ASSERT_NE(buffer->mirror, NULL);
> +
> +=09buffer->ptr =3D mmap(NULL, size,
> +=09=09=09   PROT_READ | PROT_WRITE,
> +=09=09=09   MAP_PRIVATE | MAP_ANONYMOUS,
> +=09=09=09   buffer->fd, 0);
> +=09ASSERT_NE(buffer->ptr, MAP_FAILED);
> +
> +=09/* Initialize buffer in system memory. */
> +=09for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
> +=09=09ptr[i] =3D i;
> +
> +=09/* Migrate memory to device. */
> +=09ret =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_MIGRATE, buffer, npages=
);
> +=09ASSERT_EQ(ret, 0);
> +=09ASSERT_EQ(buffer->cpages, npages);
> +
> +=09/* Check what the device read. */
> +=09for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
> +=09=09ASSERT_EQ(ptr[i], i);
> +
> +=09hmm_buffer_free(buffer);
> +}
> +
> +/*
> + * Migrate anonymous memory to device private memory and fault it back t=
o system
> + * memory.
> + */
> +TEST_F(hmm, migrate_fault)
> +{
> +=09struct hmm_buffer *buffer;
> +=09unsigned long npages;
> +=09unsigned long size;
> +=09unsigned long i;
> +=09int *ptr;
> +=09int ret;
> +
> +=09npages =3D ALIGN(HMM_BUFFER_SIZE, self->page_size) >> self->page_shif=
t;
> +=09ASSERT_NE(npages, 0);
> +=09size =3D npages << self->page_shift;
> +
> +=09buffer =3D malloc(sizeof(*buffer));
> +=09ASSERT_NE(buffer, NULL);
> +
> +=09buffer->fd =3D -1;
> +=09buffer->size =3D size;
> +=09buffer->mirror =3D malloc(size);
> +=09ASSERT_NE(buffer->mirror, NULL);
> +
> +=09buffer->ptr =3D mmap(NULL, size,
> +=09=09=09   PROT_READ | PROT_WRITE,
> +=09=09=09   MAP_PRIVATE | MAP_ANONYMOUS,
> +=09=09=09   buffer->fd, 0);
> +=09ASSERT_NE(buffer->ptr, MAP_FAILED);
> +
> +=09/* Initialize buffer in system memory. */
> +=09for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
> +=09=09ptr[i] =3D i;
> +
> +=09/* Migrate memory to device. */
> +=09ret =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_MIGRATE, buffer, npages=
);
> +=09ASSERT_EQ(ret, 0);
> +=09ASSERT_EQ(buffer->cpages, npages);
> +
> +=09/* Check what the device read. */
> +=09for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
> +=09=09ASSERT_EQ(ptr[i], i);
> +
> +=09/* Fault pages back to system memory and check them. */
> +=09for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
> +=09=09ASSERT_EQ(ptr[i], i);
> +
> +=09hmm_buffer_free(buffer);
> +}
> +
> +/*
> + * Try to migrate various memory types to device private memory.
> + */
> +TEST_F(hmm2, migrate_mixed)
> +{
> +=09struct hmm_buffer *buffer;
> +=09unsigned long npages;
> +=09unsigned long size;
> +=09int *ptr;
> +=09unsigned char *p;
> +=09int ret;
> +=09int val;
> +
> +=09npages =3D 6;
> +=09size =3D npages << self->page_shift;
> +
> +=09buffer =3D malloc(sizeof(*buffer));
> +=09ASSERT_NE(buffer, NULL);
> +
> +=09buffer->fd =3D -1;
> +=09buffer->size =3D size;
> +=09buffer->mirror =3D malloc(size);
> +=09ASSERT_NE(buffer->mirror, NULL);
> +
> +=09/* Reserve a range of addresses. */
> +=09buffer->ptr =3D mmap(NULL, size,
> +=09=09=09   PROT_NONE,
> +=09=09=09   MAP_PRIVATE | MAP_ANONYMOUS,
> +=09=09=09   buffer->fd, 0);
> +=09ASSERT_NE(buffer->ptr, MAP_FAILED);
> +=09p =3D buffer->ptr;
> +
> +=09/* Now try to migrate everything to device 1. */
> +=09ret =3D hmm_dmirror_cmd(self->fd1, HMM_DMIRROR_MIGRATE, buffer, npage=
s);
> +=09ASSERT_EQ(ret, 0);
> +=09ASSERT_EQ(buffer->cpages, 6);
> +
> +=09/* Punch a hole after the first page address. */
> +=09ret =3D munmap(buffer->ptr + self->page_size, self->page_size);
> +=09ASSERT_EQ(ret, 0);
> +
> +=09/* We expect an error if the vma doesn't cover the range. */
> +=09ret =3D hmm_dmirror_cmd(self->fd1, HMM_DMIRROR_MIGRATE, buffer, 3);
> +=09ASSERT_EQ(ret, -EINVAL);
> +
> +=09/* Page 2 will be a read-only zero page. */
> +=09ret =3D mprotect(buffer->ptr + 2 * self->page_size, self->page_size,
> +=09=09=09=09PROT_READ);
> +=09ASSERT_EQ(ret, 0);
> +=09ptr =3D (int *)(buffer->ptr + 2 * self->page_size);
> +=09val =3D *ptr + 3;
> +=09ASSERT_EQ(val, 3);
> +
> +=09/* Page 3 will be read-only. */
> +=09ret =3D mprotect(buffer->ptr + 3 * self->page_size, self->page_size,
> +=09=09=09=09PROT_READ | PROT_WRITE);
> +=09ASSERT_EQ(ret, 0);
> +=09ptr =3D (int *)(buffer->ptr + 3 * self->page_size);
> +=09*ptr =3D val;
> +=09ret =3D mprotect(buffer->ptr + 3 * self->page_size, self->page_size,
> +=09=09=09=09PROT_READ);
> +=09ASSERT_EQ(ret, 0);
> +
> +=09/* Page 4 will be read-write. */
> +=09ret =3D mprotect(buffer->ptr + 4 * self->page_size, self->page_size,
> +=09=09=09=09PROT_READ | PROT_WRITE);
> +=09ASSERT_EQ(ret, 0);
> +=09ptr =3D (int *)(buffer->ptr + 4 * self->page_size);
> +=09*ptr =3D val;
> +
> +=09/* Page 5 won't be migrated to device 0 because it's on device 1. */
> +=09buffer->ptr =3D p + 5 * self->page_size;
> +=09ret =3D hmm_dmirror_cmd(self->fd0, HMM_DMIRROR_MIGRATE, buffer, 1);
> +=09ASSERT_EQ(ret, -ENOENT);
> +=09buffer->ptr =3D p;
> +
> +=09/* Now try to migrate pages 2-3 to device 1. */
> +=09buffer->ptr =3D p + 2 * self->page_size;
> +=09ret =3D hmm_dmirror_cmd(self->fd1, HMM_DMIRROR_MIGRATE, buffer, 2);
> +=09ASSERT_EQ(ret, 0);
> +=09ASSERT_EQ(buffer->cpages, 2);
> +=09buffer->ptr =3D p;
> +
> +=09hmm_buffer_free(buffer);
> +}
> +
> +/*
> + * Migrate anonymous memory to device private memory and fault it back t=
o system
> + * memory multiple times.
> + */
> +TEST_F(hmm, migrate_multiple)
> +{
> +=09struct hmm_buffer *buffer;
> +=09unsigned long npages;
> +=09unsigned long size;
> +=09unsigned long i;
> +=09unsigned long c;
> +=09int *ptr;
> +=09int ret;
> +
> +=09npages =3D ALIGN(HMM_BUFFER_SIZE, self->page_size) >> self->page_shif=
t;
> +=09ASSERT_NE(npages, 0);
> +=09size =3D npages << self->page_shift;
> +
> +=09for (c =3D 0; c < NTIMES; c++) {
> +=09=09buffer =3D malloc(sizeof(*buffer));
> +=09=09ASSERT_NE(buffer, NULL);
> +
> +=09=09buffer->fd =3D -1;
> +=09=09buffer->size =3D size;
> +=09=09buffer->mirror =3D malloc(size);
> +=09=09ASSERT_NE(buffer->mirror, NULL);
> +
> +=09=09buffer->ptr =3D mmap(NULL, size,
> +=09=09=09=09   PROT_READ | PROT_WRITE,
> +=09=09=09=09   MAP_PRIVATE | MAP_ANONYMOUS,
> +=09=09=09=09   buffer->fd, 0);
> +=09=09ASSERT_NE(buffer->ptr, MAP_FAILED);
> +
> +=09=09/* Initialize buffer in system memory. */
> +=09=09for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
> +=09=09=09ptr[i] =3D i;
> +
> +=09=09/* Migrate memory to device. */
> +=09=09ret =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_MIGRATE, buffer,
> +=09=09=09=09      npages);
> +=09=09ASSERT_EQ(ret, 0);
> +=09=09ASSERT_EQ(buffer->cpages, npages);
> +
> +=09=09/* Check what the device read. */
> +=09=09for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i=
)
> +=09=09=09ASSERT_EQ(ptr[i], i);
> +
> +=09=09/* Fault pages back to system memory and check them. */
> +=09=09for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
> +=09=09=09ASSERT_EQ(ptr[i], i);
> +
> +=09=09hmm_buffer_free(buffer);
> +=09}
> +}
> +
> +/*
> + * Read anonymous memory multiple times.
> + */
> +TEST_F(hmm, anon_read_multiple)
> +{
> +=09struct hmm_buffer *buffer;
> +=09unsigned long npages;
> +=09unsigned long size;
> +=09unsigned long i;
> +=09unsigned long c;
> +=09int *ptr;
> +=09int ret;
> +
> +=09npages =3D ALIGN(HMM_BUFFER_SIZE, self->page_size) >> self->page_shif=
t;
> +=09ASSERT_NE(npages, 0);
> +=09size =3D npages << self->page_shift;
> +
> +=09for (c =3D 0; c < NTIMES; c++) {
> +=09=09buffer =3D malloc(sizeof(*buffer));
> +=09=09ASSERT_NE(buffer, NULL);
> +
> +=09=09buffer->fd =3D -1;
> +=09=09buffer->size =3D size;
> +=09=09buffer->mirror =3D malloc(size);
> +=09=09ASSERT_NE(buffer->mirror, NULL);
> +
> +=09=09buffer->ptr =3D mmap(NULL, size,
> +=09=09=09=09   PROT_READ | PROT_WRITE,
> +=09=09=09=09   MAP_PRIVATE | MAP_ANONYMOUS,
> +=09=09=09=09   buffer->fd, 0);
> +=09=09ASSERT_NE(buffer->ptr, MAP_FAILED);
> +
> +=09=09/* Initialize buffer in system memory. */
> +=09=09for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
> +=09=09=09ptr[i] =3D i + c;
> +
> +=09=09/* Simulate a device reading system memory. */
> +=09=09ret =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_READ, buffer,
> +=09=09=09=09      npages);
> +=09=09ASSERT_EQ(ret, 0);
> +=09=09ASSERT_EQ(buffer->cpages, npages);
> +=09=09ASSERT_EQ(buffer->faults, 1);
> +
> +=09=09/* Check what the device read. */
> +=09=09for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i=
)
> +=09=09=09ASSERT_EQ(ptr[i], i + c);
> +
> +=09=09hmm_buffer_free(buffer);
> +=09}
> +}
> +
> +void *unmap_buffer(void *p)
> +{
> +=09struct hmm_buffer *buffer =3D p;
> +
> +=09/* Delay for a bit and then unmap buffer while it is being read. */
> +=09hmm_nanosleep(hmm_random() % 32000);
> +=09munmap(buffer->ptr + buffer->size / 2, buffer->size / 2);
> +=09buffer->ptr =3D NULL;
> +
> +=09return NULL;
> +}
> +
> +/*
> + * Try reading anonymous memory while it is being unmapped.
> + */
> +TEST_F(hmm, anon_teardown)
> +{
> +=09unsigned long npages;
> +=09unsigned long size;
> +=09unsigned long c;
> +=09void *ret;
> +
> +=09npages =3D ALIGN(HMM_BUFFER_SIZE, self->page_size) >> self->page_shif=
t;
> +=09ASSERT_NE(npages, 0);
> +=09size =3D npages << self->page_shift;
> +
> +=09for (c =3D 0; c < NTIMES; ++c) {
> +=09=09pthread_t thread;
> +=09=09struct hmm_buffer *buffer;
> +=09=09unsigned long i;
> +=09=09int *ptr;
> +=09=09int rc;
> +
> +=09=09buffer =3D malloc(sizeof(*buffer));
> +=09=09ASSERT_NE(buffer, NULL);
> +
> +=09=09buffer->fd =3D -1;
> +=09=09buffer->size =3D size;
> +=09=09buffer->mirror =3D malloc(size);
> +=09=09ASSERT_NE(buffer->mirror, NULL);
> +
> +=09=09buffer->ptr =3D mmap(NULL, size,
> +=09=09=09=09   PROT_READ | PROT_WRITE,
> +=09=09=09=09   MAP_PRIVATE | MAP_ANONYMOUS,
> +=09=09=09=09   buffer->fd, 0);
> +=09=09ASSERT_NE(buffer->ptr, MAP_FAILED);
> +
> +=09=09/* Initialize buffer in system memory. */
> +=09=09for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
> +=09=09=09ptr[i] =3D i + c;
> +
> +=09=09rc =3D pthread_create(&thread, NULL, unmap_buffer, buffer);
> +=09=09ASSERT_EQ(rc, 0);
> +
> +=09=09/* Simulate a device reading system memory. */
> +=09=09rc =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_READ, buffer,
> +=09=09=09=09     npages);
> +=09=09if (rc =3D=3D 0) {
> +=09=09=09ASSERT_EQ(buffer->cpages, npages);
> +=09=09=09ASSERT_EQ(buffer->faults, 1);
> +
> +=09=09=09/* Check what the device read. */
> +=09=09=09for (i =3D 0, ptr =3D buffer->mirror;
> +=09=09=09     i < size / sizeof(*ptr);
> +=09=09=09     ++i)
> +=09=09=09=09ASSERT_EQ(ptr[i], i + c);
> +=09=09}
> +
> +=09=09pthread_join(thread, &ret);
> +=09=09hmm_buffer_free(buffer);
> +=09}
> +}
> +
> +/*
> + * Test memory snapshot without faulting in pages accessed by the device=
.
> + */
> +TEST_F(hmm2, snapshot)
> +{
> +=09struct hmm_buffer *buffer;
> +=09unsigned long npages;
> +=09unsigned long size;
> +=09int *ptr;
> +=09unsigned char *p;
> +=09unsigned char *m;
> +=09int ret;
> +=09int val;
> +
> +=09npages =3D 7;
> +=09size =3D npages << self->page_shift;
> +
> +=09buffer =3D malloc(sizeof(*buffer));
> +=09ASSERT_NE(buffer, NULL);
> +
> +=09buffer->fd =3D -1;
> +=09buffer->size =3D size;
> +=09buffer->mirror =3D malloc(npages);
> +=09ASSERT_NE(buffer->mirror, NULL);
> +
> +=09/* Reserve a range of addresses. */
> +=09buffer->ptr =3D mmap(NULL, size,
> +=09=09=09   PROT_NONE,
> +=09=09=09   MAP_PRIVATE | MAP_ANONYMOUS,
> +=09=09=09   buffer->fd, 0);
> +=09ASSERT_NE(buffer->ptr, MAP_FAILED);
> +=09p =3D buffer->ptr;
> +
> +=09/* Punch a hole after the first page address. */
> +=09ret =3D munmap(buffer->ptr + self->page_size, self->page_size);
> +=09ASSERT_EQ(ret, 0);
> +
> +=09/* Page 2 will be read-only zero page. */
> +=09ret =3D mprotect(buffer->ptr + 2 * self->page_size, self->page_size,
> +=09=09=09=09PROT_READ);
> +=09ASSERT_EQ(ret, 0);
> +=09ptr =3D (int *)(buffer->ptr + 2 * self->page_size);
> +=09val =3D *ptr + 3;
> +=09ASSERT_EQ(val, 3);
> +
> +=09/* Page 3 will be read-only. */
> +=09ret =3D mprotect(buffer->ptr + 3 * self->page_size, self->page_size,
> +=09=09=09=09PROT_READ | PROT_WRITE);
> +=09ASSERT_EQ(ret, 0);
> +=09ptr =3D (int *)(buffer->ptr + 3 * self->page_size);
> +=09*ptr =3D val;
> +=09ret =3D mprotect(buffer->ptr + 3 * self->page_size, self->page_size,
> +=09=09=09=09PROT_READ);
> +=09ASSERT_EQ(ret, 0);
> +
> +=09/* Page 4-6 will be read-write. */
> +=09ret =3D mprotect(buffer->ptr + 4 * self->page_size, 3 * self->page_si=
ze,
> +=09=09=09=09PROT_READ | PROT_WRITE);
> +=09ASSERT_EQ(ret, 0);
> +=09ptr =3D (int *)(buffer->ptr + 4 * self->page_size);
> +=09*ptr =3D val;
> +
> +=09/* Page 5 will be migrated to device 0. */
> +=09buffer->ptr =3D p + 5 * self->page_size;
> +=09ret =3D hmm_dmirror_cmd(self->fd0, HMM_DMIRROR_MIGRATE, buffer, 1);
> +=09ASSERT_EQ(ret, 0);
> +=09ASSERT_EQ(buffer->cpages, 1);
> +
> +=09/* Page 6 will be migrated to device 1. */
> +=09buffer->ptr =3D p + 6 * self->page_size;
> +=09ret =3D hmm_dmirror_cmd(self->fd1, HMM_DMIRROR_MIGRATE, buffer, 1);
> +=09ASSERT_EQ(ret, 0);
> +=09ASSERT_EQ(buffer->cpages, 1);
> +
> +=09/* Simulate a device snapshotting CPU pagetables. */
> +=09buffer->ptr =3D p;
> +=09ret =3D hmm_dmirror_cmd(self->fd0, HMM_DMIRROR_SNAPSHOT, buffer, npag=
es);
> +=09ASSERT_EQ(ret, 0);
> +=09ASSERT_EQ(buffer->cpages, npages);
> +
> +=09/* Check what the device saw. */
> +=09m =3D buffer->mirror;
> +=09ASSERT_EQ(m[0], HMM_DMIRROR_PROT_NONE);
> +=09ASSERT_EQ(m[1], HMM_DMIRROR_PROT_NONE);
> +=09ASSERT_EQ(m[2], HMM_DMIRROR_PROT_ZERO | HMM_DMIRROR_PROT_READ);
> +=09ASSERT_EQ(m[3], HMM_DMIRROR_PROT_READ);
> +=09ASSERT_EQ(m[4], HMM_DMIRROR_PROT_WRITE);
> +=09ASSERT_EQ(m[5], HMM_DMIRROR_PROT_DEV_PRIVATE_LOCAL |
> +=09=09=09HMM_DMIRROR_PROT_WRITE);
> +=09ASSERT_EQ(m[6], HMM_DMIRROR_PROT_DEV_PRIVATE_REMOTE |
> +=09=09=09HMM_DMIRROR_PROT_WRITE);
> +
> +=09hmm_buffer_free(buffer);
> +}
> +
> +TEST_HARNESS_MAIN
> diff --git a/tools/testing/selftests/vm/run_vmtests b/tools/testing/selft=
ests/vm/run_vmtests
> index 951c507a27f7..634cfefdaffd 100755
> --- a/tools/testing/selftests/vm/run_vmtests
> +++ b/tools/testing/selftests/vm/run_vmtests
> @@ -227,4 +227,20 @@ else
>  =09exitcode=3D1
>  fi
> =20
> +echo "------------------------------------"
> +echo "running HMM smoke test"
> +echo "------------------------------------"
> +./test_hmm.sh smoke
> +ret_val=3D$?
> +
> +if [ $ret_val -eq 0 ]; then
> +=09echo "[PASS]"
> +elif [ $ret_val -eq $ksft_skip ]; then
> +=09echo "[SKIP]"
> +=09exitcode=3D$ksft_skip
> +else
> +=09echo "[FAIL]"
> +=09exitcode=3D1
> +fi
> +
>  exit $exitcode
> diff --git a/tools/testing/selftests/vm/test_hmm.sh b/tools/testing/selft=
ests/vm/test_hmm.sh
> new file mode 100755
> index 000000000000..268d32752045
> --- /dev/null
> +++ b/tools/testing/selftests/vm/test_hmm.sh
> @@ -0,0 +1,97 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (C) 2018 Uladzislau Rezki (Sony) <urezki@gmail.com>
> +#
> +# This is a test script for the kernel test driver to analyse vmalloc
> +# allocator. Therefore it is just a kernel module loader. You can specif=
y
> +# and pass different parameters in order to:
> +#     a) analyse performance of vmalloc allocations;
> +#     b) stressing and stability check of vmalloc subsystem.
> +
> +TEST_NAME=3D"test_hmm"
> +DRIVER=3D"hmm_dmirror"
> +
> +# 1 if fails
> +exitcode=3D1
> +
> +# Kselftest framework requirement - SKIP code is 4.
> +ksft_skip=3D4
> +
> +check_test_requirements()
> +{
> +=09uid=3D$(id -u)
> +=09if [ $uid -ne 0 ]; then
> +=09=09echo "$0: Must be run as root"
> +=09=09exit $ksft_skip
> +=09fi
> +
> +=09if ! which modprobe > /dev/null 2>&1; then
> +=09=09echo "$0: You need modprobe installed"
> +=09=09exit $ksft_skip
> +=09fi
> +
> +=09if ! modinfo $DRIVER > /dev/null 2>&1; then
> +=09=09echo "$0: You must have the following enabled in your kernel:"
> +=09=09echo "CONFIG_HMM_DMIRROR=3Dm"
> +=09=09exit $ksft_skip
> +=09fi
> +}
> +
> +load_driver()
> +{
> +=09modprobe $DRIVER > /dev/null 2>&1
> +=09if [ $? =3D=3D 0 ]; then
> +=09=09major=3D$(awk "\$2=3D=3D\"HMM_DMIRROR\" {print \$1}" /proc/devices=
)
> +=09=09mknod /dev/hmm_dmirror0 c $major 0
> +=09=09mknod /dev/hmm_dmirror1 c $major 1
> +=09fi
> +}
> +
> +unload_driver()
> +{
> +=09modprobe -r $DRIVER > /dev/null 2>&1
> +=09rm -f /dev/hmm_dmirror?
> +}
> +
> +run_smoke()
> +{
> +=09echo "Running smoke test. Note, this test provides basic coverage."
> +
> +=09load_driver
> +=09./hmm-tests
> +=09unload_driver
> +}
> +
> +usage()
> +{
> +=09echo -n "Usage: $0"
> +=09echo
> +=09echo "Example usage:"
> +=09echo
> +=09echo "# Shows help message"
> +=09echo "./${TEST_NAME}.sh"
> +=09echo
> +=09echo "# Smoke testing"
> +=09echo "./${TEST_NAME}.sh smoke"
> +=09echo
> +=09exit 0
> +}
> +
> +function run_test()
> +{
> +=09if [ $# -eq 0 ]; then
> +=09=09usage
> +=09else
> +=09=09if [ "$1" =3D "smoke" ]; then
> +=09=09=09run_smoke
> +=09=09else
> +=09=09=09usage
> +=09=09fi
> +=09fi
> +}
> +
> +check_test_requirements
> +run_test $@
> +
> +exit 0
> --=20
> 2.20.1
>=20

