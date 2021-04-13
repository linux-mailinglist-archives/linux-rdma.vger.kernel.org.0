Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03FAC35D55A
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Apr 2021 04:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237485AbhDMCiM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 12 Apr 2021 22:38:12 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:3334 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbhDMCiL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Apr 2021 22:38:11 -0400
Received: from DGGEML404-HUB.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4FK8nL00lhz14FqX;
        Tue, 13 Apr 2021 10:34:13 +0800 (CST)
Received: from dggema754-chm.china.huawei.com (10.1.198.196) by
 DGGEML404-HUB.china.huawei.com (10.3.17.39) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Tue, 13 Apr 2021 10:37:50 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema754-chm.china.huawei.com (10.1.198.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Tue, 13 Apr 2021 10:37:50 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2106.013;
 Tue, 13 Apr 2021 10:37:50 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v2 for-next 0/7] RDMA/core: Correct some coding-style
 issues
Thread-Topic: [PATCH v2 for-next 0/7] RDMA/core: Correct some coding-style
 issues
Thread-Index: AQHXK4aas7Hr+61qM0aRWdtWu7J58A==
Date:   Tue, 13 Apr 2021 02:37:50 +0000
Message-ID: <38fd2d20d1634305818ba2d4786b05b0@huawei.com>
References: <1617783353-48249-1-git-send-email-liweihang@huawei.com>
 <20210412175937.GA1145318@nvidia.com>
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

On 2021/4/13 2:00, Jason Gunthorpe wrote:
> On Wed, Apr 07, 2021 at 04:15:46PM +0800, Weihang Li wrote:
>> Do some cleanups according to the coding-style of kernel.
>>
>> Changes since v1:
>> - Remove a BUG_ON in #3 and put the changes into a new patch.
>> - Drop the parts about spaces around xx_for_each_xx() from #4 because some
>>   clang formatter prefer current style.
>> - Link: https://patchwork.kernel.org/project/linux-rdma/cover/1617697184-48683-1-git-send-email-liweihang@huawei.com/
> 
> Let's not make a habit of sending patches like this, but I will take
> this one
>  

Sure.

>> Wenpeng Liang (6):
>>   RDMA/core: Print the function name by __func__ instead of an fixed
>>     string
>>   RDMA/core: Remove the redundant return statements
>>   RDMA/core: Add necessary spaces
>>   RDMA/core: Remove redundant spaces
> 
> I fixed the layout of most of the lines this patch touched as they
> were still not close enough to the canonical format.
> 

OK, thank you.

Weihang

> Applied to for-next, thanks
> 
> Jason
> 

