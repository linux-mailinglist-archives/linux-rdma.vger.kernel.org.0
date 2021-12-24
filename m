Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3209B47F088
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Dec 2021 19:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353422AbhLXSLs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Dec 2021 13:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353413AbhLXSLr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Dec 2021 13:11:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7A2C061401
        for <linux-rdma@vger.kernel.org>; Fri, 24 Dec 2021 10:11:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 745906206D
        for <linux-rdma@vger.kernel.org>; Fri, 24 Dec 2021 18:11:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55613C36AE8;
        Fri, 24 Dec 2021 18:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640369506;
        bh=xDl3t54/YFT4ojfy+ySRdpiOgh6qIwHk51nRqhksNqk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kTE4PwsCrxrktl12pnxqKhoMareoO9KFaUMhkXDrhRM9nkNRz25D7NPq+WzMod1yP
         VLtau/JJm3Jwku8jsJ6u1yMI9aoXPPDIKO9QQwznUYEOEl1DuFJTgSnOQ1rCCnboQM
         hA8Fjz3yy6GiMru50wL7UXbFoERhGpLD4uPiQzjwiHd4s637T9oUH/PC+W8QVmlnzd
         HRrOM/sI5AFnjVvEwFKFdlUJwUd7Ot12JiOVSQbFCHzwoCQx+kcs//oAO44Y0qpW9/
         PN6x8molGIsfMqKZ6qiyoGrO7CNrID7n3X4jOADV8vZ+V+OCT1RZfXahj1+ow748HW
         e53pr1mX/gyyA==
Date:   Fri, 24 Dec 2021 20:11:42 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Yanjun Zhu <yanjun.zhu@linux.dev>
Cc:     Cheng Xu <chengyou@linux.alibaba.com>, jgg@ziepe.ca,
        dledford@redhat.com, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com
Subject: Re: [PATCH rdma-next 10/11] RDMA/erdma: Add the ABI definitions
Message-ID: <YcYNXveFmr2qHXNe@unreal>
References: <20211221024858.25938-1-chengyou@linux.alibaba.com>
 <20211221024858.25938-11-chengyou@linux.alibaba.com>
 <c1893907-e8fb-1eec-9611-3f08d1b2a3c2@linux.dev>
 <YcTD5jDwgDln4QBV@unreal>
 <6cb90490-d21c-e76e-19b9-2a7fe0669e04@linux.dev>
 <YcVi6CfbhKSfGgxs@unreal>
 <ae2dd1e6-a33b-c19e-7100-198ea3a491df@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae2dd1e6-a33b-c19e-7100-198ea3a491df@linux.dev>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Dec 24, 2021 at 03:54:18PM +0800, Yanjun Zhu wrote:
> 在 2021/12/24 14:04, Leon Romanovsky 写道:
> > On Fri, Dec 24, 2021 at 06:55:41AM +0800, Yanjun Zhu wrote:
> > > 在 2021/12/24 2:45, Leon Romanovsky 写道:
> > > > On Thu, Dec 23, 2021 at 11:46:03PM +0800, Yanjun Zhu wrote:
> > > > > 在 2021/12/21 10:48, Cheng Xu 写道:
> > > > > > Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
> > > > > > ---
> > > > > >     include/uapi/rdma/erdma-abi.h | 49 +++++++++++++++++++++++++++++++++++
> > > > > >     1 file changed, 49 insertions(+)
> > > > > >     create mode 100644 include/uapi/rdma/erdma-abi.h
> > > > > > 
> > > > > > diff --git a/include/uapi/rdma/erdma-abi.h b/include/uapi/rdma/erdma-abi.h
> > > > > > new file mode 100644
> > > > > > index 000000000000..6bcba10c1e41
> > > > > > --- /dev/null
> > > > > > +++ b/include/uapi/rdma/erdma-abi.h
> > > > > > @@ -0,0 +1,49 @@
> > > > > > +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR Linux-OpenIB) */
> > > > > > +/*
> > > > > > + * Copyright (c) 2020-2021, Alibaba Group.
> > > > > > + */
> > > > > > +
> > > > > > +#ifndef __ERDMA_USER_H__
> > > > > > +#define __ERDMA_USER_H__
> > > > > > +
> > > > > > +#include <linux/types.h>
> > > > > > +
> > > > > > +#define ERDMA_ABI_VERSION       1
> > > > > 
> > > > > ERDMA_ABI_VERSION should be 2？
> > > > 
> > > > Why?
> > > > 
> > > > This field is for rdma-core and we don't have erdma provider in that
> > > > library yet. It always starts from 1 for new drivers.
> > > Please check this link:
> > > http://mail.spinics.net/lists/linux-rdma/msg63012.html
> > 
> > OK, I still don't understand why.
> 
> 
> Perhaps 32 bit machines require ABI version 2 which guarentees the user and
> kernel use the same ABI.

Nope, it is not.

> 
> Zhu Yanjun
> 
> > 
> > RXE case is different, because rdma-core already had broken RXE
> > implementation, so this is why the version was incremented.
> > 
> > > 
> > > Jason mentioned in this link:
> > > 
> > > "
> > > /*
> > >   * For 64 bit machines ABI version 1 and 2 are the same. Otherwise 32
> > >   * bit machines require ABI version 2 which guarentees the user and
> > >   * kernel use the same ABI.
> > >   */
> > > "
> > > 
> > > Zhu Yanjun
> > > > 
> > > > Thanks
> > > 
> 
