Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E756D79E8DD
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Sep 2023 15:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240797AbjIMNOW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 13 Sep 2023 09:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240774AbjIMNOU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 Sep 2023 09:14:20 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08C21BCE;
        Wed, 13 Sep 2023 06:14:16 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rm19d4mcKz6K6Dj;
        Wed, 13 Sep 2023 21:13:41 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 13 Sep
 2023 14:14:14 +0100
Date:   Wed, 13 Sep 2023 14:14:13 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        "Dennis Dalessandro" <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 01/10] IB/hfi1: Use FIELD_GET() to extract Link Width
Message-ID: <20230913141413.0000310a@Huawei.com>
In-Reply-To: <20230913122748.29530-2-ilpo.jarvinen@linux.intel.com>
References: <20230913122748.29530-1-ilpo.jarvinen@linux.intel.com>
        <20230913122748.29530-2-ilpo.jarvinen@linux.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, 13 Sep 2023 15:27:39 +0300
Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> wrote:

> Use FIELD_GET() to extract PCIe Negotiated Link Width field instead of
> custom masking and shifting, and remove extract_width() which only
> wraps that FIELD_GET().
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/infiniband/hw/hfi1/pcie.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hfi1/pcie.c b/drivers/infiniband/hw/hfi1/pcie.c
> index 08732e1ac966..c132a9c073bf 100644
> --- a/drivers/infiniband/hw/hfi1/pcie.c
> +++ b/drivers/infiniband/hw/hfi1/pcie.c
> @@ -3,6 +3,7 @@
>   * Copyright(c) 2015 - 2019 Intel Corporation.
>   */
>  
> +#include <linux/bitfield.h>
>  #include <linux/pci.h>
>  #include <linux/io.h>
>  #include <linux/delay.h>
> @@ -210,12 +211,6 @@ static u32 extract_speed(u16 linkstat)
>  	return speed;
>  }
>  
> -/* return the PCIe link speed from the given link status */
> -static u32 extract_width(u16 linkstat)
> -{
> -	return (linkstat & PCI_EXP_LNKSTA_NLW) >> PCI_EXP_LNKSTA_NLW_SHIFT;
> -}
> -
>  /* read the link status and set dd->{lbus_width,lbus_speed,lbus_info} */
>  static void update_lbus_info(struct hfi1_devdata *dd)
>  {
> @@ -228,7 +223,7 @@ static void update_lbus_info(struct hfi1_devdata *dd)
>  		return;
>  	}
>  
> -	dd->lbus_width = extract_width(linkstat);
> +	dd->lbus_width = FIELD_GET(PCI_EXP_LNKSTA_NLW, linkstat);
>  	dd->lbus_speed = extract_speed(linkstat);
>  	snprintf(dd->lbus_info, sizeof(dd->lbus_info),
>  		 "PCIe,%uMHz,x%u", dd->lbus_speed, dd->lbus_width);

