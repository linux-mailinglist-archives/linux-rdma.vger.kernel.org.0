Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C68229DA4D
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Oct 2020 00:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbgJ1XTC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Oct 2020 19:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728198AbgJ1XTB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Oct 2020 19:19:01 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F85C0613CF
        for <linux-rdma@vger.kernel.org>; Wed, 28 Oct 2020 16:19:01 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id y16so1112767ljk.1
        for <linux-rdma@vger.kernel.org>; Wed, 28 Oct 2020 16:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qieTkvdIer1mmTA55BrIOzN5Ma5axxSojXdZdE9NseA=;
        b=JthFpm+AuxNtGJLMjHt6RruQ7bB7nJRRwBWlG21GyPsuYFzlKXCOBJ9o6TwE/ox/ir
         alqPTMh4aNTno7TbNCW2bsyyA33mm9HepaUXAkHENBbX0v/KvENQk3U3EHJb0vQWHqr3
         QpoQmSVWHqQ0YQZ5Rz9cjipRNxO+zfoO2j9ikWhd3ObuxQHXonCIzyDd6PUguHAAlUr0
         k0jtG7rPmr4HdFhPv7NDgLtZCD+bAi4Rl+tbE7L7nJwh9aDLZutSoru0YEGmXU/P2Ffa
         UGWHdtGftnKYsAbjC4qxA3154Pf/gT9XxZ9G6XrXa5H2fLp1eKb9O7v3hXdgJKSLOG3R
         4vgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qieTkvdIer1mmTA55BrIOzN5Ma5axxSojXdZdE9NseA=;
        b=g1/BCkfe93C3+V0VPNZppMuO6VQy/EaQNfYnBR1WCUUSs8gLcrguw+DxxwiIb7F0T+
         6kLNTrj4mpI53uHtYrNaW+qfey//5KE5nYGch8yyYQUgqC1uqcldLG82lOZo770y4ZLR
         Ke5hKmASLjrZGmybb7MDcWqo+MG8DYqzmUSVEz9x22ujTnNLT/QEdYw39OmjD/WmApEe
         auZViXVPSRI+dy51N1tMen4EXnfamczd/8ZTn6/LDS4qpvp/62/nf533jGWn6apL4mLE
         g71IUCyTc4YPnkN/lA4Ra751BiXNgQancxOAugsNxPEWtfM1DSMk6hXxoPHSisDUTBar
         mnbw==
X-Gm-Message-State: AOAM530kbfBXthdavJHEayDb6Bb3CCp5niOZVSnMyeK0NLsnZemkVxyA
        DnEJJE3dSCmSYX89dfncp/INI3YCkX4+Urt4c1ALEbYu6T8=
X-Google-Smtp-Source: ABdhPJxTZJji3NwXNaNuR1n1AFJLMGurr/KFZGviqXjtsjlxiGHEHMfOU9QEFbZ0FzaVilqkZ/fn9EK4QVNSK4UnywA=
X-Received: by 2002:a50:ec02:: with SMTP id g2mr7978549edr.104.1603892892770;
 Wed, 28 Oct 2020 06:48:12 -0700 (PDT)
MIME-Version: 1.0
References: <20201013074342.15867-1-jinpu.wang@cloud.ionos.com> <20201028134419.GA2417977@nvidia.com>
In-Reply-To: <20201028134419.GA2417977@nvidia.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Wed, 28 Oct 2020 14:48:01 +0100
Message-ID: <CAMGffE=Hm7LNTS1iACZDMg77uP3xG=K0yM4qMjgj9A12E9OL=A@mail.gmail.com>
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

On Wed, Oct 28, 2020 at 2:44 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Tue, Oct 13, 2020 at 09:43:42AM +0200, Jack Wang wrote:
> > Currently ipoib choose cq completion vector based on port number,
> > when HCA only have one port, all the interface recv queue completion
> > are bind to cq completion vector 0.
> >
> > To better distribute the load, use same method as __ib_alloc_cq_any
> > to choose completion vector, with the change, each interface now use
> > different completion vectors.
> >
> > Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > Reviewed-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
> > ---
> >  drivers/infiniband/ulp/ipoib/ipoib_verbs.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>
> If you care about IPoIB performance you should be using the
> accelerated IPoIB stuff, the drivers implementing that all provide
> much better handling of CQ affinity.
>
> What scenario does this patch make a difference?

AFAIK the enhance mode is only for datagram mode, we are using connected mode.

Thanks!
