Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C36C5FF72
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jul 2019 04:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfGECTS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Jul 2019 22:19:18 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37245 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfGECTS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Jul 2019 22:19:18 -0400
Received: by mail-io1-f67.google.com with SMTP id e5so11691468iok.4;
        Thu, 04 Jul 2019 19:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qk2//h2D34hxgiSXW2dV6ayNgCS4DN9Pcd0bjNc8T14=;
        b=k/4eqnPXmvuJt4S26AnW4sZ9spsOUER10IC3IAOmmIe/lkWqvSTSB7mFLcxFoxl+OI
         hEatzLQM99Q/U0verRfdZRXYMCE0E041igoz+u78i+RA7szMvLxuRp8E8zcnGkyKOioK
         PxnX8YDbeJ7lETII83tfsmexFKsCYb9GAHLwN3hKR/xVQSfRk700JKPxp9MvGbmWDx/v
         hx+imqPwvHAggwi2mBWeNwzgJPrwpghzPqaiLT88uxM0IpIQrdEi2G7K4/Ql/ubKXfn5
         yFCes3LmCPwDgJeY4X7hYVEWLb5a29FVu306GYMGTLKXg8l2Np7VgkMmCDCEOE1p23cZ
         0+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qk2//h2D34hxgiSXW2dV6ayNgCS4DN9Pcd0bjNc8T14=;
        b=EvvEjatB5wI2Jnobm2xPz1yhhdzmbimm5Yp488+V9950PPv+crr0C37++fw1k7YCeE
         ueTOFkBE1sDOaFI+zcI+fsWWk+rBidydl4d/KlUYqnS8mRaE2S0EzjlJSC64SPZZkeN6
         4Vf7WGGWx8vzvXc/7bRJGezkEmUXL6903T0dNQgt0Z78eHY3Jo9dVmjoS3R+s8YFn43Q
         WhuPVI44bj/KbEZk6fYsklE2WnBHa7dBMBSPkBBpnPAeYkgR1D7f6QtWAU5ZDugmasoy
         ibVjajxB9hcydA/Y5R2cA0DfZb1gRtMuk6s4wb6ERijAHB4L5KKFeemHKxo2Yz1oAe5o
         OazA==
X-Gm-Message-State: APjAAAX36Y5XISMTpimg4A0XPYuHKsP457t0sQJkAgtLNs0+hhuvDaih
        agz0Iz5w+DktqcdJu/S9+1SGYzmpLAEdOP9TVXUXxf2B
X-Google-Smtp-Source: APXvYqyuVXO6nUUU3KDsJ2cq/+XZFLt+HvdkmxPLjVip5YJIhgnjkHZTG5y0OqoSLAkSE44MVLIgaD3LZeXZNm+LAwI=
X-Received: by 2002:a5d:968b:: with SMTP id m11mr1472848ion.16.1562293157370;
 Thu, 04 Jul 2019 19:19:17 -0700 (PDT)
MIME-Version: 1.0
References: <1561711763-24705-1-git-send-email-dag.moxnes@oracle.com>
In-Reply-To: <1561711763-24705-1-git-send-email-dag.moxnes@oracle.com>
From:   Parav Pandit <pandit.parav@gmail.com>
Date:   Fri, 5 Jul 2019 07:49:06 +0530
Message-ID: <CAG53R5VQqqr0S6OU+13tcuxcvz922iuqoP-mWbaQERPc48964A@mail.gmail.com>
Subject: Re: [PATCH v2] RDMA/core: Fix race when resolving IP address
To:     Dag Moxnes <dag.moxnes@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 28, 2019 at 2:20 PM Dag Moxnes <dag.moxnes@oracle.com> wrote:
>
> Use neighbour lock when copying MAC address from neighbour data struct
> in dst_fetch_ha.
>
> When not using the lock, it is possible for the function to race with
> neigh_update, causing it to copy an invalid MAC address.
>
> It is possible to provoke this error by calling rdma_resolve_addr in a
> tight loop, while deleting the corresponding ARP entry in another tight
> loop.
>
> Signed-off-by: Dag Moxnes <dag.moxnes@oracle.com>
> Signed-off-by: H=C3=A5kon Bugge <haakon.bugge@oracle.com>
>
> ---
> v1 -> v2:
>    * Modified implementation to improve readability
> ---
>  drivers/infiniband/core/addr.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/add=
r.c
> index 2f7d141598..51323ffbc5 100644
> --- a/drivers/infiniband/core/addr.c
> +++ b/drivers/infiniband/core/addr.c
> @@ -333,11 +333,14 @@ static int dst_fetch_ha(const struct dst_entry *dst=
,
>         if (!n)
>                 return -ENODATA;
>
> -       if (!(n->nud_state & NUD_VALID)) {
> +       read_lock_bh(&n->lock);
> +       if (n->nud_state & NUD_VALID) {
> +               memcpy(dev_addr->dst_dev_addr, n->ha, MAX_ADDR_LEN);
> +               read_unlock_bh(&n->lock);
> +       } else {
> +               read_unlock_bh(&n->lock);
>                 neigh_event_send(n, NULL);
>                 ret =3D -ENODATA;
> -       } else {
> -               memcpy(dev_addr->dst_dev_addr, n->ha, MAX_ADDR_LEN);
>         }
>
>         neigh_release(n);
> --
> 2.20.1
>
Reviewed-by: Parav Pandit <parav@mellanox.com>

A sample trace such as below in commit message would be good to have.
Or the similar one that you noticed with ARP delete sequence.

neigh_changeaddr()
  neigh_flush_dev()
   n->nud_state =3D NUD_NOARP;

Having some issues with office outlook, so replying via gmail.
