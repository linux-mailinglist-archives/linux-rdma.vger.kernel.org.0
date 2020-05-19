Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 458DA1D9678
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2020 14:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbgESMky (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 May 2020 08:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728773AbgESMky (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 May 2020 08:40:54 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228CCC08C5C0
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2020 05:40:54 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id s21so11689241ejd.2
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2020 05:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3KYGCesQ5jA78ThDWqs/8pLsEsOISAIqwMzt9ExzJns=;
        b=bFdf896X2MkajZQEGUhO7cDTwNmqX/zHuUxwB1f9cGX2ehAb1dhCUPIqralgcCI04X
         IXa5gqbctr9zlVGTNh5PQ3u7txE2tBY1EqPRjgAyRVQ6eFWqvAPTNDQ3FzBkoo12mO7D
         S/ttrqxaPZY2JWf0YV7ye9doq1QNxLsSlsPGGtS8GzAkM8g6pr61d3svYWDwkZM5HDBM
         RG6acO5uAz55d/g5vVLqpNju5fUrew0uM5SCiQnOX6xJ/YmbRejKwHreS9z0RmbuToIL
         1Eq0hfZadxQli046HmV6RmNjKpzZSfwjlNdLie0620D/+S0N51vT46aWzN9J9P47J/WP
         bwcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3KYGCesQ5jA78ThDWqs/8pLsEsOISAIqwMzt9ExzJns=;
        b=c0Khsdv6lHcCnPfnv4xET1F0sW/fGJ9YcGsKd1/K89MDhZV9q6UXkCqBGr/ZQsXXVL
         URkmTvAeixGzPTYgME0oHy7cKfx4Os+dW8PywrzYjAGYAMm0OzqtBMvbe4ZUA53QKHOD
         62bwibSIT40fZpHJd38WXKRnrGekD7A7jLMGxsnoh1seqcEezsKQ0H48AfjxdvBjvWS4
         EOKfa9a6qkE9UXObjiGs8x7qMHAxCmrxuBMXqb40z16fqZRTK+WlhVxh9F1GrmTdlak4
         5em6IGXB+nIvajHM38llhMvf6qCFCxSImNQbe6Tk772lwxCQmsOSQsvc3HcO6ixQzwmw
         9ueQ==
X-Gm-Message-State: AOAM533Qn3dhHtSEo+qGwYaltrq4Iixqi7cSzvUwlCgkMKucXrlTd+UX
        37YOEWRA3A3ARbS15Ix+L5REC2nLQ7tGHlrMFpCF6g==
X-Google-Smtp-Source: ABdhPJxXQe+Ctw22fpd1Cte3qIOV5IRxDzPa48+OqqeX60m+anxFik86R6XcRZkfFnNxzYHQPdPzzC26NZcLvXDIzCQ=
X-Received: by 2002:a17:906:7c4e:: with SMTP id g14mr18879018ejp.353.1589892052762;
 Tue, 19 May 2020 05:40:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200519120256.GC42765@mwanda>
In-Reply-To: <20200519120256.GC42765@mwanda>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 19 May 2020 14:40:41 +0200
Message-ID: <CAMGffEkkUVV9b=iMhP4C=ndBRcePcTQMiF4h-Et1DFEKYPA6mg@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rtrs: Fix some signedness bugs in error handling
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 19, 2020 at 2:05 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> The problem is that "req->sg_cnt" is an unsigned int so if "nr" is
> negative, it gets type promoted to a high positive value and the
> condition is false.  This patch fixes it by handling negatives separately.
>
> Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Thanks Dan, fix looks correct, just one comment inline.
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 7 +++----
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 2 +-
>  2 files changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> index 468fdd0d8713..17f99f0962d0 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> @@ -1047,11 +1047,10 @@ static int rtrs_map_sg_fr(struct rtrs_clt_io_req *req, size_t count)
>
>         /* Align the MR to a 4K page size to match the block virt boundary */
>         nr = ib_map_mr_sg(req->mr, req->sglist, count, NULL, SZ_4K);
> -       if (unlikely(nr < req->sg_cnt)) {
> -               if (nr < 0)
> -                       return nr;
> +       if (nr < 0)
> +               return -EINVAL;
Why not just return nr here?
> +       if (unlikely(nr < req->sg_cnt))
>                 return -EINVAL;
> -       }
>         ib_update_fast_reg_key(req->mr, ib_inc_rkey(req->mr->rkey));
>
>         return nr;
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> index ba8ab33b94a2..eefd149ce7a4 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> @@ -649,7 +649,7 @@ static int map_cont_bufs(struct rtrs_srv_sess *sess)
>                 }
>                 nr = ib_map_mr_sg(mr, sgt->sgl, sgt->nents,
>                                   NULL, max_chunk_size);
> -               if (nr < sgt->nents) {
> +               if (nr < 0 || nr < sgt->nents) {
>                         err = nr < 0 ? nr : -EINVAL;
>                         goto dereg_mr;
>                 }
> --
> 2.26.2
>
