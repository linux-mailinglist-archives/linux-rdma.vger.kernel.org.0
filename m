Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51965479F03
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Dec 2021 04:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhLSDgm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 18 Dec 2021 22:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhLSDgl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 18 Dec 2021 22:36:41 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F01AC061574;
        Sat, 18 Dec 2021 19:36:41 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id 13so9902210ljj.11;
        Sat, 18 Dec 2021 19:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3kGEHreSVjXQ428XHg0tZ384oIkfv9rqOgOkg0cZgMs=;
        b=h4Pxv2jv96FdEs4m11IfmtOHX7I0TcUMr9NLq68Nx53iQPuh8wq8w/+itBEKd/qOfT
         CdwYdzQjrTp9AVwxI1UFTFmUN3AtaisYyRoVKxhqReKT1kvI+WZMA273vtYD6oSpbqO8
         Zic9LkAyvSFNrDeyxmCP02K9TtZ+ovaJvd+oApS4lkLiUfbY3bcf9I/TPVH8igbPjpbM
         +PjDkkA8WRfe4wb9QB+lf/KQldGELYK9nuu8BsF0A3Hh/VgnomogGr2GSDNUuetQu8l6
         qE79NVnNs1NetZrt4lWw8RCcUH2ls7uk4Afc75u6bNgSecJ+mIfkl+bBMO48nRc92R6t
         UZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3kGEHreSVjXQ428XHg0tZ384oIkfv9rqOgOkg0cZgMs=;
        b=r6HLEheucZ5W9lS48Tx3+91ecA4ESb0qDxomvR1m2c1HJ7HrBr0xdtquSbFPn3wnNV
         QUf6KA6zkBg/CcBC87+QVzvzSnhPbFmqEPqEYy6OJxdQeJNnt5PBeUVHHfzFG15iCWyu
         NXuwB7tcsVV7rwoAHBEu8XZIXEQn7107fiLA8pdwr/IInOGYAqv8HvFfDUbIkELgCvzy
         FQtV5RsKEDnNIWYEmfBiBjUCAQnZ9Pqy3Tkbb2jbT4hbsqUm53Wjb2bEGuKZbDtNifPh
         kItOmXS+wh6mwFkPkFfKiv3zlZZsliAcMx0VKi3AAV5xcogU0zMTesTozZLgKXy+U+13
         ZBAg==
X-Gm-Message-State: AOAM533PcGMM5uyHV68laNaZjvcuQXLqeECfJTDyRGej+RWua5atFzKm
        zOtud0movttheoUOkfLrCsMIJP78Nr+xcsm1PJUJ9XYG
X-Google-Smtp-Source: ABdhPJzz1vqsiybcw/WFdahKAM4jirVCO8kkUYX6LYnTrWeZ+xO8QzxVJ9CN8XXUN6ttDrfNIyU1MkEruBkToZp9V74=
X-Received: by 2002:a2e:a4d1:: with SMTP id p17mr8814354ljm.318.1639884999578;
 Sat, 18 Dec 2021 19:36:39 -0800 (PST)
MIME-Version: 1.0
References: <20211218112320.3558770-1-cgxu519@mykernel.net>
In-Reply-To: <20211218112320.3558770-1-cgxu519@mykernel.net>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Sun, 19 Dec 2021 11:36:28 +0800
Message-ID: <CAD=hENf67N-Fwf9DOs+n4NG92GiLb+WBKtnH7Mn5AJ0bUePzsA@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rxe: fix a typo in opcode name
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Dec 18, 2021 at 7:23 PM Chengguang Xu <cgxu519@mykernel.net> wrote:
>
> There is a redundant ']' in the name of opcode IB_OPCODE_RC_SEND_MIDDLE,
> so just fix it.
>
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>

Acked-by: Zhu Yanjun <zyjzyj2000@gmail.com>

Zhu Yanjun

> ---
>  drivers/infiniband/sw/rxe/rxe_opcode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_opcode.c b/drivers/infiniband/sw/rxe/rxe_opcode.c
> index 3ef5a10a6efd..47ebaac8f475 100644
> --- a/drivers/infiniband/sw/rxe/rxe_opcode.c
> +++ b/drivers/infiniband/sw/rxe/rxe_opcode.c
> @@ -117,7 +117,7 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
>                 }
>         },
>         [IB_OPCODE_RC_SEND_MIDDLE]              = {
> -               .name   = "IB_OPCODE_RC_SEND_MIDDLE]",
> +               .name   = "IB_OPCODE_RC_SEND_MIDDLE",
>                 .mask   = RXE_PAYLOAD_MASK | RXE_REQ_MASK | RXE_SEND_MASK
>                                 | RXE_MIDDLE_MASK,
>                 .length = RXE_BTH_BYTES,
> --
> 2.27.0
>
>
