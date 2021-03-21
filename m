Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C7A34334C
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Mar 2021 16:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhCUPxv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 Mar 2021 11:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhCUPxU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 21 Mar 2021 11:53:20 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEF1C061574
        for <linux-rdma@vger.kernel.org>; Sun, 21 Mar 2021 08:53:19 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id y5so6605663qkl.9
        for <linux-rdma@vger.kernel.org>; Sun, 21 Mar 2021 08:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h5iHZo/JcEnVoMUq3sVA4J7gycD7TvrYim/GyvQPENk=;
        b=XXV3jwKGjsqtTDNClsVP7fZzg4X1hAsQBPfiNzJfuKrV7FhYLqdO2f/38GJz8WI3yw
         n0CVQyuYRjyXIKh2qfHObuJGk+xXRa4c8sfsi+5+ah/juhTCepG7Y2RSDGHHbjDdaJxQ
         SOrKeNSFPbyFKGu5pkePF0u5on75FvkCaHkf1VQm7084EjZi1oRMdBeoS0lHxiDBoNBn
         FIDy5RcSwVs+NWSiYc6vlg/1VLUnWL3cM7dD7HrBx3dbW2/CYHme+bbchD3zqlczWrEF
         UeBjzcegKzIoSvFzeBjp32b0HBTAhB71E3uKwkUNJ6vgu0ls8tqtORNFCgTtcvd/9j2a
         xsxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h5iHZo/JcEnVoMUq3sVA4J7gycD7TvrYim/GyvQPENk=;
        b=JUmHfF/PdmFEZSYHpjxJuC4Le0udLrvYrV/NqKNrhkuWslk0/Z/qyUzwffYePpPF1J
         vu0lTTXK5Ugh3r9MLWReo0WUxg7J6bxvpOG/3pFQAd9H44cdFMBBWee2le4e00/Etpsf
         e7fHFW18BWLOmF0xtjKI2u7mMwHw5lXE/gYfn/uvSLmohjQF5qHgIb3tAfbA7YOFinKw
         YzAvTfwAn+A7+k7kCvpL9dnDO/+57Zv2GKb8IkxO5yVnx/lo0bLWAQQsM+iT3s1PxX+s
         Oct99oD+t/stxIvNgy7RN66+CQWnwM40Sd8FrmyIaoEHpCt7V/+LYFEE+L/ZgC5Uyebh
         oNow==
X-Gm-Message-State: AOAM5330flJ0B+J/tTgYeXq/+VuE/QOY9tD19VyGIfYQCM0jR+Uu3dJb
        OLOU5CbMmR36la//rW/z+IrnPg==
X-Google-Smtp-Source: ABdhPJwkFpi/8GIXvfGWm+eeOB4EF9sbZLti6hm8lZkKR4W/xIRCACh7PcMOris3brn+iN3+JJHXsw==
X-Received: by 2002:ae9:e40b:: with SMTP id q11mr7325039qkc.318.1616341998973;
        Sun, 21 Mar 2021 08:53:18 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id c5sm9127900qkg.105.2021.03.21.08.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 08:53:18 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lO0OD-000av0-OQ; Sun, 21 Mar 2021 12:53:17 -0300
Date:   Sun, 21 Mar 2021 12:53:17 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     "Xiong, Jianxin" <jianxin.xiong@intel.com>,
        liweihang <liweihang@huawei.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [rdma-core] Compile issue with DRM headers
Message-ID: <20210321155317.GD2710221@ziepe.ca>
References: <d204d1db15844e45b946125a5452ab19@huawei.com>
 <MW3PR11MB4555FC2C195C0AAB5D804326E5689@MW3PR11MB4555.namprd11.prod.outlook.com>
 <YFc2348DwMqm6e3r@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFc2348DwMqm6e3r@unreal>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Mar 21, 2021 at 02:06:55PM +0200, Leon Romanovsky wrote:
> On Fri, Mar 19, 2021 at 04:50:53PM +0000, Xiong, Jianxin wrote:
> > 
> > > From: liweihang <liweihang@huawei.com>
> > > Sent: Friday, March 19, 2021 1:44 AM
> > > To: Xiong, Jianxin <jianxin.xiong@intel.com>; linux-rdma@vger.kernel.org
> > > Cc: Jason Gunthorpe <jgg@ziepe.ca>; Leon Romanovsky <leon@kernel.org>; Linuxarm <linuxarm@huawei.com>
> > > Subject: [rdma-core] Compile issue with DRM headers
> > > 
> > > Hi Jianxin,
> > > 
> > > I met a compile error with recent version of rdma-core on my server with Ubuntu
> > > 14.04:
> > > 
> > > ../pyverbs/dmabuf_alloc.c:16:24: fatal error: amdgpu_drm.h: No such file or directory  #include <amdgpu_drm.h>
> > >                         ^
> > > compilation terminated.
> > > 
> > > I found it is related with dma-buf based commits. And the commit 3788aa843b4b
> > > ("configure: Add check for DRM headers") adds a check for libdrm headers. I have installed it but my version(2.4.67-1ubuntu0.14.04.2) isn't
> > > new enough, there is no 'amdgpu_drm.h' in DRM_INCLUDE_DIRS(/usr/include/drm).
> > > 
> > > So I think we may need some check for the the version of libdrm in CMakeList.txt or something else :) Could you please give me some
> > > suggestions?
> > > 
> > > Thanks
> > > Weihang
> > 
> > Hi Weihang,
> > 
> > The simplest way is to replace the check of "drm.h" with "amdgpu_drm.h". This is 
> > reasonable since dma-buf based MR won't work with old kernel anyway. 
> > 
> > Alternatively, we can add a check for "amdgpu_drm.h" in CMakeLists.txt and add
> > some #ifdef's to dmabuf_alloc.c around the code related to amdgpu.
> 
> Let's add compilation test that checks all those files at the same time:
>    14 #include <drm.h>
>    15 #include <i915_drm.h>
>    16 #include <amdgpu_drm.h>
>    17 #include <radeon_drm.h>

Yes please

Jason
