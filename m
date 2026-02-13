Return-Path: <linux-rdma+bounces-16866-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BwfF8kJj2ngHQEAu9opvQ
	(envelope-from <linux-rdma+bounces-16866-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 12:23:53 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCF8135B48
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 12:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B420330027D6
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 11:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B182D47F1;
	Fri, 13 Feb 2026 11:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="g9Vn0/s/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6303EBF00;
	Fri, 13 Feb 2026 11:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770981829; cv=none; b=gtv5QZr8Xbt2nacX1CRBxXyaX/wD2iA3M0XyteCY8/pfjMHbfSOTY9XGgmliq64PoCCjvYTYpv8Yz/w9WQ9f0W95GWedkcfCixkut7QCugQfp/THqYOoMOabg/d/scCkGNAwl6bCJ+VNuw8avj/zsIQMzyHk/akeMfa4KoHcO7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770981829; c=relaxed/simple;
	bh=oJdk4rsPzXvqm8MPFXlGfOdBaLbte1BfisVEey6Z6dc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MvYiVHh4n2wTRWBnk9hFXU8j1c6b1dbGnXfkzBO8cEtAFynZ9WPFYQpwnOpag+JTcJ2XxR/97FiKkFh2hw1V1gcfvHNMLVvWNDqpwW05yz4Uq2DdW1i5PRo52mQy4N37nC3GxUNNO1pxlWnZH77P1jcpeiMyItjUa+6PLoSkdIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=g9Vn0/s/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61D9MUjq311754;
	Fri, 13 Feb 2026 11:23:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mgZ4Ok
	pQcTQA7VFHXs53msgZURDuFhV6mbkVp0Vihp8=; b=g9Vn0/s/pd0oM2CWK5nEeW
	KLh8MHAEw7xU3cW3VU4boyB0K2nAGcyV0XR63/W7a9Rnx0KVa7vJy2MXjBVACYPl
	4lw1kfjUNwCTibAce0eo92sZB/smhF7cWyZVDaqrEx9d0nQeNiExcnJl8Lsa29o1
	QHVwZQyRzpk1dZflAKf7jOUSQIznVHeaaQeX0qBXUtFjSbCPKILgneUXcSgwtMN8
	DMeSkmsUEWW3/vxY+FqsLD/1nyUVmbq0fdoE8/BNRMT/PH69KIX9kRwdIbwDe6np
	p8q9b70hmmeUZ8/OoObcjTB2MgJLaodC6qS5N2f7ODj0zm+m1ZeTib1lky9TDDZw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696utnu4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Feb 2026 11:23:43 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61D94sZM012611;
	Fri, 13 Feb 2026 11:23:37 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c6h7kpegm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Feb 2026 11:23:37 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61DBNZcD24576578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Feb 2026 11:23:35 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D0305805F;
	Fri, 13 Feb 2026 11:23:35 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A4A758043;
	Fri, 13 Feb 2026 11:23:30 +0000 (GMT)
Received: from [9.39.24.29] (unknown [9.39.24.29])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Feb 2026 11:23:29 +0000 (GMT)
Message-ID: <2d71bab3-161d-414e-90e3-0e408ca931c2@linux.ibm.com>
Date: Fri, 13 Feb 2026 16:53:28 +0530
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
Content-Language: en-US
From: Mahanta Jambigi <mjambigi@linux.ibm.com>
In-Reply-To: <20260209075338.GA61095@j66a10360.sqa.eu95>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=YZiwJgRf c=1 sm=1 tr=0 ts=698f09c0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=sCxrbXXTP0iVI5IyWHIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: YMBInZTsF0iReiqleGmzV9rtjq0lA3Ln
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA4NyBTYWx0ZWRfX2ZXZvS03WpgZ
 xjlA6FSncLY4fquK3+Tx/ApJ/pwHcVYkjn4ZrbrQGzmHbC486ssaf5jIR3yD/K2T5+maZOjnGze
 AXcxe983doBoUm1CE9lJQs/bqe+eRHBa6QLhsMz93ZAMBciKydSMUcEIPMVRFs+u9y754CREel4
 zgO3/Ow501J4nMDUdYx4jn2w8XvY2CkmwGDB8inTRQd7bWx9/L3lFIi3vWLTWqG3bZ/y4nr75V6
 5aWcmk8QygTu6sKuUrVdV5BrQhNYbtTW1LZA7uEA+oy+Dg4iSS6Fkc0F2C6sS0lD547F0P1Y95A
 vfDfNF3Ns8y3FyoGp2z8xOoqCJCB9Gbk2rqbtgBnoFmdtO6ak/l8Y3GQiAg6jIStDFwSf0NC/Dq
 V+POv7vqUbxJCd/x0DfwSscyimZNTvKjTDVkQi8C3P0ch8EjJ5IrPhQZ6k8PZnFi4sECP65baeQ
 6XQAx8hv59H4J4yXGtA==
X-Proofpoint-GUID: fH95bB4F1c2GTD7iNl3j9nufPkURUWjM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_02,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602130087
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mjambigi@linux.ibm.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16866-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+]
X-Rspamd-Queue-Id: CDCF8135B48
X-Rspamd-Action: no action



