Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6DC338601
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Mar 2021 07:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbhCLGhA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Mar 2021 01:37:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:43344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229587AbhCLGgo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 12 Mar 2021 01:36:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 149D264F82;
        Fri, 12 Mar 2021 06:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615531003;
        bh=chO/uLOFYR+W0oZl3i3BNFqKJM8mJ5pHBNpH5hCj3JM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GP5GdZ5dClZbDKYc+6wu/DTixU9C1pghV6OKcG6om4iAeWnePVvbqnE3szAlKR59o
         t9EaEOOLqwx6SVemT4eFZ47rGTyx9Icmb/LkH2BWO/GgLLF5KRKYmlHilnrGQ2vsXR
         coiC3AJBdmxU4OU31zz4sCpbBH3Ss8jGuEWZcEWU5HKHV4BE4gDkJhe3vuB8LaHQdE
         vJHEUjlApbQ7wR01qd8WTpdkhrQaEBpiCYQAma9ptc40d+Q3FWRlu9o+aNIyHq+w+M
         xCYx27KspVozJFJbtooeNWbQWdxHhhcmkByPwljMUnFQaaxRGTn0RhkAg5+nyK1EZo
         kATmSOjE2eIbQ==
Date:   Fri, 12 Mar 2021 08:36:39 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, Shay Drory <shayd@nvidia.com>,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH rdma-next 2/3] RDMA/mlx5: Create ODP EQ only when ODP MR
 is created
Message-ID: <YEsL9z9DCw6EGYJ7@unreal>
References: <20210304124517.1100608-1-leon@kernel.org>
 <20210304124517.1100608-3-leon@kernel.org>
 <20210312000739.GA2773739@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312000739.GA2773739@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 11, 2021 at 08:07:39PM -0400, Jason Gunthorpe wrote:
> On Thu, Mar 04, 2021 at 02:45:16PM +0200, Leon Romanovsky wrote:
> > -static int
> > -mlx5_ib_create_pf_eq(struct mlx5_ib_dev *dev, struct mlx5_ib_pf_eq *eq)
> > +int mlx5r_odp_create_eq(struct mlx5_ib_dev *dev, struct mlx5_ib_pf_eq *eq)
> >  {
> >  	struct mlx5_eq_param param = {};
> > -	int err;
> > +	int err = 0;
> >
> > +	if (eq->core)
> > +		return 0;
> > +
> > +	mutex_lock(&dev->odp_eq_mutex);
>
> The above if is locked wrong.

It is not wrong, but this is optimization for the case that will be always.

We are creating one ODP EQ for the whole life of the device. It means that
once it is created it will always exist and won't be destroyed till device
is destroyed. We don't need lock to check it.

We need lock only for first ODP EQ creation.

Thanks

>
> Jason
