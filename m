Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 599C734395B
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Mar 2021 07:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbhCVGWP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 22 Mar 2021 02:22:15 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3913 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhCVGWD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Mar 2021 02:22:03 -0400
Received: from DGGEML402-HUB.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4F3kr25KlMz5ggd;
        Mon, 22 Mar 2021 14:20:02 +0800 (CST)
Received: from dggema703-chm.china.huawei.com (10.3.20.67) by
 DGGEML402-HUB.china.huawei.com (10.3.17.38) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Mon, 22 Mar 2021 14:21:59 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema703-chm.china.huawei.com (10.3.20.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Mon, 22 Mar 2021 14:21:59 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2106.013;
 Mon, 22 Mar 2021 14:21:59 +0800
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
Date:   Mon, 22 Mar 2021 06:21:59 +0000
Message-ID: <4dd201a6dce74d47a9fdd00863b80524@huawei.com>
References: <1616144545-18159-1-git-send-email-liweihang@huawei.com>
 <YFXBprYFmFgHu9Z8@unreal> <53ff6a59a9a74443bca58bcaee6292bb@huawei.com>
 <YFgveGZ+fnDKPB81@unreal>
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

On 2021/3/22 13:47, Leon Romanovsky wrote:
> On Mon, Mar 22, 2021 at 03:29:09AM +0000, liweihang wrote:
>> On 2021/3/20 17:34, Leon Romanovsky wrote:
>>> On Fri, Mar 19, 2021 at 05:02:25PM +0800, Weihang Li wrote:
>>>> From: Xi Wang <wangxi11@huawei.com>
>>>>
>>>> Out-of-bounds may occur in 'qp_state_table' when the caller passing wrong
>>>> QP state value.
>>> How is it possible? Do you have call stack to support it?
>>>
>>> Thanks
>>>
>> ib_modify_qp_is_ok() is exported, I think any kernel modules can pass in
>> invalid QP state. Should we check it in such case?
> No, it is caller responsibility to supply valid input.
> In general case, for the kernel code, it can be seen as anti-pattern
> if in-kernel API performs input sanity check.
> 
> You can add WARN_ON() if you want to catch programmers errors earlier.
> However, I'm skeptical if it is really needed here. 
> 
> Thanks
> 

I see, thank you for the explanation. In that case, we don't need this patch.

Weihang
