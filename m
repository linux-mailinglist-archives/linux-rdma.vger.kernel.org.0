Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD83A62D30A
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Nov 2022 06:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239145AbiKQF5T (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Nov 2022 00:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239272AbiKQF46 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Nov 2022 00:56:58 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E55E6711C
        for <linux-rdma@vger.kernel.org>; Wed, 16 Nov 2022 21:56:56 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id d20so1343775ljc.12
        for <linux-rdma@vger.kernel.org>; Wed, 16 Nov 2022 21:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c362285bPRcadxp3LJ7gYhX5D2pd5v4sdbwP+Y6bigM=;
        b=E6czSGtstLaomewSI8vaWwZzLpZ3ncj3f4wgeSE3h7E5w+Os46CJLhMRWVOe48z7fA
         aXWOIu26i7wLJdVbQokAbT3CB774sdYxdSLKxzARgg5C12mSwSQ723yxZIk77eME911z
         QksPUy/SfpumlNxZ2V3uybIrrI6zgcBdDqs2wfJnqU8ZeRUZPW8r4w48hKZ0Lou2EfEs
         nYhngHa+TG4HzHCEJ/+iVrtMOnmRo4DevslL+HClrMwD3qGYl+/LTnkJ+aUEzbtYfHCy
         7w+e0qQPlgwaXJVpbr35bLULxnYVZ4u9igjIR/UiRx20aftvUV4d7wu9DtzTbegjfWOh
         Edmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c362285bPRcadxp3LJ7gYhX5D2pd5v4sdbwP+Y6bigM=;
        b=vMByghzZYMGxqSsvgEOkSyMssxwpx+5qlZStaV2Ba/DNpZny4V7eNL+Y8AS59cwTk/
         2byD0VAC2YIZiPUSxGKdM1YwmMEiwwOW1r4jqIAoMA/sfl80KMbDMC9azLVrWzCbIWag
         +Vlb3iJ3SgWu2iVhvc+qhGj+bfs4XiYrbHKhdQeFxzYBSrqMFcRsZgU4Dv3J9k2F+RYy
         vmEnzL7MjC5vSamXhwQlgBKLNER3nrNxzEQYLTS9HGMqv28pn57HhBob+Oadv0m0YAWy
         b29/kls2HQHO7Oy0jpBa88cHQU5bDC63ZynjcOg0TNBZzVXqN/hp0Exu86vLtYJXuKJ1
         kdLw==
X-Gm-Message-State: ANoB5pkEwvlLgX9aOtaH2kjq4YtMmqZvUv9BfP/J3U9yMiIRqhk5dPon
        t5PKKspe00YtzYgA3VKFkB/esz2swY1Kg4SepDQNPiq2MXQ=
X-Google-Smtp-Source: AA0mqf6tUocb/aqROtSfnE8cFV+CNlA0ZTZEjzQ1tkYVGp2v7wpag+9HYtw17T3jj4/Yq13nQxw8qjNJTKeLVv/6oI8=
X-Received: by 2002:a05:651c:2002:b0:278:a1bc:ad26 with SMTP id
 s2-20020a05651c200200b00278a1bcad26mr500142ljo.235.1668664614582; Wed, 16 Nov
 2022 21:56:54 -0800 (PST)
MIME-Version: 1.0
References: <20221116111400.7203-1-guoqing.jiang@linux.dev> <20221116111400.7203-5-guoqing.jiang@linux.dev>
In-Reply-To: <20221116111400.7203-5-guoqing.jiang@linux.dev>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Thu, 17 Nov 2022 06:56:43 +0100
Message-ID: <CAMGffEkjbyPunNiq3V4CQT5nULzm7VPnMFXO-U=0pURrrDqOzQ@mail.gmail.com>
Subject: Re: [PATCH 4/8] RDMA/rtrs-clt: Correct the checking of ib_map_mr_sg
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
> We should check with count, also the only successful case is that
> all sg elements are mapped, so make it explict.
s/explicit/explicitly
>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> index 8546b8816524..be7c8480f947 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> @@ -1064,10 +1064,8 @@ static int rtrs_map_sg_fr(struct rtrs_clt_io_req *req, size_t count)
>
>         /* Align the MR to a 4K page size to match the block virt boundary */
>         nr = ib_map_mr_sg(req->mr, req->sglist, count, NULL, SZ_4K);
> -       if (nr < 0)
> -               return nr;
> -       if (nr < req->sg_cnt)
> -               return -EINVAL;
> +       if (nr != count)
> +               return nr < 0 ? nr : -EINVAL;
>         ib_update_fast_reg_key(req->mr, ib_inc_rkey(req->mr->rkey));
>
>         return nr;
> --
> 2.31.1
>
