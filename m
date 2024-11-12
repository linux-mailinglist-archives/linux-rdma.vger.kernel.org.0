Return-Path: <linux-rdma+bounces-5931-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C64989C5128
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Nov 2024 09:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55E8D1F23D56
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Nov 2024 08:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6807620BB44;
	Tue, 12 Nov 2024 08:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ju/BJl6/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609CA20BB39
	for <linux-rdma@vger.kernel.org>; Tue, 12 Nov 2024 08:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731401368; cv=none; b=k8qgIWHA4xxeIdwPsb+h7t4DRHKMW+5FcybaB9FDpklBkO0knfYntGovqq0rn0Zq6Q1TALpLe3doUUMALJ7Z0Q6PzUoVBWaFzaYoQLcV2eeV7Y1d1zDCEgru2oByCtCgremRECmGtpvDThQioU9FqfXisjqELWuizkuB9h7ttQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731401368; c=relaxed/simple;
	bh=sT5IejiZqa3RVLVPQ/AGGhiaaMNsUjY5IDHvqM+8Ir4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K7ceyxskI50Ia6FbJx9q2VJU0Lg4PWhamB7LmOpAuTd4/fnpVkl4L0JCUXxI5WT6XYiF4N/OgKqCZ2DddW9FPhO5NqVwNhq/QD+Fuk1Xxx8mXRkbuf4i8vtpG9XZQRt1jVVFvd2dDi9OJlGKj6zqeYflPgbLGlNIHgoPCeYDaMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ju/BJl6/; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3e60fca5350so3095206b6e.2
        for <linux-rdma@vger.kernel.org>; Tue, 12 Nov 2024 00:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731401365; x=1732006165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5XmjAYU+gLVstunWmCGtbnhWCqluAAyA9vdt7jsFxs=;
        b=ju/BJl6/4Wd+mT2XAG1nmVuIpEnWqL1T9FRhWCH9NNBF+4hCvdka69iL8MBflciIpM
         oFvfyl7twdgtm4C9NTzJqQAu5Im2NUK1UHgxe0IJ2X1VrTGGp5sJsB1ZpUY+RlrUT9hY
         OMyoT1bsQi49oZggo5qjjImtHdEb2sOZf2n5+1lcasCBYlSRduhtbdV5F1Rm0x3zeul0
         heYpC1hNU7vNnuo3UpBgri3EEYsilpNNYrMD+BvyO7uS5E/zYFkbhBmot1zde2ZomFsM
         KPrvTrHPyz8mJAmh/ufCKG2ISEXsrisu0pSWNAgAWjArjywJcXmfnA1FUNoj82E5k7Jd
         gXMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731401365; x=1732006165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e5XmjAYU+gLVstunWmCGtbnhWCqluAAyA9vdt7jsFxs=;
        b=DMR22awh81hopyfSzm6L+vwg9q1bkX53SKwHzNiyWug1pHmoWyIbqvWEWdf52h6ZPk
         u1aum4/Nezn5bY/7o5EE7Sr0Yi3kmL0JvWt4SiLaQEJsq3xPZOreHWnYFLn6YukzAr1W
         EyCLXk1Rz9fAUVzHWWMQjSIMdieR0LlEmLsXEp5aGfInOrN2U4UxkjPXlZvSy31VD+ZZ
         qPB3LopBZHBYqXXp2cxZLOvz0uSA4iYE1IN8M2nm9+wPqvQRDPR2LFunIxy1n6hYirV4
         cukJaoOAcXz+NvQAnNDAHSDfjBD5nWvYGLZwwhDeJFG6AeEF1d8Ykg1BmgYs7STzGl1l
         slbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwrbKcwwzR4FPC7542e+irX5fensVqOxfvzxwN/lKlevXTBn0x0w6jgj6HeHRlM05PTqLNcZNtvEHM@vger.kernel.org
X-Gm-Message-State: AOJu0YwFW8jn7MZfRzYOMEslLR400lHyb2sQzcd6oIORfW3tj9CQB9CZ
	qz8X66qp0qWiTWNkjk8zhMTP7bHvYEc+4GzI2cmYiHsVGNGmX3tO
X-Google-Smtp-Source: AGHT+IG99pXB/Rqa1gcGM/vIGng6PKmWvauePiaCPOLg+mVi0doCyxylQeH+ro/dH4fK+C2TwsvPhg==
X-Received: by 2002:a05:6808:1a03:b0:3e6:bd6:bc68 with SMTP id 5614622812f47-3e79469cb60mr12826592b6e.14.1731401365142;
        Tue, 12 Nov 2024 00:49:25 -0800 (PST)
