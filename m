Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB45270BD4
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Sep 2020 10:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgISI1G (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 19 Sep 2020 04:27:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:51284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbgISI1G (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 19 Sep 2020 04:27:06 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32F4721481;
        Sat, 19 Sep 2020 08:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600504025;
        bh=7JC4IeC6tszkcPRpRHWGd13gNEiU1RapmCoqHR37Bkk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sP6+ETvBWx7oXgR5milVFBp0gVkjguawLTis3ReLge1MitSi3o2RNMX8o187XLbxZ
         J4mEEMbBIW5ASZZkp3Xw9+ud+KmXwfa5IJe6NNXIjF78nh5eQwT42PXLGouHRCMWfT
         jG1FdyS5BTQJiLlPVt0owbOXTiIrDLqF2ztmlnVE=
Date:   Sat, 19 Sep 2020 11:27:02 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v2 10/14] RDMA/restrack: Store all special QPs
 in restrack DB
Message-ID: <20200919082702.GX869610@unreal>
References: <20200907122156.478360-1-leon@kernel.org>
 <20200907122156.478360-11-leon@kernel.org>
 <20200918233011.GE3699@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918233011.GE3699@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 18, 2020 at 08:30:11PM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 07, 2020 at 03:21:52PM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@mellanox.com>
> >
> > Special QPs (SMI and GSI) have different rules in regards of their QP
> > numbers. While all other QP numbers are unique per-device, the QP0 and QP1
> > are created per-port as requested by IBTA.
> >
> > In multiple port devices, the number of SMI and GSI QPs with be equal
> > to the number ports.
> >
> > [leonro@vm ~]$ rdma dev
> > 0: ibp0s9: node_type ca fw 4.4.9999 node_guid 5254:00c0:fe12:3455 sys_image_guid 5254:00c0:fe12:3455
> > [leonro@vm ~]$ rdma link
> > 0/1: ibp0s9/1: subnet_prefix fe80:0000:0000:0000 lid 13397 sm_lid 49151 lmc 0 state ACTIVE physical_state LINK_UP
> > 0/2: ibp0s9/2: subnet_prefix fe80:0000:0000:0000 lid 13397 sm_lid 49151 lmc 0 state UNKNOWN physical_state UNKNOWN
> >
> > Before:
> > [leonro@mtl-leonro-l-vm ~]$ rdma res show qp type SMI,GSI
> > link ibp0s9/1 lqpn 0 type SMI state RTS sq-psn 0 comm [ib_core]
> > link ibp0s9/1 lqpn 1 type GSI state RTS sq-psn 0 comm [ib_core]
> >
> > After:
> > [leonro@vm ~]$ rdma res show qp type SMI,GSI
> > link ibp0s9/1 lqpn 0 type SMI state RTS sq-psn 0 comm [ib_core]
> > link ibp0s9/1 lqpn 1 type GSI state RTS sq-psn 0 comm [ib_core]
> > link ibp0s9/2 lqpn 0 type SMI state RTS sq-psn 0 comm [ib_core]
> > link ibp0s9/2 lqpn 1 type GSI state RTS sq-psn 0 comm [ib_core]
> >
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > ---
> >  drivers/infiniband/core/core_priv.h |  2 ++
> >  drivers/infiniband/core/restrack.c  | 11 +++++++++--
> >  2 files changed, 11 insertions(+), 2 deletions(-)
>
> Isn't this a pretty good stand alone bug fix? Add a fixes line?

I see this patch as part of this series, and have no idea if it works
as standalone fix that can be taken automatically to the stable@ by
autosel bot later.

Thanks

>
> Jason
