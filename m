Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B4C6EC4B5
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Apr 2023 07:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjDXFSq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Apr 2023 01:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjDXFSm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Apr 2023 01:18:42 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589282688
        for <linux-rdma@vger.kernel.org>; Sun, 23 Apr 2023 22:18:40 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-506bdf29712so29686916a12.0
        for <linux-rdma@vger.kernel.org>; Sun, 23 Apr 2023 22:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1682313519; x=1684905519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sMme/ObWE1XqtqiMZ6pEeHuCDa0x+FmPGqWx4VJyi4Y=;
        b=JspeccNTbD/aZwbTWRtpKIpWvGw3H/ycf7IxvjiRK/XeTzPfJoUWsl9ROqnQfgnkzw
         pSRSbm/CkVzDKLzYwjlzS0HIkTCxyoP2uEr3P7FHbhEab9QvtKMf1XaXQH5yWmNKs8dX
         0Vl4tb9w36GjJORSXry5+u08TGxCW/VpuYJzEMizyk3JaMuj9X/8n4jX5vF+cBuDdzdS
         WKAAW8o/G1WlUueOJzHKOJqY8H61nE4T8FJMtdejTeHduMl7DdrcHwLnUSpNrTyPEEqN
         KDoLQmFkKC3kKHISc5WRN62BMCHfcX6vLuXzLkIok1wpAYlvI62bUqz+oqA2LX++PDrI
         fczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682313519; x=1684905519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sMme/ObWE1XqtqiMZ6pEeHuCDa0x+FmPGqWx4VJyi4Y=;
        b=Fna+y1nFhPaor5ivC6Xd0VpfwwMy3y8T2g8LirVHyTaTc+6Od9ifjcJhRIk3Kuyjc6
         lnK5RJ7JrVcsFRoxWcPqy6euD9Y4fBl2JCt0yncK/YRO8u97aMZDusVUWlbxCz7+2hcf
         uzvIbngb+xLdySl8XLDJXeM3Z217KKeXOKZxohTPcMUI9a8AjGlXHU5SDUXFAWDtNDIU
         0x+fnXKNyP5AiDsqJEAoJp0VB8/Y959aYMPwAvoMWhD4Wu32OjfiuBW5kOC2TI1SAcBa
         +Y7Y0zo+H2VWpRsXMk/Iq/xcXwZ82xld6IgFThODbDd+0/weyQnSPKjSP3vsyGbwwvrC
         CXyw==
X-Gm-Message-State: AAQBX9c6lfAuR+GMkZ68KAMVi36wJy2smzYjWWwqA+YQCb0CUrksD0eZ
        gvaDdoXA5hYna99M7w78W5fyNcS579pPF+9X85WUqA==
X-Google-Smtp-Source: AKy350Y7qYKAEEiTeRN1tNLajDMCA8RXEmcAKIflt12S8OLivh9JMSQEbHF+QBX0Fg9Y08RyCx6KqzDWsuUepC7hu6k=
X-Received: by 2002:a05:6402:14d8:b0:504:88fb:8841 with SMTP id
 f24-20020a05640214d800b0050488fb8841mr10312980edx.21.1682313518856; Sun, 23
 Apr 2023 22:18:38 -0700 (PDT)
MIME-Version: 1.0
References: <1682213212-2-1-git-send-email-lizhijian@fujitsu.com> <1682213212-2-3-git-send-email-lizhijian@fujitsu.com>
In-Reply-To: <1682213212-2-3-git-send-email-lizhijian@fujitsu.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Mon, 24 Apr 2023 07:18:27 +0200
Message-ID: <CAMGffE=TPTi6+Lr6F2-Xh=Q1gndDDY14hRo9LhNbDb43Y8VxBA@mail.gmail.com>
Subject: Re: [PATCH for-next v2 2/3] RDMA/rtrs: Fix the last iu->buf leak in
 err path
To:     Li Zhijian <lizhijian@fujitsu.com>
Cc:     haris.iqbal@ionos.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org, guoqing.jiang@linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Apr 23, 2023 at 3:27=E2=80=AFAM Li Zhijian <lizhijian@fujitsu.com> =
wrote:
>
> The last iu->buf will leak if ib_dma_mapping_error() fails.
>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Yes, as guoqing suggested, please add the Fixes tag.
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
> V2: new patch to address memory leaking
> ---
>  drivers/infiniband/ulp/rtrs/rtrs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/=
rtrs/rtrs.c
> index 4bf9d868cc52..3696f367ff51 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs.c
> @@ -37,8 +37,10 @@ struct rtrs_iu *rtrs_iu_alloc(u32 iu_num, size_t size,=
 gfp_t gfp_mask,
>                         goto err;
>
>                 iu->dma_addr =3D ib_dma_map_single(dma_dev, iu->buf, size=
, dir);
> -               if (ib_dma_mapping_error(dma_dev, iu->dma_addr))
> +               if (ib_dma_mapping_error(dma_dev, iu->dma_addr)) {
> +                       kfree(iu->buf);
>                         goto err;
> +               }
>
>                 iu->cqe.done  =3D done;
>                 iu->size      =3D size;
> --
> 2.29.2
>
