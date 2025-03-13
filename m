Return-Path: <linux-rdma+bounces-8653-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEEBA5F485
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 13:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 519E6173AEF
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 12:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84562673B5;
	Thu, 13 Mar 2025 12:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwsTv77n"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979491EEA59
	for <linux-rdma@vger.kernel.org>; Thu, 13 Mar 2025 12:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741869042; cv=none; b=cyOxxNTenePen/oE10DUKVII0mkxTDzXuVcnRLXDU3gVLVNDGg4+D2eoYNPP52/POLbezeiI51vg4JzY5+HX1p2Go0DGhhF9S6l8ydVp5d41dZLKK0KZh2rZ8ai0CPJpNG10/ZDrbk+vl059gBE/CJrwtWhBwMQgYcdCPnmplmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741869042; c=relaxed/simple;
	bh=EnhTGsB0GEtdWZ535UcAN5y4TH4ZZmw8k8nH7MAVNO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QmHtLUPNrdsg7Sm7NiM6G1zVeeht/DTNK+L23oG/aZDXbBM6CF3rpjm/21OdIcwhs0TmTIjcoNRtmlxRlaBSA91DDJXRz2AK92aA1852NHCIJKWzTwIdR7tLt6RDEGg0DH670f/q1hN2UfSGs0qQaDnt4K7Z1OrcOuurFtXHZt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwsTv77n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45AFCC4CEDD;
	Thu, 13 Mar 2025 12:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741869040;
	bh=EnhTGsB0GEtdWZ535UcAN5y4TH4ZZmw8k8nH7MAVNO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MwsTv77nE7pMq19/5IRJEL/WGXIiPNham6XldIIaLG8Pd+GDR4pu7HE9yA73NhCQH
	 1HWYvgF2VH7NrZa8dLoSPhidx3krbbIxIsCAz618Y1H90/6RLcxRq6QGSASjHe8v6o
	 kr+L1cGcDa+lGIrKH+5kV4oY7CCCMKNSNtvOZF1Pvf12yjkz9YiFq32SBTuNvYCfu+
	 XtOYqRErE5/j1SDOp93SbARIrYHdTTQSUlj6RkD0oiRMb4e7ZgloyZUEglljYd6JjA
	 3t79BBKYyJtSvQyZSvq0TJCykbv3vTVfvYDZb6aMCaZktG0Yhl4Ag090SsaNLN1HCQ
	 jQTFWN0IEEXgg==
Date: Thu, 13 Mar 2025 14:30:34 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>, zyjzyj2000@gmail.com
Cc: linux-rdma@vger.kernel.org, jgg@ziepe.ca
Subject: Re: [PATCH for-next] RDMA/rxe: Fix incorrect return value of
 rxe_odp_atomic_op()
Message-ID: <20250313123034.GL1322339@unreal>
References: <20250313064540.2619115-1-matsuda-daisuke@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313064540.2619115-1-matsuda-daisuke@fujitsu.com>

On Thu, Mar 13, 2025 at 03:45:40PM +0900, Daisuke Matsuda wrote:
> rxe_mr_do_atomic_op() returns enum resp_states numbers, so the ODP
> counterpart must not return raw errno codes.
> 
> Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_odp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
> index 94f7bbe14981..9f6e2bb2a269 100644
> --- a/drivers/infiniband/sw/rxe/rxe_odp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
> @@ -316,7 +316,7 @@ int rxe_odp_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
>  	err = rxe_odp_map_range_and_lock(mr, iova, sizeof(char),
>  					 RXE_PAGEFAULT_DEFAULT);
>  	if (err < 0)
> -		return err;
> +		return RESPST_ERR_RKEY_VIOLATION;

I applied this patch for now, but please work to remove enum
resp_states. It is very bad practice to hide original in-kernel errors.

thanks

>  
>  	err = rxe_odp_do_atomic_op(mr, iova, opcode, compare, swap_add,
>  				   orig_val);
> -- 
> 2.43.0
> 

