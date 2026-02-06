Return-Path: <linux-rdma+bounces-16647-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YB4QA+/QhWmOGwQAu9opvQ
	(envelope-from <linux-rdma+bounces-16647-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 12:30:55 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAE6FD429
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 12:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C711D304482B
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Feb 2026 11:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FA039B4AA;
	Fri,  6 Feb 2026 11:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="szsMUJFu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC15B3612FE;
	Fri,  6 Feb 2026 11:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770377323; cv=none; b=d+w+90sOEMDlsbaEg7EH8FzZCNuylZHkGh2raJbOecqfRFxu/eBePjggXxSoGZIKXNktOtj0WVCVtxavRso+21WhlPBt5EmwlhnFXp42tzyDyTAUxFNgwIPgFyWm7dEe5cwKTTN5r11+pQJxBk4R8/4UrgWbRiRwEisQwtkJ1sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770377323; c=relaxed/simple;
	bh=JgSJjFBoJ6G/hvzkLBd8oLvVfz/qLRCc6jya47thU8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VtMJtst68G+ZT2hHGb1Xu8z28gEmxfq8yWwhpWI6frsM357/GWmfEy2eVYKae927FZBKC14rlpr5uijBRvY/q2g/AIEcnbdGasx9NJXrdX7cVDbh1AJY6eJ3/J+NKPBVUX2KzMwtY+aW5t33/k7TaY16EgVJOiOn3d5lclNRFQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=szsMUJFu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 615JVshe003785;
	Fri, 6 Feb 2026 11:28:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1K0j0X
	fJNKL0L34vWuNrRH/Z81eur0Fl8eF8ZruQejw=; b=szsMUJFuUZHuLlkFNoIoNf
	hbuusbYPzPmtDQf2654hSO6i84P+WJORQmEhqihi2F6rRj0306iM2YXohpVDDxOg
	QpTc4Q8VQRyOSjod2g310jOhcbTTpZQKhVUU7byLwfQ8kji0psUKgxlBbQijNxKu
	1MwdjUtpdbZxnhUfbc7Q9fnPr0w29pGcTzXP/oxygXGaRye3/8lZ7HH2rKusdCFv
	T+NOZlPFOrmlZiDQo6W1YbF/01+YQYoco2d2Bh3vAZBTSoC4BWPAR+axsEj4oACf
	Gfj95t/EPi2Ev4YP2CqMBzLw/zQNimGuKBDsbU8poAzvK/xqDn/D3aBmklmB7VRA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19f6ubpq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 11:28:32 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 616BSVab010057;
	Fri, 6 Feb 2026 11:28:31 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19f6ubph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 11:28:31 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 616B4Mce029068;
	Fri, 6 Feb 2026 11:28:30 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c1v2sp10j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 11:28:30 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 616BSTR232244322
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Feb 2026 11:28:30 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD3DA58059;
	Fri,  6 Feb 2026 11:28:29 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2679D58057;
	Fri,  6 Feb 2026 11:28:25 +0000 (GMT)
Received: from [9.124.217.92] (unknown [9.124.217.92])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Feb 2026 11:28:24 +0000 (GMT)
Message-ID: <daefb72f-398e-489f-bdbc-db997ef9c5ae@linux.ibm.com>
Date: Fri, 6 Feb 2026 16:58:23 +0530
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next] net/smc: transition to RDMA core CQ pooling
To: "D. Wythe" <alibuda@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dust Li
 <dust.li@linux.alibaba.com>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>
Cc: Simon Horman <horms@kernel.org>, Tony Lu <tonylu@linux.alibaba.com>,
        Wen Gu <guwen@linux.alibaba.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, oliver.yang@linux.alibaba.com,
        pasic@linux.ibm.com
References: <20260202094800.30373-1-alibuda@linux.alibaba.com>
Content-Language: en-US
From: Mahanta Jambigi <mjambigi@linux.ibm.com>
In-Reply-To: <20260202094800.30373-1-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _eLQlDoxSS_4-LIBWonMyKSASxBRwjxQ
X-Authority-Analysis: v=2.4 cv=drTWylg4 c=1 sm=1 tr=0 ts=6985d060 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=ZXMefEPHVli-rlfv-woA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 2bSCMHaMJlFNHQRvMtB2pK9ahYljxBGp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDA3OSBTYWx0ZWRfX+DJBtek+XVXm
 HgnZ3bFZaNShwqKnQXUN8JjlbtOZD8S2DDYrqYgcZc3Aovc0OlZV+ksgDjT2gA1zy1zGW19MtAQ
 +o1YB65pixEDr+XoaN1IMEOGZUKSF7Z+4QKh1kepNhpNDo7PG5FaPuwb57ZxyBkHgcH1zfYVV1y
 4K0iEew92cJtmMWoM9wPc66OOuwjB2RQjQgwXMgA1Tce0BSurFBeu1x/uMX8DZsQs+WWwya3Bpa
 kzdKIpvH2zT3DNvTv7F9B5xYVKg3uFQpsfmkXDAVm2aRgEO1ZCK4qqSWZK59+2fOql9XQeafUcV
 6RU5TAxF1c7iQqpjvBxQxcI5qAfyHkGlGHw2aYfQirkFr+1FhDg5kMJXCXXBLw56t9yZM6v8PQI
 INWK0eQ0cB33kZpdvt51XMWHJ0eYoxsCHE6czohCDlwdEYEQoaSknpbslOU7+fpleWcupm8dAYX
 dK1pnsezu5xcCWHkblg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_03,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2602060079
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16647-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mjambigi@linux.ibm.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_TWELVE(0.00)[13];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8CAE6FD429
X-Rspamd-Action: no action



