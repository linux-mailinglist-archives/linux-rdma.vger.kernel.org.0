Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D503E1DAF98
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2020 12:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgETKC6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 May 2020 06:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgETKC5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 May 2020 06:02:57 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE53C061A0F
        for <linux-rdma@vger.kernel.org>; Wed, 20 May 2020 03:02:56 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l18so2511080wrn.6
        for <linux-rdma@vger.kernel.org>; Wed, 20 May 2020 03:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1qCv6LnZLkc+ZmnPCOEPg4bD3VkMCgmCeeQUPB4C/I0=;
        b=hfXYeUnhWNOwtlHWt2eKleoasP0dym5XUmGjSaHg/Z2K2jtArTTO3x4y7a8dMlhxrH
         DKf8goaYCAnj15G4odOw4+GL3Q3IK0aQiqBWCU7HVEzlxB3kmk5nub3JQ+dbai6EzHdJ
         nmJtlNgeKOuizOeGCNeFrABerhb8D++0aSmV+upWFflavoglLIZ7JilhwQu8VIhXio9+
         81VxZS6UdudVmCiRTY2uAcq4mGIJEQEKwTRiaZdCAbbrZzghAuMstaBBmjMFc/s6lhwl
         14UBCjUVO45XOvxYnN3oV0pdXea4bw9ZMFF/fu9ATRkyGnmHe0s3YaGxDfFzgWSmangT
         v2tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1qCv6LnZLkc+ZmnPCOEPg4bD3VkMCgmCeeQUPB4C/I0=;
        b=tS2xhDvH4JEDnq4lq/Mwg9uFXUl+aMtGlJmXKldW7NNwb+1kzM5eHR72I0pEs98X6J
         LdxnrocVjYyyeGQwX4FGz4loxleKoYandi7fXVp6YbvRw4K55gGYFjSLfPc/bUikku5G
         qyGkoMJ4TgyBPDsuyBO8BLC62BiXfXrFunAXVtdljfqGObOIjF4s95Kmv42WRVK+tq6j
         lBgSO3hmK3Fxlk8lLC2jBvB0EZGolSfJVTXc4MY95pKSnRm/eLslly9F+KZSKr05xbIh
         xG0qXkx40TGJajrQOEY8GgAgXVdL3w/dxxwwi1ak9270DdCQTWph2mskImY7Xgv9s27c
         +Dyw==
X-Gm-Message-State: AOAM5338T4JYnDRdJGvrqVi7f01bEBptgnB2tAc25TVf41wm1dH1OilE
        5BGeHFeampAgo6lHDLhE8ImQnsWZogzM5wqTFVw4
X-Google-Smtp-Source: ABdhPJyWKGgPEm8MEJcYvTt+gmwLU4TczJEEN4qYstbU9TkGgHS9VHqcYV+9vOtYxAfoKxCq2ii/INHntBZtNxUsmTY=
X-Received: by 2002:a5d:6705:: with SMTP id o5mr3601013wru.426.1589968975165;
 Wed, 20 May 2020 03:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200519112936.928185-1-danil.kipnis@cloud.ionos.com> <76b6b987-4f63-2487-7fbe-a1d9c2f06b76@acm.org>
In-Reply-To: <76b6b987-4f63-2487-7fbe-a1d9c2f06b76@acm.org>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Wed, 20 May 2020 12:02:44 +0200
Message-ID: <CAHg0HuwzuTAaaq6uuCD0sJJ2NwyATZRtMj_H1B8r8308EieKwA@mail.gmail.com>
Subject: Re: [PATCH v2] rtrs-clt: silence kbuild test inconsistent intenting
 smatch warning
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Jinpu Wang <jinpu.wang@cloud.ionos.com>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Bart,

