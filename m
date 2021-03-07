Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06566330347
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Mar 2021 18:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbhCGRXE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 7 Mar 2021 12:23:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:51332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232683AbhCGRWj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 7 Mar 2021 12:22:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 15B6764F94;
        Sun,  7 Mar 2021 17:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615137758;
        bh=/RyyXTJIuknawbpmQjnQ9vaXIVBtWG5RB/RYtgDlwQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=srTaMNKaSvVCQorG5pekkh7y6e9UTR3xEr6kjR6P6oUkzkE84sxPaDOrUdn7I1aW7
         cpTudigD+H6Jm+4it67x3bfXNacfei9v7rQA8rr2jT6gl7B0ZODWZzC1agPTxuUNo+
         8GcdkROB0gJ3qoG6wAz+nEX6MYNE59HXw0wuQEs1Wx0EMZMHdVnI8kmiHDVTGObfXx
         bBbkGhC21U/edS5OC8Q+zjUlns+taTBU168YGbiUhCdFyyBVH7bzG6yyaW7Io05KUK
         lopA3z7XRcoZeEVEhJ18ogs5OfFuswdXx0nwx3Tcv6az+15ZOXmxXcVdGGv49XJE7R
         TNMJUuOLYyKZw==
Date:   Sun, 7 Mar 2021 19:22:34 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        maorg@nvidia.com
Subject: Re: Fwd: [PATCH 1/1] RDMA/umem: add back hugepage sg list
Message-ID: <YEUL2vdlWFEbZqLb@unreal>
References: <20210307221034.568606-1-yanjun.zhu@intel.com>
 <CAD=hENeqTTmpS5V+G646V0QvJFLVSd3Sq11ffQFcDXU-OSsQEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=hENeqTTmpS5V+G646V0QvJFLVSd3Sq11ffQFcDXU-OSsQEg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Mar 07, 2021 at 10:28:33PM +0800, Zhu Yanjun wrote:
> From: Zhu Yanjun <zyjzyj2000@gmail.com>
>
> After the commit ("RDMA/umem: Move to allocate SG table from pages"),
> the sg list from ib_ume_get is like the following:
> "
> sg_dma_address(sg):0x4b3c1ce000
> sg_dma_address(sg):0x4c3c1cd000
> sg_dma_address(sg):0x4d3c1cc000
> sg_dma_address(sg):0x4e3c1cb000
> "
>
> But sometimes, we need sg list like the following:
> "
> sg_dma_address(sg):0x203b400000
> sg_dma_address(sg):0x213b200000
> sg_dma_address(sg):0x223b000000
> sg_dma_address(sg):0x233ae00000
> sg_dma_address(sg):0x243ac00000
> "
> The function ib_umem_add_sg_table can provide the sg list like the
> second. And this function is removed in the commit ("RDMA/umem: Move
> to allocate SG table from pages"). Now I add it back.
>
> The new function is ib_umem_get to ib_umem_hugepage_get that calls
> ib_umem_add_sg_table.
>
> This function ib_umem_huagepage_get can get 4K, 2M sg list dma address.
>
> Fixes: 0c16d9635e3a ("RDMA/umem: Move to allocate SG table from pages")
> Signed-off-by: Zhu Yanjun <zyjzyj2000@gmail.com>
> ---
>  drivers/infiniband/core/umem.c | 197 +++++++++++++++++++++++++++++++++
>  include/rdma/ib_umem.h         |   3 +
>  2 files changed, 200 insertions(+)

You didn't use newly introduced function and didn't really explain why
it is needed.

Thanks
