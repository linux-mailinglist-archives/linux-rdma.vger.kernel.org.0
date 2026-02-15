Return-Path: <linux-rdma+bounces-16900-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qATVKDoBkmnWpAEAu9opvQ
	(envelope-from <linux-rdma+bounces-16900-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Feb 2026 18:24:10 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D0313F366
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Feb 2026 18:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A7E883002904
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Feb 2026 17:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E475329994B;
	Sun, 15 Feb 2026 17:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oDkwR+25"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFBC21ADB7
	for <linux-rdma@vger.kernel.org>; Sun, 15 Feb 2026 17:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771176244; cv=none; b=Y5aHt8Ia0DNK0duBeDzJQQLFBYprIh2MSABrvngO1VzRE+sWQSqWvIVia0NA39MoKRPKA0NskcuEJ2YFdf2/BGLphZb2Zd0z65wo9m+vthexZR1sV+iRYZbKWc9KczcxttQfx+kg0GNt6UW5tf94rNKzNIbRfk/bUEXcHkaoHjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771176244; c=relaxed/simple;
	bh=+ug8N3fxEfTk+pQ9LJQE6hT4szdAZOuh+GFrSyVeg70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=muDlfdToBV+jYLH3ZV1A0pyj+AVkxYILcptYdIqFD0/Yzo4lyQAg2DcnDsdXwC14i7fwqHAkeSM3fbkQSgA8nwUkkTintUKSXOdDf2OY7jScdpBNAQKfQLiAP5IXKot0bi65r1U9xQkWmmQ3F3CvsO7Lv45kPMylRDp3NdAML3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oDkwR+25; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <42c8552c-eb41-43f5-bea5-fdd46edba65a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771176240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pdA1Jaae8a2MfjyiVKe/3SRJSLjIuuoFOptEXjGwN64=;
	b=oDkwR+25EZ3Ryt/bVs8Na3V77FeE0fJ2N5G7OsvQV/Swz++6po39iMYdX3csMeDCBKngWe
	Ply+5SpmkwNIJ0VpBcNo7WUXcAnx1xFHDvvjpITYyFG58cg3bGXwTOaA2bQxYcjwr0JsKT
	6Q1fEcyu48W935LR6GwZRO7ghhME37c=
Date: Sun, 15 Feb 2026 19:23:41 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next] RDMA/efa: Add AH usage counter with sysfs
 exposure
To: Leon Romanovsky <leon@kernel.org>, Michael Margolin <mrgolin@amazon.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Tom Sela <tomsela@amazon.com>,
 linux-rdma@vger.kernel.org, sleybo@amazon.com, matua@amazon.com,
 Yonatan Nachum <ynachum@amazon.com>
References: <20260211131048.36217-1-tomsela@amazon.com>
 <20260211131338.GA1218606@nvidia.com>
 <ef07b718-0198-4f8c-86c1-56149c7fd239@linux.dev>
 <20260212163628.GG12887@unreal>
 <20260215134122.GA18825@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
 <20260215171543.GB12989@unreal>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Gal Pressman <gal.pressman@linux.dev>
Content-Language: en-US
In-Reply-To: <20260215171543.GB12989@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16900-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gal.pressman@linux.dev,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B5D0313F366
X-Rspamd-Action: no action

On 15/02/2026 19:15, Leon Romanovsky wrote:
>> Stats also doesn't seem as the right place
>> for this.

Because?

> 
> How can the kernel and this new counter report a different number of AH
> objects?
> 
>>
>> In a followup series we will suggest netlink counters extension to
>> support driver specific resources.
> 
> bpftrace is generally the right tool, unless you can detail why it does not  
> fit your specific debugging scenario.

I don't understand, how do you use bpftrace for this use case?

Once you get to debug a system in a certain state, bpftrace won't help
you see events that happened in the past. You won't be able to know how
many AH were created.

