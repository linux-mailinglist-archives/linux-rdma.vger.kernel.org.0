Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E425D725A3
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jul 2019 05:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfGXD6x (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jul 2019 23:58:53 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2710 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725855AbfGXD6x (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Jul 2019 23:58:53 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 098302A12B22F6B5C30E;
        Wed, 24 Jul 2019 11:58:52 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Wed, 24 Jul 2019
 11:58:42 +0800
Subject: Re: [PATCH v2] RDMA/hns: Fix build error for hip06
To:     <oulijun@huawei.com>, <xavier.huwei@huawei.com>,
        <dledford@redhat.com>, <jgg@ziepe.ca>, <leon@kernel.org>
References: <20190723024535.61412-1-yuehaibing@huawei.com>
 <20190724034428.13944-1-yuehaibing@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <62e79055-948e-155f-19eb-b216a540458a@huawei.com>
Date:   Wed, 24 Jul 2019 11:58:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190724034428.13944-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


Pls ignore this, I will fix it.

On 2019/7/24 11:44, YueHaibing wrote:
> If INFINIBAND_HNS_HIP06 is selected and HNS_DSAF
> is m, but INFINIBAND_HNS is y, building fails:
> 
> drivers/infiniband/hw/hns/hns_roce_hw_v1.o: In function `hns_roce_v1_reset':
> hns_roce_hw_v1.c:(.text+0x39fa): undefined reference to `hns_dsaf_roce_reset'
> hns_roce_hw_v1.c:(.text+0x3a25): undefined reference to `hns_dsaf_roce_reset'
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 08805fdbeb2d ("RDMA/hns: Split hw v1 driver from hns roce driver")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> v2: use select instead of depends
> ---
>  drivers/infiniband/hw/hns/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/hns/Kconfig b/drivers/infiniband/hw/hns/Kconfig
> index b9dfac0..5f6d750 100644
> --- a/drivers/infiniband/hw/hns/Kconfig
> +++ b/drivers/infiniband/hw/hns/Kconfig
> @@ -12,7 +12,8 @@ config INFINIBAND_HNS
>  
>  config INFINIBAND_HNS_HIP06
>  	bool "Hisilicon Hip06 Family RoCE support"
> -	depends on INFINIBAND_HNS && HNS && HNS_DSAF && HNS_ENET
> +	depends on INFINIBAND_HNS && HNS && HNS_ENET
> +	select HNS_DSAF
>  	---help---
>  	  RoCE driver support for Hisilicon RoCE engine in Hisilicon Hip06 and
>  	  Hip07 SoC. These RoCE engines are platform devices.
> 

