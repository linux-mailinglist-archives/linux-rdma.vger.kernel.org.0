Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE61121498F
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Jul 2020 03:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgGEBtn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 4 Jul 2020 21:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbgGEBtn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 4 Jul 2020 21:49:43 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E2BC061794
        for <linux-rdma@vger.kernel.org>; Sat,  4 Jul 2020 18:49:43 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id e4so21306376oib.1
        for <linux-rdma@vger.kernel.org>; Sat, 04 Jul 2020 18:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uuLf45TfFV1e2cMv2Ne8lPE15KA5g59tL9bBTw0d3ho=;
        b=lKQFD1VvDBuQZk6UOTLfRRnMUFDYNUlLu4S821Gx1P7Q9m667mpiUKfhcDjXoikhSw
         cJg2ICBdPXiXk4kwoMQvfpPRD5icqQlybj3t5DeacgLkjg1t0XL0OsJwvMzg29eT0EFT
         otOZgCy9gc4Rrr0j5hO9lB1Dqmm467g1AIgSDPesqtBVfF7T+XnxiGBx1QbK+VOCW6Ju
         edmXzQ/dwe3JZrHl/gsm+VYxpczG2J0AeKga/3NvqX/ZM7o17AQaKyNvYM4IDg7UtYxQ
         kh8PhTWX6iABT+IpZGChz4HhP6fgVlWPP8frTXmICio/QiuROGY0e8vt5LQ//Cz/o35Y
         mVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uuLf45TfFV1e2cMv2Ne8lPE15KA5g59tL9bBTw0d3ho=;
        b=JEoFhY/DEdOg9AkciZ7NHs8W5SlFHtVidYOxQ/Fq+53Mxd63CXiOiM2geHxRT1sdWx
         c+7OJn20kIfQ59Yu0gJhCvmV62TIouIFRCNIRbkTndb6bmknMZPVP66Rng2NzOeLtArG
         59W04Gi+TENW84DgYYqSbCU/Tw0oZoyRMPVIUpCri33fUCsObNelD1hZis7ZMeBVsKfR
         zFn13tDBdBU7P8WwmEyf3Hs/i5QGsLx5l3OjrjYfe2X1shiiqeIFci/BJbevWHgvcjxY
         ON+dpZTEuceACoAM4nrCYQVREfW5rZIPaJjXSRTx0Hq4YW8W2+HTJfYMdETIAdrXE7Gs
         xlnQ==
X-Gm-Message-State: AOAM532RIVkiy8ejUAnOYbi6tdYIrwsDROAv1y9IXJZpPStbX3JBP5sL
        tVXLPYTbyOBF0Fx3uHa4T+Be57K66x0t5rlByns=
X-Google-Smtp-Source: ABdhPJzJQJgBPMtaqzh1I8Y2chIWeleJYUq/CgNgMav+qfjvX0mpmuNhZlQ3SURaMuaJB5w/xaa8ab4wWMDHnpPUYQI=
X-Received: by 2002:aca:bed5:: with SMTP id o204mr10408173oif.169.1593913782694;
 Sat, 04 Jul 2020 18:49:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200703153428.173758-1-kamalheib1@gmail.com> <20200703153428.173758-5-kamalheib1@gmail.com>
In-Reply-To: <20200703153428.173758-5-kamalheib1@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Sun, 5 Jul 2020 09:49:31 +0800
Message-ID: <CAD=hENe33xJ+WEj3q7DpVB17Cn+Yu9Sz6at=oZKhDdz_PR9bKw@mail.gmail.com>
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
> Instead of return IB_LINK_LAYER_ETHERNET from rxe_link_layer return it
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

This is a wrapper function.

Zhu Yanjun
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
