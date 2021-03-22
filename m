Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E23AB34376B
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Mar 2021 04:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbhCVD3k convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Sun, 21 Mar 2021 23:29:40 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3045 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbhCVD3P (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 21 Mar 2021 23:29:15 -0400
Received: from DGGEML403-HUB.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4F3fzG4Wg1zWPBc;
        Mon, 22 Mar 2021 11:26:02 +0800 (CST)
Received: from dggema754-chm.china.huawei.com (10.1.198.196) by
 DGGEML403-HUB.china.huawei.com (10.3.17.33) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Mon, 22 Mar 2021 11:29:09 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema754-chm.china.huawei.com (10.1.198.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Mon, 22 Mar 2021 11:29:09 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2106.013;
 Mon, 22 Mar 2021 11:29:09 +0800
From:   liweihang <liweihang@huawei.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH for-next] RDMA/core: Check invalid QP state for
 ib_modify_qp_is_ok()
Thread-Topic: [PATCH for-next] RDMA/core: Check invalid QP state for
 ib_modify_qp_is_ok()
Thread-Index: AQHXHJ8NNG3a5kWMHUaHioKmCNer6w==
Date:   Mon, 22 Mar 2021 03:29:09 +0000
Message-ID: <53ff6a59a9a74443bca58bcaee6292bb@huawei.com>
References: <1616144545-18159-1-git-send-email-liweihang@huawei.com>
 <YFXBprYFmFgHu9Z8@unreal>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.100.165]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2021/3/20 17:34, Leon Romanovsky wrote:
> On Fri, Mar 19, 2021 at 05:02:25PM +0800, Weihang Li wrote:
>> From: Xi Wang <wangxi11@huawei.com>
>>
>> Out-of-bounds may occur in 'qp_state_table' when the caller passing wrong
>> QP state value.
> 
> How is it possible? Do you have call stack to support it?
> 
> Thanks
> 

ib_modify_qp_is_ok() is exported, I think any kernel modules can pass in
invalid QP state. Should we check it in such case?

Thanks
Weihang

>>
>> Signed-off-by: Xi Wang <wangxi11@huawei.com>
>> Signed-off-by: Weihang Li <liweihang@huawei.com>
>> ---
>>  drivers/infiniband/core/verbs.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
>> index 28464c5..66ba4e6 100644
>> --- a/drivers/infiniband/core/verbs.c
>> +++ b/drivers/infiniband/core/verbs.c
>> @@ -1613,6 +1613,10 @@ bool ib_modify_qp_is_ok(enum ib_qp_state cur_state, enum ib_qp_state next_state,
>>  	    cur_state != IB_QPS_SQD && cur_state != IB_QPS_SQE)
>>  		return false;
>>  
>> +	if (cur_state >= ARRAY_SIZE(qp_state_table) ||
>> +	    next_state >= ARRAY_SIZE(qp_state_table[0]))
>> +		return false;
>> +
>>  	if (!qp_state_table[cur_state][next_state].valid)
>>  		return false;
>>  
>> -- 
>> 2.8.1
>>

