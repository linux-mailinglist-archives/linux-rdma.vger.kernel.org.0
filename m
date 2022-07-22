Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D199C57D9A9
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Jul 2022 06:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiGVErV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Jul 2022 00:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiGVErU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Jul 2022 00:47:20 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD8E55A3;
        Thu, 21 Jul 2022 21:47:19 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id bb16so4541709oib.11;
        Thu, 21 Jul 2022 21:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/vmP9s72Bad+zjJeWAyuYUrRse9QKTisgeD/ZZJLIT8=;
        b=N8A6hIm4GgOAmOVwqSaOXJ+8HtUPtcRmobA5uC5/TWbP1rvEw/O9ISX4watCdO0izn
         wRjWKP2+rUb+BUfLym2QtOAmIfunAsrJ8VfGOB8ESQxSctcZM4TzrTdDMoNHWQKrfiuE
         m+cVilw1lBOLzriftx46rhGiO8qpiGY3jp+LJpQVVuzJD1oop/V+L9C8ymNslLTGUCOp
         CF235Mwc2kkpspsClLRyGgJGFwRCu9x1IGsrW7stIgwSoVsrQxpcf4x6g8uCcOFjXQFr
         HC/7FP0Nm1GwdQcDVtcgFcuED4KssS4dspmGT9r35vr2CEvgUAWiKIRIdW+cvT8i9WAm
         BWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/vmP9s72Bad+zjJeWAyuYUrRse9QKTisgeD/ZZJLIT8=;
        b=Wyqkv4sSmSqJCeYoy06EwUjqEcb5xl8p4Z3fizqe2PSTp9YqBzfMuMFt/3Y5Ubrh9r
         dBAvdxquuQM+vWBvbslPJjmFcZYTVL/rPgSLls0oaRgGvR9kt+3tcHIyEDlW56Mkcro2
         KKcjr2Q7a8Fpk3o9UQhEygeVDs76SOPskB7+wImkzb07iS2QFsdILpiY3OP0bWwqpK5R
         qR5o0SovItxAUiKYpGiNvextgNs8s+VlNuwOIrFJiJgtm78DRgUZi1BtNr6sy2JrLds1
         d8PVeIHrT1S0iIxn7Xvx/0MFY15RIwc0LnFcR05oja6pWCeUYqVOkc3Yw6R/y9HMBiny
         wkZQ==
X-Gm-Message-State: AJIora8MDxSnzIAwc95TNGwjInFOYfTfa/9K6msopWKa59XX0cJ0O3sH
        M1kaOJp/4bSreAkIROKYf9oNVCk7pW7Ts7ZI02SHHH/6L6kEng==
X-Google-Smtp-Source: AGRyM1tyRzY8MKTE+llnbWBeG8pkKan4y5TpOI+s1ZzxiZCdCuXKJ/wVy8u8SzwyCgbBxFhO96ADGHGDo9RqLUMkEtA=
X-Received: by 2002:a05:6808:13d6:b0:33a:aae5:853f with SMTP id
 d22-20020a05680813d600b0033aaae5853fmr3636767oiw.147.1658465237871; Thu, 21
 Jul 2022 21:47:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220719090948.612921-1-zys.zljxml@gmail.com> <Ytj9pHgPmp9rYeku@unreal>
In-Reply-To: <Ytj9pHgPmp9rYeku@unreal>
From:   Katrin Jo <zys.zljxml@gmail.com>
Date:   Fri, 22 Jul 2022 12:47:06 +0800
Message-ID: <CAOaDN_TJ7vD=jLYUh+ZZFDYchfim_4FgjeRgYDEbV-qjiRS6HA@mail.gmail.com>
Subject: Re: [PATCH] RDMA/cxgb4: Cleanup unused assignments
To:     Leon Romanovsky <leon@kernel.org>
Cc:     bharat@chelsio.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Yushan Zhou <katrinzhou@tencent.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 21, 2022 at 3:18 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Tue, Jul 19, 2022 at 05:09:48PM +0800, zys.zljxml@gmail.com wrote:
> > From: Yushan Zhou <katrinzhou@tencent.com>
> >
> > The variable err is reassigned before the assigned value works.
> > Cleanup unused assignments reported by Coverity.
> >
> > Addresses-Coverity: ("UNUSED_VALUE")
> > Signed-off-by: Yushan Zhou <katrinzhou@tencent.com>
> > ---
> >  drivers/infiniband/hw/cxgb4/cm.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
> > index c16017f6e8db..3462fe991f93 100644
> > --- a/drivers/infiniband/hw/cxgb4/cm.c
> > +++ b/drivers/infiniband/hw/cxgb4/cm.c
> > @@ -1590,7 +1590,6 @@ static int process_mpa_reply(struct c4iw_ep *ep, struct sk_buff *skb)
> >                                       insuff_ird = 1;
> >                       }
> >                       if (insuff_ird) {
> > -                             err = -ENOMEM;
> >                               ep->ird = resp_ord;
> >                               ep->ord = resp_ird;
> >                       }
> > @@ -1655,7 +1654,7 @@ static int process_mpa_reply(struct c4iw_ep *ep, struct sk_buff *skb)
> >               attrs.ecode = MPA_NOMATCH_RTR;
> >               attrs.next_state = C4IW_QP_STATE_TERMINATE;
> >               attrs.send_term = 1;
> > -             err = c4iw_modify_qp(ep->com.qp->rhp, ep->com.qp,
> > +             c4iw_modify_qp(ep->com.qp->rhp, ep->com.qp,
> >                               C4IW_QP_ATTR_NEXT_STATE, &attrs, 1);
> >               err = -ENOMEM;
>
> I would prefer do not overwrite errors returned from the functions
> unless it is really necessary.
>
> Can anyone from chelsio help here?
>
> Thanks
>
> >               disconnect = 1;
> > @@ -1674,7 +1673,7 @@ static int process_mpa_reply(struct c4iw_ep *ep, struct sk_buff *skb)
> >               attrs.ecode = MPA_INSUFF_IRD;
> >               attrs.next_state = C4IW_QP_STATE_TERMINATE;
> >               attrs.send_term = 1;
> > -             err = c4iw_modify_qp(ep->com.qp->rhp, ep->com.qp,
> > +             c4iw_modify_qp(ep->com.qp->rhp, ep->com.qp,
> >                               C4IW_QP_ATTR_NEXT_STATE, &attrs, 1);
> >               err = -ENOMEM;
> >               disconnect = 1;
> > --
> > 2.27.0
> >

The issue is that, in the original code, there were 2 subsequent
assignments to the `err` variable. I assume this is not expected. (I
tried to keep the exact same behavior as original code in this patch)

Should we keep the first assignment (c4iw_modify_qp), or the second
assignment (-ENOMEM)? I'd really appreciate some help here.

Best Regards,
Katrin
