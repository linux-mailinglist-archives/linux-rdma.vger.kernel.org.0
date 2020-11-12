Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7366E2B043D
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Nov 2020 12:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbgKLLq5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Nov 2020 06:46:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:50232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727790AbgKLLqv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Nov 2020 06:46:51 -0500
Received: from localhost (thunderhill.nvidia.com [216.228.112.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B6EE216FD;
        Thu, 12 Nov 2020 11:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605181611;
        bh=LyBs53NwKy2mPKk7gJAcahZY7ivoN/ZymUmvWPGCTjQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=04N1AtC5I7O3r+Sd+ShWoaOS6k2cNn1dNWWHlVXmcGysjaTnMMMnjdwpbJM3moMep
         UCuD44hukrM+HXZiw+uPOt13wGS3Q55RJbl21LyJjRAz2+mD7O9y17N9uGbQX7Zsnr
         Z+BqXDT2T5TFqmT/5qyL6JpPo7o2xPYtgRj4+EWE=
Date:   Thu, 12 Nov 2020 13:46:46 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, maorg@mellanox.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] RDMA/core: Fix error return code in _ib_modify_qp()
Message-ID: <20201112114646.GB3628@unreal>
References: <20201112090626.184976-1-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112090626.184976-1-chenzhou10@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 12, 2020 at 05:06:26PM +0800, Chen Zhou wrote:
> Fix to return a negative error code from the error handling case
> instead of 0 in function _ib_modify_qp(), as done elsewhere in this
> function.
>
> Fixes: 51aab12631dd ("RDMA/core: Get xmit slave for LAG")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> ---
>  drivers/infiniband/core/verbs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

It is already fixed in the commit
5333499c6014 ("RDMA/core: Fix error return in _ib_modify_qp()")
Thanks
