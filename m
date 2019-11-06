Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E203EF1A49
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Nov 2019 16:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfKFPnp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Nov 2019 10:43:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:54150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727074AbfKFPnp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 6 Nov 2019 10:43:45 -0500
Received: from localhost (unknown [77.137.81.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F117F217F5;
        Wed,  6 Nov 2019 15:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573055024;
        bh=mqqjKkHQcSpBngugzQQt6f6e8t0kivmSahddN92VQiw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ivmRxROg3w0CYh6UTQQ1x42qyHpqRfzb9aEiE5a4BQBz9tyvOABfjrbogjd9CLevc
         4/v1YG+aOI87smUUR21i9+VKEbp4jKfoZfUoHyEP8n0edWY2cQTrQF3FilSPn4X9LZ
         uTM5ekB2RuodTmtIFuc1YQv5J8/imtVyQmvD/SgU=
Date:   Wed, 6 Nov 2019 17:43:39 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Weihang Li <liweihang@hisilicon.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v2 for-next 8/9] RDMA/hns: Fix non-standard error codes
Message-ID: <20191106154339.GL6763@unreal>
References: <1572952082-6681-1-git-send-email-liweihang@hisilicon.com>
 <1572952082-6681-9-git-send-email-liweihang@hisilicon.com>
 <20191105170058.GJ6763@unreal>
 <3b2b6654-135c-a268-8933-7ca2ee5a0105@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b2b6654-135c-a268-8933-7ca2ee5a0105@hisilicon.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 06, 2019 at 06:44:06PM +0800, Weihang Li wrote:
>
>
> On 2019/11/6 1:00, Leon Romanovsky wrote:
> > On Tue, Nov 05, 2019 at 07:08:01PM +0800, Weihang Li wrote:
> >> From: Yixian Liu <liuyixian@huawei.com>
> >>
> >> It is better to return a linux error code than define a private constant.
> >>
> >> Signed-off-by: Yixian Liu <liuyixian@huawei.com>
> >> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
> >> Signed-off-by: Weihang Li <liweihang@hisilicon.com>
> >> ---
> >>  drivers/infiniband/hw/hns/hns_roce_alloc.c |  4 ++--
> >>  drivers/infiniband/hw/hns/hns_roce_cq.c    |  4 ++--
> >>  drivers/infiniband/hw/hns/hns_roce_mr.c    | 15 ++++++++-------
> >>  drivers/infiniband/hw/hns/hns_roce_pd.c    |  2 +-
> >>  drivers/infiniband/hw/hns/hns_roce_srq.c   |  2 +-
> >>  5 files changed, 14 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/drivers/infiniband/hw/hns/hns_roce_alloc.c b/drivers/infiniband/hw/hns/hns_roce_alloc.c
> >> index 8c063c5..da574c2 100644
> >> --- a/drivers/infiniband/hw/hns/hns_roce_alloc.c
> >> +++ b/drivers/infiniband/hw/hns/hns_roce_alloc.c
> >> @@ -55,7 +55,7 @@ int hns_roce_bitmap_alloc(struct hns_roce_bitmap *bitmap, unsigned long *obj)
> >
> > Why do HNS driver have custom bitmap functions instead of include/linux/bitmap.h?
> >
> > Thanks
> >
> > .
> >
>
> Hi Leon,
>
> These custom functions achieved the bitmap working in round-robin fashion.
> When using CM to establish connections, if we allocate a new QP after destroying
> one, we will get the same QP number which will be rejected by IB core.

QP number is controlled by HW (or at least should) and not by this bitmap.

>
> I found related patches about this issue:
> https://git.congatec.com/android/qmx6_kernel/commit/f4ec9e9531ac79ee2521faf7ad3d98978f747e42
> https://patchwork.kernel.org/patch/3306941/
> https://patchwork.kernel.org/patch/9444173/

Irrelevant, those patches try to create and manage object numbers in SW.

Thanks

>
> Thanks,
> Weihang
>
