Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCF318D0CD
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2020 15:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbgCTO3m (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Mar 2020 10:29:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:53506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727152AbgCTO3m (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 20 Mar 2020 10:29:42 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C76F920709;
        Fri, 20 Mar 2020 14:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584714581;
        bh=iO6PRguOPpdhSYfKfnRIXG/xdZNHL9pJgUVBEC5X2QU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fq8vVPPByb8BGeX77YGZoVhjCrMm1QMv+o0votFlm1aF/5TW/1PkZWItcpF8/K8gp
         /f2xIajzPJSVD7DpoECohlot2BE6yqlR8UfgBu9FYpcLJxlqE7FwTBTvJKwjr6MMym
         RAFOA/2qqfu/HOqTwNk9Ws956y04iw15/wH1jYlQ=
Date:   Fri, 20 Mar 2020 16:29:31 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Yishai Hadas <yishaih@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] IB/mlx5: Fix a NULL vs IS_ERR() check
Message-ID: <20200320142931.GF514123@unreal>
References: <20200320132641.GF95012@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320132641.GF95012@mwanda>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 20, 2020 at 04:26:41PM +0300, Dan Carpenter wrote:
> The kzalloc() function returns NULL, not error pointers.
>
> Fixes: 30f2fe40c72b ("IB/mlx5: Introduce UAPIs to manage packet pacing")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/infiniband/hw/mlx5/qos.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Of course, thanks a lot.

Acked-by: Leon Romanovsky <leonro@mellanox.com>
