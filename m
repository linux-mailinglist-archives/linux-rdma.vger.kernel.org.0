Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B053329DA53
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Oct 2020 00:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730721AbgJ1XUv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Oct 2020 19:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730768AbgJ1XUi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Oct 2020 19:20:38 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F04C0613CF
        for <linux-rdma@vger.kernel.org>; Wed, 28 Oct 2020 16:20:37 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id x1so1277584eds.1
        for <linux-rdma@vger.kernel.org>; Wed, 28 Oct 2020 16:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/ioNhnXeXqy8+93/P5c3+qXM8BhksYgDuwx5MCF+Ej0=;
        b=Hm/41DpcUPE8vCOIks9/+zAs4ozXRdKhBVIgnMITxmWqQ10zBstzXUBNwFzthfY8e8
         Yi0B4o9SNcAXiE4XFEM1emU2mFa3UMej2rqcTS2G8bYH9RWk6ezgJWBh4tI11+tqMr3r
         InkLBytP086dRIeytanMIgXAnjapN9R7Z+r42/spfHAxqa2Ifr5bYU7ydhV5sh56cDth
         9FSoCkssys0/yoCHcQznCMKFCYZ/eN+AgbkSlBaJH0tG5C9mZC3N6aJ+A20QVrtJUKhq
         eG7zPPbWDrXIrWl2c6Ay2smLIOs1mDxSUZSrjA3S0tZcYniOFDw6GRBj+ZrDaU0+kaWD
         8GEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/ioNhnXeXqy8+93/P5c3+qXM8BhksYgDuwx5MCF+Ej0=;
        b=ksuoNZREjOPbsDMO3JSNELnxBpHk6hD+v4V7ntRMnqB8g77fZQChzdhN09+jNhqDFj
         ZD5/Q2K8fQoDB50IBFxTVTKkoWbyI87mqYaSpfbcQSdDdCakwavJBVxmvmYv2gnYvq+2
         LjbcK8RipIR2t63OZzExv2LBLkrvvT/xn9YWrYQfJLFNyHEvOPhSxBraxjAkXsZOqQC+
         DA+7WwNU5BO/tmpvWquOFDOdrm2OyXB0aqarX2sxglYNaWBTj03LFKYSphA37cDHvCG5
         EHgwid06ONlbn+Wa5ttL4JUTRTdHuagt4FysYmxwFCAho7FScYbPOnkpOVQONTdp3383
         uBeQ==
X-Gm-Message-State: AOAM532UkdrTe3457gfRWsXZbrNNxqkQAtczJj2zR/0XueC9FcW8x9kq
        yq1nrWao00jC7RFeMkS+T3+UPROzPHwD2LpcjNmFSeKm0Wq0jg==
X-Google-Smtp-Source: ABdhPJzmTg+yP3RVJBxKyRTct8UXjuce1OybtOJ8iuQU8nycmL4IDY9OY2MTydHDGCz4Ql3bV9/vL0bf5e6Np8pxGeA=
X-Received: by 2002:aa7:db82:: with SMTP id u2mr8000037edt.262.1603893487889;
 Wed, 28 Oct 2020 06:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <20201013074342.15867-1-jinpu.wang@cloud.ionos.com>
 <20201028134419.GA2417977@nvidia.com> <CAMGffE=Hm7LNTS1iACZDMg77uP3xG=K0yM4qMjgj9A12E9OL=A@mail.gmail.com>
 <20201028135346.GW1523783@nvidia.com>
In-Reply-To: <20201028135346.GW1523783@nvidia.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Wed, 28 Oct 2020 14:57:57 +0100
Message-ID: <CAMGffE=9j+yWXhWj+X2XVYm018GBwOw4ZZxQ5GYs-rwrW4q3Kg@mail.gmail.com>
Subject: Re: [PATCH] RDMA/ipoib: distribute cq completion vector better
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 28, 2020 at 2:53 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Wed, Oct 28, 2020 at 02:48:01PM +0100, Jinpu Wang wrote:
> > On Wed, Oct 28, 2020 at 2:44 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > >
> > > On Tue, Oct 13, 2020 at 09:43:42AM +0200, Jack Wang wrote:
> > > > Currently ipoib choose cq completion vector based on port number,
> > > > when HCA only have one port, all the interface recv queue completion
> > > > are bind to cq completion vector 0.
> > > >
> > > > To better distribute the load, use same method as __ib_alloc_cq_any
> > > > to choose completion vector, with the change, each interface now use
> > > > different completion vectors.
> > > >
> > > > Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > > > Reviewed-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
> > > >  drivers/infiniband/ulp/ipoib/ipoib_verbs.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > If you care about IPoIB performance you should be using the
> > > accelerated IPoIB stuff, the drivers implementing that all provide
> > > much better handling of CQ affinity.
> > >
> > > What scenario does this patch make a difference?
> >
> > AFAIK the enhance mode is only for datagram mode, we are using connected mode.
>
> And you are using child interfaces or multiple cards?
we are using multiple child interfaces on Connect x5 HCA (MCX556A-ECAT)
ibstat
CA 'mlx5_0'
CA type: MT4119
Number of ports: 1
Firmware version: 16.28.2006
Hardware version: 0
Node GUID: 0x98039b03006c7912
System image GUID: 0x98039b03006c7912
Port 1:
State: Active
Physical state: LinkUp
Rate: 40
Base lid: 38
LMC: 0
SM lid: 4
Capability mask: 0x2651e848
Port GUID: 0x98039b03006c7912
Link layer: InfiniBand
CA 'mlx5_1'
CA type: MT4119
Number of ports: 1
Firmware version: 16.28.2006
Hardware version: 0
Node GUID: 0x98039b03006c7913
System image GUID: 0x98039b03006c7912
Port 1:
State: Active
Physical state: LinkUp
Rate: 40
Base lid: 134
LMC: 0
SM lid: 224
Capability mask: 0x2651e848
Port GUID: 0x98039b03006c7913
Link layer: InfiniBand

>
> Jason
