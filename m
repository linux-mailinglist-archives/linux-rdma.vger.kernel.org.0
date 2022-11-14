Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A789C62850A
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Nov 2022 17:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237469AbiKNQWj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Nov 2022 11:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237495AbiKNQWa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Nov 2022 11:22:30 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AAE2F01D
        for <linux-rdma@vger.kernel.org>; Mon, 14 Nov 2022 08:22:23 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id s8so2987181lfc.8
        for <linux-rdma@vger.kernel.org>; Mon, 14 Nov 2022 08:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pyI/vjNFbJB2Hv0/zqwdiZnbeMPXjSdMKeWZbUv6LEY=;
        b=MH8PRTGwKwNZyQ0/5ATLj/nT/boBF8H329SJRhwOqxefmTKpJPFiFHG4aFGn/rVQ1O
         ggOWaNFdEcHqBdrlf5bZwTXeebg/hWqsDatMuhviBDTygO5ke9XS3DCtkQfH+zfl9Eei
         Z/+4iJD+h01d7T5bPRGkxbBTpH22w2qUnc29KiDysUtoL1WwZQePam4QxaeSBgk3jTSX
         o/RrQ739AY/5SeVWebyUEpd0u49dtYGVhFUSANz02/bsNV1tZV1iTWvWV2kDej3QovyU
         aB+sQauTDOne/gSF7D/KYpTcWqGhUG6LFKwSpkUHdVi6SUl026fW0kTJraH5g10/EJC6
         jhcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pyI/vjNFbJB2Hv0/zqwdiZnbeMPXjSdMKeWZbUv6LEY=;
        b=wfvvxulc8VW49GM++pNZbOp9KuF+J5/ONumzg4tI5/xpe0ON4mRL2DW121eEPGn5/3
         fssG9ZIKCc7mXJXkeDXDykYJOq+Tjny65PumrwCYDYbAuLfKw07vxA6+MiD2DqsuM9oI
         tCsiwGJ3Th47AVFgGYQiCXh095ltx2/qJ4It0wmbNR5FiVP/GyOuy/YNmUIB8VqhBJx+
         qIePeFFtU8ubnko2uAzOs9kHouDtcgWO6YfpV3jTRLAbrLxKqgCGX1jX9PGouaS/d7y8
         0YX7Zy+Ky/0Pug2eigancMqBQozefCCquPFwJ1chnu2OvPs5jKyTGxKBFdvu99IzjDir
         eD3A==
X-Gm-Message-State: ANoB5pkuqLQ0eL6lg5K2j34jmKiSaI+CMaFNz9P9A5Bo4gT7ZHBDvGNU
        BLylbwrKNRA4+lRqLCWijdrN+pOuyadu4Lp5Ua7qXXn6VRu1sQ==
X-Google-Smtp-Source: AA0mqf56jn7rr+JBFpqJh+1uSgSphgbKcloglg/t2OGPWfx2YpjlE+XRoN/kJLhZOon1ul/NnRF9wHZ1V4Y3ZEhbEYE=
X-Received: by 2002:ac2:44d9:0:b0:4a6:fa2a:275b with SMTP id
 d25-20020ac244d9000000b004a6fa2a275bmr4434773lfm.87.1668442941698; Mon, 14
 Nov 2022 08:22:21 -0800 (PST)
MIME-Version: 1.0
References: <20221113010823.6436-1-guoqing.jiang@linux.dev> <20221113010823.6436-8-guoqing.jiang@linux.dev>
In-Reply-To: <20221113010823.6436-8-guoqing.jiang@linux.dev>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Mon, 14 Nov 2022 17:22:10 +0100
Message-ID: <CAJpMwyhHrRV1mO3LL4hsd4p-v41o7ZxwY0xUDye_+v_iuwqaRA@mail.gmail.com>
Subject: Re: [PATCH RFC 07/12] RDMA/rtrs-srv: Remove outdated comments from create_con
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     jinpu.wang@ionos.com, jgg@ziepe.ca, leon@kernel.org,
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
> Remove the orphan comments.
>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
Acked-by: Md Haris Iqbal <haris.iqbal@ionos.com>

Thanks

> ---
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> index f3bf5bbb4377..4c883c57c2ef 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> @@ -1671,12 +1671,6 @@ static int create_con(struct rtrs_srv_path *srv_path,
>                                       srv->queue_depth * (1 + 2) + 1);
>
>                 max_recv_wr = srv->queue_depth + 1;
> -               /*
> -                * If we have all receive requests posted and
> -                * all write requests posted and each read request
> -                * requires an invalidate request + drain
> -                * and qp gets into error state.
> -                */
>         }
>         cq_num = max_send_wr + max_recv_wr;
>         atomic_set(&con->c.sq_wr_avail, max_send_wr);
> --
> 2.31.1
>
