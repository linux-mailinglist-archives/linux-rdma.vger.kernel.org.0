Return-Path: <linux-rdma+bounces-17504-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNutBcP4qGlzzwAAu9opvQ
	(envelope-from <linux-rdma+bounces-17504-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 04:30:11 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6125B20A85C
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 04:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 994D73040A89
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2026 03:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2173C15A85A;
	Thu,  5 Mar 2026 03:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nxkTKLqe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E8C23C8AE
	for <linux-rdma@vger.kernel.org>; Thu,  5 Mar 2026 03:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772681407; cv=none; b=KgDjquq1rH6+ooPj54Wsm7appoKEM6siQ/IbsjbNacCtAMqxXWMk8DaBjNlVwqH9I5RqDyE2QTv7NzzjcjTfSPSRKEmL2fMkoJmYCnNo9whc7+FcJCFiOjxw6AW3vDJrdnfRbQpGysH4Yci0/rm8JEgMePnzGKwyWcz5hk9mHCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772681407; c=relaxed/simple;
	bh=yddpmHZhWAeUVfeQNin4HodtoOnbNazlINnCN/aHMuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BT5rY3QEeeKQVMHfcbTaawQ6LgSU3sQ8Bwelqa5V1PtIF0NBQRkDPiRC7IIM91/P6smp97aXoMUj9hZM8miBETmBMnfnASdJvom9+sQn5wsfFGMMTYC69vOQu+TFE5HzNtbUFv+KrnLdasNACp1iBWLxvBQAzEPszK1ImSKnGko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nxkTKLqe; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f576b139-cf1c-423f-a8cd-f51c23f7e18d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772681404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+RNGYpm2on2zfcxQ/4djKkgNn4rlEH1V459hv2ZmvLs=;
	b=nxkTKLqeIrbeDGtkLSyIq6GYtnFzd0NGPM2015oEKsD6xokKY2gtQ+TC+wxVEy9dx7zGtF
	uWz3y99O++R6MpWJWbVw/bqx7iPs2NU95swSj7ce+oo7ZtJUkx0BazVHCQxr9sSU7If0sN
	ecudU4X3N0m+J8Z5AR9bK8ghwyTSXlY=
Date: Wed, 4 Mar 2026 19:29:52 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCHv2 1/1] RDMA/rxe: Add the support that rxe can work in net
 namespace
To: David Ahern <dsahern@kernel.org>, jgg@ziepe.ca, leon@kernel.org,
 zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20260304041607.11685-1-yanjun.zhu@linux.dev>
 <28be84a9-ad21-4a29-8199-a155e63e4cd8@linux.dev>
 <c8170bb8-d031-4e43-86dd-633cc1269fcb@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <c8170bb8-d031-4e43-86dd-633cc1269fcb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 6125B20A85C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[kernel.org,ziepe.ca,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17504-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action


在 2026/3/4 11:29, David Ahern 写道:
> On 3/3/26 9:44 PM, Zhu Yanjun wrote:
>> The script in the link
>> https://github.com/zhuyj/linux/blob/6.19-net-namespace/net_ns_rxe.sh can
>> make tests in linux distributions.
> I have not read the patch, but I did look at the test script referenced
> here. Comments
>
> 1. drop the sleeps. They should never be needed. If you need to wait for
> some resource, then wait for that resource explicitly with a timeout.
Thanks a lot. The sleep statements have been removed.
>
> 2. tests should cover the range of features in the patch meaning IPv6,
IPv6 functionality is now covered. Please check the link: 
https://github.com/zhuyj/linux/blob/6.19-net-namespace/net_ns_rxe.sh
> and if you keep the attempts to delete the socket after the rxe devices
> are deleted, then tests should include variations of this theme. e.g.,
> per network namespace:
>
> a. no devices = no socket
>
> b. 1 device, sockets work, delete device, no socket
>
> c. 2 devices, sockets work, delete 1 device, socket still works, delete
> second device, no socket.
The scenarios mentioned previously (a, b, c) have been fully tested. The 
link to the test script is: 
https://github.com/zhuyj/linux/blob/6.19-net-namespace/net_ns_rxe.sh
>
> 3. the script can be added to tools/testing/selftests/{infiniband,rdma}
> -- whatever directory seems most appropriate. Adding it here and fitting
> within kernel selftests means it can be run by CI as commits are done.

The script has been added to tools/testing/selftests/rdma. The commit is

https://github.com/zhuyj/linux/commit/0fa99629c1a656592b7b2011dc5cad16de2320fd

It can be tested by running:

make -C tools/testing/selftests TARGETS=rdma run_tests

Please let me know if there are any additional concerns or suggestions.

Thanks,

Zhu Yanjun

>
>> BTW, please disable firewall before making tests.
> That should not be needed. The test script should be internal to a host
> using only namespaces you control and configure.
>
-- 
Best Regards,
Yanjun.Zhu


