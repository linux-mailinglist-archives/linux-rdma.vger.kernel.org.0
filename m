Return-Path: <linux-rdma+bounces-17838-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLd+AuZsr2m6YQIAu9opvQ
	(envelope-from <linux-rdma+bounces-17838-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 01:59:18 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6CC2433C3
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 01:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3EED3022F48
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 00:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42148239E63;
	Tue, 10 Mar 2026 00:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HKkIMrJJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5722186E2E
	for <linux-rdma@vger.kernel.org>; Tue, 10 Mar 2026 00:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773104356; cv=none; b=PXl5IXPor9xj2tLxZVWt+1p/SyPMgGYUEDwnGs9lDizrWL6ISRYFKvOlR4jMT0m46kDM2fdbvvU0kOe8FEXZN8V0o287P7l+qCi2elxz1MsbYkxUJ7vrQQytHwQsMryd1+1S/2e2Qx9rNnDvM6dDhMoHMD/D1lIM3wKjv1W+yzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773104356; c=relaxed/simple;
	bh=acAgMLq2GoV1PYZFMmwQa1oS3NzSELcKigiu1mbKhvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=r/yrDaYyD0Oqa9xXw6WUgJFMchs51iyeD6nfnHCwsx0rSQ1qQqtVHUW9p8TMmF5ci8px1ijr7FD1ey4raBexc/YbxiPGh+8OZXvjKF3GfLt9HI9jyu0PW4GxA05ei/t5BIY5E3eDhBoAMC/Qv+Xrmu1541ig5wiaxCUHZ2EYB+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HKkIMrJJ; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <879742b3-da96-44fd-9cbf-ba471b99f03c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773104352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4LB1WRHoRTnoRAaNtzpjIqZzqOf5EKjDkqzha8+8jEw=;
	b=HKkIMrJJBFUgZVFrCwdjtOkkYOND6c6eexcVe28Jj+SNm4n4W1xk+xcLgleJ9N2DtGm6z+
	eLhIUlsUFHz1QsauPyZBAwVo6YCnXzI0uT7CWFkpBsJmSTQJmu2i3Augyk2LC3Wc+MsPja
	hN4zy+EScf8tkOGzRbObdTudFAqD8ko=
Date: Mon, 9 Mar 2026 17:59:01 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 2/4] RDMA/rxe: Add net namespace support for IPv4/IPv6
 sockets
To: David Ahern <dsahern@kernel.org>, jgg@ziepe.ca, leon@kernel.org,
 zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Zhu Yanjun <yanjun.zhu@linux.dev>
References: <20260308233540.13382-1-yanjun.zhu@linux.dev>
 <20260308233540.13382-3-yanjun.zhu@linux.dev>
 <f8315319-3dda-4ab2-97b1-7645c3995d3d@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "yanjun.zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <f8315319-3dda-4ab2-97b1-7645c3995d3d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: BD6CC2433C3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-17838-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,ziepe.ca,gmail.com,vger.kernel.org,linux.dev];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/9/26 11:54 AM, David Ahern wrote:
> On 3/8/26 5:35 PM, Zhu Yanjun wrote:
>> diff --git a/drivers/infiniband/sw/rxe/rxe_ns.c b/drivers/infiniband/sw/rxe/rxe_ns.c
>> new file mode 100644
>> index 000000000000..6fe056c81ef3
>> --- /dev/null
>> +++ b/drivers/infiniband/sw/rxe/rxe_ns.c
>> @@ -0,0 +1,136 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
>> +/*
>> + * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
>> + * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
> 
> neither of those copyrights are relevant here.
> 
> 
> 
>> +static void rxe_ns_exit(struct net *net)
>> +{
>> +	/* called when the network namespace is removed
>> +	 */
>> +	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
>> +	struct sock *sk;
>> +
>> +	sk = rcu_dereference(ns_sk->rxe_sk4);
> 
> [  323.527911] =============================
> [  323.527915] WARNING: suspicious RCU usage
> [  323.527918] 7.0.0-rc1-debug+ #3 Tainted: G        W
> [  323.527922] -----------------------------
> [  323.527925] drivers/infiniband/sw/rxe/rxe_ns.c:49 suspicious
> rcu_dereference_check() usage!
> [  323.527929]
> 
>> +	if (sk) {
>> +		rcu_assign_pointer(ns_sk->rxe_sk4, NULL);
>> +		udp_tunnel_sock_release(sk->sk_socket);
>> +	}
>> +
>> +#if IS_ENABLED(CONFIG_IPV6)
>> +	sk = rcu_dereference(ns_sk->rxe_sk6);
> 
> [  323.528243] =============================
> [  323.528245] WARNING: suspicious RCU usage
> [  323.528248] 7.0.0-rc1-debug+ #3 Tainted: G        W
> [  323.528251] -----------------------------
> [  323.528253] drivers/infiniband/sw/rxe/rxe_ns.c:56 suspicious
> rcu_dereference_check() usage!
> 
> 
> you should always run tests with a debug kernel that has kmemleak and
> lock debugging enabled.
> 
> 
>> +#else /* IPV6 */
>> +
>> +struct sock *rxe_ns_pernet_sk6(struct net *net)
>> +{
>> +	return NULL;
>> +}
>> +
>> +void rxe_ns_pernet_set_sk6(struct net *net, struct sock *sk)
>> +{
>> +}
> 
> This branch is typically done as an inline in the header file.
> 
> 

Got it. All the above problems are fixed in the latest commit.

Zhu Yanjun

