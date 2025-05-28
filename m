Return-Path: <linux-rdma+bounces-10854-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DC6AC6E85
	for <lists+linux-rdma@lfdr.de>; Wed, 28 May 2025 18:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF35C4E5D8E
	for <lists+linux-rdma@lfdr.de>; Wed, 28 May 2025 16:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E19B28DF5B;
	Wed, 28 May 2025 16:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="O54rUC5t";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MID2zbPE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Il6h1JkY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4gTzGqBt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43CD28DF41
	for <linux-rdma@vger.kernel.org>; Wed, 28 May 2025 16:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748451424; cv=none; b=SAIciy5C5e9WkzI5c42RUjZn5g6BiygmHEUS1CNAuXDdk1YuYkUj1lxGwp702/iYToONM2d6xXoRh2qAd5WIxdx7Hg+xa8PJLI+3j3+L8Kf2Sp2hKWIHCXOV6i3NlCRFUGoy6Ytyr3KOb9xricA+XTQ7IaO+p5H3yQGMQLKrj8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748451424; c=relaxed/simple;
	bh=u4cOeuZEcgbOJVgggFrPe+Iwgisn1sHqzgwQeJDl5hg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eYrK43OxFcPhapdffkUhFsXHwPM9Vbib4jxLLH291So+t+0TGc3zA065GD9pt+a4Oo11BERQYxAey5MDRhyy+B6mIPFU7oO6zjAknFG4+6mDFtYqDoAf62RRTgYaxp3O88t9Q7UC9pVmFYEMhOKTTEe8PLZ0ddmnU5v85bRw5+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=O54rUC5t; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MID2zbPE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Il6h1JkY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4gTzGqBt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 84D931F7A2;
	Wed, 28 May 2025 16:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748451419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=selrdFiKTRag78HsPV/MJikZWyX48iHT4XvJCHYw5/k=;
	b=O54rUC5tPdq61P8Tg4zS0G1kVLZtacUtffaUsaMPukHuTpAaRB0pCj3uNppM+1/OF42RzY
	wqsgJPXaxMl3HvonKN6szEHpVXHh5eIvQ+bVaxkeFGILqEo+Pa/Y+n8WnuLoqOCtJGGS+P
	heJ59fW7PITPk/D6B2reKwW3Xq7i0Ec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748451419;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=selrdFiKTRag78HsPV/MJikZWyX48iHT4XvJCHYw5/k=;
	b=MID2zbPEO/7YRydWbDMooEwvbnnGBmJco+9yvkF5DwzbgbxoOJK95xsKJT2Q1Feq4P1I+j
	0K37gncJJlZc3uDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748451418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=selrdFiKTRag78HsPV/MJikZWyX48iHT4XvJCHYw5/k=;
	b=Il6h1JkYYdTpreKONsCQ5e7PilTMmTUG/H0QZD8b1II538gNVeTFBl8Na4t+MuV9YpJaSv
	t1qEN+ESRxHbbL9rn5GrjWqoBl+kEh0bUbR/u7xhqYRZcq72DbiBRGk2NIRZQiRVGx1sL+
	3+STLW1d4mAe8w2A2rr2btqqKaQqtJ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748451418;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=selrdFiKTRag78HsPV/MJikZWyX48iHT4XvJCHYw5/k=;
	b=4gTzGqBtP3pD7O3sRltbSFYzpLfM/VYufAEJH8pP6ZxYBvGUmNh0kgloT4mePHWDUzneLf
	VHbrZA13P1MEq8Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5CD971398F;
	Wed, 28 May 2025 16:56:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id skJUFVpAN2haeQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 28 May 2025 16:56:58 +0000
Message-ID: <8a1ac938-57d1-4e3d-b92c-94c6a2c270c3@suse.cz>
Date: Wed, 28 May 2025 18:56:58 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next:master] [mm, slab] 6431f06eec:
 WARNING:at_include/linux/mm.h:#skb_append_pagefrags
Content-Language: en-US
To: Bernard Metzler <BMT@zurich.ibm.com>,
 kernel test robot <oliver.sang@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
 "lkp@intel.com" <lkp@intel.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
 Matthew Wilcox <willy@infradead.org>, Simon Horman <horms@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <202505221248.595a9117-lkp@intel.com>
 <610d1a69-e237-43ec-b554-d52b5308ace1@suse.cz>
 <BN8PR15MB251311AA63AE08F9E868B0F89967A@BN8PR15MB2513.namprd15.prod.outlook.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <BN8PR15MB251311AA63AE08F9E868B0F89967A@BN8PR15MB2513.namprd15.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,intel.com:email,suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo,infradead.org:email,ziepe.ca:email,kvack.org:email,davemloft.net:email]
X-Spam-Level: 

