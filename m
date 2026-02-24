Return-Path: <linux-rdma+bounces-17090-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHPDJboKnWmtMgQAu9opvQ
	(envelope-from <linux-rdma+bounces-17090-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 03:19:38 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D78F180F5E
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 03:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D54213045C31
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 02:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992902459ED;
	Tue, 24 Feb 2026 02:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Ndn0Pf+3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB38C1E9B1A;
	Tue, 24 Feb 2026 02:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771899571; cv=none; b=GxrtELfr6bFKEDchk8Gm/1rZb5VEVNvG2I5zV9SjMyJeHTA2mWOCwBPgbXRsJPlYobJhV1dJGjNB7DFr1Flkx2xVhvEtRX5g+Hlt5S2Tfh3r8gb5kqIKriHquXU9MIr7zqepi9d2oIRQ0qQmh6005ULDi1Cbxt/67RsW1q2II20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771899571; c=relaxed/simple;
	bh=P1/UInNRTPbopanuJYg1QuNK9n0JH1eKu+uglbJlSL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nExCm5cTQpVzr8bPw3lwve8ewUO+BEjr8wnoVZ88sE8PKjF6xFVQ5Q2g/ZpowKA8Tlo4Q7QX7vn+L08owIwnePeuMq4nx4JO6+Lup1Xi4jxEsrgg61ezzEoi4pTULq2eMgtbccdD4784OLk2zLpU4r4F4u2cNmfdo1STo25oWcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Ndn0Pf+3; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1771899565; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=9NJlGZYkY4YMHtEUyi3QBzwIAufqLmLbDzPVClrsg80=;
	b=Ndn0Pf+3yf93iNGFbLKetXLPq/P10jtU5orrsJ+wsyIeJPG8MSTHYd+EeTFBN0iWGODnc56Cwp+ixBkKOvfOhGMJdqhOp4uSSbCKzcydUONPkNwFaMCBRfvTiQ5aNoO+fipXStQuqqOqY8JBW6FmNyFKN+UCdcVBWVgTGGDigjI=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WzhsA2w_1771899564 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 24 Feb 2026 10:19:24 +0800
Date: Tue, 24 Feb 2026 10:19:24 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: Mahanta Jambigi <mjambigi@linux.ibm.com>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dust Li <dust.li@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Simon Horman <horms@kernel.org>, Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
	netdev@vger.kernel.org, oliver.yang@linux.alibaba.com,
	pasic@linux.ibm.com
Subject: Re: [PATCH RFC net-next] net/smc: transition to RDMA core CQ pooling
Message-ID: <20260224021924.GA53803@j66a10360.sqa.eu95>
References: <20260202094800.30373-1-alibuda@linux.alibaba.com>
 <daefb72f-398e-489f-bdbc-db997ef9c5ae@linux.ibm.com>
 <20260209075338.GA61095@j66a10360.sqa.eu95>
 <2d71bab3-161d-414e-90e3-0e408ca931c2@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2d71bab3-161d-414e-90e3-0e408ca931c2@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17090-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alibuda@linux.alibaba.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.alibaba.com:dkim]
