Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D069435EB8F
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Apr 2021 05:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343901AbhDNDrG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Apr 2021 23:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbhDNDrF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 13 Apr 2021 23:47:05 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DA9C061574
        for <linux-rdma@vger.kernel.org>; Tue, 13 Apr 2021 20:46:45 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id p6-20020a9d69460000b029028bb7c6ff64so2063710oto.10
        for <linux-rdma@vger.kernel.org>; Tue, 13 Apr 2021 20:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dsHQ4qNYSla1Cih2FNAz5UCRYyDsB61UXJuy2u+yE4s=;
        b=Op6qZ0hdRLYq0sw7XoAByLaqpWZTZqIgCBQmPeQU3quvxjoNlCd2q8OaMN95/b3LRl
         TC+tcOCi7tZEMaWM5PjvJ6IaK8YqYdfWNBrGZZ931qP+6L/QoNs0KbYw6jyW35KkPS7Q
         xs8iKlQMoM90gD1kdceRdpUYX6KiD36YIykiJ7DiTa5XsMndo5mbZGJCj7rQk/W9FvQA
         fu3aj+81fnizPfMWLCvOCt/25UCQvQo1/fH6sDxLu4tsmbqrIOqeSLaqkwk0JJyXWoBD
         TcFRNGrYCT+0Vp1tTG7Gf+sFsSr1asv7EoGwVzlSYhuJMmNeTopwUHqL56U7WQd8w6tZ
         9BHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dsHQ4qNYSla1Cih2FNAz5UCRYyDsB61UXJuy2u+yE4s=;
        b=h3h/7HbfMMbu8rUdDAoKWmC8aJHXRtLRH0d30iTcAlPo9qwLtZD7f+eN6dS5QdEjcw
         YHk4mXGI/AHvZFunEsMf92mmR2iiuYrPwZGmfHsj4ywjrpHwfnUMreHfuP8ecRZDRtXy
         9GIoV0kqRdcd4bfjkA+2WXA7ymqEiOhaBq0UPxvYSuL6C5Fg4qTmO9HRu1yBT+L6wBsg
         VJiUotf5uUymer4sbSuxgOTEwspIulSZPQPSS6VV/p+KHL+AEqvtlLyjcmUL9EyI4Zcz
         XpTL5gw9FRn31rLR0Ccr1V6L5R+Au8M8usSpZP6bqDEuVMAgn74H7i4yzTxMFE9KtLBa
         32GA==
X-Gm-Message-State: AOAM533EXd6xdZiuqZEcvlauylr0JJccQFV+BGBtehTCtWq/uHvBDIMm
        x5P3EVewqgXDT+n+gokqM5IUlr7vvfedYgYaulE=
X-Google-Smtp-Source: ABdhPJylCwiTEespO1eaLcEtLTFSdqcQV8BKkNAQoisL2RcTh9yIzhBFO4z322R8lEWEdqrP0O+Q2FZag3/p/oHCnqY=
X-Received: by 2002:a9d:74ca:: with SMTP id a10mr24725927otl.53.1618372003845;
 Tue, 13 Apr 2021 20:46:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210413234252.12209-1-yanjun.zhu@intel.com> <YHV3F9gBeLnLvzn+@unreal>
In-Reply-To: <YHV3F9gBeLnLvzn+@unreal>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Wed, 14 Apr 2021 11:46:32 +0800
Message-ID: <CAD=hENc52T9Z5YrAFwL0QkcsF6mqSS6wTZQxfCECjVxtskdPuQ@mail.gmail.com>
Subject: Re: [PATCHv5 for-next 1/1] RDMA/rxe: Disable ipv6 features when
 ipv6.disable in cmdline
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Zhu Yanjun <yanjun.zhu@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Yi Zhang <yi.zhang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 13, 2021 at 6:48 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Tue, Apr 13, 2021 at 07:42:52PM -0400, Zhu Yanjun wrote:
> > From: Zhu Yanjun <zyjzyj2000@gmail.com>
> >
> > When ipv6.disable=1 is set in cmdline, ipv6 is actually disabled
> > in the stack. As such, the operations of ipv6 in RXE will fail.
> > So ipv6 features in RXE should also be disabled in RXE.
> >
> > Link: https://lore.kernel.org/linux-rdma/880d7b59-4b17-a44f-1a91-88257bfc3aaa@redhat.com/T/#t
> > Fixes: 8700e3e7c4857 ("Soft RoCE driver")
> > Reported-by: Yi Zhang <yi.zhang@redhat.com>
> > Signed-off-by: Zhu Yanjun <zyjzyj2000@gmail.com>
> > ---
> > V4->V5: Clean up signature block and remove error message
> > V3->V4: Check the returned value instead of ipv6 module
> > V2->V3: Remove print message
> > V1->V2: Modify the pr_info messages
> > ---
> >  drivers/infiniband/sw/rxe/rxe_net.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> > index 01662727dca0..984c3ac449bd 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_net.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> > @@ -208,7 +208,13 @@ static struct socket *rxe_setup_udp_tunnel(struct net *net, __be16 port,
> >       /* Create UDP socket */
> >       err = udp_sock_create(net, &udp_cfg, &sock);
> >       if (err < 0) {
> > -             pr_err("failed to create udp socket. err = %d\n", err);
> > +             /* If UDP tunnel over ipv6 fails with -EAFNOSUPPORT, the tunnel
> > +              * over ipv4 still works. This error message will not pop out.
> > +              * If UDP tunnle over ipv4 fails or other errors with ipv6
> > +              * tunnel, this error should pop out.
> > +              */
> > +             if (!((err == -EAFNOSUPPORT) && (ipv6)))
>
> You have too much brackets.

My code corresponds with the comments.

Zhu Yanjun

>
> if (err != -EAFNOSUPPORT || !ipv6)))
>
> > +                     pr_err("failed to create udp socket. err = %d\n", err);
> >               return ERR_PTR(err);
> >       }
> >
> > @@ -620,6 +626,11 @@ static int rxe_net_ipv6_init(void)
> >       recv_sockets.sk6 = rxe_setup_udp_tunnel(&init_net,
> >                                               htons(ROCE_V2_UDP_DPORT), true);
> >       if (IS_ERR(recv_sockets.sk6)) {
> > +             /* Though IPv6 is not supported, IPv4 still needs to continue
> > +              */
> > +             if (PTR_ERR(recv_sockets.sk6) == -EAFNOSUPPORT)
> > +                     return 0;
> > +
> >               recv_sockets.sk6 = NULL;
> >               pr_err("Failed to create IPv6 UDP tunnel\n");
> >               return -1;
> > --
> > 2.27.0
> >
