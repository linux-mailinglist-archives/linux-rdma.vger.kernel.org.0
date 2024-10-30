Return-Path: <linux-rdma+bounces-5610-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D9A9B62B8
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Oct 2024 13:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 743271C22150
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Oct 2024 12:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1BF1E8846;
	Wed, 30 Oct 2024 12:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPdksUcf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B4E1E7C12;
	Wed, 30 Oct 2024 12:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730290382; cv=none; b=ALj79mPCIrJAK4P1FVTlG/qCDcAQl0DTHbowTPSJdq5WyhqA58IvamjKgnsGG2Zu5qQ5vPmDnvcVE5ad9c5laQDzjQhFkSprZDV9fLxOfEnOYau2UF5GOHwEWscpOLe6Mi7Tv3VTC5ly6XCNBRghpAeWTSll7r3HKi2Jo448NMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730290382; c=relaxed/simple;
	bh=QpV7rFknIZ6mMFn7C5Hj1PjVlifnuMwGgn9fo/UG/gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+q2G7fLYH/FyrN/L/GcvT8m8aaTKSFkq/ZvRZNl/kwsaLH/EKJCqXM3HJn+h41pFZAxLbB5mxR4jltJOZPVXBZqr1oDLk2ijeH+aTHhg+kcs/VMdEmTQdBEv0NwtxAF8+W0i5PsOqSJ25yzD8t+0ZknLxhl0jK1xnuJk0THQrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KPdksUcf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC40FC4CEE3;
	Wed, 30 Oct 2024 12:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730290382;
	bh=QpV7rFknIZ6mMFn7C5Hj1PjVlifnuMwGgn9fo/UG/gs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KPdksUcfkXRAYFUtXQZdvXBDHyg/B6I2Hnu69ePcJthpkWDOjYknCzKmkf7b3Hz6N
	 3DZ/hbcV9RBCSyM1gcZbuIQ9erVn/p/arD0UPguumnjbu+3cUPTBPIvbdD1QmyhMOm
	 g1Gnx6yYTKlE0/X6JOYsUYKigSKnqCbdsdQgeJw0rtXw+ogdwFUzgiYTNPQZO615b0
	 D//AfD2uboF38Bg/OjBElA3u0dwri40KnTcIL07LH+R3eHjSpwBVacRftzdOWfGFX/
	 HtNbdMf5MDHEep7CAV76c7I+a9lpvbe91WgW0u+kQJqvHw+DFHV/eR4i/e+qr0riau
	 3EWozCe4Neh1Q==
Date: Wed, 30 Oct 2024 14:12:58 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	linux-kernel@vger.kernel.org, tangchengchang@huawei.com
Subject: Re: [PATCH v2 for-rc 3/5] RDMA/hns: Modify debugfs name
Message-ID: <20241030121258.GB17187@unreal>
References: <20241024124000.2931869-1-huangjunxian6@hisilicon.com>
 <20241024124000.2931869-4-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024124000.2931869-4-huangjunxian6@hisilicon.com>

On Thu, Oct 24, 2024 at 08:39:58PM +0800, Junxian Huang wrote:
> From: Yuyu Li <liyuyu6@huawei.com>
> 
> The sub-directory of hns_roce debugfs is named after the device's
> kernel name currently, but it will be inconvenient to use when
> the device is renamed.
> 
> Modify the name to pci name as users can always easily find the
> correspondence between an RDMA device and its pci name.
> 
> Fixes: eb7854d63db5 ("RDMA/hns: Support SW stats with debugfs")
> Signed-off-by: Yuyu Li <liyuyu6@huawei.com>
> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_debugfs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_debugfs.c b/drivers/infiniband/hw/hns/hns_roce_debugfs.c
> index e8febb40f645..b869cdc54118 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_debugfs.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_debugfs.c
> @@ -5,6 +5,7 @@
>  
>  #include <linux/debugfs.h>
>  #include <linux/device.h>
> +#include <linux/pci.h>
>  
>  #include "hns_roce_device.h"
>  
> @@ -86,7 +87,7 @@ void hns_roce_register_debugfs(struct hns_roce_dev *hr_dev)
>  {
>  	struct hns_roce_dev_debugfs *dbgfs = &hr_dev->dbgfs;
>  
> -	dbgfs->root = debugfs_create_dir(dev_name(&hr_dev->ib_dev.dev),
> +	dbgfs->root = debugfs_create_dir(pci_name(hr_dev->pci_dev),
>  					 hns_roce_dbgfs_root);

Let's take this change, but the more correct way is to add .rename()
callback to ib_device ops in similar way to what we do in ib_client
and call to debugfs_rename() from there.

See ib_device_rename() implementation for "lient->rename(ibdev, client_data);" call.

Thanks

