Return-Path: <linux-rdma+bounces-4769-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9BC96D613
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Sep 2024 12:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA6F8B23691
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Sep 2024 10:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF30198A21;
	Thu,  5 Sep 2024 10:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxlXTQg+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8AD1991D8
	for <linux-rdma@vger.kernel.org>; Thu,  5 Sep 2024 10:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725532151; cv=none; b=d7uEe+H/dRKj+LYUQBZjs6tESopCZjsveVJAznEBNl3wWQ3Qo8Z9bjB+K0H2fWTzrvi+ufCGvjziGMSQqwNu/ADf32VH26bKqaMgm9HK5j1fvGfxsXeQSpjmhqgS5569AcFKiCSwEnwgeawVr8qYCm7UEANFOW1MuqaxrKPMdoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725532151; c=relaxed/simple;
	bh=AXiniroZhgLlkYwov/4eiLVTSe3XvsJI9ZXGviWFDYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ugboDa+kj0y2NgcRKtaqGu0AYfiNwZa09VmWnx39qkBxh4R95kSABPv9XuGRWETM3Zk4b9Z9o6Ea3u9UqWISONOPfKrlR02PArr+4rCEKuSB2GoZvPysaADkmlx6q85TwuizJVn0FO6Gk1P4Ri0qLWvhIPiM6YYa6LtHUxVcRlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxlXTQg+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF338C4CEC3;
	Thu,  5 Sep 2024 10:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725532150;
	bh=AXiniroZhgLlkYwov/4eiLVTSe3XvsJI9ZXGviWFDYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YxlXTQg+ZPIGEnxI6rLXA7y6ZJv7CS9cB1IH22LvgCsfaKgXsZT0K3ygRqc2F0+Js
	 CIIQM1lEh8aUagCVr2bgNWsa9tWOA2MePyHz1c/0/wvLXHuh4VImfN1OJYh0J3mNXi
	 qr0BPgIOG3pgQS/wyE3X5/XspaDS2XGdAAflyad1W3QfIMGeKbmsdPaZCHjDZ96I8P
	 rnK5NgYJKb2S7zIWJXhq+HUFwtHpx9K/0xKCtO2o8rI+CPjONNSLdZGtJ+bg4kvlx6
	 GLzI9CX/gcu0W3k7Yph2TUQjphcV3Tow7gGZfgXw+MJ3eOBcH1oZjCvoBWg0DH4ZTc
	 afZQhn75H99Dg==
Date: Thu, 5 Sep 2024 13:29:06 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Selvin Xavier <selvin.xavier@broadcom.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH for-next 3/4] RDMA/bnxt_re: Add support to handle
 DCB_CONFIG_CHANGE event
Message-ID: <20240905102906.GT4026@unreal>
References: <1725363051-19268-1-git-send-email-selvin.xavier@broadcom.com>
 <1725363051-19268-4-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1725363051-19268-4-git-send-email-selvin.xavier@broadcom.com>

On Tue, Sep 03, 2024 at 04:30:50AM -0700, Selvin Xavier wrote:
> From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> 
> QP1 context in HW needs to be updated when there is a
> change in the default DSCP values used for RoCE traffic.
> Handle the event from FW and modify the dscp value used
> by QP1.
> 
> Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/bnxt_re.h  |   1 +
>  drivers/infiniband/hw/bnxt_re/main.c     | 105 +++++++++++++++++++++++++++++++
>  drivers/infiniband/hw/bnxt_re/qplib_fp.h |   2 +
>  drivers/infiniband/hw/bnxt_re/qplib_sp.h |   1 +
>  4 files changed, 109 insertions(+)

<...>

> +static void bnxt_re_uninit_dcb_wq(struct bnxt_re_dev *rdev)
> +{
> +	if (!rdev->dcb_wq)
> +		return;
> +	flush_workqueue(rdev->dcb_wq);
> +	destroy_workqueue(rdev->dcb_wq);

There is no need in flush_workqueue() as destroy_workqueue() will do it.

> +	rdev->dcb_wq = NULL;

Is this assignment needed?

> +}

Thanks

