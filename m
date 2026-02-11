Return-Path: <linux-rdma+bounces-16742-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HA2Csnbi2nMcAAAu9opvQ
	(envelope-from <linux-rdma+bounces-16742-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 02:30:49 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F15F212077A
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 02:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91C54304702D
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 01:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F5D15853B;
	Wed, 11 Feb 2026 01:30:45 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BAF1E511
	for <linux-rdma@vger.kernel.org>; Wed, 11 Feb 2026 01:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770773445; cv=none; b=Xy++Z3aSPlLBqwL5LYY6Nn512s2ciXgJOg9oCmjVichfGSWONXTFBkt+riOrFzUo0C9AcCDko5qaVNmImWKKTWycAbZMMCihfTG4d4cuY4EpI1wiQAhNhv2dWlwG7MbR0+Bbx5IQlJhjuciM8cgFxVcJLznLaizId1kj20qiR0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770773445; c=relaxed/simple;
	bh=WGnhyQrPZAXL5WCGdui16zyuDMo5u0EzWMsvkifjKpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RxT4PR00bxpJmDKDY/z6f1QL6iRSq+nC0n15VSps0NHwzk06GNfJeN4JXA6mEN8m3kkESklRbwVEgTKClGQ3jyyJOl0x/FDpFZFR9aPSclgIgxngG9Z7Wz4f1iuXK/Tks+x7sxipi2sbW+0HppDy3DKdip7tjWG7a3f+k1Se/UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 61B1UHBN090117;
	Wed, 11 Feb 2026 10:30:17 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 61B1UHfJ090114
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 11 Feb 2026 10:30:17 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <ebdbde90-3583-48dd-a5d8-7a039a9a38a6@I-love.SAKURA.ne.jp>
Date: Wed, 11 Feb 2026 10:30:17 +0900
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/core: Fix stale RoCE GIDs during netdev events at
 registration
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jiri Pirko <jiri@resnulli.us>, linux-rdma@vger.kernel.org, leon@kernel.org,
        msanalla@nvidia.com, maorg@nvidia.com, parav@nvidia.com,
        mbloch@nvidia.com, markzhang@nvidia.com, marco.crivellari@suse.com,
        roman.gushchin@linux.dev, "Yanjun.Zhu" <yanjun.zhu@linux.dev>
References: <u7t7kha66tqngzyoryly6pltiur4wtz6gm3nui3zeb32dmtctp@54rr6gcsqtap>
 <1dc21045-4030-4d37-9ae6-3dd2c42b8e88@I-love.SAKURA.ne.jp>
 <inp2nyil62tkkvahvjvwvgp63ld5cffgowqhwlbssabhd2gaka@52lfxbmxvbzi>
 <8bdfe8a3-1cdb-43e3-b68e-428f6c5133d5@I-love.SAKURA.ne.jp>
 <j5tnfwmkfqtmmtpkbcdxriu7wlgxydazuvkk4nkfv27nddlq4r@xx4amuxv6y7y>
 <d6aee73d-91cb-4eb3-ad11-6244e973932b@I-love.SAKURA.ne.jp>
 <20260202235133.GP2328995@ziepe.ca>
 <c5ebe396-eccf-450b-8486-e1900258d9c0@I-love.SAKURA.ne.jp>
 <eqplwtvsocnqesb7vysnb6cq2emmghbg5wttkc6oyltsqtw6zi@6iewgx2qnsml>
 <3f1881d9-243d-4869-8396-5cca2e915733@I-love.SAKURA.ne.jp>
 <20260210154242.GB750753@ziepe.ca>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20260210154242.GB750753@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav303.rs.sakura.ne.jp
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[penguin-kernel@I-love.SAKURA.ne.jp,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16742-lists,linux-rdma=lfdr.de];
	DMARC_NA(0.00)[i-love.sakura.ne.jp];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,I-love.SAKURA.ne.jp:mid]
X-Rspamd-Queue-Id: F15F212077A
X-Rspamd-Action: no action

On 2026/02/11 0:42, Jason Gunthorpe wrote:
> This seems like a different thing, why does it matter if an unregister
> event is lost like this?
> 
> gid_table_cleanup_one() removes all gids regardless of the state of
> the netdev? It isn't going to start leaking a netdev reference if you
> hit this race?

Yes, syzbot is reporting

  unregister_netdevice: waiting for bond1 to become free. Usage count = 2

problem when we hit this unregister race and gid_table_cleanup_one() cannot
be called within 10 seconds after xa_clear_mark(DEVICE_REGISTERED) is called
( https://lkml.kernel.org/r/c1f9511c-7ad0-444d-aa0c-516674702b4e@I-love.SAKURA.ne.jp ).

> 
> It isn't going to block unregister from progressing AFAICT.

Parav Pandit suspects that this race is relevant but you don't think
this race is relevant.

I'm currently monitoring linux-next tree whether there is a refcount leak,
by watching for khungtaskd warning at wait_for_completion() from
disable_device() from __ib_unregister_device(). If syzbot starts reporting
khungtaskd warning instead of

  unregister_netdevice: waiting for bond1 to become free. Usage count = 2

warning in linux-next tree, we can conclude that this unregister race is
a different thing.


