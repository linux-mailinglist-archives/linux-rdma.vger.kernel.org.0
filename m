Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1A979CE36
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Sep 2023 12:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbjILK1H convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 12 Sep 2023 06:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234317AbjILK0u (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Sep 2023 06:26:50 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C3C10DD;
        Tue, 12 Sep 2023 03:26:44 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RlKQ43cy9z6J7t4;
        Tue, 12 Sep 2023 18:22:04 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 12 Sep
 2023 11:26:41 +0100
Date:   Tue, 12 Sep 2023 11:26:40 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        "Dennis Dalessandro" <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] IB/hfi1: Use FIELD_GET() to extract Link Width
Message-ID: <20230912112640.00007427@Huawei.com>
In-Reply-To: <20230911121501.21910-2-ilpo.jarvinen@linux.intel.com>
References: <20230911121501.21910-1-ilpo.jarvinen@linux.intel.com>
        <20230911121501.21910-2-ilpo.jarvinen@linux.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, 11 Sep 2023 15:14:54 +0300
Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> wrote:

> Use FIELD_GET() to extract PCIe Negotiated Link Width field instead of
> custom masking and shifting.
> 
> While at it, also fix function's comment.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/infiniband/hw/hfi1/pcie.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hfi1/pcie.c b/drivers/infiniband/hw/hfi1/pcie.c
> index 08732e1ac966..d497e4c623c1 100644
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
> @@ -210,10 +211,10 @@ static u32 extract_speed(u16 linkstat)
>  	return speed;
>  }
>  
> -/* return the PCIe link speed from the given link status */
> +/* return the PCIe Link Width from the given link status */
>  static u32 extract_width(u16 linkstat)
>  {
> -	return (linkstat & PCI_EXP_LNKSTA_NLW) >> PCI_EXP_LNKSTA_NLW_SHIFT;
> +	return FIELD_GET(PCI_EXP_LNKSTA_NLW, linkstat);

The helper seems like overkill now.  Maybe just push this code inline
and drop the wrapper.  I don't think the comment is necessary after
that as we are putting it in a bus_width field and the register is
obviously link status from the naming.

	dd->lbus_width = FIELD_GET(PCI_EXP_LINKSTA_NLW, linkstat);

>  }
>  
>  /* read the link status and set dd->{lbus_width,lbus_speed,lbus_info} */

