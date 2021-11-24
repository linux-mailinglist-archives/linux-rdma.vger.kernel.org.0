Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D75AE45B2F3
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Nov 2021 05:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240907AbhKXEFJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Nov 2021 23:05:09 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:28170 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240896AbhKXEFJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Nov 2021 23:05:09 -0500
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HzS2c1GBpz8vZQ;
        Wed, 24 Nov 2021 12:00:08 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 24 Nov 2021 12:01:59 +0800
Received: from [10.40.238.78] (10.40.238.78) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Wed, 24 Nov
 2021 12:01:58 +0800
Subject: Re: [PATCH for-next 5/9] RDMA/hns: Initialize variable in the right
 place
To:     Jason Gunthorpe <jgg@ziepe.ca>
References: <20211119140208.40416-1-liangwenpeng@huawei.com>
 <20211119140208.40416-6-liangwenpeng@huawei.com>
 <20211119172732.GK876299@ziepe.ca>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
From:   Wenpeng Liang <liangwenpeng@huawei.com>
Message-ID: <ebe24c33-a9cd-c9f2-fb9e-44385a7d9470@huawei.com>
Date:   Wed, 24 Nov 2021 12:01:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20211119172732.GK876299@ziepe.ca>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.238.78]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2021/11/20 1:27, Jason Gunthorpe wrote:
> On Fri, Nov 19, 2021 at 10:02:04PM +0800, Wenpeng Liang wrote:
>> From: Haoyue Xu <xuhaoyue1@hisilicon.com>
>>
>> The "ret" should be initialized when it is defined instead of in the loop.
> 
> Why?
> 
> It is a bit weird, but the code is fine as written
> 
> The only suggestion I'd make is
> 
>  	if (hns_roce_cmq_csq_done(hr_dev)) {
>                 ret = 0;
> 		for (i = 0; i < num; i++) {
> 
> Just because the , operator is not so typically used like that
> 
> Jason
> .
> 

Thanks for your suggestion, I will assign ret in the if branch in v2.

Thanks,
Wenpeng
