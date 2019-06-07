Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D542139673
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 22:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729977AbfFGUIK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 16:08:10 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38219 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729342AbfFGUIK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jun 2019 16:08:10 -0400
Received: by mail-lf1-f68.google.com with SMTP id b11so2518242lfa.5
        for <linux-rdma@vger.kernel.org>; Fri, 07 Jun 2019 13:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QDK3Ccwx6XT9W6QHiKSRwInuQJSgvhMen0AzjEbYCA8=;
        b=CI1ZG2byPK/1Kx8LZGxmpQVJbJPwAqQiJocZJTlvpGxmCbijp6s/MCkHKaIeulCqHm
         jkzBrAdWPEJYL7EChVEhSiSL7fH/uls6StJKdkrQ5+Q01AJSmPLrW82w/L+Hn1S73z+Q
         eyuKALMZREPHrLDajs0j38+UZFCBbs1bFRfrvM40LOT8ZeGSwORrXT3ZIw6l6e+DYtyO
         WHj3L2BKr8MObeNnmJF4CZwwqvoF+GvIu23HNTC/PhyX1ZAprAr1cMW2llBY8qa9UfbT
         n0rS9y7xpuoSaMNzM0KoPozltJ5AIo5wBfdosSEzNtv1l1F1knPWA4PyuP18dJYg4v87
         a46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QDK3Ccwx6XT9W6QHiKSRwInuQJSgvhMen0AzjEbYCA8=;
        b=VNqbUyCNKSAexCCSLKL6Fe0iJmZrsh/CwSLt3rUqPum6MqjssVbayMuC1DWuotDZsy
         uLnNCRTlQohpz0aRhjv5vd7fPGHR7uxx0gWZDgAhUJP+9IpLEHaV+TVJD9LY9Q2zpN40
         DvkEGHvSGMIlE7CNeMtZGau1NfN662W7z7qp+5WgjS0fI2p4JRM++ZV8QSPKxSiDNEIL
         WPs4czlTBA+K0f36vmlr/Id+N0/7fqUOZLlohmkXb2NNaI//tKw7L/Q+TzvT4z51IVfH
         h1iC+Iqhz0Iu9JSR0i51L7Vkx84hgXKvu5aIv4PYMdV3Qgm68MiXPTbaGBmHxRLszCG3
         t/Vw==
X-Gm-Message-State: APjAAAX8ZMrnPWvWdsgXfoHnfJOC2Gp/Hn1Y+BuvHSIl0qgj/YpDLY1s
        00TARbVrfggEoOWO/gXC7smxO3jtnPH+E9+wDVDYjA==
X-Google-Smtp-Source: APXvYqwqkSPR8EIsmRv7XptKwGZtNlG6WGTa+Aw0Rgt8bmKe6Kk78did3YSh+DNFgKoB7girGDdcu1ECBFa9wEIQIxM=
X-Received: by 2002:ac2:4ac5:: with SMTP id m5mr4305451lfp.95.1559938088611;
 Fri, 07 Jun 2019 13:08:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190523153436.19102-1-jgg@ziepe.ca> <20190523153436.19102-11-jgg@ziepe.ca>
In-Reply-To: <20190523153436.19102-11-jgg@ziepe.ca>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sat, 8 Jun 2019 01:43:12 +0530
Message-ID: <CAFqt6zatjZdCzd=cg-kZiajsSwF6Jr+d-rL_vQ9kMtHjcDx8uQ@mail.gmail.com>
Subject: Re: [RFC PATCH 10/11] mm/hmm: Poison hmm_range during unregister
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
> Trying to misuse a range outside its lifetime is a kernel bug. Use WARN_ON
> and poison bytes to detect this condition.
>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>

Acked-by: Souptick Joarder <jrdr.linux@gmail.com>

> ---
>  mm/hmm.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 6c3b7398672c29..02752d3ef2ed92 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -936,8 +936,7 @@ EXPORT_SYMBOL(hmm_range_register);
>   */
>  void hmm_range_unregister(struct hmm_range *range)
>  {
> -       /* Sanity check this really should not happen. */
> -       if (range->hmm == NULL || range->end <= range->start)
> +       if (WARN_ON(range->end <= range->start))
>                 return;

Does it make any sense to sanity check for range == NULL as well ?
>
>         mutex_lock(&range->hmm->lock);
> @@ -945,9 +944,13 @@ void hmm_range_unregister(struct hmm_range *range)
>         mutex_unlock(&range->hmm->lock);
>
>         /* Drop reference taken by hmm_range_register() */
> -       range->valid = false;
>         hmm_put(range->hmm);
> -       range->hmm = NULL;
> +
> +       /* The range is now invalid, leave it poisoned. */
> +       range->valid = false;
> +       range->start = ULONG_MAX;
> +       range->end = 0;
> +       memset(&range->hmm, POISON_INUSE, sizeof(range->hmm));
>  }
>  EXPORT_SYMBOL(hmm_range_unregister);
>
> --
> 2.21.0
>
