Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71CC0395C5
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 21:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730005AbfFGTdf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 15:33:35 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46040 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729081AbfFGTdf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jun 2019 15:33:35 -0400
Received: by mail-lj1-f195.google.com with SMTP id m23so2695078lje.12
        for <linux-rdma@vger.kernel.org>; Fri, 07 Jun 2019 12:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gEQTt/69w62CAMJlx7lidr4JWqQ1JSVOKzZe9wzUYD0=;
        b=WBAeb9YrKbAluVQu4nrMlV3okf6XsP120P+h1v7Rd4vr3vsnkTU4vgCpduY2YM5ezQ
         ZC8U/tNgH2EZA0xU6gYm6T8EHUBJFtOyB8pCUYpNHE0K2uu7cRS2HajdLzZVPGJNWmLP
         o5kn20ai9Nk6v1lhHpA15tdkXrTIPHbeu1KGol63jaJ85T1QmQKpgRq8dBfivro5TDq/
         0VVuFLvOpVZ30wfG4maqWRq7WEpWaiwNYozzr3KF2QYpm6e3SiLKwMCnouJNlEACXYDG
         /DhWUWfy9Gpre3kK/XzwNxujrgejdBj3ZDHJ4T5DTjCnGMOJBfhZFptCx2FUne4MeKwM
         KqOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gEQTt/69w62CAMJlx7lidr4JWqQ1JSVOKzZe9wzUYD0=;
        b=VekHtsEaU1MbviCJn/RvEC5D0HdUZGE2DxkD+UaxRnjEi7Xvi4ptFOZz05Iz8vWKJZ
         sCCsljvpZJraKunMlYR5mAa0Q5KDxPeNwmGLyfKI8O6nDQSIiJxWpnGiwS9L3elRNQFS
         4qTQ6Tt1z+YnlAI9O9AxCXc2M7CVFHxX75MtlaVlpZt2dhrFeszRFaGWFWeB6NRaKqSn
         ezPzS6DsBKKj+5ylDP27JA/H66I0UXEgpTl5DU4MGlCkidU7RQe/0C+cmjxtLfCo1WWy
         wCzvz+JX2tKX+kn3BsE9nb59naxSUoEhLwQC5RuXGLJq15SH9k8OLUqq01pxn5Ct39HO
         tBNQ==
X-Gm-Message-State: APjAAAWtSbQJBseMiP8Ecb3Ko15uOPcUWalQTRYumOJntv6t0CNJ+CwG
        /ITRSYNOfV+eCaA/BSZctawnayE4QpGBe3KOFqKQKREA
X-Google-Smtp-Source: APXvYqyV5At9/bNoRANbxY42yFL3bcvziWxc6FqbPzzHMOEDWF48b73ld+sfmXEOlH6jYmy6qcg6bXlVtdgv8tNf/9Q=
X-Received: by 2002:a2e:8696:: with SMTP id l22mr5536229lji.201.1559936013206;
 Fri, 07 Jun 2019 12:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190523153436.19102-1-jgg@ziepe.ca> <20190523153436.19102-10-jgg@ziepe.ca>
In-Reply-To: <20190523153436.19102-10-jgg@ziepe.ca>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sat, 8 Jun 2019 01:08:37 +0530
Message-ID: <CAFqt6zarGTZeA+Dw_RT2WXwgoYhnKP28LGfc+CDZqNFRexEXoQ@mail.gmail.com>
Subject: Re: [RFC PATCH 09/11] mm/hmm: Remove racy protection against double-unregistration
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 23, 2019 at 9:05 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> From: Jason Gunthorpe <jgg@mellanox.com>
>
> No other register/unregister kernel API attempts to provide this kind of
> protection as it is inherently racy, so just drop it.
>
> Callers should provide their own protection, it appears nouveau already
> does, but just in case drop a debugging POISON.
>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>  mm/hmm.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 46872306f922bb..6c3b7398672c29 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -286,18 +286,13 @@ EXPORT_SYMBOL(hmm_mirror_register);
>   */
>  void hmm_mirror_unregister(struct hmm_mirror *mirror)
>  {
> -       struct hmm *hmm = READ_ONCE(mirror->hmm);
> -
> -       if (hmm == NULL)
> -               return;
> +       struct hmm *hmm = mirror->hmm;

How about remove struct hmm *hmm and replace the code like below -

down_write(&mirror->hmm->mirrors_sem);
list_del_init(&mirror->list);
up_write(&mirror->hmm->mirrors_sem);
hmm_put(hmm);
memset(&mirror->hmm, POISON_INUSE, sizeof(mirror->hmm));

Similar to hmm_mirror_register().


>         down_write(&hmm->mirrors_sem);
>         list_del_init(&mirror->list);
> -       /* To protect us against double unregister ... */
> -       mirror->hmm = NULL;
>         up_write(&hmm->mirrors_sem);
> -
>         hmm_put(hmm);
> +       memset(&mirror->hmm, POISON_INUSE, sizeof(mirror->hmm));
>  }
>  EXPORT_SYMBOL(hmm_mirror_unregister);
>
> --
> 2.21.0
>
