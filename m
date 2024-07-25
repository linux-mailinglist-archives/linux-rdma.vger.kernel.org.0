Return-Path: <linux-rdma+bounces-3981-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9013793C289
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2024 14:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3FFC1C20ACF
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2024 12:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DF119AD6E;
	Thu, 25 Jul 2024 12:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eEI6C95v"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACF119AD6C
	for <linux-rdma@vger.kernel.org>; Thu, 25 Jul 2024 12:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721912235; cv=none; b=kjqiozhBVm4s+QGXfFsFeA9Chojaz6Ronch3dUSqoa/nwN2cLe4UfQBYmHxdBEvvupF7rc1hve7Ah79q2hz1QrPEeA+bwJDL6slZ0f5w7AgcQvnkBIdx1CYMcBFp/ygqoG48JhmvQrLsX83IxUhirQSYsQEMCwaUEZRzfmSpjpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721912235; c=relaxed/simple;
	bh=NWVS0sh4vpStyFvKsoWQrgccVozcEaJHs/9WDhgDGWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WDoxjoYG0uyuZL3s/ylhgr+Z+j0h09mvvw0zzDBn5AZ0W4r269R3zCTwG2NjKLlMf0D1okRbHQr0SlQOAoCM4Uq5b2llTgyfMDwO0Bpr0wsL10qKOhgng64vNiRbVhjSa5Eb+CQwDFATs5Rxszv1Yk3OVt0ZTkDthqzxt7BGDXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eEI6C95v; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <17ba17f3-635f-41fe-bc5c-ab15f590c41e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721912226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PM7wsyh147ArD6p8TXkouqyJAfAdjLvDBo+c/og17WQ=;
	b=eEI6C95v1tpK8OdLgdsOQW7j4ejeguoMuqyj0dC+5++oBnj6Am4EWpHQnhDUJGuIOkF8aH
	gp+OjkDJcfDVkmrarK/JzO5WginYmQgUmVtSnkTU1Tf+2hQqAsovlSy3On9AvV9b97f5id
	PXIMGYHoh3Mhn9vNK0zuT11WEpCgBXM=
Date: Thu, 25 Jul 2024 14:57:00 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-rc] RDMA/siw: Remove NETDEV_GOING_DOWN event handler
To: Showrya M N <showrya@chelsio.com>, jgg@nvidia.com, leonro@nvidia.com,
 bmt@zurich.ibm.com
Cc: linux-rdma@vger.kernel.org, Potnuri Bharat Teja <bharat@chelsio.com>
References: <20240724085428.3813-1-showrya@chelsio.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20240724085428.3813-1-showrya@chelsio.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/7/24 10:54, Showrya M N 写道:
> Toggling link while running NVME-oF over siw hits a kernel panic
> due to race condition within siw_handler and ib_destroy_qp().
> The IB_EVENT_PORT_ERR event can alone handle destroying qps.
> therefore remove unwanted processing in siw.

In the link:
https://lore.kernel.org/all/000000000000fe34b1061e0ffa36@google.com/T/

The Call Trace is as below. Not sure if this call trace is the same with 
this commit.

Call Trace:
  <TASK>
  __debug_object_init+0x2a9/0x400 lib/debugobjects.c:654
  siw_device_goes_down drivers/infiniband/sw/siw/siw_main.c:395 [inline]
  siw_netdev_event+0x3bd/0x620 drivers/infiniband/sw/siw/siw_main.c:422
  notifier_call_chain+0x19f/0x3e0 kernel/notifier.c:93
  call_netdevice_notifiers_extack net/core/dev.c:2032 [inline]
  call_netdevice_notifiers net/core/dev.c:2046 [inline]
  __dev_close_many+0x146/0x300 net/core/dev.c:1532
  __dev_close net/core/dev.c:1570 [inline]
  __dev_change_flags+0x30e/0x6f0 net/core/dev.c:8835
  dev_change_flags+0x8b/0x1a0 net/core/dev.c:8909
  do_setlink+0xccd/0x41f0 net/core/rtnetlink.c:2900
  rtnl_setlink+0x40d/0x5a0 net/core/rtnetlink.c:3201
  rtnetlink_rcv_msg+0x73f/0xcf0 net/core/rtnetlink.c:6647
  netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
  netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
  netlink_unicast+0x7f0/0x990 net/netlink/af_netlink.c:1357
  netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
  sock_sendmsg_nosec net/socket.c:730 [inline]
  __sock_sendmsg+0x221/0x270 net/socket.c:745
  sock_write_iter+0x2dd/0x400 net/socket.c:1160
  do_iter_readv_writev+0x60a/0x890
  vfs_writev+0x37c/0xbb0 fs/read_write.c:971
  do_writev+0x1b1/0x350 fs/read_write.c:1018
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
  entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fda35175f19
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 
f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 
f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fda35fff048 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00007fda35305f60 RCX: 00007fda35175f19
RDX: 0000000000000001 RSI: 00000000200003c0 RDI: 0000000000000006
RBP: 00007fda351e4e68 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fda35305f60 R15: 00007ffc0c742898
  </TASK>

