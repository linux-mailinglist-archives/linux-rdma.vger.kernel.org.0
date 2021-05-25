Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7CCB38FACB
	for <lists+linux-rdma@lfdr.de>; Tue, 25 May 2021 08:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhEYGVz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 May 2021 02:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbhEYGVz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 May 2021 02:21:55 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACCBC061574
        for <linux-rdma@vger.kernel.org>; Mon, 24 May 2021 23:20:25 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id h9so29334190oih.4
        for <linux-rdma@vger.kernel.org>; Mon, 24 May 2021 23:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WltsMgCSbTax675eL/BCIPutsbhRbdmxCbF1/sxXCcg=;
        b=FOuhXwG0oT3cpuW/u7k25epBUi7q37xFv++SS8SeD+M2FFGJWBvqlK9T+Mn2NB7fQz
         1S2E6T04M2+FvR8KR3AIscHyo/AFn0Z17h01/wjjVqq187fFlewP0WrjIof5ezCPi1Qz
         An1pENOzCDU8KOrh0UOgQbtJlUtjfqRhfgfUMqBsJMrXyBl6ddXg3+3ip1c+EsnzzSIM
         oxwZ8/hsxykuNMsWhDUnGIvYuNSKSL60+9VXbBVO09s2pvZL0cmebPX6YsQ3dmk0igMi
         7fK75lPkbngQGWa01f/JZJCJuVECpZrXnnFpWhvxJOW7CfAbSMgoh+t80hAfVgw7TdOQ
         OR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WltsMgCSbTax675eL/BCIPutsbhRbdmxCbF1/sxXCcg=;
        b=nW2AOeuyJKp5gOlhk7PuwgVlUundiut/VE9Aq/oHoPB/Qu++U+PWHIGlZXl0+BVg66
         Ime7RdAHQyQDOS3PatCsXDaVtDP0WjMnPNTyI03fZlnnltIp+3vSWhd4Gw5pma7YZPAT
         S3KtMCO340R9kbUsscnPMNOlMGlx9E24g2GilAhIAGgZtd94sQ+7xAxs0+W/wPX1U5bi
         5uejRRWEbZ7z4FqrTzgbAO5rEhUDpNqh9hupUSQAtqoCNZLnL68bv+dtUv6jx5bXR4yS
         R/NkaiNhxwxOQ3FQ6CVHn/vexNiLZg3FIA0NZ+6hXXjYWvqsKCYC+Q6MEjwhXUkUA/3O
         d07Q==
X-Gm-Message-State: AOAM530totjid8A6OZaybG8YopkgnAje6Hi2c2eC+M3Z0stvh7zUpiMe
        4+ALzr9ItrFPFvgG0x6y/1uN+KiHY+Go0/MEsm0=
X-Google-Smtp-Source: ABdhPJxQGLyzRreLDCz8tx5KT3e9A6BWYpuqvB6Sq8lTHJ3/Xy8Dgs2b6x3ND5hHzgx6CToDt+0OdUmfFU9x7azTbU8=
X-Received: by 2002:aca:5f8b:: with SMTP id t133mr1662703oib.163.1621923624804;
 Mon, 24 May 2021 23:20:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210525223222.17636-1-yanjun.zhu@intel.com>
In-Reply-To: <20210525223222.17636-1-yanjun.zhu@intel.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Tue, 25 May 2021 14:20:13 +0800
Message-ID: <CAD=hENdRoYTuh=iJo1F2nPJpGfBQD6rVK6U+6b8OJfD3zV4vWw@mail.gmail.com>
Subject: Re: [PATCH 1/1] Update kernel headers
To:     Zhu Yanjun <yanjun.zhu@intel.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 25, 2021 at 2:07 PM Zhu Yanjun <yanjun.zhu@intel.com> wrote:
>
> From: Zhu Yanjun <zyjzyj2000@gmail.com>
>
> After the patches "RDMA/rxe: Implement memory windows", the kernel headers
> are changed. This causes about 17 errors and 1 failure when running
> "run_test.py" with rxe.
> This commit will fix these errors and failures.

This commit is for rdma-core.
https://github.com/linux-rdma/rdma-core.git

Zhu Yanjun

>
> Signed-off-by: Zhu Yanjun <zyjzyj2000@gmail.com>
> ---
>  kernel-headers/rdma/rdma_user_rxe.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/kernel-headers/rdma/rdma_user_rxe.h b/kernel-headers/rdma/rdma_user_rxe.h
> index 068433e2..90ea477f 100644
> --- a/kernel-headers/rdma/rdma_user_rxe.h
> +++ b/kernel-headers/rdma/rdma_user_rxe.h
> @@ -99,7 +99,17 @@ struct rxe_send_wr {
>                         __u32   remote_qkey;
>                         __u16   pkey_index;
>                 } ud;
> +               struct {
> +                       __aligned_u64   addr;
> +                       __aligned_u64   length;
> +                       __u32           mr_lkey;
> +                       __u32           mw_rkey;
> +                       __u32           rkey;
> +                       __u32           access;
> +                       __u32           flags;
> +               } mw;
>                 /* reg is only used by the kernel and is not part of the uapi */
> +#ifdef __KERNEL__
>                 struct {
>                         union {
>                                 struct ib_mr *mr;
> @@ -108,6 +118,7 @@ struct rxe_send_wr {
>                         __u32        key;
>                         __u32        access;
>                 } reg;
> +#endif
>         } wr;
>  };
>
> --
> 2.30.2
>
