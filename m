Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1456E16A45D
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2020 11:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgBXKwh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Feb 2020 05:52:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:41288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbgBXKwg (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 24 Feb 2020 05:52:36 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B584B2080D;
        Mon, 24 Feb 2020 10:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582541556;
        bh=pRbIAs5C//mo9jzQh7oINEMAkmc7NcM4HYwn4lFZ03Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w5djC6IpGiXEDU+/rrZLeL8VSFFZ7ZV67y6j2TAGhG0fOzNMcCRZC2PrGf816761s
         phE+DT9ZjU5BSiqHo0DTpl0SShDWadkbAic3qrtX5+d9LJYFqNqYz8ZraDCVEbxrqg
         tA24caTLG9AThDJcjzJD5heE4q+xLqoDdeVlS99A=
Date:   Mon, 24 Feb 2020 12:52:33 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Saeed Mahameed <saeedm@mellanox.com>,
        Aya Levin <ayal@mellanox.com>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] net/mlx5e: Fix error code in mlx5e_fec_in_caps()
Message-ID: <20200224105233.GB468372@unreal>
References: <20200224065557.d23b4yd46kjnzfya@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224065557.d23b4yd46kjnzfya@kili.mountain>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 24, 2020 at 09:55:57AM +0300, Dan Carpenter wrote:
> The mlx5e_fec_in_caps() function is type bool so these negative returns
> become "return true;" when they should be "return false;"
>
> Fixes: 2132b71f78d2 ("net/mlx5e: Advertise globaly supported FEC modes")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en/port.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Thanks,
Acked-by: Leon Romanovsky <leonro@mellanox.com>
