Return-Path: <linux-rdma+bounces-3882-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 111B89324DB
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jul 2024 13:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42D851C225D7
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jul 2024 11:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185AE19A2B7;
	Tue, 16 Jul 2024 11:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/xxEemb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89C119A2AD;
	Tue, 16 Jul 2024 11:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721128486; cv=none; b=ErU2lEroN37lgzjlW60Mxj2+6nwX0LUf9HTHYH645HktRCXM9/NQOSbrOhNpY7x6Ie3ZiFwcMoKMWWOEIlTWQbXVItdNmNgRCZEA/zYjU6vkgOwGCXtenZakTcrLB8mIoOjjDVNPuDSKBlIkebODNx82VkfBCMdWmyi1Pc3U/Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721128486; c=relaxed/simple;
	bh=G4+VLCcg/b45RQgnNePdcHwL7ea9zBsjF9ASasTHUAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SfI1Rd469co/qy7oQIvNcGBLQjQ+OfFIhwmN6d/Xcoj8+6a2CMp3Ro7WN7BJ+uVmrxdGDf5MlifqObbpKJz8y5bNVufcNxxmyRi1HKe2fZWMi3vuoWzy/Ig21PdqnGWLsV1VAUpzBcqCKK5OzWHpxuTs4/T5LqFE2IV5zHzchrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/xxEemb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10A9C4AF0C;
	Tue, 16 Jul 2024 11:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721128486;
	bh=G4+VLCcg/b45RQgnNePdcHwL7ea9zBsjF9ASasTHUAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B/xxEembxHiHTvol43F5xJlxtJeOX84SnX9+G71kjHAeQLyxEh8f8AL1/MFkx+i2z
	 w5Zub6SQ56H/SeXsSCX0f7+7sbcxwTPMtflqzF5PNOBOilLL/cWx0SNuB7AMzil4ai
	 iQgghVvoQ43esG1aK3IEBlP0w8w8XUSt9PtA7lkWG7Ar5MzMHDl3YH5s/OirisLGlp
	 vxxAdY6oHy/g7Q8bhNdCIQ5ozM45BKox/TLFOM2yCuRU8JuBJHTPinN7hfeIL45i6N
	 CwB5RFb0wiBSxCYh2IQLfFZIyW2VOLgdnP7BcECDSMPSQhl6/koj994I6ofOvwGuvh
	 enOUmPurbgUtA==
Date: Tue, 16 Jul 2024 14:14:41 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: kotaranov@microsoft.com, weh@microsoft.com, sharmaajay@microsoft.com,
	longli@microsoft.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next 1/1] RDMA/mana_ib: indicate that inline data is
 not supported
Message-ID: <20240716111441.GB5630@unreal>
References: <1721126889-22770-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1721126889-22770-1-git-send-email-kotaranov@linux.microsoft.com>

On Tue, Jul 16, 2024 at 03:48:09AM -0700, Konstantin Taranov wrote:
> From: Konstantin Taranov <kotaranov@microsoft.com>
> 
> Set max_inline_data to zero during RC QP creation.
> 
> Fixes: fdefb9184962 ("RDMA/mana_ib: Implement uapi to create and destroy RC QP")
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> ---
>  drivers/infiniband/hw/mana/qp.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
> index 73d67c853b6f..d9f24a763e72 100644
> --- a/drivers/infiniband/hw/mana/qp.c
> +++ b/drivers/infiniband/hw/mana/qp.c
> @@ -426,6 +426,8 @@ static int mana_ib_create_rc_qp(struct ib_qp *ibqp, struct ib_pd *ibpd,
>  	u64 flags = 0;
>  	u32 doorbell;
>  
> +	/* inline data is not supported */
> +	attr->cap.max_inline_data = 0;

Can you please point to me to the flow where attr is not zeroed before?

Thanks

>  	if (!udata || udata->inlen < sizeof(ucmd))
>  		return -EINVAL;
>  
> -- 
> 2.43.0
> 

