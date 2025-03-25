Return-Path: <linux-rdma+bounces-8941-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3226BA70586
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Mar 2025 16:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48A821676F2
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Mar 2025 15:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2E41F5831;
	Tue, 25 Mar 2025 15:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="B1EUe96C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OeGvcpRN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1362E3382;
	Tue, 25 Mar 2025 15:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742917755; cv=none; b=Uf5SUGZyo/B2nY8z8Lexy9TL0+p5MTems3CXRkKnOX4v6xeazBHFJJlUZTVm5X+0K5cRvDOGp8KFwtRtjctmIOj2mhu1Co1OSVRS9sQ82zNgxsFRNNntICA1h0mS0toXQb/6oqr+mC/1PPgc6opqVkoCmRjuTCQf1d5SSLu0yxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742917755; c=relaxed/simple;
	bh=yPqfrHntLIRVCEG+VhyCTJVAV38OoTiAqXSlcQ85F1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F9kxDecqyKxky1PuR4vd7In+80Q4tC3ZsNcYe4+8HBQOzhtxFHKNIXGNmvia6QZVL/VJLhsioHnVzw1ELusUIHV/H4Gx9eaLW7DuA1BGPirNsoWsZD6CE5MqYwRlGAqz0Q1DQ5MFPEqF06nHCQWe2D53H1jpnoNf7lpFmpJq1+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=B1EUe96C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OeGvcpRN; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8C54911401D2;
	Tue, 25 Mar 2025 11:49:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 25 Mar 2025 11:49:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1742917750; x=
	1743004150; bh=7oaEgXzXWy2DXPB9JL+lbhfLUTu+dVMvk+b8u+aYYjk=; b=B
	1EUe96CKPou7f5/64B1qeU3hsGVqI9k3tAvh8qgZbIK/Xm7q6GZFg12kVF4i4UrT
	1nJ0Knl75LqMoDmDq4b+vOkqR1xsl36rF0MsHxUDnl4dQiFnv0TDNcqvXZ4Ogoh/
	M/0VZbo2aHERWZyCWzUQ4w97Z6jiEe/5glKfAJHWlpyhH7l6c3YlLJk4lSzDVKhN
	OZphZaFNYz7ynL7fPpmEVcMA32boQvqbx3ZcYgJ1UF2fDh5vmFJ2XeauGRVbk884
	4B/ZbHuR4791FnC2EBWqGlcTJtc7vy9gmTYPPauOBe9x+h+d1wPlpXsvvlZpryPR
	9s3b7ZpPVNGkX4V8n0O2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1742917750; x=1743004150; bh=7oaEgXzXWy2DXPB9JL+lbhfLUTu+dVMvk+b
	8u+aYYjk=; b=OeGvcpRNaGXX+6jp/wnQySe6yrgKnNh1NqRm68xDhdKmBGgnhSH
	ybYKDaLHuBgiO67poyqzsL0f9Fsvxuq4HUEG+vbiDpCD2wuL0KzOE3nnD7LCsf+W
	syV8z+46gRdYNIR5YgPBhgXn2An3dyQXGZTBmJ6C+4pt4z5AsVAEHVs2AoqD2ylU
	H3ADXjwg6wzKOFZytg6gOoQaevVQqJ7wCkHV/ND+g796ZR48UVVS7CwXlO2jdg+R
	bMhI5rorahVpQdxFErzd4Y0VJwNs2MWVu7jyhtrmODG88OMvlpftg913+ehb2z9l
	9m3LBTedoLFv9vuKzjRaX4jlfja67OeQmxg==
X-ME-Sender: <xms:dtDiZ_EcQ3Rst-euNabjWbnb9qMPf8y4-gg5oGCZ-5S8FCiSqa4rCA>
    <xme:dtDiZ8X0tcAFdbcbl2qXAuemgaFsMqv09VoKI3ujGFrC4Ai3UNuxkTDejO6q7pJFV
    sLimbYQ4I4tL_4Ma9s>
X-ME-Received: <xmr:dtDiZxKOXvoUqU1r8zfMolMozQi_q-zs14E5pa1lbMfpNyhSCzYDoAu1s9i4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieeftdehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:dtDiZ9EVYmf48OnfthAIx8Rnw-9_fd9J9QKJUSHsTzqljnInug6NtQ>
    <xmx:dtDiZ1XUTLt2PngyKQ-EY_GAhm1ITZ7FpwfGqrGVchLBKXD4VOr16w>
    <xmx:dtDiZ4NivbvA8B-rwp8x4TO2lSaRF9QoU_kD86p-Nx8_AIk1J3vQDg>
    <xmx:dtDiZ001hvPiuliaEKn2Wpe1XDRzNDeMHstHvZM2y9-QYtG4yOE3cA>
    <xmx:dtDiZ6V7aQGi0k3Qc1VGZTcahtdNs3Tz_GoBm98THeQr-ywrwLVvE18y>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Mar 2025 11:49:09 -0400 (EDT)
Date: Tue, 25 Mar 2025 16:49:07 +0100
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
Subject: Re: [PATCH v2 net] rtnetlink: Allocate vfinfo size for VF GUIDs when
 supported
Message-ID: <Z-LQcyC8DU7Wny-d@krikkit>
References: <20250325090226.749730-1-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250325090226.749730-1-mbloch@nvidia.com>

2025-03-25, 11:02:26 +0200, Mark Bloch wrote:
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
> 
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
[...]
>  ---[ end trace 0000000000000000 ]---
> 
> Thus, when calculating ifinfo message size, take VF GUIDs sizes into
> account when supported.
> 
> Fixes: 30aad41721e0 ("net/core: Add support for getting VF GUIDs")
> Signed-off-by: Mark Zhang <markzhang@nvidia.com>
> Reviewed-by: Maher Sanalla <msanalla@nvidia.com>
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

