Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6CCF343B08
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Mar 2021 08:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhCVH4L convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 22 Mar 2021 03:56:11 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5107 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbhCVHzy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Mar 2021 03:55:54 -0400
Received: from DGGEML403-HUB.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4F3mwW3zGWzYMmM;
        Mon, 22 Mar 2021 15:54:03 +0800 (CST)
Received: from dggema701-chm.china.huawei.com (10.3.20.65) by
 DGGEML403-HUB.china.huawei.com (10.3.17.33) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Mon, 22 Mar 2021 15:55:48 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema701-chm.china.huawei.com (10.3.20.65) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Mon, 22 Mar 2021 15:55:48 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2106.013;
 Mon, 22 Mar 2021 15:55:48 +0800
From:   liweihang <liweihang@huawei.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH for-next] RDMA/core: Check invalid QP state for
 ib_modify_qp_is_ok()
Thread-Topic: [PATCH for-next] RDMA/core: Check invalid QP state for
 ib_modify_qp_is_ok()
Thread-Index: AQHXHJ8NNG3a5kWMHUaHioKmCNer6w==
Date:   Mon, 22 Mar 2021 07:55:48 +0000
Message-ID: <b1e09bb801b74e6e8d97b93821c1da95@huawei.com>
References: <1616144545-18159-1-git-send-email-liweihang@huawei.com>
 <YFXBprYFmFgHu9Z8@unreal> <53ff6a59a9a74443bca58bcaee6292bb@huawei.com>
 <YFgveGZ+fnDKPB81@unreal> <d1cbb0213aba493695162ee07d0d0338@huawei.com>
 <YFhHMlnzdcAMp3qs@unreal>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.100.165]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2021/3/22 15:29, Leon Romanovsky wrote:
> On Mon, Mar 22, 2021 at 07:11:47AM +0000, liweihang wrote:
>> On 2021/3/22 13:47, Leon Romanovsky wrote:
>>> On Mon, Mar 22, 2021 at 03:29:09AM +0000, liweihang wrote:
>>>> On 2021/3/20 17:34, Leon Romanovsky wrote:
>>>>> On Fri, Mar 19, 2021 at 05:02:25PM +0800, Weihang Li wrote:
>>>>>> From: Xi Wang <wangxi11@huawei.com>
>>>>>>
>>>>>> Out-of-bounds may occur in 'qp_state_table' when the caller passing wrong
>>>>>> QP state value.
>>>>> How is it possible? Do you have call stack to support it?
>>>>>
>>>>> Thanks
>>>>>
>>>> ib_modify_qp_is_ok() is exported, I think any kernel modules can pass in
>>>> invalid QP state. Should we check it in such case?
>>> No, it is caller responsibility to supply valid input.
>>> In general case, for the kernel code, it can be seen as anti-pattern
>>> if in-kernel API performs input sanity check.
>>>
>>> You can add WARN_ON() if you want to catch programmers errors earlier.
>>> However, I'm skeptical if it is really needed here. 
>>>
>>> Thanks
>>>
>>
>> Hi Leon,
>>
>> By the way, we made this change because we noticed that ib_event_msg() and
>> ib_wc_status_msg() that tries to access an array performs input check in the
>> same file. Is there anything different between these kernel APIs? Or there is
>> some other reasons?
> 
> The main difference between them is the execution flow.
>  * ib_modify_qp_is_ok() is called from the drivers, after verbs layer
>    sanitized everything already and at this stage we are pretty safe.
>  * ib_event_msg()/ib_wc_status_ms() are used by ULPs and maybe they can
>    send invalid event. I personally don't know if it is possible or not.
> 
> Thanks
> 

Thank you, this is helpful.

Weihang


