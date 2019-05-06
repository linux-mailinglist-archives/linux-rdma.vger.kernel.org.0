Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34DF314B32
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2019 15:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbfEFNui (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 May 2019 09:50:38 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36404 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfEFNui (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 May 2019 09:50:38 -0400
Received: by mail-pl1-f194.google.com with SMTP id cb4so2491108plb.3
        for <linux-rdma@vger.kernel.org>; Mon, 06 May 2019 06:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bQJbdD3DpYVGAJMB4xHT/wsaNr2EFZ6QKX73vdaXiy8=;
        b=DRQ6yKsX6G++7lU4Zg5s3BYR0P9dOtDVRdgDq4OTKtqnFzdHr5mrU+eAH8m/xaAqq9
         GjaGvUS7mkeRr5xpwetie72lE61cQQyZApscmN4YS70y1VIT4NWv/M48lKerfm627Th7
         gjcuK1BYAbSf4nXxfiio5m7d5spLpXCCTDKGcC2aVAdeBFYRKrP8Z7bE2tG9DZ2rIsGu
         CwljSWmdU9qHLtd/Gz+syQE0KKMpSKrEQoJTqd9Mdkk5tKa5G5tK8eI5XA5KcbzqPu4t
         Lq4Z4U34+8CqteCsW5OMIEDaAHJ5orfzvcPcniCK32BPqiOxrEh1Ln7swqpgKcat4g3N
         37Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bQJbdD3DpYVGAJMB4xHT/wsaNr2EFZ6QKX73vdaXiy8=;
        b=Qu/w417uMrWEMhi9RTh038RgbvjkTaLJvOLpfiuqjDIZdZI/a/tLQ8brW8zHCzJZe9
         lL0hjrloTufakt6eIqrXMOTOXeqPkj5O718x/15vEYEmvLn9R6yDKrNsr4Opp2MHezTH
         hU1AtQcX8nhr3/Eu8oAvR3utpBejNStaFyxOA7TCEn0mJD25zVJRuFzuSjv5YlNFqyes
         Nf9ljgEzZs6MnQNIp6aCP2IyPZ0xz+l/9noKLQtQi9MtU7tU7tuz9wujCfi21kNBFYGd
         rB/rQrTe8wc66ub0t6w3c2/CzfjY4mH5/t3BgWsMU34fjnEk8N7jAFijHlIs9lONkMzE
         wp0g==
X-Gm-Message-State: APjAAAXznuLqsiW45wBgV6BNc6vTe5pLQWNsks0vDZ9ACxLTr8/ob6VZ
        TlfQ0EmIjeoxKSRdJk9Oc9FjTLnLkW6e+nGRmManlA==
X-Google-Smtp-Source: APXvYqwbKSvVTOpuC9GERGa4zYi/56mC1YqRSuljrXhiTGgFzKxKxPy7xquJMcd52Z/Xw9GWuZtYyS77z4awlmXBnWo=
X-Received: by 2002:a17:902:7783:: with SMTP id o3mr32208910pll.159.1557150636780;
 Mon, 06 May 2019 06:50:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556630205.git.andreyknvl@google.com> <2e827b5c484be14044933049fec180cd6acb054b.1556630205.git.andreyknvl@google.com>
 <3108d33e-8e18-a73e-5e1a-f0db64f02ab3@amd.com>
In-Reply-To: <3108d33e-8e18-a73e-5e1a-f0db64f02ab3@amd.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 6 May 2019 15:50:25 +0200
Message-ID: <CAAeHK+zDScw-aYpQFVG=JKartDqCF+ZWnq3-6PuaYgMiBphcJA@mail.gmail.com>
Subject: Re: [PATCH v14 11/17] drm/amdgpu, arm64: untag user pointers
To:     "Kuehling, Felix" <Felix.Kuehling@amd.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 30, 2019 at 8:03 PM Kuehling, Felix <Felix.Kuehling@amd.com> wrote:
>
> On 2019-04-30 9:25 a.m., Andrey Konovalov wrote:
> > [CAUTION: External Email]
> >
> > This patch is a part of a series that extends arm64 kernel ABI to allow to
> > pass tagged user pointers (with the top byte set to something else other
> > than 0x00) as syscall arguments.
> >
> > amdgpu_ttm_tt_get_user_pages() uses provided user pointers for vma
> > lookups, which can only by done with untagged pointers. This patch
> > untag user pointers when they are being set in
> > amdgpu_ttm_tt_set_userptr().
> >
> > In amdgpu_gem_userptr_ioctl() and amdgpu_amdkfd_gpuvm.c/init_user_pages()
> > an MMU notifier is set up with a (tagged) userspace pointer. The untagged
> > address should be used so that MMU notifiers for the untagged address get
> > correctly matched up with the right BO. This patch untag user pointers in
> > amdgpu_gem_userptr_ioctl() for the GEM case and in
> > amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu() for the KFD case.
> >
> > Suggested-by: Kuehling, Felix <Felix.Kuehling@amd.com>
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c          | 2 ++
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c          | 2 +-
> >   3 files changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > index 1921dec3df7a..20cac44ed449 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > @@ -1121,7 +1121,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
> >                  alloc_flags = 0;
> >                  if (!offset || !*offset)
> >                          return -EINVAL;
> > -               user_addr = *offset;
> > +               user_addr = untagged_addr(*offset);
> >          } else if (flags & ALLOC_MEM_FLAGS_DOORBELL) {
> >                  domain = AMDGPU_GEM_DOMAIN_GTT;
> >                  alloc_domain = AMDGPU_GEM_DOMAIN_CPU;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> > index d21dd2f369da..985cb82b2aa6 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> > @@ -286,6 +286,8 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
> >          uint32_t handle;
> >          int r;
> >
> > +       args->addr = untagged_addr(args->addr);
> > +
> >          if (offset_in_page(args->addr | args->size))
> >                  return -EINVAL;
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > index 73e71e61dc99..1d30e97ac2c4 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > @@ -1248,7 +1248,7 @@ int amdgpu_ttm_tt_set_userptr(struct ttm_tt *ttm, uint64_t addr,
> >          if (gtt == NULL)
> >                  return -EINVAL;
> >
> > -       gtt->userptr = addr;
> > +       gtt->userptr = untagged_addr(addr);
>
> Doing this here seems unnecessary. You already untagged the address in
> both callers of this function. Untagging in the two callers ensures that
> the userptr and MMU notifier are in sync, using the same untagged
> address. Doing it again here is redundant.

 Will fix in v15, thanks!

>
> Regards,
>    Felix
>
>
> >          gtt->userflags = flags;
> >
> >          if (gtt->usertask)
> > --
> > 2.21.0.593.g511ec345e18-goog
> >
