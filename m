Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05AE03417AA
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Mar 2021 09:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbhCSInx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 19 Mar 2021 04:43:53 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3491 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234225AbhCSInp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 Mar 2021 04:43:45 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4F1y7B032FzRRd8;
        Fri, 19 Mar 2021 16:41:58 +0800 (CST)
Received: from dggema704-chm.china.huawei.com (10.3.20.68) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Fri, 19 Mar 2021 16:43:43 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema704-chm.china.huawei.com (10.3.20.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Fri, 19 Mar 2021 16:43:43 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2106.013;
 Fri, 19 Mar 2021 16:43:43 +0800
From:   liweihang <liweihang@huawei.com>
To:     "jianxin.xiong@intel.com" <jianxin.xiong@intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: [rdma-core] Compile issue with DRM headers
Thread-Topic: [rdma-core] Compile issue with DRM headers
Thread-Index: AQHXHJv3XGIQP1y/YEuHT1qgEOdOZw==
Date:   Fri, 19 Mar 2021 08:43:43 +0000
Message-ID: <d204d1db15844e45b946125a5452ab19@huawei.com>
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

Hi Jianxin,

I met a compile error with recent version of rdma-core on my server with Ubuntu
14.04:

./pyverbs/dmabuf_alloc.c:16:24: fatal error: amdgpu_drm.h: No such file or
directory
 #include <amdgpu_drm.h>
                        ^
compilation terminated.

I found it is related with dma-buf based commits. And the commit 3788aa843b4b
("configure: Add check for DRM headers") adds a check for libdrm headers. I have
installed it but my version(2.4.67-1ubuntu0.14.04.2) isn't new enough, there is
no 'amdgpu_drm.h' in DRM_INCLUDE_DIRS(/usr/include/drm).

So I think we may need some check for the the version of libdrm in CMakeList.txt
or something else :) Could you please give me some suggestions?

Thanks
Weihang
