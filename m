Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E34E734396C
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Mar 2021 07:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbhCVG0L convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 22 Mar 2021 02:26:11 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3494 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbhCVGZ6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Mar 2021 02:25:58 -0400
Received: from DGGEML403-HUB.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4F3kwl6YZkzRSpD;
        Mon, 22 Mar 2021 14:24:07 +0800 (CST)
Received: from dggema702-chm.china.huawei.com (10.3.20.66) by
 DGGEML403-HUB.china.huawei.com (10.3.17.33) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Mon, 22 Mar 2021 14:25:55 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema702-chm.china.huawei.com (10.3.20.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Mon, 22 Mar 2021 14:25:55 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2106.013;
 Mon, 22 Mar 2021 14:25:55 +0800
From:   liweihang <liweihang@huawei.com>
To:     "Xiong, Jianxin" <jianxin.xiong@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [rdma-core] Compile issue with DRM headers
Thread-Topic: [rdma-core] Compile issue with DRM headers
Thread-Index: AQHXHJv3XGIQP1y/YEuHT1qgEOdOZw==
Date:   Mon, 22 Mar 2021 06:25:55 +0000
Message-ID: <702e45fcf9e2470d8e46f9b69918188e@huawei.com>
References: <d204d1db15844e45b946125a5452ab19@huawei.com>
 <MW3PR11MB4555FC2C195C0AAB5D804326E5689@MW3PR11MB4555.namprd11.prod.outlook.com>
 <YFc2348DwMqm6e3r@unreal> <20210321155317.GD2710221@ziepe.ca>
 <MW3PR11MB45551494FA14979B4A0D8E50E5659@MW3PR11MB4555.namprd11.prod.outlook.com>
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

On 2021/3/22 14:00, Xiong, Jianxin wrote:
>> -----Original Message-----
>> From: Jason Gunthorpe <jgg@ziepe.ca>
>> Sent: Sunday, March 21, 2021 8:53 AM
>> To: Leon Romanovsky <leon@kernel.org>
>> Cc: Xiong, Jianxin <jianxin.xiong@intel.com>; liweihang <liweihang@huawei.com>; linux-rdma@vger.kernel.org; Linuxarm
>> <linuxarm@huawei.com>
>> Subject: Re: [rdma-core] Compile issue with DRM headers
>>
>> On Sun, Mar 21, 2021 at 02:06:55PM +0200, Leon Romanovsky wrote:
>>> On Fri, Mar 19, 2021 at 04:50:53PM +0000, Xiong, Jianxin wrote:
> ....
> 
>>>
>>> Let's add compilation test that checks all those files at the same time:
>>>    14 #include <drm.h>
>>>    15 #include <i915_drm.h>
>>>    16 #include <amdgpu_drm.h>
>>>    17 #include <radeon_drm.h>
>>
>> Yes please
>>
>> Jason
> 
> I will work on this. 
> 
> Thanks,
> 
> Jianxin
> 

Thank you. I will help test on my server after your work is done :)

Weihang
