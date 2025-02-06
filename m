Return-Path: <linux-rdma+bounces-7483-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BC1A2A3DF
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Feb 2025 10:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E321162D0F
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Feb 2025 09:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D6E225A2B;
	Thu,  6 Feb 2025 09:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oibyyYWU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EA041C92;
	Thu,  6 Feb 2025 09:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738832913; cv=none; b=gjboNw/OGVUgnL5kuZJnJ8HZNLdpymkgkotEJ7Yg7ZkGb+Q+cb/k/mymEdbXaUlyCTTEQXwDhzOekiN+9FzM2miEsvAJIcpK1Of2U5KkRjDJ/r53UAJp6j6aYjgSokpOK9cQWyZBmPivFwYE4Czu/GUp1b3G1CTPMLIGZ8mc3e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738832913; c=relaxed/simple;
	bh=pqeOdsrhQP0UVZr/cWWAMZcvGE9syj5Y/ICgwkE83yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDF8s3G8nHzDEDhSO6RGioBT/2vkGEMYIKrvbVHZXnlFcBGB/MDuHJ1C2qrrVNuHCkEoaGTupJJA44rsDRyvlPUGgQxeMkW3NE03tdtZeQiRvs+TTE1eA0hWFpqHDIIvEUrT97THG4JkdYDSVOkC0Za1M9mxvrBV32On3HSjsfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oibyyYWU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CED2C4CEDD;
	Thu,  6 Feb 2025 09:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738832912;
	bh=pqeOdsrhQP0UVZr/cWWAMZcvGE9syj5Y/ICgwkE83yw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oibyyYWUQVwc+Fv1TZMKg475NJ1djgJoShHHXzGpHSBcLt8A7Lb4ZkQ6Qiw+IVHYz
	 wIuusyZ29ANbNK/p0gtd0OxHEZ502Z7Cobmd1gW2u76TaxgSnOSDA6oPA9w6/GyD/i
	 IfMMwEPGwKmlo7DDdiSrDOzocQF4Xt46N3uZlAwwIQ7xaQvXELk4wZplP10NfRGCop
	 3W7rk9d/T9KGzXa6upCvdJFlL9CBVRrKaLy6cS/7nmxUDH0NRQT2VdjWbAPEYwWANe
	 j2tmHuHHr0Jgm85MgKdNBPkxXqUT3MRS8lIfqX8jN90iEGzcyLKqLae01Ap9EdIT0M
	 12VJbNrjjFzWg==
Date: Thu, 6 Feb 2025 11:08:28 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: kotaranov@microsoft.com, shirazsaleem@microsoft.com,
	sharmaajay@microsoft.com, longli@microsoft.com, jgg@ziepe.ca,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next 1/1] RDMA/mana_ib: Add port statistics support
Message-ID: <20250206090828.GP74886@unreal>
References: <1738751527-15517-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1738751527-15517-1-git-send-email-kotaranov@linux.microsoft.com>

On Wed, Feb 05, 2025 at 02:32:07AM -0800, Konstantin Taranov wrote:
> From: Shiraz Saleem <shirazsaleem@microsoft.com>
> 
> Implement alloc_hw_port_stats and get_hw_stats APIs to support querying
> MANA VF port level statistics from rdma stat tool.
> 
> Example output from rdma stat tool:
> 
> $rdma statistic show link mana_0/1 -p
> link mana_0/1
>     requester_timeout 45
>     requester_oos_nak 0
>     requester_rnr_nak 0
>     responder_rnr_nak 0
>     responder_oos 0
>     responder_dup_request 0
>     requester_implicit_nak 0
>     requester_readresp_psn_mismatch 0
>     nak_inv_req 0
>     nak_access_error 0
>     nak_opp_error 0
>     nak_inv_read 0
>     responder_local_len_error 0
>     requestor_local_prot_error 0
>     responder_rem_access_error 0
>     responder_local_qp_error 0
>     responder_malformed_wqe 0
>     general_hw_error 6
>     requester_rnr_nak_retries_exceeded 0
>     requester_retries_exceeded 5
>     total_fatal_error 6
>     received_cnps 0
>     num_qps_congested 0
>     rate_inc_events 0
>     num_qps_recovered 0
>     current_rate 100000
> 
> Signed-off-by: Shiraz Saleem <shirazsaleem@microsoft.com>
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> ---
>  drivers/infiniband/hw/mana/Makefile   |   2 +-
>  drivers/infiniband/hw/mana/counters.c | 105 ++++++++++++++++++++++++++
>  drivers/infiniband/hw/mana/counters.h |  44 +++++++++++
>  drivers/infiniband/hw/mana/device.c   |   7 ++
>  drivers/infiniband/hw/mana/mana_ib.h  |  61 ++++++++++++---
>  5 files changed, 206 insertions(+), 13 deletions(-)
>  create mode 100644 drivers/infiniband/hw/mana/counters.c
>  create mode 100644 drivers/infiniband/hw/mana/counters.h

<...>

>  enum mana_ib_command_code {
> -	MANA_IB_GET_ADAPTER_CAP = 0x30001,
> -	MANA_IB_CREATE_ADAPTER  = 0x30002,
> -	MANA_IB_DESTROY_ADAPTER = 0x30003,
> -	MANA_IB_CONFIG_IP_ADDR	= 0x30004,
> -	MANA_IB_CONFIG_MAC_ADDR	= 0x30005,
> -	MANA_IB_CREATE_UD_QP	= 0x30006,
> -	MANA_IB_DESTROY_UD_QP	= 0x30007,
> -	MANA_IB_CREATE_CQ       = 0x30008,
> -	MANA_IB_DESTROY_CQ      = 0x30009,
> -	MANA_IB_CREATE_RC_QP    = 0x3000a,
> -	MANA_IB_DESTROY_RC_QP   = 0x3000b,
> -	MANA_IB_SET_QP_STATE	= 0x3000d,
> +	MANA_IB_GET_ADAPTER_CAP		= 0x30001,
> +	MANA_IB_CREATE_ADAPTER		= 0x30002,
> +	MANA_IB_DESTROY_ADAPTER		= 0x30003,
> +	MANA_IB_CONFIG_IP_ADDR		= 0x30004,
> +	MANA_IB_CONFIG_MAC_ADDR		= 0x30005,
> +	MANA_IB_CREATE_UD_QP		= 0x30006,
> +	MANA_IB_DESTROY_UD_QP		= 0x30007,
> +	MANA_IB_CREATE_CQ		= 0x30008,
> +	MANA_IB_DESTROY_CQ		= 0x30009,
> +	MANA_IB_CREATE_RC_QP		= 0x3000a,
> +	MANA_IB_DESTROY_RC_QP		= 0x3000b,
> +	MANA_IB_SET_QP_STATE		= 0x3000d,
> +	MANA_IB_QUERY_VF_COUNTERS	= 0x30022,
>  };

Please stop to do vertical alignment. We don't need this churn.
I fixed it locally.

Thanks

