Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D79312D2412
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Dec 2020 08:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725807AbgLHHNm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Dec 2020 02:13:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:39102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbgLHHNm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 8 Dec 2020 02:13:42 -0500
Date:   Tue, 8 Dec 2020 09:12:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607411582;
        bh=Dxo9KLQf3IDQN19iF5kON3PE44p43pZHxo/mOBqDtgE=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=chFDwlWmtN+dDIVtBWqHHDNPcZllPQ5/kudOA3Yn94SyohWYtX3wb+zxPHbQ3Phup
         Ra0h5zUQZhFFd+6It0T2YZtAD9Fia5iEQ0WSdGEUm8FaSC2d0LN10cWpJKFC3h+9SG
         w9rs24blp+Sl1c25Z96/avttC0buons/D45EARgU+vS0lPREo91hnPo0tSHNVRJ2/g
         8OtoKN/X430E1I6tauP2ua8cM8h5VDZ/v5qYHqoY1zQ6jm2Y4fgZzKUgr2Zb+1PdW1
         bWFF9/2mwMG3Zm9OnZ/SlRk6QdIu6XM2Aa6jXVdBs+xQZoFggo9pVvSNl4a7wNhWmm
         o1/XqC/F4WJXw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jianxin Xiong <jianxin.xiong@intel.com>
Cc:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH v13 2/4] RDMA/core: Add device method for registering
 dma-buf based memory region
Message-ID: <20201208071255.GF4430@unreal>
References: <1607379353-116215-1-git-send-email-jianxin.xiong@intel.com>
 <1607379353-116215-3-git-send-email-jianxin.xiong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607379353-116215-3-git-send-email-jianxin.xiong@intel.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 07, 2020 at 02:15:51PM -0800, Jianxin Xiong wrote:
> Dma-buf based memory region requires one extra parameter and is processed
> quite differently. Adding a separate method allows clean separation from
> regular memory regions.
>
> Signed-off-by: Jianxin Xiong <jianxin.xiong@intel.com>
> Reviewed-by: Sean Hefty <sean.hefty@intel.com>
> Acked-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
> Acked-by: Christian Koenig <christian.koenig@amd.com>
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> ---
>  drivers/infiniband/core/device.c | 1 +
>  include/rdma/ib_verbs.h          | 6 +++++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
