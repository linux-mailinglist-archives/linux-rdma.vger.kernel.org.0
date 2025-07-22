Return-Path: <linux-rdma+bounces-12390-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5898CB0D845
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jul 2025 13:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15CD71894CBE
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jul 2025 11:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8394288C8A;
	Tue, 22 Jul 2025 11:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pc577WtV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ePnRo2H7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pc577WtV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ePnRo2H7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A8C2E4248
	for <linux-rdma@vger.kernel.org>; Tue, 22 Jul 2025 11:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753183933; cv=none; b=kcBHu2Vqpxb09OXnvrbkM+SxFta8PDptaxHOUnjceFLHW2nheO8wTbKqWs9oyCBleV4q+yLLLt95CtHoJleGyi15A2efxdRCY9oBNA5SINvp4C5P/M4JF7WcLckDXHTSEmsGPPpdNmR6esrn9AkZ3pXLNL21FMSNwRAUt6oEFCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753183933; c=relaxed/simple;
	bh=gMOZK8BrEYGZ0Qh6kPXwf5MXZXfYI4V723/LorbspYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BOrJzGsdD6zSrUpewGaeURXOpyEFcG4u0w7tFJ5XhObyy/Okg2WgGzXUdVUbj+nNDyXSvkxm1jhUDe1c4r/Kxz35KW6LLx+UoO6E+2fhzQr6sOt6JEOiDRbvyT/yAN2YOt+3s94clwnyE6SVmyKfhU+Jd8IwyEs4U6YZVqYHSes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pc577WtV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ePnRo2H7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pc577WtV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ePnRo2H7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B032E21ADD;
	Tue, 22 Jul 2025 11:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753183929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+PrCtUSn/haYuYkpVBJwpmXTnwMGxVaYRe8rwgXZQwo=;
	b=pc577WtVL7G6sJjw/qnXpFmcTso5YQxMyKr294WPC/AJ45E8989bUE8RJFxsMeZmYGeoRv
	ociaP11ZECEkMR3aQprMthEo5tgw2Y85hhvK1lv1ApXc/+P+8oLAeTLDUIvLd4ISEd++rr
	iDQbAdI7xSQO79dzWB1oVaHTDqe3uik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753183929;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+PrCtUSn/haYuYkpVBJwpmXTnwMGxVaYRe8rwgXZQwo=;
	b=ePnRo2H7njgiuQC1z+MdaSf+6jyzYLOklvo2166JbpyuU72+frNUahBhXuJbCuEDbNCAWt
	pbU4zkZGsyDb9pDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753183929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+PrCtUSn/haYuYkpVBJwpmXTnwMGxVaYRe8rwgXZQwo=;
	b=pc577WtVL7G6sJjw/qnXpFmcTso5YQxMyKr294WPC/AJ45E8989bUE8RJFxsMeZmYGeoRv
	ociaP11ZECEkMR3aQprMthEo5tgw2Y85hhvK1lv1ApXc/+P+8oLAeTLDUIvLd4ISEd++rr
	iDQbAdI7xSQO79dzWB1oVaHTDqe3uik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753183929;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+PrCtUSn/haYuYkpVBJwpmXTnwMGxVaYRe8rwgXZQwo=;
	b=ePnRo2H7njgiuQC1z+MdaSf+6jyzYLOklvo2166JbpyuU72+frNUahBhXuJbCuEDbNCAWt
	pbU4zkZGsyDb9pDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 97F8713A32;
	Tue, 22 Jul 2025 11:32:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sdLEJLl2f2jiRwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 22 Jul 2025 11:32:09 +0000
Message-ID: <05001622-737d-40e7-8adc-5dd23e6b9bcb@suse.cz>
Date: Tue, 22 Jul 2025 13:32:09 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next:master] [mm, slab] 5660ee54e7:
 BUG:KASAN:stack-out-of-bounds_in_copy_from_iter
Content-Language: en-US
To: Pedro Falcato <pfalcato@suse.de>,
 kernel test robot <oliver.sang@intel.com>,
 Bernard Metzler <bmt@zurich.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>,
 David Howells <dhowells@redhat.com>, linux-mm@kvack.org
