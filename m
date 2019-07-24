Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F29CD73FE2
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jul 2019 22:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388351AbfGXUgF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Jul 2019 16:36:05 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43429 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbfGXTZG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 24 Jul 2019 15:25:06 -0400
Received: by mail-qk1-f193.google.com with SMTP id m14so8949589qka.10
        for <linux-rdma@vger.kernel.org>; Wed, 24 Jul 2019 12:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OkPU/CLyukMOj3ZbNY/O7tpHR8CxfiQ425Gxa1fb2JQ=;
        b=cizJvBvS9LWtQgqD7tHrOnbfUKLn3IKwTexaKlCz0aV8WGl+nqxYE5pseR5xXgl2ZJ
         m8csupMpr7OwAKhyoW9lBHKDfnN0nYwK9z7/RsX4VX3pqa9PWl3XI5/GUR4dWGbBS/2X
         l7xDDDeEor3Zjue37hzwItxKtPGOFgmLJ5n/YPHgvOS+Y7TaohrswgfdoQ2xx5ljLnn5
         gCACdxiqqXuMTz9u7PVtheBQ9dr7K2gpEpuVehHqwNFqED9VeiqZrebhSMSMl/zhVVtH
         139CJQm906dlJU9cmPZyBRd9LIjBH6vCpXIBSECVQGTTiiTBHHUCo4qXoOTM7WaE9BBS
         G4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OkPU/CLyukMOj3ZbNY/O7tpHR8CxfiQ425Gxa1fb2JQ=;
        b=BnEqT5cLYPknHhwzOHAi4PU0BrycsF7++H181lK936BAV3RALFruCsAsw69WTkeuCl
         v8Ls6cj/xkqkhYWa3IS+QjYfN05lf5tPUzFgJLHyP8G+fAkDiPGFSbHbJddKMXAMhZW6
         9Xs3eCJryDABH41S+ckJ5LZswTwf2W0fbhLeS87YSGTVEyEV98oIr9vc3DpZC+EsPFRO
         pjp1OELEzGrkzg2rHZvs0V6uF63dO29KaVigz7sYIWf2R79xtv6YJtDH4B9tTMeRNMD4
         mB1vpsWWmivm2Ib4J0H3l51GTkKuhrT0x8o6IggxNhYbxJDkPRJ8WKU1g5SL1GhMx2Cq
         GqnQ==
X-Gm-Message-State: APjAAAXfI61zPPJBKtCIyyiaGK8tNndcOT0OBL8K5Bjr+aGEGo+liJJc
        bh/worEGI2GDQaS9O95c5G2Bkg==
X-Google-Smtp-Source: APXvYqyhflls5Pd07xc/KaSNWazAfdY/U63489DoRwgjjWJQqGNW++Rr6B+pQE207tw0i/3votp85A==
X-Received: by 2002:a05:620a:1f4:: with SMTP id x20mr56790548qkn.415.1563996305707;
        Wed, 24 Jul 2019 12:25:05 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id r40sm29245885qtk.2.2019.07.24.12.25.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jul 2019 12:25:05 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hqMsq-0001Uo-Fh; Wed, 24 Jul 2019 16:25:04 -0300
Date:   Wed, 24 Jul 2019 16:25:04 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
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
        Kees Cook <keescook@chromium.org>,
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
Subject: Re: [PATCH v19 11/15] IB/mlx4: untag user pointers in
 mlx4_get_umem_mr
Message-ID: <20190724192504.GA5716@ziepe.ca>
References: <cover.1563904656.git.andreyknvl@google.com>
 <7969018013a67ddbbf784ac7afeea5a57b1e2bcb.1563904656.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7969018013a67ddbbf784ac7afeea5a57b1e2bcb.1563904656.git.andreyknvl@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 23, 2019 at 07:58:48PM +0200, Andrey Konovalov wrote:
> This patch is a part of a series that extends kernel ABI to allow to pass
> tagged user pointers (with the top byte set to something else other than
> 0x00) as syscall arguments.
> 
> mlx4_get_umem_mr() uses provided user pointers for vma lookups, which can
> only by done with untagged pointers.
> 
> Untag user pointers in this function.
> 
> Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  drivers/infiniband/hw/mlx4/mr.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Applied to rdma-for next, please don't sent it via other trees :)

Thanks,
Jason
