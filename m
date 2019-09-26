Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75900BED00
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Sep 2019 10:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbfIZIAZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Sep 2019 04:00:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:42822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727701AbfIZIAZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 26 Sep 2019 04:00:25 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04A1D2146E;
        Thu, 26 Sep 2019 08:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569484824;
        bh=k0THwXbETRMqvszTCt+kkOwJEbpSH2FPMGPuBvhvRmc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vJepSctmaQ2w96T7EQeLvZrOSTgcYdRO6zxz+As1/nt0tTgPH72aK4T1wU/dQvbh7
         kHEMSQ8burD8U8TDm0WQK4l4SaHdtRN8HlokYX2D3fTTwbmUIXbSalOKN/rdams9ir
         jTlWp5AryP5XFFe9GoRIqK6tiCQc7Mv1gPXiWUBM=
Date:   Thu, 26 Sep 2019 11:00:19 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Parav Pandit <parav@mellanox.com>
Cc:     Yuval Basson <ybason@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "mkalderon@marvell.com" <mkalderon@marvell.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Ariel Elior <aelior@marvell.com>
Subject: Re: [PATCH rdma-next] RDMA/core: Fix find_gid_index to use the
 proper API to retrieve the vlan ID
Message-ID: <20190926080019.GW14368@unreal>
References: <20190925112301.10440-1-ybason@marvell.com>
 <AM0PR05MB4866E99966FEE8C17A295228D1870@AM0PR05MB4866.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR05MB4866E99966FEE8C17A295228D1870@AM0PR05MB4866.eurprd05.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 25, 2019 at 05:17:49PM +0000, Parav Pandit wrote:
> Hi Yuval,
>
>
> > -----Original Message-----
> > From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> > owner@vger.kernel.org> On Behalf Of Yuval Basson
> > Sent: Wednesday, September 25, 2019 6:23 AM
> > To: dledford@redhat.com; jgg@ziepe.ca
> > Cc: leon@kernel.org; mkalderon@marvell.com; linux-rdma@vger.kernel.org;
> > Yuval Basson <ybason@marvell.com>; Ariel Elior <aelior@marvell.com>
> > Subject: [PATCH rdma-next] RDMA/core: Fix find_gid_index to use the proper
> > API to retrieve the vlan ID
> >
> > When working over a macvlan device which was itself created over a vlan
> > device, the roce CM traffic should use the vlan from the lower vlan device, but
> > instead it simply queries the macvlan device as to whether it is itself a vlan
> > device.
> > Since it is not, the roce CM traffic is sent without any vlan, which causes it not
> > to be accepted by the peer which is running directly over a vlan device, and will
> > thus only accept roce CM traffic carrying the vlan.
> >
> > Fixes: dbf727de7440 ("Use GID table in AH creation and dmac resolution")
> > Signed-off-by: Ariel Elior <aelior@marvell.com>
> > Signed-off-by: Yuval Basson <ybason@marvell.com>
> > ---
> >  drivers/infiniband/core/verbs.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
> > index f974b68..1d2d9be0 100644
> > --- a/drivers/infiniband/core/verbs.c
> > +++ b/drivers/infiniband/core/verbs.c
> > @@ -662,13 +662,13 @@ static bool find_gid_index(const union ib_gid *gid,
> >  			   void *context)
> >  {
> >  	struct find_gid_index_context *ctx = context;
> > +	u16 vlan_id;
> >
> >  	if (ctx->gid_type != gid_attr->gid_type)
> >  		return false;
> >
> > -	if ((!!(ctx->vlan_id != 0xffff) == !is_vlan_dev(gid_attr->ndev)) ||
> > -	    (is_vlan_dev(gid_attr->ndev) &&
> > -	     vlan_dev_vlan_id(gid_attr->ndev) != ctx->vlan_id))
> > +	rdma_read_gid_l2_fields(gid_attr, &vlan_id, NULL);
> > +	if (ctx->vlan_id != vlan_id)
> >  		return false;
>
> A little shorter version [1] along with rdmacm support [2] are in Leon's queue which is needed for macvlan to work properly.

I'll start sending after merge window will end.

Thanks

>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git/commit/?h=rdma-next&id=9811bdac481cf6278512a8d052c5ba91cfb69c71
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git/commit/?h=rdma-next&id=d190d04808be104a2a3ef71841ff03c5ffaa16f8
>
> >
> >  	return true;
> > --
> > 1.8.3.1
>
