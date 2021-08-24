Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB363F6879
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Aug 2021 19:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239546AbhHXR5y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Aug 2021 13:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235064AbhHXR5s (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Aug 2021 13:57:48 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7843AC02B905
        for <linux-rdma@vger.kernel.org>; Tue, 24 Aug 2021 10:32:31 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id a5so4045955qvq.0
        for <linux-rdma@vger.kernel.org>; Tue, 24 Aug 2021 10:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lwC1/qqMXCHkSEuX0aG71XmLnSxkAQ0/tMDOcg4Aies=;
        b=KjMF1lA4YayhkMA/+onna2RUZsN7mjQYxMOcX2gD+57MQisyXwxt6Oi053+GIgqrkX
         wkN4XahJSetG45Hq/xYogC9dQnfLRCPsyHSD6Q7tpElYbipZG4FkwyJuWVih3LEz06oM
         +KHM4YBcae8DcATClLFJCnIgSzugnAHylazYJXvwdV+UitfGYHbYhLMgFpbtiVjDQ/hZ
         6FpUoL9d2o+MQCSNfZoI0mMyluhTbm9YMZ+emKes/bQHe0tESliqVviSsh1yLLwb/OtF
         O+Qael98lhH1hoeAIJlJwHnICFbEg0iI1liC8rgXZzX6OwslIY1ztRDfgZkeDvmxsRFp
         KsEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lwC1/qqMXCHkSEuX0aG71XmLnSxkAQ0/tMDOcg4Aies=;
        b=NyNGGmEYPMGpf3zhhRy5GqITiYCOd2mRGkF3TTgbynzEwVVFTJHjVQAwwqWTCnLF+C
         AUq/QPcNsdopzIGUgPtlNbMeI5Dy72zACeW088E0Jyk9v7pfPeAKUmiemGogw3H9Ol5a
         KmP8oiUKqKw/i7OwnBKTN7mw6dHEVm9BS7pKI+Ndln+vw1E6Gq0K271hgwOn2TevrMBI
         RHpfiujCXCNrtgmY292MHvn30psuTuwsEkKHzpeVklXVm4gRoknVdUBaW+qbe0ElpNAR
         2PKYgyEs6AcKf3e6vgkTn7ic6tXefP0Q2IS17ZwIO7PTyzUzGbCwv4lH+AhgSsTQFEss
         /Xdg==
X-Gm-Message-State: AOAM531fmMcrifUdXKQnLJ4+Rl9B4j7wzhUjo9MeViT3UWO4XUoPISRV
        fw+mATuqFtN1sz/qoZeQwMgE3A==
X-Google-Smtp-Source: ABdhPJwJ+2u+qDYC4MSLYpqJCPTaTMcY6ziqO6lM9p9+dgrNw/00zITDynb3bfoU+1EwIclnIvZtfQ==
X-Received: by 2002:a05:6214:1787:: with SMTP id ct7mr40068660qvb.53.1629826350573;
        Tue, 24 Aug 2021 10:32:30 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id m68sm9660473qkb.105.2021.08.24.10.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 10:32:29 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mIaHk-004XHB-QJ; Tue, 24 Aug 2021 14:32:28 -0300
Date:   Tue, 24 Aug 2021 14:32:28 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
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
Message-ID: <20210824173228.GE543798@ziepe.ca>
References: <20210819230602.GU543798@ziepe.ca>
 <CAKMK7uGgQWcs4Va6TGN9akHSSkmTs1i0Kx+6WpeiXWhJKpasLA@mail.gmail.com>
 <20210820123316.GV543798@ziepe.ca>
 <0fc94ac0-2bb9-4835-62b8-ea14f85fe512@amazon.com>
 <20210820143248.GX543798@ziepe.ca>
 <da6364b7-9621-a384-23b0-9aa88ae232e5@amazon.com>
 <fa124990-ee0c-7401-019e-08109e338042@amd.com>
 <e2c47256-de89-7eaa-e5c2-5b96efcec834@amazon.com>
 <6b819064-feda-b70b-ea69-eb0a4fca6c0c@amd.com>
 <a9604a39-d08f-6263-4c5b-a2bc9a70583d@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a9604a39-d08f-6263-4c5b-a2bc9a70583d@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 24, 2021 at 10:27:23AM -0700, John Hubbard wrote:
> On 8/24/21 2:32 AM, Christian König wrote:
> > Am 24.08.21 um 11:06 schrieb Gal Pressman:
> > > On 23/08/2021 13:43, Christian König wrote:
> > > > Am 21.08.21 um 11:16 schrieb Gal Pressman:
> > > > > On 20/08/2021 17:32, Jason Gunthorpe wrote:
> > > > > > On Fri, Aug 20, 2021 at 03:58:33PM +0300, Gal Pressman wrote:
> ...
> > > > > IIUC, we're talking about three different exporter "types":
> > > > > - Dynamic with move_notify (requires ODP)
> > > > > - Dynamic with revoke_notify
> > > > > - Static
> > > > > 
> > > > > Which changes do we need to make the third one work?
> > > > Basically none at all in the framework.
> > > > 
> > > > You just need to properly use the dma_buf_pin() function when you start using a
> > > > buffer (e.g. before you create an attachment) and the dma_buf_unpin() function
> > > > after you are done with the DMA-buf.
> > > I replied to your previous mail, but I'll ask again.
> > > Doesn't the pin operation migrate the memory to host memory?
> > 
> > Sorry missed your previous reply.
> > 
> > And yes at least for the amdgpu driver we migrate the memory to host
> > memory as soon as it is pinned and I would expect that other GPU drivers
> > do something similar.
> 
> Well...for many topologies, migrating to host memory will result in a
> dramatically slower p2p setup. For that reason, some GPU drivers may
> want to allow pinning of video memory in some situations.
> 
> Ideally, you've got modern ODP devices and you don't even need to pin.
> But if not, and you still hope to do high performance p2p between a GPU
> and a non-ODP Infiniband device, then you would need to leave the pinned
> memory in vidmem.
> 
> So I think we don't want to rule out that behavior, right? Or is the
> thinking more like, "you're lucky that this old non-ODP setup works at
> all, and we'll make it work by routing through host/cpu memory, but it
> will be slow"?

I think it depends on the user, if the user creates memory which is
permanently located on the GPU then it should be pinnable in this way
without force migration. But if the memory is inherently migratable
then it just cannot be pinned in the GPU at all as we can't
indefinately block migration from happening eg if the CPU touches it
later or something.

Jason
