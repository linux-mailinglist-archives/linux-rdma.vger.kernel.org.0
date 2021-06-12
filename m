Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 773133A4D28
	for <lists+linux-rdma@lfdr.de>; Sat, 12 Jun 2021 08:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhFLGsv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 12 Jun 2021 02:48:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:46342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230516AbhFLGst (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 12 Jun 2021 02:48:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B71A661186;
        Sat, 12 Jun 2021 06:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623480409;
        bh=kdQvwMHbedlm+ADX9wKQEei5+ddrHu41sDJLfTsfur0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nIw9P+QKUZ3JYnFacL4FaRUF9++YE+Embt9dnp7yz3FT4+qx2u+qipVM2Ah91OE7r
         kQb5xCltK+wlW2DY7qmRmbEaiQ1/ipaH8O7VgYNb9iX6TQuMIcqwExGidj7hwgmBMF
         6XdVG0fCCJwD6BVlGZpf8k6PfCHsW/AXbPaBi3gYALgyUWHh85Jcadu0j49gcZVdqA
         JfNwxqAGuCiartkkV1s57EFBj+dJEEa0kqrEkoL6H/2yd34DWOjw74jqKzTJPky64Z
         dxJXkYpJ91HFwoMv1hag77naSuZowN0OToTyYLKc+GzOr9iN2ttpQNgEwpULTMI+KX
         41EDFAvRNo8JA==
Date:   Sat, 12 Jun 2021 09:46:45 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com, Xi Wang <wangxi11@huawei.com>
Subject: Re: [PATCH v3 for-next] RDMA/hns: Clear extended doorbell info
 before using
Message-ID: <YMRYVXV8VSaZCdd/@unreal>
References: <1623392089-35639-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623392089-35639-1-git-send-email-liweihang@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 11, 2021 at 02:14:49PM +0800, Weihang Li wrote:
> From: Xi Wang <wangxi11@huawei.com>
> 
> Both of HIP08 and HIP09 require the extended doorbell information to be
> cleared before being used.
> 
> Fixes: 6b63597d3540 ("RDMA/hns: Add TSQ link table support")
> Signed-off-by: Xi Wang <wangxi11@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
> Changes since v2:
> - Clear ext doorbell list info before get_hem_table().
> - Link: https://patchwork.kernel.org/project/linux-rdma/patch/1623323990-62343-1-git-send-email-liweihang@huawei.com/
> 
> Changes since v1:
> - Add fixes tag.
> - Add check for return value of hns_roce_clear_extdb_list_info().
> - Link: https://patchwork.kernel.org/project/linux-rdma/patch/1623237065-43344-1-git-send-email-liweihang@huawei.com/
> 
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 21 +++++++++++++++++++++
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  1 +
>  2 files changed, 22 insertions(+)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
