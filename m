Return-Path: <linux-rdma+bounces-17897-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLnIIs9nsGloigIAu9opvQ
	(envelope-from <linux-rdma+bounces-17897-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 19:49:51 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E7845256ABD
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 19:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A51AD304E701
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 18:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC52A29ACD1;
	Tue, 10 Mar 2026 18:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYi00l3X"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAC1314A73
	for <linux-rdma@vger.kernel.org>; Tue, 10 Mar 2026 18:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773168588; cv=none; b=AoyytBgJDaQq6zd5Tat0mN/AADCAMexjzxziGgnntJaFiRCVxENzeNKHNfrW3BiaVBOGr5snVoFIARIeDBdeM+kP05qngdAO7GFdrMeJXNhC/G8PAsbac9vnIjYP9ezw4nu8RYU0DIkRalVuYupybFSU74pQFHkIsD5qEHI24NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773168588; c=relaxed/simple;
	bh=NHT/PewF1vGdy4PYDqGIZxXh99EZi/xcvwaGPcMbry0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o8B/PMHMMNIqfciu08NclNQQUTnsDBIYYpEMAaNmozi2I5CQaZmbN4QspaaqTcm6CC1/2LHHuSRWgvXnY7m1yvONN6APzdp0u3Ar75nB38fTjtQMulXieXJFJ9xS9UI5Q9JImiY2vUOY85ondcTe9WF1kG1uwlaPpusruPuLfnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYi00l3X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99CDDC19423;
	Tue, 10 Mar 2026 18:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773168588;
	bh=NHT/PewF1vGdy4PYDqGIZxXh99EZi/xcvwaGPcMbry0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gYi00l3XY/Ets10zBm59kKMCWq1Mi82OQ/G3njXiNvzX4ohbp1VPE+/qhIYoZ4m1e
	 QOh/G66EjbaRi7C0BlQnhtn7j90t6/qn7DTdwZpTaaHLlCxJkWOLrVdrTtumep5kES
	 tMoe1wZ4HYZYBvoZpasQ5EL/ZmN8X3YAhtLUjqi+9xnyTuS47wsvgiy1ZwsNtN6Wuf
	 ms0scU58GQFHd1eSW9A0Jnkr2AaYtwH40yVjWlb7jNEYFwzso9JukF6P2e9ZkSS1N2
	 Jsetfe6b3aQjobbkhGUdGH0Z8q/P92JDZeCvV+q3IzSvnWSj4bsentPx+SHZG+UQJc
	 qi+V1PLlx/0vQ==
Message-ID: <2ae88f79-36a1-4b43-bf40-da86425046a5@kernel.org>
Date: Tue, 10 Mar 2026 14:49:46 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/rw: Fix MR pool exhaustion in bvec RDMA READ path
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, linux-rdma@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
References: <20260310034621.5799-1-cel@kernel.org>
 <abAftjplHdwdwrkd@infradead.org>
 <d0fefc47-b60f-47ba-8f2f-7eb05b1bb86d@kernel.org>
 <20260310183756.GH12611@unreal>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <20260310183756.GH12611@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E7845256ABD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17897-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/10/26 2:37 PM, Leon Romanovsky wrote:
> On Tue, Mar 10, 2026 at 10:36:43AM -0400, Chuck Lever wrote:
>> On 3/10/26 9:42 AM, Christoph Hellwig wrote:
>>> On Mon, Mar 09, 2026 at 11:46:21PM -0400, Chuck Lever wrote:
>>>> Under NFS WRITE workloads the server performs RDMA READs to
>>>> pull data from the client. With the inflated MR demand, the
>>>> pool is rapidly exhausted, ib_mr_pool_get() returns NULL, and
>>>> rdma_rw_init_one_mr() returns -EAGAIN. svcrdma treats this as
>>>> a DMA mapping failure, closes the connection, and the client
>>>> reconnects -- producing a cycle of 71% RPC retransmissions and
>>>> ~100 reconnections per test run. RDMA WRITEs (NFS READ
>>>> direction) are unaffected because DMA_TO_DEVICE never triggers
>>>> the max_sgl_rd check.
>>>
>>> So this changelog extensively describes the problem, but it doesn't
>>> actually say how you fix it.
>>
>> I didn't want to waste everyone's time, but I can add that.
>>
>>
>>>> +	 *
>>>> +	 * TODO: A bulk DMA mapping API for bvecs analogous to
>>>> +	 * dma_map_sgtable() would provide a proper post-DMA-
>>>> +	 * coalescing segment count here, enabling the map_wrs
>>>> +	 * path in more cases.
>>>
>>> This isn't really something the DMA layer can easily do without getting
>>> as inefficient as the sgtable based path.  What the block layer does
>>> here is to simply keep a higher level count of merged segments.  The
>>> other option would be to not create multiple bvecs for continguous
>>> regions, which is what modern file system do in general, and why the
>>> above block layer nr_phys_segments based optimization isn't actually
>>> used all that much these days.
>>
>> Technically, NFSD isn't a file system, it's a protocol adapter.
>>
>>
>>> Why can't NFS send a single bvec for contiguous ranges?
>>
>> Have a look at svc_rdma_build_read_segment(). The RDMA READ path builds
>> bvecs from rqstp->rq_pages[], which is an array of individual struct
>> page pointers. Each bvec entry covers at most one page.
>>
>> This is because I/O payloads arrive in an xdr_buf, which represents its
>> page data as a struct page ** array (xdr->pages), and svc_rqst::rq_pages
>> is likewise a flat array of single-page pointers. These pages are
>> allocated individually (typically from the page allocator via
>> alloc_pages()), so there's no guarantee of physical contiguity. Even if
>> adjacent pages happen to be contiguous, the code has no way to know that
>> without inspecting PFNs (which is exactly what the DMA mapping layer
>> does).
>>
>> So currently svcrdma can't send a single bvec for contiguous ranges
>> because the contiguity information doesn't exist at the NFSD or RPC
>> layer. Contiguity is (re)discovered only at DMA map time.
>>
>> The alternative is to build an SGL for mapping the bvec so that rw.c can
>> get the real contiguity of the pages before proceeding. But that seems
>> icky.
>>
>> Long term, I expect that NFSD will need to preserve the folios it gets
>> from file systems and pass those to the RPC transports without
>> translating them to an array of page pointers.
> 
> Folio sounds like a correct approach to me, why do you mark it as "long term"?

All four NFS maintainers are aware of this need, and I /think/ we are
all on board with the "folio/bvec" approach. But there are a number of
reasons this is not just a "go write the code" kind of problem:

- xdr_buf is used by both the NFS client and NFS server stacks, and they
are separately maintained.

- xdr_buf is used from nearly the top to the bottom of these stacks, so
making this kind of change will be painstaking.

- The XDR layer is full of helper APIs that deal with xdr_buf page
arrays that would need attention.

- I need to understand whether addressing the DMA map problem has
benefits for more broadly-deployed RPC transports such as TCP.


I'll have to think if we can just add something clever to the xdr_buf
that only NFSD can use and then have that act as the conduit from file
system to RPC transport. That could act as a prototype.


-- 
Chuck Lever

