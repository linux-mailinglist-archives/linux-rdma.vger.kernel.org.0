Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C595A5ECD
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Aug 2022 11:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiH3JAk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Aug 2022 05:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiH3JAk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Aug 2022 05:00:40 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C57A696C3
        for <linux-rdma@vger.kernel.org>; Tue, 30 Aug 2022 02:00:36 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id h5so9165448ejb.3
        for <linux-rdma@vger.kernel.org>; Tue, 30 Aug 2022 02:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=xITJcMt1vcYpf3rC6UBP5nkxEeouZYcbK1zcpXpBYdE=;
        b=WdUlX7qMNx7+FIxflADiZ0J45qjmk+HGes2SwhKHNqyLPDjalu6/UqynNEDPRSUB4e
         I1kAqHZADA+Jfk+KkQ0QEFdVksCMVAY21intcyMNZUPR786PPsUg2OlytlSWAU502qkZ
         le+tqHteeFYbAqRubaQKCXqAON3a9s4OjF0F/+thiOV/CahJjQwLu59GawP/SDWHmdrU
         E8dzcy9dDTCS3QBDbZu6cOsGYg7KjgCyYZOntV5KQlAeuMhn7bbMDEOgna3xuD+JUDsl
         CuyWV1x6rAvCSgcR1EhDsbQdpEg4u9PYiKOSm7Wetc5OKAWP65dgRvX0d3eLoHmuSxaa
         ynwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=xITJcMt1vcYpf3rC6UBP5nkxEeouZYcbK1zcpXpBYdE=;
        b=o6S2JM5GsuaUIKvaoFjjSgcD5b7d/Ki24mvChf4KxE5LA13ypws6UNStvUyFznoFsJ
         7DsC6lKDrQR0b+gZnn+2d0XsjW3cfbYyMguohIHpvaa2cjCFqcs9VuNTBbjjhDH6wStm
         b+Sl9VpG4vnWBdwzMpbubySZSYaXyoOptUtyGzPmCYpPx9yrCsIPrGRsJnBsEfV+gv9h
         s7GLZDYs6Qdlank2N1+vdJmdMj/TlZSdYa73cQUvXTUugi3+3pgAq9gx8BgalykGzYKh
         TbnjCizMEUXG8d4VKXWOQBW6zVO7wJctedwyKfAlxGdNQhfRT3sC3MSuqO73Sj2JYWQh
         iPVA==
X-Gm-Message-State: ACgBeo2LZXXG2ozEfVEGSMx6mD0UCqyfXJ9i2IWH4OXzlhCcoXviXFPC
        gtgGSIXt0XXSTxVJTsr7dtaXOMh972ypYEhghkNdEg==
X-Google-Smtp-Source: AA6agR6w6En+uzkwVuRB66DKoqwoahNeVhR9UHCXF5/sRdsboCuccAAQLFjF1Fd5sMeb5Z2iWozvU0CbR4IQ7frsYyU=
X-Received: by 2002:a17:906:6a26:b0:741:6fe2:9e02 with SMTP id
 qw38-20020a1709066a2600b007416fe29e02mr1251154ejc.204.1661850035299; Tue, 30
 Aug 2022 02:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220826081117.21687-1-guoqing.jiang@linux.dev>
 <YwxuYrJJRBDxsJ8X@unreal> <d969d7bf-d2a3-05aa-26e5-41628f74b8ab@linux.dev>
 <CAMGffE=-Dsr=s1X=00+y1UcOhHC=FJ-9guQAWTDoHLTRBQ7Qaw@mail.gmail.com> <Yw3N0ALRz5xcBunA@unreal>
In-Reply-To: <Yw3N0ALRz5xcBunA@unreal>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Tue, 30 Aug 2022 11:00:24 +0200
Message-ID: <CAMGffE=FKiah3Wk4nbdB7rQy39tz6mREv7qzsRrFXgS211eDig@mail.gmail.com>
Subject: Re: [PATCH] rnbd-srv: remove 'dir' argument from rnbd_srv_rdma_ev
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Guoqing Jiang <guoqing.jiang@linux.dev>, haris.iqbal@ionos.com,
        axboe@kernel.dk, jgg@ziepe.ca, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 30, 2022 at 10:44 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Mon, Aug 29, 2022 at 03:43:43PM +0200, Jinpu Wang wrote:
> > On Mon, Aug 29, 2022 at 3:33 PM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
> > >
> > >
> > >
> > > On 8/29/22 3:44 PM, Leon Romanovsky wrote:
> > > > On Fri, Aug 26, 2022 at 04:11:17PM +0800, Guoqing Jiang wrote:
> > > >> Since all callers (process_{read,write}) set id->dir, no need to
> > > >> pass 'dir' again.
> > > >>
> > > >> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> > > >> ---
> > > >>   drivers/block/rnbd/rnbd-srv.c          | 9 ++++-----
> > > >>   drivers/block/rnbd/rnbd-srv.h          | 1 +
> > > >>   drivers/infiniband/ulp/rtrs/rtrs-srv.c | 4 ++--
> > > >>   drivers/infiniband/ulp/rtrs/rtrs.h     | 3 +--
> > > >>   4 files changed, 8 insertions(+), 9 deletions(-)
> > >
> > > > I applied the patch and cleanup of rtrs-srv.h can be done later.
> > >
> > > Thanks! I suppose below
> > >
> > > > So decouple it from rtrs-srv.h and hide everything that not-needed to be
> > > > exported to separate header file.
> > >
> > > means move 'struct rtrs_srv_op' to rtrs.h, which seems not appropriate to me
> > > because both client and server include the header. Pls correct me if I
> > > am wrong.
> > >
> > > Since process_{read,write} prints direction info if ctx->ops.rdma_ev
> > > fails, how
> > > about remove the 'dir' info from rnbd_srv_rdma_ev? Then we  don't need to
> > > include rtrs-srv.h.
> > >
> > > diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
> > > index 431c6da19d3f..d07ff3ba560c 100644
> > > --- a/drivers/block/rnbd/rnbd-srv.c
> > > +++ b/drivers/block/rnbd/rnbd-srv.c
> > > @@ -387,8 +387,8 @@ static int rnbd_srv_rdma_ev(void *priv, struct
> > > rtrs_srv_op *id,
> > >                                              datalen);
> > >                  break;
> > >          default:
> > > -               pr_warn("Received unexpected message type %d with dir %d
> > > from session %s\n",
> > > -                       type, id->dir, srv_sess->sessname);
> > > +               pr_warn("Received unexpected message type %d from
> > > session %s\n",
> > > +                       type, srv_sess->sessname);
> > >                  return -EINVAL;
> > >          }
> > >
> > > diff --git a/drivers/block/rnbd/rnbd-srv.h b/drivers/block/rnbd/rnbd-srv.h
> > > index 5a0ef6c2b5c7..081bceaf4ae9 100644
> > > --- a/drivers/block/rnbd/rnbd-srv.h
> > > +++ b/drivers/block/rnbd/rnbd-srv.h
> > > @@ -14,7 +14,6 @@
> > >   #include <linux/kref.h>
> > >
> > >   #include <rtrs.h>
> > > -#include <rtrs-srv.h>
> > >   #include "rnbd-proto.h"
> > >   #include "rnbd-log.h"
> > >
> > >
> > > Thoughts?
> > I like the idea. Please post a formal patch based on leon's
> > https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/log/?h=wip/leon-for-next
>
> I squashed this hunk into original patch.
>
Hi Leon,

Thank you!
> Thanks
>
> >
> > Thx!
> > >
> > > Thanks,
> > > Guoqing
