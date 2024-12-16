Return-Path: <linux-rdma+bounces-6543-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 904A39F3196
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Dec 2024 14:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C54977A327F
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Dec 2024 13:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEDF20551E;
	Mon, 16 Dec 2024 13:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjKJfeUI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D148B19066D
	for <linux-rdma@vger.kernel.org>; Mon, 16 Dec 2024 13:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734355929; cv=none; b=HJh2pSgsehBZgN7doWOM0ydNeUDWZjqNeb1YB8jg1/9YBjxz8n7YM9BGcvpO+Try0hIoeRtgWYkFI+bkBZhBsKsWsib++nCaOpw+RzU+efwKKH+g9p4LjUUuQkFFEB1NKSSfhWUfGl2lg1aQgZTbLkvByDAJph34vbusnsWRz88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734355929; c=relaxed/simple;
	bh=ATCWS4KxP6+yU0qUUnDkBOsdHCOy1Obr3suOEmvmYEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8TbM5Qok4Gr70MnK11GD5KsUNazSeNwnm87xV9DjlsBem4CfLPBXb5lFcvpw7FPU8CmpZUSRbENe+RUSibpnJIO7mvorvAp9aQqXpEUfgdSo/zgP0LsTlHExeEefSHmL6pisKV9GM4DE/hSCWTOwsLfGr8Miz2SGJ6pbABm4ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjKJfeUI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4552C4CED0;
	Mon, 16 Dec 2024 13:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734355929;
	bh=ATCWS4KxP6+yU0qUUnDkBOsdHCOy1Obr3suOEmvmYEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FjKJfeUIvahb2QNf/Lrzobyu/CViP7IkQChnXlisSUTaYyV7cPPZwOEIaLstA2kW1
	 JCCVqm3WSOvKOsPKwXbo/0m7ToANK1M8jQq0ItFbz+/OByyhFSolfRgyl0rPCOW2B7
	 VbSeqayD6hDP0w2h0XZ9G35u91EuycH5JO60q+9y6hn/W8pbt2yXsvOzB7WE/noDsN
	 0Gxjt9fDkdvAePNm/oVGTokgQGtEoIGnrnpXZ8WjKw7UTv8m/Z4yhywiJ47YAmhbPn
	 acqEA6U1lRzFW2avw/TYEiVHgrZEBWBtNJ80nlSwZTxlpqs+AenmDfDswAE1CiG4Bf
	 PPWmGlDNOPUFA==
Date: Mon, 16 Dec 2024 15:32:04 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	Preethi G <preethi.gurusiddalingeswaraswamy@broadcom.com>
Subject: Re: [PATCH for-rc 5/5] RDMA/bnxt_re: Fix reporting hw_ver in
 query_device
Message-ID: <20241216133204.GJ1245331@unreal>
References: <20241211083931.968831-1-kalesh-anakkur.purayil@broadcom.com>
 <20241211083931.968831-6-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211083931.968831-6-kalesh-anakkur.purayil@broadcom.com>

On Wed, Dec 11, 2024 at 02:09:31PM +0530, Kalesh AP wrote:
> Driver currently populates subsystem_device id in the
> "hw_ver" field of ib_attr structure in query_device.

I applied this patch, but it is not currently, it was the case for last
7 years and it has chances to break your customers.

Thanks

> 
> Updated to populate PCI revision ID.
> 
> Fixes: 1ac5a4047975 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
> Reviewed-by: Preethi G <preethi.gurusiddalingeswaraswamy@broadcom.com>
> Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> index bcb7cfc63d09..e3d26bd6de05 100644
> --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> @@ -199,7 +199,7 @@ int bnxt_re_query_device(struct ib_device *ibdev,
>  
>  	ib_attr->vendor_id = rdev->en_dev->pdev->vendor;
>  	ib_attr->vendor_part_id = rdev->en_dev->pdev->device;
> -	ib_attr->hw_ver = rdev->en_dev->pdev->subsystem_device;
> +	ib_attr->hw_ver = rdev->en_dev->pdev->revision;
>  	ib_attr->max_qp = dev_attr->max_qp;
>  	ib_attr->max_qp_wr = dev_attr->max_qp_wqes;
>  	ib_attr->device_cap_flags =
> -- 
> 2.43.5
> 

