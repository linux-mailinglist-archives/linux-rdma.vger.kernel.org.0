Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0292CB21C
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Dec 2020 02:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgLBBKh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 1 Dec 2020 20:10:37 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2081 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbgLBBKg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Dec 2020 20:10:36 -0500
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Cm1852pFwzVfr9;
        Wed,  2 Dec 2020 09:09:09 +0800 (CST)
Received: from dggema754-chm.china.huawei.com (10.1.198.196) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Wed, 2 Dec 2020 09:09:53 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema754-chm.china.huawei.com (10.1.198.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Wed, 2 Dec 2020 09:09:53 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.1913.007;
 Wed, 2 Dec 2020 09:09:53 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH for-next] RDMA/hns: Move capability flags of QP and CQ to
 hns-abi.h
Thread-Topic: [PATCH for-next] RDMA/hns: Move capability flags of QP and CQ to
 hns-abi.h
Thread-Index: AQHWx+XBtyR8rKQ1NUyAV7I6YqHf5Q==
Date:   Wed, 2 Dec 2020 01:09:53 +0000
Message-ID: <3efdefefed0d4821bee4d90375d83659@huawei.com>
References: <1606829024-51856-1-git-send-email-liweihang@huawei.com>
 <20201201134341.GD5487@ziepe.ca>
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

On 2020/12/1 21:44, Jason Gunthorpe wrote:
> On Tue, Dec 01, 2020 at 09:23:44PM +0800, Weihang Li wrote:
>> diff --git a/include/uapi/rdma/hns-abi.h b/include/uapi/rdma/hns-abi.h
>> index 9ec85f7..2dd5fa07 100644
>> +++ b/include/uapi/rdma/hns-abi.h
>> @@ -43,6 +43,10 @@ struct hns_roce_ib_create_cq {
>>  	__u32 reserved;
>>  };
>>  
>> +enum hns_roce_cq_cap_flags {
>> +	HNS_ROCE_CQ_FLAG_RECORD_DB = BIT(0),
>> +};
>> +
>>  struct hns_roce_ib_create_cq_resp {
>>  	__aligned_u64 cqn; /* Only 32 bits used, 64 for compat */
>>  	__aligned_u64 cap_flags;
>> @@ -69,6 +73,12 @@ struct hns_roce_ib_create_qp {
>>  	__aligned_u64 sdb_addr;
>>  };
>>  
>> +enum hns_roce_qp_cap_flags {
>> +	HNS_ROCE_QP_CAP_RQ_RECORD_DB = BIT(0),
>> +	HNS_ROCE_QP_CAP_SQ_RECORD_DB = BIT(1),
>> +	HNS_ROCE_QP_CAP_OWNER_DB = BIT(2),
>> +};
> 
> Don't use BIT in uapi headers
> 
> Jason
> 

I see, thank you.

Weihang
