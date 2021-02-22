Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6F0320F7D
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Feb 2021 03:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbhBVCkM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 Feb 2021 21:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbhBVCkM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 21 Feb 2021 21:40:12 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C095DC061786;
        Sun, 21 Feb 2021 18:39:31 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id w1so12607967oic.0;
        Sun, 21 Feb 2021 18:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=solsyygeRIFD8kx12bO5ONpOL1PtMojzvbkImwwoet8=;
        b=g3UeQy1rhYnR/uoi5A00kzA4QXhd2xORkWju0oP55eVJl4u0Q4xQyxYFGHzPn8rAcp
         1VMQcnlUaUco6Nk5OMKfNG3ygIs2B+70qKo/4PP0oQ46jc/HFfLCUqjQ+M+vqWZr0Uat
         1cuMWHTb29Ev109Yrbxaawx4BOmZo3/ydAIgnuyzii1HfrKQBKi3Hn3xzSRGn/KLWEop
         oavIMOOMoIkA/PEk9lrs3fa6Je9LvEWQXL7mK14Sx2gc0ER1lRQS/Mk3yTrOwYy2F5g3
         5vF2PDAneQvbkxqmRMbMjrZJsUC8xs0HCGJAQ+mk9M3EQmOhatFmCcBtc7jqlfMDqRly
         l9iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=solsyygeRIFD8kx12bO5ONpOL1PtMojzvbkImwwoet8=;
        b=Ihe/4gsCV/iEVwKjzs02L3R53ZBnsn4NleIkofgQ+BdjCQT+ODyqKpXIEcmgTsiCPi
         QKuwGKaMgNpqz1jw4MmA02FAgSXfNLzB0My6er01r6hN5XJhPUpebHUpmN8n4tiP5hFn
         RtH4Yc8M8LDUVG2FFOgIlHLVRYXNPLclo159/AQkO9+HUK0FaNTCOna1hn3/iyfRVa9y
         5DS07kIKeDtWN26Au2Vlx2x9SDaVHkSFADl4nZou9qlCcv8z+jPz1mPEjdPPpAL1bHkN
         36HJY/3/hH62eJhUx9s3RsalebNDm1rTgwEj91YYeok5NINxPMfNJ6KbchfcpRdIhzaK
         0oZg==
X-Gm-Message-State: AOAM530S9CW2T8q3B6wxfWT0OUZGq3cCtUbWivEEMN0gR9nfecCOpFsI
        epMU+u4UblRK5fR4XjL+SPKP+y97LwDSnTNJEs0=
X-Google-Smtp-Source: ABdhPJwZzzXM4E3wrdvoKJLeriqszSmrQhMjSAzIv9kNAqzeUdx4SK2leqX/c0F2WGZAMt096oYdo0lAL05olPcPHsA=
X-Received: by 2002:aca:3906:: with SMTP id g6mr14334731oia.169.1613961571271;
 Sun, 21 Feb 2021 18:39:31 -0800 (PST)
MIME-Version: 1.0
References: <21525878.NYvzQUHefP@ubuntu-mate-laptop> <YDICM3SwwGZfE+Sg@unreal>
In-Reply-To: <YDICM3SwwGZfE+Sg@unreal>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Mon, 22 Feb 2021 10:39:20 +0800
Message-ID: <CAD=hENeCXGtKrXxLof=DEZjxpKyYBFS80pAX20nnJBuP_s-GBA@mail.gmail.com>
Subject: Re: [PATCH] drivers: infiniband: sw: rxe: fix kconfig dependency on CRYPTO
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Julian Braha <julianbraha@gmail.com>,
        Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Feb 21, 2021 at 2:49 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Fri, Feb 19, 2021 at 06:32:26PM -0500, Julian Braha wrote:
> > commit 6e61907779ba99af785f5b2397a84077c289888a
> > Author: Julian Braha <julianbraha@gmail.com>
> > Date:   Fri Feb 19 18:20:57 2021 -0500
> >
> >     drivers: infiniband: sw: rxe: fix kconfig dependency on CRYPTO
> >
> >     When RDMA_RXE is enabled and CRYPTO is disabled,
> >     Kbuild gives the following warning:
> >
> >     WARNING: unmet direct dependencies detected for CRYPTO_CRC32
> >       Depends on [n]: CRYPTO [=n]
> >       Selected by [y]:
> >       - RDMA_RXE [=y] && (INFINIBAND_USER_ACCESS [=y] || !INFINIBAND_USER_ACCESS [=y]) && INET [=y] && PCI [=y] && INFINIBAND [=y] && INFINIBAND_VIRT_DMA [=y]
> >
> >     This is because RDMA_RXE selects CRYPTO_CRC32,
> >     without depending on or selecting CRYPTO, despite that config option
> >     being subordinate to CRYPTO.
> >
> >     Signed-off-by: Julian Braha <julianbraha@gmail.com>
>
> Please use git sent-email to send patches and please fix crypto Kconfig
> to enable CRYPTO if CRYPTO_* selected.
>
> It is a little bit awkward to request all users of CRYPTO_* to request
> select CRYPTO too.

The same issue and similar patch is in this link:

https://patchwork.kernel.org/project/linux-rdma/patch/20200915101559.33292-1-fazilyildiran@gmail.com/#23615747

Zhu Yanjun

>
> Thanks
>
> >
> > diff --git a/drivers/infiniband/sw/rxe/Kconfig b/drivers/infiniband/sw/rxe/Kconfig
> > index 452149066792..06b8dc5093f7 100644
> > --- a/drivers/infiniband/sw/rxe/Kconfig
> > +++ b/drivers/infiniband/sw/rxe/Kconfig
> > @@ -4,6 +4,7 @@ config RDMA_RXE
> >         depends on INET && PCI && INFINIBAND
> >         depends on INFINIBAND_VIRT_DMA
> >         select NET_UDP_TUNNEL
> > +      select CRYPTO
> >         select CRYPTO_CRC32
> >         help
> >         This driver implements the InfiniBand RDMA transport over
> >
> >
> >
