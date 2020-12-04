Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17F3F2CE533
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Dec 2020 02:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbgLDBih (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Dec 2020 20:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgLDBih (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Dec 2020 20:38:37 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118EAC061A4F
        for <linux-rdma@vger.kernel.org>; Thu,  3 Dec 2020 17:37:51 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id z24so3763816oto.6
        for <linux-rdma@vger.kernel.org>; Thu, 03 Dec 2020 17:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kKrD0HqFeTR8lweY/XjW6kamTbExOOnIxdWV0N/47QU=;
        b=oEothRtTzC+gaNiXBRd1kALBoqZevm5shKLDxvg4b3YSNQVg+potlSC/3d7jwld1Gy
         1ImsHQKnm5lt9uFvy3gY/G2SPkMaJ/+sM6EoHa8+22upIRN+qnpVJ6ecikh0FZsD9W0b
         UnldFuOkwY+BDpEVspJUSoJ19H9mj2e75PwekeG/nt2bOIzxUNQKFYOU+2sXxJ1fWpMo
         QnCbfdhVP0pSNyft2mVIB9IRZEwOi2+5J6QFgTEWRunXEyIQrBaQ5zjREiAENYopSu/x
         NXr0xRrf1hc5Pb4vb3Tqf9Xfzatj+ogNTfftX0bHGPsx8UzzoqkxmJSztKSyZ6EObTOh
         EPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kKrD0HqFeTR8lweY/XjW6kamTbExOOnIxdWV0N/47QU=;
        b=BBp9pFCZOqnY1nfhvxVv/vgAKsGSluvf+yYZTMSkINCKtG8gRlFQZy4G/g6keygjXM
         6cShg7jZyBkar5IJmZjW0R81x0skYTRWROm2WfHFMkFEg/8ANPmvIfY08otvDe2l3++m
         jc0/rVbb+jfRD5pBgdHUOI0oX1AbtrdGXbFb5bMa6AywXP2brWjJ9nH78RbapBPcUX8W
         K5z1sXZ2ZuUD/FiO55OWrRPzOJW7PUh6h3CQtHgRmv9CkL1g0g6xwEKkcg/FsuENHVvv
         G9N9S+sEH7g9upfylrs6awgUultTDVuzULokrgVGKSBnA539UznkxmIFOTJ5HUxHBpX3
         r/5g==
X-Gm-Message-State: AOAM530ApcTApuqdxieq9Yvyx97AMr36xW1IgIfcv+0PfBtQE7yzi4cV
        UQ8eFHN6wFQ2KNYJ9N+VAp/YeQXhozeEYmEJGFo=
X-Google-Smtp-Source: ABdhPJwNecB6n0r+MwHiKU4CeP8DLILclpfVyirrVvh7K9r4K1poTMxmBIhrjr4TZssZZfZhyniO/l8Qj387QX5Ib9E=
X-Received: by 2002:a9d:4b03:: with SMTP id q3mr1769340otf.53.1607045870531;
 Thu, 03 Dec 2020 17:37:50 -0800 (PST)
MIME-Version: 1.0
References: <20201203190659.126932-1-leon@kernel.org>
In-Reply-To: <20201203190659.126932-1-leon@kernel.org>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Fri, 4 Dec 2020 09:37:39 +0800
Message-ID: <CAD=hENes8=9oT-SWvPC1oQVMkJc7fnsEi6+OzbNsDZNE0xB43w@mail.gmail.com>
Subject: Re: [PATCH rdma-next] MAINTAINERS: SOFT-ROCE: Change Zhu Yanjun's
 email address
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Zhu Yanjun <yanjunz@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Dec 4, 2020 at 3:10 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> From: Zhu Yanjun <yanjunz@nvidia.com>
>
> Change Zhu's working email to his private one.
>
> Signed-off-by: Zhu Yanjun <yanjunz@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Thanks a lot.

Zhu Yanjun

> ---
>  .mailmap    | 1 +
>  MAINTAINERS | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/.mailmap b/.mailmap
> index d9fb83d67055..22831c2991ab 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -341,3 +341,4 @@ Wolfram Sang <wsa@kernel.org> <w.sang@pengutronix.de>
>  Wolfram Sang <wsa@kernel.org> <wsa@the-dreams.de>
>  Yakir Yang <kuankuan.y@gmail.com> <ykk@rock-chips.com>
>  Yusuke Goda <goda.yusuke@renesas.com>
> +Zhu Yanjun <zyjzyj2000@gmail.com> <yanjunz@nvidia.com>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2daa6ee673f7..73e53207c920 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16195,7 +16195,7 @@ F:      drivers/infiniband/sw/siw/
>  F:     include/uapi/rdma/siw-abi.h
>
>  SOFT-ROCE DRIVER (rxe)
> -M:     Zhu Yanjun <yanjunz@nvidia.com>
> +M:     Zhu Yanjun <zyjzyj2000@gmail.com>
>  L:     linux-rdma@vger.kernel.org
>  S:     Supported
>  F:     drivers/infiniband/sw/rxe/
> --
> 2.28.0
>
