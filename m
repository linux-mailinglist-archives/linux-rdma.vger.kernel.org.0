Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58204183762
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2020 18:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbgCLR0R (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Mar 2020 13:26:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:55452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbgCLR0R (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Mar 2020 13:26:17 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87B0C206FA;
        Thu, 12 Mar 2020 17:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584033976;
        bh=kuCpvvlxmIGK+u/L6yXVzC1eXfTg2zlvyG4Lfpdi2mU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U4J8Juhofl/jLB1Oc+4aF6Goz4A60EEgwo+Zu639LzL37VvBG47NnJ/abYuptDjcQ
         YnunM/mMj3XiMsTVLLB7mEIv7S/OTgXg+egVXwASvuMC9W/7YsrXL8CnUSXwHRjApI
         Si72hfHQxOtjCf2595ZIWe7XQz95QVj2msRdPiBo=
Date:   Thu, 12 Mar 2020 19:26:09 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Andrew Boyer <aboyer@pensando.io>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Weihang Li <liweihang@huawei.com>,
        dledford@redhat.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next] RDMA/hns: Add interface to support lock free
Message-ID: <20200312172609.GC31504@unreal>
References: <1583999290-20514-1-git-send-email-liweihang@huawei.com>
 <20200312092640.GA31504@unreal>
 <20200312170237.GS31668@ziepe.ca>
 <42CC9743-9112-4954-807D-2A7A856BC78E@pensando.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42CC9743-9112-4954-807D-2A7A856BC78E@pensando.io>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 12, 2020 at 01:04:05PM -0400, Andrew Boyer wrote:
> What would you say to a per-process env variable to disable locking in a userspace provider?

We have thread-domain concept in libibverbs to achieve lockless flows.
https://github.com/linux-rdma/rdma-core/blob/master/libibverbs/man/ibv_alloc_td.3

BTW, please don't use top-posting.

Thanks

>
> -Andrew
>
> > On Mar 12, 2020, at 1:02 PM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Thu, Mar 12, 2020 at 11:26:40AM +0200, Leon Romanovsky wrote:
> >> On Thu, Mar 12, 2020 at 03:48:10PM +0800, Weihang Li wrote:
> >>> From: Jiaran Zhang <zhangjiaran@huawei.com>
> >>>
> >>> In some scenarios, ULP can ensure that there is no concurrency when
> >>> processing io, thus lock free can be used to improve performance.
> >>>
> >>> Signed-off-by: Jiaran Zhang <zhangjiaran@huawei.com>
> >>> Signed-off-by: Yixian Liu <liuyixian@huawei.com>
> >>> Signed-off-by: Weihang Li <liweihang@huawei.com>
> >>> drivers/infiniband/hw/hns/hns_roce_device.h |   1 +
> >>> drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 112 ++++++++++++++++++++--------
> >>> drivers/infiniband/hw/hns/hns_roce_qp.c     |   1 +
> >>> 3 files changed, 84 insertions(+), 30 deletions(-)
> >>>
> >>
> >> NAK, everything in this patch is wrong, starting from exposure,
> >> implementation and description.
> >
> > Yes, complete no on a module parameter to disable locking.
> >
> > Jason
>
