Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 687FC2E304A
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Dec 2020 07:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725986AbgL0F7K (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Dec 2020 00:59:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:50438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbgL0F7K (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Dec 2020 00:59:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E49B0207AD;
        Sun, 27 Dec 2020 05:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609048709;
        bh=cPm4sxCE5015yznLo6BQHSXu6K9K3+t99xbpKSQyH/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gGFIaH/fnX/kGPLI+gE+udTaC8ascKmPSclI6j0vhTVVBb7vfGW9t7JoJS4S+GMhb
         T6Ai+Z/rWN2Y5yQ67AiRAMj0mliRD+7e7giu5tjH5qCKPmO//z8TNehTgSkl03qKiZ
         Ph0DjEAt+/jQkou3VqIXndVRfKK1x69eYV2k2dn4PFcbDpiqCIDuI2u3ySdhHRCcy/
         7J87/u7suXj/5oKBHU2DWkVxCWGBK01PG1eVvu/vwU8z6V8IOcICLMlBm53XqwOPl9
         WKUoeZuQNjz5/6RksJvnU5GqOZNhd1rMwtYtk9NDXZctHUN4ofxQxdhP4/TFn+VB9u
         2uMglkzbQoOfQ==
Date:   Sun, 27 Dec 2020 07:58:24 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        dledford@redhat.com, jgg@ziepe.ca
Subject: Re: [PATCH v2 -next] mlx5: use DEFINE_MUTEX() for mutex lock
Message-ID: <20201227055824.GA4457@unreal>
References: <20201224132323.31126-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201224132323.31126-1-zhengyongjun3@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 24, 2020 at 09:23:23PM +0800, Zheng Yongjun wrote:
> mutex lock can be initialized automatically with DEFINE_MUTEX()
> rather than explicitly calling mutex_init().
>
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  drivers/infiniband/hw/mlx5/main.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

As I wrote earlier, this patch can't be applied, because the xlt_emergency_page_mutex
mutex was moved in the commit f22c30aa6d27 ("RDMA/mlx5: Move xlt_emergency_page_mutex into mr.c")

Thanks