On 09/02/26 1:23 pm, D. Wythe wrote:
> On Fri, Feb 06, 2026 at 04:58:23PM +0530, Mahanta Jambigi wrote:
>>
>>
>> On 02/02/26 3:18 pm, D. Wythe wrote:
>>> The current SMC-R implementation relies on global per-device CQs
>>> and manual polling within tasklets, which introduces severe
>>> scalability bottlenecks due to global lock contention and tasklet
>>> scheduling overhead, resulting in poor performance as concurrency
>>> increases.
>>>
>>> Refactor the completion handling to utilize the ib_cqe API and
>>> standard RDMA core CQ pooling. This transition provides several key
>>> advantages:
>>>
>>> 1. Multi-CQ: Shift from a single shared per-device CQ to multiple
>>> link-specific CQs via the CQ pool. This allows completion processing
>>> to be parallelized across multiple CPU cores, effectively eliminating
>>> the global CQ bottleneck.
>>>
>>> 2. Leverage DIM: Utilizing the standard CQ pool with IB_POLL_SOFTIRQ
>>> enables Dynamic Interrupt Moderation from the RDMA core, optimizing
>>> interrupt frequency and reducing CPU load under high pressure.
>>>
>>> 3. O(1) Context Retrieval: Replaces the expensive wr_id based lookup
>>> logic (e.g., smc_wr_tx_find_pending_index) with direct context retrieval
>>> using container_of() on the embedded ib_cqe.
>>>
>>> 4. Code Simplification: This refactoring results in a reduction of
>>> ~150 lines of code. It removes redundant sequence tracking, complex lookup
>>> helpers, and manual CQ management, significantly improving maintainability.
>>>
>>> Performance Test: redis-benchmark with max 32 connections per QP
>>> Data format: Requests Per Second (RPS), Percentage in brackets
>>> represents the gain/loss compared to TCP.
>>>
>>> | Clients | TCP      | SMC (original)      | SMC (cq_pool)       |
>>> |---------|----------|---------------------|---------------------|
>>> | c = 1   | 24449    | 31172  (+27%)       | 34039  (+39%)       |
>>> | c = 2   | 46420    | 53216  (+14%)       | 64391  (+38%)       |
>>> | c = 16  | 159673   | 83668  (-48%)  <--  | 216947 (+36%)       |
>>> | c = 32  | 164956   | 97631  (-41%)  <--  | 249376 (+51%)       |
>>> | c = 64  | 166322   | 118192 (-29%)  <--  | 249488 (+50%)       |
>>> | c = 128 | 167700   | 121497 (-27%)  <--  | 249480 (+48%)       |
>>> | c = 256 | 175021   | 146109 (-16%)  <--  | 240384 (+37%)       |
>>> | c = 512 | 168987   | 101479 (-40%)  <--  | 226634 (+34%)       |
>>>
>>> The results demonstrate that this optimization effectively resolves the
>>> scalability bottleneck, with RPS increasing by over 110% at c=64
>>> compared to the original implementation.
>>
>> I applied your patch to the latest kernel(6.19-rc8) & saw below
>> Performance results:
>>
>> 1) In my evaluation, I ran several *uperf* based workloads using a
>> request/response (RR) pattern, and I observed performance *degradation*
>> ranging from *4%* to *59%*, depending on the specific read/write sizes
>> used. For example, with a TCP RR workload using 50 parallel clients
>> (nprocs=50) sending a 200‑byte request and reading a 1000‑byte response
>> over a 60‑second run, I measured approximately 59% degradation compared
>> to SMC‑R original performance.
>>
> 
> The only setting I changed was net.smc.smcr_max_conns_per_lgr = 32, all
> other parameters were left at their default values. redis-benchmark is a
> classic Request/Response (RR) workload, which contradicts your test
> results. Since I'm unable to reproduce your results, it would be
> very helpful if you could share the specific test configuration for my
> analysis.

I used a simple client–server setup connected via 25 Gb/s RoCE_Express2
adapters on the same LAN(connection established via SMC-R v1). After
running the commands shown below, I observed a performance degradation
of up to 59%.

Server: smc_run uperf -s
Client: smc_run uperf -m rr1c-200x1000-50.xml

cat rr1c-200x1000-50.xml

<?xml version="1.0"?>
<profile name="TCP_RR">
	<group nprocs="50">
		<transaction iterations="1">
			<flowop type="connect" options="remotehost=server_ip protocol=tcp
tcp_nodelay" />
		</transaction>
		<transaction duration="60">
			<flowop type="write" options="size=200"/>
			<flowop type="read" options="size=1000"/>
		</transaction>
		<transaction iterations="1">
			<flowop type="disconnect" />
		</transaction>
	</group>
</profile>

I installed redis-server on the server machine & redis-benchmark on the
client machine & I was able to establish the SMC-R using below commands.
If you could help me with the exact commands you used to measure the
redis-benchmark performance, I can try the same on my setup.

Server: smc_run redis-server --port <port_num> --save "" --appendonly no
  --protected-mode no --bind 0.0.0.0
Client: smc_run redis-benchmark -h <server_ip> -p <port_num> -n 10000 -c
50 -t ping_inline,ping_bulk -q