X-Rspamd-Queue-Id: 2D78F180F5E
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 04:53:28PM +0530, Mahanta Jambigi wrote:
> 
> 
> On 09/02/26 1:23 pm, D. Wythe wrote:
> > On Fri, Feb 06, 2026 at 04:58:23PM +0530, Mahanta Jambigi wrote:
> >>
> >>
> >> On 02/02/26 3:18 pm, D. Wythe wrote:
> >>> The current SMC-R implementation relies on global per-device CQs
> >>> and manual polling within tasklets, which introduces severe
> >>> scalability bottlenecks due to global lock contention and tasklet
> >>> scheduling overhead, resulting in poor performance as concurrency
> >>> increases.
> >>>
> >>> Refactor the completion handling to utilize the ib_cqe API and
> >>> standard RDMA core CQ pooling. This transition provides several key
> >>> advantages:
> >>>
> >>> 1. Multi-CQ: Shift from a single shared per-device CQ to multiple
> >>> link-specific CQs via the CQ pool. This allows completion processing
> >>> to be parallelized across multiple CPU cores, effectively eliminating
> >>> the global CQ bottleneck.
> >>>
> >>> 2. Leverage DIM: Utilizing the standard CQ pool with IB_POLL_SOFTIRQ
> >>> enables Dynamic Interrupt Moderation from the RDMA core, optimizing
> >>> interrupt frequency and reducing CPU load under high pressure.
> >>>
> >>> 3. O(1) Context Retrieval: Replaces the expensive wr_id based lookup
> >>> logic (e.g., smc_wr_tx_find_pending_index) with direct context retrieval
> >>> using container_of() on the embedded ib_cqe.
> >>>
> >>> 4. Code Simplification: This refactoring results in a reduction of
> >>> ~150 lines of code. It removes redundant sequence tracking, complex lookup
> >>> helpers, and manual CQ management, significantly improving maintainability.
> >>>
> >>> Performance Test: redis-benchmark with max 32 connections per QP
> >>> Data format: Requests Per Second (RPS), Percentage in brackets
> >>> represents the gain/loss compared to TCP.
> >>>
> >>> | Clients | TCP      | SMC (original)      | SMC (cq_pool)       |
> >>> |---------|----------|---------------------|---------------------|
> >>> | c = 1   | 24449    | 31172  (+27%)       | 34039  (+39%)       |
> >>> | c = 2   | 46420    | 53216  (+14%)       | 64391  (+38%)       |
> >>> | c = 16  | 159673   | 83668  (-48%)  <--  | 216947 (+36%)       |
> >>> | c = 32  | 164956   | 97631  (-41%)  <--  | 249376 (+51%)       |
> >>> | c = 64  | 166322   | 118192 (-29%)  <--  | 249488 (+50%)       |
> >>> | c = 128 | 167700   | 121497 (-27%)  <--  | 249480 (+48%)       |
> >>> | c = 256 | 175021   | 146109 (-16%)  <--  | 240384 (+37%)       |
> >>> | c = 512 | 168987   | 101479 (-40%)  <--  | 226634 (+34%)       |
> >>>
> >>> The results demonstrate that this optimization effectively resolves the
> >>> scalability bottleneck, with RPS increasing by over 110% at c=64
> >>> compared to the original implementation.
> >>
> >> I applied your patch to the latest kernel(6.19-rc8) & saw below
> >> Performance results:
> >>
> >> 1) In my evaluation, I ran several *uperf* based workloads using a
> >> request/response (RR) pattern, and I observed performance *degradation*
> >> ranging from *4%* to *59%*, depending on the specific read/write sizes
> >> used. For example, with a TCP RR workload using 50 parallel clients
> >> (nprocs=50) sending a 200‑byte request and reading a 1000‑byte response
> >> over a 60‑second run, I measured approximately 59% degradation compared
> >> to SMC‑R original performance.
> >>
> > 
> > The only setting I changed was net.smc.smcr_max_conns_per_lgr = 32, all
> > other parameters were left at their default values. redis-benchmark is a
> > classic Request/Response (RR) workload, which contradicts your test
> > results. Since I'm unable to reproduce your results, it would be
> > very helpful if you could share the specific test configuration for my
> > analysis.
> 
> I used a simple client–server setup connected via 25 Gb/s RoCE_Express2
> adapters on the same LAN(connection established via SMC-R v1). After
> running the commands shown below, I observed a performance degradation
> of up to 59%.
> 
> Server: smc_run uperf -s
> Client: smc_run uperf -m rr1c-200x1000-50.xml
> 
> cat rr1c-200x1000-50.xml
> 
> <?xml version="1.0"?>
> <profile name="TCP_RR">
> 	<group nprocs="50">
> 		<transaction iterations="1">
> 			<flowop type="connect" options="remotehost=server_ip protocol=tcp
> tcp_nodelay" />
> 		</transaction>
> 		<transaction duration="60">
> 			<flowop type="write" options="size=200"/>
> 			<flowop type="read" options="size=1000"/>
> 		</transaction>
> 		<transaction iterations="1">
> 			<flowop type="disconnect" />
> 		</transaction>
> 	</group>
> </profile>

Using the exact same XML profile you provided, I tested this on a 25Gb
NIC. I observed no degradation. Instead, performance improved
significantly:

Original: ~1.08 Gb/s
Patched: ~5.1 Gb/s

I suspect the 59% drop might be due to connections falling back to TCP.
Could you check smcss -a during your test to see if the traffic is
actually running over SMC-R?

> 
> I installed redis-server on the server machine & redis-benchmark on the
> client machine & I was able to establish the SMC-R using below commands.
> If you could help me with the exact commands you used to measure the
> redis-benchmark performance, I can try the same on my setup.
> 
> Server: smc_run redis-server --port <port_num> --save "" --appendonly no
>   --protected-mode no --bind 0.0.0.0
> Client: smc_run redis-benchmark -h <server_ip> -p <port_num> -n 10000 -c
> 50 -t ping_inline,ping_bulk -q

Here are the exact commands and scripts I used for the
redis-benchmark:

Server: smc_run redis-server --protected-mode no --save

Client: smc_run redis-benchmark -h <server_ip> -n 5000000 -t set --threads 3
-c <conn_num>

D. Wythe

