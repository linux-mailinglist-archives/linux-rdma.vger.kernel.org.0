Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D76113389F
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jan 2020 02:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbgAHBnG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jan 2020 20:43:06 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:41582 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725601AbgAHBnG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 7 Jan 2020 20:43:06 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id CF725A79E4ADEAB27148;
        Wed,  8 Jan 2020 09:43:03 +0800 (CST)
Received: from [127.0.0.1] (10.40.168.149) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Wed, 8 Jan 2020
 09:42:57 +0800
Subject: Re: [PATCH for-next 7/7] RDMA/hns: Fix coding style issues
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
References: <1578313276-29080-1-git-send-email-liweihang@huawei.com>
 <1578313276-29080-8-git-send-email-liweihang@huawei.com>
 <20200107203121.GA5313@ziepe.ca>
From:   Weihang Li <liweihang@huawei.com>
Message-ID: <6df9e9a1-5a26-ceb8-6d41-f7c81a194617@huawei.com>
Date:   Wed, 8 Jan 2020 09:42:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200107203121.GA5313@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.168.149]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2020/1/8 4:31, Jason Gunthorpe wrote:
> On Mon, Jan 06, 2020 at 08:21:16PM +0800, Weihang Li wrote:
>> From: Lijun Ou <oulijun@huawei.com>
>>
>> Fix some coding style issuses without changing logic of codes, most of the
>> modification is unreasonable line breaks and alignments.
>>
>> Signed-off-by: Lijun Ou <oulijun@huawei.com>
>> Signed-off-by: Lang Cheng <chenglang@huawei.com>
>> Signed-off-by: Weihang Li <liweihang@huawei.com>
>> ---
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 167 ++++++++++-------------------
>>  drivers/infiniband/hw/hns/hns_roce_main.c  |  56 +++++-----
>>  2 files changed, 86 insertions(+), 137 deletions(-)
> 
> If you are going to be re-intending code please at least refer to
> clang-format's presentation. I recommend clang-format as an
> interactive editor plugin to do single statement reformatting on
> demand to help follow the coding style.
> 
> I ran it over the lines changed here and it suggested the below, which
> seems like a reasonable improvement so I folded it in:
>  - One line is better than two
>  - Subexpressions crossing lines should be indented more than the
>    normal indent. ie
>     foo(a &
>           B,
>         c)
>  - ?: should line up under the ?
> 

Hi Jason,

Thanks for your advice and your modifications on this patch :)
We will use clang-format and other tools to help fix coding style issues
next time.

Weihang

