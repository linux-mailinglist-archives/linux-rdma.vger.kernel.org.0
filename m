Return-Path: <linux-rdma+bounces-7006-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E871A1054A
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jan 2025 12:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF19B3A7172
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jan 2025 11:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02C32309AC;
	Tue, 14 Jan 2025 11:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brk8G+6k"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B041620F97C
	for <linux-rdma@vger.kernel.org>; Tue, 14 Jan 2025 11:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736853961; cv=none; b=gXvE4Fnm/Av6PNdQW+5Q/931ayQFTv1f+yYWTuGk2LcWKZTLj0duxtCoaixceUmwMeX1HEQvaNyDqUj+SF0KGDjpjyRoDFgzc6a51MXbRNz+qCSgC6a+o9fDDkSsgQRp7nmVQB2gGlzVhKs5LPMzJty3izNQgZWpDuo4qXmtSHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736853961; c=relaxed/simple;
	bh=y+3QYDRo0AS26gA4QeRQLeZxwT2FTH73LSbLR4ePQrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODqFypiAKy3cvBjBmeZV6ePpeDM+u//rSli3LzFfJwDToUy65PTarw1bKWeYTf6R/gkY2O827hMspoz9oktoPsfqHxYDuaXo5No2+Ukvl2Bf+lV85D1SocTNYYe7hLwaYB8MtVqiB6NI83vK7wBqnVw29rerrVJ2Qa/+BhC6UYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brk8G+6k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E250C4CEDD;
	Tue, 14 Jan 2025 11:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736853961;
	bh=y+3QYDRo0AS26gA4QeRQLeZxwT2FTH73LSbLR4ePQrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=brk8G+6kQrIDJLqkH4vaMiaSQCtv1EJ+/1Fy+kUyS8qBQgtVkIQX2XFZ+DIu0DJsp
	 bF7r4nLB1B1pVOa5C03XtY3Cb035f6HVuzVW8H/vIBXqvPPHmw4gKiB9uGAsYgGhSU
	 v8trNFakQDd2lPeYVMhAWLHqQpiqAQjyosSIkhEwcFxxFDXi1+qHEMJIm85JI6lEE3
	 irjeA7n+5Iy+qgM7xZFaODRLHmf41ZhUAGrqDkHrFoaVORnOeVeQ4wEg0WmPVOyg9H
	 TeYsZH+YtlyEmxhUTYF9SnrVQeBYlAKjxL2YeiXGgGoecOfRMddwKefCoYZ37+QnyH
	 p67HDNoO4a0UA==
Date: Tue, 14 Jan 2025 13:25:55 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Selvin Xavier <selvin.xavier@broadcom.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH for-next 2/2] RDMA/bnxt_re: Allocate dev_attr information
 dynamically
Message-ID: <20250114112555.GG3146852@unreal>
References: <1736446693-6692-1-git-send-email-selvin.xavier@broadcom.com>
 <1736446693-6692-3-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1736446693-6692-3-git-send-email-selvin.xavier@broadcom.com>

On Thu, Jan 09, 2025 at 10:18:13AM -0800, Selvin Xavier wrote:
> From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> 
> In order to optimize the size of driver private structure,
> the memory for dev_attr is allocated dynamically during the
> chip context initialization. In order to make certain runtime
> decisions, store dev_attr in the qplib_res structure.
> 
> Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/bnxt_re.h     |  2 +-
>  drivers/infiniband/hw/bnxt_re/hw_counters.c |  2 +-
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c    | 38 ++++++++++++++---------------
>  drivers/infiniband/hw/bnxt_re/main.c        | 36 +++++++++++++++++----------
>  drivers/infiniband/hw/bnxt_re/qplib_res.c   |  7 +++---
>  drivers/infiniband/hw/bnxt_re/qplib_res.h   |  4 +--
>  drivers/infiniband/hw/bnxt_re/qplib_sp.c    |  4 +--
>  drivers/infiniband/hw/bnxt_re/qplib_sp.h    |  3 +--
>  8 files changed, 51 insertions(+), 45 deletions(-)

<...>

> index 33956fc..7c7057b 100644
> --- a/drivers/infiniband/hw/bnxt_re/main.c
> +++ b/drivers/infiniband/hw/bnxt_re/main.c
> @@ -148,6 +148,10 @@ static void bnxt_re_destroy_chip_ctx(struct bnxt_re_dev *rdev)
>  
>  	if (!rdev->chip_ctx)
>  		return;
> +
> +	kfree(rdev->dev_attr);
> +	rdev->dev_attr = NULL;
> +

I'm taking this patch, but please let's stop this practice of setting NULL
for the pointers which are not going to be reused. Such assignment hides bugs.

Thanks

