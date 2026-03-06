Return-Path: <linux-rdma+bounces-17588-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCcGH9bEqmnVWwEAu9opvQ
	(envelope-from <linux-rdma+bounces-17588-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Mar 2026 13:13:10 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C6998220487
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Mar 2026 13:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BB7EA304B961
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Mar 2026 12:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FB938E5CB;
	Fri,  6 Mar 2026 12:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jbWBZLnv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606DD38E10F;
	Fri,  6 Mar 2026 12:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772798885; cv=none; b=s3sZ91qdFzGIeQvInj/CVnn/kSYofzoqdXAccObVM2hf/ddrv9QOCWb+lEODi0wot3fAoUj7lH9nsqUIo86Ests4rWr0VidT17pcAXnqHvlxnLbMEumST5gN5mjOblkDNfbpYDCuD4H5Vis7zhKwnXDHXaxSKLs4O3tim7+/Qi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772798885; c=relaxed/simple;
	bh=AOkKMy7Q4DfFPGIXcT/fjITfQuCQoW4Bs+ylC4rcZ6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QZ1hFPa5A9Ud1diYNgPPGNupI8q7gTNQvKzEYwCH424A5L2fcLH8oKEWyUDbfJdtmr4k79KF8PiTspOUMUnw4A6vFUfSygmheqDHoUaucNEjIhMHDNVubaZAQ48FNzmyjEHCevpb+lIBrnnXZehKRlG5T8jqokdh03jlhpvbK4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jbWBZLnv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6264Kbk91171368;
	Fri, 6 Mar 2026 12:07:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=k0Y8HK
	c8LITYke4TuHe/rf3FmEyQ4SxYm63/LK4sQmI=; b=jbWBZLnvvW47NLrLv2PLiX
	8/71+Ny6nTHYI1HfC6xQXX04xWV8ZOXLnpe4cT0Jejy73ES8bWXKtIGxNVPkM6Q3
	lRq0TGxQH7vvcSvWtarpQORg4CZTX3KreMhA/a0NI7nXbyDgikrzP0UqjcG0y9Gb
	erThU6SAX6dN9PXQBhDo+KUhTOq3w+MRW7gqinoM3kLtTCul8Rx89dkdOYm3HDCo
	SHRMeNTHU06tQPJmbFsKKi1avzz8UkaeZiqQe+Kcst10L2wrfo8itE4jFmPWVuQO
	/UDm8ufGohLUEkRnyvEalrFnJmS4jyMT1a7GjEm4pg6BDRYWzv7mFttjUlsX+RbA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksk47u98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 12:07:58 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6269ngZF008796;
	Fri, 6 Mar 2026 12:07:57 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmdd1qfcp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 12:07:57 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 626C7uqu31326746
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Mar 2026 12:07:56 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2EB6558063;
	Fri,  6 Mar 2026 12:07:56 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C8D0758059;
	Fri,  6 Mar 2026 12:07:50 +0000 (GMT)
Received: from [9.39.19.120] (unknown [9.39.19.120])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Mar 2026 12:07:50 +0000 (GMT)
Message-ID: <bdcd2405-93d1-4b4c-91ae-174b577e5734@linux.ibm.com>
Date: Fri, 6 Mar 2026 17:37:49 +0530
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net/smc: transition to RDMA core CQ pooling
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
References: <20260305022323.96125-1-alibuda@linux.alibaba.com>
Content-Language: en-US
From: Mahanta Jambigi <mjambigi@linux.ibm.com>
In-Reply-To: <20260305022323.96125-1-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 6ce2a2YXkWd_epGEgQNeRWeP-pai1ZQD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDExMSBTYWx0ZWRfX6pH5UMJ1/Rr/
 36I00uan44a8iLSXuGg3gSx4ezrQRXu4s2v8xEsZczBhoPXZf7icqWltF5Y4q4A4clUJJwkKUHa
 vIu1PCEgD6bybawl3auwK1P9F6+Wxdwj0G3PfuWGs2ihZ8lTtRIhRrjyCRyfyCDi2/Hd/o7rUqi
 9oxiNyiiemIMT5MQh2cc0ceTx5LKXq+uFCs48BYURntAkm+kt1KZoqN61l+rqgOE8wXEmgHDU25
 IXhaD2ngNGaYP982OrZYp04XbBwSIJCbXCNX8Py4ju5Oa1MQ/kL3zmdtc4PQT0/oKFuY0ZXiUVz
 2GwPCKSwgo0idpMfcYa1hzoXjgh2hh9bjzkF7bt1+/WJyQ+tw0BKWFwBeGQZkNou6WN3n4A8V/u
 FC2B41ArNlA9nLFFSjxTqjD62BaPZDfzAa+H2yYvtUZljSwfszF0UW6pATMwNkTl2bUXKesCD2j
 yLDTEMpcbde4E6b8AcQ==
X-Authority-Analysis: v=2.4 cv=csCWUl4i c=1 sm=1 tr=0 ts=69aac39e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=cEV2uSDX2Sh9gm4Zn8EA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: MObLhJvsXRtNPJA-fLZwDpPFZsQi7c_b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_04,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060111
X-Rspamd-Queue-Id: C6998220487
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-17588-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.ibm.com:mid];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mjambigi@linux.ibm.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action



On 05/03/26 7:53 am, D. Wythe wrote:
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

Since your performance results look really-really nice on x86 but ours
show severe degradations on s390x, one way forward could be adding the
cq_poll mechanism but also keeping the existing mechanism for now
(because the things are right now it works better on s390x) and making
it either runtime or compile time configurable which of the both is
going to be used.

Alternatively, we could work together making the cq_poll mechanism does
not introduce a regression to s390x (ideally improve performance for
s390x as well). But it that case we would like to have this change
deferred until we find a way to make the regression disappear.

I am aware that the first option, co-existence, would kill the
simplification aspect of this and instead introduce added complexity.
But we are talking about a major regression here on one end, and major
improvements on the other end, so it might be still worth it. In any
case, we are very motivated to eventually get rid of the old mechanism,
provided significant performance regressions can be avoided.

