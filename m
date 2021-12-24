Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8B0247EBEB
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Dec 2021 07:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351445AbhLXGEa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Dec 2021 01:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245640AbhLXGE3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Dec 2021 01:04:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB656C061401
        for <linux-rdma@vger.kernel.org>; Thu, 23 Dec 2021 22:04:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5676961FD4
        for <linux-rdma@vger.kernel.org>; Fri, 24 Dec 2021 06:04:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCBF3C36AE5;
        Fri, 24 Dec 2021 06:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640325868;
        bh=Dr8OqGYU9v5jE94iYGbbIdKeNYYZgr4H/svxLwgxptM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gb19OimJiaisCeUtgIAe6EK5O6qGSvEguK1GjM/dWEL1HWtbYqwdsVJ0Z14P/lryd
         hU4bmglj4YgBrvC4QFnz9/erk0dMdvTyyOQZ2W37MLTPRGUpBmfs7TQbesqP19Jggk
         uzbrl7z1dzVFkrMxrq1rHx4OVew4n+7cAdAUJJJh2PEeU0I73I93ydBumC4GPPEe7R
         nULwXdOx3AoUT7sQvgldI1epjK2hJ+wa4CsP2yU2bI93eji7sGtldtFaHJZhjX7MkH
         +7v82TIC11aUMgfMzNtKiHz4sTAlDRMg7fvJmWc5J3dHbmdIrYvl7Q0ed97vM8oqla
         l30hBwOg4qwYg==
Date:   Fri, 24 Dec 2021 08:04:24 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Yanjun Zhu <yanjun.zhu@linux.dev>
Cc:     Cheng Xu <chengyou@linux.alibaba.com>, jgg@ziepe.ca,
        dledford@redhat.com, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com
Subject: Re: [PATCH rdma-next 10/11] RDMA/erdma: Add the ABI definitions
Message-ID: <YcVi6CfbhKSfGgxs@unreal>
References: <20211221024858.25938-1-chengyou@linux.alibaba.com>
 <20211221024858.25938-11-chengyou@linux.alibaba.com>
 <c1893907-e8fb-1eec-9611-3f08d1b2a3c2@linux.dev>
 <YcTD5jDwgDln4QBV@unreal>
 <6cb90490-d21c-e76e-19b9-2a7fe0669e04@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6cb90490-d21c-e76e-19b9-2a7fe0669e04@linux.dev>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Dec 24, 2021 at 06:55:41AM +0800, Yanjun Zhu wrote:
> 在 2021/12/24 2:45, Leon Romanovsky 写道:
> > On Thu, Dec 23, 2021 at 11:46:03PM +0800, Yanjun Zhu wrote:
> > > 在 2021/12/21 10:48, Cheng Xu 写道:
> > > > Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
> > > > ---
> > > >    include/uapi/rdma/erdma-abi.h | 49 +++++++++++++++++++++++++++++++++++
> > > >    1 file changed, 49 insertions(+)
> > > >    create mode 100644 include/uapi/rdma/erdma-abi.h
> > > > 
> > > > diff --git a/include/uapi/rdma/erdma-abi.h b/include/uapi/rdma/erdma-abi.h
> > > > new file mode 100644
> > > > index 000000000000..6bcba10c1e41
> > > > --- /dev/null
> > > > +++ b/include/uapi/rdma/erdma-abi.h
> > > > @@ -0,0 +1,49 @@
> > > > +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR Linux-OpenIB) */
> > > > +/*
> > > > + * Copyright (c) 2020-2021, Alibaba Group.
> > > > + */
> > > > +
> > > > +#ifndef __ERDMA_USER_H__
> > > > +#define __ERDMA_USER_H__
> > > > +
> > > > +#include <linux/types.h>
> > > > +
> > > > +#define ERDMA_ABI_VERSION       1
> > > 
> > > ERDMA_ABI_VERSION should be 2？
> > 
> > Why?
> > 
> > This field is for rdma-core and we don't have erdma provider in that
> > library yet. It always starts from 1 for new drivers.
> Please check this link:
> http://mail.spinics.net/lists/linux-rdma/msg63012.html

OK, I still don't understand why.

RXE case is different, because rdma-core already had broken RXE
implementation, so this is why the version was incremented.

> 
> Jason mentioned in this link:
> 
> "
> /*
>  * For 64 bit machines ABI version 1 and 2 are the same. Otherwise 32
>  * bit machines require ABI version 2 which guarentees the user and
>  * kernel use the same ABI.
>  */
> "
> 
> Zhu Yanjun
> > 
> > Thanks
> 
