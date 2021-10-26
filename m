Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 393CF43AE7E
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Oct 2021 11:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbhJZJFn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Oct 2021 05:05:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:39066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230041AbhJZJFm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 26 Oct 2021 05:05:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9AC4A60F0F;
        Tue, 26 Oct 2021 09:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635238999;
        bh=V/JirVYmCUw7SwN05d4lRm2+VShv2f/d0tPhnxi0hUU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dEu/6IqbSHdkHCR6JISNjQWGwB+MDKOU4LibmVOCD8L7ZYbZs3mx2uN3zjfxe1eQm
         FsUx9JE5EcPk00PTSu00A/zrfpQXTBoj+aDaESWXpc1kGdIkJS/2Kqpy3jpQQWzPgU
         6Ax6Ad0COexFwYrEC6bbMiyuqn2/asuuCLE0IBN2G9kVLJrnRTJZxgUvqfH70KE/B8
         6PNw/CNdKV15lXh/rKBMDWMN10WbU49cWKHXaKtuTo0YrS3CD0IYjBu9LrRgNG0OPM
         NkLvLSvvA6gON2ZuB8eHG3v3eJXGEdoGKEJCgTKg/pBHSHbIEV7W44aEV9kxXfHRD4
         UYdKYcfKfggpg==
Date:   Tue, 26 Oct 2021 12:03:15 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>,
        Jiri Pirko <jiri@nvidia.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, mbloch@nvidia.com,
        jinpu.wang@ionos.com, lee.jones@linaro.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-rc] IB/core: fix a UAF for netdev in netdevice_event
 process
Message-ID: <YXfEU0nCyw+9Ujpf@unreal>
References: <20211025034258.2426872-1-william.xuanziyang@huawei.com>
 <YXZdsyifJVY+jOaH@unreal>
 <00f99243-919a-d697-646a-0e200c0aef81@huawei.com>
 <YXaPm6oTI/lk5GoT@unreal>
 <07239ae2-8994-20a6-1cba-c3018c9b0117@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07239ae2-8994-20a6-1cba-c3018c9b0117@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 26, 2021 at 11:14:01AM +0800, Ziyang Xuan (William) wrote:
> >>>> diff --git a/drivers/infiniband/core/roce_gid_mgmt.c b/drivers/infiniband/core/roce_gid_mgmt.c
> >>>> index 68197e576433..063dbe72b7c2 100644
> >>>> --- a/drivers/infiniband/core/roce_gid_mgmt.c
> >>>> +++ b/drivers/infiniband/core/roce_gid_mgmt.c
> >>>> @@ -621,6 +621,7 @@ static void netdevice_event_work_handler(struct work_struct *_work)
> >>>>  {
> >>>>  	struct netdev_event_work *work =
> >>>>  		container_of(_work, struct netdev_event_work, work);
> >>>> +	struct net_device *real_dev;
> >>>>  	unsigned int i;
> >>>>  
> >>>>  	for (i = 0; i < ARRAY_SIZE(work->cmds) && work->cmds[i].cb; i++) {
> >>>> @@ -628,6 +629,12 @@ static void netdevice_event_work_handler(struct work_struct *_work)
> >>>>  					 work->cmds[i].filter_ndev,
> >>>>  					 work->cmds[i].cb,
> >>>>  					 work->cmds[i].ndev);
> >>>> +		real_dev = rdma_vlan_dev_real_dev(work->cmds[i].ndev);
> >>>> +		if (real_dev)
> >>>> +			dev_put(real_dev);
> >>>> +		real_dev = rdma_vlan_dev_real_dev(work->cmds[i].filter_ndev);
> >>>> +		if (real_dev)
> >>>> +			dev_put(real_dev);
> >>>>  		dev_put(work->cmds[i].ndev);
> >>>>  		dev_put(work->cmds[i].filter_ndev);
> >>>>  	}
> >>>> @@ -638,9 +645,10 @@ static void netdevice_event_work_handler(struct work_struct *_work)
> >>>>  static int netdevice_queue_work(struct netdev_event_work_cmd *cmds,
> >>>>  				struct net_device *ndev)
> >>>>  {
> >>>> -	unsigned int i;
> >>>>  	struct netdev_event_work *ndev_work =
> >>>>  		kmalloc(sizeof(*ndev_work), GFP_KERNEL);
> >>>> +	struct net_device *real_dev;
> >>>> +	unsigned int i;
> >>>>  
> >>>>  	if (!ndev_work)
> >>>>  		return NOTIFY_DONE;
> >>>> @@ -653,6 +661,12 @@ static int netdevice_queue_work(struct netdev_event_work_cmd *cmds,
> >>>>  			ndev_work->cmds[i].filter_ndev = ndev;
> >>>>  		dev_hold(ndev_work->cmds[i].ndev);
> >>>>  		dev_hold(ndev_work->cmds[i].filter_ndev);
> >>>> +		real_dev = rdma_vlan_dev_real_dev(ndev_work->cmds[i].ndev);
> >>>> +		if (real_dev)
> >>>> +			dev_hold(real_dev);
> >>>> +		real_dev = rdma_vlan_dev_real_dev(ndev_work->cmds[i].filter_ndev);
> >>>> +		if (real_dev)
> >>>> +			dev_hold(real_dev);
> >>>>  	}
> >>>>  	INIT_WORK(&ndev_work->work, netdevice_event_work_handler);
> >>>
> >>> Probably, this is the right change, but I don't know well enough that
> >>> part of code. What prevents from "real_dev" to disappear right after
> >>> your call to rdma_vlan_dev_real_dev()?
> >>>
> >>
> >> It is known that free the net_device until its dev_refcnt is one. The
> >> detail realization see netdev_run_todo().The real_dev's dev_refcnt of
> >> a vlan net_device will reach one after unregister_netdevice(&real_dev)
> >> and unregister_vlan_dev(&vlan_ndev, ...) but the dev_refcnt of the vlan
> >> net_device is bigger than one because netdevice_queue_work() will hold
> >> the vlan net_device. So my solution is hold the real_dev too in
> >> netdevice_queue_work().
> > 
> >               dev_hold(ndev_work->cmds[i].filter_ndev);
> >  +            real_dev = rdma_vlan_dev_real_dev(ndev_work->cmds[i].ndev);
> >  +            if (real_dev)
> >                   <------------ real_dev is released here.
> >  +                    dev_hold(real_dev);
> 
> At first, I thought the real_dev's dev_refcnt is bigger than one before
> NETDEV_UNREGISTER notifier event of the vlan net_device because it calls
> dev_put(real_dev) after calling unregister_netdevice_queue(dev, head).
> I thought unregister_netdevice_queue() would issue NETDEV_UNREGISTER
> notifier event of the vlan net_device, I can hold the real_dev in
> NETDEV_UNREGISTER notifier event handler netdevice_queue_work().
> 
> But I read unregister_vlan_dev() again, found unregister_netdevice_queue()
> in unregister_vlan_dev() just move the vlan net_device to a list to unregister
> later. So it is possible the real_dev has been freed when we access in
> netdevice_queue_work() although the probability is very small.
> 
> So the modification need to improve. For example set vlan->real_dev = NULL
> after dev_put(real_dev) in unregister_vlan_dev() proposed by Jason Gunthorpe.
> 
> Do you have any other good ideas?

It is hard to tell, such implementation existed almost from day one.

Thanks

> 
> Thank you!
