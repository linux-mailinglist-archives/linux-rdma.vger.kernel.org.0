Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B836B2DA7A9
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Dec 2020 06:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgLOF0C (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Dec 2020 00:26:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:36578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbgLOFZs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 15 Dec 2020 00:25:48 -0500
Date:   Tue, 15 Dec 2020 07:25:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608009908;
        bh=Emb3sGF05S/A2lHWRBtkjmZWvVz1D5920x/e+pYfvLA=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=YJVb9X389Au05JAPp6eg+uRW5H1zKoSwVS+xRkz67nlWUfQX13BdUHAfKem695AUA
         /vxjXOI/TJWgi02mTDPa7Q4rnilAdb9aO/YVBST71T/vRe6bNFB8Rug+jOxlycvuro
         TSLDMmkOhY7IRqvY2c+f+WbKmEOflPm3fKfxpZ88ZojFny9ovNXXCiM6CW/EUxSiI+
         33tZChhVvnpRKofe9IyTn3u5+A79Y19PLi2FtegH/1mwGnlNgMeuz5NGbn3Yvjn0WJ
         tge7YqRBqCNpVAFPSR9Ff1WlY6+rDxsBqCBDlyCOBSOc+Cv1phBmbVCfZH4bpNsSty
         j2XrVGnKYYz3A==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>,
        Parav Pandit <parav@mellanox.com>,
        Shay Drory <shayd@nvidia.com>
Subject: Re: [PATCH rdma-rc 0/5] Fixes to v5.10
Message-ID: <20201215052504.GK5005@unreal>
References: <20201213132940.345554-1-leon@kernel.org>
 <20201214192722.GB2551375@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214192722.GB2551375@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 14, 2020 at 03:27:22PM -0400, Jason Gunthorpe wrote:
> On Sun, Dec 13, 2020 at 03:29:35PM +0200, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> >
> > Hi,
> >
> > This is another series with various fixes that can easily go to -next too.
> >
> > Thanks
> >
> > Leon Romanovsky (1):
> >   RDMA/cma: Don't overwrite sgid_attr after device is released
> >
> > Maor Gottlieb (2):
> >   RDMA/mlx5: Fix MR cache memory leak
>
> Applied these two to for-next, thanks
>
> >   RDMA/ucma: Fix memory leak of connection request
> >   IB/umad: Return EIO in case of when device disassociated
> >   IB/umad: Return EPOLLERR in case of when device disassociated
>
> These ones can wait till next cycle

Thanks

>
> Jason
