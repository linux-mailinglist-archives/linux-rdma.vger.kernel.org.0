Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5EF2C8EB
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2019 16:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfE1OiS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 May 2019 10:38:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:60722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbfE1OiS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 28 May 2019 10:38:18 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 248E520679;
        Tue, 28 May 2019 14:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559054297;
        bh=FliAhEdRTiOnsN7QkSsB6eiQWNcJG4v+nIWcscoRjWs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K3rSZcnLDBYc31OeLl3Rsqps37QDdX1kfwN7ZuwjzDOYKbPgaThdD9d9ryJfZWSY0
         dz7lSbYn0YVSBCDyfRkTDP0hTv+TSJFBAWPdrFHwsRLu1hj57BiUE0QX5wbFSOdbFO
         cWvHHNbbiiVmqgo1V2YP0SnwR4wnFc12wrHWPMhU=
Date:   Tue, 28 May 2019 17:38:14 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Saeed Mahameed <saeedm@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] net/mlx5: potential error pointer dereference in error
 handling
Message-ID: <20190528143814.GQ4633@mtr-leonro.mtl.com>
References: <20190503122839.GB29695@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503122839.GB29695@mwanda>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 03, 2019 at 03:28:39PM +0300, Dan Carpenter wrote:
> The error handling was a bit flipped around.  If the mlx5_create_flow_group()
> function failed then it would have resulted in dereferencing "fg" when
> it was an error pointer.
>
> Fixes: 80f09dfc237f ("net/mlx5: Eswitch, enable RoCE loopback traffic")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/rdma.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Sorry for the delay, applied to mlx5-next branch.
6cc070bdf07c net/mlx5: potential error pointer dereference in error handling

Thanks
