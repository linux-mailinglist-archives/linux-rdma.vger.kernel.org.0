Return-Path: <linux-rdma+bounces-8658-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4638A5F4BB
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 13:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A4193AC70B
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 12:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADF32673B6;
	Thu, 13 Mar 2025 12:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lzv0bNca"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1AA6EB7C;
	Thu, 13 Mar 2025 12:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741869749; cv=none; b=J36BFBr5dnHToS+MzThCiiSgSjRpkfAFH8fwQaMa4blq3coslYSwt28HBMdUBbix/oGK4hjWKpmGIfGRdSNKwR3/AX1te8AsHMv00qdnA06kYl0WIpwAcaW6iPgq0RtWB27a4vWzNGhLtRBwae116g3bj8xlo1CB+G9GWV6zils=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741869749; c=relaxed/simple;
	bh=PfGtIWhreLV0ipjwCVf4LyeaYgTYH5sQAFgjnOmN+Zw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=upywk636Agr10V3zH/o1wIIL+AI8A2AA4AlPxNZzx3xXv7Ko36UN2Z7rkdB1D0LtpQZKbyT4fqNoZIX09MYaUUoeEb4PfWkcsYgfrVbxRCF0zAYYecmXh/qy9N4WzcvJLqZ70PAorueZm1Kxdc3QEbs9vaWGTIaP44P76Xug53c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lzv0bNca; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE9BBC4CEDD;
	Thu, 13 Mar 2025 12:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741869749;
	bh=PfGtIWhreLV0ipjwCVf4LyeaYgTYH5sQAFgjnOmN+Zw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Lzv0bNcan0dcY97xrw/j7MEeByPMxnFMOw2ZcvWQ3M3IlYQx5Zav2/cAuqj57cpLy
	 mwKUvwylO2KYDMfHRtjNJA/oU0dQ9cSzJ5IMQiafprfcAJh9MFXzI2DXUeFjQts+Aq
	 TOmyghsJsiXdW/ZkIMVXYEhmeAeXCBJLriOa6xnb56teYX9GiA+PM9Ldsh/Yn8jVc0
	 7OSMZP/AmcuSlnSYv9LYefY/N2g0Jsj8ticUXmqY3AEXj4PO+r3sjv09fpeq/TG4x2
	 1K66mwEHAXhFhtq7wzYbvRhISP343KYFbxMOnaxVBruRJ4qcwGi1YhWx2EhMPxQIbS
	 qHeB/Ps4NjJYQ==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, cmeiohas@nvidia.com, michaelgur@nvidia.com, 
 huangjunxian6@hisilicon.com, liyuyu6@huawei.com, markzhang@nvidia.com, 
 linux@treblig.org, jbi.octave@gmail.com, dsahern@kernel.org, 
 Wang Liang <wangliang74@huawei.com>
Cc: yuehaibing@huawei.com, zhangchangzhong@huawei.com, 
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250313092421.944658-1-wangliang74@huawei.com>
References: <20250313092421.944658-1-wangliang74@huawei.com>
Subject: Re: [PATCH net v2] infiniband: fix use-after-free when rename
 device name
Message-Id: <174186974628.624946.14807525282579098223.b4-ty@kernel.org>
Date: Thu, 13 Mar 2025 08:42:26 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Thu, 13 Mar 2025 17:24:21 +0800, Wang Liang wrote:
> Syzbot reported a slab-use-after-free with the following call trace:
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in nla_put+0xd3/0x150 lib/nlattr.c:1099
> Read of size 5 at addr ffff888140ea1c60 by task syz.0.988/10025
> 
> CPU: 0 UID: 0 PID: 10025 Comm: syz.0.988
> Not tainted 6.14.0-rc4-syzkaller-00859-gf77f12010f67 #0
> Hardware name: Google Compute Engine, BIOS Google 02/12/2025
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:408 [inline]
>  print_report+0x16e/0x5b0 mm/kasan/report.c:521
>  kasan_report+0x143/0x180 mm/kasan/report.c:634
>  kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
>  __asan_memcpy+0x29/0x70 mm/kasan/shadow.c:105
>  nla_put+0xd3/0x150 lib/nlattr.c:1099
>  nla_put_string include/net/netlink.h:1621 [inline]
>  fill_nldev_handle+0x16e/0x200 drivers/infiniband/core/nldev.c:265
>  rdma_nl_notify_event+0x561/0xef0 drivers/infiniband/core/nldev.c:2857
>  ib_device_notify_register+0x22/0x230 drivers/infiniband/core/device.c:1344
>  ib_register_device+0x1292/0x1460 drivers/infiniband/core/device.c:1460
>  rxe_register_device+0x233/0x350 drivers/infiniband/sw/rxe/rxe_verbs.c:1540
>  rxe_net_add+0x74/0xf0 drivers/infiniband/sw/rxe/rxe_net.c:550
>  rxe_newlink+0xde/0x1a0 drivers/infiniband/sw/rxe/rxe.c:212
>  nldev_newlink+0x5ea/0x680 drivers/infiniband/core/nldev.c:1795
>  rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
>  rdma_nl_rcv+0x6dd/0x9e0 drivers/infiniband/core/netlink.c:259
>  netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
>  netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1339
>  netlink_sendmsg+0x8de/0xcb0 net/netlink/af_netlink.c:1883
>  sock_sendmsg_nosec net/socket.c:709 [inline]
>  __sock_sendmsg+0x221/0x270 net/socket.c:724
>  ____sys_sendmsg+0x53a/0x860 net/socket.c:2564
>  ___sys_sendmsg net/socket.c:2618 [inline]
>  __sys_sendmsg+0x269/0x350 net/socket.c:2650
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f42d1b8d169
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 ...
> RSP: 002b:00007f42d2960038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007f42d1da6320 RCX: 00007f42d1b8d169
> RDX: 0000000000000000 RSI: 00004000000002c0 RDI: 000000000000000c
> RBP: 00007f42d1c0e2a0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007f42d1da6320 R15: 00007ffe399344a8
>  </TASK>
> 
> [...]

Applied, thanks!

[1/1] infiniband: fix use-after-free when rename device name
      https://git.kernel.org/rdma/rdma/c/40731619b3e706

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


