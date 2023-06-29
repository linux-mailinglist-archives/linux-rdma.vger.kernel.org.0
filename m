Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B377426A9
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jun 2023 14:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjF2Mmn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Jun 2023 08:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjF2Mmm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Jun 2023 08:42:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303A01FD8
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jun 2023 05:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688042516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kL/IY7VdJ1Tifalq4nK/Jdpl7gvWGL1HinFoqJ6Dr30=;
        b=VN9GewfxVX+jGI7gWcwSJTaiR025QQq+aPC0mNUU/zNwr9h/zqY3wU9viQa+ZL3zI1qoHj
        cNnVFT5uZvHkSeAEBQO2d8Lg+SaXi/fSRmTnVTx1skC94cLbEM5V0gy74VLEW4hygSHHf9
        rCU43bAo+BEJSba5wW5/m5GJ4nujbiQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-JyrHWYn0MvGNueuBUkVA7w-1; Thu, 29 Jun 2023 08:41:55 -0400
X-MC-Unique: JyrHWYn0MvGNueuBUkVA7w-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-26314c2bdb8so328871a91.1
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jun 2023 05:41:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688042514; x=1690634514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kL/IY7VdJ1Tifalq4nK/Jdpl7gvWGL1HinFoqJ6Dr30=;
        b=G44o4zXnHr5HPb9UdYxwzOKr3EspUoC0l9SGJs9ZkJn/W9hZtsuY8Z4AqRlJr8+71A
         ftVe9qIgAOdqA12F+xDm+0hPl+nizAZqIGXtBCBUwqICrpDnOg5Oj+9qT9brExYP4ewc
         G0d/QPpz1iOyBrtlu21Vw6VQKBGRgL/iwXeDCBO6l52iAJ5SkLdZecbBrDLfAiZKx2xO
         jsYj+FqwKZKj3dEzD+Izgi8zbkjI7ozKIP8m2Ws7gD6t5ZMkOATdKkqecgLHMNqrrhz4
         G8u/4vqKLKJLZZHEXO6wXTFAGdpD+3VLwue/MZPsx2OHFXMqYCSha9+rogI6f2yp2rHX
         PY7g==
X-Gm-Message-State: AC+VfDyqUIkSGVr8a6xK+9u1vTo7HwXYJwXoOrILP1FDAfooxczxFrVO
        tUQ9HOl8iiDLpAD9hv2ZWoK97cvbGF6DPk9AmXjhb+FGnbHbIE0vjzgaI1hDdLzmbYeKzICjqhZ
        UXfhLEZrOqfpbZTfrqrL742nAN46AI/22m63K8ZMBABmbRA==
X-Received: by 2002:a17:90a:1cc:b0:263:3cb7:753c with SMTP id 12-20020a17090a01cc00b002633cb7753cmr3726240pjd.1.1688042513738;
        Thu, 29 Jun 2023 05:41:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4DP1c48LJBQKnsqBD85yWEJrtejMDZL87RnVV6I53sF70DS8YqzS0oE3b5+cPZNKv2+evaFZaY+eUgVX6k6UU=
X-Received: by 2002:a17:90a:1cc:b0:263:3cb7:753c with SMTP id
 12-20020a17090a01cc00b002633cb7753cmr3726228pjd.1.1688042513361; Thu, 29 Jun
 2023 05:41:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230609153147.667674-1-neelx@redhat.com> <20230613131931.738436-1-neelx@redhat.com>
In-Reply-To: <20230613131931.738436-1-neelx@redhat.com>
From:   Daniel Vacek <neelx@redhat.com>
Date:   Thu, 29 Jun 2023 14:41:16 +0200
Message-ID: <CACjP9X9T_HbR5Up4zx6xUJ3tE=HzXGE3WtRiRZNDES3f-1ou1w@mail.gmail.com>
Subject: Re: [PATCH v2] verbs: fix compilation warning with C++20
To:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Rogerio Moraes <rogerio@cadence.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Bump.

Was this forgotten or overlooked?

--nX

On Tue, Jun 13, 2023 at 3:20=E2=80=AFPM Daniel Vacek <neelx@redhat.com> wro=
te:
>
> Our customer reported the below warning whe using Clang v16.0.4 and C++20=
,
> on a code that includes the header "/usr/include/infiniband/verbs.h":
>
> error: bitwise operation between different enumeration types ('ibv_access=
_flags' and
> 'ib_uverbs_access_flags') is deprecated [-Werror,-Wdeprecated-enum-enum-c=
onversion]
>                 mem->mr =3D ibv_reg_mr(dev->pd, (void*)start, len, IBV_AC=
CESS_LOCAL_WRITE);
>                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~
> /usr/include/infiniband/verbs.h:2514:19: note: expanded from macro 'ibv_r=
eg_mr'
>                              ((access) & IBV_ACCESS_OPTIONAL_RANGE) =3D=
=3D 0))
>                               ~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~
> 1 error generated.
>
> According to the article "Clang 11 warning: Bitwise operation between dif=
ferent
> enumeration types is deprecated":
>
> C++20's P1120R0 deprecated bitwise operations between different enums. Su=
ch code is
> likely to become ill-formed in C++23. Clang 11 warns about such cases. It=
 should be fixed.
>
> Reported-by: Rogerio Moraes <rogerio@cadence.com>
> Signed-off-by: Daniel Vacek <neelx@redhat.com>
> ---
>  libibverbs/verbs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libibverbs/verbs.h b/libibverbs/verbs.h
> index 03a7a2a7..ed9aed21 100644
> --- a/libibverbs/verbs.h
> +++ b/libibverbs/verbs.h
> @@ -2590,7 +2590,7 @@ __ibv_reg_mr(struct ibv_pd *pd, void *addr, size_t =
length, unsigned int access,
>  #define ibv_reg_mr(pd, addr, length, access)                            =
       \
>         __ibv_reg_mr(pd, addr, length, access,                           =
      \
>                      __builtin_constant_p(                               =
      \
> -                            ((access) & IBV_ACCESS_OPTIONAL_RANGE) =3D=
=3D 0))
> +                            ((int)(access) & IBV_ACCESS_OPTIONAL_RANGE) =
=3D=3D 0))
>
>  /**
>   * ibv_reg_mr_iova - Register a memory region with a virtual offset
> --
> 2.40.1
>

