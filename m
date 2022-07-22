Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD03957E02B
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Jul 2022 12:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235202AbiGVKnm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Jul 2022 06:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235129AbiGVKnl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Jul 2022 06:43:41 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81B1BB5C4
        for <linux-rdma@vger.kernel.org>; Fri, 22 Jul 2022 03:43:39 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id e11so4977015ljl.4
        for <linux-rdma@vger.kernel.org>; Fri, 22 Jul 2022 03:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z4wci0FSdXRSQOFvNZ+NIfVlyvQ7a48Qnafkh39PYKg=;
        b=hsmBtbfDMDFpdAYmL1cUR9GKxFSm1+i6QBHhSQdkLBi9Pq6XdcOCewENlYR8GgUtsj
         nqW6OgKaCjB2panWswYFAqxCMCUE/+PWSNY/tYdU/lOrCDSbbyfmR9Br+8icbHwTUGUK
         2Ne/2TC68g5eQBBONcEOW9Luh+gzl07+Mp8plkB0znxI7tQDT80nC15wst/CWNuC+pq7
         u5KFUWuDhYBxoRpapUUP0nOrFPaqqCI8NXz/maeWQ0GAzDQNZ78vJtM0JaEUIVkNY97Y
         lg8n28DACGhb8TJqq9yMyqwHYE+tRkLQc5tN5RrJS22smCmI1/e9ESIAkfnb4CiGqyfP
         1gzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z4wci0FSdXRSQOFvNZ+NIfVlyvQ7a48Qnafkh39PYKg=;
        b=K/jG7YMOZnh/8Psyr4V9ClpoNnGziyamg49L5ePtldFrcpBy/ciFgHukpUdXSFy/ov
         s4D/dSXiB4u/pFT+SHZAbP7e4zwd5fnqHVplsf1p5uiZ0zgTt3OKe40VPbxhSQ2mgMU4
         D8kxIFwBJkpLsVBKp3++l6oGAmBpawB52bMoOnbHM5nmQgjLkGQ/m99RWjWQdeH7woj/
         GhlOuBIxMthx0EeonAxxhGCFDbVI1XNXcUYvClHyjxQ9ZhPOyPCt5SkLBdkHIC7kw+UG
         gmJ/xfYR5i9W9s8UaKAsBVBoL6oMtzeANp8cPrHFq3DjVBKrOlCdPNR9zdx9Bfyq6Ki1
         BEXg==
X-Gm-Message-State: AJIora8v1TespZHntUHaVrPxfFg8XWxrhlB3MkLNQHiZ6CxJZP6ao/jy
        tx4KbuwSKJ+5S55eJpWb6TbZ0Wcwppj5jDIYSdDh+vgooy0MOg==
X-Google-Smtp-Source: AGRyM1uvfzJ6fc1yZqPY22fBgVWczJY+LInL8NF8/usLu8VeA6kTferPU7MKIU+C84+GQFyvuaXTpYaPIyZAsZ0lpO8=
X-Received: by 2002:a2e:9bc2:0:b0:25d:53a9:65e1 with SMTP id
 w2-20020a2e9bc2000000b0025d53a965e1mr1063915ljj.158.1658486618101; Fri, 22
 Jul 2022 03:43:38 -0700 (PDT)
MIME-Version: 1.0
References: <1658312958-13-1-git-send-email-lizhijian@fujitsu.com>
 <CAJpMwyier2gtHoMhkrFeNXmqjUo9ab2Ba4Ef_YZoCwv__9cz=Q@mail.gmail.com> <318d02a4-8028-551c-5cda-e7934153e03d@gmail.com>
In-Reply-To: <318d02a4-8028-551c-5cda-e7934153e03d@gmail.com>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Fri, 22 Jul 2022 12:43:27 +0200
Message-ID: <CAJpMwygwvi=CfJmtgienyfPJ=QgiM6dShGuQB4es7qRtSjuKaQ@mail.gmail.com>
Subject: Re: [RESEND RFC PATCH for-next] Revert "RDMA/rxe: Create duplicate
 mapping tables for FMRs"
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Li Zhijian <lizhijian@fujitsu.com>,
        Yanjun Zhu <yanjun.zhu@linux.dev>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        Leon Romanovsky <leon@kernel.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 22, 2022 at 12:19 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> On 7/20/22 05:50, Haris Iqbal wrote:
> > On Wed, Jul 20, 2022 at 12:22 PM Li Zhijian <lizhijian@fujitsu.com> wrote:
> >>
> >> Below 2 commits will be reverted:
> >>      8ff5f5d9d8cf ("RDMA/rxe: Prevent double freeing rxe_map_set()")
> >>      647bf13ce944 ("RDMA/rxe: Create duplicate mapping tables for FMRs")
> >>
> >> The community has a few bug reports which pointed this commit at last.
> >> Some proposals are raised up in the meantime but all of them have no
> >> follow-up operation.
> >>
> >> The previous commit led the map_set of FMR to be not avaliable any more if
> >> the MR is registered again after invalidating. Although the mentioned
> >> patch try to fix a potential race in building/accessing the same table
> >> for fast memory regions, it broke rnbd etc ULPs. Since the latter could
> >> be worse, revert this patch.
> >>
> >> With previous commit, it's observed that a same MR in rnbd server will
> >> trigger below code path:
> >
> > Looks Good. I tested the patch against rdma for-next and it solves the
> > problem mentioned in the commit.
> > One small nitpick. It should be rtrs, and not rnbd in the commit message.
> >
> > Feel free to add my,
> >
> > Tested-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> >
> >>  -> rxe_mr_init_fast()
> >>  |-> alloc map_set() # map_set is uninitialized
> >>  |...-> rxe_map_mr_sg() # build the map_set
> >>      |-> rxe_mr_set_page()
> >>  |...-> rxe_reg_fast_mr() # mr->state change to VALID from FREE that means
> >>                           # we can access host memory(such rxe_mr_copy)
> >>  |...-> rxe_invalidate_mr() # mr->state change to FREE from VALID
> >>  |...-> rxe_reg_fast_mr() # mr->state change to VALID from FREE,
> >>                           # but map_set was not built again
> >>  |...-> rxe_mr_copy() # kernel crash due to access wild addresses
> >>                       # that lookup from the map_set
> >>
>
> Where is the use case for this? All the FMR examples I am aware of call rxe_map_mr_sg()
> between each reg_fast_mr/invalidate_mr() sequence. I am not familiar with rtrs.
> What is it?

From drivers/infiniband/ulp/rtrs/README

RTRS (RDMA Transport) is a reliable high speed transport library which
provides support to establish optimal number of connections between
client and server machines using RDMA

IMHO, in addition to finding a use case for this, another question
would be, whether putting this restriction of "rxe_map_mr_sg" needed
for every reg_fast_mr/invalidate_mr() cycle makes sense in terms of
spec and/or mlx drivers.

>
> Bob
