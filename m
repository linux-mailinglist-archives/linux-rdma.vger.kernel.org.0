Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A612B3336
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Nov 2020 10:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgKOJ3b (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Nov 2020 04:29:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:39562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726438AbgKOJ31 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 15 Nov 2020 04:29:27 -0500
Received: from localhost (thunderhill.nvidia.com [216.228.112.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71E5E22450;
        Sun, 15 Nov 2020 09:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605432566;
        bh=S+l7zjOVIux2ji8vYMF5u+4XPB+/PGFifq/NnLov1ds=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yTYhmZ79Zx56I4zsC4G5mhESOGtLIXtwBgZYuQVmvj3zQF5weYrUnpmjKdmQ8AGKU
         nDJhvWEM17XiDnVztyAvy3bcuymUoVKdXoExzd/1OisMMb+B5IwW0D+JTy+ElgpBHz
         u0RPKppKmu9NgfltDUQrOFVQ/uibM4lqmZ6SDhCc=
Date:   Sun, 15 Nov 2020 11:29:22 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Wang ShaoBo <bobo.shaobowang@huawei.com>
Cc:     jgg@ziepe.ca, dennis.dalessandro@cornelisnetworks.com,
        mike.marciniszyn@cornelisnetworks.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, huawei.libin@huawei.com,
        cj.chengjian@huawei.com
Subject: Re: [PATCH] IB/hfi1: Fix error return code in hfi1_init_dd()
Message-ID: <20201115092922.GB47002@unreal>
References: <20201115082548.35793-1-bobo.shaobowang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201115082548.35793-1-bobo.shaobowang@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Nov 15, 2020 at 04:25:48PM +0800, Wang ShaoBo wrote:
> Fix to return the error code from hfi1_netdev_alloc() instaed of 0
> in hfi1_init_dd(), as done elsewhere in this function.
>
> Fixes: 4730f4a6c6b2 ("IB/hfi1: Activate the dummy netdev")
> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
> ---
>  drivers/infiniband/hw/hfi1/chip.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

It was already handled, thanks
https://lore.kernel.org/lkml/1605249747-17942-1-git-send-email-zhangchangzhong@huawei.com