On Tue, May 19, 2020 at 4:29 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-05-19 04:29, Danil Kipnis wrote:
> > Kbuild test robot reports a smatch warning:
> > drivers/infiniband/ulp/rtrs/rtrs-clt.c:1196 rtrs_clt_failover_req() warn: inconsistent indenting
> > drivers/infiniband/ulp/rtrs/rtrs-clt.c:2890 rtrs_clt_request() warn: inconsistent indenting
> >
> > To get rid of the warning, move the while_each_path() macro to a newline.
> > Rename the macro to end_each_path() to avoid the "while should follow close
> > brace '}'" checkpatch error.
> >
> > Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
> >
> > Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> > Reported-by: kbuild test robot <lkp@intel.com>
> > ---
> >  v1->v2 Add fixes line
> >  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > index 468fdd0d8713..0fa3a229d90e 100644
> > --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > @@ -734,7 +734,7 @@ struct path_it {
> >                         (it)->i < (it)->clt->paths_num;               \
> >            (it)->i++)
> >
> > -#define while_each_path(it)                                          \
> > +#define end_each_path(it)                                            \
> >       path_it_deinit(it);                                             \
> >       rcu_read_unlock();                                              \
> >       }
> > @@ -1193,7 +1193,8 @@ static int rtrs_clt_failover_req(struct rtrs_clt *clt,
> >               /* Success path */
> >               rtrs_clt_inc_failover_cnt(alive_sess->stats);
> >               break;
> > -     } while_each_path(&it);
> > +     }
> > +     end_each_path(&it);
> >
> >       return err;
> >  }
> > @@ -2887,7 +2888,8 @@ int rtrs_clt_request(int dir, struct rtrs_clt_req_ops *ops,
> >               }
> >               /* Success path */
> >               break;
> > -     } while_each_path(&it);
> > +     }
> > +     end_each_path(&it);
> >
> >       return err;
> >  }
>
> I don't like the do_each_path() and end_each_path() macros because these do not
> follow the pattern that is used elsewhere in the kernel to use a single macro
> to iterate over a custom container. Has it been considered to combine these two
> macros into a single macro, e.g. something like the following (untested) patch?
>
>
> Subject: [PATCH] Combine while_each_path() and do_each_path() into
>  for_each_path()
>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 23 +++++++++--------------
>  1 file changed, 9 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> index 468fdd0d8713..8dfa56dc32bc 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> @@ -727,18 +727,13 @@ struct path_it {
>         struct rtrs_clt_sess *(*next_path)(struct path_it *it);
>  };
>
> -#define do_each_path(path, clt, it) {                                  \
> -       path_it_init(it, clt);                                          \
> -       rcu_read_lock();                                                \
> -       for ((it)->i = 0; ((path) = ((it)->next_path)(it)) &&           \
> -                         (it)->i < (it)->clt->paths_num;               \
> +#define for_each_path(path, clt, it)                                   \
> +       for (path_it_init((it), (clt)), rcu_read_lock(), (it)->i = 0;   \
> +            (((path) = ((it)->next_path)(it)) &&                       \
> +             (it)->i < (it)->clt->paths_num) ||                        \
> +                    (path_it_deinit(it), rcu_read_unlock(), 0);        \
>              (it)->i++)
>
> -#define while_each_path(it)                                            \
> -       path_it_deinit(it);                                             \
> -       rcu_read_unlock();                                              \
> -       }
> -
>  /**
>   * list_next_or_null_rr_rcu - get next list element in round-robin fashion.
>   * @head:      the head for the list.
> @@ -1177,7 +1172,7 @@ static int rtrs_clt_failover_req(struct rtrs_clt *clt,
>         int err = -ECONNABORTED;
>         struct path_it it;
>
> -       do_each_path(alive_sess, clt, &it) {
> +       for_each_path(alive_sess, clt, &it) {
>                 if (unlikely(READ_ONCE(alive_sess->state) !=
>                              RTRS_CLT_CONNECTED))
>                         continue;
> @@ -1193,7 +1188,7 @@ static int rtrs_clt_failover_req(struct rtrs_clt *clt,
>                 /* Success path */
>                 rtrs_clt_inc_failover_cnt(alive_sess->stats);
>                 break;
> -       } while_each_path(&it);
> +       }
>
>         return err;
>  }
> @@ -2862,7 +2857,7 @@ int rtrs_clt_request(int dir, struct rtrs_clt_req_ops *ops,
>                 dma_dir = DMA_TO_DEVICE;
>         }
>
> -       do_each_path(sess, clt, &it) {
> +       for_each_path(sess, clt, &it) {
>                 if (unlikely(READ_ONCE(sess->state) != RTRS_CLT_CONNECTED))
>                         continue;
>
> @@ -2887,7 +2882,7 @@ int rtrs_clt_request(int dir, struct rtrs_clt_req_ops *ops,
>                 }
>                 /* Success path */
>                 break;
> -       } while_each_path(&it);
> +       }
>
>         return err;
>  }

This does look better. Will run it through tests.
