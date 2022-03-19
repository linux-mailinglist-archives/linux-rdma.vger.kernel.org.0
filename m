Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45AA4DE4FC
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Mar 2022 02:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238454AbiCSB1m (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Mar 2022 21:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiCSB1l (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Mar 2022 21:27:41 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD4930A8A5
        for <linux-rdma@vger.kernel.org>; Fri, 18 Mar 2022 18:26:21 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KL35W2zBZz9spv;
        Sat, 19 Mar 2022 09:22:23 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 19 Mar 2022 09:26:14 +0800
Received: from [10.40.238.78] (10.40.238.78) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Sat, 19 Mar
 2022 09:26:14 +0800
Subject: Re: [PATCH for-next v4 05/12] RDMA/erdma: Add cmdq implementation
To:     Jason Gunthorpe <jgg@ziepe.ca>
References: <20220314064739.81647-1-chengyou@linux.alibaba.com>
 <20220314064739.81647-6-chengyou@linux.alibaba.com>
 <ed329d4d-c3e8-ea4b-f599-577d16de4be0@huawei.com>
 <20220318181746.GF64706@ziepe.ca>
CC:     Cheng Xu <chengyou@linux.alibaba.com>, <dledford@redhat.com>,
        <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <KaiShen@linux.alibaba.com>, <tonylu@linux.alibaba.com>,
        <BMT@zurich.ibm.com>
From:   Wenpeng Liang <liangwenpeng@huawei.com>
Message-ID: <7e72c0db-27fb-45bb-b0a6-a9f6a20a3b77@huawei.com>
Date:   Sat, 19 Mar 2022 09:26:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20220318181746.GF64706@ziepe.ca>
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

On 2022/3/19 2:17, Jason Gunthorpe wrote:
> On Fri, Mar 18, 2022 at 07:16:08PM +0800, Wenpeng Liang wrote:
>> On 2022/3/14 14:47, Cheng Xu wrote:
>> <...>
>>> +int erdma_cmdq_init(struct erdma_dev *dev)
>>> +{
>>> +	int err, i;
>>> +	struct erdma_cmdq *cmdq = &dev->cmdq;
>>> +	u32 status, ctrl;
>>
>> Hi, Jason and Leon
>>
>> Defining and initializing variables in the form of an inverted triangle at
>> the head of the function can make the code clearer. The kernel's coding-style
>> does not specify this behavior, and the various kernel subsystems do not seem
>> to have formed a unified opinion. Does our RDMA subsystem recommend this?
>>
>> struct erdma_cmdq *cmdq = &dev->cmdq;
>> u32 status, ctrl;
>> int err, i;
> 
> This is often called reverse christmas tree style
> 
> It is common in RDMA, but I would not insist on it.

Thanks for your reply and correction.

Thanks,
Wenpeng

> 
> Thanks,
> Jason
> .
> 
