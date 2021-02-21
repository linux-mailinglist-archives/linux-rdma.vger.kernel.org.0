Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 687203208FB
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Feb 2021 07:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbhBUGtD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 Feb 2021 01:49:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:49562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229634AbhBUGtD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 21 Feb 2021 01:49:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DE61664EF5;
        Sun, 21 Feb 2021 06:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613890102;
        bh=vbvE9zVTZqeRweigQYDIRO3Go9QQGsXwIwwEYb0BfE0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S6KJfsY/VJ1KweiimDubVsfxZJ5xzRB7HjwHm9EQ5BzCm2L7EBLZcbVMGnChjfgND
         gwKc+8s7n0M6tVizS5oK/ASPDegU+0mXhSQFVDRwip5oyNf7rKx/7BzZ21TM3iC/Kv
         3eZH6LLQb5A/7W+z9fulEBq5vG9uxTHsSlMjj5Js9e0ybUiipPp5WFjiHqRlT2+/8W
         DzH7RIN7VFHrPtg5iUjN3XQy6beOrVyNmo01gtznTw9ulbUi1oDtCxMzlrjjNiJsYd
         EvyKV40C9nTF+rMiNeBHIztpaovqPuyQT8QhDqiBGInrqnGI7y+0rj02jiY0sH5+E3
         sakyGVyjeMzbg==
Date:   Sun, 21 Feb 2021 08:48:19 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Julian Braha <julianbraha@gmail.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: infiniband: sw: rxe: fix kconfig dependency on
 CRYPTO
Message-ID: <YDICM3SwwGZfE+Sg@unreal>
References: <21525878.NYvzQUHefP@ubuntu-mate-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21525878.NYvzQUHefP@ubuntu-mate-laptop>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 19, 2021 at 06:32:26PM -0500, Julian Braha wrote:
> commit 6e61907779ba99af785f5b2397a84077c289888a
> Author: Julian Braha <julianbraha@gmail.com>
> Date:   Fri Feb 19 18:20:57 2021 -0500
>
>     drivers: infiniband: sw: rxe: fix kconfig dependency on CRYPTO
>
>     When RDMA_RXE is enabled and CRYPTO is disabled,
>     Kbuild gives the following warning:
>
>     WARNING: unmet direct dependencies detected for CRYPTO_CRC32
>       Depends on [n]: CRYPTO [=n]
>       Selected by [y]:
>       - RDMA_RXE [=y] && (INFINIBAND_USER_ACCESS [=y] || !INFINIBAND_USER_ACCESS [=y]) && INET [=y] && PCI [=y] && INFINIBAND [=y] && INFINIBAND_VIRT_DMA [=y]
>
>     This is because RDMA_RXE selects CRYPTO_CRC32,
>     without depending on or selecting CRYPTO, despite that config option
>     being subordinate to CRYPTO.
>
>     Signed-off-by: Julian Braha <julianbraha@gmail.com>

Please use git sent-email to send patches and please fix crypto Kconfig
to enable CRYPTO if CRYPTO_* selected.

It is a little bit awkward to request all users of CRYPTO_* to request
select CRYPTO too.

Thanks

>
> diff --git a/drivers/infiniband/sw/rxe/Kconfig b/drivers/infiniband/sw/rxe/Kconfig
> index 452149066792..06b8dc5093f7 100644
> --- a/drivers/infiniband/sw/rxe/Kconfig
> +++ b/drivers/infiniband/sw/rxe/Kconfig
> @@ -4,6 +4,7 @@ config RDMA_RXE
>         depends on INET && PCI && INFINIBAND
>         depends on INFINIBAND_VIRT_DMA
>         select NET_UDP_TUNNEL
> +      select CRYPTO
>         select CRYPTO_CRC32
>         help
>         This driver implements the InfiniBand RDMA transport over
>
>
>
