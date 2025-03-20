Return-Path: <linux-rdma+bounces-8873-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A947A6A9B1
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Mar 2025 16:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51EA618820E5
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Mar 2025 15:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F181EB1BB;
	Thu, 20 Mar 2025 15:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="auvP1+io";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YJLxRiH0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB783158DAC;
	Thu, 20 Mar 2025 15:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742484177; cv=none; b=pZrbaDvNS91jbHT9DNN2Z4nYajtdbWMXokiXxTQ8ikyHVB66pPUL/lezrecmr09VsVGk6blRmyQ68nOs/GXXyVQn/y4c8nPWj++N5NmtF2n6T1SoxXyDxa4SEom8etpnjN5ZdusGd/QKYL/e03IaMajko4oLepe0VxuAUFZgHdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742484177; c=relaxed/simple;
	bh=usqPczUWqAeUvF8y2TUUqp9JaaDMbCssooMMouP13fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sS+U5/fo4EEFDafLADNAH5SY2BuoNYh6cdR4L6dJs6IDooOKfVBkNPAVdBi73YDwYlMPw2858Ndvizfw/HjfPcuKkljKnmIlQt6RkVYsOskXR0lsyJhqqYhdOtr6Hlq+Elhv0U+RCRAksR8oe0npmSQ8EXil7JCZDGZUmrI4Jcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=auvP1+io; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YJLxRiH0; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 9B6D81383586;
	Thu, 20 Mar 2025 11:22:53 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 20 Mar 2025 11:22:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1742484173; x=
	1742570573; bh=0KAhEWkVsl0NNYwVCjx4tb9wuCsNpgOLyHLfIJZaooQ=; b=a
	uvP1+ioPRrUL5kIUpiPHMAxA0f9GfoqDYLA1skSnGtZLZv2Df+OgIN7BfHoy7Gp0
	KiFAMpBl+3YAHU9Y/p4vmx/o4Sbnzkd40xpldT0DppaIlMztrEMDS+0xO08I3yRX
	eUm2BOJTKpGPGN4rDX+KTWGHHTwT4v7OPDENmO5xmbDD2FImqKLZ9JZHgdg367gU
	Ml5HwgzCRebBIZSTVbyiTM+huvtxqdv2WNLqq8j5264j0xxnykzDsCgYqxt4LZEZ
	TrkIon/943IAzgwCJ2KLq9EA5ONADVI0FQG0XTmHYNbPT77534dtg/afcUfSS9m6
	d1NBFkFxg/SkOimUh5zUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742484173; x=1742570573; bh=0KAhEWkVsl0NNYwVCjx4tb9wuCsNpgOLyHL
	fIJZaooQ=; b=YJLxRiH0wamVaogDcklYvcE38boSL647501/bB8sWWCoLRXNGTc
	Dgyu6LxPqRuT+0UaQBhZvNkkkczeS4iuYk3AKfa84ZYEbODjkTm6CzbpgkecVg7W
	MYFCe5Tv367rCiNOzmOSo1QqgggMx6apf5XpF7WjkwlGcftOcu5K5nAXYEDxRWQ9
	sLZSEifhCMwtP+MlN7O32vLDEgQSiyff7q0zOfvBZWHwIgUon3jGDvbtwZElxtX8
	bV8tzxdW2AYko3xmkk1hYC5z2ebxzsvAClftwNUl/tpUm6NCi6IAXb68AfbE9x8b
	jVH9WQkQUVWUEww30n/rhaq9utGSEBSDJlQ==
X-ME-Sender: <xms:zTLcZ45o82NpMk3GWJ3OSlTkdhOwYfTTyRVCwpO2YKZI8xOi8MEcAw>
    <xme:zTLcZ540cQ31-XEi6DH5M453iPc8qthh8S8zfGy8MPs6Wyapsj9Nr_K5ZcuXnIGo1
    rx3MhgrOZ_6RQjOdfE>
X-ME-Received: <xmr:zTLcZ3ezgeuLGacO9zGqn6IeL_8YLa0v8rRXto64SnygmdP6XpDOKwMNgiWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeekheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    jeenucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshihsh
    hnrghilhdrnhgvtheqnecuggftrfgrthhtvghrnheptddtgedufedvtefftddtleehteef
    ieffgeetueeliefhfeegleffvddtvdefiedvnecuffhomhgrihhnpehqvghmuhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsuges
    qhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepudefpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehmsghlohgthhesnhhvihguihgrrdgtohhmpdhrtghp
    thhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumh
    griigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoh
    ephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhunhhihihusegrmhgr
    iihonhdrtghomhdprhgtphhtthhopehlvghonheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepughsrghhvghrnheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:zTLcZ9K_DbZDPmeMuOe6QuWxr2JByyNfLGp9LM2imT8x3jFA_FNJIA>
    <xmx:zTLcZ8IcDQwsow2oRjSAqudUCyOa1AgrN__olXCnGF-FNzCNdfBsuQ>
    <xmx:zTLcZ-wmKikH3su011YyUna3z1azQb_n3urrskkS-5dddJy6WsCqsA>
    <xmx:zTLcZwIsGGLMI_tbcH7qiBenDlAjgNo_ZxOBxnG7zWKVbZObSXtIjg>
    <xmx:zTLcZ_aKQhXnz9vDbMbn2Ib_46AfkUSmfq3U_K_WcFb23vQwMT1DjUTI>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Mar 2025 11:22:52 -0400 (EDT)
