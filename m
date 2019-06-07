Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC2D638C29
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 16:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbfFGODQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 10:03:16 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39171 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728311AbfFGODQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jun 2019 10:03:16 -0400
Received: by mail-qt1-f196.google.com with SMTP id i34so2352305qta.6
        for <linux-rdma@vger.kernel.org>; Fri, 07 Jun 2019 07:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=P7GoCE6Vzl1X5NohwcLhAV/U9MsA/FhXn4++zB5+WQw=;
        b=HEjJDRLT1/QrA6H/XpWwtPycyetApCN4CInuydPmEmSGPRRJv+Cn/jI64AeZu0N/bC
         PXklr3+VSClv6Qje5a8q/NaHAeR2RO96W4pxfd9tEXkAS8YQuSd8rdwNTzvHpyEhvlzB
         R6bFoF/NlWFv03tX7XWcM8xVuEbzIMN2maEqxblaz42nopqucXcsniwmuN3bycCbynMh
         +mIYN90GQZsDgAFyAZaFZK4r64NsWLjFXc9zviD8/t0b3KHPgkMMdG5HQuqfhvA8fR/p
         GWBn+WTOku/tkXz7yhlu+QqUseN0G5TjKCGMeF2EOBa1naQKJUB7b4ZX8y76Hd3jGLEM
         PHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=P7GoCE6Vzl1X5NohwcLhAV/U9MsA/FhXn4++zB5+WQw=;
        b=PEvHWDbtTMm4zNCHZBsGeMKaKUr8hvcFVoCRJ++b2sBl+tITz+aPfq4qMoaUF02Uoh
         AdoqJ5A7stPMDUHpjL46uRja2Mfb2agnH1tGRo3ILEzPDpFg2a1QGX3V78ZdTgC8WdQx
         4BoxANLHiQS/8lY1mOnzqVVdIcoX76YO7+rNHemR1RCUQYLGkSZhNHAmruQeeU/Tumae
         SUDYb3OXv8zGPkz2no9BKKjiB58hmx/oBBa19QFY+otXqZL00pAD0M7hKk8TTPZuKIL6
         U/zNnDwpc9yx2qDlIkZkP6IaNzsVAoFd8MY95PBTRIwsvE5yi8dsvtooer57UQcoC6tY
         tEMw==
X-Gm-Message-State: APjAAAWko0pwyhGRWIPXkP+e22Zg1FofQv63QtrZAqbWpxntr6YtLCjR
        BBHrSjQfiPn/L7BhPAvjb5Ejsw==
X-Google-Smtp-Source: APXvYqz2/915uO4AoJkylfCxPwtwvf01ilYy48xf4ydSxLalVse+hWheTEibI1VzArzBO6/jyTi2Rg==
X-Received: by 2002:ac8:7342:: with SMTP id q2mr5402914qtp.134.1559916195107;
        Fri, 07 Jun 2019 07:03:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id d123sm1160617qkb.94.2019.06.07.07.03.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 07:03:13 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hZFSb-0003fn-4v; Fri, 07 Jun 2019 11:03:13 -0300
Date:   Fri, 7 Jun 2019 11:03:13 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Felix.Kuehling@amd.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v2 hmm 09/11] mm/hmm: Poison hmm_range during unregister
Message-ID: <20190607140313.GI14802@ziepe.ca>
References: <20190606184438.31646-1-jgg@ziepe.ca>
 <20190606184438.31646-10-jgg@ziepe.ca>
 <c00da0f2-b4b8-813b-0441-a50d4de9d8be@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c00da0f2-b4b8-813b-0441-a50d4de9d8be@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 06, 2019 at 08:37:42PM -0700, John Hubbard wrote:
> On 6/6/19 11:44 AM, Jason Gunthorpe wrote:
> > From: Jason Gunthorpe <jgg@mellanox.com>
> > 
> > Trying to misuse a range outside its lifetime is a kernel bug. Use WARN_ON
> > and poison bytes to detect this condition.
> > 
> > Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> > Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
> > v2
> > - Keep range start/end valid after unregistration (Jerome)
> >  mm/hmm.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/mm/hmm.c b/mm/hmm.c
> > index 6802de7080d172..c2fecb3ecb11e1 100644
> > +++ b/mm/hmm.c
> > @@ -937,7 +937,7 @@ void hmm_range_unregister(struct hmm_range *range)
> >  	struct hmm *hmm = range->hmm;
> >  
> >  	/* Sanity check this really should not happen. */
> 
> That comment can also be deleted, as it has the same meaning as
> the WARN_ON() that you just added.
> 
> > -	if (hmm == NULL || range->end <= range->start)
> > +	if (WARN_ON(range->end <= range->start))
> >  		return;
> >  
> >  	mutex_lock(&hmm->lock);
> > @@ -948,7 +948,10 @@ void hmm_range_unregister(struct hmm_range *range)
> >  	range->valid = false;
> >  	mmput(hmm->mm);
> >  	hmm_put(hmm);
> > -	range->hmm = NULL;
> > +
> > +	/* The range is now invalid, leave it poisoned. */
> 
> To be precise, we are poisoning the range's back pointer to it's
> owning hmm instance.  Maybe this is clearer:
> 
> 	/*
> 	 * The range is now invalid, so poison it's hmm pointer. 
> 	 * Leave other range-> fields in place, for the caller's use.
> 	 */
> 
> ...or something like that?
> 
> > +	range->valid = false;
> > +	memset(&range->hmm, POISON_INUSE, sizeof(range->hmm));
> >  }
> >  EXPORT_SYMBOL(hmm_range_unregister);
> >  
> > 
> 
> The above are very minor documentation points, so:
> 
>     Reviewed-by: John Hubbard <jhubbard@nvidia.com>

done thanks

Jason
