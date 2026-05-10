Return-Path: <linux-rdma+bounces-20307-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLDlKtCiAGqTLAEAu9opvQ
	(envelope-from <linux-rdma+bounces-20307-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 17:22:56 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 632E8504CE0
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 17:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F2AF301586D
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 15:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814B639E193;
	Sun, 10 May 2026 15:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="B7gr0Djg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373E62F8E81;
	Sun, 10 May 2026 15:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778426365; cv=none; b=SgRmddCs2vQdq1Z+/od+TFlqzSaoK4cteI4oq+6XmrkyyaoKd+os4gajDe2Vssrj1mXQ6c9GIONVvnvGIxS3qJKzErF0TOiKKg5WFCK7MFmsF33qegh8VW6M6qmR25aXGyIDbdlvGA3A9wUC8m7KwqFMxCHroJA61gAsjI//4mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778426365; c=relaxed/simple;
	bh=KA/p1RhujIaTAg1hTVqbE076u80O9x23DXASfs8gZPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eb0RIEX8WnYw4T2djRsmXzQTQBYz8IlyqMpVBA2Y4GpSPH/ZOT9pUbQkRrSefD5sagpY+zx81OtKUQ7sz+/gGaz1A88igEmFKn50Nabm22zJ2nZEcoyBf4rrVnLzhjqKARi4PoZ49le1M8CNEzPMEx/pvf2hYrgv4IvWw3vZwQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=B7gr0Djg; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778426353; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=h8xm0ICWFyWAHAFUbZ2x6pFmPnB7nZ1XWtBXDMkVHTY=;
	b=B7gr0DjgCvQaFFuoGvNTi4v0bV56JJQ1ykBne7gpROPhqkxEbvsQtyonu4J+LPsUZpGPrp1y9zFuBs4EOudwmheQ7jf/M71CZgp3zrTlIWU+A8tOPti3Tx/tj8dwde9OVAGWRcd3rkO55axfCAa44wl2hor9a+GgcSu+F+CB9Cw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X2cvymd_1778426352;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0X2cvymd_1778426352 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 10 May 2026 23:19:12 +0800
Date: Sun, 10 May 2026 23:19:12 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: =?iso-8859-1?Q?Nicol=F2?= Coccia <n.coccia96@gmail.com>,
	alibuda@linux.alibaba.com, sidraya@linux.ibm.com,
	Wenjia Zhang <wenjia@linux.ibm.com>
Cc: Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	mjambigi@linux.ibm.com,
	=?iso-8859-1?Q?Nicol=F2?= Coccia <nicolo.coccia@leonardo.com>
Subject: Re: [PATCH net] net/smc: fix sleep-inside-lock in __smc_setsockopt()
 causing local DoS
Message-ID: <agCh8NuM69sYSIRA@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <CALSA8UZaE8FR2K-60fPYE6uSUvUNuLnH=8pPq0Hak2ADQpp1Qw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALSA8UZaE8FR2K-60fPYE6uSUvUNuLnH=8pPq0Hak2ADQpp1Qw@mail.gmail.com>
X-Rspamd-Queue-Id: 632E8504CE0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20307-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linux.alibaba.com,linux.ibm.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dust.li@linux.alibaba.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	HAS_REPLYTO(0.00)[dust.li@linux.alibaba.com];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:mid,linux.alibaba.com:dkim,linux.alibaba.com:replyto,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 2026-05-09 07:01:02, Nicolò Coccia wrote:
>A logic flaw in __smc_setsockopt() allows a local unprivileged user to
>cause a Denial of Service (DoS) by holding the socket lock indefinitely.
>
>The function __smc_setsockopt() calls copy_from_sockptr() while holding
>lock_sock(sk). By passing a userfaultfd-monitored memory page (or
>FUSE-backed memory on systems where unprivileged userfaultfd is disabled)
>as the optval, an attacker can halt execution during the copy operation,
>keeping the lock held.
>
>Combined with asynchronous tear-down operations like shutdown(), this
>exhausts the kernel wq (kworkers) and triggers the hung task watchdog.
>
>[  240.123456] INFO: task kworker/u8:2 blocked for more than 120 seconds.
>[  240.123489] Call Trace:
>[  240.123501]  smc_shutdown+...
>[  240.123512]  lock_sock_nested+...
>
>This patch moves the user-space copy outside the lock_sock() critical
>section to prevent the issue.
>
>Fixes: a6a6fe27bab4 ("net/smc: Dynamic control handshake limitation by
>socket options")
>Signed-off-by: Nicolò Coccia <n.coccia96@gmail.com>
>---
>v1 -> v2:
> - Rebased against netdev/net tree
> - Added Fixes tag
>
> net/smc/af_smc.c | 17 ++++++++---------
> 1 file changed, 8 insertions(+), 9 deletions(-)
>
>diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>index 185dbed7de5d..da28652f6810 100644
>--- a/net/smc/af_smc.c
>+++ b/net/smc/af_smc.c
>@@ -3054,18 +3054,17 @@ static int __smc_setsockopt(struct socket
>*sock, int level, int optname,


Still not apply, have you changed this manually ?
You can produce the patch simply using `git format-patch `

Best regards,
Dust


