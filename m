Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 424F935F88
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2019 16:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbfFEOq4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jun 2019 10:46:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:51816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726442AbfFEOq4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 5 Jun 2019 10:46:56 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8185B20693;
        Wed,  5 Jun 2019 14:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559746015;
        bh=ErhGag2HU22LO2XlAHaaq7u7D1FlJhAcgpZyic36J6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N2yYzWUNwSpGDoKn9/U4eUY9wzAwyp7GxVwoQ0iW/H05Vd5AASTc0HcwlnG/Yr6NZ
         4SvgUqI/DfoQKuz1dA3/WHqfWiGM09/FgG5BtmB1Tk4W0jWh8Q50SV8P7mYTX4rd0E
         bt0gClYrOfzfTw8JDAPtkJa/MYXBXJWqNBU3wpkc=
Date:   Wed, 5 Jun 2019 17:46:51 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Cc:     linux-rdma@vger.kernel.org, dledford@redhat.com, jgg@mellanox.com
Subject: Re: [PATCH for-next v3 0/4] ib_pd should not have ib_uobject
Message-ID: <20190605144651.GO5261@mtr-leonro.mtl.com>
References: <20190530122422.32283-1-shamir.rabinovitch@oracle.com>
 <20190605072125.GA18424@srabinov-laptop>
 <20190605082549.GM5261@mtr-leonro.mtl.com>
 <20190605130244.GA3433@srabinov-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605130244.GA3433@srabinov-laptop>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 05, 2019 at 04:02:45PM +0300, Shamir Rabinovitch wrote:
> On Wed, Jun 05, 2019 at 11:25:49AM +0300, Leon Romanovsky wrote:
> > On Wed, Jun 05, 2019 at 10:21:26AM +0300, Shamir Rabinovitch wrote:
> > > On Thu, May 30, 2019 at 03:24:05PM +0300, Shamir Rabinovitch wrote:
> > > > This patch set complete the cleanup done in the driver/verbs/uverbs
> > > > where the dependency of the code in the ib_x uobject pointer was
> > > > removed.
> > > >
> > > > The uobject pointer is removed from the ib_pd as last step
> > > > before I can start adding the pd sharing code.
> > > >
> > > > The rdma/netlink code now don't have dependency in the ib_pd
> > > > uobject pointer and can report multiple context id that point
> > > > to same ib_pd.
> > > >
> > > > Using iproute2 I can test the modified rdma/netlink:
> > > > [root@qemu-fc29 iproute2]# rdma/rdma res show pd dev mlx4_0
> > > > dev mlx4_0 pdn 0 local_dma_lkey 0x8000 users 4 comm [ib_core]
> > > > dev mlx4_0 pdn 1 local_dma_lkey 0x8000 users 4 comm [ib_core]
> > > > dev mlx4_0 pdn 2 local_dma_lkey 0x8000 users 5 comm [ib_ipoib]
> > > > dev mlx4_0 pdn 3 local_dma_lkey 0x8000 users 5 comm [ib_ipoib]
> > > > dev mlx4_0 pdn 4 local_dma_lkey 0x8000 users 0 comm [ib_srp]
> > > > dev mlx4_0 pdn 5 local_dma_lkey 0x8000 users 0 comm [ib_srpt]
> > > > dev mlx4_0 pdn 6 local_dma_lkey 0x0 users 2 ctxn 0 pid 7693 comm ib_send_bw
> > > > dev mlx4_0 pdn 7 local_dma_lkey 0x0 users 2 ctxn 1 pid 7694 comm ib_send_bw
> > > >
> > > > Changelog:
> > > >
> > > > v1->v2
> > > > * 1 patch from v1 applied (Jason)
> > > > * Fix uobj_get_obj_read macro (Jason)
> > > > * Do not allocate memory when fixing uobj_get_obj_read (Jason)
> > > > * Fix uobj_get_obj_read macro (Jason)
> > > > * rdma/netlink can now work as before (Leon)
> > > >
> > > > v2->v3:
> > > > * rdma/netlink nest multiple context ids of same ib_pd (Leon)
> > > >
> > > > Shamir Rabinovitch (4):
> > > >   RDMA/uverbs: uobj_get_obj_read should return the ib_uobject
> > > >   RDMA/uverbs: uobj_put_obj_read macro should be removed
> > > >   RDMA/nldev: ib_pd can be pointed by multiple ib_ucontext
> > > >   IB/{core,hw}: ib_pd should not have ib_uobject pointer
> > > >
> > > >  drivers/infiniband/core/nldev.c            | 129 +++++++++++-
> > > >  drivers/infiniband/core/uverbs_cmd.c       | 218 +++++++++++++--------
> > > >  drivers/infiniband/core/verbs.c            |   1 -
> > > >  drivers/infiniband/hw/hns/hns_roce_hw_v1.c |   1 -
> > > >  drivers/infiniband/hw/mlx5/main.c          |   1 -
> > > >  drivers/infiniband/hw/mthca/mthca_qp.c     |   3 +-
> > > >  include/rdma/ib_verbs.h                    |   1 -
> > > >  include/rdma/uverbs_std_types.h            |  11 +-
> > > >  include/uapi/rdma/rdma_netlink.h           |   3 +
> > > >  9 files changed, 273 insertions(+), 95 deletions(-)
> > > >
> > > > --
> > > > 2.20.1
> > > >
> > >
> > > Jason, Leon, can you please review this patch set ?
> >
> > I'm sorry for the delay.
> >
> > >
> > > Anything missing from my side here?
> >
> > Can you please post rdmatool output for shared PD?
> > In such case, all those shared PD need to have same PDN.
>
> Leon I do not have all the pieces in place for this yes.
>
> I only tested that current rdmatool can cope with netlink message that
> has nested context ids as it will happen in shared pd case.

Thanks, multiple PDNs worried me and I was afraid that they come from
shared PDs. You will still need to mock something to see that you
print them correctly.

>
> I'll do that once we have the export_to_fd & import_pd & import_mr verbs
> in place.
>
> >
> > Thanks
