Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97027FF44
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2019 20:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbfD3SFG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Apr 2019 14:05:06 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:37377 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbfD3SFG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Apr 2019 14:05:06 -0400
Received: by mail-yw1-f68.google.com with SMTP id a62so6594343ywa.4
        for <linux-rdma@vger.kernel.org>; Tue, 30 Apr 2019 11:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p4pO1HKcBdG6wbJHDrsieY8R1CBbZC+OzfgvNY6ecwA=;
        b=I2D9Nl4TV25eO/QpZSOK9ghNfEs1JhVHOiNXUffTWZMTxWtsG/rKqtmXDKIeirYb1r
         DGvS+aUVZ4YdVnJomKppO3L+r7p25Cvca8JJA1QL2ymJw2V3k3m/LCKqaG3yX+oB6JbJ
         lWrTBg4Lu4EWF598+hJqA7Bc3UX6tgqvq8dTKaO5yYlEe6VmPYZJgErR9Aqm/1KIfttI
         Z6vAxINyD/hMFdfpZd8gPF+GOCFaz0kQPFyyx9eh7UxbRGoL/E8veQtcWAosnq9YnA1e
         hL5WGUZ2dCuhRn+6ByI8s2Ubw7ScpJCz8qntQMGZ3lE/R6MCvnAhYphagCZNw9TIh+xl
         QOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p4pO1HKcBdG6wbJHDrsieY8R1CBbZC+OzfgvNY6ecwA=;
        b=sWYGkT6hUsaIFq6Jn1EIu3re4bl4h19CdJNo8YBrJaBYTJbzb5QIU4PU/G7Fy4QM7o
         j/EcuKZun0rPQk8VbM7jVfOoTwywZQuoBz/jUbkcKulYXfvDfTJXJFlPHT9ETxetSzmU
         g8ARSkCpbVJ99XFxkVLzlt3LB9dijEL9P+TUQze/olemZZG8j2DinoMAkxG1gcvXgfku
         SMYu1Hsii9E8QDK4iyyZFUVA76WFOUGDj3LsXfEAHxw1BerLiy3PYSQlYjpKFvlqBsap
         JenKCx1FLIVcRw0l2Sh7oXuKY+sXf7BcxJ1QbOamRtUKov9YbFtM48qSyousht7POGFc
         hmUQ==
X-Gm-Message-State: APjAAAXo06tWvVBPkrs2QIls46yiM84iHQwBQ6iW9dJUbN82ReG2KOQa
        ttApd6U7fPinAB2VlWG5eM9sdQ==
X-Google-Smtp-Source: APXvYqz6RL72QRaohisBbwe8L0VEx7tzMb7+pSOzyZ5wlz9ttQy6BvzkabMvA8/OLHzNO35TBE+/Xw==
X-Received: by 2002:a25:1ed6:: with SMTP id e205mr56658715ybe.392.1556647505155;
        Tue, 30 Apr 2019 11:05:05 -0700 (PDT)
Received: from ziepe.ca (adsl-173-228-226-134.prtc.net. [173.228.226.134])
        by smtp.gmail.com with ESMTPSA id l13sm1561845ywe.84.2019.04.30.11.05.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Apr 2019 11:05:04 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hLX7n-0002F0-G3; Tue, 30 Apr 2019 15:05:03 -0300
Date:   Tue, 30 Apr 2019 15:05:03 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>
Cc:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Gal Pressman <galpress@amazon.com>
Subject: Re: [PATCH v2 rdma-next 1/5] RDMA/umem: Add API to find best driver
 supported page size in an MR
Message-ID: <20190430180503.GB8101@ziepe.ca>
References: <20190419134353.12684-1-shiraz.saleem@intel.com>
 <20190419134353.12684-2-shiraz.saleem@intel.com>
 <20190425142559.GA5388@ziepe.ca>
 <9DD61F30A802C4429A01CA4200E302A7A5AC3A8C@fmsmsx124.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9DD61F30A802C4429A01CA4200E302A7A5AC3A8C@fmsmsx124.amr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 30, 2019 at 01:36:14PM +0000, Saleem, Shiraz wrote:

> >If we make a MR with VA 0x6400FFF and length 2M-4095 I expect the 2M page
> >size with the NIC.
> >
> >We will have dma_addr_start = 0x2600000 and sg_dma_len = 0x200000 as the
> >SGL is always rounded to pages
> 
> why isn't it the sg_dma_len 2M-4095? Is it because we compute npages in ib_umem_get()
> to build the SGL? Could using (addr & PAGE_MASK) and then adding dma_len help take
> care of this?  

We always round to page sizes when building the SGL, so the start is
rounded down and the end remains the same.

> >I have a feeling the uvirt_addr should be computed more like
> >
> >  if (flags & IB_UMEM_VA_BASED_OFFSET)
> >        mask |= uvirt_addr ^ umem->addr;
> 
> I am not following.
> 
> For a case like below where uvirt_addr = umem_addr, mask = 0 and we run rdma_find_pgbit on it
> we ll pick 4K instead of 2M which is wrong.
 
> uvirt_addr [0x7f2b98200000]
> best_pgsz [0x201000]
> umem->address [0x7f2b98200000]
> dma_addr_start [0x130e200000]
> dma_addr_end [0x130e400000]
> sg_dma_len [2097152]

??

0x7f2b98200000 ^ 0x7f2b98200000 = 0

So mask isn't altered by the requested VA and you get 2M pages.
 
> Somewhere in the computation of mask, we need to take the va_addr + len and
> make sure that's 2M aligned? Correct?

No, we only care about the bits in the VA that differ from bits in the
PA, ie the bits that can't just pass through the lookup process

ie we want to compute the maximum value such that

(VA + off) & MASK == (PA + off)

Which is the hard upper bound on our page size.


> >.. and a more resonable case of say, uvirt_addr = 0 and umem->addr =
> >0x271000, then 0 ^ 0x271000 -> means the biggest page size is 4k, which is
> >correct.
> >
> 
> For ZERO_BASED, is the uvirt_addr just added to umem->addr or not?

No, for ZERO_BASED uvirt_addr == 0 and umem->addr is some userspace
address

Jason
