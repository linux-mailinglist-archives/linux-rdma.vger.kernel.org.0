Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0BA435DD5
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Oct 2021 11:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbhJUJZv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Oct 2021 05:25:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:39482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231308AbhJUJZv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Oct 2021 05:25:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3558460E96;
        Thu, 21 Oct 2021 09:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634808215;
        bh=JVaNPdg0AzC9sKq4Z9T68BwM1dSelrumDgV2vK+UNHg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dn8knl3gvR8PsKjtyh3ynFU/kCwy0s8ZvYShOWJXruiWNq18HA9sGsHMjKR382DB3
         b/cSnh30YzIl0R6dD3fAhOcaa/4SPmuvqCWKb1dqjcfsijXCEZ3DjM2FeyOAnPPI1N
         hlpH2eW19unyGVyru+mkz39rdNQdFg0ay4q+vOryhAEKmYP4QB1xT+Bz0k9lbZRd1O
         f7MumBrYGVF7RbAdRkd/v/WS11mQ7mAT9h6szQHQU65tioRfUS0lmHf0Zd/fFOX6tL
         Z992YXfJIPZgSxrmIYlp5oHR9sPEqgIIYsszuT2kRfL8wJ7ejxIHxdHmtKI8r3+eu3
         NzI5j0kPzS2xg==
Date:   Thu, 21 Oct 2021 12:23:31 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Mark Zhang <markzhang@nvidia.com>,
        Aharon Landau <aharonl@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Mark Bloch <mbloch@nvidia.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC] RDMA/mlx5: fix build error with
 INFINIBAND_USER_ACCESS=n
Message-ID: <YXExkx2jieJwe71d@unreal>
References: <20211019061602.3062196-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019061602.3062196-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 19, 2021 at 08:15:45AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The mlx5_ib_fs_add_op_fc/mlx5_ib_fs_remove_op_fc functions are
> only available when user access is enabled, without that we
> run into a link error:
> 
> ERROR: modpost: "mlx5_ib_fs_add_op_fc" [drivers/infiniband/hw/mlx5/mlx5_ib.ko] undefined!
> ERROR: modpost: "mlx5_ib_fs_remove_op_fc" [drivers/infiniband/hw/mlx5/mlx5_ib.ko] undefined!
> 
> Conditionally compiling the newly added code section makes
> it build, though this is probably not a correct fix.
> 
> Fixes: a29b934ceb4c ("RDMA/mlx5: Add modify_op_stat() support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/infiniband/hw/mlx5/counters.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 

Thanks,
Acked-by: Leon Romanovsky <leonro@nvidia.com>
