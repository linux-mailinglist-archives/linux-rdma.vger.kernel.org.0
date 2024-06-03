Return-Path: <linux-rdma+bounces-2785-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2972D8D85C2
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 17:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDDDC1F23025
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 15:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B05212D755;
	Mon,  3 Jun 2024 15:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GTCo0Kja"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD27B65C;
	Mon,  3 Jun 2024 15:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717427283; cv=none; b=KwQvcrRVVvbWKSBvmyvUCboP4FSLNnVRMriTikS91J+kkQewSV21D2+gt2E1aOHOLw8w+XFPwaENTUr8ivPpEEIRsPwkPg6OEo7vzoCZjFuMIsWAuNc21aKqzXvpKjL0D39l3wG6+Fy8+GCGROzY7byr4G4d+T5OsLVyrQVI4HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717427283; c=relaxed/simple;
	bh=VCUxvf40PeWO0v13WelMmA+xQ37dhVq8M3t69FUqGuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lC/79JfxluaLkNmKNfx9Zgznno7/FyPSt25y9QXgFzkMvULEpvh8IIXU2/JJWyyBfEGIZVThzIJeHdLMnanKwByGNvr+jcDvmbXBdkDv8wHg9o/ZEvIIWbdYwrfxzFWFZMq8XCfdQTEyojM15YVUHymMbNDy2AcOImAfH8bAUhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GTCo0Kja; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717427272; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=/4ExhM1ycUL2LB1X5E43kh09loTPzspI5pYJP1gvxPo=;
	b=GTCo0KjaqiaaCWJuSQeY3mBILLqRsA3J4jMFYM9ZDVM8hEe5cOiOcTzdG6yb3Ff/1MdSIYSAcdTzoZ98eue2VYbtr1YzVlyWnPczDdfRnLU+6+Gyua8XMwq223jk7y6dODbRtaPUFlmIEKozmH3EuNNkHp9FcuwrG59EPdgSepk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W7oJ3jY_1717427270;
Received: from 192.168.50.173(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0W7oJ3jY_1717427270)
          by smtp.aliyun-inc.com;
          Mon, 03 Jun 2024 23:07:51 +0800
Message-ID: <24a12884-415c-43ce-8353-cc92af1e7aa1@linux.alibaba.com>
Date: Mon, 3 Jun 2024 23:07:49 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 0/3] Introduce IPPROTO_SMC
To: Niklas Schnelle <schnelle@linux.ibm.com>, kgraul@linux.ibm.com,
 wenjia@linux.ibm.com, jaka@linux.ibm.com, wintera@linux.ibm.com,
 guwen@linux.alibaba.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
 tonylu@linux.alibaba.com, pabeni@redhat.com, edumazet@google.com
References: <1717061440-59937-1-git-send-email-alibuda@linux.alibaba.com>
 <bd80b8f9-9c86-4a9b-a7ba-07471dcd5a7c@linux.alibaba.com>
 <22e38d2f32c4a25615e8bda24b089202864a4d10.camel@linux.ibm.com>
