Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB14E39554
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 21:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbfFGTNE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 15:13:04 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44896 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728752AbfFGTNE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jun 2019 15:13:04 -0400
Received: by mail-qt1-f193.google.com with SMTP id x47so3528737qtk.11
        for <linux-rdma@vger.kernel.org>; Fri, 07 Jun 2019 12:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=L5u/Ewjt5chLxfL8rJhTxjnnE9xyDskU5p/CRtJxiWk=;
        b=bHsPjAAReITKwgXncrDQTUnXH5Uijp2yxwi54oFK0Oz03jgNQyFhk7SQWR25Vf57lG
         5J6WB8BhgQr2brS9p/HxVjcz/IKspC8ZZGgXxTb89hyDw6XGOwJRJa3HYjZxUQMfLrqP
         uVoeOGU1e0jF8iYlcy/d4lLIPcQqPtxjbX9ZItpPRa/lHVfSdg9gmJmTyxiQtHKaPV1U
         J1ylkbGKkx6WHJknF7MIDM9blwCpIDf4aCW/jrUX4cc6/SZAxImLy9wuCFni5MukTp9f
         vwPYJF+o6d56Yg60VxHr2pAlIWg0aH5DsbA7nYwEO21TQ5DiUxGjo1TsMsh9ne7w/s2v
         6l3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=L5u/Ewjt5chLxfL8rJhTxjnnE9xyDskU5p/CRtJxiWk=;
        b=qw/85jnBUIlsWCLNNRqCDeio+G7+4Few2uV/0SnHj04+NrVjPN8Xxk5NCVGiByktLq
         Iaec0h0FLjc/5LWVV4kXsnhq51pIFMVLAGVxxTMjXJMt9AbZ6Gn63MAi3apOkxLTd9gA
         ws8OJ54n1wZbBELb4bl0s2C0XBpZW1zwP7OQA8dUFlzxhAJwV/ELybD3rm1vKPfei0Ff
         QKjjPQtpsGsBg+2aR1reCA9HlsAsJkZ3aL/lFDX/i9M0gnCKCZ+LhAdFsz3EuwXK6ZMl
         EDk36ApjfPfZXMDD3kd8fbJ5CSLXE99Vq20Kaozfepx4GnqJ93Zou7EnbWSSOoXhIGwK
         LpTQ==
X-Gm-Message-State: APjAAAUePN7MzPO89zXj8mxS4EZGKq3NdNv6WoM0lW1/iBaIYSGOERQm
        VRYdWnGqxiMlWU4DCou8+DdDmg==
X-Google-Smtp-Source: APXvYqypnlbRh0P3THtdFA6tT1uB3/DaS37Mw0g1zWi372Eeo4eJbdLfgNtonmEZ+OErUzAT0EDkAg==
X-Received: by 2002:a0c:88c3:: with SMTP id 3mr26437457qvo.21.1559934783538;
        Fri, 07 Jun 2019 12:13:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id k40sm2014808qta.50.2019.06.07.12.13.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 12:13:03 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hZKIQ-0000kC-MD; Fri, 07 Jun 2019 16:13:02 -0300
Date:   Fri, 7 Jun 2019 16:13:02 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v2 hmm 05/11] mm/hmm: Remove duplicate condition test
 before wait_event_timeout
Message-ID: <20190607191302.GR14802@ziepe.ca>
References: <20190606184438.31646-1-jgg@ziepe.ca>
 <20190606184438.31646-6-jgg@ziepe.ca>
 <6833be96-12a3-1a1c-1514-c148ba2dd87b@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6833be96-12a3-1a1c-1514-c148ba2dd87b@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 07, 2019 at 12:01:45PM -0700, Ralph Campbell wrote:
> 
> On 6/6/19 11:44 AM, Jason Gunthorpe wrote:
> > From: Jason Gunthorpe <jgg@mellanox.com>
> > 
> > The wait_event_timeout macro already tests the condition as its first
> > action, so there is no reason to open code another version of this, all
> > that does is skip the might_sleep() debugging in common cases, which is
> > not helpful.
> > 
> > Further, based on prior patches, we can no simplify the required condition
> > test:
> >   - If range is valid memory then so is range->hmm
> >   - If hmm_release() has run then range->valid is set to false
> >     at the same time as dead, so no reason to check both.
> >   - A valid hmm has a valid hmm->mm.
> > 
> > Also, add the READ_ONCE for range->valid as there is no lock held here.
> > 
> > Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> > Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
> >   include/linux/hmm.h | 12 ++----------
> >   1 file changed, 2 insertions(+), 10 deletions(-)
> > 
> > diff --git a/include/linux/hmm.h b/include/linux/hmm.h
> > index 4ee3acabe5ed22..2ab35b40992b24 100644
> > +++ b/include/linux/hmm.h
> > @@ -218,17 +218,9 @@ static inline unsigned long hmm_range_page_size(const struct hmm_range *range)
> >   static inline bool hmm_range_wait_until_valid(struct hmm_range *range,
> >   					      unsigned long timeout)
> >   {
> > -	/* Check if mm is dead ? */
> > -	if (range->hmm == NULL || range->hmm->dead || range->hmm->mm == NULL) {
> > -		range->valid = false;
> > -		return false;
> > -	}
> > -	if (range->valid)
> > -		return true;
> > -	wait_event_timeout(range->hmm->wq, range->valid || range->hmm->dead,
> > +	wait_event_timeout(range->hmm->wq, range->valid,
> >   			   msecs_to_jiffies(timeout));
> > -	/* Return current valid status just in case we get lucky */
> > -	return range->valid;
> > +	return READ_ONCE(range->valid);
> >   }
> >   /*
> > 
> 
> Since we are simplifying things, perhaps we should consider merging
> hmm_range_wait_until_valid() info hmm_range_register() and
> removing hmm_range_wait_until_valid() since the pattern
> is to always call the two together.

? the hmm.rst shows the hmm_range_wait_until_valid being called in the
(ret == -EAGAIN) path. It is confusing because it should really just
have the again label moved up above hmm_range_wait_until_valid() as
even if we get the driver lock it could still be a long wait for the
colliding invalidation to clear.

What I want to get to is a pattern like this:

pagefault():

   hmm_range_register(&range);
again:
   /* On the slow path, if we appear to be live locked then we get
      the write side of mmap_sem which will break the live lock,
      otherwise this gets the read lock */
   if (hmm_range_start_and_lock(&range))
         goto err;

   lockdep_assert_held(range->mm->mmap_sem);

   // Optional: Avoid useless expensive work
   if (hmm_range_needs_retry(&range))
      goto again;
   hmm_range_(touch vmas)

   take_lock(driver->update);
   if (hmm_range_end(&range) {
       release_lock(driver->update);
       goto again;
   }
   // Finish driver updates
   release_lock(driver->update);

   // Releases mmap_sem
   hmm_range_unregister_and_unlock(&range);

What do you think? 

Is it clear?

Jason
