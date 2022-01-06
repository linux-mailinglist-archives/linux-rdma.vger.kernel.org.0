Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 269144869B5
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jan 2022 19:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242706AbiAFSZB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jan 2022 13:25:01 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56858 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240698AbiAFSZB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Jan 2022 13:25:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 527FEB82300;
        Thu,  6 Jan 2022 18:25:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7061DC36AEB;
        Thu,  6 Jan 2022 18:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641493499;
        bh=9GaARdco9wd21+mN5BPDwOHzbkJBPWLuHC4uImRkdBc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EtdZFzxVU+CRuORFheo4CeymdCoKqwQsEjrSiG+7rh9HNKa5EyrlN4sZ67kHAeYra
         c9i4Oa9HXDWXutc7m5EWInTsmBti9OpqCJKDCDdlFjfICKD6ZYP2F6dIctcs+FCcIR
         oQILuPwvbzoAGEYw8+wgcUXRW5ZhsdmaMlF2+1FmBqphsePKvpdakpeiRcVobKxeof
         0rq0VSXeROnWWYz9NZF8i3g26SIb6AfMzZXHNvEvdb1jZQy1tQlGCmx4RvJFbQv5o5
         QqautvsisAq+aklvteB4YsnA49bXOc7ai/Z0rD0sVydOBpm5Wo1sAAv6rJ2Rv3qF09
         X1NMHer40s50g==
Date:   Thu, 6 Jan 2022 20:24:51 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        syzbot+8fcbb77276d43cc8b693@syzkaller.appspotmail.com
Subject: Re: [PATCH rdma-rc] RDMA/cma: Clear all multicast request fields
Message-ID: <Ydcz87l4S+iZIjE6@unreal>
References: <1876bacbbcb6f82af3948e5c37a09da6ea3fcae5.1641474841.git.leonro@nvidia.com>
 <20220106173941.GA2963550@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106173941.GA2963550@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 06, 2022 at 01:39:41PM -0400, Jason Gunthorpe wrote:
> On Thu, Jan 06, 2022 at 03:15:07PM +0200, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > The ib->rec.qkey field is accessed without being initialized.
> > Clear the ib_sa_multicast struct to fix the following syzkaller error/.
> > 
> > =====================================================
> > BUG: KMSAN: uninit-value in cma_set_qkey drivers/infiniband/core/cma.c:510 [inline]
> > BUG: KMSAN: uninit-value in cma_make_mc_event+0xb73/0xe00 drivers/infiniband/core/cma.c:4570
> >  cma_set_qkey drivers/infiniband/core/cma.c:510 [inline]
> >  cma_make_mc_event+0xb73/0xe00 drivers/infiniband/core/cma.c:4570
> >  cma_iboe_join_multicast drivers/infiniband/core/cma.c:4782 [inline]
> >  rdma_join_multicast+0x2b83/0x30a0 drivers/infiniband/core/cma.c:4814
> >  ucma_process_join+0xa76/0xf60 drivers/infiniband/core/ucma.c:1479
> >  ucma_join_multicast+0x1e3/0x250 drivers/infiniband/core/ucma.c:1546
> >  ucma_write+0x639/0x6d0 drivers/infiniband/core/ucma.c:1732
> >  vfs_write+0x8ce/0x2030 fs/read_write.c:588
> >  ksys_write+0x28c/0x520 fs/read_write.c:643
> >  __do_sys_write fs/read_write.c:655 [inline]
> >  __se_sys_write fs/read_write.c:652 [inline]
> >  __ia32_sys_write+0xdb/0x120 fs/read_write.c:652
> >  do_syscall_32_irqs_on arch/x86/entry/common.c:114 [inline]
> >  __do_fast_syscall_32+0x96/0xf0 arch/x86/entry/common.c:180
> >  do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
> >  do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
> >  entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
> > 
> > Local variable ib.i created at:
> >  cma_iboe_join_multicast drivers/infiniband/core/cma.c:4737 [inline]
> >  rdma_join_multicast+0x586/0x30a0 drivers/infiniband/core/cma.c:4814
> >  ucma_process_join+0xa76/0xf60 drivers/infiniband/core/ucma.c:1479
> > 
> > CPU: 0 PID: 29874 Comm: syz-executor.3 Not tainted 5.16.0-rc3-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > =====================================================
> > 
> > Fixes: b5de0c60cc30 ("RDMA/cma: Fix use after free race in roce multicast join")
> > Reported-by: syzbot+8fcbb77276d43cc8b693@syzkaller.appspotmail.com
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> >  drivers/infiniband/core/cma.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> > index 69c9a12dd14e..9c53e1e7de50 100644
> > +++ b/drivers/infiniband/core/cma.c
> > @@ -4737,7 +4737,7 @@ static int cma_iboe_join_multicast(struct rdma_id_private *id_priv,
> >  	int err = 0;
> >  	struct sockaddr *addr = (struct sockaddr *)&mc->addr;
> >  	struct net_device *ndev = NULL;
> > -	struct ib_sa_multicast ib;
> > +	struct ib_sa_multicast ib = {};
> >  	enum ib_gid_type gid_type;
> >  	bool send_only;
> 
> We shouldn't be able to join anything except a RDMA_PS_UDP to a
> multicast in the first place:
> 
> 	if (id_priv->id.ps == RDMA_PS_UDP)
> 		ib.rec.qkey = cpu_to_be32(RDMA_UDP_QKEY);
> 
> Multicast RC/etc is meaningless. So I guess it should be like this:

Strange that we don't have repro for such deterministic flow.

> 
> --- a/drivers/infiniband/core/cma.c
> +++ b/drivers/infiniband/core/cma.c
> @@ -4744,7 +4744,7 @@ static int cma_iboe_join_multicast(struct rdma_id_private *id_priv,
>  
>         send_only = mc->join_state == BIT(SENDONLY_FULLMEMBER_JOIN);
>  
> -       if (cma_zero_addr(addr))
> +       if (cma_zero_addr(addr) || id_priv->id.ps != RDMA_PS_UDP)
>                 return -EINVAL;
>  
>         gid_type = id_priv->cma_dev->default_gid_type[id_priv->id.port_num -
> @@ -4752,8 +4752,7 @@ static int cma_iboe_join_multicast(struct rdma_id_private *id_priv,
>         cma_iboe_set_mgid(addr, &ib.rec.mgid, gid_type);
>  
>         ib.rec.pkey = cpu_to_be16(0xffff);
> -       if (id_priv->id.ps == RDMA_PS_UDP)
> -               ib.rec.qkey = cpu_to_be32(RDMA_UDP_QKEY);
> +       ib.rec.qkey = cpu_to_be32(RDMA_UDP_QKEY);
>  
>         if (dev_addr->bound_dev_if)
>                 ndev = dev_get_by_index(dev_addr->net, dev_addr->bound_dev_if);
