Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF65396FFB
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jun 2021 11:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbhFAJLD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Jun 2021 05:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbhFAJLC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Jun 2021 05:11:02 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EAAC061574
        for <linux-rdma@vger.kernel.org>; Tue,  1 Jun 2021 02:09:21 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id z8so8327171wrp.12
        for <linux-rdma@vger.kernel.org>; Tue, 01 Jun 2021 02:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=brhlJqoImtm4tHSFGdgNI5Km2jnWDDvp4MpJAHNXBBE=;
        b=MI/gSmPxIhUH9WjCT0ZP0UqL6ZDyqsQAsjvplprryGgCXTU2cXq3sAtMvVSB0AyIAw
         t5qIG6A+MyBcmMgmoAG1fiKAwh+T4Q9P0Q1qEUjKEN09Ezu1sQJSMvAOK4yfpoBCqhPd
         dy/yQs6G+XW1sG01MIEnUndPSomtPwFqLx5PA2CpMv9ZT0pLut2NcS3Bev9EXVQxdoq0
         R8cuXotargEFYFmI90ahCGH+8TWkwQ4uK51JHR2Mlf9UHxA2Lbqir1UruowRShNM3Qfk
         hR7P7m7wRnan/2X8jRjhhHTC4yDwMiizyt6IIkl+xZlfcgENkH07+7RMcF46t3ZjmrUr
         bK5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=brhlJqoImtm4tHSFGdgNI5Km2jnWDDvp4MpJAHNXBBE=;
        b=IuiXCoDPtzQZjNqRGIZqpD1gOyPDyHTUfEPH/3fLv3h82NAAG25mjRr8JcdO17KDjF
         XEjF+Om97klUGR0L3L2UM+3sL0ztWVmbo0N5fdQfo2O18kwAUQWjADW9WN/A4KMmPGPA
         2W28jo4XnAQIkpi07pQ+QNFvn9rUaUp4rZKeIlAO/ePOcNDBfTYH2MMUDIbg+z6yjUjc
         89J0dMmVV+7dWdvaMa3ymPolxmJ7CELoez3T6t0DKwqd5MXMIVRZfXE6uhGHnWe1nmkO
         TUUo9Up8gbGQZXx8aAAmMx/ZqmIwwUsO6Jb0AeQYM+38mdNDdqKbK8AI7M8AhuoUnB/r
         tLeQ==
X-Gm-Message-State: AOAM532BBFWwtZ93ZfCQK6ie4CIJYtbdwyU4uGC5/jUiB/T11wHX+DSc
        WDGHUTFPQBIzgBKZIUsRMjU=
X-Google-Smtp-Source: ABdhPJzFLorzxF22DhT3qMUrR7mvvpaHorcoyMJcMU83APyYUtScZ+8hkeGRuZPC9K8axSv7pBA52g==
X-Received: by 2002:a5d:46c4:: with SMTP id g4mr6254530wrs.308.1622538559919;
        Tue, 01 Jun 2021 02:09:19 -0700 (PDT)
Received: from kheib-workstation ([2a00:a040:19b:e02f::1006])
        by smtp.gmail.com with ESMTPSA id 73sm2477560wrk.17.2021.06.01.02.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 02:09:19 -0700 (PDT)
Date:   Tue, 1 Jun 2021 12:09:16 +0300
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH for-rc] RDMA/rxe: Fix failure during driver load
Message-ID: <YLX5PLZjjoRiDNGN@kheib-workstation>
References: <CAD=hENe9O+3Z9ck6G5+t9RaVpbqUL-edfa+b1-Ki5NZO0eJPPA@mail.gmail.com>
 <8649FCE4-EAEE-4DA9-AF51-FC6329F67C43@gmail.com>
 <CAD=hENdazayh5wmjd=3shHMVrNMrMw40qFdDFbkTqtaST46o8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=hENdazayh5wmjd=3shHMVrNMrMw40qFdDFbkTqtaST46o8A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 01, 2021 at 04:11:08PM +0800, Zhu Yanjun wrote:
