Return-Path: <linux-rdma+bounces-19604-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIV8ObvF72m4FwEAu9opvQ
	(envelope-from <linux-rdma+bounces-19604-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 22:23:23 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1436A479F9F
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 22:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7789A3047BD8
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 20:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE2436AB4B;
	Mon, 27 Apr 2026 20:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S+3XisTr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8224F36605D
	for <linux-rdma@vger.kernel.org>; Mon, 27 Apr 2026 20:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777321248; cv=none; b=ZNqWccNj2XBxrMboHPhNurXO0UCz85F6lSK2Mal7ikQykrSJk6sDX+7xbYj7JzUG1Fepp//uoYcOPmNqnDIAHj9l5DWPhUhTKBw87RpCgbBLZWKlUlKsdu9UAhE7vHOv0B4KAdTHwWD9aDlmn4pHfLGJxaQx92pAOiO1OkqKf+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777321248; c=relaxed/simple;
	bh=Wc7kdDlkgJo6u6009qGQeD3ZunIEMerUDHyNc7n1Oq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nVxE0yDg2ZCV3ivlAB8mzyvXQ7AyWaJ96TUmopchLEl8/fi1cMOSZvhwZJNncV7BFTYXDX4H4h4aeRUVAAU4CCqC40BVyR0AiiazUIMZirdT20g5gD7E4gKTL0YunnKQYQUKjSICS+34Kytmc04KM0HqvFq5q/xjPB8Oe14YmUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S+3XisTr; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0cf42593-0149-4019-a51b-36f74ff67f51@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777321243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KODjF/C2Q+xylwDA12rhmxUYxfUoU9arw+CvoLBWZ20=;
	b=S+3XisTreNN7ccYjjm1jSlX90/dQDyGF/ukLUer+1O6Efc6cCB/SF/kOKYUKIjh9BFvuQ/
	Z5qpUjpCzkPRga2C04NeHcKvmZkwGdRG7fYVyrk7bAr0/lscz2RC31FguwflrgCz4uU6Js
	O68ixY5e2D+RCUVkwW2FGu1vVzpq0do=
Date: Mon, 27 Apr 2026 13:20:37 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] RDMA/rxe: Fix null-ptr-deref in
 kernel_sock_shutdown().
To: David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 linux-rdma@vger.kernel.org,
 syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com
References: <20260425060436.2316620-1-kuniyu@google.com>
 <20260425060436.2316620-2-kuniyu@google.com>
 <030d3487-b5b9-4067-8b8c-89b4e8756e1a@linux.dev>
 <86499305-4522-4a82-a689-0247f2d5f6c0@kernel.org>
 <4196fe33-88c2-416d-ac20-b68bf7f328a6@linux.dev>
 <CAAVpQUAh2KT=YpfDO5nkqrzH0kbAXEBVe6jtOtLc93wjs3N7Fg@mail.gmail.com>
 <e2e1406f-8d9d-4a96-949d-e75096446d1a@linux.dev>
 <9681c9e2-79a9-4d72-b1ad-229ba6d7aab7@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "yanjun.zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <9681c9e2-79a9-4d72-b1ad-229ba6d7aab7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 1436A479F9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19604-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[gmail.com,ziepe.ca,kernel.org,vger.kernel.org,syzkaller.appspotmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,d8f76778263ab65c2b21];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid]

On 4/27/26 7:38 AM, David Ahern wrote:
> On 4/26/26 9:53 PM, Zhu Yanjun wrote:
>>> That said, I don't have a strong preference, so up to you
>>> maintainers.  Simple lockless solution vs per-newlink/dellink
>>> locking.
>> To be honest, I do not have a strong preference here, though
>>
>> I lean slightly toward the per-newlink/dellink locking approach.
>>
>> Both the simple lockless solution and the locking approach seem
>>
>> reasonable, depending on whether we prioritize simplicity or
>>
>> explicit synchronization and lifecycle clarity.
>>
>> It would be helpful to get feedback from David Ahern, Leon,
>>
>> and Jason to converge on a final direction.
> 
> 
> Going in circles. I have said from the beginning of network namespace
> support for rxe do not open the port until first rxe device create and
> once opened leave it open. Simple design that limits socket churn to
> users wanting to leverage rxe in a network namespace. Zhu Yanjun, if you
> are going to be a maintainer of a feature you need to have a consistent
> stance on the architecture and code design.

Thanks for the clarification — I see your point about keeping the design 
simple and avoiding unnecessary socket churn.

I agree that deferring the port open until the first RXE device is 
created, and keeping it open afterwards, provides a cleaner and more 
predictable model. It also better scopes the overhead to users who 
actually rely on RXE within a network namespace.

My earlier responses were not consistent, and that’s on me. I was 
exploring different approaches, but I understand that as a maintainer I 
need to converge on a clear and stable architectural direction.

Unless there are strong objections, I will align the implementation with 
this model and make sure the behavior is consistent across the code 
paths. I’ll also revisit the current patches to ensure they follow this 
design principle.

Please let me know if there are additional constraints or edge cases I 
should consider.

@Kuniyuki Iwashima, Please follow the per-newlink/dellink locking 
approach. Thanks a lot.

Zhu Yanjun

