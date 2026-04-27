Return-Path: <linux-rdma+bounces-19575-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id HCUrL60/72kM/QAAu9opvQ
	(envelope-from <linux-rdma+bounces-19575-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 12:51:25 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 29414471417
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 12:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75DD4300B9D4
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 10:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC253B2FF4;
	Mon, 27 Apr 2026 10:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="JWkfdLEA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9761C862F
	for <linux-rdma@vger.kernel.org>; Mon, 27 Apr 2026 10:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777286938; cv=none; b=KI8V2in7AWLfYb6czrMImJdjuPjzwzxXRthwW9qxZwvTeYfG8aAujE4w8iIdUYZqk/tCAHIe4p99LVggGIqeiTZKo3m6zTN8AFvlFN8p6yszYjYdJREIvxmR6c7iOBg8MB3f5wbsd2hUmGPuWkT6a3Hj2vk04M9JIThtklJYzVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777286938; c=relaxed/simple;
	bh=7lgpNiBOz7bmBnrNQ/hViLvKPUvix4mzOTtwGFnyXp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=leKCzkFJfZ8HIc7XS/s1EJbyILgiUt1iSYhYwNlDTLzU0vnxDTycGevhERFlzQt5+9u5i2HOIDfqLe+Pu71by87AB51Rs8VRW6S0xuu2MHhoPun88qfF4m+xyZRJKBx3/yX1Sd7IjYSbpUgi6HDKhLhNp0vi2boPt+2tatX8JbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=JWkfdLEA; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso74650435e9.2
        for <linux-rdma@vger.kernel.org>; Mon, 27 Apr 2026 03:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1777286932; x=1777891732; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8440vjqkIDKLpfikmVBsDH70QXTUzaYPiyHKfzIMqJk=;
        b=JWkfdLEAPqAYOS+bieb8blB5nbs+A1uOsidDV4GIk6ChMyEte77r5f+gNzHoq8QZlb
         5GpCmtjkurwZ0T1WkHwWpJTWNtxQo6EYM7gRLPnIUokcAZL0YIPeuxD0lCFQpnOx2s4c
         0pRofVODafWO+2/eIgQDpZR9ccs7k1rWCZrgws3X/8xNexcQ5vxI5xr7Ov+CSx46d4Hs
         JJwHRk4oOYHIWlEuYPjFaDfGQp9rf4f/GCa9k7Y0mW3Z6jHuarpU4R0ow+PpNyZNAWvl
         1pGL0ygDzBh++BYUpsQfCuwxdTg9Zr0gUyABuEn0NX/bFJuDFl2g7pnCFS+eKTFtcD+t
         bxNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777286932; x=1777891732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8440vjqkIDKLpfikmVBsDH70QXTUzaYPiyHKfzIMqJk=;
        b=eWn2lYAvqPd2V4kBBVRvSGyX0ptwOueskcN36ee6iaODv9oyE9rIbv8trAR0QuCHXq
         gWzd+QyAYLsO5ZyRW4umuskdZRG3h6FnR1+0/R+D3EPGZb9fbOC9ajmAwqtntxBMT+en
         40rq+5w1MIQR5SBtMcjs9kthoUsfQm5Rl7gvt31T9w8hDHN/TLviBqSK4daTZ5lKljX9
         9DWwjPPqKl7+op4kWKDIpvedpZTeVsL3MYvCJCKPccZLgDZAwNGynU/QhqqT5GNvGw39
         PviSbD1lgRcc8O72lmTwEQHttU4FQ797l6TSEhMBp9LFaQHtunjN0T1WArMA1epnc5xO
         IQzg==
X-Forwarded-Encrypted: i=1; AFNElJ808tMA9U113Ws127tf+3+ndbOegLwZphAz26iYzcf7OClGpJA53GhbcJH+3HvpjReX9kRwkt5w/zDp@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg1JPuRClwXbrZzF2dhLWJ3b//XgMA3Uv97PEAJSsZHyYUM1ta
	h8fuma3o8eYAwEvi7zqwltUSOGYM8Y6IeGHPjHtCakJRHoanqZJWBPM5fn2ptpTtM/c=
X-Gm-Gg: AeBDies+PgpESV+Px3eUCtzZqch+0X5XCJSskYn5iNUgLcCV1wYua/ikteuWA6pG3nI
	m9SnJKmcIk5az3xd5lOc9MaaG/FlfB/eOR7tgVS/4+Z+n+jqjOiedgYDs21QFB6BFre8fBVaJF3
	Z6dLlgVjggFLi3Ghjl/mMi8UuD7Onuul6nxxkCg6eD/xSrAV/h4cS61j1KT2AI5YO2o/ejS6rYs
	AvYSkgR9DSU4D9/FPKbK0n9Hu/v68j27xykHAKYfT1Sh+xFsh1mu7tdayPo7pUiuqrbNYStkYHo
	8uoBU5QUxOHto+LCA+IlNHjLKxg/M1wEF3h/VA+LVCAz9SoGL3n/pzobneKrqUXOLV9PYjIUUWb
	grpMP5I0pq1x5kBXQ6FThKIHuOYclarQuxsJBMWsMHFvnGWLX5wk1e2Tx7ohnEg3+ku4I73V+KB
	lM97BsPjnRqt7twPeCfI6SWwgcIUs3T7cqRpDCQnbLPOLiig==
X-Received: by 2002:a05:600c:5285:b0:48a:5333:811e with SMTP id 5b1f17b1804b1-48a53338269mr450830315e9.15.1777286931349;
        Mon, 27 Apr 2026 03:48:51 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc10019bsm805488775e9.4.2026.04.27.03.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 03:48:50 -0700 (PDT)
Date: Mon, 27 Apr 2026 12:48:46 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org, 
	mrgolin@amazon.com, gal.pressman@linux.dev, sleybo@amazon.com, parav@nvidia.com, 
	mbloch@nvidia.com, yanjun.zhu@linux.dev, marco.crivellari@suse.com, 
	roman.gushchin@linux.dev, phaddad@nvidia.com, lirongqing@baidu.com, ynachum@amazon.com, 
	huangjunxian6@hisilicon.com, kalesh-anakkur.purayil@broadcom.com, ohartoov@nvidia.com, 
	michaelgur@nvidia.com, shayd@nvidia.com, edwards@nvidia.com, 
	sriharsha.basavapatna@broadcom.com, andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-next v2 01/15] RDMA/core: Introduce generic buffer
 descriptor infrastructure for umem
