Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEEA810154
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2019 23:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfD3VAV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Apr 2019 17:00:21 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:40390 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfD3VAV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Apr 2019 17:00:21 -0400
Received: by mail-yw1-f68.google.com with SMTP id t79so6974727ywc.7
        for <linux-rdma@vger.kernel.org>; Tue, 30 Apr 2019 14:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rfpby8+rgIUlqERrNPxE2DB2BRQe1PhQQWZAwsZuxhI=;
        b=nUHBF/WZh1Glm8NurivrDX0R0ZXLh00vvvDcEwk1dqfiEVaZxN9NCYFOnFSAIzQgct
         P2pUSOIU5NCKb+NcdcWzvwk+g4FtFH7ZNb5M2oH1YZvpzYspgKVL4CqM6lLOYRBvIjNM
         k8ZS9SVGP9wTvh7g5dfvt44HySLWcisB3l2BlKr5z5zCE1gsrqCOeEbBXj4iSnujfwJ+
         HqZDOGOpgD4HaI5O5Gd97O2gLvYSE05+QoAH3mjNod8F65d8g0cBw4q4F4NQpC703Eae
         mcv9St3cd7o5kK8PHnaqbqkEdlVeFDbNovqU4SZqUtYFEJMBTKnfyxJL4Yf0MEwmh/Zk
         vUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rfpby8+rgIUlqERrNPxE2DB2BRQe1PhQQWZAwsZuxhI=;
        b=WORkNytmPUxHZ9268X9ZibUNM9lVpjKFgdtIyy7gtWZKcMz3M2ftHLIvbjM+fvx6oA
         EJR648NDP8j4DWLEcsvPSaDMQvr2Dl+ZsvE79sUJighOt6Z7pRcaZA81e4MxnD74bj2E
         twB3z84sAVi460YrGfkgKpLzxP9JJ/i0nWmXTgVknWfsmPUBo/dcavAu9y/hhVdCGXZk
         TnjCPbjcIQJ1WCOutoIwzRA7bb9RENGYxYhQpOs8i3p8bGQPaphp0AJBnqGfu7QH2cJ+
         Fh8ldU1ScISJ028EB0r1bZR7Idlomfulu+nz+DPXz4RB66cOa+cE08BEsXabYJDr9oAf
         Mwvg==
X-Gm-Message-State: APjAAAUQ2cmpQxyw1gsESFun9IrpIVggi4YeZlNnescKu6LFPwW6QXAy
        R2dkdVAAYtde+DiaoPaODnV1hg==
X-Google-Smtp-Source: APXvYqx7fFiPKB0fsmXa5RuMK8hP6y0X6uthF5jnnywjth0fg4IJAkL4if6CjnM095NMro1WZrZvUg==
X-Received: by 2002:a25:8105:: with SMTP id o5mr40006873ybk.242.1556658020129;
        Tue, 30 Apr 2019 14:00:20 -0700 (PDT)
Received: from ziepe.ca (adsl-173-228-226-134.prtc.net. [173.228.226.134])
        by smtp.gmail.com with ESMTPSA id 202sm3390792ywt.72.2019.04.30.14.00.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Apr 2019 14:00:12 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hLZrH-0002W8-B7; Tue, 30 Apr 2019 18:00:11 -0300
Date:   Tue, 30 Apr 2019 18:00:11 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>
Cc:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Gal Pressman <galpress@amazon.com>
Subject: Re: [PATCH v2 rdma-next 1/5] RDMA/umem: Add API to find best driver
 supported page size in an MR
Message-ID: <20190430210011.GA9059@ziepe.ca>
References: <20190419134353.12684-1-shiraz.saleem@intel.com>
 <20190419134353.12684-2-shiraz.saleem@intel.com>
 <20190425142559.GA5388@ziepe.ca>
 <9DD61F30A802C4429A01CA4200E302A7A5AC3A8C@fmsmsx124.amr.corp.intel.com>
 <20190430180503.GB8101@ziepe.ca>
 <9DD61F30A802C4429A01CA4200E302A7A5ACCB03@fmsmsx124.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9DD61F30A802C4429A01CA4200E302A7A5ACCB03@fmsmsx124.amr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 30, 2019 at 07:54:24PM +0000, Saleem, Shiraz wrote:
> >Subject: Re: [PATCH v2 rdma-next 1/5] RDMA/umem: Add API to find best driver
> >supported page size in an MR
> >
> >On Tue, Apr 30, 2019 at 01:36:14PM +0000, Saleem, Shiraz wrote:
> >
> >> >If we make a MR with VA 0x6400FFF and length 2M-4095 I expect the 2M
> >> >page size with the NIC.
> >> >
> >> >We will have dma_addr_start = 0x2600000 and sg_dma_len = 0x200000 as
> >> >the SGL is always rounded to pages
> >>
> >> why isn't it the sg_dma_len 2M-4095? Is it because we compute npages
> >> in ib_umem_get() to build the SGL? Could using (addr & PAGE_MASK) and
> >> then adding dma_len help take care of this?
> >
> >We always round to page sizes when building the SGL, so the start is rounded
> >down and the end remains the same.
> >
> >> >I have a feeling the uvirt_addr should be computed more like
> >> >
> >> >  if (flags & IB_UMEM_VA_BASED_OFFSET)
> >> >        mask |= uvirt_addr ^ umem->addr;
> >>
> >> I am not following.
> >>
> >> For a case like below where uvirt_addr = umem_addr, mask = 0 and we
> >> run rdma_find_pgbit on it we ll pick 4K instead of 2M which is wrong.
> >
> >> uvirt_addr [0x7f2b98200000]
> >> best_pgsz [0x201000]
> >> umem->address [0x7f2b98200000]
> >> dma_addr_start [0x130e200000]
> >> dma_addr_end [0x130e400000]
> >> sg_dma_len [2097152]
> >
> >??
> >
> >0x7f2b98200000 ^ 0x7f2b98200000 = 0
> >
> >So mask isn't altered by the requested VA and you get 2M pages.

> I am still missing the point. mask was initialized to 0 and if we just do
> "mask |= uvirt_addr ^ umem->addr" for the first SGE, then you ll
> always get 0 for mask (and one page size) when uvirt_addr = umem->addr
> irrespective of their values.

This is because mask shouldn't start as zero - the highest possible
mask is something like log2_ru(umem length)

ie absent other considerations the page size at the NIC should be the
size of the umem.

Then we scan the sgl and reduce that value based on the physical
address layout

Then we reduce it again based on the uvirt vs address difference

Oring a '0' into the mask means that step contributes no restriction.

..

So I think the algorithm is just off as is, it should be more like

 // Page size can't be larger than the length of the MR
 mask = log2_ru(umem length); 

 // offset into the first SGL for umem->addr
 pgoff = umem->address & PAGE_MASK;
 va = uvirt_addr;

 for_each_sgl()
   mask |= (sgl->dma_addr + pgoff) ^ va
   if (not first or last)
       // Interior SGLs limit by the length as well
       mask |= sgl->length;
   va += sgl->length - pgoff;
   pgoff = 0;

The key is the xor of the VA to the PA at every step because that is
really the restriction we are looking at. If any VA/PA bits differ for
any address in the MR that immediately reduces the max page size.

Remember what the HW does is
  PA = MR_PAGE[VA] | (VA & PAGE_MASK)

So any situation where PA & PAGE_MASK != VA is a violation - this is
the calculation the XOR is doing.

Jason
