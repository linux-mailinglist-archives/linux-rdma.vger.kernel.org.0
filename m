Return-Path: <linux-rdma+bounces-17281-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0ODFKaIgoWn9qQQAu9opvQ
	(envelope-from <linux-rdma+bounces-17281-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 05:42:10 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 064321B2BAC
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 05:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B34FD305749B
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 04:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D1A361678;
	Fri, 27 Feb 2026 04:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ccpSCF6F"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77ABB361673;
	Fri, 27 Feb 2026 04:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772167314; cv=none; b=QjjmSCal3uG4a+ooSEuTYlWrhiApnsaB1oekeDJ3DXromtXdXP3acALDsHmgVDu67DCzmXM+HfpunTvnHoBdnZIC9plpQr5NLhBK0iz+H13RjY9Z5UwmLxzyiiNzeOYU28Dd+jb94q38An23uX2pKA3CD8hcth6VemOVP3S255M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772167314; c=relaxed/simple;
	bh=crZTA+Ej7c7BrEK0261uy783ifbl5T43ZJgQmMPx5bo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=abaFLccw6my2OucR9ZIoAFod/ZhTbf702KFRvKStzlokIhC7ktaEbrauFNf3GXy9XwpUv6flvyZ6xfOF4tGovckAxP7CPjXZi5TYZ9SB/wvbz1T3v7bHH/VVU8wZv3mD3tCLgGJ7bcuZ0buvQmD8myZrigdpholMgJjrbYWKRxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ccpSCF6F; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QN63qo2870425;
	Fri, 27 Feb 2026 04:41:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1PGIUK
	AXxs2bpiKfvzUW0d8IkxsRc2M+oZGlK9/N6f4=; b=ccpSCF6F/zCwr+BcwvPJmJ
	A3DvuUOSQZXKtR6XyFYGvj1M/ngGgdQtYl7H3nMFa3utA888zvAX+VZjOuq86Lul
	FX6xHudgde83SexT+vA4IozxK0zqBIbc+zoplyQa9PCxYWUmPHtYLD1bNmFR9SNy
	zSQF6B2ALMBY+j9lwXn+nxUZxGue+C8XHfwR4v1QfoC3iuUkxaydpcAPvcLaxRLm
	bIsqRag6lF5OljGrTfJKOCyOz1DNo7lCFHqOwpVqDepmjDcjcs/GGoeA0fKPrbUB
	zc2qKQD1O42tVCnuNj6vY6mJTQl7ZMUYiXyBpskiC89moX7IRjr8Y2fkzGPG5xWA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4bs9t90-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 04:41:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61R4C2w8030267;
	Fri, 27 Feb 2026 04:41:46 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cfrhkr1b9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 04:41:46 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61R4fjhc32244350
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Feb 2026 04:41:45 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 65A355805F;
	Fri, 27 Feb 2026 04:41:45 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 39BC858059;
	Fri, 27 Feb 2026 04:41:40 +0000 (GMT)
Received: from [9.124.208.121] (unknown [9.124.208.121])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Feb 2026 04:41:39 +0000 (GMT)
Message-ID: <93779e14-95cc-4149-b4a6-865f8e3d4a96@linux.ibm.com>
Date: Fri, 27 Feb 2026 10:11:38 +0530
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next] net/smc: transition to RDMA core CQ pooling
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: "David S. Miller" <davem@davemloft.net>,
        Dust Li <dust.li@linux.alibaba.com>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Wenjia Zhang
 <wenjia@linux.ibm.com>, Simon Horman <horms@kernel.org>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        oliver.yang@linux.alibaba.com, pasic@linux.ibm.com
References: <20260202094800.30373-1-alibuda@linux.alibaba.com>
 <daefb72f-398e-489f-bdbc-db997ef9c5ae@linux.ibm.com>
 <20260209075338.GA61095@j66a10360.sqa.eu95>
 <2d71bab3-161d-414e-90e3-0e408ca931c2@linux.ibm.com>
 <20260224021924.GA53803@j66a10360.sqa.eu95>