References: <202507220801.50a7210-lkp@intel.com>
 <jehx7y7mwer77d2rrx323qixc456ffod3qrcssemkebjotstbh@fpklsa72lzky>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 xsFNBFZdmxYBEADsw/SiUSjB0dM+vSh95UkgcHjzEVBlby/Fg+g42O7LAEkCYXi/vvq31JTB
 KxRWDHX0R2tgpFDXHnzZcQywawu8eSq0LxzxFNYMvtB7sV1pxYwej2qx9B75qW2plBs+7+YB
 87tMFA+u+L4Z5xAzIimfLD5EKC56kJ1CsXlM8S/LHcmdD9Ctkn3trYDNnat0eoAcfPIP2OZ+
 9oe9IF/R28zmh0ifLXyJQQz5ofdj4bPf8ecEW0rhcqHfTD8k4yK0xxt3xW+6Exqp9n9bydiy
 tcSAw/TahjW6yrA+6JhSBv1v2tIm+itQc073zjSX8OFL51qQVzRFr7H2UQG33lw2QrvHRXqD
 Ot7ViKam7v0Ho9wEWiQOOZlHItOOXFphWb2yq3nzrKe45oWoSgkxKb97MVsQ+q2SYjJRBBH4
 8qKhphADYxkIP6yut/eaj9ImvRUZZRi0DTc8xfnvHGTjKbJzC2xpFcY0DQbZzuwsIZ8OPJCc
 LM4S7mT25NE5kUTG/TKQCk922vRdGVMoLA7dIQrgXnRXtyT61sg8PG4wcfOnuWf8577aXP1x
 6mzw3/jh3F+oSBHb/GcLC7mvWreJifUL2gEdssGfXhGWBo6zLS3qhgtwjay0Jl+kza1lo+Cv
 BB2T79D4WGdDuVa4eOrQ02TxqGN7G0Biz5ZLRSFzQSQwLn8fbwARAQABzSBWbGFzdGltaWwg
 QmFia2EgPHZiYWJrYUBzdXNlLmN6PsLBlAQTAQoAPgIbAwULCQgHAwUVCgkICwUWAgMBAAIe
 AQIXgBYhBKlA1DSZLC6OmRA9UCJPp+fMgqZkBQJnyBr8BQka0IFQAAoJECJPp+fMgqZkqmMQ
 AIbGN95ptUMUvo6aAdhxaOCHXp1DfIBuIOK/zpx8ylY4pOwu3GRe4dQ8u4XS9gaZ96Gj4bC+
 jwWcSmn+TjtKW3rH1dRKopvC07tSJIGGVyw7ieV/5cbFffA8NL0ILowzVg8w1ipnz1VTkWDr
 2zcfslxJsJ6vhXw5/npcY0ldeC1E8f6UUoa4eyoskd70vO0wOAoGd02ZkJoox3F5ODM0kjHu
 Y97VLOa3GG66lh+ZEelVZEujHfKceCw9G3PMvEzyLFbXvSOigZQMdKzQ8D/OChwqig8wFBmV
 QCPS4yDdmZP3oeDHRjJ9jvMUKoYODiNKsl2F+xXwyRM2qoKRqFlhCn4usVd1+wmv9iLV8nPs
 2Db1ZIa49fJet3Sk3PN4bV1rAPuWvtbuTBN39Q/6MgkLTYHb84HyFKw14Rqe5YorrBLbF3rl
 M51Dpf6Egu1yTJDHCTEwePWug4XI11FT8lK0LNnHNpbhTCYRjX73iWOnFraJNcURld1jL1nV
 r/LRD+/e2gNtSTPK0Qkon6HcOBZnxRoqtazTU6YQRmGlT0v+rukj/cn5sToYibWLn+RoV1CE
 Qj6tApOiHBkpEsCzHGu+iDQ1WT0Idtdynst738f/uCeCMkdRu4WMZjteQaqvARFwCy3P/jpK
 uvzMtves5HvZw33ZwOtMCgbpce00DaET4y/UzsBNBFsZNTUBCACfQfpSsWJZyi+SHoRdVyX5
 J6rI7okc4+b571a7RXD5UhS9dlVRVVAtrU9ANSLqPTQKGVxHrqD39XSw8hxK61pw8p90pg4G
 /N3iuWEvyt+t0SxDDkClnGsDyRhlUyEWYFEoBrrCizbmahOUwqkJbNMfzj5Y7n7OIJOxNRkB
 IBOjPdF26dMP69BwePQao1M8Acrrex9sAHYjQGyVmReRjVEtv9iG4DoTsnIR3amKVk6si4Ea
 X/mrapJqSCcBUVYUFH8M7bsm4CSxier5ofy8jTEa/CfvkqpKThTMCQPNZKY7hke5qEq1CBk2
 wxhX48ZrJEFf1v3NuV3OimgsF2odzieNABEBAAHCwXwEGAEKACYCGwwWIQSpQNQ0mSwujpkQ
 PVAiT6fnzIKmZAUCZ8gcVAUJFhTonwAKCRAiT6fnzIKmZLY8D/9uo3Ut9yi2YCuASWxr7QQZ
 lJCViArjymbxYB5NdOeC50/0gnhK4pgdHlE2MdwF6o34x7TPFGpjNFvycZqccSQPJ/gibwNA
 zx3q9vJT4Vw+YbiyS53iSBLXMweeVV1Jd9IjAoL+EqB0cbxoFXvnjkvP1foiiF5r73jCd4PR
 rD+GoX5BZ7AZmFYmuJYBm28STM2NA6LhT0X+2su16f/HtummENKcMwom0hNu3MBNPUOrujtW
 khQrWcJNAAsy4yMoJ2Lw51T/5X5Hc7jQ9da9fyqu+phqlVtn70qpPvgWy4HRhr25fCAEXZDp
 xG4RNmTm+pqorHOqhBkI7wA7P/nyPo7ZEc3L+ZkQ37u0nlOyrjbNUniPGxPxv1imVq8IyycG
 AN5FaFxtiELK22gvudghLJaDiRBhn8/AhXc642/Z/yIpizE2xG4KU4AXzb6C+o7LX/WmmsWP
 Ly6jamSg6tvrdo4/e87lUedEqCtrp2o1xpn5zongf6cQkaLZKQcBQnPmgHO5OG8+50u88D9I
 rywqgzTUhHFKKF6/9L/lYtrNcHU8Z6Y4Ju/MLUiNYkmtrGIMnkjKCiRqlRrZE/v5YFHbayRD
 dJKXobXTtCBYpLJM4ZYRpGZXne/FAtWNe4KbNJJqxMvrTOrnIatPj8NhBVI0RSJRsbilh6TE
 m6M14QORSWTLRg==
