Return-Path: <linux-rdma+bounces-20165-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAxmJuCp/GkNSgAAu9opvQ
	(envelope-from <linux-rdma+bounces-20165-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 17:04:00 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 828BA4EAC1A
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 17:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0966B301482D
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 15:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7409F43D501;
	Thu,  7 May 2026 15:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="B8vURC+N"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B142237AA82;
	Thu,  7 May 2026 15:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778166218; cv=none; b=T/5q/S5AYNFj//DvKjrUqTcUvZuqFK/Uvk4RJ3uFd3wCuuxodnLI4jGRawYbXMLKuGttrfgMcdEdw3Wqj4+sFmZqX7ICKocF7vtWPinURtDKUr8xmxBNe+CajLlhTGYr3AWyRxy2mxfINdQWcwbXT1BJjobNFxAuM2jAEl7y1Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778166218; c=relaxed/simple;
	bh=RqqEmSAYe5uO5yFHnV/lHGnWfVJKUcwk0oQAySoPpuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FoMOodpENxa2Jxgxed3PhTxEDCETxLzB6wG3mBW+dhffP1eCQ/Uko+GFc0qwwUQE3iuLrlVDuhqgiGWCzXbacWVMixAHB1wEQMsBWApkiuTYxeXwVdU1Q00qEEKqsrjjG60ENTM06u97RWeam5UphesW4dzVTi4hre4urJ3up5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=B8vURC+N; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778166203; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=gN0R7K+mFD2y2ohlTCIAYE5Mk6fJmoCLJCQhnJ8zqCc=;
	b=B8vURC+NgyV//UevGjIZ6Wn/v9i3r84zHtcypYdxhakVbMP6oidxv5F4rYfGbASJZS6GW2Nt7vIF6s8D47ysQhlpQ6z+PAuZOWiAiC9gwIMYMI735PlXt1IdeSISSRqMRwvcecDnclCAFm5kakrqcawjYJZ20YIvm7f+gA3FfK8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0X2Uqj2g_1778166201;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0X2Uqj2g_1778166201 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 07 May 2026 23:03:22 +0800
Date: Thu, 7 May 2026 23:03:21 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: "D. Wythe" <alibuda@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>
Cc: Karsten Graul <kgraul@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Simon Horman <horms@kernel.org>, Tony Lu <tonylu@linux.alibaba.com>,
	Ursula Braun <ubraun@linux.ibm.com>,
	Wen Gu <guwen@linux.alibaba.com>, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
	netdev@vger.kernel.org, oliver.yang@linux.alibaba.com,
	pasic@linux.ibm.com
Subject: Re: [PATCH net] net/smc: fix missing sk_err when TCP handshake fails
Message-ID: <afypuUy5ZAXVQPuI@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20260506014105.27093-1-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506014105.27093-1-alibuda@linux.alibaba.com>
X-Rspamd-Queue-Id: 828BA4EAC1A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-20165-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dust.li@linux.alibaba.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	HAS_REPLYTO(0.00)[dust.li@linux.alibaba.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.alibaba.com:mid,linux.alibaba.com:dkim,linux.alibaba.com:replyto]
X-Rspamd-Action: no action

On 2026-05-06 09:41:05, D. Wythe wrote:
>In smc_connect_work(), when the underlying TCP handshake fails, the error
>code (rc) must be propagated to sk_err to ensure userspace can correctly
>retrieve the error status via SO_ERROR. Currently, the code only handles
>a restricted set of error codes (e.g., EPIPE, ECONNREFUSED). If other
>errors occurs, such as EHOSTUNREACH, sk_err remains unset (zero).
>
>This affects applications that rely on SO_ERROR to determine connect
>outcome. For example, higher versions of Go's netpoller treats
>SO_ERROR == 0 combined with a failed getpeername() as a spurious wakeup
>and re-enters epoll_wait(). Under ET mode, no further edge will be
>generated since the socket is already in a terminal state, causing the
>connect to hang indefinitely or until a user-specified timeout, if one
>is set.
>
>Fixes: 50717a37db03 ("net/smc: nonblocking connect rework")
>Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>

Reviewed-by: Dust Li <dust.li@linux.alibaba.com>

Best regards,
Dust

>---
> net/smc/af_smc.c | 8 ++------
> 1 file changed, 2 insertions(+), 6 deletions(-)
>
>diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>index 1a565095376a..185dbed7de5d 100644
>--- a/net/smc/af_smc.c
>+++ b/net/smc/af_smc.c
>@@ -1628,12 +1628,8 @@ static void smc_connect_work(struct work_struct *work)
> 	lock_sock(&smc->sk);
> 	if (rc != 0 || smc->sk.sk_err) {
> 		smc->sk.sk_state = SMC_CLOSED;
>-		if (rc == -EPIPE || rc == -EAGAIN)
>-			smc->sk.sk_err = EPIPE;
>-		else if (rc == -ECONNREFUSED)
>-			smc->sk.sk_err = ECONNREFUSED;
>-		else if (signal_pending(current))
>-			smc->sk.sk_err = -sock_intr_errno(timeo);
>+		if (!smc->sk.sk_err)
>+			smc->sk.sk_err = (rc == -EAGAIN) ? EPIPE : -rc;
> 		sock_put(&smc->sk); /* passive closing */
> 		goto out;
> 	}
>-- 
>2.45.0