Received: from 10-20-1-10.. ([58.34.148.69])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f4424adcd7sm6246568a12.69.2024.11.12.00.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 00:49:24 -0800 (PST)
From: Cyclinder Kuo <kuocyclinder@gmail.com>
To: yanjun.zhu@intel.com
Cc: jgg@ziepe.ca,
	lehrer@gmail.com,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	parav@nvidia.com,
	rpearsonhpe@gmail.com,
	yanjun.zhu@linux.dev,
	zyjzyj2000@gmail.com
Subject: Re: '[v6,0/8] Fix the problem that rxe can not work in net namespace'
Date: Tue, 12 Nov 2024 16:49:19 +0800
Message-Id: <20241112084919.2515149-1-kuocyclinder@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623095749.485873-1-yanjun.zhu@intel.com>
References: <20230623095749.485873-1-yanjun.zhu@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> When run "ip link add" command to add a rxe rdma link in a net
> namespace, normally this rxe rdma link can not work in a net
> name space.
> 
> The root cause is that a sock listening on udp port 4791 is created
> in init_net when the rdma_rxe module is loaded into kernel. That is,
> the sock listening on udp port 4791 is created in init_net. Other net
> namespace is difficult to use this sock.
> 
> The following commits will solve this problem.
> 
> In the first commit, move the creating sock listening on udp port 4791
> from module_init function to rdma link creating functions. That is,
> after the module rdma_rxe is loaded, the sock will not be created.
> When run "rdma link add ..." command, the sock will be created. So
> when creating a rdma link in the net namespace, the sock will be
> created in this net namespace.
> 
> In the second commit, the functions udp4_lib_lookup and udp6_lib_lookup
> will check the sock exists in the net namespace or not. If yes, rdma
> link will increase the reference count of this sock, then continue other
> jobs instead of creating a new sock to listen on udp port 4791. Since the
> network notifier is global, when the module rdma_rxe is loaded, this
> notifier will be registered.
> 
> After the rdma link is created, the command "rdma link del" is to
> delete rdma link at the same time the sock is checked. If the reference
> count of this sock is greater than the sock reference count needed by
> udp tunnel, the sock reference count is decreased by one. If equal, it
> indicates that this rdma link is the last one. As such, the udp tunnel
> is shut down and the sock is closed. The above work should be
> implemented in linkdel function. But currently no dellink function in
> rxe. So the 3rd commit addes dellink function pointer. And the 4th
> commit implements the dellink function in rxe.
> 
> To now, it is not necessary to keep a global variable to store the sock
> listening udp port 4791. This global variable can be replaced by the
> functions udp4_lib_lookup and udp6_lib_lookup totally. Because the
> function udp6_lib_lookup is in the fast path, a member variable l_sk6
> is added to store the sock. If l_sk6 is NULL, udp6_lib_lookup is called
> to lookup the sock, then the sock is stored in l_sk6, in the future,it
> can be used directly.
> 
> All the above work has been done in init_net. And it can also work in
> the net namespace. So the init_net is replaced by the individual net
> namespace. This is what the 6th commit does. Because rxe device is
> dependent on the net device and the sock listening on udp port 4791,
> every rxe device is in exclusive mode in the individual net namespace.
> Other rdma netns operations will be considerred in the future.
> 
> In the 7th commit, the register_pernet_subsys/unregister_pernet_subsys
> functions are added. When a new net namespace is created, the init
> function will initialize the sk4 and sk6 socks. Then the 2 socks will
> be released when the net namespace is destroyed. The functions
> rxe_ns_pernet_sk4/rxe_ns_pernet_set_sk4 will get and set sk4 in the net
> namespace. The functions rxe_ns_pernet_sk6/rxe_ns_pernet_set_sk6 will
> handle sk6. Then sk4 and sk6 are used in the previous commits.
> 
> As the sk4 and sk6 in pernet namespace can be accessed, it is not
> necessary to add a new l_sk6. As such, in the 8th commit, the l_sk6 is
> replaced with the sk6 in pernet namespace.
> 
> Test steps:
> 1) Suppose that 2 NICs are in 2 different net namespaces.
> 
>   # ip netns exec net0 ip link
>   3: eno2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP
>      link/ether 00:1e:67:a0:22:3f brd ff:ff:ff:ff:ff:ff
>      altname enp5s0
> 
>   # ip netns exec net1 ip link
>   4: eno3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel
>      link/ether f8:e4:3b:3b:e4:10 brd ff:ff:ff:ff:ff:ff
> 
> 2) Add rdma link in the different net namespace
>     net0:
>     # ip netns exec net0 rdma link add rxe0 type rxe netdev eno2
> 
>     net1:
>     # ip netns exec net1 rdma link add rxe1 type rxe netdev eno3
> 
> 3) Run rping test.
>     net0
>     # ip netns exec net0 rping -s -a 192.168.2.1 -C 1&
>     [1] 1737
>     # ip netns exec net1 rping -c -a 192.168.2.1 -d -v -C 1
>     verbose
>     count 1
>     ...
>     ping data: rdma-ping-0: ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqr
>     ...
> 
> 4) Remove the rdma links from the net namespaces.
>     net0:
>     # ip netns exec net0 ss -lu
>     State     Recv-Q    Send-Q    Local Address:Port    Peer Address:Port    Process
>     UNCONN    0         0         0.0.0.0:4791          0.0.0.0:*
>     UNCONN    0         0         [::]:4791             [::]:*
> 
>     # ip netns exec net0 rdma link del rxe0
> 
>     # ip netns exec net0 ss -lu
>     State     Recv-Q    Send-Q    Local Address:Port    Peer Address:Port    Process
> 
>     net1:
>     # ip netns exec net0 ss -lu
>     State     Recv-Q    Send-Q    Local Address:Port    Peer Address:Port    Process
>     UNCONN    0         0         0.0.0.0:4791          0.0.0.0:*
>     UNCONN    0         0         [::]:4791             [::]:*
> 
>     # ip netns exec net1 rdma link del rxe1
> 
>     # ip netns exec net0 ss -lu
>     State     Recv-Q    Send-Q    Local Address:Port    Peer Address:Port    Process
> 
> V5->V6: Fix resource leak problem when rxe_net_init fails. And fix some
> 	style problems.
> 
> V4->V5: Rebase the commits to V6.4-rc1
> 
> V3->V4: Rebase the commits to rdma-next;
> 
> V2->V3: 1) Add "rdma link del" example in the cover letter, and use "ss -lu" to
>            verify rdma link is removed.
>         2) Add register_pernet_subsys/unregister_pernet_subsys net namespace
>         3) Replace l_sk6 with sk6 of pernet_name_space
> 
> V1->V2: Add the explicit initialization of sk6.
> 
> Zhu Yanjun (8):
>   RDMA/rxe: Creating listening sock in newlink function
>   RDMA/rxe: Support more rdma links in init_net
>   RDMA/nldev: Add dellink function pointer
>   RDMA/rxe: Implement dellink in rxe
>   RDMA/rxe: Replace global variable with sock lookup functions
>   RDMA/rxe: add the support of net namespace
>   RDMA/rxe: Add the support of net namespace notifier
>   RDMA/rxe: Replace l_sk6 with sk6 in net namespace
> 
>  drivers/infiniband/core/nldev.c     |   6 ++
>  drivers/infiniband/sw/rxe/Makefile  |   3 +-
>  drivers/infiniband/sw/rxe/rxe.c     |  35 +++++++-
>  drivers/infiniband/sw/rxe/rxe_net.c | 119 ++++++++++++++++++------
>  drivers/infiniband/sw/rxe/rxe_net.h |   9 +-
>  drivers/infiniband/sw/rxe/rxe_ns.c  | 134 ++++++++++++++++++++++++++++
>  drivers/infiniband/sw/rxe/rxe_ns.h  |  17 ++++
>  include/rdma/rdma_netlink.h         |   2 +
>  8 files changed, 285 insertions(+), 40 deletions(-)
>  create mode 100644 drivers/infiniband/sw/rxe/rxe_ns.c
>  create mode 100644 drivers/infiniband/sw/rxe/rxe_ns.h
> 

