Return-Path: <linux-rdma+bounces-13306-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EC8B545AA
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Sep 2025 10:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C55421B23E49
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Sep 2025 08:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C5C2D3221;
	Fri, 12 Sep 2025 08:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkrraaVX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472B519E97A;
	Fri, 12 Sep 2025 08:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757666373; cv=none; b=XNcyN3dye4q2md6aVatOLa7Fsn2zVLK8mDhwELqvwqWkcPiHHVhQQvDvfYuI1+xqhGqgjKzy7wG6Ld/XuCufq2Mt7GKlwZpixTBVjgdSMgtOib/5NQHUOWb9bQAuzEjq6JDL9OWzF8WVG0XT/P33/xVnmcBhYDlDxc4c4zMA+Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757666373; c=relaxed/simple;
	bh=p97QM/aAwDRHBKhz5N1adc9ynT5CC9rvXjsVAciBkwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hUDqA/rZ1PfvOqn4HNxsf80430bx751m7LAseyEZQTO5o572E1biH6NA92mTSYFhljW/epDlt7rbmicX5xDnHnSvnUyFudRpVD3y6EUosxoH8FbxErP+LDIhMmgiC0rtDfyw38tGX/l5iMmakwx3DRC3nBG1ZqfYHTrCsjev7gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkrraaVX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E8EC4CEF4;
	Fri, 12 Sep 2025 08:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757666372;
	bh=p97QM/aAwDRHBKhz5N1adc9ynT5CC9rvXjsVAciBkwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fkrraaVXpCTNDiuUTl7wenGztKRAwxlGRaAKdWBgU6cOHIJxmVziBrW9SKw5eUH+G
	 f4e94RCe6By+UFok4WRS+b+igZKGSXeRwOGWoEuW0h0YNzO+EOsLOnY1bBaYXPRIfD
	 pweG1eKXgWy1X7vTtz6GZFFvdpS9RdA+9Lf5XdTn1uJYr9tEiQb+yOAi/J0mOnfDid
	 Uy0B+HDVXjzm96T6FzPIaYuRDGkjGxdpcgNTd6RtBNTG/8uyDO7N97d+jj7NQggFTJ
	 PGbyT2hhLuV2tOHRCjoWUg+wmQjgHzeQ9iCI7ZijRMSok9ipRqZZZa0gngvH25VJoA
	 wvV0RRsT3dWew==
Date: Fri, 12 Sep 2025 09:39:28 +0100
From: Simon Horman <horms@kernel.org>
To: Siva Reddy Kallam <siva.kallam@broadcom.com>
Cc: leonro@nvidia.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, vikas.gupta@broadcom.com,
	selvin.xavier@broadcom.com, anand.subramanian@broadcom.com,
	Usman Ansari <usman.ansari@broadcom.com>
Subject: Re: [PATCH 5/8] RDMA/bng_re: Add infrastructure for enabling
 Firmware channel
Message-ID: <20250912083928.GS30363@horms.kernel.org>
References: <20250829123042.44459-1-siva.kallam@broadcom.com>
 <20250829123042.44459-6-siva.kallam@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829123042.44459-6-siva.kallam@broadcom.com>

On Fri, Aug 29, 2025 at 12:30:39PM +0000, Siva Reddy Kallam wrote:
> Add infrastructure for enabling Firmware channel.
> 
> Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
> Reviewed-by: Usman Ansari <usman.ansari@broadcom.com>

...

> diff --git a/drivers/infiniband/hw/bng_re/bng_fw.c b/drivers/infiniband/hw/bng_re/bng_fw.c

...

> +/* function events */
> +static int bng_re_process_func_event(struct bng_re_rcfw *rcfw,
> +				     struct creq_func_event *func_event)
> +{
> +	int rc;
> +
> +	switch (func_event->event) {
> +	case CREQ_FUNC_EVENT_EVENT_TX_WQE_ERROR:
> +		break;
> +	case CREQ_FUNC_EVENT_EVENT_TX_DATA_ERROR:
> +		break;
> +	case CREQ_FUNC_EVENT_EVENT_RX_WQE_ERROR:
> +		break;
> +	case CREQ_FUNC_EVENT_EVENT_RX_DATA_ERROR:
> +		break;
> +	case CREQ_FUNC_EVENT_EVENT_CQ_ERROR:
> +		break;
> +	case CREQ_FUNC_EVENT_EVENT_TQM_ERROR:
> +		break;
> +	case CREQ_FUNC_EVENT_EVENT_CFCQ_ERROR:
> +		break;
> +	case CREQ_FUNC_EVENT_EVENT_CFCS_ERROR:
> +		/* SRQ ctx error, call srq_handler??
> +		 * But there's no SRQ handle!
> +		 */
> +		break;
> +	case CREQ_FUNC_EVENT_EVENT_CFCC_ERROR:
> +		break;
> +	case CREQ_FUNC_EVENT_EVENT_CFCM_ERROR:
> +		break;
> +	case CREQ_FUNC_EVENT_EVENT_TIM_ERROR:
> +		break;
> +	case CREQ_FUNC_EVENT_EVENT_VF_COMM_REQUEST:
> +		break;
> +	case CREQ_FUNC_EVENT_EVENT_RESOURCE_EXHAUSTED:
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return rc;

rc does not appear to be initialised in this function.

Flagged by Clang 20.1.8 with -Wuninitialized

> +}

...

> +int bng_re_enable_fw_channel(struct bng_re_rcfw *rcfw,
> +			     int msix_vector,
> +			     int cp_bar_reg_off)
> +{
> +	struct bng_re_cmdq_ctx *cmdq;
> +	struct bng_re_creq_ctx *creq;
> +	int rc;
> +
> +	cmdq = &rcfw->cmdq;
> +	creq = &rcfw->creq;

Conversely, creq is initialised here but otherwise unused in this function.

Flagged by GCC 15.1.0 and Clang 20.1.8 with -Wunused-but-set-variable

> +
> +	/* Assign defaults */
> +	cmdq->seq_num = 0;
> +	set_bit(FIRMWARE_FIRST_FLAG, &cmdq->flags);
> +	init_waitqueue_head(&cmdq->waitq);
> +
> +	rc = bng_re_map_cmdq_mbox(rcfw);
> +	if (rc)
> +		return rc;
> +
> +	rc = bng_re_map_creq_db(rcfw, cp_bar_reg_off);
> +	if (rc)
> +		return rc;
> +
> +	rc = bng_re_rcfw_start_irq(rcfw, msix_vector, true);
> +	if (rc) {
> +		dev_err(&rcfw->pdev->dev,
> +			"Failed to request IRQ for CREQ rc = 0x%x\n", rc);
> +		bng_re_disable_rcfw_channel(rcfw);
> +		return rc;
> +	}
> +
> +	return 0;
> +}

...

