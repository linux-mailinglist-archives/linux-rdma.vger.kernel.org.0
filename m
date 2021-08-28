Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDB03FA48E
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Aug 2021 11:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbhH1In4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 28 Aug 2021 04:43:56 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:36195 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230208AbhH1In4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 28 Aug 2021 04:43:56 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AF1wl1qCiWNixr97lHemQ55DYdb4zR+YMi2TD?=
 =?us-ascii?q?tnoBLSC9F/b0qynAppomPGDP4gr5NEtApTniAtjkfZq/z+8X3WB5B97LMzUO01?=
 =?us-ascii?q?HYTr2Kg7GD/xTQXwX69sN4kZxrarVCDrTLZmRSvILX5xaZHr8brOW6zA=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.84,359,1620662400"; 
   d="scan'208";a="113603736"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 28 Aug 2021 16:42:58 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id DDF7C4D0D9D5;
        Sat, 28 Aug 2021 16:42:53 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Sat, 28 Aug 2021 16:42:53 +0800
Received: from [192.168.122.212] (10.167.226.45) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Sat, 28 Aug 2021 16:42:54 +0800
Subject: Re: [PATCH] RDMA/mlx5: return the EFAULT per ibv_advise_mr(3)
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210801092050.6322-1-lizhijian@cn.fujitsu.com>
 <20210803162507.GA2892108@nvidia.com> <YQmDZpbCy3uTS5jv@unreal>
 <20210803181341.GE1721383@nvidia.com> <YQonIu3VMTlGj0TJ@unreal>
 <20210804185022.GM1721383@nvidia.com> <YQuIlUT9jZLeFPNH@unreal>
 <6b372500-ebc5-bc42-11c5-99de381b2e50@fujitsu.com>
 <7b930773-0071-5b96-2a85-718d0ca07bfa@cn.fujitsu.com>
 <20210825172844.GK1721383@nvidia.com>
 <fb1c7505-62d3-a64e-4c57-170f9f5f86a4@fujitsu.com>
From:   "Li, Zhijian" <lizhijian@cn.fujitsu.com>
Message-ID: <238e5d3c-30e8-86fc-0263-42864fd0d848@cn.fujitsu.com>
Date:   Sat, 28 Aug 2021 16:42:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <fb1c7505-62d3-a64e-4c57-170f9f5f86a4@fujitsu.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-yoursite-MailScanner-ID: DDF7C4D0D9D5.ADCD4
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Just noticed that there is another code path i was missing will return EINVAL
when get_prefetchable_mr returns NULL

ENOENT:
mlx5_ib_advise_mr_prefetch()
   -> mlx5_ib_prefetch_sg_list()
       -> get_prefetchable_mr()
    return -ENOENT;


EINVAL:
mlx5_ib_advise_mr_prefetch
   ->init_prefetch_work()
      -> get_prefetchable_mr()
     return -EINVAL;

where get_prefetchable_mr will check pd and write access & key
So which value we should return ?

Thanks
  

on 2021/8/26 9:18, Li, Zhijian wrote:
>
> On 26/08/2021 01:28, Jason Gunthorpe wrote:
>> On Sat, Aug 21, 2021 at 05:44:43PM +0800, Li, Zhijian wrote:
>>> convert to text and send again
>>>
>>>
>>> Hi Jason & Leon
>>>
>>> It reminds me that ibv_advise_mr doesn't mention ENOENT any more which value the API actually returns now.
>>> the ENOENT cases/situations returned by kernel mlx5 implementation is most likely same with EINVALL as its manpage[1].
>>>
>>> So shall we return EINVAL instead of ENOENT in kernel side when get_prefetchable_mr returns NULL?
>> No, the man page should be fixed
> thanks a lot, i have submitted a RP to rdma-core https://github.com/linux-rdma/rdma-core/pull/1048
>
> Thanks
> Zhijian
>
>> Jason
>>
>>


