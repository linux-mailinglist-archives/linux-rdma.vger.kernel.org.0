Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1680302CF
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2019 21:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbfE3Tbh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 May 2019 15:31:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:35958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbfE3Tbh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 30 May 2019 15:31:37 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BC27260D2;
        Thu, 30 May 2019 19:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559244696;
        bh=Ndni3u5PVwSKQkK/6TSJYcTvSSwqQ/XJkQNoh2C3Jgw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jo5xGUL2u5bzPMCGGY06MpGHSlnPFfQOa9NjsnbJoJgjQ2IXQjvujF5QOp/c9/NCA
         T+y5v3nnYsNJYIJibhYlOhg0BRVPPiaHc37KgL8w+O01DUHDm9QmGPgAuT+oesJ5rC
         Hu3AaCBhUex4ascL8o1a8X3vDcam2dCYh8Z+r08w=
Date:   Thu, 30 May 2019 22:31:17 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Lijun Ou <oulijun@huawei.com>, dledford@redhat.com,
        linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH V2 for-next] RDMA/hns: Bugfix for posting multiple srq
 work request
Message-ID: <20190530193117.GD5768@mtr-leonro.mtl.com>
References: <1559231753-81837-1-git-send-email-oulijun@huawei.com>
 <20190530184919.GA5454@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530184919.GA5454@ziepe.ca>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 30, 2019 at 03:49:19PM -0300, Jason Gunthorpe wrote:
> On Thu, May 30, 2019 at 11:55:53PM +0800, Lijun Ou wrote:
> > When the user submits more than 32 work request to a srq queue
> > at a time, it needs to find the corresponding number of entries
> > in the bitmap in the idx queue. However, the original lookup
> > function named ffs only processes 32 bits of the array element,
> > When the number of srq wqe issued exceeds 32, the ffs will only
> > process the lower 32 bits of the elements, it will not be able
> > to get the correct wqe index for srq wqe.
> >
> > Signed-off-by: Xi Wang <wangxi11@huawei.com>
> > Signed-off-by: Lijun Ou <oulijun@huawei.com>
> > ---
> > V1->V2:
> > 1. Use bitmap function instead of __ffs64()
> > ---
> >  drivers/infiniband/hw/hns/hns_roce_device.h |  2 +-
> >  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 29 +++++++++++++----------------
> >  drivers/infiniband/hw/hns/hns_roce_srq.c    | 15 +++------------
> >  3 files changed, 17 insertions(+), 29 deletions(-)
>
> Applied to for-next, thanks

Jason,

I don't want to be a party buster, but it is hard to believe that
this part of their patch is correct.

+       if (unlikely(bitmap_full(idx_que->bitmap, size)))
+               bitmap_zero(idx_que->bitmap, size);

They simply "dropping" all indexes.

>
> Jason
