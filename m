Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7770D191D76
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2020 00:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgCXXXu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Mar 2020 19:23:50 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41470 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbgCXXXu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Mar 2020 19:23:50 -0400
Received: by mail-qk1-f194.google.com with SMTP id q188so518584qke.8
        for <linux-rdma@vger.kernel.org>; Tue, 24 Mar 2020 16:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZrlGEqwnfo8eLXcvcn1eNCwteL7gBVD5QI6Fm+5H5og=;
        b=ltCKJLzmN9atuEmXNaqmIwJis74j3BY2dEbkI6EJWC7UL98FY9kjXnGSfg/M6YY/YU
         ayPehKokDmBpohwTMkHx6gncGcYzBj+oiPLxmEvu2/SBS67boQlP0KsmzNsnxcd7mpwa
         VC+DcWJusjRXJMLd019fgEkIPlw2b7Q279ITBiYMSSSdRsohplrGV6HV/XKCce3TPbNd
         S+Bax58qBTOYF4lI3K7q88V/gttgFlyIA6K06169XOf07g8rt5V4FI+9kRa4/4gKNgOB
         wCN5de/+BUS8OZf+x3wWx7SKvHKnjF/KPVaQcR6zE2cz0oFBUWd8PzfVTsU6+usekOVd
         /nKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZrlGEqwnfo8eLXcvcn1eNCwteL7gBVD5QI6Fm+5H5og=;
        b=FiRVUCGPToaSm7r6BucovQKY3HtTpr8A2rt4jTl3cPg2wGpaTA1Q8dz45rrkhF+n3o
         CINTTFqFXU6fiElw0WR6z5Ve9jDjaS+f/zhTKhslWEtAjaiKPHn6wo9vT2CEkGuNMvP/
         pDZq/XYsvxTWTd0YYEx/3wZ4xjyY3YN1SM3dz4ImQuLrpHV+1X4tdK1yBxQk0lQhRLVN
         Mxo9gpEUULl3v1Y55ekFCdHw8RnpnuB9ekJnRl6d89HbXCpEf+fCCIcb7QukA22+tYFn
         qe29z75yp85p3Kqklys1T36tepK2REyrfzCr/W9TRh2wKU3VYCxR6C6GQBH/J6zmQocA
         r3iw==
X-Gm-Message-State: ANhLgQ1N6EqWeVu188OoB8puLEZMT+2d32Ri7PwFbQsp51kanti8QAgl
        6L37JN76nTzQAd4iqsUG+Sdd5SQvCU/dDg==
X-Google-Smtp-Source: ADFU+vu4IEXTSMgY9VoY5i9lADMTnVpjCHzdQD8GOcxiznNP2MjXulTmU/P/ZWNxemZ8fPCTVSDVOg==
X-Received: by 2002:a37:9ecc:: with SMTP id h195mr332859qke.448.1585092228994;
        Tue, 24 Mar 2020 16:23:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id h11sm14237249qta.44.2020.03.24.16.23.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Mar 2020 16:23:48 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jGstf-0004Jr-Jj; Tue, 24 Mar 2020 20:23:47 -0300
Date:   Tue, 24 Mar 2020 20:23:47 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@mellanox.com>
Subject: Re: [PATCH rdma-next] IB/mlx5: Generally use the WC auto detection
 test result
Message-ID: <20200324232347.GA16554@ziepe.ca>
References: <20200318100323.46659-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318100323.46659-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 18, 2020 at 12:03:23PM +0200, Leon Romanovsky wrote:
> From: Yishai Hadas <yishaih@mellanox.com>
> 
> Now that we have direct and reliable detection of WC support by the
> system, use is broadly. The only case we have to worry about is when the
> WC autodetector cannot run.
> 
> For this fringe case generally assume that that WC is available, except
> in the well defined case of no PAT support on x86 which is tested by
> calling arch_can_pci_mmap_wc().
> 
> If WC is wrongly assumed to be available then it causes a small
> performance hit on paths in userspace that are tuned to the assumption
> that WC is available. There is no functional loss.
> 
> It is very unlikely that any platforms exist that lack WC and also care
> about the micro optimization of WC in the fringe case where
> autodetection does not work.
> 
> By removing the fairly bogus CONFIG tests this makes WC work broadly on
> all arches and all platforms.
> 
> Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
> Reviewed-by: Michael Guralnik <michaelgur@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx5/main.c | 16 ++++------------
>  drivers/infiniband/hw/mlx5/mem.c  |  2 +-
>  2 files changed, 5 insertions(+), 13 deletions(-)

Applied to for-next, thanks

> diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
> index 66cd417f5d09..05804e4ba292 100644
> --- a/drivers/infiniband/hw/mlx5/main.c
> +++ b/drivers/infiniband/hw/mlx5/main.c
> @@ -39,9 +39,6 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/slab.h>
>  #include <linux/bitmap.h>
> -#if defined(CONFIG_X86)
> -#include <asm/memtype.h>
> -#endif
>  #include <linux/sched.h>
>  #include <linux/sched/mm.h>
>  #include <linux/sched/task.h>
> @@ -2146,14 +2143,6 @@ static int uar_mmap(struct mlx5_ib_dev *dev, enum mlx5_ib_mmap_cmd cmd,
>  	switch (cmd) {
>  	case MLX5_IB_MMAP_WC_PAGE:
>  	case MLX5_IB_MMAP_ALLOC_WC:
> -/* Some architectures don't support WC memory */
> -#if defined(CONFIG_X86)
> -		if (!pat_enabled())
> -			return -EPERM;
> -#elif !(defined(CONFIG_PPC) || (defined(CONFIG_ARM) && defined(CONFIG_MMU)))
> -			return -EPERM;
> -#endif
> -	/* fall through */
>  	case MLX5_IB_MMAP_REGULAR_PAGE:
>  		/* For MLX5_IB_MMAP_REGULAR_PAGE do the best effort to get WC */
>  		prot = pgprot_writecombine(vma->vm_page_prot);
> @@ -2299,9 +2288,12 @@ static int mlx5_ib_mmap(struct ib_ucontext *ibcontext, struct vm_area_struct *vm
>  	command = get_command(vma->vm_pgoff);
>  	switch (command) {
>  	case MLX5_IB_MMAP_WC_PAGE:
> +	case MLX5_IB_MMAP_ALLOC_WC:
> +		if (!dev->wc_support)
> +			return -EPERM;
> +		/* fall through */

This is apparently supposed to be spelled as

    fallthrough;

Now. I fixed it

Jason
