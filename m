Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4EB347A7D
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Mar 2021 15:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236081AbhCXOT4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Mar 2021 10:19:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:33558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236029AbhCXOTt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 24 Mar 2021 10:19:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C374C619D5;
        Wed, 24 Mar 2021 14:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616595589;
        bh=SqJk8IkxfEpl+NF3dJR2+tt7AFBJle3tFmyyydCRxDU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nsxBwiu820tX1DJ0Kt8I8l8D6Y9bGBu3wL9etC2Puv9mn5tMB/VluzKlms7udel5I
         NecOfzGbJHCrgxjZGSnliPxEI9eRNbf+FWGwBGllBupQP8w1PYTQeMLKAK/ASVI24U
         DjAbdn8MZ60wIwzRRJKkJrA1rlSg37yE/9/LpyfBnxqtw+/HOAdxDbGyodmscgRIYa
         LVctF9egU5hh8BUdgGMxEroBJrMzbOjLK6+H0PqVwHsBCcq2vZ1aEztgdH4crKwwfB
         5Uo0F3KRh6EZISwWHy7P2E3mUBqvtrrh6loD7rw91dAqOg+oGJlPp2l87ShgPn8vMB
         WrEbkrz4ehC2A==
Date:   Wed, 24 Mar 2021 16:19:45 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     bvanassche@acm.org, dledford@redhat.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] IB/srpt: Fix passing zero to 'PTR_ERR'
Message-ID: <YFtKgU17EwK22hdj@unreal>
References: <20210324140939.7480-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324140939.7480-1-yuehaibing@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 24, 2021 at 10:09:39PM +0800, YueHaibing wrote:
> Fix smatch warning:
> 
> drivers/infiniband/ulp/srpt/ib_srpt.c:2341 srpt_cm_req_recv() warn: passing zero to 'PTR_ERR'
> 
> Use PTR_ERR_OR_ZERO instead of PTR_ERR
> 
> Fixes: 847462de3a0a ("IB/srpt: Fix srpt_cm_req_recv() error path (1/2)")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/infiniband/ulp/srpt/ib_srpt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
> index 6be60aa5ffe2..3ff24b5048ac 100644
> --- a/drivers/infiniband/ulp/srpt/ib_srpt.c
> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
> @@ -2338,7 +2338,7 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
>  
>  	if (IS_ERR_OR_NULL(ch->sess)) {
>  		WARN_ON_ONCE(ch->sess == NULL);
> -		ret = PTR_ERR(ch->sess);
> +		ret = PTR_ERR_OR_ZERO(ch->sess);

It is crazy, in first line, we checked ch->sess and allowed it to be NULL,
later caused to kernel panic and set ret to success.

>  		ch->sess = NULL;
>  		pr_info("Rejected login for initiator %s: ret = %d.\n",
>  			ch->sess_name, ret);
> -- 
> 2.22.0
> 
