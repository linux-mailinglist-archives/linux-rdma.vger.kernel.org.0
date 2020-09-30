Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F6327E9B4
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Sep 2020 15:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730243AbgI3N1Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Sep 2020 09:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729813AbgI3N0m (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 30 Sep 2020 09:26:42 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD313C061755
        for <linux-rdma@vger.kernel.org>; Wed, 30 Sep 2020 06:26:41 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id g4so1856319edk.0
        for <linux-rdma@vger.kernel.org>; Wed, 30 Sep 2020 06:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+zvRa+T4/5HBz5Nz536SOot7ApFyuegrF7jZyGB7kD0=;
        b=c/lysZ/i748ltsbqxeT4ny6BWPXHd1Z7BjJlNexuZhAdDpxe7kzrldHjOvCGPrvPbF
         6YYf0rL9Ea3kR775oDxqtqUjgFzp2ei0UM9px+655bVIHw1GuXSZLJsTyvcefxVC7ed6
         z3oeZR7uHRFGHXxJpXKMeTh90a8ksK562ryzH1siFuhKcvCWpNg0zMokg6hL8hlpQ6eQ
         FvVPumKF414x33h/vTAcIQ3Kwte/WA7s08Y9YwHLsnJeH7Y0QNlPV81pgS0zBcb/dwEO
         Ngkfy79U/ik//rH5filpvv4GmqQUS3Ks36I10EJLxBBa0YTO1UwP+jQV9ufW0N0tIQ25
         dfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+zvRa+T4/5HBz5Nz536SOot7ApFyuegrF7jZyGB7kD0=;
        b=Z5K4eAv4kdjRG5tgOgKOICpo3HuQy16AZ5C+9ypePq2FKKeVoCRS4GZGpm2cCoSVZm
         CJeWdier0DZ2s1QAT4G4yQoT+g/clLtCJcnAx6RgmhGA22BBbH5pLdKay4ojLc+gPP5B
         SzQiCP8tt45rAhUw3W3qsK41BnKIdR3onPys5meeJtGOYIV951eSDxyqoGVp6bHaFmJT
         3///B3fnyhAydG3kmSBK6ggV8R5OqzR/wyxCtboF1qa7oQZ/uT4RZd497AZPhJMSP1qX
         s1hmCI0MlfKc5OO12T6l8arQjpmvbJB8MbgLTJ/AOV8S0M/f5X75tf5LyRK2AsBqJgxF
         OKxA==
X-Gm-Message-State: AOAM530UlqrkX1r/HO0nS2i8+AMczf/h3jLF6JVvUA/4Y3Juh811GIuG
        kc5bvArRST3BChhqPiN5XV9zYzZ1wzqBcy5lb4zk9w==
X-Google-Smtp-Source: ABdhPJwqfuZ/gn/kXu2Yp713TZ3/bhXfQqJsygNIRG4Xz6JO/2PRv4wOpEvfTbXBNxeRuuHdUQr/AU4h0E1L7MoCxJI=
X-Received: by 2002:a50:eb0a:: with SMTP id y10mr2795362edp.89.1601472400531;
 Wed, 30 Sep 2020 06:26:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200930131407.6438-1-gi-oh.kim@clous.ionos.com>
In-Reply-To: <20200930131407.6438-1-gi-oh.kim@clous.ionos.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Wed, 30 Sep 2020 15:26:29 +0200
Message-ID: <CAMGffEktjxkWYByRknjF2mA-8DqkOJzC4zLKMChvR43SHeYZXQ@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rtrs: remove unused field of rtrs_iu
To:     Gioh Kim <gi-oh.kim@cloud.ionos.com>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 30, 2020 at 3:14 PM Gioh Kim <gi-oh.kim@cloud.ionos.com> wrote:
>
> From: Gioh Kim <gi-oh.kim@cloud.ionos.com>
>
> list field is not used anywhere
>
> Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
thanks, Gioh!
Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-pri.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-pri.h b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
> index 0a93c87ef92b..b8e43dc4d95a 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-pri.h
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
> @@ -115,7 +115,6 @@ struct rtrs_sess {
>
>  /* rtrs information unit */
>  struct rtrs_iu {
> -       struct list_head        list;
>         struct ib_cqe           cqe;
>         dma_addr_t              dma_addr;
>         void                    *buf;
> --
> 2.20.1
>