Zhu Yanjun

> 
> Suggested-by: Bernard Metzler <bmt@zurich.ibm.com>
> Signed-off-by: Showrya M N <showrya@chelsio.com>
> Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
> ---
>   drivers/infiniband/sw/siw/siw.h      |  2 --
>   drivers/infiniband/sw/siw/siw_main.c | 37 ----------------------------
>   2 files changed, 39 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
> index 75253f2b3e3d..86d4d6a2170e 100644
> --- a/drivers/infiniband/sw/siw/siw.h
> +++ b/drivers/infiniband/sw/siw/siw.h
> @@ -94,8 +94,6 @@ struct siw_device {
>   	atomic_t num_mr;
>   	atomic_t num_srq;
>   	atomic_t num_ctx;
> -
> -	struct work_struct netdev_down;
>   };
>   
>   struct siw_ucontext {
> diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
> index 61ad8ca3d1a2..9a50a9dcce39 100644
> --- a/drivers/infiniband/sw/siw/siw_main.c
> +++ b/drivers/infiniband/sw/siw/siw_main.c
> @@ -364,39 +364,6 @@ static struct siw_device *siw_device_create(struct net_device *netdev)
>   	return NULL;
>   }
>   
> -/*
> - * Network link becomes unavailable. Mark all
> - * affected QP's accordingly.
> - */
> -static void siw_netdev_down(struct work_struct *work)
> -{
> -	struct siw_device *sdev =
> -		container_of(work, struct siw_device, netdev_down);
> -
> -	struct siw_qp_attrs qp_attrs;
> -	struct list_head *pos, *tmp;
> -
> -	memset(&qp_attrs, 0, sizeof(qp_attrs));
> -	qp_attrs.state = SIW_QP_STATE_ERROR;
> -
> -	list_for_each_safe(pos, tmp, &sdev->qp_list) {
> -		struct siw_qp *qp = list_entry(pos, struct siw_qp, devq);
> -
> -		down_write(&qp->state_lock);
> -		WARN_ON(siw_qp_modify(qp, &qp_attrs, SIW_QP_ATTR_STATE));
> -		up_write(&qp->state_lock);
> -	}
> -	ib_device_put(&sdev->base_dev);
> -}
> -
> -static void siw_device_goes_down(struct siw_device *sdev)
> -{
> -	if (ib_device_try_get(&sdev->base_dev)) {
> -		INIT_WORK(&sdev->netdev_down, siw_netdev_down);
> -		schedule_work(&sdev->netdev_down);
> -	}
> -}
> -
>   static int siw_netdev_event(struct notifier_block *nb, unsigned long event,
>   			    void *arg)
>   {
> @@ -418,10 +385,6 @@ static int siw_netdev_event(struct notifier_block *nb, unsigned long event,
>   		siw_port_event(sdev, 1, IB_EVENT_PORT_ACTIVE);
>   		break;
>   
> -	case NETDEV_GOING_DOWN:
> -		siw_device_goes_down(sdev);
> -		break;
> -
>   	case NETDEV_DOWN:
>   		sdev->state = IB_PORT_DOWN;
>   		siw_port_event(sdev, 1, IB_EVENT_PORT_ERR);


