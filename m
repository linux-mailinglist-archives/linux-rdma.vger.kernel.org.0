Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB3373F69E0
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Aug 2021 21:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbhHXTbj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Aug 2021 15:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234360AbhHXTbj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Aug 2021 15:31:39 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD209C061764
        for <linux-rdma@vger.kernel.org>; Tue, 24 Aug 2021 12:30:54 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id r21so17756059qtw.11
        for <linux-rdma@vger.kernel.org>; Tue, 24 Aug 2021 12:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nISK/DnSMLsPKL33eQfrjbTBgFhp/AOhrSTXl8tgvVY=;
        b=BBZ/DdRgt5H9lez5WzLUWLJI8CSm49bjqG/ijHPqdU//5r21+B/V9LDmau1ile99vj
         ihXEXykNbCWxBdSt1o+/OBIH3V6JByVsYZzFSIvZZA9pAuP1aGsZD1dx/JOQtpO2F070
         xkmZBbOZYa2jF9TmJTfo46ih/34THHx3HNpZ200z1wfuD2NUWKDUtHpXhSoZiVJ79CK4
         WIqvRnCwVSMZ5qqvSTkaScBbjOjAUluNvFDFs3ao3V2i0DYaiCk5S344s1rEeQWfzGoH
         0kL2BPZBmWJzrZdjhRM7ZGEbilknKYgR2dlZRPL8wNh4i3BfXwj7Z6qyQkxhunknYZvn
         2hdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nISK/DnSMLsPKL33eQfrjbTBgFhp/AOhrSTXl8tgvVY=;
        b=MvpPoDf10lLzMoK6IuyU6yCfflYkXAzqCqAPMvb3gtgAUKcl3CR+xRI/oP/HuOKxYD
         OrCYkmb8Ac5SR9nVpLfWnRYYsL/prByJBLU467tPx8/hcvYAe+0u2qWg/nmXBDGIcjbr
         yKLHpjskusP0+rK748izFslOVZlZW69C3S/g6sY9MMuTzY+JPQUfMUFVGUfqjzNAfayv
         leNz5UAigY86XfzLARoAK01W3CkVRwkTf1h3VQPApdgrcfmgNb6zi/SVj9KXHmYCvIKb
         0sTrZcJkYv2fbhGpNcwQs9VZn9CPs3uBm6hWig5b/2KHB+BmPNLIquQVaRdUPJoF3JSS
         r1jg==
X-Gm-Message-State: AOAM531FSvGKvsY8gPoBh+PZYW5c6e3EcNaHl8rrY8jMJHBiB/LKrULZ
        sayQd6cBvuKeOaadRK7C8xiNew==
X-Google-Smtp-Source: ABdhPJxXjfrAKQzkOvCMB0CeoOhrejCp5dMuDkaR5tjrmjOC+w0vSyChN42xlzQjduZni77z8K57jg==
X-Received: by 2002:ac8:dc9:: with SMTP id t9mr35660938qti.293.1629833453961;
        Tue, 24 Aug 2021 12:30:53 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id q22sm6382139qtr.95.2021.08.24.12.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 12:30:53 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mIc8K-004ZMK-M2; Tue, 24 Aug 2021 16:30:52 -0300
Date:   Tue, 24 Aug 2021 16:30:52 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dave Airlie <airlied@gmail.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Gal Pressman <galpress@amazon.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Doug Ledford <dledford@redhat.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Oded Gabbay <ogabbay@habana.ai>,
        Tomer Tayar <ttayar@habana.ai>,
        Yossi Leybovich <sleybo@amazon.com>,
        Alexander Matushevsky <matua@amazon.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jianxin Xiong <jianxin.xiong@intel.com>
Subject: Re: [RFC] Make use of non-dynamic dmabuf in RDMA
Message-ID: <20210824193052.GF543798@ziepe.ca>
References: <0fc94ac0-2bb9-4835-62b8-ea14f85fe512@amazon.com>
 <20210820143248.GX543798@ziepe.ca>
 <da6364b7-9621-a384-23b0-9aa88ae232e5@amazon.com>
 <fa124990-ee0c-7401-019e-08109e338042@amd.com>
 <e2c47256-de89-7eaa-e5c2-5b96efcec834@amazon.com>
 <6b819064-feda-b70b-ea69-eb0a4fca6c0c@amd.com>
 <a9604a39-d08f-6263-4c5b-a2bc9a70583d@nvidia.com>
 <20210824173228.GE543798@ziepe.ca>
 <1d1bd2d0-f467-4808-632b-1cca1174cfd9@nvidia.com>
 <CAPM=9txd71fisvZ1Es5Fv2mwR2vWfHJarya7oeKOm2aq6tH0HQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPM=9txd71fisvZ1Es5Fv2mwR2vWfHJarya7oeKOm2aq6tH0HQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 25, 2021 at 05:15:52AM +1000, Dave Airlie wrote:
> On Wed, 25 Aug 2021 at 03:36, John Hubbard <jhubbard@nvidia.com> wrote:
> >
> > On 8/24/21 10:32 AM, Jason Gunthorpe wrote:
> > ...
> > >>> And yes at least for the amdgpu driver we migrate the memory to host
> > >>> memory as soon as it is pinned and I would expect that other GPU drivers
> > >>> do something similar.
> > >>
> > >> Well...for many topologies, migrating to host memory will result in a
> > >> dramatically slower p2p setup. For that reason, some GPU drivers may
> > >> want to allow pinning of video memory in some situations.
> > >>
> > >> Ideally, you've got modern ODP devices and you don't even need to pin.
> > >> But if not, and you still hope to do high performance p2p between a GPU
> > >> and a non-ODP Infiniband device, then you would need to leave the pinned
> > >> memory in vidmem.
> > >>
> > >> So I think we don't want to rule out that behavior, right? Or is the
> > >> thinking more like, "you're lucky that this old non-ODP setup works at
> > >> all, and we'll make it work by routing through host/cpu memory, but it
> > >> will be slow"?
> > >
> > > I think it depends on the user, if the user creates memory which is
> > > permanently located on the GPU then it should be pinnable in this way
> > > without force migration. But if the memory is inherently migratable
> > > then it just cannot be pinned in the GPU at all as we can't
> > > indefinately block migration from happening eg if the CPU touches it
> > > later or something.
> > >
> >
> > OK. I just want to avoid creating any API-level assumptions that dma_buf_pin()
> > necessarily implies or requires migrating to host memory.
> 
> I'm not sure we should be allowing dma_buf_pin at all on
> non-migratable memory, what's to stop someone just pinning all the
> VRAM and making the GPU unuseable?

IMHO the same thinking that prevents pining all of system ram and
making the system unusable? GPU isn't so special here. The main
restriction is the pinned memory ulimit. For most out-of-the-box cases
this is set to something like 64k

For the single-user HPC use cases it is made unlimited.

> My impression from this is we've designed hardware that didn't
> consider the problem, and now to let us use that hardware in horrible
> ways we should just allow it to pin all the things.

It is more complex than that, HW that can support dynamic memory under
*everything* is complicated (and in some cases slow!). As there is
only a weak rational to do this, we don't see it in often in the
market.

Jason
