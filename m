Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5455E5A5E6B
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Aug 2022 10:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbiH3IoP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Aug 2022 04:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiH3IoM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Aug 2022 04:44:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA02D570B;
        Tue, 30 Aug 2022 01:44:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F63DB81719;
        Tue, 30 Aug 2022 08:44:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E043C433D7;
        Tue, 30 Aug 2022 08:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661849045;
        bh=McKf9DyPkoGQXJk/Ngof0SvY2mYNrGNiV88jiyHxYnQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nEoUccTX7JXKDCCQlBN1iymQIDamhyGX/BcGGVw6DXyDs3aHX5AoeGfj5a28WBWWw
         +1bx0qq7JTYKj+woKQsW/tg61tDItd7HlNy9fnU9SK7hu0Zb6+lfBoJy7kPaD6r3Cj
         bP19wNbv2pOLuUJXmHj8ojTXmaHaBRSulPHVA3BpfHZf/+/ZTSpNT1EQafigI2Bzro
         FovSj1Nb5X+MBTY8er6WaZumMmivgyQfgRsT2XCVi0hQscRVXYIWlMfdMp5ks9o0O3
         utcFLXFFdnXfafQ3k4Qt4LYotbcud1JVH/zLHgcePvbZfZsIsJEOvLIfBBb0l5X7wB
         6/hBBctKdO4aA==
Date:   Tue, 30 Aug 2022 11:44:00 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jinpu Wang <jinpu.wang@ionos.com>
Cc:     Guoqing Jiang <guoqing.jiang@linux.dev>, haris.iqbal@ionos.com,
        axboe@kernel.dk, jgg@ziepe.ca, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH] rnbd-srv: remove 'dir' argument from rnbd_srv_rdma_ev
Message-ID: <Yw3N0ALRz5xcBunA@unreal>
References: <20220826081117.21687-1-guoqing.jiang@linux.dev>
 <YwxuYrJJRBDxsJ8X@unreal>
 <d969d7bf-d2a3-05aa-26e5-41628f74b8ab@linux.dev>
 <CAMGffE=-Dsr=s1X=00+y1UcOhHC=FJ-9guQAWTDoHLTRBQ7Qaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffE=-Dsr=s1X=00+y1UcOhHC=FJ-9guQAWTDoHLTRBQ7Qaw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 29, 2022 at 03:43:43PM +0200, Jinpu Wang wrote:
> On Mon, Aug 29, 2022 at 3:33 PM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
> >
> >
> >
> > On 8/29/22 3:44 PM, Leon Romanovsky wrote:
> > > On Fri, Aug 26, 2022 at 04:11:17PM +0800, Guoqing Jiang wrote:
> > >> Since all callers (process_{read,write}) set id->dir, no need to
> > >> pass 'dir' again.
> > >>
> > >> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> > >> ---
> > >>   drivers/block/rnbd/rnbd-srv.c          | 9 ++++-----
> > >>   drivers/block/rnbd/rnbd-srv.h          | 1 +
> > >>   drivers/infiniband/ulp/rtrs/rtrs-srv.c | 4 ++--
> > >>   drivers/infiniband/ulp/rtrs/rtrs.h     | 3 +--
> > >>   4 files changed, 8 insertions(+), 9 deletions(-)
> >
> > > I applied the patch and cleanup of rtrs-srv.h can be done later.
> >
> > Thanks! I suppose below
> >
> > > So decouple it from rtrs-srv.h and hide everything that not-needed to be
> > > exported to separate header file.
> >
> > means move 'struct rtrs_srv_op' to rtrs.h, which seems not appropriate to me
> > because both client and server include the header. Pls correct me if I
> > am wrong.
> >
> > Since process_{read,write} prints direction info if ctx->ops.rdma_ev
> > fails, how
> > about remove the 'dir' info from rnbd_srv_rdma_ev? Then we  don't need to
> > include rtrs-srv.h.
> >
> > diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
> > index 431c6da19d3f..d07ff3ba560c 100644
> > --- a/drivers/block/rnbd/rnbd-srv.c
> > +++ b/drivers/block/rnbd/rnbd-srv.c
> > @@ -387,8 +387,8 @@ static int rnbd_srv_rdma_ev(void *priv, struct
> > rtrs_srv_op *id,
> >                                              datalen);
> >                  break;
> >          default:
> > -               pr_warn("Received unexpected message type %d with dir %d
> > from session %s\n",
> > -                       type, id->dir, srv_sess->sessname);
> > +               pr_warn("Received unexpected message type %d from
> > session %s\n",
> > +                       type, srv_sess->sessname);
> >                  return -EINVAL;
> >          }
> >
> > diff --git a/drivers/block/rnbd/rnbd-srv.h b/drivers/block/rnbd/rnbd-srv.h
> > index 5a0ef6c2b5c7..081bceaf4ae9 100644
> > --- a/drivers/block/rnbd/rnbd-srv.h
> > +++ b/drivers/block/rnbd/rnbd-srv.h
> > @@ -14,7 +14,6 @@
> >   #include <linux/kref.h>
> >
> >   #include <rtrs.h>
> > -#include <rtrs-srv.h>
> >   #include "rnbd-proto.h"
> >   #include "rnbd-log.h"
> >
> >
> > Thoughts?
> I like the idea. Please post a formal patch based on leon's
> https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/log/?h=wip/leon-for-next

I squashed this hunk into original patch.

Thanks

> 
> Thx!
> >
> > Thanks,
> > Guoqing
