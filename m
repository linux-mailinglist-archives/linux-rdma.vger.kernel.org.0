Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C348543633B
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Oct 2021 15:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhJUNnN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Oct 2021 09:43:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:34334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230372AbhJUNnM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Oct 2021 09:43:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F93561220;
        Thu, 21 Oct 2021 13:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634823656;
        bh=ByZxuGhT085/mtPBLThK0m5ugXYlvYQdbeej36Q4VtY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lmNxXaCoomYWUa6+DnTdpKH/n4KXZXAZJqcd4TjG1OP6XYmBj4xMKvCMy2CcjV9vv
         fsolO1WFskUzntPjLvY5WPB5w+fJ6S60kba7MWecGjWjsOiFSMp/35FJYmOe59vi36
         jchEnH6lGCGnM/ipnkWMGfLtimkh8LT0dhVxdzWn7055AMEAvnH60oIeJeYvAwq5hz
         ldIY8vT7aAdFjGxsq7JHzcM46VA54NYM5qO600e3mw0drzpetFn3ajNVTofTho816m
         7VYje3XcSggvJOZp7mus+tsczjjqAy8kEJHa5Tq5uWtzdszD8IDqronAtLqyZNcNV9
         qKPvaiQQ6sTgQ==
Date:   Thu, 21 Oct 2021 16:40:53 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     dledford@redhat.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
        saeedm@nvidia.com
Subject: Re: [PATCH rdma-next 2/3] mlx5: use dev_addr_mod()
Message-ID: <YXFt5Ygeh0u9dw0l@unreal>
References: <20211019182604.1441387-1-kuba@kernel.org>
 <20211019182604.1441387-3-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019182604.1441387-3-kuba@kernel.org>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 19, 2021 at 11:26:03AM -0700, Jakub Kicinski wrote:
> Commit 406f42fa0d3c ("net-next: When a bond have a massive amount
> of VLANs...") introduced a rbtree for faster Ethernet address look
> up. To maintain netdev->dev_addr in this tree we need to make all
> the writes to it got through appropriate helpers.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: saeedm@nvidia.com
> CC: leon@kernel.org
> CC: linux-rdma@vger.kernel.org
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
