Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37F943AF94D
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 01:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbhFUXbb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Jun 2021 19:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbhFUXba (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Jun 2021 19:31:30 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3ACC061574
        for <linux-rdma@vger.kernel.org>; Mon, 21 Jun 2021 16:29:14 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id r19so8372166qvw.5
        for <linux-rdma@vger.kernel.org>; Mon, 21 Jun 2021 16:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WGIQy0LtKLkIE/rK0/0LmxIf0Yhw3y7s+bpYX0ZTb4E=;
        b=XkURmaeBNxY2KNIu+e3I7r7c8Mw2wNE/2QAVf2JLvg6H3Ao6a1CHuNZ3vZ9RBTFdKx
         H3HDY9NRafLjynlaVkG4PxqZXZk/v2PZSf4FNAtjAaDZ+6ONvHcsFIGONwVDeOf17HrF
         h4Z5tocnUYIAKpC3IQtgBEC1vGg2T8esb9cF9sxkRyXpR+nn2OjKipQdc2qiNBCYtMp5
         8yt3ntQEIkDMB6fEEsB9d5jku+rDz/qbvQ2tZqk6+/0aRqBqq05Onc+pKKb0R8HJo8Ai
         55y54osBIrECu/xwViWlwG2EaBg82LCP+kuA9VXzH9FS9l7AMz909JQzyaOkpt0gKptG
         0naA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WGIQy0LtKLkIE/rK0/0LmxIf0Yhw3y7s+bpYX0ZTb4E=;
        b=OWLEN3RxLVsAeRBXOQqnreeF84mn6gwCFGXJQu1UKNgHZ/5COhZXpZVeM81KBCp+d8
         +MJYBIUT2Htvl4aFV5YiUVcyrUWWZxhAKjvR2CN46jk0NcGB5WzUXFxBMJusg31vFBLj
         BeP9idv8mYBhLG4pMpDtfT4vIT+oR+0PtBcP1QVo0SrvytGekA2kY4NbRmhDAmc/Dz9v
         bzD5na9aLrbcuxbF3m+yz/qQ9zhUKdFsL88zZEHWZNcXbiJb+izh/Ie3XVBL9um2/oyR
         C/kVG7jIjuFqGUR+ZA+5JrlbFKitnlDLzwFuZB9gKbWf1TlItrO/8QgBsso41FP9sMjR
         4DMA==
X-Gm-Message-State: AOAM533+YttOWAYuojM/ElL4unegNI77e5elhRD5mncdH6AJ70Rf7qD/
        aYi4ezzneQZeHqnCJrgApt4rJA==
X-Google-Smtp-Source: ABdhPJzRTPsxAjXcsN31fYToN1kshtwgii2JxLBC8O2dnJ4kI8UL0Km8hvy0yekYsKCtQzKfourLAQ==
X-Received: by 2002:a0c:fd44:: with SMTP id j4mr22797061qvs.12.1624318153681;
        Mon, 21 Jun 2021 16:29:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.113.94])
        by smtp.gmail.com with ESMTPSA id t30sm10969084qkm.11.2021.06.21.16.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 16:29:13 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lvTLs-009tun-DJ; Mon, 21 Jun 2021 20:29:12 -0300
Date:   Mon, 21 Jun 2021 20:29:12 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg KH <gregkh@linuxfoundation.org>,
        Oded Gabbay <ogabbay@kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>, Doug Ledford <dledford@redhat.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Gal Pressman <galpress@amazon.com>, sleybo@amazon.com,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Tomer Tayar <ttayar@habana.ai>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 1/2] habanalabs: define uAPI to export FD for DMA-BUF
Message-ID: <20210621232912.GK1096940@ziepe.ca>
References: <20210618123615.11456-1-ogabbay@kernel.org>
 <CAKMK7uFOfoxbD2Z5mb-qHFnUe5rObGKQ6Ygh--HSH9M=9bziGg@mail.gmail.com>
 <YNCN0ulL6DQiRJaB@kroah.com>
 <20210621141217.GE1096940@ziepe.ca>
 <CAFCwf10KvCh0zfHEHqYR-Na6KJh4j+9i-6+==QaMdHHpLH1yEA@mail.gmail.com>
 <20210621175511.GI1096940@ziepe.ca>
 <CAKMK7uEO1_B59DtM7N2g7kkH7pYtLM_WAkn+0f3FU3ps=XEjZQ@mail.gmail.com>
 <CAFCwf11jOnewkbLuxUESswCJpyo7C0ovZj80UrnwUOZkPv2JYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf11jOnewkbLuxUESswCJpyo7C0ovZj80UrnwUOZkPv2JYQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 21, 2021 at 10:24:16PM +0300, Oded Gabbay wrote:

> Another thing I want to emphasize is that we are doing p2p only
> through the export/import of the FD. We do *not* allow the user to
> mmap the dma-buf as we do not support direct IO. So there is no access
> to these pages through the userspace.

Arguably mmaping the memory is a better choice, and is the direction
that Logan's series goes in. Here the use of DMABUF was specifically
designed to allow hitless revokation of the memory, which this isn't
even using.

So you are taking the hit of very limited hardware support and reduced
performance just to squeeze into DMABUF..

Jason
