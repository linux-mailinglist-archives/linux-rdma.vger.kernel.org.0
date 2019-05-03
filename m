Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBBC513129
	for <lists+linux-rdma@lfdr.de>; Fri,  3 May 2019 17:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbfECP2j (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 May 2019 11:28:39 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:35735 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfECP2j (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 May 2019 11:28:39 -0400
Received: by mail-yw1-f65.google.com with SMTP id n188so4603701ywe.2
        for <linux-rdma@vger.kernel.org>; Fri, 03 May 2019 08:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LtrVNx5gMZ+7b2l4xpx5McHYMP9SZnq/rES5fTsM0cU=;
        b=n4o9UZnSMxH/dXiIXSJzERhRQC/hoP7CTbKDI7ydjh9IDga7UHKl/zoX+Yqx91CqUq
         ETQMsQ3dABrKkj9UmA61U2eFHWR5o4UF8FLPHgfnqEHrAKmo2TJeUAgg9O0QuDhrGAaY
         udBy4KITwcZKfPsvab76ZRpZF7H8ce0jp3eS9pGoMziVs8rcr2OHslrT9BcbFd12FqAy
         AXkvP1CDfsUyh1m+XfT9VtJU2hNcYL+OBd5g7PhsRb3e1NekC7GablQ5T+x+SZtUSZ0T
         aKcjAdXuU1XCYDLI6Fa1nKIi2U6aDHzboAb7Zyj7sbk+dDzsoV6rTA03+qKM25x7rjvn
         oChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LtrVNx5gMZ+7b2l4xpx5McHYMP9SZnq/rES5fTsM0cU=;
        b=FWUlEZ7RRs1wzHNid+v5Yy43OQNyUM9iQO2g4PzquGFCFYP7WLRiu928nW+5RauHdO
         oN42jvnpYLDLJd6OYL2Bsvd5O++xUe1W/mc85k7pRCrJ5cZtJOcpfN5cnGzCbJOySMZz
         Q9tW8EGQ2Uj8PqqCybiBd4kRSkQxuqFw3vcse+r2KRVFnrCMJmhrhtAVCdOCzcwKpzs/
         jiIAGkF5oBnO3z8QuzUEz3YtoHOIpWUf48aIMM9tTsBJkOmHFkTkFlT/5H4LcRT+FeHx
         IuoYzM1rhbg/etFnZf87O0QO9vc19pyevbGBABX1Z69uA09UszIoA+9mJ5pUvNjeZQI2
         uOMw==
X-Gm-Message-State: APjAAAWxUShTlDH5Oylx/cYRp4g9pGwAL/7rF68mRb3Rbs1i3yf7Lud0
        mMPgaWAqqx/j3DelMV8HjJ1iQQ==
X-Google-Smtp-Source: APXvYqzmeqOsZYiteqwLXaz0wYI2O/sFzfVZlxz42N5DMVQmjueTzP5YA12m2tz1iv4P6caQQWYV7g==
X-Received: by 2002:a25:428e:: with SMTP id p136mr8230110yba.321.1556897318057;
        Fri, 03 May 2019 08:28:38 -0700 (PDT)
Received: from ziepe.ca (65-23-217-40.prtc.net. [65.23.217.40])
        by smtp.gmail.com with ESMTPSA id h184sm640596ywb.59.2019.05.03.08.28.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 08:28:36 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hMa71-0008V2-6h; Fri, 03 May 2019 12:28:35 -0300
Date:   Fri, 3 May 2019 12:28:35 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>
Cc:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Gal Pressman <galpress@amazon.com>
Subject: Re: [PATCH v2 rdma-next 1/5] RDMA/umem: Add API to find best driver
 supported page size in an MR
Message-ID: <20190503152835.GB31165@ziepe.ca>
References: <20190419134353.12684-1-shiraz.saleem@intel.com>
 <20190419134353.12684-2-shiraz.saleem@intel.com>
 <20190425142559.GA5388@ziepe.ca>
 <9DD61F30A802C4429A01CA4200E302A7A5AC3A8C@fmsmsx124.amr.corp.intel.com>
 <20190430180503.GB8101@ziepe.ca>
 <9DD61F30A802C4429A01CA4200E302A7A5ACCB03@fmsmsx124.amr.corp.intel.com>
 <20190430210011.GA9059@ziepe.ca>
 <9DD61F30A802C4429A01CA4200E302A7A5AD1514@fmsmsx124.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9DD61F30A802C4429A01CA4200E302A7A5AD1514@fmsmsx124.amr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 03, 2019 at 03:22:59PM +0000, Saleem, Shiraz wrote:
> >This is because mask shouldn't start as zero - the highest possible mask is
> >something like log2_ru(umem length)
> >
> >ie absent other considerations the page size at the NIC should be the size of the
> >umem.
> >
> >Then we scan the sgl and reduce that value based on the physical address
> >layout
> >
> >Then we reduce it again based on the uvirt vs address difference
> >
> >Oring a '0' into the mask means that step contributes no restriction.
> >
> >..
> >
> >So I think the algorithm is just off as is, it should be more like
> >
> > // Page size can't be larger than the length of the MR mask = log2_ru(umem
> >length);
> >
> > // offset into the first SGL for umem->addr pgoff = umem->address &
> >PAGE_MASK;  va = uvirt_addr;
> >
> 
> Did you mean pgoff = umem->address & ~PAGE_MASK?

Yes...

But really even that is not what it should be, the 'pgoff' should
simply be the 'offset' member of the first sgl and we should set it
correctly based on the umem->address when building the sgl in the core code.

Jason
