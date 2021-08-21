Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A413F39E8
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Aug 2021 11:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbhHUJkO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 21 Aug 2021 05:40:14 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:15200 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbhHUJkO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 21 Aug 2021 05:40:14 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GsD3Y3VVvz1CYF9;
        Sat, 21 Aug 2021 17:39:05 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 21 Aug 2021 17:39:33 +0800
Received: from [10.40.238.78] (10.40.238.78) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Sat, 21 Aug
 2021 17:39:33 +0800
Subject: Re: [PATCH v4 for-next 08/12] RDMA/hns: Add method to query WQE
 buffer's address
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <1627525163-1683-1-git-send-email-liangwenpeng@huawei.com>
 <1627525163-1683-9-git-send-email-liangwenpeng@huawei.com>
 <20210819235808.GA399558@nvidia.com>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, <leon@kernel.org>,
        Xi Wang <wangxi11@huawei.com>
From:   Wenpeng Liang <liangwenpeng@huawei.com>
Message-ID: <3c9a7034-3d88-4e00-e52c-27a8a8ca6c56@huawei.com>
Date:   Sat, 21 Aug 2021 17:39:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20210819235808.GA399558@nvidia.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.238.78]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2021/8/20 7:58, Jason Gunthorpe wrote:
> On Thu, Jul 29, 2021 at 10:19:19AM +0800, Wenpeng Liang wrote:
> 
>>  DECLARE_UVERBS_NAMED_OBJECT(HNS_IB_OBJECT_DCA_MEM,
>>  			    UVERBS_TYPE_ALLOC_IDR(dca_cleanup),
>>  			    &UVERBS_METHOD(HNS_IB_METHOD_DCA_MEM_REG),
>>  			    &UVERBS_METHOD(HNS_IB_METHOD_DCA_MEM_DEREG),
>>  			    &UVERBS_METHOD(HNS_IB_METHOD_DCA_MEM_SHRINK),
>>  			    &UVERBS_METHOD(HNS_IB_METHOD_DCA_MEM_ATTACH),
>> -			    &UVERBS_METHOD(HNS_IB_METHOD_DCA_MEM_DETACH));
>> +			    &UVERBS_METHOD(HNS_IB_METHOD_DCA_MEM_DETACH),
>> +			    &UVERBS_METHOD(HNS_IB_METHOD_DCA_MEM_QUERY));
> 
> These lists should be kept sorted in each patch
> 

DECLARE_UVERBS_NAMED_METHOD() will be put together in order.

>> +struct hns_dca_query_resp {
>> +	u64 mem_key;
>> +	u32 mem_ofs;
>> +	u32 page_count;
>> +};
> 
> This is strange, why in a public header, why have the query_dca_mem
> function at all? Just inline it and remove the struct entirely.
> 
> Jason
> .
> 

There is indeed no need to form a separate query_dca_mem function,
will inline it.

Thanks,
Wenpeng.
