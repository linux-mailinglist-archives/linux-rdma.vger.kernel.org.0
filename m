Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0899B283C1
	for <lists+linux-rdma@lfdr.de>; Thu, 23 May 2019 18:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730987AbfEWQec (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 May 2019 12:34:32 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38340 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730867AbfEWQeb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 May 2019 12:34:31 -0400
Received: by mail-qt1-f196.google.com with SMTP id l3so7486049qtj.5
        for <linux-rdma@vger.kernel.org>; Thu, 23 May 2019 09:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F1YBHT3496svrxz+EkatQOzrROHl8f06iX70UV39xd8=;
        b=HldtNd9DThCXABUokXssytt+812XdJeJivvnSsHqGM+j4bUvIvlV09bjjFwKa16++I
         On9uV6QYyvZunXFC03CsY+SLzNeYgTgrJOctFXSGTHgDaLoQ9V1R4xLeEw/QiYp/KWFb
         PDa07LQSEJaPSSa6yVorRs4qfI8XtuVZxkb2pamApt6eKUdFfW3zF5p7W0S3n4g8TN+q
         fHSkGsmd4Fe8LrJrOrUN7ArzG9BBD2yuq0r4NtuOfGd7Kq5PapeuB2wkGRs1K9PiVwk4
         dPIxd1t1ZdynIrcnf/aDpZ9rDSYvCwiEUki3zmA+hVr8mi2p2Fdto2QvQ9h8jD0X6PBD
         dfAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F1YBHT3496svrxz+EkatQOzrROHl8f06iX70UV39xd8=;
        b=JnQuQHJVyof22AbS6pZNcsoSjJWxW2T6L7CKa8PwF70mLlPcqC1GNiLKlhx/Z2kMPz
         YRlpJ8eB5aDmgcCXvzkY6OsFZmyquYq8ioNcLMvf0osoR86Ij9gk7ZL8ps2GOHx1BNOY
         5ShZDhxSaVDiPABb1Q2FvEe0DTSC+b9yw8W3LCi9rNjrp11SZMOgnGTNLNBHb1nmJwxd
         w5Aal0rWlu1gD+lG6lEEXJP3M8qRkoIAxTFtcR3ZXNQ6hIIAURO/gzH7j0WGPaj1l+wF
         xMK3Mb0ocoRj0a/c5KWe2ZJ6OaXP7jIZOxLcy4LNklZbKksHS2DenDPM32HoGqgiAmH8
         Xsug==
X-Gm-Message-State: APjAAAXwBkt4sIkSXeC+Fsc83n7iZLYqBiW1YN0MbLiIjfux+7hS69oO
        dSNaPMoUqT0YVROWgCEtjarcEg==
X-Google-Smtp-Source: APXvYqwwASbT06slnQZ2dSsUZFCR8e09enADDDiYvAH6zm8DNI7x0isJ5vaxAb7mVHA/78N1kIP3zQ==
X-Received: by 2002:a0c:e64f:: with SMTP id c15mr72350005qvn.239.1558629270823;
        Thu, 23 May 2019 09:34:30 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id f10sm7973934qkh.23.2019.05.23.09.34.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 09:34:30 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hTqfl-0005Lw-OR; Thu, 23 May 2019 13:34:29 -0300
Date:   Thu, 23 May 2019 13:34:29 -0300
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
Message-ID: <20190523163429.GC12159@ziepe.ca>
References: <20190411181314.19465-1-jglisse@redhat.com>
 <20190506195657.GA30261@ziepe.ca>
 <20190521205321.GC3331@redhat.com>
 <20190522005225.GA30819@ziepe.ca>
 <20190522174852.GA23038@redhat.com>
 <20190522235737.GD15389@ziepe.ca>
 <20190523150432.GA5104@redhat.com>
 <20190523154149.GB12159@ziepe.ca>
 <20190523155207.GC5104@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523155207.GC5104@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 23, 2019 at 11:52:08AM -0400, Jerome Glisse wrote:
> On Thu, May 23, 2019 at 12:41:49PM -0300, Jason Gunthorpe wrote:
> > On Thu, May 23, 2019 at 11:04:32AM -0400, Jerome Glisse wrote:
> > > On Wed, May 22, 2019 at 08:57:37PM -0300, Jason Gunthorpe wrote:
> > > > On Wed, May 22, 2019 at 01:48:52PM -0400, Jerome Glisse wrote:
> > > > 
> > > > > > > So attached is a rebase on top of 5.2-rc1, i have tested with pingpong
> > > > > > > (prefetch and not and different sizes). Seems to work ok.
> > > > > > 
> > > > > > Urk, it already doesn't apply to the rdma tree :(
> > > > > > 
> > > > > > The conflicts are a little more extensive than I'd prefer to handle..
> > > > > > Can I ask you to rebase it on top of this branch please:
> > > > > > 
> > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/log/?h=wip/jgg-for-next
> > > > > > 
> > > > > > Specifically it conflicts with this patch:
> > > > > > 
> > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/commit/?h=wip/jgg-for-next&id=d2183c6f1958e6b6dfdde279f4cee04280710e34
> > > > 
> > > > There is at least one more serious blocker here:
> > > > 
> > > > config ARCH_HAS_HMM_MIRROR
> > > >         bool
> > > >         default y
> > > >         depends on (X86_64 || PPC64)
> > > >         depends on MMU && 64BIT
> > > > 
> > > > I can't loose ARM64 support for ODP by merging this, that is too
> > > > serious of a regression.
> > > > 
> > > > Can you fix it?
> > > 
> > > 5.2 already has patch to fix the Kconfig (ARCH_HAS_HMM_MIRROR and
> > > ARCH_HAS_HMM_DEVICE replacing ARCH_HAS_HMM) I need to update nouveau
> > 
> > Newer than 5.2-rc1? Is this why ARCH_HAS_HMM_MIRROR is not used anywhere?
> 
> Yes this is multi-step update, first add the new Kconfig release n,
> update driver in release n+1, update core Kconfig in release n+2
> 
> So we are in release n (5.2), in 5.3 i will update nouveau and amdgpu
> so that in 5.4 in ca remove the old ARCH_HAS_HMM

Why don't you just send the patch for both parts to mm or to DRM?

This is very normal - as long as the resulting conflicts would be
small during there is no reason not to do this. Can you share the
combined patch?

> > If mm takes the fixup patches so hmm mirror is as reliable as ODP's
> > existing stuff, and patch from you to enable ARM64, then we can
> > continue to merge into 5.3
> > 
> > So, let us try to get acks on those other threads..
> 
> I will be merging your patchset and Ralph and repost, they are only
> minor change mostly that you can not update the driver API in just
> one release.

Of course you can, we do it all the time. It requires some
co-ordination, but as long as the merge conflicts are not big it is
fine.

Merge the driver API change and the call site updates to -mm and
refain from merging horrendously conflicting patches through DRM.

In the case of the changes in my HMM RFC it is something like 2
lines in DRM that need touching, no problem at all.

If you want help I can volunteer make a hmm PR for Linus just for this
during the merge window - but Andrew would need to agree and ack the
patches.

Jason