Content-Language: en-US
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <22e38d2f32c4a25615e8bda24b089202864a4d10.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 6/3/24 3:48 PM, Niklas Schnelle wrote:
> On Thu, 2024-05-30 at 18:14 +0800, D. Wythe wrote:
>> On 5/30/24 5:30 PM, D. Wythe wrote:
>>> From: "D. Wythe" <alibuda@linux.alibaba.com>
>>>
>>> This patch allows to create smc socket via AF_INET,
>>> similar to the following code,
>>>
>>> /* create v4 smc sock */
>>> v4 = socket(AF_INET, SOCK_STREAM, IPPROTO_SMC);
>>>
>>> /* create v6 smc sock */
>>> v6 = socket(AF_INET6, SOCK_STREAM, IPPROTO_SMC);
>> Welcome everyone to try out the eBPF based version of smc_run during
>> testing, I have added a separate command called smc_run.bpf,
>> it was equivalent to normal smc_run but with IPPROTO_SMC via eBPF.
>>
>> You can obtain the code and more info from:
>> https://github.com/D-Wythe/smc-tools
>>
>> Usage:
>>
>> smc_run.bpf
>> An eBPF implemented smc_run based on IPPROTO_SMC:
>>
>> 1. Support to transparent replacement based on command (Just like smc_run).
>> 2. Supprot to transparent replacement based on pid configuration. And
>> supports the inheritance of this capability between parent and child
>> processes.
>> 3. Support to transparent replacement based on per netns configuration.
>>
>> smc_run.bpf COMMAND
>>
>> 1. Equivalent to smc_run but with IPPROTO_SMC via eBPF
>>
>> smc_run.bpf -p pid
>>
>>    1. Add the process with target pid to the map. Afterward, all socket()
>> calls of the process and its descendant processes will be replaced from
>> IPPROTO_TCP to IPPROTO_SMC.
>>    2. Mapping will be automatically deleted when process exits.
>>    3. Specifically, COMMAND mode is actually works like following:
>>
>>       smc_run.bpf -p $$
>>       COMMAND
>>       exit
>>
>> smc_run.bpf -n 1
>>
>>    1. Make all socket() calls of the current netns to be replaced from
>> IPPROTO_TCP to IPPROTO_SMC.
>>    2. Turn off it by smc_run.bpf -n 0
>>
>>
> Hi D. Wythe,
>
> I gave this series plus your smc_run.bpf and SMC_LO based SMC-D a test
> run on my Ryzen 3900X workstation and I have to say I'm quite
> impressed. I first tried the SMC_LO feature as merged in v6.10-rc1 with
> the classic LD_PRELOAD based smc_run and iperf3, and qperf …
> tcp_bw/tcp_lat both with normal localhost and between docker
> containers. For this to work I of course had to initially set my UEID
> as x86_64 unlike s390x doesn't get an SEID set. I used the following
> script for this.
>
>
> #!/usr/bin/sh
> machine_id_upper=$(cat /etc/machine-id | tr '[:lower:]' '[:upper:]')
> machine_id_suffix=$(echo "$machine_id_upper" | head -c 27)
> ueid="MID-$machine_id_suffix"
> smcd ueid add "$ueid"
>
>
> The performance is pretty impressive:
> * iperf3 with 12 parallel connections (matching core count) results in
>    ~152 Gbit/s on normal loopback and ~312 Gbit/s with SMC_LO.
> * qperf … tcp_bw (single thread) results in ~46 Gbit/s on normal loopback
>    and ~58 Gbit/s with SMC_LO
> * qperf … tcp_lat latency test results in 5-9 us with normal loopback
>    and around 3-4 us with SMC_LO
>
> Then I applied this series on top of v6.10-rc1 and tried it with your
> smc_run.bpf. The performance is of course in-line with the above but
> thanks to being able to enable SMC on a per-netns basis I was able to
> try a few more thing. First I tried just enabling it in my default
> netns and verified that after restarting sshd new ssh connections to
> localhost used SMC-D through SMC_LO. Then I started Chrome and
> confirmed that its TCP connections also registered with SMC and
> successfully fell back to TCP mode. I had no trouble with normal
> browsing though I guess especially Google stuff often uses HTTP/3 so
> isn't affected. Still nice to see I didn't get breakage.
>
> Secondly I tried smc_run.bpf with docker containers using the following
> trick:
>
> docker inspect --format '{{.State.Pid}}' <my_container_name>
> 34651
> nsenter -t 34651 -n smc_run.bpf -n 1
>
> Sadly this only works for commands started in the container after
> loading the BPF. So I wonder if you know of a good way to either
> automatically execute smc_run.bpf on container start or maybe use it on
> the docker daemon such that all namespaces created by docker get the
> IPPROTO_SMC override. I'd then definitely consider using SMC-D with
> SMC_LO between my home lab containers even if just for bragging rights
> ;-)
>
> Feel free to add for the IPPROTO_SMC series:
>
> Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
>
> Thanks,
> Niklas

Hi Niklas ,

Thanks very much for your testing.

Regarding your question, have you ever tried starting the container 
using 'smc_run.bpf docker' ?

The smc_run.bpf allows the capability for replacement to be inherited by 
descendant processes. This might meet your needs.
However, it should be noted that this scope would no longer be limited 
to netns.

If you don't want to replace the docker command and would like to keep 
per netns, there are indeed some tricky ways, for example,
we could check current process name when creating new netns to decide if 
we should add it to the ebpf-map,
but I think it's not appropriate to include this in smc_run.bpf.

Best wishes,
D. Wythe



