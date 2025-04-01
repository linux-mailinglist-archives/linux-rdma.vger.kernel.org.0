Return-Path: <linux-rdma+bounces-9080-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E1EA77C1F
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Apr 2025 15:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5C72188FB18
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Apr 2025 13:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAD41EF37C;
	Tue,  1 Apr 2025 13:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KD+77uEm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CE21F930
	for <linux-rdma@vger.kernel.org>; Tue,  1 Apr 2025 13:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743514328; cv=none; b=HMRGL0Z2jQl/90xQUkq3SUpOl5gEk7s2uzG1vmRfUEjd5wy96besf8+XmAcwp5khmhFSHihgylaY0TqBQ4n6I1g9C9BuPptQfE4PYS/EGPtL7ixj7LxxQ+RKTxoH7V5+AXY6K+Vc8Wl4Am49GUk68QAEoRYV1LSgEG12ldzpfbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743514328; c=relaxed/simple;
	bh=/tBD38mp4DS6jkQtiRDsu4bhtmz7msq1iOn6Dz0mWmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EuAzOvJj/923Zr+N80/NgZUXx9llUIWMCswsxfPooGc+S4J2jDytKh9iBI9Jo5QZB0DlvPSn6Mlp43RWxUe/5CQNgV7XVGgi8ZveXPjMID8IW0hLqtPS/TgTDm1i5+rYEOVhdK5CY/kLNm05piyvsBmIZTJWGg5XX7OryT5Zo6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KD+77uEm; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <052a9a59-b555-4867-9ec6-c6fa719adb61@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743514321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lg826qukLI7doC/5Gq/qEXLkMQocti6S+kHz6s4mVhA=;
	b=KD+77uEmnJzlYVcl++uqZFBZMmN9a07Fx8ECI9PCoqSh/jw7WXEewlggpwX8PDEVyAMA1U
	+cYLjrSzc0sQ2PLj0iCRoZUwr/85VG6tB/qpTBhSFucK63Mtf0C7byMWasHDffa4s6izxx
	6ZPeccmb5AmrKkR4s764ArJLFtIiFoc=
Date: Tue, 1 Apr 2025 15:31:57 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net/smc: fix general protection fault in
 __smc_diag_dump
To: Paolo Abeni <pabeni@redhat.com>, Wang Liang <wangliang74@huawei.com>,
 wenjia@linux.ibm.com, jaka@linux.ibm.com, alibuda@linux.alibaba.com,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 ubraun@linux.vnet.ibm.com
Cc: yuehaibing@huawei.com, zhangchangzhong@huawei.com,
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250331081003.1503211-1-wangliang74@huawei.com>
 <37f86471-5abc-4f04-954e-c6fb5f2b653a@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <37f86471-5abc-4f04-954e-c6fb5f2b653a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 01.04.25 13:01, Paolo Abeni wrote:
> On 3/31/25 10:10 AM, Wang Liang wrote:
>> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>> index 3e6cb35baf25..454801188514 100644
>> --- a/net/smc/af_smc.c
>> +++ b/net/smc/af_smc.c
>> @@ -371,6 +371,7 @@ void smc_sk_init(struct net *net, struct sock *sk, int protocol)
>>   	sk->sk_protocol = protocol;
>>   	WRITE_ONCE(sk->sk_sndbuf, 2 * READ_ONCE(net->smc.sysctl_wmem));
>>   	WRITE_ONCE(sk->sk_rcvbuf, 2 * READ_ONCE(net->smc.sysctl_rmem));
>> +	smc->clcsock = NULL;
>>   	INIT_WORK(&smc->tcp_listen_work, smc_tcp_listen_work);
>>   	INIT_WORK(&smc->connect_work, smc_connect_work);
>>   	INIT_DELAYED_WORK(&smc->conn.tx_work, smc_tx_work);
> 
> The syzkaller report has a few reproducers, have you tested this? AFAICS
> the smc socket is already zeroed on allocation by sk_alloc().

Yes. I also agree with you that smc socket should have already been zeroed.

Currently in this commit, this member variable is set to NULL 
explicitly. I am not sure if this can fix this problem or not.

Based on the following, it seems that this problem can be reproduced.
"
syzbot has tested the proposed patch but the reproducer is still 
triggering an issue:
general protection fault in __smc_diag_dump
"

Thus follow the instructions in this link to make tests.

https://groups.google.com/g/syzkaller-bugs/c/YwENRImdcsk/m/wBJo6qGiCAAJ?pli=1, 
the following can trigger the reproducer.

"
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
"

Zhu Yanjun

> 
> /P
> 


