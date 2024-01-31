Return-Path: <linux-rdma+bounces-834-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52348843FAA
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jan 2024 13:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76ECB1C271B5
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jan 2024 12:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BB97AE50;
	Wed, 31 Jan 2024 12:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZpnI/Px"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF46C79DDF;
	Wed, 31 Jan 2024 12:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706705442; cv=none; b=iAymcL6wsyk7ldgCvhWnGoxif28pk/T7VbLHiiW11+Hq1l4ix3ew5fdP3W4UmUkeiOuN2OWuah84jMlaLt/WrxOCgiZTZv7fM5XDCRX9L7eA/I7GpeI9l3Q1QHk6BX1KZwguNByjNAJL9NzQdP12bYYlCyejNPjJWBLbg10LLUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706705442; c=relaxed/simple;
	bh=RHrTYtjNRuLO1M8OAwEXyjHhu2rKdRpSTOU9mSp3TKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hpZv0Suls9CIyXihoubtaAfUWGeNchmMo8pyNT1eppokbnIb2+vf/WAGevxsI3OLeqg8ecMMTDQf5QXd3mZFvZetOc3kLCpt36ONlL4vuE+DjJA2fA4B/hY4urQDnqUbYFhFAdpI0dXKjHvtIqBtL+IeOZk49FE3lKS8px04C7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZpnI/Px; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1ACDC433C7;
	Wed, 31 Jan 2024 12:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706705442;
	bh=RHrTYtjNRuLO1M8OAwEXyjHhu2rKdRpSTOU9mSp3TKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tZpnI/Pxr/BNixfR5YQwEkVC0VCJn/HgEAYGry3QuEGwjEJ9lyN2a0DVxcMq7TcmU
	 zF3tosaaYGdAfDUQmR0UuBqASgJfh5G5NhLfuuX2m4z4qLi4QgApzFLXa6BRtCwqBR
	 UV+76I6uHWU5I2T7A6JOuHPtRbb43+eW7tV3n7XPMJrC9mws5C697YKBATsXUbF8Bs
	 Znn6/jbmeLEUie68X6VLT+ILwWrMc4JSEsbH6gjkyg/jjHsJoQgeguP+4h6me0vXPu
	 oW5TjgEMafJYGAJVKwG1v5lSpZRDdvz7Y9NDLBa8CqsXnaupLpvUMEv/GBBhzG04Em
	 +cZ+xZ5G9vRqg==
Date: Wed, 31 Jan 2024 14:50:37 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Daniel Vacek <neelx@redhat.com>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Brendan Cunningham <bcunningham@cornelisnetworks.com>,
	Patrick Kelsey <pat.kelsey@cornelisnetworks.com>,
	stable@vger.kernel.org, Mats Kronberg <kronberg@nsc.liu.se>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/hfi1: Fix sdma.h tx->num_descs off-by-one error (take
 two)
Message-ID: <20240131125037.GF71813@unreal>
References: <20240126152125.869509-1-neelx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126152125.869509-1-neelx@redhat.com>

