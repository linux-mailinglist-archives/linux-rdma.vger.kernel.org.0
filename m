Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC845A5F03
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Aug 2022 11:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbiH3JPi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Aug 2022 05:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbiH3JPf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Aug 2022 05:15:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859A885FCC;
        Tue, 30 Aug 2022 02:15:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25830615AF;
        Tue, 30 Aug 2022 09:15:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F722C433D6;
        Tue, 30 Aug 2022 09:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661850927;
        bh=0rCKjtciXq7v8NAdMwNUpKFAV7bH3z1yw3HXxLkc038=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PVwwsNBnBm640JzQk8Kab8hp1F4C9Z1erAgsv+pQtJDmEwkQ/n2H8lUHuab+GG3za
         Xm3T9C3Ah/nNWto6gp7d8ItrKTD3tMYqWJTNlJokLbAoWKvkexy3VnKeeAnrIsJJIL
         POm/Wgt76E2Ax2bhpgspJLSmIqT2TZZvB6uhe7v1No+8HB59qCwXJwVZlUXysHEknK
         eVWGeLn7YEgtbb59HvlWXHEhs3XktHVCkK8ncWQCGQIIkuzkpzW3xF2dErTRadD4tC
         xzTBascDHFc1o1gBUFwiVW7ZzxbTKA+NaGMULsztASGIJiJRfizKg/GAeeC0zR7cx6
         H22/5Z2y3Kqzw==
Date:   Tue, 30 Aug 2022 12:15:23 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     Jinpu Wang <jinpu.wang@ionos.com>, haris.iqbal@ionos.com,
        axboe@kernel.dk, jgg@ziepe.ca, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH] rnbd-srv: remove 'dir' argument from rnbd_srv_rdma_ev
Message-ID: <Yw3VK/qbixMW7U6z@unreal>
References: <20220826081117.21687-1-guoqing.jiang@linux.dev>
 <YwxuYrJJRBDxsJ8X@unreal>
 <d969d7bf-d2a3-05aa-26e5-41628f74b8ab@linux.dev>
 <CAMGffE=-Dsr=s1X=00+y1UcOhHC=FJ-9guQAWTDoHLTRBQ7Qaw@mail.gmail.com>
 <Yw3N0ALRz5xcBunA@unreal>
 <a8774cb1-fa99-33cd-f681-527de1e079be@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8774cb1-fa99-33cd-f681-527de1e079be@linux.dev>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 30, 2022 at 04:57:19PM +0800, Guoqing Jiang wrote:
> 
> 
> On 8/30/22 4:44 PM, Leon Romanovsky wrote:
> > On Mon, Aug 29, 2022 at 03:43:43PM +0200, Jinpu Wang wrote:
> > > On Mon, Aug 29, 2022 at 3:33 PM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
> > > > 
> > > > 
> > > > On 8/29/22 3:44 PM, Leon Romanovsky wrote:
> > > > > On Fri, Aug 26, 2022 at 04:11:17PM +0800, Guoqing Jiang wrote:
> > > > > > Since all callers (process_{read,write}) set id->dir, no need to
> > > > > > pass 'dir' again.
> > > > > > 
> > > > > > Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> > > > > > ---
> > > > > >    drivers/block/rnbd/rnbd-srv.c          | 9 ++++-----
> > > > > >    drivers/block/rnbd/rnbd-srv.h          | 1 +
> > > > > >    drivers/infiniband/ulp/rtrs/rtrs-srv.c | 4 ++--
> > > > > >    drivers/infiniband/ulp/rtrs/rtrs.h     | 3 +--
> > > > > >    4 files changed, 8 insertions(+), 9 deletions(-)
> > > > > I applied the patch and cleanup of rtrs-srv.h can be done later.
> > > > Thanks! I suppose below
> > > > 
> > > > > So decouple it from rtrs-srv.h and hide everything that not-needed to be
> > > > > exported to separate header file.
> > > > means move 'struct rtrs_srv_op' to rtrs.h, which seems not appropriate to me
> > > > because both client and server include the header. Pls correct me if I
> > > > am wrong.
> > > > 
> > > > Since process_{read,write} prints direction info if ctx->ops.rdma_ev
> > > > fails, how
> > > > about remove the 'dir' info from rnbd_srv_rdma_ev? Then we  don't need to
> > > > include rtrs-srv.h.
> > > > 
> > > > diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
> > > > index 431c6da19d3f..d07ff3ba560c 100644
> > > > --- a/drivers/block/rnbd/rnbd-srv.c
> > > > +++ b/drivers/block/rnbd/rnbd-srv.c
> > > > @@ -387,8 +387,8 @@ static int rnbd_srv_rdma_ev(void *priv, struct
> > > > rtrs_srv_op *id,
> > > >                                               datalen);
> > > >                   break;
> > > >           default:
> > > > -               pr_warn("Received unexpected message type %d with dir %d
> > > > from session %s\n",
> > > > -                       type, id->dir, srv_sess->sessname);
> > > > +               pr_warn("Received unexpected message type %d from
> > > > session %s\n",
> > > > +                       type, srv_sess->sessname);
> > > >                   return -EINVAL;
> > > >           }
> > > > 
> > > > diff --git a/drivers/block/rnbd/rnbd-srv.h b/drivers/block/rnbd/rnbd-srv.h
> > > > index 5a0ef6c2b5c7..081bceaf4ae9 100644
> > > > --- a/drivers/block/rnbd/rnbd-srv.h
> > > > +++ b/drivers/block/rnbd/rnbd-srv.h
> > > > @@ -14,7 +14,6 @@
> > > >    #include <linux/kref.h>
> > > > 
> > > >    #include <rtrs.h>
> > > > -#include <rtrs-srv.h>
> > > >    #include "rnbd-proto.h"
> > > >    #include "rnbd-log.h"
> > > > 
> > > > 
> > > > Thoughts?
> > > I like the idea. Please post a formal patch based on leon's
> > > https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/log/?h=wip/leon-for-next
> > I squashed this hunk into original patch.
> 
> Great, thank you!
> 
> If possible, to better reflect the change, please at your convenience to
> replace the original commit
> message with below.
> 
> "Since process_{read,write} already prints direction info if
> ctx->ops.rdma_ev fails, no need to pass 'dir'"

Done, as long as patches are in wip/* branches, we can rebase them.

Thanks

> 
> Thanks,
> Guoqing
