Return-Path: <linux-rdma+bounces-242-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 679CF8042DB
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Dec 2023 00:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 082B5B20AD8
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Dec 2023 23:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5194A39FC4;
	Mon,  4 Dec 2023 23:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qg/SZdsY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [IPv6:2001:41d0:1004:224b::ad])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150FB1B9
	for <linux-rdma@vger.kernel.org>; Mon,  4 Dec 2023 15:50:34 -0800 (PST)
Message-ID: <afd3694a-695b-45d9-909c-b28b99a09d24@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701733831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PDyapmdUnbuvt3r810rxl2GnQLpN2TqehHiU2gdVXEk=;
	b=qg/SZdsYMg7/8SiCP1i4SgBUj+4INz71RYeE7lmnrx9ogUdiaTaEeo1dzaJQH4K0humJQS
	MHxMBe2Cka/VqaC4+TROFTXbW48OrvzWFzmYA1H/hzlYoVLuFDy2dPbTo4c5lS7fstDNKt
	oNdPsZ+CXteyG8bAkH5NwbSqPftahtc=
Date: Tue, 5 Dec 2023 07:50:27 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next v4 0/7] RDMA/rxe: Make multicast work
To: Bob Pearson <rpearsonhpe@gmail.com>, jgg@nvidia.com,
 linux-rdma@vger.kernel.org, "leon@kernel.org" <leon@kernel.org>
References: <20231204200342.7125-1-rpearsonhpe@gmail.com>
 <2ce139e0-8fd7-4ed7-af5e-83a9e4b55710@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <2ce139e0-8fd7-4ed7-af5e-83a9e4b55710@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

+ Leon

Bob

Exactly.  Some kind of lock is needed for ipv6_sock_mc_join/drop. I will 
delve into these commits.

And this is related with mcast. We can invite netdev experts to review 
the code as well.

If you agree, I will also send your commits to netdev maillist.

And these commits are complicated. It is very good to have the 
suggestions from

the experts in netdev.

Zhu Yanjun

在 2023/12/5 4:07, Bob Pearson 写道:
> Zhu,
>
> Thanks for testing this. It turns out I needed to take the sk_lock for
> ipv6_sock_mc_join/drop().
>
> Bob
>
> On 12/4/23 14:03, Bob Pearson wrote:
>> After developing a test program which exercises node to node
>> testing of RoCE multicast it became clear that there are a
>> number of issues with the current rdma_rxe multicast implementation.
>>
>> The issues seen include:
>>     - There is no support for IPV4 multicast addresses.
>>     - Once a multicast MAC is added it is not removed.
>>     - Multicast packets are sent with the wrong QP number.
>>     - Multicast IP addresses are not created and without
>>       them no multicast packets received on the interface
>>       are delivered to the rdma_rxe driver.
>>     - The implementation in rxe_mcast.c is potentially
>>       racy if multiple simultaneous attach/detach operations
>>       are issued.
>>
>> This patch set fixes these issues.
>> ---
>> v4:
>>    Corrected a lockdep bug reported by Zhu Yanjun.
>> v3:
>>    Removed rxe_loop_and_send(). It turns out it is not needed.
>>    Added module parameters to set mcast limits to small values when
>>    driver is loaded to enable mcast limit testing.
>>    Rebased to current for-next branch.
>> v2:
>>    Respond to comments by Zhu.
>>    Added more Fixes lines.
>>    Added some more explanation in the commit messages.
>>    Fixed an error in rxe_lookup_mcg. Should have checked
>>     the return from rxe_get_mcg().
>>
>> Bob Pearson (7):
>>    RDMA/rxe: Cleanup rxe_ah/av_chk_attr
>>    RDMA/rxe: Fix sending of mcast packets
>>    RDMA/rxe: Register IP mcast address
>>    RDMA/rxe: Let rxe_lookup_mcg use rcu_read_lock
>>    RDMA/rxe: Split multicast lock
>>    RDMA/rxe: Cleanup mcg lifetime
>>    RDMA/rxe: Add module parameters for mcast limits
>>
>>   drivers/infiniband/sw/rxe/Makefile     |   3 +-
>>   drivers/infiniband/sw/rxe/rxe.c        |   8 +-
>>   drivers/infiniband/sw/rxe/rxe_av.c     |  50 +--
>>   drivers/infiniband/sw/rxe/rxe_loc.h    |   6 +-
>>   drivers/infiniband/sw/rxe/rxe_mcast.c  | 524 +++++++++++--------------
>>   drivers/infiniband/sw/rxe/rxe_net.c    |   6 +-
>>   drivers/infiniband/sw/rxe/rxe_net.h    |   1 +
>>   drivers/infiniband/sw/rxe/rxe_opcode.h |   2 +-
>>   drivers/infiniband/sw/rxe/rxe_param.c  |  23 ++
>>   drivers/infiniband/sw/rxe/rxe_param.h  |   4 +
>>   drivers/infiniband/sw/rxe/rxe_qp.c     |   4 +-
>>   drivers/infiniband/sw/rxe/rxe_recv.c   |  11 +-
>>   drivers/infiniband/sw/rxe/rxe_req.c    |  11 +-
>>   drivers/infiniband/sw/rxe/rxe_verbs.c  |   5 +-
>>   drivers/infiniband/sw/rxe/rxe_verbs.h  |   5 +-
>>   15 files changed, 303 insertions(+), 360 deletions(-)
>>   create mode 100644 drivers/infiniband/sw/rxe/rxe_param.c
>>

