Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD5E1603E1
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Feb 2020 12:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgBPLyA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 16 Feb 2020 06:54:00 -0500
Received: from mail-eopbgr20064.outbound.protection.outlook.com ([40.107.2.64]:6976
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728009AbgBPLyA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 16 Feb 2020 06:54:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QKzYLXHrlwGrXwGU4QxPfAH7GF9FkoFBXww4QPP1JNgu+4dz6+/KEkBAw0xvK/UeQ5dGM89J5rXXh4GDuEwLulD6NBnslOvpPy2Gu5BMkgd30GFQ1zzUJZltBYFA5ZJ31AsKAUcJ2viJe5odcQuoaoOIRTUk+QkZWMszyC+FSHZ6Hazn1KLKdQU2Vd139V2umBmjYVR3ekuCT9hb378tv/WNN3InM+qnaYlE59xAhddYiTCzAeCVQ0HxPsI9trw9h2wVeW1A0H21qAAUbOa1xVbBPr3FgTnt4o1eLdAVThJTrarc3/c9BfhJzGXG+nXgh5WPU96WJhu+RR/GUGe/Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9I0u6T1Zd3Gh8VTWC6X9qkMo9FjVz7MZo+J/5rgQlrk=;
 b=E5N7ImMNPZG+CglUeFk5eFdT1Tf7qW9BAr95s5ZEflq5yuNfwX6Qy2r2YcpPfZY1KK0liKaTPjCgC52uYTYNkKi9lNxXUC0xHcM4e6eleJzxS9uFnZXcb3lp4ESUAsCy/wTXNz4kW3Fwpgcv9PNt5lLKLX1AZjChCR4K8yVvjPRQaHY74PjPa96MdZH/V+xocu+JkxTF6cKTMueirGKW6FsJckqkiicLtRV1cpkXZmKzNAJRN7E5eVhkRMb+hBLjgGLGwVEYy/HsXy130+cQNWgwE3PROOCy+l+OTSlrmhtQiVP/iZNgpeHDpvAb/S/qCAXQ7ZufLUFOd57KWjIzAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9I0u6T1Zd3Gh8VTWC6X9qkMo9FjVz7MZo+J/5rgQlrk=;
 b=nF1YRiqrj0j7RYJN7nXWuL/SQYuUDVbbznmHzPFqFvL7PZzgg/4MJu0LRSf7NzBAB15ij4vcyULxHP82wbAgJExSmguYMGBYm8wry0X+KVfO1jiHBInOVIjnBUJM02mYhszgb9D4QnZe/2wZ9W1A0s8UdzeNr05SXvxGWrUj2x0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=maximmi@mellanox.com; 
Received: from HE1PR0501MB2570.eurprd05.prod.outlook.com (10.168.126.17) by
 HE1SPR00MB85.eurprd05.prod.outlook.com (10.172.127.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.27; Sun, 16 Feb 2020 11:53:53 +0000
Received: from HE1PR0501MB2570.eurprd05.prod.outlook.com
 ([fe80::60c4:f0b4:dc7b:c7fc]) by HE1PR0501MB2570.eurprd05.prod.outlook.com
 ([fe80::60c4:f0b4:dc7b:c7fc%10]) with mapi id 15.20.2729.031; Sun, 16 Feb
 2020 11:53:53 +0000
Subject: Re: [PATCH rdma] IB/mlx5: Fix linkage failure on 32-bit arches
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Alexander Lobakin <alobakin@dlink.ru>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200214191309.155654-1-alobakin@dlink.ru>
 <20200214192410.GW31668@ziepe.ca> <6f7c270fef9ec5bae2dcb780dee3f49f@dlink.ru>
From:   Maxim Mikityanskiy <maximmi@mellanox.com>
Message-ID: <3c70c7da-60aa-10ec-767f-5e519357b8e6@mellanox.com>
Date:   Sun, 16 Feb 2020 13:53:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <6f7c270fef9ec5bae2dcb780dee3f49f@dlink.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FRYP281CA0011.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::21)
 To HE1PR0501MB2570.eurprd05.prod.outlook.com (2603:10a6:3:6c::17)
MIME-Version: 1.0
Received: from [10.80.3.13] (193.47.165.251) by FRYP281CA0011.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.25 via Frontend Transport; Sun, 16 Feb 2020 11:53:52 +0000
X-Originating-IP: [193.47.165.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 72f4e32f-3822-45e7-1a1e-08d7b2d6e53a
X-MS-TrafficTypeDiagnostic: HE1SPR00MB85:|HE1SPR00MB85:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1SPR00MB858E51EBCB03CF16C9AE58D1170@HE1SPR00MB85.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 03152A99FF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(39860400002)(396003)(376002)(366004)(199004)(189003)(4326008)(5660300002)(956004)(16576012)(478600001)(2616005)(54906003)(26005)(86362001)(316002)(8676002)(52116002)(53546011)(31686004)(966005)(2906002)(81166006)(81156014)(6486002)(6916009)(186003)(66946007)(66556008)(66476007)(16526019)(31696002)(8936002)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1SPR00MB85;H:HE1PR0501MB2570.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cq1gP2QdQHo8MpqV8DcXQXeJp7dvROx8ezcqy8LOdP5yiiBTy2yYTS7SEBfE6vtK7OZcdWdxgm/cg3Krff9GTMTKz3ok189q1E7YDvZOTSncf10opfMMWAp6gVVjSUIzbpFs0jS+TGYQasyktVyCRwRlVjSr6+x9PpYBMCvL4G35zx0yjwJzsfDurFHPFFQiXB+wAkFclZYoVndnkqt4l+mW4q/guVh/y4WYhnKxclzajqM8t7ILjUlMFSP1h754EPGimRbwcfFbZtARoH7GZKCscvQUBKgDuroCtzq1nsLVapCrGM3qmsyxNyCMTiHaNKGnbep65kupUYbBXLibwiYhQXiwuiCCg81ZHuFwn6MIwonfJC7CiG8I2vtYWU86f3omcqQn8mkr5Lqe/66p8ld7n6XeapE+i9Lcy2USt4d4U2BUWyniu7OUurxfGD/hmY/Y3l+p2loDfHOSnfO02h1mUJ4HQ7sHGnTq94nmfIJpKTywGn7O6jW01NFhpgXrVMrsEHguKsHA2wZf3s6GQg==
X-MS-Exchange-AntiSpam-MessageData: j0THxgZ0gSDbpFQaY9Rg71S4xFp7tBSSy3RUVI9FHA71NJuC6p6SAExDbG9hknzYAnu0oksIrOc6Wj8rI9m5lgIcOFM2l40ZXnM/gGvoDv2wjQcCGlwT3PgbrB4X0w+QPoORDYsFemc5TECbS+BLVg==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f4e32f-3822-45e7-1a1e-08d7b2d6e53a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2020 11:53:53.6649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dzWPa/ZjbuZco1oEdYQ5n9rv+SnDIDeDdi07EVCDQYg+vQx7QBpbStERRth+u1Z5jDcf90iZCAMUyKlnX5VuIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1SPR00MB85
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-02-14 21:44, Alexander Lobakin wrote:
> Jason Gunthorpe wrote 14.02.2020 22:24:
>> On Fri, Feb 14, 2020 at 10:13:09PM +0300, Alexander Lobakin wrote:
>>> Commit f164be8c0366 ("IB/mlx5: Extend caps stage to handle VAR
>>> capabilities") introduced a straight "/" division of the u64
>>> variable "bar_size", which emits an __udivdi3() libgcc call on
>>> 32-bit arches and certain GCC versions:
>>>
>>> error: "__udivdi3" [drivers/infiniband/hw/mlx5/mlx5_ib.ko] undefined! 
>>> [1]
>>>
>>> Replace it with the corresponding div_u64() call.
>>> Compile-tested on ARCH=mips 32r2el_defconfig BOARDS=ocelot.
>>>
>>> [1] 
>>> https://lore.kernel.org/linux-mips/CAMuHMdXM9S1VkFMZ8eDAyZR6EE4WkJY215Lcn2qdOaPeadF+EQ@mail.gmail.com/ 
>>>
>>>
>>> Fixes: f164be8c0366 ("IB/mlx5: Extend caps stage to handle VAR
>>> capabilities")
>>> Signed-off-by: Alexander Lobakin <alobakin@dlink.ru>
>>> ---
>>>  drivers/infiniband/hw/mlx5/main.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> Randy beat you too it..
>>
>> https://lore.kernel.org/linux-rdma/20200206143201.GF25297@ziepe.ca/
> 
> Ah, OK. Sorry for missing this one. I didn't see any fix over
> git.kernel.org and thought it doesn't exist yet.
> 
>> But it seems patchwork missed this somehow.
>>
>> Applied now at least

Jason, I think Alexander's patch is more correct. It uses div_u64, while 
yours uses div64_u64. The divider is 32-bit, so div_u64 would be more 
optimized on most 32-bit architectures.

> Thanks!
> 
>> Jason
> 
> Regards,
> ᚷ ᛖ ᚢ ᚦ ᚠ ᚱ

