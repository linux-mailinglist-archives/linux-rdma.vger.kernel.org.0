Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3094C9B33
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Mar 2022 03:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235847AbiCBC27 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Mar 2022 21:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiCBC26 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Mar 2022 21:28:58 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5086A13E05
        for <linux-rdma@vger.kernel.org>; Tue,  1 Mar 2022 18:28:13 -0800 (PST)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4K7dFw0HKXz1GBvn;
        Wed,  2 Mar 2022 10:23:32 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Mar 2022 10:28:11 +0800
Received: from [10.40.238.78] (10.40.238.78) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 2 Mar
 2022 10:28:11 +0800
Subject: Re: [PATCH v2 for-next 7/9] RDMA/hns: Clean up the return value check
 of hns_roce_alloc_cmd_mailbox()
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20220225112559.43300-1-liangwenpeng@huawei.com>
 <20220225112559.43300-8-liangwenpeng@huawei.com>
 <20220228160458.GA595987@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
From:   Wenpeng Liang <liangwenpeng@huawei.com>
Message-ID: <e3e68b06-c383-8313-5320-15febcb94a5c@huawei.com>
Date:   Wed, 2 Mar 2022 10:28:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20220228160458.GA595987@nvidia.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.238.78]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2022/3/1 0:04, Jason Gunthorpe wrote:
> On Fri, Feb 25, 2022 at 07:25:57PM +0800, Wenpeng Liang wrote:
>> @@ -282,7 +280,7 @@ struct ib_mr *hns_roce_rereg_user_mr(struct ib_mr *ibmr, int flags, u64 start,
>>  
>>  	mailbox = hns_roce_alloc_cmd_mailbox(hr_dev);
>>  	if (IS_ERR(mailbox))
>> -		return ERR_CAST(mailbox);
>> +		return ERR_PTR(mailbox);
> 
> This doesn't compile, it should stay as ERR_CAST, right?
> 
> Jason
> .
> 

Yes, should keep using ERR_CAST, I missed the compile warning.
Fix it in v3.

Thanks,
Wenpeng
