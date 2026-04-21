Return-Path: <linux-rdma+bounces-19460-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPXhEWfL52mKAwIAu9opvQ
	(envelope-from <linux-rdma+bounces-19460-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2026 21:09:27 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9494D43EDF3
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2026 21:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B38AC3010EF3
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2026 19:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92569377007;
	Tue, 21 Apr 2026 19:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o0cANMyN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0EB372683
	for <linux-rdma@vger.kernel.org>; Tue, 21 Apr 2026 19:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776798563; cv=none; b=JDiq7EQTIacC9kTieXClmQth6Mayiv8GdPD4vcS4t1003YZM9lxf9asmDq8N4LdgPp4/hA3kYZfWZR9JFhGAjlc1mECO06pv/7i7L5ofHNQPrp8tC9VnX6QFBOmN2h6ZHsh4bHlt0BWxWvoVf0WCTMw2qKJurnQ54j9jyfgWLDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776798563; c=relaxed/simple;
	bh=/DgMXYHEa+hLzLcOPcZq/M4u+RrxEt38YAZt7yM2nxs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qA9bF0TRhDU3eGczKAudXGIBZSh+YVk4R6QpoEybCQMhejNaSSGLE3wfs4P/woOB820SOlTrHGcMgFRA46OgSi5HwNOZQJXuMLBIdrG5bPIy/j67I6FZIquDHUbCORU5+Rjn5MSQvHrTeWMoKM3ZAar4hCUEC3jnDxkoHe5LQ+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o0cANMyN; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <62c87071-51ab-4449-bcef-9c21e03713ae@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776798550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8sb/gJnXDsoanW6gaV5O7OvCI9qKrXN++ZSYB0knuOw=;
	b=o0cANMyNhUhQ+9I5HKQ29Ambp4SgAmcSt2MTD4ge9dKw9Eb4n76gQ1gtoX24QeR57NMIA3
	XPYep6+qE9pdsMT1hveDmPbaVO4SQlm5GlneQUT45zGWoQpBzVOXCPawN4Yz20FRxX7rg5
	Cki+OcOV/RJXo3QzQ+DQtZXlGrWOgWM=
Date: Tue, 21 Apr 2026 21:08:58 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/siw: use kzalloc_flex
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Bernard Metzler <bernard.metzler@linux.dev>
To: Rosen Penev <rosenp@gmail.com>, linux-rdma@vger.kernel.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 open "list:KERNEL" HARDENING "(not" covered by other
 "areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
References: <20260327030056.8321-1-rosenp@gmail.com>
 <49794f9f-8a35-4e36-af19-26b68c89decd@linux.dev>
In-Reply-To: <49794f9f-8a35-4e36-af19-26b68c89decd@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-19460-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernard.metzler@linux.dev,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9494D43EDF3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Rosen, all,

thanks for your patch. As stated, I think we shall make a change
to it, which exchanges 'num_pages' with more appropriate
'num_chunks' logic. Since I haven't received a response to my
first reply yet, I'll send an RFC patch right away. I'll
restrict it to linux-rdma list and other individuals on cc
in your patch.

Thanks,
Bernard.

On 29.03.2026 15:21, Bernard Metzler wrote:
> On 27.03.2026 04:00, Rosen Penev wrote:
>> Simplifies allocations by using a flexible array member in this struct.
>>
>> Add __counted_by to get extra runtime analysis.
>>
>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
>> ---
>>   drivers/infiniband/sw/siw/siw.h     |  2 +-
>>   drivers/infiniband/sw/siw/siw_mem.c | 12 +++---------
>>   2 files changed, 4 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
>> index f5fd71717b80..2b327a899a1c 100644
>> --- a/drivers/infiniband/sw/siw/siw.h
>> +++ b/drivers/infiniband/sw/siw/siw.h
>> @@ -119,9 +119,9 @@ struct siw_page_chunk {
>>   struct siw_umem {
>>       struct ib_umem *base_mem;
>> -    struct siw_page_chunk *page_chunk;
>>       int num_pages;
> 
> Shouldn't we replace 'num_pages' by a 'num_chunks' and change
> memory allocation and release code accordingly?
> 
>>       u64 fp_addr; /* First page base address */
>> +    struct siw_page_chunk page_chunk[] __counted_by(num_pages);
>>   };
>>   struct siw_pble {
>> diff --git a/drivers/infiniband/sw/siw/siw_mem.c b/drivers/infiniband/sw/siw/siw_mem.c
>> index 98c802b3ed72..08047fcf0df1 100644
>> --- a/drivers/infiniband/sw/siw/siw_mem.c
>> +++ b/drivers/infiniband/sw/siw/siw_mem.c
>> @@ -50,7 +50,6 @@ void siw_umem_release(struct siw_umem *umem)
>>           kfree(umem->page_chunk[i].plist);
>>           num_pages -= PAGES_PER_CHUNK;
>>       }
>> -    kfree(umem->page_chunk);
>>       kfree(umem);
>>   }
>> @@ -347,16 +346,12 @@ struct siw_umem *siw_umem_get(struct ib_device *base_dev, u64 start,
>>       num_pages = PAGE_ALIGN(start + len - first_page_va) >> PAGE_SHIFT;
>>       num_chunks = (num_pages >> CHUNK_SHIFT) + 1;
>> -    umem = kzalloc_obj(*umem);
>> +    umem = kzalloc_flex(*umem, page_chunk, num_chunks);
>>       if (!umem)
>>           return ERR_PTR(-ENOMEM);
>> -    umem->page_chunk =
>> -        kzalloc_objs(struct siw_page_chunk, num_chunks);
>> -    if (!umem->page_chunk) {
>> -        rv = -ENOMEM;
>> -        goto err_out;
>> -    }
>> +    umem->num_pages = num_pages;
>> +
>>       base_mem = ib_umem_get(base_dev, start, len, rights);
>>       if (IS_ERR(base_mem)) {
>>           rv = PTR_ERR(base_mem);
>> @@ -385,7 +380,6 @@ struct siw_umem *siw_umem_get(struct ib_device *base_dev, u64 start,
>>           umem->page_chunk[i].plist = plist;
>>           while (nents--) {
>>               *plist = sg_page_iter_page(&sg_iter);
>> -            umem->num_pages++;
>>               num_pages--;
>>               plist++;
>>               if (!__sg_page_iter_next(&sg_iter))
> 


