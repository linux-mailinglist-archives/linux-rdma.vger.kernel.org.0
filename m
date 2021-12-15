Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5BD3475605
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Dec 2021 11:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236717AbhLOKP5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Dec 2021 05:15:57 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:15743 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233862AbhLOKP5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Dec 2021 05:15:57 -0500
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JDWK34n3rzZdhk;
        Wed, 15 Dec 2021 18:12:55 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 15 Dec 2021 18:15:55 +0800
Received: from [10.40.238.78] (10.40.238.78) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Wed, 15 Dec
 2021 18:15:55 +0800
Subject: Re: [PATCH v6 for-next 0/1] RDMA/hns: Support direct WQE of userspace
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20211207124901.42123-1-liangwenpeng@huawei.com>
 <20211215000325.GA975121@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
From:   Wenpeng Liang <liangwenpeng@huawei.com>
Message-ID: <6225fb50-cf7c-4f0e-96a3-84c7ad3e9ee7@huawei.com>
Date:   Wed, 15 Dec 2021 18:15:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20211215000325.GA975121@nvidia.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.238.78]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2021/12/15 8:03, Jason Gunthorpe wrote:
> On Tue, Dec 07, 2021 at 08:49:00PM +0800, Wenpeng Liang wrote:
>> Direct wqe is a mechanism to fill wqe directly into the hardware. In the
>> case of light load, the wqe will be filled into pcie bar space of the
>> hardware, this will reduce one memory access operation and therefore reduce
>> the latency.
>>
>> The user space parts is named "libhns: Add support for direct wqe".
> 
> Applied to for-next, thanks
> 
> Please update the PR on the github
> 

The PR has been updated.

https://github.com/linux-rdma/rdma-core/pull/1088

Thanks
Wenpeng

> Jason
> .
>
