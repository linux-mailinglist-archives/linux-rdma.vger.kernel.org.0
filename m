Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4739609836
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Oct 2022 04:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiJXC0M (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 23 Oct 2022 22:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiJXC0L (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 23 Oct 2022 22:26:11 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D085D0D8;
        Sun, 23 Oct 2022 19:26:10 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id q9-20020a17090a178900b00212fe7c6bbeso2022981pja.4;
        Sun, 23 Oct 2022 19:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=71rjY3eLm+7RTIJeX7H54aiz+xuwcwUC1e8Fpch6tyk=;
        b=d/l60TUozsO8NzthUJnNGQjNDekj6EZ059Bj/Yu232ph2q3G9tEcGVoNbRDHlPh7KO
         z0ZToBrJsdjnhcGrnvJx+Lj8KOAITTi43vpnFusHSh7ZJ7SEusRBe+YonMHTBvZ96awj
         jwq/5vXY+kZmJtwbttrJatDjk/ovmttkZ0Kz6iF73H6zQL4RMmcSgbernXCAZclytEgX
         ARGXt9z34OUu3b4B73oKec1yRltf3UQGwhQqpYMTVHKb3L5arNM4Q4GV+cmrAvNDc8zr
         Bis4UBgYAFIzeCRM3yLxNUlgWCqDW2fZpgGai1aflf+nHsrUbf2j+7wAcGtbAbpjUcXi
         GaCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=71rjY3eLm+7RTIJeX7H54aiz+xuwcwUC1e8Fpch6tyk=;
        b=LEZ1CPr/RDUQclT8rysOxaLsVBaxCXI+jf2SVYduK96yGiZLnEsjn4TR9LNERy7zWw
         chJyt+t2QlJwPow+YbYHwaRvyOGT+YxK6VkbNljd4MXEJrEfx6TCGdUiPC9vWQh4iLw1
         Nu2QmzChzXOh6j+iA6mdchFuGz5gfY0H6InI+e5Rb1CzNwAbVZidNllVL9FVvl4WgT9/
         7GIcvVX0N2/a8vBU2EQOcIaJyBh/iDWXxGS5U+H+UXefyNUeTts2xYjer5Dw1uTWVxax
         rBRga3P2nzli0ybPdLaRcnrLYTjJ69glge7AaT+fApPXmraDJB6ZVxvkpQw8BQ8aWpT8
         VbvA==
X-Gm-Message-State: ACrzQf2SyQW/9ESX0ZQiRVbuEzVEBQZ54WMu99VmIOrTaB3g8tp8zw3Z
        wpmNATPE1mGKnpJifxvM1YwpMPilNQp8a8bHejs=
X-Google-Smtp-Source: AMsMyM5XXS5doRLt3gET5d9S+BTfM6vYGER4xgnWkcA/iyiiQPqTJ29gd3agZia8krEz+aGNcjnF2uf45vIY0T9ShsE=
X-Received: by 2002:a17:902:f78b:b0:17f:9c94:b247 with SMTP id
 q11-20020a170902f78b00b0017f9c94b247mr30116589pln.137.1666578369902; Sun, 23
 Oct 2022 19:26:09 -0700 (PDT)
MIME-Version: 1.0
References: <1666338764-2-1-git-send-email-lizhijian@fujitsu.com>
 <1666338764-2-2-git-send-email-lizhijian@fujitsu.com> <CAD=hENeGMKri0nYMtcu98K2j3D+ZBkxO6fFX5cvvyJsEghrrmQ@mail.gmail.com>
 <1846f2e1-ff13-5fa2-240f-fd7749921ce2@fujitsu.com> <30ff25c4-ce66-eac4-eaa2-64c0db203a19@gmail.com>
In-Reply-To: <30ff25c4-ce66-eac4-eaa2-64c0db203a19@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Mon, 24 Oct 2022 10:25:58 +0800
Message-ID: <CAD=hENeTnLGN5KKi_Cwni6FDb77prijHVjCjfdvhrjXdp7bdjQ@mail.gmail.com>
Subject: Re: [for-next PATCH v2 1/2] RDMA/rxe: Remove unnecessary mr testing
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Li Zhijian <lizhijian@fujitsu.com>, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 24, 2022 at 2:05 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> On 10/21/22 20:09, Li Zhijian wrote:
> >
> >
> > On 21/10/2022 22:39, Zhu Yanjun wrote:
> >> On Fri, Oct 21, 2022 at 3:53 PM Li Zhijian <lizhijian@fujitsu.com> wrote:
> >>> Before the testing, we already passed it to rxe_mr_copy() where mr could
> >>> be dereferenced. so this checking is not exactly correct.
> >>>
> >>> I tried to figure out the details how/when mr could be NULL, but failed
> >>> at last. Add a WARN_ON(!mr) to that path to tell us more when it
> >>> happends.
> >> If I get you correctly, you confronted a problem,
> > Not exactly,  I removed the mr checking since i think this checking is not correct.
> > the newly added WARN_ON(!mr) is the only once place where the mr can be NULL but not handled correctly.
> > At least with/without this patch, once WARN_ON(!mr) is triggered, kernel will go something wrong.
> >
> > so i want to place this  WARN_ON(!mr) to point to the problem.
> >
> > Thanks
> > Zhijian
> >
> >>   but you can not figure it out.
> >> So you send it upstream as a patch?
> >>
> >> I am not sure if it is a good idea.
> >>
> >> Zhu Yanjun
> >>
> >>> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> >>> ---
> >>>   drivers/infiniband/sw/rxe/rxe_resp.c | 4 ++--
> >>>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> >>> index ed5a09e86417..218c14fb07c6 100644
> >>> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> >>> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> >>> @@ -778,6 +778,7 @@ static enum resp_states read_reply(struct rxe_qp *qp,
> >>>          if (res->state == rdatm_res_state_new) {
> >>>                  if (!res->replay) {
> >>>                          mr = qp->resp.mr;
> >>> +                       WARN_ON(!mr);
> >>>                          qp->resp.mr = NULL;
> >>>                  } else {
> >>>                          mr = rxe_recheck_mr(qp, res->read.rkey);
> >>> @@ -811,8 +812,7 @@ static enum resp_states read_reply(struct rxe_qp *qp,
> >>>
> >>>          rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
> >>>                      payload, RXE_FROM_MR_OBJ);
> >>> -       if (mr)
> >>> -               rxe_put(mr);
> >>> +       rxe_put(mr);
> >>>
> >>>          if (bth_pad(&ack_pkt)) {
> >>>                  u8 *pad = payload_addr(&ack_pkt) + payload
> >>> --
> >>> 2.31.1
> >>>
> >
>
> Li is correct that the only way mr could be NULL is if qp->resp.mr == NULL. So the

What I am concerned about is if "WARN_ON(!mr);" should be added or not.
IMO, if the root cause remains unclear, this should be a problem.
Currently this problem is not fixed. It is useless to send a debug
statement to the maillist.

Zhu Yanjun

> 'if (mr)' is not needed if that is the case. The read_reply subroutine is reached
> from a new rdma read operation after going through check_rkey or from a previous
> rdma read operations from get_req if qp->resp.res != NULL or from a duplicate request
> where the previous responder resource is found. In all these cases the mr is set.
> Initially in check_rkey where if it can't find the mr it causes an RKEY_VIOLATION.
> Thereafter the rkey is stored in the responder resources and looked up for each
> packet to get an mr or cause an RKEY_VIOLATION. So the mr can't be NULL. I think
> you can leave out the WARN and just drop the if (mr).
>
> Bob
>
