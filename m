Return-Path: <linux-rdma+bounces-13413-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 694DFB59823
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Sep 2025 15:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EC8A1C00895
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Sep 2025 13:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14853115A0;
	Tue, 16 Sep 2025 13:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8BV94p7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF24101F2;
	Tue, 16 Sep 2025 13:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758030561; cv=none; b=R5n49zv/3O3FsntTUzPWmTIz29oOvdCtRYDlnMCATGTPUXKE1FflLTAB+ps0EhQJrB8dEK+t3FXI3M+51lYbvjA5nPa0QO32q0J4Z5CH10hlVTKkGRvONLnSSna3DZVC1Mi3CVanB0MsLBqwUg1jdUf0Fcd6uQWGU9v84ToDI2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758030561; c=relaxed/simple;
	bh=3tFDQ5PXjECZreGW2Mg6CH8zpQKyQ9QK7iQR7ImTgwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dRQ395NXFQUBj61pGWPUbGwu2l3UebvRvT1oYamp8kTJdx6NTcldtu1HTOi3SScaUBRSeyjUI+XV9yeWPx8/DqnCi5O92t82rBaTi7n0M6MitFAqy6fhSmPEsSjXvq2sMvmEu0YbzA4Fpssv8g74nGLIOMK46R5ewrZA2+Nar5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8BV94p7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52035C4CEEB;
	Tue, 16 Sep 2025 13:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758030560;
	bh=3tFDQ5PXjECZreGW2Mg6CH8zpQKyQ9QK7iQR7ImTgwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l8BV94p7UmQOOxN8y5wmI618lyCl4HmnCC4dPceeHbjEXcop4lrKlIHqr1Jhpam6B
	 8vEFCVf45kyObxowpSeeZBQLbmkAqZGN0oMXsHHDJDMhMofikVoKZZbV1ejR7Hgqo+
	 1VWW5m+zm30ugJHpHizGh5zsndh0fc9S9Inzjz4bj0697uDZk6AW3zYvg3TxXNk5QS
	 nG+FCZfa/vlV6nt3h7iF/iDB4EQggcFww046utrTeUej4jhL4flMGHNoZ1VJ6A4Xbe
	 FZSwq7AHfvBD4rBmcw1rBNW9/VgenQ6XioBXa1Gr3fDvD2gLD28rFwZTnuLfxHxDGC
	 ejMRCkH9w2L+Q==
Date: Tue, 16 Sep 2025 16:49:15 +0300
From: Leon Romanovsky <leon@kernel.org>
To: YanLong Dai <dyl_wlc@163.com>
Cc: selvin.xavier@broadcom.com, kalesh-anakkur.purayil@broadcom.com,
	jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, daiyanlong <daiyanlong@kylinos.cn>
Subject: Re: [PATCH] drivers: fix the exception was not returned
Message-ID: <20250916134915.GC82444@unreal>
References: <20250916091154.11421-1-dyl_wlc@163.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916091154.11421-1-dyl_wlc@163.com>

On Tue, Sep 16, 2025 at 05:11:54PM +0800, YanLong Dai wrote:
> From: daiyanlong <daiyanlong@kylinos.cn>
> 
> The return value rc of bnxt_qplib_destroy_qp is abnormal and no return

And what is wrong with that? This is expected behavior - do not fail if
destroy fails.

Thanks

> 
> Signed-off-by: daiyanlong <daiyanlong@kylinos.cn>
> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> index 260dc67b8b87..d52cfb50b1b8 100644
> --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> @@ -971,8 +971,10 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
>  	bnxt_qplib_flush_cqn_wq(&qp->qplib_qp);
>  
>  	rc = bnxt_qplib_destroy_qp(&rdev->qplib_res, &qp->qplib_qp);
> -	if (rc)
> +	if (rc) {
>  		ibdev_err(&rdev->ibdev, "Failed to destroy HW QP");
> +		return rc;
> +	}
>  
>  	if (rdma_is_kernel_res(&qp->ib_qp.res)) {
>  		flags = bnxt_re_lock_cqs(qp);
> -- 
> 2.43.0
> 

