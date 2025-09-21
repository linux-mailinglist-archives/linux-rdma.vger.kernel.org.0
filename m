Return-Path: <linux-rdma+bounces-13531-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D38CB8DA33
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Sep 2025 13:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51070189DF1D
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Sep 2025 11:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDD5266565;
	Sun, 21 Sep 2025 11:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kh8x790i"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D6A155A30;
	Sun, 21 Sep 2025 11:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758454139; cv=none; b=VYHh0UYzZNGh4QPR0TXDNmiYFi6/I1Lj31aBjdNOJaTNszy+5jXYH7KrhnHqtf0vlegVTwN4JwHUOQOP85P2bUcgYnOMZYxthrrbgnsEqXmJvMmfwyh5/osHIa5D7oMEVLV31wRiadgvii3y4bBDbKPVezk5F4rp24T1rScoBYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758454139; c=relaxed/simple;
	bh=cbYx3xO3GH7BFaxpMuXiS/p7n2UGOfMP0gztbwVmuGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qhFmspUN3Ldge55Q6dwF52YMUNmuynyMTVaraoNNV/XtsmpafF4QcCOkiCjuyZw3P6pKh21nl/R3VFrk3ckOq0n167axVyAtRDPk+hLljWLLqk+dygCWm5MVziu+6vIdyRSDRM1I5+LoAWL3E77pjTlpuPwbhQziv51/zWMGFIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kh8x790i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1B9C4CEE7;
	Sun, 21 Sep 2025 11:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758454138;
	bh=cbYx3xO3GH7BFaxpMuXiS/p7n2UGOfMP0gztbwVmuGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kh8x790iiubcpqW5VidKg+bW7AzxBtDJ/GV0EHyWJHhVU5UbzTFAYkH342BmXjxUD
	 XBFu21li1ZQkqMCTiAuuKfuO/O9hgB7WfstWrlGLnryR1+v74cV8LukyXmPCowxDNo
	 Ue5gkUDiv/Gs8ighh/yg06Hcu2q1s0qKca/MnRdxB23rxcH79/EM+5RSCTeoHxMDBr
	 mtPFiziTE4xWhv/uKIqkA61IuuKApTm6j4H0QwwIUac6MfcxU64T1FnEs67yRt/0yl
	 djpnvM/HsUI+8UZY27LkEu5QSZqL5Ie/xkKpNZM5HBQxB2CDD/BMzw6lPKcda3abNz
	 OEUyIx33LCcKA==
Date: Sun, 21 Sep 2025 14:28:54 +0300
From: Leon Romanovsky <leon@kernel.org>
To: YanLong Dai <dyl_wlc@163.com>
Cc: kalesh-anakkur.purayil@broadcom.com, jgg@ziepe.ca,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	selvin.xavier@broadcom.com, daiyanlong@kylinos.cn
Subject: Re: [PATCH rdma-rc] RDMA/bnxt_re: Fix a potential memory leak in
 destroy_gsi_sqp
Message-ID: <20250921112854.GI10800@unreal>
References: <20250919054238.5374-1-dyl_wlc@163.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919054238.5374-1-dyl_wlc@163.com>

On Fri, Sep 19, 2025 at 01:42:38PM +0800, YanLong Dai wrote:
> From: daiyanlong <daiyanlong@kylinos.cn>
> 
> The current error handling path in bnxt_re_destroy_gsi_sqp() could lead
> to a resource leak. When bnxt_qplib_destroy_qp() fails, the function
> jumps to the 'fail' label and returns immediately, skipping the call
> to bnxt_qplib_free_qp_res().
> 
> Continue the resource teardown even if bnxt_qplib_destroy_qp() fails,
> which aligns with the driver's general error handling strategy and
> prevents the potential leak.
> 
> Fixes: 8dae419f9ec73 ("RDMA/bnxt_re: Refactor queue pair creation code")
> 
> Signed-off-by: daiyanlong <daiyanlong@kylinos.cn>

Documentation/process/submitting-patches.rst
  396 Sign your work - the Developer's Certificate of Origin
  397 ------------------------------------------------------
  398
  ...
  440 using a known identity (sorry, no anonymous contributions.)

Thanks

> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> index 260dc67b8b87..15d3f5d5c0ee 100644
> --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> @@ -931,10 +931,9 @@ static int bnxt_re_destroy_gsi_sqp(struct bnxt_re_qp *qp)
>  
>  	ibdev_dbg(&rdev->ibdev, "Destroy the shadow QP\n");
>  	rc = bnxt_qplib_destroy_qp(&rdev->qplib_res, &gsi_sqp->qplib_qp);
> -	if (rc) {
> +	if (rc)
>  		ibdev_err(&rdev->ibdev, "Destroy Shadow QP failed");
> -		goto fail;
> -	}
> +
>  	bnxt_qplib_free_qp_res(&rdev->qplib_res, &gsi_sqp->qplib_qp);
>  
>  	/* remove from active qp list */
> @@ -951,8 +950,6 @@ static int bnxt_re_destroy_gsi_sqp(struct bnxt_re_qp *qp)
>  	rdev->gsi_ctx.sqp_tbl = NULL;
>  
>  	return 0;
> -fail:
> -	return rc;
>  }
>  
>  /* Queue Pairs */
> -- 
> 2.43.0
> 

