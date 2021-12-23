Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6E147E7B8
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Dec 2021 19:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349882AbhLWSqF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Dec 2021 13:46:05 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:55950 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349869AbhLWSqF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 Dec 2021 13:46:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16417B8219E
        for <linux-rdma@vger.kernel.org>; Thu, 23 Dec 2021 18:46:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10FF4C36AE5;
        Thu, 23 Dec 2021 18:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640285162;
        bh=k/+cwcugIJk1qTpCSozi9ivgMZsG/EXgK8KvFWqH5XU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y76l749O0KnHvT05XU/KfEVLts3S45+cju3qXBDIorp4zrVR1nnY9HirESrNoJbF+
         et6CEeoH/mZHw0r6SFo420OMbkoWZFvl0Wu+wuMW3G+YS18hoVFLS6+LKSPoD+oHl3
         VS/DoUy3v7gQVUtvcsUDoF1jBnnddP6q4Bsn0AGmFYOmyMhyeeZsC8fU9GgdDICq7F
         im3BRiXTzERWoN49X02nfNvt4l7CW2BIBOShsftuCc7qUx9h5HFDs6qalRRF9/HuRh
         LF6N+YUWC9I4Cq8Ttb22XR7yW62wd5GyvtEqqR2JcDTgl18yGOKfCDkGZC1SLeb16+
         G3wUYSkQ+TgBA==
Date:   Thu, 23 Dec 2021 20:45:58 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Yanjun Zhu <yanjun.zhu@linux.dev>
Cc:     Cheng Xu <chengyou@linux.alibaba.com>, jgg@ziepe.ca,
        dledford@redhat.com, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com
Subject: Re: [PATCH rdma-next 10/11] RDMA/erdma: Add the ABI definitions
Message-ID: <YcTD5jDwgDln4QBV@unreal>
References: <20211221024858.25938-1-chengyou@linux.alibaba.com>
 <20211221024858.25938-11-chengyou@linux.alibaba.com>
 <c1893907-e8fb-1eec-9611-3f08d1b2a3c2@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c1893907-e8fb-1eec-9611-3f08d1b2a3c2@linux.dev>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 23, 2021 at 11:46:03PM +0800, Yanjun Zhu wrote:
> 在 2021/12/21 10:48, Cheng Xu 写道:
> > Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
> > ---
> >   include/uapi/rdma/erdma-abi.h | 49 +++++++++++++++++++++++++++++++++++
> >   1 file changed, 49 insertions(+)
> >   create mode 100644 include/uapi/rdma/erdma-abi.h
> > 
> > diff --git a/include/uapi/rdma/erdma-abi.h b/include/uapi/rdma/erdma-abi.h
> > new file mode 100644
> > index 000000000000..6bcba10c1e41
> > --- /dev/null
> > +++ b/include/uapi/rdma/erdma-abi.h
> > @@ -0,0 +1,49 @@
> > +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR Linux-OpenIB) */
> > +/*
> > + * Copyright (c) 2020-2021, Alibaba Group.
> > + */
> > +
> > +#ifndef __ERDMA_USER_H__
> > +#define __ERDMA_USER_H__
> > +
> > +#include <linux/types.h>
> > +
> > +#define ERDMA_ABI_VERSION       1
> 
> ERDMA_ABI_VERSION should be 2？

Why?

This field is for rdma-core and we don't have erdma provider in that
library yet. It always starts from 1 for new drivers.

Thanks
