Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08A24489EC8
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jan 2022 19:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238706AbiAJSFr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jan 2022 13:05:47 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59868 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238685AbiAJSFr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Jan 2022 13:05:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E8C5B81052;
        Mon, 10 Jan 2022 18:05:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32DAFC36AE3;
        Mon, 10 Jan 2022 18:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641837945;
        bh=dnWKtHk0IMmaexsJnKOVegVsP9sJVV2kMtH9JIx/ZVM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ckda3dbWiZftWSME3bgZNy/HtPb/AaXjsJ8L8htjUeWiT4HlZXDfLxLdIbT45Hsp+
         36dfTomFEhpnTwkyXEozdcCJVf+4dteT7eyQVhQiK2t3c8dAIJi1Pldww2n92V95b/
         PAEkdqLIzQFz3/hTCdytg4P66MJGjryvZwFLf74bNksNnNudQBEpzd56AUcAx/QL3D
         m2KzEsVFAMLhyXBEKOVlSW4mDwQ5R1RT1P+mt7JTMUCIYWWtpLYrEv8A1IEqRIdiRc
         DbjeCHtyd/BCQkOrjxTR4+7f859e4CvovnEXwxgMG32zs6f8eBXWjhEN0O+soQEwI1
         deOkqawUskVgQ==
Date:   Mon, 10 Jan 2022 20:05:40 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        syzbot+8fcbb77276d43cc8b693@syzkaller.appspotmail.com
Subject: Re: [PATCH rdma-rc] RDMA/cma: Clear all multicast request fields
Message-ID: <Ydx1dDSa1JDJGFdJ@unreal>
References: <1876bacbbcb6f82af3948e5c37a09da6ea3fcae5.1641474841.git.leonro@nvidia.com>
 <20220106173941.GA2963550@nvidia.com>
 <YdrTbNDTg7VdR2iu@unreal>
 <20220110153619.GC2328285@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110153619.GC2328285@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 10, 2022 at 11:36:19AM -0400, Jason Gunthorpe wrote:
> On Sun, Jan 09, 2022 at 02:22:04PM +0200, Leon Romanovsky wrote:
> > On Thu, Jan 06, 2022 at 01:39:41PM -0400, Jason Gunthorpe wrote:
> > > On Thu, Jan 06, 2022 at 03:15:07PM +0200, Leon Romanovsky wrote:
> > > > From: Leon Romanovsky <leonro@nvidia.com>
> > > > 
> > > > The ib->rec.qkey field is accessed without being initialized.
> > > > Clear the ib_sa_multicast struct to fix the following syzkaller error/.
> > > > 
> > > > =====================================================
> > > > BUG: KMSAN: uninit-value in cma_set_qkey drivers/infiniband/core/cma.c:510 [inline]
> > > > BUG: KMSAN: uninit-value in cma_make_mc_event+0xb73/0xe00 drivers/infiniband/core/cma.c:4570
> > > >  cma_set_qkey drivers/infiniband/core/cma.c:510 [inline]
> > > >  cma_make_mc_event+0xb73/0xe00 drivers/infiniband/core/cma.c:4570
> > > >  cma_iboe_join_multicast drivers/infiniband/core/cma.c:4782 [inline]
> > > >  rdma_join_multicast+0x2b83/0x30a0 drivers/infiniband/core/cma.c:4814
> > > >  ucma_process_join+0xa76/0xf60 drivers/infiniband/core/ucma.c:1479
> > > >  ucma_join_multicast+0x1e3/0x250 drivers/infiniband/core/ucma.c:1546
> > > >  ucma_write+0x639/0x6d0 drivers/infiniband/core/ucma.c:1732
> > > >  vfs_write+0x8ce/0x2030 fs/read_write.c:588
> > > >  ksys_write+0x28c/0x520 fs/read_write.c:643
> > > >  __do_sys_write fs/read_write.c:655 [inline]
> > > >  __se_sys_write fs/read_write.c:652 [inline]
> > > >  __ia32_sys_write+0xdb/0x120 fs/read_write.c:652
> > > >  do_syscall_32_irqs_on arch/x86/entry/common.c:114 [inline]
> > > >  __do_fast_syscall_32+0x96/0xf0 arch/x86/entry/common.c:180
> > > >  do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
> > > >  do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
> > > >  entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
> > > > 
> > > > Local variable ib.i created at:
> > > >  cma_iboe_join_multicast drivers/infiniband/core/cma.c:4737 [inline]
> > > >  rdma_join_multicast+0x586/0x30a0 drivers/infiniband/core/cma.c:4814
> > > >  ucma_process_join+0xa76/0xf60 drivers/infiniband/core/ucma.c:1479
> > > > 
> > > > CPU: 0 PID: 29874 Comm: syz-executor.3 Not tainted 5.16.0-rc3-syzkaller #0
> > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > > > =====================================================
> > > > 
> > > > Fixes: b5de0c60cc30 ("RDMA/cma: Fix use after free race in roce multicast join")
> > > > Reported-by: syzbot+8fcbb77276d43cc8b693@syzkaller.appspotmail.com
> > > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > >  drivers/infiniband/core/cma.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> > > > index 69c9a12dd14e..9c53e1e7de50 100644
> > > > +++ b/drivers/infiniband/core/cma.c
> > > > @@ -4737,7 +4737,7 @@ static int cma_iboe_join_multicast(struct rdma_id_private *id_priv,
> > > >  	int err = 0;
> > > >  	struct sockaddr *addr = (struct sockaddr *)&mc->addr;
> > > >  	struct net_device *ndev = NULL;
> > > > -	struct ib_sa_multicast ib;
> > > > +	struct ib_sa_multicast ib = {};
> > > >  	enum ib_gid_type gid_type;
> > > >  	bool send_only;
> > > 
> > > We shouldn't be able to join anything except a RDMA_PS_UDP to a
> > > multicast in the first place:
> > > 
> > > 	if (id_priv->id.ps == RDMA_PS_UDP)
> > > 		ib.rec.qkey = cpu_to_be32(RDMA_UDP_QKEY);
> > > 
> > > Multicast RC/etc is meaningless. So I guess it should be like this:
> > 
> > I don't know, I used 0 exactly like we have for cma_join_ib_multicast().
> > 
> > Where can I read about this PS limitation? I didn't find anything
> > relevant in the IBTA spec.
> 
> It is a Linux thing
> 
> We should probably check the PS even earlier to prevent the IB side
> from having the same issue.

What do you think about this?

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 835ac54d4a24..0a1f008ca929 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -4669,12 +4669,8 @@ static int cma_join_ib_multicast(struct rdma_id_private *id_priv,
        if (ret)
                return ret;

-       ret = cma_set_qkey(id_priv, 0);
-       if (ret)
-               return ret;
-
        cma_set_mgid(id_priv, (struct sockaddr *) &mc->addr, &rec.mgid);
-       rec.qkey = cpu_to_be32(id_priv->qkey);
+       rec.qkey = cpu_to_be32(RDMA_UDP_QKEY);
        rdma_addr_get_sgid(dev_addr, &rec.port_gid);
        rec.pkey = cpu_to_be16(ib_addr_get_pkey(dev_addr));
        rec.join_state = mc->join_state;
@@ -4748,8 +4744,7 @@ static int cma_iboe_join_multicast(struct rdma_id_private *id_priv,
        cma_iboe_set_mgid(addr, &ib.rec.mgid, gid_type);

        ib.rec.pkey = cpu_to_be16(0xffff);
-       if (id_priv->id.ps == RDMA_PS_UDP)
-               ib.rec.qkey = cpu_to_be32(RDMA_UDP_QKEY);
+       ib.rec.qkey = cpu_to_be32(RDMA_UDP_QKEY);

        if (dev_addr->bound_dev_if)
                ndev = dev_get_by_index(dev_addr->net, dev_addr->bound_dev_if);
@@ -4796,6 +4791,9 @@ int rdma_join_multicast(struct rdma_cm_id *id, struct sockaddr *addr,
        if (WARN_ON(id->qp))
                return -EINVAL;

+       if (id->ps != RDMA_PS_UDP)
+               return -EINVAL;
+
        /* ULP is calling this wrong. */
        if (!id->device || (READ_ONCE(id_priv->state) != RDMA_CM_ADDR_BOUND &&
                            READ_ONCE(id_priv->state) != RDMA_CM_ADDR_RESOLVED))


> 
> multicast should never be used in any place that can omit a qkey,
> IIRC..
> 
> Jason
