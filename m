Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F93747F08D
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Dec 2021 19:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343997AbhLXSTt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Dec 2021 13:19:49 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56436 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343993AbhLXSTt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Dec 2021 13:19:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10D50B81729
        for <linux-rdma@vger.kernel.org>; Fri, 24 Dec 2021 18:19:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22644C36AE5;
        Fri, 24 Dec 2021 18:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640369986;
        bh=tiBKtEHydt70mUFM5Gru1hGXzC9AwmdpRbpcKPiytj8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UeWiw/UjdsbDhbnry7ilnAj/yx7fBGT+ChAFKHsrPOXg9ZqQILHpJ1FFvIGhuIF7u
         lZeNbTh7qs/eDXZw8JRGRyjnBjxrH6iBvahvMZ9j2+CAVX9KqymwlumMI//nZilyR/
         2/TiQP6Y4TPQLtt/4LS4wSHbY39wOt/MtjXL4cU07UBaaQ9GnAT5KWX5YPF2UQNWUG
         vBDe7o5BY9xiTB1sNhiQxP3z0nk4+vLs4JdSRb/hkvxK9+KmndJ75bW8t3HnSEar6i
         vYpcSYGly4qalmfSEkTgMbNOoXalEeTxywlAo6eR026Cn0KNg1CTt0/VBZMDyV6XLY
         z0qaTtiuWIxJw==
Date:   Fri, 24 Dec 2021 20:19:42 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     Yanjun Zhu <yanjun.zhu@linux.dev>, jgg@ziepe.ca,
        dledford@redhat.com, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com
Subject: Re: [PATCH rdma-next 10/11] RDMA/erdma: Add the ABI definitions
Message-ID: <YcYPPieF3IrIIIv1@unreal>
References: <20211221024858.25938-1-chengyou@linux.alibaba.com>
 <20211221024858.25938-11-chengyou@linux.alibaba.com>
 <c1893907-e8fb-1eec-9611-3f08d1b2a3c2@linux.dev>
 <YcTD5jDwgDln4QBV@unreal>
 <6cb90490-d21c-e76e-19b9-2a7fe0669e04@linux.dev>
 <e860964f-7084-8ff4-ffd5-bb296ee7cad1@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e860964f-7084-8ff4-ffd5-bb296ee7cad1@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Dec 24, 2021 at 03:12:35PM +0800, Cheng Xu wrote:
> 
> 
> On 12/24/21 6:55 AM, Yanjun Zhu wrote:
> > 在 2021/12/24 2:45, Leon Romanovsky 写道:
> > > On Thu, Dec 23, 2021 at 11:46:03PM +0800, Yanjun Zhu wrote:
> > > > 在 2021/12/21 10:48, Cheng Xu 写道:
> > > > > Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
> > > > > ---
> > > > >    include/uapi/rdma/erdma-abi.h | 49
> > > > > +++++++++++++++++++++++++++++++++++
> > > > >    1 file changed, 49 insertions(+)
> > > > >    create mode 100644 include/uapi/rdma/erdma-abi.h
> > > > > 
> > > > > diff --git a/include/uapi/rdma/erdma-abi.h
> > > > > b/include/uapi/rdma/erdma-abi.h
> > > > > new file mode 100644
> > > > > index 000000000000..6bcba10c1e41
> > > > > --- /dev/null
> > > > > +++ b/include/uapi/rdma/erdma-abi.h
> > > > > @@ -0,0 +1,49 @@
> > > > > +/* SPDX-License-Identifier: ((GPL-2.0 WITH
> > > > > Linux-syscall-note) OR Linux-OpenIB) */
> > > > > +/*
> > > > > + * Copyright (c) 2020-2021, Alibaba Group.
> > > > > + */
> > > > > +
> > > > > +#ifndef __ERDMA_USER_H__
> > > > > +#define __ERDMA_USER_H__
> > > > > +
> > > > > +#include <linux/types.h>
> > > > > +
> > > > > +#define ERDMA_ABI_VERSION       1
> > > > 
> > > > ERDMA_ABI_VERSION should be 2？
> > > 
> > > Why?
> > > 
> > > This field is for rdma-core and we don't have erdma provider in that
> > > library yet. It always starts from 1 for new drivers.
> > Please check this link:
> > http://mail.spinics.net/lists/linux-rdma/msg63012.html
> > 
> > Jason mentioned in this link:
> > 
> > "
> > /*
> >   * For 64 bit machines ABI version 1 and 2 are the same. Otherwise 32
> >   * bit machines require ABI version 2 which guarentees the user and
> >   * kernel use the same ABI.
> >   */
> > "
> > 
> > Zhu Yanjun
> 
> Even though I do not understand the reason, but as mentioned above, I think
> ERDMA_ABI_VERSION = 1 is fine, because ERDMA can only work in 64bit
> machines.

Jason's comment came after we discovered that many of our API structures had
problematic layout and weren't aligned to 64bits. This caused to issues when
the 32bits software tried to use 64bit kernel.

So we didn't have many choices but bump ABI versions for broken drivers
and RXE was one of them.

You are proposing new driver, it should start from 1.

Thanks
