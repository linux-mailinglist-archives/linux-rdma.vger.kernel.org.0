Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3E52765D
	for <lists+linux-rdma@lfdr.de>; Thu, 23 May 2019 08:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725814AbfEWG6F (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 May 2019 02:58:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:35928 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725806AbfEWG6F (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 23 May 2019 02:58:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E1920B12B;
        Thu, 23 May 2019 06:58:03 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 5CD76E00A9; Thu, 23 May 2019 08:58:03 +0200 (CEST)
Date:   Thu, 23 May 2019 08:58:03 +0200
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] RDMA/mlx5: Use DIV_ROUND_UP_ULL macro to allow 32 bit to
 build
Message-ID: <20190523065803.GB30439@unicorn.suse.cz>
References: <20190522145450.25ff483d@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522145450.25ff483d@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 22, 2019 at 02:54:50PM -0400, Steven Rostedt wrote:
> 
> From: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> When testing 32 bit x86, my build failed with:
> 
>   ERROR: "__udivdi3" [drivers/infiniband/hw/mlx5/mlx5_ib.ko] undefined!
> 
> It appears that a few non-ULL roundup() calls were made, which uses a
> normal division against a 64 bit number. This is fine for x86_64, but
> on 32 bit x86, it causes the compiler to look for a helper function
> __udivdi3, which we do not have in the kernel, and thus fails to build.
> 
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
...
> diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
> index abac70ad5c7c..40d4c5f7ea43 100644
> --- a/drivers/infiniband/hw/mlx5/main.c
> +++ b/drivers/infiniband/hw/mlx5/main.c
> @@ -2344,7 +2344,7 @@ static int handle_alloc_dm_sw_icm(struct ib_ucontext *ctx,
>  	/* Allocation size must a multiple of the basic block size
>  	 * and a power of 2.
>  	 */
> -	act_size = roundup(attr->length, MLX5_SW_ICM_BLOCK_SIZE(dm_db->dev));
> +	act_size = DIV_ROUND_UP_ULL(attr->length, MLX5_SW_ICM_BLOCK_SIZE(dm_db->dev));
>  	act_size = roundup_pow_of_two(act_size);
>  
>  	dm->size = act_size;

This seems wrong: roundup() rounds up to a multiple of second argument
but DIV_ROUND_UP_ULL() would divide with rounding up.

Michal Kubecek
