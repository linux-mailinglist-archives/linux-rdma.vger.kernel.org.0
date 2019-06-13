Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D09D44591
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2019 18:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbfFMQo6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Jun 2019 12:44:58 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:18141 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730404AbfFMGOm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 13 Jun 2019 02:14:42 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E567D21003BA1BAD2B0B;
        Thu, 13 Jun 2019 14:14:35 +0800 (CST)
Received: from [127.0.0.1] (10.61.25.96) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Thu, 13 Jun 2019
 14:14:27 +0800
Subject: Re: [PATCH] RDMA/hns: Fix an error code in
 hns_roce_set_user_sq_size()
To:     Leon Romanovsky <leon@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
CC:     "Wei Hu(Xavier)" <xavier.huwei@huawei.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, <linux-rdma@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20190608092714.GE28890@mwanda>
 <20190612172316.GU6369@mtr-leonro.mtl.com>
From:   oulijun <oulijun@huawei.com>
Message-ID: <e4a4e905-2c9e-151b-e995-4920687b09c0@huawei.com>
Date:   Thu, 13 Jun 2019 14:14:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <20190612172316.GU6369@mtr-leonro.mtl.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.61.25.96]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

ÔÚ 2019/6/13 1:23, Leon Romanovsky Ð´µÀ:
> On Sat, Jun 08, 2019 at 12:27:14PM +0300, Dan Carpenter wrote:
>> This function is supposed to return negative kernel error codes but here
>> it returns CMD_RST_PRC_EBUSY (2).  The error code eventually gets passed
>> to IS_ERR() and since it's not an error pointer it leads to an Oops in
>> hns_roce_v1_rsv_lp_qp()
>>
>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>> ---
>> Static analysis.  Not tested.
>>
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> index ac017c24b200..018ff302ab9e 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> @@ -1098,7 +1098,7 @@ static int hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
>>  	if (ret == CMD_RST_PRC_SUCCESS)
>>  		return 0;
>>  	if (ret == CMD_RST_PRC_EBUSY)
> The better fix will be to remove CMD_RST_PRC_* definitions in favor of
> normal errno.
>
> Thanks
>
> .
>
Sorry, Our guys are analyzing his influence. So the response is a bit late.


