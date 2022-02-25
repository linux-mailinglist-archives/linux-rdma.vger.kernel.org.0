Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0D94C42D2
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Feb 2022 11:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238587AbiBYKxu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Feb 2022 05:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239853AbiBYKxt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Feb 2022 05:53:49 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A62C1B5115
        for <linux-rdma@vger.kernel.org>; Fri, 25 Feb 2022 02:53:16 -0800 (PST)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4K4mmx328FzdfgZ;
        Fri, 25 Feb 2022 18:52:01 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 25 Feb 2022 18:53:14 +0800
Received: from [10.40.238.78] (10.40.238.78) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 25 Feb
 2022 18:53:14 +0800
Subject: Re: [PATCH for-next 7/8] RDMA/hns: Refactor the alloc_srqc()
To:     Leon Romanovsky <leon@kernel.org>
References: <20220218110519.37375-1-liangwenpeng@huawei.com>
 <20220218110519.37375-8-liangwenpeng@huawei.com> <YheJtTpU04bYtvNm@unreal>
CC:     <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
From:   Wenpeng Liang <liangwenpeng@huawei.com>
Message-ID: <97995b94-27ce-9d5b-d438-35f0bc433b18@huawei.com>
Date:   Fri, 25 Feb 2022 18:53:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <YheJtTpU04bYtvNm@unreal>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.238.78]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

On 2022/2/24 21:35, Leon Romanovsky wrote:
>> +static int hns_roce_create_srqc(struct hns_roce_dev *hr_dev,
>> +				struct hns_roce_srq *srq)
>> +{
>> +	struct ib_device *ibdev = &hr_dev->ib_dev;
>> +	struct hns_roce_cmd_mailbox *mailbox;
>> +	int ret;
>>  
>>  	mailbox = hns_roce_alloc_cmd_mailbox(hr_dev);
>>  	if (IS_ERR_OR_NULL(mailbox)) {
> hns_roce_alloc_cmd_mailbox() never returns NULL, so the check should be IS_ERR()
> 
> Thanks
> 

There are a few more hns_roce_alloc_cmd_mailbox() return values to deal with.
I will add a new patch in v2.

Thanks,
Wenpeng

>>  		ibdev_err(ibdev, "failed to alloc mailbox for SRQC.\n");
>> -		ret = -ENOMEM;
>> -		goto err_xa;
>> +		return PTR_ERR(mailbox);
>>  	}
