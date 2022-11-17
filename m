Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF7562D303
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Nov 2022 06:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233278AbiKQFwo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Nov 2022 00:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbiKQFwl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Nov 2022 00:52:41 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545A8E2A
        for <linux-rdma@vger.kernel.org>; Wed, 16 Nov 2022 21:52:38 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id a29so1118836lfj.9
        for <linux-rdma@vger.kernel.org>; Wed, 16 Nov 2022 21:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T5sBqUasBU6StzC3o8Q5n4kN1rlev+YbPe+SrsGyl7w=;
        b=XV5uTwaJilAR6CvXEUZRIdwufeLSgv+Nl5OZNRF3N9CBURdujnxWzCo2tmKSTP/Jm1
         2QLQd/1J8UBx+ttqjQ4KEfb/2rLDpGZsFKxWN50hMsdo8HUpK1m561xnnWpk9sBDbhq3
         Vnj2wCHdGIyp0sJGcJr/1ZD7feUxxzXz99joLF+XWaTCIagfoyrVtNCLpYfrfvge5cbn
         XYrQyy4FjeEXOacPFgDY14ZfKpHVzS+xr4Tdam4k7/LNSJt9+OPtivCyTXGKoyM5HvtV
         lHuC2INgz5Wv8FHMuXscRiH4ymj3Ov72T1QZqT/yMdbbl/FyuVDyObxj201eK8cXU2wB
         ZdQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T5sBqUasBU6StzC3o8Q5n4kN1rlev+YbPe+SrsGyl7w=;
        b=P77E6YGP60ewHXxNGfaxpzYso4W2dpocfTDJqhwATb1T7ubJxgyrILfkVdl2TunNtK
         bGVOK8X7uTGCxtBpadWT21TQRJTz8KGlbEI11ato5MEEWeWaUvCMG2XwEkrKhS+X/gFV
         tBsEBLLKDJUb3zSIqXSD720GqscCWRAaS5KIgBlYYfW5e1XiA6io4iEvcXRAy5UJEFEA
         wa0l2yG5C+AorFiu8D8h5lqrtbdE0hxEVKq4kPVAOSRPc5I5kjEJev27KCNBAI7/Rpli
         nkDrupeY4+twx+iBzbmylgLfXvc+TTI+sEHt7hHAweiAnzGjVZdYW52TeS/lJIJeoJ+5
         JzEQ==
X-Gm-Message-State: ANoB5plrAMU36dOydOmchWJq3TyxLOz+MQdisEqAPKnV8NwDLXd/9nb2
        GM0ehyAixg9mVtuG8S+yYxoVab5C9NpR4VONWAQ+yg==
X-Google-Smtp-Source: AA0mqf7NXGTHwAXhiOayN1dUi6bqaezK+ZU2oxFJfLvM8TsVvk+CLVnMOlmdfy7od6bAUlOMiCR9V4+tRRz3BOtmNyo=
X-Received: by 2002:ac2:47e3:0:b0:4b4:1324:6ed3 with SMTP id
 b3-20020ac247e3000000b004b413246ed3mr370063lfp.19.1668664356626; Wed, 16 Nov
 2022 21:52:36 -0800 (PST)
MIME-Version: 1.0
References: <20221116111400.7203-1-guoqing.jiang@linux.dev> <20221116111400.7203-2-guoqing.jiang@linux.dev>
In-Reply-To: <20221116111400.7203-2-guoqing.jiang@linux.dev>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Thu, 17 Nov 2022 06:52:25 +0100
Message-ID: <CAMGffEmnzA6+2H_CbhusfQ0r68jo8j93jVau-qoX7=kJv_UNrA@mail.gmail.com>
Subject: Re: [PATCH 1/8] RDMA/rtrs-srv: Refactor rtrs_srv_rdma_cm_handler
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     haris.iqbal@ionos.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 16, 2022 at 12:14 PM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>
> The RDMA_CM_EVENT_CONNECT_REQUEST is quite different to other types,
> let's checking it separately at the beginning of routine, then we can
> avoid the identation accordingly.
There are two typos.
s/checking/check
s/identation/indentation.

>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> index 22d7ba05e9fe..5fe3699cb8ff 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> @@ -1950,22 +1950,21 @@ static int rtrs_srv_rdma_cm_handler(struct rdma_cm_id *cm_id,
>  {
>         struct rtrs_srv_path *srv_path = NULL;
>         struct rtrs_path *s = NULL;
> +       struct rtrs_con *c = NULL;
>
> -       if (ev->event != RDMA_CM_EVENT_CONNECT_REQUEST) {
> -               struct rtrs_con *c = cm_id->context;
> -
> -               s = c->path;
> -               srv_path = to_srv_path(s);
> -       }
> -
> -       switch (ev->event) {
> -       case RDMA_CM_EVENT_CONNECT_REQUEST:
> +       if (ev->event == RDMA_CM_EVENT_CONNECT_REQUEST)
>                 /*
>                  * In case of error cma.c will destroy cm_id,
>                  * see cma_process_remove()
>                  */
>                 return rtrs_rdma_connect(cm_id, ev->param.conn.private_data,
>                                           ev->param.conn.private_data_len);
> +
> +       c = cm_id->context;
> +       s = c->path;
> +       srv_path = to_srv_path(s);
> +
> +       switch (ev->event) {
>         case RDMA_CM_EVENT_ESTABLISHED:
>                 /* Nothing here */
>                 break;
> --
> 2.31.1
>
The patch LGTM.
Acked-by: Jack Wang <jinpu.wang@ionos.com>
