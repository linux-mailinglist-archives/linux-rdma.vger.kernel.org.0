Return-Path: <linux-rdma+bounces-21649-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8JHxKElFH2rAjQAAu9opvQ
	(envelope-from <linux-rdma+bounces-21649-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 23:04:09 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 18783631FD4
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 23:04:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=URBRQO8E;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21649-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21649-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8573B3030D41
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jun 2026 21:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A587397695;
	Tue,  2 Jun 2026 21:04:02 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73154221DB6;
	Tue,  2 Jun 2026 21:04:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780434242; cv=none; b=IQQYCOnKCUXcAtPHqyiHbXOO6Xpt7FzuZQH0eoYUm73uCepLvjjSzKqp3rHjsE4NyOkM/m/uPJandfHt80cuWKrpqsr8TEmjCKzgpBhcdqXu8HTJIh03P0ONcMBFRkwKbem9qUdPfxcrK2sL5iKwz4HA8mz0IbNmRDFozKtcoM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780434242; c=relaxed/simple;
	bh=xcBwUqenQnYMfSBWCxuZu0/kzGfDaLbnZtYKX98y8zk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZA8UVlY/E8lTkdGxRJCpYK8mAAH+D5yAjUo4iiGtHtKn/wvHMLhLrZH6ELALsNjvMUxxELhZBreMj9NaSxuJdZKKHEL+OlReFSP2+qpBYkso/hyWwmafiIipcuctagUqKRSYF6T04c6sU69KhvityHcMN494L0OIISkGj3tvgmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URBRQO8E; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544E51F00893;
	Tue,  2 Jun 2026 21:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780434241;
	bh=szrWBKhghiac2i2mueK/YjJu1FK82B5hSpdAwSlajBM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=URBRQO8EBqqlHB/KHgDkXH5tmEouzPHMlK1s0wDdHL+bZ3gBuynAz+fso8Al8Jrj/
	 9JQDn+55i4u1Z3eVPrHvnULBNeLDirvQ25E3iDMU+y6qmdfmrr8C8T+UcDLIr+mCO+
	 0FEni1K10C+s+N+NJYUKd9Kxqk6Sp5Lvgkfwf/qPbSA+Jp9Kw9qancwOhtlaamVQDz
	 5ldsm636C9d6gkqy4Dnp/z7VGOIK09alUM8om2KAkTVIbDQTL9pwIi5SuexN4HFTki
	 s96CuKvrux8DwF2d4l9PQDYp/KYZM3zd1Aatv3mJziyjCBU9o2dg6w02HwSlkI5Ckx
	 a4nUS34yeqC0g==
Date: Tue, 2 Jun 2026 14:03:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: "David S. Miller" <davem@davemloft.net>, Dust Li
 <dust.li@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Sidraya Jayagond <sidraya@linux.ibm.com>, Wenjia
 Zhang <wenjia@linux.ibm.com>, Mahanta Jambigi <mjambigi@linux.ibm.com>,
 Simon Horman <horms@kernel.org>, Tony Lu <tonylu@linux.alibaba.com>, Wen Gu
 <guwen@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, oliver.yang@linux.alibaba.com, pasic@linux.ibm.com
Subject: Re: [PATCH net-next 0/2] net/smc: transition to RDMA core CQ
 pooling
Message-ID: <20260602140359.3b97d180@kernel.org>
In-Reply-To: <20260528084819.6059-1-alibuda@linux.alibaba.com>
References: <20260528084819.6059-1-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-21649-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alibuda@linux.alibaba.com,m:davem@davemloft.net,m:dust.li@linux.alibaba.com,m:edumazet@google.com,m:pabeni@redhat.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,m:mjambigi@linux.ibm.com,m:horms@kernel.org,m:tonylu@linux.alibaba.com,m:guwen@linux.alibaba.com,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-s390@vger.kernel.org,m:netdev@vger.kernel.org,m:oliver.yang@linux.alibaba.com,m:pasic@linux.ibm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 18783631FD4

On Thu, 28 May 2026 16:48:17 +0800 D. Wythe wrote:
> This series transitions SMC-R completion handling to RDMA core CQ pooling
> via the ib_cqe API. The new completion model improves scalability by
> allowing per-link completion processing across multiple cores and enables
> DIM-based interrupt moderation.
> 
> As a side effect, the increased concurrency can amplify contention for TX
> slots on the shared wait queue. Patch 2 addresses this by switching TX slot
> allocation from non-exclusive wait_event() to prepare_to_wait_exclusive(),
> which avoids thundering-herd wakeups under contention.
> 
> Patch 1 replaces the global per-device CQ and manual tasklet polling model
> with RDMA core CQ pooling.
> Patch 2 reduces TX slot contention by using exclusive wait queue entries
> during allocation.

Sashiko reports a couple of issues on patch 1:
https://sashiko.dev/#/patchset/20260528084819.6059-2-alibuda@linux.alibaba.com
Are these legit?

Either way - would be good to get some reviews here from (ohter) SMC
maintainers.

