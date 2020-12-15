Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D6B2DA8CB
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Dec 2020 08:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgLOHyG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Dec 2020 02:54:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:34350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726749AbgLOHyB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 15 Dec 2020 02:54:01 -0500
Date:   Tue, 15 Dec 2020 09:53:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608018801;
        bh=VxdBYKynl8U9or9FSPVMqwCN8NK8dLVivfL6NwbVh3M=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=W7s8tOqAzv+7YOC1/C5QYkdXTi5Tu/p6dBWBebZ0g6O4xv10YPfqM+8oZJP44PIu6
         SvhD9gS58rrfykdkD2jpORioQtMYTvhATVUX++5/8xSGemX53NbqNGiabBEYRA5BUP
         ekhYzIFXLf7vuVTy/uIl27GyR0rhKYZGdz2XZMUgGtOnJ7wZLofK8ROCg3B4qcfVf8
         o9K3dRGDxEAU87XRZ+oukN54+jGaTXOw3CrPvvgCerrlklo7blRpNzQM8BE3KYDDUT
         ZXfeABI8trOpvbm50+3ZlzFf0IlbIdy6LFcwWtGPTu5EiSIvzSn41TkHKAT4TPGCFX
         W7wugCpr9IW/A==
From:   Leon Romanovsky <leon@kernel.org>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] infiniband: core: Delete useless kfree code
Message-ID: <20201215075317.GM5005@unreal>
References: <20201214134655.4991-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214134655.4991-1-zhengyongjun3@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 14, 2020 at 09:46:55PM +0800, Zheng Yongjun wrote:
> The parameter of kfree function is NULL, so kfree code is useless, delete it.
>
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  drivers/infiniband/core/cma_configfs.c | 1 -
>  1 file changed, 1 deletion(-)

The best thing will be to delete whole "free:" section and return
an error immediately.

Thanks

>
> diff --git a/drivers/infiniband/core/cma_configfs.c b/drivers/infiniband/core/cma_configfs.c
> index 7ec4af2ed87a..c6e7cd9bc25a 100644
> --- a/drivers/infiniband/core/cma_configfs.c
> +++ b/drivers/infiniband/core/cma_configfs.c
> @@ -235,7 +235,6 @@ static int make_cma_ports(struct cma_dev_group *cma_dev_group,
>
>  	return 0;
>  free:
> -	kfree(ports);
>  	cma_dev_group->ports = NULL;
>  	return err;
>  }
> --
> 2.22.0
>
