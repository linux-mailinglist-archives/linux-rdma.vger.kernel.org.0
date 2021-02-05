Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 504FD310C50
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Feb 2021 14:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbhBEN5h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Feb 2021 08:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbhBENyx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Feb 2021 08:54:53 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45AFC06178C
        for <linux-rdma@vger.kernel.org>; Fri,  5 Feb 2021 05:54:12 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id h6so7471946oie.5
        for <linux-rdma@vger.kernel.org>; Fri, 05 Feb 2021 05:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j6v1VGSVATY+hRCrnnT7AY/QYNm5+/40mYg+pzQl86A=;
        b=A6iq2KXrFahtB4cr3kBPqnqyo0XAzdmKOQhEnAbZD+/KssOkXDwz6IJ0qo8ox1WLvf
         8UGkL/qfkfkl6uMou7uXvK/1sI/u1c+soMpQE/MjNXBtluQs7cCAxhy28nieGmGPq1A+
         KL9fKX4IKHeAbDqPcytAyykKTpjzrV4nYRQeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j6v1VGSVATY+hRCrnnT7AY/QYNm5+/40mYg+pzQl86A=;
        b=gDhmXTAnqxesj+Z43KhXvDpXup7/S5feNWuVlk6x4T+4UsUg7Ge886lW8wabkNCuvv
         9i2S8ELQz3MpJaHjd1CJkB4CAeXPkvDHx8lFw4RkGF4WpSaGchooIk4aiBjFtXuWGwvd
         5CyEh3vJtVwb4tQPg73alnlEnFebU0YVgpdJviBOGcEZ8As5qO/dROm6UrK5IVtEheHz
         n3Z3wPgLkWZvjEFdfqZTBWNZD5DK6DjiJ1K8PL4XsORKd++LAicdW5BR2jNMy54yXdy9
         ybL2hRO34mqt6f3LPjZXBEijil0L8oTGCSbWj7TORp6JiUIiQa+AoT8prJ3ICib0FZXq
         G5ng==
X-Gm-Message-State: AOAM531RDzo951jEK5SAp69HBtxOv4AawZ71aGYKvnr/r7pfjmJ4GtYk
        4ThiOdjGFPwucgNWKhbMri7uNxohw3A1AunQj4dXiq6zyYKzgw==
X-Google-Smtp-Source: ABdhPJz9685+eI3NdzBDb5abkOxLpUI3dgTqppxo5J29WG/YfwXVsL5gNZKnX3HBnOyiivnkPOk/JQIaVu1Zrp1aNTo=
X-Received: by 2002:aca:df42:: with SMTP id w63mr3045004oig.128.1612533252354;
 Fri, 05 Feb 2021 05:54:12 -0800 (PST)
MIME-Version: 1.0
References: <1612484954-75514-1-git-send-email-jianxin.xiong@intel.com>
 <1612484954-75514-4-git-send-email-jianxin.xiong@intel.com> <20210205132224.GK4718@ziepe.ca>
In-Reply-To: <20210205132224.GK4718@ziepe.ca>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 5 Feb 2021 14:54:01 +0100
Message-ID: <CAKMK7uG4M3vBVB_gH4gJOOATdCk9HfUWEWAP5g87mDVM78P23A@mail.gmail.com>
Subject: Re: [PATCH rdma-core v2 3/3] configure: Add check for the presence of
 DRM headers
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jianxin Xiong <jianxin.xiong@intel.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Edward Srouji <edwards@nvidia.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Gal Pressman <galpress@amazon.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Doug Ledford <dledford@redhat.com>,
        Ali Alnubani <alialnu@nvidia.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 5, 2021 at 2:22 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Thu, Feb 04, 2021 at 04:29:14PM -0800, Jianxin Xiong wrote:
> > Compilation of pyverbs/dmabuf_alloc.c depends on a few DRM headers
> > that are installed by either the kernel-header or the libdrm package.
> > The installation is optional and the location is not unique.
> >
> > Check the presence of the headers at both the standard locations and
> > any location defined by custom libdrm installation. If the headers
> > are missing, the dmabuf allocation routines are replaced by stubs that
> > return suitable error to allow the related tests to skip.
> >
> > Signed-off-by: Jianxin Xiong <jianxin.xiong@intel.com>
> >  CMakeLists.txt              | 15 +++++++++++++++
> >  pyverbs/CMakeLists.txt      | 14 ++++++++++++--
> >  pyverbs/dmabuf_alloc.c      |  8 ++++----
> >  pyverbs/dmabuf_alloc_stub.c | 39 +++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 70 insertions(+), 6 deletions(-)
> >  create mode 100644 pyverbs/dmabuf_alloc_stub.c
> >
> > diff --git a/CMakeLists.txt b/CMakeLists.txt
> > index 4113423..95aec11 100644
> > +++ b/CMakeLists.txt
> > @@ -515,6 +515,21 @@ find_package(Systemd)
> >  include_directories(${SYSTEMD_INCLUDE_DIRS})
> >  RDMA_DoFixup("${SYSTEMD_FOUND}" "systemd/sd-daemon.h")
> >
> > +# drm headers
> > +
> > +# First check the standard locations. The headers could have been installed
> > +# by either the kernle-headers package or the libdrm package.
> > +find_path(DRM_INCLUDE_DIRS "drm.h" PATH_SUFFIXES "drm" "libdrm")
>
> Is there a reason not to just always call pkg_check_modules?

Note that the gpu-specific libraries are split out, so I'd also check
for those just to be sure - I don't know whether all distros package
the uapi headers consistently in libdrm or sometimes also in one of
the libdrm-$vendor packages.
-Daniel

>
> > +# Then check custom installation of libdrm
> > +if (NOT DRM_INCLUDE_DIRS)
> > +  pkg_check_modules(DRM libdrm)
> > +endif()
> > +
> > +if (DRM_INCLUDE_DIRS)
> > +  include_directories(${DRM_INCLUDE_DIRS})
> > +endif()
>
> This needs a hunk at the end:
>
> if (NOT DRM_INCLUDE_DIRS)
>   message(STATUS " DMABUF NOT supported (disabling some tests)")
> endif()
>
> >  #-------------------------
> >  # Apply fixups
> >
> > diff --git a/pyverbs/CMakeLists.txt b/pyverbs/CMakeLists.txt
> > index 6fd7625..922253f 100644
> > +++ b/pyverbs/CMakeLists.txt
> > @@ -13,8 +13,6 @@ rdma_cython_module(pyverbs ""
> >    cmid.pyx
> >    cq.pyx
> >    device.pyx
> > -  dmabuf.pyx
> > -  dmabuf_alloc.c
> >    enums.pyx
> >    mem_alloc.pyx
> >    mr.pyx
> > @@ -25,6 +23,18 @@ rdma_cython_module(pyverbs ""
> >    xrcd.pyx
> >  )
> >
> > +if (DRM_INCLUDE_DIRS)
> > +rdma_cython_module(pyverbs ""
> > +  dmabuf.pyx
> > +  dmabuf_alloc.c
> > +)
> > +else()
> > +rdma_cython_module(pyverbs ""
> > +  dmabuf.pyx
> > +  dmabuf_alloc_stub.c
> > +)
> > +endif()
>
> Like this:
>
> if (DRM_INCLUDE_DIRS)
>   set(DMABUF_ALLOC dmabuf_alloc.c)
> else()
>   set(DMABUF_ALLOC dmabuf_alloc_stbub.c)
> endif()
> rdma_cython_module(pyverbs ""
>   dmabuf.pyx
>   $(DMABUF_ALLOC)
> )
>
> Jason
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
