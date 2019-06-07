Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B72038AC4
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 14:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbfFGM6o (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 08:58:44 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46558 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727606AbfFGM6o (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jun 2019 08:58:44 -0400
Received: by mail-qk1-f196.google.com with SMTP id a132so1127612qkb.13
        for <linux-rdma@vger.kernel.org>; Fri, 07 Jun 2019 05:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XZLOMkYs5vXjMI8Dkpaj3wAhdY/xEzfilUkvJL4EXH4=;
        b=N80l5v8nv6hIG51GGBM5+5TLSkvUjSSCa9Cn4MGZUpD+wY28VR23asHPPM24ICOwL2
         nAbR23abB3zKIl8/4vBjtjhFTTbIPzEqJYil1OYzPPhROYxXgqqdNOuNSancrYWXqewx
         BnOcJSJOWmic6p2onjwo9+ZCZdNNNr4DcNaiX2EqP7jgfF8/mbDYj0Z94+7C0i3GdDBI
         zT37XTlbwh3fm0/MZZEKJkZRVsb/IAcRWwlHOUDFHaMaYFqITiRjZIAd1IGyPQGV5mA7
         00nLqMYxsjqP5MczltRg1QpmNV4fmex4E92/bFXMahKwHP+EKfNY+zQ4QqMf53bT1nRI
         Zm2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XZLOMkYs5vXjMI8Dkpaj3wAhdY/xEzfilUkvJL4EXH4=;
        b=ZUcBF50ULx3ZEu0DotyeXa+7Ni180yvy8R/grsicO0sTw9xfSv0iHCu5y5mL57TPH1
         J+q3290fq3DbhVD9y03tBZSHqTITRlmz70TRwR7JEC3uaPfq4MRCQ/w2/sqnzumtfHgm
         pgKivcbLVSLg8y9blsCZC+7WLCJsQJGFbZnPX7E8VhFpcywij7ugvWQx86WcQiN4ouo4
         p75QSEn1SSjEXFSmDL90uZfh3MZt5VAOEXEKT3lP0I0TakGvzdzfVyhgqcXOyDh7ZfYh
         Mm21TfWtEx5O1XIFbXofQxlyaBJOgr0bic2Ud0tVkhEuWllV6Tx58uOtTm8he6HuwhX/
         473Q==
X-Gm-Message-State: APjAAAVYeOPS2undcaesvJ/mHIU16ZucSWEmmtxsgOCvilKrj0NoOOFa
        vE4Q5C3FZPPLTzmpVBuQlFe+tQ==
X-Google-Smtp-Source: APXvYqwLYhkbnVkO37hDdk1D8+dw0XaaSJbnZghiAkAd4Vn3rUNFhKrdJtv3yRh7yG+5koJqQBqxRg==
X-Received: by 2002:a37:b342:: with SMTP id c63mr44488163qkf.292.1559912323433;
        Fri, 07 Jun 2019 05:58:43 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id p49sm1384966qtb.69.2019.06.07.05.58.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 05:58:43 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hZESA-0007KA-Il; Fri, 07 Jun 2019 09:58:42 -0300
Date:   Fri, 7 Jun 2019 09:58:42 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Felix.Kuehling@amd.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v2 hmm 11/11] mm/hmm: Remove confusing comment and logic
 from hmm_release
Message-ID: <20190607125842.GE14802@ziepe.ca>
References: <20190606184438.31646-1-jgg@ziepe.ca>
 <20190606184438.31646-12-jgg@ziepe.ca>
 <3edc47bd-e8f6-0e65-5844-d16901890637@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3edc47bd-e8f6-0e65-5844-d16901890637@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 06, 2019 at 08:47:28PM -0700, John Hubbard wrote:
> On 6/6/19 11:44 AM, Jason Gunthorpe wrote:
> > From: Jason Gunthorpe <jgg@mellanox.com>
> > 
> > hmm_release() is called exactly once per hmm. ops->release() cannot
> > accidentally trigger any action that would recurse back onto
> > hmm->mirrors_sem.
> > 
> > This fixes a use after-free race of the form:
> > 
> >        CPU0                                   CPU1
> >                                            hmm_release()
> >                                              up_write(&hmm->mirrors_sem);
> >  hmm_mirror_unregister(mirror)
> >   down_write(&hmm->mirrors_sem);
> >   up_write(&hmm->mirrors_sem);
> >   kfree(mirror)
> >                                              mirror->ops->release(mirror)
> > 
> > The only user we have today for ops->release is an empty function, so this
> > is unambiguously safe.
> > 
> > As a consequence of plugging this race drivers are not allowed to
> > register/unregister mirrors from within a release op.
> > 
> > Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> >  mm/hmm.c | 28 +++++++++-------------------
> >  1 file changed, 9 insertions(+), 19 deletions(-)
> > 
> > diff --git a/mm/hmm.c b/mm/hmm.c
> > index 709d138dd49027..3a45dd3d778248 100644
> > +++ b/mm/hmm.c
> > @@ -136,26 +136,16 @@ static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
> >  	WARN_ON(!list_empty(&hmm->ranges));
> >  	mutex_unlock(&hmm->lock);
> >  
> > -	down_write(&hmm->mirrors_sem);
> > -	mirror = list_first_entry_or_null(&hmm->mirrors, struct hmm_mirror,
> > -					  list);
> > -	while (mirror) {
> > -		list_del_init(&mirror->list);
> > -		if (mirror->ops->release) {
> > -			/*
> > -			 * Drop mirrors_sem so the release callback can wait
> > -			 * on any pending work that might itself trigger a
> > -			 * mmu_notifier callback and thus would deadlock with
> > -			 * us.
> > -			 */
> > -			up_write(&hmm->mirrors_sem);
> > +	down_read(&hmm->mirrors_sem);
> 
> This is cleaner and simpler, but I suspect it is leading to the deadlock
> that Ralph Campbell is seeing in his driver testing. (And in general, holding
> a lock during a driver callback usually leads to deadlocks.)

I think Ralph has never seen this patch (it is new), so it must be one
of the earlier patches..

> Ralph, is this the one? It's the only place in this patchset where I can
> see a lock around a callback to driver code, that wasn't there before. So
> I'm pretty sure it is the one...

Can you share the lockdep report please?

Thanks,
Jason
