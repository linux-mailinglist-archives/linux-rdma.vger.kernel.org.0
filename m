Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6AF2C2B02
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Nov 2020 16:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730546AbgKXPRE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Nov 2020 10:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728389AbgKXPRE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Nov 2020 10:17:04 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA222C0613D6
        for <linux-rdma@vger.kernel.org>; Tue, 24 Nov 2020 07:17:02 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id s8so22649460wrw.10
        for <linux-rdma@vger.kernel.org>; Tue, 24 Nov 2020 07:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ts31PWn2osQNMfqv6eeBKBtEOWs++a2LWDPRDxGGxbY=;
        b=fVzwlRZbNERIy1g5e2WU8y0mSpLAMs7BC+BY0ZXbVU1kJqt9Yqc17VOb1kzAVweHgd
         tkgySdDHnX4eaZ8LV5FXgT8eU9hyDvaPfqiZOiuvHj6w7KfGLJaYWdT2CEnbbZ3xKmYk
         hoYO2YZhLxwN0JmdgXain0OWmKFvyh8nPqVVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ts31PWn2osQNMfqv6eeBKBtEOWs++a2LWDPRDxGGxbY=;
        b=a7p8jnAWhvA6l+cib/dnQJBt8EURP0ypMUnyBGXwxrh+yKowNH1ByYuwualZASbLlr
         aw3WqzjQA6QMPnIxZDHmafNC1xeWTNAMr4c62DXtS97rx2Z2CHLKeBtTxo0thXKQMKlP
         ZfL8ij5bmCXqlrxfN4JOeR7LLItEW8ArWzY0JZbROsSIyuhov902gSHK6UwjvW8hnw6Y
         zlOmItn3fGWYWxKKGdp2W8zC5DAFQtjbvQiGLKTUDKQMwkr2N/VHR0w8SG1SGkXm5uVZ
         hAqsx+ev7gawtJPOgCumEnGKQkD9vkJ33Z74hQREYE5g5k6Wgf3NRKwL7049YBX5UpnZ
         ZNtQ==
X-Gm-Message-State: AOAM531aL83g8ivPTV02oNzJbS0OqLjW1ZG0l/MeI8qbIg4ZFLpnUhhd
        EAJ5ab0EmHJ/PjoYRFpoGbUgfu4ZGFjNnw==
X-Google-Smtp-Source: ABdhPJwWzpYKeM+Z+xQIFX4VTUoFmi2NZANo2rduFjE8ri3FzOsooQ0lGsLD2BeZ5Z28D/b7M81otQ==
X-Received: by 2002:adf:f1cb:: with SMTP id z11mr5940638wro.363.1606231021444;
        Tue, 24 Nov 2020 07:17:01 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id c64sm5585398wmd.41.2020.11.24.07.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 07:17:00 -0800 (PST)
Date:   Tue, 24 Nov 2020 16:16:58 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jianxin Xiong <jianxin.xiong@intel.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Doug Ledford <dledford@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Christian Koenig <christian.koenig@amd.com>
Subject: Re: [PATCH rdma-core 3/5] pyverbs: Add dma-buf based MR support
Message-ID: <20201124151658.GT401619@phenom.ffwll.local>
References: <1606153984-104583-1-git-send-email-jianxin.xiong@intel.com>
 <1606153984-104583-4-git-send-email-jianxin.xiong@intel.com>
 <20201123180504.GA244516@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123180504.GA244516@ziepe.ca>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 23, 2020 at 02:05:04PM -0400, Jason Gunthorpe wrote:
> On Mon, Nov 23, 2020 at 09:53:02AM -0800, Jianxin Xiong wrote:
> 
> > +cdef class DmaBuf:
> > +    def __init__(self, size, unit=0):
> > +        """
> > +        Allocate DmaBuf object from a GPU device. This is done through the
> > +        DRI device interface (/dev/dri/card*). Usually this requires the

Please use /dev/dri/renderD* instead. That's the interface meant for
unpriviledged rendering access. card* is the legacy interface with
backwards compat galore, don't use.

Specifically if you do this on a gpu which also has display (maybe some
testing on a local developer machine, no idea ...) then you mess with
compositors and stuff.

Also wherever you copied this from, please also educate those teams that
using /dev/dri/card* for rendering stuff is a Bad Idea (tm)

> > +        effective user id being root or being a member of the 'video' group.
> > +        :param size: The size (in number of bytes) of the buffer.
> > +        :param unit: The unit number of the GPU to allocate the buffer from.
> > +        :return: The newly created DmaBuf object on success.
> > +        """
> > +        self.dmabuf_mrs = weakref.WeakSet()
> > +        self.dri_fd = open('/dev/dri/card'+str(unit), O_RDWR)
> > +
> > +        args = bytearray(32)
> > +        pack_into('=iiiiiiq', args, 0, 1, size, 8, 0, 0, 0, 0)
> > +        ioctl(self.dri_fd, DRM_IOCTL_MODE_CREATE_DUMB, args)
> > +        a, b, c, d, self.handle, e, self.size = unpack('=iiiiiiq', args)

Yeah no, don't allocate render buffers with create_dumb. Every time this
comes up I'm wondering whether we should just completely disable dma-buf
operations on these. Dumb buffers are explicitly only for software
rendering for display purposes when the gpu userspace stack isn't fully
running yet, aka boot splash.

And yes I know there's endless amounts of abuse of that stuff floating
around, especially on arm-soc/android systems.

> > +
> > +        args = bytearray(12)
> > +        pack_into('=iii', args, 0, self.handle, O_RDWR, 0)
> > +        ioctl(self.dri_fd, DRM_IOCTL_PRIME_HANDLE_TO_FD, args)
> > +        a, b, self.fd = unpack('=iii', args)
> > +
> > +        args = bytearray(16)
> > +        pack_into('=iiq', args, 0, self.handle, 0, 0)
> > +        ioctl(self.dri_fd, DRM_IOCTL_MODE_MAP_DUMB, args);
> > +        a, b, self.map_offset = unpack('=iiq', args);
> 
> Wow, OK
> 
> Is it worth using ctypes here instead? Can you at least add a comment
> before each pack specifying the 'struct XXX' this is following?
> 
> Does this work with normal Intel GPUs, like in a Laptop? AMD too?
> 
> Christian, I would be very happy to hear from you that this entire
> work is good for AMD as well

I think the smallest generic interface for allocating gpu buffers which
are more useful than the stuff you get from CREATE_DUMB is gbm. That's
used by compositors to get bare metal opengl going on linux. Ofc Android
has gralloc for the same purpose, and cros has minigbm (which isn't the
same as gbm at all). So not so cool.

The other generic option is using vulkan, which works directly on bare
metal (without a compositor or anything running), and is cross vendor. So
cool, except not used for compute, which is generally the thing you want
if you have an rdma card.

Both gbm-egl/opengl and vulkan have extensions to hand you a dma-buf back,
properly.

Compute is the worst, because opencl is widely considered a mistake (maybe
opencl 3 is better, but nvidia is stuck on 1.2). The actually used stuff is
cuda (nvidia-only), rocm (amd-only) and now with intel also playing we
have xe (intel-only).

It's pretty glorious :-/

Also I think we discussed this already, but for actual p2p the intel
patches aren't in upstream yet. We have some internally, but with very
broken locking (in the process of getting fixed up, but it's taking time).

Cheers, Daniel

> Edward should look through this, but I'm glad to see something like
> this
> 
> Thanks,
> Jason
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
