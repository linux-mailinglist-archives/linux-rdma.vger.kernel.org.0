Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4759A3DDEB6
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Aug 2021 19:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbhHBRna (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Aug 2021 13:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbhHBRn3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Aug 2021 13:43:29 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B51C06175F
        for <linux-rdma@vger.kernel.org>; Mon,  2 Aug 2021 10:43:18 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id b6so12339154lff.10
        for <linux-rdma@vger.kernel.org>; Mon, 02 Aug 2021 10:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zt3QYvOtMK3aS7Kre24BdNWSKzeAXGFSPj9ug3bpWP0=;
        b=hMA1DAhxCAZWtvlxfR0ZwU3KkgRXhW1a2a9AsEf8rdXFCFLhWgGfnGfk1VKHiT2r/A
         bS9wyJzmch1Etufr4tbJnGtcoj/pUnQCC7GAgfwlMaN3sj9FYxFlHOFkWTIhmHbv9+Fx
         27SDVXopQVQsPPdYg9kqJ1XoR7tiCvqy72PaATIEm2jRkSjgP6rsf/zkVfp6lNaah07f
         Z+aY7B+iM9TzBaywp9Tri406hpOascBHlTQKRynET7X314VEqEdkRRfaq+gNtBI265Ql
         x8MgvD+sEA3lAgrR62Ysw3RiL6FkuRq82Ljyyy0p7A2AwYmKSEIsG6kTmmnGacMBMv8C
         EShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zt3QYvOtMK3aS7Kre24BdNWSKzeAXGFSPj9ug3bpWP0=;
        b=AchVj92zf8Kn7POj7ajlLwNU90/AL08HzEH81DD0QaGbiHYjytA09XU4TfFE0b5LNy
         mav2rf6q0FU1UMnEuhzoWtA+rRgtlebcY/pjd9nfk5ui40MS/9Elq4oab9GjWOMumzQA
         q7ENh7s/K+OIoFtIUF8hb7P2yQHOeLyC0wtydhTVHE7pqdN/C/TBWUEZWfs908/ajfaw
         xNl2MrO6ot7YcIALA99ZbXoHghzsRr1lTB9p3fiU19m6xcPteOUQCpKxyDJcgtYf4nAO
         e3FyIlGiPMw9pH5xYwVSV8kY24nBliEVMgF6lxGYM6ER0LdIJ59kdUk07rrSjh+S2Q9v
         bDrA==
X-Gm-Message-State: AOAM5301PJhB6e8wPzqBJN0a+YEVXBZ+cASfPhTea6Mqx/k0V2HdHg4T
        9fXA8/IyOHgNdtQYD3Sm6G32x6S0IjIjOWmhM0EN3Q==
X-Google-Smtp-Source: ABdhPJzQd5B0p+XfwRaIxUCp1VTH4WY8jU58h9m5zxxi2z85fBQ9Ejzu9HHHigxDoBveqYg5yQ66qVesC+3STL8kWx4=
X-Received: by 2002:a05:6512:537:: with SMTP id o23mr13060435lfc.58.1627926196515;
 Mon, 02 Aug 2021 10:43:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210730131832.118865-1-jinpu.wang@ionos.com> <20210730131832.118865-10-jinpu.wang@ionos.com>
 <YQee8091rXaXU4vL@unreal> <CAJpMwyj6SjO+yNsA9uMDZP1Cu2gUfXHAeRGgaGf46xbxDBrk5g@mail.gmail.com>
 <YQge6yQTILQsQECO@unreal>
In-Reply-To: <YQge6yQTILQsQECO@unreal>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Mon, 2 Aug 2021 19:43:05 +0200
Message-ID: <CAJpMwygeu=LYdTWMHxWYHMe_==yHxB_KEsTstH3CWOaMWu0sgQ@mail.gmail.com>
Subject: Re: [PATCH for-next 09/10] RDMA/rtrs: Add support to disable an IB
 port on the storage side
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jack Wang <jinpu.wang@ionos.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 2, 2021 at 6:36 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Mon, Aug 02, 2021 at 04:31:01PM +0200, Haris Iqbal wrote:
> > On Mon, Aug 2, 2021 at 9:30 AM Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > On Fri, Jul 30, 2021 at 03:18:31PM +0200, Jack Wang wrote:
> > > > From: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> > > >
> > > > This commit adds support to reject connection on a specific IB port which
> > > > can be specified in the added sysfs entry for the rtrs-server module.
> > > >
> > > > Example,
> > > >
> > > > $ echo "mlx4_0 1" > /sys/class/rtrs-server/ctl/disable_port
> > > >
> > > > When a connection request is received on the above IB port, rtrs_srv
> > > > rejects the connection and notifies the client to disable reconnection
> > > > attempts. A manual reconnect has to be triggerred in such a case.
> > > >
> > > > A manual reconnect can be triggered by doing the following,
> > > >
> > > > echo 1 > /sys/class/rtrs-client/blya/paths/<select-path>/reconnect
>
> <...>
>
> > >
> > > And maybe Jason thinks differently, but I don't feel comfortable with
> > > such new sysfs file at all.
>
> This part is much more important and should be cleared before resending.

Agreed. I will wait for Jason to respond.

>
> > >
> > > Thanks
