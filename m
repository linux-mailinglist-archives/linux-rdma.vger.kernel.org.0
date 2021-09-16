Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4656B40D9F3
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Sep 2021 14:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239511AbhIPMc7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Sep 2021 08:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239363AbhIPMc7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Sep 2021 08:32:59 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADF9C061764
        for <linux-rdma@vger.kernel.org>; Thu, 16 Sep 2021 05:31:38 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id w17so1071276wrv.10
        for <linux-rdma@vger.kernel.org>; Thu, 16 Sep 2021 05:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=yVn4bOUftTP0XsVCYOhP2MVjOD5RXLBjZ2je0UhYRc0=;
        b=UllxjW1pQN4AmYZEbLg7VrErGUqD+1ja2ihP7bNIWt/uTZGlmL71/XP9jjO6KhmKY0
         fiRtXpVcCH1hQKOY2jdfchmwYGS0XP4lfMRLycLsW6+OfxpIvDESU51aAUOmrcst/rON
         qWFSoQtqfz711rHCKql1DqY94oNcjEZ2J6WVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=yVn4bOUftTP0XsVCYOhP2MVjOD5RXLBjZ2je0UhYRc0=;
        b=LSSQn6mqUiEGRqz58HuU8IZ06c5VbQWTP0YmNuvJJVvp+gxoq/me8XmO6NS5OmwS3T
         DWBo7wFJxGrwdPRoCbjOWyXUaASDx61CJfSFsAgZLLPOm6OOT9xgSmK/jveELpEMxxt8
         7Ca6PlEGu/7iBizHx6skEb5a5Kvsd3kYPNwZepn2uvVkJbtXHrJa2CfSlD5aZlXmq1zl
         PddMbXEMnstvg8m6cxPl6Q4UJNCsFeQd+5WkR5ey1PTfHP3M7DH3xU3M09TOSZ7KT1sN
         0vQgDnlMa0V47Oys7U5/9VdGp1WDGDHak2PU4EHgDCP21aojq2BsrShh+sKbaGXv5EI9
         xZJg==
X-Gm-Message-State: AOAM533MSjH1JSzoDOPM7qcgx9kKaNaIsOIsUb0OZ2VM9rdIlyKZ2Kld
        aOm5FceJsndaWayAIIJZzZB8vg==
X-Google-Smtp-Source: ABdhPJyNeVVi6f4gVXn8CFkrZVMl66WAIJsG4jZYF2OG8FsFOYQQOCNHITS4sqBQA+1lZuWg++BXfA==
X-Received: by 2002:a5d:6da9:: with SMTP id u9mr5766027wrs.155.1631795497459;
        Thu, 16 Sep 2021 05:31:37 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id g5sm3285526wrq.80.2021.09.16.05.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 05:31:36 -0700 (PDT)
Date:   Thu, 16 Sep 2021 14:31:34 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Gal Pressman <galpress@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Dave Airlie <airlied@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>
Subject: Re: [PATCH v6 0/2] Add p2p via dmabuf to habanalabs
Message-ID: <YUM5JoMMK7gceuKZ@phenom.ffwll.local>
Mail-Followup-To: Oded Gabbay <ogabbay@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Gal Pressman <galpress@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>, Dave Airlie <airlied@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Leon Romanovsky <leonro@nvidia.com>, Christoph Hellwig <hch@lst.de>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>
References: <20210912165309.98695-1-ogabbay@kernel.org>
 <YUCvNzpyC091KeaJ@phenom.ffwll.local>
 <20210914161218.GF3544071@ziepe.ca>
 <CAFCwf13322953Txr3Afa_MomuD148vnfpEog0xzW7FPWH9=6fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf13322953Txr3Afa_MomuD148vnfpEog0xzW7FPWH9=6fg@mail.gmail.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 15, 2021 at 10:45:36AM +0300, Oded Gabbay wrote:
> On Tue, Sep 14, 2021 at 7:12 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Tue, Sep 14, 2021 at 04:18:31PM +0200, Daniel Vetter wrote:
> > > On Sun, Sep 12, 2021 at 07:53:07PM +0300, Oded Gabbay wrote:
> > > > Hi,
> > > > Re-sending this patch-set following the release of our user-space TPC
> > > > compiler and runtime library.
> > > >
> > > > I would appreciate a review on this.
> > >
> > > I think the big open we have is the entire revoke discussions. Having the
> > > option to let dma-buf hang around which map to random local memory ranges,
> > > without clear ownership link and a way to kill it sounds bad to me.
> > >
> > > I think there's a few options:
> > > - We require revoke support. But I've heard rdma really doesn't like that,
> > >   I guess because taking out an MR while holding the dma_resv_lock would
> > >   be an inversion, so can't be done. Jason, can you recap what exactly the
> > >   hold-up was again that makes this a no-go?
> >
> > RDMA HW can't do revoke.

Like why? I'm assuming when the final open handle or whatever for that MR
is closed, you do clean up everything? Or does that MR still stick around
forever too?

> > So we have to exclude almost all the HW and several interesting use
> > cases to enable a revoke operation.
> >
> > >   - For non-revokable things like these dma-buf we'd keep a drm_master
> > >     reference around. This would prevent the next open to acquire
> > >     ownership rights, which at least prevents all the nasty potential
> > >     problems.
> >
> > This is what I generally would expect, the DMABUF FD and its DMA
> > memory just floats about until the unrevokable user releases it, which
> > happens when the FD that is driving the import eventually gets closed.
> This is exactly what we are doing in the driver. We make sure
> everything is valid until the unrevokable user releases it and that
> happens only when the dmabuf fd gets closed.
> And the user can't close it's fd of the device until he performs the
> above, so there is no leakage between users.

Maybe I got the device security model all wrong, but I thought Guadi is
single user, and the only thing it protects is the system against the
Gaudi device trhough iommu/device gart. So roughly the following can
happen:

1. User A opens gaudi device, sets up dma-buf export

2. User A registers that with RDMA, or anything else that doesn't support
revoke.

3. User A closes gaudi device

4. User B opens gaudi device, assumes that it has full control over the
device and uploads some secrets, which happen to end up in the dma-buf
region user A set up

5. User B extracts secrets.

> > I still don't think any of the complexity is needed, pinnable memory
> > is a thing in Linux, just account for it in mlocked and that is
> > enough.

It's not mlocked memory, it's mlocked memory and I can exfiltrate it.
Mlock is fine, exfiltration not so much. It's mlock, but a global pool and
if you didn't munlock then the next mlock from a completely different user
will alias with your stuff.

Or is there something that prevents that? Oded at least explain that gaudi
works like a gpu from 20 years ago, single user, no security at all within
the device.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
