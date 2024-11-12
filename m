Return-Path: <linux-rdma+bounces-5936-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D02CB9C5220
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Nov 2024 10:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 612A81F21E85
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Nov 2024 09:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174AE20E31C;
	Tue, 12 Nov 2024 09:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iASbMsgM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0694220D4E7
	for <linux-rdma@vger.kernel.org>; Tue, 12 Nov 2024 09:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731404042; cv=none; b=hYiv9fRc4AEzVLoi5vUOMvwBlG4TWpvg51XuCoaQ8GsHfCgwg64mE2jQG3Va8jmhCxKZ3fxu/9VT/xfdQuY9Wun87BkwU8rksn48Z2eMbuuUzo8iD9aKKizADry9szmFvkpcoh1ciHYMzjMfEZUFLEnHnPsSzgJFKa6ZhFSXU7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731404042; c=relaxed/simple;
	bh=qWeE+wnw8x7rkV1nwK1BycFxtKPZ58oORnJs2Eo8O9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uwrsk1n1ffwYx9JqiO+qECLri0KVaaH4LkKomspDdYnwdOAADyRokW0bRRk7/HQX01V8TGfYA4PLeLYYSJKiHuT8Kply7usu/0DrKxmfytOsaLbMQM66326dDhQstfR8uChhzrScPBzCnqEGI7ypcbpq1HRjzQYYylYdnq1b04E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iASbMsgM; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e2eb9dde40so4391212a91.0
        for <linux-rdma@vger.kernel.org>; Tue, 12 Nov 2024 01:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731404040; x=1732008840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZgCdEoSrFMEDqPsR6GojTZkOgi2KLxpzsUq1eOtaUc=;
        b=iASbMsgMnMrEWXh3YieWqMWBcWBSUqB1iHAejohSG0dmoeIAPoeX33lRDX9qbCXoCi
         L0MVwHisqgDnb2Ns+YYolJaPEIclxoavauUgBpB+GljcF6JokXxXYtWj9NFc1shrevd8
         B6RwenY+HEkVnLJicQxBED3uu9gpRTJMLb0oOMeuTdJAdFB2WUWX3ecBckLSVTYhcTKx
         F0yBI+LpARkDr3Pg1y30VLDrtaqYnZzJ1WFGbwzdT0fPjYz6DqriXALxB665MaGP9eTe
         Yrf4ijX7ke1wssYLW0rHiPXlKvD+M8fQ7XArlpvqvy0szKJrXKik3r7Ce+CLw6wQo2+m
         T0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731404040; x=1732008840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ZgCdEoSrFMEDqPsR6GojTZkOgi2KLxpzsUq1eOtaUc=;
        b=v9EgewodWndzHglRpOMUYC3lLrQogZg2VY52sri+h66xC6JioYpY4xbJbH16WSiQMV
         MMqsT68PQ99XGe8yJvH29cn0PWpc0S9d2JMC50iJpSE3IXxsKyPy3H1OmMt3Oj5e19Y5
         qn5MN3i3BCpMJ7GF4K030+uRZJW94V/kFlEeUgosQVdagmj7yzaTE6bzhDFtvuSO7WqO
         g1iLykdXTYKavWWLahPGKxGvB3L3L+H1McTScc7RkAEaYN1RpzZQYH/r30nPf71cRNgn
         qLoWCKxSMlSJVgaUEUM4UrxI8oWb90yibK5bXVubfHnFAVEOaPPFNbNiLt4h/wPsAEND
         8opQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJNekXhHKneWCxmfbE7avDoi8w9ar8lVubYZLhhZIBQbjH5fNPTSUjsAeYGhnlJhJV5p0fIm1o8k3g@vger.kernel.org
X-Gm-Message-State: AOJu0YzrMRmvedCS2wKKnaNLaIMUfI8lQhLVuZVAMzRJLxxRSij4ZE/+
	RBCpxR3pZNGbPXMqzvFecwZoyHXiOe2+ms/QKU9J/I2awNHmKppO
X-Google-Smtp-Source: AGHT+IHif1ftZ8LeVpPjW4RLaG5QlYr4UmGg81j7uXOG3AiNgqGvCjsD+y/Q7rWUIRjqr02y5l8vGQ==
X-Received: by 2002:a17:90b:1d88:b0:2e0:d1fa:fdd7 with SMTP id 98e67ed59e1d1-2e9b172af9cmr20331174a91.27.1731404039970;
        Tue, 12 Nov 2024 01:33:59 -0800 (PST)
