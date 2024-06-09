Return-Path: <linux-rdma+bounces-3013-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D2D9014F0
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Jun 2024 10:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C63F31F21523
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Jun 2024 08:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68017EAE9;
	Sun,  9 Jun 2024 08:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CyEZRszC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F85BE4F
	for <linux-rdma@vger.kernel.org>; Sun,  9 Jun 2024 08:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717921503; cv=none; b=nVuoLhrpm8FOK2Y0q0fjNYRVe6isBZwP3wN7QnRrOEnEdL+0P13QMpzl+8nFsVdXtgWcGdx8KrU/E9sUBMzhkX61cDYUT1YepMRzHVkadlUglP1TvXTEa7YwWoIfCyEyKNayMENIe12rDqZmRjrY8BiQGw38tm6iZjQuQmzk9+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717921503; c=relaxed/simple;
	bh=g3+xLmhQyYah+bh00/4xl+QNJSsrj1dXs8Rc3x2kvXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i17x0O41fSqpyTZ1uu/SlTzLohEzoYFhRPL9pEayukNAO5OgLM1DysaoZsmGhDvLVFAYrN7E+rQr5A90BtZHsOLzJAuOnJbFGPVHm3iO0L3e4jkGW+9Eq68L7XJZM4NNc0xgDOjjo3LKhh94yDOCL1rz++u/8Sr4ZeUStvCMbYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CyEZRszC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2726DC2BD10;
	Sun,  9 Jun 2024 08:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717921502;
	bh=g3+xLmhQyYah+bh00/4xl+QNJSsrj1dXs8Rc3x2kvXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CyEZRszCbC207wkoLXvgbCMC5ZF5GOJJ2aGt2whZvpdrn3MW6ODnt62Szz5v8XOyM
	 n5Dp2TSR91cGop2UY6aFHXpoO/F4HeUB/9rj/ItesGTkXKTAZ8EiS4aYM+4eo36g6j
	 hfusfAvoClnU4ThnPoIwyH13ZvGlEsMy36SefenavRXk6NEC2RZbTSqR96PvMbwALz
	 R4VXHcpIBlxVpz7aCQux87YPDvfh3gcxrSi6jwR0vcsswZvoYxD8nMt+owOHvmTDlg
	 oxYVFDfQrtpqIywEvjUxuSZS7lQ1rc2aWHlf/MScpp9bIeh3/1SttNZwYCn2EoT5kb
	 3hNLDh/fb642w==
Date: Sun, 9 Jun 2024 11:24:57 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>, linux-rdma@vger.kernel.org,
	Zhu Yanjun <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Joel Granados <j.granados@samsung.com>
Subject: Re: [PATCH 5/5] RDMA/iwcm: Fix a use-after-free related to
 destroying CM IDs
Message-ID: <20240609082457.GA8976@unreal>
References: <20240605145117.397751-1-bvanassche@acm.org>
 <20240605145117.397751-6-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605145117.397751-6-bvanassche@acm.org>

On Wed, Jun 05, 2024 at 08:51:01AM -0600, Bart Van Assche wrote:
> iw_conn_req_handler() associates a new struct rdma_id_private (conn_id) with
> an existing struct iw_cm_id (cm_id) as follows:
> 
>         conn_id->cm_id.iw = cm_id;
>         cm_id->context = conn_id;
>         cm_id->cm_handler = cma_iw_handler;
> 
> rdma_destroy_id() frees both the cm_id and the struct rdma_id_private. Make
> sure that cm_work_handler() does not trigger a use-after-free by only
> freeing of the struct rdma_id_private after all pending work has finished.
> 
> Cc: stable

This is not right way to mark a patch for stable. I added the following
to the commit message and applied the patch:

Cc: stable@vger.kernel.org
Fixes: 59c68ac31e15 ("iw_cm: free cm_id resources on the last deref")

There is no clear Fixes tag which I can use, so I used the latest significant
commit that touch that area.

Thanks

> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/infiniband/core/iwcm.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)

