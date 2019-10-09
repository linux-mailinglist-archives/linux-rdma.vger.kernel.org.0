Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 279B3D051C
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Oct 2019 03:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729737AbfJIBPR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Oct 2019 21:15:17 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3664 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727051AbfJIBPR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 8 Oct 2019 21:15:17 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BB81D622A3AAD2CD37BE;
        Wed,  9 Oct 2019 09:15:15 +0800 (CST)
Received: from [127.0.0.1] (10.40.168.149) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Wed, 9 Oct 2019
 09:15:08 +0800
Subject: Re: [PATCH for-next] RDMA/hns: Release qp resources when failed to
 destroy qp
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
References: <1570532331-49676-1-git-send-email-liweihang@hisilicon.com>
 <20191008194810.GA3280@ziepe.ca>
From:   Weihang Li <liweihang@hisilicon.com>
Message-ID: <3af76d7d-30e2-e48f-6187-d33effe45c36@hisilicon.com>
Date:   Wed, 9 Oct 2019 09:15:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191008194810.GA3280@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.168.149]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2019/10/9 3:48, Jason Gunthorpe wrote:
> On Tue, Oct 08, 2019 at 06:58:51PM +0800, Weihang Li wrote:
>> From: Yangyang Li <liyangyang20@huawei.com>
>>
>> Even if no response from hardware, we should make sure that qp related
>> resources are released to avoid memory leaks.
>>
>> Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
>> Signed-off-by: Weihang Li <liweihang@hisilicon.com>
>> ---
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 12 ++++--------
>>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> This needs a fixes line
>  
> Jason
> 

OK, thank you.

> 

