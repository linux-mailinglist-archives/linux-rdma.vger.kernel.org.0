Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 912DB3664EB
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Apr 2021 07:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234792AbhDUFja (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Apr 2021 01:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbhDUFja (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Apr 2021 01:39:30 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56982C06174A
        for <linux-rdma@vger.kernel.org>; Tue, 20 Apr 2021 22:38:56 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id m13so41319321oiw.13
        for <linux-rdma@vger.kernel.org>; Tue, 20 Apr 2021 22:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fSQt4PjE8YzbGwheVUea/MCxZ0v9BU2jbUPZ6f8CnfE=;
        b=IY9afLFSNgRFb/PNtrJKaT/3ymhyx3jGmQ3wLreXKFAtSysqbjOWvcARZTImODLd7y
         1t1c+aXxfCClJGLNgBLZ0qgyvhpINdDvfzyjSK4PnP4LcNfO4lDVonIx1y8eHLzdLOb8
         RA0j70Rxw/TCkZy5grjYtQ3TyWyUm56YXCmwUtfixCBc+s0AJIkP9G2I2c8KHr7YRz1D
         fQXHdCljl4dhHNWrJxJNtlarrFVnwhxue4L4qHHfMeUrslWMw7CP11nRAMcIgdcHkwvv
         +nkhmW12wwDe5DbHUBPili9361fjhQsSICWzCKktwgddICkmrTpuCdb2jbLSeCU9i4Z1
         ynPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fSQt4PjE8YzbGwheVUea/MCxZ0v9BU2jbUPZ6f8CnfE=;
        b=hG3AEtvv1BigjQ7x84HPHebKPLV+wzV3K0+iopZ3Ps6MO9QqiNQO/Xz1ac8vuRlizZ
         0UPgRKLNo+lg0Xy1BxPUHTXgHG8wT7zuQ7xhBAjiCJ49DnkoQaO9SQfr1hbdRVOyVVNO
         /DV4c3OP0Q2x1WndbM8SIJQH0tNAdGgstAaricsNs4GToXiJC4C2b4K1JgNBHPLdFR0q
         B2piMdQueA9MBKk1yXo2LOc9s6WD8jCPRLK5oWGgGvJozMlinfUkTvqbt1n/XKqN82Tx
         wHEJlaSS9cehWmkLVkxxawHNh7L5sRyVzkVD48Yhlz8iY14BxjGAm6jaiZ2angSych9v
         1yIw==
X-Gm-Message-State: AOAM5316cFnnQNrsKDGUMO/ariHTfvymVLb6lfCWAJnmHFmrzHdM6oSg
        IkEgNMRRCBQQ1TTVXAtFYVuR2ZQzITvgvY5uYrM=
X-Google-Smtp-Source: ABdhPJz/mCvLjMMgCc2qI+H4BrYLN7FUJecjRNJR4HOafLN1f2UlYETJnSiF5pIS6gsUia29pegD20Uo+Yqxg8PzmFY=
X-Received: by 2002:a05:6808:8c6:: with SMTP id k6mr5423390oij.163.1618983535704;
 Tue, 20 Apr 2021 22:38:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210421035952.4892-1-rpearson@hpe.com>
In-Reply-To: <20210421035952.4892-1-rpearson@hpe.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Wed, 21 Apr 2021 13:38:44 +0800
Message-ID: <CAD=hENcpo=gtYJOsgQ0jP=Vi6Dv0piFR8sCKCmksJ=PijXh1Cg@mail.gmail.com>
Subject: Re: [PATCH for-next] RDMA/rxe: Fix a bug in rxe_fill_ip_info()
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>, Frank Zago <frank.zago@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Thanks.

Acked-by: Zhu Yanjun <zyjzyj2000@gmail.com>

Zhu Yanjun

On Wed, Apr 21, 2021 at 12:01 PM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> Fix a bug in rxe_fill_ip_info() which was attempting to convert from
> RDMA_NETWORK_XXX to RXE_NETWORK_XXX. .._IPV6 should have mapped to .._IPV6
> not .._IPV4.
>
> Fixes: edebc8407b88 ("RDMA/rxe: Fix small problem in network_type patch")
> Suggested-by: Frank Zago <frank.zago@hpe.com>
> Signed-off-by: Bob Pearson <rpearson@hpe.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_av.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_av.c b/drivers/infiniband/sw/rxe/rxe_av.c
> index df0d173d6acb..da2e867a1ed9 100644
> --- a/drivers/infiniband/sw/rxe/rxe_av.c
> +++ b/drivers/infiniband/sw/rxe/rxe_av.c
> @@ -88,7 +88,7 @@ void rxe_av_fill_ip_info(struct rxe_av *av, struct rdma_ah_attr *attr)
>                 type = RXE_NETWORK_TYPE_IPV4;
>                 break;
>         case RDMA_NETWORK_IPV6:
> -               type = RXE_NETWORK_TYPE_IPV4;
> +               type = RXE_NETWORK_TYPE_IPV6;
>                 break;
>         default:
>                 /* not reached - checked in rxe_av_chk_attr */
> --
> 2.27.0
>
