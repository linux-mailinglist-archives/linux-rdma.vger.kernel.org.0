Return-Path: <linux-rdma+bounces-259-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09317804977
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Dec 2023 06:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B4BDB20C4F
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Dec 2023 05:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A221CD288;
	Tue,  5 Dec 2023 05:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KWTQhQdq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [IPv6:2001:41d0:203:375::bb])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90F7113
	for <linux-rdma@vger.kernel.org>; Mon,  4 Dec 2023 21:50:32 -0800 (PST)
Message-ID: <9d5f532a-9ea1-42be-8628-4acb060753b3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701755430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gAnOSA3g1Gowc+bLC/mvEA1Nb1F40NAfi2ei8l4jX4k=;
	b=KWTQhQdqILPCmqdRAEbZXTLRtUV/P7up3uGztGWQsvyd3q/luYmn4JQo3haS2QwqVTrUod
	1i1Vs5LDhjgvmA5CRTQ9FkDHwWaBXZGDhSkfoE00kcKWljQxgna1jTBGpDWjIoLZoxDiST
	EfLdG0oFRvjGHNJcOESEReqnLU6xW9w=
Date: Tue, 5 Dec 2023 13:50:25 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next v5 0/7] RDMA/rxe: Make multicast work
To: Bob Pearson <rpearsonhpe@gmail.com>, jgg@nvidia.com,
 linux-rdma@vger.kernel.org, dsahern@kernel.org,
 "davem@davemloft.net" <davem@davemloft.net>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20231205002322.10143-1-rpearsonhpe@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20231205002322.10143-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add  David S. Miller and  David Ahern.

They are the maintainers in netdev and very familiar with mcast.

Zhu Yanjun

在 2023/12/5 8:23, Bob Pearson 写道:
> After developing a test program which exercises node to node
> testing of RoCE multicast it became clear that there are a
> number of issues with the current rdma_rxe multicast implementation.
>
> The issues seen include:
> 	- There is no support for IPV4 multicast addresses.
> 	- Once a multicast MAC is added it is not removed.
> 	- Multicast packets are sent with the wrong QP number.
> 	- Multicast IP addresses are not created and without
> 	  them no multicast packets received on the interface
> 	  are delivered to the rdma_rxe driver.
> 	- The implementation in rxe_mcast.c is potentially
> 	  racy if multiple simultaneous attach/detach operations
> 	  are issued.
>
> This patch set fixes these issues.
> ---
> v5:
>    Missed previous fix in error path. Add sock lock around
>    ipv6_sock_mm_drop() in rxe_mcast_add6().
> v4:
>    Corrected a lockdep bug reported by Zhu Yanjun.
> v3:
>    Removed rxe_loop_and_send(). It turns out it is not needed.
>    Added module parameters to set mcast limits to small values when
>    driver is loaded to enable mcast limit testing.
>    Rebased to current for-next branch.
> v2:
>    Respond to comments by Zhu.
>    Added more Fixes lines.
>    Added some more explanation in the commit messages.
>    Fixed an error in rxe_lookup_mcg. Should have checked
> 	the return from rxe_get_mcg().
>
> Bob Pearson (7):
>    RDMA/rxe: Cleanup rxe_ah/av_chk_attr
>    RDMA/rxe: Fix sending of mcast packets
>    RDMA/rxe: Register IP mcast address
>    RDMA/rxe: Let rxe_lookup_mcg use rcu_read_lock
>    RDMA/rxe: Split multicast lock
>    RDMA/rxe: Cleanup mcg lifetime
>    RDMA/rxe: Add module parameters for mcast limits
>
>   drivers/infiniband/sw/rxe/Makefile     |   3 +-
>   drivers/infiniband/sw/rxe/rxe.c        |   8 +-
>   drivers/infiniband/sw/rxe/rxe_av.c     |  50 +--
>   drivers/infiniband/sw/rxe/rxe_loc.h    |   6 +-
>   drivers/infiniband/sw/rxe/rxe_mcast.c  | 526 +++++++++++--------------
>   drivers/infiniband/sw/rxe/rxe_net.c    |   6 +-
>   drivers/infiniband/sw/rxe/rxe_net.h    |   1 +
>   drivers/infiniband/sw/rxe/rxe_opcode.h |   2 +-
>   drivers/infiniband/sw/rxe/rxe_param.c  |  23 ++
>   drivers/infiniband/sw/rxe/rxe_param.h  |   4 +
>   drivers/infiniband/sw/rxe/rxe_qp.c     |   4 +-
>   drivers/infiniband/sw/rxe/rxe_recv.c   |  11 +-
>   drivers/infiniband/sw/rxe/rxe_req.c    |  11 +-
>   drivers/infiniband/sw/rxe/rxe_verbs.c  |   5 +-
>   drivers/infiniband/sw/rxe/rxe_verbs.h  |   5 +-
>   15 files changed, 305 insertions(+), 360 deletions(-)
>   create mode 100644 drivers/infiniband/sw/rxe/rxe_param.c
>

