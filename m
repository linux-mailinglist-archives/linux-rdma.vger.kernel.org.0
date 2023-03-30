Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70CF36D057D
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Mar 2023 14:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjC3M5u (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Mar 2023 08:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjC3M5t (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Mar 2023 08:57:49 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236EF44B8
        for <linux-rdma@vger.kernel.org>; Thu, 30 Mar 2023 05:57:46 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PnNhw3dGXzrZP8;
        Thu, 30 Mar 2023 20:56:32 +0800 (CST)
Received: from [10.67.103.121] (10.67.103.121) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 30 Mar 2023 20:57:41 +0800
Subject: Re: [RFC PATCH for-next 3/3] libhns: Add support for SVE Direct WQE
 function
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
References: <20230225100253.3993383-1-xuhaoyue1@hisilicon.com>
 <20230225100253.3993383-4-xuhaoyue1@hisilicon.com>
 <ZBtQ1/3WjWNXAT/b@nvidia.com>
 <53ff5576-3469-1264-aab9-6eed7956238c@hisilicon.com>
 <ZCGSXzD8LJqsXHTF@nvidia.com>
From:   "xuhaoyue (A)" <xuhaoyue1@hisilicon.com>
Message-ID: <3789bfe9-f96e-8d87-9322-6f1476757704@hisilicon.com>
Date:   Thu, 30 Mar 2023 20:57:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <ZCGSXzD8LJqsXHTF@nvidia.com>
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



On 2023/3/27 20:55:59, Jason Gunthorpe wrote:
> On Mon, Mar 27, 2023 at 08:53:35PM +0800, xuhaoyue (A) wrote:
> 
>>>>  static void hns_roce_write512(uint64_t *dest, uint64_t *val)
>>>>  {
>>>>  	mmio_memcpy_x64(dest, val, sizeof(struct hns_roce_rc_sq_wqe));
>>>> @@ -314,7 +319,10 @@ static void hns_roce_write_dwqe(struct hns_roce_qp *qp, void *wqe)
>>>>  	hr_reg_write(rc_sq_wqe, RCWQE_DB_SL_H, qp->sl >> HNS_ROCE_SL_SHIFT);
>>>>  	hr_reg_write(rc_sq_wqe, RCWQE_WQE_IDX, qp->sq.head);
>>>>  
>>>> -	hns_roce_write512(qp->sq.db_reg, wqe);
>>>> +	if (qp->flags & HNS_ROCE_QP_CAP_SVE_DIRECT_WQE)
>>>
>>> Why do you need a device flag here?
>>
>> Our CPU die can support NEON instructions and SVE instructions,
>> but some CPU dies only have SVE instructions that can accelerate our direct WQE performance.
>> Therefore, we need to add such a flag bit to distinguish.
> 
> NEON vs SVE is available to userspace already, it shouldn't come
> throuhg a driver flag. You need another reason to add this flag
> 
> The userspace should detect the right instruction to use based on the
> cpu flags using the attribute stuff I pointed you at
> 
> Jason
> .
> 

We optimized direct wqe based on different instructions for different CPUs,
but the architecture of the CPUs is the same and supports both SVE and NEON instructions.
We plan to use cpuid to distinguish between them. Is this more reasonable?

Sincerely,
Haoyue
