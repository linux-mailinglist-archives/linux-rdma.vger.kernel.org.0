Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9423A2ABE
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jun 2021 13:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhFJLwu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Jun 2021 07:52:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:58508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230130AbhFJLwt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 10 Jun 2021 07:52:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B068D613CA;
        Thu, 10 Jun 2021 11:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623325853;
        bh=9yXWr+KZ8+TLzQlIDiYhReMeneGK+skxaEi8tt4B1F0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QMVkBwnielS6szGuq+975QpdTxgt4O8tRp31dVO+LNsozHuCC4urqOU7+Tdpw1ELm
         r0QRhxj6YKWu7gS/3MThW6t3DQtHORXbT+aabXq1htFFhGiQihAJ+HiiH7XyhreZJc
         3wJGrKLwGq76YusEeEehu4nFDJKOQYVsz56fSm4/iNxIsIm3PlOuICtzTpa4WBKH+0
         5qi6uMelC2J91OJhwZXAPJk0ugpV/uxfri5zZA3l1xJPTWw1so6MtKrR7nsf8ceqqJ
         vCA52yc8XpjTZyJzsebGj+Yt6aZ0DhUpA8f86kvqLygZF74UVzMuufofVAEx1F+32/
         EoIal1yWV1eVw==
Date:   Thu, 10 Jun 2021 14:50:50 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Yishai Hadas <yishaih@nvidia.com>, linux-rdma@vger.kernel.org,
        yishaih@mellanox.com, maorg@mellanox.com, phaddad@nvidia.com,
        Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH rdma-core 2/4] mlx5: Implement
 ibv_query_qp_data_in_order() verb
Message-ID: <YMH8mr6AWEuJceoj@unreal>
References: <20210609155932.218005-1-yishaih@nvidia.com>
 <20210609155932.218005-3-yishaih@nvidia.com>
 <YMGoQ2ZmTjSun54y@unreal>
 <20210610114224.GJ1002214@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610114224.GJ1002214@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 10, 2021 at 08:42:24AM -0300, Jason Gunthorpe wrote:
> On Thu, Jun 10, 2021 at 08:50:59AM +0300, Leon Romanovsky wrote:
> > On Wed, Jun 09, 2021 at 06:59:30PM +0300, Yishai Hadas wrote:
> > > From: Patrisious Haddad <phaddad@nvidia.com>
> > > 
> > > Implement the ibv_query_qp_data_in_order() verb by using DEVX to read
> > > from firmware the 'in_order_data' capability.
> > > 
> > > Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
> > > Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
> > > Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> > >  providers/mlx5/mlx5.c     |  1 +
> > >  providers/mlx5/mlx5.h     |  3 +++
> > >  providers/mlx5/mlx5_ifc.h | 39 +++++++++++++++++++++++++++++++--
> > >  providers/mlx5/verbs.c    | 55 +++++++++++++++++++++++++++++++++++++++++++++++
> > >  4 files changed, 96 insertions(+), 2 deletions(-)
> > 
> > <...>
> > 
> > > +int mlx5_query_qp_data_in_order(struct ibv_qp *qp, enum ibv_wr_opcode op,
> > > +				uint32_t flags)
> > > +{
> > > +	uint32_t in_qp[DEVX_ST_SZ_DW(query_qp_in)] = {};
> > > +	uint32_t out_qp[DEVX_ST_SZ_DW(query_qp_out)] = {};
> > > +	struct mlx5_context *mctx = to_mctx(qp->context);
> > > +	struct mlx5_qp *mqp = to_mqp(qp);
> > > +	int ret;
> > > +
> > > +/* Currently this API is only supported for x86 architectures since most
> > > + * non-x86 platforms are known to be OOO and need to do a per-platform study.
> > > + */
> > > +#if !defined(__i386__) && !defined(__x86_64__)
> > > +	return 0;
> > > +#endif
> > 
> > Does it compile without warnings/errors on such platforms?
> > You have "return 0;" in the middle of function, so the right thing to do
> > it is to write with "#if ..." over function or inside like below, as
> > long as "#else" exists.
> > 
> > int mlx5_query_qp_data_in_order(struct ibv_qp *qp, enum ibv_wr_opcode op,
> > 				uint32_t flags)
> > {
> > #if !defined(__i386__) && !defined(__x86_64__)
> > 	/* Currently this API is only supported for x86 architectures since most
> > 	 * non-x86 platforms are known to be OOO and need to do a per-platform study.
> > 	 */
> > 	 return 0;
> > #else
> > .....
> > #endif
> 
> We should probably put the above in the core code anyhow

Agree, it makes sense.

Thanks

> 
> Jason
