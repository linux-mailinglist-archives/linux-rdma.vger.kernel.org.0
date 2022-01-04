Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5BCD483AAC
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jan 2022 03:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbiADCql (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Jan 2022 21:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbiADCql (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Jan 2022 21:46:41 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757BBC061761;
        Mon,  3 Jan 2022 18:46:40 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id r4so35405333lfe.7;
        Mon, 03 Jan 2022 18:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XwS+dVl5eiGqQaeH1qcWnqbx39W64a5YJhPs5tWYw7g=;
        b=YXapyd2qG3y6Gyfh/8n/8oPRJItmRTXGr97OlealEHQMyM1zxhQqfY/s++lkwXIb4h
         uqPK4wK28d+ZGbYX0HuUf0/4dYib8TgVwNelG8RYpSJnLHYyUtCnUngWUFN8hoP4M0Pq
         83Mp0bYcIBxVzVQhGc811+L5v6q33/OfymddcRJCmxPspOl5ZdV+734O9gGYVe5LkRuu
         SZCRr7i7UMgwopJlwo6Volz0cwnHxuq098HQO3915X0WVFMbYdMhuf/PQ322tTXCV30e
         UQta80zF5BDFOEsSePVTDfp1pIJcO/LbjlpdNHPR8D8LR1ZGQ93sfsGg4o7LSGzFBfGw
         89kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XwS+dVl5eiGqQaeH1qcWnqbx39W64a5YJhPs5tWYw7g=;
        b=MhkpbP+EADvSQrgazFcw/2ZVp9wX07/I91iGkYkaHlcXdECirF0B38KywKqTihaeSF
         xW5zHbXHWZv23ljy2N6boczRdfy5YFHfzfWqXusHkVa9USrZg985xOS60h9ErxIhUsTw
         QNJM7XtW1IklnwwAFwld1s59zjpH7Ja3vI8EAtl/yevbmXOK9y2sDZIGv3oaF3M6YLXg
         j+htkC8JYQOgcMliRfMUaodPKM2UlzfcDJbcCCK2ZhqDk2RN2xl62BrVD31KLL83zRyD
         kwCvE9wI+yKheKiizSQFFb1l/Gy+yKzcbd3+MIIYo7ryJ6pjVvbf6w/6ceO3hN3bA5HD
         Ogtw==
X-Gm-Message-State: AOAM533IUVGATlz8q4UCZqWepvmSKMc9e+ssrYGOdUQinYEtIejsH8GO
        tXawchkL8I49CmVQnUa2tNV0xOSPmEqqWD9McI4=
X-Google-Smtp-Source: ABdhPJyf3/HeqXcc8LXsBeEU2licr8rlepkC/OaEN4ONlssLyRjB+M6ckTtp2DyRj/bMN5yED/Cwrj/hSJUE/u/+9bQ=
X-Received: by 2002:a05:6512:3b26:: with SMTP id f38mr43643428lfv.374.1641264398765;
 Mon, 03 Jan 2022 18:46:38 -0800 (PST)
MIME-Version: 1.0
References: <20220104012406.27580-1-lizhijian@fujitsu.com>
In-Reply-To: <20220104012406.27580-1-lizhijian@fujitsu.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Tue, 4 Jan 2022 10:46:27 +0800
Message-ID: <CAD=hENd7dQPVAOrLvZwQG=SHRdnzN-Y4Ag3V_b5vUTzh6Y0YjQ@mail.gmail.com>
Subject: Re: [PATCH v2] RDMA/rxe: Get rid of redundant plus
To:     Li Zhijian <lizhijian@fujitsu.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Li Zhijian <lizhijian@cn.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 4, 2022 at 9:25 AM Li Zhijian <lizhijian@fujitsu.com> wrote:
>
> From: Li Zhijian <lizhijian@cn.fujitsu.com>
>
> Get rid of the duplicate plus in a line to be consistent with others.
>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>

Reviewed-by: Zhu Yanjun <zyjzyj2000@gmail.com>

Zhu Yanjun

> ---
>  drivers/infiniband/sw/rxe/rxe_opcode.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_opcode.c b/drivers/infiniband/sw/rxe/rxe_opcode.c
> index 3ef5a10a6efd..79122eeb4d82 100644
> --- a/drivers/infiniband/sw/rxe/rxe_opcode.c
> +++ b/drivers/infiniband/sw/rxe/rxe_opcode.c
> @@ -879,9 +879,9 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
>                         [RXE_ATMETH]    = RXE_BTH_BYTES
>                                                 + RXE_RDETH_BYTES
>                                                 + RXE_DETH_BYTES,
> -                       [RXE_PAYLOAD]   = RXE_BTH_BYTES +
> +                       [RXE_PAYLOAD]   = RXE_BTH_BYTES
>                                                 + RXE_ATMETH_BYTES
> -                                               + RXE_DETH_BYTES +
> +                                               + RXE_DETH_BYTES
>                                                 + RXE_RDETH_BYTES,
>                 }
>         },
> @@ -900,9 +900,9 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
>                         [RXE_ATMETH]    = RXE_BTH_BYTES
>                                                 + RXE_RDETH_BYTES
>                                                 + RXE_DETH_BYTES,
> -                       [RXE_PAYLOAD]   = RXE_BTH_BYTES +
> +                       [RXE_PAYLOAD]   = RXE_BTH_BYTES
>                                                 + RXE_ATMETH_BYTES
> -                                               + RXE_DETH_BYTES +
> +                                               + RXE_DETH_BYTES
>                                                 + RXE_RDETH_BYTES,
>                 }
>         },
> --
> 2.33.0
>
>
>
