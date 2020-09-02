Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0DC25A886
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Sep 2020 11:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgIBJYG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Sep 2020 05:24:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgIBJYF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 2 Sep 2020 05:24:05 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE9F520773;
        Wed,  2 Sep 2020 09:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599038644;
        bh=/Y5/ncA4+fnNzq1qLhBRcreHjYHv6iLV1oFlGIQDEhU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r0cW4pSiiCuA3KcYxKjgNceq+LsfKSYMsbU3WiC0mPr/Up6ILiAm7VJT2Wz9CIdiI
         yAk4xi7zbjTroUoiYdbqoVDQAt2M5k/ZeYKxWAY4FnjKHfNJdaVQmZCJJpXhv7RXUu
         SCrGJXFS9l1NyYOFSQ+QB0XW9rFzkzXQU1q506VQ=
Date:   Wed, 2 Sep 2020 12:24:00 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: Re: [PATCH 01/14] RDMA/umem: Fix ib_umem_find_best_pgsz() for
 mappings that cross a page boundary
Message-ID: <20200902092400.GG59010@unreal>
References: <0-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
 <1-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 01, 2020 at 09:43:29PM -0300, Jason Gunthorpe wrote:
> It is possible for a single SGL to span an aligned boundary, eg if the SGL
> is
>
>   61440 -> 90112
>
> Then the length is 28672, which currently limits the block size to
> 32k. With a 32k page size the two covering blocks will be:
>
>   32768->65536 and 65536->98304
>
> However, the correct answer is a 128K block size which will span the whole
> 28672 bytes in a single block.
>
> Instead of limiting based on length figure out which high IOVA bits don't
> change between the start and end addresses. That is the highest useful
> page size.
>
> Fixes: 4a35339958f1 ("RDMA/umem: Add API to find best driver supported page size in an MR")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/core/umem.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
