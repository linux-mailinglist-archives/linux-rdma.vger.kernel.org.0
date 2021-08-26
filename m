Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0DC3F86A0
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Aug 2021 13:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242114AbhHZLm0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Aug 2021 07:42:26 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:8780 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242290AbhHZLm0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Aug 2021 07:42:26 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GwLWz07g4zYtkR;
        Thu, 26 Aug 2021 19:41:03 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 26 Aug 2021 19:41:35 +0800
Received: from [10.40.238.78] (10.40.238.78) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 26 Aug
 2021 19:41:35 +0800
Subject: Re: [PATCH for-next 0/3] RDMA/hns: Fix some errors in the congestion
 control algorithm
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <1629884592-23424-1-git-send-email-liangwenpeng@huawei.com>
 <20210825175059.GD1200145@nvidia.com>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
From:   Wenpeng Liang <liangwenpeng@huawei.com>
Message-ID: <a0cbe12f-1dbd-7bc4-309e-16a35ff0ba90@huawei.com>
Date:   Thu, 26 Aug 2021 19:41:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20210825175059.GD1200145@nvidia.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.238.78]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2021/8/26 1:50, Jason Gunthorpe wrote:
> On Wed, Aug 25, 2021 at 05:43:09PM +0800, Wenpeng Liang wrote:
>> Fix three dip_idx related errors.
>>
>> Junxian Huang (3):
>>   RDMA/hns: Bugfix for data type of dip_idx
>>   RDMA/hns: Bugfix for the missing assignment for dip_idx
>>   RDMA/hns: Bugfix for incorrect association between dip_idx and dgid
> 
> Applied to for-next
> 
> Please do not put a blank line after Fixes:, it needs to be part of
> the trailer block to parse properly. I fixed it
> 
> Thanks,
> Jason
> .
> 

Sorry, I forgot to delete the blank line when submitting the commit,
I will pay more attention to it in the future.

Thanks,
Wenpeng