On Fri, Jan 26, 2024 at 04:21:23PM +0100, Daniel Vacek wrote:
> Unfortunately the commit `fd8958efe877` introduced another error
> causing the `descs` array to overflow. This reults in further crashes
> easily reproducible by `sendmsg` system call.
> 
> [ 1080.836473] general protection fault, probably for non-canonical address 0x400300015528b00a: 0000 [#1] PREEMPT SMP PTI
> [ 1080.869326] RIP: 0010:hfi1_ipoib_build_ib_tx_headers.constprop.0+0xe1/0x2b0 [hfi1]
> --
> [ 1080.974535] Call Trace:
> [ 1080.976990]  <TASK>
> [ 1081.021929]  hfi1_ipoib_send_dma_common+0x7a/0x2e0 [hfi1]
> [ 1081.027364]  hfi1_ipoib_send_dma_list+0x62/0x270 [hfi1]
> [ 1081.032633]  hfi1_ipoib_send+0x112/0x300 [hfi1]
> [ 1081.042001]  ipoib_start_xmit+0x2a9/0x2d0 [ib_ipoib]
> [ 1081.046978]  dev_hard_start_xmit+0xc4/0x210
> --
> [ 1081.148347]  __sys_sendmsg+0x59/0xa0
> 
> crash> ipoib_txreq 0xffff9cfeba229f00
> struct ipoib_txreq {
>   txreq = {
>     list = {
>       next = 0xffff9cfeba229f00,
>       prev = 0xffff9cfeba229f00
>     },
>     descp = 0xffff9cfeba229f40,
>     coalesce_buf = 0x0,
>     wait = 0xffff9cfea4e69a48,
>     complete = 0xffffffffc0fe0760 <hfi1_ipoib_sdma_complete>,
>     packet_len = 0x46d,
>     tlen = 0x0,
>     num_desc = 0x0,
>     desc_limit = 0x6,
>     next_descq_idx = 0x45c,
>     coalesce_idx = 0x0,
>     flags = 0x0,
>     descs = {{
>         qw = {0x8024000120dffb00, 0x4}  # SDMA_DESC0_FIRST_DESC_FLAG (bit 63)
>       }, {
>         qw = {  0x3800014231b108, 0x4}
>       }, {
>         qw = { 0x310000e4ee0fcf0, 0x8}
>       }, {
>         qw = {  0x3000012e9f8000, 0x8}
>       }, {
>         qw = {  0x59000dfb9d0000, 0x8}
>       }, {
>         qw = {  0x78000e02e40000, 0x8}
>       }}
>   },
>   sdma_hdr =  0x400300015528b000,  <<< invalid pointer in the tx request structure
>   sdma_status = 0x0,                   SDMA_DESC0_LAST_DESC_FLAG (bit 62)
>   complete = 0x0,
>   priv = 0x0,
>   txq = 0xffff9cfea4e69880,
>   skb = 0xffff9d099809f400
> }
> 
> With this patch the crashes are no longer reproducible and the machine is stable.
> 
> Note, the header file changes are just an unrelated clean-up while I was looking
> around trying to find the bug.
> 
> Fixes: fd8958efe877 ("IB/hfi1: Fix sdma.h tx->num_descs off-by-one errors")
> Cc: stable@vger.kernel.org
> Reported-by: Mats Kronberg <kronberg@nsc.liu.se>
> Tested-by: Mats Kronberg <kronberg@nsc.liu.se>
> Signed-off-by: Daniel Vacek <neelx@redhat.com>
> ---
>  drivers/infiniband/hw/hfi1/sdma.c |  2 +-
>  drivers/infiniband/hw/hfi1/sdma.h | 17 +++++++----------
>  2 files changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hfi1/sdma.c b/drivers/infiniband/hw/hfi1/sdma.c
> index 6e5ac2023328a..b67d23b1f2862 100644
> --- a/drivers/infiniband/hw/hfi1/sdma.c
> +++ b/drivers/infiniband/hw/hfi1/sdma.c
> @@ -3158,7 +3158,7 @@ int _pad_sdma_tx_descs(struct hfi1_devdata *dd, struct sdma_txreq *tx)
>  {
>  	int rval = 0;
>  
> -	if ((unlikely(tx->num_desc + 1 == tx->desc_limit))) {
> +	if ((unlikely(tx->num_desc == tx->desc_limit))) {

Maybe, Dennis?

>  		rval = _extend_sdma_tx_descs(dd, tx);
>  		if (rval) {
>  			__sdma_txclean(dd, tx);
> diff --git a/drivers/infiniband/hw/hfi1/sdma.h b/drivers/infiniband/hw/hfi1/sdma.h
> index d77246b48434f..362815a8da267 100644
> --- a/drivers/infiniband/hw/hfi1/sdma.h
> +++ b/drivers/infiniband/hw/hfi1/sdma.h
> @@ -639,13 +639,13 @@ static inline void sdma_txclean(struct hfi1_devdata *dd, struct sdma_txreq *tx)
>  static inline void _sdma_close_tx(struct hfi1_devdata *dd,
>  				  struct sdma_txreq *tx)
>  {
> -	u16 last_desc = tx->num_desc - 1;
> +	struct sdma_desc *desc = &tx->descp[tx->num_desc - 1];
>  
> -	tx->descp[last_desc].qw[0] |= SDMA_DESC0_LAST_DESC_FLAG;
> -	tx->descp[last_desc].qw[1] |= dd->default_desc1;
> +	desc->qw[0] |= SDMA_DESC0_LAST_DESC_FLAG;
> +	desc->qw[1] |= dd->default_desc1;
>  	if (tx->flags & SDMA_TXREQ_F_URGENT)
> -		tx->descp[last_desc].qw[1] |= (SDMA_DESC1_HEAD_TO_HOST_FLAG |
> -					       SDMA_DESC1_INT_REQ_FLAG);
> +		desc->qw[1] |= (SDMA_DESC1_HEAD_TO_HOST_FLAG |
> +				SDMA_DESC1_INT_REQ_FLAG);

Unrelated change which doesn't change anything.

>  }
>  
>  static inline int _sdma_txadd_daddr(
> @@ -670,13 +670,10 @@ static inline int _sdma_txadd_daddr(
>  	tx->tlen -= len;
>  	/* special cases for last */
>  	if (!tx->tlen) {
> -		if (tx->packet_len & (sizeof(u32) - 1)) {
> +		if (tx->packet_len & (sizeof(u32) - 1))
>  			rval = _pad_sdma_tx_descs(dd, tx);
> -			if (rval)
> -				return rval;
> -		} else {
> +		else
>  			_sdma_close_tx(dd, tx);
> -		}

Same as before, unrelated change.

>  	}
>  	return rval;
>  }
> -- 
> 2.43.0
> 

