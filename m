Return-Path: <linux-rdma+bounces-17837-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AVxCaRsr2m6YQIAu9opvQ
	(envelope-from <linux-rdma+bounces-17837-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 01:58:12 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5322433B1
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 01:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E52ED3052B9D
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 00:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D763E186E2E;
	Tue, 10 Mar 2026 00:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pycPdyu6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2F0260580
	for <linux-rdma@vger.kernel.org>; Tue, 10 Mar 2026 00:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773104287; cv=none; b=PAvQSQSatlZ1ldmrrCGS5z0O0PL1H0Df1r/JnBNLN8Atqj46iTo4jwOwV/WnV3o67iTAke9HusNGCN1Kx5mWtR8UoUeTPWdgbMWI6gOO65bMO65yFcmpZeJVI17WuRkP7B4pAdWQ31v79tJSQTmKddtktpfplmnTVGiYPBn2g+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773104287; c=relaxed/simple;
	bh=dPoEIOAYHx5KLrElD/4+mIklDzgqI00gPUpmH8GDibM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Hn6mHUDAFpftd4ikFYxYbAn9nF7ee9HWGMYQ95IIx5X6sDM9vS9tU/CYT0FQmwVrS+8VzFYDwscCinh1JpZRFonshwwd8A/khb8SiFP6sGXstgo9kIRjaz1GaEz7On6Z4sFjj7QuKqbukLwL5e2w2bWjk9czo2UYX3J7Z9ENu3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pycPdyu6; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a8667ffa-8157-42b7-b1e8-632891de7f1c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773104279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uq+YT/c2bPbY61/CzhKnRWl7UJSRGUFSbyEUAdzLVMs=;
	b=pycPdyu6xzn9YbY8k42TaUulljiM+mnMX99p2zSHMr1JVfUOZJ5uTf+TBzAQXkc4lEJudU
	Nd1gs3uHqV8BM0ahvBwp6e0WKzcyQeETU7TTnPDTYGAbownxUJn4u6UozxBQR4pvokVxl3
	Ypg9n1bUT4RjGoIcWZVBb64J8Ndle/M=
Date: Mon, 9 Mar 2026 17:57:49 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 3/4] RDMA/rxe: Support RDMA link creation and
 destruction per net namespace
To: David Ahern <dsahern@kernel.org>, jgg@ziepe.ca, leon@kernel.org,
 zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Zhu Yanjun <yanjun.zhu@linux.dev>
References: <20260308233540.13382-1-yanjun.zhu@linux.dev>
 <20260308233540.13382-4-yanjun.zhu@linux.dev>
 <a91c6ed2-2eb2-4e7c-9213-5cc977abc660@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "yanjun.zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <a91c6ed2-2eb2-4e7c-9213-5cc977abc660@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: BE5322433B1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-17837-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,ziepe.ca,gmail.com,vger.kernel.org,linux.dev];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid]
X-Rspamd-Action: no action

On 3/9/26 11:54 AM, David Ahern wrote:
> On 3/8/26 5:35 PM, Zhu Yanjun wrote:
>> @@ -101,20 +100,20 @@ static inline void rxe_reclassify_recv_socket(struct socket *sock)
>>   }
>>   
>>   static struct dst_entry *rxe_find_route4(struct rxe_qp *qp,
>> +					 struct net *net,
>>   					 struct net_device *ndev,
>>   					 struct in_addr *saddr,
>>   					 struct in_addr *daddr)
>>   {
>>   	struct rtable *rt;
>> -	struct flowi4 fl = { { 0 } };
>> +	struct flowi4 fl = {};
>>   
>> -	memset(&fl, 0, sizeof(fl));
> 
> changing init of fl here and fl6 in the next function are not relevant
> to this patch. It should be a different one after this set.

Thanks. The changes have been done. It is a trivial problem. Let us keep 
them in this patch series.

> 
>>   	fl.flowi4_oif = ndev->ifindex;
>>   	memcpy(&fl.saddr, saddr, sizeof(*saddr));
>>   	memcpy(&fl.daddr, daddr, sizeof(*daddr));
>>   	fl.flowi4_proto = IPPROTO_UDP;
>>   
>> -	rt = ip_route_output_key(&init_net, &fl);
>> +	rt = ip_route_output_key(net, &fl);
>>   	if (IS_ERR(rt)) {
>>   		rxe_dbg_qp(qp, "no route to %pI4\n", &daddr->s_addr);
>>   		return NULL;
>> @@ -125,21 +124,21 @@ static struct dst_entry *rxe_find_route4(struct rxe_qp *qp,
>>   
>>   #if IS_ENABLED(CONFIG_IPV6)
>>   static struct dst_entry *rxe_find_route6(struct rxe_qp *qp,
>> +					 struct net *net,
>>   					 struct net_device *ndev,
>>   					 struct in6_addr *saddr,
>>   					 struct in6_addr *daddr)
>>   {
>>   	struct dst_entry *ndst;
>> -	struct flowi6 fl6 = { { 0 } };
>> +	struct flowi6 fl6 = {};
>>   
>> -	memset(&fl6, 0, sizeof(fl6));
>>   	fl6.flowi6_oif = ndev->ifindex;
>>   	memcpy(&fl6.saddr, saddr, sizeof(*saddr));
>>   	memcpy(&fl6.daddr, daddr, sizeof(*daddr));
>>   	fl6.flowi6_proto = IPPROTO_UDP;
>>   
>> -	ndst = ipv6_stub->ipv6_dst_lookup_flow(sock_net(recv_sockets.sk6->sk),
>> -					       recv_sockets.sk6->sk, &fl6,
>> +	ndst = ipv6_stub->ipv6_dst_lookup_flow(net,
>> +					       rxe_ns_pernet_sk6(dev_net(ndev)), &fl6,
> 
> why dev_net(ndev) here?

Got it. I will fix it in the latest commits.

Zhu Yanjun

> 
> 
>>   					       NULL);
>>   	if (IS_ERR(ndst)) {
>>   		rxe_dbg_qp(qp, "no route to %pI6\n", daddr);
> 


