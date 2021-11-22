Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D4D4587E3
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Nov 2021 03:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbhKVCHr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 Nov 2021 21:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbhKVCHr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 21 Nov 2021 21:07:47 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D387C061574;
        Sun, 21 Nov 2021 18:04:41 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id m27so73090099lfj.12;
        Sun, 21 Nov 2021 18:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rXfY0v9Exo7icWZ54y7mfJX8FZsGPzYLuZU5J2WEmhU=;
        b=cJsjOnh+8bOR2vKGnZY6YvWNZmE2UZFXj76/goL3vYw6WNA/ghF5VNdn52HcTrllzl
         WywOvr4YxZwLHcp/RYfdRCEEz+yOkIDEktx+cJ6tjFI5ScUO32b7qU07dkhchohV2KXa
         RNqCf2TlypGBwmpL7mU7w8G0pndtWonhquF9l0yrfQy0YEJk9Dfvw7LyY7MJ6ZcZyaHC
         1PZFkFqqy68oU4htSRENt+flERhM73bMxydWl85gNqDvGm6LmuFTv0l1yg0xGZFDLQXP
         sdJAnNnyELAYsBOrjaq+smksPz1dNxAGoGf2HuZdHV93V3SoPvT6B4jbLz94LMD6erzZ
         /ndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rXfY0v9Exo7icWZ54y7mfJX8FZsGPzYLuZU5J2WEmhU=;
        b=vAh9TOPQBq23quuD/8EE2M2xJq7A2pIEdb9RQaDPySJDZ0yzr/ZNZhWH5Ag/YzR10s
         nBTbAeUCihh/Gxo5opszxcC4cE87iAMuD4rwxWWgZkANKtqY2LVPSI1SLRPY6aepRnqq
         vr/EAhqg0bK313nzjm73zy2V+RUSQt1/TZRGuv3ICdmVVthkz6pT6DGPM5q9ecmauFhf
         U0woX68dMXf8El5fJtWyUGqFNSVWoz5Pf9dTqnApJTmsqVOk0Zil9L8IC6yCkwMms0WG
         +/zt1o1cpdWQcaa3LtCKz9I3gEmbV5I5p8+gXRVpaz7BmgzgUwGHtsFe0kEvAkMZ1r4X
         WwEw==
X-Gm-Message-State: AOAM533qd3ptSaSNQf81XT/wK8b64ETuOhClEt6NZn/zm3pEm3qu9ZK2
        6wOCmNgZwH35awFQxdiRCp2s8POfm6uuOET/ZDo=
X-Google-Smtp-Source: ABdhPJxqKtu9R+Eb45JrAezj04kQEiMfyopC09wROFjMfztQ8TzP21GfDLxCQtzgWmoll0lva1m+rtlTto4GuS9qhAs=
X-Received: by 2002:a2e:b751:: with SMTP id k17mr47611457ljo.467.1637546679391;
 Sun, 21 Nov 2021 18:04:39 -0800 (PST)
MIME-Version: 1.0
References: <YZpUnR05mK6taHs9@unreal> <20211121202239.3129-1-paskripkin@gmail.com>
In-Reply-To: <20211121202239.3129-1-paskripkin@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Mon, 22 Nov 2021 10:04:28 +0800
Message-ID: <CAD=hENcbr22fW8YuoG2o2_MCNBjF7DW_sgLRpcC=qh24Edq=Dw@mail.gmail.com>
Subject: Re: [PATCH] RDMA: fix use-after-free in rxe_queue_cleanup
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzbot+aab53008a5adf26abe91@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 22, 2021 at 4:22 AM Pavel Skripkin <paskripkin@gmail.com> wrote:
>
> On error handling path in rxe_qp_from_init() qp->sq.queue is freed and
> then rxe_create_qp() will drop last reference to this object. qp clean
> up function will try to free this queue one time and it causes UAF bug.
>
> Fix it by zeroing queue pointer after freeing queue in
> rxe_qp_from_init().
>
> Fixes: 514aee660df4 ("RDMA: Globally allocate and release QP memory")
> Reported-by: syzbot+aab53008a5adf26abe91@syzkaller.appspotmail.com
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>

Reviewed-by: Zhu Yanjun <zyjzyj2000@gmail.com>

Thanks a lot.
Zhu Yanjun

> ---
>  drivers/infiniband/sw/rxe/rxe_qp.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
> index 975321812c87..54b8711321c1 100644
> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
> @@ -359,6 +359,7 @@ int rxe_qp_from_init(struct rxe_dev *rxe, struct rxe_qp *qp, struct rxe_pd *pd,
>
>  err2:
>         rxe_queue_cleanup(qp->sq.queue);
> +       qp->sq.queue = NULL;
>  err1:
>         qp->pd = NULL;
>         qp->rcq = NULL;
> --
> 2.33.1
>
