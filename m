Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77ED929DAEF
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Oct 2020 00:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbgJ1Xil (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Oct 2020 19:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390564AbgJ1Xhf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Oct 2020 19:37:35 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5AEC0613CF
        for <linux-rdma@vger.kernel.org>; Wed, 28 Oct 2020 16:37:34 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id g25so456581edm.6
        for <linux-rdma@vger.kernel.org>; Wed, 28 Oct 2020 16:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ki+Ts9WKcCq40vX0E5rPi4mRWX8BE4sWZrihaMXRb7g=;
        b=NTNS3xhYiThv5AiuO5UDhrHOnw5VCnYAvwXB7jjq0zfMjHu7n7O4LVCi/oOA9RaziR
         6VCUp6Ig5apT+1Ex/2cgMk1LLZYC7capZxQPreHKfEvUIjhg/nLhKjQoKfZ/onR1qZCA
         zoVhSOGo7BscXno+Vy0o8of31fVKfOZmBexOqWQPIMVvVc4rh3jCPICSoJ+brrnwbbv3
         BnuVTAiWfn1fBDr7UKrJAGLAhX/I4j2yMyVVEgsYSfQ1m+yRe9zM8tx44DTKKVKiOfGz
         YRINgQUnT6Yxkw4yDRvXHcQJnZEbPApFAkZps0+oLrIFB8xfm6scd5OQ4reQhFxt1XHk
         iErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ki+Ts9WKcCq40vX0E5rPi4mRWX8BE4sWZrihaMXRb7g=;
        b=jaHg4uDFmGLW9lltDq2WGLNpkQz6rVvSdbxW5FVyTknPiyM47XkaVAHc8gSaMkpOc3
         HLJ4YfKy+/FC6XXlTrkhznQe1XQVzF4BLEHHQiXUZgGJKGEx6B0lCV/6WfPClvrjOg4R
         LOwIPjt2pOh25rkbtS475DWlVStLcXlS09InLneZvOu8N8+AmMrurXh2Zsbjs4gXRqfP
         qGcFadUJFFvRU/BErONF4tQlqUq1GVos/nd+A4ev0D67e+qAQrT5SUuEjgFWaTNsoZGS
         5rpnIKPU295ZtV29nIXj5bg/8bvP1GCBzfXQ9ft5+JVsagfzVqh906i+uICxSumZGWWD
         mEyQ==
X-Gm-Message-State: AOAM531dsTlEExe4faXe3G5MsqMrMgvSYGL2JDCLsHUnAAUH2wfY5org
        9tWZVgQDMrnDffNfeYLq2kYP0iidhmy8dUEyl9MCnTuL8YzETQ==
X-Google-Smtp-Source: ABdhPJypa7/FW2Ldanl3eHfEyTIia5wXvIQvT38PzNyrCGwSRJTStqNY3jundbwNOyUp8FPEUSojU6iOHTz53YfWxh0=
X-Received: by 2002:aa7:c984:: with SMTP id c4mr7787222edt.42.1603894095174;
 Wed, 28 Oct 2020 07:08:15 -0700 (PDT)
MIME-Version: 1.0
References: <20201013074342.15867-1-jinpu.wang@cloud.ionos.com>
 <20201028134419.GA2417977@nvidia.com> <CAMGffE=Hm7LNTS1iACZDMg77uP3xG=K0yM4qMjgj9A12E9OL=A@mail.gmail.com>
 <20201028135346.GW1523783@nvidia.com> <CAMGffE=9j+yWXhWj+X2XVYm018GBwOw4ZZxQ5GYs-rwrW4q3Kg@mail.gmail.com>
 <20201028135929.GX1523783@nvidia.com>
In-Reply-To: <20201028135929.GX1523783@nvidia.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Wed, 28 Oct 2020 15:08:03 +0100
Message-ID: <CAMGffEmWLqVft9YKA2WoBbHcfD8_knbhsBxJneV9dGpJzwuAiw@mail.gmail.com>
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

On Wed, Oct 28, 2020 at 2:59 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Wed, Oct 28, 2020 at 02:57:57PM +0100, Jinpu Wang wrote:
> > On Wed, Oct 28, 2020 at 2:53 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > >
> > > On Wed, Oct 28, 2020 at 02:48:01PM +0100, Jinpu Wang wrote:
> > > > On Wed, Oct 28, 2020 at 2:44 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > > > >
> > > > > On Tue, Oct 13, 2020 at 09:43:42AM +0200, Jack Wang wrote:
> > > > > > Currently ipoib choose cq completion vector based on port number,
> > > > > > when HCA only have one port, all the interface recv queue completion
> > > > > > are bind to cq completion vector 0.
> > > > > >
> > > > > > To better distribute the load, use same method as __ib_alloc_cq_any
> > > > > > to choose completion vector, with the change, each interface now use
> > > > > > different completion vectors.
> > > > > >
> > > > > > Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > > > > > Reviewed-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
> > > > > >  drivers/infiniband/ulp/ipoib/ipoib_verbs.c | 4 ++--
> > > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > >
> > > > > If you care about IPoIB performance you should be using the
> > > > > accelerated IPoIB stuff, the drivers implementing that all provide
> > > > > much better handling of CQ affinity.
> > > > >
> > > > > What scenario does this patch make a difference?
> > > >
> > > > AFAIK the enhance mode is only for datagram mode, we are using connected mode.
> > >
> > > And you are using child interfaces or multiple cards?
> > we are using multiple child interfaces on Connect x5 HCA
> > (MCX556A-ECAT)
>
> Ok.. Do you think it would be better to change IPoIB to use the new
> shared CQ pool API?
>
> Jason
I thought about it, but CQ pool API doesn't work with IB_POLL_DIRECT,
ipoib is using NAPI,
and it's non-trivial to convert to CQ pool API. I'm not confident to
do it properly,
