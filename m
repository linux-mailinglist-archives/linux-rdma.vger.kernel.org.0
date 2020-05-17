Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2231B1D6838
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2020 15:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgEQNOO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 17 May 2020 09:14:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:56236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727929AbgEQNOO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 17 May 2020 09:14:14 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3433F2075F;
        Sun, 17 May 2020 13:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589721253;
        bh=3Il1XyG35ERZRYti7zQS0Z2kPrUhsozj6Uvoae6XcqY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Uoz51nC3q2yzZuZ8++BL/colCKovtItCxcn58xoafEsspZU4tDlY23wbr9PFcwt3R
         sEUq1ZddnscbbITSg1OpG3yYGV3VZuH1VLYpM6PCkUnhVRgq5BbmxYjzDycRfv24eA
         sRNGcY/TiY5ynhXriz802ixZn71Ife1dnFQ1uMQ8=
Date:   Sun, 17 May 2020 16:14:09 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     liweihang <liweihang@huawei.com>
Cc:     "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: Questions about masked atomic
Message-ID: <20200517131409.GA60005@unreal>
References: <B82435381E3B2943AA4D2826ADEF0B3A02359ED3@DGGEML522-MBX.china.huawei.com>
 <20200512113512.GK4814@unreal>
 <B82435381E3B2943AA4D2826ADEF0B3A02363499@DGGEML522-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B82435381E3B2943AA4D2826ADEF0B3A02363499@DGGEML522-MBX.china.huawei.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 15, 2020 at 09:40:26AM +0000, liweihang wrote:
> On 2020/5/12 19:35, Leon Romanovsky wrote:
> > On Mon, May 11, 2020 at 01:54:48PM +0000, liweihang wrote:
> >> Hi All,
> >>
> >> I have two questions about masked atomic (Masked Compare and Swap & MFetchAdd):
> >>
> >> 1. The kernel now supports masked atomic, but the it does not support atomic
> >>    operation. Is the masked atomic valid in kernel currently?
> >
> > Yes, it is valid, but probably has a very little real value for the kernel ULPs.
> > I see code in the RDS that uses atomics, but it says nothing to me, because
> > upstream RDS and version in-real-use are completely different.
> >
> >> 2. In the userspace, ofed does not have the corresponding opcode for the masked
> >>    atomic (IB_WR_MASKED_ATOMIC_CMP_AND_SWP, IB_WR_MASKED_ATOMIC_FETCH_AND_ADD),
> >>    and ibv_send_wr also has no related data segment for it. How to support it in
> >>    userspace?
> >
> > ibv_send_wr is not extensible, so the real solution will need to extend ibv_wr_post() [1]
> > with specific and new post builders.
> >
> > Thanks
> >
> > [1] https://github.com/linux-rdma/rdma-core/blob/master/libibverbs/man/ibv_wr_post.3.md
> >
>
> Hi Leon,
>
> Thanks for your response. May I ask another question:
>
> Why it's not encouraged to use atomic/extended atomic/masked atomic operations in kernel?
> Jason said that there seems no kernel users of extended atomic, is there any other reasons?

I don't think that "it is not encouraged", the more accurate will be
"the IBTA atomics will give nothing to the kernel ULPs".

The atomic data is not necessary stored in the host memory, while ULPs
need it in the memory. It means that they anyway will need to do some
synchronization in the host and "cancel" any advantage of atomics if
they exist.

Thanks

>
> Weihang
