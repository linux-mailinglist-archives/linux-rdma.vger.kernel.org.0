Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A692C975A
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Dec 2020 06:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgLAF5J (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Dec 2020 00:57:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:58240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbgLAF5J (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 1 Dec 2020 00:57:09 -0500
Received: from localhost (searspoint.nvidia.com [216.228.112.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 039892168B;
        Tue,  1 Dec 2020 05:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606802188;
        bh=7k9y1k/fW/QbC2A52mLlh98jkAU0n34EysfGQg3iV+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dHYPrIohNPyOXHhxTd9PYOQ4/0OVV3DgENrigD8/HFkvmAqBz83A7IUQE2qc71Xb2
         t5WfT0OXKPwuTrN73pCx+/BZmzKZJHbA/RLED/fW7sr0hUuIJCTmrKtp6lj9yH/dxJ
         /PxVYiy98DLcb8d6MS842amQrUd2TnnI5GzLo+tc=
Date:   Tue, 1 Dec 2020 07:56:24 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next 2/3] RDMA/hns: Bugfix for calculation of
 extended sge
Message-ID: <20201201055624.GE3286@unreal>
References: <1606558959-48510-1-git-send-email-liweihang@huawei.com>
 <1606558959-48510-3-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1606558959-48510-3-git-send-email-liweihang@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Nov 28, 2020 at 06:22:38PM +0800, Weihang Li wrote:
> From: Yangyang Li <liyangyang20@huawei.com>
>
> Page alignment is required when setting the number of extended sge
> according to the hardware's achivement. If the space of needed extended sge
> is greater than one page, the roundup_pow_of_two() can ensure that. But if
> the needed extended sge isn't 0 and can not be filled in a whole page, the
> driver should align it specifically.
>
> Fixes: 54d6638765b0 ("RDMA/hns: Optimize WQE buffer size calculating process")
> Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_qp.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
