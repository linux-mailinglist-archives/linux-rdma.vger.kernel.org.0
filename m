Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2333D0949
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jul 2021 08:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbhGUGSZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Jul 2021 02:18:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:52286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229920AbhGUGSG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Jul 2021 02:18:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B1DD861029;
        Wed, 21 Jul 2021 06:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626850723;
        bh=/dzN3dGvff07PV8xReNJiv6NdGO7sdh+YWMg6puc25U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X6n/g+kWHUUgQWyFDHa6yC6UF9FlbF3Z3kDwXYf78ctmf7J3fy2Cz3Y6m/4jvwLCA
         Ho9oSdogFAw+NJMkFmOQ0vmxpcQKPKtFyn4kGfoVKN0ROpixGcXAbcZr7H+x81xhOn
         bm4jmGhG0NBLpkszFJ8saq2EtKTj1JK6TPyS+2UkqFo2CurpVX/OTLFgXCfytuvdkQ
         ktJ+XxO1UqFEcHQB6xbwfBHi4CFG3aJDyCyU20M0TyfuUT8F7SNNb2Kdj1auVmlLK7
         C457DPuw1Y9DnUGfHZMZ+Eh3PUCLDNV/TowDE2jBVub6l9135GX8ZAe0HrCfKvjm63
         FfnfCGbe7XU2g==
Date:   Wed, 21 Jul 2021 09:58:39 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Mark Zhang <markz@mellanox.com>
Subject: Re: [PATCH rdma-next 4/7] RDMA/core: Reorganize create QP low-level
 functions
Message-ID: <YPfFn2Qlaoe5cwBX@unreal>
References: <cover.1626846795.git.leonro@nvidia.com>
 <328963df8e30bfc040c846d2c7626becd341f3ec.1626846795.git.leonro@nvidia.com>
 <YPfCnIfVmolgfMPF@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPfCnIfVmolgfMPF@infradead.org>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 21, 2021 at 07:45:48AM +0100, Christoph Hellwig wrote:
> > +/**
> > + * ib_create_qp_kernel - Creates a kernel QP associated with the specified
> 
> Any reason this function is renamed?  This seems rather unrelated to
> the rest of th patch.

I wanted to make two functions: ib_create_qp_kernel and ib_create_qp_user.

> 
> > + *   protection domain.
> >   * @pd: The protection domain associated with the QP.
> >   * @qp_init_attr: A list of initial attributes required to create the
> >   *   QP.  If QP creation succeeds, then the attributes are updated to
> >   *   the actual capabilities of the created QP.
> >   * @caller: caller's build-time module name
> > - *
> > - * NOTE: for user qp use ib_create_qp_user with valid udata!
> >   */
> 
> Also a kerneldoc comment for a function that is an implementation
> detail is actively harmful.  Please document ib_create_qp instead.

Sure, will do.
