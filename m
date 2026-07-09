Return-Path: <linux-rdma+bounces-22924-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id b5X+J7BNT2rcdwIAu9opvQ
	(envelope-from <linux-rdma+bounces-22924-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 09:28:48 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0353772DB21
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 09:28:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=auditcode.ai header.s=zmail header.b=CkPAAq9g;
	dmarc=pass (policy=none) header.from=auditcode.ai;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22924-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22924-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C6733027379
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jul 2026 07:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9923C819D;
	Thu,  9 Jul 2026 07:27:06 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from sender-op-o19.zoho.eu (sender-op-o19.zoho.eu [136.143.169.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4524D329C60
	for <linux-rdma@vger.kernel.org>; Thu,  9 Jul 2026 07:27:03 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783582026; cv=pass; b=b2hwZxh71vg8NT82s3Vs+2IifUwaib/tMXclilTU7NynueD7ClcmYCl1Xrvn/V9CWWe05qAdlR2olOYFOw0WHQzNS9Zp2AOuMDalAFyPibHcLUy2lk774RsAZek7sOqqac9jXu7rl2OcJcXK0q4iAQYohLUIBzgiqklz4AVZr14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783582026; c=relaxed/simple;
	bh=fBn6Og3TAmYk+U9YH2s5EFECTNaCfEeWdtbwDDBLB/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EMc1wHjLuG1AZCT3rET/3uyBMaVCl/Tp89UyB4K76zlcLGL5Fqcu2TmvsXTextbVBGDoIFvtFahh8eqolLkLcgcPAHeWRXDkCPvd09HsUY3I2667UjWCzVcg5GyQ8zXHZLObJ296neTEVqBPAQ7DD6krtbp7BQ2lWyHVIauCeoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=auditcode.ai; spf=pass smtp.mailfrom=auditcode.ai; dkim=pass (1024-bit key) header.d=auditcode.ai header.i=security@auditcode.ai header.b=CkPAAq9g; arc=pass smtp.client-ip=136.143.169.19
ARC-Seal: i=1; a=rsa-sha256; t=1783582000; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=cnpvpo0EMSR+aHzLhrVlFqNQzt+DrHOlgqIX+qeMOom+zPaOWOqfqolumjN0knceCeM0f0Na1QqxIu9spa3snqUjWBu2E7zoFvtGUYQ8JrK8fHTtC7ZmPkEba1ntJmyq/7aA7+pclNbaHL/r1t7GTI56OZVkIxvnTv3qdmFvQgw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1783582000; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=kvT5LHrGkA0PvjX6UGFEQesuaCcaql3UrEB+1IrHqGU=; 
	b=F0G97fgPaS1VQsXsO2HFl4T3ch8GJwU/tUBkmtj3+jD3ACq6repVnKfej+G8BaP0fTBD8JLadYoOe+qbvYTpjIIEj/bmEO73vSo8PwAViNfpSqURHIZ8hWhP9VXbHih4PVtlwSDBWpG9Yne1C3oqnWghuS2zeUa5+2hqRa4T9xU=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=auditcode.ai;
	spf=pass  smtp.mailfrom=security@auditcode.ai;
	dmarc=pass header.from=<security@auditcode.ai>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783582000;
	s=zmail; d=auditcode.ai; i=security@auditcode.ai;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=kvT5LHrGkA0PvjX6UGFEQesuaCcaql3UrEB+1IrHqGU=;
	b=CkPAAq9g8/xtLvfWZgD8z4PQv3HSZFQjCSPVs81mzYcJ2k8zriTXBeMDwj3Jlef3
	tMgWARZNBQvnZj4mU4zyQK1vOPmJtPi5t9QE70TULE9TNlNWyNW6/fA85FCfUPMv78l
	DxrAhM7VAEobKvDS6UZldYGHYtu7nWmW/29mkOtM=
Received: by mx.zoho.eu with SMTPS id 178358199713461.53284917089161;
	Thu, 9 Jul 2026 09:26:37 +0200 (CEST)
From: Ibrahim Hashimov <security@auditcode.ai>
To: yanjun.zhu@linux.dev,
	zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/rxe: validate num_sge/cur_sge before indexing wqe->dma.sge[]
Date: Thu,  9 Jul 2026 09:26:34 +0200
Message-ID: <20260709072634.9004-1-security@auditcode.ai>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <71562c7f-183c-40e4-bb90-84b078cf079d@linux.dev>
References: <20260708224534.1206-1-security@auditcode.ai> <71562c7f-183c-40e4-bb90-84b078cf079d@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[auditcode.ai,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[auditcode.ai:s=zmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22924-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[security@auditcode.ai,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:yanjun.zhu@linux.dev,m:zyjzyj2000@gmail.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linux.dev,gmail.com,ziepe.ca,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[security@auditcode.ai,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[auditcode.ai:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,auditcode.ai:from_mime,auditcode.ai:dkim,auditcode.ai:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0353772DB21

Hi Zhu Yanjun, thanks for the review -- good catch, you're right.

> From this function,
> static int rxe_init_sq(struct rxe_qp *qp, struct ibv_qp_init_attr *init_attr)
> ...
>      qp->sq.max_sge = init_attr->cap.max_send_sge;
> ...
> qp->sq.max_sge is also from the user space application. It is possible
> that qp->sq.max_sge is 0.
> Then this makes rxe_requester will return error and exit.

Correct: with max_sge == 0 my "cur_sge >= qp->sq.max_sge" check rejects
a legitimate zero-SGE WQE (cur_sge == 0), so such a QP could never post.
The claim in my commit message that zero-payload WQEs "remain valid" was
simply wrong for the max_sge == 0 case -- thanks for catching it.

One subtlety while fixing it: gating the check on num_sge alone is not
enough. The requester's payload is wqe->dma.resid, which is independent
of num_sge, so a crafted WQE with num_sge == 0, a large resid and an
out-of-range cur_sge would still reach copy_data() and dereference
dma->sge[cur_sge]. What actually makes a zero-SGE WQE safe is that
copy_data() returns early on length == 0, before it ever touches
dma->sge[]. So in v2 I gate the cur_sge bound on wqe->dma.resid (i.e.
"is there payload that will make copy_data() index dma->sge[]") rather
than on num_sge:

	if (unlikely(wqe->dma.num_sge > qp->sq.max_sge ||
		     (wqe->dma.resid &&
		      wqe->dma.cur_sge >= qp->sq.max_sge))) {

This lets a zero-payload WQE through (including on a max_sge == 0 QP),
still rejects the oversized-num_sge and out-of-range-cur_sge cases, and
keeps multi-packet sends valid (cur_sge advances within [0, num_sge)
while resid > 0, and num_sge <= max_sge keeps that in the array).

Re-verified on the same v6.19 KASAN (CONFIG_KASAN_VMALLOC=y) stand: the
original reproducer -- which posts a user-QP send WQE with an
out-of-range cur_sge -- reaches the exploit path and the QP now
completes cleanly with no "vmalloc-out-of-bounds in copy_data" report,
whereas the pre-fix kernel trips it.

One thing worth flagging for completeness: this gate (like the sibling
validate_send_wr()/get_srq_wqe() checks) validates the WQE in place in
the mmap'd ring, so it narrows rather than fully closes the underlying
race -- a userspace thread can still mutate cur_sge/resid after the
check and before copy_data() re-reads them. The retransmit path
(advance_dma_data() via req_retry()) also indexes dma->sge[cur_sge]
ahead of this check. Both are pre-existing and out of scope for this
one-liner, but I'm happy to look at them separately if you'd like.

I'll send this as [PATCH v2].

Thanks,
Ibrahim

