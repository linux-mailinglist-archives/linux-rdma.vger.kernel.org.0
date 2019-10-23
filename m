Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74400E1E2F
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Oct 2019 16:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392229AbfJWOad (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Oct 2019 10:30:33 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35652 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389521AbfJWOad (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Oct 2019 10:30:33 -0400
Received: by mail-qt1-f193.google.com with SMTP id m15so32656522qtq.2
        for <linux-rdma@vger.kernel.org>; Wed, 23 Oct 2019 07:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yx3Mvj+WA5H4oqlUaBce1afpJ7dufyimQH74NGeTi8A=;
        b=N1H4C4952aF6tczYr5iS6VGjnaUQfVXgYHoz4nP1Eezwuuu5cuQXYkgI6L0nRPy2ns
         F85nK4r0eVNMwnoTHRvWvkVNGt96OLbirm8G2dR+0hM9g0i2sPlc5ziK0TWwUqthOd25
         5ebLH9qxblcdDcR/p3NlrfiwAM7AbBKCWLKVg0XZp0OcSroHzCQRDV7QvkGp3F9yBuex
         0AggDDNn7+LXTntQwu/9IVg4aY9o7XFDAHeQxAJZguO0HAA/8dmV6uHzHtah7r8EuWxe
         HRllwUbw61TXIhRCTOwGO8SqkJeIJyLPYmlb6NjIS4KdriUGx4CFu3KMIUkHv43H8TvY
         3Pgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yx3Mvj+WA5H4oqlUaBce1afpJ7dufyimQH74NGeTi8A=;
        b=dh5QwaNBEtWlCG30mmiwO9DivQ/5Du1g1zC+Wrm1RkJrlf7kGNTvETAGPpNyCLhD6M
         W8QuftOmxjzmsC3IntM1QE/msqtZBSHiDNXpmSFA4zJn3DBFjhlY4uot9wH6hswddaB5
         LCRl0PRb5U13UK1ZCd9iKo/QhaMA/Dwhp437+4u1V3Wr0BLvho5CBxDj/wCQPtlLb/qd
         kuBfjjDySG0uGdJAe+VFB9Xp99G7IR64Gx+ThdZqvKNvs+bRQ9ghld76Zbc/t8GPXiCm
         K0WzhstZArvJxB42RcdgZPdmoPDgZzVd6kEFj2ROa2j5wepgwHdIrx6Jl/SQvYNkfdiE
         SbcQ==
X-Gm-Message-State: APjAAAWnUb1Gx9Jn/cqYesp5mTXwnNd6VBPTjAt6zYfwQhXodmcUGB/m
        55BrBwfxfpY9nZ2YyUV+/XqvaF2QvHs=
X-Google-Smtp-Source: APXvYqzjZGtga0izbp/7/IjBNakFW1RYQCdJWMNVBOEkWiJeyH1Y6rep+9L3KofFUOc9mDrEtdOxLQ==
X-Received: by 2002:ad4:50a5:: with SMTP id d5mr9063774qvq.38.1571841031439;
        Wed, 23 Oct 2019 07:30:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id j7sm17428432qtc.73.2019.10.23.07.30.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Oct 2019 07:30:30 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iNHef-0003CA-QP; Wed, 23 Oct 2019 11:30:29 -0300
Date:   Wed, 23 Oct 2019 11:30:29 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Yuval Shaia <yuval.shaia@oracle.com>, bharat@chelsio.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH] iw_cxgb3: Remove the iw_cxgb3 provider code
Message-ID: <20191023143029.GI23952@ziepe.ca>
References: <20191022174710.12758-1-yuval.shaia@oracle.com>
 <ba91bb6c42e18e72cd6eaa705067a9cb30a02853.camel@redhat.com>
 <20191022175821.GB23952@ziepe.ca>
 <20191023054802.GI4853@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023054802.GI4853@unreal>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 23, 2019 at 08:48:02AM +0300, Leon Romanovsky wrote:
> On Tue, Oct 22, 2019 at 02:58:21PM -0300, Jason Gunthorpe wrote:
> > On Tue, Oct 22, 2019 at 01:57:18PM -0400, Doug Ledford wrote:
> > > On Tue, 2019-10-22 at 20:47 +0300, Yuval Shaia wrote:
> > > > diff --git a/kernel-headers/rdma/rdma_user_ioctl_cmds.h b/kernel-
> > > > headers/rdma/rdma_user_ioctl_cmds.h
> > > > index b8bb285f..b2680051 100644
> > > > +++ b/kernel-headers/rdma/rdma_user_ioctl_cmds.h
> > > > @@ -88,7 +88,6 @@ enum rdma_driver_id {
> > > >         RDMA_DRIVER_UNKNOWN,
> > > >         RDMA_DRIVER_MLX5,
> > > >         RDMA_DRIVER_MLX4,
> > > > -       RDMA_DRIVER_CXGB3,
> > > >         RDMA_DRIVER_CXGB4,
> > > >         RDMA_DRIVER_MTHCA,
> > > >         RDMA_DRIVER_BNXT_RE,
> > >
> > > This is the same bug the kernel patch had.  We can't change that enum.
> >
> > This patch shouldn't touch the kernel headers, delete the driver, then
> > we will get the kernel header changes on the next resync.
> 
> If you are doing that, can you please delete nes provider too?
> Maybe ipathverbs too?

ipathverbs is qib, iirc

Jason
