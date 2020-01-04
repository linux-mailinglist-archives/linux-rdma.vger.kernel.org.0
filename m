Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED5F13011E
	for <lists+linux-rdma@lfdr.de>; Sat,  4 Jan 2020 06:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbgADF6K (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 4 Jan 2020 00:58:10 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:46542 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725790AbgADF6K (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 4 Jan 2020 00:58:10 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4D67E408A20CD1EE7C0E;
        Sat,  4 Jan 2020 13:58:07 +0800 (CST)
Received: from [127.0.0.1] (10.40.168.149) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Sat, 4 Jan 2020
 13:57:56 +0800
Subject: Re: [PATCH for-next] RDMA/hns: Simplify the calculation and usage of
 wqe idx for post verbs
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Weihang Li <liweihang@hisilicon.com>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
References: <1575981902-5274-1-git-send-email-liweihang@hisilicon.com>
 <20200103195104.GA19725@ziepe.ca>
From:   Weihang Li <liweihang@huawei.com>
Message-ID: <c5270773-5c22-3402-48e6-565e2442d360@huawei.com>
Date:   Sat, 4 Jan 2020 13:57:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200103195104.GA19725@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.168.149]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2020/1/4 3:51, Jason Gunthorpe wrote:
> On Tue, Dec 10, 2019 at 08:45:02PM +0800, Weihang Li wrote:
>> From: Yixian Liu <liuyixian@huawei.com>
>>
>> Currently, the wqe idx is calculated repeatly everywhere it is used.
>> This patch defines wqe_idx and calculated it only once, then just use it
>> as needed.
>>
>> Fixes: 2d40788825ac ("RDMA/hns: Add support for processing send wr and
>> receive wr")
> 
> Please don't wrap fixes tags

I see, thank you.

Weihang

> 
>> Signed-off-by: Yixian Liu <liuyixian@huawei.com>
>> Signed-off-by: Weihang Li <liweihang@hisilicon.com>
>> ---
>>  drivers/infiniband/hw/hns/hns_roce_device.h |  3 +-
>>  drivers/infiniband/hw/hns/hns_roce_hw_v1.c  | 37 +++++++++++--------------
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 43 ++++++++++++-----------------
>>  3 files changed, 35 insertions(+), 48 deletions(-)
> 
> Applied to for-next, thanks
> 
> Jason
> 
> 

