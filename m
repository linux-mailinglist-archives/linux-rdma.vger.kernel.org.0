Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90B9239AAA
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Jun 2019 06:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbfFHEC1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 8 Jun 2019 00:02:27 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37865 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfFHEC1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 8 Jun 2019 00:02:27 -0400
Received: by mail-pl1-f195.google.com with SMTP id bh12so1545202plb.4
        for <linux-rdma@vger.kernel.org>; Fri, 07 Jun 2019 21:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ld9qqur+4qvQ29YBRyUFm2eutAmUIhRNEhUVQshxtq0=;
        b=HXvVg9coUo1xEEGS0DwgDUYkxEz6DS1r+bnepiqG47VSO6k+SKaBqi5wnLJUzhKT0Q
         F77v/3inF5WO9KdoxanRYXG9UTvU9WuNvhZbHSnOvkwygp4/KRjUvBwoWTTXrnkExWcy
         ADu9rIK/0BZ8VaknNJsilZ7GGCNNLhX/1899U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ld9qqur+4qvQ29YBRyUFm2eutAmUIhRNEhUVQshxtq0=;
        b=B+w/0ArQ0WW6rGBNHIt/LDxY4bImFRZ7ASjEydFlQMs4oub50AQ8Ylw1HDe7qMZbOp
         9BeBBmgiyrWbpkThEVER/oNkLKqiyPNMx8s9xOZVPivaO/TPqL1D7Mm1sQ2qoMvcZHBy
         ZEDzlc4jDwEonTzJfuuAk9L3DvtqBsbRhnmR8lXtpPZeY2xUJmdxEIVYvPqueNg+Oxk9
         E2N0acaBh3W2MvSjaU3VAy+/E/Dhn+RAjrHBMg1/k6u2eFg/V+qlZ9OhrNRigpnogwrv
         Acx3P+tWjZIeTWaoorCIuKCPNn6W7O1Apfi8Ft9UnjW48UIoZAhnesgo6OnFgVYer4yA
         e0Uw==
X-Gm-Message-State: APjAAAV1GTSnc45MjKjw8lsP79PU8j0YaUVegJ0AL4slUnE1ftc/gEgO
        dsJNMbSxif//pVP5sqM/m1ir4Q==
X-Google-Smtp-Source: APXvYqyWIU7z0h83s595E4gtAHnTw/dwV2AWdUHb9XfpIujI04l63mQHZIFAtQw1iHXTD7aat4vguA==
X-Received: by 2002:a17:902:8ec3:: with SMTP id x3mr57418900plo.340.1559966546670;
        Fri, 07 Jun 2019 21:02:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b16sm3567551pfd.12.2019.06.07.21.02.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 21:02:25 -0700 (PDT)
Date:   Fri, 7 Jun 2019 21:02:25 -0700
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
Subject: Re: [PATCH v16 08/16] fs, arm64: untag user pointers in
 copy_mount_options
Message-ID: <201906072101.58C919E@keescook>
References: <cover.1559580831.git.andreyknvl@google.com>
 <51f44a12c4e81c9edea8dcd268f820f5d1fad87c.1559580831.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51f44a12c4e81c9edea8dcd268f820f5d1fad87c.1559580831.git.andreyknvl@google.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 03, 2019 at 06:55:10PM +0200, Andrey Konovalov wrote:
> This patch is a part of a series that extends arm64 kernel ABI to allow to
> pass tagged user pointers (with the top byte set to something else other
> than 0x00) as syscall arguments.
> 
> In copy_mount_options a user address is being subtracted from TASK_SIZE.
> If the address is lower than TASK_SIZE, the size is calculated to not
> allow the exact_copy_from_user() call to cross TASK_SIZE boundary.
> However if the address is tagged, then the size will be calculated
> incorrectly.
> 
> Untag the address before subtracting.
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

One thing I just noticed in the commit titles... "arm64" is in the
prefix, but these are arch-indep areas. Should the ", arm64" be left
out?

I would expect, instead:

	fs/namespace: untag user pointers in copy_mount_options

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  fs/namespace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index b26778bdc236..2e85712a19ed 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2993,7 +2993,7 @@ void *copy_mount_options(const void __user * data)
>  	 * the remainder of the page.
>  	 */
>  	/* copy_from_user cannot cross TASK_SIZE ! */
> -	size = TASK_SIZE - (unsigned long)data;
> +	size = TASK_SIZE - (unsigned long)untagged_addr(data);
>  	if (size > PAGE_SIZE)
>  		size = PAGE_SIZE;
>  
> -- 
> 2.22.0.rc1.311.g5d7573a151-goog
> 

-- 
Kees Cook
