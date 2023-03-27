Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B00E6CA4EB
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Mar 2023 14:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbjC0MyZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Mar 2023 08:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbjC0Mxk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 Mar 2023 08:53:40 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA83171C
        for <linux-rdma@vger.kernel.org>; Mon, 27 Mar 2023 05:53:38 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PlXkC02lBzKv3Z;
        Mon, 27 Mar 2023 20:51:14 +0800 (CST)
Received: from [10.67.103.121] (10.67.103.121) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 20:53:36 +0800
Subject: Re: [RFC PATCH for-next 3/3] libhns: Add support for SVE Direct WQE
 function
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
References: <20230225100253.3993383-1-xuhaoyue1@hisilicon.com>
 <20230225100253.3993383-4-xuhaoyue1@hisilicon.com>
 <ZBtQ1/3WjWNXAT/b@nvidia.com>
From:   "xuhaoyue (A)" <xuhaoyue1@hisilicon.com>
Message-ID: <53ff5576-3469-1264-aab9-6eed7956238c@hisilicon.com>
Date:   Mon, 27 Mar 2023 20:53:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <ZBtQ1/3WjWNXAT/b@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.121]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.3 required=5.0 tests=HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 2023/3/27, Haoyue Xu wrote:
On 2023/3/23 3:02:47, Jason Gunthorpe wrote:
> On Sat, Feb 25, 2023 at 06:02:53PM +0800, Haoyue Xu wrote:
> 
>> +
>> +set_source_files_properties(hns_roce_u_hw_v2.c PROPERTIES COMPILE_FLAGS "${SVE_FLAGS}")
>> diff --git a/providers/hns/hns_roce_u_hw_v2.c b/providers/hns/hns_roce_u_hw_v2.c
>> index 3a294968..bd457217 100644
>> --- a/providers/hns/hns_roce_u_hw_v2.c
>> +++ b/providers/hns/hns_roce_u_hw_v2.c
>> @@ -299,6 +299,11 @@ static void hns_roce_update_sq_db(struct hns_roce_context *ctx,
>>  	hns_roce_write64(qp->sq.db_reg, (__le32 *)&sq_db);
>>  }
>>  
>> +static void hns_roce_sve_write512(uint64_t *dest, uint64_t *val)
>> +{
>> +	mmio_memcpy_x64_sve(dest, val);
>> +}
> 
> This is not the right way, you should make this work like the x86 SSE
> stuff, using a "__attribute__((target(xx)))"
> 
> Look in util/mmio.c and implement a mmio_memcpy_x64 for ARM SVE
> 
> mmio_memcpy_x64 is defined to try to generate a 64 byte PCI-E TLP.
> 
> If you don't want or can't handle that then you should write your own
> loop of 8 byte stores.
> 

We will refer to the mmio.c and make a new version, reflected in v2.


>>  static void hns_roce_write512(uint64_t *dest, uint64_t *val)
>>  {
>>  	mmio_memcpy_x64(dest, val, sizeof(struct hns_roce_rc_sq_wqe));
>> @@ -314,7 +319,10 @@ static void hns_roce_write_dwqe(struct hns_roce_qp *qp, void *wqe)
>>  	hr_reg_write(rc_sq_wqe, RCWQE_DB_SL_H, qp->sl >> HNS_ROCE_SL_SHIFT);
>>  	hr_reg_write(rc_sq_wqe, RCWQE_WQE_IDX, qp->sq.head);
>>  
>> -	hns_roce_write512(qp->sq.db_reg, wqe);
>> +	if (qp->flags & HNS_ROCE_QP_CAP_SVE_DIRECT_WQE)
> 
> Why do you need a device flag here?

Our CPU die can support NEON instructions and SVE instructions,
but some CPU dies only have SVE instructions that can accelerate our direct WQE performance.
Therefore, we need to add such a flag bit to distinguish.


> 
>> +		hns_roce_sve_write512(qp->sq.db_reg, wqe);
>> +	else
>> +		hns_roce_write512(qp->sq.db_reg, wqe);
> 
> Isn't this function being called on WC memory already? The usual way
> to make the 64 byte write is with stores to WC memory..
> 
> Jason
> .
> 
We are currently using WC memory.

Sincerely,
Haoyue
