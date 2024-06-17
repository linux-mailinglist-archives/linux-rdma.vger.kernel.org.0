Return-Path: <linux-rdma+bounces-3207-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5788B90AF13
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 15:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DE801C20CF9
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 13:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173A419B3F3;
	Mon, 17 Jun 2024 13:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UaHpX00H"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2ECA17FAA2;
	Mon, 17 Jun 2024 13:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630291; cv=none; b=O2cvS1O49g4xMDNuvvom0tuUb3dxF+BGWtjN22KrUtl6gQO+hP/DLDAXnnq16qClqA6P0aE1K+rvxsOC3o0qGsE+tvHLMU0/HalgtgwLJIHGxKQz8Q+WiZawAYoTo1076386otyKfAoCyYtOr5hVjbj6+IrjdNudLGzZ2PU/eCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630291; c=relaxed/simple;
	bh=gtTvgsZapgBgfFHVMZ2FpeBT5zJ8mnTafDMFjnTGrW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YH35BIxSV2W//om2I804N3hmBxmqEKR8CM00SP3t3vnf5J+kxSIhXN0ptNixffb8owbxOYDSU3TgRqOjPkWWSuErtbq7/ziJuRV6D03JhVwv9wIJmG6cc/O/OdcKCtS36WddQxPGUFMukHmRAaPOblkWgyN1nDGz2I7Ag+CjDbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UaHpX00H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F09C2BD10;
	Mon, 17 Jun 2024 13:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630291;
	bh=gtTvgsZapgBgfFHVMZ2FpeBT5zJ8mnTafDMFjnTGrW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UaHpX00HJrBDUziBt452PjFgQyHAtm6wJzsifYNNB5SjBy1idVcFy01BBfdLGAsjb
	 /LZv5YsIpDu+Kf3JH0oxbNN0l9w9o14AUaQPyuHYhTXyie/nLRBMclt6MJYzOoYM7F
	 PRrGiuW6zODa0d57FMu4JfvftQQ+jaqqKPDZsMw/8MvvGXYPiLE5d9ybXIRXDl5yzk
	 VAyd9ZD+oV0JfL7p1BTBOFdcFQADHkgb9+KCv/7mU4rL6bGyYUKSL/esSb8WNy42sB
	 eleVuaG46S9EqdAVLCCYjKZX7hHOMFBFXYr2M7kcX6WvIbyh4vDv9sol49y6yceWbP
	 c+EYeXE+0xvyA==
Date: Mon, 17 Jun 2024 16:18:07 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Omer Shpigelman <oshpigelman@habana.ai>
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	ogabbay@kernel.org, zyehudai@habana.ai
Subject: Re: [PATCH 04/15] net: hbl_cn: QP state machine
Message-ID: <20240617131807.GE6805@unreal>
References: <20240613082208.1439968-1-oshpigelman@habana.ai>
 <20240613082208.1439968-5-oshpigelman@habana.ai>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613082208.1439968-5-oshpigelman@habana.ai>

On Thu, Jun 13, 2024 at 11:21:57AM +0300, Omer Shpigelman wrote:
> Add a common QP state machine which handles the moving for a QP from one
> state to another including performing necessary checks, draining
> in-flight transactions, invalidating caches and error reporting.
> 
> Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
> Co-developed-by: Abhilash K V <kvabhilash@habana.ai>
> Signed-off-by: Abhilash K V <kvabhilash@habana.ai>
> Co-developed-by: Andrey Agranovich <aagranovich@habana.ai>
> Signed-off-by: Andrey Agranovich <aagranovich@habana.ai>
> Co-developed-by: Bharat Jauhari <bjauhari@habana.ai>
> Signed-off-by: Bharat Jauhari <bjauhari@habana.ai>
> Co-developed-by: David Meriin <dmeriin@habana.ai>
> Signed-off-by: David Meriin <dmeriin@habana.ai>
> Co-developed-by: Sagiv Ozeri <sozeri@habana.ai>
> Signed-off-by: Sagiv Ozeri <sozeri@habana.ai>
> Co-developed-by: Zvika Yehudai <zyehudai@habana.ai>
> Signed-off-by: Zvika Yehudai <zyehudai@habana.ai>
> ---
>  .../ethernet/intel/hbl_cn/common/hbl_cn_qp.c  | 480 +++++++++++++++++-
>  1 file changed, 479 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/hbl_cn/common/hbl_cn_qp.c b/drivers/net/ethernet/intel/hbl_cn/common/hbl_cn_qp.c
> index 9ddc23bf8194..26ebdf448193 100644
> --- a/drivers/net/ethernet/intel/hbl_cn/common/hbl_cn_qp.c
> +++ b/drivers/net/ethernet/intel/hbl_cn/common/hbl_cn_qp.c
> @@ -6,8 +6,486 @@

<...>

