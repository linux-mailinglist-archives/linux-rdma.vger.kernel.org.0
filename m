Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC2A82143F2
	for <lists+linux-rdma@lfdr.de>; Sat,  4 Jul 2020 06:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725849AbgGDESt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 4 Jul 2020 00:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgGDESt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 4 Jul 2020 00:18:49 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262FDC061794
        for <linux-rdma@vger.kernel.org>; Fri,  3 Jul 2020 21:18:49 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id k22so16669258oib.0
        for <linux-rdma@vger.kernel.org>; Fri, 03 Jul 2020 21:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ITDoUL+45ihEP40EjfKo4ZSQMgUg6E+/sz33XQMAeEo=;
        b=UGlBRUfYyUy+n9S54Dr4D2U+Wncdw0QhMSOjnYv6gk/Gnr8xZQXJt6bM0HOZAK1toE
         ofcuwI+nPgM21srcZa164TEfX4Uvf/pFNJ4s0sV01IgTN0TIL5jETBwvo5MQ89Oyd8sI
         impkviM65veoh/fachJfsixTZp2ZZMGY+ZYjF/91PdDytjHlvi6vW0gKqtDEcIt7ZGb0
         bRzClbi9OuS3Qm+f9VHCel7v2Rtt1iYeN+csYhZJJ+CE7gcViNT7WykD6RL0+siY/UQ7
         kJrLgJVtKV3QAI+5hXr/CXLmyxsEaJKAdVivVBgRKzpqjAc40tduwZSpDH1EDEfLt2Nv
         bReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ITDoUL+45ihEP40EjfKo4ZSQMgUg6E+/sz33XQMAeEo=;
        b=gGQnbVxJ5nrvvBNcM6I34TnrBMOnxMVoRlSwmDmb3rRMXNjjLyL/AOia2PNug3CMV/
         IlgRzmknogLIGYZ+6a020of0+wYIfYfKxrl/IRXUGPT90ljEnB+eR/BIp3A7q8PBjrkt
         zZ59sQt+E5mM3Zq+nXsCDD/K7GLpz90RjHJSTsYcpM0b5U5kKEnrzNpG8H34TqYLj9zT
         msz93RUeA4sT9oC0nRjfQWdoEZPFYC+aKW1SbeI/MN5mA2m4SNLci3qC2CZl3GghME0j
         xJ19gRxMw1pD830cejo2/I721Cwaslnt+S7SmH3qTrqb3eQ5BV/P1hhs0donXvq3yDCR
         6kkQ==
X-Gm-Message-State: AOAM531w1nVsPxTJKW6IUQyryDMqY+ytTY9LxpE6mAZVLIEOJI/enbaW
        uqbX9V259DGVREVhElnbJ4lK18Cki/pXVEfMpiXESg==
X-Google-Smtp-Source: ABdhPJwjpNqTP54bOGGs3NNyw3/0kc1UBeeyMQHQOAaYHQ8ziS9FSSaWo0Gl4iHW137eCH7MbHxcnJDCfFZ2xb/JkNs=
X-Received: by 2002:aca:bed5:: with SMTP id o204mr8084640oif.169.1593836327538;
 Fri, 03 Jul 2020 21:18:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200703153428.173758-1-kamalheib1@gmail.com> <20200703153428.173758-5-kamalheib1@gmail.com>
In-Reply-To: <20200703153428.173758-5-kamalheib1@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Sat, 4 Jul 2020 12:18:36 +0800
Message-ID: <CAD=hENe8ZDWRVXzhm6u_fB0c=BQP4+uSWBW4cBdgKkMQidKnUw@mail.gmail.com>
Subject: Re: [PATCH for-next 4/4] RDMA/rxe: Remove rxe_link_layer()
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Zhu Yanjun <yanjunz@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 3, 2020 at 11:35 PM Kamal Heib <kamalheib1@gmail.com> wrote:
>
> Instead of

return

returning?

 IB_LINK_LAYER_ETHERNET from rxe_link_layer return it
> directly from get_link_layer callback and remove rxe_link_layer().
>
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_loc.h   | 1 -
>  drivers/infiniband/sw/rxe/rxe_net.c   | 5 -----
>  drivers/infiniband/sw/rxe/rxe_verbs.c | 4 +---
>  3 files changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
> index 0688928cf2b1..39dc3bfa5d5d 100644
> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> @@ -142,7 +142,6 @@ int rxe_send(struct rxe_pkt_info *pkt, struct sk_buff *skb);
>  struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
>                                 int paylen, struct rxe_pkt_info *pkt);
>  int rxe_prepare(struct rxe_pkt_info *pkt, struct sk_buff *skb, u32 *crc);
> -enum rdma_link_layer rxe_link_layer(struct rxe_dev *rxe, unsigned int port_num);
>  const char *rxe_parent_name(struct rxe_dev *rxe, unsigned int port_num);
>  struct device *rxe_dma_device(struct rxe_dev *rxe);
>  int rxe_mcast_add(struct rxe_dev *rxe, union ib_gid *mgid);
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> index 312c2fc961c0..0c3808611f95 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -520,11 +520,6 @@ const char *rxe_parent_name(struct rxe_dev *rxe, unsigned int port_num)
>         return rxe->ndev->name;
>  }
>
> -enum rdma_link_layer rxe_link_layer(struct rxe_dev *rxe, unsigned int port_num)
> -{
> -       return IB_LINK_LAYER_ETHERNET;
> -}
> -
>  int rxe_net_add(const char *ibdev_name, struct net_device *ndev)
>  {
>         int err;
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index ee80b8862db8..a3cf9bbe818d 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -141,9 +141,7 @@ static int rxe_modify_port(struct ib_device *dev,
>  static enum rdma_link_layer rxe_get_link_layer(struct ib_device *dev,
>                                                u8 port_num)
>  {
> -       struct rxe_dev *rxe = to_rdev(dev);
> -
> -       return rxe_link_layer(rxe, port_num);
> +       return IB_LINK_LAYER_ETHERNET;
>  }
>
>  static int rxe_alloc_ucontext(struct ib_ucontext *uctx, struct ib_udata *udata)
> --
> 2.25.4
>
