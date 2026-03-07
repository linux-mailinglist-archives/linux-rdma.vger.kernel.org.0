Return-Path: <linux-rdma+bounces-17679-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CM5aMxT5q2nDigEAu9opvQ
	(envelope-from <linux-rdma+bounces-17679-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 07 Mar 2026 11:08:20 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC4122AF08
	for <lists+linux-rdma@lfdr.de>; Sat, 07 Mar 2026 11:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB9D1301F333
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Mar 2026 10:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F53309F02;
	Sat,  7 Mar 2026 10:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ljfv9Qev"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252E130CD80;
	Sat,  7 Mar 2026 10:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772878094; cv=none; b=OidDXgd5mRK4cpqvQNa+4qzMIJv/28yyL5WfCC7Urc85UnYO8Xw0ZvN4/OgIsV8j4nq4rSXGYH7hTG9l0qEYA0qXLmymdZTXthArkjdBzd9m6/4zWNppuI13nTHAm4rgxzL8pt0Y02UU+Bx9nuG1wbadtvpMEH0Qy5YdQ7aA7uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772878094; c=relaxed/simple;
	bh=egZ1+M1uc0jkAv5m17k+C3GcHFY6xwEHcD81x2VjVTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LGQBoJMAE6y827c6/eXNCzwPLqEnuos83JMP9w2oZVLmEeh4cKiWXbN+1UrHb4DaBSYdsWPfby7P5sj8WMgOkMan+pcgjp4cfhDRowEbVDTuxUF18Bvnli9ccXsmHh7hV3Rvv2LZ1MU4NJLqScSQ32r4/ltRSlwOUlqaUNkigms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ljfv9Qev; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772878080; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=Ee8lmlga3uDFZLOnTMgosbonAxDSBeCsgWYca7ZXZNI=;
	b=ljfv9Qevd3P7u3pCsTQAPgHDIiMcJ7a4u1XzMjuwd8hED3O1/HHh3RkSE6yCYXvvMpXgzlf/lal/sjdALS74ifVnGybZOUes8q1DdbyeiuKY2Wg2eEOTVl0nZh7PBF1l/899zeWjeW1dYS6USFseYMAMHd39DlaS5+2NWQObBrk=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0X-PTgJf_1772878079 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 07 Mar 2026 18:08:00 +0800
Date: Sat, 7 Mar 2026 18:07:59 +0800
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
Subject: Re: [PATCH net-next v3] net/smc: transition to RDMA core CQ pooling
Message-ID: <20260307100759.GA71792@j66a10360.sqa.eu95>
References: <20260305022323.96125-1-alibuda@linux.alibaba.com>
 <bdcd2405-93d1-4b4c-91ae-174b577e5734@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdcd2405-93d1-4b4c-91ae-174b577e5734@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Rspamd-Queue-Id: 7BC4122AF08
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17679-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alibuda@linux.alibaba.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-0.974];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 05:37:49PM +0530, Mahanta Jambigi wrote:
> 
> 
> On 05/03/26 7:53 am, D. Wythe wrote:
> > The current SMC-R implementation relies on global per-device CQs
> > and manual polling within tasklets, which introduces severe
> > scalability bottlenecks due to global lock contention and tasklet
> > scheduling overhead, resulting in poor performance as concurrency
> > increases.
> > 
> > Refactor the completion handling to utilize the ib_cqe API and
> > standard RDMA core CQ pooling. This transition provides several key
> > advantages:
> > 
> > 1. Multi-CQ: Shift from a single shared per-device CQ to multiple
> > link-specific CQs via the CQ pool. This allows completion processing
> > to be parallelized across multiple CPU cores, effectively eliminating
> > the global CQ bottleneck.
> > 
> > 2. Leverage DIM: Utilizing the standard CQ pool with IB_POLL_SOFTIRQ
> > enables Dynamic Interrupt Moderation from the RDMA core, optimizing
> > interrupt frequency and reducing CPU load under high pressure.
> > 
> > 3. O(1) Context Retrieval: Replaces the expensive wr_id based lookup
> > logic (e.g., smc_wr_tx_find_pending_index) with direct context retrieval
> > using container_of() on the embedded ib_cqe.
> > 
> > 4. Code Simplification: This refactoring results in a reduction of
> > ~150 lines of code. It removes redundant sequence tracking, complex lookup
> > helpers, and manual CQ management, significantly improving maintainability.
> > 
> > Performance Test: redis-benchmark with max 32 connections per QP
> > Data format: Requests Per Second (RPS), Percentage in brackets
> > represents the gain/loss compared to TCP.
> > 
> > | Clients | TCP      | SMC (original)      | SMC (cq_pool)       |
> > |---------|----------|---------------------|---------------------|
> > | c = 1   | 24449    | 31172  (+27%)       | 34039  (+39%)       |
> > | c = 2   | 46420    | 53216  (+14%)       | 64391  (+38%)       |
> > | c = 16  | 159673   | 83668  (-48%)  <--  | 216947 (+36%)       |
> > | c = 32  | 164956   | 97631  (-41%)  <--  | 249376 (+51%)       |
> > | c = 64  | 166322   | 118192 (-29%)  <--  | 249488 (+50%)       |
> > | c = 128 | 167700   | 121497 (-27%)  <--  | 249480 (+48%)       |
> > | c = 256 | 175021   | 146109 (-16%)  <--  | 240384 (+37%)       |
> > | c = 512 | 168987   | 101479 (-40%)  <--  | 226634 (+34%)       |
> > 
> > The results demonstrate that this optimization effectively resolves the
> > scalability bottleneck, with RPS increasing by over 110% at c=64
> > compared to the original implementation.
> 
> Since your performance results look really-really nice on x86 but ours
> show severe degradations on s390x, one way forward could be adding the
> cq_poll mechanism but also keeping the existing mechanism for now
> (because the things are right now it works better on s390x) and making
> it either runtime or compile time configurable which of the both is
> going to be used.
> 
> Alternatively, we could work together making the cq_poll mechanism does
> not introduce a regression to s390x (ideally improve performance for
> s390x as well). But it that case we would like to have this change
> deferred until we find a way to make the regression disappear.
> 
> I am aware that the first option, co-existence, would kill the
> simplification aspect of this and instead introduce added complexity.
> But we are talking about a major regression here on one end, and major
> improvements on the other end, so it might be still worth it. In any
> case, we are very motivated to eventually get rid of the old mechanism,
> provided significant performance regressions can be avoided.

I'm in no rush to push this, since a significant performance degradation
was observed on s390x, I'll withdraw this patch until the issue is
resolved, and it would be great if you could investigate what specifically
happened on s390x.

D. Wythe


