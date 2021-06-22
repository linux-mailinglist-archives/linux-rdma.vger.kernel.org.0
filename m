Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01ECA3AFF05
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 10:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbhFVIUl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Jun 2021 04:20:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:44760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229844AbhFVIUl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Jun 2021 04:20:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 72E3B61289;
        Tue, 22 Jun 2021 08:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624349906;
        bh=YKkHSdb0LbYZAmTQIOolpaiHX/VvCwVJWMLowJswj/Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AsxSC9ZR5JxiVS1KyL4uV+hC8C83jZWds5X0ATvW9ELOkg92sxf1kfdS6WTQOXzxY
         hxTY1Xo3idLwgrafysmSUgIVlXvBsi+VLt+K9Q+SPhHXyPbfN+0Tvmhf6n5MhdvGJd
         D+RxdZCdV5cVZaDuz/4Vw+SynYn+XoQqj3ToHYFAtPOBGO7nD2mFpRR2JcVhi0as88
         2GsP7WwL0X7yAOn3DHj64N0PDAfUUSq4ul64WF+3/etozwjL0SyigXagJzPuzwNIZl
         mgPWcrvw5/YU65KVk75MbBEyLDdY0e7fZKUybBHgACRZq14b5Nrh31xdQGXUw3I+s/
         Ba10HnNm/YQvQ==
Date:   Tue, 22 Jun 2021 11:18:22 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     =?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-rdma@vger.kernel.org,
        Hans Westgaard Ry <hans.westgaard.ry@oracle.com>
Subject: Re: [PATCH for-next] RDMA/cma: Fix incorrect Packet Lifetime
 calculation
Message-ID: <YNGcznXKXn2+izJX@unreal>
References: <1624281537-5573-1-git-send-email-haakon.bugge@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1624281537-5573-1-git-send-email-haakon.bugge@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 21, 2021 at 03:18:57PM +0200, Håkon Bugge wrote:
> An approximation for the PacketLifeTime is half the local ACK timeout.
> The encoding for both timers are logarithmic. The PacketLifeTime
> calculation is wrong when local ACK timeout is zero. In that case,
> PacketLifeTime is set to the incorrect value 255.
> 
> Fixed by explicitly testing for timeout being zero.
> 
> Fixes: e1ee1e62bec4 ("RDMA/cma: Use ACK timeout for RoCE packetLifeTime")
> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> 
> ---
> 
> 	* Note: This commit must be merged after ("RDMA/cma: Replace
>           RMW with atomic bit-ops")
> ---
>  drivers/infiniband/core/cma.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
