Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF19E3F394B
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Aug 2021 09:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbhHUHWH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 21 Aug 2021 03:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbhHUHWG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 21 Aug 2021 03:22:06 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F983C061575
        for <linux-rdma@vger.kernel.org>; Sat, 21 Aug 2021 00:21:27 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id c19-20020a9d6153000000b0051829acbfc7so20033410otk.9
        for <linux-rdma@vger.kernel.org>; Sat, 21 Aug 2021 00:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T4MBd50qTGeZaMz5vz/1XyJoarg0qVyLnCwjDiIKSO8=;
        b=TpiBTAXs56TrWXZ3+kz8J2Rx2awNo3zKJ4m0LSma31sH2bE+IoxjC4ffwIbnytLG8r
         1Wjc/XwDMK1vv2CYuQdBXUMjUQiaoCOevsDrL+7NBCMJ/BLgGdyrietTRS23QObbdAeo
         CH/LLQwf3eajPrj14bvg6JOw06DheS9VYkxC2RkD6vQlRgQ56Kc/arBnDOzzLonqYDIN
         wGAmHmE15tR53Ov/Ko6dsjirLwguHJQJ1GIY0E20Rh4TEw5RGqOTypbTnEiB/yXPD29p
         q//VKODPqf/RzzhqwBnfCOCd1Iw1bXn3y0FeUiOjFGikjaJYTud8BuKlxPlh5clKqMBF
         HHjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T4MBd50qTGeZaMz5vz/1XyJoarg0qVyLnCwjDiIKSO8=;
        b=T6bG0ytPa5ACbZ2gEBz4Laxq2gcPigCGDj6XBB/qPjumr6PLnk0pfsPg6mAKMLsCP8
         dusouBDGaT8f3HEh4v17pGDHb+2nzSbSPq9FrlkCeQkTseja2myE+UG/jxS1HMM6zoe4
         NzM8bmIWheHdCekQzz73bHIqcaJebxT2NFsm9v/UyUwD8NHGkOsQ361fUhITXqk2Y03u
         fbhU84lvHiWzyxJKX5UMBz6be+lfkD8SUj5ECy+PAdpa40KSWqEiRBCJTrfgy3bVAZbi
         JuIzBfDwrkQfiRybJS7Uwwaaf8XnBrfJYSxmoPi+pPB6wKWXMpv7ne30fV8dEaSv9ntB
         oowg==
X-Gm-Message-State: AOAM531EMC12Xl+e++53uoUnOSa9afEtporLfnvnfZ6qZtSkdy6CGIZy
        j5cdcmHjyOFK+yfLaLVuSIMRTKBJb20hwZUlzz+GLRj0
X-Google-Smtp-Source: ABdhPJzaH11kBoc+EU8QLMa+PCs38UjpxS3JEXyofgBupXiJB7pAMKQW4rV9FxVovVlmAKMyUFADxnpwjB6iyUpU/W4=
X-Received: by 2002:a9d:541:: with SMTP id 59mr18280556otw.278.1629530486954;
 Sat, 21 Aug 2021 00:21:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210820111509.172500-1-yangx.jy@fujitsu.com>
In-Reply-To: <20210820111509.172500-1-yangx.jy@fujitsu.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Sat, 21 Aug 2021 15:21:16 +0800
Message-ID: <CAD=hENffdb237oicsjwecE1Os9WZNhTkUrn7RUiM2YQwHP51fQ@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rxe: Zero out index member of struct rxe_queue
To:     Xiao Yang <yangx.jy@fujitsu.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Olga Kornievskaia <aglo@umich.edu>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 20, 2021 at 6:44 PM Xiao Yang <yangx.jy@fujitsu.com> wrote:
>
> 1) New index member of struct rxe_queue is introduced but not zeroed
>    so the initial value of index may be random.
> 2) Current index is not masked off to index_mask.
> In such case, producer_addr() and consumer_addr() will get an invalid
> address by the random index and then accessing the invalid address
> triggers the following panic:
> "BUG: unable to handle page fault for address: ffff9ae2c07a1414"
>
> Fix the issue by using kzalloc() to zero out index member.
>
> Fixes: 5bcf5a59c41e ("RDMA/rxe: Protext kernel index from user space")
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_queue.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_queue.c b/drivers/infiniband/sw/rxe/rxe_queue.c
> index 85b812586ed4..72d95398e604 100644
> --- a/drivers/infiniband/sw/rxe/rxe_queue.c
> +++ b/drivers/infiniband/sw/rxe/rxe_queue.c
> @@ -63,7 +63,7 @@ struct rxe_queue *rxe_queue_init(struct rxe_dev *rxe, int *num_elem,
>         if (*num_elem < 0)
>                 goto err1;
>
> -       q = kmalloc(sizeof(*q), GFP_KERNEL);
> +       q = kzalloc(sizeof(*q), GFP_KERNEL);

Perhaps this is why I can not reproduce this problem in the local host.

Zhu Yanjun

>         if (!q)
>                 goto err1;
>
> --
> 2.25.1
>
>
>
