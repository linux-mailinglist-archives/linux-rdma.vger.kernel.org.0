Return-Path: <linux-rdma+bounces-19464-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6O5XJkCF6GkNLQIAu9opvQ
	(envelope-from <linux-rdma+bounces-19464-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Apr 2026 10:22:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA6F443644
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Apr 2026 10:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECC1030071DE
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Apr 2026 08:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602743B95FF;
	Wed, 22 Apr 2026 08:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="eMoQjmjv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66233B6C15;
	Wed, 22 Apr 2026 08:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776845815; cv=none; b=pF5dxfYHXOJKaLWjk6sPxhjwvTAoxU1MEM4tkQzn72m6chcUvEHH8kpr2SZx3g7af5cuK4d7yqLU/F75SFJLPIQDiwp7ps/lsUHKmBVYbGd+mDNBIWTroQ70c8t0UON89XqG4lou1d1btXcgqp9O7L49fAUxvsIL+8wVwb74uFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776845815; c=relaxed/simple;
	bh=k4p4LMgdJtO5cU5zDgCARGfX+/nRYgRKxs5+A+3xGg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sGa9126QBso6iPaxi+T2MUcfYUC2LwdB9cdFuKrlYEOz+UFixf3MXI4rBe19g825EVvbOn2YOriZXrkGRs4K/VCnwAsKE5qnS8mdLG7LsDdudjuZu9r84YyzYhGNOhpK8ZdPrO4/f48e78LKIjAAadbM1wuhd6E4I1gXUT9JyOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=eMoQjmjv; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=dK9i7Cr5XO7g/+h3dQazZvCkWlC6rfLQehRve6OwtbY=; b=eMoQjmjvNKb97qy4zA7NuFMhoa
	WvwgIkm+1ACHg41AAiBShiSyw2t7weJwYYBN+dzUZITHldr+TO/u2BeC7XPAuQumbzHj3eYuKcM1B
	ICUrFUK23Pp+nd7QS9MaDquZIDU571Ai/dD5+eSVtAFCu3XJzt8nZehTKMWWYqorThbl22D5RLZjc
	7mRzwFE9PBN7NtUVYXV8ZtcAweeAqgn6/4yLs88p1z17iXPmq4dD9cyBT9Zj2YUFTUm4tbwHDJfMk
	1GKg6kfby3dB3s6z7TA+n7zVaiTFnDSTF381Pmrd/WurCdpdoT0MhJVB7tBbX0FIPvagogIqC+cZm
	raembxRqRpJj2J88iZLv1P0Yr14l4tXOVQQb4vd5EPvPHqq28KtmFbjTBXFX+tXE8XbFoeX4AIkek
	Ahn27LYEDKpH+4yqYMiI3kE4pEXo+WA4OyOWEEDcLw/HtCkoYdsV6W7RhJbmWkAdjGGivPOl2gPtB
	HcRqMy46JFNzjYocvS1iHjl5;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1wFSlG-00000003ERj-3ZDU;
	Wed, 22 Apr 2026 08:16:43 +0000
Message-ID: <9cb0901c-18c5-4858-941c-3b37ee112af9@samba.org>
Date: Wed, 22 Apr 2026 10:16:41 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smb: smbdirect: move fs/smb/common/smbdirect/ to
 fs/smb/smbdirect/
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-cifs@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, samba-technical@lists.samba.org,
 Tom Talpey <tom@talpey.com>, Steve French <smfrench@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Namjae Jeon <linkinjeon@kernel.org>
References: <20260419192018.3046449-1-metze@samba.org>
 <aehrPuY60VMcYGU8@infradead.org>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <aehrPuY60VMcYGU8@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samba.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[samba.org:s=42];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.samba.org,talpey.com,gmail.com,linux-foundation.org,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19464-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[samba.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[metze@samba.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samba.org:dkim,samba.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3EA6F443644
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Christoph,

>> diff --git a/fs/smb/Makefile b/fs/smb/Makefile
>> index 9a1bf59a1a65..353b1c2eefc4 100644
>> --- a/fs/smb/Makefile
>> +++ b/fs/smb/Makefile
>> @@ -1,5 +1,6 @@
>>   # SPDX-License-Identifier: GPL-2.0
>>   
>>   obj-$(CONFIG_SMBFS)		+= common/
>> +obj-$(CONFIG_SMBDIRECT)		+= smbdirect/
> 
> Why is this not in net/smbdirect/ or driver/infiniband/ulp/smdirect?

Yes, I also thought about net/smbdirect.

As IPPROTO_SMBDIRECT or PF_SMBDIRECT will be the next step,
see the open discussion here:
https://lore.kernel.org/linux-cifs/cover.1775571957.git.metze@samba.org/
(I'll follow with that discussion soon)

I was just unsure about the consequences, e.g. would
the maintainer/pull request flow have to change in that case?
Or would Steve be able to take the changes via his trees?
Any I also didn't want to offend anybody, so I just took
what Linus proposed.

Using driver/infiniband/ulp/smdirect would also work,
if everybody prefer that.

> As far as I can tell there is zero file system logic in this code.
> 
>> -#include "../common/smbdirect/smbdirect_public.h"
>> +#include "../smbdirect/public.h"
> 
> And all these relative includes suggest you really want a
> include/linux/smdirect/ instead.

Yes, that's my also my goal in the next steps.

> While we're at it: __SMBDIRECT_EXPORT_SYMBOL__ is really odd.
> One thing is the __ pre- and postfix that make it look weird.

Yes, the __SMBDIRECT_EXPORT_SYMBOL__ was mainly a temporary
thing, now it's useless and I'll remove it.

> The other is that EXPORT_SYMBOL_FOR_MODULES is for very specific
> symbols that really should not exported.  What this warrants instead
> is a normal EXPORT_SYMBOL_NS_GPL.

I want the exported functions be minimal, as most of
of should go via the socket layer instead.

If EXPORT_SYMBOL_NS_GPL(func, "smbdirect") is better than
EXPORT_SYMBOL_FOR_MODULES() I can change that.

It means cifs.ko and ksmbd.ko would need MODULE_IMPORT_NS("smbdirect"), correct?

Thanks!
metze