Hi mates, thanks for your work. I'm working on cloud native web related and I really need this patch :).

Nowadays AI + Cloud Native is becoming more and more popular and there are more and more AI clusters running on Kubernetes. Most AI clusters use RDMA technology to communicate across nodes between training tasks, which speeds up training and reduces network latency. However, RDMA hardware devices are very expensive and costly for those who want to experience or test the entire AI training process (involving scheduling, using RDMA networks, and using nccl-like communication libraries, etc.). So we plan to develop a Kubernetes CNI plugin that can run RDMA locally, which will mount the rdma device on the host inside the container so that the AI tasks can also use the RDMA network.

I understand that Soft Roce is able to virtualize rdma devices without RDMA hardware, and I have verified this locally, being able to test it with tools like ib_send_bw. However, I further moved the NIC on the host or the NIC on the host using macvlan technology to the network namespace inside the container, and then manually added the rdma device inside the container using the rdma link add command, and then finally found out that I couldn't see the virtualized rdma device inside the container by using the ibv_devices command, and I switched the system mode of the rdma respectively(shared or exclusive), and neither of them worked. I've also seen other developers report similar issues, refer [nccl-tests container can't use Soft-RoCE interfaces](https://github.com/NVIDIA/deepops/issues/772).

I guess the Linux kernel upstream doesn't support soft roce containerization yet. I read the linux kernel upstream code and related patches carefully and confirmed my guess. So I contacted Yanjun, I really hope this patch can be merged into upstream, thanks again for your work.

Best Regards
Cyclinder kuo