On 5/28/25 18:52, Bernard Metzler wrote:
> 
> 
>> -----Original Message-----
>> From: Vlastimil Babka <vbabka@suse.cz>
>> Sent: Wednesday, May 28, 2025 11:46 AM
>> To: kernel test robot <oliver.sang@intel.com>; David S. Miller
>> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub Kicinski
>> <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Bernard Metzler
>> <BMT@zurich.ibm.com>; Jason Gunthorpe <jgg@ziepe.ca>; Leon Romanovsky
>> <leon@kernel.org>
>> Cc: oe-lkp@lists.linux.dev; lkp@intel.com; linux-mm@kvack.org; Matthew
>> Wilcox <willy@infradead.org>; Simon Horman <horms@kernel.org>;
>> netdev@vger.kernel.org; linux-rdma@vger.kernel.org
>> Subject: [EXTERNAL] Re: [linux-next:master] [mm, slab] 6431f06eec:
>> WARNING:at_include/linux/mm.h:#skb_append_pagefrags
>> 
>> On 5/22/25 06:54, kernel test robot wrote:
>> >
>> >
>> > Hello,
>> >
>> >
>> > we noticed the WARN added in this commit is hit in our tests. not sure if
>> it's
>> > expected. below full report FYI.
>> 
>> It's expected in the sense that if somebody is doing the wrong thing, there
>> would be a report. So it seems that has now happened :)
>> 
>> > kernel test robot noticed
>> "WARNING:at_include/linux/mm.h:#skb_append_pagefrags" on:
>> >
>> > commit: 6431f06eecf44e7b8d42237cb0e166a456f491ad ("mm, slab: warn when
>> increasing refcount on large kmalloc page")
>> > https% 
>> 3A__git.kernel.org_cgit_linux_kernel_git_next_linux-
>> 2Dnext.git&d=DwIFaQ&c=BSDicqBQBDjDI9RkVyTcHQ&r=4ynb4Sj_4MUcZXbhvovE4tYSbqxy
>> OwdSiLedP4yO55g&m=RVwvTs1_4tv9VS6aBY_BN1Nb5XX4P80N9RLHq1UND_lRCm9uja6lYFlrt
>> 1eIP6xD&s=gDBCZ9iGPTCbRHLz-aCIQx6RpCDBnybfljVjh1G_MjQ&e=  master
>> 
>> FYI that's
>> https% 
>> 3A__git.kernel.org_pub_scm_linux_kernel_git_vbabka_slab.git_commit_-3Fh-
>> 3Dslab_for-2D6.16_testing-26id-
>> 3D6431f06eecf44e7b8d42237cb0e166a456f491ad&d=DwIFaQ&c=BSDicqBQBDjDI9RkVyTcH
>> Q&r=4ynb4Sj_4MUcZXbhvovE4tYSbqxyOwdSiLedP4yO55g&m=RVwvTs1_4tv9VS6aBY_BN1Nb5
>> XX4P80N9RLHq1UND_lRCm9uja6lYFlrt1eIP6xD&s=HgoQP2p-
>> qH0YF0Pxt2hT1lLJjQI4CaEArKRz-4OZCUA&e=
>> 
>> so we have skb_splice_from_iter() calling skb_append_pagefrags() and that
>> does a get_page(). But this warning means one of the pages is a kmalloc()
>> with size >8kb that is using the page allocator and not slab caches. But
>> that 8kb threshold is an implementation detail, so we want all kmalloc()
>> allocated buffers to behave the same and use frozen pages and thus not
>> allow
>> get_page().
>> 
>> Note skb_splice_from_iter() has above the call to skb_append_pagefrags():
>> 
>> if (WARN_ON_ONCE(!sendpage_ok(page)))
>>     goto out;
>> 
>> and sendpage_ok() is:
>> 
>> return !PageSlab(page) && page_count(page) >= 1;
>> 
>> Thus if we went ahead with frozen pages for large kmalloc(), sendpage_ok()
>> would start marking them as not ok, which seems like the right thing. But
>> this callsite would still produce a WARN_ON_ONCE(), so that suggests it's
>> not really expected to for kmalloc() pages to reach this code.
>> 
>> It's possible that some other code using sendpage_ok() elsewhere prevents
>> this from happening, and this WARN_ON_ONCE() is just a safety double check.
>> Or not, and something (siw?) needs to be fixed to e.g. stop using kmalloc()
> 
> siw ckecks every page before sending via sendpage_ok(). It unsets
> MSG_SPLICE_PAGES flag for the current message if one page to be
> handed to tcp_sendmsg_locked() fails that test. Wouldn't that
> be sufficient?

So that's indeed the "some other code using sendpage_ok() elsewhere prevents
this from happening" case. Excellent, thanks. I thought I was being careful
by introducing the warning in -next without actually making the pages frozen
at the same time, but Matthew was of course rightfully doubting that
approach. I will adjust it to do both then and then this case will be resolved.

Thanks,
Vlastimil

> Thanks,
> Bernard.
> 

