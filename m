Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F10226D698
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Sep 2020 10:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgIQI3d (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Sep 2020 04:29:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:59806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbgIQI3c (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 17 Sep 2020 04:29:32 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CC1122228;
        Thu, 17 Sep 2020 08:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600331370;
        bh=+Vr3j6pf/c4D0IsDxnewLGxBc93i2o1qJfDyxZP8dQI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=13Mwfky3NHK2BmSsmuy/rPK210D1BIQfqN8hCmy6JXfZFA9befmCBE+f+E1IItcdj
         dly8kS6nyIYbRKrW2+4LA0DZBjjU31McJvvM2ndPMn+JGqNdCycTvnhUwRNGGCzwQ6
         lrOni6ED4hkt09/tnh4XGHZBZD4rUaUZ9khTsXGE=
Date:   Thu, 17 Sep 2020 11:29:26 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] RDMA/mlx5: fix type warning of sizeof in
 __mlx5_ib_alloc_counters()
Message-ID: <20200917082926.GA869610@unreal>
References: <20200917081354.2083293-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917081354.2083293-1-liushixin2@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 17, 2020 at 04:13:54PM +0800, Liu Shixin wrote:
> sizeof() when applied to a pointer typed expression should gives the

gives -> give

> size of the pointed data, even if the data is a pointer.
>
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>  drivers/infiniband/hw/mlx5/counters.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Thanks,
Acked-by: Leon Romanovsky <leonro@nvidia.com>
