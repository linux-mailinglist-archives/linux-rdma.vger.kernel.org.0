Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E724178D64
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2019 16:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbfG2OEr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Jul 2019 10:04:47 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36104 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728379AbfG2OEq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Jul 2019 10:04:46 -0400
Received: by mail-qk1-f196.google.com with SMTP id g18so44190775qkl.3
        for <linux-rdma@vger.kernel.org>; Mon, 29 Jul 2019 07:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7ppbGArVZI4ZDOixVF87b1IeJRA7ogQ7KQEeVarUgp8=;
        b=bvHawiHxZdslwx2WM5E/f2kRIS5duXnjcFeeD4L1SbDcy0npDM5EmKEHnRN7jN9AXa
         QAdZxvhzFqjQz4WZyj5C6zc6gyNqcQESthsgp+dZJXPaWegcTSJYB0GIXSfW25NICXcm
         gI+3u727rW7x6QID/xhN7s9Z2MGCVefIOgAYUGKqhAX5o6sjy9P8qgu4v27kG5Snb7G2
         OfHAgGoYc6IxcOzoHJM8eL6RQPL9xoFZQy50dlXp6XhN7Qgqt2KejTJqD325vqiUCZI/
         Vt+tuCRfgDxKRMDEHWVchn8JbNoP06bs3azn6n7k6J7C+QOy2N0rcIVQf8Unud84Rrey
         cdRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7ppbGArVZI4ZDOixVF87b1IeJRA7ogQ7KQEeVarUgp8=;
        b=jpuuR9Z64sSyWCcr/QgNnlWnEJ1tTyaG0dkAoiVepD+wChu0VrCVOIcn+pyJWTS3ZV
         rYEDevAg4RcnNlTyhKm9wCk+poRLa/X9dy4voV5B0p+S3YjW2MUpM2egrK2ipk92wAB/
         kzKVCwZmVZBDK5WRjB0cHboBu7uHJrOvfDQ2Fg3mFoviH7of0dJME/b5W4gI+1gKEEL0
         AFFABB3W6dmlPbYKBST3zLot9IQLinkkv8iUmQzAzqyoHGf7fvPULlds6ckBerRXOE4+
         IJnH4Sv+OOFoNK82pkd7SBadTquuPRL2cQlPj2AV32jqZpWG+DZYMAXZjndhauOh9Io+
         qxNQ==
X-Gm-Message-State: APjAAAVxUXmN3QG3mAGvoFnEg6BPxp0C722g1YTv5fAZeg7qMcFQCK1m
        0c0n6kEEr0jbIQRF9O/vPYsQCn69xVZVVA==
X-Google-Smtp-Source: APXvYqxiIW5VTLvJD/4xCKU7cLsg2FfVyKcwS5jsjnveptNBlJcIQiQHiN/Ewy/7P0Bfq3ehFC2PYQ==
X-Received: by 2002:a37:9ec8:: with SMTP id h191mr77824303qke.229.1564409085498;
        Mon, 29 Jul 2019 07:04:45 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id e1sm30581721qtb.52.2019.07.29.07.04.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 07:04:44 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hs6Ga-00071u-9w; Mon, 29 Jul 2019 11:04:44 -0300
Date:   Mon, 29 Jul 2019 11:04:44 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Michal Kalderon <mkalderon@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v6 rdma-next 1/6] RDMA/core: Create mmap database and
 cookie helper functions
Message-ID: <20190729140444.GB17990@ziepe.ca>
References: <20190709141735.19193-1-michal.kalderon@marvell.com>
 <20190709141735.19193-2-michal.kalderon@marvell.com>
 <20190725175540.GA18757@ziepe.ca>
 <MN2PR18MB3182F4557BC042EE37A3C565A1DD0@MN2PR18MB3182.namprd18.prod.outlook.com>
 <d632598e-0896-fa10-9148-73794a9a49d7@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d632598e-0896-fa10-9148-73794a9a49d7@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 29, 2019 at 04:53:38PM +0300, Gal Pressman wrote:
> On 29/07/2019 15:58, Michal Kalderon wrote:
> >> From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> >> owner@vger.kernel.org> On Behalf Of Jason Gunthorpe
> >>
> >>> +	xa_lock(&ucontext->mmap_xa);
> >>> +	if (check_add_overflow(ucontext->mmap_xa_page,
> >>> +			       (u32)(length >> PAGE_SHIFT),
> >>> +			       &next_mmap_page))
> >>> +		goto err_unlock;
> >>
> >> I still don't like that this algorithm latches into a permanent failure when the
> >> xa_page wraps.
> >>
> >> It seems worth spending a bit more time here to tidy this.. Keep using the
> >> mmap_xa_page scheme, but instead do something like
> >>
> >> alloc_cyclic_range():
> >>
> >> while () {
> >>    // Find first empty element in a cyclic way
> >>    xa_page_first = mmap_xa_page;
> >>    xa_find(xa, &xa_page_first, U32_MAX, XA_FREE_MARK)
> >>
> >>    // Is there a enough room to have the range?
> >>    if (check_add_overflow(xa_page_first, npages, &xa_page_end)) {
> >>       mmap_xa_page = 0;
> >>       continue;
> >>    }
> >>
> >>    // See if the element before intersects
> >>    elm = xa_find(xa, &zero, xa_page_end, 0);
> >>    if (elm && intersects(xa_page_first, xa_page_last, elm->first, elm->last)) {
> >>       mmap_xa_page = elm->last + 1;
> >>       continue
> >>    }
> >>
> >>    // xa_page_first -> xa_page_end should now be free
> >>    xa_insert(xa, xa_page_start, entry);
> >>    mmap_xa_page = xa_page_end + 1;
> >>    return xa_page_start;
> >> }
> >>
> >> Approximately, please check it.
> > Gal & Jason, 
> > 
> > Coming back to the mmap_xa_page algorithm. I couldn't find some background on this. 
> > Why do you need the length to be represented in the mmap_xa_page ?  
> > Why not simply use xa_alloc_cyclic ( like in siw )

I think siw is dealing with only PAGE_SIZE objects, efa had variable
sized ones.

> > This is simply a key to a mmap object... 
> 
> The intention was that the entry would "occupy" number of xarray elements
> according to its size (in pages). It wasn't initially like this, but IIRC this
> was preferred by Jason.

It is not so critical, maybe we could drop it if it is really
simplifiying. But it doesn't look so hard to make an xa algorithm that
will be OK.

The offset/length is shown in things like lsof and what not, and from
a debugging perspective it makes a lot more sense if the offset/length
are sensible, ie they should not overlap.

Jason
