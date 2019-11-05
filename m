Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF4DF03A6
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2019 18:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbfKERBI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Nov 2019 12:01:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:41530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728399AbfKERBG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 5 Nov 2019 12:01:06 -0500
Received: from localhost (unknown [77.137.81.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06AAB21D6C;
        Tue,  5 Nov 2019 17:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572973265;
        bh=KR8TH4FlPwzamila9nAwgFaKF8OEQhmG5Jvhf3n3v3o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ORtbtZl8lPQReTM+X2/ghYGB4pFmvgm0AtXN/21Bn6MRbVmSNFLNU4jLYh+qXjQum
         Neom8tW5i0WIuleOQ/UlinkpHacoSXq8MM2r2S2L1UN7zv/7bNDdjCzq2RnbKeK5UP
         6rM+0276QzhGAULQMcWfNxgtm1IPhj/JEazeyS54=
Date:   Tue, 5 Nov 2019 19:00:58 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Weihang Li <liweihang@hisilicon.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v2 for-next 8/9] RDMA/hns: Fix non-standard error codes
Message-ID: <20191105170058.GJ6763@unreal>
References: <1572952082-6681-1-git-send-email-liweihang@hisilicon.com>
 <1572952082-6681-9-git-send-email-liweihang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572952082-6681-9-git-send-email-liweihang@hisilicon.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 05, 2019 at 07:08:01PM +0800, Weihang Li wrote:
> From: Yixian Liu <liuyixian@huawei.com>
>
> It is better to return a linux error code than define a private constant.
>
> Signed-off-by: Yixian Liu <liuyixian@huawei.com>
> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
> Signed-off-by: Weihang Li <liweihang@hisilicon.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_alloc.c |  4 ++--
>  drivers/infiniband/hw/hns/hns_roce_cq.c    |  4 ++--
>  drivers/infiniband/hw/hns/hns_roce_mr.c    | 15 ++++++++-------
>  drivers/infiniband/hw/hns/hns_roce_pd.c    |  2 +-
>  drivers/infiniband/hw/hns/hns_roce_srq.c   |  2 +-
>  5 files changed, 14 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/infiniband/hw/hns/hns_roce_alloc.c b/drivers/infiniband/hw/hns/hns_roce_alloc.c
> index 8c063c5..da574c2 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_alloc.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_alloc.c
> @@ -55,7 +55,7 @@ int hns_roce_bitmap_alloc(struct hns_roce_bitmap *bitmap, unsigned long *obj)

Why do HNS driver have custom bitmap functions instead of include/linux/bitmap.h?

Thanks
