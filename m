Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64A6725ED36
	for <lists+linux-rdma@lfdr.de>; Sun,  6 Sep 2020 09:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgIFHhV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 6 Sep 2020 03:37:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:34082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgIFHhU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 6 Sep 2020 03:37:20 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE27E20759;
        Sun,  6 Sep 2020 07:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599377840;
        bh=NVKyACicb1f3yRGWk5C9iVCbe4uQLXaHNFMzXLD2+rY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0AwLLrIbp7rdBnbUgRYoEpC40yxX5fworq72tVSFTTGPgP0zZi2VBihO43j0DvJ3c
         wfXZDEjojiWhp65EM1/3YS6QeQJY0v7JTDmNuySbvV7w+oUKk1VYAHKBltnooAGfws
         PD3NPn+EYZt2J/2/6YsBXWoBOrRfGhPp2jaokgJI=
Date:   Sun, 6 Sep 2020 10:37:16 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     selvin.xavier@broadcom.com, devesh.sharma@broadcom.com,
        somnath.kotur@broadcom.com, sriharsha.basavapatna@broadcom.com,
        nareshkumar.pbs@broadcom.com, dledford@redhat.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] RDMA/bnxt_re: Remove set but not used variable
 'qplib_ctx'
Message-ID: <20200906073716.GD55261@unreal>
References: <20200905121624.32776-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200905121624.32776-1-yuehaibing@huawei.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Sep 05, 2020 at 08:16:24PM +0800, YueHaibing wrote:
> drivers/infiniband/hw/bnxt_re/main.c:1012:25:
>  warning: variable ‘qplib_ctx’ set but not used [-Wunused-but-set-variable]
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/infiniband/hw/bnxt_re/main.c | 2 --
>  1 file changed, 2 deletions(-)

The patch is for rdma-rc and not for rdma-next.
Fixes: f86b31c6a28f ("RDMA/bnxt_re: Static NQ depth allocation")

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
