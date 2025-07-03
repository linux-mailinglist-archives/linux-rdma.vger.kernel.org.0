Return-Path: <linux-rdma+bounces-11854-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47272AF6AB0
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 08:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A2E0188C7A4
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 06:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80408286A1;
	Thu,  3 Jul 2025 06:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BjUWXhyt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B64F226D03
	for <linux-rdma@vger.kernel.org>; Thu,  3 Jul 2025 06:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751525191; cv=none; b=QfWNWfFWbAYXwkrrrgLIxxgGdRXlm5Ie0dgNlVriistyjW/mVo1y+z5ImufdIByZp5wh1kwC+bi5vsyWS6M8n9NcK4iP2M1Kae0qheXRKCzGiU/sKnjQI0NWwVPxy1d2aITlqoskVeo+j5Y3fIDbrdJscG/odLwPlwLsF/zTjnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751525191; c=relaxed/simple;
	bh=sEoRz4g3ONK5bLfoaU4ymBfM+q1gqWySeELeoXNPgvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lp0mumM4tmrWB377M5tBCylaJyn/9AWnZ9RrgF6qQwTHdwsoHFJlsGPt6Yv2SZIqMPmfROQd0RYosUoEkaA9jXO5fj32/pBigG3QtmODb6Sd6hXwY1fgO2sJxTRBAp4vsiNkf9Lc+Ew/bHFh0BianOFABLgIVPNPvgPlECrxIgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BjUWXhyt; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bdbb1205-d940-434a-a102-b233562a1429@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751525186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K6R8tsCWvVTu2+o+auycHtmyyCOgivrVMcUA4H31fxM=;
	b=BjUWXhytfldJheaSmezNYp6EPs17uycR8fFZ1q6X/m4adAqxJiZ3mizcwZGzN2yXXAl6Ql
	JXiNX8CjAZEu7Npam5FvS3BSgythzlwgueLEJUQoXxY9NpUk7n7nmKmLjDtihLDb5B3OEF
	hB7t9BXCBt5KDGa9tbJnAFYql96aPmQ=
Date: Thu, 3 Jul 2025 09:46:18 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next] RDMA/efa: Extend admin timeout error print
To: Michael Margolin <mrgolin@amazon.com>, jgg@nvidia.com, leon@kernel.org,
 linux-rdma@vger.kernel.org
Cc: sleybo@amazon.com, matua@amazon.com, Yonatan Nachum <ynachum@amazon.com>
References: <20250702152028.2812-1-mrgolin@amazon.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Gal Pressman <gal.pressman@linux.dev>
In-Reply-To: <20250702152028.2812-1-mrgolin@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 02/07/2025 18:20, Michael Margolin wrote:
> Add command context index to the printed message for additional debug
> information.
> 
> Reviewed-by: Yonatan Nachum <ynachum@amazon.com>
> Signed-off-by: Michael Margolin <mrgolin@amazon.com>
> ---
>  drivers/infiniband/hw/efa/efa_com.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/efa/efa_com.c b/drivers/infiniband/hw/efa/efa_com.c
> index bafd210dd43e..f1e88ee89bb8 100644
> --- a/drivers/infiniband/hw/efa/efa_com.c
> +++ b/drivers/infiniband/hw/efa/efa_com.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
>  /*
> - * Copyright 2018-2024 Amazon.com, Inc. or its affiliates. All rights reserved.
> + * Copyright 2018-2025 Amazon.com, Inc. or its affiliates. All rights reserved.
>   */
>  
>  #include "efa_com.h"
> @@ -557,17 +557,19 @@ static int efa_com_wait_and_process_admin_cq_interrupts(struct efa_comp_ctx *com
>  		if (comp_ctx->status == EFA_CMD_COMPLETED)
>  			ibdev_err_ratelimited(
>  				aq->efa_dev,
> -				"The device sent a completion but the driver didn't receive any MSI-X interrupt for admin cmd %s(%d) status %d (ctx: 0x%p, sq producer: %d, sq consumer: %d, cq consumer: %d)\n",
> +				"The device sent a completion but the driver didn't receive any MSI-X interrupt for admin cmd %s(%d) status %d (ctx[%d]: 0x%p, sq producer: %d, sq consumer: %d, cq consumer: %d)\n",
>  				efa_com_cmd_str(comp_ctx->cmd_opcode),
>  				comp_ctx->cmd_opcode, comp_ctx->status,
> -				comp_ctx, aq->sq.pc, aq->sq.cc, aq->cq.cc);
> +				comp_ctx - aq->comp_ctx, comp_ctx, aq->sq.pc,
> +				aq->sq.cc, aq->cq.cc);
>  		else
>  			ibdev_err_ratelimited(
>  				aq->efa_dev,
> -				"The device didn't send any completion for admin cmd %s(%d) status %d (ctx 0x%p, sq producer: %d, sq consumer: %d, cq consumer: %d)\n",
> +				"The device didn't send any completion for admin cmd %s(%d) status %d (ctx[%d]: 0x%p, sq producer: %d, sq consumer: %d, cq consumer: %d)\n",
>  				efa_com_cmd_str(comp_ctx->cmd_opcode),
>  				comp_ctx->cmd_opcode, comp_ctx->status,
> -				comp_ctx, aq->sq.pc, aq->sq.cc, aq->cq.cc);
> +				comp_ctx - aq->comp_ctx, comp_ctx, aq->sq.pc,
> +				aq->sq.cc, aq->cq.cc);
>  
>  		clear_bit(EFA_AQ_STATE_RUNNING_BIT, &aq->state);
>  		err = -ETIME;

Arguably, there is no point in keeping the comp_ctx pointer print, as
you have nothing to compare the hashed pointer to. It could've been
useful if the pointer was also printed when the command is submitted,
but it isn't, so it's probably better to just remove it and keep the
index you added.

A better alternative might be storing the cmd_id inside the comp_ctx and
printing it instead, it contains more information.

