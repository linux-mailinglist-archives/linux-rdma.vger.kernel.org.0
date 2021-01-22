Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27CE52FFF0A
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Jan 2021 10:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbhAVJCn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 22 Jan 2021 04:02:43 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2986 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbhAVJCV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Jan 2021 04:02:21 -0500
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4DMYBN145nzR5XM;
        Fri, 22 Jan 2021 17:00:28 +0800 (CST)
Received: from dggema701-chm.china.huawei.com (10.3.20.65) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Fri, 22 Jan 2021 17:01:29 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema701-chm.china.huawei.com (10.3.20.65) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Fri, 22 Jan 2021 17:01:29 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2106.002;
 Fri, 22 Jan 2021 17:01:29 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: Re: [PATCH v2 for-next] RDMA/hns: Add caps flag for UD inline of
 userspace
Thread-Topic: [PATCH v2 for-next] RDMA/hns: Add caps flag for UD inline of
 userspace
Thread-Index: AQHW8B4yNEZLbyzPPkiYOSj3dqUAaw==
Date:   Fri, 22 Jan 2021 09:01:29 +0000
Message-ID: <bed8f16eda944d11b3679f7866fb2dcb@huawei.com>
References: <1609836423-40069-1-git-send-email-liweihang@huawei.com>
 <20210121175033.GA1221624@nvidia.com>
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

On 2021/1/22 1:52, Jason Gunthorpe wrote:
> On Tue, Jan 05, 2021 at 04:47:03PM +0800, Weihang Li wrote:
>> diff --git a/include/uapi/rdma/hns-abi.h b/include/uapi/rdma/hns-abi.h
>> index 90b739d..79dba94 100644
>> +++ b/include/uapi/rdma/hns-abi.h
>> @@ -77,6 +77,7 @@ enum hns_roce_qp_cap_flags {
>>  	HNS_ROCE_QP_CAP_RQ_RECORD_DB = 1 << 0,
>>  	HNS_ROCE_QP_CAP_SQ_RECORD_DB = 1 << 1,
>>  	HNS_ROCE_QP_CAP_OWNER_DB = 1 << 2,
>> +	HNS_ROCE_QP_CAP_UD_SQ_INL = 1 << 3,
> 
> I don't understand why you need this flag.
> 
> The # of bytes of inline data should be returned from create_qp in the
> max_inline_data cap.
> 
> If things doesn't support inline data then shouldn't that just return
> 0?
> 
> Jason
> 

Yes, you are right. Please ignore this patch and I will update the userspace
part later.

Thanks
Weihang
