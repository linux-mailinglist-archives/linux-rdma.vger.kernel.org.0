Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61D7A388C0F
	for <lists+linux-rdma@lfdr.de>; Wed, 19 May 2021 12:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245100AbhESKvt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 May 2021 06:51:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:44230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240246AbhESKvk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 May 2021 06:51:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 843786139A;
        Wed, 19 May 2021 10:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621421421;
        bh=vLEqrXlYA1Z5ur8Rd/VSFSHPBkLv8Cx+K6M4PEaFb84=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bIOtRfj/C4uhYhDuuxpIiRfwyAz1AV4hMRJedak23P6reGhPjJ/8oCbWgjSAvQ3Rl
         mlRbFywp/PmsMJ8tEqCS47JTBPRx6QVNcIe3/2hQXwioiP4TCP0AKSum6SYw/PbleB
         0w1WDELRE041MoFz0nyeRepBqXWF/+uy6bJT7bc4QBgULTb7B1T6NZIFpujvPjiNna
         wRr5VICnsN9hJyYfH+FHtIjq9KCv72dnDJm1bo3vAx0GnRuJmH9295TudE4/r2AV3U
         qJpaWrpwPdbss864TtGO/D5PyHfy0Q20LCt2DBD4W6jZN/ct7VnOInaR3yc6ajiW8P
         b0wzD+TZ4s1vw==
Date:   Wed, 19 May 2021 13:50:16 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com, Lang Cheng <chenglang@huawei.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH for-next 4/4] RDMA/rxe: Remove unused parameter udata
Message-ID: <YKTtaKH0TYhHV6AR@unreal>
References: <1620807142-39157-1-git-send-email-liweihang@huawei.com>
 <1620807142-39157-5-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620807142-39157-5-git-send-email-liweihang@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 12, 2021 at 04:12:22PM +0800, Weihang Li wrote:
> From: Lang Cheng <chenglang@huawei.com>
> 
> The old version of ib_umem_get() need these udata as a parameter but now
> they are unnecessary.
> 
> Fixes: c320e527e154 ("IB: Allow calls to ib_umem_get from kernel ULPs")
> Cc: Zhu Yanjun <zyjzyj2000@gmail.com>
> Signed-off-by: Lang Cheng <chenglang@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_loc.h   | 2 +-
>  drivers/infiniband/sw/rxe/rxe_mr.c    | 2 +-
>  drivers/infiniband/sw/rxe/rxe_verbs.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
