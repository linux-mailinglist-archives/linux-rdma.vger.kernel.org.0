Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90AF4CB4DC
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Mar 2022 03:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbiCCC1G (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Mar 2022 21:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbiCCC1F (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Mar 2022 21:27:05 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8370F381A7
        for <linux-rdma@vger.kernel.org>; Wed,  2 Mar 2022 18:26:20 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id f37so5964472lfv.8
        for <linux-rdma@vger.kernel.org>; Wed, 02 Mar 2022 18:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sHBBVrV9EisE/p56YIJhwv9zOfVaMnpLfl9PrbsUiYc=;
        b=nJa0Uby3N7JAe/CSI7UWpwcKZKTFvB/v80FiHjj4a0t8OO5I6vAU8oRCiAgqvV6DN+
         kGOdcuJnPuAjsvbrju6m7xnl81vcGrtr4bo/Kkmz3aZJ3Qjy0X5NUHEZJQuyE8DxbOhc
         JCr2Wh0/BEV3FPCnHHF9DXQJl8BWLcbvX97LKMKPtb33m+myPeQBsrsPo6nGmT8pKmNl
         EjbzNG3cYVPJV76OOnymBLV56ekJ5kskYAaufLTNHdpk6W0sMcyPt8qpOOqvm3QqjhdJ
         GK+WZQoR9ADgYdOw/AYMYaVwxQ+qG+/jaJzNHYP+OIFbfYLPbT56p9jI31Pfge6ZxQhJ
         8hKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sHBBVrV9EisE/p56YIJhwv9zOfVaMnpLfl9PrbsUiYc=;
        b=7N1lzcNrhgpv959rrDunlLocUXSqNRQOX4A2ajT+sRHxlgpw4Zi1REPnmlC+WhXVDt
         xXqRZ5Ltd0sujApSr6dLNIFbmog7Eok/tynA+BA5l10/QvRakZi4haiZZH2Vj0jCY6tL
         CknREivh3RGq3Ye2WoxtfmdAjUSrxH6UMgJGHti4b3GRjCM5Jd+AH3eLR6bD0V2nLHly
         MBXwccNcWyZTsm3rbtnafigYKuueQSlgq8o9oFTjLhud75ZQri0sbQJtrSHa81mLN9Tk
         KQkOuWhxgXAG6Conp0UePPFFmyfmp5CjxJrO2htv7EMLtFKNsJa+voUs4T1GDRohJuZI
         MQmg==
X-Gm-Message-State: AOAM531j5MWBPrGR8NFn5v2fW1D+GBOYjpPW62vRypzYVNXuC14i35ns
        qrF6xzg2CjVB+fwro5wdSGkUzp3Zl6ufqrws+OEK3WCr
X-Google-Smtp-Source: ABdhPJzXO+frvyxQuuteYPGzMJeTlW9DL5KbD2zQX3q/bPA6vl2/ghRoBzXAY17QmbQsWfDTO5W0UwWd2xLv8mY/pww=
X-Received: by 2002:a05:6512:2291:b0:445:6ce3:4867 with SMTP id
 f17-20020a056512229100b004456ce34867mr20254185lfu.281.1646274378493; Wed, 02
 Mar 2022 18:26:18 -0800 (PST)
MIME-Version: 1.0
References: <20220302141054.2078616-1-cgxu519@mykernel.net>
In-Reply-To: <20220302141054.2078616-1-cgxu519@mykernel.net>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Thu, 3 Mar 2022 10:26:07 +0800
Message-ID: <CAD=hENdxVJGqPre1uPZmcfMdG+FOz5qg+1Yfr7E-FSd+vJVJ1w@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rxe: change payload type to u32 from int
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 2, 2022 at 10:11 PM Chengguang Xu <cgxu519@mykernel.net> wrote:
>
> The type of wqe length is u32 so change variable payload
> to type u32 to avoid overflow on large wqe length.
>
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>

Thanks.
Acked-by: Zhu Yanjun <zyjzyj2000@gmail.com>

Zhu Yanjun

> ---
>  drivers/infiniband/sw/rxe/rxe_req.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
> index 5eb89052dd66..e989ee3a2033 100644
> --- a/drivers/infiniband/sw/rxe/rxe_req.c
> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
> @@ -612,7 +612,7 @@ int rxe_requester(void *arg)
>         struct sk_buff *skb;
>         struct rxe_send_wqe *wqe;
>         enum rxe_hdr_mask mask;
> -       int payload;
> +       u32 payload;
>         int mtu;
>         int opcode;
>         int ret;
> --
> 2.27.0
>
>
