Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B22381DDB4F
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2020 01:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbgEUXus (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 May 2020 19:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728762AbgEUXus (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 May 2020 19:50:48 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C7DC061A0E
        for <linux-rdma@vger.kernel.org>; Thu, 21 May 2020 16:50:47 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id m64so7028423qtd.4
        for <linux-rdma@vger.kernel.org>; Thu, 21 May 2020 16:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=81AgANmxBfK3CD5Fhv/JZA9KM43JB2BIFV9VrxHpKbA=;
        b=aI3dsn4wtbyMzkryxVIYH3OWQECYquhcTKYSLKQquZjUdUYUfAEb7CbAxsITXKmmye
         g2BCJlOY1Uwkghf4pH7e2JpxJr+eYBThUEPJBL/wuUtK1BDR2zaVofcgaUght6JN42tn
         E6pNhQ+yPfdM/VGLvjc45Ki/hn2yk4hzV8MH8LlK5I2Rw52+nvI2fjDPMha9nvxuqQHC
         Hjew347QGBuDm932ycOGpupHzvnpcZKk0eKYmP4WNrq0kWFCtcVN/b4KoR4MTYRrqbwZ
         hwr79W5C8LjFfTJp1FXzrMM525CqlRLnWTVpdPFSsDVvUjhXZYJ3uODrpkaGjAR4yc8B
         e5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=81AgANmxBfK3CD5Fhv/JZA9KM43JB2BIFV9VrxHpKbA=;
        b=e/9j8NTEUqJFKaQTkD7znS2mBmDJb3LciPeCq92Uyo8UUT+lFZBW+D3kGUe4szvLm0
         mHMRVPrRGEvINnmOXm0K2N0Ps0cSIf05A4bnfamSevp+hMTnGzZR3jk5/h3ZHe7uzper
         Vibz2ijiZ5VguTLqNVnS+UbIfK22B78rju1QuGpLAh+zRcE139gwu2LQUnPuuRPGfyq1
         CEuB6ChZFM9bWY9vf1iSJ2v3VM2k+gpZO+PjCwYKtqanE+OgTXg4ZebRv3nD/8DOKU8X
         L7DG0MLT0Eyamir8Pd029emoAZ2PbT6op5hvv5pFBXvSYKrBpUZR+IW3QQ7g5GYJPuny
         H5Eg==
X-Gm-Message-State: AOAM533okg9khRomwRXeu4d5cPY1Z1IGpYmBSLZgcfCvp/HDSVcWvSTZ
        QdE9K8NnUGNq/e6cF9TQFQXj/Q==
X-Google-Smtp-Source: ABdhPJwIcdp6326e6qyHJENUXrnW8TfgCenMLLLAYrN+eW9duGtqpCV467NumMxP8m0ETS64VUY4ow==
X-Received: by 2002:ac8:7b43:: with SMTP id m3mr13078294qtu.298.1590105046966;
        Thu, 21 May 2020 16:50:46 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id 66sm6462704qtg.84.2020.05.21.16.50.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 May 2020 16:50:46 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jbuxa-0002o8-52; Thu, 21 May 2020 20:50:46 -0300
Date:   Thu, 21 May 2020 20:50:46 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH rdma-next v2 0/7] Enable asynchronous event FD per object
Message-ID: <20200521235046.GA10623@ziepe.ca>
References: <20200519072711.257271-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519072711.257271-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 19, 2020 at 10:27:04AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Changelog:
> v2:
>  * Added READ_ONCE to all default_async_file calls
>  * Rebased on latest rdma/wip/jgg-for-next
>  * Removed uninitalized_var?()
>  * Simplified uverbs_free_srq()
>  * Put uverbs_finalize_uobj_create() after object is finalized
> v1: https://lore.kernel.org/lkml/20200506082444.14502-1-leon@kernel.org
>  * Forgot to add patch "IB/uverbs: Move QP, SRQ, WQ type and flags to UAPI"
> v0: https://lore.kernel.org/lkml/20200506074049.8347-1-leon@kernel.org
> 
> >From Yishai:
> 
> This series enables applicable events objects (i.e. QP, SRQ, CQ, WQ) to
> be created with their own asynchronous event FD.
> 
> Before this series any affiliated event on an object was reported on the
> first asynchronous event FD that was created on the context without the
> ability to create and use a dedicated FD for it.
> 
> With this series we enable granularity and control for the usage per
> object, according to the application's usage.
> 
> For example, a secondary process that uses the same command FD as of the
> master one, can create its own objects with its dedicated event FD to be
> able to get the events for them once occurred, this couldn't be done
> before this series.
> 
> To achieve the above, any 'create' method for the applicable objects was
> extended to get from rdma-core its optional event FD, if wasn't
> supplied, the default one from the context will be used.
> 
> As we prefer to not extend the 'write' mode KABIs anymore and fully
> move to the 'ioct' mode, as part of this extension QP, SRQ and WQ
> create/destroy commands were introduced over 'ioctl', the CQ KABI was
> extended over its existing 'ioctl' create command.
> 
> As part of moving to 'ioctl' for the above objects the frame work was
> improved to abort a fully created uobject upon some later error, some
> flows were consolidated with the 'write' mode and few bugs were found
> and fixed.
> 
> Yishai
> 
> Jason Gunthorpe (1):
>   RDMA/core: Allow the ioctl layer to abort a fully created uobject
> 
> Yishai Hadas (6):
>   IB/uverbs: Refactor related objects to use their own asynchronous
>     event FD
>   IB/uverbs: Extend CQ to get its own asynchronous event FD
>   IB/uverbs: Move QP, SRQ, WQ type and flags to UAPI
>   IB/uverbs: Introduce create/destroy SRQ commands over ioctl
>   IB/uverbs: Introduce create/destroy WQ commands over ioctl
>   IB/uverbs: Introduce create/destroy QP commands over ioctl

Applied to for-next

Thanks,
Jason
