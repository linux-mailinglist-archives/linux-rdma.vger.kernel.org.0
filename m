Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF8B1356C08
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Apr 2021 14:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352131AbhDGM0v (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Apr 2021 08:26:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:48984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235368AbhDGM0v (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 7 Apr 2021 08:26:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D38C6128A;
        Wed,  7 Apr 2021 12:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617798401;
        bh=qWLH2wyeHl5fLuFHSuEP3YS/pZxbTCGJuM81QUP1pbY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Btlip+yWAEDC6NWwqrNMx51dYqwrJsy0pg19b1nu3+AV6K915EwqQ71RQ/O2rG7VB
         A3QyHI8gM3WBPgAckYLH/Kcv6EITpgtW32ZR1fYD+rD07OMs0Tg8SdDqHY+xGGsjQk
         oc9z/Rj3d9QhvwKfF7OWwRZumfWf9Gc/uynPvr4Ojpui6uuM5SAW/D3grMa9J998fV
         Yv43bNJn/+j173XyX6HOYLwmKRgVOS12GRQuFzGJmmaauzKAtLj2IQO0xug9kEk5jb
         SRxeaepBQIRCgfOSuYYU7EdPdjCi4VPLl6JaRON/l4z76rmjXu2U/gt/hO0uaFx9BW
         thmhcYyEoIk9A==
Date:   Wed, 7 Apr 2021 15:26:37 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v2 for-next 0/7] RDMA/core: Correct some coding-style
 issues
Message-ID: <YG2k/dNx69+AC/kX@unreal>
References: <1617783353-48249-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617783353-48249-1-git-send-email-liweihang@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Apr 07, 2021 at 04:15:46PM +0800, Weihang Li wrote:
> Do some cleanups according to the coding-style of kernel.
> 
> Changes since v1:
> - Remove a BUG_ON in #3 and put the changes into a new patch.
> - Drop the parts about spaces around xx_for_each_xx() from #4 because some
>   clang formatter prefer current style.
> - Link: https://patchwork.kernel.org/project/linux-rdma/cover/1617697184-48683-1-git-send-email-liweihang@huawei.com/
> 
> Weihang Li (1):
>   RDMA/core: Remove redundant BUG_ON
> 
> Wenpeng Liang (6):
>   RDMA/core: Print the function name by __func__ instead of an fixed
>     string
>   RDMA/core: Remove the redundant return statements
>   RDMA/core: Add necessary spaces
>   RDMA/core: Remove redundant spaces
>   RDMA/core: Correct format of braces
>   RDMA/core: Correct format of block comments
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
