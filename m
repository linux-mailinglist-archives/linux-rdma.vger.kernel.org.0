Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6792EA5F2
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Jan 2021 08:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbhAEH2l convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 5 Jan 2021 02:28:41 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:4129 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbhAEH2k (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Jan 2021 02:28:40 -0500
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4D93wX37BtzXwPQ;
        Tue,  5 Jan 2021 15:27:08 +0800 (CST)
Received: from dggema751-chm.china.huawei.com (10.1.198.193) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Tue, 5 Jan 2021 15:27:52 +0800
Received: from dggema703-chm.china.huawei.com (10.3.20.67) by
 dggema751-chm.china.huawei.com (10.1.198.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 5 Jan 2021 15:27:52 +0800
Received: from dggema703-chm.china.huawei.com ([10.8.64.130]) by
 dggema703-chm.china.huawei.com ([10.8.64.130]) with mapi id 15.01.1913.007;
 Tue, 5 Jan 2021 15:27:52 +0800
From:   liweihang <liweihang@huawei.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: Re: [PATCH for-next] RDMA/hns: Add caps flag for UD inline of
 userspace
Thread-Topic: [PATCH for-next] RDMA/hns: Add caps flag for UD inline of
 userspace
Thread-Index: AQHW4y/lJ+7Cdb8+U0uGnjYt0uVedg==
Date:   Tue, 5 Jan 2021 07:27:52 +0000
Message-ID: <55ea08e37714492ebf5acc66d2be3cd6@huawei.com>
References: <1609810615-50515-1-git-send-email-liweihang@huawei.com>
 <20210105065605.GO31158@unreal>
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

On 2021/1/5 14:56, Leon Romanovsky wrote:
> On Tue, Jan 05, 2021 at 09:36:55AM +0800, Weihang Li wrote:
>> HIP09 supports UD inline up to size of 1024 Bytes, the caps flag is got
>> from firmware and passed back to userspace when creating QP.
>>
>> Signed-off-by: Weihang Li <liweihang@huawei.com>
>> ---
>>  drivers/infiniband/hw/hns/hns_roce_device.h | 1 +
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 3 +++
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  | 1 +
>>  drivers/infiniband/hw/hns/hns_roce_qp.c     | 3 +++
>>  include/uapi/rdma/hns-abi.h                 | 1 +
>>  5 files changed, 9 insertions(+)
>>
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
>> index 55d5386..87716da 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_device.h
>> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
>> @@ -214,6 +214,7 @@ enum {
>>  	HNS_ROCE_CAP_FLAG_FRMR                  = BIT(8),
>>  	HNS_ROCE_CAP_FLAG_QP_FLOW_CTRL		= BIT(9),
>>  	HNS_ROCE_CAP_FLAG_ATOMIC		= BIT(10),
>> +	HNS_ROCE_CAP_FLAG_UD_SQ_INL		= BIT(13),
>>  	HNS_ROCE_CAP_FLAG_SDI_MODE		= BIT(14),
>>  	HNS_ROCE_CAP_FLAG_STASH			= BIT(17),
>>  };
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> index 833e1f2..619e828 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> @@ -1916,6 +1916,8 @@ static void set_default_caps(struct hns_roce_dev *hr_dev)
>>  		caps->gmv_buf_pg_sz = 0;
>>  		caps->gid_table_len[0] = caps->gmv_bt_num * (HNS_HW_PAGE_SIZE /
>>  					 caps->gmv_entry_sz);
>> +		caps->flags |= HNS_ROCE_CAP_FLAG_UD_SQ_INL;
>> +		caps->max_sq_inline = HNS_ROCE_V2_MAX_SQ_INL_EXT;
> 
> You are doing very similar assignment in the top of set_default_caps().
>   1803         caps->max_sq_inline     = HNS_ROCE_V2_MAX_SQ_INLINE;
> 
> IMHO, it will be better to have one assignment instead of overwrite in
> the same function.
> 
> Thanks
> 

Thanks for your advice, will avoid overwriting fields in this funtion.

Weihang
