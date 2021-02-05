Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15ED310DA8
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Feb 2021 17:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbhBEOcM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Feb 2021 09:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbhBEO3k (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Feb 2021 09:29:40 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A947C0617A9
        for <linux-rdma@vger.kernel.org>; Fri,  5 Feb 2021 08:07:44 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id t8so8328124ljk.10
        for <linux-rdma@vger.kernel.org>; Fri, 05 Feb 2021 08:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=33iEg0Lzg2Scz+ykUwbjbp3zOqxp5drs4CJ+cvBOqgU=;
        b=hVpQoCeLL3cUg4rnqfXztHEfkItcdom7HyQiIPiofzBFBzwrrzBs+0NZeMWjqfKfF/
         0ZczgPrEqUjX3q4+iMKmi0AAFJAU1H7y+/Uhc5JNeF4Iw2cxVuaoBO/aWwBr2hA8iuzN
         vrU74JhDuZMXJZTtSW+qbqsC0y/4F5ICD3+MA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=33iEg0Lzg2Scz+ykUwbjbp3zOqxp5drs4CJ+cvBOqgU=;
        b=ir+xM1rgeUUJSul2yHjdH6e4jg1O0S7Ajwvf7Rx6QKB2jWSyjN//kBAruxDX4IE721
         0ZlDY6P/cBjco6nCR+3uGIKTlR5kdMx9kgJllx/6UZn++Thy+KmaQL2R74y2mziUoeGh
         m6VHPbR6Y/RVvMRfMIRPtIljQ3HQOkY30Hof/HNIzevvFI87BTv6H7IW/svX8UNdcVhU
         bRIkLgFCsg49ctbRM3r+xHXtKA4gG8+k2n3CuRFpdX+gef1nK6UvQbm6hA4J3AbsX6BM
         7FKdocZh6yAZf+O6nZBXwlKmBg3xTj7uXHW1fRLhXPgZ4iGHxD0cZqI0BVA6lQ0YAFtd
         vzfg==
X-Gm-Message-State: AOAM53305wYIPAsaNiIrwnDz9LTyH78pffDOIBM1BuTkvX3NDyvSzt4g
        vmLQ+gf/8Tjook1OibrPnIJCg80XFfQh9gyF
X-Google-Smtp-Source: ABdhPJySzTyhnQ1ckfeV9CnQVBMBiqqfk1ZpMohKuWGas+Al69+ZycglOALtd8ry33SSwp4Ppt2mFA==
X-Received: by 2002:a05:6000:1543:: with SMTP id 3mr5759016wry.254.1612539589783;
        Fri, 05 Feb 2021 07:39:49 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id o83sm3476354wme.37.2021.02.05.07.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 07:39:48 -0800 (PST)
Date:   Fri, 5 Feb 2021 16:39:47 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Doug Ledford <dledford@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Jianxin Xiong <jianxin.xiong@intel.com>
Subject: Re: [PATCH v16 0/4] RDMA: Add dma-buf support
Message-ID: <YB1mw/uYwueFwUdh@phenom.ffwll.local>
References: <1608067636-98073-1-git-send-email-jianxin.xiong@intel.com>
 <5e4ac17d-1654-9abc-9a14-bda223d62866@nvidia.com>
 <CADnq5_M2YuOv16E2DG6sCPtL=z5SDDrN+y7iwD_pHVc7Omyrmw@mail.gmail.com>
 <20210204182923.GL4247@nvidia.com>
 <CADnq5_N9QvgAKQMLeutA7oBo5W5XyttvNOMK_siOc6QL+H07jQ@mail.gmail.com>
 <8e731fce-95c1-4ace-d8bc-dc0df7432d22@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e731fce-95c1-4ace-d8bc-dc0df7432d22@nvidia.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 04, 2021 at 11:00:32AM -0800, John Hubbard wrote:
> On 2/4/21 10:44 AM, Alex Deucher wrote:
> ...
> > > > The argument is that vram is a scarce resource, but I don't know if
> > > > that is really the case these days.  At this point, we often have as
> > > > much vram as system ram if not more.
> > > 
> > > I thought the main argument was that GPU memory could move at any time
> > > between the GPU and CPU and the DMA buf would always track its current
> > > location?
> > 
> > I think the reason for that is that VRAM is scarce so we have to be
> > able to move it around.  We don't enforce the same limitations for
> > buffers in system memory.  We could just support pinning dma-bufs in
> > vram like we do with system ram.  Maybe with some conditions, e.g.,
> > p2p is possible, and the device has a large BAR so you aren't tying up
> > the BAR window.

Minimally we need cgroups for that vram, so it can be managed. Which is a
bit stuck unfortunately. But if we have cgroups with some pin limit, I
think we can easily lift this.

> Excellent. And yes, we are already building systems in which VRAM is
> definitely not scarce, but on the other hand, those newer systems can
> also handle GPU (and NIC) page faults, so not really an issue. For that,
> we just need to enhance HMM so that it does peer to peer.
> 
> We also have some older hardware with large BAR1 apertures, specifically
> for this sort of thing.
> 
> And again, for slightly older hardware, without pinning to VRAM there is
> no way to use this solution here for peer-to-peer. So I'm glad to see that
> so far you're not ruling out the pinning option.

Since HMM and ZONE_DEVICE came up, I'm kinda tempted to make ZONE_DEVICE
ZONE_MOVEABLE (at least if you don't have a pinned vram contigent in your
cgroups) or something like that, so we could benefit from the work to make
sure pin_user_pages and all these never end up in there?

https://lwn.net/Articles/843326/

Kind inspired by the recent lwn article.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
