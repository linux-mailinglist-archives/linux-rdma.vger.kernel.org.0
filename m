Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1059422EC62
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jul 2020 14:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbgG0MmA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 27 Jul 2020 08:42:00 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:42768 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728362AbgG0MmA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Jul 2020 08:42:00 -0400
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 9EE12D196B7E3770873D;
        Mon, 27 Jul 2020 20:41:58 +0800 (CST)
Received: from dggema752-chm.china.huawei.com (10.1.198.194) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Mon, 27 Jul 2020 20:41:58 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema752-chm.china.huawei.com (10.1.198.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 27 Jul 2020 20:41:57 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.1913.007;
 Mon, 27 Jul 2020 20:41:57 +0800
From:   liweihang <liweihang@huawei.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH for-next 2/7] RDMA/hns: Refactor hns_roce_v2_set_hem()
Thread-Topic: [PATCH for-next 2/7] RDMA/hns: Refactor hns_roce_v2_set_hem()
Thread-Index: AQHWY+2ZQom8feTowU6oGB6RPmNnTw==
Date:   Mon, 27 Jul 2020 12:41:57 +0000
Message-ID: <21abb708ae414d90b24681809841ceaf@huawei.com>
References: <1595837449-29193-1-git-send-email-liweihang@huawei.com>
 <1595837449-29193-3-git-send-email-liweihang@huawei.com>
 <20200727105135.GC75549@unreal>
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

On 2020/7/27 18:51, Leon Romanovsky wrote:
> On Mon, Jul 27, 2020 at 04:10:44PM +0800, Weihang Li wrote:
>> The parts about preparing and sending mailbox to hardware is not strongly
>> related to other codes in hns_roce_v2_set_hem(), and can be encapsulated
>> into a separate function.
>>
>> Signed-off-by: Weihang Li <liweihang@huawei.com>
>> ---
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 45 +++++++++++++++++-------------
>>  1 file changed, 26 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> index 35d46b7..0eab92a 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> @@ -3373,11 +3373,33 @@ static int get_op_for_set_hem(struct hns_roce_dev *hr_dev, u32 type,
>>  	return op + step_idx;
>>  }
>>
>> +static int set_hem_to_hw(struct hns_roce_dev *hr_dev, int obj, u64 bt_ba,
>> +			 u32 hem_type, int step_idx)
>> +{
>> +	struct hns_roce_cmd_mailbox *mailbox;
>> +	int ret;
>> +	int op;
>> +
>> +	op = get_op_for_set_hem(hr_dev, hem_type, step_idx);
>> +	if (op == -EINVAL)
>> +		return 0;
> 
> It is not how we write error checks "if (op < 0) return 0;"
> 
> Thanks
> 

Thanks for your comments, will modify it.

Weihang