In-Reply-To: <jehx7y7mwer77d2rrx323qixc456ffod3qrcssemkebjotstbh@fpklsa72lzky>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-8.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -8.30

On 7/22/25 12:52, Pedro Falcato wrote:
> +cc dhowells

+Cc siw+infiniband maintainers too.

Thanks Pedro. Hope there can be either a hotfix for 6.16, or the fix is part
of 6.17 merge window (and I tell Linus to merge slab only afterwards), or I
get the blessing to include it in my tree preceding commit 5660ee54e798 (to
be merged in 6.17 merge window).

Also would you submit the fix formally?

Thanks,
Vlastimil

> On Tue, Jul 22, 2025 at 03:07:44PM +0800, kernel test robot wrote:
>> 
>> 
>> Hello,
>> 
>> kernel test robot noticed "BUG:KASAN:stack-out-of-bounds_in_copy_from_iter" on:
>> 
>> commit: 5660ee54e7982f9097ddc684e90f15bdcc7fef4b ("mm, slab: use frozen pages for large kmalloc")
>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>> 
>> [test failed on linux-next/master d086c886ceb9f59dea6c3a9dae7eb89e780a20c9]
>> 
>> in testcase: blktests
>> version: blktests-x86_64-5d9ef47-1_20250709
>> with following parameters:
>> 
>> 	disk: 1SSD
>> 	test: nvme-group-00
>> 	nvme_trtype: rdma
>> 	use_siw: true
>> 
>> 
>> 
>> config: x86_64-rhel-9.4-func
>> compiler: gcc-12
>> test machine: 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz (Skylake) with 28G memory
>> 
>> (please refer to attached dmesg/kmsg for entire log/backtrace)
>> 
>> 
>> 
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <oliver.sang@intel.com>
>> | Closes: https://lore.kernel.org/oe-lkp/202507220801.50a7210-lkp@intel.com
>> 
>> 
>> [ 232.729908][ T3003] BUG: KASAN: stack-out-of-bounds in _copy_from_iter (include/linux/iov_iter.h:117 include/linux/iov_iter.h:304 include/linux/iov_iter.h:328 lib/iov_iter.c:249 lib/iov_iter.c:260) 
>> [  232.737608][ T3003] Read of size 4 at addr ffffc90002527694 by task siw_tx/2/3003
>> [  232.745045][ T3003]
>> [  232.747222][ T3003] CPU: 2 UID: 0 PID: 3003 Comm: siw_tx/2 Not tainted 6.16.0-rc2-00002-g5660ee54e798 #1 PREEMPT(voluntary)
>> [  232.747226][ T3003] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.2.8 01/26/2016
>> [  232.747228][ T3003] Call Trace:
>> [  232.747230][ T3003]  <TASK>
>> [ 232.747231][ T3003] dump_stack_lvl (lib/dump_stack.c:123 (discriminator 1)) 
>> [ 232.747236][ T3003] print_address_description+0x2c/0x3b0 
>> [ 232.747241][ T3003] ? _copy_from_iter (include/linux/iov_iter.h:117 include/linux/iov_iter.h:304 include/linux/iov_iter.h:328 lib/iov_iter.c:249 lib/iov_iter.c:260) 
>> [ 232.747244][ T3003] print_report (mm/kasan/report.c:522) 
>> [ 232.747247][ T3003] ? kasan_addr_to_slab (mm/kasan/common.c:37) 
>> [ 232.747250][ T3003] ? _copy_from_iter (include/linux/iov_iter.h:117 include/linux/iov_iter.h:304 include/linux/iov_iter.h:328 lib/iov_iter.c:249 lib/iov_iter.c:260) 
>> [ 232.747252][ T3003] kasan_report (mm/kasan/report.c:636) 
>> [ 232.747255][ T3003] ? _copy_from_iter (include/linux/iov_iter.h:117 include/linux/iov_iter.h:304 include/linux/iov_iter.h:328 lib/iov_iter.c:249 lib/iov_iter.c:260) 
>> [ 232.747259][ T3003] _copy_from_iter (include/linux/iov_iter.h:117 include/linux/iov_iter.h:304 include/linux/iov_iter.h:328 lib/iov_iter.c:249 lib/iov_iter.c:260) 
>> [ 232.747263][ T3003] ? __pfx__copy_from_iter (lib/iov_iter.c:254) 
>> [ 232.747266][ T3003] ? __pfx_tcp_current_mss (net/ipv4/tcp_output.c:1873) 
>> [ 232.747270][ T3003] ? check_heap_object (arch/x86/include/asm/bitops.h:206 arch/x86/include/asm/bitops.h:238 include/asm-generic/bitops/instrumented-non-atomic.h:142 include/linux/page-flags.h:867 include/linux/page-flags.h:888 include/linux/mm.h:992 include/linux/mm.h:2050 mm/usercopy.c:199) 
>> [  232.747274][ T3003]  ? 0xffffffff81000000
>> [ 232.747276][ T3003] ? __check_object_size (mm/memremap.c:421) 
>> [ 232.747280][ T3003] skb_do_copy_data_nocache (include/linux/uio.h:228 include/linux/uio.h:245 include/net/sock.h:2243) 
>> [ 232.747284][ T3003] ? __pfx_skb_do_copy_data_nocache (include/net/sock.h:2234) 
>> [ 232.747286][ T3003] ? __sk_mem_schedule (net/core/sock.c:3403) 
>> [ 232.747291][ T3003] tcp_sendmsg_locked (include/net/sock.h:2271 net/ipv4/tcp.c:1254) 
>> [ 232.747297][ T3003] ? sock_sendmsg (net/socket.c:712 net/socket.c:727 net/socket.c:750) 
>> [ 232.747300][ T3003] ? __pfx_tcp_sendmsg_locked (net/ipv4/tcp.c:1061) 
>> [ 232.747303][ T3003] ? __pfx_sock_sendmsg (net/socket.c:739) 
>> [ 232.747306][ T3003] ? _raw_spin_lock_bh (arch/x86/include/asm/atomic.h:107 include/linux/atomic/atomic-arch-fallback.h:2170 include/linux/atomic/atomic-instrumented.h:1302 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:127 kernel/locking/spinlock.c:178) 
>> [ 232.747312][ T3003] siw_tcp_sendpages+0x1f1/0x4f0 siw 
> 
> It seems to me that the change introduced back in 6.4 by David was silently
> borked (credit to Vlastimil for initially pointing it out to me). Namely:
> 
> https://lore.kernel.org/all/20230331160914.1608208-1-dhowells@redhat.com/
> introduced three changes, where we're inlining tcp_sendpages:
> 
> c2ff29e99a76 ("siw: Inline do_tcp_sendpages()")
> e117dcfd646e ("tls: Inline do_tcp_sendpages()")
> 7f8816ab4bae ("espintcp: Inline do_tcp_sendpages()")
> 
> (there's a separate ebf2e8860eea, but it looks okay)
> 
> Taking a closer look into siw (my comments):
> 
> static int siw_tcp_sendpages(struct socket *s, struct page **page, int offset,
> 			     size_t size)
> [...]
> 	/* Calculate the number of bytes we need to push, for this page
> 	 * specifically */
> 	size_t bytes = min_t(size_t, PAGE_SIZE - offset, size);
> 	/* If we can't splice it, then copy it in, as normal */
> 	if (!sendpage_ok(page[i]))
> 		msg.msg_flags &= ~MSG_SPLICE_PAGES;
> 	/* Set the bvec pointing to the page, with len $bytes */
> 	bvec_set_page(&bvec, page[i], bytes, offset);
> 	/* Set the iter to $size, aka the size of the whole sendpages (!!!) */
> 	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, size);
> try_page_again:
> 	lock_sock(sk);
> 	/* Sendmsg with $size size (!!!) */
> 	rv = tcp_sendmsg_locked(sk, &msg, size);
> 
> 
> Now, (probably) why we didn't see this before: ever since Vlastimil introduced
> 5660ee54e798("mm, slab: use frozen pages for large kmalloc") into -next, sendpage_ok
> fails for large kmalloc pages. This makes it so we don't take the MSG_SPLICE_PAGES paths,
> which have a subtle difference deep into iov_iter paths:
> 
> (MSG_SPLICE_PAGES)
> skb_splice_from_iter
>   iov_iter_extract_pages
>     iov_iter_extract_bvec_pages
>       uses i->nr_segs to correctly stop in its tracks before OoB'ing everywhere
>   skb_splice_from_iter gets a "short" read
> 
> (!MSG_SPLICE_PAGES)
> skb_copy_to_page_nocache copy=iov_iter_count
>  [...]
>    copy_from_iter
>    	/* this doesn't help */
>      	if (unlikely(iter->count < len))
> 		len = iter->count;
> 	  iterate_bvec
> 	    ... and we run off the bvecs
> 
> Anyway, long-winded analysis just to say:
> 
> --- a/drivers/infiniband/sw/siw/siw_qp_tx.c
> +++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
> @@ -332,11 +332,11 @@ static int siw_tcp_sendpages(struct socket *s, struct page **page, int offset,
>                 if (!sendpage_ok(page[i]))
>                         msg.msg_flags &= ~MSG_SPLICE_PAGES;
>                 bvec_set_page(&bvec, page[i], bytes, offset);
> -               iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, size);
> +               iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, bytes);
> 
>  try_page_again:
>                 lock_sock(sk);
> -               rv = tcp_sendmsg_locked(sk, &msg, size);
> +               rv = tcp_sendmsg_locked(sk, &msg, bytes);
>                 release_sock(sk);
> 
>                 if (rv > 0) {
> 
> (I had a closer look at the tls, espintcp changes, and they seem correct)
> 


