Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1C0A439475
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Oct 2021 13:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbhJYLIa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Oct 2021 07:08:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:47318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231133AbhJYLI3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 25 Oct 2021 07:08:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E840F604AC;
        Mon, 25 Oct 2021 11:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635159967;
        bh=gnVibMBLKO5DOKmJFj8OxeJZBQGQGJ62kqCFi2dNI6M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wq0JqFgjSaOEhPU4iuM2ghR1BYqugrNsvLZoZyepj3PyNn75a+O3MtzmTZO3uvEl/
         iz1x4CpMH8LFMm4lihDSTcD0KZaaDMb1o3o3rEC17bI9HPz9ari4CHWlLbpO+YJg8U
         yxmbefPs0xQOi2k6WJHJ5+iOvxxfbmZ/pqqK32fRbqgAeZZcK6TqapT+OWV2YbmWGs
         jLZqMDFIASNlIuZQFQKOYxHssGQTSRh1ihhlilwcq1X08BssDfyd5MCJ6xCHZWWKG8
         vkzkqA7w6l2Zul67WnZZ2foI3INPQ8yr0rgpW85PTtSjPiSBIqQFbiI2fQgvs2V5K4
         bqqJMDQT1jIQA==
Date:   Mon, 25 Oct 2021 14:06:03 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, mbloch@nvidia.com,
        jinpu.wang@ionos.com, lee.jones@linaro.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-rc] IB/core: fix a UAF for netdev in netdevice_event
 process
Message-ID: <YXaPm6oTI/lk5GoT@unreal>
References: <20211025034258.2426872-1-william.xuanziyang@huawei.com>
 <YXZdsyifJVY+jOaH@unreal>
 <00f99243-919a-d697-646a-0e200c0aef81@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00f99243-919a-d697-646a-0e200c0aef81@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 25, 2021 at 04:37:41PM +0800, Ziyang Xuan (William) wrote:
> > On Mon, Oct 25, 2021 at 11:42:58AM +0800, Ziyang Xuan wrote:
> >> When a vlan netdev enter netdevice_event process although it is not a
> >> roce netdev, it will be passed to netdevice_event_work_handler() to
> >> process. In order to hold the netdev of netdevice_event after
> >> netdevice_event() return, call dev_hold() to hold the netdev in
> >> netdevice_queue_work(). But that did not consider the real_dev of a vlan
> >> netdev, the real_dev can be freed within netdevice_event_work_handler()
> >> be scheduled. It would trigger the UAF problem for the real_dev like
> >> following:
> >>
> >> ==================================================================
> >> BUG: KASAN: use-after-free in vlan_dev_real_dev+0xf9/0x120
> >> Read of size 4 at addr ffff88801648a0c4 by task kworker/u8:0/8
> >> Workqueue: gid-cache-wq netdevice_event_work_handler
> >> Call Trace:
> >>  dump_stack_lvl+0xcd/0x134
> >>  print_address_description.constprop.0.cold+0x93/0x334
> >>  kasan_report.cold+0x83/0xdf
> >>  vlan_dev_real_dev+0xf9/0x120
> >>  is_eth_port_of_netdev_filter.part.0+0xb1/0x2c0
> >>  is_eth_port_of_netdev_filter+0x28/0x40
> >>  ib_enum_roce_netdev+0x1a3/0x300
> >>  ib_enum_all_roce_netdevs+0xc7/0x140
> >>  netdevice_event_work_handler+0x9d/0x210
> >> ...
> >>
> >> Allocated by task 9289:
> >>  kasan_save_stack+0x1b/0x40
> >>  __kasan_kmalloc+0x9b/0xd0
> >>  __kmalloc_node+0x20a/0x330
> >>  kvmalloc_node+0x61/0xf0
> >>  alloc_netdev_mqs+0x9d/0x1140
> >>  rtnl_create_link+0x955/0xb70
> >>  __rtnl_newlink+0xe10/0x15b0
> >>  rtnl_newlink+0x64/0xa0
> >> ...
> >>
> >> Freed by task 9288:
> >>  kasan_save_stack+0x1b/0x40
> >>  kasan_set_track+0x1c/0x30
> >>  kasan_set_free_info+0x20/0x30
> >>  __kasan_slab_free+0xfc/0x130
> >>  slab_free_freelist_hook+0xdd/0x240
> >>  kfree+0xe4/0x690
> >>  kvfree+0x42/0x50
> >>  device_release+0x9f/0x240
> >>  kobject_put+0x1c8/0x530
> >>  put_device+0x1b/0x30
> >>  free_netdev+0x370/0x540
> >>  ppp_destroy_interface+0x313/0x3d0
> >>  ppp_release+0x1bf/0x240
> >> ...
> >>
> >> Hold the real_dev for a vlan netdev in netdevice_event_work_handler()
> >> to fix the UAF problem.
> >>
> >> Fixes: 238fdf48f2b5 ("IB/core: Add RoCE table bonding support")
> >> Reported-by: syzbot+e4df4e1389e28972e955@syzkaller.appspotmail.com
> >> Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
> >> ---
> >>  drivers/infiniband/core/roce_gid_mgmt.c | 16 +++++++++++++++-
> >>  1 file changed, 15 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/infiniband/core/roce_gid_mgmt.c b/drivers/infiniband/core/roce_gid_mgmt.c
> >> index 68197e576433..063dbe72b7c2 100644
> >> --- a/drivers/infiniband/core/roce_gid_mgmt.c
> >> +++ b/drivers/infiniband/core/roce_gid_mgmt.c
> >> @@ -621,6 +621,7 @@ static void netdevice_event_work_handler(struct work_struct *_work)
> >>  {
> >>  	struct netdev_event_work *work =
> >>  		container_of(_work, struct netdev_event_work, work);
> >> +	struct net_device *real_dev;
> >>  	unsigned int i;
> >>  
> >>  	for (i = 0; i < ARRAY_SIZE(work->cmds) && work->cmds[i].cb; i++) {
> >> @@ -628,6 +629,12 @@ static void netdevice_event_work_handler(struct work_struct *_work)
> >>  					 work->cmds[i].filter_ndev,
> >>  					 work->cmds[i].cb,
> >>  					 work->cmds[i].ndev);
> >> +		real_dev = rdma_vlan_dev_real_dev(work->cmds[i].ndev);
> >> +		if (real_dev)
> >> +			dev_put(real_dev);
> >> +		real_dev = rdma_vlan_dev_real_dev(work->cmds[i].filter_ndev);
> >> +		if (real_dev)
> >> +			dev_put(real_dev);
> >>  		dev_put(work->cmds[i].ndev);
> >>  		dev_put(work->cmds[i].filter_ndev);
> >>  	}
> >> @@ -638,9 +645,10 @@ static void netdevice_event_work_handler(struct work_struct *_work)
> >>  static int netdevice_queue_work(struct netdev_event_work_cmd *cmds,
> >>  				struct net_device *ndev)
> >>  {
> >> -	unsigned int i;
> >>  	struct netdev_event_work *ndev_work =
> >>  		kmalloc(sizeof(*ndev_work), GFP_KERNEL);
> >> +	struct net_device *real_dev;
> >> +	unsigned int i;
> >>  
> >>  	if (!ndev_work)
> >>  		return NOTIFY_DONE;
> >> @@ -653,6 +661,12 @@ static int netdevice_queue_work(struct netdev_event_work_cmd *cmds,
> >>  			ndev_work->cmds[i].filter_ndev = ndev;
> >>  		dev_hold(ndev_work->cmds[i].ndev);
> >>  		dev_hold(ndev_work->cmds[i].filter_ndev);
> >> +		real_dev = rdma_vlan_dev_real_dev(ndev_work->cmds[i].ndev);
> >> +		if (real_dev)
> >> +			dev_hold(real_dev);
> >> +		real_dev = rdma_vlan_dev_real_dev(ndev_work->cmds[i].filter_ndev);
> >> +		if (real_dev)
> >> +			dev_hold(real_dev);
> >>  	}
> >>  	INIT_WORK(&ndev_work->work, netdevice_event_work_handler);
> > 
> > Probably, this is the right change, but I don't know well enough that
> > part of code. What prevents from "real_dev" to disappear right after
> > your call to rdma_vlan_dev_real_dev()?
> > 
> 
> It is known that free the net_device until its dev_refcnt is one. The
> detail realization see netdev_run_todo().The real_dev's dev_refcnt of
> a vlan net_device will reach one after unregister_netdevice(&real_dev)
> and unregister_vlan_dev(&vlan_ndev, ...) but the dev_refcnt of the vlan
> net_device is bigger than one because netdevice_queue_work() will hold
> the vlan net_device. So my solution is hold the real_dev too in
> netdevice_queue_work().

              dev_hold(ndev_work->cmds[i].filter_ndev);
 +            real_dev = rdma_vlan_dev_real_dev(ndev_work->cmds[i].ndev);
 +            if (real_dev)
                  <------------ real_dev is released here.
 +                    dev_hold(real_dev);


> 
> > Thanks
> > 
> >>  
> >> -- 
> >> 2.25.1
> >>
> > .
> > 
