Return-Path: <linux-rdma+bounces-6372-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B2A9EA943
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2024 08:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9597518835CD
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2024 07:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05CF22CBE7;
	Tue, 10 Dec 2024 07:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="q7lGGmHB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2E522617C;
	Tue, 10 Dec 2024 07:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733814439; cv=none; b=EDDDkISyVECXInZm8S4ZFPAvWzeo4+rBxfHKgCh2zIvjlOT8I361U/IG5Fq3Bg5qa0CW/a8ViLR1HVdV9fhDUoIbvnk1JXpw9TVOiHEyv3S4N8BFmiwU9vF+RQwdowPvGoToBQ13y3EYY9Cn7kJeJ1GkxdeFqtZSGo1TlFbSMpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733814439; c=relaxed/simple;
	bh=21yYhE3JbhGoBWJsgIJYYeuG7B7/nF2qsxltmh9NDKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ig6Qz9T3hOsoZ9qswtUdfecFsa9qkAvS2X59mx/GATsLc747a4NJGS/aINrntWJylkahm1ZPSCGYTvtYGK5U13rePkDu188BuLxDlD1GEz/zK9k2L7/3g4ZhlUtShfdEw0POIV9KKcyJ+9FDJVUAEwD9t6GBXRvVCUOYfo3PW+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=q7lGGmHB; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733814427; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=DCSpoueBZE9y2EqJgZJxE02iPNXEzifaehYh+skOFvs=;
	b=q7lGGmHBkO89AIDcpa3JHCdyUCG1Incd5pzr5H+5wk86rW23xZjW7ztFL9IPZofzH6EJVjcQamjotLra+d3KY99pmoJNwyogGfMO3PY/OPHOAds7T2SxSqjQor3SZJAyn1e22Z49bN3afKLFDTOYwRfcAzUwJ6fapZejWnL+Gfo=
Received: from 30.221.101.48(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0WLE42aD_1733814424 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 10 Dec 2024 15:07:06 +0800
Message-ID: <58075d86-b43a-4d58-bf64-c29418f99143@linux.alibaba.com>
Date: Tue, 10 Dec 2024 15:07:04 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] net/smc: support ipv4 mapped ipv6 addr
 client for smc-r v2
To: Halil Pasic <pasic@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>
Cc: jaka@linux.ibm.com, alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 guwen@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dust Li <dust.li@linux.alibaba.com>
References: <20241202125203.48821-1-guangguan.wang@linux.alibaba.com>
 <20241202125203.48821-3-guangguan.wang@linux.alibaba.com>
 <894d640f-d9f6-4851-adb8-779ff3678440@linux.ibm.com>
 <20241205135833.0beafd61.pasic@linux.ibm.com>
 <5ac2c5a7-3f12-48e5-83a9-ecd3867e6125@linux.alibaba.com>
 <7de81edd-86f2-4cfd-95db-e273c3436eb6@linux.ibm.com>
 <3710a042-cabe-4b6d-9caa-fd4d864b2fdc@linux.ibm.com>
 <d2af79e2-adb2-46f0-a7e3-67a9265f3adf@linux.alibaba.com>
 <868f5d66-ac74-4b0a-a0d0-e44fdea3bb73@linux.ibm.com>
 <20241209104647.5c36c429.pasic@linux.ibm.com>
 <85d1c6e1-0fe3-4c71-af4e-8015270b90dc@linux.alibaba.com>
 <20241209214449.0bb5afce.pasic@linux.ibm.com>
Content-Language: en-US
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
In-Reply-To: <20241209214449.0bb5afce.pasic@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024/12/10 04:44, Halil Pasic wrote:
> On Mon, 9 Dec 2024 20:36:45 +0800
> Guangguan Wang <guangguan.wang@linux.alibaba.com> wrote:
> 
>>> I believe we would like to have a v3 here. Also I'm not sure
>>> checking on saddr is sufficient, but I didn't do my research on
>>> that question yet.
>>>
>>> Regards,
>>> Halil  
>>
>> Did you mean to research whether the daddr should be checked too?
> 
> Right! Or is it implied that if saddr is a ipv4 mapped ipv6 addr
> then the daddr must be ipv4 mapped ipv6 addr as well?
> 
> Regards,
> Halil

I did a test by iperf3:
A server with IPV4 addr 11.213.5.33/24 and real IPV6 addr 2012::1/64.
A client with IPV4 addr 11.213.5.5/24 and real IPV6 addr 2012::2/64.
iperf3 fails to run when server listen on IPV6 addr and client connect
to server using IPV4 mapped IPV6 addr. commands show below:
server: smc_run iperf3 -s -6 -B 2012::1
client: smc_run iperf3 -t 10 -c 2012::1 -6 -B ::ffff:11.213.5.5

Failure happened due to the connect() function got the errno -EAFNOSUPPORT,
I also located the kernel code where the -EAFNOSUPPORT is returned
(https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/net/ipv6/ip6_output.c#:~:text=err%20%3D%20%2DEAFNOSUPPORT%3B).
The call stack is:
ip6_dst_lookup_tail+1
ip6_dst_lookup_flow+55
tcp_v6_connect+743
__inet_stream_connect+181
inet_stream_connect+59
kernel_connect+109
smc_connect+239
__sys_connect+179
__x64_sys_connect+26
do_syscall_64+112
entry_SYSCALL_64_after_hwframe+118

The kernel code mentioned above restricts that when the saddr is ipv4
mapped ipv6 addr, the daddr should be either ipv4 mapped ipv6 addr or
ipv6_addr_any(::). As far as I know, the ipv6_addr_any daddr is used
to connect to a server listen on ipv6_addr_any(::) by loopback connection.

Thus, based on the test and the code, I think it has the restrict that for
SMC-Rv2 if saddr is a ipv4 mapped ipv6 addr then the daddr must be
ipv4 mapped ipv6 addr as well.

Thanks,
Guangguan Wang