Received: from 10-20-1-10.. ([58.34.148.69])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5fd3f0dsm10086750a91.34.2024.11.12.01.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 01:33:59 -0800 (PST)
From: Cyclinder Kuo <kuocyclinder@gmail.com>
To: rpearsonhpe@gmail.com
Cc: jgg@ziepe.ca,
	lehrer@gmail.com,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	parav@nvidia.com,
	yanjun.zhu@intel.com,
	yanjun.zhu@linux.dev,
	zyjzyj2000@gmail.com
Subject: Re: [PATCH v6.4-rc1 v5 0/8] Fix the problem that rxe can not work in net namespace
Date: Tue, 12 Nov 2024 17:33:55 +0800
Message-Id: <20241112093355.2534407-1-kuocyclinder@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <4f097d4a-85f5-392f-53bb-85ca0d75e16f@gmail.com>
References: <4f097d4a-85f5-392f-53bb-85ca0d75e16f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> > From: Zhu Yanjun <yanjun.zhu@linux.dev>
> > 
> > When run "ip link add" command to add a rxe rdma link in a net
> > namespace, normally this rxe rdma link can not work in a net
> > name space.
> > 
> > The root cause is that a sock listening on udp port 4791 is created
> > in init_net when the rdma_rxe module is loaded into kernel. That is,
> > the sock listening on udp port 4791 is created in init_net. Other net
> > namespace is difficult to use this sock.
> > 
> > The following commits will solve this problem.
> > 
> > In the first commit, move the creating sock listening on udp port 4791
> > from module_init function to rdma link creating functions. That is,
> > after the module rdma_rxe is loaded, the sock will not be created.
> > When run "rdma link add ..." command, the sock will be created. So
> > when creating a rdma link in the net namespace, the sock will be
> > created in this net namespace.
> > 
> > In the second commit, the functions udp4_lib_lookup and udp6_lib_lookup
> > will check the sock exists in the net namespace or not. If yes, rdma
> > link will increase the reference count of this sock, then continue other
> > jobs instead of creating a new sock to listen on udp port 4791. Since the
> > network notifier is global, when the module rdma_rxe is loaded, this
> > notifier will be registered.
> > 
> > After the rdma link is created, the command "rdma link del" is to
> > delete rdma link at the same time the sock is checked. If the reference
> > count of this sock is greater than the sock reference count needed by
> > udp tunnel, the sock reference count is decreased by one. If equal, it
> > indicates that this rdma link is the last one. As such, the udp tunnel
> > is shut down and the sock is closed. The above work should be
> > implemented in linkdel function. But currently no dellink function in
> > rxe. So the 3rd commit addes dellink function pointer. And the 4th
> > commit implements the dellink function in rxe.
> > 
> > To now, it is not necessary to keep a global variable to store the sock
> > listening udp port 4791. This global variable can be replaced by the
> > functions udp4_lib_lookup and udp6_lib_lookup totally. Because the
> > function udp6_lib_lookup is in the fast path, a member variable l_sk6
> > is added to store the sock. If l_sk6 is NULL, udp6_lib_lookup is called
> > to lookup the sock, then the sock is stored in l_sk6, in the future,it
> > can be used directly.
> > 
> > All the above work has been done in init_net. And it can also work in
> > the net namespace. So the init_net is replaced by the individual net
> > namespace. This is what the 6th commit does. Because rxe device is
> > dependent on the net device and the sock listening on udp port 4791,
> > every rxe device is in exclusive mode in the individual net namespace.
> > Other rdma netns operations will be considerred in the future.
> > 
> > In the 7th commit, the register_pernet_subsys/unregister_pernet_subsys
> > functions are added. When a new net namespace is created, the init
> > function will initialize the sk4 and sk6 socks. Then the 2 socks will
> > be released when the net namespace is destroyed. The functions
> > rxe_ns_pernet_sk4/rxe_ns_pernet_set_sk4 will get and set sk4 in the net
> > namespace. The functions rxe_ns_pernet_sk6/rxe_ns_pernet_set_sk6 will
> > handle sk6. Then sk4 and sk6 are used in the previous commits.
> > 
> > As the sk4 and sk6 in pernet namespace can be accessed, it is not
> > necessary to add a new l_sk6. As such, in the 8th commit, the l_sk6 is
> > replaced with the sk6 in pernet namespace.
> > 
> > Test steps:
> > 1) Suppose that 2 NICs are in 2 different net namespaces.
> > 
> >   # ip netns exec net0 ip link
> >   3: eno2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP
> >      link/ether 00:1e:67:a0:22:3f brd ff:ff:ff:ff:ff:ff
> >      altname enp5s0
> > 
> >   # ip netns exec net1 ip link
> >   4: eno3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel
> >      link/ether f8:e4:3b:3b:e4:10 brd ff:ff:ff:ff:ff:ff
> > 
> > 2) Add rdma link in the different net namespace
> >     net0:
> >     # ip netns exec net0 rdma link add rxe0 type rxe netdev eno2
> > 
> >     net1:
> >     # ip netns exec net1 rdma link add rxe1 type rxe netdev eno3
> > 
> > 3) Run rping test.
> >     net0
> >     # ip netns exec net0 rping -s -a 192.168.2.1 -C 1&
> >     [1] 1737
> >     # ip netns exec net1 rping -c -a 192.168.2.1 -d -v -C 1
> >     verbose
> >     count 1
> >     ...
> >     ping data: rdma-ping-0: ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqr
> >     ...
> > 
> > 4) Remove the rdma links from the net namespaces.
> >     net0:
> >     # ip netns exec net0 ss -lu
> >     State     Recv-Q    Send-Q    Local Address:Port    Peer Address:Port    Process
> >     UNCONN    0         0         0.0.0.0:4791          0.0.0.0:*
> >     UNCONN    0         0         [::]:4791             [::]:*
> > 
> >     # ip netns exec net0 rdma link del rxe0
> > 
> >     # ip netns exec net0 ss -lu
> >     State     Recv-Q    Send-Q    Local Address:Port    Peer Address:Port    Process
> > 
> >     net1:
> >     # ip netns exec net0 ss -lu
> >     State     Recv-Q    Send-Q    Local Address:Port    Peer Address:Port    Process
> >     UNCONN    0         0         0.0.0.0:4791          0.0.0.0:*
> >     UNCONN    0         0         [::]:4791             [::]:*
> > 
> >     # ip netns exec net1 rdma link del rxe1
> > 
> >     # ip netns exec net0 ss -lu
> >     State     Recv-Q    Send-Q    Local Address:Port    Peer Address:Port    Process
> > 
> > V4->V5: Rebase the commits to V6.4-rc1
> > 
> > V3->V4: Rebase the commits to rdma-next;
> > 
> > V2->V3: 1) Add "rdma link del" example in the cover letter, and use "ss -lu" to
> >            verify rdma link is removed.
> >         2) Add register_pernet_subsys/unregister_pernet_subsys net namespace
> >         3) Replace l_sk6 with sk6 of pernet_name_space
> > 
> > V1->V2: Add the explicit initialization of sk6.
> > 
> > Zhu Yanjun (8):
> >   RDMA/rxe: Creating listening sock in newlink function
> >   RDMA/rxe: Support more rdma links in init_net
> >   RDMA/nldev: Add dellink function pointer
> >   RDMA/rxe: Implement dellink in rxe
> >   RDMA/rxe: Replace global variable with sock lookup functions
> >   RDMA/rxe: add the support of net namespace
> >   RDMA/rxe: Add the support of net namespace notifier
> >   RDMA/rxe: Replace l_sk6 with sk6 in net namespace
> > 
> >  drivers/infiniband/core/nldev.c     |   6 ++
> >  drivers/infiniband/sw/rxe/Makefile  |   3 +-
> >  drivers/infiniband/sw/rxe/rxe.c     |  35 +++++++-
> >  drivers/infiniband/sw/rxe/rxe_net.c | 113 +++++++++++++++++------
> >  drivers/infiniband/sw/rxe/rxe_net.h |   9 +-
> >  drivers/infiniband/sw/rxe/rxe_ns.c  | 134 ++++++++++++++++++++++++++++ip netns add test
> >  drivers/infiniband/sw/rxe/rxe_ns.h  |  17 ++++
> >  include/rdma/rdma_netlink.h         |   2 +
> >  8 files changed, 279 insertions(+), 40 deletions(-)
> >  create mode 100644 drivers/infiniband/sw/rxe/rxe_ns.c
> >  create mode 100644 drivers/infiniband/sw/rxe/rxe_ns.hip netns add test
> > 
> 
> Zhu,
> 
> I did some simple experiments on netns functionality.
> 
> With your patch set applied and rxe0 created on enp6s0 and rxe1 created on lo in the default namespace
> 
> 	# sudo ip netns add test
> 	# ip netns
> 	test
> 	# sudo ip netns exec test ip link
> 	1: lo: <LOOPBACK> mtu 65536 qdisc noop state DOWN mode DEFAULT group default qlen 1000
> 	    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
> 	# sudo ip netns exec test ip link set dev lo up
> 	# sudo ip netns exec test ip link
> 	1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
> 	    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
> 	# sudo ip netns exec test ip addr add dev lo fe80::0200:00ff:fe00:0000/64
> 		[rxe doesn't work unless this IPV6 address is set]
> 	# sudo ip netns exec test ip addr
> 	1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
> 	    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
> 	    inet 127.0.0.1/8 scope host lo
> 	       valid_lft forever preferred_lft forever
> 	    inet6 fe80::200:ff:fe00:0/64 scope link 
> 	       valid_lft forever preferred_lft forever
> 	    inet6 ::1/128 scope host 
> 	       valid_lft forever preferred_lft forever
> 	# sudo ip netns exec test ls /sys/class/infiniband
> 	rxe0  rxe1
> 		[These show up even though the ndevs do *not* belong to the test namespace! Probably OK.]
> 	# sudo ip netns exec test rdma link add rxe2 type rxe netdev lo
> 	# ls /sys/class/infiniband
> 	rxe0  rxe1  rxe2
> 		[The new rxe device shows up in the default namespace. At least we're consistent.]
> 	# ib_send_bw -d rxe0 ... 192.168.0.27
> 		[Works. Didn't break the existing rxe devices. Expected]
> 	# ib_send_bw -d rxe1 ... 127.0.0.1
> 		[Works. Expected]
> 	# ib_send_bw -d rxe2 ... 127.0.0.1
> 	IB device rxe2 not found
>  	 Unable to find the Infiniband/RoCE device
> 		[Not work. Expected.]
> 	# sudo ip netns exec test ib_send_bw -d rxe2 ... 127.0.0.1
> 	IB device rxe2 not found
> 	 Unable to find the Infiniband/RoCE device
> 		[Also not work. Turns out rxe2 device is gone after failure. Not expected.]
> 	# sudo ip netns exec test rdma link add rxe2 type rxe netdev lo
> 	# ls /sys/class/infiniband
> 	rxe0  rxe1  rxe2
> 		[Good. It's back]
> 	# sudo ip netns exec test ib_send_bw -d rxe2 ... 127.0.0.1
> 		[Works in test namespace! Expected.]
> 	# sudo ip netns exec test ib_send_bw -d rxe1 ... 127.0.0.1
> 		[Also works. Definitely not expected.]
> 
> My take, it sort of works. But there are some serious issues. You shouldn't be able to use the
> rxe2 device in the default namespace. It would be nice if you couldn't see the rxe devices in each
> other's namespaces (Like ip link or ip addr hide other namespace's devices.)

Hi mates:

If rdma's system is shared, should every net namespace see all rdma devices?

Thanks for your work. I'm working on cloud native web related and I really need this patch :).

Nowadays AI + Cloud Native is becoming more and more popular and there are more and more AI clusters running on Kubernetes. Most AI clusters use RDMA technology to communicate across nodes between training tasks, which speeds up training and reduces network latency. However, RDMA hardware devices are very expensive and costly for those who want to experience or test the entire AI training process (involving scheduling, using RDMA networks, and using nccl-like communication libraries, etc.). So we plan to develop a Kubernetes CNI plugin that can run RDMA locally, which will mount the rdma device on the host inside the container so that the AI tasks can also use the RDMA network.

I understand that Soft Roce is able to virtualize rdma devices without RDMA hardware, and I have verified this locally, being able to test it with tools like ib_send_bw. However, I further moved the NIC on the host or the NIC on the host using macvlan technology to the network namespace inside the container, and then manually added the rdma device inside the container using the rdma link add command, and then finally found out that I couldn't see the virtualized rdma device inside the container by using the ibv_devices command, and I switched the system mode of the rdma respectively(shared or exclusive), and neither of them worked. I've also seen other developers report similar issues, refer [nccl-tests container can't use Soft-RoCE interfaces](https://github.com/NVIDIA/deepops/issues/772).

I guess the Linux kernel upstream doesn't support soft roce containerization yet. I read the linux kernel upstream code and related patches carefully and confirmed my guess. So I contacted Yanjun, I really hope this patch can be merged into upstream, thanks again for your work, looking forward to working further.

Best Regards
Cyclinder

> Bob