> +/* The following table represents the (valid) operations that can be performed on
> + * a QP in order to move it from one state to another
> + * For example: a QP in RTR state can be moved to RTS state using the CN_QP_OP_RTR_2RTS
> + * operation.
> + */
> +static const enum hbl_cn_qp_state_op qp_valid_state_op[CN_QP_NUM_STATE][CN_QP_NUM_STATE] = {
> +	[CN_QP_STATE_RESET] = {
> +		[CN_QP_STATE_RESET]	= CN_QP_OP_2RESET,
> +		[CN_QP_STATE_INIT]	= CN_QP_OP_RST_2INIT,
> +		[CN_QP_STATE_SQD]	= CN_QP_OP_NOP,
> +		[CN_QP_STATE_QPD]	= CN_QP_OP_NOP,
> +	},
> +	[CN_QP_STATE_INIT] = {
> +		[CN_QP_STATE_RESET]	= CN_QP_OP_2RESET,
> +		[CN_QP_STATE_ERR]	= CN_QP_OP_2ERR,
> +		[CN_QP_STATE_INIT]	= CN_QP_OP_NOP,
> +		[CN_QP_STATE_RTR]	= CN_QP_OP_INIT_2RTR,
> +		[CN_QP_STATE_SQD]	= CN_QP_OP_NOP,
> +		[CN_QP_STATE_QPD]	= CN_QP_OP_NOP,
> +	},
> +	[CN_QP_STATE_RTR] = {
> +		[CN_QP_STATE_RESET]	= CN_QP_OP_2RESET,
> +		[CN_QP_STATE_ERR]	= CN_QP_OP_2ERR,
> +		[CN_QP_STATE_RTR]	= CN_QP_OP_RTR_2RTR,
> +		[CN_QP_STATE_RTS]	= CN_QP_OP_RTR_2RTS,
> +		[CN_QP_STATE_SQD]	= CN_QP_OP_NOP,
> +		[CN_QP_STATE_QPD]	= CN_QP_OP_RTR_2QPD,
> +	},
> +	[CN_QP_STATE_RTS] = {
> +		[CN_QP_STATE_RESET]	= CN_QP_OP_2RESET,
> +		[CN_QP_STATE_ERR]	= CN_QP_OP_2ERR,
> +		[CN_QP_STATE_RTS]	= CN_QP_OP_RTS_2RTS,
> +		[CN_QP_STATE_SQD]	= CN_QP_OP_RTS_2SQD,
> +		[CN_QP_STATE_QPD]	= CN_QP_OP_RTS_2QPD,
> +		[CN_QP_STATE_SQERR]	= CN_QP_OP_RTS_2SQERR,
> +	},
> +	[CN_QP_STATE_SQD] = {
> +		[CN_QP_STATE_RESET]	= CN_QP_OP_2RESET,
> +		[CN_QP_STATE_ERR]	= CN_QP_OP_2ERR,
> +		[CN_QP_STATE_SQD]	= CN_QP_OP_SQD_2SQD,
> +		[CN_QP_STATE_RTS]	= CN_QP_OP_SQD_2RTS,
> +		[CN_QP_STATE_QPD]	= CN_QP_OP_SQD_2QPD,
> +		[CN_QP_STATE_SQERR]	= CN_QP_OP_SQD_2SQ_ERR,
> +	},
> +	[CN_QP_STATE_QPD] = {
> +		[CN_QP_STATE_RESET]	= CN_QP_OP_2RESET,
> +		[CN_QP_STATE_ERR]	= CN_QP_OP_2ERR,
> +		[CN_QP_STATE_SQD]	= CN_QP_OP_NOP,
> +		[CN_QP_STATE_QPD]	= CN_QP_OP_NOP,
> +		[CN_QP_STATE_RTR]	= CN_QP_OP_QPD_2RTR,
> +	},
> +	[CN_QP_STATE_SQERR] = {
> +		[CN_QP_STATE_RESET]	= CN_QP_OP_2RESET,
> +		[CN_QP_STATE_ERR]	= CN_QP_OP_2ERR,
> +		[CN_QP_STATE_SQD]	= CN_QP_OP_SQ_ERR_2SQD,
> +		[CN_QP_STATE_SQERR]	= CN_QP_OP_NOP,
> +	},
> +	[CN_QP_STATE_ERR] = {
> +		[CN_QP_STATE_RESET]	= CN_QP_OP_2RESET,
> +		[CN_QP_STATE_ERR]	= CN_QP_OP_2ERR,
> +	}
> +};

I don't understand why IBTA QP state machine is declared in ETH driver
and not in IB driver.

> +

<...>

> +		/* Release lock while we wait before retry.
> +		 * Note, we can assert that we are already locked.
> +		 */
> +		port_funcs->cfg_unlock(cn_port);
> +
> +		msleep(20);
> +
> +		port_funcs->cfg_lock(cn_port);

lock/unlock through ops pointer doesn't look like a good idea.

Thanks

