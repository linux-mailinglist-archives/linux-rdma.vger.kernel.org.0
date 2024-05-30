Return-Path: <linux-rdma+bounces-2707-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D4B8D50BD
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2024 19:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B561EB21CBA
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2024 17:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180C745033;
	Thu, 30 May 2024 17:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVtnVjqu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9935405FB;
	Thu, 30 May 2024 17:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717089286; cv=none; b=WWvHVc/fvWM9L7eD0khFSz8bx/z5DXrUqcP1XIxg9PfPSqJnzsITnLjoQoOyILVdFSk9dqYD4pB0BYDGUuqoHDVWTUCVzkDIaPTNvsjcvx6FXXe2TgfXXe/r9fnDC/EecuHDEzmjyQOFCSsG48BV6KzC5aWuCXghQXd8Z6Ibe6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717089286; c=relaxed/simple;
	bh=zmY0ORK1B5BkKpd/9Xan0GjeGKmQu1tubxofXOvTQ3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGclEvESfvjTLIgMWMn0wi0Mh/eQfKXAdPfceadR6ZBXnl4fcPYIvPr4jwxT02yt1edpCvhjJqwMDfAu47BKi8CyAA0YZewWxH7g5p+zMJrVJZBq7Tg4v8/Xw/9rTHI9aaYIRFvkDZ3orZ8OHbdOV/jGiP+5dLRe94KDILKULuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVtnVjqu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB8AC2BBFC;
	Thu, 30 May 2024 17:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717089286;
	bh=zmY0ORK1B5BkKpd/9Xan0GjeGKmQu1tubxofXOvTQ3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cVtnVjquT9t/oU24rofoX/VO4hKKAoyUg8nwf1saq/CSo8QiS0jvEMbGyn4uOanMH
	 w2AiX8R+8ATIx0dVLBVrk/PR6vskaGikuVfH6zcvNOsffNnXYx4zlMB6G2rEgC+p9m
	 Q3Wx3u1ArDSN0tOlN4IUvG40geWHH9UBKMAWVRIlKAAgXrCd+2MSbpFDWQ8NEX33+4
	 OfPS9hkHwCm/3gF4h/bshVJ1cr+d1gW573dmt5+X+DPzaZjcQN/aRDGFyJEbyvcnZD
	 G9UU820BZUuVtIH6GdCWU0uNBXjyNW4GyF14wiex3EZMjG41pTNrSbTHPDiDmvqVQs
	 5FS6ig9zbaL7Q==
Date: Thu, 30 May 2024 20:14:40 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Anand Khoje <anand.a.khoje@oracle.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	rama.nichanamatlu@oracle.com, manjunath.b.patil@oracle.com
Subject: Re: [PATCH 1/1] RDMA/mlx5: Release CPU for other processes in
 mlx5_free_cmd_msg()
Message-ID: <20240530171440.GE3884@unreal>
References: <20240522033256.11960-1-anand.a.khoje@oracle.com>
 <20240522033256.11960-2-anand.a.khoje@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240522033256.11960-2-anand.a.khoje@oracle.com>

On Wed, May 22, 2024 at 09:02:56AM +0530, Anand Khoje wrote:
> In non FLR context, at times CX-5 requests release of ~8 million device pages.
> This needs humongous number of cmd mailboxes, which to be released once
> the pages are reclaimed. Release of humongous number of cmd mailboxes
> consuming cpu time running into many secs, with non preemptable kernels
> is leading to critical process starving on that cpu’s RQ. To alleviate
> this, this patch relinquishes cpu periodically but conditionally.
> 
> Orabug: 36275016
> 
> Signed-off-by: Anand Khoje <anand.a.khoje@oracle.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/cmd.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
> index 9c21bce..9fbf25d 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
> @@ -1336,16 +1336,23 @@ static struct mlx5_cmd_msg *mlx5_alloc_cmd_msg(struct mlx5_core_dev *dev,
>  	return ERR_PTR(err);
>  }
>  
> +#define RESCHED_MSEC 2
>  static void mlx5_free_cmd_msg(struct mlx5_core_dev *dev,
>  			      struct mlx5_cmd_msg *msg)
>  {
>  	struct mlx5_cmd_mailbox *head = msg->next;
>  	struct mlx5_cmd_mailbox *next;
> +	unsigned long start_time = jiffies;
>  
>  	while (head) {
>  		next = head->next;
>  		free_cmd_box(dev, head);

Did you consider to make this function asynchronous and parallel?

Thanks

>  		head = next;
> +		if (time_after(jiffies, start_time + msecs_to_jiffies(RESCHED_MSEC))) {
> +			mlx5_core_warn_rl(dev, "Spent more than %d msecs, yielding CPU\n", RESCHED_MSEC);
> +			cond_resched();
> +			start_time = jiffies;
> +		}
>  	}
>  	kfree(msg);
>  }
> -- 
> 1.8.3.1
> 
> 

