Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 256342B0E77
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Nov 2020 20:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgKLTsQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Nov 2020 14:48:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbgKLTsP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Nov 2020 14:48:15 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766D0C0613D1
        for <linux-rdma@vger.kernel.org>; Thu, 12 Nov 2020 11:48:15 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id p12so4954214qtp.7
        for <linux-rdma@vger.kernel.org>; Thu, 12 Nov 2020 11:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jtGqagHdWHIKiLQB/K/IeYWX2Du9m+U2LUKTH6HjACk=;
        b=BoVCwck82f1Mty8NNE5rhbczJopS7N/3UrDi4l4C7hqVve/QoWyVMGbx1wVscCgsPL
         dXLAbmWGZfTIvCjA9jJhYD8XOjBp+vxBio2ZvZiY4g9+YEgSwy4bNTcfvgaEqYJX4c28
         4jEJGio4J9StyPtguhHvJ74bmRt9oCHmeehMkNna7p+ue0rZ6ymHAE4k3iPzQ80VpCux
         TuXV1ikvp29Cqn5DejTVsxaptaqVerMqKmb8wJCQPo5SMaKGhL9jlDcSUM1ss5DgL1t/
         wd8S01cD0WUIQg6zqKvplqI0rdin3vvBvHg1lb4IB4sHBd8RT7aE9HBGhKD5OfhV3FnT
         sVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jtGqagHdWHIKiLQB/K/IeYWX2Du9m+U2LUKTH6HjACk=;
        b=NEcIk15059pcMdXYwikdnEBH+kpt5nBQiP9ThJs/iw1pr6YddZflNC4i/vaY38R8Rz
         KkabOsBQn2q29CzZJelxOoz1ccJCEg5z+s8MFIrrrLc95EcmCdHGoPPIhTTVI312Fscm
         NJILp2PdQ4cxqXIfB80g1nsWUTWiB4ZLoCzEyummNve5tQwDeqUvjai5KRObUkI/9dig
         r976YcNMFU967yNjmt1FQYpYQzfpfXVr2HYUcntbS6zlGCW1jCrb4RMvTQSxfybUkKoY
         rD48uk42tx0oWx6Llehc/7xOepHPBnH9ErMP+FSC4DYUlh1sn0tDC0g+jaki13ra68I4
         MaBw==
X-Gm-Message-State: AOAM531IBR8SeRGQdMJQsEyDDmRfZMEqvng8u7sridnO2dHQuAWrTVZH
        cYdJnlnq+XuesMWMeNPBvG7TNQ==
X-Google-Smtp-Source: ABdhPJy0p13G7RO2Pbhs3lOLlqYQQ/tGl2+F6nlayxmQS7Xu/jAQFOp86pgI99Y8vzFF7BgklKQ5OA==
X-Received: by 2002:ac8:c2:: with SMTP id d2mr754424qtg.207.1605210494784;
        Thu, 12 Nov 2020 11:48:14 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id v78sm5895051qkb.128.2020.11.12.11.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 11:48:14 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kdIZp-0048M0-8w; Thu, 12 Nov 2020 15:48:13 -0400
Date:   Thu, 12 Nov 2020 15:48:13 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v4 0/5] Track memory allocation with restrack
 DB help (Part I)
Message-ID: <20201112194813.GV244516@ziepe.ca>
References: <20201104144008.3808124-1-leon@kernel.org>
 <20201112185951.GA981682@nvidia.com>
 <20201112192346.GB3483@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112192346.GB3483@unreal>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 12, 2020 at 09:23:46PM +0200, Leon Romanovsky wrote:
> On Thu, Nov 12, 2020 at 02:59:51PM -0400, Jason Gunthorpe wrote:
> > On Wed, Nov 04, 2020 at 04:40:03PM +0200, Leon Romanovsky wrote:
> >
> > > Leon Romanovsky (5):
> > >   RDMA/core: Allow drivers to disable restrack DB
> >
> > This stuff is never used
> 
> It is in use in mlx4/mlx5 QPs.
> https://lore.kernel.org/linux-rdma/20201104144008.3808124-2-leon@kernel.org/
> https://lore.kernel.org/linux-rdma/20201104144008.3808124-2-leon@kernel.org/#Z30drivers:infiniband:hw:mlx4:qp.c
> https://lore.kernel.org/linux-rdma/20201104144008.3808124-2-leon@kernel.org/#Z30drivers:infiniband:hw:mlx5:qp.c

Well send it with that series

> > >   RDMA/cma: Be strict with attaching to CMA device
> >
> > This adds a return 0 which is pointless..
> 
> It will be used after I will resubmit patch "RDMA/restrack: Add error
> handling while adding restrack object" and I'm working on it right now.

I think we will end up with add not being able to fail, so I want to
see this with the series that adds a failure

Jason