Content-Language: en-US
From: Mahanta Jambigi <mjambigi@linux.ibm.com>
In-Reply-To: <20260224021924.GA53803@j66a10360.sqa.eu95>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: pNvPn2sHG14hiX46wf5UKqYPx8oF_jQL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDAzNCBTYWx0ZWRfXx6WWfamxPlLg
 bNtFwvg5JIjHcD1Wu38YgDdHWeyGS48Vupc2wLhgofh7omoZ6CeQKqoiGrSymGpY1xwvTR92SMC
 sFQ4T5GpyiU7docCKuWafJ3rwFVRhRIBdh4TrSVCaHjJiglii+XPbJRnDSdVm5aqZuPNFkH0u5K
 orCBfEgLJdf4qF7gtemFRBPyRvKZ95FWQ0UPYY9ehzFUyjpiuvOFz1ekA4pktLu55ueSWUPfA09
 UbUv/TKdPEkMyBT92Cu8prjB8GBXMTGnb5EhAPHBRdCC1STNbdjX2srOkRzoTwtRze9p6jls3QT
 TpWKXN3v95FtPK3VboFhKzKK0fHzqa5Lcz30U1SsS3P+bflx34UlWplFkzQuA+dxqr7q5gtYIQK
 gmbrWDOVrCof75RRfF7rlAjRs5Sf3y/a706FFB448Uk9F8AdIP9V8MqlpUGHUh1Pd9xh/9j0+tq
 Mw12Nh8V38q729Ielng==
X-Authority-Analysis: v=2.4 cv=eNceTXp1 c=1 sm=1 tr=0 ts=69a1208b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=KFbtujwD9d188Aqvv-QA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ob1o3a-7dAjm5dkH_lGYA3DimTJbH9ZQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602270034
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-17281-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mjambigi@linux.ibm.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 064321B2BAC
X-Rspamd-Action: no action



