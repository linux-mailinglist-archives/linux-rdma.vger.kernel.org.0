Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13AD5182CAC
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2020 10:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgCLJpr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 12 Mar 2020 05:45:47 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3419 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726302AbgCLJpr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Mar 2020 05:45:47 -0400
Received: from dggeml406-hub.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id CC122377A54335B5F146;
        Thu, 12 Mar 2020 17:45:42 +0800 (CST)
Received: from DGGEML422-HUB.china.huawei.com (10.1.199.39) by
 dggeml406-hub.china.huawei.com (10.3.17.50) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 12 Mar 2020 17:45:42 +0800
Received: from DGGEML522-MBX.china.huawei.com ([169.254.7.20]) by
 dggeml422-hub.china.huawei.com ([10.1.199.39]) with mapi id 14.03.0439.000;
 Thu, 12 Mar 2020 17:45:35 +0800
From:   liweihang <liweihang@huawei.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v3 for-next] RDMA/hns: Check if depth of qp is 0 before
 configure
Thread-Topic: [PATCH v3 for-next] RDMA/hns: Check if depth of qp is 0 before
 configure
Thread-Index: AQHV+E1M0BNohuydI0mK8G+4VtxUjQ==
Date:   Thu, 12 Mar 2020 09:45:34 +0000
Message-ID: <B82435381E3B2943AA4D2826ADEF0B3A0227D376@DGGEML522-MBX.china.huawei.com>
References: <1583995244-51072-1-git-send-email-liweihang@huawei.com>
 <20200312090438.GB17383@unreal>
 <B82435381E3B2943AA4D2826ADEF0B3A0227BBCE@DGGEML522-MBX.china.huawei.com>
 <20200312093948.GB31504@unreal>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.40.168.149]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020/3/12 17:40, Leon Romanovsky wrote:
> On Thu, Mar 12, 2020 at 09:27:39AM +0000, liweihang wrote:
>> On 2020/3/12 17:04, Leon Romanovsky wrote:
>>> On Thu, Mar 12, 2020 at 02:40:44PM +0800, Weihang Li wrote:
>>>> From: Lang Cheng <chenglang@huawei.com>
>>>>
>>>> Depth of qp shouldn't be allowed to be set to zero, after ensuring that,
>>>> subsequent process can be simplified. And when qp is changed from reset to
>>>> reset, the capability of minimum qp depth was used to identify hardware of
>>>> hip06, it should be changed into a more readable form.
>>>>
>>>> Signed-off-by: Lang Cheng <chenglang@huawei.com>
>>>> Signed-off-by: Weihang Li <liweihang@huawei.com>
>>>> Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
>>>
>>> I didn't review, please don't add tags before they explicitly posted.
>>> https://lore.kernel.org/linux-rdma/1583140937-2223-1-git-send-email-liweihang@huawei.com/
>>>
>>> Thanks
>>>
>>
>> Sorry, I misunderstood what you mean about the Reviewed-by tag in
>> previous discussions. Will remove it and send a new version.
> 
> You are supposed to add those tags if someone writes something like this:
> Reviewed-by: ....
> 
> Thanks
> 

I see, thank you.

>>
>> Thank you
>> Weihang
> 

