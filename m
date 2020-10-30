Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5171829FBC7
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Oct 2020 03:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725790AbgJ3Cy1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Oct 2020 22:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgJ3Cy0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Oct 2020 22:54:26 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1FDC0613CF
        for <linux-rdma@vger.kernel.org>; Thu, 29 Oct 2020 19:54:26 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id f1so1272470oov.1
        for <linux-rdma@vger.kernel.org>; Thu, 29 Oct 2020 19:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3MjkbtwLZRo7hjCSi0XdpJJrMSdKJOPlZBTkb1T3jx4=;
        b=fHrddPxiwrYccFgjtFJwwrg/xoOXCJoaVI4TpKvCkqbZ2snTMEZ1OzGObSMrWdGNYN
         of8f928JlZAQrd07IGqyImdti4w4A6ka9QAqyuA1a4pncDGk6b+2nCjdakDnsnj+O2Pn
         /CDp2qSjq034JmcALV6rW3VwsqBgo50Trc02Vj4+hg/TLwum5EGnS5HsntuG4syoVHcO
         GbKJ4ZAMEoDnIVsF+d4foOmwrbtTWCh5dQZ2YVL+Nk8VwS7fp1zJAUq7jQEnntkUbWfU
         6MZnNcMUM98+mjxe+NVJtLeCFy9gU0gtTwQvULp2RvehC9jtXbbNWiX0wSPghuZvX5x6
         yg0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3MjkbtwLZRo7hjCSi0XdpJJrMSdKJOPlZBTkb1T3jx4=;
        b=FR8as1G2dZtdQRjvtVfU9kHqVSFo46omaLfGlJmv9m59Cl3kqiYBjPE4/H01/ad9lD
         l68KZt6XsKJZrjUiC5XwF/D+oMUfEBIZ38A075yBNinxojz9lZo72IYebaFcFY3UBR+1
         umOZqBZh3Auoo0Qm5+kqu2WRKVmROR2xBlqoeqpfbd9CPE/koDISYJdglljfOVrWauDn
         lJl3uIeCNdanJEV/k+8cUXvhoBc9GPMpZmv6vu47DIvCz5NoRk17gQJrg8kmJFAmbpFd
         YyVEw0cr8I68RSGeWplAOUzKx1KKKAMqKHTV4NB5VQhld/9BpgZfLRDBbFKL2VtycvHK
         ITdA==
X-Gm-Message-State: AOAM533eiisYHpGNoKH7+VqSE7ssvPF/mm4/63/FsTSSA6c+RBRdI5A9
        eHeHXNGx3qTvylrt8ygQdUy5CAU3CLVgvaXLbVFSnL3O
X-Google-Smtp-Source: ABdhPJy1sNvMPWBx5wW+uIxsgYhJdlTBoJ9Xz5bMxb79B2zuCb12rUGQE8COWOiLdc8tmhGK+QFrtY+CZgjWHigHxwI=
X-Received: by 2002:a4a:5547:: with SMTP id e68mr138570oob.49.1604026465696;
 Thu, 29 Oct 2020 19:54:25 -0700 (PDT)
MIME-Version: 1.0
References: <20201029212545.6616-1-rpearson@hpe.com>
In-Reply-To: <20201029212545.6616-1-rpearson@hpe.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Fri, 30 Oct 2020 10:54:14 +0800
Message-ID: <CAD=hENeC0F7K8VtN-JhmMgJVbidJ4gxMwqjPyLscYA4s2oGXrQ@mail.gmail.com>
Subject: Re: [PATCH for-next] RDMA/rxe: fix regression caused by recent patch
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, linux-rdma@vger.kernel.org,
        Bob Pearson <rpearson@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 30, 2020 at 5:27 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> The commit referenced below performs additional checking on
> devices used for DMA. Specifically it checks that
>
> device->dma_mask != NULL
>
> Rdma_rxe uses this device when pinning MR memory but did not
> set the value of dma_mask. In fact rdma_rxe does not perform
> any DMA operations so the value is never used but is checked.
>
> This patch gives dma_mask a valid value. Without this patch
> rdma_rxe does not function at all.
>
> Fixes: f959dcd6ddfd2 ("dma-direct: Fix potential NULL pointer dereference")
> Signed-off-by: Bob Pearson <rpearson@hpe.com>

Thanks a lot.

Zhu Yanjun

> ---
>  drivers/infiniband/sw/rxe/rxe_verbs.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index 7652d53af2c1..116a234e92db 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -1134,8 +1134,15 @@ int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
>         dev->node_type = RDMA_NODE_IB_CA;
>         dev->phys_port_cnt = 1;
>         dev->num_comp_vectors = num_possible_cpus();
> +
> +       /* rdma_rxe never does real DMA but does rely on
> +        * pinning user memory in MRs to avoid page faults
> +        * in responder and completer tasklets
> +        */
>         dev->dev.parent = rxe_dma_device(rxe);
> +       dev->dev.dma_mask = DMA_BIT_MASK(64);
>         dev->local_dma_lkey = 0;
> +
>         addrconf_addr_eui48((unsigned char *)&dev->node_guid,
>                             rxe->ndev->dev_addr);
>         dev->dev.dma_parms = &rxe->dma_parms;
> --
> 2.27.0
>
