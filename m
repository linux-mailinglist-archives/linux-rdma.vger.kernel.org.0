Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37DD1486AB5
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jan 2022 20:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbiAFTzh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jan 2022 14:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243460AbiAFTzg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Jan 2022 14:55:36 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA356C061245
        for <linux-rdma@vger.kernel.org>; Thu,  6 Jan 2022 11:55:36 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id v11so3421944pfu.2
        for <linux-rdma@vger.kernel.org>; Thu, 06 Jan 2022 11:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kilkNjlgBPzLpwZlydRX0XxoyxKLEi3W9JyLK07DMRs=;
        b=nWuQE7ivGg1p/uPqpriQOS5c8tUiElmqwHuiWGbLE5ID809I+QnD05FNYCK1Gk6vbJ
         Bh+IxqeOaaWqN/qk3d8P1Y8uKLCMk3jJU7QcWT/BUB6BtDb9fx8z60E3mD7YRu2TEzPx
         YyV9yGT3ij1hNNrBMG3JPjomhx+CUIkJcUJv/JZXEywUlMHwEaG3JP24fcur05DVsaNH
         pziGXygwGj7TzBoB6rnUK7lS8NNr3qHjsL+ED7eWpP/2jvTs3SX7pT2yRXzIcFS92cYN
         0Y4flKQ6+PPviJi7FCCA4N0NR5mlyrv8jLK9NPU5HLfP3KTMSqg6a/1Yjle8/W2XtFrc
         eCGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kilkNjlgBPzLpwZlydRX0XxoyxKLEi3W9JyLK07DMRs=;
        b=quk6oInAc/dvNm/znTueWIzGHwh6N5R9O8BIaP36lIPnAW0TOTz55peGC2iIyhxYz4
         Hqwkxs8S5l0Bd+l/ijzMGKQcngkzoboXddr0aUI+yMloY/OEzNmYEwPCqOgVota5rF/r
         rIAjy3ftJesHxNgTbfyzgt/geBbHT/Sy23o3VruM+A29zIVg7ex1wSt1CHYRanl63dC9
         AOWmClXUbrtQLn5Wnn/0AKZsMhXwX7Q4IJrAnKm0t8iZLkmvoLSj9Mu8mw4eWcDFm8A3
         AfCE8QL3qIHX8cn7uhYPe7Zp/INborE/U5jZJ3vax2wORl1BGom4kJOeyRS2yLetUJYQ
         81lQ==
X-Gm-Message-State: AOAM5336bE6Iezzn6IUfhM3m1fNInw84lOr8rC3ReTWTj7cZOLg69dAF
        LN4zg6hFARepp9T9y1BIXpWPwY32vn5SoldVDO8=
X-Google-Smtp-Source: ABdhPJxHKNgO9L0gFF5UFL52XdbfVuUq/HQtOs4GcrEnbr92s/e6XU1DwCfNL4VyKdHOgQnglCzVxRp5UnoskOru8jI=
X-Received: by 2002:a63:3f01:: with SMTP id m1mr31759754pga.446.1641498936220;
 Thu, 06 Jan 2022 11:55:36 -0800 (PST)
MIME-Version: 1.0
References: <20211229034438.1854908-1-yangx.jy@fujitsu.com> <20220106004005.GA2913243@nvidia.com>
In-Reply-To: <20220106004005.GA2913243@nvidia.com>
From:   Robert Pearson <rpearsonhpe@gmail.com>
Date:   Thu, 6 Jan 2022 13:55:25 -0600
Message-ID: <CAFc_bgZy_vpNtKzU0Az9qZvy8OoU9AYQRgQ_fzw3Pe9HFps1nA@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rxe: Check the last packet by RXE_END_MASK
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Xiao Yang <yangx.jy@fujitsu.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        yanjun.zhu@linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Yes.

On Wed, Jan 5, 2022 at 6:40 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Wed, Dec 29, 2021 at 11:44:38AM +0800, Xiao Yang wrote:
> > It's wrong to check the last packet by RXE_COMP_MASK because the flag
> > is to indicate if responder needs to generate a completion.
> >
> > Fixes: 9fcd67d1772c ("IB/rxe: increment msn only when completing a request")
> > Fixes: 8700e3e7c485 ("Soft RoCE driver")
> > Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> > ---
> >  drivers/infiniband/sw/rxe/rxe_resp.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
>
> Bob/Zhu is this OK?
>
> > diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> > index e8f435fa6e4d..380934e38923 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> > @@ -814,6 +814,10 @@ static enum resp_states execute(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
> >                       return RESPST_ERR_INVALIDATE_RKEY;
> >       }
> >
> > +     if (pkt->mask & RXE_END_MASK)
> > +             /* We successfully processed this new request. */
> > +             qp->resp.msn++;
> > +
> >       /* next expected psn, read handles this separately */
> >       qp->resp.psn = (pkt->psn + 1) & BTH_PSN_MASK;
> >       qp->resp.ack_psn = qp->resp.psn;
> > @@ -821,11 +825,9 @@ static enum resp_states execute(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
> >       qp->resp.opcode = pkt->opcode;
> >       qp->resp.status = IB_WC_SUCCESS;
> >
> > -     if (pkt->mask & RXE_COMP_MASK) {
> > -             /* We successfully processed this new request. */
> > -             qp->resp.msn++;
> > +     if (pkt->mask & RXE_COMP_MASK)
> >               return RESPST_COMPLETE;
> > -     } else if (qp_type(qp) == IB_QPT_RC)
> > +     else if (qp_type(qp) == IB_QPT_RC)
> >               return RESPST_ACKNOWLEDGE;
> >       else
> >               return RESPST_CLEANUP;
> > --
> > 2.25.1
> >
> >
> >
