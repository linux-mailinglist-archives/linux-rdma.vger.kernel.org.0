Return-Path: <linux-rdma+bounces-13477-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85769B83F36
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 12:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11D253B1DEE
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 10:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A157A235345;
	Thu, 18 Sep 2025 10:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqOmpIHM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9C02AD0D;
	Thu, 18 Sep 2025 10:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758189730; cv=none; b=rfSGOr3MNcVTgMg9WY4/zNtSztgoNqYU8FBxRl6zvsG2ROqAy/3D0QBvSKvU0HbmEMUsvqjDovaCvwoCWZ+CfJNJERQU4B/o0BHjBudchSlFQPfozbFOzLivtLfl1dUiCe7WUioy749tTYtCQ3cD9/WWnDp6T8dwmDnNF1HrPNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758189730; c=relaxed/simple;
	bh=pIHGaGx2cvCcdeBapTyy30mussctO9oipC7Drg8JAGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVustMgTdPdTk6wsOTuaeQMMKEdFPPtMJpSEEIx2REmxKWBc7Oa+UP1ypC+EgNV5Y697tEImW2B0U8slVaSijFjfHtDr7wRGw5mnRtlQm1RRm3yAJexp2HoDBDDzQH6TxGJPpRYyiDoBkODIX5aDWr0nsnvWqK4TAIisIqm0RCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqOmpIHM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F2FCC4CEE7;
	Thu, 18 Sep 2025 10:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758189729;
	bh=pIHGaGx2cvCcdeBapTyy30mussctO9oipC7Drg8JAGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BqOmpIHMyFNBFwLBJtR6KPeDO744MKKgVeG73e401xgD+KZKJqtrpuKlWkC0EAPb0
	 1xLDv3dQGwLdlx80xX+WrXum3t3es+chioD1OzB3OaYrZ06V7NCP+ZTfiDoHf+tPKy
	 NjpJWZT56K+F64GXzGRYCGY0QiQvNS6+dl9RtJ17WJdfQ+F/y5Zju7UnFG0D8Af7lp
	 z/hP24IdDy/xq7xjYdXQI4wLjkP7lVoClorhzQaErUbCmIz9RWvmZi3LC/yky+hG0o
	 EOK2jqsvMmIgWAXZmRLT8DQ65GP8W4Ve22OayIyU23TGmRP+358bL9YfdH3DdBub9s
	 oK/sucryWEosQ==
Date: Thu, 18 Sep 2025 13:02:05 +0300
From: Leon Romanovsky <leon@kernel.org>
To: YanLong Dai <dyl_wlc@163.com>
Cc: kalesh-anakkur.purayil@broadcom.com, jgg@ziepe.ca,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	selvin.xavier@broadcom.com, daiyanlong@kylinos.cn
Subject: Re: [PATCH] drivers: fix the potential memory leak in
 bnxt_re_destroy_gsi_sqp()
Message-ID: <20250918100205.GE10800@unreal>
References: <20250916134915.GC82444@unreal>
 <20250917113539.6139-1-dyl_wlc@163.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917113539.6139-1-dyl_wlc@163.com>

On Wed, Sep 17, 2025 at 07:35:39PM +0800, YanLong Dai wrote:
> From: daiyanlong <daiyanlong@kylinos.cn>
> 
> As suggested by Kalesh Anakkur Purayil, fix the potential memory leak in bnxt_re_destroy_gsi_sqp() by continuing the teardown even if bnxt_qplib_destroy_qp() fails, we should not fail the resource destroy operations
> 
> Signed-off-by: daiyanlong <daiyanlong@kylinos.cn>
> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Please resend this patch as standalone and not as Reply-to to other conversion.
While you are doing that, make sure that your patch pass checkpatch.pl, break lines
in commit message, use real name in Signed-off-by and From fields, and
remove "rc" variable too, which is not used.

Thanks

> 
> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> index 260dc67b8b87..adee44aa0583 100644
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
> -- 
> 2.43.0
> 
> 

