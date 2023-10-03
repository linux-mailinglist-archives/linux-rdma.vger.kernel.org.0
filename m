Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3017B74D6
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Oct 2023 01:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235144AbjJCX0x (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Oct 2023 19:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235041AbjJCX0w (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Oct 2023 19:26:52 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB7FAC
        for <linux-rdma@vger.kernel.org>; Tue,  3 Oct 2023 16:26:49 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9a9f139cd94so252299766b.2
        for <linux-rdma@vger.kernel.org>; Tue, 03 Oct 2023 16:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696375608; x=1696980408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZkOmFORPNdegsvUzletDdGNQTS/35DzAQHoVxYp5MXg=;
        b=g8BdXQY2ymaa+Ax1z7Lecj0GB4zjvxggDOmeVtM/kQn/8YBjYIz0I07RM51X9bcp2x
         MZvnbvAQz6x5X9OlSeEJe9ec6+OQyqFNPktZvPfgDVieDIfOjLZAV+mWjAD3xSza3tnK
         d5q20wEOwJLmLUMru5coi3WCU1T5UgAoIk7GyDWXMkwu5JkkzwDoKMufZILEweUSBgn5
         g26ShFblNyVG1xMHe1WgXzU8wXr3h7yi1UafE9HwEB/tbu9QcD2lrDEEzxpMidIFQsrc
         JIuRF4cGFXwlXPUGx4vTsZSRzb5ac7kwQBCm+svodMikpQx7VV0DnBG3rHGGFr+vSlxp
         FyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696375608; x=1696980408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZkOmFORPNdegsvUzletDdGNQTS/35DzAQHoVxYp5MXg=;
        b=rc+WBSww5ZYlyQ27yEqpfENcGBHqfZVxZ73cjYY67ZAajdJXNvJBpzZY+n8gLsdthu
         wFfERvnnwwiutcufqsSAaOdqTcVLA74AMEJjRWl09yOJIIYcSfdCiuP5YkcCvdAgY9kq
         BMiWEIbJoQQ6v9cNGUeT1+uixXKaYJAM9HVaOOF6w1PkbYTj1uxeF/wdxV3If9u5yh3a
         o1Ua0P0H556INe4p+eqLwCNmfFFbQb4rTqjaxFztIO82HkzYZzX/DDmBnhvfSgyvoiWF
         mPQmWebgYT1RMaXIYdFsRA/yEF150hsAEo2XFUbu2QqA5Tn3YndsgBAbTCvfx9kehjKs
         9vmg==
X-Gm-Message-State: AOJu0YxtHo6LnMjlDM4nZQoMU0Ekmaq/0aXpNKGnNAkZcWzz2Tl3qduj
        ZEP7Jey5eD3HPWLlP4HVD6PKg3HvtdPykpfX7HAbsA==
X-Google-Smtp-Source: AGHT+IF1d5AjAJYgdKzsBfMm7uGg6I8MvuOFlaYXOCXzffRCV1Xz22bcMhb3NFM3XTYkvVVirGgXazVoYcInwB6GX3o=
X-Received: by 2002:a17:906:da8c:b0:9a2:139:f45d with SMTP id
 xh12-20020a170906da8c00b009a20139f45dmr657784ejb.43.1696375607793; Tue, 03
 Oct 2023 16:26:47 -0700 (PDT)
MIME-Version: 1.0
References: <20231003231730.work.166-kees@kernel.org>
In-Reply-To: <20231003231730.work.166-kees@kernel.org>
From:   Justin Stitt <justinstitt@google.com>
Date:   Tue, 3 Oct 2023 16:26:35 -0700
Message-ID: <CAFhGd8qFcusVNabygT2PuuzqaeFH27BJP9BfWiF7Keo-j2RVQg@mail.gmail.com>
Subject: Re: [PATCH] net/mlx5: Annotate struct mlx5_flow_handle with __counted_by
To:     Kees Cook <keescook@chromium.org>
Cc:     Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 3, 2023 at 4:17=E2=80=AFPM Kees Cook <keescook@chromium.org> wr=
ote:
>
> Prepare for the coming implementation by GCC and Clang of the __counted_b=
y
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
>
> As found with Coccinelle[1], add __counted_by for struct mlx5_flow_handle=
.
>
> Cc: Saeed Mahameed <saeedm@nvidia.com>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> Cc: linux-rdma@vger.kernel.org
> Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples=
/counted_by.cocci [1]
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/fs_core.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h b/drivers/=
net/ethernet/mellanox/mlx5/core/fs_core.h
> index 4aed1768b85f..78eb6b7097e1 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
> @@ -181,7 +181,7 @@ struct mlx5_flow_rule {
>
>  struct mlx5_flow_handle {
>         int num_rules;
> -       struct mlx5_flow_rule *rule[];
> +       struct mlx5_flow_rule *rule[] __counted_by(num_rules);
>  };

Great patch!

handle->num_rules is properly assigned to before handle->rule
has any accesses.

        handle =3D alloc_handle((dest_num) ? dest_num : 1);

then

        static struct mlx5_flow_handle *alloc_handle(int num_rules) {
                ...
               handle->num_rules =3D num_rules;

then

        handle->rule[i] =3D rule;


Reviewed-by: Justin Stitt <justinstitt@google.com>
>
>  /* Type of children is mlx5_flow_group */
> --
> 2.34.1
>
>
Thanks
Justin
