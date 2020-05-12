Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 488C21CF409
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2020 14:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbgELMJz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 May 2020 08:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbgELMJz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 May 2020 08:09:55 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED402C061A0E
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2020 05:09:54 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id f13so12623572qkh.2
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2020 05:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0E+w23r0rm59Sttp+Cx0/u2Fxv6Zhza30yRDAxBOwIM=;
        b=XRnT+4+TWQyHNmyGS+cSdisYi0zNeQpz5uND4j+3R32mzcUZGCtrhnUZduANVucjLs
         fPeDcZnf0jJZdFR18+rXBGExeB/xOfjO6j5ubgczrNSIabiDm3PpWhxkNKaizLg4FP0J
         sa50sZfadORNY04EFhJQrsRUYbYc9oVcbKS2sMEoCu11o9nPs7ZSUus3alQ+pAkKbMAV
         aWmgipf3DUd2+yiqRDwFz9qMTz3IWl1iCgmhXs/gmp7BDs1Z+Hp9W9wAYy5ZacibQ3td
         xqUancRvGLhZbF4o+FHI7mZTtBugkHa1LurSn3oFjsiEMnHhi/WOIzp2ySY0+TXNYike
         G58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0E+w23r0rm59Sttp+Cx0/u2Fxv6Zhza30yRDAxBOwIM=;
        b=qpctYrhbRwQDZ15zxqIvUgpWGiafymdeMgbWqced8ZUK04S6toLSBAeKqBd/GM4k5a
         Xx2ckV069ZfzX7SzC+2q2wNhi9qqAF8A/0R6HH1cjZTIP8o4YvaLLfp4iVLvtkOEdePg
         kBt/rn6HfR3uUXV06SYIO+BEtFXFrMoFb236zF4m5WLV8+4g8keyb2gFVkxr5cMeY1p9
         4arNzgBuTz6k7S8hP3R+983XWQLOslaelI86hwKrppA6Q2mEgFWH4gFSIDx3dgb9DnC2
         3PegCdR+q6V7rEgakcvJLRLgjk/zjNfc8Xfq7G6BQHVS0muL8/j/9qHbZ6vYKogcfwTA
         MULA==
X-Gm-Message-State: AGi0PuZ2KO8D7WZbkVk1C1lWbnETi0IUGCz0ohK2twVxXf27+5SYo5uk
        7KqwAA9cRldoPgwQwPcnDSOz/0Ciyq4=
X-Google-Smtp-Source: APiQypKyJUyUDzstE5W+rLlCHv8FxVxdeZGVjAl1eRUGduGzlJpYQ83iKZf1ZsgDC1FOpB7AS1NLBw==
X-Received: by 2002:a37:484c:: with SMTP id v73mr8524856qka.496.1589285394059;
        Tue, 12 May 2020 05:09:54 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id y18sm12534463qty.41.2020.05.12.05.09.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 May 2020 05:09:53 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jYTjM-0003lT-T7; Tue, 12 May 2020 09:09:52 -0300
Date:   Tue, 12 May 2020 09:09:52 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, linux-rdma@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [RFC 02/17] dma-fence: basic lockdep annotations
Message-ID: <20200512120952.GG26002@ziepe.ca>
References: <20200512085944.222637-1-daniel.vetter@ffwll.ch>
 <20200512085944.222637-3-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512085944.222637-3-daniel.vetter@ffwll.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 12, 2020 at 10:59:29AM +0200, Daniel Vetter wrote:
> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> index 6802125349fb..d5c0fd2efc70 100644
> +++ b/drivers/dma-buf/dma-fence.c
> @@ -110,6 +110,52 @@ u64 dma_fence_context_alloc(unsigned num)
>  }
>  EXPORT_SYMBOL(dma_fence_context_alloc);
>  
> +#ifdef CONFIG_LOCKDEP
> +struct lockdep_map	dma_fence_lockdep_map = {
> +	.name = "dma_fence_map"
> +};
> +
> +bool dma_fence_begin_signalling(void)
> +{

Why is this global? I would have expected it to be connected to a
single fence?

It would also be alot nicer if this was some general lockdep feature,
not tied to dmabuf. This exact problem also strikes anyone using
completions, for instance, and the same solution should be
applicable??

Jason
