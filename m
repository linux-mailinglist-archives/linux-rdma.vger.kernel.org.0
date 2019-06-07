Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1E913969F
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 22:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbfFGUR3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 16:17:29 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34947 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729153AbfFGUR3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jun 2019 16:17:29 -0400
Received: by mail-lf1-f67.google.com with SMTP id a25so2547550lfg.2
        for <linux-rdma@vger.kernel.org>; Fri, 07 Jun 2019 13:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eB+zLVLfAFyykufn/XC4ip2S/T+nSU9Oi0mJz6C4cpk=;
        b=FQqTRrXgGS2jrJ8I3nnXEyz2J4J11YDw6Eag8y7l5BvDnfSjpG1M4GmyfNT5sGdpoD
         sgC36jHnS3Kftnrz495NnejxTN2ls148Epcko/zcjwy9K1EHa50DWUuX2a1xSerz/iIl
         yoZ/8N/+HT/+IKU8ghKoUJzRCokbG13Qv/KxiGrekQF766ps+91rNWtpBKwmIFV0IMyk
         8gi1d9GmB1AiVLMDIqq1LjL9Hzy9OSXEGX9NUcrDInpXqQjQSvmk/j3CJmb5J2/sHXBo
         XGWKnQVPZN6czIVgNxg2kjczorGxN3bjRSv1zS8Ys+3+f/LCxNuRn8jrIoTnvnw58pjZ
         dtFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eB+zLVLfAFyykufn/XC4ip2S/T+nSU9Oi0mJz6C4cpk=;
        b=BYVqmyGEPp/BqqLZ0tz0mNl966IjTW6BDrxVtrLmY28VTcWhThktJjYVKz7EeLMKbk
         pQIpIt/LNVN4eXRPmqsXctcAhO7Z2+ecK4sj7x1bPlzBKsDamV9PZ6s3RP6Mx+pqAmfY
         G84mhm92uvgPLTnN6pKyCLZlLVKunGJ9BzqZghMi5KoJbJhQUn3rPETE1EylHIojFKkH
         ZQxaf+6ZGxnTRM5ZN8iGH66EWjTgRQ8BPkggBE6+v0vdF1XrGzzqGQWrE4MsAtS8HoUl
         GGz3UdWVdK4szkynD0hWV9BPIwSy6gOad4TuZDncIvJkivU7SAIFTrpLmRVJBp70nYz4
         eEeA==
X-Gm-Message-State: APjAAAXc9dXjZG6UQWQKIWPmD4aX3sj5B43u3gQqFMVwVmQwkUg+6Qrd
        uYOydUoQR4rAeqxFUyjZrWyUiIIn1kcHh6HbUzw=
X-Google-Smtp-Source: APXvYqwNbS5okzmn/wvJQhaWtqRFW+VpDLbfpOAnq+OdiQj/sI6qsKbd8tQnL6UsJJdy6cQHjAVmjxfhz9/5+/oHQpA=
X-Received: by 2002:ac2:5212:: with SMTP id a18mr20962797lfl.50.1559938648148;
 Fri, 07 Jun 2019 13:17:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190523153436.19102-1-jgg@ziepe.ca> <20190523153436.19102-12-jgg@ziepe.ca>
In-Reply-To: <20190523153436.19102-12-jgg@ziepe.ca>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sat, 8 Jun 2019 01:52:32 +0530
Message-ID: <CAFqt6zado2ZFTuXbbp4WZDqJ5cXe1LJGb+rAa4SvsF23jY4aWQ@mail.gmail.com>
Subject: Re: [RFC PATCH 11/11] mm/hmm: Do not use list*_rcu() for hmm->ranges
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
> This list is always read and written while holding hmm->lock so there is
> no need for the confusing _rcu annotations.
>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>

Acked-by: Souptick Joarder <jrdr.linux@gmail.com>

> ---
>  mm/hmm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 02752d3ef2ed92..b4aafa90a109a5 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -912,7 +912,7 @@ int hmm_range_register(struct hmm_range *range,
>         /* Initialize range to track CPU page table update */
>         mutex_lock(&range->hmm->lock);
>
> -       list_add_rcu(&range->list, &range->hmm->ranges);
> +       list_add(&range->list, &range->hmm->ranges);
>
>         /*
>          * If there are any concurrent notifiers we have to wait for them for
> @@ -940,7 +940,7 @@ void hmm_range_unregister(struct hmm_range *range)
>                 return;
>
>         mutex_lock(&range->hmm->lock);
> -       list_del_rcu(&range->list);
> +       list_del(&range->list);
>         mutex_unlock(&range->hmm->lock);
>
>         /* Drop reference taken by hmm_range_register() */
> --
> 2.21.0
>
