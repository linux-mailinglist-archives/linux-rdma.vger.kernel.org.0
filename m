Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C526D2C8A08
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Nov 2020 17:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgK3Q4W (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Nov 2020 11:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728924AbgK3Q4W (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Nov 2020 11:56:22 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA39C0613CF
        for <linux-rdma@vger.kernel.org>; Mon, 30 Nov 2020 08:55:41 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id a6so5636109wmc.2
        for <linux-rdma@vger.kernel.org>; Mon, 30 Nov 2020 08:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sdakq9XhpJ+KrmP4fx7Gl71XIguvQHaFIVLLDLyf8Cw=;
        b=D7Tedd+/Optb8nLNAPKq+zL98736O+zvVf8Mm2ibr2JXit50xF6OTY1CjVOmB8ZCfW
         p9XEAoQx8LQ/u5/tFXQ+5OirEaaREDxDgXGbzbM1/ncW+2kzqH0xofoysA/AThIRmKci
         GqysJYaJWkUcmz/EWeZH+zEz5+18/TsAP3Zyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sdakq9XhpJ+KrmP4fx7Gl71XIguvQHaFIVLLDLyf8Cw=;
        b=N0zDwPpoEe+Ix5aaOC0nlVppPtmdHvw6Ii3+4xim2I8ugNLNnEtpX3LbOYx82tAbGT
         2NkdE+61QVP68RVHwhzt8TTXMK3y1Mh8Cklzwrz8kG2TYuMIHhNmJtgVmbUr7k+mtzC2
         4bgp7pDErnbocQ98ICBH74Gs5U7EL30nPtK+rVDGJdx8CPA5iavGV64gyNX1WqY99C2k
         hSTMmxkl3c+3qTkPbXrS+wRAHcIzHeN/jn62mzW0BCWlmOkAvutSC1cM5hE5elJUv6ko
         IrLD+cNFVeD7mWqepK7mK6/eQ5EwaSPt3QfMj/1SptvYEeOe9NGxgbHFzgdIdHOGI1wd
         XRUA==
X-Gm-Message-State: AOAM533uDQ8KrYxg1VEpJi6kQmHgXlPxk0TLF96txXs/+DwIDwk/6Ev9
        8gL6HfehDBB5E2CSXD1yoiuSiw==
X-Google-Smtp-Source: ABdhPJwWxaLNesXJvW7im41SZbH7ex71A7ZkUqVIqznJ9lzsvuUs9EstlepkcMbmFh0h/f5MLeOycw==
X-Received: by 2002:a05:600c:229a:: with SMTP id 26mr24696901wmf.100.1606755338827;
        Mon, 30 Nov 2020 08:55:38 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id k64sm24529970wmb.11.2020.11.30.08.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 08:55:38 -0800 (PST)
Date:   Mon, 30 Nov 2020 17:55:35 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Jianxin Xiong <jianxin.xiong@intel.com>,
        linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Christian Koenig <christian.koenig@amd.com>
Subject: Re: [PATCH rdma-core v3 4/6] pyverbs: Add dma-buf based MR support
Message-ID: <20201130165535.GW401619@phenom.ffwll.local>
References: <1606510543-45567-1-git-send-email-jianxin.xiong@intel.com>
 <1606510543-45567-5-git-send-email-jianxin.xiong@intel.com>
 <20201130145741.GP401619@phenom.ffwll.local>
 <20201130155544.GA5487@ziepe.ca>
 <20201130160443.GV401619@phenom.ffwll.local>
 <20201130163642.GC5487@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130163642.GC5487@ziepe.ca>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 30, 2020 at 12:36:42PM -0400, Jason Gunthorpe wrote:
> On Mon, Nov 30, 2020 at 05:04:43PM +0100, Daniel Vetter wrote:
> > On Mon, Nov 30, 2020 at 11:55:44AM -0400, Jason Gunthorpe wrote:
> > > On Mon, Nov 30, 2020 at 03:57:41PM +0100, Daniel Vetter wrote:
> > > > > +	err = ioctl(dri->fd, DRM_IOCTL_AMDGPU_GEM_CREATE, &gem_create);
> > > > > +	if (err)
> > > > > +		return err;
> > > > > +
> > > > > +	*handle = gem_create.out.handle;
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +static int radeon_alloc(struct dri *dri, size_t size, uint32_t *handle)
> > > > 
> > > > Tbh radeon chips are old enough I wouldn't care. Also doesn't support p2p
> > > > dma-buf, so always going to be in system memory when you share. Plus you
> > > > also need some more flags like I suggested above I think.
> > > 
> > > What about nouveau?
> > 
> > Reallistically chances that someone wants to use rdma together with the
> > upstream nouveau driver are roughly nil. Imo also needs someone with the
> > right hardware to make sure it works (since the flags are all kinda arcane
> > driver specific stuff testing is really needed).
> 
> Well, it would be helpful if we can test the mlx5 part of the
> implementation, and I have a lab stocked with nouveau compatible HW..
> 
> But you are right someone needs to test/etc, so this does not seem
> like Jianxin should worry

Ah yes sounds good. I can help with trying to find how to allocate vram
with nouveau if you don't find it. Caveat is that nouveau doesn't do
dynamic dma-buf exports and hence none of the intersting flows and also
not p2p. Not sure how much work it would be to roll that out (iirc it
wasnt that much amdgpu code really, just endless discussions on the
interface semantics and how to roll it out without breaking any of the
existing dma-buf users).

Another thing that just crossed my mind: Do we have a testcase for forcing
the eviction? Should be fairly easy to provoke with something like this:

- register vram-only buffer with mlx5 and do something that binds it
- allocate enough vram-only buffers to overfill vram (again figuring out
  how much vram you have is driver specific)
- touch each buffer with mmap. that should force the mlx5 buffer out. it
  might be that eviction isn't lru but preferentially idle buffers (i.e.
  not used by hw, so anything register to mlx5 won't qualify as first
  victims). so we might need to instead register a ton of buffers with
  mlx5 and access them through ibverbs
- do something with mlx5 again to force the rebinding and test it all
  keeps working

That entire invalidate/buffer move flow is the most complex interaction I
think.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
