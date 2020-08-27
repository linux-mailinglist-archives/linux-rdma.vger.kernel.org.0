Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F173253E82
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Aug 2020 09:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgH0HCd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Aug 2020 03:02:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:37758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbgH0HCa (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 Aug 2020 03:02:30 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6819A22B49;
        Thu, 27 Aug 2020 07:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598511750;
        bh=T7Zx6kWDQV3KUPXj5HnKAxbzskPBflWugsny/VglPng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tz6WjLDSs2Rkyzr+o4fDeKiJljvTrkwF4oVZSV8EVwXnvhUPVvWbr4FajBu0gfuEe
         E2TUv5M/H6Anj1K9pcxeZfqQKn8d8Xtlw8BF0oI4isW/YlzCRNkxH8yyd73WUGjxap
         qH8LQV1wClTO+hU39wUtmfEDc0VVmpdSngmnAEas=
Date:   Thu, 27 Aug 2020 10:02:26 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH for-next] rdma_rxe: address an issue with hardened user
 copy
Message-ID: <20200827070226.GQ1362631@unreal>
References: <20200825165836.27477-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825165836.27477-1-rpearson@hpe.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 25, 2020 at 11:58:37AM -0500, Bob Pearson wrote:
> Change rxe pools to use kzalloc instead of kmem_cache to allocate
> memory for rxe objects.
>
> Signed-off-by: Bob Pearson <rpearson@hpe.com>
> ---
>  drivers/infiniband/sw/rxe/rxe.c      |  8 ----
>  drivers/infiniband/sw/rxe/rxe_pool.c | 60 +---------------------------
>  drivers/infiniband/sw/rxe/rxe_pool.h |  7 ----
>  3 files changed, 2 insertions(+), 73 deletions(-)
>

I liked this solution.

Thanks,
Acked-by: Leon Romanovsky <leonro@nvidia.com>

BTW, didn't test/"review deeply" the patch so take my Acked-by with grain of salt.
