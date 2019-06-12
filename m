Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFC7E424EE
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2019 14:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfFLMBQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jun 2019 08:01:16 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:47043 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbfFLMBQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Jun 2019 08:01:16 -0400
Received: by mail-qk1-f194.google.com with SMTP id a132so9899043qkb.13
        for <linux-rdma@vger.kernel.org>; Wed, 12 Jun 2019 05:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ytRyq9tD6/B2UUk+DlUG0EGvYLV7mqKpRopmhrX9MMA=;
        b=etqhAyF+sK43iLfBcDQ5rnLpM3+o/s4U0M8rewYDO5GaupFZQ54jwPvPLm13DYrlAB
         29JJj6NEQiVqK3wQW4AnZaAdlwEr1+r/wr+djAkKO0wTyVvHj+BgjsRFYSSqMffGqNVb
         hGAbMeyOa+2PGsyPohcsecilgo/APPYCW1afuRagfi98EwVQPT2y+x00Ou10yazKlZ/k
         qWxU9qKn9a3eBpmI5p/UBBvmlQcK5iXMUWSF3zmSkIoHCeMnPg6xqTjrsQdXysgS0Ga1
         ugfd8gmzWDs52GSyPGcvGBu7epG4fWUajdBOOaiQjn/YN63g0kEM2LCS2kf+3TOcxizd
         nQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ytRyq9tD6/B2UUk+DlUG0EGvYLV7mqKpRopmhrX9MMA=;
        b=Tbewr96rlnT/tLLCKUXKLWXiapJJw1srwtpFjxXD+LLngztcb9H9h6jiQp1nba5Qi3
         DR3RhLNUhNR/ese9gntfuw3HI+9QMhbK/Hngsgk5bsbdGq0JN3k5F8zkKouuqdq/AhfU
         uNwU6NGX2RDJcGq9OOJNu3Rvbl8AzP8YF/c/O/VMHJmew68iEMkmac9iCDOYYbBNcD9w
         c/uaUy2vml34zDQA0K1XSdl8T3hFr7SgRdDB66fq3Q54UYhQbOZf2TwzQ6fRgLI1kKGA
         YdpJQxQ8ME6r/v+rnD0VRina5WX1utlKP74Th6bjIKAk8l10pv81u0ztVMNYIYfScBEB
         1Thg==
X-Gm-Message-State: APjAAAXjhCFBGKHkICUwW5jOTq4W4193AoAcQHdg5i1r8CuuDTGkak1L
        BTiWVAPbHBsl1cqWvy0c5tuJy02s57ifqg==
X-Google-Smtp-Source: APXvYqwSae0AIwiRaLE1vzmLJQoahfZuZP3CM+jsF7jhYJmv1qvMKPLmlC+DAnnGVsxPxWfjZLj0Dw==
X-Received: by 2002:a37:4ad7:: with SMTP id x206mr62518273qka.85.1560340875528;
        Wed, 12 Jun 2019 05:01:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id s64sm7598542qkb.56.2019.06.12.05.01.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2019 05:01:14 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hb1wI-0002PJ-Cg; Wed, 12 Jun 2019 09:01:14 -0300
Date:   Wed, 12 Jun 2019 09:01:14 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-rc 2/2] RDMA/efa: Handle mmap insertions overflow
Message-ID: <20190612120114.GD3876@ziepe.ca>
References: <20190612072842.99285-1-galpress@amazon.com>
 <20190612072842.99285-3-galpress@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612072842.99285-3-galpress@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 12, 2019 at 10:28:42AM +0300, Gal Pressman wrote:
> When inserting a new mmap entry to the xarray we should check for
> 'mmap_page' overflow as it is limited to 32 bits.
> 
> While at it, make sure to advance the mmap_page stored on the ucontext
> only after a successful insertion.
> 
> Fixes: 40909f664d27 ("RDMA/efa: Add EFA verbs implementation")
> Signed-off-by: Gal Pressman <galpress@amazon.com>
>  drivers/infiniband/hw/efa/efa_verbs.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
> index 0fea5d63fdbe..c463c683ae84 100644
> +++ b/drivers/infiniband/hw/efa/efa_verbs.c
> @@ -204,6 +204,7 @@ static u64 mmap_entry_insert(struct efa_dev *dev, struct efa_ucontext *ucontext,
>  			     void *obj, u64 address, u64 length, u8 mmap_flag)
>  {
>  	struct efa_mmap_entry *entry;
> +	u32 next_mmap_page;
>  	int err;
>  
>  	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
> @@ -216,15 +217,19 @@ static u64 mmap_entry_insert(struct efa_dev *dev, struct efa_ucontext *ucontext,
>  	entry->mmap_flag = mmap_flag;
>  
>  	xa_lock(&ucontext->mmap_xa);
> +	if (check_add_overflow(ucontext->mmap_xa_page,
> +			       (u32)(length >> PAGE_SHIFT),
> +			       &next_mmap_page))
> +		goto err_unlock;
> +
>  	entry->mmap_page = ucontext->mmap_xa_page;
> -	ucontext->mmap_xa_page += DIV_ROUND_UP(length, PAGE_SIZE);
>  	err = __xa_insert(&ucontext->mmap_xa, entry->mmap_page, entry,
>  			  GFP_KERNEL);
> +	if (err)
> +		goto err_unlock;
> +
> +	ucontext->mmap_xa_page = next_mmap_page;

This is not ordered right anymore, the xa_lock can be released inside
__xa_insert, so to be atomic you must do everything before calling
__xa_insert.

Jason
