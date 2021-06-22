Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF4413AFB70
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 05:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbhFVDmG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 21 Jun 2021 23:42:06 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5063 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbhFVDmG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Jun 2021 23:42:06 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G8Bpm2HTszXjZ8;
        Tue, 22 Jun 2021 11:34:40 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 22 Jun 2021 11:39:49 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 22 Jun 2021 11:39:48 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2176.012;
 Tue, 22 Jun 2021 11:39:48 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        liangwenpeng <liangwenpeng@huawei.com>
Subject: Re: [PATCH for-next] RDMA/core: Fix incorrect print format specifier
Thread-Topic: [PATCH for-next] RDMA/core: Fix incorrect print format specifier
Thread-Index: AQHXXe13RUm0KzXB/UyeulvcAl47xw==
Date:   Tue, 22 Jun 2021 03:39:48 +0000
Message-ID: <d4618e18227a449fa14199aa8e81fb55@huawei.com>
References: <1623325232-30900-1-git-send-email-liweihang@huawei.com>
 <20210621184054.GA2341530@nvidia.com>
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

On 2021/6/22 2:41, Jason Gunthorpe wrote:
> On Thu, Jun 10, 2021 at 07:40:32PM +0800, Weihang Li wrote:
>> From: Wenpeng Liang <liangwenpeng@huawei.com>
>>
>> There are some '%u' for 'int' and '%d' for 'unsigend int', they should be
>> fixed.
> 
> What tool found these? Mildly surprised normal gcc doesn't complain
>  

They were found by Coverity. I'm using GCC 10.2.0, it can't find the misused
'%u' and '%d', it can only find the case of using '%s' for a integer.

Weihang

>> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
>> Signed-off-by: Weihang Li <liweihang@huawei.com>
>> ---
>>  drivers/infiniband/core/cache.c       | 10 +++++-----
>>  drivers/infiniband/core/cm.c          |  2 +-
>>  drivers/infiniband/core/iwpm_msg.c    | 22 +++++++++++-----------
>>  drivers/infiniband/core/iwpm_util.c   |  4 ++--
>>  drivers/infiniband/core/mad.c         | 10 +++++-----
>>  drivers/infiniband/core/netlink.c     |  2 +-
>>  drivers/infiniband/core/rw.c          |  8 ++++----
>>  drivers/infiniband/core/security.c    |  2 +-
>>  drivers/infiniband/core/sysfs.c       | 10 +++++-----
>>  drivers/infiniband/core/ud_header.c   |  8 ++++----
>>  drivers/infiniband/core/umem_odp.c    |  2 +-
>>  drivers/infiniband/core/user_mad.c    |  4 ++--
>>  drivers/infiniband/core/uverbs_cmd.c  |  2 +-
>>  drivers/infiniband/core/uverbs_uapi.c |  2 +-
>>  drivers/infiniband/core/verbs.c       |  2 +-
>>  15 files changed, 45 insertions(+), 45 deletions(-)
> 
> Applied to for-next, thanks
> 
> Jason
> 

