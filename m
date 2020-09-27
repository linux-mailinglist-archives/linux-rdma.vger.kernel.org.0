Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1B9427A044
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Sep 2020 11:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgI0JdM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Sun, 27 Sep 2020 05:33:12 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3561 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726244AbgI0JdM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Sep 2020 05:33:12 -0400
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 2B7D9EF20CFBC88351D4;
        Sun, 27 Sep 2020 17:33:10 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Sun, 27 Sep 2020 17:33:09 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Sun, 27 Sep 2020 17:33:09 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.1913.007;
 Sun, 27 Sep 2020 17:33:09 +0800
From:   liweihang <liweihang@huawei.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH for-next] RDMA/hns: Support owner mode doorbell
Thread-Topic: [PATCH for-next] RDMA/hns: Support owner mode doorbell
Thread-Index: AQHWkxVgpY7CzIZB4EWLV6O1KLIoKA==
Date:   Sun, 27 Sep 2020 09:33:09 +0000
Message-ID: <3dba4d0d025144bfbe2fc7a67705f49b@huawei.com>
References: <1601022214-56412-1-git-send-email-liweihang@huawei.com>
 <20200927063004.GG2280698@unreal>
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

On 2020/9/27 14:30, Leon Romanovsky wrote:
> On Fri, Sep 25, 2020 at 04:23:34PM +0800, Weihang Li wrote:
>> From: Lang Cheng <chenglang@huawei.com>
>>
>> The doorbell needs to store PI information into QPC, so the RoCEE should
>> wait for the results of storing, that is, it needs two bus operations to
>> complete a doorbell. When ROCEE is in SDI mode, multiple doorbells may be
>> interlocked because the RoCEE can only handle bus operations serially. So a
>> flag to mark if HIP09 is working in SDI mode is added. When the SDI flag is
>> set, the ROCEE will ignore the PI information of the doorbell, continue to
>> fetch wqe and verify its validity by it's owner_bit.
>>
>> Signed-off-by: Lang Cheng <chenglang@huawei.com>
>> Signed-off-by: Weihang Li <liweihang@huawei.com>
>> ---
>>  drivers/infiniband/hw/hns/hns_roce_device.h |  5 ++++-
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 28 ++++++++++++++++++++++------
>>  drivers/infiniband/hw/hns/hns_roce_qp.c     |  3 +++
>>  3 files changed, 29 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
>> index a8183ef..517c127 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_device.h
>> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
>> @@ -137,9 +137,10 @@ enum {
>>  	SERV_TYPE_UD,
>>  };
>>
>> -enum {
>> +enum hns_roce_qp_caps {
>>  	HNS_ROCE_QP_CAP_RQ_RECORD_DB = BIT(0),
>>  	HNS_ROCE_QP_CAP_SQ_RECORD_DB = BIT(1),
>> +	HNS_ROCE_QP_CAP_OWNER_DB = BIT(2),
>>  };
>>
>>  enum hns_roce_cq_flags {
>> @@ -229,6 +230,8 @@ enum {
>>  	HNS_ROCE_CAP_FLAG_FRMR                  = BIT(8),
>>  	HNS_ROCE_CAP_FLAG_QP_FLOW_CTRL		= BIT(9),
>>  	HNS_ROCE_CAP_FLAG_ATOMIC		= BIT(10),
>> +	HNS_ROCE_CAP_FLAG_SDI_MODE		= BIT(14),
>> +	HNS_ROCE_CAP_FLAG_MAX			= BIT(28)
> 
> This enum is not used.
> 
> Thanks
> 

Thank you, the enum is not used in this patch. I will remove it
and add it back when needed later.

Weihang
