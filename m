Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C109DFA0B
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2019 03:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbfJVBOO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Oct 2019 21:14:14 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4701 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727264AbfJVBON (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Oct 2019 21:14:13 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 40F6A3C0A1668F8716E4;
        Tue, 22 Oct 2019 09:14:11 +0800 (CST)
Received: from [127.0.0.1] (10.61.25.96) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Tue, 22 Oct 2019
 09:14:00 +0800
Subject: Re: [PATCH for-next 9/9] RDMA/hns: Copy some information of AV to
 user
To:     Doug Ledford <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
References: <1565343666-73193-1-git-send-email-oulijun@huawei.com>
 <1565343666-73193-10-git-send-email-oulijun@huawei.com>
 <3056732a61a9f4d356f761f0e436cc01e67aac31.camel@redhat.com>
From:   oulijun <oulijun@huawei.com>
Message-ID: <09a9101e-b458-a7c7-4fde-adc63feefc16@huawei.com>
Date:   Tue, 22 Oct 2019 09:13:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <3056732a61a9f4d356f761f0e436cc01e67aac31.camel@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.61.25.96]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2019/10/22 1:23, Doug Ledford 写道:
> On Fri, 2019-08-09 at 17:41 +0800, Lijun Ou wrote:
>> When the driver support UD transport in user mode, it needs to
>> create the Address Handle(AH) and transfer Address Vector to
>> The hardware. The Address Vector includes the destination mac
>> and vlan inforation and it will be generated from the kernel
>> driver. As a result, we can copy this information to user
>> through ib_copy_to_udata function.
>>
>> Signed-off-by: Lijun Ou <oulijun@huawei.com>
> This patch is broken.  There are multiple instance of whitespace
> breakage (spaces that should be tabs, etc.), and at least one instance
> of a hanging character that makes no sense:
>
>>  	ah->av.sl_tclass_flowlabel = cpu_to_le32(rdma_ah_get_sl(ah_attr)
>> <<
>> -						 HNS_ROCE_SL_SHIFT);
>> +				i		 HNS_ROCE_SL_SHIFT);
>                                 ^ ?
> This needs to be resubmitted.
>
ok， I will do


