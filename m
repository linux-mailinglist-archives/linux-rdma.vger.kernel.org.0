Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC35378EA6
	for <lists+linux-rdma@lfdr.de>; Mon, 10 May 2021 15:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240780AbhEJNXG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 May 2021 09:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343658AbhEJMOI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 May 2021 08:14:08 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E772C0612EA
        for <linux-rdma@vger.kernel.org>; Mon, 10 May 2021 05:07:08 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2so22978117lft.4
        for <linux-rdma@vger.kernel.org>; Mon, 10 May 2021 05:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QvZsXwdzWair1nAvybVvnt+mffaSYKaI0smFVVcSaM8=;
        b=Xf9IAnDVO23XTX3sypiGCiiSTxeA9Uybsy6g5IM+NzeNeGZxnSFRuu33qdMR39T2hg
         IGha8lO56UgkP+7zN5ega6jl6zd6eZJ9bLdObGCRHcN7vu+4wwzwCVH5YdPEqefwqHcD
         SKDr04Q7OE91oFsgi6sgcFGoNAG1qeqRNGV8I7yFaZyVactJW77+YAP9tmRfC9L1seOG
         2fBJg7x7+0HUkH70QkDIGy34iPloq4R7fxI9VFjgdxtYkXoDlF+Dzpek97Rhmhcj8u2f
         DPZVyhq1W31v2lowdwSY87S4fj9Z0nwdu9zYR9EiQv7uToUswwpwzKl7dImkkcy3L2yU
         0WLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QvZsXwdzWair1nAvybVvnt+mffaSYKaI0smFVVcSaM8=;
        b=Jh7kF8iQrZN8ksLsQAGYC9ALptEvpxb1krqS73agWs1sW0vd/OgNwe/n/JRtgg/w/R
         0RD42a+P8e5F+Sy4oUeFtFpD0sEJYQOH9DmvKFChsOnh29cz7oRKb5hkiiSkYFQXqOZu
         C32YFwbInDmbDO8fFsKKslPBpdTDSnkFve+OvF3xrusyuT7/5lv8hCXye6+hya6uParu
         uZck6ntFaiXXWZ5emXrrPy7q4mJpDWzzBE/RyvLHv43OktZs1RtH3TG9nMVJfJMQ88go
         DLdPMoMge/Drg7undAzY5+6cRoOwOPAPStlI5pCAYMuuHjXPvnkWlVZ6gMFwPbHcdeQQ
         QmGg==
X-Gm-Message-State: AOAM5303RolBkLqPvndNH6vKKripHNWWx8PhGi84jPRisonFRWUEVpEj
        j4Xt2VQcmmAIDfPnkm5/IX7hiumClE6a0bx5JcJewQ==
X-Google-Smtp-Source: ABdhPJxHMIMSwGujHeovQDXLF5mCz5AI4ncOEkje56YJkefAlsUYfKrtgWBhwbrt0nH36Me7JJYP3F4L7CZ79s3T4V0=
X-Received: by 2002:ac2:5631:: with SMTP id b17mr16178232lff.58.1620648426660;
 Mon, 10 May 2021 05:07:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210503114818.288896-1-gi-oh.kim@ionos.com> <20210503114818.288896-4-gi-oh.kim@ionos.com>
 <YJfGcFlJCHrf2quT@unreal> <CAJpMwyiXbqTK-pB=nQ4sfzXeeo8=dd5KJVZ_57apGF5cbpM5dA@mail.gmail.com>
 <YJkerTfjpXOGW7X+@unreal>
In-Reply-To: <YJkerTfjpXOGW7X+@unreal>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Mon, 10 May 2021 14:06:55 +0200
Message-ID: <CAJpMwyitTn2oFxyWwr+bnFh3cQDdPwmN8L8JKPnBGqMc4a1aiw@mail.gmail.com>
Subject: Re: [PATCH for-next 03/20] RDMA/rtrs-clt: No need to check
 queue_depth when receiving
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Gioh Kim <gi-oh.kim@ionos.com>, linux-rdma@vger.kernel.org,
        bvanassche@acm.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jinpu Wang <jinpu.wang@ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 10, 2021 at 1:53 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Mon, May 10, 2021 at 01:00:33PM +0200, Haris Iqbal wrote:
> > On Sun, May 9, 2021 at 1:24 PM Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > On Mon, May 03, 2021 at 01:48:01PM +0200, Gioh Kim wrote:
> > > > From: Gioh Kim <gi-oh.kim@cloud.ionos.com>
> > > >
> > > > The queue_depth size is sent from server and
> > > > server already checks validity of the value.
> > >
> > > Do you trust server? What will be if server is not reliable and sends
> > > garbage?
> >
> > Hi Leon,
> >
> > The server code checks for the queue_depth before sending. If the
> > server is really running malicious code, then the queue_depth is the
> > last thing that the client needs to worry about.
>
> Like what? for an example?

Like accessing compromised block devices. If the queue_depth is
garbage, the client would fail at allocation with ENOMEM; thats it.

>
> Thanks
