Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5DA5A4395
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Aug 2022 09:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbiH2HN2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Aug 2022 03:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiH2HN1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Aug 2022 03:13:27 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11434D819
        for <linux-rdma@vger.kernel.org>; Mon, 29 Aug 2022 00:13:26 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id o4so7132639pjp.4
        for <linux-rdma@vger.kernel.org>; Mon, 29 Aug 2022 00:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=LPZotytenerIWF7sJ6aPAlDZ5wIJK/ijwTlWGfg4oG4=;
        b=T3YoQpPlr1Hb9zcnTlFjW4EGiY68wh1jkt1n5HcNocKRS+V+AFECT0hI3MbQihNN/Q
         i6xCUVInkdPu7olv/Dk8zBHOSoAXI1P1H9xh6VbSsdoFs+UvKb3aALDdu0qLxMezeeZj
         YMGraB0PacYoZ481tnT+fXE71KCHG2eztjFCOanM0TNAiCOrD40Lqe7N7bvF6iBeS2ib
         Qlq54B3g2yx5PEBznKwDJw0pkXwkuAsfRERLXiqYEtJYHvgK8kOSc1fxMvLfjf1Fb7Hy
         3+Kpuy4Cr8gmuE7D+o3tnsLDOmdBOE9GusgFSCCMnpvPBYYStsmHovWzXnlM5cTRdJqC
         wNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=LPZotytenerIWF7sJ6aPAlDZ5wIJK/ijwTlWGfg4oG4=;
        b=j0Sxz9blb/ieQJgGrvqR6oQ+dZRN3M9qDes87b+we5VGwGL1uqkuhZ16XP9pAyIKzP
         LOME8rKkujR+9OjZLge2iVdQfWfchx2ngWuU9tGds4Rf007x9E2ug42K7HWIZ4icSt78
         eVNSOh8a6RI214QBqiS4jPUdt6ZCK3Hqx5Ap107a9cqopPkioAqjvJrfUUoLfODi398T
         fDkhDX7p5MDBlWHlVUXhBJgSWWIomi8qMJ4lnDhCPxKq6sBE4npUmUc3Idl771dAN1HU
         R5DrwWdjsrHpxwRbV1yxbruHWnM7Ux+CrGuyOTV120ydsi1gIaMod7Bp1aNntR/uoNPV
         zzzA==
X-Gm-Message-State: ACgBeo2WStwSgHr61UqOYzb3TOUxS2jl1BrqUXoQ6NQj28ttgOXflLvL
        REBYArQ30+4WhJjNQGy22dWVxAQuYuT8YMGNcF8=
X-Google-Smtp-Source: AA6agR4hk8KTO/o7W+RmNUnVKf62MCEdJNNVHD9lfsTC4zkWM7WcLitXiSgN32jTNtfnoSS4JzP5Ke7AcQr4cOqcUmk=
X-Received: by 2002:a17:902:d550:b0:174:9dcf:93d8 with SMTP id
 z16-20020a170902d55000b001749dcf93d8mr6215749plf.145.1661757206328; Mon, 29
 Aug 2022 00:13:26 -0700 (PDT)
MIME-Version: 1.0
References: <Ywi8ZebmZv+bctrC@nvidia.com> <20220829054413.1630495-1-matsuda-daisuke@fujitsu.com>
 <CAD=hENf0d_HyPRi2wmWLswULrn9UWHvQvz54-E7=M5DTSB-qGg@mail.gmail.com> <Ywxkj4JqZpFr6w+V@unreal>
In-Reply-To: <Ywxkj4JqZpFr6w+V@unreal>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Mon, 29 Aug 2022 15:13:14 +0800
Message-ID: <CAD=hENdqqPqTAXVYcjZ9n-MBWD6mMww9r1o9FE+NNFhUr3y6kA@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rxe: Delete error messages triggered by incoming
 Read requests
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 29, 2022 at 3:02 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Mon, Aug 29, 2022 at 02:31:00PM +0800, Zhu Yanjun wrote:
> > On Mon, Aug 29, 2022 at 1:45 PM Daisuke Matsuda
> > <matsuda-daisuke@fujitsu.com> wrote:
> > >
> > > An incoming Read request causes multiple Read responses. If a user MR to
> > > copy data from is unavailable or responder cannot send a reply, then the
> > > error messages can be printed for each response attempt, resulting in
> > > message overflow.
> > >
> > > Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> > > ---
> > >  drivers/infiniband/sw/rxe/rxe_resp.c | 6 +-----
> > >  1 file changed, 1 insertion(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> > > index b36ec5c4d5e0..4b3e8aec2fb8 100644
> > > --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> > > +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> > > @@ -811,8 +811,6 @@ static enum resp_states read_reply(struct rxe_qp *qp,
> > >
> > >         err = rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
> > >                           payload, RXE_FROM_MR_OBJ);
> > > -       if (err)
> > > -               pr_err("Failed copying memory\n");
> >
> > pr_err_once is better?
>
> Like Jason said, there shouldn't any prints in network triggered flows.
>

Ok, thanks.

Zhu Yanjun
> Thanks
