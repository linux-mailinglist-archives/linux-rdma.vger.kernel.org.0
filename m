Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36E6428170
	for <lists+linux-rdma@lfdr.de>; Thu, 23 May 2019 17:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730961AbfEWPlv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 May 2019 11:41:51 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41453 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730951AbfEWPlv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 May 2019 11:41:51 -0400
Received: by mail-qt1-f193.google.com with SMTP id y22so7249033qtn.8
        for <linux-rdma@vger.kernel.org>; Thu, 23 May 2019 08:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0TsHr4jNVrFLZQLBUCR+FrMQge3L+UP+h42ztox37hc=;
        b=lFyCpp4To4CeKZoF5gLn2kPrtZIAdF5TSSMV1WQY6giKDSOKYm5rgMAFDOtpmliUiu
         cCximb+BLdj7cICGvLdBf1flJHBp6CpoBiQOuwBUaxdviSxaMZXQ9e/0yyTBn9zqGApV
         J0AVKUNUEHJo3mxyGej6O5dQBXszIg17+BPM3pbBBFko/pdfYKerg86ew5Us0oU7Z8l4
         nfx7I+Qk6qj2AXE+02nseMM2D11o9O6Bk6QmkeLzmNuDhwewsAhycJnBySXRPp7qiDcn
         AAdhbfk7CFjyU+4GUIxZAs2MMw10A04GGlWRStBk9yYmpkt3Jn7Xld+WJd/DKrRU3IeA
         XZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0TsHr4jNVrFLZQLBUCR+FrMQge3L+UP+h42ztox37hc=;
        b=Y+Lmz67C5PRDn8C6vALOyp+Hbbx9xzXOMDfy3hGRRN+jPupmg6LKsqAfmeNQoQGJ4e
         E0iIufDL1V6Gg1QCVaPdBVJWPrhWck1eOZxo+1LedeygwTFT1qXmzV1ABDMYRV0WF/dS
         cNbDPdwTK/Ft1/gqi42r8QG+vgIMpsNL64cNEvnxxfnos91Whw9Aioy4Rwwp5cMdshG/
         IGI7PYgvaKOXgZkuav4voiIAV511J/GSpPypT8LxVHJZknniiyGteBKXT0UcVOwDPsAo
         jW9cG81rCDPI8zLcK6bKqLHNAtRkltFb4TMfAoJXWJJuAo8+DeY0KqHNH7BET3dzvvSf
         WuLQ==
X-Gm-Message-State: APjAAAUfXTiCHTgMkn0EM1dpSAP7+Ho6RWtj5ikv2xZBw3/4G7iF3kpm
        fo9ORbmquKeg3yfPBFppxDU00g==
X-Google-Smtp-Source: APXvYqyhhx8yoS7UXUXf4CfVaj6FrbAXNdjYL4HcvOy5AsnwYSpvcWyzddKtuWjjfNgAUoyiFzRfrg==
X-Received: by 2002:ac8:34b7:: with SMTP id w52mr80878196qtb.11.1558626110443;
        Thu, 23 May 2019 08:41:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id x30sm17904824qtx.35.2019.05.23.08.41.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 08:41:49 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hTpqn-00053x-Hl; Thu, 23 May 2019 12:41:49 -0300
Date:   Thu, 23 May 2019 12:41:49 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>
Subject: Re: [PATCH v4 0/1] Use HMM for ODP v4
Message-ID: <20190523154149.GB12159@ziepe.ca>
References: <20190411181314.19465-1-jglisse@redhat.com>
 <20190506195657.GA30261@ziepe.ca>
 <20190521205321.GC3331@redhat.com>
 <20190522005225.GA30819@ziepe.ca>
 <20190522174852.GA23038@redhat.com>
 <20190522235737.GD15389@ziepe.ca>
 <20190523150432.GA5104@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523150432.GA5104@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 23, 2019 at 11:04:32AM -0400, Jerome Glisse wrote:
> On Wed, May 22, 2019 at 08:57:37PM -0300, Jason Gunthorpe wrote:
> > On Wed, May 22, 2019 at 01:48:52PM -0400, Jerome Glisse wrote:
> > 
> > > > > So attached is a rebase on top of 5.2-rc1, i have tested with pingpong
> > > > > (prefetch and not and different sizes). Seems to work ok.
> > > > 
> > > > Urk, it already doesn't apply to the rdma tree :(
> > > > 
> > > > The conflicts are a little more extensive than I'd prefer to handle..
> > > > Can I ask you to rebase it on top of this branch please:
> > > > 
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/log/?h=wip/jgg-for-next
> > > > 
> > > > Specifically it conflicts with this patch:
> > > > 
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/commit/?h=wip/jgg-for-next&id=d2183c6f1958e6b6dfdde279f4cee04280710e34
> > 
> > There is at least one more serious blocker here:
> > 
> > config ARCH_HAS_HMM_MIRROR
> >         bool
> >         default y
> >         depends on (X86_64 || PPC64)
> >         depends on MMU && 64BIT
> > 
> > I can't loose ARM64 support for ODP by merging this, that is too
> > serious of a regression.
> > 
> > Can you fix it?
> 
> 5.2 already has patch to fix the Kconfig (ARCH_HAS_HMM_MIRROR and
> ARCH_HAS_HMM_DEVICE replacing ARCH_HAS_HMM) I need to update nouveau

Newer than 5.2-rc1? Is this why ARCH_HAS_HMM_MIRROR is not used anywhere?

> in 5.3 so that i can drop the old ARCH_HAS_HMM and then convert
> core mm in 5.4 to use ARCH_HAS_HMM_MIRROR and ARCH_HAS_HMM_DEVICE
> instead of ARCH_HAS_HMM

My problem is that ODP needs HMM_MIRROR which needs HMM & ARCH_HAS_HMM
- and then even if fixed we still have the ARCH_HAS_HMM_MIRROR
restricted to ARM64..

Can we broaden HMM_MIRROR to all arches? I would very much prefer
that.

> So it seems it will have to wait 5.4 for ODP. I will re-spin the
> patch for ODP once i am done reviewing Ralph changes and yours
> for 5.3.

I think we are still OK for 5.3.

If mm takes the fixup patches so hmm mirror is as reliable as ODP's
existing stuff, and patch from you to enable ARM64, then we can
continue to merge into 5.3

So, let us try to get acks on those other threads..

Jason
