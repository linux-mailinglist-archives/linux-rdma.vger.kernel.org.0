Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298425A4E68
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Aug 2022 15:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiH2NoA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Aug 2022 09:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiH2NoA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Aug 2022 09:44:00 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BE08FD50
        for <linux-rdma@vger.kernel.org>; Mon, 29 Aug 2022 06:43:55 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id se27so8055305ejb.8
        for <linux-rdma@vger.kernel.org>; Mon, 29 Aug 2022 06:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=JmNnBz360ICvTuyulOMiVni7Ij1DUnsSDNhiIpTqsUk=;
        b=DyUunINlMdxMn0kC/W7hZ6zP4jALP3cPh9EsH4wd7tKiuIi2qkNeo1AtvFOrpJ0CFh
         UpiW3x0ixWkxdgOGdlhfKcnc6zyz2wjyBx3aEP1Q+7b5wSBmUYBfjWxEEH/4acJmYMAT
         TatPODd37Hgh+myZ/Lzx61yBiuFD8FMqvLwX0RogwjUUqv+MvcNGqwnPjAvqIKirCe/K
         9SFE6VhMiUVEjgoWTT3nkokLlJaH/ii0Q0HgPhMM4yqXq6cB/Doj7yCqVXOPv98vMsG2
         2hhlA40yadCNqN8BS0/vMOFJsZWcY96IqMK3zwRqnsgbDCmhEd+KyLtwWa3OYXQPAOut
         iH8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=JmNnBz360ICvTuyulOMiVni7Ij1DUnsSDNhiIpTqsUk=;
        b=eBszjrXGxe+iGJ5QYD/c/wrdAYaq7fcFezycENKs7UZqGhXLOfURlsHqZkTRMO4YxZ
         hpPU22IYbXcUSEPFap5oVzdGGrNjAa1ZtaVMNA9XxYIfGH5fb/4OVi2QyJHuct6M68bx
         COjhuE/gFh+zb/xEtgHuK6IiITq0YFlqcSfMAn6lrOZNlGFsRHTsAbe8nztznMNCCarP
         87pGgv0Cd/JSYvsjKgkI1bvBvKYfYATD6dcR+ya/DoMA718ifPCuWpzW/fTsj48ifbRl
         0QMZe8lFmL0hclgNy0+j8RuhUbQK+PHW0inXHobBOxgnQs75QJ3sPwg1BZGuYRVl2jI0
         SncQ==
X-Gm-Message-State: ACgBeo0+/SrH81eDLW8soPWxTjszyxwbsF+xj5wfcNAgsyhV50q/xscs
        VzHuaUmXDO2ZwZeq71YeWnFb1jA2sRszDPDPpwVwBAgXlFVNmA==
X-Google-Smtp-Source: AA6agR7jlcTamH+MHq78d+5WPrpSBkAb7eWVJpdJLUSu9XwRcRz08BW3sLQAY4ezkiMjwVZFPyWDOdxBLbdsJQAT6tI=
X-Received: by 2002:a17:907:75ec:b0:741:484b:3ca4 with SMTP id
 jz12-20020a17090775ec00b00741484b3ca4mr7341238ejc.316.1661780634320; Mon, 29
 Aug 2022 06:43:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220826081117.21687-1-guoqing.jiang@linux.dev>
 <YwxuYrJJRBDxsJ8X@unreal> <d969d7bf-d2a3-05aa-26e5-41628f74b8ab@linux.dev>
In-Reply-To: <d969d7bf-d2a3-05aa-26e5-41628f74b8ab@linux.dev>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Mon, 29 Aug 2022 15:43:43 +0200
Message-ID: <CAMGffE=-Dsr=s1X=00+y1UcOhHC=FJ-9guQAWTDoHLTRBQ7Qaw@mail.gmail.com>
Subject: Re: [PATCH] rnbd-srv: remove 'dir' argument from rnbd_srv_rdma_ev
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     Leon Romanovsky <leon@kernel.org>, haris.iqbal@ionos.com,
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

On Mon, Aug 29, 2022 at 3:33 PM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>
>
>
> On 8/29/22 3:44 PM, Leon Romanovsky wrote:
> > On Fri, Aug 26, 2022 at 04:11:17PM +0800, Guoqing Jiang wrote:
> >> Since all callers (process_{read,write}) set id->dir, no need to
> >> pass 'dir' again.
> >>
> >> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> >> ---
> >>   drivers/block/rnbd/rnbd-srv.c          | 9 ++++-----
> >>   drivers/block/rnbd/rnbd-srv.h          | 1 +
> >>   drivers/infiniband/ulp/rtrs/rtrs-srv.c | 4 ++--
> >>   drivers/infiniband/ulp/rtrs/rtrs.h     | 3 +--
> >>   4 files changed, 8 insertions(+), 9 deletions(-)
>
> > I applied the patch and cleanup of rtrs-srv.h can be done later.
>
> Thanks! I suppose below
>
> > So decouple it from rtrs-srv.h and hide everything that not-needed to be
> > exported to separate header file.
>
> means move 'struct rtrs_srv_op' to rtrs.h, which seems not appropriate to me
> because both client and server include the header. Pls correct me if I
> am wrong.
>
> Since process_{read,write} prints direction info if ctx->ops.rdma_ev
> fails, how
> about remove the 'dir' info from rnbd_srv_rdma_ev? Then we  don't need to
> include rtrs-srv.h.
>
> diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
> index 431c6da19d3f..d07ff3ba560c 100644
> --- a/drivers/block/rnbd/rnbd-srv.c
> +++ b/drivers/block/rnbd/rnbd-srv.c
> @@ -387,8 +387,8 @@ static int rnbd_srv_rdma_ev(void *priv, struct
> rtrs_srv_op *id,
>                                              datalen);
>                  break;
>          default:
> -               pr_warn("Received unexpected message type %d with dir %d
> from session %s\n",
> -                       type, id->dir, srv_sess->sessname);
> +               pr_warn("Received unexpected message type %d from
> session %s\n",
> +                       type, srv_sess->sessname);
>                  return -EINVAL;
>          }
>
> diff --git a/drivers/block/rnbd/rnbd-srv.h b/drivers/block/rnbd/rnbd-srv.h
> index 5a0ef6c2b5c7..081bceaf4ae9 100644
> --- a/drivers/block/rnbd/rnbd-srv.h
> +++ b/drivers/block/rnbd/rnbd-srv.h
> @@ -14,7 +14,6 @@
>   #include <linux/kref.h>
>
>   #include <rtrs.h>
> -#include <rtrs-srv.h>
>   #include "rnbd-proto.h"
>   #include "rnbd-log.h"
>
>
> Thoughts?
I like the idea. Please post a formal patch based on leon's
https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/log/?h=wip/leon-for-next

Thx!
>
> Thanks,
> Guoqing
