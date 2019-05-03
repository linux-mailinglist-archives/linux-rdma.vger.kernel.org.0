Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9EC13658
	for <lists+linux-rdma@lfdr.de>; Sat,  4 May 2019 01:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfECXu0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 May 2019 19:50:26 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41635 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfECXu0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 May 2019 19:50:26 -0400
Received: by mail-qt1-f193.google.com with SMTP id c13so8696521qtn.8
        for <linux-rdma@vger.kernel.org>; Fri, 03 May 2019 16:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=myEmDM1tl8JbR6YMpSXJcrDkeSv8GCoixvaAoXhr78I=;
        b=dpzp0Ir0qlWbRF7Yq/HHM0joK+p7hkUNm9sadj2y+lK/wbCY7lJ9yiiGozPIGOqNfB
         SJkybzPS+g+f21FO/x9mz/cQyUJGg79S7os9kiqIUEUa/rbL3IzH4mpa1obS5anyBqyr
         SHKoU/2GSDZgNgB57EnjRJ8h0zuz1dfLq/JEdVSE5RIskNjFswD9e5infY+XnCKjUZU+
         FsovaoVmpAFAB7g9oxBs7FFh1fWInTtKBgTRyyDBpoX65pVxNgVZja+ilGTyE5WCt7R/
         Xck975+x6Kxw85Vw2htWTplG0RYTJO83DsXfsDmWYX1JnjGfIk26MLTQ6vjrgSK8b6cJ
         roHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=myEmDM1tl8JbR6YMpSXJcrDkeSv8GCoixvaAoXhr78I=;
        b=B8Tb1xuRt/+9d4IxF2fHCJH4o2m/F+/BLtWjvyxUbOUFy3KZgnq9TunArHfQRxYl6Z
         bSE3lPsMyUcCUwdEho1mhTb20T2ZO643Jz4hHXw0MJ9YRbld09uAPWwXq+Iz3mlGmGQS
         TZSKo7++ra6bJZnuqzB0Lhkuy3nZpR77kZWimFrkzd/uj38qyUJwFu/ogVYxRX8vFiSA
         K309YSGvvmkoHv5Hu/0pdng+eJi0wM79G5ni3AkI3Z1vKIYq5lE2SiuQIYXYfiYkoxmX
         UcFf7eOiYIHztHXxYM9sTwop7UY7Jwt6+wBvZca7FRksGEBXc6I2nGfRmycOmiutvTP/
         TiCA==
X-Gm-Message-State: APjAAAWQ4zo+OmgDyKbIA+4Hs9QxdJwrsm+Hf2D8k++Li6393qMaYMu3
        lBOmdB1Nt3c4uaInuBMKQ2srKACG3mj69Q==
X-Google-Smtp-Source: APXvYqx6FTN5Ns8Os3k5JZyjYh4ogaIluYRodOB3Dwf/Mnpyu2Rse2uQUyHYdEubw82blvhvZVJO8Q==
X-Received: by 2002:aed:24a3:: with SMTP id t32mr10993590qtc.206.1556927425112;
        Fri, 03 May 2019 16:50:25 -0700 (PDT)
Received: from ziepe.ca ([65.119.211.164])
        by smtp.gmail.com with ESMTPSA id j129sm2001197qkd.51.2019.05.03.16.50.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 16:50:24 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hMhwd-0001ku-43; Fri, 03 May 2019 20:50:23 -0300
Date:   Fri, 3 May 2019 20:50:23 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>
Cc:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Gal Pressman <galpress@amazon.com>
Subject: Re: [PATCH v2 rdma-next 1/5] RDMA/umem: Add API to find best driver
 supported page size in an MR
Message-ID: <20190503235023.GA6660@ziepe.ca>
References: <20190419134353.12684-1-shiraz.saleem@intel.com>
 <20190419134353.12684-2-shiraz.saleem@intel.com>
 <20190425142559.GA5388@ziepe.ca>
 <9DD61F30A802C4429A01CA4200E302A7A5AC3A8C@fmsmsx124.amr.corp.intel.com>
 <20190430180503.GB8101@ziepe.ca>
 <9DD61F30A802C4429A01CA4200E302A7A5ACCB03@fmsmsx124.amr.corp.intel.com>
 <20190430210011.GA9059@ziepe.ca>
 <9DD61F30A802C4429A01CA4200E302A7A5AD1514@fmsmsx124.amr.corp.intel.com>
 <20190503152835.GB31165@ziepe.ca>
 <9DD61F30A802C4429A01CA4200E302A7A5AD161A@fmsmsx124.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9DD61F30A802C4429A01CA4200E302A7A5AD161A@fmsmsx124.amr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 03, 2019 at 04:01:27PM +0000, Saleem, Shiraz wrote:
> >Subject: Re: [PATCH v2 rdma-next 1/5] RDMA/umem: Add API to find best driver
> >supported page size in an MR
> >
> >On Fri, May 03, 2019 at 03:22:59PM +0000, Saleem, Shiraz wrote:
> >> >This is because mask shouldn't start as zero - the highest possible
> >> >mask is something like log2_ru(umem length)
> >> >
> >> >ie absent other considerations the page size at the NIC should be the
> >> >size of the umem.
> >> >
> >> >Then we scan the sgl and reduce that value based on the physical
> >> >address layout
> >> >
> >> >Then we reduce it again based on the uvirt vs address difference
> >> >
> >> >Oring a '0' into the mask means that step contributes no restriction.
> >> >
> >> >..
> >> >
> >> >So I think the algorithm is just off as is, it should be more like
> >> >
> >> > // Page size can't be larger than the length of the MR mask =
> >> >log2_ru(umem length);
> >> >
> >> > // offset into the first SGL for umem->addr pgoff = umem->address &
> >> >PAGE_MASK;  va = uvirt_addr;
> >> >
> >>
> >> Did you mean pgoff = umem->address & ~PAGE_MASK?
> >
> >Yes...
> 
> OK. Don't we need something like this for zero based VA?
> va = uvirt_addr ?  uvirt_addr :  umem->addr;

Every MR is created with an IOVA (here called VA). Before we get here
the caller should figure out the IOVA and it should either be 0 or
umem->address in the cases we implement today *however* it can really
be anything and this code shouldn't care..

> Also can we do this for all HW?

All hardware has to support an arbitary IOVA.

> Or do we keep the IB_UMEM_VA_BASED_OFFSET flag and OR
> in the dma_addr_end (for first SGL) and dma_addr_start (for last SGL)
> to the mask when the flag is not set?

I wasn't totally sure what that flag did..

If we don't have any drivers that need something different today then
I would focus entirely on the:

 PA = MR_PAGE_TABLE[IOVA/PAGE_SIZE] | (IOVA & PAGE_MASK)

Case, which is what I outlined.

The ^ is checking that the (IOVA & PAGE_MASK) scheme will work.

> > for_each_sgl()
> >   mask |= (sgl->dma_addr + pgoff) ^ va
> >   if (not first or last)
> >       // Interior SGLs limit by the length as well
> >       mask |= sgl->length;
> >   va += sgl->length - pgoff;
> >   pgoff = 0;
> >
> 
> >
> >But really even that is not what it should be, the 'pgoff' should simply be the
> >'offset' member of the first sgl and we should set it correctly based on the umem-
> >>address when building the sgl in the core code.
> >
> 
> I can look to update it post this series.
> And the core code changes to not over allocate scatter table.

Sure

Lets try and get this sorted out right away so it can go in this merge
window, which might start on Monday.

Jason  
