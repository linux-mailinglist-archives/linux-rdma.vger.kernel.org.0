Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1743438B8
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Mar 2021 06:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhCVFmr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Mar 2021 01:42:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:47202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229482AbhCVFmQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Mar 2021 01:42:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CCDFB61966;
        Mon, 22 Mar 2021 05:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616391736;
        bh=jwRpjhsyhJ8h24O9iEpL7ZSp0VLf2Y/Z1vAYJM38LVk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OezATpyrbdIkcbTV8++Q2BeA9WlT3/qHV/ugSBGnALAH75X9cGYtdEAcakhVAgbPT
         ScFdf9+fVUAoMTznrR84xTwM1Qcoc0WxnA1242GrDuMJ9EnpFRbtN7tP3bXJso7tjF
         U724II2bSRgDjn+JwwU2nlGw8uAlOxVs8zAgtddh40gg+FVZlYTUW1WgIywuxvlWVL
         FiRnTRJg/b9L0CAyEffPakUkAZ3+BJsGN1j0r8oHfgFaQLd1FylzuBXaXE4eXmt+lk
         XhPYvO1u96VPm9U+b65z1CpWAYyeVtOGX3s0KI+F1zkkK5PNP/2GT9UxhuYziDUXpT
         TVAu6peWjYJEw==
Date:   Mon, 22 Mar 2021 07:42:12 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v2 for-next] RDMA/hns: Fix memory corruption when
 allocating XRCDN
Message-ID: <YFguNJBMSnr4YXUC@unreal>
References: <1616381069-51759-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616381069-51759-1-git-send-email-liweihang@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 22, 2021 at 10:44:29AM +0800, Weihang Li wrote:
> It's incorrect to cast the type of pointer to xrcdn from (u32 *) to
> (unsigned long *), then pass it into hns_roce_bitmap_alloc(), this will
> lead to a memory corruption.
> 
> Fixes: 32548870d438 ("RDMA/hns: Add support for XRC on HIP09")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
> Changes since v1:
> - xrcdn won't be set if hns_roce_bitmap_alloc() fails.
> - Link: https://patchwork.kernel.org/project/linux-rdma/patch/1616143536-24874-1-git-send-email-liweihang@huawei.com/
> 
>  drivers/infiniband/hw/hns/hns_roce_pd.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
