Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4D89388C00
	for <lists+linux-rdma@lfdr.de>; Wed, 19 May 2021 12:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240111AbhESKvA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 May 2021 06:51:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:43800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238171AbhESKu6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 May 2021 06:50:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BBCFB610A8;
        Wed, 19 May 2021 10:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621421379;
        bh=HXNQsZ6q8IIw05bj9iv+LdxcCHl+2V/wr105TIR8OeA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C2GmDmOFwgFIy2r2147pY/R8MtngfZy9nerNHDWDuefKUIudZTIZpliiXYF2SxUMF
         Pe/+CCvoifU/ukght8Ktyt6PtfpTClqKG583/cNjLh9pNXiXHJujxfDHHa3EIEjvJ/
         KQE1rAZeSMcafrcyHBI3v/mRgcSOjiidaaVf+rRut+3ThAk9bASY7oFN3BdotqKhMm
         H0jYbp5ZE3ADsvfrVNM5VhXVEuVYCL7FpHV2RpZ1+OFFe0XyBDs1huPn9pZmuNBIls
         WTkR3OUQ+sDaYaoI82MwO1wZItdSTk0cXwvOaB3jPbS7e+zky4wMSpd60kLTvM3eEC
         ihDhGtr1/xxeA==
Date:   Wed, 19 May 2021 13:49:35 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com, Lang Cheng <chenglang@huawei.com>
Subject: Re: [PATCH for-next 1/4] RDMA/hns: Remove unused parameter udata
Message-ID: <YKTtP3/q6tILVMsh@unreal>
References: <1620807142-39157-1-git-send-email-liweihang@huawei.com>
 <1620807142-39157-2-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620807142-39157-2-git-send-email-liweihang@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 12, 2021 at 04:12:19PM +0800, Weihang Li wrote:
> From: Lang Cheng <chenglang@huawei.com>
> 
> The old version of ib_umem_get() need these udata as a parameter but now
> they are unnecessary.
> 
> Fixes: c320e527e154 ("IB: Allow calls to ib_umem_get from kernel ULPs")
> Signed-off-by: Lang Cheng <chenglang@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_cq.c     | 3 +--
>  drivers/infiniband/hw/hns/hns_roce_db.c     | 3 +--
>  drivers/infiniband/hw/hns/hns_roce_device.h | 3 +--
>  drivers/infiniband/hw/hns/hns_roce_qp.c     | 4 ++--
>  4 files changed, 5 insertions(+), 8 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
