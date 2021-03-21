Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4622B34323C
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Mar 2021 13:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhCUMHK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 Mar 2021 08:07:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:57478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229840AbhCUMHA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 21 Mar 2021 08:07:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CFA8061939;
        Sun, 21 Mar 2021 12:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616328419;
        bh=GnNSETU6BVrJoL/FwBCOfkzDwU4GMhZ6BeFvNUTFE9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WuX4fb+y8lkV28hW2hW5qNpJpcndD3qVt7vw+sk/gFo8E+XQKtR9KWUnsuy034w7E
         V8ODCk1AkXP45V1V9Y3/FQRnmKGe0tPlCdmt7ZWS6FW4sWtRJp3Sm+lFLj4QfCV2yx
         tit55estOf2GH8UpEf9/Lpy39aedd4pg0fdZO/7AclBunPH2TPSJLpHTZ3H9MLQGSN
         ouH2rQLfGQ7zZTwYPOwn/u5TVTUizodLpJs72V6Zm/jvOMoNsxR9mcJnoLqfyChaVS
         iJmPQ98qiY3K54bNxYdCo5iyyPFRkDCdpD6kIVx+7uQ6XmQFZzKN4z2Ow59aoa/cMx
         viO5kOhEY8jaQ==
Date:   Sun, 21 Mar 2021 14:06:55 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     "Xiong, Jianxin" <jianxin.xiong@intel.com>
Cc:     liweihang <liweihang@huawei.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Linuxarm <linuxarm@huawei.com>
Subject: Re: [rdma-core] Compile issue with DRM headers
Message-ID: <YFc2348DwMqm6e3r@unreal>
References: <d204d1db15844e45b946125a5452ab19@huawei.com>
 <MW3PR11MB4555FC2C195C0AAB5D804326E5689@MW3PR11MB4555.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW3PR11MB4555FC2C195C0AAB5D804326E5689@MW3PR11MB4555.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 19, 2021 at 04:50:53PM +0000, Xiong, Jianxin wrote:
> 
> > -----Original Message-----
> > From: liweihang <liweihang@huawei.com>
> > Sent: Friday, March 19, 2021 1:44 AM
> > To: Xiong, Jianxin <jianxin.xiong@intel.com>; linux-rdma@vger.kernel.org
> > Cc: Jason Gunthorpe <jgg@ziepe.ca>; Leon Romanovsky <leon@kernel.org>; Linuxarm <linuxarm@huawei.com>
> > Subject: [rdma-core] Compile issue with DRM headers
> > 
> > Hi Jianxin,
> > 
> > I met a compile error with recent version of rdma-core on my server with Ubuntu
> > 14.04:
> > 
> > ../pyverbs/dmabuf_alloc.c:16:24: fatal error: amdgpu_drm.h: No such file or directory  #include <amdgpu_drm.h>
> >                         ^
> > compilation terminated.
> > 
> > I found it is related with dma-buf based commits. And the commit 3788aa843b4b
> > ("configure: Add check for DRM headers") adds a check for libdrm headers. I have installed it but my version(2.4.67-1ubuntu0.14.04.2) isn't
> > new enough, there is no 'amdgpu_drm.h' in DRM_INCLUDE_DIRS(/usr/include/drm).
> > 
> > So I think we may need some check for the the version of libdrm in CMakeList.txt or something else :) Could you please give me some
> > suggestions?
> > 
> > Thanks
> > Weihang
> 
> Hi Weihang,
> 
> The simplest way is to replace the check of "drm.h" with "amdgpu_drm.h". This is 
> reasonable since dma-buf based MR won't work with old kernel anyway. 
> 
> Alternatively, we can add a check for "amdgpu_drm.h" in CMakeLists.txt and add
> some #ifdef's to dmabuf_alloc.c around the code related to amdgpu.

Let's add compilation test that checks all those files at the same time:
   14 #include <drm.h>
   15 #include <i915_drm.h>
   16 #include <amdgpu_drm.h>
   17 #include <radeon_drm.h>

Thanks

> 
> -Jianxin
> 
