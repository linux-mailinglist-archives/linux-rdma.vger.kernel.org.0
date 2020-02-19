Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A62B163D70
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2020 08:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgBSHQV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Feb 2020 02:16:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:49698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbgBSHQV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 Feb 2020 02:16:21 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 675F0208C4;
        Wed, 19 Feb 2020 07:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582096581;
        bh=30NcROZjqAUFQdyrNMDM6Z/BMhZ4m3JaHQKqCoHg7ls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IA6ULHD5tidxeOxPzHD2rbTvR6LF77JH6g8TtI5XVrg3oCO0NsNQ7wIQ/9f2rMQYH
         aVM7EEuwUYLxF6XDKOweMIxNn928p45KB+7Jssk9UY8gKyC/ydcIJJULSDGbqABmZD
         M9tiSZdYPFX9gy3g+eFAAN8rHva5MoP47xtWH7IY=
Date:   Wed, 19 Feb 2020 09:16:17 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] RDMA/ucma: Use refcount_t for the ctx->ref
Message-ID: <20200219071617.GF15239@unreal>
References: <20200218191657.GA29724@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218191657.GA29724@ziepe.ca>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 18, 2020 at 07:17:00PM +0000, Jason Gunthorpe wrote:
> Don't use an atomic as a refcount.
>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>  drivers/infiniband/core/ucma.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