Date: Thu, 20 Mar 2025 16:22:50 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Mark Bloch <mbloch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Leon Romanovsky <leon@kernel.org>, David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	Mark Zhang <markzhang@nvidia.com>,
	Maher Sanalla <msanalla@nvidia.com>
Subject: Re: [PATCH net] rtnetlink: Allocate vfinfo size for VF GUIDs when
 supported
Message-ID: <Z9wyyqTSPOiekIbX@krikkit>
References: <20250317102419.573846-1-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250317102419.573846-1-mbloch@nvidia.com>

2025-03-17, 12:24:19 +0200, Mark Bloch wrote:
> From: Mark Zhang <markzhang@nvidia.com>
> 
> Commit 30aad41721e0 ("net/core: Add support for getting VF GUIDs")
> added support for getting VF port and node GUIDs in netlink ifinfo
> messages, but their size was not taken into consideration in the
> function that allocates the netlink message, causing the following
> warning when a netlink message is filled with many VF port and node
> GUIDs:
>  # echo 64 > /sys/bus/pci/devices/0000\:08\:00.0/sriov_numvfs
>  # ip link show dev ib0
>  RTNETLINK answers: Message too long
>  Cannot send link get request: Message too long
> 
> Kernel warning:

nit: that trace could be trimmed a bit while still keeping all the
relevant information to explain the problem

>  ------------[ cut here ]------------
>  WARNING: CPU: 2 PID: 1930 at net/core/rtnetlink.c:4151 rtnl_getlink+0x586/0x5a0
>  Modules linked in: xt_conntrack xt_MASQUERADE nfnetlink xt_addrtype iptable_nat nf_nat br_netfilter overlay mlx5_ib macsec mlx5_core tls rpcrdma rdma_ucm ib_uverbs ib_iser libiscsi scsi_transport_iscsi ib_umad rdma_cm iw_cm ib_ipoib fuse ib_cm ib_core
>  CPU: 2 UID: 0 PID: 1930 Comm: ip Not tainted 6.14.0-rc2+ #1
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
>  RIP: 0010:rtnl_getlink+0x586/0x5a0
>  Code: cb 82 e8 3d af 0a 00 4d 85 ff 0f 84 08 ff ff ff 4c 89 ff 41 be ea ff ff ff e8 66 63 5b ff 49 c7 07 80 4f cb 82 e9 36 fc ff ff <0f> 0b e9 16 fe ff ff e8 de a0 56 00 66 66 2e 0f 1f 84 00 00 00 00
>  RSP: 0018:ffff888113557348 EFLAGS: 00010246
>  RAX: 00000000ffffffa6 RBX: ffff88817e87aa34 RCX: dffffc0000000000
>  RDX: 0000000000000003 RSI: 0000000000000000 RDI: ffff88817e87afb8
>  RBP: 0000000000000009 R08: ffffffff821f44aa R09: 0000000000000000
>  R10: ffff8881260f79a8 R11: ffff88817e87af00 R12: ffff88817e87aa00
>  R13: ffffffff8563d300 R14: 00000000ffffffa6 R15: 00000000ffffffff
>  FS:  00007f63a5dbf280(0000) GS:ffff88881ee00000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 00007f63a5ba4493 CR3: 00000001700fe002 CR4: 0000000000772eb0
>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>  PKRU: 55555554
>  Call Trace:
>   <TASK>
>   ? __warn+0xa5/0x230
>   ? rtnl_getlink+0x586/0x5a0
>   ? report_bug+0x22d/0x240
>   ? handle_bug+0x53/0xa0
>   ? exc_invalid_op+0x14/0x50
>   ? asm_exc_invalid_op+0x16/0x20
>   ? skb_trim+0x6a/0x80
>   ? rtnl_getlink+0x586/0x5a0
>   ? __pfx_rtnl_getlink+0x10/0x10
>   ? rtnetlink_rcv_msg+0x1e5/0x860
>   ? __pfx___mutex_lock+0x10/0x10
>   ? rcu_is_watching+0x34/0x60
>   ? __pfx_lock_acquire+0x10/0x10
>   ? stack_trace_save+0x90/0xd0
>   ? filter_irq_stacks+0x1d/0x70
>   ? kasan_save_stack+0x30/0x40
>   ? kasan_save_stack+0x20/0x40
>   ? kasan_save_track+0x10/0x30
>   rtnetlink_rcv_msg+0x21c/0x860
>   ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
>   ? __pfx_rtnetlink_rcv_msg+0x10/0x10
>   ? arch_stack_walk+0x9e/0xf0
>   ? rcu_is_watching+0x34/0x60
>   ? lock_acquire+0xd5/0x410
>   ? rcu_is_watching+0x34/0x60
>   netlink_rcv_skb+0xe0/0x210
[...]
> 
> Thus, when calculating ifinfo message size, take VF GUIDs sizes into
> account when supported.
> 
> Fixes: 30aad41721e0 ("net/core: Add support for getting VF GUIDs")
> Signed-off-by: Mark Zhang <markzhang@nvidia.com>
> Reviewed-by: Maher Sanalla <msanalla@nvidia.com>
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>

Either way, the patch looks good to me.

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

