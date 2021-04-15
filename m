Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4B05360CFC
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Apr 2021 16:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbhDOO4B (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Apr 2021 10:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbhDOOyb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 15 Apr 2021 10:54:31 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A79C061574
        for <linux-rdma@vger.kernel.org>; Thu, 15 Apr 2021 07:54:07 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id m13so24509733oiw.13
        for <linux-rdma@vger.kernel.org>; Thu, 15 Apr 2021 07:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EZT8xI5CiRle9dMo1oeIJ5BBbLQPUtSZbPCTIN/aURI=;
        b=pPq6HLFfELL1/i4jL0IWogxqvXLLVWZFRqgyQvC3wl9Uuia6kWHPr09lcYPWJjWn9q
         SstGHaYHyighEbWnrzDvXfyvCH0zYkhSTXJEDbU7/e2xzwB3X9WEgveMZWsYms96O/GC
         HZqzqpRJG9G4fck4LI2EOmoumASPZNJpq+rhN/XPot4oiGD/Xz8zaFmLtphSvqppT+dm
         ZG1NFzxRNi3zo3lfksTgYxnkdyIQ0dOTmUtKY/Al1xlGdlU+9Nik9KoGNqevTnYmIvJ6
         fp+AhN/xQ0g/0SdjedhFJgGhHAdNLRhD1SKwbgp8fO82K/0ryGiKnjGwP6wAVrUWOZW3
         BUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EZT8xI5CiRle9dMo1oeIJ5BBbLQPUtSZbPCTIN/aURI=;
        b=L9G6P6irG4iopGZS9RfV3WDODqrZgYfG2Fyy877a2J+97oVxSoVpy068ks/7CDb/FB
         8s2PNGpewgkzvQI4sZIwV6IR/uAdPzB31kINj2OYRf0vpC3O6QLEGr4l2Pee3VKQ8//M
         po3fKIxJeEDrbScq1voI8so65CEH8XP0HiVgWK/SGWiZkTuDTadgMnIbGRr7encjbJ85
         9yteInQxkWU+qZrkIYjiLz0LnEgAjPu6rvn2bsQp0S+yumMsDT2ugoQ2VmtzfKwStYjT
         VedV6jsosxYflnqpnOjoIRLDzewblaSAZ9pLbgZhSLEoWABBwwJxqTRT14aHNEXZpZ1U
         64aw==
X-Gm-Message-State: AOAM533eZukLLvWHfMFYIMhUhg/BGjC6vD3eOTQTfnpfVfEHCTHD27d9
        hfrmXkj7gz7Aj/X3KFm79kkAsYw9VaDeI0X+yts=
X-Google-Smtp-Source: ABdhPJziMqEmkw9n/bFwi5g4yy9YUEIwHtPuLDAcOF6rB+L1dDXl+/UYapTm/spJKtfvVeAOzxdRroOqqE/Ocvy7uJA=
X-Received: by 2002:a05:6808:143:: with SMTP id h3mr2842040oie.89.1618498446888;
 Thu, 15 Apr 2021 07:54:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210413234252.12209-1-yanjun.zhu@intel.com> <ad1ca691-2d7f-905a-2a41-818f6cc34c50@redhat.com>
 <YHWtDNjhwKJgws24@unreal> <9d410fde-ade3-c7fe-e73e-ca0103ec67c5@redhat.com>
In-Reply-To: <9d410fde-ade3-c7fe-e73e-ca0103ec67c5@redhat.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Thu, 15 Apr 2021 22:53:55 +0800
Message-ID: <CAD=hENfmxwpCJPpbmWoCkk+WLk+AmZeNdSzg_LnaHZ=DHD-Wvg@mail.gmail.com>
Subject: Re: [PATCHv5 for-next 1/1] RDMA/rxe: Disable ipv6 features when
 ipv6.disable in cmdline
To:     Kamal Heib <kheib@redhat.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Zhu Yanjun <yanjun.zhu@intel.com>,
        Yi Zhang <yi.zhang@redhat.com>,
        Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Apr 14, 2021 at 3:34 AM Kamal Heib <kheib@redhat.com> wrote:
>
>
>
> On 4/13/21 5:39 PM, Leon Romanovsky wrote:
> > On Tue, Apr 13, 2021 at 04:56:05PM +0300, Kamal Heib wrote:
> >>
> >>
> >> On 4/14/21 2:42 AM, Zhu Yanjun wrote:
> >>> From: Zhu Yanjun <zyjzyj2000@gmail.com>
> >>>
> >>> When ipv6.disable=1 is set in cmdline, ipv6 is actually disabled
> >>> in the stack. As such, the operations of ipv6 in RXE will fail.
> >>> So ipv6 features in RXE should also be disabled in RXE.
> >>>
> >>> Link: https://lore.kernel.org/linux-rdma/880d7b59-4b17-a44f-1a91-88257bfc3aaa@redhat.com/T/#t
> >>> Fixes: 8700e3e7c4857 ("Soft RoCE driver")
> >>> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> >>> Signed-off-by: Zhu Yanjun <zyjzyj2000@gmail.com>
> >>> ---
> >>> V4->V5: Clean up signature block and remove error message
> >>> V3->V4: Check the returned value instead of ipv6 module
> >>> V2->V3: Remove print message
> >>> V1->V2: Modify the pr_info messages
> >>> ---
> >>>  drivers/infiniband/sw/rxe/rxe_net.c | 13 ++++++++++++-
> >>>  1 file changed, 12 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> >>> index 01662727dca0..984c3ac449bd 100644
> >>> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> >>> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> >>> @@ -208,7 +208,13 @@ static struct socket *rxe_setup_udp_tunnel(struct net *net, __be16 port,
> >>>     /* Create UDP socket */
> >>>     err = udp_sock_create(net, &udp_cfg, &sock);
> >>>     if (err < 0) {
> >>> -           pr_err("failed to create udp socket. err = %d\n", err);
> >>> +           /* If UDP tunnel over ipv6 fails with -EAFNOSUPPORT, the tunnel
> >>> +            * over ipv4 still works. This error message will not pop out.
> >>> +            * If UDP tunnle over ipv4 fails or other errors with ipv6
> >>> +            * tunnel, this error should pop out.
> >>> +            */
> >>> +           if (!((err == -EAFNOSUPPORT) && (ipv6)))
> >>> +                   pr_err("failed to create udp socket. err = %d\n", err);
> >>>             return ERR_PTR(err);
> >>>     }
> >>>
> >>> @@ -620,6 +626,11 @@ static int rxe_net_ipv6_init(void)
> >>>     recv_sockets.sk6 = rxe_setup_udp_tunnel(&init_net,
> >>>                                             htons(ROCE_V2_UDP_DPORT), true);
> >>>     if (IS_ERR(recv_sockets.sk6)) {
> >>> +           /* Though IPv6 is not supported, IPv4 still needs to continue
> >>> +            */
> >>> +           if (PTR_ERR(recv_sockets.sk6) == -EAFNOSUPPORT)
> >>> +                   return 0;
> >>> +
> >>>             recv_sockets.sk6 = NULL;
> >>>             pr_err("Failed to create IPv6 UDP tunnel\n");
> >>>             return -1;
> >>>
> >>
> >> I think the following change is much simpler than changing the udp_sock_create()
> >> helper function?
> >>
> >>
> >> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c
> >> b/drivers/infiniband/sw/rxe/rxe_net.c
> >> index 01662727dca0..b56d6f76ab31 100644
> >> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> >> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> >> @@ -621,6 +621,11 @@ static int rxe_net_ipv6_init(void)
> >>                                                 htons(ROCE_V2_UDP_DPORT), true);
> >>         if (IS_ERR(recv_sockets.sk6)) {
> >>                 recv_sockets.sk6 = NULL;
> >> +               if (PTR_ERR(recv_sockets.sk6) == -EAFNOSUPPORT) {
> >
> > You have "recv_sockets.sk6 = NULL;" in the line above.
> >
>
> Sorry, my bad...
>
> The idea is to handle this issue in the error path of rxe_net_ipv6_init()
> instead of changing the udp_sock_create(), also to make sure that

We do not change udp_sock_create.

> "recv_sockets.sk6" is set to NULL.

Is it necessary to set recv_sockets_sk6 to NULL?

Zhu Yanjun
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c
> b/drivers/infiniband/sw/rxe/rxe_net.c
> index 01662727dca0..445a47f82f42 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -615,17 +615,25 @@ static int rxe_net_ipv4_init(void)
>
>  static int rxe_net_ipv6_init(void)
>  {
> +       int err = 0;
>  #if IS_ENABLED(CONFIG_IPV6)
>
>         recv_sockets.sk6 = rxe_setup_udp_tunnel(&init_net,
>                                                 htons(ROCE_V2_UDP_DPORT), true);
>         if (IS_ERR(recv_sockets.sk6)) {
> +
> +               if (PTR_ERR(recv_sockets.sk6) == -EAFNOSUPPORT) {
> +                       pr_warn("Create IPv6 UDP tunnel is not supported\n");
> +                       err = 0;
> +               } else {
> +                       pr_err("Failed to create IPv6 UDP tunnel\n");
> +                       err = -1;
> +               }
> +
>                 recv_sockets.sk6 = NULL;
> -               pr_err("Failed to create IPv6 UDP tunnel\n");
> -               return -1;
>         }
>  #endif
> -       return 0;
> +       return err;
>  }
>
> >> +                       pr_warn("Create IPv6 UDP tunnel is not supported\n");
> >> +                       return 0;
> >> +               }
> >> +
> >>                 pr_err("Failed to create IPv6 UDP tunnel\n");
> >>                 return -1;
> >>         }
> >> --
> >> 2.26.3
> >>
> >>
> >> Thanks,
> >> Kamal
> >>
> >
>
