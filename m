Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC6E45B2F6
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Nov 2021 05:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240911AbhKXEH3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Nov 2021 23:07:29 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:28099 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240896AbhKXEH1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Nov 2021 23:07:27 -0500
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HzS4T0p8Dz1DJV9;
        Wed, 24 Nov 2021 12:01:45 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 24 Nov 2021 12:04:16 +0800
Received: from [10.40.238.78] (10.40.238.78) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Wed, 24 Nov
 2021 12:04:16 +0800
Subject: Re: [PATCH for-next 7/9] RDMA/hns: Add void conversion for function
 whose return value is not used
To:     Jason Gunthorpe <jgg@ziepe.ca>
References: <20211119140208.40416-1-liangwenpeng@huawei.com>
 <20211119140208.40416-8-liangwenpeng@huawei.com>
 <20211119172830.GL876299@ziepe.ca>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
From:   Wenpeng Liang <liangwenpeng@huawei.com>
Message-ID: <6806451c-dcd0-a76f-a3e2-bcb7b889b091@huawei.com>
Date:   Wed, 24 Nov 2021 12:04:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20211119172830.GL876299@ziepe.ca>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.238.78]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2021/11/20 1:28, Jason Gunthorpe wrote:
> On Fri, Nov 19, 2021 at 10:02:06PM +0800, Wenpeng Liang wrote:
>> From: Xinhao Liu <liuxinhao5@hisilicon.com>
>>
>> If the return value of the function is not used, then void should be
>> added.
> 
> AFAIK we don't do this in the kernel
> 
> Jason
> .
> 

Thanks for your comments, I will fix it in v2.

Thanks
Wenpeng
