Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 238D535B39C
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Apr 2021 13:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235436AbhDKLoQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 11 Apr 2021 07:44:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:37910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235095AbhDKLoP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 11 Apr 2021 07:44:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0DDF610CB;
        Sun, 11 Apr 2021 11:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618141439;
        bh=Anoqp+LMUcK4opU7q36clB465ysnewarF+yeFwlA3v4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=igXR7D/i/rXNGzWr5TNUYPKz40hmYVCts8pxa2a7kf5/ClY6KdnP+183BPKgyu74M
         sVFr3HuLISQ9wO67jVJTEZRpoNCOU1Ay1d9QYdkxe9h93T1UhI5jYJEcXMaF50QM9v
         a2d1b0x0yPOfxwBbtsKP591lCNBMGcfz8k9JtOd2+gfgEd6QFlY/HUswzx4E0i+3Go
         SIQ1u9dn9nyao2BoFriSpH6QOnw3vjfABPQoLWghbOSp178wdZKb8gVU3lc0G45k0z
         qd9eklcUljWg7U7B0/q0v9BiZ3/bI4eXrAq2KMv+3TU9tJlTRbkwtulZ/rJbQDtIs+
         pGRus4iYXwSAA==
Date:   Sun, 11 Apr 2021 14:43:55 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, Mark Bloch <mbloch@nvidia.com>,
        linux-api@vger.kernel.org, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH rdma-next v2] RDMA/mlx5: Expose private query port
Message-ID: <YHLg+1vkClbhGMod@unreal>
References: <20210401085004.577338-1-leon@kernel.org>
 <20210408185412.GA678376@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408185412.GA678376@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 08, 2021 at 03:54:12PM -0300, Jason Gunthorpe wrote:
> On Thu, Apr 01, 2021 at 11:50:04AM +0300, Leon Romanovsky wrote:
> > From: Mark Bloch <mbloch@nvidia.com>
> > 
> > Expose a non standard query port via IOCTL that will be used to expose
> > port attributes that are specific to mlx5 devices.
> > 
> > The new interface receives a port number to query and returns a
> > structure that contains the available attributes for that port.
> > This will be used to fill the gap between pure DEVX use cases
> > and use cases where a kernel needs to inform userspace about
> > various kernel driver configurations that userspace must use
> > in order to work correctly.
> > 
> > Flags is used to indicate which fields are valid on return.
> > 
> > MLX5_IB_UAPI_QUERY_PORT_VPORT:
> > 	The vport number of the queered port.
> > 
> > MLX5_IB_UAPI_QUERY_PORT_VPORT_VHCA_ID:
> > 	The VHCA ID of the vport of the queered port.
> > 
> > MLX5_IB_UAPI_QUERY_PORT_VPORT_STEERING_ICM_RX:
> > 	The vport's RX ICM address used for sw steering.
> > 
> > MLX5_IB_UAPI_QUERY_PORT_VPORT_STEERING_ICM_TX:
> > 	The vport's TX ICM address used for sw steering.
> > 
> > MLX5_IB_UAPI_QUERY_PORT_VPORT_REG_C0:
> > 	The metadata used to tag egress packets of the vport.
> > 
> > MLX5_IB_UAPI_QUERY_PORT_ESW_OWNER_VHCA_ID:
> > 	The E-Switch owner vhca id of the vport.
> > 
> > Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
> > Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> > Changelog:
> > v2:
> >  * Changed __u64 to be __aligned_u64 in the uapi header
> > v1: https://lore.kernel.org/linux-api/20210322093932.398466-1-leon@kernel.org
> >  * Missed sw_owner check for CX-6 device, fixed it.
> > v0: https://lore.kernel.org/linux-api/20210318135221.681014-1-leon@kernel.org
> > ---
> >  drivers/infiniband/hw/mlx5/std_types.c    | 177 ++++++++++++++++++++++
> >  include/uapi/rdma/mlx5_user_ioctl_cmds.h  |   9 ++
> >  include/uapi/rdma/mlx5_user_ioctl_verbs.h |  25 +++
> >  3 files changed, 211 insertions(+)
> 
> Where is the rdma-core part of this? Did I miss it someplace?

Ne, the rdma-core series wasn't sent because of requestedchanges
in the PR https://github.com/linux-rdma/rdma-core/pull/958.

Thanks

> 
> Jason
