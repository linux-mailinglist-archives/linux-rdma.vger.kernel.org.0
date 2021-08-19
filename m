Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7713F2382
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Aug 2021 01:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbhHSXGl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Aug 2021 19:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhHSXGl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Aug 2021 19:06:41 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371E1C061575
        for <linux-rdma@vger.kernel.org>; Thu, 19 Aug 2021 16:06:04 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id t66so9092743qkb.0
        for <linux-rdma@vger.kernel.org>; Thu, 19 Aug 2021 16:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lUX7epF7foRJPnJW8zAvGrpG9sbsCy+8eUVnLXUioaw=;
        b=k/GgjG+KGvsRHDTaR/VlVvRNrfg9uPX5JU23M6lnlFazEhBaLpFG2yLgIA5DjuqITc
         ZtITYZTtiD4QoA9YVBs+h0X1AVz3p2dPiahcKu4x64AcrhVQXiJIob4kXZsFDqfHLPEH
         MDAy0kMdT7vfNS453Pn3keQ8XOV6pBw+XrZ9JH3zS6LTaGidh2NOFMUyf6POnFxjJjMV
         dteg7esI3k4ovVAkSAOQhtzZ0/kyjPmh1I1TnfpWjWVKuXx7m8P9gtlyRFtfWMupn+rj
         +p4DvEIaviEiwP7Tg+vxG/hXWAG9QrvF2o7GcnaIaJ8USAjvXaOGmBneEWy8U7uYSyyp
         KRiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lUX7epF7foRJPnJW8zAvGrpG9sbsCy+8eUVnLXUioaw=;
        b=MzePw3lK1n84BoCQr+TqnpJmyPIp4OsZ5u391Wlo1PYO7HMmYitXokEro6jvw3ZuKg
         f4pOZ15hrQzn9vfQkfLOacB4cfrXJe9ict/q1gOqxzU3zVoeP0E8TkZ8zN+LVUnnBCbV
         BhkxwY3b62xhCzDStU2rspBQ4m4vsoovmX8VRHeybQBSxteQ/UVZr4mSM/rLf4+Es7yi
         H2RRTNsW8QxMo3qLMhgxsFe/wKuLkDliBNz8ztCXzwNxsTs8SN6DmbuCaySRw1BYW/p5
         mmw2W1jpETisJLxuP7cfFKi4zELTm9JVeOLwiTV8LJ0JCd5io+ra4xTBB5Y7Jk2SuwEK
         +8OA==
X-Gm-Message-State: AOAM532ihKw1Kuz+6DFWLUcKkSyFpLrSdg8yUWn2vXY0iiJifapiPWBg
        2cNdAKNxWQIC5FK+/+I4irPiMQ==
X-Google-Smtp-Source: ABdhPJy/ltQJWz3bEvwivJHVegVN2SJG5oJXKMzn032Cjp7qnG0C8JFFt9RanDCCQRXqWfZ4YPIPmA==
X-Received: by 2002:a37:2753:: with SMTP id n80mr5973504qkn.223.1629414363407;
        Thu, 19 Aug 2021 16:06:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id n20sm2401213qkk.135.2021.08.19.16.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 16:06:02 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mGr6o-001dOi-8m; Thu, 19 Aug 2021 20:06:02 -0300
Date:   Thu, 19 Aug 2021 20:06:02 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Gal Pressman <galpress@amazon.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
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
        Jianxin Xiong <jianxin.xiong@intel.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [RFC] Make use of non-dynamic dmabuf in RDMA
Message-ID: <20210819230602.GU543798@ziepe.ca>
References: <20210818074352.29950-1-galpress@amazon.com>
 <CAKMK7uGZ_eX+XfYJU6EkKEOVrHz3q6QMxaEbyyD3_1iqj9YSjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uGZ_eX+XfYJU6EkKEOVrHz3q6QMxaEbyyD3_1iqj9YSjw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 18, 2021 at 11:34:51AM +0200, Daniel Vetter wrote:
> On Wed, Aug 18, 2021 at 9:45 AM Gal Pressman <galpress@amazon.com> wrote:
> >
> > Hey all,
> >
> > Currently, the RDMA subsystem can only work with dynamic dmabuf
> > attachments, which requires the RDMA device to support on-demand-paging
> > (ODP) which is not common on most devices (only supported by mlx5).
> >
> > While the dynamic requirement makes sense for certain GPUs, some devices
> > (such as habanalabs) have device memory that is always "pinned" and do
> > not need/use the move_notify operation.
> >
> > The motivation of this RFC is to use habanalabs as the dmabuf exporter,
> > and EFA as the importer to allow for peer2peer access through libibverbs.
> >
> > This draft patch changes the dmabuf driver to differentiate between
> > static/dynamic attachments by looking at the move_notify op instead of
> > the importer_ops struct, and allowing the peer2peer flag to be enabled
> > in case of a static exporter.
> >
> > Thanks
> >
> > Signed-off-by: Gal Pressman <galpress@amazon.com>
> 
> Given that habanalabs dma-buf support is very firmly in limbo (at
> least it's not yet in linux-next or anywhere else) I think you want to
> solve that problem first before we tackle the additional issue of
> making p2p work without dynamic dma-buf. Without that it just doesn't
> make a lot of sense really to talk about solutions here.

I have been thinking about adding a dmabuf exporter to VFIO, for
basically the same reason habana labs wants to do it.

In that situation we'd want to see an approach similar to this as well
to have a broad usability.

The GPU drivers also want this for certain sophisticated scenarios
with RDMA, the intree drivers just haven't quite got there yet.

So, I think it is worthwhile to start thinking about this regardless
of habana labs.

Jason
