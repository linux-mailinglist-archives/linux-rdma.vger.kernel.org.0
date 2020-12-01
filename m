Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4F62C975B
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Dec 2020 06:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgLAF5c (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Dec 2020 00:57:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:58298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbgLAF5c (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 1 Dec 2020 00:57:32 -0500
Received: from localhost (searspoint.nvidia.com [216.228.112.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEC73216C4;
        Tue,  1 Dec 2020 05:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606802211;
        bh=9isfbctzO+bFIiWdCIoukJI1prqrS3YuXDVbFGWswoc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kIpZ7RSykubYcKK9dbt42osr+CyHQ0dLylttZHAhLE3SPHwcr1BccI0a8UEk09gGR
         8vEmIV+FtOBsMAbOTEfIJ44c1VMDPNiknj4Fg713IjDG3fyjCK5/+Vnb/LZ86StAzP
         4NS6Sxogj5fa2MJ1KHSBQrkExHaG+OJ9SGWaNCD0=
Date:   Tue, 1 Dec 2020 07:56:47 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next 3/3] RDMA/hns: Refactor process of setting
 extended sge
Message-ID: <20201201055647.GF3286@unreal>
References: <1606558959-48510-1-git-send-email-liweihang@huawei.com>
 <1606558959-48510-4-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1606558959-48510-4-git-send-email-liweihang@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Nov 28, 2020 at 06:22:39PM +0800, Weihang Li wrote:
> The variable 'cnt' is used to represent the max number of sge an SQ WQE can
> use at first, then it means how many extended sge an SQ has. In addition,
> this function has no need to return a value. So refactor and encapsulate
> the parts of getting number of extended sge a WQE can use to make it easier
> to understand.
>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_qp.c | 60 +++++++++++++++------------------
>  1 file changed, 28 insertions(+), 32 deletions(-)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
