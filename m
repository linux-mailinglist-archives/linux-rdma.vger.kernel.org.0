Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8656297BA
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Nov 2022 12:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbiKOLtm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Nov 2022 06:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiKOLtl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Nov 2022 06:49:41 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A94B1B
        for <linux-rdma@vger.kernel.org>; Tue, 15 Nov 2022 03:49:40 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id b9so17189073ljr.5
        for <linux-rdma@vger.kernel.org>; Tue, 15 Nov 2022 03:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IQAVM3TnUj3lVCtlxbG9x+1pvOwFY35R9w1F6E0oEI4=;
        b=LCkymLLpMkDvAZz07j+azO+jLb6DTckeN5jw5QGTiOVYrsMzOgwGYqSk8Lv5xhvnUb
         JNimNCQcFa6FclU9ds6z3vTYbsaUkU2k3J3Zu+W1UNLpEsVyvYBUTqa8kcf6IkUqN0EP
         qA6nB86Or7SuQsZfq3ZxtV48XKdjnxESws0PQC0jYP2oNx4XfmSURdqgslSHd/29ynT2
         pCiZJlkgTHo+w9pDj5NJgTHObeJ4zFz0u0oC04g20TCsJZ1MR5UDtDj9PLv7KMVqH2jk
         tL/gGtT6GbnmAYGuKUtPtzotVQlR6YLfQMTn269Mjt2+sVlMqzzBOhPz1vk6R/86s5sA
         OqQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IQAVM3TnUj3lVCtlxbG9x+1pvOwFY35R9w1F6E0oEI4=;
        b=LKR8nO/ejQyHx1u4WXtG0TgiV+j2NZCSWsQd5TZSkg4FH4ASRgIQ4Ddh/c2tMMasuh
         ioC9edWWxXzANw0pqyXROTazg497S0CBn6QA7m6iyekHZydbSFB4k3RrqtgCk4KXY2yb
         iXwA1/qWw1ANMKFoE/bD67k+qOgYWpE3IK+rTAprDm5ClOnY0mMqhIOPdfhKFXoefe71
         L6Fqa7WnfVmUICZuN94bBNuNPIoiOpM157mUpFja1rAYg5IMWd3WjPK5NFm/XIE0B9b3
         0aGRzHII6a0gW7NcNWXaKeXM9XmE6J/s4CoFFKOETls8ORb5daIxQUyAX1uyXM2tOY6N
         0FuA==
X-Gm-Message-State: ANoB5pl+U2Om8ctjwxSvaFG9fh2gtfr3rPIX7yR9Yod7gObrUPF4sHFt
        xNMVo1CX98/oTmC2EqJ6C/cYO2tMs7VgeEWGJunULw==
X-Google-Smtp-Source: AA0mqf5d3C45p3toJnJLIwNP1TTaywBkklEZOaa5O6U+8Jey/zV5YmGV/DUPclRZsCi5AQlXprsbEXgptEf9qDGnXMk=
X-Received: by 2002:a05:651c:8b:b0:26d:d196:d04 with SMTP id
 11-20020a05651c008b00b0026dd1960d04mr5945375ljq.403.1668512979058; Tue, 15
 Nov 2022 03:49:39 -0800 (PST)
MIME-Version: 1.0
References: <20221113010823.6436-1-guoqing.jiang@linux.dev> <20221113010823.6436-7-guoqing.jiang@linux.dev>
In-Reply-To: <20221113010823.6436-7-guoqing.jiang@linux.dev>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Tue, 15 Nov 2022 12:49:28 +0100
Message-ID: <CAMGffEksscRoEJb4pbSubdbQ1JCODwnRSO+hjOA4QArnKrR1bA@mail.gmail.com>
Subject: Re: [PATCH RFC 06/12] RDMA/rtrs-clt: Correct the checking of ib_map_mr_sg
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

On Sun, Nov 13, 2022 at 2:08 AM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>
> We should check with count, also the only successful case is that
> all sg elements are mapped, so make it explict.
>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> index 8546b8816524..5ffc170dae8c 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> @@ -1064,9 +1064,7 @@ static int rtrs_map_sg_fr(struct rtrs_clt_io_req *req, size_t count)
>
>         /* Align the MR to a 4K page size to match the block virt boundary */
>         nr = ib_map_mr_sg(req->mr, req->sglist, count, NULL, SZ_4K);
> -       if (nr < 0)
> -               return nr;
> -       if (nr < req->sg_cnt)
> +       if (nr != count)
>                 return -EINVAL;
same here, we lost errno from API.
>         ib_update_fast_reg_key(req->mr, ib_inc_rkey(req->mr->rkey));
>
> --
> 2.31.1
>
