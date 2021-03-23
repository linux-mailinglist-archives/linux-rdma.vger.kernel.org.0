Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA942345553
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Mar 2021 03:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhCWCKA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 22 Mar 2021 22:10:00 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:3315 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbhCWCJ7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Mar 2021 22:09:59 -0400
Received: from DGGEML402-HUB.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4F4F9L1wtZz147dm;
        Tue, 23 Mar 2021 10:06:46 +0800 (CST)
Received: from dggema752-chm.china.huawei.com (10.1.198.194) by
 DGGEML402-HUB.china.huawei.com (10.3.17.38) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Tue, 23 Mar 2021 10:09:55 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema752-chm.china.huawei.com (10.1.198.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Tue, 23 Mar 2021 10:09:54 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2106.013;
 Tue, 23 Mar 2021 10:09:54 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jianxin Xiong <jianxin.xiong@intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Leon Romanovsky" <leon@kernel.org>
Subject: Re: [PATCH rdma-core] configure: Check the existence of all needed
 DRM headers
Thread-Topic: [PATCH rdma-core] configure: Check the existence of all needed
 DRM headers
Thread-Index: AQHXH1bFAvSdRMEdmEWebND5jduhBA==
Date:   Tue, 23 Mar 2021 02:09:54 +0000
Message-ID: <c4ca032f261840a7a9c59c15caabbfbf@huawei.com>
References: <1616444421-148423-1-git-send-email-jianxin.xiong@intel.com>
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

On 2021/3/23 4:05, Jianxin Xiong wrote:
> Some vendor specific DRM headers may be missing on systems with old
> kernels. Make sure that all headers needed by pyverbs/dmabuf_alloc.c
> are present before enabling that module.
> 
> Remove unused reference of "radeon_drm.h" from pyverbs/dmabuf_alloc.c.
> 
> Signed-off-by: Jianxin Xiong <jianxin.xiong@intel.com>
> ---
>  CMakeLists.txt         | 6 +++++-
>  pyverbs/dmabuf_alloc.c | 1 -
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/CMakeLists.txt b/CMakeLists.txt
> index e9a2f49..1208ab6 100644
> --- a/CMakeLists.txt
> +++ b/CMakeLists.txt
> @@ -526,7 +526,11 @@ if (NOT DRM_INCLUDE_DIRS)
>  endif()
>  
>  if (DRM_INCLUDE_DIRS)
> -  include_directories(${DRM_INCLUDE_DIRS})
> +  if (EXISTS ${DRM_INCLUDE_DIRS}/i915_drm.h AND EXISTS ${DRM_INCLUDE_DIRS}/amdgpu_drm.h)
> +    include_directories(${DRM_INCLUDE_DIRS})
> +  else()
> +    unset(DRM_INCLUDE_DIRS CACHE)
> +  endif()
>  endif()
>  
>  #-------------------------
> diff --git a/pyverbs/dmabuf_alloc.c b/pyverbs/dmabuf_alloc.c
> index 9978a5b..e3ea0a4 100644
> --- a/pyverbs/dmabuf_alloc.c
> +++ b/pyverbs/dmabuf_alloc.c
> @@ -14,7 +14,6 @@
>  #include <drm.h>
>  #include <i915_drm.h>
>  #include <amdgpu_drm.h>
> -#include <radeon_drm.h>
>  #include "dmabuf_alloc.h"
>  
>  /*
> 

Tested-by: Weihang Li <liweihang@huawei.com>

It solves the issue I met on my server with ubuntu 14.04 ,thank you.

Weihang
