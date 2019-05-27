Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCB32BB84
	for <lists+linux-rdma@lfdr.de>; Mon, 27 May 2019 22:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfE0Ur3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 May 2019 16:47:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:39354 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727132AbfE0Ur3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 May 2019 16:47:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F30BEAF49;
        Mon, 27 May 2019 20:47:27 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 7CC76E00A9; Mon, 27 May 2019 22:47:27 +0200 (CEST)
Date:   Mon, 27 May 2019 22:47:27 +0200
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Ariel Levkovich <lariel@mellanox.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mlx5: avoid 64-bit division
Message-ID: <20190527204727.GH30439@unicorn.suse.cz>
References: <20190520111902.7104DE0184@unicorn.suse.cz>
 <20190527181534.GA10029@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527181534.GA10029@ziepe.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 27, 2019 at 03:15:34PM -0300, Jason Gunthorpe wrote:
> On Mon, May 20, 2019 at 01:19:02PM +0200, Michal Kubecek wrote:
> > diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
> > index abac70ad5c7c..340290b883fe 100644
> > +++ b/drivers/infiniband/hw/mlx5/main.c
> > @@ -2344,7 +2344,7 @@ static int handle_alloc_dm_sw_icm(struct ib_ucontext *ctx,
> >  	/* Allocation size must a multiple of the basic block size
> >  	 * and a power of 2.
> >  	 */
> > -	act_size = roundup(attr->length, MLX5_SW_ICM_BLOCK_SIZE(dm_db->dev));
> > +	act_size = round_up(attr->length, MLX5_SW_ICM_BLOCK_SIZE(dm_db->dev));
> >  	act_size = roundup_pow_of_two(act_size);
> 
> It is kind of weird that we have round_up and the bitshift
> version.. None of this is performance critical so why not just use
> round_up everywhere?
> 
> Ariel, it is true MLX5_SW_ICM_BLOCK_SIZE will always be a power of
> two?

If it weren't, the requirements from the comment above could never be
satisfied as a power of two can only be a multiple of another power of
two. Which also means that what the code above does is in fact
equivalent to

	act_size = max_t(u64, roundup_pow_of_two(attr->length),
			 MLX5_SW_ICM_BLOCK_SIZE(dm_db->dev));

or

	act_size = roundup_pow_of_two(max_t(u64, attr->length,
					    MLX5_SW_ICM_BLOCK_SIZE(dm_db->dev));

Michal Kubecek
