Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C70457280C
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jul 2019 08:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbfGXGMk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Jul 2019 02:12:40 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2711 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725945AbfGXGMj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 24 Jul 2019 02:12:39 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DB0DDD7CEC6E4F93575F;
        Wed, 24 Jul 2019 14:12:36 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Wed, 24 Jul 2019
 14:12:26 +0800
Subject: Re: [PATCH v2] RDMA/hns: Fix build error for hip08
To:     <oulijun@huawei.com>, <xavier.huwei@huawei.com>,
        <dledford@redhat.com>, <jgg@ziepe.ca>, <leon@kernel.org>
References: <20190723024908.11876-1-yuehaibing@huawei.com>
 <20190724034016.15048-1-yuehaibing@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <a022a386-85cc-aa92-2f50-1b61070d4d2e@huawei.com>
Date:   Wed, 24 Jul 2019 14:12:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190724034016.15048-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


Pls drop this, this cannot fix the issue.

On 2019/7/24 11:40, YueHaibing wrote:
> If INFINIBAND_HNS_HIP08 is selected and HNS3 is m,
> but INFINIBAND_HNS is y, building fails:
> 
> drivers/infiniband/hw/hns/hns_roce_hw_v2.o: In function `hns_roce_hw_v2_exit':
> hns_roce_hw_v2.c:(.exit.text+0xd): undefined reference to `hnae3_unregister_client'
> drivers/infiniband/hw/hns/hns_roce_hw_v2.o: In function `hns_roce_hw_v2_init':
> hns_roce_hw_v2.c:(.init.text+0xd): undefined reference to `hnae3_register_client'
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Suggested-by: Leon Romanovsky <leon@kernel.org>
> Fixes: dd74282df573 ("RDMA/hns: Initialize the PCI device for hip08 RoCE")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> v2: select HNS3 to fix this
> ---
>  drivers/infiniband/hw/hns/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/hns/Kconfig b/drivers/infiniband/hw/hns/Kconfig
> index 8bf847b..b9dfac0 100644
> --- a/drivers/infiniband/hw/hns/Kconfig
> +++ b/drivers/infiniband/hw/hns/Kconfig
> @@ -22,7 +22,8 @@ config INFINIBAND_HNS_HIP06
>  
>  config INFINIBAND_HNS_HIP08
>  	bool "Hisilicon Hip08 Family RoCE support"
> -	depends on INFINIBAND_HNS && PCI && HNS3
> +	depends on INFINIBAND_HNS && PCI
> +	select HNS3
>  	---help---
>  	  RoCE driver support for Hisilicon RoCE engine in Hisilicon Hip08 SoC.
>  	  The RoCE engine is a PCI device.
> 

