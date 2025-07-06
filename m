Return-Path: <linux-rdma+bounces-11908-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15882AFA36C
	for <lists+linux-rdma@lfdr.de>; Sun,  6 Jul 2025 09:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72C6C17CDE9
	for <lists+linux-rdma@lfdr.de>; Sun,  6 Jul 2025 07:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5CB1C861F;
	Sun,  6 Jul 2025 07:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWnjN6Bd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA7815E8B
	for <linux-rdma@vger.kernel.org>; Sun,  6 Jul 2025 07:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751786727; cv=none; b=kwCVgkMPFycNwe/2WoWr2kMFkAF+KmNoETY+9/mgqPjNO0DUvNj6+mTe9J0pxchLqYt913gSPxn60KZJgguzeSV2/VvyzxEC5OE7b9Xhx4PfNaRVFVBWBBf7be/6MM0OiE+GrMhOrIY1zFDMbkzpjIvbAi7906VAJ1kbTCFeYnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751786727; c=relaxed/simple;
	bh=lD8j+udBWBzzqQUfP4O2yl2n7xfLcRy346uBF6heZhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVwpJvXzcyfVVFModnDYYQALRq6jsC24v06jC542WuU55gPvy2YLqbog3L8hTguoGnM5scnszS0TZpSQm2nE3BuYkyA2FOH6aeYArwWJkqTOUvzQ36Trz37ASUVVOG8cSFqsCJSXbvssxfiEwwJVU850GerKy8Y5Eu7juMmsW6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWnjN6Bd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8821DC4CEED;
	Sun,  6 Jul 2025 07:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751786727;
	bh=lD8j+udBWBzzqQUfP4O2yl2n7xfLcRy346uBF6heZhQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lWnjN6BdDPg91P3jKD4t8CuP6iWWub8O2ZEhbqeGtR422VY3QCmzsoCcbLYQ8675m
	 zg3RzLL2EbGPoDwsRC9prX8Es5ZgW7uTp5ubw2JAMjrazmFYOcB8BNEF9bs0jqHhBN
	 7d9GGOruxQfKMBSJSvFxB9iZEPcikY28jgDbDhmH7mkwp+Ovpsd//CAtA2edsZsCxg
	 KWUBY82cmV/VhK+YOSyV+ghbGDJtUpWBJ5TI82VaZCQ54RpYPXm/qnKGZP2rMlfYV7
	 MMpKZoeOHNVqHusvxMmwAqsbNGYktbj9k/YIfrK11JWvq2uW5raVk7b7fJzgdnjqsS
	 XrnkCvdT20KjQ==
Date: Sun, 6 Jul 2025 10:25:23 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Michael Margolin <mrgolin@amazon.com>
Cc: jgg@nvidia.com, linux-rdma@vger.kernel.org, sleybo@amazon.com,
	matua@amazon.com, gal.pressman@linux.dev,
	Yonatan Nachum <ynachum@amazon.com>
Subject: Re: [PATCH for-next v2] RDMA/efa: Extend admin timeout error print
Message-ID: <20250706072523.GQ6278@unreal>
References: <20250703182314.16442-1-mrgolin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703182314.16442-1-mrgolin@amazon.com>

On Thu, Jul 03, 2025 at 06:23:14PM +0000, Michael Margolin wrote:
> Add command id to the printed message for additional debug information.
> 
> Reviewed-by: Yonatan Nachum <ynachum@amazon.com>
> Signed-off-by: Michael Margolin <mrgolin@amazon.com>
> ---
>  drivers/infiniband/hw/efa/efa_com.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)

Please don't forget to add changelogs.

> 
> diff --git a/drivers/infiniband/hw/efa/efa_com.c b/drivers/infiniband/hw/efa/efa_com.c
> index bafd210dd43e..e6377602a9c4 100644
> --- a/drivers/infiniband/hw/efa/efa_com.c
> +++ b/drivers/infiniband/hw/efa/efa_com.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
>  /*
> - * Copyright 2018-2024 Amazon.com, Inc. or its affiliates. All rights reserved.
> + * Copyright 2018-2025 Amazon.com, Inc. or its affiliates. All rights reserved.
>   */

<...>

>  	reinit_completion(&comp_ctx->wait_event);
>  
> @@ -557,17 +559,19 @@ static int efa_com_wait_and_process_admin_cq_interrupts(struct efa_comp_ctx *com
>  		if (comp_ctx->status == EFA_CMD_COMPLETED)
>  			ibdev_err_ratelimited(
>  				aq->efa_dev,
> -				"The device sent a completion but the driver didn't receive any MSI-X interrupt for admin cmd %s(%d) status %d (ctx: 0x%p, sq producer: %d, sq consumer: %d, cq consumer: %d)\n",
> +				"The device sent a completion but the driver didn't receive any MSI-X interrupt for admin cmd %s(%d) status %d (id: %d, sq producer: %d, sq consumer: %d, cq consumer: %d)\n",
>  				efa_com_cmd_str(comp_ctx->cmd_opcode),
>  				comp_ctx->cmd_opcode, comp_ctx->status,
> -				comp_ctx, aq->sq.pc, aq->sq.cc, aq->cq.cc);
> +				comp_ctx->cmd_id, aq->sq.pc, aq->sq.cc,
> +				aq->cq.cc);
>  		else
>  			ibdev_err_ratelimited(
>  				aq->efa_dev,
> -				"The device didn't send any completion for admin cmd %s(%d) status %d (ctx 0x%p, sq producer: %d, sq consumer: %d, cq consumer: %d)\n",
> +				"The device didn't send any completion for admin cmd %s(%d) status %d (id: %d, sq producer: %d, sq consumer: %d, cq consumer: %d)\n",
>  				efa_com_cmd_str(comp_ctx->cmd_opcode),
>  				comp_ctx->cmd_opcode, comp_ctx->status,
> -				comp_ctx, aq->sq.pc, aq->sq.cc, aq->cq.cc);
> +				comp_ctx->cmd_id, aq->sq.pc, aq->sq.cc,
> +				aq->cq.cc);

I have very strong feeling that you don't really use these prints in real life.

For example, comp_ctx->cmd_id is printed with %d, while code and comment
around cmd_id in __efa_com_submit_admin_cmd() suggests that it needs to be 0x%X.

It has a lot of information separated to LSB and MSB bits which are not readable
while printing with %d.

You are also printing comp_ctx->status, which is clear from if/else section.

So no, I don't buy this claim for "additional debug information", while
existing is not used.

Thanks

>  
>  		clear_bit(EFA_AQ_STATE_RUNNING_BIT, &aq->state);
>  		err = -ETIME;
> -- 
> 2.47.1
> 