> On Tue, Jun 1, 2021 at 3:56 PM kamal heib <kamalheib1@gmail.com> wrote:
> >
> >
> >
> > > On 1 Jun 2021, at 10:45, Zhu Yanjun <zyjzyj2000@gmail.com> wrote:
> > >
> > > ﻿On Tue, Jun 1, 2021 at 1:58 PM Kamal Heib <kamalheib1@gmail.com> wrote:
> > >>
> > >> To avoid the following failure when trying to load the rdma_rxe module
> > >> while IPv6 is disabled, Add a check to make sure that IPv6 is enabled
> > >> before trying to create the IPv6 UDP tunnel.
> > >>
> > >> $ modprobe rdma_rxe
> > >> modprobe: ERROR: could not insert 'rdma_rxe': Operation not permitted
> > >
> > > About this problem, this link:
> > > https://patchwork.kernel.org/project/linux-rdma/patch/20210413234252.12209-1-yanjun.zhu@intel.com/
> > > also tries to solve ipv6 problem.
> > >
> > > Zhu Yanjun
> > >
> >
> > Yes, but this patch is fixing the problem more cleanly and I’ve tested it.
> >
> > Could you please review and ACK this patch?
> 
> https://www.spinics.net/lists/linux-rdma/msg100274.html
> Compared with the above commit, are the following also needed?
>

I don't think so, because we aren't going to reach this function.

Do you know about a real bug that fails in this function?!

Thanks,
Kamal

> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c
> b/drivers/infiniband/sw/rxe/rxe_net.c
> index 0701bd1ffd1a..6ef092cb575e 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -72,6 +72,11 @@ static struct dst_entry *rxe_find_route6(struct
> net_device *ndev,
>         struct dst_entry *ndst;
>         struct flowi6 fl6 = { { 0 } };
> 
> +       if (!ipv6_mod_enabled()) {
> +               pr_info("IPv6 is disabled by ipv6.disable=1 in cmdline");
> +               return NULL;
> +       }
> +
>         memset(&fl6, 0, sizeof(fl6));
>         fl6.flowi6_oif = ndev->ifindex;
>         memcpy(&fl6.saddr, saddr, sizeof(*saddr));
> 
> Zhu Yanjun
> 
> >
> > Thanks,
> > Kamal
> >
> >
> > >>
> > >> Fixes: dfdd6158ca2c ("IB/rxe: Fix kernel panic in udp_setup_tunnel")
> > >> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> > >> ---
> > >> drivers/infiniband/sw/rxe/rxe_net.c | 14 ++++++++------
> > >> 1 file changed, 8 insertions(+), 6 deletions(-)
> > >>
> > >> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> > >> index 01662727dca0..f353fc18769f 100644
> > >> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> > >> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> > >> @@ -617,12 +617,14 @@ static int rxe_net_ipv6_init(void)
> > >> {
> > >> #if IS_ENABLED(CONFIG_IPV6)
> > >>
> > >> -       recv_sockets.sk6 = rxe_setup_udp_tunnel(&init_net,
> > >> -                                               htons(ROCE_V2_UDP_DPORT), true);
> > >> -       if (IS_ERR(recv_sockets.sk6)) {
> > >> -               recv_sockets.sk6 = NULL;
> > >> -               pr_err("Failed to create IPv6 UDP tunnel\n");
> > >> -               return -1;
> > >> +       if (ipv6_mod_enabled()) {
> > >> +               recv_sockets.sk6 = rxe_setup_udp_tunnel(&init_net,
> > >> +                                       htons(ROCE_V2_UDP_DPORT), true);
> > >> +               if (IS_ERR(recv_sockets.sk6)) {
> > >> +                       recv_sockets.sk6 = NULL;
> > >> +                       pr_err("Failed to create IPv6 UDP tunnel\n");
> > >> +                       return -1;
> > >> +               }
> > >>        }
> > >> #endif
> > >>        return 0;
> > >> --
> > >> 2.26.3
> > >>
