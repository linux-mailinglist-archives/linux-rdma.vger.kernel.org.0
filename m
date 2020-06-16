Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C36B1FA543
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2020 02:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgFPAvb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 15 Jun 2020 20:51:31 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6326 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726386AbgFPAvb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 15 Jun 2020 20:51:31 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C57CDF8AAA548630529D;
        Tue, 16 Jun 2020 08:51:27 +0800 (CST)
Received: from [10.166.215.157] (10.166.215.157) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 16 Jun
 2020 08:51:25 +0800
Subject: Re: [PATCH] IB/srpt: Fix a potential null pointer dereference
To:     Bart Van Assche <bvanassche@acm.org>, <dledford@redhat.com>,
        <jgg@ziepe.ca>
References: <20200615091220.6439-1-jingxiangfeng@huawei.com>
 <7366b608-4474-cfaa-c465-957fd2d2366d@acm.org>
CC:     <linux-rdma@vger.kernel.org>, <target-devel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
Message-ID: <5EE8178C.9090005@huawei.com>
Date:   Tue, 16 Jun 2020 08:51:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <7366b608-4474-cfaa-c465-957fd2d2366d@acm.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.157]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2020/6/15 21:37, Bart Van Assche wrote:
> On 2020-06-15 02:12, Jing Xiangfeng wrote:
>> In srpt_cm_req_recv(), it is possible that sdev is NULL,
>> so we should test sdev before using it.
>>
>> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
>> ---
>>   drivers/infiniband/ulp/srpt/ib_srpt.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
>> index 98552749d71c..72053254bf84 100644
>> --- a/drivers/infiniband/ulp/srpt/ib_srpt.c
>> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
>> @@ -2143,7 +2143,7 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
>>   			    const struct srp_login_req *req,
>>   			    const char *src_addr)
>>   {
>> -	struct srpt_port *sport = &sdev->port[port_num - 1];
>> +	struct srpt_port *sport;
>>   	struct srpt_nexus *nexus;
>>   	struct srp_login_rsp *rsp = NULL;
>>   	struct srp_login_rej *rej = NULL;
>> @@ -2162,6 +2162,7 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
>>   	if (WARN_ON(!sdev || !req))
>>   		return -EINVAL;
>>
>> +	sport = &sdev->port[port_num - 1];
>>   	it_iu_len = be32_to_cpu(req->req_it_iu_len);
>>
>
> Please remove the (!sdev || !req) check instead of making the above
> change. It's easy to show that both pointers are always valid.

OK, I will send a v2 with this change.

Thanks
>
> Thanks,
>
> Bart.
> .
>