Message-ID: <jpobfdsuuj4wmrqkxzpjmfjxgz6vn2m6a6wy666yfapv6hzytj@6g5qrelixuwe>
References: <20260411144915.114571-1-jiri@resnulli.us>
 <20260411144915.114571-2-jiri@resnulli.us>
 <20260421134635.GG3611611@ziepe.ca>
 <pun4bxcclwqmurxzxuqlkv5qdpiqcxqjpbhrz7vtsjf2paallz@6f3w32ww4gl7>
 <sdmwjrxzgbg4iz5cspcdkvvdb7rjgdggkw4njct3pkdsvhsq24@qstis6jnplap>
 <20260422165101.GO3611611@ziepe.ca>
 <20260426135340.GH440345@unreal>
 <20260426225034.GA3540346@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260426225034.GA3540346@ziepe.ca>
X-Rspamd-Queue-Id: 29414471417
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19575-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,resnulli-us.20251104.gappssmtp.com:dkim]

Mon, Apr 27, 2026 at 12:50:34AM +0200, jgg@ziepe.ca wrote:
>On Sun, Apr 26, 2026 at 04:53:40PM +0300, Leon Romanovsky wrote:
>> > Well, brainstorming idea. I'd like to hear from Leon too
>> > 
>> > But if we set the general goals as:
>> > 
>> > 1) All umem creations should have a struct ib_uverbs_buffer_desc at
>> >    the UAPI boundary
>> > 2) ib_uverbs_buffer_desc should pass directly to umem code without any
>> >    driver touching it. ib_uverbs_buffer_desc should be the only way to
>> >    create a umem from a driver.
>> > 3) Existing UWH umem descriptions must continue to work if the desc is
>> >    not provided, by reforming them into a desc
>> > 3) Cleanup and lifecycle should be centralized
>> 
>> I have mixed feelings about this. My CQ conversion showed that even a simple
>> task like creating a CQ umem (numb_of_entries * size_of_entries) ends up full
>> of creative hacks in various drivers. Because of that, I see real value in
>> pushing as much logic as possible into the core code instead of duplicating it
>> across drivers. However, my later attempt to change the QP path made it clear
>> that creating umems in the core is not a viable goal in the general case.
>> 
>> Another outcome of that work was realizing that CQ resize (and probably MR
>> rereg as well) becomes messy when we keep the "old" umem around. Splitting
>> creation and cleanup into different layers probably will going to hurt us
>> at some point of time.
>> 
>> To summarize:
>> 1. The most practical fix is likely to provide a driver callback to create
>>    the umem when needed, as you suggested.
>> 2. We should reduce the use of UWH as much as possible in favor of a
>>    well-defined schema. In the long run, we want to add more umem types,
>>    and many drivers should work out of the box under that model.
>> 3. Explicit behavior is preferable. If a driver creates something, the
>>    driver should also clean it up.
>> 
>> I'm not saying no to your proposal, just expressing my thoughts.
>
>So, I think making small steps that upgrade all drivers will be
>helpful here.
>
>If we can get all drivers calling the same attrs function and giving
>their uhw parameters that is a good step closer to being able to put
>that in a function if that is how things need to go down the road.
>
>And it does #2..
>
>Not sure about #3, we already moved toward core destroying umems it
>may not be a good idea to try to undo that now.. But maybe we just
>keep that for CQ and leave QP as driver managed?

I think that the uniform approach is better in order not to confuse
people. Perhaps one day we will manage to untangle the create QP flow
and separate user/kernel paths too. But:

After lots for thinking and back and forth motions, I tend to agree
with Leon, the init/fini alloc/free should be symmetric
in drivers. Now, that the core will never create umem and the driver is
always responsible to create it, the driver should be the one to
do release. Drivers still store the umem pointer locally.
Then there is not need for ib_umem_list, makes things much easier
and more neat. Another pro is, the code does not care if called on
user or kernel part.