On 24/02/26 7:49 am, D. Wythe wrote:
> On Fri, Feb 13, 2026 at 04:53:28PM +0530, Mahanta Jambigi wrote:
>>
>>
>> On 09/02/26 1:23 pm, D. Wythe wrote:
>>> On Fri, Feb 06, 2026 at 04:58:23PM +0530, Mahanta Jambigi wrote:
>>>>
>>>>
>>>> On 02/02/26 3:18 pm, D. Wythe wrote:
>>>>> The current SMC-R implementation relies on global per-device CQs
>>>>> and manual polling within tasklets, which introduces severe
>>>>> scalability bottlenecks due to global lock contention and tasklet
>>>>> scheduling overhead, resulting in poor performance as concurrency
>>>>> increases.
>>>>>
>>>>> Refactor the completion handling to utilize the ib_cqe API and
>>>>> standard RDMA core CQ pooling. This transition provides several key
>>>>> advantages:
>>>>>
>>>>> 1. Multi-CQ: Shift from a single shared per-device CQ to multiple
>>>>> link-specific CQs via the CQ pool. This allows completion processing
>>>>> to be parallelized across multiple CPU cores, effectively eliminating
>>>>> the global CQ bottleneck.
>>>>>
>>>>> 2. Leverage DIM: Utilizing the standard CQ pool with IB_POLL_SOFTIRQ
>>>>> enables Dynamic Interrupt Moderation from the RDMA core, optimizing
>>>>> interrupt frequency and reducing CPU load under high pressure.
>>>>>
>>>>> 3. O(1) Context Retrieval: Replaces the expensive wr_id based lookup
>>>>> logic (e.g., smc_wr_tx_find_pending_index) with direct context retrieval
>>>>> using container_of() on the embedded ib_cqe.
>>>>>
>>>>> 4. Code Simplification: This refactoring results in a reduction of
>>>>> ~150 lines of code. It removes redundant sequence tracking, complex lookup
>>>>> helpers, and manual CQ management, significantly improving maintainability.
>>>>>
>>>>> Performance Test: redis-benchmark with max 32 connections per QP
>>>>> Data format: Requests Per Second (RPS), Percentage in brackets
>>>>> represents the gain/loss compared to TCP.
>>>>>
>>>>> | Clients | TCP      | SMC (original)      | SMC (cq_pool)       |
>>>>> |---------|----------|---------------------|---------------------|
>>>>> | c = 1   | 24449    | 31172  (+27%)       | 34039  (+39%)       |
>>>>> | c = 2   | 46420    | 53216  (+14%)       | 64391  (+38%)       |
>>>>> | c = 16  | 159673   | 83668  (-48%)  <--  | 216947 (+36%)       |
>>>>> | c = 32  | 164956   | 97631  (-41%)  <--  | 249376 (+51%)       |
>>>>> | c = 64  | 166322   | 118192 (-29%)  <--  | 249488 (+50%)       |
>>>>> | c = 128 | 167700   | 121497 (-27%)  <--  | 249480 (+48%)       |
>>>>> | c = 256 | 175021   | 146109 (-16%)  <--  | 240384 (+37%)       |
>>>>> | c = 512 | 168987   | 101479 (-40%)  <--  | 226634 (+34%)       |
>>>>>
>>>>> The results demonstrate that this optimization effectively resolves the
>>>>> scalability bottleneck, with RPS increasing by over 110% at c=64
>>>>> compared to the original implementation.
>>>>
>>>> I applied your patch to the latest kernel(6.19-rc8) & saw below
>>>> Performance results:
>>>>
>>>> 1) In my evaluation, I ran several *uperf* based workloads using a
>>>> request/response (RR) pattern, and I observed performance *degradation*
>>>> ranging from *4%* to *59%*, depending on the specific read/write sizes
>>>> used. For example, with a TCP RR workload using 50 parallel clients
>>>> (nprocs=50) sending a 200‑byte request and reading a 1000‑byte response
>>>> over a 60‑second run, I measured approximately 59% degradation compared
>>>> to SMC‑R original performance.
>>>>
>>>
>>> The only setting I changed was net.smc.smcr_max_conns_per_lgr = 32, all
>>> other parameters were left at their default values. redis-benchmark is a
>>> classic Request/Response (RR) workload, which contradicts your test
>>> results. Since I'm unable to reproduce your results, it would be
>>> very helpful if you could share the specific test configuration for my
>>> analysis.
>>
>> I used a simple client–server setup connected via 25 Gb/s RoCE_Express2
>> adapters on the same LAN(connection established via SMC-R v1). After
>> running the commands shown below, I observed a performance degradation
>> of up to 59%.
>>
>> Server: smc_run uperf -s
>> Client: smc_run uperf -m rr1c-200x1000-50.xml
>>
>> cat rr1c-200x1000-50.xml
>>
>> <?xml version="1.0"?>
>> <profile name="TCP_RR">
>> 	<group nprocs="50">
>> 		<transaction iterations="1">
>> 			<flowop type="connect" options="remotehost=server_ip protocol=tcp
>> tcp_nodelay" />
>> 		</transaction>
>> 		<transaction duration="60">
>> 			<flowop type="write" options="size=200"/>
>> 			<flowop type="read" options="size=1000"/>
>> 		</transaction>
>> 		<transaction iterations="1">
>> 			<flowop type="disconnect" />
>> 		</transaction>
>> 	</group>
>> </profile>
> 
> Using the exact same XML profile you provided, I tested this on a 25Gb
> NIC. I observed no degradation. Instead, performance improved
> significantly:
> 
> Original: ~1.08 Gb/s
> Patched: ~5.1 Gb/s
> 
> I suspect the 59% drop might be due to connections falling back to TCP.
> Could you check smcss -a during your test to see if the traffic is
> actually running over SMC-R?

I have checked this. The connection was successful using *SMCR* Mode
itself. Also I have confirmed this via 'smcr -d stats' command which
shows 0 count for TCP fallback.

> 
>>
>> I installed redis-server on the server machine & redis-benchmark on the
>> client machine & I was able to establish the SMC-R using below commands.
>> If you could help me with the exact commands you used to measure the
>> redis-benchmark performance, I can try the same on my setup.
>>
>> Server: smc_run redis-server --port <port_num> --save "" --appendonly no
>>   --protected-mode no --bind 0.0.0.0
>> Client: smc_run redis-benchmark -h <server_ip> -p <port_num> -n 10000 -c
>> 50 -t ping_inline,ping_bulk -q
> 
> Here are the exact commands and scripts I used for the
> redis-benchmark:
> 
> Server: smc_run redis-server --protected-mode no --save
> 
> Client: smc_run redis-benchmark -h <server_ip> -n 5000000 -t set --threads 3
> -c <conn_num>
> 
> D. Wythe


