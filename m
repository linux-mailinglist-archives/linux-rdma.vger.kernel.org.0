Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2732A3F5B29
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Aug 2021 11:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235642AbhHXJht (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Aug 2021 05:37:49 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:15208 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235566AbhHXJht (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Aug 2021 05:37:49 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Gv3sC5Wlhz1CZXB;
        Tue, 24 Aug 2021 17:36:31 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 24 Aug 2021 17:37:03 +0800
Received: from [10.40.238.78] (10.40.238.78) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 24 Aug
 2021 17:37:03 +0800
Subject: Re: [PATCH for-next 0/3] RDMA/hns: Use ida to manage some index of
 resources and remove unused bitmap
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <1629336980-17499-1-git-send-email-liangwenpeng@huawei.com>
 <20210820184833.GA566369@nvidia.com>
 <d40c6ee9-241e-c9b6-fd80-6936db34c1ea@huawei.com>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
From:   Wenpeng Liang <liangwenpeng@huawei.com>
Message-ID: <f96fa057-68cb-ec44-0c29-ef2345b3fdea@huawei.com>
Date:   Tue, 24 Aug 2021 17:37:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <d40c6ee9-241e-c9b6-fd80-6936db34c1ea@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.238.78]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 2021/8/21 16:26, Wenpeng Liang wrote:
> 
> 
> On 2021/8/21 2:48, Jason Gunthorpe wrote:
>> On Thu, Aug 19, 2021 at 09:36:17AM +0800, Wenpeng Liang wrote:
>>> Use the ida interface to replace hns' own bitmap interface. The previous
>>> ida patchset has replaced qp, cq, mr, pd, and xrcd. This ida patchset
>>> will replace the remaining uar and srq. Since then, all replacements
>>> have been completed.
>>>
>>> Link to the previous ida patchset:
>>> https://patchwork.kernel.org/project/linux-rdma/cover/1623325814-55737-1-git-send-email-liweihang@huawei.com/
>>>
>>> Yangyang Li (3):
>>>   RDMA/hns: Use IDA interface to manage uar index
>>>   RDMA/hns: Use IDA interface to manage srq index
>>>   RDMA/hns: Delete unused hns bitmap interface
>>
>> It looks OK, but doesn't apply. Can you rebase it and resend? Looks
>> like it was based on the earlier hns patchset
>>
>> Thanks,
>> Jason
>> .
>>
> 
> I will rebase it and resend.
> 
> Thanks,
> Wenpeng
> .
> 

Hi, Jason
If the jgg-rc-next branch has been revert the patchset
"RDMA/hns: Add support for Dynamic Context Attachment"
(Link:https://patchwork.kernel.org/project/linux-rdma/cover/1627525163-1683-1-git-send -email-liangwenpeng@huawei.com/),
then this patchset can be applied without conflicts, please try again.

Thanks,
Wenpeng
