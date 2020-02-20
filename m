Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFE3E166290
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2020 17:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgBTQ0e (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Feb 2020 11:26:34 -0500
Received: from out20-86.mail.aliyun.com ([115.124.20.86]:53807 "EHLO
        out20-86.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728119AbgBTQ0e (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Feb 2020 11:26:34 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436282|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.682818-0.0088784-0.308303;DS=CONTINUE|ham_system_inform|0.0191604-0.000814833-0.980025;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03267;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.GqC4P1A_1582215988;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.GqC4P1A_1582215988)
          by smtp.aliyun-inc.com(10.147.41.120);
          Fri, 21 Feb 2020 00:26:28 +0800
Date:   Fri, 21 Feb 2020 00:26:33 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Leon Romanovsky <leon@kernel.org>
Subject: Re: a bug(BUG: kernel NULL pointer dereference) of ib or mlx happened in 5.4.21 but not in 5.4.20
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
In-Reply-To: <20200220140547.GE209126@unreal>
References: <FD4E1E87-28CF-4F4C-BBF4-2BD945142A14@oracle.com> <20200220140547.GE209126@unreal>
Message-Id: <20200221002631.97A1.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-Mailer: Becky! ver. 2.74.03 [en]
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi, Leon, Chuck 

It is still broken even with the hotfix(https://patchwork.kernel.org/patch/11387567/) for 5.4.21.

the call stack is almost the same.

Feb 20 23:49:53 T630 kernel: Call Trace:
Feb 20 23:49:53 T630 kernel: port_pkey_list_insert+0x30/0x1a0 [ib_core]
Feb 20 23:49:53 T630 kernel: ? kmem_cache_alloc_trace+0x219/0x230
Feb 20 23:49:53 T630 kernel: ib_security_modify_qp+0x244/0x3b0 [ib_core]
Feb 20 23:49:53 T630 kernel: _ib_modify_qp+0x1c0/0x3c0 [ib_core]
Feb 20 23:49:53 T630 kernel: ? dma_pool_free+0x24/0xc0
Feb 20 23:49:53 T630 kernel: ipoib_init_qp+0x77/0x190 [ib_ipoib]
Feb 20 23:49:53 T630 kernel: ? __mlx4_ib_query_pkey+0xe7/0x110 [mlx4_ib]
Feb 20 23:49:53 T630 kernel: ? ib_find_pkey+0x98/0xe0 [ib_core]
Feb 20 23:49:53 T630 kernel: ipoib_ib_dev_open_default+0x1a/0x180 [ib_ipoib]
Feb 20 23:49:53 T630 kernel: ipoib_ib_dev_open+0x66/0xa0 [ib_ipoib]
Feb 20 23:49:53 T630 kernel: ipoib_open+0x44/0x110 [ib_ipoib]
Feb 20 23:49:53 T630 kernel: __dev_open+0xcd/0x160
Feb 20 23:49:53 T630 kernel: __dev_change_flags+0x1ad/0x220
Feb 20 23:49:53 T630 kernel: ? __dev_notify_flags+0x95/0xf0
Feb 20 23:49:53 T630 kernel: dev_change_flags+0x21/0x60
Feb 20 23:49:53 T630 kernel: do_setlink+0x320/0xf00
Feb 20 23:49:53 T630 kernel: ? __nla_validate_parse+0x51/0x840
Feb 20 23:49:53 T630 kernel: ? xas_load+0x8/0x80
Feb 20 23:49:53 T630 kernel: ? __update_load_avg_cfs_rq+0x1d5/0x2c0
Feb 20 23:49:53 T630 kernel: ? cpumask_next+0x17/0x20
Feb 20 23:49:53 T630 kernel: ? __snmp6_fill_stats64.isra.56+0x6b/0x110
Feb 20 23:49:53 T630 kernel: ? __nla_validate_parse+0x51/0x840
Feb 20 23:49:53 T630 kernel: __rtnl_newlink+0x53d/0x890
Feb 20 23:49:53 T630 kernel: ? __nla_reserve+0x38/0x50
Feb 20 23:49:53 T630 kernel: ? __nla_put+0xc/0x20
Feb 20 23:49:53 T630 kernel: ? __nla_reserve+0x38/0x50
Feb 20 23:49:53 T630 kernel: ? __nla_put+0xc/0x20
Feb 20 23:49:53 T630 kernel: ? nla_put+0x2f/0x40
Feb 20 23:49:53 T630 kernel: ? __nla_reserve+0x38/0x50
Feb 20 23:49:53 T630 kernel: ? __nla_put+0xc/0x20
Feb 20 23:49:53 T630 kernel: ? nla_put+0x2f/0x40
Feb 20 23:49:53 T630 kernel: ? rt6_fill_node+0x2d4/0x850
Feb 20 23:49:53 T630 kernel: ? _cond_resched+0x15/0x30
Feb 20 23:49:53 T630 kernel: ? kmem_cache_alloc_trace+0x1c9/0x230
Feb 20 23:49:53 T630 kernel: rtnl_newlink+0x43/0x60
Feb 20 23:49:53 T630 kernel: rtnetlink_rcv_msg+0x2b1/0x360
Feb 20 23:49:53 T630 kernel: ? __kmalloc_node_track_caller+0x241/0x300
Feb 20 23:49:53 T630 kernel: ? _cond_resched+0x15/0x30
Feb 20 23:49:53 T630 kernel: ? rtnl_calcit.isra.32+0x110/0x110
Feb 20 23:49:53 T630 kernel: netlink_rcv_skb+0x49/0x110
Feb 20 23:49:53 T630 kernel: netlink_unicast+0x191/0x220
Feb 20 23:49:53 T630 kernel: netlink_sendmsg+0x21d/0x3f0
Feb 20 23:49:53 T630 kernel: sock_sendmsg+0x5b/0x60
Feb 20 23:49:53 T630 kernel: ____sys_sendmsg+0x1eb/0x260
Feb 20 23:49:53 T630 kernel: ? copy_msghdr_from_user+0xdb/0x160
Feb 20 23:49:53 T630 kernel: ___sys_sendmsg+0x7c/0xc0
Feb 20 23:49:53 T630 kernel: ? do_filp_open+0xa7/0x100
Feb 20 23:49:53 T630 kernel: ? netdev_run_todo+0x5e/0x290
Feb 20 23:49:53 T630 kernel: ? list_lru_add+0xb7/0x1d0
Feb 20 23:49:53 T630 kernel: __sys_sendmsg+0x57/0xa0
Feb 20 23:49:53 T630 kernel: do_syscall_64+0x5b/0x180
Feb 20 23:49:53 T630 kernel: entry_SYSCALL_64_after_hwframe+0x44/0xa9


This card have 2 port, and port 1 is set as InfiniBand, port 2
is set as Ethernet.

# ibstat
CA 'mlx4_0'
        CA type: MT4099
        Number of ports: 2
        Firmware version: 2.42.5000
        Hardware version: 1
        Node GUID: 0xe41d2d03007b4080
        System image GUID: 0xe41d2d03007b4083
        Port 1:
                State: Down
                Physical state: Polling
                Rate: 10
                Base lid: 0
                LMC: 0
                SM lid: 0
                Capability mask: 0x02594868
                Port GUID: 0xe41d2d03007b4081
                Link layer: InfiniBand
        Port 2:
                State: Down
                Physical state: Disabled
                Rate: 40
                Base lid: 0
                LMC: 0
                SM lid: 0
                Capability mask: 0x00010000
                Port GUID: 0xe61d2dfffe7b4082
                Link layer: Ethernet


Best Regards
王玉贵
2020/02/21

> On Thu, Feb 20, 2020 at 08:57:29AM -0500, Chuck Lever wrote:
> > Hello!
> >
> > Thanks for your bug report.
> >
> >
> > > On Feb 19, 2020, at 10:22 PM, Wang Yugui <wangyugui@e16-tech.com> wrote:
> > >
> > > Hi, chuck.lever
> > >
> > > a bug(BUG: kernel NULL pointer dereference) of ib or mlx happened in 5.4.21 but not in 5.4.20.
> > >
> > > maybe some releationship to xprtrdma-fix-dma-scatter-gather-list-mapping-imbalance.patch
> >
> > I don't see an obvious connection to fix-dma-scatter-gather-list-mapping-imbalance.
> > The backtrace below is through IPoIB code paths. Those have nothing to do with
> > NFS/RDMA, which is the only ULP code that is changed by my commit.
> >
> >
> > > maybe the info is useful.
> >
> > I'm copying linux-rdma for a bigger set of eyeballs.
> >
> > My knee-jerk recommendation is that if you have a reliable reproducer, try "git bisect"
> > between .20 and .21 to nail down a specific commit where the BUG starts to occur.
> 
> No need to bisect, it is me who broke.
> The fix is already accepted, but not yet merged.
> https://patchwork.kernel.org/patch/11387567/
> 
> Thanks

--------------------------------------
北京京垓科技有限公司
王玉贵	wangyugui@e16-tech.com
电话：+86-136-71123776

