Return-Path: <linux-rdma+bounces-19618-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id L5QSCmAG8GmoNQEAu9opvQ
	(envelope-from <linux-rdma+bounces-19618-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 02:59:12 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CE947C45D
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 02:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D58CA302DA3B
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 00:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7156C2848A1;
	Tue, 28 Apr 2026 00:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sqn5ADPL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FFB26B74A
	for <linux-rdma@vger.kernel.org>; Tue, 28 Apr 2026 00:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777337920; cv=none; b=CC2YDq7uPbbBWguqIIVzE+PuW/PQ7ksEhg7jPxeEZFOqxM4XtLEUMzkF+YHs6+Tjs8kYtMePxBqK0EN4f4ROt7HbRB8HNXKebbcFSiosG/vnFTxg8DWKa3ndBBP8zBsRZF6AhpG/OClIhsz7w44mwRC84UGddkfdPQaxJuLSQL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777337920; c=relaxed/simple;
	bh=o4knKAc6QwanZkMYuNvml2KCFjuGpUo1cJgFacZj4rw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ke1gIKFR0kXhbRbIx8tT8V3xiDP/XDeiI9P68LvjGYVpaRz9zefayJCvmCYqg6121CbUwzHcDJprcRAkS+zA5HqrVzTs8kqvF3crbyxbI93n+m8TcshniHWqgZ+tQv1uO/LzLIXvvI90pty76+GfDOdHmyF9lYFVbvb7/fjp6DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sqn5ADPL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E8B8C19425;
	Tue, 28 Apr 2026 00:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777337919;
	bh=o4knKAc6QwanZkMYuNvml2KCFjuGpUo1cJgFacZj4rw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sqn5ADPLBRSiX0OYhDoWfmULlQFNsz4/j3qXJ27VabPPYnVAOHXGwWZDsvS6Us0kB
	 JO/7Ygew3lnDgQtUJib45rTicSfZSZZZOLyCzuEsj9SxYfZlfV0efjPAmf/TEtM7uV
	 Cxd9MFLu+QLzwm1fLHiycKUEPzLl/gV5O7RzjrC3hCum3YE59mSdXCEiRL2P8YNeCG
	 4zhpRNYjqH8iT2IwHJAAKvOLNQmGc3Z0OPss8yQlFILjgYiu5nw2cqkTypVVdRCSi4
	 R+1BuL6ITUVqpF4q8XoCtLwLfrH7uI0qIRbbmkLXwpVEoFExiMiN6Pm4K1Fd2UD8AJ
	 kijiruQss6HsA==
Message-ID: <0c1258e2-7060-4084-9a07-dd7af8262dec@kernel.org>
Date: Mon, 27 Apr 2026 18:58:38 -0600
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
To: Kuniyuki Iwashima <kuniyu@google.com>, "yanjun.zhu" <yanjun.zhu@linux.dev>
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
 <0cf42593-0149-4019-a51b-36f74ff67f51@linux.dev>
 <CAAVpQUDVb4VDibeXz-DmAHF7gOAvDenSTGA6DpEwwS5HaQjM5w@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CAAVpQUDVb4VDibeXz-DmAHF7gOAvDenSTGA6DpEwwS5HaQjM5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 60CE947C45D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19618-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[gmail.com,ziepe.ca,kernel.org,vger.kernel.org,syzkaller.appspotmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,d8f76778263ab65c2b21];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On 4/27/26 6:52 PM, Kuniyuki Iwashima wrote:
> 
> To be clear, you meant implementing David' idea, right ?
> I'm asking because dellink won't need locking then.

dellink is not needed with my suggestion. It was added to manage
basically a refcount on the socket to close on last rxe delete in the
namespace.

