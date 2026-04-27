Return-Path: <linux-rdma+bounces-19590-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EB9NJIV272mZBgEAu9opvQ
	(envelope-from <linux-rdma+bounces-19590-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 16:45:25 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FE44749FB
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 16:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6629A3060D5A
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 14:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90E93195FC;
	Mon, 27 Apr 2026 14:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XEc+n+bl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DD6317160
	for <linux-rdma@vger.kernel.org>; Mon, 27 Apr 2026 14:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777300716; cv=none; b=bwPc2ffXzkF9SzkAdba8xNsqEhXACmveTc7yI8OPydaVSw87VozSPyLovrXiGHBxqYqav0+a6H4OBKWy/eUJohtO7X5X5GkfV5kHzH4FHN/yaTogVGSMqWnvn5jJT40AFi6w3vdWHIqM+PoKcxwnvAM2uYdHcbtmR1eycLXr0CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777300716; c=relaxed/simple;
	bh=46XpfX6wkHAcy501fXHRyYSs+6aBGubG2ApXfZePM2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U1vlc0u3JMe+N5GsjMhHGw2RFHZ61f3B6lYuk57l5q4jkit7R0O1HP4ihVRmfRerCShobmk1pDo9TKdvqhSshdU2UbLvEKtB/BfwKQ3chlv4KK4Nulh6CbfuId3yEAa5Bc4RoeYv1yT5E2fWvv4fZIAvmgGULWLKSVMX818p4EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XEc+n+bl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC4D9C19425;
	Mon, 27 Apr 2026 14:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777300716;
	bh=46XpfX6wkHAcy501fXHRyYSs+6aBGubG2ApXfZePM2o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XEc+n+blhoNyH0GDjc7bBAn0krFLEdsPPdaSIt3aKFBEPnwU3ri804+Acc2B+7PwN
	 aifglQ20yw0WDP3+iS5H5CVBda9ktjL/FUJJMlsAy2/1eaZmUZTuTRe+7QKLNK4Xr3
	 Yd3MbTSNJR21MzJT1CmT7MeThbqTKLVCGW13r1s7uJL3OGFXYpWriJiBMYfHoAzMtx
	 09noZzZ1xkfzUOrPHhZob7IpT3U5lW5mcURLtapeUSIPoVRMGsK25Vu+LLMxS2fUju
	 KC1yKizQD9JmfXtTHAbICBEYUSpTdYAIrmHFaaf2K/hyu9eKrgR9LIC9FISThdUs6v
	 0TYxO28dDMXFw==
Message-ID: <9681c9e2-79a9-4d72-b1ad-229ba6d7aab7@kernel.org>
Date: Mon, 27 Apr 2026 08:38:35 -0600
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] RDMA/rxe: Fix null-ptr-deref in
 kernel_sock_shutdown().
Content-Language: en-US
To: Zhu Yanjun <yanjun.zhu@linux.dev>, Kuniyuki Iwashima <kuniyu@google.com>
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
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <e2e1406f-8d9d-4a96-949d-e75096446d1a@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 13FE44749FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,ziepe.ca,kernel.org,vger.kernel.org,syzkaller.appspotmail.com];
	TAGGED_FROM(0.00)[bounces-19590-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,d8f76778263ab65c2b21];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On 4/26/26 9:53 PM, Zhu Yanjun wrote:
>> That said, I don't have a strong preference, so up to you
>> maintainers.  Simple lockless solution vs per-newlink/dellink
>> locking.
> To be honest, I do not have a strong preference here, though
> 
> I lean slightly toward the per-newlink/dellink locking approach.
> 
> Both the simple lockless solution and the locking approach seem
> 
> reasonable, depending on whether we prioritize simplicity or
> 
> explicit synchronization and lifecycle clarity.
> 
> It would be helpful to get feedback from David Ahern, Leon,
> 
> and Jason to converge on a final direction.


Going in circles. I have said from the beginning of network namespace
support for rxe do not open the port until first rxe device create and
once opened leave it open. Simple design that limits socket churn to
users wanting to leverage rxe in a network namespace. Zhu Yanjun, if you
are going to be a maintainer of a feature you need to have a consistent
stance on the architecture and code design.

