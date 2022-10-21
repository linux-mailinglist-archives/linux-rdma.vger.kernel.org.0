Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC216079C6
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Oct 2022 16:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiJUOjp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Oct 2022 10:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiJUOjn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Oct 2022 10:39:43 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005E22BE39;
        Fri, 21 Oct 2022 07:39:40 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id u71so2735198pgd.2;
        Fri, 21 Oct 2022 07:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TJdjjbqfS8qsW7u7aXCQ7xu5aumb/vvCAg+jRbJnw1A=;
        b=k1LKv/J+inGUxNTo3pmIpTgDnKzT1DkFBnYnQvoXrW209pFh45Mxp4rdR0vIfqJ3ax
         2kGysuVL7UpEw+iquD3fXRoFU9YZeV1hB5P9b+G9kxZ0ShLcjwIrIIEUf4Ml7LVOXAag
         hBQOMzgKbr0hhal74dgkSAIjRD+zWlTdaLjohvd4tylOKQwqzYpyBmft6TZJsHhAvoNZ
         i7wmHGQajrqBiOCP1JkWKlX96OCJTLVOtufXVs+OaEKNJmAhozN0dilrxf0Vdjr1QPgF
         rITe8AQTikRnF/V5Nv6liPp4u9RvFPu+R0W5J5hbNlfRZD7dx3LDkdPMR0O7YS0IRuro
         jj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TJdjjbqfS8qsW7u7aXCQ7xu5aumb/vvCAg+jRbJnw1A=;
        b=bhHwbUU39+YzY8NRsyyGUQ++up5eQmP8tzTRPcOPfP5ap5ybaPykCdG9nnMSa+mODz
         ioM6p+yBT8q8MoUjIaCaVfZ6vJzo9eR9ESguASQTPdtWx701s4QKWaE2bMMxx+Jj3bQU
         6SnkwSjRNKenuCvI3Th+N6QoeWiWZAqDv87udQF5tDOXu7soS2PJNK2dPhTTAFpXlpRO
         SAKBcHyWpdd9FdlahLqIAMOOJuQSznVAJbyonJ3sIGZiF21BmnygiVrs5CXoWw1TZxzD
         nbHh6h0j1uplIQnG7o7QeXgGQug7JuEpVZuh36yd3kMyFfS8al1sS0Sewz+O5/2/3vw/
         fE/A==
X-Gm-Message-State: ACrzQf1tfA3acIx4ZA7kC3jZgkJkghlvCqWu4nU7y1TW7q0cdZRlX4Ho
        Q3RhgH7yJ/ouOFgt11BurFiBsUA1Ik8WvWKWy3C1lI6f
X-Google-Smtp-Source: AMsMyM7tObOYfZahTQY3BIieWt9mGyiWEmJTfrRFchwsUV2XkP1MTUOeaCq8pFbeA7jLoaG0BLq4YvNtxOcTCuFPg0c=
X-Received: by 2002:a05:6a00:847:b0:563:b593:b685 with SMTP id
 q7-20020a056a00084700b00563b593b685mr19422593pfk.75.1666363179950; Fri, 21
 Oct 2022 07:39:39 -0700 (PDT)
MIME-Version: 1.0
References: <1666338764-2-1-git-send-email-lizhijian@fujitsu.com> <1666338764-2-2-git-send-email-lizhijian@fujitsu.com>
In-Reply-To: <1666338764-2-2-git-send-email-lizhijian@fujitsu.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Fri, 21 Oct 2022 22:39:28 +0800
Message-ID: <CAD=hENeGMKri0nYMtcu98K2j3D+ZBkxO6fFX5cvvyJsEghrrmQ@mail.gmail.com>
Subject: Re: [for-next PATCH v2 1/2] RDMA/rxe: Remove unnecessary mr testing
To:     Li Zhijian <lizhijian@fujitsu.com>
Cc:     jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 21, 2022 at 3:53 PM Li Zhijian <lizhijian@fujitsu.com> wrote:
>
> Before the testing, we already passed it to rxe_mr_copy() where mr could
> be dereferenced. so this checking is not exactly correct.
>
> I tried to figure out the details how/when mr could be NULL, but failed
> at last. Add a WARN_ON(!mr) to that path to tell us more when it
> happends.

If I get you correctly, you confronted a problem, but you can not figure it out.
So you send it upstream as a patch?

I am not sure if it is a good idea.

Zhu Yanjun

>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_resp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> index ed5a09e86417..218c14fb07c6 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -778,6 +778,7 @@ static enum resp_states read_reply(struct rxe_qp *qp,
>         if (res->state == rdatm_res_state_new) {
>                 if (!res->replay) {
>                         mr = qp->resp.mr;
> +                       WARN_ON(!mr);
>                         qp->resp.mr = NULL;
>                 } else {
>                         mr = rxe_recheck_mr(qp, res->read.rkey);
> @@ -811,8 +812,7 @@ static enum resp_states read_reply(struct rxe_qp *qp,
>
>         rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
>                     payload, RXE_FROM_MR_OBJ);
> -       if (mr)
> -               rxe_put(mr);
> +       rxe_put(mr);
>
>         if (bth_pad(&ack_pkt)) {
>                 u8 *pad = payload_addr(&ack_pkt) + payload;
> --
> 2.31.1
>
