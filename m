Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29E0570356
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Jul 2022 14:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbiGKMvn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 Jul 2022 08:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbiGKMvn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 Jul 2022 08:51:43 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A262A96D
        for <linux-rdma@vger.kernel.org>; Mon, 11 Jul 2022 05:51:42 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id u12so8633657eja.8
        for <linux-rdma@vger.kernel.org>; Mon, 11 Jul 2022 05:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JkioUlyXsWtostATJ3u0HnRvtF12CIZO0nbupsZilPE=;
        b=UwTjZqh5FPE3v+aEWCKeALzktrkdLFKO/hnpxSxbeMzboGZWVkPEp9yvyvMe+yELqx
         hSi2YcYBF4+JLuVarZptcBaoFqRt1JjuUSHnFY2vN+KVCkRs2GLnC36hAgdYlAQwpJos
         RWQX0hzozSDrPd0gmgUCkkv74VkRMT7ZXl6637NmAIy0T4/WuVQ0KK14odBLhdvxyIAf
         MA0exyizlmjdmPvaAjhqOh+EycJ8eZqMf51z/haO4CnCUKlInu++hx/68aVt/IKJ/WN+
         bcNY1YDosCPZylceFLu/6aOOCKUxjdF8yCQdfe3Q/otfz5IaKTf+Ti3g2vA73nxxBNeQ
         779A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JkioUlyXsWtostATJ3u0HnRvtF12CIZO0nbupsZilPE=;
        b=wjizKzE6L7qcoz6eINTTsCNQOWO1mDP1k9uf4+pmVvLwNqjGZorAQc9lmPKOvRhW8w
         OvFgG0e298gLZOkMtp4iAMItcTkmauW6qMpJrzXNopVb//vWpKJLhm8lwpJbyLRZvMYk
         XIijeVQkUbuCv5MdIjNoGYODNxKBfWnB8v8BKP+79LCiKvzldQIN7XdDyIsSExMuVPOj
         m5G6zmxNvsILOspuhg/8/bKudTsJO/v9BTtqYrWaAflm4IUFsZTSVHjFVccxKpm3Z29V
         8lfDCcZfnHjVOrsaJwqoUZ6aReymBAEx1I77O0sKdxhIpcXZx8fcuN6DF5qOv96j8hzc
         yjpw==
X-Gm-Message-State: AJIora8oi7JwmKXd6+TQyEuFiS0oVhL8NLx6vI9E+TE3KS/9O/LVgA5b
        034v6FY6/3izZj+FWhRrATFftLuIBNfGCXwvkbJY1gmUht0=
X-Google-Smtp-Source: AGRyM1tOtK7xAhQOCFytdJvSDS2LIAxhU6MnGCessw8gltyNFqrPs7d3fenAXsf0Iecioj+FkPNGYMZRi7TI/gdYzY0=
X-Received: by 2002:a17:906:d54f:b0:726:2c7c:c0f9 with SMTP id
 cr15-20020a170906d54f00b007262c7cc0f9mr18599577ejc.441.1657543900546; Mon, 11
 Jul 2022 05:51:40 -0700 (PDT)
MIME-Version: 1.0
References: <ca9c5c8301d76d60de34640568b3db0d4401d050.1657298747.git.christophe.jaillet@wanadoo.fr>
 <b71ccfaf4a47dee8e1ad373604c861479d499b6b.1657298747.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <b71ccfaf4a47dee8e1ad373604c861479d499b6b.1657298747.git.christophe.jaillet@wanadoo.fr>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Mon, 11 Jul 2022 14:51:30 +0200
Message-ID: <CAMGffEngaZFX+B22shwOFDQN_MM==Uy+8NuHGAKfeyGwFd6N6w@mail.gmail.com>
Subject: Re: [PATCH 2/2] RDMA/rtrs-clt: Use bitmap_empty()
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 8, 2022 at 6:47 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Use bitmap_empty() instead of hand-writing them.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
Thx!
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> index 06c27a3d83f5..8441f0965b56 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> @@ -1433,12 +1433,10 @@ static int alloc_permits(struct rtrs_clt_sess *clt)
>
>  static void free_permits(struct rtrs_clt_sess *clt)
>  {
> -       if (clt->permits_map) {
> -               size_t sz = clt->queue_depth;
> -
> +       if (clt->permits_map)
>                 wait_event(clt->permits_wait,
> -                          find_first_bit(clt->permits_map, sz) >= sz);
> -       }
> +                          bitmap_empty(clt->permits_map, clt->queue_depth));
> +
>         bitmap_free(clt->permits_map);
>         clt->permits_map = NULL;
>         kfree(clt->permits);
> --
> 2.34.1
>
