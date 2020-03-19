Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D08818B887
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2020 15:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbgCSODL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Mar 2020 10:03:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:46896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726998AbgCSODK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Mar 2020 10:03:10 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D34DE208E4;
        Thu, 19 Mar 2020 14:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584626590;
        bh=8hqdxDW8OeK+z/z2ZXtpmgi1sJ8VQOmtHmmf0EgtVTo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BF5wNIiOXgYimoGQ0YZPa688wEt2SJy1LPyPD1bgzyNuivEHhewSlFoK9MfYw9XxR
         IDJ5elnFnk/ZGSW5/SyMvYCDFPJclsd+8HzUDxeo6a5dpRh4Fk1KP1S8oDqu8gUb09
         o6mOErjW9xWNlP4V9wFiBwY8tRzOYEPHtomfNm/g=
Date:   Thu, 19 Mar 2020 16:03:06 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org,
        Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Block delay drop to unprivileged users
Message-ID: <20200319140306.GQ126814@unreal>
References: <20200318100223.46436-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318100223.46436-1-leon@kernel.org>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 18, 2020 at 12:02:23PM +0200, Leon Romanovsky wrote:
> From: Maor Gottlieb <maorg@mellanox.com>
>
> Since this feature can globally block the RX port, it should
> be allowed to privileged users only.
>
> Fixes: 03404e8ae652("IB/mlx5: Add support to dropless RQ")
> Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
> We didn't put this check in IB/core because it is unclear if it can be
> applicable to all vendors, but for the mlx5 it is clear, due to how wq
> is created.
> ---
>  drivers/infiniband/hw/mlx5/qp.c | 4 ++++
>  1 file changed, 4 insertions(+)
>

Please drop this patch, it needs to be resent.

Thanks
