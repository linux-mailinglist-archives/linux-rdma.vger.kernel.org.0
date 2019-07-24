Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F20D472E0E
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jul 2019 13:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbfGXLr5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Jul 2019 07:47:57 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40698 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727128AbfGXLr5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 24 Jul 2019 07:47:57 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5CE3F10A13D1A8E51729;
        Wed, 24 Jul 2019 19:47:54 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Wed, 24 Jul 2019
 19:47:46 +0800
Subject: Re: [PATCH] RDMA/hns: Fix build error
To:     Jason Gunthorpe <jgg@ziepe.ca>
References: <20190723024908.11876-1-yuehaibing@huawei.com>
 <20190724065443.53068-1-yuehaibing@huawei.com>
 <20190724113252.GA28493@ziepe.ca>
CC:     <oulijun@huawei.com>, <xavier.huwei@huawei.com>,
        <dledford@redhat.com>, <leon@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <1254a3e5-88e9-7d38-b4a2-ca00526ce885@huawei.com>
Date:   Wed, 24 Jul 2019 19:47:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190724113252.GA28493@ziepe.ca>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 2019/7/24 19:32, Jason Gunthorpe wrote:
> On Wed, Jul 24, 2019 at 02:54:43PM +0800, YueHaibing wrote:
>> If INFINIBAND_HNS_HIP08 is selected and HNS3 is m,
>> but INFINIBAND_HNS is y, building fails:
>>
>> drivers/infiniband/hw/hns/hns_roce_hw_v2.o: In function `hns_roce_hw_v2_exit':
>> hns_roce_hw_v2.c:(.exit.text+0xd): undefined reference to `hnae3_unregister_client'
>> drivers/infiniband/hw/hns/hns_roce_hw_v2.o: In function `hns_roce_hw_v2_init':
>> hns_roce_hw_v2.c:(.init.text+0xd): undefined reference to `hnae3_register_client'
>>
>> Also if INFINIBAND_HNS_HIP06 is selected and HNS_DSAF
>> is m, but INFINIBAND_HNS is y, building fails:
>>
>> drivers/infiniband/hw/hns/hns_roce_hw_v1.o: In function `hns_roce_v1_reset':
>> hns_roce_hw_v1.c:(.text+0x39fa): undefined reference to `hns_dsaf_roce_reset'
>> hns_roce_hw_v1.c:(.text+0x3a25): undefined reference to `hns_dsaf_roce_reset'
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Fixes: dd74282df573 ("RDMA/hns: Initialize the PCI device for hip08 RoCE")
>> Fixes: 08805fdbeb2d ("RDMA/hns: Split hw v1 driver from hns roce driver")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>>  drivers/infiniband/hw/hns/Kconfig  | 6 +++---
>>  drivers/infiniband/hw/hns/Makefile | 8 ++------
>>  2 files changed, 5 insertions(+), 9 deletions(-)
> 
> did you test this approach with CONFIG_MODULES=n?

Yes, I test it, it works now.

> 
> Jason
> 
> .
> 

