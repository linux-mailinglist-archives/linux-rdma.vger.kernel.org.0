Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4A126A3C0
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Sep 2020 12:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgIOK7i (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Sep 2020 06:59:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:51800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbgIOK7h (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 15 Sep 2020 06:59:37 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4103A206DC;
        Tue, 15 Sep 2020 10:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600167568;
        bh=zNET5dRCkhuJrz/6kd8w9Ne6fthI7xID0DnCWQFJUo4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qwCQo/uPyhuwHTbDHiSz9tMi25wgehruQvsUgCL4CBocL5x0AqySv4IhXrPqdtjA+
         7MXDVxt3FziJaPvWwe2gZO6mMzrJA1t4BGCj87icpX5cd4fkUgCl6lmDQ92hi7NQKj
         5YTVJctiG9PhUgv57PTEsjWTuQt64+1vOftOD+qk=
Date:   Tue, 15 Sep 2020 13:59:20 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Necip Fazil Yildiran <fazilyildiran@gmail.com>
Cc:     dledford@redhat.com, jgg@mellanox.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, paul@pgazz.com, jeho@cs.utexas.edu
Subject: Re: [PATCH] IB/rxe: fix kconfig dependency warning for RDMA_RXE
Message-ID: <20200915105920.GA486552@unreal>
References: <20200915101559.33292-1-fazilyildiran@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915101559.33292-1-fazilyildiran@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 15, 2020 at 01:16:00PM +0300, Necip Fazil Yildiran wrote:
> When RDMA_RXE is enabled and CRYPTO is disabled, it results in the
> following Kbuild warning:
>
> WARNING: unmet direct dependencies detected for CRYPTO_CRC32
>   Depends on [n]: CRYPTO [=n]
>   Selected by [y]:
>   - RDMA_RXE [=y] && (INFINIBAND_USER_ACCESS [=y] || !INFINIBAND_USER_ACCESS [=y]) && INET [=y] && PCI [=y] && INFINIBAND [=y] && (!64BIT || ARCH_DMA_ADDR_T_64BIT [=n])
>
> The reason is that RDMA_RXE selects CRYPTO_CRC32 without depending on or
> selecting CRYPTO while CRYPTO_CRC32 is subordinate to CRYPTO.

It is not RXE specific issue and almost all users of CRYPTO_* configs
don't select CRYPTO.

There are two possible solutions.
1. Fix crypto/Kconfig to enable CRYPTO.
2. Change "select CRYPTO_CRC32" to be "depends on CRYPTO_CRC32".

Thanks

>
> Honor the kconfig menu hierarchy to remove kconfig dependency warnings.
>
> Fixes: 0812ed132178 ("IB/rxe: Change RDMA_RXE kconfig to use select")
> Signed-off-by: Necip Fazil Yildiran <fazilyildiran@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/infiniband/sw/rxe/Kconfig b/drivers/infiniband/sw/rxe/Kconfig
> index a0c6c7dfc181..e1f52710edfc 100644
> --- a/drivers/infiniband/sw/rxe/Kconfig
> +++ b/drivers/infiniband/sw/rxe/Kconfig
> @@ -4,6 +4,7 @@ config RDMA_RXE
>  	depends on INET && PCI && INFINIBAND
>  	depends on !64BIT || ARCH_DMA_ADDR_T_64BIT
>  	select NET_UDP_TUNNEL
> +	select CRYPTO
>  	select CRYPTO_CRC32
>  	select DMA_VIRT_OPS
>  	help
> --
> 2.25.1
>
