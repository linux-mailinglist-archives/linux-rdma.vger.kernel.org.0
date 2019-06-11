Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C28373C4BE
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2019 09:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403953AbfFKHQW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jun 2019 03:16:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:51734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403812AbfFKHQW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 Jun 2019 03:16:22 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54B7E2086D;
        Tue, 11 Jun 2019 07:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560237382;
        bh=JmM+WFTJou9ux73bMBDOSH2O8/S8CImQhmnAPpT1hRA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wi2c021AhYFPyvJsZusxy7jRoAiNklpiAn9RLyv9hERkUc3Wd6mmXtgxqPtEr14ce
         bgbkucdwPSehCwjw22lHL1IJFVbk0Aiu6SSCj7zHf2OMsFDBEqD0wp/sdit9KP/SgQ
         jnX1MAKKA2jaDDe3xezCrVka0U785cYJrDDFPX3c=
Date:   Tue, 11 Jun 2019 10:16:18 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH] rdma: Delete the ib_ucm module
Message-ID: <20190611071618.GJ6369@mtr-leonro.mtl.com>
References: <20190610180407.11104-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610180407.11104-1-jgg@ziepe.ca>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 10, 2019 at 03:04:07PM -0300, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
>
> This has been marked CONFIG_BROKEN for over a year now with no complaints.
> Delete the whole thing for good.
>
> The module provided the /dev/infiniband/ucmX interface.
>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>  drivers/infiniband/Kconfig       |   11 -
>  drivers/infiniband/core/Makefile |    3 -
>  drivers/infiniband/core/ucm.c    | 1350 ------------------------------
>  include/uapi/rdma/ib_user_cm.h   |  326 --------
>  4 files changed, 1690 deletions(-)
>  delete mode 100644 drivers/infiniband/core/ucm.c
>  delete mode 100644 include/uapi/rdma/ib_user_cm.h
>
> Leon points out it is time for this to go, so let it be so.
>
> This is just deleting, so I'm going to queue it to wip right now.
>
> Jason
>

Need to drop it and nes from rdma-core too,
https://github.com/linux-rdma/rdma-core/blob/master/kernel-headers/rdma/ib_user_cm.h

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
