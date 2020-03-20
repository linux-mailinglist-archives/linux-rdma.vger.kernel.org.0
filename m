Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C92918D0E8
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2020 15:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbgCTOcH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Mar 2020 10:32:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:56056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726896AbgCTOcG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 20 Mar 2020 10:32:06 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F80420709;
        Fri, 20 Mar 2020 14:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584714726;
        bh=d7xXJd389UII+bu2/n9kpsSIPtN/A/AqG3qZ+IwXdNY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vdu3vYu7sUommyM7i7DxBVKD0u4RuMd3R72m4+lSeqjmfcxTqfThfxUFGAyIh3T5C
         +pzV/lpW31dFn+gfYqDwX9g4SsMzf7d6x5glG2CN8xKqyrAQMlzVAT2bGgWRcZSZC0
         p11U94GmPnNb8VTW+Rhr0JlK/vn8EL2j0D6a8xW0=
Date:   Fri, 20 Mar 2020 16:32:02 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Saeed Mahameed <saeedm@mellanox.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] {IB,net}/mlx5: Remove unused variable
Message-ID: <20200320143202.GG514123@unreal>
References: <20200320132525.GE95012@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320132525.GE95012@mwanda>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 20, 2020 at 04:25:25PM +0300, Dan Carpenter wrote:
> The "key" variable is never initialized or used except to print out a
> debug message.
>
> Fixes: fc6a9f86f08a ("{IB,net}/mlx5: Assign mkey variant in mlx5_ib only")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/mr.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>

Thanks, for the patch, but Saeed already fixed it and it is in linux-next.
https://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git/commit/?h=mlx5-next&id=826096d84f509d95ee8f72728fe19c44fbb9df6b

Thanks
