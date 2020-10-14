Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81CAF28DD09
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Oct 2020 11:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbgJNJWE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 14 Oct 2020 05:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731157AbgJNJVz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 14 Oct 2020 05:21:55 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7690AC02524C;
        Tue, 13 Oct 2020 17:37:40 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id f10so1867741otb.6;
        Tue, 13 Oct 2020 17:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=w+vug/3Yr6WVwWrd+dXT93Db+SxDwBpmr1Zre51Ex4I=;
        b=nNOVJ3vN0rFBmgnVURURJZUP1NAU5qAqU2zFX3lLnNNONJLDlADruSJ1cKwoIMLMiH
         sxEKBfrplmC4+LbNQ11n+RFxTzWSYYfoJ7oXIhrG+Z7sogskoJ3eeIyg+6HJBtMdwBC+
         5YpRQFX3ypgey+X7/vuAOjewfPWRhGZH98wcIwdUwIwMLGyU3g9vsU9BBdHYp+M3tXOQ
         n2FSe/Forx2MORVwCT4mOdJu44RzF373NZojOsFVyrAmPy+i2c4P266hAzZc0+vm2Mv5
         +ILj/ISo6TzcXdD9Ebb5TmBcjIlC/xMtC41aBArnhdb7n66zfqF3XaHycDAREd52pQ3Z
         eYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=w+vug/3Yr6WVwWrd+dXT93Db+SxDwBpmr1Zre51Ex4I=;
        b=GoJ9wJGz38TVasZUE5odPWDnbULF7onpj+Tyuw7YnVla3YV3hQLgux+suyOXmjzf3r
         wXT2/ztoKvZS9ubREjIobJyd1A0cOpwQXq5shXvDCcQNXPPTFtULYC0B46tcsgW6Caw1
         iNp+HA9aGFDek3pchU78DPyup5+fp4OVAszWD3GvRSP8PLqYc3xs80u0HVy/M4ZoMdb/
         Lg7mhn3EcDiDbOhXD4rDaWzkBhvorDwFS6eM8GPq8rYHt002+12hWcI5hfa4ZFWlMIkl
         tHjbqp4cWUlQjD8Hw87Sxy693QKkBkdn569lELKMeGLzEe+gnHbHYxlvxIvK7FkIuPZV
         lXqg==
X-Gm-Message-State: AOAM530S5AYfgDNh1JfWAYrkb3K2jwKn2YxsPWYNroc7rswPO0aUnfH9
        rKBZuDfd7hTHfqJoVwMuK3u1hfFd1ClgEPFGm0grXmtr
X-Google-Smtp-Source: ABdhPJxhe9VW9XUgavM/6ARchKBzi5s9Ya6FaaymGswqVSKwzqTktAbPxyBRFypiPISWZCTSuMhO+0RCt1BKorl3X6Y=
X-Received: by 2002:a9d:1406:: with SMTP id h6mr1587270oth.59.1602635859919;
 Tue, 13 Oct 2020 17:37:39 -0700 (PDT)
MIME-Version: 1.0
References: <20201012165229.59257-1-alex.dewar90@gmail.com> <DM6PR12MB3516EC1E0F28EB8F9B970F24D5050@DM6PR12MB3516.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB3516EC1E0F28EB8F9B970F24D5050@DM6PR12MB3516.namprd12.prod.outlook.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Wed, 14 Oct 2020 08:37:28 +0800
Message-ID: <CAD=hENeBf=u30XWnZFdcZCYGR2Q41HhCFRSduRER=k05zqaCzQ@mail.gmail.com>
Subject: Re: FW: [PATCH] RDMA/rxe: Fix possible NULL pointer dereference
To:     Yanjun Zhu <yanjunz@nvidia.com>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        linux-rdma@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 14, 2020 at 8:34 AM Yanjun Zhu <yanjunz@nvidia.com> wrote:
>
>
>
> -----Original Message-----
> From: Alex Dewar <alex.dewar90@gmail.com>
> Sent: Tuesday, October 13, 2020 12:53 AM
> Cc: Alex Dewar <alex.dewar90@gmail.com>; Yanjun Zhu <yanjunz@nvidia.com>; Doug Ledford <dledford@redhat.com>; Jason Gunthorpe <jgg@ziepe.ca>; Bob Pearson <rpearsonhpe@gmail.com>; linux-rdma@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] RDMA/rxe: Fix possible NULL pointer dereference
>
> skb_clone() is called without checking if the returned pointer is NULL before it is dereferenced. Fix by adding an additional error check.
>
> Fixes: e7ec96fc7932 ("RDMA/rxe: Fix skb lifetime in rxe_rcv_mcast_pkt()")
> Addresses-Coverity-ID: 1497804: Null pointer dereferences (NULL_RETURNS)
> Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>

Thanks a lot.

Zhu Yanjun
> ---
>  drivers/infiniband/sw/rxe/rxe_recv.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
> index 11f3daf20768..a65936e12f89 100644
> --- a/drivers/infiniband/sw/rxe/rxe_recv.c
> +++ b/drivers/infiniband/sw/rxe/rxe_recv.c
> @@ -266,10 +266,13 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
>                 /* for all but the last qp create a new clone of the
>                  * skb and pass to the qp.
>                  */
> -               if (mce->qp_list.next != &mcg->qp_list)
> +               if (mce->qp_list.next != &mcg->qp_list) {
>                         per_qp_skb = skb_clone(skb, GFP_ATOMIC);
> -               else
> +                       if (!per_qp_skb)
> +                               goto err2;
> +               } else {
>                         per_qp_skb = skb;
> +               }
>
>                 per_qp_pkt = SKB_TO_PKT(per_qp_skb);
>                 per_qp_pkt->qp = qp;
> @@ -283,6 +286,10 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
>
>         return;
>
> +err2:
> +       spin_unlock_bh(&mcg->mcg_lock);
> +       rxe_drop_ref(mcg);      /* drop ref from rxe_pool_get_key. */
> +
>  err1:
>         kfree_skb(skb);
>  }
> --
> 2.28.0
>
