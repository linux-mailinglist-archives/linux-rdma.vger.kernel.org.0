Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDB39483E4D
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jan 2022 09:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbiADIhS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jan 2022 03:37:18 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:44852 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbiADIhS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Jan 2022 03:37:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D87361239
        for <linux-rdma@vger.kernel.org>; Tue,  4 Jan 2022 08:37:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A217C36AEB;
        Tue,  4 Jan 2022 08:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641285437;
        bh=0XXQTtEgti/YY033h1UIoYQ99E3yqRXON6sGLX+JNwE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FkIbh0Gyyb3J74JMLE4waVuJXexALvNEEJAZc8TNMauGvYdip2Q9gdLi5woAHjGOs
         +F7YGNWPbmAY5X2CXPJXGxWRtyBhywaQIQ3UexC2cGjw+Y4qugNjT+is4zOS4baiia
         KYUsjSdBI0KCLoRzSiBqiQZnbtxKWrSeciMRczhehuxdDw5orQQJ6n/cgcbxCKl78f
         XDZHefMcdrUXj21EreTzYUzQ/Mf8ASfbXdVSK1O/6nFS2EkMR7ILzfERGEj5PsYkdB
         AC6/TKfI0fJRWTFJHSr6rRwshKkTM3nVgNN25qTUgIWpRztx3yVM9bJRfREOrA3tJ9
         0v5BubJoPa0NQ==
Date:   Tue, 4 Jan 2022 10:37:13 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH for-next 1/2] RDMA/hns: Fix potential memory leak in
 free_dip_list
Message-ID: <YdQHObYfElU/3RNI@unreal>
References: <20211231101341.45759-1-liangwenpeng@huawei.com>
 <20211231101341.45759-2-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211231101341.45759-2-liangwenpeng@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Dec 31, 2021 at 06:13:40PM +0800, Wenpeng Liang wrote:
> Hardware with a higher version than HIP09 should also release dip memory.
> 
> Fixes: f91696f2f053 ("RDMA/hns: Support congestion control type selection according to the FW")
> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> index e681c2dc23e8..d0c0ea6754f6 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> @@ -2769,7 +2769,7 @@ static void hns_roce_v2_exit(struct hns_roce_dev *hr_dev)
>  	if (!hr_dev->is_vf)
>  		hns_roce_free_link_table(hr_dev);
>  
> -	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP09)
> +	if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09)

Are you referring to out-of-tree code? In upstream code,
PCI_REVISION_ID_HIP09 is the highest revision.

Thanks

>  		free_dip_list(hr_dev);
>  }
>  
> -- 
> 2.33.0
> 
