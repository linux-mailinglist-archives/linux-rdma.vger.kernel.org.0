Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CECD4758F1
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Dec 2021 13:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242554AbhLOMga (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Dec 2021 07:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242501AbhLOMg3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Dec 2021 07:36:29 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A20C061574;
        Wed, 15 Dec 2021 04:36:29 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id m6so31074575lfu.1;
        Wed, 15 Dec 2021 04:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/B4+jWAqwXykz4vWfcUdoaBnklx9nhuB0x+qyPZT6e4=;
        b=UAdo901qc25WuNpQZDyIvsjT7MHJscQaAW/or9naMisIevsgNzMgpGPPPhQcrTt8rQ
         lOXQYK3oYdH/yIuy/R0hdNs7CJKgaRryqjzllOivmcoXWDjxKCIVM0VT1abWCm6jtz6o
         sja4416/aVwuRbjCos2+Kp2YJpMzn1JP/buhSkfFp6BzEm2adSR73Nl1u/ESjfY3wmkk
         DBMTOnxh0qsphAB3YZDRFd7sfFOn9gWZSJwV7uxV2JoGmfUx1+gEwQGf9iFnMxBXg+ba
         Dl7yj1jUbp0u8cO/ydZb60I+9N7fAh/FukHPlVpGM12e7MXOdea7d9GlMmNMiYnhVnrR
         aHFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/B4+jWAqwXykz4vWfcUdoaBnklx9nhuB0x+qyPZT6e4=;
        b=s2N2dJtSPrJ363RoQCnN7YD++4ZgwWglCCZVZxEINyAikPKcwY2BDKNrx99aOU80cQ
         T140KzFA6eKsfWHfIgbcBZdqZwTiCnBRQ6KCRsWkHBebyUOIr8d+FKghM7PWftpHGpjT
         CaIn/UcDI9rkUNBXuHEbKrDXrgaDgfnOZEv6zMbTGqFkCxQxEswCZUtbVd2xUqHy9dpU
         BZLfhGBpeiiGAEKZo4OiAaz1ozc2XfKJQhpxThew+G7Z4NADR6zFhv6BfdUZLUUvY4Cc
         2vW/xSGgUJZJzEUUNQTmpjXk8H2VAJ6fO5l/+rIpBd9/ceyUnrr3x4CrHBmOVj7bRVm0
         4IgQ==
X-Gm-Message-State: AOAM533Db56TW5dpDIiR13EjbJrwFy4QCB48mEJZebVXA3EmfIKsIPWx
        kYHb2HxC5JpHJL1AF5FaJKNXkiJQNVUGyGOe75A=
X-Google-Smtp-Source: ABdhPJzhZ9IPJsVU6iKeCj8iz3RjSkbPmPIM1Wcx5S8yxI/CfGDPKV61YqYV/sGNXBOjyUlbfnmYURqjJu5mbt1QnHQ=
X-Received: by 2002:ac2:5049:: with SMTP id a9mr9595535lfm.666.1639571787323;
 Wed, 15 Dec 2021 04:36:27 -0800 (PST)
MIME-Version: 1.0
References: <CO6PR10MB56353FD77836D5605CDDB8DEDD769@CO6PR10MB5635.namprd10.prod.outlook.com>
 <20211215075258.442930-1-chi.minghao@zte.com.cn>
In-Reply-To: <20211215075258.442930-1-chi.minghao@zte.com.cn>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Wed, 15 Dec 2021 20:36:15 +0800
Message-ID: <CAD=hENdjPT7PeMe8AoeQXQr-Ksj8S08N4xeL_=__VEsoPDeOmw@mail.gmail.com>
Subject: Re: [PATCH for-next v2] RDMA/rxe: remove redundant err variable
To:     cgel.zte@gmail.com
Cc:     devesh.s.sharma@oracle.com, chi.minghao@zte.com.cn,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        LKML <linux-kernel@vger.kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        zealci@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 15, 2021 at 3:53 PM <cgel.zte@gmail.com> wrote:
>
> From: Minghao Chi <chi.minghao@zte.com.cn>
>
> Return value directly instead of taking this
> in another redundant variable.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>

Thanks.
Acked-by: Zhu Yanjun <zyjzyj2000@gmail.com>

Zhu Yanjun

> ---
>  drivers/infiniband/sw/rxe/rxe_net.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c
> b/drivers/infiniband/sw/rxe/rxe_net.c
> index 2cb810cb890a..f557150bd59a 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -22,24 +22,20 @@ static struct rxe_recv_sockets recv_sockets;
>
>  int rxe_mcast_add(struct rxe_dev *rxe, union ib_gid *mgid)
>  {
> -       int err;
>         unsigned char ll_addr[ETH_ALEN];
>
>         ipv6_eth_mc_map((struct in6_addr *)mgid->raw, ll_addr);
> -       err = dev_mc_add(rxe->ndev, ll_addr);
>
> -       return err;
> +       return dev_mc_add(rxe->ndev, ll_addr);
>  }
>
>  int rxe_mcast_delete(struct rxe_dev *rxe, union ib_gid *mgid)
>  {
> -       int err;
>         unsigned char ll_addr[ETH_ALEN];
>
>         ipv6_eth_mc_map((struct in6_addr *)mgid->raw, ll_addr);
> -       err = dev_mc_del(rxe->ndev, ll_addr);
>
> -       return err;
> +       return dev_mc_del(rxe->ndev, ll_addr);
>  }
>
>  static struct dst_entry *rxe_find_route4(struct net_device *ndev,
> --
> 2.25.1
>
