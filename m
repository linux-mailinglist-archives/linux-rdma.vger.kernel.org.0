Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5AE2D711E
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Dec 2020 08:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391519AbgLKHyg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Dec 2020 02:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728909AbgLKHy0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Dec 2020 02:54:26 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2843FC0613CF
        for <linux-rdma@vger.kernel.org>; Thu, 10 Dec 2020 23:53:46 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id n26so11060620eju.6
        for <linux-rdma@vger.kernel.org>; Thu, 10 Dec 2020 23:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=epQKKcZOGNR5hbwa/g5zP+9rGI/fAihJIw4rWq/4v6A=;
        b=TPbaR1EEtRSVb+05szASxtF54oA1yXEuhY4WSeTuDZAbF8xl9T75zXwSk0EHoWE6h+
         JdfGtzfkzK94rACQlRWulgjcXxfgNeWiOOGGNi3eXBvI2mvDxMHBw3HRCom+a4J8CXdJ
         B2moystgCLG68L5eM8QeV4xCrDkf50FcZN9NUwXOIcoMgDujxhYL8pxbD9MIv/cqe/uc
         EO9umvQ+agcVIbV9guqffWLRx6JhtskcRIpRoTpze3iu8MkuLxFGA4pnLTfadAo08xTy
         aaryfkwJswVI3yD4o1YaoLbdZ9s0AdPdIZNsx65DAHMCNA0oFmFdOSL+xc7Fv5NqZXQy
         Zfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=epQKKcZOGNR5hbwa/g5zP+9rGI/fAihJIw4rWq/4v6A=;
        b=Xdf6/azrfLzxgVmxrSYBka4Nj4etf5fHFzlK29p54RANE2FDlWXwsNYgRa2lgB+84v
         3qwzRCN94iVxoR+AjIe4x4eqzgSqjSh68VLQ2Hlg4YSm/SQisk79EF7/memZWpxLDIXh
         W43SUa7oHDunotHW1e9YraCgJONmu5leaSspKB011jfQ8e+PhttAgGCN0U2ZcWD8VZv5
         7r3asuDpyQSrih/sFTKiwDiPpQI+zxCXZHnIuGT5kHPLfnFSWja3agWWu3A332zI014E
         uwWdQskKMONftgbpwfnhKKUnZJlO4zW+kbvobSZpTmfn58A4ADmo2lg/3j6Yb8bMH2G2
         LyPg==
X-Gm-Message-State: AOAM5308X9U8H2Bo+DKv0Ene9kX9pIFv6Wvhz0XAlA4o7Pdy4WgwhiML
        +YYpw60z25rlyobmKtQsjZOQ2x6sTiyxQfF+rDngUw==
X-Google-Smtp-Source: ABdhPJwzq0OTfFu/SquNRrbU/pFKdyKiuI1ZfxAiqRFQm1QkYceia8u0Zcs7WFJB2ozl8SJeOzJlWd6d7UuzhF5UWAQ=
X-Received: by 2002:a17:906:4756:: with SMTP id j22mr10128805ejs.353.1607673224722;
 Thu, 10 Dec 2020 23:53:44 -0800 (PST)
MIME-Version: 1.0
References: <20201209164542.61387-1-jinpu.wang@cloud.ionos.com>
 <20201209164542.61387-3-jinpu.wang@cloud.ionos.com> <CAMGffE=_axtHU=pAV3qx5FVY2pB786z3kffQwDzinOaH=yS5Ag@mail.gmail.com>
 <e841a2c3-2774-ca8f-302a-cd43c3b3161e@cloud.ionos.com> <CAMGffEmKAzy3dXVKhoZDAqLpZ6DiQiaYNQn8_0Fd+MQUXbn_eA@mail.gmail.com>
 <20201211072600.GA192848@unreal>
In-Reply-To: <20201211072600.GA192848@unreal>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Fri, 11 Dec 2020 08:53:33 +0100
Message-ID: <CAMGffEn4fbTud3qrrwnrS6bqxcpF6sueKb=Qke8N9yLvDeEWpA@mail.gmail.com>
Subject: Re: [PATCH for-next 02/18] RMDA/rtrs-srv: Occasionally flush ongoing
 session closing
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        linux-rdma@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Dec 11, 2020 at 8:26 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Fri, Dec 11, 2020 at 07:50:13AM +0100, Jinpu Wang wrote:
> > On Fri, Dec 11, 2020 at 3:35 AM Guoqing Jiang
> > <guoqing.jiang@cloud.ionos.com> wrote:
> > >
> > >
> > >
> > > On 12/10/20 15:56, Jinpu Wang wrote:
> > > > On Wed, Dec 9, 2020 at 5:45 PM Jack Wang <jinpu.wang@cloud.ionos.com> wrote:
> > > >>
> > > >> If there are many establishments/teardowns, we need to make sure
> > > >> we do not consume too much system memory. Thus let on going
> > > >> session closing to finish before accepting new connection.
> > > >>
> > > >> Inspired by commit 777dc82395de ("nvmet-rdma: occasionally flush ongoing controller teardown")
> > > >> Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > > >> Reviewed-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> > > > Please ignore this one, it could lead to deadlock, due to the fact
> > > > cma_ib_req_handler is holding
> > > > mutex_lock(&listen_id->handler_mutex) when calling into
> > > > rtrs_rdma_connect, we call close_work which will call rdma_destroy_id,
> > > > which
> > > > could try to hold the same handler_mutex, so deadlock.
> > > >
> > >
> > > I am wondering if nvmet-rdma has the similar issue or not, if so, maybe
> > > introduce a locked version of rdma_destroy_id.
> > >
> > > Thanks,
> > > Guoqing
> >
> > No, I was wrong. I rechecked the code, it's not a valid deadlock, in
> > cma_ib_req_handler, the conn_id is newly created in
> > https://elixir.bootlin.com/linux/latest/source/drivers/infiniband/core/cma.c#L2185.
> >
> > Flush_workqueue will only flush close_work for any other cm_id, but
> > not the newly created one conn_id, it has not associated with anything
> > yet.
> >
> > The same applies to nvme-rdma. so it's a false alarm by lockdep.
>
> Leaving this without fix (proper lock annotation) is not right thing to
> do, because everyone who runs rtrs code with LOCKDEP on will have same
> "false alarm".
>
> So I recommend or not to take this patch or write it without LOCKDEP warning.
Hi Leon,

I'm thinking about the same, do you have a suggestion on how to teach
LOCKDEP this is not really a deadlock,
I do not know LOCKDEP well.

Thanks
>
> Thanks
>
> >
> > Regards!
> > Jack