On 02/02/26 3:18 pm, D. Wythe wrote:
> The current SMC-R implementation relies on global per-device CQs
> and manual polling within tasklets, which introduces severe
> scalability bottlenecks due to global lock contention and tasklet
> scheduling overhead, resulting in poor performance as concurrency
> increases.
> 
> Refactor the completion handling to utilize the ib_cqe API and
> standard RDMA core CQ pooling. This transition provides several key
> advantages:
> 
> 1. Multi-CQ: Shift from a single shared per-device CQ to multiple
> link-specific CQs via the CQ pool. This allows completion processing
> to be parallelized across multiple CPU cores, effectively eliminating
> the global CQ bottleneck.
> 
> 2. Leverage DIM: Utilizing the standard CQ pool with IB_POLL_SOFTIRQ
> enables Dynamic Interrupt Moderation from the RDMA core, optimizing
> interrupt frequency and reducing CPU load under high pressure.
> 
> 3. O(1) Context Retrieval: Replaces the expensive wr_id based lookup
> logic (e.g., smc_wr_tx_find_pending_index) with direct context retrieval
> using container_of() on the embedded ib_cqe.
> 
> 4. Code Simplification: This refactoring results in a reduction of
> ~150 lines of code. It removes redundant sequence tracking, complex lookup
> helpers, and manual CQ management, significantly improving maintainability.
> 
> Performance Test: redis-benchmark with max 32 connections per QP
> Data format: Requests Per Second (RPS), Percentage in brackets
> represents the gain/loss compared to TCP.
> 
> | Clients | TCP      | SMC (original)      | SMC (cq_pool)       |
> |---------|----------|---------------------|---------------------|
> | c = 1   | 24449    | 31172  (+27%)       | 34039  (+39%)       |
> | c = 2   | 46420    | 53216  (+14%)       | 64391  (+38%)       |
> | c = 16  | 159673   | 83668  (-48%)  <--  | 216947 (+36%)       |
> | c = 32  | 164956   | 97631  (-41%)  <--  | 249376 (+51%)       |
> | c = 64  | 166322   | 118192 (-29%)  <--  | 249488 (+50%)       |
> | c = 128 | 167700   | 121497 (-27%)  <--  | 249480 (+48%)       |
> | c = 256 | 175021   | 146109 (-16%)  <--  | 240384 (+37%)       |
> | c = 512 | 168987   | 101479 (-40%)  <--  | 226634 (+34%)       |
> 
> The results demonstrate that this optimization effectively resolves the
> scalability bottleneck, with RPS increasing by over 110% at c=64
> compared to the original implementation.

I applied your patch to the latest kernel(6.19-rc8) & saw below
Performance results:

1) In my evaluation, I ran several *uperf* based workloads using a
request/response (RR) pattern, and I observed performance *degradation*
ranging from *4%* to *59%*, depending on the specific read/write sizes
used. For example, with a TCP RR workload using 50 parallel clients
(nprocs=50) sending a 200‑byte request and reading a 1000‑byte response
over a 60‑second run, I measured approximately 59% degradation compared
to SMC‑R original performance.

2) In contrast, with uperf *streaming‑type* workloads, your patch shows
clear gains. I observed performance *improvement* ranging from *11%* to
*75%*, again depending on the specific streaming parameters. One
representative case is a TCP streaming/bulk‑receive workload with 250
parallel clients (nprocs=250) performing 640 reads per burst with 30 KB
per read, running continuously for 60 seconds, where I measured
approximately *75%* *improvement* over the SMC‑R original performance.

Note: I ran above tests with default WR(work request buffers), default
receive & transmit buffer size with smc_run.

I am looking for additional details regarding the redis-benchmark
performance results you previously shared. I would like to understand
whether the workload behaved more like a traditional request/response
(RR) pattern or a streaming-type workload, and what SMC‑R configuration
was used during the tests?

1) SMC Work Request (WR) Settings - Did your test environment use the
default SMC‑R work request buffers?
  net.smc.smcr_max_recv_wr = 48
  net.smc.smcr_max_send_wr = 16
2) SMC-R Buffer sizes used via smc_run - Did you use default transmit &
receive buffer sizes(smc_run -r <recv_size> -t <send_size>)?
3) Additional system or network tuning e.g CPU affinity, NIC offload
settings etc?

