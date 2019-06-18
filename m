Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE9C4A1A0
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2019 15:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbfFRNFq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jun 2019 09:05:46 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43984 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfFRNFq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Jun 2019 09:05:46 -0400
Received: by mail-qk1-f194.google.com with SMTP id m14so8453339qka.10
        for <linux-rdma@vger.kernel.org>; Tue, 18 Jun 2019 06:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TTs4qX/AlYeTgBhCVY6oKlnamVeM1+PLnw1E3BGPQ7k=;
        b=HSw6uNWbQt7fjJEsOb5v36NS40qEnnvUQQOjF8RYBujsDACr03g6V1BCXbU+eBSqgE
         PkA+PsoTe9P7s1R1QtqFnAPzo/EF0jJEZAr6tsjkwmr6bfdZ90QRfQscfOxkLlDOvybP
         Swzg2ZlAGssU+HOBqU4mE1v3gbJZ/njoW2LtezmgzdRWxLtbcsPt+AxODrrQQ57lBck6
         w1NOErizBGOfwHoHv6R+Rr9DtnvHuBJAl6gq8Zzn0we2Jq+p11rahAQx0yLw5X1G4Fb3
         BYHFnuVdQJ8DB5EIRKcdRgWqsSU3aocFHyuDxLPSQ6xUqP+lxAtEF+CfR+M6EBbrnn2T
         dTOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TTs4qX/AlYeTgBhCVY6oKlnamVeM1+PLnw1E3BGPQ7k=;
        b=ldRUK06oxBqvs7FXUo57wSXWB/iyXxB4tRa603TXj80VZlKhV1+jLC1mBRxoR5hERe
         wOmENn0Ja5gVCLVLQ7lP/kQ7SZ5Uy0m+wudcouEggKhNUmLkR9nbpTbbO+Kiy8ckz6R1
         13AWSUBbKPrzqAl0fNjCVSdh1yT8oThSEahr2e/xneuw41f7JT+5VjVQqL+4DdAGZTMO
         Ghd3PNlMDIm9IzTbSFIx4qKxKiaS6VedfZB7v3ZX5/3TY55JEP7EII8FPg3/hsxyCOI1
         +dubsrF+UmiZV8NFKYt4FqKzvhjizVs8DdGArVDGChUls43Gz+AZTLMozm594ESfhB97
         fWfg==
X-Gm-Message-State: APjAAAXCyJQ8JNX3lsdS6BQuP3WOtiLU3WA71kHAOa2Qk/LdSUHY4mrF
        0K6k36WYi/v/GQnYVv10HsmJ5mun+KxKCg==
X-Google-Smtp-Source: APXvYqyTVmV2qJESAaYOKHbD1BjBEsgUZPM0i2g79H7bXawYK5ERfS0qh6JfLB9C36JFGw7C3yUXcw==
X-Received: by 2002:ae9:ed0a:: with SMTP id c10mr91466247qkg.207.1560863145518;
        Tue, 18 Jun 2019 06:05:45 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id k15sm7008956qtg.22.2019.06.18.06.05.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2019 06:05:45 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hdDo0-0002Yh-HV; Tue, 18 Jun 2019 10:05:44 -0300
Date:   Tue, 18 Jun 2019 10:05:44 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Philip Yang <Philip.Yang@amd.com>
Subject: Re: [PATCH v3 hmm 02/12] mm/hmm: Use hmm_mirror not mm as an
 argument for hmm_range_register
Message-ID: <20190618130544.GC6961@ziepe.ca>
References: <20190614004450.20252-1-jgg@ziepe.ca>
 <20190614004450.20252-3-jgg@ziepe.ca>
 <20190615135906.GB17724@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190615135906.GB17724@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jun 15, 2019 at 06:59:06AM -0700, Christoph Hellwig wrote:
> On Thu, Jun 13, 2019 at 09:44:40PM -0300, Jason Gunthorpe wrote:
> > From: Jason Gunthorpe <jgg@mellanox.com>
> > 
> > Ralph observes that hmm_range_register() can only be called by a driver
> > while a mirror is registered. Make this clear in the API by passing in the
> > mirror structure as a parameter.
> > 
> > This also simplifies understanding the lifetime model for struct hmm, as
> > the hmm pointer must be valid as part of a registered mirror so all we
> > need in hmm_register_range() is a simple kref_get.
> 
> Looks good, at least an an intermediate step:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> > index f6956d78e3cb25..22a97ada108b4e 100644
> > +++ b/mm/hmm.c
> > @@ -914,13 +914,13 @@ static void hmm_pfns_clear(struct hmm_range *range,
> >   * Track updates to the CPU page table see include/linux/hmm.h
> >   */
> >  int hmm_range_register(struct hmm_range *range,
> > -		       struct mm_struct *mm,
> > +		       struct hmm_mirror *mirror,
> >  		       unsigned long start,
> >  		       unsigned long end,
> >  		       unsigned page_shift)
> >  {
> >  	unsigned long mask = ((1UL << page_shift) - 1UL);
> > -	struct hmm *hmm;
> > +	struct hmm *hmm = mirror->hmm;
> >  
> >  	range->valid = false;
> >  	range->hmm = NULL;
> > @@ -934,20 +934,15 @@ int hmm_range_register(struct hmm_range *range,
> >  	range->start = start;
> >  	range->end = end;
> 
> But while you're at it:  the calling conventions of hmm_range_register
> are still rather odd, as the staet, end and page_shift arguments are
> only used to fill out fields in the range structure passed in.  Might
> be worth cleaning up as well if we change the calling convention.

I'm thinking to tackle that as part of the mmu notififer invlock
idea.. Once the range looses the lock then we don't really need to
register it at all.

Thanks,
Jason
