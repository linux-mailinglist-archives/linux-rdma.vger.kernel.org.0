Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22153310BC5
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Feb 2021 14:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhBENZ1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Feb 2021 08:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhBENXH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Feb 2021 08:23:07 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEB0C0617A7
        for <linux-rdma@vger.kernel.org>; Fri,  5 Feb 2021 05:22:26 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id l11so3395777qvt.1
        for <linux-rdma@vger.kernel.org>; Fri, 05 Feb 2021 05:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jQUIp9niz/uOgL5mmbfjBwhGvI5VU8KjTGU8DMkCJHY=;
        b=axFVMjNvflN4c5MmnvPMBQOovQ410sbVVkUEoKwCzSPZ39cUveXsub7rPwEIQLdUNI
         yXXXicSW4D/9CbIEG8P/qOAqHVqPvfgTvefUOVA5H75U3lNc6hfUVH95Nnl7lhk+jm1b
         ceo0dCVL6UL3wmbTLv8yXGjd+YsA6wI7ql+8da3Ygm1xBJKpnxTjpU5amkEbNA3McUWw
         csfgtDYxuuGjUM1v52Z2Gbh9JPLNWQWjogPrn5VUN4RqElhxnN2ePgjFYp6EjAaGmP7J
         IA3+GijkY63qUHTAESC/ONI48qv65lq2JMADqTB8K7v9M/Y1XyqbhXns2bj5Zqi/5mY3
         GXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jQUIp9niz/uOgL5mmbfjBwhGvI5VU8KjTGU8DMkCJHY=;
        b=OGxaf/1FaDFoDvI/xX8wdBclUb9X4ObpEgOt0ap/2WhMoWYr8jXFFTdCjJrDuVuNJf
         TGaU6j/zouo44eOQMe+eF03iK2/qP0a+K9mfaQVVuMUSu0Ho/4BXRTHJznU1s+7NweDw
         Sb4lJMlKEx7x31poZ5ufYL8xHVYYublYDJP6xOIONHwgpKbJu/zfSUPCiI6ArjY/Z61I
         GeLah16Wa/ikmx2A3xImkLvNTh5Ut5wRb/IBB1pTtlBdrQd13MfWWngywoygX0kEtXmQ
         kYK73fhThoYzz88ncYi01PG1yH58kOpUN1NpCeqbI1wmtQOHKbPTVas4qY7awG0zEhoN
         0FNw==
X-Gm-Message-State: AOAM533nh95euWZVad25njzV/TpmkfEHoyjBawSalC4yw5yK0NCGAWyb
        RYvf5FqlhPS5XYVkQfMoK77oPg==
X-Google-Smtp-Source: ABdhPJw3RA9vBcmfXBOlbNYqYZ2+IIALUDcInGmWO9yQ0P8R/Ss6/JzAqsIz/4qywP43kMcRTS314g==
X-Received: by 2002:a05:6214:725:: with SMTP id c5mr4095464qvz.27.1612531345671;
        Fri, 05 Feb 2021 05:22:25 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id k90sm6612703qtd.0.2021.02.05.05.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 05:22:25 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1l8144-003pvy-Kf; Fri, 05 Feb 2021 09:22:24 -0400
Date:   Fri, 5 Feb 2021 09:22:24 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jianxin Xiong <jianxin.xiong@intel.com>
Cc:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Edward Srouji <edwards@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Ali Alnubani <alialnu@nvidia.com>,
        Gal Pressman <galpress@amazon.com>,
        Emil Velikov <emil.l.velikov@gmail.com>
Subject: Re: [PATCH rdma-core v2 3/3] configure: Add check for the presence
 of DRM headers
Message-ID: <20210205132224.GK4718@ziepe.ca>
References: <1612484954-75514-1-git-send-email-jianxin.xiong@intel.com>
 <1612484954-75514-4-git-send-email-jianxin.xiong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612484954-75514-4-git-send-email-jianxin.xiong@intel.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 04, 2021 at 04:29:14PM -0800, Jianxin Xiong wrote:
> Compilation of pyverbs/dmabuf_alloc.c depends on a few DRM headers
> that are installed by either the kernel-header or the libdrm package.
> The installation is optional and the location is not unique.
> 
> Check the presence of the headers at both the standard locations and
> any location defined by custom libdrm installation. If the headers
> are missing, the dmabuf allocation routines are replaced by stubs that
> return suitable error to allow the related tests to skip.
> 
> Signed-off-by: Jianxin Xiong <jianxin.xiong@intel.com>
>  CMakeLists.txt              | 15 +++++++++++++++
>  pyverbs/CMakeLists.txt      | 14 ++++++++++++--
>  pyverbs/dmabuf_alloc.c      |  8 ++++----
>  pyverbs/dmabuf_alloc_stub.c | 39 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 70 insertions(+), 6 deletions(-)
>  create mode 100644 pyverbs/dmabuf_alloc_stub.c
> 
> diff --git a/CMakeLists.txt b/CMakeLists.txt
> index 4113423..95aec11 100644
> +++ b/CMakeLists.txt
> @@ -515,6 +515,21 @@ find_package(Systemd)
>  include_directories(${SYSTEMD_INCLUDE_DIRS})
>  RDMA_DoFixup("${SYSTEMD_FOUND}" "systemd/sd-daemon.h")
>  
> +# drm headers
> +
> +# First check the standard locations. The headers could have been installed
> +# by either the kernle-headers package or the libdrm package.
> +find_path(DRM_INCLUDE_DIRS "drm.h" PATH_SUFFIXES "drm" "libdrm")

Is there a reason not to just always call pkg_check_modules?

> +# Then check custom installation of libdrm
> +if (NOT DRM_INCLUDE_DIRS)
> +  pkg_check_modules(DRM libdrm)
> +endif()
> +
> +if (DRM_INCLUDE_DIRS)
> +  include_directories(${DRM_INCLUDE_DIRS})
> +endif()

This needs a hunk at the end:

if (NOT DRM_INCLUDE_DIRS)
  message(STATUS " DMABUF NOT supported (disabling some tests)")
endif()

>  #-------------------------
>  # Apply fixups
>  
> diff --git a/pyverbs/CMakeLists.txt b/pyverbs/CMakeLists.txt
> index 6fd7625..922253f 100644
> +++ b/pyverbs/CMakeLists.txt
> @@ -13,8 +13,6 @@ rdma_cython_module(pyverbs ""
>    cmid.pyx
>    cq.pyx
>    device.pyx
> -  dmabuf.pyx
> -  dmabuf_alloc.c
>    enums.pyx
>    mem_alloc.pyx
>    mr.pyx
> @@ -25,6 +23,18 @@ rdma_cython_module(pyverbs ""
>    xrcd.pyx
>  )
>  
> +if (DRM_INCLUDE_DIRS)
> +rdma_cython_module(pyverbs ""
> +  dmabuf.pyx
> +  dmabuf_alloc.c
> +)
> +else()
> +rdma_cython_module(pyverbs ""
> +  dmabuf.pyx
> +  dmabuf_alloc_stub.c
> +)
> +endif()

Like this:

if (DRM_INCLUDE_DIRS)
  set(DMABUF_ALLOC dmabuf_alloc.c)
else()
  set(DMABUF_ALLOC dmabuf_alloc_stbub.c)
endif()
rdma_cython_module(pyverbs ""
  dmabuf.pyx
  $(DMABUF_ALLOC)
)

Jason
