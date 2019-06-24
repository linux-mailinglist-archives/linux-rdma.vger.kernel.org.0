Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9B1950F70
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2019 17:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbfFXPBN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Jun 2019 11:01:13 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43161 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729485AbfFXPBN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Jun 2019 11:01:13 -0400
Received: by mail-pg1-f195.google.com with SMTP id f25so7257217pgv.10
        for <linux-rdma@vger.kernel.org>; Mon, 24 Jun 2019 08:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wtUCrmBvvtcTuAx+h8NVUvwzdIMNqCWWz94+pOdbySM=;
        b=SgtXb1ZoPYVGoTEFnr3Dke5H/wW1XINfDlxvUxMEVKLscJVqYESlzT6pTs1qtGKsP3
         VeuBN2URvFVWTMNeAoodZlrCQwZUc/5Z9xlB5RTSjoVcpo/SiTZgkaWRm8NhK88ImAdg
         pZTI13ZgoVTCMMEv5hkuIuzOLGORBtQ5+y4c8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wtUCrmBvvtcTuAx+h8NVUvwzdIMNqCWWz94+pOdbySM=;
        b=FyS41Xg+VjwdEMJExY8wm0Xe9ApZeeyknlEG6Q/enFH/COLmcyra7OLbdDyAO0XOl0
         mMmnenDrZbaPDRJYBffaUmE8/SpytKFaWwHEfNPsepHggxer+RULkazXG7HnQ+fCbcrD
         B1uRwz71qxBaZaPHsbsb61XhIolDaCv9BTKAYC6XPnLkcrVKB0lYrsDlQdNmcFnzRCyb
         /zcxnATM+UzNM8dZvEO6bLjJTSlrBmbCiCafDHW5vDS4CNrWdIKH8RRA+IxFhjIB5Ma4
         eM6b58n0lm7OjLS3jxpokycO567OABs/rnIJThH5s2w4VWF4STGX7JXN0I15jmf4tloP
         ujTA==
X-Gm-Message-State: APjAAAW6LrOAk3yzGRBxmNZ576EaqLbQ4pwtzHTporTOCxe4W+QiGzeo
        TasexRjPhT36ixLczNRsCIVcUg==
X-Google-Smtp-Source: APXvYqzelK/vNHxou/EQMWEPlS7Rae3sUcNTxG5Oed/VwPMQT+QfUbDH1pcZmoGQxd0g0HPzOMRX5A==
X-Received: by 2002:a63:f349:: with SMTP id t9mr32144143pgj.296.1561388472617;
        Mon, 24 Jun 2019 08:01:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v5sm14367158pgq.66.2019.06.24.08.01.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Jun 2019 08:01:11 -0700 (PDT)
Date:   Mon, 24 Jun 2019 08:01:10 -0700
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
Subject: Re: [PATCH v18 10/15] drm/radeon: untag user pointers in
 radeon_gem_userptr_ioctl
Message-ID: <201906240801.F35CE2641@keescook>
References: <cover.1561386715.git.andreyknvl@google.com>
 <61d800c35a4f391218fbca6f05ec458557d8d097.1561386715.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61d800c35a4f391218fbca6f05ec458557d8d097.1561386715.git.andreyknvl@google.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 24, 2019 at 04:32:55PM +0200, Andrey Konovalov wrote:
> This patch is a part of a series that extends kernel ABI to allow to pass
> tagged user pointers (with the top byte set to something else other than
> 0x00) as syscall arguments.
> 
> In radeon_gem_userptr_ioctl() an MMU notifier is set up with a (tagged)
> userspace pointer. The untagged address should be used so that MMU
> notifiers for the untagged address get correctly matched up with the right
> BO. This funcation also calls radeon_ttm_tt_pin_userptr(), which uses
> provided user pointers for vma lookups, which can only by done with
> untagged pointers.
> 
> This patch untags user pointers in radeon_gem_userptr_ioctl().
> 
> Suggested-by: Felix Kuehling <Felix.Kuehling@amd.com>
> Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/gpu/drm/radeon/radeon_gem.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon/radeon_gem.c
> index 44617dec8183..90eb78fb5eb2 100644
> --- a/drivers/gpu/drm/radeon/radeon_gem.c
> +++ b/drivers/gpu/drm/radeon/radeon_gem.c
> @@ -291,6 +291,8 @@ int radeon_gem_userptr_ioctl(struct drm_device *dev, void *data,
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
