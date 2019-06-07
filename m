Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9D8538A8F
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 14:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbfFGMri (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 08:47:38 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34727 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbfFGMri (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jun 2019 08:47:38 -0400
Received: by mail-qt1-f195.google.com with SMTP id m29so2064572qtu.1
        for <linux-rdma@vger.kernel.org>; Fri, 07 Jun 2019 05:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+c/gka4YIKdP7GQGtlyknCKyAsbIyrfj7eQnoWT0OTY=;
        b=ABb2mR+ZZAV64KjuG42+1j8wOiBv07RLnEhokivS6dkelGWvCuHxWLWQ38ajecNiKk
         I8sax2ddk0PeIAqNVoPFLfW2P6rXeC8U5w0Jrec9nBiBmucTap3T5/jsCXs4CCfSOwLl
         wfrdji6NUMTVsPnvyFNCJydZIcD7xJBJqy9vaUBkvmih1nK7k6E1uAvGVfIjlPupPNSe
         ifmSWCefglCgnsrpSVAbfkmbRRGkaFRHLdx9xyHbg7k7w/Yl+a3pAxaxNVqe/daJJP19
         rIUhjtOhW2yxF3FTfuEmH7csLa2KcjCRb/9e1fXaLpf1XmSt14O0WkYFjloyewXGofh1
         PWFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+c/gka4YIKdP7GQGtlyknCKyAsbIyrfj7eQnoWT0OTY=;
        b=dOHCuh0lYYWLwzrkJvNEKegSxGdLcxk4ktOJCl0eaQjAvpp4Bczn+YP9J59V1zXoD0
         Cx+o9EhO6as0Enh6QIroQRlAYKDByxJwCRu2TPocJO8lo3dtQHbUBU9li64fuPHI1lrb
         a11P5snYX4YLD2S9c7QG78qD0CbyCNmg+9ma5dShQoGp0B0Iu+TdX2/hXYmvVr8iqgKa
         BrpOI7Gx6P30li5X8frb3mYZ1Vn+wRnzJQKYErSRqJkUUWi+sM6QXczJTfRWJ0bQQFTx
         uQtiMcEwZeWNzNrlBHdbPTBy/8KVX4rxGGrF22ElimDkWThLZLPCnvQEmY59B2ip7yE5
         FRRw==
X-Gm-Message-State: APjAAAUnYl2Jj/ilQg1lNZQZLORyTNQLw9acVkk4ppTkHVi6M0/oePEe
        aKS4Y+hj8AdBXzXZ2xDJBIOowg==
X-Google-Smtp-Source: APXvYqwdM/GqmL5RLvNREoHCt3f9E4ZMzm0f8oQsiHff8vd5bIxBZ1U6i5LCEvmvIuO+Xy7+sKWVmA==
X-Received: by 2002:a0c:d610:: with SMTP id c16mr44488711qvj.22.1559911657239;
        Fri, 07 Jun 2019 05:47:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id t8sm1271201qtc.80.2019.06.07.05.47.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 05:47:36 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hZEHQ-0007Fq-EM; Fri, 07 Jun 2019 09:47:36 -0300
Date:   Fri, 7 Jun 2019 09:47:36 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Felix.Kuehling@amd.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v2 hmm 05/11] mm/hmm: Remove duplicate condition test
 before wait_event_timeout
Message-ID: <20190607124736.GD14802@ziepe.ca>
References: <20190606184438.31646-1-jgg@ziepe.ca>
 <20190606184438.31646-6-jgg@ziepe.ca>
 <86962e22-88b1-c1bf-d704-d5a5053fa100@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86962e22-88b1-c1bf-d704-d5a5053fa100@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 06, 2019 at 08:06:52PM -0700, John Hubbard wrote:
> On 6/6/19 11:44 AM, Jason Gunthorpe wrote:
> > From: Jason Gunthorpe <jgg@mellanox.com>
> > 
> > The wait_event_timeout macro already tests the condition as its first
> > action, so there is no reason to open code another version of this, all
> > that does is skip the might_sleep() debugging in common cases, which is
> > not helpful.
> > 
> > Further, based on prior patches, we can no simplify the required condition
> 
>                                           "now simplify"
> 
> > test:
> >  - If range is valid memory then so is range->hmm
> >  - If hmm_release() has run then range->valid is set to false
> >    at the same time as dead, so no reason to check both.
> >  - A valid hmm has a valid hmm->mm.
> > 
> > Also, add the READ_ONCE for range->valid as there is no lock held here.
> > 
> > Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> > Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
> >  include/linux/hmm.h | 12 ++----------
> >  1 file changed, 2 insertions(+), 10 deletions(-)
> > 
> > diff --git a/include/linux/hmm.h b/include/linux/hmm.h
> > index 4ee3acabe5ed22..2ab35b40992b24 100644
> > +++ b/include/linux/hmm.h
> > @@ -218,17 +218,9 @@ static inline unsigned long hmm_range_page_size(const struct hmm_range *range)
> >  static inline bool hmm_range_wait_until_valid(struct hmm_range *range,
> >  					      unsigned long timeout)
> >  {
> > -	/* Check if mm is dead ? */
> > -	if (range->hmm == NULL || range->hmm->dead || range->hmm->mm == NULL) {
> > -		range->valid = false;
> > -		return false;
> > -	}
> > -	if (range->valid)
> > -		return true;
> > -	wait_event_timeout(range->hmm->wq, range->valid || range->hmm->dead,
> > +	wait_event_timeout(range->hmm->wq, range->valid,
> >  			   msecs_to_jiffies(timeout));
> > -	/* Return current valid status just in case we get lucky */
> > -	return range->valid;
> > +	return READ_ONCE(range->valid);
> 
> Just to ensure that I actually understand the model: I'm assuming that the 
> READ_ONCE is there solely to ensure that range->valid is read *after* the
> wait_event_timeout() returns. Is that correct?

No, wait_event_timout already has internal barriers that make sure
things don't leak across it.

The READ_ONCE is required any time a thread is reading a value that
another thread can be concurrently changing - ie in this case there is
no lock protecting range->valid so the write side could be running.

Without the READ_ONCE the compiler is allowed to read the value twice
and assume it gets the same result, which may not be true with a
parallel writer, and thus may compromise the control flow in some
unknown way. 

It is also good documentation for the locking scheme in use as it
marks shared data that is not being locked.

However, now that dead is gone we can just write the above more simply
as:

static inline bool hmm_range_wait_until_valid(struct hmm_range *range,
					      unsigned long timeout)
{
	return wait_event_timeout(range->hmm->wq, range->valid,
				  msecs_to_jiffies(timeout)) != 0;
}

Which relies on the internal barriers of wait_event_timeout, I'll fix
it up..

Thanks,
Jason
