Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 147161DE3A4
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2020 12:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbgEVKBY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 May 2020 06:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbgEVKBW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 May 2020 06:01:22 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F77C05BD43
        for <linux-rdma@vger.kernel.org>; Fri, 22 May 2020 03:01:22 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id n18so9251161wmj.5
        for <linux-rdma@vger.kernel.org>; Fri, 22 May 2020 03:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RyxHtd8t+Tnym6Rgfk/b1z6/xAgAd1SgDqjswJTBPeQ=;
        b=HnPluOJFuyWZ2ZmEnp7WE34nWh83fzfZaugdRb/RgIp3B3UhhAIdNPCeePTwTkn32y
         OTCuEppurSdXNLugm1Y+bu9BGs8PW/AhkWHQ1NBM4ECKgFTUA+KHgpqd8xXXRGCZw5J4
         khAyW9C9LXtu9y7EvPqTpxXsYzMVmFPWcSWJa9OzGwG3wcyw0wN6qzA8pah3yWvZwEgS
         YfefvBkrxQrAHM++e+EgghWkvd5/DaKlvevQYJU6vjcSnFAV+kd9P4vRBr+Q7nU/oGHy
         KG4/MQJxpGMH9TajPB4/r+GGj0tiG+Xyrfn/BnwHykkZvfS3hrmUt2dpR7pzf5vCW7Ql
         S4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RyxHtd8t+Tnym6Rgfk/b1z6/xAgAd1SgDqjswJTBPeQ=;
        b=lXmS2amQac1wW5pJQolehwRHpdkCswYqe4ZYNMRZ6KUlTxEV2oiRtTbaPBm6qgPcbz
         2AZuMFZ+LgUW0rLfPHSjarbgMf4lCYShAISGB1pbQ84RSywHsgazsQXAOn0q9hTlFxK7
         RB7plWDcKArXtiuu8D67SUQh+tts7MKWIXhqMeqPLgC8RjGkh4unoK38kyP80J+Bbr0y
         wRMGRxjPZCLiDneNe+LxWY8n04dh2U3qlRjplqhQY67WDDMaKaiEQyodENnFUrzRCaow
         m4driaFko/Xx+pKjCpsF2ogeVi8xUHe74iZmw5BNtFk7U4UMWCCZkCgTG6BxdyUxi0rC
         t5LA==
X-Gm-Message-State: AOAM532HmyOhnRrZ9JubL9OIOxo15Bma/aJXzOB6biT6Xsx0lSW0Y9II
        A4kjIDg+x+ImN8VIUwPqWlDGhhsSkK//y4FyWpjV
X-Google-Smtp-Source: ABdhPJyCVsG6wWaF1VxfaUETpoayuVhLjiFIiH8pDZdtkv+vqCyWpNVJcDDNCjYoo2AfDxsELPltZ6BD8lCKZrMMIM4=
X-Received: by 2002:a1c:c242:: with SMTP id s63mr12990862wmf.180.1590141680757;
 Fri, 22 May 2020 03:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200522082833.1480551-1-haris.phnx@gmail.com>
In-Reply-To: <20200522082833.1480551-1-haris.phnx@gmail.com>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Fri, 22 May 2020 12:01:10 +0200
Message-ID: <CAHg0HuwK3FepXP06o-S_y6hukYmF3sMRgU+RweB6EMWdF3y9TQ@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rtrs: server: use already dereferenced rtrs_sess structure
To:     haris iqbal <haris.phnx@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jinpu Wang <jinpu.wang@cloud.ionos.com>,
        Jens Axboe <axboe@kernel.dk>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 22, 2020 at 10:28 AM <haris.phnx@gmail.com> wrote:
>
> From: Md Haris Iqbal <haris.phnx@gmail.com>
>
> The rtrs_sess structure has already been extracted above from the
> rtrs_srv_sess structure. Use that to avoid redundant dereferencing.
>
> Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
> Signed-off-by: Md Haris Iqbal <haris.phnx@gmail.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> index 1fc6ece036ff..5ef8988ee75b 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> @@ -1822,13 +1822,13 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
>                 /*
>                  * Sanity checks
>                  */
> -               if (con_num != sess->s.con_num || cid >= sess->s.con_num) {
> +               if (con_num != s->con_num || cid >= s->con_num) {
>                         rtrs_err(s, "Incorrect request: %d, %d\n",
>                                   cid, con_num);
>                         mutex_unlock(&srv->paths_mutex);
>                         goto reject_w_econnreset;
>                 }
> -               if (sess->s.con[cid]) {
> +               if (s->con[cid]) {
>                         rtrs_err(s, "Connection already exists: %d\n",
>                                   cid);
>                         mutex_unlock(&srv->paths_mutex);
> --
> 2.25.1
>

Acked-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>

Thanks Haris.
