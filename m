Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F11BB3DD440
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Aug 2021 12:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbhHBKqt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Aug 2021 06:46:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:40786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233317AbhHBKqt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 2 Aug 2021 06:46:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4963A60FA0;
        Mon,  2 Aug 2021 10:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627901199;
        bh=cMY1dVVXuWwh7Mw1QFGFb/SAmJFkeBmI0+kfizR6KE0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yf22NywVyjqAqlliL6uLGyfh87U7k0grKddfOnhMT7ogiHhrPYd4OLrU9R0s5l0Wg
         n6PBDghWwA03E7z4zHin5vp9L7r50Bf+H6HQjcfIIcy/nzgz3+mJkWnGMJZX2R5Bxv
         9FF1Jq2pdt6Z5/VThQP8KPtnY6v7eW+TlXiIOmL91eQ4HK6VT4i0bSDroYw87tIPqg
         i2cbmSn54MTohTGD0voBQ8tLNJ2sdV/1LcdzCKxz57lge+uDoa30W7y/aLvmS5BAO7
         r3gSx8XcSvY0NHJ/hWZEGhxNnd2hXUrHHwMyc26SwjFwgDY2tzcJNn3g9HaOLGuqxb
         WEnyFSfsClHIQ==
Date:   Mon, 2 Aug 2021 13:46:36 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     dledford@redhat.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com, Yangyang Li <liyangyang20@huawei.com>
Subject: Re: [PATCH for-rc] RDMA/hns: Fix the double unlock problem of
 poll_sem
Message-ID: <YQfNDOuxWlDt3O8e@unreal>
References: <1627887374-20019-1-git-send-email-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1627887374-20019-1-git-send-email-liangwenpeng@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 02, 2021 at 02:56:14PM +0800, Wenpeng Liang wrote:
> From: Yangyang Li <liyangyang20@huawei.com>
> 
> If hns_roce_cmd_use_events() fails then it means that the poll_sem is not
> obtained, but the poll_sem is released in hns_roce_cmd_use_polling(), this
> will cause an unlock problem.
> 
> This is the static checker warning:
> 	drivers/infiniband/hw/hns/hns_roce_main.c:926 hns_roce_init()
> 	error: double unlocked '&hr_dev->cmd.poll_sem' (orig line 879)
> 
> Event mode and polling mode are mutually exclusive and resources are
> separated, so there is no need to process polling mode resources in
> event mode.
> 
> The initial mode of cmd is polling mode, so even if cmd fails to switch to
> event mode, it is not necessary to switch to polling mode.
> 
> Fixes: a389d016c030 ("RDMA/hns: Enable all CMDQ context")
> Fixes: 3d50503b3b33 ("RDMA/hns: Optimize cmd init and mode selection for hip08")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_cmd.c  | 7 +++----
>  drivers/infiniband/hw/hns/hns_roce_main.c | 4 +---
>  2 files changed, 4 insertions(+), 7 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
