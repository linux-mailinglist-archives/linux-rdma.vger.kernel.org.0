Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAD5D8BF0
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Oct 2019 10:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732705AbfJPI6H (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Oct 2019 04:58:07 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42893 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730468AbfJPI6H (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Oct 2019 04:58:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id n14so27004941wrw.9
        for <linux-rdma@vger.kernel.org>; Wed, 16 Oct 2019 01:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=V+4SMbJY+xnY/02Qu1SPKip6GAEd3pyslcFpF7IxHBM=;
        b=vI5EgckJStxRO73bc+3CwPgKxclRbKnLXPsOtNhcrVURZW63+9T1e2AR+xD4ChmYjb
         F09Az3ubghdrV9WGNALSeqQTPTWu3DRy4fj4jt/7XpCfcYOXb97srJ+8PG01E8O4sYxe
         alaKfq+3azM37/Z9sab8NfOx5RuG3cz3D7bOj0LoGEmV03UEbCQ2M8o4eH+iNDAL65kT
         NUkh3nPZoaRQ4VtHUDdLuoZtEpF2ba26YAvw6u7cdrsWGafqXs3O/NxmX5gnSy0+Nkjz
         xUjXcoBkOZ9KEXo6In0z6fpRL/TMFSnEc3h3Phoj68Pum7UJui5fB1f08XIfVZboPN+1
         5OYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=V+4SMbJY+xnY/02Qu1SPKip6GAEd3pyslcFpF7IxHBM=;
        b=n6/ZXnnWsIcgUG6ZyT7qFZPfLLcTEq+JVhtLmoXBxKG6ufcVVUR+L5fDKUG6gis8zl
         aiiP+/ydld8F1F2+XaYNTKRpPkvZfgrs1HoeC84U418ykE5TOuBCWz56g/5yZMdoyuT1
         /GjDrq9qJkjqixIxTU4zoylhXnvIM6kyl2EWpXK07JhH605JZpLlCaDHPrib3LmUkgvS
         iTLcfaPZGCwYJBMmEH8bMbPotVmT2rWHZABGD0sOQy+4Q/pTB4uR2MHpoiSoKFBoB8Pu
         KYCVR0KFr4MEq8msg2w2auO1BhoIBT97uM41x6hylrqnsX4I/6dMLuR+/n0aZMTWNzOe
         LfOg==
X-Gm-Message-State: APjAAAUftIZoo6sJg0E5IrBb1HYHxe/FGWVg8xYH8onDCjKuQ0qyKRE/
        mC3YanRWQtGu/Fg7EIXpAx4=
X-Google-Smtp-Source: APXvYqywHpqS2WwakM+BUQmjn7/0SQxlW6RiaETqeNUjKm43xk/4p1AdnGlHpqoSz8YMsyfharKZLg==
X-Received: by 2002:adf:fa92:: with SMTP id h18mr1684319wrr.220.1571216284378;
        Wed, 16 Oct 2019 01:58:04 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id b5sm1610909wmj.18.2019.10.16.01.58.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 01:58:03 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH hmm 00/15] Consolidate the mmu notifier interval_tree and
 locking
To:     Jason Gunthorpe <jgg@ziepe.ca>, Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc:     Andrea Arcangeli <aarcange@redhat.com>, linux-rdma@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, linux-mm@kvack.org,
        Jason Gunthorpe <jgg@mellanox.com>,
        dri-devel@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>
References: <20191015181242.8343-1-jgg@ziepe.ca>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <bc954d29-388b-9e29-f960-115ccc6b9fea@gmail.com>
Date:   Wed, 16 Oct 2019 10:58:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191015181242.8343-1-jgg@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Am 15.10.19 um 20:12 schrieb Jason Gunthorpe:
> From: Jason Gunthorpe <jgg@mellanox.com>
>
> 8 of the mmu_notifier using drivers (i915_gem, radeon_mn, umem_odp, hfi1,
> scif_dma, vhost, gntdev, hmm) drivers are using a common pattern where
> they only use invalidate_range_start/end and immediately check the
> invalidating range against some driver data structure to tell if the
> driver is interested. Half of them use an interval_tree, the others are
> simple linear search lists.
>
> Of the ones I checked they largely seem to have various kinds of races,
> bugs and poor implementation. This is a result of the complexity in how
> the notifier interacts with get_user_pages(). It is extremely difficult to
> use it correctly.
>
> Consolidate all of this code together into the core mmu_notifier and
> provide a locking scheme similar to hmm_mirror that allows the user to
> safely use get_user_pages() and reliably know if the page list still
> matches the mm.

That sounds really good, but could you outline for a moment how that is 
archived?

Please keep in mind that the page reference get_user_pages() grabs is 
*NOT* sufficient to guarantee coherency here.

Regards,
Christian.

>
> This new arrangment plays nicely with the !blockable mode for
> OOM. Scanning the interval tree is done such that the intersection test
> will always succeed, and since there is no invalidate_range_end exposed to
> drivers the scheme safely allows multiple drivers to be subscribed.
>
> Four places are converted as an example of how the new API is used.
> Four are left for future patches:
>   - i915_gem has complex locking around destruction of a registration,
>     needs more study
>   - hfi1 (2nd user) needs access to the rbtree
>   - scif_dma has a complicated logic flow
>   - vhost's mmu notifiers are already being rewritten
>
> This is still being tested, but I figured to send it to start getting help
> from the xen, amd and hfi drivers which I cannot test here.
>
> It would be intended for the hmm tree.
>
> Jason Gunthorpe (15):
>    mm/mmu_notifier: define the header pre-processor parts even if
>      disabled
>    mm/mmu_notifier: add an interval tree notifier
>    mm/hmm: allow hmm_range to be used with a mmu_range_notifier or
>      hmm_mirror
>    mm/hmm: define the pre-processor related parts of hmm.h even if
>      disabled
>    RDMA/odp: Use mmu_range_notifier_insert()
>    RDMA/hfi1: Use mmu_range_notifier_inset for user_exp_rcv
>    drm/radeon: use mmu_range_notifier_insert
>    xen/gntdev: Use select for DMA_SHARED_BUFFER
>    xen/gntdev: use mmu_range_notifier_insert
>    nouveau: use mmu_notifier directly for invalidate_range_start
>    nouveau: use mmu_range_notifier instead of hmm_mirror
>    drm/amdgpu: Call find_vma under mmap_sem
>    drm/amdgpu: Use mmu_range_insert instead of hmm_mirror
>    drm/amdgpu: Use mmu_range_notifier instead of hmm_mirror
>    mm/hmm: remove hmm_mirror and related
>
>   Documentation/vm/hmm.rst                      | 105 +---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   2 +
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |   9 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |  14 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c        | 445 ++------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h        |  53 --
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |  13 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 111 ++--
>   drivers/gpu/drm/nouveau/nouveau_svm.c         | 229 +++++---
>   drivers/gpu/drm/radeon/radeon.h               |   9 +-
>   drivers/gpu/drm/radeon/radeon_mn.c            | 218 ++-----
>   drivers/infiniband/core/device.c              |   1 -
>   drivers/infiniband/core/umem_odp.c            | 288 +---------
>   drivers/infiniband/hw/hfi1/file_ops.c         |   2 +-
>   drivers/infiniband/hw/hfi1/hfi.h              |   2 +-
>   drivers/infiniband/hw/hfi1/user_exp_rcv.c     | 144 ++---
>   drivers/infiniband/hw/hfi1/user_exp_rcv.h     |   3 +-
>   drivers/infiniband/hw/mlx5/mlx5_ib.h          |   7 +-
>   drivers/infiniband/hw/mlx5/mr.c               |   3 +-
>   drivers/infiniband/hw/mlx5/odp.c              |  48 +-
>   drivers/xen/Kconfig                           |   3 +-
>   drivers/xen/gntdev-common.h                   |   8 +-
>   drivers/xen/gntdev.c                          | 179 ++----
>   include/linux/hmm.h                           | 195 +------
>   include/linux/mmu_notifier.h                  | 124 +++-
>   include/rdma/ib_umem_odp.h                    |  65 +--
>   include/rdma/ib_verbs.h                       |   2 -
>   kernel/fork.c                                 |   1 -
>   mm/Kconfig                                    |   2 +-
>   mm/hmm.c                                      | 275 +--------
>   mm/mmu_notifier.c                             | 542 +++++++++++++++++-
>   32 files changed, 1180 insertions(+), 1923 deletions(-)
>

