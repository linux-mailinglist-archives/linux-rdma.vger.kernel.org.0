Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A502F3AC5A7
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jun 2021 10:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbhFRIFG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Jun 2021 04:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbhFRIEk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Jun 2021 04:04:40 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EED5C061574
        for <linux-rdma@vger.kernel.org>; Fri, 18 Jun 2021 01:02:25 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id n20-20020a4abd140000b029024b43f59314so444954oop.9
        for <linux-rdma@vger.kernel.org>; Fri, 18 Jun 2021 01:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kuWxwRqpf6+SITv9tahjhxlvu6ZGYPlyh9KVuWcnRos=;
        b=tjQ+pg7ggl3rAyORJC23V0lQuKyf1yHqfiBuIdxgzitAS6T6XsS9m/Hk9Ze7hq+l51
         C5hUDmDcBnvSJyKu13UmxCyxaWbn+k9vyGn6/MevQ1d3olHEaWwOwyz9MKbwlQgXGhsr
         9YVAJD7Ec7LHrlycx6p9hKKKJDaznjbjtCHh/NV/vTEDbr7yGM2nCqSOuZgGYAo7Fr4T
         EgenEZCQ8Itg/rlXqt4HahKxQ+Ynm+tJknk0V0/pNotLtEGvZN0SXXCfVvxt2hHl3+LS
         WsRTHTKl2z4Zs5LR6+mUB3pZyQep7zYBD5XqXnfAIlbuN6VzYM9vG4pRcc43b7as/aIv
         7aXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kuWxwRqpf6+SITv9tahjhxlvu6ZGYPlyh9KVuWcnRos=;
        b=Ba9lsoL8owHLK0T/2MxU295yC2HtOXgHa5f05Fk6dqC0RWPfh8wx7p+do+1aAdkQly
         eQs8DMUnpQVOWE8F4Okmojk9LpKnj2VdHRvcBeR2aMTg1eGn3WUVel8S89OEDF9aBeKw
         ZTvTigQHIjD/AB5utbU62b2PkWnaOi/7+/j6jdAH7NutKA5lYIoJm6g1nJf+m6O78pfz
         Jb6cADajdgjBbWKLfPc2tWMMxv3Tj5co+1PBSaGCQ2nTT+j8C6ZJTy7O/9uaxF4dfhJS
         givr9twt8VlmWF8vtay/zJ4rkACXR9wfJgV8JUkSeuhaxGCa107uV1emk0A28mNyb7B+
         9isA==
X-Gm-Message-State: AOAM530Im8G4Qa+8VZOVRWtzU24xipWBAu6CvzeuxZPeOjkUe4sWlY0e
        gDpVB0ZVHqkzXMbPLHwHA/IJat7+StnTwzocpuw=
X-Google-Smtp-Source: ABdhPJwunhIE+xqiRSXLQcNO6iTPQWuW3TC/6PRQO02XeKlIS9CDWT3/+NMh4VFpJ016zCLpSmjpv/+qVy2U8aVL+TQ=
X-Received: by 2002:a4a:97ed:: with SMTP id x42mr7880644ooi.49.1624003344916;
 Fri, 18 Jun 2021 01:02:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210618045742.204195-1-rpearsonhpe@gmail.com> <20210618045742.204195-7-rpearsonhpe@gmail.com>
In-Reply-To: <20210618045742.204195-7-rpearsonhpe@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Fri, 18 Jun 2021 16:02:13 +0800
Message-ID: <CAD=hENfOFHUrSFws0ipYmrcQ803uFNmK9rPNLt-hPWpXndsLSQ@mail.gmail.com>
Subject: Re: [PATCH for-next 6/6] RDMA/rxe: Fix redundant skb_put_zero
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 18, 2021 at 1:00 PM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> rxe_init_packet() in rxe_net.c calls skb_put_zero() to reserve space
> for the payload and zero it out. All these bytes are then re-written
> with RoCE headers and payload. Remove this useless extra copy.

The paylen seems to be a variable, that is, the length of pkt->hdr is not fixed.

Can you confirm that all the pkt->hdr are re-writtenwith RoCE headers
and payload?

Zhu Yanjun

>
> Fixes: ecb238f6a7f3 ("IB/cxgb4: use skb_put_zero()/__skb_put_zero")
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> index 178a66a45312..6605ee777667 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -470,7 +470,7 @@ struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
>
>         pkt->rxe        = rxe;
>         pkt->port_num   = port_num;
> -       pkt->hdr        = skb_put_zero(skb, paylen);
> +       pkt->hdr        = skb_put(skb, paylen);
>         pkt->mask       |= RXE_GRH_MASK;
>
>  out:
> --
> 2.30.2
>
