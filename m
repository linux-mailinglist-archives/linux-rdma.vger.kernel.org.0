Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75F0F19630D
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Mar 2020 03:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgC1CP1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 27 Mar 2020 22:15:27 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:40506 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726225AbgC1CP1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 27 Mar 2020 22:15:27 -0400
Received: from DGGEML404-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 2C9D1AF3BBC4F88F8D33;
        Sat, 28 Mar 2020 10:15:23 +0800 (CST)
Received: from DGGEML502-MBS.china.huawei.com ([169.254.3.252]) by
 DGGEML404-HUB.china.huawei.com ([fe80::b177:a243:7a69:5ab8%31]) with mapi id
 14.03.0487.000; Sat, 28 Mar 2020 10:15:15 +0800
From:   liweihang <liweihang@huawei.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        oulijun <oulijun@huawei.com>,
        "Huwei (Xavier)" <huwei87@hisilicon.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "wangxi (M)" <wangxi11@huawei.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] RDMA/hns: Fix uninitialized variable bug
Thread-Topic: [PATCH][next] RDMA/hns: Fix uninitialized variable bug
Thread-Index: AQHWBG3eNmqMJQj2ZUuxHg3rC+f0Zw==
Date:   Sat, 28 Mar 2020 02:15:14 +0000
Message-ID: <B82435381E3B2943AA4D2826ADEF0B3A022B739C@DGGEML502-MBS.china.huawei.com>
References: <20200327193142.GA32547@embeddedor>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.40.168.149]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020/3/28 3:28, Gustavo A. R. Silva wrote:
> There is a potential execution path in which variable *ret* is returned
> without being properly initialized, previously.
> 
> Fix this by initializing variable *ret* to -ENODEV.
> 
> Addresses-Coverity-ID: 1491917 ("Uninitialized scalar variable")
> Fixes: 2f49de21f3e9 ("RDMA/hns: Optimize mhop get flow for multi-hop addressing")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
> index c96378718f88..3fd8100c2b56 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hem.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
> @@ -603,7 +603,7 @@ static int set_mhop_hem(struct hns_roce_dev *hr_dev,
>  {
>  	struct ib_device *ibdev = &hr_dev->ib_dev;
>  	int step_idx;
> -	int ret;
> +	int ret = -ENODEV;
>  
>  	if (index->inited & HEM_INDEX_L0) {
>  		ret = hr_dev->hw->set_hem(hr_dev, table, obj, 0);
> 

Hi Gustavo,

Thanks for your modification. But I check the code and I think "ret"
should be initialized to 0, which means no need to set hem and it is
not an error.

Weihang
