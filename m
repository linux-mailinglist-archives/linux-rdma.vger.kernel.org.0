Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03BFD3271B5
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Feb 2021 10:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbhB1JYi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 28 Feb 2021 04:24:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:43786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230075AbhB1JYh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 28 Feb 2021 04:24:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8487164D99;
        Sun, 28 Feb 2021 09:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614504237;
        bh=K2JDpc7EhaBDnGCa1SHO84oOEesXXBSaulPWIzAy32Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=avk8JKXPReInenU8MsphKfb8fwcr61zbYEPnIifC5I27QqXu61i7iemgNsZGtY0yH
         T0Js6Ea82R0MdFz6oj7RMwMwMGIm+lAWpgdvAwsNdi3pHO53PgTN1B7fFJM5KqP27G
         sExuLnNcjX9C7pEEbVE7rhT1eM4TIlRktFUtUTlbq0FttkI74+USSa32h48nYiJpUA
         W90hu1PCg/riUkBhS1XTUA9eWkqvJDjB71rsmsBgM2PN6yohTLY+BLoEenVUu5aY/K
         bFGLNoFZWby25xB5AGE145xIcEkK2SZNdIAhNKlhxizZmE01+9gamIhDWTQvUCnbQ4
         2s7++fnnw9zmQ==
Date:   Sun, 28 Feb 2021 11:23:53 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Yi Zhang <yi.zhang@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: modprobe rdma_rxe failed when ipv6 disabled
Message-ID: <YDthKWQa9+2BhvHd@unreal>
References: <1688338252.14107275.1614354083739.JavaMail.zimbra@redhat.com>
 <1010828157.14107334.1614354448762.JavaMail.zimbra@redhat.com>
 <CAD=hENfyNMc-wQL5JAX+T3GGaj75mMy8JTpuUrpuqOPY0Gcgfw@mail.gmail.com>
 <b153b7e2-e62b-1289-3566-c1184e224ed8@redhat.com>
 <CAD=hENeotEgBxi7WFmUVg8asxPduJaVc3UR+YSV3DxdX5v0=2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=hENeotEgBxi7WFmUVg8asxPduJaVc3UR+YSV3DxdX5v0=2w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Feb 27, 2021 at 11:32:35PM +0800, Zhu Yanjun wrote:
> From 9dcdd09f3ca3cf222b563866acd91d18bc4b93d4 Mon Sep 17 00:00:00 2001
> From: Zhu Yanjun <zyjzyj2000@gmail.com>
> Date: Sat, 27 Feb 2021 23:01:15 +0000
> Subject: [PATCH 1/1] RDMA/rxe: Disable ipv6 features when ipv6.disable set in
>  cmdline
>
> When ipv6.disable=1 is set in cmdline, ipv6 is actually disabled
> in the stack. As such, the operations of ipv6 in RXE will fail.
> So ipv6 features in RXE should also be disabled in RXE.
>
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Signed-off-by: Zhu Yanjun <zyjzyj2000@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_net.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c
> b/drivers/infiniband/sw/rxe/rxe_net.c
> index 0701bd1ffd1a..6ef092cb575e 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -72,6 +72,11 @@ static struct dst_entry *rxe_find_route6(struct
> net_device *ndev,
>         struct dst_entry *ndst;
>         struct flowi6 fl6 = { { 0 } };
>
> +       if (!ipv6_mod_enabled()) {
> +               pr_info("IPv6 is disabled by ipv6.disable=1 in cmdline");
> +               return NULL;
> +       }
> +


Except the info message, the change looks valid.

pr_info("IPv6 is disabled by ipv6.disable=1 in cmdline");
->
pr_info("IPv6 is disabled");

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
