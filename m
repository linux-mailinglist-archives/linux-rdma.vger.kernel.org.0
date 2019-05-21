Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEB062496F
	for <lists+linux-rdma@lfdr.de>; Tue, 21 May 2019 09:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfEUHyV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 May 2019 03:54:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:56576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbfEUHyV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 21 May 2019 03:54:21 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72B642173C;
        Tue, 21 May 2019 07:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558425261;
        bh=MvkXzA8hBWzdBIe+xwbvPdbuUZp1fulj5mrEcRoLtxM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=avfHTQ661TYl/Zk8V5nVwBPuNJB3m5bRTE79yLMe2bhPNL08/2Y04MDgb/Om+KOUN
         KGRO3k58niMX7yR3uGPUEwB2tI7JgSAjzIw+LgE9BcCCM33RbRwI9+5agURY4c7cVD
         jqORiicJkkpmiYCYDuRxu9tkocX8TTuaz5rawhrw=
Date:   Tue, 21 May 2019 10:54:17 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH for-next] RDMA/core: Return void from
 ib_device_check_mandatory()
Message-ID: <20190521075417.GV4573@mtr-leonro.mtl.com>
References: <20190521070507.16686-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521070507.16686-1-kamalheib1@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 21, 2019 at 10:05:07AM +0300, Kamal Heib wrote:
> The return value from ib_device_check_mandatory() is always 0 - change
> it to be void.
>
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>  drivers/infiniband/core/device.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
