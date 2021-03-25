Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00E0F3492FC
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Mar 2021 14:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbhCYNUd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Mar 2021 09:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbhCYNU3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Mar 2021 09:20:29 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8570C06174A
        for <linux-rdma@vger.kernel.org>; Thu, 25 Mar 2021 06:20:28 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id g20so1680986qkk.1
        for <linux-rdma@vger.kernel.org>; Thu, 25 Mar 2021 06:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=INfL/yOGSv7iymbCWnvt4xR0dGUct2+eqgpMDI6XVQk=;
        b=MBxATCNRSXN2xX7yiq1RunjB/I8Ulr8qiknjSVNkyBZ2QfHevcgj/d2LoKJvfh/VJy
         aHJXGCv65fic/P9ds6Ktu3Fl9NFrmF3Zk+NiC3p1JjsqO7wOyzC6W2zsJXmyR7FyRDeg
         4rYZQ8f6SMS49Ix8zzJnO/X1+g1D5n+wC4T8pZmNoOOl9j0H/FEp7tNOsq4a/zYeJpO1
         vHJqUoR3wIWXYqJ2ZgNor7+Y3qWZx8f/r7hAfESxTY6L0enxnxqZ7qTNWER+13seeaX3
         59ujn+H2YRZJtkycukB/RlYI64XtFoagOQMSGCNHnoVII8Z3NfC6aog7xjSu6lSKqKqx
         w8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=INfL/yOGSv7iymbCWnvt4xR0dGUct2+eqgpMDI6XVQk=;
        b=TAl9ezRSwxZPbURtFLYylAFZvGmOoKKfGHTUrw0pZQwoE6LnXghIG339HA1G9JQDEQ
         pksC7i2fSbINjbos6fKyoXV74urTiWN/u1WZv/bTINwZJzzNTaV1tDWClX4/Z3ix4HFd
         Et92+9nHVhhjOJKr1hFp+FcyXd/y1PVBmTHNJrK2vrD6oE5FmHMzlba4EzuEesy5nmKV
         mhJrmSEM4yLy6Na4KhzEVLnpeIjV4WPYEICaAc9EKRvDel7f2WjL/cWDE2MB0cMpxysI
         S+PgQbV+tEsfWitT+BbAUlH74Efo15N6VYmYWUUle9ZVXHUSdiL2rX3GHwKgsuAnuClV
         Tspg==
X-Gm-Message-State: AOAM532lccQE9h/2maJnklznrG+WBBrcUVYLm++i6wVIHXO3McaTiSay
        3hcEX3x4Ev7+iZN5O2VsASNXYQ==
X-Google-Smtp-Source: ABdhPJweqZwwKIe/WRvbACvv6HVWnTOe1awyVqAz7sh5He2epLh/sHDI/qwnW10KCf6MIvC3+rHTaQ==
X-Received: by 2002:a37:66c6:: with SMTP id a189mr7907813qkc.229.1616678427876;
        Thu, 25 Mar 2021 06:20:27 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id h5sm3482343qtq.1.2021.03.25.06.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 06:20:27 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lPPuU-002WpY-CC; Thu, 25 Mar 2021 10:20:26 -0300
Date:   Thu, 25 Mar 2021 10:20:26 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jianxin Xiong <jianxin.xiong@intel.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        liweihang <liweihang@huawei.com>
Subject: Re: [PATCH rdma-core] configure: Check the existence of all needed
 DRM headers
Message-ID: <20210325132026.GJ2710221@ziepe.ca>
References: <1616444421-148423-1-git-send-email-jianxin.xiong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616444421-148423-1-git-send-email-jianxin.xiong@intel.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 22, 2021 at 01:20:21PM -0700, Jianxin Xiong wrote:
> Some vendor specific DRM headers may be missing on systems with old
> kernels. Make sure that all headers needed by pyverbs/dmabuf_alloc.c
> are present before enabling that module.
> 
> Remove unused reference of "radeon_drm.h" from pyverbs/dmabuf_alloc.c.
> 
> Signed-off-by: Jianxin Xiong <jianxin.xiong@intel.com>
>  CMakeLists.txt         | 6 +++++-
>  pyverbs/dmabuf_alloc.c | 1 -
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/CMakeLists.txt b/CMakeLists.txt
> index e9a2f49..1208ab6 100644
> +++ b/CMakeLists.txt
> @@ -526,7 +526,11 @@ if (NOT DRM_INCLUDE_DIRS)
>  endif()
>  
>  if (DRM_INCLUDE_DIRS)
> -  include_directories(${DRM_INCLUDE_DIRS})
> +  if (EXISTS ${DRM_INCLUDE_DIRS}/i915_drm.h AND EXISTS ${DRM_INCLUDE_DIRS}/amdgpu_drm.h)
> +    include_directories(${DRM_INCLUDE_DIRS})

It should be in a compile test not coded like this.

The whole thing is getting complex, it should probably go into a
find_package() subroutine

Jason
