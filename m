Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2AB8912A
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Aug 2019 11:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfHKJ5B (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 11 Aug 2019 05:57:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:43674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbfHKJ5B (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 11 Aug 2019 05:57:01 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26AB52084D;
        Sun, 11 Aug 2019 09:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565517420;
        bh=lC2U5/AN/rqY2NHA7ESDuFpo++nq91VTbEYCfazjs7c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dCfVx/bsCytfW4OGKddurPa/3HNJWBUTGdqA5uXD2N3OAcjr5d06pHuUVSV/cWaou
         L4MlXD7UCYGDV8qmkrB1oH9dShS4nxPJxSpE2QA6Nb5NV9n4yWxO4thLTjHu5A8C0M
         JvLbeQl+V4wtLwUlH+Otb5OgszveKaUI5vsUvKsw=
Date:   Sun, 11 Aug 2019 12:56:57 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Mark Zhang <markz@mellanox.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Parav Pandit <parav@mellanox.com>,
        Majd Dibbiny <majd@mellanox.com>,
        Steve Wise <swise@opengridcomputing.com>,
        linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/core: Fix error code in stat_get_doit_qp()
Message-ID: <20190811095657.GG28049@mtr-leonro.mtl.com>
References: <20190809101311.GA17867@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809101311.GA17867@mwanda>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 09, 2019 at 01:13:19PM +0300, Dan Carpenter wrote:
> We need to set the error codes on these paths.  Currently the only
> possible error code is -EMSGSIZE so that's what the patch uses.
>
> Fixes: 83c2c1fcbd08 ("RDMA/nldev: Allow get counter mode through RDMA netlink")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/infiniband/core/nldev.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
