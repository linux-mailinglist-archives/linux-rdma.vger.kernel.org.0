Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC95B50F6D
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2019 17:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbfFXPBA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Jun 2019 11:01:00 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42891 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbfFXPBA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Jun 2019 11:01:00 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so7658059pff.9
        for <linux-rdma@vger.kernel.org>; Mon, 24 Jun 2019 08:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZH0KsEpqEXiZL11grL/nW8IzWOxozO/nFecO0TNWzZg=;
        b=KQ2654w6YgnMZs2At+Zd89XQIqIuYR8jlquNCWJJuIXpWD/HlSd4ZBjLxPQsxGeT2n
         QOBGSpQkVzrAWhjdNm3L175i3EwkQyprQmoxs6iyZjw9hV5O7BunNQVJJ3RYGgog4Rsr
         YQVv/8/84su3okC1IPWa+LhVmvUHm4bqUkhyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZH0KsEpqEXiZL11grL/nW8IzWOxozO/nFecO0TNWzZg=;
        b=gQ6MCIk8SaLoutYxXxmclYX14qOvm0He3Up2CELDrAyCqyUkqA0jytboIW9rYB9t3H
         2pGX46f2HRHQYusP5ee6eP4SVMB/kdzTV8/Ng6egtmn8m7n79T3p4JSMHVZ3eBUY9SPl
         3YvQwRmzpxhJxQHTjCYC0Hs7Qs/d617F60DgltrKHEVEH5nkQqj/8svJELlFkNLkUikh
         5XivTvXYxGjkNrFh1iNhbxeOw/2a5vY8ZMqVQvYXPjJ/Ekqd+qDmyKGxRx54LPeVGT/c
         TTpDzIdGNpVzomFMuwz7amrzp/j0A2K9np6jFt6OyS+k92nxLavL4jk7LJEphSFRHKKi
         WNqw==
X-Gm-Message-State: APjAAAUaEThWzHwOhdsDmZpsQlv/qUhObuTLHHzqdYj06qE3w+tG9bqe
        YrkNe69MznN4zgZAomOLToEdCQ==
X-Google-Smtp-Source: APXvYqyXA9qWckeMWJ1FYgTNxW3Kl/SaHQcwWPkv+8Ov9g+q8rZ/yCmpPgqZaQwQyexxau4NGmLb3Q==
X-Received: by 2002:a17:90a:338b:: with SMTP id n11mr24999228pjb.21.1561388459522;
        Mon, 24 Jun 2019 08:00:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e188sm1978374pfh.99.2019.06.24.08.00.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Jun 2019 08:00:58 -0700 (PDT)
Date:   Mon, 24 Jun 2019 08:00:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Khalid Aziz <khalid.aziz@oracle.com>, enh <enh@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christoph Hellwig <hch@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Subject: Re: [PATCH v18 09/15] drm/amdgpu: untag user pointers
Message-ID: <201906240800.5677E3CF@keescook>
References: <cover.1561386715.git.andreyknvl@google.com>
 <1d036fc5bec4be059ee7f4f42bf7417dc44651dd.1561386715.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d036fc5bec4be059ee7f4f42bf7417dc44651dd.1561386715.git.andreyknvl@google.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 24, 2019 at 04:32:54PM +0200, Andrey Konovalov wrote:
> This patch is a part of a series that extends kernel ABI to allow to pass
> tagged user pointers (with the top byte set to something else other than
> 0x00) as syscall arguments.
> 
> In amdgpu_gem_userptr_ioctl() and amdgpu_amdkfd_gpuvm.c/init_user_pages()
> an MMU notifier is set up with a (tagged) userspace pointer. The untagged
> address should be used so that MMU notifiers for the untagged address get
> correctly matched up with the right BO. This patch untag user pointers in
> amdgpu_gem_userptr_ioctl() for the GEM case and in amdgpu_amdkfd_gpuvm_
> alloc_memory_of_gpu() for the KFD case. This also makes sure that an
> untagged pointer is passed to amdgpu_ttm_tt_get_user_pages(), which uses
> it for vma lookups.
> 
> Suggested-by: Felix Kuehling <Felix.Kuehling@amd.com>
> Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c          | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index a6e5184d436c..5d476e9bbc43 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1108,7 +1108,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>  		alloc_flags = 0;
>  		if (!offset || !*offset)
>  			return -EINVAL;
> -		user_addr = *offset;
> +		user_addr = untagged_addr(*offset);
>  	} else if (flags & ALLOC_MEM_FLAGS_DOORBELL) {
>  		domain = AMDGPU_GEM_DOMAIN_GTT;
>  		alloc_domain = AMDGPU_GEM_DOMAIN_CPU;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index d4fcf5475464..e91df1407618 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -287,6 +287,8 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
>  	uint32_t handle;
>  	int r;
>  
> +	args->addr = untagged_addr(args->addr);
> +
>  	if (offset_in_page(args->addr | args->size))
>  		return -EINVAL;
>  
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 

-- 
Kees Cook
