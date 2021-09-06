Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6B34016ED
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Sep 2021 09:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239895AbhIFHXE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Sep 2021 03:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbhIFHXE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Sep 2021 03:23:04 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB0DC061575;
        Mon,  6 Sep 2021 00:22:00 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id v2so7831328oie.6;
        Mon, 06 Sep 2021 00:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jma2HyPnKZSUv1JWcMBX0ytnVUkyGu5hD420f9iCjs8=;
        b=N7KoiW7aKaGJFUTKwwof1u/UFQrjCCFhPnHUfW9J6dH5gox+zQncAYURgr/fNU9pL6
         M5s3xShudIVLcWCoOJ1GSVFvf6hvNqeZLw1Nlh825cfHCfxQXvm5X5W7Rl6J1XlHbkyF
         O/4Y+9d+cpSdzKEBNFtGcVWzdDw9xtcLGhX7rleGhu2bfIqIhAEctKXsuhR/MEfYsxx/
         x4c6JYO9QWyIKwunL/DSPoJ7WK+wYDRWJGH+i9POBCk5lqtKAEPilOqQrlR/er2nE+w1
         y/u60/GYCSUgAUoDk4vjFXk+JWyGt7cU8wqS2TAFZQZNpRD4W7cHr0wh7CP8BRCIvCfW
         vEgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jma2HyPnKZSUv1JWcMBX0ytnVUkyGu5hD420f9iCjs8=;
        b=oo2J0ftgIXvSEgOkTMcT+9X+FR2vw3PcBKNvrPP+C87FWcIjN+NvpfjNMhkk/c8t4f
         VMZFExKU0TMbCJCrvkugDghWFO3K17uaxuvobcFBmnSbXjALzoNc/9T9aGfSu7EhKtHf
         UIGUZi9wzSwIf3wydHqzvIijScK/ONwKiJltKlJ1xgVVxZT5X2OZ2Cwa0W4oyUFEfHU3
         wZMRIFCVQa+83un689fXfxrGHFBpR4a4rUug+7syOsj5APwPbNFvD0NMVOTfeM9sbRw+
         WumD+mckH1aEG7z9jN2Qt7L5ZTLQeGcGglNWj4ktFjkrDl3zfiPt/xWAPS9IgWNa5pnH
         53cg==
X-Gm-Message-State: AOAM532phqVW6OJ0QuvoKzyCLXLW+pobX0vJWlS63R0uGxICTsSfhuYF
        Ug/NXv0rf/E3Ff06cO+zH1tP+TrsOISqU3jaFiXQ055ZNwc=
X-Google-Smtp-Source: ABdhPJxb86tMFWpbtRCjUQUFmxhOtcjeT7oflkgnjyzOJjzzzfx/QrjIjaqa64MnwR90LSoJ+tm177qnzDjU5WQkt9c=
X-Received: by 2002:a05:6808:55c:: with SMTP id i28mr7385954oig.169.1630912919714;
 Mon, 06 Sep 2021 00:21:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210831083223.65797-1-weijunji@bytedance.com>
In-Reply-To: <20210831083223.65797-1-weijunji@bytedance.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Mon, 6 Sep 2021 15:21:48 +0800
Message-ID: <CAD=hENcbvs3_Mu7tjTPfrj8h1xTDb03y-5bACU3cckOpmPJveg@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rxe: Fix wrong port_cap_flags
To:     Junji Wei <weijunji@bytedance.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, xieyongji@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 31, 2021 at 4:32 PM Junji Wei <weijunji@bytedance.com> wrote:
>
> The port->attr.port_cap_flags should be set to enum
> ib_port_capability_mask_bits in ib_mad.h,
> not RDMA_CORE_CAP_PROT_ROCE_UDP_ENCAP.
>
> Signed-off-by: Junji Wei <weijunji@bytedance.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_param.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
> index 742e6ec93686..b5a70cbe94aa 100644
> --- a/drivers/infiniband/sw/rxe/rxe_param.h
> +++ b/drivers/infiniband/sw/rxe/rxe_param.h
> @@ -113,7 +113,7 @@ enum rxe_device_param {
>  /* default/initial rxe port parameters */
>  enum rxe_port_param {
>         RXE_PORT_GID_TBL_LEN            = 1024,
> -       RXE_PORT_PORT_CAP_FLAGS         = RDMA_CORE_CAP_PROT_ROCE_UDP_ENCAP,
> +       RXE_PORT_PORT_CAP_FLAGS         = IB_PORT_CM_SUP,

RXE_PORT_PORT_CAP_FLAGS         = IB_PORT_CM_SUP |
RDMA_CORE_CAP_PROT_ROCE_UDP_ENCAP,

Is it better?

Zhu Yanjun

>         RXE_PORT_MAX_MSG_SZ             = 0x800000,
>         RXE_PORT_BAD_PKEY_CNTR          = 0,
>         RXE_PORT_QKEY_VIOL_CNTR         = 0,
> --
> 2.30.1 (Apple Git-130)
>
