Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE93396E0D
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jun 2021 09:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbhFAHrS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Jun 2021 03:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbhFAHrR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Jun 2021 03:47:17 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C077C061574
        for <linux-rdma@vger.kernel.org>; Tue,  1 Jun 2021 00:45:36 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id t10-20020a05683022eab0290304ed8bc759so13274562otc.12
        for <linux-rdma@vger.kernel.org>; Tue, 01 Jun 2021 00:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=94igLADofQW/5krxpuO65uCv/pkYA5BAPk41tY8ymiM=;
        b=cJ79PXNaN7aN0sEiDXbbkKj9yX8VuabPTPW93kKiCJ2MvV3oazQknDz5ijhgGClqUL
         5l0cVt/KDjFHlG8b4qYO82X7YwfzvDw+QuG2PCmJskmwoigwCtMrwHshmnx9+epxdMIq
         5i+7UzmR6sWYqVsKX35gSKdT6w2tr2FpsSfZrfTymqRGtALFfcegULc3uIKX1utc2X0y
         3f/i56w+6HPxdEDBO6AgjZPMg7TxFkiJMkIHn7/crewA+IvzFdsJXWGsZVPjn7tsNpCV
         XA9L26o1C7VoueuA2L/Yt9mbCnabmeK4Od7KB9uyX+F8HRW9e/EkPi17jYFPGDPyFIal
         r8WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=94igLADofQW/5krxpuO65uCv/pkYA5BAPk41tY8ymiM=;
        b=txel2i66a2ImVZ3IYSM307GQ3XaDalMBGsUKeGa0USnItA4vsYR6V3gvJ67zJLpfe9
         dzJsDuKt37iMNdc3R3ZMDfWYsr0PsOFpF2Y4k+VNt8XYgE59JkUcouYW9howICDYdfo0
         I4jPxMs2HcnJxJCP4LwfrumiwpBqOGlqO4dnv2Q4ZNaGeqMm/tOgXmfegZKtD+/MEkIy
         uoxcCKiII5HtiYe8bXHZVyPOzIn2JmOxCzEN7DtWuHT7TMF0XHqQAd5bwZUwlIduoaXN
         3RZZdfbTcuwB3Gl+f7HokthPSee4cDQ675Ef2TL8xn5wl6+JtaOtbEu1qYkWkYqCYD8w
         krMA==
X-Gm-Message-State: AOAM531s+YD7dtHyDC75+HqtHtwjyMCtfrdJdRV2b1T4S6t13ilZZKI8
        5UV2ytIt5D7/uefdj8aBq+IKHWCXLwrZW6tDK7E=
X-Google-Smtp-Source: ABdhPJyweBi0EcMygririoy9t5U0GrlAPUJgKPUIsXumUy3JSBUmllwtYw9OrsavIJ+cN+Ch0Wr/sMJ8rsY3oAucbsQ=
X-Received: by 2002:a9d:4801:: with SMTP id c1mr10872096otf.278.1622533535945;
 Tue, 01 Jun 2021 00:45:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210601055612.195653-1-kamalheib1@gmail.com>
In-Reply-To: <20210601055612.195653-1-kamalheib1@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Tue, 1 Jun 2021 15:45:25 +0800
Message-ID: <CAD=hENe9O+3Z9ck6G5+t9RaVpbqUL-edfa+b1-Ki5NZO0eJPPA@mail.gmail.com>
Subject: Re: [PATCH for-rc] RDMA/rxe: Fix failure during driver load
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 1, 2021 at 1:58 PM Kamal Heib <kamalheib1@gmail.com> wrote:
>
> To avoid the following failure when trying to load the rdma_rxe module
> while IPv6 is disabled, Add a check to make sure that IPv6 is enabled
> before trying to create the IPv6 UDP tunnel.
>
> $ modprobe rdma_rxe
> modprobe: ERROR: could not insert 'rdma_rxe': Operation not permitted

About this problem, this link:
https://patchwork.kernel.org/project/linux-rdma/patch/20210413234252.12209-1-yanjun.zhu@intel.com/
also tries to solve ipv6 problem.

Zhu Yanjun

>
> Fixes: dfdd6158ca2c ("IB/rxe: Fix kernel panic in udp_setup_tunnel")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_net.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> index 01662727dca0..f353fc18769f 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -617,12 +617,14 @@ static int rxe_net_ipv6_init(void)
>  {
>  #if IS_ENABLED(CONFIG_IPV6)
>
> -       recv_sockets.sk6 = rxe_setup_udp_tunnel(&init_net,
> -                                               htons(ROCE_V2_UDP_DPORT), true);
> -       if (IS_ERR(recv_sockets.sk6)) {
> -               recv_sockets.sk6 = NULL;
> -               pr_err("Failed to create IPv6 UDP tunnel\n");
> -               return -1;
> +       if (ipv6_mod_enabled()) {
> +               recv_sockets.sk6 = rxe_setup_udp_tunnel(&init_net,
> +                                       htons(ROCE_V2_UDP_DPORT), true);
> +               if (IS_ERR(recv_sockets.sk6)) {
> +                       recv_sockets.sk6 = NULL;
> +                       pr_err("Failed to create IPv6 UDP tunnel\n");
> +                       return -1;
> +               }
>         }
>  #endif
>         return 0;
> --
> 2.26.3
>
